# -*- coding: utf-8 -*-
"""
Created on Wed Mar 16 17:49:57 2016

@author: bgauthie
"""

# -*- coding: utf-8 -*-
"""
Created on Tue Mar 15 18:05:35 2016

@author: bgauthie
"""

###############################################################################
def browse_components(subject, runlist, badEEG):
  
    import numpy as np
    import mne
    import os.path as op
    import os
    from mne.report import Report
    from mne.io.pick import _picks_by_type as picks_by_type
    from mne.preprocessing import read_ica
    from mne.io import Raw  
    
    
    data_path = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/'      
    report    = Report(subject)
    
    raw_fnames = []
    for run in runlist:
        raw_fnames.append(data_path + subject + '/' + run + '_trans_sss.fif')
    # read raw data
    raw       = Raw(raw_fnames, preload=True)
    raw.info['bads'] = badEEG 
    # Highpass filter 1Hz on EOG/ECG channels
    #picks =  mne.pick_types(raw.info, meg=False,eeg=False, eog=True, ecg=True)
    #raw.filter(l_freq = 1, h_freq=30, picks = picks)
    #picks =  mne.pick_types(raw.info, meg=True,eeg=True, eog=True, ecg=True)
    #raw.filter(l_freq = None, h_freq=30, picks = picks,n_jobs = 4)
    picks =  mne.pick_types(raw.info, meg=False,eeg=False, eog=False, ecg=True)
    raw.filter(l_freq = 1, h_freq=30, picks = picks)
    picks =  mne.pick_types(raw.info, meg=False,eeg=False, eog=True, ecg=False)
    raw.filter(l_freq = 1, h_freq=5, picks = picks)
    picks =  mne.pick_types(raw.info, meg=True,eeg=True, eog=True, ecg=True)
    raw.filter(l_freq = None, h_freq=30, picks = picks,n_jobs = 4)
    
    results_dir = op.join(data_path, subject,'artefactICA')
    if not op.exists(results_dir):
    	os.makedirs(results_dir)    
    
    # Plot all ICA component
    for ch_type, picks in picks_by_type(raw.info, meg_combined=True): # bad EEG channels are excluded
        # Read ICA file for each data type (MEG and EEG) - created in preprocessing_ica
        ica = read_ica(data_path + subject + '/mne_python/ICA/ICA_' + ch_type + '_allRuns' )
        
        print subject + ' ' + ch_type
        #fig = ica.plot_sources(raw, block = True) # the viewer will open and ICA component can be screened
        #report.add_figs_to_section(fig, 'All ICA sources (%s)' % ch_type,'ICA decomposition')
        fig = ica.plot_components(colorbar=True)
        for i in range(np.shape(fig)[0]):
            report.add_figs_to_section(fig[i], 'All ICA components (%s)' % ch_type,'ICA decomposition')   
        
    report.save((results_dir + '/AllRuns_checkcomponents.html'), open_browser=False,overwrite=True)
    del raw

###############################################################################  
browse_components('jm100042',['run1_GD','run2_GD','run3_DG','run4_DG'],
                   ['EEG035'])
browse_components('sb120316',
                   ['run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'],
                   ['EEG026', 'EEG036'])                  
browse_components('tk130502',
                   ['run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'],
                   ['EEG035'])
browse_components('lm130479',
                   ['run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'],
                   ['EEG025', 'EEG035', 'EEG036' ,'EEG037'])
browse_components('ms130534',
                   ['run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'],
                   ['EEG025', 'EEG035'])
browse_components('ma100253',
                   ['run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'],
                   ['EEG009', 'EEG022',  'EEG045',   'EEG046',  'EEG053', 'EEG054',  'EEG059'])
browse_components('sl130503',
                   ['run1_GD','run2_GD','run3_DG','run4_DG'],
                   ['EEG035', 'EEG057'])
browse_components('mb140004',
                   ['run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'],
                   ['EEG043'])

browse_components('mp140019',
                   ['run1_GD','run2_GD','run3_DG','run4_DG'],
                   ['EEG035'])
browse_components('dm130250',
                   ['run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'],
                   ['EEG025', 'EEG035'])
browse_components('hr130504',
                   ['run1_GD','run2_GD','run3_DG','run4_DG'],
                   ['EEG025', 'EEG035'])
browse_components('wl130316',
                   ['run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'],
                   ['EEG025', 'EEG035',  'EEG036', 'EEG017'])
browse_components('rl130571',
                   ['run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'],
                    ['EEG017', 'EEG025', 'EEG036', 'EEG026', 'EEG034'])
browse_components('sg120518',
                   ['run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'],
                    ['EEG002', 'EEG055'])
browse_components('mm130405',
                   ['run2_GD','run3_DG'],
                   ['EEG017', 'EEG025',  'EEG035'])
browse_components('ma100253',
                   ['run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'],
                   ['EEG009', 'EEG022',  'EEG045',   'EEG046',  'EEG053', 'EEG054',  'EEG059'])
browse_components('jm100109',
                   ['run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'],
                   ['EEG017', 'EEG025'])


  
    
    
    
    
    