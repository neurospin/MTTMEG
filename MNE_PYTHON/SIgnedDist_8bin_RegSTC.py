# -*- coding: utf-8 -*-
"""
Created on Tue Nov  8 18:40:35 2016

@author: bgauthie
"""
import mne
import numpy as np
import matplotlib
matplotlib.use('Agg')
from scipy import stats

    
# parameter value example
wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG"
path_script  = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS/MNE_PYTHON"

###############################################################################
###############################################################################
def compute_stcdiff_dist8bin_twin_ttest(ListSubj,tag,modality,method,twin,ori,cropwin):     

    if tag == 'T':
        condition = ('signDT8_1','signDT8_2','signDT8_3','signDT8_4','signDT8_5','signDT8_6','signDT8_7','signDT8_8')
        Name = 'TsignedEVT'
        dist = [-27.7, -12.9, -8.3, -3.5, 2.5, 7.94, 13.4, 21.8]
    elif tag == 'S':
        condition = ('signDS8_1','signDS8_2','signDS8_3','signDS8_4','signDS8_5','signDS8_6','signDS8_7','signDS8_8')
        Name = 'SsignedEVS'
        dist = [-124, -82, -47, -10, 15, 50, 76, 120]  

    # load a specific STC morphed on fsaverage
    stc0_path = (wdir + '/' + ListSubj[0] + '/mne_python/STCS/' + modality + 
           '_' + ListSubj[0] + '_' +condition[0] + '_pick_ori'+ ori +'_' + 
            method + '_ico-5-fwd-fsaverage.fif-rh.stc')
    stc0      = mne.read_source_estimate(stc0_path)
    stc0.crop(twin[0],twin[1])
    ncond     = len(condition)
    nsub      = len(ListSubj)
    ntimes    = len(stc0.times)    
    nvertices = stc0.data.shape[0]       

    # average individual STCs morphed on fsaverage for each cond
    AVG_STC_cond  = np.empty([ncond, nsub, nvertices, ntimes])
    for c,cond in enumerate(condition):
        for s,subj in enumerate(ListSubj):
            stc_path = (wdir + '/' + subj + '/mne_python/STCS/' + modality +
                        '_' + subj + '_' + cond + '_pick_ori' + ori +'_' + 
                        method + '_ico-5-fwd-fsaverage.fif-rh.stc')
            stc = mne.read_source_estimate(stc_path)
            stc.crop(twin[0],twin[1])
            AVG_STC_cond[c,s,:,:] = stc.data

    # average over time window
    AVG_STC = np.mean(AVG_STC_cond, axis = 3)
   
    # compute subject-level linear regression beta
    BETAS = np.empty([nsub, nvertices])    
    for s,subj in enumerate(ListSubj):
        for v in range(nvertices):
            slope, intercept, r_value, p_value, std_err = stats.linregress(dist,AVG_STC[:,s,v])
            BETAS[s,v] = slope

    Mask05  = np.zeros((BETAS.shape[1]))
    Mask01  = np.zeros((BETAS.shape[1]))
    Mask005 = np.zeros((BETAS.shape[1]))
    Mask001 = np.zeros((BETAS.shape[1]))
    tmap    = np.zeros((BETAS.shape[1]))
    
    # mean on the twin
    for v in range(BETAS.shape[1]):
        t,p = stats.ttest_1samp(BETAS[:,v],0)
        tmap[v] = t
        if p < 0.001:
            Mask001[v] = 1
            
    for v in range(BETAS.shape[1]):
        t,p = stats.ttest_1samp(BETAS[:,v],0)
        if p < 0.005:
            Mask005[v] = 1
            
    for v in range(BETAS.shape[1]):
        t,p = stats.ttest_1samp(BETAS[:,v],0)
        if p < 0.01:
            Mask01[v] = 1
            
    for v in range(BETAS.shape[1]):
        t,p = stats.ttest_1samp(BETAS[:,v],0)
        if p < 0.05:
            Mask05[v] = 1

    
    # Replace the values & # save the stc
    fsave_vertices = [np.arange(stc0.shape[0]/2), np.arange(stc0.shape[0]/2)]
    
    tmp = np.mean(BETAS,axis = 0)
    
    tmp05  = tmp*Mask05
    tmp01  = tmp*Mask01
    tmp005 = tmp*Mask005
    tmp001 = tmp*Mask001
    
    tmp05  = tmp05[:,np.newaxis]
    tmp01  = tmp01[:,np.newaxis]
    tmp005 = tmp005[:,np.newaxis]
    tmp001 = tmp001[:,np.newaxis]
    tmp    = tmp[:,np.newaxis]
    tmap   = tmap[:,np.newaxis]
    
    stc_Dummy = mne.SourceEstimate(tmp,fsave_vertices,stc0.tmin,stc0.tstep)
    
    stc = mne.SourceEstimate(tmp,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stc.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_BETA_' +
                 modality + '_' + 'LinRegress8bin_' + Name + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')

    stctmap = mne.SourceEstimate(tmap,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stctmap.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_tmap_' +
                 modality + '_' + 'LinRegress8bin_' + Name + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')

    stc05 = mne.SourceEstimate(tmp05,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stc05.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_BETAp05uncorr_' +
                 modality + '_' + 'LinRegress8bin_' + Name + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')

    stc01 = mne.SourceEstimate(tmp01,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stc01.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_BETAp01uncorr_' +
                 modality + '_' + 'LinRegress8bin_' + Name + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')

    stc001 = mne.SourceEstimate(tmp001,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stc001.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_BETAp001uncorr_' +
                 modality + '_' + 'LinRegress8bin_' + Name + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')
                 
    stc005 = mne.SourceEstimate(tmp005,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stc005.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_BETAp005uncorr_' +
                 modality + '_' + 'LinRegress8bin_' + Name + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')              
 
 ##############################################################################
 ##############################################################################  
ListSubj   = ('sd130343', 'cb130477', 'rb130313', 'jm100042', 
            'jm100109', 'sb120316', 'tk130502', 'lm130479', 
            'ms130534', 'ma100253', 'sl130503', 'mb140004',
            'mp140019', 'dm130250', 'hr130504', 'wl130316',
            'rl130571','sg120518','mm130405')
 
compute_stcdiff_dist8bin_twin_ttest(ListSubj,'T','MEEG','dSPM',(0.444, 0.520),'None',(0,1)) 
compute_stcdiff_dist8bin_twin_ttest(ListSubj,'T','MEG' ,'dSPM',(0.444, 0.520),'None',(0,1)) 
compute_stcdiff_dist8bin_twin_ttest(ListSubj,'S','MEEG','dSPM',(0.640, 0.928),'None',(0,1))
compute_stcdiff_dist8bin_twin_ttest(ListSubj,'S','MEG' ,'dSPM',(0.640, 0.928),'None',(0,1))
 
compute_stcdiff_dist8bin_twin_ttest(ListSubj,'S','MEEG','dSPM',(0.768, 0.860),'None',(0,1))
compute_stcdiff_dist8bin_twin_ttest(ListSubj,'S','MEG' ,'dSPM',(0.768, 0.860),'None',(0,1)) 
 
# -*- coding: utf-8 -*-
"""
Created on Tue Nov  8 18:40:35 2016

@author: bgauthie
"""
import mne
import numpy as np
import matplotlib
matplotlib.use('Agg')
from scipy import stats

    
# parameter value example
wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG"
path_script  = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS/MNE_PYTHON"

###############################################################################
###############################################################################
def compute_stcdiff_dist8bin_twin_ttest(ListSubj,tag,modality,method,twin,ori,cropwin):     

    if tag == 'T':
        condition = ('signDT8_1','signDT8_2','signDT8_3','signDT8_4','signDT8_5','signDT8_6','signDT8_7','signDT8_8')
        Name = 'TsignedEVT'
        dist = [-27.7, -12.9, -8.3, -3.5, 2.5, 7.94, 13.4, 21.8]
    elif tag == 'S':
        condition = ('signDS8_1','signDS8_2','signDS8_3','signDS8_4','signDS8_5','signDS8_6','signDS8_7','signDS8_8')
        Name = 'SsignedEVS'
        dist = [-124, -82, -47, -10, 15, 50, 76, 120]  

    # load a specific STC morphed on fsaverage
    stc0_path = (wdir + '/' + ListSubj[0] + '/mne_python/STCS/' + modality + 
           '_' + ListSubj[0] + '_' +condition[0] + '_pick_ori'+ ori +'_' + 
            method + '_ico-5-fwd-fsaverage.fif-rh.stc')
    stc0      = mne.read_source_estimate(stc0_path)
    stc0.crop(twin[0],twin[1])
    ncond     = len(condition)
    nsub      = len(ListSubj)
    ntimes    = len(stc0.times)    
    nvertices = stc0.data.shape[0]       

    # average individual STCs morphed on fsaverage for each cond
    AVG_STC_cond  = np.empty([ncond, nsub, nvertices, ntimes])
    for c,cond in enumerate(condition):
        for s,subj in enumerate(ListSubj):
            stc_path = (wdir + '/' + subj + '/mne_python/STCS/' + modality +
                        '_' + subj + '_' + cond + '_pick_ori' + ori +'_' + 
                        method + '_ico-5-fwd-fsaverage.fif-rh.stc')
            stc = mne.read_source_estimate(stc_path)
            stc.crop(twin[0],twin[1])
            AVG_STC_cond[c,s,:,:] = stc.data

    # average over time window
    AVG_STC = np.mean(AVG_STC_cond, axis = 3)
   
    # compute subject-level linear regression beta
    BETAS = np.empty([nsub, nvertices])    
    for s,subj in enumerate(ListSubj):
        for v in range(nvertices):
            slope, intercept, r_value, p_value, std_err = stats.linregress(dist,AVG_STC[:,s,v])
            BETAS[s,v] = slope

    Mask05  = np.zeros((BETAS.shape[1]))
    Mask01  = np.zeros((BETAS.shape[1]))
    Mask005 = np.zeros((BETAS.shape[1]))
    Mask001 = np.zeros((BETAS.shape[1]))
    tmap    = np.zeros((BETAS.shape[1]))
    
    # mean on the twin
    for v in range(BETAS.shape[1]):
        t,p = stats.ttest_1samp(BETAS[:,v],0)
        tmap[v] = t
        if p < 0.001:
            Mask001[v] = 1
            
    for v in range(BETAS.shape[1]):
        t,p = stats.ttest_1samp(BETAS[:,v],0)
        if p < 0.005:
            Mask005[v] = 1
            
    for v in range(BETAS.shape[1]):
        t,p = stats.ttest_1samp(BETAS[:,v],0)
        if p < 0.01:
            Mask01[v] = 1
            
    for v in range(BETAS.shape[1]):
        t,p = stats.ttest_1samp(BETAS[:,v],0)
        if p < 0.05:
            Mask05[v] = 1

    
    # Replace the values & # save the stc
    fsave_vertices = [np.arange(stc0.shape[0]/2), np.arange(stc0.shape[0]/2)]
    
    tmp = np.mean(BETAS,axis = 0)
    
    tmp05  = tmp*Mask05
    tmp01  = tmp*Mask01
    tmp005 = tmp*Mask005
    tmp001 = tmp*Mask001
    tmap005 = tmap*Mask005
    
    tmp05  = tmp05[:,np.newaxis]
    tmp01  = tmp01[:,np.newaxis]
    tmp005 = tmp005[:,np.newaxis]
    tmp001 = tmp001[:,np.newaxis]
    tmp    = tmp[:,np.newaxis]
    tmap   = tmap[:,np.newaxis]
    tmap005   = tmap005[:,np.newaxis]
    
    stc_Dummy = mne.SourceEstimate(tmp,fsave_vertices,stc0.tmin,stc0.tstep)
    
    stc = mne.SourceEstimate(tmp,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stc.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_BETA_' +
                 modality + '_' + 'LinRegress8bin_' + Name + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')

    stctmap = mne.SourceEstimate(tmap,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stctmap.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_tmap_' +
                 modality + '_' + 'LinRegress8bin_' + Name + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')

    stctmap005 = mne.SourceEstimate(tmap005,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stctmap005.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_tmap005_' +
                 modality + '_' + 'LinRegress8bin_' + Name + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')

    stc05 = mne.SourceEstimate(tmp05,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stc05.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_BETAp05uncorr_' +
                 modality + '_' + 'LinRegress8bin_' + Name + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')

    stc01 = mne.SourceEstimate(tmp01,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stc01.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_BETAp01uncorr_' +
                 modality + '_' + 'LinRegress8bin_' + Name + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')

    stc001 = mne.SourceEstimate(tmp001,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stc001.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_BETAp001uncorr_' +
                 modality + '_' + 'LinRegress8bin_' + Name + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')
                 
    stc005 = mne.SourceEstimate(tmp005,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stc005.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_BETAp005uncorr_' +
                 modality + '_' + 'LinRegress8bin_' + Name + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')              
 
 ##############################################################################
 ##############################################################################  
ListSubj   = ('sd130343', 'cb130477', 'rb130313', 'jm100042', 
            'jm100109', 'sb120316', 'tk130502', 'lm130479', 
            'ms130534', 'ma100253', 'sl130503', 'mb140004',
            'mp140019', 'dm130250', 'hr130504', 'wl130316',
            'rl130571','sg120518','mm130405')
 
compute_stcdiff_dist8bin_twin_ttest(ListSubj,'T','MEEG','dSPM',(0.444, 0.520),'None',(0,1)) 
compute_stcdiff_dist8bin_twin_ttest(ListSubj,'T','MEG' ,'dSPM',(0.444, 0.520),'None',(0,1)) 
compute_stcdiff_dist8bin_twin_ttest(ListSubj,'S','MEEG','dSPM',(0.640, 0.928),'None',(0,1))
compute_stcdiff_dist8bin_twin_ttest(ListSubj,'S','MEG' ,'dSPM',(0.640, 0.928),'None',(0,1))
 
 
###############################################################################
###############################################################################
###############################################################################
import mne
import numpy as np
import matplotlib
matplotlib.use('Agg')
from scipy import stats
    
# parameter value example
wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG"
path_script  = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS/MNE_PYTHON"

###############################################################################
###############################################################################
def compute_stcdiff_absdist8bin_twin_ttest(ListSubj,tag,modality,method,twin,ori,cropwin):     

    if tag == 'T':
        condition = ('signDT8_1','signDT8_2','signDT8_3','signDT8_4','signDT8_5','signDT8_6','signDT8_7','signDT8_8')
        Name = 'TsignedEVT'
        dist = [27.7, 12.9, 8.3, 3.5, 2.5, 7.94, 13.4, 21.8]
    elif tag == 'S':
        condition = ('signDS8_1','signDS8_2','signDS8_3','signDS8_4','signDS8_5','signDS8_6','signDS8_7','signDS8_8')
        Name = 'SsignedEVS'
        dist = [124, 82, 47, 10, 15, 50, 76, 120]  

    # load a specific STC morphed on fsaverage
    stc0_path = (wdir + '/' + ListSubj[0] + '/mne_python/STCS/' + modality + 
           '_' + ListSubj[0] + '_' +condition[0] + '_pick_ori'+ ori +'_' + 
            method + '_ico-5-fwd-fsaverage.fif-rh.stc')
    stc0      = mne.read_source_estimate(stc0_path)
    stc0.crop(twin[0],twin[1])
    ncond     = len(condition)
    nsub      = len(ListSubj)
    ntimes    = len(stc0.times)    
    nvertices = stc0.data.shape[0]       

    # average individual STCs morphed on fsaverage for each cond
    AVG_STC_cond  = np.empty([ncond, nsub, nvertices, ntimes])
    for c,cond in enumerate(condition):
        for s,subj in enumerate(ListSubj):
            stc_path = (wdir + '/' + subj + '/mne_python/STCS/' + modality +
                        '_' + subj + '_' + cond + '_pick_ori' + ori +'_' + 
                        method + '_ico-5-fwd-fsaverage.fif-rh.stc')
            stc = mne.read_source_estimate(stc_path)
            stc.crop(twin[0],twin[1])
            AVG_STC_cond[c,s,:,:] = stc.data

    # average over time window
    AVG_STC = np.mean(AVG_STC_cond, axis = 3)
   
    # compute subject-level linear regression beta
    BETAS = np.empty([nsub, nvertices])    
    for s,subj in enumerate(ListSubj):
        for v in range(nvertices):
            slope, intercept, r_value, p_value, std_err = stats.linregress(dist,AVG_STC[:,s,v])
            BETAS[s,v] = slope

    Mask05  = np.zeros((BETAS.shape[1]))
    Mask01  = np.zeros((BETAS.shape[1]))
    Mask005 = np.zeros((BETAS.shape[1]))
    Mask001 = np.zeros((BETAS.shape[1]))
    tmap    = np.zeros((BETAS.shape[1]))
    
    # mean on the twin
    for v in range(BETAS.shape[1]):
        t,p = stats.ttest_1samp(BETAS[:,v],0)
        tmap[v] = t
        if p < 0.001:
            Mask001[v] = 1
            
    for v in range(BETAS.shape[1]):
        t,p = stats.ttest_1samp(BETAS[:,v],0)
        if p < 0.005:
            Mask005[v] = 1
            
    for v in range(BETAS.shape[1]):
        t,p = stats.ttest_1samp(BETAS[:,v],0)
        if p < 0.01:
            Mask01[v] = 1
            
    for v in range(BETAS.shape[1]):
        t,p = stats.ttest_1samp(BETAS[:,v],0)
        if p < 0.05:
            Mask05[v] = 1

    
    # Replace the values & # save the stc
    fsave_vertices = [np.arange(stc0.shape[0]/2), np.arange(stc0.shape[0]/2)]
    
    tmp = np.mean(BETAS,axis = 0)
    
    tmp05  = tmp*Mask05
    tmp01  = tmp*Mask01
    tmp005 = tmp*Mask005
    tmp001 = tmp*Mask001
    tmap005 = tmap*Mask005
    
    tmp05  = tmp05[:,np.newaxis]
    tmp01  = tmp01[:,np.newaxis]
    tmp005 = tmp005[:,np.newaxis]
    tmp001 = tmp001[:,np.newaxis]
    tmp    = tmp[:,np.newaxis]
    tmap   = tmap[:,np.newaxis]
    tmap005   = tmap005[:,np.newaxis]
    
    stc_Dummy = mne.SourceEstimate(tmp,fsave_vertices,stc0.tmin,stc0.tstep)
    
    stc = mne.SourceEstimate(tmp,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stc.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_BETA_' +
                 modality + '_' + 'LinRegressabs8bin_' + Name + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')

    stctmap = mne.SourceEstimate(tmap,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stctmap.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_tmap_' +
                 modality + '_' + 'LinRegressabs8bin_' + Name + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')

    stctmap005 = mne.SourceEstimate(tmap005,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stctmap005.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_tmap005_' +
                 modality + '_' + 'LinRegressabs8bin_' + Name + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')

    stc05 = mne.SourceEstimate(tmp05,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stc05.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_BETAp05uncorr_' +
                 modality + '_' + 'LinRegressabs8bin_' + Name + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')

    stc01 = mne.SourceEstimate(tmp01,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stc01.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_BETAp01uncorr_' +
                 modality + '_' + 'LinRegressabs8bin_' + Name + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')

    stc001 = mne.SourceEstimate(tmp001,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stc001.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_BETAp001uncorr_' +
                 modality + '_' + 'LinRegressabs8bin_' + Name + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')
                 
    stc005 = mne.SourceEstimate(tmp005,fsave_vertices,stc_Dummy.tmin,stc.tstep) 
    stc005.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_BETAp005uncorr_' +
                 modality + '_' + 'LinRegressabs8bin_' + Name + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + ori + '_'+ method + '_ico-5-fwd-fsaverage.stc')              
 
 ##############################################################################
 ##############################################################################  
ListSubj   = ('sd130343', 'cb130477', 'rb130313', 'jm100042', 
            'jm100109', 'sb120316', 'tk130502', 'lm130479', 
            'ms130534', 'ma100253', 'sl130503', 'mb140004',
            'mp140019', 'dm130250', 'hr130504', 'wl130316',
            'rl130571','sg120518','mm130405')
 
compute_stcdiff_absdist8bin_twin_ttest(ListSubj,'T','MEEG','dSPM',(0.828, 1    ),'None',(0,1)) 
compute_stcdiff_absdist8bin_twin_ttest(ListSubj,'T','MEG' ,'dSPM',(0.828, 1    ),'None',(0,1)) 
compute_stcdiff_absdist8bin_twin_ttest(ListSubj,'S','MEEG','dSPM',(0.653, 0.985),'None',(0,1))
compute_stcdiff_absdist8bin_twin_ttest(ListSubj,'S','MEG' ,'dSPM',(0.653, 0.985),'None',(0,1))
 
compute_stcdiff_absdist8bin_twin_ttest(ListSubj,'T','MEEG','dSPM',(0.440, 0.500),'None',(0,1)) 
compute_stcdiff_absdist8bin_twin_ttest(ListSubj,'T','MEG' ,'dSPM',(0.440, 0.500),'None',(0,1)) 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
  
 
 
 
 
 
 
 