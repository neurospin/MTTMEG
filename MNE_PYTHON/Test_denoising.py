# -*- coding: utf-8 -*-
"""
Created on Fri Mar 11 10:44:48 2016

@author: bgauthie
"""


###############################################################################
def autodenoise_MEG(subject,run):
    
    ###############################################################################
    import numpy as np
    
    import mne
    import os.path as op
    import os
    import matplotlib
    matplotlib.use('Agg')
    
    from mne.report import Report
    from mne.io import Raw
    from mne.preprocessing import ICA
    from mne.preprocessing import create_ecg_epochs, create_eog_epochs

    
    data_path = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/'
    raw_fname = data_path + subject + '/' + run + '_trans_sss.fif'
    # ICA
    report    = Report(subject)
    
    raw       = Raw(raw_fname, preload=True)
    raw.filter(None, 30, n_jobs=4)
    
    picks     = mne.pick_types(raw.info, meg=True, eeg=False, eog=False,
                           stim=False, exclude='bads')
    
    ica       = ICA(n_components=0.95, method='fastica')
    ica.fit(raw, picks=picks, decim=4)
    
    # maximum number of components to reject
    n_max_ecg, n_max_eogv, n_max_eogh = 3, 3, 3  
    
    title = 'Sources related to %s artifacts (red)'
    
    # Create the results directory if it doesn't exist
    results_dir = op.join(data_path, subject,'artefactICA')
    if not op.exists(results_dir):
    	os.makedirs(results_dir)
    #ica_fname = '%s_ica' % (subject)
    
    ###############################################################################
    # generate ECG epochs use detection via phase statistics
    ecg_epochs = create_ecg_epochs(raw, tmin=-.5, tmax=.5, picks=picks)
    
    ecg_inds, scores = ica.find_bads_ecg(ecg_epochs, method='ctps')
    fig1 = ica.plot_scores(scores, exclude=ecg_inds, title=title % 'ecg', labels='ecg')
    report.add_figs_to_section(fig1, captions='ECGcomp', section='ICA') 
    
    show_picks = np.abs(scores).argsort()[::-1][:5]
    
    fig2 = ica.plot_sources(raw, show_picks, exclude=ecg_inds, title=title % 'ecg')
    report.add_figs_to_section(fig2, captions='ECGcomptime', section='ICA') 
    fig3 = ica.plot_components(ecg_inds, title=title % 'ecg', colorbar=True)
    report.add_figs_to_section(fig3, captions='ECGcomptopo', section='ICA') 
    
    ecg_inds = ecg_inds[:n_max_ecg]
    
    report.save((results_dir + '/'+  run + '.html'), open_browser=False,overwrite=True)
    ###############################################################################
    # detect vertical EOG by correlation
    
    eogv_inds = []
    eogv_inds, scores = ica.find_bads_eog(raw, ch_name = 'EOG061')
    fig4 = ica.plot_scores(scores, exclude=eogv_inds, title=title % 'eogv', labels='ecg')
    report.add_figs_to_section(fig4, captions='EOGvcomp', section='ICA') 
    
    show_picks = np.abs(scores).argsort()[::-1][:5]
    
    fig5 = ica.plot_sources(raw, show_picks, exclude=eogv_inds, title=title % 'eogv')
    report.add_figs_to_section(fig5, captions='EOGvcomptime', section='ICA') 
    fig6 = ica.plot_components(eogv_inds, title=title % 'eogv', colorbar=True)
    report.add_figs_to_section(fig6, captions='EOGvcomptopo', section='ICA') 
    
    eogv_inds = eogv_inds[:n_max_eogv]
    
    report.save((results_dir + '/'+  run + '.html'), open_browser=False,overwrite=True)
    ###############################################################################
    # detect horizontal EOG by correlation
    
    eogh_inds = []
    eogh_inds, scores = ica.find_bads_eog(raw, ch_name = 'EOG062')
    fig7 = ica.plot_scores(scores, exclude=eogh_inds, title=title % 'eogh', labels='ecg')
    report.add_figs_to_section(fig7, captions='EOGhcomp', section='ICA') 
    
    show_picks = np.abs(scores).argsort()[::-1][:5]
    
    fig8 = ica.plot_sources(raw, show_picks, exclude=eogh_inds, title=title % 'eogh')
    report.add_figs_to_section(fig8, captions='EOGhcomptime', section='ICA') 
    fig9 = ica.plot_components(eogh_inds, title=title % 'eogh', colorbar=True)
    report.add_figs_to_section(fig9, captions='EOGhcomptopo', section='ICA') 
    
    eogh_inds = eogh_inds[:n_max_eogh]
    
    report.save((results_dir + '/'+  run + '.html'), open_browser=False,overwrite=True)
    ###############################################################################
    # estimate average artifact
    ecg_evoked = ecg_epochs.average()
    fig10 = ica.plot_sources(ecg_evoked, exclude=ecg_inds)  # plot ECG sources + selection
    fig11 = ica.plot_overlay(ecg_evoked, exclude=ecg_inds)  # plot ECG cleaning
    report.add_figs_to_section(fig10, captions='ECG sources', section='ICA') 
    report.add_figs_to_section(fig11, captions='ECG clean'  , section='ICA') 
    
    eogv_evoked = create_eog_epochs(raw, tmin=-.5, ch_name = 'EOG061', tmax=.5, picks=picks).average()
    fig12 = ica.plot_sources(eogv_evoked, exclude=eogv_inds)  # plot EOG sources + selection
    fig13 = ica.plot_overlay(eogv_evoked, exclude=eogv_inds)  # plot EOG cleaning
    report.add_figs_to_section(fig12, captions='EOGv sources', section='ICA') 
    report.add_figs_to_section(fig13, captions='EOGv clean'  , section='ICA') 
    
    eogh_evoked = create_eog_epochs(raw, tmin=-.5, ch_name = 'EOG062', tmax=.5, picks=picks).average()
    fig14 = ica.plot_sources(eogh_evoked, exclude=eogh_inds)  # plot EOG sources + selection
    fig15 = ica.plot_overlay(eogh_evoked, exclude=eogh_inds)  # plot EOG cleaning
    report.add_figs_to_section(fig14, captions='EOGh sources', section='ICA') 
    report.add_figs_to_section(fig15, captions='EOGh clean'  , section='ICA') 
    
    
    # check the amplitudes do not change
    fig16 = ica.plot_overlay(raw)  # EOG artifacts remain
    report.add_figs_to_section(fig16, captions='avg'  , section='ICA') 
    
    ###############################################################################
    # Create the results directory if it doesn't exist
    ica_dir = op.join(data_path, subject,'mne_python/ICA')
    if not op.exists(ica_dir):
    	os.makedirs(ica_dir)
    
    # mark bad components and save ica
    artifact_inds = list(np.unique(eogv_inds + eogh_inds + ecg_inds))
    ica.exclude = []
    ica.exclude = artifact_inds
    ica.save((ica_dir +'/ICA_MEG' + run))
 
    #return ica, artifact_inds   
###############################################################################
###############################################################################































