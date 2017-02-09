# -*- coding: utf-8 -*-
"""
Created on Tue Nov  8 18:11:28 2016

@author: bgauthie
"""

###############################################################################
import os
import numpy as np
import mne

#from matplotlib import pyplot as pl
from matplotlib import pyplot as pl

###############################################################################
ListSubj = ('sd130343', 'cb130477', 'rb130313', 'jm100042', 
            'jm100109', 'sb120316', 'tk130502', 'lm130479', 
            'ms130534', 'ma100253', 'sl130503', 'mb140004',
            'mp140019', 'dm130250', 'hr130504', 'wl130316',
            'rl130571','sg120518','mm130405')   
            
condition  = ('signDS8_1' ,'signDS8_2','signDS8_3' ,'signDS8_4','signDS8_5' ,'signDS8_6','signDS8_7' ,'signDS8_8')
mod        = 'MEEG'
method     = 'dSPM'

label_path = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/labels_user_defined/SignedDistSLinReg'

label_list = (os.listdir(label_path))

graphcolor = ((0, 0,   0.25  ),
            (0, 0,   0.5  ),
            (0.05, 0.05,   0.75  ),
            (0.10, 0.10,   1  ),
            (0.25,   0.25, 1),
            (0.25,   0.50, 1),
            (0.75,   0.75,1),
            (0.95,   0.95, 1))            
              
cropwin    = [-0.2    ,1    ]
#twin       = [1.606,1.829]
#twin       = [0.673,0.809]
twin       = (0.644, 0.924)
ori ='None'

wdir       = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG"
###############################################################################
DATA    = []
SUBJECT = []
COND    = []
ROI     = []

subjects_dir = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/mri/'

for l,labeltag in enumerate(label_list):
    label =   mne.read_label(label_path+'/'+labeltag)
    
    # get the indexes of vertices of interest (VertOI)
    path = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps';
    stc_fname = (path +'/IcaCorr_BETAp005uncorr_MEEG_LinRegress8bin_SsignedEVS_twin'+str(twin[0])+'-'+str(twin[1])+'ms_pick_oriNone_dSPM_ico-5-fwd-fsaverage.stc-lh.stc')
    stc = mne.read_source_estimate(stc_fname)
    stc_label = stc.in_label(label) 
    VertOI = np.where(np.abs(stc_label.data) >0)[0] 
    
    #################################
    # load a specific STC morphed on fsaverage to get shape info
    stc0_path = (wdir + '/' + ListSubj[0] + '/mne_python/STCS/' + mod + 
               '_' + ListSubj[0] + '_' + condition[0] + '_pick_ori'+ori+'_' + 
                method + '_ico-5-fwd-fsaverage.fif-rh.stc')
    stc0      = mne.read_source_estimate(stc0_path)
    stc0      = stc0.in_label(label)
    stc0      = stc0.crop(cropwin[0],cropwin[1])
    ncond     = len(condition)
    nsub      = len(ListSubj)
    ntimes    = len(stc0.times)    
    nvertices = stc0.data.shape[0]         
     
    # average individual STCs morphed on fsaverage for each cond
    AVG_STC_cond  = np.empty([nvertices, ntimes,  nsub, ncond])
    for s,subj in enumerate(ListSubj):            
        for c,cond in enumerate(condition):
            stc_path = (wdir + '/' + subj + '/mne_python/STCS/' + mod +
                        '_' + subj + '_' + cond + '_pick_ori'+ori+'_' + 
                        method + '_ico-5-fwd-fsaverage.fif-rh.stc')
            stc = mne.read_source_estimate(stc_path) 
            stc = stc.crop(cropwin[0],cropwin[1])
            stc = stc.in_label(label)
            AVG_STC_cond[:,:,s,c] = stc.data
            
    fig, (ax1,ax2) = pl.subplots(1,2, gridspec_kw = {'width_ratios':[3, 1]},figsize=(16,4))
    ax1.plot((0,0),(0.5,4.5),linewidth = 3,linestyle='--',color = (0.5,0.5,0.5))
    ax1.plot((1,1),(0.5,4.5),linewidth = 3,linestyle='--',color = (0.5,0.5,0.5))
    for c,cond in enumerate(condition):
        ax1.plot(stc0.times,np.nanmean(np.nanmean(AVG_STC_cond[VertOI,:,:,c],axis = 0),axis = 1),
        linewidth = 3,color = graphcolor[c] ,label=condition[c])
        ax1.set_title(labeltag)   
    ax1.axvspan(twin[0], twin[1], color='k', alpha=0.2)   
    ax1.set_xlim(-0.2,1.5)
    ax1.legend(loc='upper right')
    ax1.set_xlabel('Time(s)')
    ax1.set_ylabel('Amplitude (a.u.)')   
    ax1.set_ylim(0.5, 4.5)      
    
     
    # crop
    # load a specific STC morphed on fsaverage to get shape info
    stc0_path = (wdir + '/' + ListSubj[0] + '/mne_python/STCS/' + mod + 
               '_' + ListSubj[0] + '_' + condition[0] + '_pick_ori'+ori+'_' + 
                method + '_ico-5-fwd-fsaverage.fif-rh.stc')
    stc0      = mne.read_source_estimate(stc0_path)
    stc0      = stc0.in_label(label)
    stc0.crop(twin[0],twin[1])
    ncond     = len(condition)
    nsub      = len(ListSubj)
    ntimes    = len(stc0.times)    
    nvertices = stc0.data.shape[0]  
       
    
    ntimes_crop    = len(stc0.times)          
    AVG_STC_crop  = np.empty([nvertices, ntimes_crop,  nsub, ncond])
    for s,subj in enumerate(ListSubj):            
        for c,cond in enumerate(condition):
            stc_path = (wdir + '/' + subj + '/mne_python/STCS/' + mod +
                        '_' + subj + '_' + cond + '_pick_ori'+ori+'_' + 
                        method + '_ico-5-fwd-fsaverage.fif-rh.stc')
            stc = mne.read_source_estimate(stc_path) 
            stc = stc.in_label(label)
            stc.crop(twin[0],twin[1])
            AVG_STC_crop[:,:,s,c] = stc.data
    
    for c,cond in enumerate(condition):
        ax2.bar(0.5+c,np.mean(np.nanmean(np.nanmean(AVG_STC_crop[VertOI,:,:,c]))),color = graphcolor[c],
               linewidth = 2,
               yerr = np.std(np.nanmean(np.nanmean(AVG_STC_crop[VertOI,:,:,c],axis = 0),axis=0))/np.sqrt(19),
                error_kw = dict(linewidth=2,ecolor='black'))
    ax2.set_xlim(0,len(condition)+1)
    ax2.set_ylim(1.5, 4.5)
    
    save_path = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/PLOTS_PAPER/' +
                    '_'.join(condition))   
                     
    if not os.path.exists(save_path):
        os.makedirs(save_path)  
        
    pl.savefig(save_path+'/'+'Barplot_'+label.name+'.png')
    pl.close     

    save_Rpath = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/R_data/'
    
    
#    data1 = np.mean(np.mean(AVG_STC_crop[VertOI,:,:,0],axis = 0),axis = 0)
#    data2 = np.mean(np.mean(AVG_STC_crop[VertOI,:,:,1],axis = 0),axis = 0)


#    DATA.append(np.hstack([data1, data2,data3]))
#    SUBJECT.append(np.hstack([range(1,20),range(1,20),range(1,20)]))
#    COND.append(np.hstack([np.ones(19),np.ones(19)*2,np.ones(19)*3]))
#    ROI.append(np.hstack([np.ones(19)*(l+1),np.ones(19)*(l+1),np.ones(19)*(l+1)]))


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





