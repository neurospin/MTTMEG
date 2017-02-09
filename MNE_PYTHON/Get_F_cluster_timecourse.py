# -*- coding: utf-8 -*-
"""
Created on Mon Jul  4 13:47:47 2016

@author: bgauthie
"""

###############################################################################
import os
import numpy as np
import mne

#from matplotlib import pyplot as pl
from matplotlib import pyplot as pl

###############################################################################
('sd130343', 'cb130477', 'rb130313', 'jm100042', 
            'jm100109', 'sb120316', 'tk130502', 'lm130479', 
            'ms130534', 'ma100253', 'sl130503', 'mb140004',
            'mp140019', 'dm130250', 'hr130504', 'wl130316',
            'rl130571','sg120518','mm130405')   
            
condition  = ('RefPast','RefPre','RefFut')   
mod        = 'MEEG'
method     = 'dSPM'
 
wdir       = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG"
###############################################################################

subjects_dir = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/mri/'
    
labels = mne.read_labels_from_annot('fsaverage',
                                    parc='aparc', 
                                    hemi = 'both', 
                                    subjects_dir = subjects_dir)

# get the indexes of vertices of interest (VertOI)
stc_fname = ('/home/bgauthie/test_F_Map_REFTPROJ_clust2_meg-rh.stc')
stc = mne.read_source_estimate(stc_fname)
stc_label = stc.in_label(labels[49]) # right  SMG
VertOI = np.where(stc_label.data >= 8.6)[0] # F-threshold above 8.6 ==> p<0.001

#rSMG:63,rprecentral:49 
#################################
# load a specific STC morphed on fsaverage to get shape info
stc0_path = (wdir + '/' + ListSubj[0] + '/mne_python/STCS/IcaCorr_' + mod + 
           '_' + ListSubj[0] + '_' + condition[0] + '_pick_orinormal_' + 
            method + '_ico-5-fwd-fsaverage.fif-rh.stc')
stc0      = mne.read_source_estimate(stc0_path)
stc0      = stc0.in_label(labels[49])
ncond     = len(condition)
nsub      = len(ListSubj)
ntimes    = len(stc0.times)    
nvertices = stc0.data.shape[0]        
        
# average individual STCs morphed on fsaverage for each cond
AVG_STC_cond  = np.empty([nvertices, ntimes,  nsub, ncond])
for s,subj in enumerate(ListSubj):            
    for c,cond in enumerate(condition):
        stc_path = (wdir + '/' + subj + '/mne_python/STCS/IcaCorr_' + mod +
                    '_' + subj + '_' + cond + '_pick_orinormal_' + 
                    method + '_ico-5-fwd-fsaverage.fif-rh.stc')
        stc = mne.read_source_estimate(stc_path) 
        stc = stc.in_label(labels[49])
        AVG_STC_cond[:,:,s,c] = stc.data

pl.figure(figsize=(16,4))
pl.plot(stc0.times,np.mean(np.mean(AVG_STC_cond[VertOI,:,:,0],axis = 0),axis = 1),
linewidth = 3,color = (1,0.7,0.7),label='Past')
pl.plot(stc0.times,np.mean(np.mean(AVG_STC_cond[VertOI,:,:,1],axis = 0),axis = 1),
linewidth = 3,color = (0,0,0),label='Now')
pl.plot(stc0.times,np.mean(np.mean(AVG_STC_cond[VertOI,:,:,2],axis = 0),axis = 1),
linewidth = 3,color = (1,0,0),label='Future')
pl.xlim(-0.2,5)
pl.legend(loc='upper right')
pl.xlabel('Time(s)')
pl.ylabel('Amplitude (a.u.)')

save_path = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/PLOTS_PAPER/' +
            'RefPast_Now_Fut_rdLPFC.png')       
pl.savefig(save_path)
pl.close


###############################################################################
###############################################################################
ListSubj   = ('sd130343', 'cb130477', 'rb130313', 'jm100042', 
            'jm100109', 'sb120316', 'tk130502', 'lm130479', 
            'ms130534', 'ma100253', 'sl130503', 'mb140004',
            'mp140019', 'dm130250', 'hr130504', 'wl130316',
            'rl130571')
            
condition  = ('QsWest','QsPar','QsEast')   
mod        = 'MEEG'
method     = 'dSPM'
 
wdir       = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG"
############### self-defined including label ##################################
subjects_dir = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/mri/'
    
label =   mne.read_label('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/test_label_QSleftfront-lh.label')
# get the indexes of vertices of interest (VertOI)
#stc_fname = ('/home/bgauthie/test_F_Map_REFTPROJ_clust1_meg-lh.stc')
#stc_fname = ('/home/bgauthie/test_F_Map_REFTPROJ_clust2_meg-lh.stc')
#stc_fname = ('/home/bgauthie/test_F_Map_REFTPROJ_clust3s_meg-lh.stc')
#stc_fname = ('/home/bgauthie/test_F_Map_REFTPROJ_clust4s_meg-lh.stc')
#stc_fname = ('/home/bgauthie/test_F_Map_ETTPRJ_rm-lh.stc')
stc_fname = ('/home/bgauthie/test_F_Map_QSREF-lh.stc')
stc = mne.read_source_estimate(stc_fname)
stc_label = stc.in_label(label) # right  SMG
VertOI = np.where(stc_label.data >= 8.6)[0] # F-threshold above 8.6 ==> p<0.001

#rSMG:63,rprecentral:49 
#################################
# load a specific STC morphed on fsaverage to get shape info
stc0_path = (wdir + '/' + ListSubj[0] + '/mne_python/STCS/IcaCorr_' + mod + 
           '_' + ListSubj[0] + '_' + condition[0] + '_pick_orinormal_' + 
            method + '_ico-5-fwd-fsaverage.fif-rh.stc')
stc0      = mne.read_source_estimate(stc0_path)
stc0      = stc0.in_label(label)
ncond     = len(condition)
nsub      = len(ListSubj)
ntimes    = len(stc0.times)    
nvertices = stc0.data.shape[0]        
        
# average individual STCs morphed on fsaverage for each cond
AVG_STC_cond  = np.empty([nvertices, ntimes,  nsub, ncond])
for s,subj in enumerate(ListSubj):            
    for c,cond in enumerate(condition):
        stc_path = (wdir + '/' + subj + '/mne_python/STCS/IcaCorr_' + mod +
                    '_' + subj + '_' + cond + '_pick_orinormal_' + 
                    method + '_ico-5-fwd-fsaverage.fif-rh.stc')
        stc = mne.read_source_estimate(stc_path) 
        stc = stc.in_label(label)
        AVG_STC_cond[:,:,s,c] = stc.data

pl.figure(figsize=(10,4))
pl.plot(stc0.times,np.mean(np.mean(AVG_STC_cond[VertOI,:,:,0],axis = 0),axis = 1),
linewidth = 3,color = (0.7,0.7,1),label='West')
pl.plot(stc0.times,np.mean(np.mean(AVG_STC_cond[VertOI,:,:,1],axis = 0),axis = 1),
linewidth = 3,color = (0,0,0),label='here')
pl.plot(stc0.times,np.mean(np.mean(AVG_STC_cond[VertOI,:,:,2],axis = 0),axis = 1),
linewidth = 3,color = (0,0,1),label='East')
pl.xlim(-0.2,1.5)
pl.legend(loc='lower right')
pl.xlabel('Time(s)')
pl.ylabel('Amplitude (a.u.)')

save_path = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/PLOTS_PAPER/' +
            'QSWHE_leftfront.png')       
pl.savefig(save_path)
pl.close

###############################################################################
import os
import numpy as np
import mne
from matplotlib import pyplot as pl
###############################################################################
ListSubj   = ('sd130343', 'cb130477', 'rb130313', 'jm100042', 
            'jm100109', 'sb120316', 'tk130502', 'lm130479', 
            'ms130534', 'ma100253', 'sl130503', 'mb140004',
            'mp140019', 'dm130250', 'hr130504', 'wl130316',
            'rl130571','sg120518','mm130405')
            
condition  = ('RefPast','RefPre','RefFut')   
mod        = 'MEEG'
method     = 'dSPM'
twin_      = (1.606,1.829)
 
wdir       = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG"
subjects_dir = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/mri/'

# get self-defined label of interest
label_folder= '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/labels_user_defined/RefPastPreFut'
list_ = os.listdir(label_folder)
# get the indexes of vertices of interest (VertOI)
stc_fname = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/'
             +'Plot_STATS/'+'_vs_'.join(condition) + '/'+
             'fmapMEEG_'+'_vs_'.join(condition) +'-lh.stc') 

stat_threshold = 8.42  
twin = (-0.2,2.5)      
############################################################################### 
DATA    = []
SUBJECT = []
COND    = []
ROI     = []

for l,label_ in enumerate(list_):   
    label =   mne.read_label(label_folder +'/'+label_)

    stc = mne.read_source_estimate(stc_fname)
    stc_label = stc.in_label(label) # right  SMG
    VertOI = np.where(stc_label.data >= stat_threshold)[0] # F-threshold above 8.42 ==> p<0.001 unc
    
    #rSMG:63,rprecentral:49 
    #################################
    # load a specific STC morphed on fsaverage to get shape info
    stc0_path = (wdir + '/' + ListSubj[0] + '/mne_python/STCS/IcaCorr_' + mod + 
           '_' + ListSubj[0] + '_' + condition[0] + '_pick_orinormal_' + 
            method + '_ico-5-fwd-fsaverage.fif-rh.stc')
    stc0      = mne.read_source_estimate(stc0_path)
    stc0      = stc0.in_label(label)
    stc0.crop(twin[0],twin[1])
    ncond     = len(condition)
    nsub      = len(ListSubj)
    ntimes    = len(stc0.times)    
    nvertices = stc0.data.shape[0]        
        
    # average individual STCs morphed on fsaverage for each cond
    AVG_STC_cond  = np.empty([nvertices, ntimes,  nsub, ncond])
    for s,subj in enumerate(ListSubj):            
        for c,cond in enumerate(condition):
            stc_path = (wdir + '/' + subj + '/mne_python/STCS/IcaCorr_' + mod +
                        '_' + subj + '_' + cond + '_pick_orinormal_' + 
                        method + '_ico-5-fwd-fsaverage.fif-rh.stc')
            stc = mne.read_source_estimate(stc_path) 
            stc = stc.in_label(label)
            stc.crop(twin[0],twin[1])
            AVG_STC_cond[:,:,s,c] = stc.data
    
    pl.figure(figsize=(10,4))
    pl.plot(stc0.times,np.mean(np.mean(AVG_STC_cond[VertOI,:,:,0],axis = 0),axis = 1),
    linewidth = 3,color = (1,0.7,0.7),label=condition[0])
    pl.plot(stc0.times,np.mean(np.mean(AVG_STC_cond[VertOI,:,:,1],axis = 0),axis = 1),
    linewidth = 3,color = (0,0,0),label=condition[1])
    pl.plot(stc0.times,np.mean(np.mean(AVG_STC_cond[VertOI,:,:,2],axis = 0),axis = 1),
    linewidth = 3,color = (1,0,0),label=condition[2])
    pl.xlim(-0.2,2.5)
    pl.legend(loc='upper left')
    pl.xlabel('Time(s)')
    pl.ylabel('Amplitude (a.u.)')
    
    save_path = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/PLOTS_PAPER/' +
                 "_vs_".join(condition))    
                 
    if not os.path.exists(save_path):
        os.makedirs(save_path)                
                 
    pl.savefig(save_path+'/'+label_ +'.png')
    pl.close
    
    save_Rpath = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/R_data/'
    
    lowb = np.where(stc0.times >= twin_[0])[0][0]
    upb  = np.where(stc0.times >= twin_[1])[0][0]
    
    data1 = np.mean(np.mean(AVG_STC_cond[VertOI,lowb:upb,:,0],axis = 0),axis = 0)
    data2 = np.mean(np.mean(AVG_STC_cond[VertOI,lowb:upb,:,1],axis = 0),axis = 0)
    data3 = np.mean(np.mean(AVG_STC_cond[VertOI,lowb:upb,:,2],axis = 0),axis = 0)

    DATA.append(np.hstack([data1, data2,data3]))
    SUBJECT.append(np.hstack([range(1,20),range(1,20),range(1,20)]))
    COND.append(np.hstack([np.ones(19),np.ones(19)*2,np.ones(19)*3]))
    ROI.append(np.hstack([np.ones(19)*(l+1),np.ones(19)*(l+1),np.ones(19)*(l+1)]))

# shape the data for a csv file
DATA2    = np.array(DATA)
SUBJECT2 = np.array(SUBJECT)
COND2     = np.array(COND)
ROI2      = np.array(ROI)

DATA2 = np.reshape(DATA2,[DATA2.shape[0]*DATA2.shape[1]])
SUBJECT2 = np.reshape(SUBJECT2,[SUBJECT2.shape[0]*SUBJECT2.shape[1]])
CON2 = np.reshape(COND2,[COND2.shape[0]*COND2.shape[1]])
ROI2 = np.reshape(ROI2,[ROI2.shape[0]*ROI2.shape[1]])

DATAFRAME = np.transpose(np.array((DATA2,SUBJECT2,CON2,ROI2)),[1,0])
             
np.savetxt((save_Rpath +'/'+"".join(condition) +".txt"), DATAFRAME, delimiter=" ")




