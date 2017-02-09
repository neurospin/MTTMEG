# -*- coding: utf-8 -*-
"""
Created on Thu Jan  7 11:26:02 2016

@author: bgauthie
"""

import mne
import os
import numpy as np
import matplotlib
matplotlib.use('Agg')
from matplotlib import pyplot as pl
from scipy import stats

    
# parameter value example
wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG"
path_script  = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS/MNE_PYTHON"

###############################################################################
#subfunction for individual differences
def compute_stcdiff_subject(subject,condcouple,modality,method,ori):

    stc0_path = (wdir + '/' + subject + '/mne_python/STCS/IcaCorr_' + modality + 
               '_' + subject + '_' + condcouple[0] + '_pick_oriNone_' + 
                method + '_ico-5-fwd-fsaverage.fif-rh.stc')
    stc0      = mne.read_source_estimate(stc0_path)
    
    stc1_path = (wdir + '/' + subject + '/mne_python/STCS/IcaCorr_' + modality + 
               '_' + subject + '_' + condcouple[1] + '_pick_oriNone_' + 
                method + '_ico-5-fwd-fsaverage.fif-rh.stc')
    stc1      = mne.read_source_estimate(stc1_path)    
    
    tmp = stc0.data - stc1.data
    fsave_vertices = [np.arange(stc0.shape[0]/2), np.arange(stc0.shape[0]/2)]
    stc_Diff1 = mne.SourceEstimate(tmp,fsave_vertices,stc0.tmin,stc0.tstep) 
    
    PlotDir = []
    PlotDir = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/' + subject + '/mne_python/STCS_diff/IcaCorr_'
               + condcouple[0] + '-' + condcouple[1]) 
    
    if not os.path.exists(PlotDir):
        os.makedirs(PlotDir)    
    
    stc_Diff1.save(PlotDir + '/IcaCorr_' + modality + '_' + method + '_' + subject 
                        + '_' + condcouple[0] + '-' + condcouple[1] 
                        + '_' + '_ico-5-fwd-fsaverage-'
                        +'.stc')              

###############################################################################
#subfunction for individual differences
def compute_stcdiff_subject2(subject,condcouple,modality,method):

    stc0_path = (wdir + '/' + subject + '/mne_python/STCS/IcaCorr_' + modality + 
               '_' + subject + '_' + condcouple[0] + '_pick_oriNone_' + 
                method + '_ico-5-fwd-fsaverage.fif-rh.stc')
    stc0      = mne.read_source_estimate(stc0_path)
    
    stc1_path = (wdir + '/' + subject + '/mne_python/STCS/IcaCorr_' + modality + 
               '_' + subject + '_' + condcouple[1] + '_pick_oriNone_' + 
                method + '_ico-5-fwd-fsaverage.fif-rh.stc')
    stc1      = mne.read_source_estimate(stc1_path)    
    
    tmp = stc0.data - stc1.data
    fsave_vertices = [np.arange(stc0.shape[0]/2), np.arange(stc0.shape[0]/2)]
    stc_Diff1 = mne.SourceEstimate(tmp,fsave_vertices,stc0.tmin,stc0.tstep) 
    
    PlotDir = []
    PlotDir = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/' + subject + '/mne_python/STCS_diff/IcaCorr_'
               + condcouple[0] + '-' + condcouple[1]) 
    
    if not os.path.exists(PlotDir):
        os.makedirs(PlotDir)    
    
    stc_Diff1.save(PlotDir + '/IcaCorr_' + modality + '_' + method + '_' + subject 
                        + '_' + condcouple[0] + '-' + condcouple[1] 
                        + '_' + '_ico-5-fwd-fsaverage-'
                        +'.stc')  

###############################################################################                
###############################################################################
#subfunction for group differences     
def compute_stcdiff_group(ListSubj,condcouple,modality,method):     

    # load a specific STC morphed on fsaverage
    stc0_path = (wdir + '/' + ListSubj[0] + '/mne_python/STCS/IcaCorr_' + modality + 
           '_' + ListSubj[0] + '_' +condcouple[0] + '_pick_oriNone_' + 
            method + '_ico-5-fwd-fsaverage.fif-rh.stc')
    stc0      = mne.read_source_estimate(stc0_path)
    ncond     = len(condcouple)
    nsub      = len(ListSubj)
    ntimes    = len(stc0.times)    
    nvertices = stc0.data.shape[0]       

    # average individual STCs morphed on fsaverage for each cond
    AVG_STC_cond  = np.empty([ncond, nsub, nvertices, ntimes])
    for c,cond in enumerate(condcouple):
        for s,subj in enumerate(ListSubj):
            stc_path = (wdir + '/' + subj + '/mne_python/STCS/IcaCorr_' + modality +
                        '_' + subj + '_' + cond + '_pick_oriNone_' + 
                        method + '_ico-5-fwd-fsaverage.fif-rh.stc')
            stc = mne.read_source_estimate(stc_path)    
            AVG_STC_cond[c,s,:,:] = stc.data
    
    # compute the difference
    AVG_STC_1 = np.mean(AVG_STC_cond[0,:,:,:],axis = 0)
    AVG_STC_2 = np.mean(AVG_STC_cond[1,:,:,:],axis = 0)      

    sem = np.std(AVG_STC_cond)/np.sqrt(len(ListSubj)) 
    
    tmp = np.mean(AVG_STC_cond,2)
    pl.plot(np.rollaxis(tmp[0,:,:],1))    
    
    # Replace the values & # save the stc
    tmp = AVG_STC_1 - AVG_STC_2
    fsave_vertices = [np.arange(stc0.shape[0]/2), np.arange(stc0.shape[0]/2)]
    stc_Diff1 = mne.SourceEstimate(tmp,fsave_vertices,stc0.tmin,stc0.tstep) 
    stc_Diff1.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_' +
                 modality + '_' + condcouple[0] + '-' + condcouple[1] +
                 '_pick_oriNone_' + method + '_ico-5-fwd-fsaverage.stc')
    tmp = AVG_STC_1
    stc_1 = mne.SourceEstimate(tmp,fsave_vertices,stc0.tmin,stc0.tstep) 
    stc_1.save(('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_' +
                 modality + '_' + condcouple[0] +
                 '_pick_oriNone_' + method + '_ico-5-fwd-fsaverage.stc'))
    tmp = AVG_STC_2
    stc_2 = mne.SourceEstimate(tmp,fsave_vertices,stc0.tmin,stc0.tstep) 
    stc_2.save(('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_' +
                 modality + '_' + condcouple[1] +
                 '_pick_oriNone_' + method + '_ico-5-fwd-fsaverage.stc'))
 
    return sem

###############################################################################
#subfunction for group differences     
def compute_stcdiff_group_dist(ListSubj,modality,method,ori,tag):     

    # load a specific STC morphed on fsaverage
    stc0_path = (wdir + '/' + ListSubj[0] + '/mne_python/STCS/'+modality + 
           '_' + ListSubj[0] + '_dist'+tag+'_pick_ori'+ori+'_' + 
            method + '_ico-5-fwd-fsaverage.fif-rh.stc')
    stc0      = mne.read_source_estimate(stc0_path)
    nsub      = len(ListSubj)
    ntimes    = len(stc0.times)    
    nvertices = stc0.data.shape[0]       

    # average individual STCs morphed on fsaverage for each cond
    AVG_STC_cond  = np.empty([nsub, nvertices, ntimes])
    for s,subj in enumerate(ListSubj):
        stc_path = (wdir + '/' + subj + '/mne_python/STCS/'+ modality +
                    '_' + subj + '_dist'+tag+'_pick_ori'+ori+'_' + 
                    method + '_ico-5-fwd-fsaverage.fif-rh.stc')
        stc = mne.read_source_estimate(stc_path)    
        AVG_STC_cond[s,:,:] = stc.data   

    sem = np.std(AVG_STC_cond)/np.sqrt(len(ListSubj)) 
    
    tmp = np.mean(AVG_STC_cond,0)
    fsave_vertices = [np.arange(stc0.shape[0]/2), np.arange(stc0.shape[0]/2)]
    stc_Diff1 = mne.SourceEstimate(tmp,fsave_vertices,stc0.tmin,stc0.tstep) 
    stc_Diff1.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_' +
                 modality + '_dist'+tag+'_pick_ori'+ori+'_' + method + '_ico-5-fwd-fsaverage.stc')

    return sem

###############################################################################
#subfunction for group differences     
def compute_stcdiff_group_dist_twin(ListSubj,modality,method,twin,ori,cropwin,tag,col):     

    # load a specific STC morphed on fsaverage
    stc0_path = (wdir + '/' + ListSubj[0] + '/mne_python/STCS/' + modality + 
           '_' + ListSubj[0] + '_dist'+tag+'_pick_ori'+ ori +'_' + 
            method + '_ico-5-fwd-fsaverage.fif-rh.stc')
    stc0      = mne.read_source_estimate(stc0_path)
    stc0.crop(cropwin[0],cropwin[1])
    nsub      = len(ListSubj)
    ntimes    = len(stc0.times)    
    nvertices = stc0.data.shape[0]       

    # average individual STCs morphed on fsaverage for each cond
    AVG_STC_cond  = np.empty([nsub, nvertices, ntimes])
    for s,subj in enumerate(ListSubj):
        stc_path = (wdir + '/' + subj + '/mne_python/STCS/'+ modality +
                    '_' + subj + '_dist'+tag+'_pick_ori'+ ori +'_' + 
                    method + '_ico-5-fwd-fsaverage.fif-rh.stc')
        stc = mne.read_source_estimate(stc_path)
        stc.crop(cropwin[0],cropwin[1])
        AVG_STC_cond[s,:,:] = stc.data
    
    # compute the difference
    AVG_STC = np.mean(AVG_STC_cond[:,:,:],axis = 0) 
    meandata= np.mean(AVG_STC,axis =1)
    
    # compute sem across subject on twin-average
    sem = np.std(np.mean(AVG_STC_cond,axis = 2),axis = 0)/np.sqrt(len(ListSubj)) 
  
    mask1 = np.hstack((np.where((meandata - 1.96*sem) > 0)[0],np.where((meandata + 1.96*sem) < 0)[0])) # p < 0.05 uncorr.
    mask2 = np.hstack((np.where((meandata - 3.3*sem) > 0)[0],np.where((meandata + 3.3*sem) < 0)[0])) # p < 0.001 uncorr.
  
    # Replace the values & # save the stc
    tmp = AVG_STC
    fsave_vertices = [np.arange(stc0.shape[0]/2), np.arange(stc0.shape[0]/2)]
    stc_Diff1 = mne.SourceEstimate(tmp,fsave_vertices,stc0.tmin,stc0.tstep) 
    stc_Dummy = mne.SourceEstimate(tmp,fsave_vertices,stc0.tmin,stc0.tstep) 
    stc_Dummy.crop(tmin = 0, tmax = 0)
    
    tmp = (np.mean(stc_Diff1.data,1))
    # masks for theoritical p threshold uncorrected
    tmpmask1 = np.zeros(tmp.shape)
    tmpmask2 = np.zeros(tmp.shape)
    tmpmask3 = np.zeros(tmp.shape)
    tmpmask4 = np.zeros(tmp.shape)
    tmpmask5 = np.zeros(tmp.shape)
    tmpmask6 = np.zeros(tmp.shape)
    tmpmask7 = np.zeros(tmp.shape)
    tmpmask1[mask1] = 1
    tmpmask2[mask2] = 1
    tmp1 = tmp*tmpmask1
    tmp2 = tmp*tmpmask2
    # mask for 5,10,15% of vertices
    mask3 =  np.argpartition(meandata,-204)[-204:]   
    mask4 =  np.argpartition(meandata,-408)[-408:]
    mask5 =  np.argpartition(meandata,-612)[-612:]  
    mask6 =  np.argpartition(meandata,-102)[-102:] 
    mask7 =  np.argpartition(meandata,-20)[-20:]
    tmpmask3[mask3] = 1
    tmpmask4[mask4] = 1  
    tmpmask5[mask5] = 1  
    tmpmask6[mask6] = 1  
    tmpmask7[mask7] = 1
    tmp3 = tmp*tmpmask3
    tmp4 = tmp*tmpmask4
    tmp5 = tmp*tmpmask5
    tmp6 = tmp*tmpmask6
    tmp7 = tmp*tmpmask7
    
    tmp  = tmp[:,np.newaxis]
    tmp1 = tmp1[:,np.newaxis]
    tmp2 = tmp2[:,np.newaxis]
    tmp3 = tmp3[:,np.newaxis]
    tmp4 = tmp4[:,np.newaxis]
    tmp5 = tmp5[:,np.newaxis]
    tmp6 = tmp6[:,np.newaxis]
    tmp7 = tmp7[:,np.newaxis]
    if col == 0:
        stc = mne.SourceEstimate(tmp,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
        stc1 = mne.SourceEstimate(tmp1,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
        stc2 = mne.SourceEstimate(tmp2,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
        stc3 = mne.SourceEstimate(tmp3,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
        stc4 = mne.SourceEstimate(tmp4,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
        stc5 = mne.SourceEstimate(tmp5,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
        stc6 = mne.SourceEstimate(tmp6,fsave_vertices,stc_Dummy.tmin,stc.tstep)
        stc7 = mne.SourceEstimate(tmp7,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
        stc_sem = mne.SourceEstimate(np.reshape(sem,[20484,1]),fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    else:
        stc = mne.SourceEstimate(-tmp,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
        stc1 = mne.SourceEstimate(-tmp1,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
        stc2 = mne.SourceEstimate(-tmp2,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
        stc3 = mne.SourceEstimate(-tmp3,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
        stc4 = mne.SourceEstimate(-tmp4,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
        stc5 = mne.SourceEstimate(-tmp5,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
        stc6 = mne.SourceEstimate(-tmp6,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
        stc7 = mne.SourceEstimate(-tmp7,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
        stc_sem = mne.SourceEstimate(np.reshape(sem,[20484,1]),fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stc.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_' +
                 modality + '_dist'+tag+'_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')
    stc1.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_' +
                modality + '_dist'+tag+'Mask1_twin' +
                str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')
    stc2.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_' +
                modality + '_dist'+tag+'Mask2_twin' +
                str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')
    stc3.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_' +
                modality + '_dist'+tag+'Mask3_twin' +
                str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')
    stc4.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_' +
                modality + '_dist'+tag+'Mask4_twin' +
                str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')
    stc5.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_' +
                modality + '_dist'+tag+'Mas56_twin' +
                str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')
    stc6.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_' +
                modality + '_dist'+tag+'Mask6_twin' +
                str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')
    stc7.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_' +
                modality + '_dist'+tag+'Mask7_twin' +
                str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')
    stc_sem.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_' +
                 modality + '_dist'+tag+'_SEM_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')       
    return sem

###############################################################################      
def compute_stcdiff_group_dist_twin_ttest(ListSubj,modality,method,twin,ori,cropwin,tag,col):     

    # load a specific STC morphed on fsaverage
    stc0_path = (wdir + '/' + ListSubj[0] + '/mne_python/STCS/' + modality + 
           '_' + ListSubj[0] + '_dist'+tag+'_pick_ori'+ ori +'_' + 
            method + '_ico-5-fwd-fsaverage.fif-rh.stc')
    stc0      = mne.read_source_estimate(stc0_path)
    stc0.crop(cropwin[0],cropwin[1])
    nsub      = len(ListSubj)
    ntimes    = len(stc0.times)    
    nvertices = stc0.data.shape[0]       

    # average individual STCs morphed on fsaverage for each cond
    AVG_STC_cond  = np.empty([nsub, nvertices, ntimes])
    for s,subj in enumerate(ListSubj):
        stc_path = (wdir + '/' + subj + '/mne_python/STCS/'+ modality +
                    '_' + subj + '_dist'+tag+'_pick_ori'+ ori +'_' + 
                    method + '_ico-5-fwd-fsaverage.fif-rh.stc')
        stc = mne.read_source_estimate(stc_path)
        stc.crop(cropwin[0],cropwin[1])
        AVG_STC_cond[s,:,:] = stc.data
    
    # compute the difference
    AVG_STC = np.mean(AVG_STC_cond[:,:,:],axis = 0) 
    
    # compute the difference per subject for test across vertices
    Diff = np.empty([nsub, nvertices, ntimes])
    tmap = np.empty([nvertices])
    Diff = np.mean(AVG_STC_cond ,axis = 2)  
    
    Mask005 = np.zeros((Diff.shape[1]))

    # mean on the twin
    for v in range(Diff.shape[1]):
        t,p = stats.ttest_1samp(Diff[:,v],0)
        tmap[v] = t
        if p < 0.005:
            Mask005[v] = 1
 
    # Replace the values & # save the stc
    tmp = AVG_STC
    fsave_vertices = [np.arange(stc0.shape[0]/2), np.arange(stc0.shape[0]/2)]
    stc_Diff1 = mne.SourceEstimate(tmp,fsave_vertices,stc0.tmin,stc0.tstep) 
    stc_Dummy = mne.SourceEstimate(tmp,fsave_vertices,stc0.tmin,stc0.tstep) 
    stc_Dummy.crop(tmin = 0, tmax = 0)
    
    tmp = (np.mean(stc_Diff1.data,1))
    # masks for theoritical p threshold uncorrected
    tmp005 = tmp*Mask005
    
    tmp     = tmp[:,np.newaxis]
    tmap    = tmap[:,np.newaxis]
    tmp005  = tmp005[:,np.newaxis]

    if ori == 'None':
        if col == 0:
            stc = mne.SourceEstimate(tmp,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
        else:
            stc = mne.SourceEstimate(-tmp,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    else:
        stc = mne.SourceEstimate(tmp,fsave_vertices,stc_Dummy.tmin,stc.tstep) 

    stc.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_' +
                 modality + '_dist'+tag+'_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')

    stctmap = mne.SourceEstimate(tmap,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stctmap.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_tmap_' +
                 modality + '_dist'+tag+'_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')

    stc005 = mne.SourceEstimate(tmp005,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stc005.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_p005uncorr_' +
                 modality + '_dist'+tag+'_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')     

      
###############################################################################                
###############################################################################
#subfunction for group differences     
def compute_stcdiff_group2(ListSubj,condcouple,modality,method,cropwin,ori):           

    # load a specific STC morphed on fsaverage
    stc0_path = (wdir + '/' + ListSubj[0] + '/mne_python/STCS/IcaCorr_' + modality + 
           '_' + ListSubj[0] + '_' +condcouple[0] + '_pick_ori'+ori+'_' + 
            method + '_ico-5-fwd-fsaverage.fif-rh.stc')
    stc0      = mne.read_source_estimate(stc0_path)
    stc0.crop(cropwin[0],cropwin[1])
    ncond     = len(condcouple)
    nsub      = len(ListSubj)
    ntimes    = len(stc0.times)    
    nvertices = stc0.data.shape[0]       

    # average individual STCs morphed on fsaverage for each cond
    AVG_STC_cond  = np.empty([ncond, nsub, nvertices, ntimes])
    for s,subj in enumerate(ListSubj):
        multfact = 0
        for c,cond in enumerate(condcouple):
            stc_path = (wdir + '/' + subj + '/mne_python/STCS/IcaCorr_' + modality +
                        '_' + subj + '_' + cond + '_pick_ori'+ori+'_' + 
                        method + '_ico-5-fwd-fsaverage.fif-rh.stc')
            stc = mne.read_source_estimate(stc_path) 
            stc.crop(cropwin[0],cropwin[1])
            multfact = multfact  + np.mean(np.mean(stc.data))
            
        for c,cond in enumerate(condcouple):
            stc_path = (wdir + '/' + subj + '/mne_python/STCS/IcaCorr_' + modality +
                        '_' + subj + '_' + cond + '_pick_ori'+ori+'_' + 
                        method + '_ico-5-fwd-fsaverage.fif-rh.stc')
            stc = mne.read_source_estimate(stc_path) 
            stc.crop(cropwin[0],cropwin[1])
            AVG_STC_cond[c,s,:,:] = stc.data/(multfact/2)  
        
        # compute the difference
    AVG_STC_1 = np.mean(AVG_STC_cond[0,:,:,:],axis = 0)
    AVG_STC_2 = np.mean(AVG_STC_cond[1,:,:,:],axis = 0)    
    
    sem = np.std(AVG_STC_cond)/np.sqrt(len(ListSubj))
    
    #tmp = np.mean(AVG_STC_cond,2)
    #pl.plot(np.rollaxis(tmp[0,:,:],1))    
    
    # Replace the values & # save the stc
    tmp = AVG_STC_1 - AVG_STC_2
    fsave_vertices = [np.arange(stc0.shape[0]/2), np.arange(stc0.shape[0]/2)]
    stc_Diff1 = mne.SourceEstimate(tmp,fsave_vertices,stc0.tmin,stc0.tstep) 
    stc_Diff1.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_Normalized' +
                 modality + '_' + condcouple[0] + '-' + condcouple[1] +
                 '_pick_ori'+ori+'_' + method + '_ico-5-fwd-fsaverage.stc')
    #img = stc.as_volume,              
                 
                 
    tmp = AVG_STC_1
    stc_1 = mne.SourceEstimate(tmp,fsave_vertices,stc0.tmin,stc0.tstep) 
    stc_1.save(('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_Normalized' +
                 modality + '_' + condcouple[0] +
                 '_pick_ori'+ori+'_' + method + '_ico-5-fwd-fsaverage.stc'))
    tmp = AVG_STC_2
    stc_2 = mne.SourceEstimate(tmp,fsave_vertices,stc0.tmin,stc0.tstep) 
    stc_2.save(('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_Normalized' +
                 modality + '_' + condcouple[1] +
                 '_pick_ori'+ori+'_' + method + '_ico-5-fwd-fsaverage.stc'))
                 
    return sem
    
###############################################################################                
###############################################################################
#subfunction for group differences     
def compute_stcdiff_group3(ListSubj,condcouple,modality,method,cropwin,ori):           

    # load a specific STC morphed on fsaverage
    stc0_path = (wdir + '/' + ListSubj[0] + '/mne_python/STCS/' + modality + 
           '_' + ListSubj[0] + '_' +condcouple[0] + '_pick_ori'+ori+'_' + 
            method + '_ico-5-fwd-fsaverage.fif-rh.stc')
    stc0      = mne.read_source_estimate(stc0_path)
    stc0.crop(cropwin[0],cropwin[1])
    ncond     = len(condcouple)
    nsub      = len(ListSubj)
    ntimes    = len(stc0.times)    
    nvertices = stc0.data.shape[0]       

    # average individual STCs morphed on fsaverage for each cond
    AVG_STC_cond  = np.empty([ncond, nsub, nvertices, ntimes])
    for s,subj in enumerate(ListSubj):
        multfact = 0
        for c,cond in enumerate(condcouple):
            stc_path = (wdir + '/' + subj + '/mne_python/STCS/' + modality +
                        '_' + subj + '_' + cond + '_pick_ori'+ori+'_' + 
                        method + '_ico-5-fwd-fsaverage.fif-rh.stc')
            stc = mne.read_source_estimate(stc_path) 
            stc.crop(cropwin[0],cropwin[1])
            multfact = multfact  + np.mean(np.mean(stc.data))
            
        for c,cond in enumerate(condcouple):
            stc_path = (wdir + '/' + subj + '/mne_python/STCS/' + modality +
                        '_' + subj + '_' + cond + '_pick_ori'+ori+'_' + 
                        method + '_ico-5-fwd-fsaverage.fif-rh.stc')
            stc = mne.read_source_estimate(stc_path) 
            stc.crop(cropwin[0],cropwin[1])
            AVG_STC_cond[c,s,:,:] = stc.data/(multfact/2)  
        
        # compute the difference
    AVG_STC_1 = np.mean(AVG_STC_cond[0,:,:,:],axis = 0)
    AVG_STC_2 = np.mean(AVG_STC_cond[1,:,:,:],axis = 0)    
    
    sem = np.std(AVG_STC_cond)/np.sqrt(len(ListSubj))
    
    #tmp = np.mean(AVG_STC_cond,2)
    #pl.plot(np.rollaxis(tmp[0,:,:],1))    
    
    # Replace the values & # save the stc
    tmp = AVG_STC_1 - AVG_STC_2
    fsave_vertices = [np.arange(stc0.shape[0]/2), np.arange(stc0.shape[0]/2)]
    stc_Diff1 = mne.SourceEstimate(tmp,fsave_vertices,stc0.tmin,stc0.tstep) 
    stc_Diff1.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_Normalized' +
                 modality + '_' + condcouple[0] + '-' + condcouple[1] +
                 '_pick_ori'+ori+'_' + method + '_ico-5-fwd-fsaverage.stc')
    #img = stc.as_volume,              
                 
                 
    tmp = AVG_STC_1
    stc_1 = mne.SourceEstimate(tmp,fsave_vertices,stc0.tmin,stc0.tstep) 
    stc_1.save(('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_Normalized' +
                 modality + '_' + condcouple[0] +
                 '_pick_ori'+ori+'_' + method + '_ico-5-fwd-fsaverage.stc'))
    tmp = AVG_STC_2
    stc_2 = mne.SourceEstimate(tmp,fsave_vertices,stc0.tmin,stc0.tstep) 
    stc_2.save(('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_Normalized' +
                 modality + '_' + condcouple[1] +
                 '_pick_ori'+ori+'_' + method + '_ico-5-fwd-fsaverage.stc'))
                 
    return sem    
    
############################################################################### 
def compute_stcdiff_group_twin(ListSubj,condcouple,modality,method,twin,ori,cropwin):     

    # load a specific STC morphed on fsaverage
    stc0_path = (wdir + '/' + ListSubj[0] + '/mne_python/STCS/IcaCorr_' + modality + 
           '_' + ListSubj[0] + '_' +condcouple[0] + '_pick_ori'+ ori +'_' + 
            method + '_ico-5-fwd-fsaverage.fif-rh.stc')
    stc0      = mne.read_source_estimate(stc0_path)
    stc0.crop(cropwin[0],cropwin[1])
    ncond     = len(condcouple)
    nsub      = len(ListSubj)
    ntimes    = len(stc0.times)    
    nvertices = stc0.data.shape[0]       

    # average individual STCs morphed on fsaverage for each cond
    AVG_STC_cond  = np.empty([ncond, nsub, nvertices, ntimes])
    for c,cond in enumerate(condcouple):
        for s,subj in enumerate(ListSubj):
            stc_path = (wdir + '/' + subj + '/mne_python/STCS/IcaCorr_' + modality +
                        '_' + subj + '_' + cond + '_pick_ori' + ori +'_' + 
                        method + '_ico-5-fwd-fsaverage.fif-rh.stc')
            stc = mne.read_source_estimate(stc_path)
            stc.crop(cropwin[0],cropwin[1])
            AVG_STC_cond[c,s,:,:] = stc.data
    
    # compute the difference
    AVG_STC_1 = np.mean(AVG_STC_cond[0,:,:,:],axis = 0)
    AVG_STC_2 = np.mean(AVG_STC_cond[1,:,:,:],axis = 0)      

    sem = np.std(AVG_STC_cond)/np.sqrt(len(ListSubj)) 
    
    #tmp = np.mean(AVG_STC_cond,2)
    #pl.plot(np.rollaxis(tmp[0,:,:],1))    
    
    # Replace the values & # save the stc
    tmp = AVG_STC_1 - AVG_STC_2
    fsave_vertices = [np.arange(stc0.shape[0]/2), np.arange(stc0.shape[0]/2)]
    stc_Diff1 = mne.SourceEstimate(tmp,fsave_vertices,stc0.tmin,stc0.tstep) 
    stc_Dummy = mne.SourceEstimate(tmp,fsave_vertices,stc0.tmin,stc0.tstep) 
    stc_Dummy.crop(tmin = 0, tmax = 0.005)
    
    stc_Diff1.crop(tmin=twin[0],tmax=twin[1])
    
    tmp = (np.mean(stc_Diff1.data,1))
    tmp = tmp[:,np.newaxis]
    stc = mne.SourceEstimate(tmp,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stc.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_' +
                 modality + '_' + condcouple[0] + '-' + condcouple[1] + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')
                 
    tmp = AVG_STC_1
    stc_1 = mne.SourceEstimate(tmp,fsave_vertices,stc0.tmin,stc0.tstep) 
    stc_1.save(('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_' +
                 modality + '_' + condcouple[0] +
                 '_pick_ori'+ori+'_' + method + '_ico-5-fwd-fsaverage.stc'))
    tmp = AVG_STC_2
    stc_2 = mne.SourceEstimate(tmp,fsave_vertices,stc0.tmin,stc0.tstep) 
    stc_2.save(('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_' +
                 modality + '_' + condcouple[1] +
                 '_pick_ori'+ori+'_' + method + '_ico-5-fwd-fsaverage.stc'))
 
    return sem
 
#############################################################################
def compute_stcdiff_group_twin2(ListSubj,condcouple,modality,method,twin,ori,cropwin):     

    # load a specific STC morphed on fsaverage
    stc0_path = (wdir + '/' + ListSubj[0] + '/mne_python/STCS/IcaCorr_' + modality + 
           '_' + ListSubj[0] + '_' +condcouple[0] + '_pick_ori'+ ori +'_' + 
            method + '_ico-5-fwd-fsaverage.fif-rh.stc')
    stc0      = mne.read_source_estimate(stc0_path)
    stc0.crop(cropwin[0],cropwin[1])
    ncond     = len(condcouple)
    nsub      = len(ListSubj)
    ntimes    = len(stc0.times)    
    nvertices = stc0.data.shape[0]       

    # average individual STCs morphed on fsaverage for each cond
    AVG_STC_cond  = np.empty([ncond, nsub, nvertices, ntimes])
    multfact = 0
    for c,cond in enumerate(condcouple):
        for s,subj in enumerate(ListSubj):
            stc_path = (wdir + '/' + subj + '/mne_python/STCS/IcaCorr_' + modality +
                        '_' + subj + '_' + cond + '_pick_ori' + ori +'_' + 
                        method + '_ico-5-fwd-fsaverage.fif-rh.stc')
            stc = mne.read_source_estimate(stc_path)
            stc.crop(cropwin[0],cropwin[1])
            AVG_STC_cond[c,s,:,:] = stc.data
            multfact = multfact  + np.mean(np.mean(stc.data))
            
    AVG_STC_cond  = np.empty([ncond, nsub, nvertices, ntimes])
    for c,cond in enumerate(condcouple):
        for s,subj in enumerate(ListSubj):
            stc_path = (wdir + '/' + subj + '/mne_python/STCS/IcaCorr_' + modality +
                        '_' + subj + '_' + cond + '_pick_ori' + ori +'_' + 
                        method + '_ico-5-fwd-fsaverage.fif-rh.stc')
            stc = mne.read_source_estimate(stc_path)
            stc.crop(cropwin[0],cropwin[1])
            AVG_STC_cond[c,s,:,:] = stc.data/(multfact/2)

   
    # compute the difference
    AVG_STC_1 = np.mean(AVG_STC_cond[0,:,:,:],axis = 0)
    AVG_STC_2 = np.mean(AVG_STC_cond[1,:,:,:],axis = 0)      

    sem = np.std(AVG_STC_cond)/np.sqrt(len(ListSubj)) 
    
    #tmp = np.mean(AVG_STC_cond,2)
    #pl.plot(np.rollaxis(tmp[0,:,:],1))    
    
    # Replace the values & # save the stc
    tmp = AVG_STC_1 - AVG_STC_2
    fsave_vertices = [np.arange(stc0.shape[0]/2), np.arange(stc0.shape[0]/2)]
    stc_Diff1 = mne.SourceEstimate(tmp,fsave_vertices,stc0.tmin,stc0.tstep) 
    stc_Dummy = mne.SourceEstimate(tmp,fsave_vertices,stc0.tmin,stc0.tstep) 
    stc_Dummy.crop(tmin = 0, tmax = 0.005)
    
    stc_Diff1.crop(tmin=twin[0],tmax=twin[1])
    
    tmp = (np.mean(stc_Diff1.data,1))
    tmp = tmp[:,np.newaxis]
    stc = mne.SourceEstimate(tmp,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stc.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_Normalized_' +
                 modality + '_' + condcouple[0] + '-' + condcouple[1] + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')
                 
    tmp = AVG_STC_1
    stc_1 = mne.SourceEstimate(tmp,fsave_vertices,stc0.tmin,stc0.tstep) 
    stc_1.save(('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_Normalized_' +
                 modality + '_' + condcouple[0] +
                 '_pick_ori'+ori+'_' + method + '_ico-5-fwd-fsaverage.stc'))
    tmp = AVG_STC_2
    stc_2 = mne.SourceEstimate(tmp,fsave_vertices,stc0.tmin,stc0.tstep) 
    stc_2.save(('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_Normalized_' +
                 modality + '_' + condcouple[1] +
                 '_pick_ori'+ori+'_' + method + '_ico-5-fwd-fsaverage.stc'))
 
    return sem 

###############################################################################
def compute_stcdiff_group_twin2_ttest(ListSubj,condcouple,modality,method,twin,ori,cropwin):     

    # load a specific STC morphed on fsaverage
    stc0_path = (wdir + '/' + ListSubj[0] + '/mne_python/STCS/IcaCorr_' + modality + 
           '_' + ListSubj[0] + '_' +condcouple[0] + '_pick_ori'+ ori +'_' + 
            method + '_ico-5-fwd-fsaverage.fif-rh.stc')
    stc0      = mne.read_source_estimate(stc0_path)
    stc0.crop(twin[0],twin[1])
    ncond     = len(condcouple)
    nsub      = len(ListSubj)
    ntimes    = len(stc0.times)    
    nvertices = stc0.data.shape[0]       

    # average individual STCs morphed on fsaverage for each cond
    AVG_STC_cond  = np.empty([ncond, nsub, nvertices, ntimes])
    multfact = 0
    for c,cond in enumerate(condcouple):
        for s,subj in enumerate(ListSubj):
            stc_path = (wdir + '/' + subj + '/mne_python/STCS/IcaCorr_' + modality +
                        '_' + subj + '_' + cond + '_pick_ori' + ori +'_' + 
                        method + '_ico-5-fwd-fsaverage.fif-rh.stc')
            stc = mne.read_source_estimate(stc_path)
            stc.crop(twin[0],twin[1])
            AVG_STC_cond[c,s,:,:] = stc.data
            multfact = multfact  + np.mean(np.mean(stc.data))
            
    AVG_STC_cond  = np.empty([ncond, nsub, nvertices, ntimes])
    for c,cond in enumerate(condcouple):
        for s,subj in enumerate(ListSubj):
            stc_path = (wdir + '/' + subj + '/mne_python/STCS/IcaCorr_' + modality +
                        '_' + subj + '_' + cond + '_pick_ori' + ori +'_' + 
                        method + '_ico-5-fwd-fsaverage.fif-rh.stc')
            stc = mne.read_source_estimate(stc_path)
            stc.crop(twin[0],twin[1])
            AVG_STC_cond[c,s,:,:] = stc.data/(multfact/2)

   
    # compute the difference
    AVG_STC_1 = np.mean(AVG_STC_cond[0,:,:,:],axis = 0)
    AVG_STC_2 = np.mean(AVG_STC_cond[1,:,:,:],axis = 0)      
    
    # compute the difference per subject for test across vertices
    Diff = np.empty([1, nsub, nvertices, ntimes])
    tmap = np.empty([nvertices])
    Diff = AVG_STC_cond[0,:,:,:] - AVG_STC_cond[1,:,:,:]
    Diff = np.mean(Diff, axis = 2)
    
    Mask05  = np.zeros((Diff.shape[1]))
    Mask01  = np.zeros((Diff.shape[1]))
    Mask005 = np.zeros((Diff.shape[1]))
    Mask001 = np.zeros((Diff.shape[1]))
    # mean on the twin
    for v in range(Diff.shape[1]):
        t,p = stats.ttest_1samp(Diff[:,v],0)
        tmap[v] = t
        if p < 0.001:
            Mask001[v] = 1
            
    for v in range(Diff.shape[1]):
        t,p = stats.ttest_1samp(Diff[:,v],0)
        if p < 0.005:
            Mask005[v] = 1
            
    for v in range(Diff.shape[1]):
        t,p = stats.ttest_1samp(Diff[:,v],0)
        if p < 0.01:
            Mask01[v] = 1
            
    for v in range(Diff.shape[1]):
        t,p = stats.ttest_1samp(Diff[:,v],0)
        if p < 0.05:
            Mask05[v] = 1

    sem = np.std(AVG_STC_cond)/np.sqrt(len(ListSubj)) 
    
    #tmp = np.mean(AVG_STC_cond,2)
    #pl.plot(np.rollaxis(tmp[0,:,:],1))    
    
    # Replace the values & # save the stc
    tmp = AVG_STC_1 - AVG_STC_2
    fsave_vertices = [np.arange(stc0.shape[0]/2), np.arange(stc0.shape[0]/2)]
    stc_Diff1 = mne.SourceEstimate(tmp,fsave_vertices,stc0.tmin,stc0.tstep) 
    stc_Dummy = mne.SourceEstimate(tmp,fsave_vertices,stc0.tmin,stc0.tstep) 
    stc_Dummy.crop(tmin = twin[0], tmax = twin[0]+0.005)
    
    stc_Diff1.crop(tmin=twin[0],tmax=twin[1])
    
    tmp = (np.mean(stc_Diff1.data,1))
    tmp05 = tmp*Mask05
    tmp01 = tmp*Mask01
    tmp005 = tmp*Mask005
    tmap005 = tmap*Mask005
    tmp001 = tmp*Mask001
    tmp05 = tmp05[:,np.newaxis]
    tmp01 = tmp01[:,np.newaxis]
    tmp005 = tmp005[:,np.newaxis]
    tmp001 = tmp001[:,np.newaxis]
    tmp = tmp[:,np.newaxis]
    tmap = tmap[:,np.newaxis]
    tmap005 = tmap005[:,np.newaxis]
    stc = mne.SourceEstimate(tmp,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stc.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_Normalized_' +
                 modality + '_' + condcouple[0] + '-' + condcouple[1] + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')

    stctmap = mne.SourceEstimate(tmap,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stctmap.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_Normalized_tmap_' +
                 modality + '_' + condcouple[0] + '-' + condcouple[1] + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')
                 
    stctmap005 = mne.SourceEstimate(tmap005,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stctmap005.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_Normalized_tmap005_' +
                 modality + '_' + condcouple[0] + '-' + condcouple[1] + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')             

    stc05 = mne.SourceEstimate(tmp05,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stc05.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_Normalized_p05uncorr_' +
                 modality + '_' + condcouple[0] + '-' + condcouple[1] + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')

    stc01 = mne.SourceEstimate(tmp01,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stc01.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_Normalized_p01uncorr_' +
                 modality + '_' + condcouple[0] + '-' + condcouple[1] + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')

    stc001 = mne.SourceEstimate(tmp001,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stc001.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_Normalized_p001uncorr_' +
                 modality + '_' + condcouple[0] + '-' + condcouple[1] + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')
                 
    stc005 = mne.SourceEstimate(tmp005,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stc005.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_Normalized_p005uncorr_' +
                 modality + '_' + condcouple[0] + '-' + condcouple[1] + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')
                 
    tmp = AVG_STC_1
    stc_1 = mne.SourceEstimate(tmp,fsave_vertices,stc0.tmin,stc0.tstep) 
    stc_1.save(('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_Normalized_' +
                 modality + '_' + condcouple[0] +
                 '_pick_ori'+ori+'_' + method + '_ico-5-fwd-fsaverage.stc'))
    tmp = AVG_STC_2
    stc_2 = mne.SourceEstimate(tmp,fsave_vertices,stc0.tmin,stc0.tstep) 
    stc_2.save(('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_Normalized_' +
                 modality + '_' + condcouple[1] +
                 '_pick_ori'+ori+'_' + method + '_ico-5-fwd-fsaverage.stc'))
 
    return sem 

############################################################################### 
def compute_stcdiff_group_twin2_ttest_v2(ListSubj,condcouple,modality,method,twin,ori,cropwin):     

    # load a specific STC morphed on fsaverage
    stc0_path = (wdir + '/' + ListSubj[0] + '/mne_python/STCS/' + modality + 
           '_' + ListSubj[0] + '_' +condcouple[0] + '_pick_ori'+ ori +'_' + 
            method + '_ico-5-fwd-fsaverage.fif-rh.stc')
    stc0      = mne.read_source_estimate(stc0_path)
    stc0.crop(twin[0],twin[1])
    ncond     = len(condcouple)
    nsub      = len(ListSubj)
    ntimes    = len(stc0.times)    
    nvertices = stc0.data.shape[0]       

    # average individual STCs morphed on fsaverage for each cond
    AVG_STC_cond  = np.empty([ncond, nsub, nvertices, ntimes])
    multfact = 0
    for c,cond in enumerate(condcouple):
        for s,subj in enumerate(ListSubj):
            stc_path = (wdir + '/' + subj + '/mne_python/STCS/' + modality +
                        '_' + subj + '_' + cond + '_pick_ori' + ori +'_' + 
                        method + '_ico-5-fwd-fsaverage.fif-rh.stc')
            stc = mne.read_source_estimate(stc_path)
            stc.crop(twin[0],twin[1])
            AVG_STC_cond[c,s,:,:] = stc.data
            multfact = multfact  + np.mean(np.mean(stc.data))
            
    AVG_STC_cond  = np.empty([ncond, nsub, nvertices, ntimes])
    for c,cond in enumerate(condcouple):
        for s,subj in enumerate(ListSubj):
            stc_path = (wdir + '/' + subj + '/mne_python/STCS/' + modality +
                        '_' + subj + '_' + cond + '_pick_ori' + ori +'_' + 
                        method + '_ico-5-fwd-fsaverage.fif-rh.stc')
            stc = mne.read_source_estimate(stc_path)
            stc.crop(twin[0],twin[1])
            AVG_STC_cond[c,s,:,:] = stc.data/(multfact/2)

   
    # compute the difference
    AVG_STC_1 = np.mean(AVG_STC_cond[0,:,:,:],axis = 0)
    AVG_STC_2 = np.mean(AVG_STC_cond[1,:,:,:],axis = 0)      
    
    # compute the difference per subject for test across vertices
    Diff = np.empty([1, nsub, nvertices, ntimes])
    tmap = np.empty([nvertices])
    Diff = AVG_STC_cond[0,:,:,:] - AVG_STC_cond[1,:,:,:]
    Diff = np.mean(Diff, axis = 2)
    
    Mask05  = np.zeros((Diff.shape[1]))
    Mask01  = np.zeros((Diff.shape[1]))
    Mask005 = np.zeros((Diff.shape[1]))
    Mask001 = np.zeros((Diff.shape[1]))
    # mean on the twin
    for v in range(Diff.shape[1]):
        t,p = stats.ttest_1samp(Diff[:,v],0)
        tmap[v] = t
        if p < 0.001:
            Mask001[v] = 1
            
    for v in range(Diff.shape[1]):
        t,p = stats.ttest_1samp(Diff[:,v],0)
        if p < 0.005:
            Mask005[v] = 1
            
    for v in range(Diff.shape[1]):
        t,p = stats.ttest_1samp(Diff[:,v],0)
        if p < 0.01:
            Mask01[v] = 1
            
    for v in range(Diff.shape[1]):
        t,p = stats.ttest_1samp(Diff[:,v],0)
        if p < 0.05:
            Mask05[v] = 1

    sem = np.std(AVG_STC_cond)/np.sqrt(len(ListSubj)) 
    
    #tmp = np.mean(AVG_STC_cond,2)
    #pl.plot(np.rollaxis(tmp[0,:,:],1))    
    
    # Replace the values & # save the stc
    tmp = AVG_STC_1 - AVG_STC_2
    fsave_vertices = [np.arange(stc0.shape[0]/2), np.arange(stc0.shape[0]/2)]
    stc_Diff1 = mne.SourceEstimate(tmp,fsave_vertices,stc0.tmin,stc0.tstep) 
    stc_Dummy = mne.SourceEstimate(tmp,fsave_vertices,stc0.tmin,stc0.tstep) 
    stc_Dummy.crop(tmin = twin[0], tmax = twin[0]+0.005)
    
    stc_Diff1.crop(tmin=twin[0],tmax=twin[1])
    
    tmp = (np.mean(stc_Diff1.data,1))
    tmp05 = tmp*Mask05
    tmp01 = tmp*Mask01
    tmp005 = tmp*Mask005
    tmp001 = tmp*Mask001
    tmp05 = tmp05[:,np.newaxis]
    tmp01 = tmp01[:,np.newaxis]
    tmp005 = tmp005[:,np.newaxis]
    tmp001 = tmp001[:,np.newaxis]
    tmp = tmp[:,np.newaxis]
    tmap = tmap[:,np.newaxis]
    stc = mne.SourceEstimate(tmp,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stc.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_Normalized_' +
                 modality + '_' + condcouple[0] + '-' + condcouple[1] + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')

    stctmap = mne.SourceEstimate(tmap,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stctmap.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_Normalized_tmap_' +
                 modality + '_' + condcouple[0] + '-' + condcouple[1] + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')

    stc05 = mne.SourceEstimate(tmp05,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stc05.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_Normalized_p05uncorr_' +
                 modality + '_' + condcouple[0] + '-' + condcouple[1] + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')

    stc01 = mne.SourceEstimate(tmp01,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stc01.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_Normalized_p01uncorr_' +
                 modality + '_' + condcouple[0] + '-' + condcouple[1] + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')

    stc001 = mne.SourceEstimate(tmp001,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stc001.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_Normalized_p001uncorr_' +
                 modality + '_' + condcouple[0] + '-' + condcouple[1] + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')
                 
    stc005 = mne.SourceEstimate(tmp005,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stc005.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_Normalized_p005uncorr_' +
                 modality + '_' + condcouple[0] + '-' + condcouple[1] + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')
                 
    tmp = AVG_STC_1
    stc_1 = mne.SourceEstimate(tmp,fsave_vertices,stc0.tmin,stc0.tstep) 
    stc_1.save(('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_Normalized_' +
                 modality + '_' + condcouple[0] +
                 '_pick_ori'+ori+'_' + method + '_ico-5-fwd-fsaverage.stc'))
    tmp = AVG_STC_2
    stc_2 = mne.SourceEstimate(tmp,fsave_vertices,stc0.tmin,stc0.tstep) 
    stc_2.save(('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_Normalized_' +
                 modality + '_' + condcouple[1] +
                 '_pick_ori'+ori+'_' + method + '_ico-5-fwd-fsaverage.stc'))
 
    return sem 
  
###############################################################################
def compute_stcdiff_group_twin2_ttest_nornorm(ListSubj,condcouple,modality,method,twin,ori,cropwin):     

    # load a specific STC morphed on fsaverage
    stc0_path = (wdir + '/' + ListSubj[0] + '/mne_python/STCS/IcaCorr_' + modality + 
           '_' + ListSubj[0] + '_' +condcouple[0] + '_pick_ori'+ ori +'_' + 
            method + '_ico-5-fwd-fsaverage.fif-rh.stc')
    stc0      = mne.read_source_estimate(stc0_path)
    stc0.crop(twin[0],twin[1])
    ncond     = len(condcouple)
    nsub      = len(ListSubj)
    ntimes    = len(stc0.times)    
    nvertices = stc0.data.shape[0]       

    # average individual STCs morphed on fsaverage for each cond
    AVG_STC_cond  = np.empty([ncond, nsub, nvertices, ntimes])
    multfact = 0
    for c,cond in enumerate(condcouple):
        for s,subj in enumerate(ListSubj):
            stc_path = (wdir + '/' + subj + '/mne_python/STCS/IcaCorr_' + modality +
                        '_' + subj + '_' + cond + '_pick_ori' + ori +'_' + 
                        method + '_ico-5-fwd-fsaverage.fif-rh.stc')
            stc = mne.read_source_estimate(stc_path)
            stc.crop(twin[0],twin[1])
            AVG_STC_cond[c,s,:,:] = stc.data

    # compute the difference
    AVG_STC_1 = np.mean(AVG_STC_cond[0,:,:,:],axis = 0)
    AVG_STC_2 = np.mean(AVG_STC_cond[1,:,:,:],axis = 0)      
    
    # compute the difference per subject for test across vertices
    Diff = np.empty([1, nsub, nvertices, ntimes])
    Diff = AVG_STC_cond[0,:,:,:] - AVG_STC_cond[1,:,:,:]
    Diff = np.mean(Diff, axis = 2)
    
    Mask05  = np.zeros((Diff.shape[1]))
    Mask01  = np.zeros((Diff.shape[1]))
    Mask005 = np.zeros((Diff.shape[1]))
    Mask001 = np.zeros((Diff.shape[1]))
    # mean on the twin
    for v in range(Diff.shape[1]):
        t,p = stats.ttest_1samp(Diff[:,v],0)
        if p < 0.001:
            Mask001[v] = 1
            
    for v in range(Diff.shape[1]):
        t,p = stats.ttest_1samp(Diff[:,v],0)
        if p < 0.005:
            Mask005[v] = 1
            
    for v in range(Diff.shape[1]):
        t,p = stats.ttest_1samp(Diff[:,v],0)
        if p < 0.01:
            Mask01[v] = 1
            
    for v in range(Diff.shape[1]):
        t,p = stats.ttest_1samp(Diff[:,v],0)
        if p < 0.05:
            Mask05[v] = 1

    sem = np.std(AVG_STC_cond)/np.sqrt(len(ListSubj)) 
    
    #tmp = np.mean(AVG_STC_cond,2)
    #pl.plot(np.rollaxis(tmp[0,:,:],1))    
    
    # Replace the values & # save the stc
    tmp = AVG_STC_1 - AVG_STC_2
    fsave_vertices = [np.arange(stc0.shape[0]/2), np.arange(stc0.shape[0]/2)]
    stc_Diff1 = mne.SourceEstimate(tmp,fsave_vertices,stc0.tmin,stc0.tstep) 
    stc_Dummy = mne.SourceEstimate(tmp,fsave_vertices,stc0.tmin,stc0.tstep) 
    stc_Dummy.crop(tmin = twin[0], tmax = twin[0]+0.005)
    
    stc_Diff1.crop(tmin=twin[0],tmax=twin[1])
    
    tmp = (np.mean(stc_Diff1.data,1))
    tmp05 = tmp*Mask05
    tmp01 = tmp*Mask01
    tmp005 = tmp*Mask005
    tmp001 = tmp*Mask001
    tmp05 = tmp05[:,np.newaxis]
    tmp01 = tmp01[:,np.newaxis]
    tmp005 = tmp005[:,np.newaxis]
    tmp001 = tmp001[:,np.newaxis]
    tmp = tmp[:,np.newaxis]
    stc = mne.SourceEstimate(tmp,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stc.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_' +
                 modality + '_' + condcouple[0] + '-' + condcouple[1] + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')

    stc05 = mne.SourceEstimate(tmp05,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stc05.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_p05uncorr_' +
                 modality + '_' + condcouple[0] + '-' + condcouple[1] + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')

    stc01 = mne.SourceEstimate(tmp01,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stc01.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_p01uncorr_' +
                 modality + '_' + condcouple[0] + '-' + condcouple[1] + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')

    stc001 = mne.SourceEstimate(tmp001,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stc001.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_p001uncorr_' +
                 modality + '_' + condcouple[0] + '-' + condcouple[1] + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')
                 
    stc005 = mne.SourceEstimate(tmp005,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stc005.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_p005uncorr_' +
                 modality + '_' + condcouple[0] + '-' + condcouple[1] + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')            
 
    return sem   
 
###############################################################################
def compute_stcdiff_group_twin2_ftest_nornorm(ListSubj,condcouple,modality,method,twin,ori,cropwin):     

    # load a specific STC morphed on fsaverage
    stc0_path = (wdir + '/' + ListSubj[0] + '/mne_python/STCS/IcaCorr_' + modality + 
           '_' + ListSubj[0] + '_' +condcouple[0] + '_pick_ori'+ ori +'_' + 
            method + '_ico-5-fwd-fsaverage.fif-rh.stc')
    stc0      = mne.read_source_estimate(stc0_path)
    stc0.crop(twin[0],twin[1])
    ncond     = len(condcouple)
    nsub      = len(ListSubj)
    ntimes    = len(stc0.times)    
    nvertices = stc0.data.shape[0]       

    # average individual STCs morphed on fsaverage for each cond
    AVG_STC_cond  = np.empty([ncond, nsub, nvertices, ntimes])
    for c,cond in enumerate(condcouple):
        for s,subj in enumerate(ListSubj):
            stc_path = (wdir + '/' + subj + '/mne_python/STCS/IcaCorr_' + modality +
                        '_' + subj + '_' + cond + '_pick_ori' + ori +'_' + 
                        method + '_ico-5-fwd-fsaverage.fif-rh.stc')
            stc = mne.read_source_estimate(stc_path)
            stc.crop(twin[0],twin[1])
            AVG_STC_cond[c,s,:,:] = stc.data

    # compute the difference
    AVG_STC_1 = np.mean(AVG_STC_cond[0,:,:,:],axis = 0)
    AVG_STC_2 = np.mean(AVG_STC_cond[1,:,:,:],axis = 0)      
    AVG_STC_3 = np.mean(AVG_STC_cond[1,:,:,:],axis = 0)     
    
    # compute the difference per subject for test across vertices
    Diff = np.empty([1, nsub, nvertices, ntimes])
    Diff = AVG_STC_cond[0,:,:,:] - AVG_STC_cond[1,:,:,:]
    Diff = np.mean(Diff, axis = 2)
    
    Mask05  = np.zeros((Diff.shape[1]))
    Mask01  = np.zeros((Diff.shape[1]))
    Mask005 = np.zeros((Diff.shape[1]))
    Mask001 = np.zeros((Diff.shape[1]))
    # mean on the twin
    for v in range(Diff.shape[1]):
        t,p = stats.ttest_1samp(Diff[:,v],0)
        if p < 0.001:
            Mask001[v] = 1
            
    for v in range(Diff.shape[1]):
        t,p = stats.ttest_1samp(Diff[:,v],0)
        if p < 0.005:
            Mask005[v] = 1
            
    for v in range(Diff.shape[1]):
        t,p = stats.ttest_1samp(Diff[:,v],0)
        if p < 0.01:
            Mask01[v] = 1
            
    for v in range(Diff.shape[1]):
        t,p = stats.ttest_1samp(Diff[:,v],0)
        if p < 0.05:
            Mask05[v] = 1

    sem = np.std(AVG_STC_cond)/np.sqrt(len(ListSubj)) 
    
    #tmp = np.mean(AVG_STC_cond,2)
    #pl.plot(np.rollaxis(tmp[0,:,:],1))    
    
    # Replace the values & # save the stc
    tmp = AVG_STC_1 - AVG_STC_2
    fsave_vertices = [np.arange(stc0.shape[0]/2), np.arange(stc0.shape[0]/2)]
    stc_Diff1 = mne.SourceEstimate(tmp,fsave_vertices,stc0.tmin,stc0.tstep) 
    stc_Dummy = mne.SourceEstimate(tmp,fsave_vertices,stc0.tmin,stc0.tstep) 
    stc_Dummy.crop(tmin = twin[0], tmax = twin[0]+0.005)
    
    stc_Diff1.crop(tmin=twin[0],tmax=twin[1])
    
    tmp = (np.mean(stc_Diff1.data,1))
    tmp05 = tmp*Mask05
    tmp01 = tmp*Mask01
    tmp005 = tmp*Mask005
    tmp001 = tmp*Mask001
    tmp05 = tmp05[:,np.newaxis]
    tmp01 = tmp01[:,np.newaxis]
    tmp005 = tmp005[:,np.newaxis]
    tmp001 = tmp001[:,np.newaxis]
    tmp = tmp[:,np.newaxis]
    stc = mne.SourceEstimate(tmp,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stc.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_' +
                 modality + '_' + condcouple[0] + '-' + condcouple[1] + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')

    stc05 = mne.SourceEstimate(tmp05,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stc05.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_p05uncorr_' +
                 modality + '_' + condcouple[0] + '-' + condcouple[1] + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')

    stc01 = mne.SourceEstimate(tmp01,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stc01.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_p01uncorr_' +
                 modality + '_' + condcouple[0] + '-' + condcouple[1] + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')

    stc001 = mne.SourceEstimate(tmp001,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stc001.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_p001uncorr_' +
                 modality + '_' + condcouple[0] + '-' + condcouple[1] + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')
                 
    stc005 = mne.SourceEstimate(tmp005,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stc005.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_p005uncorr_' +
                 modality + '_' + condcouple[0] + '-' + condcouple[1] + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')            
 
    return sem    
 
###############################################################################
def compute_stcdiff_group_twin2_ttest_int4(ListSubj,condcouple,modality,method,twin,ori,cropwin):     

    # load a specific STC morphed on fsaverage
    stc0_path = (wdir + '/' + ListSubj[0] + '/mne_python/STCS/IcaCorr_' + modality + 
           '_' + ListSubj[0] + '_' +condcouple[0] + '_pick_ori'+ ori +'_' + 
            method + '_ico-5-fwd-fsaverage.fif-rh.stc')
    stc0      = mne.read_source_estimate(stc0_path)
    stc0.crop(twin[0],twin[1])
    ncond     = len(condcouple)
    nsub      = len(ListSubj)
    ntimes    = len(stc0.times)    
    nvertices = stc0.data.shape[0]       

    # average individual STCs morphed on fsaverage for each cond
    AVG_STC_cond  = np.empty([ncond, nsub, nvertices, ntimes])
    for c,cond in enumerate(condcouple):
        for s,subj in enumerate(ListSubj):
            stc_path = (wdir + '/' + subj + '/mne_python/STCS/IcaCorr_' + modality +
                        '_' + subj + '_' + cond + '_pick_ori' + ori +'_' + 
                        method + '_ico-5-fwd-fsaverage.fif-rh.stc')
            stc = mne.read_source_estimate(stc_path)
            stc.crop(twin[0],twin[1])
            AVG_STC_cond[c,s,:,:] = stc.data

    # compute the difference
    AVG_STC_1 = np.mean(AVG_STC_cond[0,:,:,:],axis = 0)
    AVG_STC_2 = np.mean(AVG_STC_cond[1,:,:,:],axis = 0)   
    AVG_STC_3 = np.mean(AVG_STC_cond[2,:,:,:],axis = 0)
    AVG_STC_4 = np.mean(AVG_STC_cond[3,:,:,:],axis = 0)       
    
    # compute the difference per subject for test across vertices
    Diff = np.empty([1, nsub, nvertices, ntimes])
    Diff = (AVG_STC_cond[0,:,:,:] - AVG_STC_cond[1,:,:,:]) - (AVG_STC_cond[2,:,:,:] - AVG_STC_cond[3,:,:,:])
    Diff = np.mean(Diff, axis = 2)
    tmap = np.empty([nvertices])
    
    Mask05  = np.zeros((Diff.shape[1]))
    Mask01  = np.zeros((Diff.shape[1]))
    Mask005 = np.zeros((Diff.shape[1]))
    Mask001 = np.zeros((Diff.shape[1]))
    # mean on the twin
    for v in range(Diff.shape[1]):
        t,p = stats.ttest_1samp(Diff[:,v],0)
        tmap[v] = t
        if p < 0.001:
            Mask001[v] = 1
            
    for v in range(Diff.shape[1]):
        t,p = stats.ttest_1samp(Diff[:,v],0)
        if p < 0.005:
            Mask005[v] = 1
            
    for v in range(Diff.shape[1]):
        t,p = stats.ttest_1samp(Diff[:,v],0)
        if p < 0.01:
            Mask01[v] = 1
            
    for v in range(Diff.shape[1]):
        t,p = stats.ttest_1samp(Diff[:,v],0)
        if p < 0.05:
            Mask05[v] = 1

    sem = np.std(AVG_STC_cond)/np.sqrt(len(ListSubj)) 
    
    #tmp = np.mean(AVG_STC_cond,2)
    #pl.plot(np.rollaxis(tmp[0,:,:],1))    
    
    # Replace the values & # save the stc
    tmp = (AVG_STC_1 - AVG_STC_2) - (AVG_STC_3 - AVG_STC_4)
    fsave_vertices = [np.arange(stc0.shape[0]/2), np.arange(stc0.shape[0]/2)]
    stc_Diff1 = mne.SourceEstimate(tmp,fsave_vertices,stc0.tmin,stc0.tstep) 
    stc_Dummy = mne.SourceEstimate(tmp,fsave_vertices,stc0.tmin,stc0.tstep) 
    stc_Dummy.crop(tmin = twin[0], tmax = twin[0]+0.005)
    
    stc_Diff1.crop(tmin=twin[0],tmax=twin[1])
    
    tmp = (np.mean(stc_Diff1.data,1))
    tmp05 = tmp*Mask05
    tmp01 = tmp*Mask01
    tmp005 = tmp*Mask005
    tmp001 = tmp*Mask001
    tmp05 = tmp05[:,np.newaxis]
    tmp01 = tmp01[:,np.newaxis]
    tmp005 = tmp005[:,np.newaxis]
    tmp001 = tmp001[:,np.newaxis]
    tmap = tmap[:,np.newaxis]
    tmp = tmp[:,np.newaxis]
    stc = mne.SourceEstimate(tmp,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stc.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_' +
                 modality + '_INT' + condcouple[0] + '-' + condcouple[1] +
                 condcouple[2] + '-' + condcouple[3] +'_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')

    stctmap = mne.SourceEstimate(tmap,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stctmap.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_tmap_' +
                 modality + '_INT' + condcouple[0] + '-' + condcouple[1] +
                 condcouple[2] + '-' + condcouple[3] +'_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')


    stc05 = mne.SourceEstimate(tmp05,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stc05.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_p05uncorr_' +
                 modality + '_INT' + condcouple[0] + '-' + condcouple[1] +
                 condcouple[2] + '-' + condcouple[3] +'_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')

    stc01 = mne.SourceEstimate(tmp01,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stc01.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_p01uncorr_' +
                 modality + '_INT' + condcouple[0] + '-' + condcouple[1] +
                 condcouple[2] + '-' + condcouple[3] +'_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')

    stc001 = mne.SourceEstimate(tmp001,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stc001.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_p001uncorr_' +
                 modality + '_INT' + condcouple[0] + '-' + condcouple[1] +
                 condcouple[2] + '-' + condcouple[3] +'_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')
                 
    stc005 = mne.SourceEstimate(tmp005,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stc005.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_p005uncorr_' +
                 modality + '_INT' + condcouple[0] + '-' + condcouple[1] +
                 condcouple[2] + '-' + condcouple[3] +'_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')           
 
    return sem   
###############################################################################  
 
def compute_stcdiff_group_twin2_3cond(ListSubj,condcouple,modality,method,twin,ori,cropwin):     

    # load a specific STC morphed on fsaverage
    stc0_path = (wdir + '/' + ListSubj[0] + '/mne_python/STCS/IcaCorr_' + modality + 
           '_' + ListSubj[0] + '_' +condcouple[0] + '_pick_ori'+ ori +'_' + 
            method + '_ico-5-fwd-fsaverage.fif-rh.stc')
    stc0      = mne.read_source_estimate(stc0_path)
    stc0.crop(cropwin[0],cropwin[1])
    nsub      = len(ListSubj)
    ntimes    = len(stc0.times)    
    nvertices = stc0.data.shape[0]       

    # average individual STCs morphed on fsaverage for each cond
    AVG_STC_cond  = np.empty([2, nsub, nvertices, ntimes])
    multfact  = 0
    multfact2 = 0
    for s,subj in enumerate(ListSubj):
        stc1_path = (wdir + '/' + subj + '/mne_python/STCS/IcaCorr_' + modality +
                    '_' + subj + '_' + condcouple[0] + '_pick_ori' + ori +'_' + 
                    method + '_ico-5-fwd-fsaverage.fif-rh.stc')
        stc1 = mne.read_source_estimate(stc1_path)
        stc1.crop(cropwin[0],cropwin[1])
        multfact = multfact  + np.mean(np.mean(stc1.data))
        stc2_path = (wdir + '/' + subj + '/mne_python/STCS/IcaCorr_' + modality +
                    '_' + subj + '_' + condcouple[1] + '_pick_ori' + ori +'_' + 
                    method + '_ico-5-fwd-fsaverage.fif-rh.stc')
        stc2 = mne.read_source_estimate(stc2_path)
        stc2.crop(cropwin[0],cropwin[1])        
        multfact = multfact  + np.mean(np.mean(stc2.data))
        stc3_path = (wdir + '/' + subj + '/mne_python/STCS/IcaCorr_' + modality +
            '_' + subj + '_' + condcouple[2] + '_pick_ori' + ori +'_' + 
            method + '_ico-5-fwd-fsaverage.fif-rh.stc')
        stc3 = mne.read_source_estimate(stc3_path)
        stc3.crop(cropwin[0],cropwin[1])   
        multfact2 = multfact2  + np.mean(np.mean(stc3.data))
            
    for s,subj in enumerate(ListSubj):
        stc1_path = (wdir + '/' + subj + '/mne_python/STCS/IcaCorr_' + modality +
                    '_' + subj + '_' + condcouple[0] + '_pick_ori' + ori +'_' + 
                    method + '_ico-5-fwd-fsaverage.fif-rh.stc')
        stc1 = mne.read_source_estimate(stc1_path)
        stc1.crop(cropwin[0],cropwin[1])
        stc2_path = (wdir + '/' + subj + '/mne_python/STCS/IcaCorr_' + modality +
            '_' + subj + '_' + condcouple[1] + '_pick_ori' + ori +'_' + 
            method + '_ico-5-fwd-fsaverage.fif-rh.stc')
        stc2 = mne.read_source_estimate(stc2_path)
        stc2.crop(cropwin[0],cropwin[1]) 
        stc3_path = (wdir + '/' + subj + '/mne_python/STCS/IcaCorr_' + modality +
            '_' + subj + '_' + condcouple[2] + '_pick_ori' + ori +'_' + 
            method + '_ico-5-fwd-fsaverage.fif-rh.stc')
        stc3 = mne.read_source_estimate(stc3_path)
        stc3.crop(cropwin[0],cropwin[1])  
        AVG_STC_cond[0,s,:,:] = (((stc1.data+stc2.data)/2)/((multfact+multfact2)/2))
        AVG_STC_cond[1,s,:,:] = ((stc3.data)/((multfact+multfact2)/2))

    # compute the difference
    AVG_STC_1 = np.mean(AVG_STC_cond[0,:,:,:],axis = 0)
    AVG_STC_2 = np.mean(AVG_STC_cond[1,:,:,:],axis = 0)     
    
    sem = np.std(AVG_STC_cond)/np.sqrt(len(ListSubj)) 
    
    #tmp = np.mean(AVG_STC_cond,2)
    #pl.plot(np.rollaxis(tmp[0,:,:],1))    
    
    # Replace the values & # save the stc
    tmp = AVG_STC_1 - AVG_STC_2
    fsave_vertices = [np.arange(stc0.shape[0]/2), np.arange(stc0.shape[0]/2)]
    stc_Diff1 = mne.SourceEstimate(tmp,fsave_vertices,stc0.tmin,stc0.tstep) 
    stc_Dummy = mne.SourceEstimate(tmp,fsave_vertices,stc0.tmin,stc0.tstep) 
    stc_Dummy.crop(tmin = 0, tmax = 0.005)
    
    stc_Diff1.crop(tmin=twin[0],tmax=twin[1])
    
    tmp = (np.mean(stc_Diff1.data,1))
    tmp = tmp[:,np.newaxis]
    stc = mne.SourceEstimate(tmp,fsave_vertices,stc_Dummy.tmin,stc1.tstep) 
    stc.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_Normalized_' +
                 modality + '_Mean' + condcouple[0] + '+' + condcouple[1] + '-' + condcouple[2] + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')
                 
    return sem 

def compute_stcdiff_group_twin2_3cond_ttest(ListSubj,condcouple,modality,method,twin,ori,cropwin):     

    # load a specific STC morphed on fsaverage
    stc0_path = (wdir + '/' + ListSubj[0] + '/mne_python/STCS/IcaCorr_' + modality + 
           '_' + ListSubj[0] + '_' +condcouple[0] + '_pick_ori'+ ori +'_' + 
            method + '_ico-5-fwd-fsaverage.fif-rh.stc')
    stc0      = mne.read_source_estimate(stc0_path)
    stc0.crop(cropwin[0],cropwin[1])
    nsub      = len(ListSubj)
    ntimes    = len(stc0.times)    
    nvertices = stc0.data.shape[0]       

    # average individual STCs morphed on fsaverage for each cond
    AVG_STC_cond  = np.empty([2, nsub, nvertices, ntimes])
    for s,subj in enumerate(ListSubj):
        
        stc1_path = (wdir + '/' + subj + '/mne_python/STCS/IcaCorr_' + modality +
                    '_' + subj + '_' + condcouple[0] + '_pick_ori' + ori +'_' + 
                    method + '_ico-5-fwd-fsaverage.fif-rh.stc')
        stc1 = mne.read_source_estimate(stc1_path)
        stc1.crop(cropwin[0],cropwin[1])
        
        stc2_path = (wdir + '/' + subj + '/mne_python/STCS/IcaCorr_' + modality +
                    '_' + subj + '_' + condcouple[1] + '_pick_ori' + ori +'_' + 
                    method + '_ico-5-fwd-fsaverage.fif-rh.stc')
        stc2 = mne.read_source_estimate(stc2_path)
        stc2.crop(cropwin[0],cropwin[1])        
        
        stc3_path = (wdir + '/' + subj + '/mne_python/STCS/IcaCorr_' + modality +
            '_' + subj + '_' + condcouple[2] + '_pick_ori' + ori +'_' + 
            method + '_ico-5-fwd-fsaverage.fif-rh.stc')
        stc3 = mne.read_source_estimate(stc3_path)
        stc3.crop(cropwin[0],cropwin[1])   
            
        AVG_STC_cond[0,s,:,:] = (stc1.data + stc2.data)/2
        AVG_STC_cond[1,s,:,:] = stc3.data

    # compute the difference
    AVG_STC_1 = np.mean(AVG_STC_cond[0,:,:,:],axis = 0)
    AVG_STC_2 = np.mean(AVG_STC_cond[1,:,:,:],axis = 0)     
    
    sem = np.std(AVG_STC_cond)/np.sqrt(len(ListSubj)) 
    
    # compute the difference per subject for test across vertices
    tmap = np.empty([nvertices])
    Diff = np.empty([1, nsub, nvertices, ntimes])
    Diff = AVG_STC_cond[0,:,:,:] - AVG_STC_cond[1,:,:,:]
    Diff = np.mean(Diff, axis = 2)
    
    Mask05  = np.zeros((Diff.shape[1]))
    Mask01  = np.zeros((Diff.shape[1]))
    Mask005 = np.zeros((Diff.shape[1]))
    Mask001 = np.zeros((Diff.shape[1]))
    # mean on the twin
    for v in range(Diff.shape[1]):
        t,p = stats.ttest_1samp(Diff[:,v],0)
        tmap[v] = t
        if p < 0.001:
            Mask001[v] = 1
            
    for v in range(Diff.shape[1]):
        t,p = stats.ttest_1samp(Diff[:,v],0)
        if p < 0.005:
            Mask005[v] = 1
            
    for v in range(Diff.shape[1]):
        t,p = stats.ttest_1samp(Diff[:,v],0)
        if p < 0.01:
            Mask01[v] = 1
            
    for v in range(Diff.shape[1]):
        t,p = stats.ttest_1samp(Diff[:,v],0)
        if p < 0.05:
            Mask05[v] = 1 
    
    # Replace the values & # save the stc
    tmp = AVG_STC_1 - AVG_STC_2
    fsave_vertices = [np.arange(stc0.shape[0]/2), np.arange(stc0.shape[0]/2)]
    stc_Diff1 = mne.SourceEstimate(tmp,fsave_vertices,stc0.tmin,stc0.tstep) 
    stc_Dummy = mne.SourceEstimate(tmp,fsave_vertices,stc0.tmin,stc0.tstep) 
    stc_Dummy.crop(tmin = 0, tmax = 0.005)
    
    stc_Diff1.crop(tmin=twin[0],tmax=twin[1])
    
    tmp = (np.mean(stc_Diff1.data,1))
    
    tmp = tmp[:,np.newaxis]
    tmp05 = tmp*Mask05
    tmp01 = tmp*Mask01
    tmp005 = tmp*Mask005
    tmp001 = tmp*Mask001
    tmp05 = tmp05[:,np.newaxis]
    tmp01 = tmp01[:,np.newaxis]
    tmp005 = tmp005[:,np.newaxis]
    tmp001 = tmp001[:,np.newaxis]    
    tmap = tmap[:,np.newaxis]

    stctmap = mne.SourceEstimate(tmap,fsave_vertices,stc_Dummy.tmin,stc1.tstep) 
    stctmap.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_tmap_' +
                 modality + '_Mean' + condcouple[0] + '+' + condcouple[1] + '-' + condcouple[2] + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')    

    stctmap = mne.SourceEstimate(-tmap,fsave_vertices,stc_Dummy.tmin,stc1.tstep) 
    stctmap.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_-tmap_' +
                 modality + '_Mean' + condcouple[0] + '+' + condcouple[1] + '-' + condcouple[2] + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')  
    
    stc = mne.SourceEstimate(tmp,fsave_vertices,stc_Dummy.tmin,stc1.tstep) 
    stc.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_' +
                 modality + '_Mean' + condcouple[0] + '+' + condcouple[1] + '-' + condcouple[2] + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')

    stc = mne.SourceEstimate(tmp05,fsave_vertices,stc_Dummy.tmin,stc1.tstep) 
    stc.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_p05uncorr_' +
                 modality + '_Mean' + condcouple[0] + '+' + condcouple[1] + '-' + condcouple[2] + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')

    stc = mne.SourceEstimate(tmp01,fsave_vertices,stc_Dummy.tmin,stc1.tstep) 
    stc.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_p01uncorr_' +
                 modality + '_Mean' + condcouple[0] + '+' + condcouple[1] + '-' + condcouple[2] + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')
                 
    stc = mne.SourceEstimate(tmp005,fsave_vertices,stc_Dummy.tmin,stc1.tstep) 
    stc.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_p005uncorr_' +
                 modality + '_Mean' + condcouple[0] + '+' + condcouple[1] + '-' + condcouple[2] + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')
                 
    stc = mne.SourceEstimate(tmp001,fsave_vertices,stc_Dummy.tmin,stc1.tstep) 
    stc.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_p001uncorr_' +
                 modality + '_Mean' + condcouple[0] + '+' + condcouple[1] + '-' + condcouple[2] + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')
                 
    return sem 

def compute_stcdiff_group_twin2_notnorm(ListSubj,condtriplet,modality,method,twin,ori,cropwin):     

    # load a specific STC morphed on fsaverage
    stc0_path = (wdir + '/' + ListSubj[0] + '/mne_python/STCS/IcaCorr_' + modality + 
           '_' + ListSubj[0] + '_' +condtriplet[0] + '_pick_ori'+ ori +'_' + 
            method + '_ico-5-fwd-fsaverage.fif-rh.stc')
    stc0      = mne.read_source_estimate(stc0_path)
    stc0.crop(cropwin[0],cropwin[1])
    ncond     = len(condtriplet)
    nsub      = len(ListSubj)
    ntimes    = len(stc0.times)    
    nvertices = stc0.data.shape[0]       

    # average individual STCs morphed on fsaverage for each cond
    AVG_STC_cond  = np.empty([ncond, nsub, nvertices, ntimes])
    for c,cond in enumerate(condtriplet):
        for s,subj in enumerate(ListSubj):
            stc_path = (wdir + '/' + subj + '/mne_python/STCS/IcaCorr_' + modality +
                        '_' + subj + '_' + cond + '_pick_ori' + ori +'_' + 
                        method + '_ico-5-fwd-fsaverage.fif-rh.stc')
            stc = mne.read_source_estimate(stc_path)
            stc.crop(cropwin[0],cropwin[1])
            AVG_STC_cond[c,s,:,:] = stc.data

   
    # compute the difference
    AVG_STC_1 = np.mean(AVG_STC_cond[0,:,:,:],axis = 0)
    AVG_STC_2 = np.mean(AVG_STC_cond[1,:,:,:],axis = 0)     
    AVG_STC_3 = np.mean(AVG_STC_cond[2,:,:,:],axis = 0)   

    sem = np.std(AVG_STC_cond)/np.sqrt(len(ListSubj)) 
    
    #tmp = np.mean(AVG_STC_cond,2)
    #pl.plot(np.rollaxis(tmp[0,:,:],1))    
    
    # Replace the values & # save the stc
    tmp = (AVG_STC_1 + AVG_STC_2)/2 - AVG_STC_3
    fsave_vertices = [np.arange(stc0.shape[0]/2), np.arange(stc0.shape[0]/2)]
    stc_Diff1 = mne.SourceEstimate(tmp,fsave_vertices,stc0.tmin,stc0.tstep) 
    stc_Dummy = mne.SourceEstimate(tmp,fsave_vertices,stc0.tmin,stc0.tstep) 
    stc_Dummy.crop(tmin = 0, tmax = 0.005)
    
    stc_Diff1.crop(tmin=twin[0],tmax=twin[1])
    
    tmp = (np.mean(stc_Diff1.data,1))
    tmp = tmp[:,np.newaxis]
    stc = mne.SourceEstimate(tmp,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stc.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_notNormalized_' +
                 modality + '_Mean' + condtriplet[0] + '+' + condtriplet[1] + '-' + condtriplet[2] + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')
                 
    return sem
    
###############################################################################
def compute_stcdiff_group_twin2_3cond_ttest_notnorm(ListSubj,condcouple,modality,method,twin,ori,cropwin):     

    # load a specific STC morphed on fsaverage
    stc0_path = (wdir + '/' + ListSubj[0] + '/mne_python/STCS/IcaCorr_' + modality + 
           '_' + ListSubj[0] + '_' +condcouple[0] + '_pick_ori'+ ori +'_' + 
            method + '_ico-5-fwd-fsaverage.fif-rh.stc')
    stc0      = mne.read_source_estimate(stc0_path)
    stc0.crop(cropwin[0],cropwin[1])
    nsub      = len(ListSubj)
    ntimes    = len(stc0.times)    
    nvertices = stc0.data.shape[0]       

    # average individual STCs morphed on fsaverage for each cond
    AVG_STC_cond  = np.empty([2, nsub, nvertices, ntimes])
    for s,subj in enumerate(ListSubj):
        stc1_path = (wdir + '/' + subj + '/mne_python/STCS/IcaCorr_' + modality +
                    '_' + subj + '_' + condcouple[0] + '_pick_ori' + ori +'_' + 
                    method + '_ico-5-fwd-fsaverage.fif-rh.stc')
        stc1 = mne.read_source_estimate(stc1_path)
        stc1.crop(cropwin[0],cropwin[1])
        stc2_path = (wdir + '/' + subj + '/mne_python/STCS/IcaCorr_' + modality +
            '_' + subj + '_' + condcouple[1] + '_pick_ori' + ori +'_' + 
            method + '_ico-5-fwd-fsaverage.fif-rh.stc')
        stc2 = mne.read_source_estimate(stc2_path)
        stc2.crop(cropwin[0],cropwin[1]) 
        stc3_path = (wdir + '/' + subj + '/mne_python/STCS/IcaCorr_' + modality +
            '_' + subj + '_' + condcouple[2] + '_pick_ori' + ori +'_' + 
            method + '_ico-5-fwd-fsaverage.fif-rh.stc')
        stc3 = mne.read_source_estimate(stc3_path)
        stc3.crop(cropwin[0],cropwin[1])  
        AVG_STC_cond[0,s,:,:] = (stc1.data + stc2.data)/2
        AVG_STC_cond[1,s,:,:] = stc3.data

    # compute the difference
    AVG_STC_1 = np.mean(AVG_STC_cond[0,:,:,:],axis = 0)
    AVG_STC_2 = np.mean(AVG_STC_cond[1,:,:,:],axis = 0)     
    
    sem = np.std(AVG_STC_cond)/np.sqrt(len(ListSubj)) 
    
    # compute the difference per subject for test across vertices
    Diff = np.empty([1, nsub, nvertices, ntimes])
    Diff = AVG_STC_cond[0,:,:,:] - AVG_STC_cond[1,:,:,:]
    Diff = np.mean(Diff, axis = 2)
    
    Mask05  = np.zeros((Diff.shape[1]))
    Mask01  = np.zeros((Diff.shape[1]))
    Mask005 = np.zeros((Diff.shape[1]))
    Mask001 = np.zeros((Diff.shape[1]))
    # mean on the twin
    for v in range(Diff.shape[1]):
        t,p = stats.ttest_1samp(Diff[:,v],0)
        if p < 0.001:
            Mask001[v] = 1
            
    for v in range(Diff.shape[1]):
        t,p = stats.ttest_1samp(Diff[:,v],0)
        if p < 0.005:
            Mask005[v] = 1
            
    for v in range(Diff.shape[1]):
        t,p = stats.ttest_1samp(Diff[:,v],0)
        if p < 0.01:
            Mask01[v] = 1
            
    for v in range(Diff.shape[1]):
        t,p = stats.ttest_1samp(Diff[:,v],0)
        if p < 0.05:
            Mask05[v] = 1 
    
    # Replace the values & # save the stc
    tmp = AVG_STC_1 - AVG_STC_2
    fsave_vertices = [np.arange(stc0.shape[0]/2), np.arange(stc0.shape[0]/2)]
    stc_Diff1 = mne.SourceEstimate(tmp,fsave_vertices,stc0.tmin,stc0.tstep) 
    stc_Dummy = mne.SourceEstimate(tmp,fsave_vertices,stc0.tmin,stc0.tstep) 
    stc_Dummy.crop(tmin = 0, tmax = 0.005)
    
    stc_Diff1.crop(tmin=twin[0],tmax=twin[1])
    
    tmp = (np.mean(stc_Diff1.data,1))
    
    tmp = tmp[:,np.newaxis]
    tmp05 = tmp*Mask05
    tmp01 = tmp*Mask01
    tmp005 = tmp*Mask005
    tmp001 = tmp*Mask001
    tmp05 = tmp05[:,np.newaxis]
    tmp01 = tmp01[:,np.newaxis]
    tmp005 = tmp005[:,np.newaxis]
    tmp001 = tmp001[:,np.newaxis]    
    
    stc = mne.SourceEstimate(tmp,fsave_vertices,stc_Dummy.tmin,stc1.tstep) 
    stc.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_' +
                 modality + '_Mean' + condcouple[0] + '+' + condcouple[1] + '-' + condcouple[2] + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')

    stc = mne.SourceEstimate(tmp05,fsave_vertices,stc_Dummy.tmin,stc1.tstep) 
    stc.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_p05uncorr_' +
                 modality + '_Mean' + condcouple[0] + '+' + condcouple[1] + '-' + condcouple[2] + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')

    stc = mne.SourceEstimate(tmp01,fsave_vertices,stc_Dummy.tmin,stc1.tstep) 
    stc.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_p01uncorr_' +
                 modality + '_Mean' + condcouple[0] + '+' + condcouple[1] + '-' + condcouple[2] + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')
                 
    stc = mne.SourceEstimate(tmp005,fsave_vertices,stc_Dummy.tmin,stc1.tstep) 
    stc.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_p005uncorr_' +
                 modality + '_Mean' + condcouple[0] + '+' + condcouple[1] + '-' + condcouple[2] + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')
                 
    stc = mne.SourceEstimate(tmp001,fsave_vertices,stc_Dummy.tmin,stc1.tstep) 
    stc.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_p001uncorr_' +
                 modality + '_Mean' + condcouple[0] + '+' + condcouple[1] + '-' + condcouple[2] + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')
                 
    return sem    
###############################################################################
#############################################################################
def compute_stcdiff_group_twin3(condcouple,modality,method,twin,ori):     

    # load a specific STC morphed on fsaverage
    stc0_path = (wdir + '/GROUP/mne_python/BrainMaps/IcaCorr_Normalized_' + modality + 
           '_' +condcouple[0] + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori +'_' + 
            method + '_ico-5-fwd-fsaverage.stc-rh.stc')
    stc0      = mne.read_source_estimate(stc0_path)

    ncond     = len(condcouple)
    ntimes    = len(stc0.times)    
    nvertices = stc0.data.shape[0]       

    # average individual STCs morphed on fsaverage for each cond
    AVG_STC_cond  = np.empty([ncond, nvertices, ntimes])
    for c,cond in enumerate(condcouple):
            stc_path = (wdir + '/GROUP/mne_python/BrainMaps/IcaCorr_Normalized_' + modality +
                        '_' + cond + '_twin' + str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori'+ori +'_' + 
                        method + '_ico-5-fwd-fsaverage.stc-rh.stc')
            stc = mne.read_source_estimate(stc_path)
            AVG_STC_cond[c,:,:] = stc.data
 
    # Replace the values & # save the stc
    tmp = (AVG_STC_cond[0,:,:] + AVG_STC_cond[1,:,:])/2
    fsave_vertices = [np.arange(stc0.shape[0]/2), np.arange(stc0.shape[0]/2)]
    stc_Diff1 = mne.SourceEstimate(tmp,fsave_vertices,stc0.tmin,stc0.tstep) 
    stc_Dummy = mne.SourceEstimate(tmp,fsave_vertices,stc0.tmin,stc0.tstep) 
    
    tmp = (np.mean(stc_Diff1.data,1))
    tmp = tmp[:,np.newaxis]
    stc = mne.SourceEstimate(tmp,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stc.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_Normalized_' +
                 modality + '_' + condcouple[0] + '-' + condcouple[1] + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')
                 
    
###############################################################################
###############################################################################                 
modality   = ('MEG','MEEG')
method     = 'dSPM'   
                        
ListSubj   = ('sd130343', 'cb130477', 'rb130313', 'jm100042', 
            'jm100109', 'sb120316', 'tk130502', 'lm130479', 
            'ms130534', 'ma100253', 'sl130503', 'mb140004',
            'mp140019', 'dm130250', 'hr130504', 'wl130316',
            'rl130571','sg120518','mm130405')
 
CondComb  = (('signDT8_1' ,'signDT8_2','signDT8_3' ,'signDT8_4','signDT8_5' ,'signDT8_6','signDT8_7' ,'signDT8_8'),
             ('signDS8_1' ,'signDS8_2','signDS8_3' ,'signDS8_4','signDS8_5' ,'signDS8_6','signDS8_7' ,'signDS8_8'))
    
sem_meg  = []
sem_meeg = []

for c,Conds in enumerate(CondComb):           
    tmp = compute_stcdiff_group3(ListSubj,Conds,'MEEG',method,(0,2),'None')  
    sem_meeg.append(tmp)
    tmp2= compute_stcdiff_group3(ListSubj,Conds,'MEG',method,(0,2),'None')  
    sem_meg.append(tmp2)


ListSubj   = ('sd130343', 'cb130477', 'rb130313', 'jm100042', 
              'jm100109', 'sb120316', 'tk130502', 'lm130479', 
              'ms130534', 'ma100253', 'sl130503', 'mb140004',
              'mp140019', 'dm130250', 'hr130504', 'wl130316',
              'rl130571','sg120518','mm130405')
compute_stcdiff_group_dist(ListSubj,'MEG','dSPM','None','TEVT')
compute_stcdiff_group_dist(ListSubj,'MEEG','dSPM','None','TEVT')  
compute_stcdiff_group_dist(ListSubj,'MEG','dSPM','normal','TEVT')
compute_stcdiff_group_dist(ListSubj,'MEEG','dSPM','normal','TEVT') 

compute_stcdiff_group_dist(ListSubj,'MEG','dSPM','None','TsignedEVT')
compute_stcdiff_group_dist(ListSubj,'MEEG','dSPM','None','TsignedEVT')  
compute_stcdiff_group_dist(ListSubj,'MEG','dSPM','normal','TsignedEVT')
compute_stcdiff_group_dist(ListSubj,'MEEG','dSPM','normal','TsignedEVT') 

compute_stcdiff_group_dist(ListSubj,'MEG','dSPM','None','SsignedEVS')
compute_stcdiff_group_dist(ListSubj,'MEEG','dSPM','None','SsignedEVS')  
compute_stcdiff_group_dist(ListSubj,'MEG','dSPM','normal','SsignedEVS')
compute_stcdiff_group_dist(ListSubj,'MEEG','dSPM','normal','SsignedEVS') 

sem_meeg = compute_stcdiff_group_dist_twin(ListSubj,'MEEG','dSPM',[0.828, 1] ,'None',[0, 1],'TEVT',0)
sem_meg = compute_stcdiff_group_dist_twin(ListSubj,'MEG','dSPM',[0.828, 1] ,'None',[0, 1],'TEVT',0)
sem_meeg = compute_stcdiff_group_dist_twin(ListSubj,'MEEG','dSPM',[0.828, 1] ,'normal',[0, 1],'TEVT',0)
sem_meg = compute_stcdiff_group_dist_twin(ListSubj,'MEG','dSPM',[0.828, 1] ,'normal',[0, 1],'TEVT',0)                
 
sem_meeg = compute_stcdiff_group_dist_twin(ListSubj,'MEEG','dSPM',[0.444, 0.520] ,'None',[0, 1],'TsignedEVT',0)
sem_meg = compute_stcdiff_group_dist_twin(ListSubj,'MEG','dSPM',[0.444, 0.520],'None',[0, 1],'TsignedEVT',0)
sem_meeg = compute_stcdiff_group_dist_twin(ListSubj,'MEEG','dSPM',[0.444, 0.520] ,'normal',[0, 1],'TsignedEVT',0)
sem_meg = compute_stcdiff_group_dist_twin(ListSubj,'MEG','dSPM',[0.444, 0.520] ,'normal',[0, 1],'TsignedEVT',0)  
 
sem_meeg = compute_stcdiff_group_dist_twin2_ttest(ListSubj,'MEEG','dSPM',[0.444, 0.520] ,'None',[0, 1],'TsignedEVT',0)
sem_meg = compute_stcdiff_group_dist_twin2_ttest(ListSubj,'MEG','dSPM',[0.444, 0.520],'None',[0, 1],'TsignedEVT',0)
sem_meeg = compute_stcdiff_group_dist_twin_ttest(ListSubj,'MEEG','dSPM',[0.444, 0.520] ,'normal',[0, 1],'TsignedEVT',0)
sem_meg = compute_stcdiff_group_dist_twin_ttest(ListSubj,'MEG','dSPM',[0.444, 0.520] ,'normal',[0, 1],'TsignedEVT',0)   
 
sem_meeg = compute_stcdiff_group_dist_twin_ttest(ListSubj,'MEEG','dSPM',[0.640, 0.928] ,'None',[0, 1],'SsignedEVS',0)
sem_meg = compute_stcdiff_group_dist_twin_ttest(ListSubj,'MEG','dSPM',[0.640, 0.928],'None',[0, 1],'SsignedEVS',0)
sem_meeg = compute_stcdiff_group_dist_twin_ttest(ListSubj,'MEEG','dSPM',[0.640, 0.928] ,'normal',[0, 1],'SsignedEVS',0)
sem_meg = compute_stcdiff_group_dist_twin_ttest(ListSubj,'MEG','dSPM',[0.640, 0.928],'normal',[0, 1],'SsignedEVS',0)   
 
 
sem_meeg = compute_stcdiff_group_dist_twin(ListSubj,'MEEG','dSPM',[0.828, 1] ,'None',[0, 1],'SEVS',-1)
sem_meg = compute_stcdiff_group_dist_twin(ListSubj,'MEG','dSPM',[0.828, 1] ,'None',[0, 1],'SEVS',-1)
sem_meeg = compute_stcdiff_group_dist_twin(ListSubj,'MEEG','dSPM',[0.828, 1] ,'normal',[0, 1],'SEVS',-1)
sem_meg = compute_stcdiff_group_dist_twin(ListSubj,'MEG','dSPM',[0.828, 1] ,'normal',[0, 1],'SEVS',-1)
 
sem_meeg = compute_stcdiff_group_dist_twin(ListSubj,'MEEG','dSPM',[0.640, 0.928] ,'None',[0, 1],'SsignedEVS',-1)
sem_meg = compute_stcdiff_group_dist_twin(ListSubj,'MEG','dSPM',[0.640, 0.928] ,'None',[0, 1],'SsignedEVS',-1)
sem_meeg = compute_stcdiff_group_dist_twin(ListSubj,'MEEG','dSPM',[0.640, 0.928] ,'normal',[0, 1],'SsignedEVS',-1)
sem_meg = compute_stcdiff_group_dist_twin(ListSubj,'MEG','dSPM',[0.640, 0.928] ,'normal',[0, 1],'SsignedEVS',-1)            
             
compute_stcdiff_group_twin2_ttest(ListSubj,('RefPast','RefFut'),'MEEG','dSPM',[1.606,1.829],'None',[1, 2])             
compute_stcdiff_group_twin2_ttest(ListSubj,('RefPast','RefFut'),'MEG','dSPM',[1.606,1.829],'None',[1, 2])          
    
compute_stcdiff_group_twin2_ttest(ListSubj,('Et_all','Es_all'),'MEEG','dSPM',[0.300, 1],'None',[0,1])             
compute_stcdiff_group_twin2_ttest(ListSubj,('Et_all','Es_all'),'MEG','dSPM',[0.300, 1],'None',[0,1])    
   
compute_stcdiff_group_twin2_ttest(ListSubj,('EtPast','EtPre'),'MEEG','dSPM',[0.504, 0.993],'None',[0,1])             
compute_stcdiff_group_twin2_ttest(ListSubj,('EtPast','EtPre'),'MEG','dSPM',[0.504, 0.993],'None',[0,1])   
compute_stcdiff_group_twin2_ttest(ListSubj,('EtFut' ,'EtPre'),'MEEG','dSPM',[0.504, 0.993],'None',[0,1])             
compute_stcdiff_group_twin2_ttest(ListSubj,('EtFut' ,'EtPre'),'MEG','dSPM',[0.504, 0.993],'None',[0,1])   
 
compute_stcdiff_group_twin2_ttest(ListSubj,('QsWest','QsEast'),'MEEG','dSPM',[0.673, 0.809],'None',[0,1])             
compute_stcdiff_group_twin2_ttest(ListSubj,('QsWest','QsEast'),'MEG','dSPM',[0.673, 0.809],'None',[0,1])   
compute_stcdiff_group_twin2_ttest(ListSubj,('EsWest' ,'EsPar'),'MEEG','dSPM',[0.504, 0.993],'None',[0,1])  
compute_stcdiff_group_twin2_ttest(ListSubj,('EsWest' ,'EsPar'),'MEG','dSPM',[0.504, 0.993],'None',[0,1])               
compute_stcdiff_group_twin2_ttest(ListSubj,('EsEast' ,'EsPar'),'MEEG','dSPM',[0.504, 0.993],'None',[0,1])   
compute_stcdiff_group_twin2_ttest(ListSubj,('EsEast' ,'EsPar'),'MEG','dSPM',[0.504, 0.993],'None',[0,1])   
    
compute_stcdiff_group_twin2_ttest_v2(ListSubj,('signDT8_8' ,'signDT8_1'),'MEG','dSPM' ,[0.444, 0.520],'None',[0,1]) 
compute_stcdiff_group_twin2_ttest_v2(ListSubj,('signDT8_8' ,'signDT8_1'),'MEEG','dSPM',[0.444, 0.520],'None',[0,1])          
compute_stcdiff_group_twin2_ttest_v2(ListSubj,('signDS8_8' ,'signDS8_1'),'MEG','dSPM' ,[0.640, 0.928],'None',[0,1]) 
compute_stcdiff_group_twin2_ttest_v2(ListSubj,('signDS8_8' ,'signDS8_1'),'MEEG','dSPM',[0.640, 0.928],'None',[0,1])          
        
compute_stcdiff_group_twin2_ttest_nornorm(ListSubj,('RefPast','RefFut'),'MEEG','dSPM',[1.606,1.829],'None',[1, 2])             
compute_stcdiff_group_twin2_ttest_nornorm(ListSubj,('RefPast','RefFut'),'MEG','dSPM',[1.606,1.829],'None',[1, 2])          
   
compute_stcdiff_group_twin2_ttest_nornorm(ListSubj,('EtPast','EtPre'),'MEEG','dSPM',[0.504, 0.993],'None',[0,1])             
compute_stcdiff_group_twin2_ttest_nornorm(ListSubj,('EtPast','EtPre'),'MEG','dSPM',[0.504, 0.993],'None',[0,1])   
compute_stcdiff_group_twin2_ttest_nornorm(ListSubj,('EtFut' ,'EtPre'),'MEEG','dSPM',[0.504, 0.993],'None',[0,1])             
compute_stcdiff_group_twin2_ttest_nornorm(ListSubj,('EtFut' ,'EtPre'),'MEG','dSPM',[0.504, 0.993],'None',[0,1])   
 
compute_stcdiff_group_twin2_ttest_nornorm(ListSubj,('QsWest','QsEast'),'MEEG','dSPM',[0.673, 0.809],'None',[0,1])             
compute_stcdiff_group_twin2_ttest_nornorm(ListSubj,('QsWest','QsEast'),'MEG','dSPM',[0.673, 0.809],'None',[0,1])   
compute_stcdiff_group_twin2_ttest_nornorm(ListSubj,('EsWest' ,'EsPar'),'MEEG','dSPM',[0.504, 0.993],'None',[0,1])  
compute_stcdiff_group_twin2_ttest_nornorm(ListSubj,('EsWest' ,'EsPar'),'MEG','dSPM',[0.504, 0.993],'None',[0,1])               
compute_stcdiff_group_twin2_ttest_nornorm(ListSubj,('EsEast' ,'EsPar'),'MEEG','dSPM',[0.504, 0.993],'None',[0,1])   
compute_stcdiff_group_twin2_ttest_nornorm(ListSubj,('EsEast' ,'EsPar'),'MEG','dSPM',[0.504, 0.993],'None',[0,1])   
   
condcouple = ('EtPast','EtFut','EtPre')
compute_stcdiff_group_twin2_3cond_ttest(ListSubj,condcouple,'MEEG','dSPM',[0.504, 0.993],'None',[0, 1])
compute_stcdiff_group_twin2_3cond_ttest(ListSubj,condcouple,'MEG','dSPM',[0.504, 0.993],'None',[0, 1]) 
condcouple = ('EtPast','EtFut','EtPre')
compute_stcdiff_group_twin2_3cond_ttest_notnorm(ListSubj,condcouple,'MEEG','dSPM',[0.504, 0.993],'None',[0, 1])
compute_stcdiff_group_twin2_3cond_ttest_notnorm(ListSubj,condcouple,'MEG','dSPM',[0.504, 0.993],'None',[0, 1]) 
                        
condcouple = ('EsWest','EsEast','EsPar')
compute_stcdiff_group_twin2_3cond_ttest(ListSubj,condcouple,'MEEG','dSPM',[0.504, 0.993],'None',[0, 1])
compute_stcdiff_group_twin2_3cond_ttest(ListSubj,condcouple,'MEG','dSPM',[0.504, 0.993],'None',[0, 1]) 
condcouple = ('EsWest','EsEast','EsPar')
compute_stcdiff_group_twin2_3cond_ttest_notnorm(ListSubj,condcouple,'MEEG','dSPM',[0.504, 0.993],'None',[0, 1])
compute_stcdiff_group_twin2_3cond_ttest_notnorm(ListSubj,condcouple,'MEG','dSPM',[0.504, 0.993],'None',[0, 1]) 
         
modality   = ('MEG','MEEG')
method     = 'dSPM'   
                        
ListSubj   = ('sd130343', 'cb130477', 'rb130313', 'jm100042', 
            'jm100109', 'sb120316', 'tk130502', 'lm130479', 
            'ms130534', 'ma100253', 'sl130503', 'mb140004',
            'mp140019', 'dm130250', 'hr130504', 'wl130316',
            'rl130571','sg120518')
 
compute_stcdiff_group_twin2_ttest(ListSubj,('RelPastG','RelFutG'),'MEEG','dSPM',[0.204, 366],'None',[0, 1])             
compute_stcdiff_group_twin2_ttest(ListSubj,('RelPastG','RelFutG'),'MEG','dSPM',[0.204, 366],'None',[0, 1])    
compute_stcdiff_group_twin2_ttest(ListSubj,('RelWestG','RelEastG'),'MEEG','dSPM',[0.204, 366],'None',[0, 1])             
compute_stcdiff_group_twin2_ttest(ListSubj,('RelWestG','RelEastG'),'MEG','dSPM',[0.204, 366],'None',[0, 1]) 
 
compute_stcdiff_group_twin2_ttest(ListSubj,('RelPastG_intmap','RelFutG_intmap'),'MEEG','dSPM',[0.772,1.],'None',[0, 1])             
compute_stcdiff_group_twin2_ttest(ListSubj,('RelPastG_intmap','RelFutG_intmap'),'MEG','dSPM',[0.772,1.],'None',[0, 1])    
compute_stcdiff_group_twin2_ttest(ListSubj,('RelPastG_coumap','RelFutG_coumap'),'MEEG','dSPM',[0.772,1.],'None',[0, 1])              
compute_stcdiff_group_twin2_ttest(ListSubj,('RelPastG_coumap','RelFutG_coumap'),'MEG','dSPM',[0.772,1.],'None',[0, 1])   

compute_stcdiff_group_twin2_ttest_int4(ListSubj,('RelPastG','RelFutG','RelWestG','RelEastG'),'MEEG','dSPM',[0.076, 300],'None',[0, 1])             
compute_stcdiff_group_twin2_ttest_int4(ListSubj,('RelPastG','RelFutG','RelWestG','RelEastG'),'MEG','dSPM',[0.076, 366],'None',[0, 1])  
compute_stcdiff_group_twin2_ttest_int4(ListSubj,('RelPastG','RelFutG','RelWestG','RelEastG'),'MEEG','dSPM',[0.204, 366],'None',[0, 1])             
compute_stcdiff_group_twin2_ttest_int4(ListSubj,('RelPastG','RelFutG','RelWestG','RelEastG'),'MEG','dSPM',[0.204, 366],'None',[0, 1])  

compute_stcdiff_group_twin2_ttest_int4(ListSubj,('RelPastG_intmap','RelFutG_intmap','RelPastG_coumap','RelFutG_coumap'),'MEEG','dSPM',[0.772, 1.],'None',[0, 1])             
compute_stcdiff_group_twin2_ttest_int4(ListSubj,('RelPastG_intmap','RelFutG_intmap','RelPastG_coumap','RelFutG_coumap'),'MEG','dSPM',[0.772, 1.],'None',[0, 1])  
   
compute_stcdiff_group_twin2_ttest_int4(ListSubj,('RelPastG_intmap','RelFutG_intmap','RelPastG_coumap','RelFutG_coumap'),'MEEG','dSPM',[1.356, 1.8],'None',[1, 2])             
compute_stcdiff_group_twin2_ttest_int4(ListSubj,('RelPastG_intmap','RelFutG_intmap','RelPastG_coumap','RelFutG_coumap'),'MEG','dSPM',[1.356, 1.8],'None',[1, 2])  
compute_stcdiff_group_twin2_ttest_int4(ListSubj,('RelWestG_intmap','RelEastG_intmap','RelWestG_coumap','RelEastG_coumap'),'MEEG','dSPM',[1.356, 1.8],'None',[1, 2])             
compute_stcdiff_group_twin2_ttest_int4(ListSubj,('RelWestG_intmap','RelEastG_intmap','RelWestG_coumap','RelEastG_coumap'),'MEG','dSPM',[1.356, 1.8],'None',[1, 2])                  

compute_stcdiff_group_twin2_ttest_int4(ListSubj,('RelWestG_intmap','RelEastG_intmap','RelWestG_coumap','RelEastG_coumap'),'MEG','dSPM',[1.356, 1.8],'None',[1, 2])                  
compute_stcdiff_group_twin2_ttest_int4(ListSubj,('RelWestG_intmap','RelEastG_intmap','RelWestG_coumap','RelEastG_coumap'),'MEG','dSPM',[1.356, 1.8],'None',[1, 2])                  

               
compute_stcdiff_group_twin(ListSubj,('RelPastG','RelFutG'),'MEEG','dSPM',[0.204, 366],'None',[0, 1])  


ListSubj   = ('sd130343', 'cb130477', 'rb130313', 'jm100042', 
              'jm100109', 'sb120316', 'tk130502', 'lm130479', 
              'ms130534', 'ma100253', 'sl130503', 'mb140004',
              'mp140019', 'dm130250', 'hr130504', 'wl130316',
              'rl130571','sg120518','mm130405')
              
compute_stcdiff_group_twin2_ttest(ListSubj,('RefPast','RefFut'),'MEEG','dSPM',[1.606,1.829],'None',[1, 2])             
compute_stcdiff_group_twin2_ttest(ListSubj,('RefPast','RefFut'),'MEG','dSPM',[1.606,1.829],'None',[1, 2])   
             
compute_stcdiff_group_twin2_ttest(ListSubj,('QsWest','QsEast'),'MEEG','dSPM',[0.673, 0.809],'None',[0,1])             
compute_stcdiff_group_twin2_ttest(ListSubj,('QsWest','QsEast'),'MEG','dSPM',[0.673, 0.809],'None',[0,1])               

compute_stcdiff_group_twin2_ttest(ListSubj,('EtPast','EtPre'),'MEEG','dSPM',[0.504, 0.993],'None',[0,1])             
compute_stcdiff_group_twin2_ttest(ListSubj,('EtPast','EtPre'),'MEG','dSPM',[0.504, 0.993],'None',[0,1])   
compute_stcdiff_group_twin2_ttest(ListSubj,('EtFut' ,'EtPre'),'MEEG','dSPM',[0.504, 0.993],'None',[0,1])             
compute_stcdiff_group_twin2_ttest(ListSubj,('EtFut' ,'EtPre'),'MEG','dSPM',[0.504, 0.993],'None',[0,1])   
 
compute_stcdiff_group_twin2_ttest(ListSubj,('EsWest' ,'EsPar'),'MEEG','dSPM',[0.504, 0.993],'None',[0,1])  
compute_stcdiff_group_twin2_ttest(ListSubj,('EsWest' ,'EsPar'),'MEG','dSPM',[0.504, 0.993],'None',[0,1])               
compute_stcdiff_group_twin2_ttest(ListSubj,('EsEast' ,'EsPar'),'MEEG','dSPM',[0.504, 0.993],'None',[0,1])   
compute_stcdiff_group_twin2_ttest(ListSubj,('EsEast' ,'EsPar'),'MEG','dSPM',[0.504, 0.993],'None',[0,1])   
   
