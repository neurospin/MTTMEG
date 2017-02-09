#!/bin/bash

# cd /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS
# launch mne_init before the script

ListSubj=" sd130343 sd130343 sd130343 sd130343 sd130343
           cb130477 cb130477 cb130477 cb130477 cb130477
	   rb130313 rb130313 rb130313
           jm100042 jm100042 jm100042 jm100042
           jm100109 jm100109 jm100109 jm100109 jm100109
           sb120316 sb120316 sb120316 sb120316 sb120316
           tk130502 tk130502 tk130502 tk130502 tk130502
           lm130479 lm130479 lm130479 lm130479 lm130479
           sg120518 sg120518 sg120518 sg120518 sg120518
           ms130534 ms130534 ms130534 ms130534 ms130534
           ma100253 ma100253 ma100253 ma100253 ma100253
           sl130503 sl130503 sl130503 sl130503
           mb140004 mb140004 mb140004 mb140004 mb140004
           mp140019 mp140019 mp140019 mp140019 
           mm130405 mm130405 mm130405 mm130405
           dm130250 dm130250 dm130250 dm130250 dm130250
           hr130504 hr130504 hr130504 hr130504
           wl130316 wl130316 wl130316 wl130316 wl130316
           rl130571 rl130571 rl130571 rl130571 rl130571 "

arr1=($ListSubj)
listRunPerSubj=" run1_GD run2_GD run3_DG run4_DG run5_GD 
                 run1_GD run2_GD run3_DG run4_DG run5_GD 
                 run1_GD run3_DG run4_DG 
                 run1_GD run2_GD run3_DG run4_DG 
                 run1_GD run2_GD run3_DG run4_DG run5_GD 
                 run1_GD run2_GD run3_DG run4_DG run5_GD 
                 run1_GD run2_GD run3_DG run4_DG run5_GD 
                 run1_GD run2_GD run3_DG run4_DG run5_GD 
                 run1_GD run2_GD run3_DG run4_DG run5_GD 
                 run1_GD run2_GD run3_DG run4_DG run5_GD 
                 run1_GD run2_GD run3_DG run4_DG run5_GD 
                 run1_GD run2_GD run3_DG run4_DG 
                 run1_GD run2_GD run3_DG run4_DG run5_GD 
                 run1_GD run2_GD run3_DG run4_DG 
                 run1_GD run2_GD run3_DG run4_DG 
                 run1_GD run2_GD run3_DG run4_DG run5_GD 
                 run1_GD run2_GD run3_DG run4_DG 
                 run1_GD run2_GD run3_DG run4_DG run5_GD 
                 run1_GD run2_GD run3_DG run4_DG run5_GD "
arr2=($listRunPerSubj)

Dir=/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/

for i in {0..87}; do
	echo ${arr1[i]}
	echo ${arr2[i]}

mne_process_raw --raw $Dir${arr1[i]}/raw_sss/${arr2[i]}_trans_sss.fif --lowpass 40 --save $Dir${arr1[i]}/mne_python/preproc_${arr2[i]}_trans_sss.fif --projon --proj $Dir${arr1[i]}/raw_sss/ecg_eogv/PCA_MEG_ECG_GRADS.fif --proj $Dir${arr1[i]}/raw_sss/ecg_eogv/PCA_MEG_ECG_MAGS.fif --proj $Dir${arr1[i]}/raw_sss/ecg_eogv/PCA_MEG_EOG61_GRADS.fif --proj /$Dir${arr1[i]}/raw_sss/ecg_eogv/PCA_MEG_EOG61_MAGS.fif --proj $Dir${arr1[i]}/raw_sss/ecg_eogv/PCA_EEG_EOG61.fif --proj $Dir${arr1[i]}/raw_sss/ecg_eogv/PCA_EEG_ECG.fif

done

