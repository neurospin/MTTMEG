# -*- coding: utf-8 -*-
"""
Created on Tue Sep 27 19:01:36 2016

@author: bgauthie
"""

#ListSubj = ('sd130343','cb130477')

def SourceReg(ListSubj,modality,Method):


    #pre-defined conditions
    covmatsource = 'EV'
    condarray = ('dist1t_evt','dist2t_evt','dist3t_evt','dist4t_evt','dist5t_evt','dist6t_evt',
    'dist7t_evt','dist8t_evt','dist9t_evt','dist10t_evt','dist11t_evt','dist12t_evt',
    'dist13t_evt','dist14t_evt','dist15t_evt','dist16t_evt','dist17t_evt','dist18t_evt',
    'dist19t_evt','dist20t_evt','dist21t_evt','dist22t_evt','dist23t_evt','dist24t_evt')
#    condarray = ('dist1s_evs','dist2s_evs','dist3s_evs','dist4s_evs','dist5s_evs','dist6s_evs',
#    'dist7s_evs','dist8s_evs','dist9s_evs','dist10s_evs','dist11s_evs','dist12s_evs',
#    'dist13s_evs','dist14s_evs','dist15s_evs','dist16s_evs','dist17s_evs','dist18s_evs',
#    'dist19s_evs','dist20s_evs','dist21s_evs','dist22s_evs','dist23s_evs','dist24s_evs')
    tag  = 't_evt'
    Name = 'TEVT'

    import mne
    import numpy as np
    from mne.minimum_norm import apply_inverse, make_inverse_operator
    import os

    os.chdir('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS/MNE_PYTHON')
    os.environ['SUBJECTS_DIR'] = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/mri'
    os.environ['MNE_ROOT'] = '/neurospin/local/mne'

    wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"
    
    # dist = [1,2,3,4,5,6,7,8,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,27]
    dist = [5, 10, 15, 20, 25, 30, 35, 41, 46, 51, 56, 61, 66, 71, 77, 82, 87, 92, 97, 102, 107, 113, 118, 123, 128]
    BETAS = []
    RegEpochList = []  
    
    for s,subj in enumerate(ListSubj):
        
        # which modality?
        if modality == 'MEG':
            megtag=True  
            eegtag=False
            fname_fwd  = (wdir+subj+"/mne_python/run3_ico5_megonly_icacorr_-fwd.fif") 
        elif modality == 'EEG':
            megtag=False  
            eegtag=True
            fname_fwd  = (wdir+subj+"/mne_python/run3_ico5_eegonly_icacorr_-fwd.fif") 
        elif modality == 'MEEG':
            megtag=True  
            eegtag=True
            fname_fwd = (wdir+subj+"/mne_python/run3_ico5_meeg_icacorr_-fwd.fif")  
        
        DistPerTrial = []
        # initiate data size
        fname_epochs0      = (wdir + subj + '/mne_python/EPOCHS/MEEG_epochs_icacorr_dist1'+tag+'_'+subj+'-epo.fif')        
        epochs0 = mne.read_epochs(fname_epochs0)
        epochs0.pick_types(meg=megtag,  eeg=eegtag)
        
        if ListSubj[s] == 'sd130343':
            epochs0.drop_channels(('EEG064',))
        nchans  = epochs0.get_data().shape[1]
        ntime   = epochs0.get_data().shape[2]
        DATAMAT = np.zeros((0,nchans,ntime))
        
        for c,cond in enumerate(condarray):
            fname_epochs = (wdir+ListSubj[s]+"/mne_python/EPOCHS/MEEG_epochs_icacorr_" +cond+ '_' + subj+"-epo.fif")          
            epochs       = mne.read_epochs(fname_epochs)            
            epochs.pick_types(meg=megtag,  eeg=eegtag)
            
            if ListSubj[s] == 'sd130343':
                epochs.drop_channels(('EEG064',))
            ntrials      = epochs.get_data().shape[0]
            DistPerTrial = np.hstack((DistPerTrial,(np.ones(ntrials))*dist[c]))
            
            DATAMAT= np.concatenate((DATAMAT,epochs.get_data()),axis = 0)
        
        Predictor = np.transpose(np.vstack([DistPerTrial,np.ones(len(DistPerTrial))]))
        BETAS.append(np.zeros([nchans,ntime]))        
        for c in range(nchans):
            for t in range(ntime):
                a,b = np.linalg.lstsq(Predictor,DATAMAT[:,c,t])[0] # resp = a*pred + b
                BETAS[s][c,t] = a

        #use a dummy epochs to store regression betas
        fname_epochsdummy      = (wdir + subj + '/mne_python/EPOCHS/MEEG_epochs_icacorr_dist1'+tag+'_'+subj+'-epo.fif')          
        epochsdummy = mne.read_epochs(fname_epochsdummy)
        epochsdummy.pick_types(meg=megtag,  eeg=eegtag)
        if ListSubj[s] == 'sd130343':
            epochsdummy.drop_channels(('EEG064',))
        fakeavg = epochsdummy.average()
        fakeavg.data = BETAS[s]
        RegEpochList.append(fakeavg)

    for s in range(len(ListSubj)):
        # load noise covariance matrice
        fname_noisecov    = (wdir+subj+"/mne_python/COVMATS/"+modality+"_noisecov_icacorr_"+ covmatsource +"_"+ subj +"-cov.fif")
        NOISE_COV1        = mne.read_cov(fname_noisecov)
        
        # concatenate epochs if several conditions
        forward           = mne.read_forward_solution(fname_fwd ,surf_ori=True)
        inverse_operator1 = make_inverse_operator(RegEpochList[s].info,  forward, NOISE_COV1,  loose=0.2, depth=0.8)
        
        snr = 3.0
        lambda2 = 1.0 / snr **2
        
        # MEG source reconstruction
        stccond1     = apply_inverse(RegEpochList[s], inverse_operator1, lambda2,method = Method, pick_ori= None)
        stccond1.save(wdir+subj+"/mne_python/STCS/"+modality+"_"+subj+"_dist"+Name+"_pick_oriNone_"+Method+"_ico-5-fwd.fif")
        
        stccond1norm = apply_inverse(RegEpochList[s], inverse_operator1, lambda2,method =Method, pick_ori= "normal")
        stccond1norm.save(wdir+subj+"/mne_python/STCS/"+modality+"_"+subj+"_dist"+Name+"_pick_orinormal_"+Method+"_ico-5-fwd.fif")

        # morphing to fsaverage
        stc_fsaverage_cond1 = mne.morph_data(subj, 'fsaverage', stccond1,smooth = 20)
        stc_fsaverage_cond1.save(wdir+subj+"/mne_python/STCS/"+modality+"_"+subj+"_dist"+Name+"_pick_oriNone_"+Method+"_ico-5-fwd-fsaverage.fif")
     
        stc_fsaverage_cond1norm = mne.morph_data(subj, 'fsaverage', stccond1norm,smooth = 20) 
        stc_fsaverage_cond1norm.save(wdir+subj+"/mne_python/STCS/"+modality+"_"+subj+"_dist"+Name+"_pick_orinormal_"+Method+"_ico-5-fwd-fsaverage.fif")

 
