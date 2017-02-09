# -*- coding: utf-8 -*-

############################ preprocessing ###############################################
mne_init

mne_process_raw --raw /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/raw_sss/run1_GD_trans_sss.fif --lowpass 40 --save /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/mne_python/preproc_run1_GD_trans_sss.fif --projon --proj /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/raw_sss/PCA_MEG_ECG_GRADS.fif --proj /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/raw_sss/PCA_MEG_ECG_MAGS.fif --proj /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/raw_sss/PCA_MEG_EOG61_GRADS.fif --proj /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/raw_sss/PCA_MEG_EOG61_MAGS.fif --proj /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/raw_sss/PCA_EEG_EOG61.fif --proj /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/raw_sss/PCA_EEG_ECG.fif

mne_process_raw --raw /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/raw_sss/run2_GD_trans_sss.fif --lowpass 40 --save /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/mne_python/preproc_run2_GD_trans_sss.fif --projon --proj /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/raw_sss/PCA_MEG_ECG_GRADS.fif --proj /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/raw_sss/PCA_MEG_ECG_MAGS.fif --proj /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/raw_sss/PCA_MEG_EOG61_GRADS.fif --proj /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/raw_sss/PCA_MEG_EOG61_MAGS.fif --proj /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/raw_sss/PCA_EEG_EOG61.fif --proj /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/raw_sss/PCA_EEG_ECG.fif

mne_process_raw --raw /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/raw_sss/run3_DG_trans_sss.fif --lowpass 40 --save /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/mne_python/preproc_run3_DG_trans_sss.fif --projon --proj /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/raw_sss/PCA_MEG_ECG_GRADS.fif --proj /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/raw_sss/PCA_MEG_ECG_MAGS.fif --proj /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/raw_sss/PCA_MEG_EOG61_GRADS.fif --proj /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/raw_sss/PCA_MEG_EOG61_MAGS.fif --proj /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/raw_sss/PCA_EEG_EOG61.fif --proj /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/raw_sss/PCA_EEG_ECG.fif

mne_process_raw --raw /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/raw_sss/run4_DG_trans_sss.fif --lowpass 40 --save /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/mne_python/preproc_run4_DG_trans_sss.fif --projon --proj /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/raw_sss/PCA_MEG_ECG_GRADS.fif --proj /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/raw_sss/PCA_MEG_ECG_MAGS.fif --proj /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/raw_sss/PCA_MEG_EOG61_GRADS.fif --proj /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/raw_sss/PCA_MEG_EOG61_MAGS.fif --proj /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/raw_sss/PCA_EEG_EOG61.fif --proj /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/raw_sss/PCA_EEG_ECG.fif

mne_process_raw --raw /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/raw_sss/run5_GD_trans_sss.fif --lowpass 40 --save /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/mne_python/preproc_run5_GD_trans_sss.fif --projon --proj /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/raw_sss/PCA_MEG_ECG_GRADS.fif --proj /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/raw_sss/PCA_MEG_ECG_MAGS.fif --proj /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/raw_sss/PCA_MEG_EOG61_GRADS.fif --proj /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/raw_sss/PCA_MEG_EOG61_MAGS.fif --proj /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/raw_sss/PCA_EEG_EOG61.fif --proj /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/raw_sss/PCA_EEG_ECG.fif

############################ MRILAB Coregistration #####################################
#Create COR.fif file
mne_init 

export SUBJECTS_DIR=/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/mri/
export SUBJECT=sd130343
export MEG_DIR=/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/mne_python/
mne_setup_mri -- sd130343

cd /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG 
mrilab

############################ MNE iterative procedure ###################################
mne_init 

export SUBJECTS_DIR=/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/mri/
export SUBJECT=sd130343
export MEG_DIR=/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/mne_python/
mne_setup_mri -- sd130343

mne_analyze

############################ compute fwd ###############################################
mne_init 

export SUBJECTS_DIR=/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/mri/
export SUBJECT=sd130343
export MEG_DIR=/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343

mne_setup_source_space --ico 5 –overwrite
mne_setup_forward_model --homog --surf --ico 4

mne_do_forward_solution --mindist 5 --spacing ico-5 --mricoord /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/raw_sss/run1_GD_trans_sss-trans.fif --meas /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/raw_sss/run1_GD_trans_sss.fif --bem sd130343-5120.fif --megonly --overwrite --fwd /neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/mne_python/sd130343_run1_ico-5-fwd.fif

############################ compute inv - evtFARq1 &  evtFARq1 ###############################################
# set fonctions #
ipython --pylab
import mne
import numpy as np
from scipy import io
from matplotlib import pyplot as plt
from matplotlib import image as mpimg
from mne.fiff import Raw
from mne.minimum_norm import apply_inverse, make_inverse_operator
from copy import deepcopy
import os
os.chdir('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS/MNE_PYTHON')
import MatchEventsFT2MNE as match

# load trans_sss data #
raw1 = Raw("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/mne_python/preproc_run1_GD_trans_sss_raw.fif")
raw2 = Raw("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/mne_python/preproc_run2_GD_trans_sss_raw.fif")
raw3 = Raw("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/mne_python/preproc_run3_DG_trans_sss_raw.fif")
raw4 = Raw("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/mne_python/preproc_run4_DG_trans_sss_raw.fif")
raw5 = Raw("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/mne_python/preproc_run5_GD_trans_sss_raw.fif")

# define events #
fileE1 = io.loadmat("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/sd130343/PsychData/events1.mat")
fileE2 = io.loadmat("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/sd130343/PsychData/events2.mat")
fileE3 = io.loadmat("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/sd130343/PsychData/events3.mat")
fileE4 = io.loadmat("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/sd130343/PsychData/events4.mat")
fileE5 = io.loadmat("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/sd130343/PsychData/events5.mat")
eventsFT1 = fileE1['fullsubj'];
eventsFT2 = fileE2['fullsubj'];
eventsFT3 = fileE3['fullsubj'];
eventsFT4 = fileE4['fullsubj'];
eventsFT5 = fileE5['fullsubj'];
eventsMNE1 = mne.find_events(raw1, stim_channel=['STI101'],consecutive = False)
eventsMNE2 = mne.find_events(raw2, stim_channel=['STI101'],consecutive = False)
eventsMNE3 = mne.find_events(raw3, stim_channel=['STI101'],consecutive = False)
eventsMNE4 = mne.find_events(raw4, stim_channel=['STI101'],consecutive = False)
eventsMNE5 = mne.find_events(raw5, stim_channel=['STI101'],consecutive = False)
print "%d events found" %len(eventsMNE1)
print "%d events found" %len(eventsMNE2)
print "%d events found" %len(eventsMNE3)
print "%d events found" %len(eventsMNE4)
print "%d events found" %len(eventsMNE5)

# find events corresponding to FT run 1
itemindex1  = np.where(eventsFT1[:,7]==1)
eventsFT1   = eventsFT1[itemindex1[0],:]
# find events corresponding to FT run 2
itemindex2  = np.where(eventsFT2[:,7]==2)
eventsFT2   = eventsFT2[itemindex2[0],:]
# find events corresponding to FT run 3
itemindex3  = np.where(eventsFT3[:,7]==3)
eventsFT3   = eventsFT3[itemindex3[0],:]
# find events corresponding to FT run 4
itemindex4  = np.where(eventsFT4[:,7]==4)
eventsFT4   = eventsFT4[itemindex4[0],:]
# find events corresponding to FT run 5
itemindex5  = np.where(eventsFT5[:,7]==5)
eventsFT5   = eventsFT5[itemindex5[0],:]

# find events corresponding to "Historical events" stimuli
init1       = np.where(eventsFT1[:,6]== 16)
for i in range(17,36):
	init1  = np.append(init1,np.where(eventsFT1[:,6]== i)[0]) 

# find events corresponding to "Historical events" stimuli
init2       = np.where(eventsFT2[:,6]== 16)
for i in range(17,36):
	init2  = np.append(init2,np.where(eventsFT2[:,6]== i)[0]) 

# find events corresponding to "Historical events" stimuli
init3       = np.where(eventsFT3[:,6]== 16)
for i in range(17,36):
	init3  = np.append(init3,np.where(eventsFT3[:,6]== i)[0]) 

# find events corresponding to "Historical events" stimuli
init4       = np.where(eventsFT4[:,6]== 16)
for i in range(17,36):
	init4  = np.append(init4,np.where(eventsFT4[:,6]== i)[0]) 

# find events corresponding to "Historical events" stimuli
init5       = np.where(eventsFT5[:,6]== 16)
for i in range(17,36):
	init5  = np.append(init5,np.where(eventsFT5[:,6]== i)[0]) 

eventsFT1   = eventsFT1[init1,:]
eventsFT2   = eventsFT2[init2,:]
eventsFT3   = eventsFT3[init3,:]
eventsFT4   = eventsFT4[init4,:]
eventsFT5   = eventsFT5[init5,:]


# reject bad data base on fiedltrip "ft_rejectvisual"
good1      = np.where(eventsFT1[:,8]== 1)
good2      = np.where(eventsFT2[:,8]== 1)
good3      = np.where(eventsFT3[:,8]== 1)
good4      = np.where(eventsFT4[:,8]== 1)
good5      = np.where(eventsFT5[:,8]== 1)
eventsFT1  = eventsFT1[good1[0],:]
eventsFT2  = eventsFT2[good2[0],:]
eventsFT3  = eventsFT3[good3[0],:]
eventsFT4  = eventsFT4[good4[0],:]
eventsFT5  = eventsFT5[good5[0],:]

# set the "zero point" to the first event
initsamp1 = eventsMNE1[0,0]
initsamp2 = eventsMNE2[0,0]
initsamp3 = eventsMNE3[0,0]
initsamp4 = eventsMNE4[0,0]
initsamp5 = eventsMNE5[0,0]
for k in range(eventsMNE1.shape[0]):
	eventsMNE1[k,0] = eventsMNE1[k,0] - initsamp1

for k in range(eventsMNE2.shape[0]):
	eventsMNE2[k,0] = eventsMNE2[k,0] - initsamp2

for k in range(eventsMNE3.shape[0]):
	eventsMNE3[k,0] = eventsMNE3[k,0] - initsamp3

for k in range(eventsMNE4.shape[0]):
	eventsMNE4[k,0] = eventsMNE4[k,0] - initsamp4

for k in range(eventsMNE5.shape[0]):
	eventsMNE5[k,0] = eventsMNE5[k,0] - initsamp5

# get the FT event in MNE events (should be the same but a small sample of events isn't matched
# I need to check that soon
SelEve1 = match.MatchEventsFT2MNE(eventsMNE1,eventsFT1)
SelEve2 = match.MatchEventsFT2MNE(eventsMNE2,eventsFT2)
SelEve3 = match.MatchEventsFT2MNE(eventsMNE3,eventsFT3)
SelEve4 = match.MatchEventsFT2MNE(eventsMNE4,eventsFT4)
SelEve5 = match.MatchEventsFT2MNE(eventsMNE5,eventsFT5)

# get back to the original timing
for k in range(SelEve1.shape[0]):
	SelEve1[k,0] = SelEve1[k,0] + initsamp1

for k in range(SelEve2.shape[0]):
	SelEve2[k,0] = SelEve2[k,0] + initsamp2

for k in range(SelEve3.shape[0]):
	SelEve3[k,0] = SelEve3[k,0] + initsamp3

for k in range(SelEve4.shape[0]):
	SelEve4[k,0] = SelEve4[k,0] + initsamp4

for k in range(SelEve5.shape[0]):
	SelEve5[k,0] = SelEve5[k,0] + initsamp5


# correct for photodelay
for i in range(SelEve1.shape[0]):
	SelEve1[i,0] = SelEve1[i,0] + 60;

for i in range(SelEve2.shape[0]):
	SelEve2[i,0] = SelEve2[i,0] + 60;

for i in range(SelEve3.shape[0]):
	SelEve3[i,0] = SelEve3[i,0] + 60;

for i in range(SelEve4.shape[0]):
	SelEve4[i,0] = SelEve4[i,0] + 60;

for i in range(SelEve5.shape[0]):
	SelEve5[i,0] = SelEve5[i,0] + 60;

etDtq1G_QRT2 = io.loadmat("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/event_def_for_mne/EtDtq1G_QRT2.mat")
etDtq2G_QRT2 = io.loadmat("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/event_def_for_mne/EtDtq2G_QRT2.mat")
etDtq1G_QRT2 = etDtq1G_QRT2['cond']
etDtq2G_QRT2 = etDtq2G_QRT2['cond']

# process cond1
event_id, tmin, tmax = etDtq1G_QRT2[:,0].tolist(), -0.2,1.1 

# epoched data
picks1  = mne.fiff.pick_types(raw1.info, meg=True, eeg=False, stim=False, eog=False, include=[], exclude=[])
picks2  = mne.fiff.pick_types(raw2.info, meg=True, eeg=False, stim=False, eog=False, include=[], exclude=[])
picks3  = mne.fiff.pick_types(raw3.info, meg=True, eeg=False, stim=False, eog=False, include=[], exclude=[])
picks4  = mne.fiff.pick_types(raw4.info, meg=True, eeg=False, stim=False, eog=False, include=[], exclude=[])
picks5  = mne.fiff.pick_types(raw5.info, meg=True, eeg=False, stim=False, eog=False, include=[], exclude=[])
epochs1 = mne.Epochs(raw1, SelEve1, event_id, tmin, tmax, baseline=(-0.2, 0),picks = picks1,preload = True,reject = None,on_missing = 'warning')
epochs2 = mne.Epochs(raw2, SelEve2, event_id, tmin, tmax, baseline=(-0.2, 0),picks = picks2,preload = True,reject = None,on_missing = 'warning')
epochs3 = mne.Epochs(raw3, SelEve3, event_id, tmin, tmax, baseline=(-0.2, 0),picks = picks3,preload = True,reject = None,on_missing = 'warning')
epochs4 = mne.Epochs(raw4, SelEve4, event_id, tmin, tmax, baseline=(-0.2, 0),picks = picks4,preload = True,reject = None,on_missing = 'warning')
epochs5 = mne.Epochs(raw5, SelEve5, event_id, tmin, tmax, baseline=(-0.2, 0),picks = picks5,preload = True,reject = None,on_missing = 'warning')

# append subject's runs 
epochs_tot = deepcopy(epochs1)
epochs_tot._data  = np.vstack((epochs1._data,epochs2._data,epochs3._data,epochs4._data,epochs5._data))
epochs_tot.events = np.vstack((epochs1.events,epochs2.events,epochs3.events,epochs4.events,epochs5.events))

# save data
evokedcond1 = epochs_tot.average()
evokedcond1.save('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/mne_python/EtDtq1G_QRT2_sd130343-ave.fif')

#process cond2
event_id, tmin, tmax = etDtq2G_QRT2[:,0].tolist(), -0.2,1.1 

epochs1 = mne.Epochs(raw1, SelEve1, event_id, tmin, tmax, baseline=(-0.2, 0),picks = picks1,preload = True,reject = None,on_missing = 'warning')
epochs2 = mne.Epochs(raw2, SelEve2, event_id, tmin, tmax, baseline=(-0.2, 0),picks = picks2,preload = True,reject = None,on_missing = 'warning')
epochs3 = mne.Epochs(raw3, SelEve3, event_id, tmin, tmax, baseline=(-0.2, 0),picks = picks3,preload = True,reject = None,on_missing = 'warning')
epochs4 = mne.Epochs(raw4, SelEve4, event_id, tmin, tmax, baseline=(-0.2, 0),picks = picks4,preload = True,reject = None,on_missing = 'warning')
epochs5 = mne.Epochs(raw5, SelEve5, event_id, tmin, tmax, baseline=(-0.2, 0),picks = picks5,preload = True,reject = None,on_missing = 'warning')

# append subject's runs 
epochs_tot = deepcopy(epochs1)
epochs_tot._data  = np.vstack((epochs1._data,epochs2._data,epochs3._data,epochs4._data,epochs5._data))
epochs_tot.events = np.vstack((epochs1.events,epochs2.events,epochs3.events,epochs4.events,epochs5.events))

# save data
evokedcond2 = epochs_tot.average()
evokedcond2.save('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/mne_python/EtDtq2G_QRT2_sd130343-ave.fif')

# compute noise covariance matrix from emptyroom epochs #
empty = Raw("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/raw_sss/emptyroom_trans_sss.fif")
noise_cov = mne.compute_raw_data_covariance(empty)

# dSPM solution #
fname_fwd='/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/mne_python/sd130343_run1_ico-5-fwd.fif' 
forward = mne.read_forward_solution(fname_fwd,surf_ori=True)
inverse_operator1 = make_inverse_operator(evokedcond1.info, forward, noise_cov, loose=0.4, depth=0.8)
inverse_operator2 = make_inverse_operator(evokedcond2.info, forward, noise_cov, loose=0.4, depth=0.8)

snr = 3.0
lambda2 = 1.0 / snr **2
dSPM = True

stccond1 = apply_inverse(evokedcond1, inverse_operator1, lambda2, 'dSPM', pick_normal=False)
stccond1.save('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/mne_python/sd130343_EtDtq1G_QRT2_dPSMinverse_ico-5-fwd.fif')

stccond2 = apply_inverse(evokedcond2, inverse_operator2, lambda2, 'dSPM', pick_normal=False)
stccond2.save('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/mne_python/sd130343_EtDtq2G_QRT2_dPSMinverse_ico-5-fwd.fif')










