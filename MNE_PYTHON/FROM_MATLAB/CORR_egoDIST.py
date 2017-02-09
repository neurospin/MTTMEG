# -*- coding: utf-8 -*-
"""
Created on Wed Nov  4 10:45:57 2015

@author: bgauthie
"""

##############################################################################
# parameters
wdir = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop'
ListSubj = (
	  'sd130343','sg120518','mm130405','rb130313',
        'cb130477', 'jm100042', 'jm100109', 'sb120316', 'tk130502',
        'lm130479', 'ms130534', 'ma100253', 'sl130503', 'mb140004',
        'mp140019', 'dm130250', 'hr130504', 'wl130316', 'rl130571')
ListSubj2 = ('sg120518','mm130405','rb130313')
        
##############################################################################
import scipy.io as spio
from scipy import stats
import numpy as np
from matplotlib import pyplot as plt
import mne
from mne.viz import iter_topography

def loadmat(filename):
    '''
    this function should be called instead of direct spio.loadmat
    as it cures the problem of not properly recovering python dictionaries
    from mat files. It calls the function check keys to cure all entries
    which are still mat-objects
    '''
    data = spio.loadmat(filename, struct_as_record=False, squeeze_me=True)
    return _check_keys(data)

def _check_keys(dict):
    '''
    checks if entries in dictionary are mat-objects. If yes
    todict is called to change them to nested dictionaries
    '''
    for key in dict:
        if isinstance(dict[key], spio.matlab.mio5_params.mat_struct):
            dict[key] = _todict(dict[key])
    return dict        

def _todict(matobj):
    '''
    A recursive function which constructs from matobjects nested dictionaries
    '''
    dict = {}
    for strg in matobj._fieldnames:
        elem = matobj.__dict__[strg]
        if isinstance(elem, spio.matlab.mio5_params.mat_struct):
            dict[strg] = _todict(elem)
        else:
            dict[strg] = elem
    return dict

def regress_dist(subject, datasource):
    
    # load datasource from FT epoching
    var = loadmat(wdir + '/Subjects/' + subject + '/MegData/Processed_new/' +
                 datasource + '_dat_filt40')
    tabledist = loadmat(wdir + '/Scripts/CORR_TABLE_DIST')

    # get basic information bout the shape of the epochs FT data set
    ntimes = var['datafilt40']['time'][0]
    tstim0 = np.where(ntimes < 0.3)[0][-1]
    tbase0 = np.where(ntimes < 0.1)[0][-1]
    DataEvents = var['datafilt40']['trialinfo'][::,0]
    EventDist = tabledist['egoCORR_TABLE']
    
    # baselining epochs
    DATAMAT = []
    for t,trial in enumerate(var['datafilt40']['trial']):
        trial = trial - np.rollaxis(np.tile(np.mean(trial[::,tbase0:tstim0],axis = 1),
                                (len(ntimes),1)),1)
        DATAMAT.append(trial)
        
    DATAMAT = np.array(DATAMAT)    
    egodist_T = np.zeros(len(DataEvents))
    egodist_S = np.zeros(len(DataEvents))   
    
    # get egocentric distance value for each event in the dataset
    for e,evt in enumerate(DataEvents):
        for t,tab in enumerate(EventDist):
            if tab[0] == evt:
                egodist_T[e] = tab[1]
                egodist_S[e] = tab[2]     
    
    c = np.where(egodist_T > 0.)[0]
    #c = np.where(egodist_S > 0.)
    
    R = np.zeros((DATAMAT.shape[1],DATAMAT.shape[2]))
    S = np.zeros((DATAMAT.shape[1],DATAMAT.shape[2]))
    # regress amplitude with distance
    for i in range(DATAMAT.shape[1]):
        for j in range(DATAMAT.shape[2]):
            sl, int, r, p, std = stats.linregress(egodist_T[c],DATAMAT[c,i,j])
            R[i,j] = r
            S[i,j] = std
            
    return R, S
###############################################################################

var = loadmat('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/'+
              'hr130504/MegData/Processed_new/EVT_dat_filt40.mat')
ntimes = var['datafilt40']['time'][0]
chan   = var['datafilt40']['label']

count = 0 
Rmat  = []   

for s,subj in enumerate(ListSubj):    
    R, S = regress_dist(subj, 'EVT') 
    Rmat.append(R)

np.save('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' +
            'GROUP/Python/REG_EVT_egoT',np.array(Rmat))           
            
spio.savemat(('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' +
            'GROUP/Python/REG_EVT_egoT_frompy.mat'),
            {'REG_EVT_egoDIST_py':np.array(Rmat),
            'time':ntimes,
            'chan':chan,
            'Subjects':ListSubj})            
            

fig1 = plt.figure(1,figsize=(12,12))
l = []
L = []
Rmat = np.load('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' +
            'GROUP/Python/REG_EVT_egoT.npy')
for s,subj in enumerate(ListSubj):    
    plt.subplot(4,5,s+1)    
    plt.imshow(Rmat[s],clim = [-0.1 , 0.1], cmap = 'bwr',aspect = 'auto')
    frame1 = plt.gca()
    frame1.axes.get_xaxis().set_visible(False)
    frame1.axes.get_yaxis().set_visible(False)
    plt.tight_layout()

plt.imshow(np.mean(Rmat,axis = 0),
           clim = [-0.05 , 0.05],
           cmap = 'bwr',
           aspect = 'auto')
plt.colorbar()

plt.imshow(np.std(Rmat,axis = 0),
           cmap = 'bwr',
           aspect = 'auto')
plt.colorbar()

data = mne.evoked.read_evokeds('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/'+
            'dm130250/mne_python/AVGS/MEEGEsEast_dm130250-ave.fif')[0]
data.pick_types(meg = True, eeg = False)
data.data = Rmat[0,0:306,::]
data.times = ntimes = var['datafilt40']['time'][0]

for ax, idx in iter_topography(data.info,
                           fig_facecolor='white',
                           axis_facecolor='white',
                           axis_spinecolor='k'):                      
    ax.plot(np.mean(Rmat,axis = 0)[idx])  
    hyp_limits = (np.mean(Rmat,axis = 0)[idx] - np.std(Rmat,axis = 0)[idx], 
                  np.mean(Rmat,axis = 0)[idx] + np.std(Rmat,axis = 0)[idx])
    ax.fill_between(range(Rmat.shape[2]),
                     hyp_limits[0], y2=hyp_limits[1], color= 'b', alpha=0.2)
    ax.plot(np.zeros(data.data[idx].shape[0]))
    plt.savefig('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/REGPLOTS/EVT_distT.png')

plt.figure()
count = 1
for c in range(52):
    ax = plt.subplot(6,10,count)
    plt.plot(np.mean(Rmat,axis = 0)[c])
    hyp_limits = (np.mean(Rmat,axis = 0)[c] - np.std(Rmat,axis = 0)[c], 
                  np.mean(Rmat,axis = 0)[c] + np.std(Rmat,axis = 0)[c])
    plt.fill_between(range(Rmat.shape[2]),
                     hyp_limits[0], y2=hyp_limits[1], color= 'b', alpha=0.2)
    ax.yaxis.set_visible(False)
    ax.xaxis.set_visible(False)
    ax.plot(np.zeros(Rmat.shape[2]))
    plt.tight_layout()
    count = count + 1

plt.figure()
count = 1
for c in range(52,103):
    ax = plt.subplot(6,10,count)
    plt.plot(np.mean(Rmat,axis = 0)[c])
    hyp_limits = (np.mean(Rmat,axis = 0)[c] - np.std(Rmat,axis = 0)[c], 
                  np.mean(Rmat,axis = 0)[c] + np.std(Rmat,axis = 0)[c])
    plt.fill_between(range(Rmat.shape[2]),
                     hyp_limits[0], y2=hyp_limits[1], color= 'b', alpha=0.2)
    ax.yaxis.set_visible(False)
    ax.plot(np.zeros(Rmat.shape[2]))
    plt.tight_layout()
    count = count + 1






