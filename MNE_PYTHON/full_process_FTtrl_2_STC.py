# -*- coding: utf-8 -*-

############################ compute inv - evtFARq1 &  evtFARq1 ###############################################
# set fonctions #

#ipython --pylab
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

os.environ['SUBJECTS_DIR'] = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/mri'
os.environ['MNE_ROOT'] = '/neurospin/local/mne'

# get a full list of subject and associated runs
ListSubj= ('sd130343', 'cb130477', 'rb130313', 'jm100042',  'jm100109', 'sb120316', 'tk130502', 'lm130479',
'sg120518','ms130534','ma100253', 'sl130503','mb140004', 'mp140019', 'mm130405', 'dm130250', 'hr130504', 'wl130316', 'rl130571')

listRunPerSubj = (('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
    ('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
    ('run2_GD','run3_DG','run4_DG'),
    ('run1_GD','run2_GD','run3_DG','run4_DG'),
    ('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
    ('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
    ('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
    ('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
    ('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
    ('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
    ('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
    ('run1_GD','run2_GD','run3_DG','run4_DG'),
    ('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
    ('run1_GD','run2_GD','run3_DG','run4_DG'),
    ('run1_GD','run2_GD','run3_DG','run4_DG'),
    ('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
    ('run1_GD','run2_GD','run3_DG','run4_DG'),
    ('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
    ('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'))

# list of bad EEG channels for EEG processing
EEGbadlist = (['EEG25', 'EEG036'],['EEG035', 'EEG036'],['EEG025', 'EEG035', 'EEG036'],['EEG035'],['EEG017', 'EEG025'],['EEG026', 'EEG036'],
    [],['EEG025', 'EEG035', 'EEG036' 'EEG037'],['EEG002', 'EEG055'],['EEG025', 'EEG035'],
    ['EEG009', 'EEG022', 'EEG045', 'EEG046', 'EEG053', 'EEG054', 'EEG059'],
    ['EEG035', 'EEG057'],['EEG043'],['EEG035'],['EEG017', 'EEG025', 'EEG035'],['EEG025', 'EEG035'],
    ['EEG025', 'EEG035'],['EEG025', 'EEG035', 'EEG036', 'EEG017'],['EEG0017', 'EEG0025', 'EEG0036', 'EEG0026', 'EEG0034'])

for i in range(len(ListSubj)):
	for j in range(len(listRunPerSubj[i])):
		print(j)
                print(i)
		# load trans_sss data #
		raw = Raw("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"+ListSubj[i]+"/mne_python/preproc_"+listRunPerSubj[i][j]+"_trans_sss_raw.fif")
		raw.info['bads'] += EEGbadlist[i]

		# define events #
		tmp = str(j+1)
		fileE = io.loadmat("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/"+ListSubj[i]+"/PsychData/events"+tmp+".mat")
		eventsFT  = fileE['fullsubj']
		eventsMNE = mne.find_events(raw, stim_channel=['STI101'],consecutive = False)
		print "%d events found" %len(eventsMNE)

		# find events corresponding to FT run j
		itemindex = np.where(eventsFT[:,7]==(j+1))
		eventsFT  = eventsFT[itemindex[0],:]

		# find events corresponding to "Historical events" stimuli
		init      = np.where(eventsFT[:,6]== 16)
		for k in range(17,36):
			init = np.append(init,np.where(eventsFT[:,6]== k)[0]) 

		eventsFT = eventsFT[init,:]

		# set the "zero point" to a target event in MNE event
		initsampmne = eventsMNE[np.where(eventsMNE[:,2] == 18)[0][0],0]

		for l in range(eventsMNE.shape[0]):
			eventsMNE[l,0] = eventsMNE[l,0] - initsampmne

		# set the "zero point" to a target event in FT event
		initsampft = eventsFT[np.where(eventsFT[:,6] == 18)[0][0],0]

		for l in range(eventsFT.shape[0]):
			eventsFT[l,0] = eventsFT[l,0] - initsampft

		# reject bad data based on fieldtrip "ft_rejectvisual"
		good     = np.where(eventsFT[:,8]== 1)
		eventsFT = eventsFT[good[0],:]

		# get the FT event in MNE events (should be the same but a small sample of events isn't matched
		# I need to check that soon
		SelEve = match.MatchEventsFT2MNE(eventsMNE,eventsFT)

		# get back to the original timing
		for m in range(SelEve.shape[0]):
			SelEve[m,0] = SelEve[m,0] + initsampmne

		# correct for photodelay
		for n in range(SelEve.shape[0]):
			SelEve[n,0] = SelEve[n,0] + 60;

		etDtq1G_QRT2 = io.loadmat("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/event_def_for_mne/EtDtq1G_QRT2.mat")
		etDtq2G_QRT2 = io.loadmat("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/event_def_for_mne/EtDtq2G_QRT2.mat")
		etDtq1G_QRT2 = etDtq1G_QRT2['cond']
		etDtq2G_QRT2 = etDtq2G_QRT2['cond']

		# process cond1&2
		event_id1, tmin, tmax = etDtq1G_QRT2[:,0].tolist(), -0.2,1.1 
		event_id2, tmin, tmax = etDtq2G_QRT2[:,0].tolist(), -0.2,1.1 

		# epoched data
		picks  = mne.fiff.pick_types(raw.info, meg=True, eeg=False, stim=False, eog=False, include=[], exclude='bads')

		epochs_cond1 = mne.Epochs(raw, SelEve, event_id1, tmin, tmax, baseline=(-0.2, 0),picks = picks,preload = True,reject = None,on_missing = 'warning')
		epochs_cond2 = mne.Epochs(raw, SelEve, event_id2, tmin, tmax, baseline=(-0.2, 0),picks = picks,preload = True,reject = None,on_missing = 'warning')

		baseline_cond1 = mne.Epochs(raw, SelEve, event_id1, -0.2, 0, baseline=(None, 0),picks = picks,preload = True,reject = None,on_missing = 'warning')
		baseline_cond2 = mne.Epochs(raw, SelEve, event_id2, -0.2, 0, baseline=(None, 0),picks = picks,preload = True,reject = None,on_missing = 'warning')

		# compute noise covariance matrix from emptyroom epochs #
		evokedcond1 = epochs_cond1.average()
		evokedcond2 = epochs_cond2.average()
		noise_cov1 = mne.compute_covariance(baseline_cond1,keep_sample_mean=True, tmin=-0.2, tmax=0)
        	noise_cov2 = mne.compute_covariance(baseline_cond2,keep_sample_mean=True, tmin=-0.2, tmax=0)
        	noise_cov1 = mne.cov.regularize(noise_cov1, evokedcond1.info, grad=0.1, mag=0.1, eeg=0.1)
		noise_cov2 = mne.cov.regularize(noise_cov2, evokedcond2.info, grad=0.1, mag=0.1, eeg=0.1)

		# append subject's runs
		if j == 0:
			epochs_tot_cond1 = deepcopy(epochs_cond1)
			epochs_tot_base1 = deepcopy(baseline_cond1)
			COV1 = noise_cov1
		else:
			epochs_tmp_cond1 = epochs_cond1
			epochs_tmp_base1 = baseline_cond1
 			COV1['data'] += noise_cov1['data']
			COV1['nfree'] += noise_cov1['nfree']
			COV1 = COV1 + noise_cov1

			epochs_tot_cond1._data = np.vstack((epochs_tot_cond1._data,epochs_tmp_cond1._data))
			epochs_tot_cond1.events = np.vstack((epochs_tot_cond1.events,epochs_tmp_cond1.events))
			#epochs_tot_cond1.selection = np.concatenate((epochs_tot_cond1.selection,epochs_tmp_cond1.selection))
			epochs_tot_base1._data = np.vstack((epochs_tot_base1._data,epochs_tmp_base1._data))
			epochs_tot_base1.events = np.vstack((epochs_tot_base1.events,epochs_tmp_base1.events))
			#epochs_tot_base1.selection = np.concatenate((epochs_tot_base1.selection,epochs_tmp_base1.selection))

		# append subject's runs 
		if j == 0:
			epochs_tot_cond2 = deepcopy(epochs_cond2)
			epochs_tot_base2 = deepcopy(baseline_cond2)
			COV2 = noise_cov2
		else:
			epochs_tmp_cond2 = epochs_cond2
			epochs_tmp_base2 = baseline_cond2
			COV2['data'] += noise_cov2['data']
			COV2['nfree'] += noise_cov2['nfree']
			COV2 = COV2 + noise_cov2

			epochs_tot_cond2._data = np.vstack((epochs_tot_cond2._data,epochs_tmp_cond2._data))
			epochs_tot_cond2.events = np.vstack((epochs_tot_cond2.events,epochs_tmp_cond2.events))
			#epochs_tot_cond2.selection = np.concatenate((epochs_tot_cond2.selection,epochs_tmp_cond2.selection))
			epochs_tot_base2._data = np.vstack((epochs_tot_base2._data,epochs_tmp_base2._data))
			epochs_tot_base2.events = np.vstack((epochs_tot_base2.events,epochs_tmp_base2.events))
			#epochs_tot_base2.selection = np.concatenate((epochs_tot_base2.selection,epochs_tmp_base2.selection))

		SelEve = None
	
	# save data
	evokedcond1 = epochs_tot_cond1.average()
	evokedcond1.save("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"+ListSubj[i]+"/mne_python/EtDtq1G_QRT2_"+ListSubj[i]+"-ave.fif")

	# save data
	evokedcond2 = epochs_tot_cond2.average()
	evokedcond2.save("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"+ListSubj[i]+"/mne_python/EtDtq2G_QRT2_"+ListSubj[i]+"-ave.fif")

	# compute noise covariance matrix from emptyroom epochs #
        NOISE_COV1 =mne.cov.regularize(COV1, evokedcond1.info, grad=0.1, mag=0.1, eeg=0.1)
	NOISE_COV2 =mne.cov.regularize(COV2, evokedcond2.info, grad=0.1, mag=0.1, eeg=0.1)

	print(noise_cov1)
	# Show covariance
	mne.viz.plot_cov(noise_cov1, raw.info, colorbar=True, proj=True,show_svd=False,show=False)
	plt.savefig("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/plots/"+ListSubj[i]+"covmat")
	plt.close()
	
	# dSPM solution #
	fname_fwd=("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"+ListSubj[i]+"/mne_python/run3_ico-5-fwd.fif") 
	forward = mne.read_forward_solution(fname_fwd,surf_ori=True)
	inverse_operator1 = make_inverse_operator(evokedcond1.info, forward, noise_cov1, loose=0.4, depth=0.8)
	inverse_operator2 = make_inverse_operator(evokedcond2.info, forward, noise_cov2, loose=0.4, depth=0.8)
	
	snr = 3.0
	lambda2 = 1.0 / snr **2
	dSPM = True

	stccond1 = apply_inverse(evokedcond1, inverse_operator1, lambda2, 'dSPM', pick_normal=False)
	stccond1.save("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"+ListSubj[i]+"/mne_python/"+ListSubj[i]+"_EtDtq1G_QRT2_dPSMinverse_ico-5-fwd.fif")

	stc_fsaverage_cond1 = mne.morph_data(ListSubj[i], 'fsaverage', stccond1)
	stc_fsaverage_cond1.save("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"+ListSubj[i]+"/mne_python/"+ListSubj[i]+"_EtDtq1G_QRT2_dPSMinverse_ico-5-fwd-fsaverage.fif")

	stccond2 = apply_inverse(evokedcond2, inverse_operator2, lambda2, 'dSPM', pick_normal=False)
	stccond2.save("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"+ListSubj[i]+"/mne_python/"+ListSubj[i]+"_EtDtq2G_QRT2_dPSMinverse_ico-5-fwd.fif")

	stc_fsaverage_cond2 = mne.morph_data(ListSubj[i], 'fsaverage', stccond2)
	stc_fsaverage_cond2.save("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"+ListSubj[i]+"/mne_python/"+ListSubj[i]+"_EtDtq2G_QRT2_dPSMinverse_ico-5-fwd-fsaverage.fif")








