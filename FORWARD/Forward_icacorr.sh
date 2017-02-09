#!/bin/bash

# cd /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS
# launch mne_init before the script

ListSubj=" sd130343 
           cb130477 
	   rb130313 
           jm100042 
           jm100109 
           sb120316 
           tk130502 
           lm130479 
           sg120518 
           ms130534 
           ma100253 
           sl130503 
           mb140004 
           mp140019 
           mm130405 
           dm130250 
           hr130504 
           wl130316 
           rl130571 "
arr1=($ListSubj)

export Dir=/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/

for i in {0..19}; do
	echo ${arr1[i]}

export SUBJECTS_DIR=/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/mri/
export SUBJECT=${arr1[i]}
export MEG_DIR=/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/${arr1[i]}

# for MEG
mne_check_eeg_locations --file $Dir${arr1[i]}/run3_DGICAcorr_trans_sss.fif --fix

mne_setup_source_space --ico5 –overwrite
mne_setup_forward_model --homog --surf --ico 4

mne_do_forward_solution --mindist 5 --spacing ico-5 --mricoord $Dir${arr1[i]}/run3_DGICAcorr_trans_sss.fif --meas $Dir${arr1[i]}/run3_DGICAcorr_trans_sss.fif --bem ${arr1[i]}-5120.fif --megonly --overwrite --fwd $MEG_DIR/run3_ico5_megonly_icacorr_-fwd.fif

done


