# -*- coding: utf-8 -*-
"""
Created on Mon Mar 14 17:33:00 2016

@author: bgauthie
"""

# -*- coding: utf-8 -*-
"""
Created on Fri Mar 11 10:44:48 2016

@author: bgauthie
"""

###############################################################################
def ICA_denoising(subject,run,badEEG):
    
    import mne
    import os.path as op
    import os
    import matplotlib
    matplotlib.use('Agg')
    
    from mne.report import Report
    from mne.io import Raw
    from meeg_preprocessing import compute_ica
    from mne.io.pick import _picks_by_type as picks_by_type
    
    ###########################################################################
    # jobs and runtime performance
    n_components = 0.99
    decim = 5  # decimation
    n_max_ecg, n_max_eog = 5, 5  # limit components detected due to ECG / EOG
    ica_reject = {'mag': 5e-12, 'grad': 5000e-13, 'eeg': 200e-6}
    
    ###########################################################################
    data_path = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/'
    raw_fname = data_path + subject + '/' + run + '_trans_sss.fif'
    report    = Report(subject)
    # read raw data
    raw       = Raw(raw_fname, preload=True)
    raw.info['bads'] = badEEG 
    # Highpass filter 1Hz on EOG/ECG channels
    picks =  mne.pick_types(raw.info, meg=False,eeg=False, eog=True, ecg=True)
    raw.filter(l_freq = 1, h_freq=30, picks = picks)
    picks =  mne.pick_types(raw.info, meg=True,eeg=True, eog=True, ecg=True)
    raw.filter(l_freq = None, h_freq=30, picks = picks)
    
    ###########################################################################
    # Create the report directory if it doesn't exist
    results_dir = op.join(data_path, subject,'artefactICA')
    if not op.exists(results_dir):
    	os.makedirs(results_dir)
     
    # Create the results directory if it doesn't exist
    ica_dir = op.join(data_path, subject,'mne_python/ICA')
    if not op.exists(ica_dir):
    	os.makedirs(ica_dir)
    
    report = mne.report.Report(subject)    
    
    ###########################################################################        
    for ch_type, picks in picks_by_type(raw.info, meg_combined=True): # bad EEG channels are excluded
        ica, _ = compute_ica(
	   raw, picks=picks, subject=subject, n_components=n_components,
    	   n_max_ecg=n_max_ecg, n_max_eog=n_max_eog, reject=ica_reject,
    	   random_state=666,decim=decim, report=report)
        
        ica.save((ica_dir +'/ICA_' + ch_type + '_' + run))    
    
    report.save((results_dir + '/'+  run + '.html'), open_browser=False,overwrite=True)
    del raw
###############################################################################
###############################################################################
###############################################################################
ICA_denoising('sd130343','run1_GD',['EEG025', 'EEG036', 'EEG064','EEG058'])  
ICA_denoising('sd130343','run2_GD',['EEG025', 'EEG036', 'EEG064','EEG058'])  
ICA_denoising('sd130343','run3_DG',['EEG025', 'EEG036', 'EEG064','EEG058'])  
ICA_denoising('sd130343','run4_DG',['EEG025', 'EEG036', 'EEG064','EEG058'])  
ICA_denoising('sd130343','run5_GD',['EEG025', 'EEG036', 'EEG064','EEG058'])  






















