# -*- coding: utf-8 -*-
"""
Created on Tue Mar 15 10:06:27 2016

@author: bgauthie
inspired from https://github.com/dengemann/meeg-preprocessing/blob/master/examples/config.py
"""

###############################################################################
# jobs and runtime performance
n_jobs = 4
# Filters
filter_params = [dict(l_freq=1.0, h_freq=100, n_jobs=n_jobs, method='fft',
                      l_trans_bandwidth=0.1, h_trans_bandwidth=0.5)]
notch_filter_params = dict(freqs=(50, 100, 150,))
# margins for the PSD plot
plot_fmin = 0.0
plot_fmax = 120.0
# ICA
n_components = 0.99
# comment out to select ICA components via rank (useful with SSSed data):
# n_components = 'rank'
ica_meg_combined = True  # esimtate combined MAG and GRADs
decim = 5  # decimation
n_max_ecg, n_max_eog = 3, 2  # limit components detected due to ECG / EOG
ica_reject = {'mag': 5e-12, 'grad': 5000e-13, 'eeg': 300e-6}
# Report
img_scale = 1.5  # make big PNG images

###############################################################################
import os
import matplotlib
import mne
import os.path as op

from mne.io.pick import _picks_by_type as picks_by_type
from meeg_preprocessing import compute_ica
from mne.preprocessing import read_ica
from meeg_preprocessing.utils import setup_provenance
from meeg_preprocessing.viz import plot_psd_ica_overlay











