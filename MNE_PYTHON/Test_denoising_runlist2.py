# -*- coding: utf-8 -*-
"""
Created on Wed Mar 16 16:48:47 2016

@author: bgauthie
"""

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
def ICA_denoising_full(subject,runlist,badEEG):
    
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
    ica_reject = {'mag': 5e-12, 'grad': 5000e-13, 'eeg': 500e-6}
    
    ###########################################################################
    data_path = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/'
    raw_fnames = []
    for run in runlist:
        raw_fnames.append(data_path + subject + '/' + run + '_trans_sss.fif')
    report    = Report(subject)
    # read raw data
    raw       = Raw(raw_fnames, preload=True)
    raw.info['bads'] = badEEG 
    # Highpass filter 1Hz on EOG/ECG channels
    picks =  mne.pick_types(raw.info, meg=False,eeg=False, eog=False, ecg=True)
    raw.filter(l_freq = 1, h_freq=30, picks = picks)
    picks =  mne.pick_types(raw.info, meg=False,eeg=False, eog=True, ecg=False)
    raw.filter(l_freq = 1, h_freq=2, picks = picks)
    picks =  mne.pick_types(raw.info, meg=True,eeg=True, eog=True, ecg=True)
    raw.filter(l_freq = None, h_freq=30, picks = picks,n_jobs = 4)
    
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
         print'loul'
         ica, _ = compute_ica(
	   raw, picks=picks, subject=subject, n_components=n_components,
    	   n_max_ecg=n_max_ecg, n_max_eog=n_max_eog, reject=ica_reject,
    	   random_state=666,decim=decim, report=report)
        
         # when pb with eeg
         #ica = ICA(n_components=0.99, method='fastica')
         #ica.fit(raw, picks=picks, decim=5, reject=dict(eeg=300e-6))
         ica.save((ica_dir +'/ICA_' + ch_type + '_allRuns'))    
    
    report.save((results_dir + '/AllRuns.html'), open_browser=False,overwrite=True)
    del raw
###############################################################################
###############################################################################
###############################################################################
ICA_denoising_full('sd130343',
                   ['run1_GD', 'run2_GD', 'run3_DG', 'run4_DG', 'run5_GD'],
                   ['EEG025', 'EEG036', 'EEG064'])  
ICA_denoising_full('cb130477',
                   ['run1_GD', 'run2_GD', 'run3_DG', 'run4_DG', 'run5_GD'],
                   ['EEG035', 'EEG036', 'EEG064'])
ICA_denoising_full('rb130313',
                   ['run1_GD','run2_GD','run3_DG','run4_DG'],
                   ['EEG025', 'EEG035',  'EEG036'])
ICA_denoising_full('jm100042',
                   ['run1_GD','run2_GD','run3_DG','run4_DG'],
                   ['EEG035'])
ICA_denoising_full('sb120316',
                   ['run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'],
                   ['EEG026', 'EEG036'])                  
ICA_denoising_full('tk130502',
                   ['run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'],
                   ['EEG035'])
ICA_denoising_full('lm130479',
                   ['run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'],
                   ['EEG025', 'EEG035', 'EEG036' ,'EEG037'])
ICA_denoising_full('ms130534',
                   ['run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'],
                   ['EEG025', 'EEG035'])
ICA_denoising_full('ma100253',
                   ['run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'],
                   ['EEG009', 'EEG022',  'EEG045',   'EEG046',  'EEG053', 'EEG054',  'EEG059'])
ICA_denoising_full('sl130503',
                   ['run1_GD','run2_GD','run3_DG','run4_DG'],
                   ['EEG035', 'EEG057'])
ICA_denoising_full('mb140004',
                   ['run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'],
                   ['EEG043'])
ICA_denoising_full('mp140019',
                   ['run1_GD','run2_GD','run3_DG','run4_DG'],
                   ['EEG035'])
ICA_denoising_full('dm130250',
                   ['run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'],
                   ['EEG025', 'EEG035'])
ICA_denoising_full('hr130504',
                   ['run1_GD','run2_GD','run3_DG','run4_DG'],
                   ['EEG025', 'EEG035'])
ICA_denoising_full('wl130316',
                   ['run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'],
                   ['EEG025', 'EEG035',  'EEG036', 'EEG017'])
ICA_denoising_full('rl130571',
                   ['run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'],
                    ['EEG017', 'EEG025', 'EEG036', 'EEG026', 'EEG034'])
ICA_denoising_full('mm130405',
                   ['run2_GD','run3_DG'],
                   ['EEG017', 'EEG025',  'EEG035'])
ICA_denoising_full('sg120518',
                   ['run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'],
                    ['EEG002', 'EEG055'])
ICA_denoising_full('jm100109',
                   ['run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'],
                   ['EEG017', 'EEG025'])






