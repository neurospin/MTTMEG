# -*- coding: utf-8 -*-
"""
Created on Fri Oct 28 16:40:59 2016

@author: bgauthie
"""

def SourceReconstruction_eq(condnames,ListSubj,modality,Method,covmatsource):

#    condnames = ('signDT8_1','signDT8_8')
#    ListSubj  = ('jm100109',)
#    modality  = 'MEG'
#    covmatsource = 'EV'

    import mne
    from mne.minimum_norm import apply_inverse, make_inverse_operator
    import os

    os.chdir('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS/MNE_PYTHON')
    os.environ['SUBJECTS_DIR'] = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/mri'
    os.environ['MNE_ROOT'] = '/neurospin/local/mne'

    wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"

    
    for i in range(len(ListSubj)):
        epochs_list = []
        for c in range(len(condnames)):

            # which modality?
            if modality == 'MEG':
                megtag=True  
                eegtag=False
                fname_fwd  = (wdir+str(ListSubj[i])+"/mne_python/run3_ico5_megonly_icacorr_-fwd.fif") 
            elif modality == 'EEG':
                megtag=False  
                eegtag=True
                fname_fwd  = (wdir+str(ListSubj[i])+"/mne_python/run3_ico5_eegonly_icacorr_-fwd.fif") 
            elif modality == 'MEEG':
                megtag=True  
                eegtag=True
                fname_fwd = (wdir+str(ListSubj[i])+"/mne_python/run3_ico5_meeg_icacorr_-fwd.fif")


            # load noise covariance matrice
            fname_noisecov    = (wdir+str(str(ListSubj[i]))+"/mne_python/COVMATS/"+modality+"_noisecov_icacorr_"+ covmatsource +"_"+ str(ListSubj[i]) +"-cov.fif")
            NOISE_COV1        = mne.read_cov(fname_noisecov)

            # load MEEG epochs, then pick    
            fname_epochs      = (wdir+str(ListSubj[i])+"/mne_python/EPOCHS/MEEG_epochs_icacorr_" +str(condnames[c])+ '_' + str(ListSubj[i])+"-epo.fif")          
            epochs            = mne.read_epochs(fname_epochs)
            epochs_list.append(epochs)
            
        mne.epochs.equalize_epoch_counts(epochs_list)

        for c in range(len(condnames)):
            
            epochs = []
            epochs = epochs_list[c]
            # compute evoked
            picks = mne.pick_types(epochs.info, meg=megtag,  eeg=eegtag, stim=False , eog=False)
            evokedcond1       = epochs.average(picks = picks)
            forward           = mne.read_forward_solution(fname_fwd ,surf_ori=True)
            inverse_operator1 = make_inverse_operator(evokedcond1.info,  forward, NOISE_COV1,  loose=0.2, depth=0.8)
            snr = 3.0
            lambda2 = 1.0 / snr **2
            
            # MEG source reconstruction
            stccond1     = apply_inverse(evokedcond1, inverse_operator1, lambda2,method = Method, pick_ori= None)
            stccond1.save(wdir+str(ListSubj[i])+"/mne_python/STCS/"+modality+"_"+str(ListSubj[i])+"_"+condnames[c]+"_pick_oriNone_"+Method+"_ico-5-fwd.fif")
            stccond1norm = apply_inverse(evokedcond1, inverse_operator1, lambda2,method =Method, pick_ori= "normal")
            stccond1norm.save(wdir+str(ListSubj[i])+"/mne_python/STCS/"+modality+"_"+str(ListSubj[i])+"_"+condnames[c]+"_pick_orinormal_"+Method+"_ico-5-fwd.fif")
            
            # morphing to fsaverage
            stc_fsaverage_cond1 = mne.morph_data(str(ListSubj[i]), 'fsaverage', stccond1,smooth = 20)
            stc_fsaverage_cond1.save(wdir+str(ListSubj[i])+"/mne_python/STCS/"+modality+"_"+str(ListSubj[i])+"_"+condnames[c]+"_pick_oriNone_"+Method+"_ico-5-fwd-fsaverage.fif")
            stc_fsaverage_cond1norm = mne.morph_data(str(ListSubj[i]), 'fsaverage', stccond1norm,smooth = 20)
            stc_fsaverage_cond1norm.save(wdir+str(ListSubj[i])+"/mne_python/STCS/"+modality+"_"+str(ListSubj[i])+"_"+condnames[c]+"_pick_orinormal_"+Method+"_ico-5-fwd-fsaverage.fif")
      
       