# -*- coding: utf-8 -*-
"""
Created on Mon Oct 10 16:52:15 2016

@author: bgauthie
"""
# -*- coding: utf-8 -*-
"""
Created on Wed Apr 27 15:38:06 2016

@author: bgauthie
"""

def SourceReconstructionv_intmapcoumap(condarray,ListSubj,modality,Method,covmatsource):

#    condarray = ('RelPastG_coumap','RelPastG_coumap','RelPastG_intmap','RelPastG_intmap')
#    ListSubj  = ('jm100109',)
#    modality  = 'MEEG'
#    Method    = 'dSPM'
#    covmatsource = 'EV'

    import mne
    from mne.minimum_norm import apply_inverse, make_inverse_operator
    from mne.beamformer import lcmv
    import os

    os.chdir('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS/MNE_PYTHON')
    os.environ['SUBJECTS_DIR'] = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/mri'
    os.environ['MNE_ROOT'] = '/neurospin/local/mne'

    wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"

    for i in range(len(ListSubj)):
        
        # which modality?
        if modality == 'MEG':
            megtag=True  
            eegtag=False
            fname_fwd  = (wdir+ListSubj[i]+"/mne_python/run3_ico5_megonly_icacorr_-fwd.fif") 
        elif modality == 'EEG':
            megtag=False  
            eegtag=True
            fname_fwd  = (wdir+ListSubj[i]+"/mne_python/run3_ico5_eegonly_icacorr_-fwd.fif") 
        elif modality == 'MEEG':
            megtag=True  
            eegtag=True
            fname_fwd = (wdir+ListSubj[i]+"/mne_python/run3_ico5_meeg_icacorr_-fwd.fif")

        # load noise covariance matrice
        fname_noisecov    = (wdir+ListSubj[i]+"/mne_python/COVMATS/"+modality+"_noisecov_icacorr_"+ covmatsource +"_"+ ListSubj[i] +"-cov.fif")
        NOISE_COV1        = mne.read_cov(fname_noisecov)
        
        epochlist = []
        for c in range(4):
            # load MEEG epochs, then pick    
            fname_epochs      = (wdir+ListSubj[i]+"/mne_python/EPOCHS/MEEG_epochs_icacorr_" +condarray[c]+ '_' + ListSubj[i]+"-epo.fif")          
            epochs            = mne.read_epochs(fname_epochs)
            epochlist.append(epochs)
            
        mne.epochs.equalize_epoch_counts(epochlist)
           
        for c in range(4):
            epochs = []  
            epochs = epochlist[c]
            picks = mne.pick_types(epochs.info, meg=megtag,  eeg=eegtag, stim=False , eog=False)

            # compute evoked
            evokedcond1       = epochs.average(picks = picks)
            forward           = mne.read_forward_solution(fname_fwd ,surf_ori=True)
            inverse_operator1 = make_inverse_operator(evokedcond1.info,  forward, NOISE_COV1,  loose=0.2, depth=0.8)
                    
            
            if Method == 'LCMV':
                fname_datacov     = (wdir+ListSubj[i]+"/mne_python/COVMATS/"+modality+"datacov_"+condarray[c]+"_"+ListSubj[i]+"-cov.fif")
                DATA_COV1         = mne.read_cov(fname_datacov)

        ###############################
        # dSPM/ MNE/ sLORETA solution #
        ###############################
    
            if Method == 'dSPM' or Method == 'MNE' or Method == 'sLORETA':
    
        	    snr = 3.0
        	    lambda2 = 1.0 / snr **2
        	
    	    # MEG source reconstruction
        	    stccond1     = apply_inverse(evokedcond1, inverse_operator1, lambda2,method = Method, pick_ori= None)
        	    stccond1.save(wdir+ListSubj[i]+"/mne_python/STCS/IcaCorr_"+modality+"_"+ListSubj[i]+"_"+condarray[c]+"_pick_oriNone_"+Method+"_ico-5-fwd.fif")
    
        	    stccond1norm = apply_inverse(evokedcond1, inverse_operator1, lambda2,method =Method, pick_ori= "normal")
        	    stccond1norm.save(wdir+ListSubj[i]+"/mne_python/STCS/IcaCorr_"+modality+"_"+ListSubj[i]+"_"+condarray[c]+"_pick_orinormal_"+Method+"_ico-5-fwd.fif")
    
                # morphing to fsaverage
        	    stc_fsaverage_cond1 = mne.morph_data(ListSubj[i], 'fsaverage', stccond1,smooth = 20)
        	    stc_fsaverage_cond1.save(wdir+ListSubj[i]+"/mne_python/STCS/IcaCorr_"+modality+"_"+ListSubj[i]+"_"+condarray[c]+"_pick_oriNone_"+Method+"_ico-5-fwd-fsaverage.fif")
    
        	    stc_fsaverage_cond1norm = mne.morph_data(ListSubj[i], 'fsaverage', stccond1norm,smooth = 20)
        	    stc_fsaverage_cond1norm.save(wdir+ListSubj[i]+"/mne_python/STCS/IcaCorr_"+modality+"_"+ListSubj[i]+"_"+condarray[c]+"_pick_orinormal_"+Method+"_ico-5-fwd-fsaverage.fif")
        
        ###################
        # LCMV Beamformer #
        ###################
    
            elif Method == 'LCMV':
    
                # MEG source reconstruction    
                stccond1 = lcmv(evokedcond1, forward, NOISE_COV1,DATA_COV1, reg=0.01,pick_ori= None)
                stccond1.save(wdir+ListSubj[i]+"/mne_python/STCS/"+modality+"_"+ListSubj[i]+"_"+condarray[c]+"_pick_oriNone_"+Method+"_ico-5-fwd.fif")
    
                stccond1norm = lcmv(evokedcond1, forward, NOISE_COV1,DATA_COV1, reg=0.01,pick_ori= "normal")
                stccond1norm.save(wdir+ListSubj[i]+"/mne_python/STCS/"+modality+"_"+ListSubj[i]+"_"+condarray[c]+"_pick_orinormal_"+Method+"_ico-5-fwd.fif")
    
                # morphing to fsaverage
                stc_fsaverage_cond1 = mne.morph_data(ListSubj[i], 'fsaverage', stccond1,smooth = 20)
                stc_fsaverage_cond1.save(wdir+ListSubj[i]+"/mne_python/STCS/"+modality+"_"+ListSubj[i]+"_"+condarray[c]+"_pick_oriNone_"+Method+"_ico-5-fwd-fsaverage.fif") 
    
                stc_fsaverage_cond1norm = mne.morph_data(ListSubj[i], 'fsaverage', stccond1norm,smooth = 20)
                stc_fsaverage_cond1norm.save(wdir+ListSubj[i]+"/mne_python/STCS/"+modality+"_"+ListSubj[i]+"_"+condarray[c]+"_pick_orinormal_"+Method+"_ico-5-fwd-fsaverage.fif")   
        

     

