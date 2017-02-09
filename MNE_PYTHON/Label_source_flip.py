# -*- coding: utf-8 -*-
"""
Created on Fri Feb  5 15:59:11 2016

@author: bgauthie
"""

def Label_source_flip(condnames,ListSubj,modality,Method,covmatsource,parc):

    condnames = ('Qt_all','Qs_all')
    ListSubj = (
	'sd130343', 'cb130477', 'rb130313', 
	'jm100109', 'sb120316', 'tk130502', 
	'lm130479', 'ms130534', 'ma100253',
	'sl130503', 'mb140004', 'mp140019',
	'dm130250', 'hr130504', 'wl130316', 
	'rl130571')
    modality  = 'MEG'
    Method    = 'dSPM'
    covmatsource = 'QT'
    parc = 'aparc'

    import mne
    import numpy as np
    from mne.minimum_norm import apply_inverse, make_inverse_operator
    from mne.minimum_norm import apply_inverse_epochs
    import os
    from matplotlib import pyplot as plt

    os.chdir('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS/MNE_PYTHON')
    os.environ['SUBJECTS_DIR'] = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/mri'
    os.environ['MNE_ROOT'] = '/neurospin/local/mne'

    wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"

    for c in range(len(condnames)):  
        label_mean,label_mean_flip,label_mean_ev = [],[],[]
        for i in range(len(ListSubj)):
            
        subjects_dir = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/mri/'   
        labels = mne.read_labels_from_annot('fsaverage',
                                            parc, 
                                            hemi = 'both', 
                                            subjects_dir = ListSubj[i])
        label = labels[6]                                     

            # which modality?
            if modality == 'MEG':
                megtag=True  
                eegtag=False
                fname_fwd  = (wdir+ListSubj[i]+"/mne_python/run3_ico-5_megonly_-fwd.fif") 
            elif modality == 'EEG':
                megtag=False  
                eegtag=True
                fname_fwd  = (wdir+ListSubj[i]+"/mne_python/run3_ico-5_eegonly_-fwd.fif") 
            elif modality == 'MEEG':
                megtag=True  
                eegtag=True
                fname_fwd = (wdir+ListSubj[i]+"/mne_python/run3_ico-5_meeg_-fwd.fif")

            # load noise covariance matrice
            fname_noisecov    = (wdir+ListSubj[i]+"/mne_python/COVMATS/"+modality
                                 +"_noisecov_"+ covmatsource +"_"+ ListSubj[i] +"-cov.fif")
            NOISE_COV1        = mne.read_cov(fname_noisecov)

            # load MEEG epochs, then pick    
            fname_epochs      = (wdir+ListSubj[i]+"/mne_python/EPOCHS/MEEG_epochs_" 
                                 +condnames[c]+ '_' + ListSubj[i]+"-epo.fif")          
            epochs            = mne.read_epochs(fname_epochs)
            epochs.pick_types(meg=megtag,  eeg=eegtag, stim=False , eog=False)
            # compute evoked
            evokedcond1       = epochs.average()
            forward           = mne.read_forward_solution(fname_fwd ,surf_ori=True)
            inverse_operator1 = make_inverse_operator(evokedcond1.info,  forward,
                                                      NOISE_COV1,  loose=0.2, depth=0.8)
            snr = 3.0
            lambda2 = 1.0 / snr **2
        	
            
            # MEG source reconstruction
            stc,stc_ev, label_mean_evoked = [], [], []
            stc= apply_inverse_epochs(epochs, inverse_operator1, lambda2,
                                         method =Method, label=label, pick_ori= "normal",nave=evokedcond1.nave)
                                             
            stc_ev= apply_inverse(evokedcond1, inverse_operator1, lambda2,
                                         method =Method, label=label, pick_ori= "normal")
            label_mean_evoked = np.mean(stc_ev.data, axis=0)                            
            # Mean across trials but not across vertices in label
            mean_stc = []
            mean_stc = sum(stc) / len(stc)
            
            # compute sign flip to avoid signal cancelation when averaging signed values
            flip = mne.label_sign_flip(label, inverse_operator1['src'])
            
            label_mean.append(np.mean(mean_stc.data, axis=0))
            label_mean_flip.append(np.mean(flip[:, np.newaxis] * mean_stc.data, axis=0))
            label_mean_ev.append(label_mean_evoked)
            
        LabMean     = np.mean(np.array(label_mean),axis=0)    
        LabMeanFlip = np.mean(np.array(label_mean_flip),axis=0)       
        LabelmeanEv = np.mean(np.array(label_mean_ev),axis=0)       

                 
        ############################## PLOT ###############################
        times = 1e3 * stc[0].times  # times in ms
        
        
        plt.figure()
        h1, = plt.plot(times, LabMean, 'r', linewidth=3)
        h2, = plt.plot(times, LabMeanFlip, 'g', linewidth=3)
        h3, = plt.plot(times, LabelmeanEv, 'k', linewidth=3)
        
        
        plt.legend((h1, h2, h3), ('mean',
                 'mean with sign flip', 'evoked'))
        plt.xlabel('time (ms)')
        plt.ylabel('dSPM value')
        plt.show()
       
       plt.figure()         
       plt.plot(times,np.transpose(np.array(label_mean),[1, 0]))
       plt.figure()
       plt.plot(times,np.transpose(np.array(label_mean_flip),[1, 0]))
       
   
       plt.figure()         
       plt.plot(np.transpose(mean_stc.data,[1,0]))
       plt.figure() 
       plt.plot(np.transpose(flip[:, np.newaxis] * mean_stc.data,[1,0]))   
   
       plt.figure()         
       plt.plot(np.mean(mean_stc.data, axis=0))
       plt.figure() 
       plt.plot(np.mean(flip[:, np.newaxis] * mean_stc.data, axis=0))     

###############################################################################   
## compare to extraction for whole brain stc
stc0_path = (wdir + '/' + ListSubj[0] + '/mne_python/STCS/' + modality + 
           '_' + ListSubj[0] + '_' + condnames[0] + '_pick_orinormal_' + 
            Method + '_ico-5-fwd-fsaverage.fif-rh.stc')
            
init_timepoints = mne.read_source_estimate(stc0_path)
ncond  = len(condnames)
nsub   = len(ListSubj)
nlabel = len(labels)
ntimes = len(init_timepoints.times)

# get timecourse data from each subject & each label
TC_Label   = np.empty([ncond,nsub,ntimes])
TCsd_Label = np.empty([ncond,nsub,ntimes])
for s,subj in enumerate(ListSubj):
    label = labels[6] 
    for c,cond in enumerate(condnames):
        stc_path = (wdir + '/' + subj + '/mne_python/STCS/' + modality +
                    '_' + subj + '_' + cond + '_pick_orinormal_' + 
                    Method + '_ico-5-fwd-fsaverage.fif-rh.stc')           
        fname_epochs      = (wdir+ListSubj[i]+"/mne_python/EPOCHS/MEEG_epochs_" 
                             +condnames[c]+ '_' + ListSubj[i]+"-epo.fif")          
        epochs            = mne.read_epochs(fname_epochs)
        epochs.pick_types(meg=megtag,  eeg=eegtag, stim=False , eog=False)
        # compute evoked
        evokedcond1       = epochs.average()
        forward           = mne.read_forward_solution(fname_fwd ,surf_ori=True)
        inverse_operator1 = make_inverse_operator(evokedcond1.info,  forward,
                                                      NOISE_COV1,  loose=0.2, depth=0.8)
        stc = mne.read_source_estimate(stc_path)                                              
        a = stc.extract_label_time_course(label,inverse_operator1['src'],mode = 'mean')
        TC_Label[c,s,:] = np.mean(a.data[:,:], axis = 0)
        TCsd_Label[c,s,:] = np.std(a.data[:,:], axis = 0)/np.sqrt(np.float32(a.shape[0]))
        del stc, a

tmp1 = np.mean(TC_Label[1,:,:],axis = 0)


   