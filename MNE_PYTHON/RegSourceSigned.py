# -*- coding: utf-8 -*-
"""
Created on Thu Oct 27 15:33:14 2016

@author: bgauthie
"""

# -*- coding: utf-8 -*-
"""
Created on Fri Oct 21 17:54:43 2016

@author: bgauthie
"""


#ListSubj = ('sd130343','cb130477')

def RegSourceSigned(ListSubj,modality,Method,ori,twin,tag):
    
    import mne
    import os
    import numpy as np
    
    from scipy import stats
    from mne.minimum_norm import apply_inverse_epochs, make_inverse_operator

    wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"
    ###############################################################################
    ############################# SUBFUNCTIONS ####################################
    ###############################################################################
    def CatEpochs(subject, CondComb, CovSource, Method, modality,twin,dist,ori):
        
        snr = 3.0
        lambda2 = 1.0 / snr **2        
    
        if CondComb[0] != CondComb[1]:
            X,  stcs = [], []
            epochs_list, epochs_count, evoked_list, inverse_operator_list = [], [], [], []
            for c,cond in enumerate(CondComb):        
    
                epochs  = mne.read_epochs(wdir + subject + 
                                          "/mne_python/EPOCHS/MEEG_epochs_icacorr_" + cond +
                                          '_' + subject + "-epo.fif")
                
                epochs.crop(tmin = -0.2, tmax = 1)
                # which modality?
                if modality == 'MEG':
                    megtag=True  
                    eegtag=False
                    fname_fwd  = (wdir+subj+"/mne_python/run3_ico5_megonly_icacorr_-fwd.fif") 
                    epochs.pick_types(meg=megtag, eeg = eegtag)
                elif modality == 'EEG':
                    megtag=False  
                    eegtag=True
                    fname_fwd  = (wdir+subj+"/mne_python/run3_ico5_eegonly_icacorr_-fwd.fif") 
                    epochs.pick_types(meg=megtag, eeg = eegtag)
                elif modality == 'MEEG':
                    megtag=True  
                    eegtag=True
                    fname_fwd = (wdir+subj+"/mne_python/run3_ico5_meeg_icacorr_-fwd.fif")  
                    epochs.pick_types(meg=megtag, eeg = eegtag)                                         
                
                epochs_list.append(epochs)
                epochs_count.append(epochs.get_data().shape[0])
                
                # import nose_cov
                noise_cov = mne.read_cov((wdir + subject + "/mne_python/COVMATS/" +
                                         modality + "_noisecov_icacorr_" + CovSource + "_" +
                                         subject + "-cov.fif"))   
                # import forward
                forward = mne.read_forward_solution(fname_fwd ,surf_ori=True)
                 
                # load  epochs, then pick    
                picks = mne.pick_types(epochs.info, meg=megtag,  eeg=eegtag, stim=False , eog=False)
        
                # compute evoked
                evoked       = epochs.average(picks = picks)   
                evoked_list.append(evoked)                           
                
                # compute inverse operator
                inverse_operator  = make_inverse_operator(evoked.info,  
                                                              forward,
                                                              noise_cov,  
                                                              loose=0.2, 
                                                              depth=0.8) 
                inverse_operator_list.append(inverse_operator)   
        
        Epochs = mne.epochs.concatenate_epochs(epochs_list)
        Epochs.crop(twin[0],twin[1])        
                                                                   
        n_epochs  = np.sum(epochs_count)
        n_times   = len(Epochs.times)
        n_vertices = forward['nsource']
        X = np.zeros([n_epochs, n_vertices, n_times])  
        #for condition_count, ep in zip([0, n_epochs / 8], epochs_list):
        for epcount in range(len(Epochs)):
            stcs = apply_inverse_epochs(Epochs[epcount], inverse_operator, lambda2,
                            Method, pick_ori=ori,  # saves us memory
                            return_generator=True)
            for jj, stc in enumerate(stcs):
                X[epcount + jj] = stc.data
        
        tmp = []
        for index, nb in enumerate(epochs_count):
            tmp.append(np.ones((nb))*(dist[index]))
        Y = np.concatenate(tmp)    
        
        return stc, n_times, X, Y, forward
    #########################################################################      

    #pre-defined conditions
    if tag == 'T':
        condarray = ('signDT8_1','signDT8_2','signDT8_3','signDT8_4','signDT8_5','signDT8_6','signDT8_7','signDT8_8')
        Name = 'TsignedEVT'
        dist = [-27.7, -12.9, -8.3, -3.5, 2.5, 7.94, 13.4, 21.8]
    elif tag == 'S':
        condarray = ('signDS8_1','signDS8_2','signDS8_3','signDS8_4','signDS8_5','signDS8_6','signDS8_7','signDS8_8')
        Name = 'SsignedEVS'
        dist = [-124, -82, -47, -10, 15, 50, 76, 120]         

    os.chdir('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS/MNE_PYTHON')
    os.environ['SUBJECTS_DIR'] = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/mri'
    os.environ['MNE_ROOT'] = '/neurospin/local/mne'

    wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"
    covmatsource = 'EV'   
    
    ###########################################################################
    for s,subj in enumerate(ListSubj):  
        
        # trial-by-trial source reconstruction
        stc, n_times, DATAMAT, Predictor, forward = CatEpochs(subj, condarray, covmatsource, Method, modality,twin,dist,ori)   
        
        DATAMAT = np.mean(DATAMAT,axis = 2)
        nvertices = DATAMAT.shape[1]
        BETAS = np.zeros((nvertices))     
        for v in range(nvertices):
                slope, intercept, r_value, p_value, std_err = stats.linregress(Predictor,DATAMAT[:,v]) # resp = a*pred + b
                BETAS[v] = r_value

        #use a dummy stc to plot source-space BETAS
        fsave_vertices = [np.arange(stc.shape[0]/2), np.arange(stc.shape[0]/2)]
        tmp = BETAS[:,np.newaxis]
        stc = mne.SourceEstimate(tmp,fsave_vertices,stc.tmin,stc.tstep) 
        
        stc.save('//neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_' +
                 modality + '_LinRegressSourceLevel_' + Name + '_twin' +
                 str(twin[0]) + '-' + str(twin[1]) + 'ms_pick_ori' + str(ori) + '_'+ Method + '_ico-5-fwd-fsaverage.stc')
        
        
        
        
        
