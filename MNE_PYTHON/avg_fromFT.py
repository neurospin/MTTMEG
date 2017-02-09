# -*- coding: utf-8 -*-
"""
Created on Thu May 12 15:15:46 2016

@author: bgauthie
"""

# test read fieltrip epochs
import os
import mne

os.environ['SUBJECTS_DIR'] = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/mri';


evoked = mne.read_evokeds('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/' 
                     + 'Subjects/rl130571/MegData/ERPs_from_mne/RefPast_RefPre_RefFut_EEG.fif')
# load forward
fname_fwd = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/rl130571/mne_python/run3_ico5_eegonly_icacorr_-fwd.fif'
forward           = mne.read_forward_solution(fname_fwd ,surf_ori=True)
 
# load noise covariance matrice
fname_noisecov    = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/rl130571/'
                    + 'mne_python/COVMATS/MEEG_noisecov_QT_rl130571-cov.fif')
NOISE_COV1        = mne.read_cov(fname_noisecov)

inverse_operator1 = mne.minimum_norm.make_inverse_operator(evokedcond1.info,  forward, NOISE_COV1,  loose=0.2, depth=0.8)

snr = 3.0
lambda2 = 1.0 / snr **2
stccond1     = mne.minimum_norm.apply_inverse(evokedcond1, inverse_operator1, lambda2,method = 'dSPM', pick_ori= None)
stccond1.save('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/test.stc') 
stc_fsaverage_cond1 = mne.morph_data('rl130571', 'fsaverage', stccond1,smooth = 20)
stc_fsaverage_cond1.save('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/test_morphed.stc') 

evoked[0].data.shape

# test replace data
epo = mne.read_epochs('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/rl130571/'
                + 'mne_python/EPOCHS/MEEG_epochs_icacorr_RefFut_rl130571-epo.fif')
picks = mne.pick_types(epo.info, meg=False,  eeg=True, stim=False , eog=False)
# compute evoked
evokedcond1       = epo.average(picks = picks)                
evokedcond1.data  = evoked[0].data
evokedcond1.times = evoked[0].times




