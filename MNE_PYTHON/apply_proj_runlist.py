# -*- coding: utf-8 -*-
"""
Created on Wed Mar 16 18:10:42 2016

@author: bgauthie
"""

###############################################################################
def check_ICA_Cleaning(subject, runlist, badEEG, badICA):

    import mne
    import os.path as op
    import os
    from mne.report import Report
    from mne.io.pick import _picks_by_type as picks_by_type
    from mne.preprocessing import read_ica
    from mne.io import Raw  
    from mne.preprocessing import create_ecg_epochs, create_eog_epochs
    
    
    data_path = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/'      
    report    = Report(subject)
    
    raw_fnames = []
    for run in runlist:
        raw_fnames.append(data_path + subject + '/' + run + '_trans_sss.fif')
    # read raw data
    raw       = Raw(raw_fnames, preload=True)
    raw.info['bads'] = badEEG 
    # Highpass filter 1Hz on EOG/ECG channels
    picks =  mne.pick_types(raw.info, meg=False,eeg=False, eog=True, ecg=False)
    raw.filter(l_freq = 1, h_freq=2, picks = picks)
    picks =  mne.pick_types(raw.info, meg=True,eeg=True, eog=True, ecg=True)
    raw.filter(l_freq = None, h_freq=30, picks = picks,n_jobs = 4)
    
    results_dir = op.join(data_path, subject,'artefactICA')
    if not op.exists(results_dir):
        os.makedirs(results_dir)    
    
    # Create ICA file for each data type (MEG and EEG) 
    for ch_type, picks in picks_by_type(raw.info, meg_combined=True): # bad EEG channels are excluded
        # Read ICA file
        ica = []
        ica = read_ica(data_path + subject + '/mne_python/ICA/ICA_' + ch_type + '_allRuns' )

        for badICAsel in badICA[ch_type]:
            # Select bad component and assess artefact rejection quality
            ica_exclude  = badICAsel
            
            ecg_evoked = create_ecg_epochs(raw, tmin=-.5, tmax=.5, picks=picks).average()
            fig = ica.plot_overlay(ecg_evoked, exclude=ica_exclude)  # plot ECG cleaning
            report.add_figs_to_section(fig, str(badICAsel) + ' Rejection overlay (%s)' % ch_type,'ECG')               
               
            eog_evoked = create_eog_epochs(raw, tmin=-.5, tmax=.5, picks=picks).average()
            fig = ica.plot_overlay(eog_evoked, exclude=ica_exclude) # plot EOG cleaning
            report.add_figs_to_section(fig, str(badICAsel) + ' Rejection overlay (%s)' % ch_type,'EOG')
               
            fig = ica.plot_overlay(raw)
            report.add_figs_to_section(fig, str(badICAsel) + ' Rejection overlay (%s)' % ch_type,'Workroad artefact')

    
    report.save((results_dir + '/AllRunsChecked.html'), open_browser=False,overwrite=True)
     
###############################################################################
###############################################################################
def apply_ICA(subject, runlist, badEEG, badICA):

    from mne.io.pick import _picks_by_type as picks_by_type
    from mne.preprocessing import read_ica
    from mne.io import Raw  
    
    data_path = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/'      
    
    for run in runlist:
        raw_fname = (data_path + subject + '/' + run + '_trans_sss.fif')
        # read raw data
        raw              = []
        raw              = Raw(raw_fname, preload=True)
        raw.info['bads'] = badEEG 
        
        # Load ICA file for each data type (MEG and EEG) 
        for ch_type, picks in picks_by_type(raw.info, meg_combined=True):
            # Read ICA file
            ica = []
            ica = read_ica(data_path + subject + '/mne_python/ICA/ICA_' + ch_type + '_allRuns' )
            # Apply ICA projection    
            ica.exclude += badICA[ch_type]
            raw = ica.apply(raw, copy=True)
        # Interpolate bad EEG channels
        raw = raw.copy().interpolate_bads()
        # Save artifacts-corrected raw data
        raw.save((data_path + subject + '/' + run + 'ICAcorr_trans_sss.fif'), overwrite = 'True')
        
###############################################################################
###############################################################################
subject = 'sd130343'
runlist = ['run1_GD', 'run2_GD', 'run3_DG', 'run4_DG', 'run5_GD']
badEEG  = ['EEG025', 'EEG036', 'EEG064']
badICA  = {'eeg':[[24,5,6,7],[24,5,6,7,8],[24,5,6,7,8,22],[24,5,6,7,22]],
           'meg':[[52,0,8]]}
check_ICA_Cleaning(subject, runlist, badEEG, badICA) 
badICA  = {'eeg':[24,5,6,7,8,22],
           'meg':[52,0,8]}    
apply_ICA(subject, runlist, badEEG,badICA)     
########################################################################     
subject = 'cb130477'
runlist = ['run1_GD','run2_GD','run3_DG','run4_DG','run5_GD']
badEEG  = ['EEG035', 'EEG036', 'EEG064']
badICA  = {'eeg':[[0,1,2,3,4,5,6,7,8,9,10,11,12,13,16,17,18,20,21,22,23,24,25,26,
                   27,28,29,30,31,32,33,34,35,36,37,38,40,42,43,44,45]],
           'meg':[[41,30,5,46,17,15,34]]}
check_ICA_Cleaning(subject, runlist, badEEG, badICA) 
badICA  = {'eeg':[0,1,2,3,4,5,6,7,8,9,10,11,12,13,16,17,18,20,21,22,23,24,25,26,
                   27,28,29,30,31,32,33,34,35,36,37,38,40,42,43,44,45],
           'meg':[41,30,5,46,17,15,34]}
apply_ICA(subject, runlist, badEEG,badICA)          
###############################################################################     
subject = 'rb130313'
runlist = ['run1_GD','run2_GD','run3_DG','run4_DG']
badEEG  =  ['EEG025', 'EEG035',  'EEG036']
badICA  = {'eeg':[[0,5,24],[0,5,9,10,12,13,14,15,17,22,23,24,25,26,28]],
           'meg':[[37,14,39],[37,14,39,34]]}
check_ICA_Cleaning(subject, runlist, badEEG, badICA)     
badICA  = {'eeg':[0,5,9,10,12,13,14,15,17,22,23,24,25,26,28],
           'meg':[37,14,39,34]}
apply_ICA(subject, runlist, badEEG,badICA)      
###############################################################################     
subject = 'jm100042'
runlist = ['run1_GD','run2_GD','run3_DG','run4_DG']
badEEG  = ['EEG035']
badICA  = {'eeg':[[0, 9, 2, 1, 3, 4, 19, 12]],
           'meg':[[48,54,34,32,36],[48,54,34,32,36,9]]}  
check_ICA_Cleaning(subject, runlist, badEEG, badICA)  
badICA  = {'eeg':[0, 9, 2, 1, 3, 4, 19, 12],
           'meg':[48,54,34,32,36,9]} 
apply_ICA(subject, runlist, badEEG,badICA)         
###############################################################################     
subject = 'sb120316'
runlist = ['run1_GD','run2_GD','run3_DG','run4_DG','run5_GD']
badEEG  = ['EEG026', 'EEG036']
badICA  = {'eeg':[[2,12],[2,12,28],[2,12,28,0,3,4,6,7,8,11,13,14,15,16,18,19,20,21,22,23,24,26,29,30,31,32,33]],
           'meg':[[26,39,27,37],[26,39,27,37,11,23]]}      
check_ICA_Cleaning(subject, runlist, badEEG, badICA)       
badICA  = {'eeg':[2,12,28,0,3,4,6,7,8,11,13,14,15,16,18,19,20,21,22,23,24,26,29,30,31,32,33],
           'meg':[26,39,27,37,11,23]}        
apply_ICA(subject, runlist, badEEG,badICA)       
###############################################################################     
subject = 'tk130502'
runlist = ['run1_GD','run2_GD','run3_DG','run4_DG','run5_GD']
badEEG  = ['EEG035']
badICA  = {'eeg':[[28,30,8],[28,30,8,0,2,3,4,5,9,10,11,14,16,18,19,20,22,23,25,27,29,31,32,33,34,35,36]],
           'meg':[[35,49,35],[35,49,35,48,15,22]]}      
check_ICA_Cleaning(subject, runlist, badEEG, badICA)       
badICA  = {'eeg':[28,30,8,0,2,3,4,5,9,10,11,14,16,18,19,20,22,23,25,27,29,31,32,33,34,35,36],
           'meg':[35,49,35,48,15,22]}    
apply_ICA(subject, runlist, badEEG,badICA)          
###############################################################################  
subject = 'lm130479'
runlist = ['run1_GD','run2_GD','run3_DG','run4_DG','run5_GD']
badEEG  = ['EEG025', 'EEG035', 'EEG036' ,'EEG037']
badICA  = {'eeg':[[16,20],[16,20,13,3,9],[16,20,13,3,9,1,4,5,6,7,10,12,15,17,18,21,23,25,28,29]],
           'meg':[[14, 47],[14,47,11,37,9,16]]} 
check_ICA_Cleaning(subject, runlist, badEEG, badICA)       
badICA  = {'eeg':[16,20,13,3,9,1,4,5,6,7,10,12,15,17,18,21,23,25,28,29],
           'meg':[14,47,11,37,9,16]}    
apply_ICA(subject, runlist, badEEG,badICA)    
###############################################################################  
subject = 'ms130534'
runlist = ['run1_GD','run2_GD','run3_DG','run4_DG','run5_GD']
badEEG  = ['EEG025', 'EEG035']
badICA  = {'eeg':[[10,14,13,2,25],],
           'meg':[[0,5,7,30,14]]} 
check_ICA_Cleaning(subject, runlist, badEEG, badICA)       
badICA  = {'eeg':[10,14,13,2,25],
           'meg':[0,5,7,30,14]}   
apply_ICA(subject, runlist, badEEG,badICA)    
###############################################################################
subject = 'rl130571'
runlist = ['run1_GD','run2_GD','run3_DG','run4_DG','run5_GD']
badEEG  = ['EEG017', 'EEG025', 'EEG036', 'EEG026', 'EEG034']
badICA  = {'eeg':[[16,11,1,2,5,8,12,13,18,19,20]],
           'meg':[[34,58,5,28,10]]} 
check_ICA_Cleaning(subject, runlist, badEEG, badICA)   
badICA  = {'eeg':[16,11,1,2,5,8,12,13,18,19,20],
           'meg':[34,58,5,28,10]}  
apply_ICA(subject, runlist, badEEG,badICA)   
###############################################################################
subject = 'mp140019'
runlist = ['run1_GD','run2_GD','run3_DG','run4_DG']
badEEG  = ['EEG035']
badICA  = {'eeg':[[14,29,24,27]],
           'meg':[[30,18,2]]} 
check_ICA_Cleaning(subject, runlist, badEEG, badICA)   
badICA  = {'eeg':[14,29,24,27],
           'meg':[30,18,2]} 
apply_ICA(subject, runlist, badEEG,badICA)   
###############################################################################
subject = 'dm130250'
runlist = ['run1_GD','run2_GD','run3_DG','run4_DG','run5_GD']
badEEG  = ['EEG025', 'EEG035']
badICA  = {'eeg':[[1,17,19],[1,17,19,0,2,3,4,11,16,18,19,22,24,26,27,28,30,31,32,33]],
           'meg':[[22,0]]}
check_ICA_Cleaning(subject, runlist, badEEG, badICA)   
badICA  = {'eeg':[1,17,19,0,2,3,4,11,16,18,19,22,24,26,27,28,30,31,32,33],
           'meg':[22,0]}
apply_ICA(subject, runlist, badEEG,badICA)   
###############################################################################
subject = 'mb140004'
runlist = ['run1_GD','run2_GD','run3_DG','run4_DG','run5_GD']
badEEG  = ['EEG043']
badICA  = {'eeg':[[31,27,36,35],[31,27,36,35,0,1,3,4,5,6,7,8,9,11,12,13,14,16,18,
                  19,20,21,22,23,24,25,26,28,29,30,31,32,33,34,38]],
           'meg':[[22,6,13],[22,6,13,33],[22,6,13,51]]}
check_ICA_Cleaning(subject, runlist, badEEG, badICA)   
badICA  = {'eeg':[31,27,36,35,0,1,3,4,5,6,7,8,9,11,12,13,14,16,18,
                  19,20,21,22,23,24,25,26,28,29,30,31,32,33,34,38],
           'meg':[22,6,13,51]}
apply_ICA(subject, runlist, badEEG,badICA)   
###############################################################################
subject = 'sl130503'
runlist = ['run1_GD','run2_GD','run3_DG','run4_DG']
badEEG  = ['EEG035', 'EEG057']
badICA  = {'eeg':[[13,29,32,8,21],[13,29,32,8,21,0,3,4,5,6,7,10,11,12,14,16,17,19,20,23,24,27,28,
                  30,31,35,36]],
           'meg':[[12,39,51,54,19,10]]}
check_ICA_Cleaning(subject, runlist, badEEG, badICA)   
badICA  = {'eeg':[13,29,32,8,21,0,3,4,5,6,7,10,11,12,14,16,17,19,20,23,24,27,28,
                  30,31,35,36],
           'meg':[12,39,51,54,19,10]}
apply_ICA(subject, runlist, badEEG,badICA)   
###############################################################################
subject = 'hr130504'
runlist = ['run1_GD','run2_GD','run3_DG','run4_DG']
badEEG  = ['EEG025', 'EEG035']
badICA  = {'eeg':[[3,13,0,1,2,5,6,9,10,12,18,19,20,25,27]],
           'meg':[[38,24,6,21]]}
check_ICA_Cleaning(subject, runlist, badEEG, badICA)   
badICA  = {'eeg':[3,13,0,1,2,5,6,9,10,12,18,19,20,25,27],
           'meg':[38,24,6,21]}
apply_ICA(subject, runlist, badEEG,badICA) 
###############################################################################
subject = 'sl130503'
runlist = ['run1_GD','run2_GD','run3_DG','run4_DG']
badEEG  = ['EEG035', 'EEG057']
badICA  = {'eeg':[[13,29,32,8,21],[13,29,32,8,21,0,3,4,5,6,7,10,11,12,14,16,17,19,20,23,24,27,28,
                  30,31,35,36]],
           'meg':[[12,39,51,54,19,10]]}
check_ICA_Cleaning(subject, runlist, badEEG, badICA)   
badICA  = {'eeg':[13,29,32,8,21,0,3,4,5,6,7,10,11,12,14,16,17,19,20,23,24,27,28,
                  30,31,35,36],
           'meg':[12,39,51,54,19,10]}
apply_ICA(subject, runlist, badEEG,badICA)      
###############################################################################  
subject = 'wl130316'
runlist = ['run1_GD','run2_GD','run3_DG','run4_DG','run5_GD']
badEEG  = ['EEG025', 'EEG035',  'EEG036', 'EEG017']
badICA  = {'eeg':[[7,11,12,1,3,4,5,6,10,13,14,15,18,20,21,22,23]],
           'meg':[[12,37,28]]}
check_ICA_Cleaning(subject, runlist, badEEG, badICA)   
badICA  = {'eeg':[7,11,12,1,3,4,5,6,10,13,14,15,18,20,21,22,23],
           'meg':[12,37,28]}
apply_ICA(subject, runlist, badEEG,badICA)  
###############################################################################
subject = 'sg120518'
runlist = ['run1_GD','run2_GD','run3_DG','run4_DG','run5_GD']
badEEG  = ['EEG002', 'EEG055']
badICA  = {'eeg':[[4,11,7],[4,11,7,1,3,5,6,9,10,16,17,18,20,21,22]],
           'meg':[[6,19,44,8,30],[6,19,44,8,30,18,13,19],
                  [6,19,44,8,30,18,13,19,45,44,43,24,30,20,33,21,32,42,40]]}
check_ICA_Cleaning(subject, runlist, badEEG, badICA)   
badICA  = {'eeg':[4,11,7,1,3,5,6,9,10,16,17,18,20,21,22],
           'meg':[6,19,44,8,30,18,13,19,45,44,43,24,30,20,33,21,32,42,40]}
apply_ICA(subject, runlist, badEEG,badICA)  
###############################################################################
subject = 'mm130405'
runlist = ['run2_GD','run3_DG']
badEEG  = ['EEG017', 'EEG025',  'EEG035']
badMEG  = ['MEG2113','MEG2342']
badICA  = {'eeg':[[7,18,16,13,0]],
           'meg':[[38,41,42,17]]}
check_ICA_Cleaning(subject, runlist, badEEG, badICA) 
badICA  = {'eeg':[7,18,16,13,0],
           'meg':[38,41,42,17]}  
apply_ICA(subject, runlist, badEEG,badICA)  
###############################################################################
subject = 'jm100109'
runlist = ['run1_GD','run2_GD','run3_DG','run4_DG','run5_GD']
badEEG  = ['EEG017', 'EEG025']
badICA  = {'eeg':[[8,12,2],[8,12,2,0,3,4,6,9,13,15,17,19]],
           'meg':[[31,42,18,6]]}
check_ICA_Cleaning(subject, runlist, badEEG, badICA) 
badICA  = {'eeg':[8,12,2,0,3,4,6,9,13,15,17,19],
           'meg':[31,42,18,6]}
apply_ICA(subject, runlist, badEEG,badICA)  
###############################################################################
subject = 'ma100253'
runlist = ['run1_GD','run2_GD','run3_DG','run4_DG','run5_GD']
badEEG  = ['EEG009', 'EEG022',  'EEG045',   'EEG046',  'EEG053', 'EEG054',  'EEG059']
badICA  = {'eeg':[[17,8,1,0,7,16,4],[17,8,1,0,7,16,4,2,3,5,6,11,14,15,18,20,23,
                  24,25,26,28,29,30,31]],
           'meg':[[6,24,44],[6,24,44,23]]}
check_ICA_Cleaning(subject, runlist, badEEG, badICA) 
badICA  = {'eeg':[17,8,1,0,7,16,4,2,3,5,6,11,14,15,18,20,23,
                  24,25,26,28,29,30,31],
           'meg':[6,24,44,23]}
apply_ICA(subject, runlist, badEEG,badICA)  



