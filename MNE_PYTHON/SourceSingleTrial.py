# -*- coding: utf-8 -*-
"""
Created on Thu Oct 29 10:24:35 2015

@author: bgauthie
"""

def SourceSingleTrial(combs,subject,modality,Method):

    combs = ('Qt_all','Qs_all')
    subject  = 'jm100109'
    modality  = 'MEG'
    Method    = 'MNE'

    import mne
    from mne.minimum_norm import apply_inverse_epochs, read_inverse_operator
    import os
    import pickle

    os.chdir('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS/MNE_PYTHON')
    os.environ['SUBJECTS_DIR'] = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/mri'
    os.environ['MNE_ROOT'] = '/neurospin/local/mne'

    wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"

    for c,cond in enumerate(combs):

        # which modality? Import forward model accordingly
        if modality   == 'MEG':
            mod       = 'meg'
            fname_fwd = (wdir + subject +
                         "/mne_python/run3_oct-6_megonly_-fwd.fif") 
        elif modality == 'EEG':
            mod       = 'eeg'
            fname_fwd = (wdir + subject +
                         "/mne_python/run3_oct-6_eegonly_-fwd.fif") 
        elif modality == 'MEEG':
            mod       = 'meeg'
            fname_fwd = (wdir + subject +
                         "/mne_python/run3_oct-6_meeg_-fwd.fif")

        # load noise covariance matrice, forward model, evoked and epochs
        #noisecov = mne.read_cov((wdir + subject + "/mne_python/COVMATS/" +
        #                         modality + "noisecov_" +  + "_" +
        #                         subject + "-cov.fif")) 
                                       
        forward = mne.read_forward_solution(fname_fwd ,surf_ori=True)
        
        epochs  = mne.read_epochs(wdir + subject + 
                                  "/mne_python/EPOCHS/MEEG_epochs_" + cond +
                                  '_' + subject + "-epo.fif") 
                                 
        evoked = mne.read_evokeds((wdir + subject + "/mne_python/" + 
                                         modality + "_" + cond  + "_" + subject 
                                         + "-ave.fif"), baseline = (-0.2, 0))
                                         
        inverse_operator  = make_inverse_operator(evoked.info,  forward,
                                                  noise_cov,  loose=0.2, 
                                                  depth=0.8)
        write_inverse_operator(wdir + subject + "/mne_python/INVS/"+condnames+"_"+ mod +"_ico5-inv.fif",inverse_operator)

        ###############################
        # dSPM/ MNE/ sLORETA solution #
        ###############################

        if Method == 'dSPM' or Method == 'MNE' or Method == 'sLORETA':
            snr = 3.0
            lambda2 = 1.0 / snr **2
    	
	      #MEG source reconstruction
            #stc     = apply_inverse_epochs(epochs, invop, lambda2,method = Method,
            #                     pick_ori= None, nave=evoked[0].nave)
            #stc[0].save(wdir + subject + "/mne_python/STCS/SgTr_" + modality + "_" + 
            #      subject + "_" + cond + "_pick_oriNone_" + Method + 
            #      "_ico-5-fwd.fif")

            stcnorm = apply_inverse_epochs(epochs, invop, lambda2,method = Method, 
                                 pick_ori = "normal", nave=evoked[0].nave)
           
            savefolder = []
            savefolder = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/' +
                         subject + '/mne_python/STCS/SgTr_' + modality + "_" +
                       subject + "_" + cond + "_pick_orinormal_" + Method )                  
            if os.path.exists(savefolder) == False:    
                os.mkdir(savefolder)                 
                                 
            [stcnorm[c].save(savefolder + '/trial' + str(c) + '.fif') for c in range(len(stcnorm))]



            # morphing to fsaverage
            #stc_fsaverage_ = mne.morph_data(subject, 'fsaverage', stc[0])
            #stc_fsaverage_.save(wdir + subject + "/mne_python/STCS/SgTr_" + modality + 
            #                 "_" + subject + "_" + cond + "_pick_oriNone_" + 
            #                 Method + "_ico-5-fwd-fsaverage.fif")

            stc_fsaverage_norm = mne.morph_data(subject, 'fsaverage', stcnorm[0])
            stc_fsaverage_norm.save(wdir + subject + "/mne_python/STCS/SgTr_" + 
                                  modality + "_" + subject + "_" + cond + 
                                  "_pick_orinormal_" + Method + 
                                  "_ico-5-fwd-fsaverage.fif")
    
