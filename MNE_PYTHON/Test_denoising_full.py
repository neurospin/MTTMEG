# -*- coding: utf-8 -*-
"""
Created on Fri Mar 11 17:55:34 2016

@author: bgauthie
"""

# -*- coding: utf-8 -*-
"""
Created on Fri Mar 11 10:44:48 2016

@author: bgauthie
"""

###############################################################################
import mne
import os.path as op
import os
import numpy as np

from mne.report import Report
from mne.io import Raw
from mne.preprocessing import ICA

###############################################################################
def plotICA_comp(subject,run):
    
    # subject parameters
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
    
    # Create the results directory if it doesn't exist
    results_dir = op.join(data_path, subject,'artefactICA')
    if not op.exists(results_dir):
    	os.makedirs(results_dir)

    report    = Report(subject)     
    fig       = ica.plot_components(title= 'ICA comp', colorbar=True)
    for i in range(np.shape(fig)[0]):
        report.add_figs_to_section(fig[i], captions='ICA comp', section='ICA_allcomp') 
    report.save((results_dir + '/'+  run + '_allcomp.html'), open_browser=False,overwrite=True)

###############################################################################
###############################################################################
plotICA_comp('sd130343','run1_GD')
plotICA_comp('sd130343','run2_GD')
plotICA_comp('sd130343','run3_DG')
plotICA_comp('sd130343','run4_DG')
plotICA_comp('sd130343','run5_GD')








