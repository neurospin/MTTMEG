# -*- coding: utf-8 -*-
"""
Created on Fri Oct 21 17:54:43 2016

@author: bgauthie
"""


#ListSubj = ('sd130343','cb130477')

def SourceSignedReg(ListSubj,modality,Method):


    #pre-defined conditions
    covmatsource = 'EV'
#    condarray =  ('signDT-24','signDT-21','signDT-19','signDT-17','signDT-14','signDT-12',
#             'signDT-10','signDT-7','signDT-5','signDT-3','signDT0',
#             'signDT4','signDT6','signDT9','signDT11','signDT13','signDT16',
#             'signDT18','signDT20','signDT23','signDT25','signDT27','signDT29')
    condarray = ('signDS-149','signDS-117',
              'signDS-95','signDS-85','signDS-74','signDS-63','signDS-52','signDS-42',
              'signDS-31','signDS-20','signDS-10','signDS1','signDS12','signDS22',
              'signDS33','signDS44','signDS55','signDS65','signDS76','signDS87',
              'signDS97','signDS108','signDS119','signDS129','signDS140')
    tag  = 'signedt_evs'
    Name = 'SsignedEVS'

    import mne
    import numpy as np
    from mne.minimum_norm import apply_inverse, make_inverse_operator
    import os

    os.chdir('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS/MNE_PYTHON')
    os.environ['SUBJECTS_DIR'] = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/mri'
    os.environ['MNE_ROOT'] = '/neurospin/local/mne'

    wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"
    
    #dist = [-24, -21, -19, -17, -14, -12, -10, -7, -5, -3, 0, 4, 6, 9, 11, 13, 16, 18, 20, 23, 25, 27, 29]
    dist = [-149, -117,-95,-85, -74, -63, -52, -42, -31, -20, -10, 1, 12, 22, 33, 44, 55, 65, 76, 87, 97, 108, 119, 129, 140]
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
        fname_epochs0      = (wdir + subj + '/mne_python/EPOCHS/MEEG_epochs_icacorr_signDS-149_'+subj+'-epo.fif')        
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
        fname_epochsdummy      = (wdir + subj + '/mne_python/EPOCHS/MEEG_epochs_icacorr_signDS-149_'+subj+'-epo.fif')          
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

 
