# -*- coding: utf-8 -*-
"""
Created on Mon Sep 12 17:28:51 2016

@author: bgauthie
"""

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
ListSubj = ('sd130343', 'cb130477', 'rb130313', 'jm100042', 
            'jm100109', 'sb120316', 'tk130502', 'lm130479', 
            'ms130534', 'ma100253', 'sl130503', 'mb140004',
            'mp140019', 'dm130250', 'hr130504', 'wl130316',
            'rl130571','sg120518','mm130405')   
            
condition  = ('EtPast','EtPre','EtFut')   
mod        = 'MEEG'
method     = 'dSPM'
 
#label_list = ('label_HC2_right-rh.label','label_HC2_left-lh.label','label_prefrontal_right-rh.label',
#              'label_medprefront_left-lh.label','label_smg_left-lh.label','label_precu_left-lh.label',
#              'label_precu_right-rh.label')    
label_list = ('Postcentral-rh.label',) 

graphcolor = ((1,0.7, 0.7),(0, 0, 0),(1, 0, 0))

wdir       = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG"
###############################################################################
DATA    = []
SUBJECT = []
COND    = []
ROI     = []

subjects_dir = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/mri/'
label_path   = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/labels_user_defined/EtPastPreFut/'

for l,labeltag in enumerate(label_list):
    label =   mne.read_label(label_path+labeltag)
    
    # get the indexes of vertices of interest (VertOI)
    path = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps';
    stc_fname = (path +'/IcaCorr_Normalized_MEEG_EtPast-EtPre-EtFut-EtPre_twin0.504-0.993ms_pick_oriNone_dSPM_ico-5-fwd-fsaverage.stc-lh.stc')
    stc = mne.read_source_estimate(stc_fname)
    stc_label = stc.in_label(label) 
    VertOI = np.where(np.abs(stc_label.data) >=0.020)[0] # P < 0.05 (>+-1.96std)
    
    #################################
    # load a specific STC morphed on fsaverage to get shape info
    stc0_path = (wdir + '/' + ListSubj[0] + '/mne_python/STCS/IcaCorr_' + mod + 
               '_' + ListSubj[0] + '_' + condition[0] + '_pick_orinormal_' + 
                method + '_ico-5-fwd-fsaverage.fif-rh.stc')
    stc0      = mne.read_source_estimate(stc0_path)
    stc0      = stc0.in_label(label)
    stc0      = stc0.crop(0,1)
    ncond     = len(condition)
    nsub      = len(ListSubj)
    ntimes    = len(stc0.times)    
    nvertices = stc0.data.shape[0]         
     
    # average individual STCs morphed on fsaverage for each cond
    AVG_STC_cond  = np.empty([nvertices, ntimes,  nsub, ncond])
    for s,subj in enumerate(ListSubj):            
        for c,cond in enumerate(condition):
            stc_path = (wdir + '/' + subj + '/mne_python/STCS/IcaCorr_' + mod +
                        '_' + subj + '_' + cond + '_pick_oriNone_' + 
                        method + '_ico-5-fwd-fsaverage.fif-rh.stc')
            stc = mne.read_source_estimate(stc_path) 
            stc = stc.crop(0,1)
            stc = stc.in_label(label)
            AVG_STC_cond[:,:,s,c] = stc.data
            
    pl.figure(figsize=(16,4))
    pl.plot(stc0.times,np.mean(np.mean(AVG_STC_cond[VertOI,:,:,0],axis = 0),axis = 1),
    linewidth = 3,color = graphcolor[0] ,label='Past')
    pl.plot(stc0.times,np.mean(np.mean(AVG_STC_cond[VertOI,:,:,1],axis = 0),axis = 1),
    linewidth = 3,color = graphcolor[1],label='Now')
    pl.plot(stc0.times,np.mean(np.mean(AVG_STC_cond[VertOI,:,:,2],axis = 0),axis = 1),
    linewidth = 3,color = graphcolor[2],label='Future')
    pl.xlim(-0.2,5)
    pl.legend(loc='upper right')
    pl.xlabel('Time(s)')
    pl.ylabel('Amplitude (a.u.)')         
    
    save_path = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/PLOTS_PAPER/' +
                '_'.join(condition))   
                 
    if not os.path.exists(save_path):
        os.makedirs(save_path)  
        
    pl.savefig(save_path+'/'+'Timecourse_'+label.name+'.png')
    pl.close    
          
    # crop
    # load a specific STC morphed on fsaverage to get shape info
    stc0_path = (wdir + '/' + ListSubj[0] + '/mne_python/STCS/IcaCorr_' + mod + 
               '_' + ListSubj[0] + '_' + condition[0] + '_pick_orinormal_' + 
                method + '_ico-5-fwd-fsaverage.fif-rh.stc')
    stc0      = mne.read_source_estimate(stc0_path)
    stc0      = stc0.in_label(label)
    stc0.crop(0.504,0.993)
    ncond     = len(condition)
    nsub      = len(ListSubj)
    ntimes    = len(stc0.times)    
    nvertices = stc0.data.shape[0]  
       
    
    ntimes_crop    = len(stc0.times)          
    AVG_STC_crop  = np.empty([nvertices, ntimes_crop,  nsub, ncond])
    for s,subj in enumerate(ListSubj):            
        for c,cond in enumerate(condition):
            stc_path = (wdir + '/' + subj + '/mne_python/STCS/IcaCorr_' + mod +
                        '_' + subj + '_' + cond + '_pick_oriNone_' + 
                        method + '_ico-5-fwd-fsaverage.fif-rh.stc')
            stc = mne.read_source_estimate(stc_path) 
            stc = stc.in_label(label)
            stc.crop(0.504,0.993)
            AVG_STC_crop[:,:,s,c] = stc.data
    
    pl.figure(figsize=(4,4))
    pl.bar(0.5,np.mean(np.mean(np.mean(AVG_STC_crop[VertOI,:,:,0]))),color = graphcolor[0],
           linewidth = 3,
           yerr = np.std(np.mean(np.mean(AVG_STC_crop[VertOI,:,:,0],axis = 0),axis=0))/np.sqrt(19),
            error_kw = dict(linewidth=3,ecolor='black'))
    pl.bar(1.5,np.mean(np.mean(np.mean(AVG_STC_crop[VertOI,:,:,1]))),color = graphcolor[1],
           linewidth = 3,
           yerr = np.std(np.mean(np.mean(AVG_STC_crop[VertOI,:,:,1],axis = 0),axis=0))/np.sqrt(19),
            error_kw = dict(linewidth=3,ecolor='black'))
    pl.bar(2.5,np.mean(np.mean(np.mean(AVG_STC_crop[VertOI,:,:,2]))),color = graphcolor[2],
           linewidth = 3,
           yerr = np.std(np.mean(np.mean(AVG_STC_crop[VertOI,:,:,2],axis = 0),axis=0))/np.sqrt(19),
            error_kw = dict(linewidth=3,ecolor='black'))
    pl.xlim(0,3.5)
    save_path = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/PLOTS_PAPER/' +
                '_'.join(condition))   
                 
    if not os.path.exists(save_path):
        os.makedirs(save_path)  
        
    pl.savefig(save_path+'/'+'Barplot_'+label.name+'.png')
    pl.close     

    save_Rpath = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/R_data/'
    
    
    data1 = np.mean(np.mean(AVG_STC_crop[VertOI,:,:,0],axis = 0),axis = 0)
    data2 = np.mean(np.mean(AVG_STC_crop[VertOI,:,:,1],axis = 0),axis = 0)
    data3 = np.mean(np.mean(AVG_STC_crop[VertOI,:,:,2],axis = 0),axis = 0)

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




