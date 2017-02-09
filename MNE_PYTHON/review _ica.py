# -*- coding: utf-8 -*-
"""
Created on Tue Mar 15 18:05:35 2016

@author: bgauthie
"""

###############################################################################
def browse_components(subject, run, badEEG):
  
    import numpy as np
    import mne
    import os.path as op
    import os
    from mne.report import Report
    from mne.io.pick import _picks_by_type as picks_by_type
    from mne.preprocessing import read_ica
    from mne.io import Raw  
    
    
    data_path = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/'      
    raw_fname = data_path + subject + '/' + run + '_trans_sss.fif'
    report    = Report(subject)
    
    # read raw data
    raw       = Raw(raw_fname, preload=True)    
    picks =  mne.pick_types(raw.info, meg=False,eeg=False, eog=True, ecg=True)
    raw.filter(l_freq = 1, h_freq=30, picks = picks)
    picks =  mne.pick_types(raw.info, meg=True,eeg=True, eog=True, ecg=True)
    raw.filter(l_freq = None, h_freq=30, picks = picks)    
    # Mark EEG bad channels
    raw.info['bads'] = badEEG
    
    results_dir = op.join(data_path, subject,'artefactICA')
    if not op.exists(results_dir):
    	os.makedirs(results_dir)    
    
    # Plot all ICA component
    for ch_type, picks in picks_by_type(raw.info, meg_combined=True): # bad EEG channels are excluded
        # Read ICA file for each data type (MEG and EEG) - created in preprocessing_ica
        ica = read_ica(data_path + subject + '/mne_python/ICA/ICA_'+ ch_type 
                       + '_run1_GD' )
        
        print subject + ' ' + ch_type
        #fig = ica.plot_sources(raw, block = True) # the viewer will open and ICA component can be screened
        #report.add_figs_to_section(fig, 'All ICA sources (%s)' % ch_type,'ICA decomposition')
        fig = ica.plot_components(colorbar=True)
        for i in range(np.shape(fig)[0]):
            report.add_figs_to_section(fig[i], 'All ICA components (%s)' % ch_type,'ICA decomposition')   
        
    report.save((results_dir + '/TOPO_ICA'+  run + '.html'), open_browser=False,overwrite=True)

###############################################################################
browse_components('sd130343','run2_GD',['EEG025', 'EEG036', 'EEG064','EEG058'])
  










  
    
    
    
    
    