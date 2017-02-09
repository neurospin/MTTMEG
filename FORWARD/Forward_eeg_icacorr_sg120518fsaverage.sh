#!/bin/bash

# cd /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS
# launch mne_init before the script


export Dir=/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/

export SUBJECTS_DIR=/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/mri/
export SUBJECT=sg120518
export MEG_DIR=/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sg120518

# for EEG
#mne_rename_channels --fif $Dir${arr1[i]}/mne_python/preproc_run3_DG_trans_sss_raw.fif --alias /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS/define_aliases.txt

mne_setup_source_space --ico5 --overwrite
# the --innershift -5 was used to compensate for a bug with inner skull position, to be removed in general case
mne_setup_forward_model --surf --ico 4 --innershift -1

#mne_check_eeg_locations --file $Dir${arr1[i]}/mne_python/preproc_run3_DG_trans_sss_raw.fif --fix
mne_check_eeg_locations --file /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sg120518/run3_DGICAcorr_trans_sss.fif --fix --dig /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/run3_DGICAcorr_trans_sss.fif

mne_do_forward_solution --mindist 5 --spacing ico-5 --mricoord /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sg120518/raw_sss/run3_DG_trans_sss-trans.fif --meas /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sg120518/run3_DGICAcorr_trans_sss.fif --bem sg120518-5120-5120-5120-bem.fif --overwrite --fwd $MEG_DIR/run3_ico5_meeg_icacorr_-fwd.fif

mne_do_forward_solution --mindist 5 --spacing ico-5 --mricoord /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sg120518/raw_sss/run3_DG_trans_sss-trans.fif --meas /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sg120518/run3_DGICAcorr_trans_sss.fif --bem sg120518-5120-5120-5120-bem.fif --eegonly --overwrite --fwd $MEG_DIR/run3_ico5_eegonly_icacorr_-fwd.fif


