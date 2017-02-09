def GDAVG_source_trialsfromFT_1cond(condnames,datasource):

    #ipython --pylab
    import mne
    import numpy as np
    from scipy import io
    from matplotlib import pyplot as plt
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
    'sg120518','ms130534','ma100253', 'sl130503','mb140004', 'mp140019', 'dm130250', 'hr130504', 'wl130316', 'rl130571')
    
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
        ('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
        ('run1_GD','run2_GD','run3_DG','run4_DG'),
        ('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
        ('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'))
    
    # list of bad EEG channels for EEG processing
    EEGbadlist = (['EEG25', 'EEG036'],['EEG035', 'EEG036'],['EEG025', 'EEG035', 'EEG036'],['EEG035'],['EEG017', 'EEG025'],['EEG026', 'EEG036'],
        [],['EEG025', 'EEG035', 'EEG036' 'EEG037'],['EEG002', 'EEG055'],['EEG025', 'EEG035'],
        ['EEG009', 'EEG022', 'EEG045', 'EEG046', 'EEG053', 'EEG054', 'EEG059'],
        ['EEG035', 'EEG057'],['EEG043'],['EEG035'],['EEG025', 'EEG035'],
        ['EEG025', 'EEG035'],['EEG025', 'EEG035', 'EEG036', 'EEG017'],['EEG0017', 'EEG0025', 'EEG0036', 'EEG0026', 'EEG0034'])

    for i in range(len(ListSubj)):

    	# open a text logfile
    	logfile = open("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"+ListSubj[i]+"/mne_python/logfile_preproc.txt", "w")

        for j in range(len(listRunPerSubj[i])):
            print(j)
            print(i)
            # load trans_sss data 
            raw = io.RawFIFF("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"+ListSubj[i]+"/mne_python/preproc_"+listRunPerSubj[i][j]+"_trans_sss_raw.fif", preload = True)
	    # band-pass filter 1-35Hz
	    raw.filter(l_freq = 1, h_freq=35, method = 'iir',n_jobs=4)
	    # Specify bad channels
            raw.info['bads'] += EEGbadlist[i]           

            # define events : import trial definition from fieldtrip and with mne_function
            tmp = str(j+1)
            fileE = io.loadmat("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/"+ListSubj[i]+"/PsychData/events"+tmp+".mat")
            eventsFT  = fileE['fullsubj']
            eventsMNE = mne.find_events(raw, stim_channel=['STI101'],consecutive = False)
            
            print "%d events found" %len(eventsMNE)
            logfile.write("%d mne events found" %len(eventsMNE) "\n")  
	    logfile.write("%d ft events found" %len(eventsFT) "\n")           

            # find events corresponding to FT run j
            itemindex = np.where(eventsFT[:,7]==(j+1))
            eventsFT  = eventsFT[itemindex[0],:]
            
            # set the "zero point" to a target event in MNE event
            initsampmne = eventsMNE[np.where(eventsMNE[:,2] == 18)[0][0],0]

            for l in range(eventsMNE.shape[0]):
    			eventsMNE[l,0] = eventsMNE[l,0] - initsampmne

    	    # set the "zero point" to a target event in FT event
            initsampft = eventsFT[np.where(eventsFT[:,6] == 18)[0][0],0]

            for l in range(eventsFT.shape[0]):
    			eventsFT[l,0] = eventsFT[l,0] - initsampft
            
            # Select original event before recoding according to the condition and the source dataset
            if datasource == 'EVT':
			origevent = [16,20,24,28,32,17,21,25,29,33]
			# find events corresponding to "Historical events" stimuli
			init      = np.where(eventsFT[:,6]== origevent[0])
			for k in origevent[1:]:
				init = np.append(init,np.where(eventsFT[:,6]== k)[0]) 

			eventsFT = eventsFT[init,:]
            
            elif datasource == 'EVS':
    			origevent = [18,22,26,30,34,19,23,27,31,35]
    			# find events corresponding to "Historical events" stimuli
    			init      = np.where(eventsFT[:,6]== origevent[0])
    			for k in origevent[1:]:
    				init = np.append(init,np.where(eventsFT[:,6]== k)[0]) 
    
    			eventsFT = eventsFT[init,:]
            
            elif datasource == 'QTT':
    			origevent = [6,8,10,12,14]
    			# find events corresponding to "Historical events" stimuli
    			init      = np.where(eventsFT[:,6]== origevent[0])
    			for k in origevent[1:]:
    				init = np.append(init,np.where(eventsFT[:,6]== k)[0]) 
                 
    			eventsFT = eventsFT[init,:]
            
            elif datasource == 'QTS':
    			origevent = [7,9,11,13,15]
    			# find events corresponding to "Historical events" stimuli
    			init      = np.where(eventsFT[:,6]== origevent[0])
    			for k in origevent[1:]:
    				init = np.append(init,np.where(eventsFT[:,6]== k)[0]) 
                 
    			eventsFT = eventsFT[init,:]

    	    # reject bad data based on fieldtrip "ft_rejectvisual"
            good     = np.where(eventsFT[:,8]== 1)
            eventsFT = eventsFT[good[0],:]
            
    	    # get the FT event in MNE events (should be the same but a small sample of events isn't matched
    	    # (FIXME)
            SelEve = match.MatchEventsFT2MNE(eventsMNE,eventsFT)
            
    	    # get back to the original timing
            for m in range(SelEve.shape[0]):
    			SelEve[m,0] = SelEve[m,0] + initsampmne

    	    # correct for photodelay
            for n in range(SelEve.shape[0]):
    			SelEve[n,0] = SelEve[n,0] + 60
            
            TMPset1 = io.loadmat("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/event_def_for_mne/"+condnames+".mat")
            DATASET1 = TMPset1['cond']
            
            logfile.write("%d selected final events" %len(SelEve) "\n")  

    	    # process cond1
            event_id1, tmin, tmax = DATASET1[:,0].tolist(), -0.2,1.1 
            
    	    # epoched data
            picks_meg  = mne.pick_types(raw.info, meg=False, eeg=True, stim=True , eog=False, include=[], exclude='bads')
	    picks_eeg  = mne.pick_types(raw.info, meg=True , eeg=False, stim=True, eog=False, include=[], exclude='bads')
	    picks_meeg = mne.pick_types(raw.info, meg=True , eeg=True, stim=True , eog=False, include=[], exclude='bads')
            
            epochs_cond1_meg = mne.Epochs(raw, SelEve, event_id1, tmin, tmax, baseline=(-0.2, 0),picks_meg  = picks,preload = True,decim=4,reject = None,on_missing = 'warning')
            epochs_cond1_eeg = mne.Epochs(raw, SelEve, event_id1, tmin, tmax, baseline=(-0.2, 0),picks_eeg  = picks,preload = True,decim=4,reject = None,on_missing = 'warning')
            epochs_cond1_meeg= mne.Epochs(raw, SelEve, event_id1, tmin, tmax, baseline=(-0.2, 0),picks_meeg = picks,preload = True,decim=4,reject = None,on_missing = 'warning')
            
            baseline_cond1_meg = mne.Epochs(raw, SelEve, event_id1, -0.2, 0, baseline=(None, 0),picks_meg = picks,preload = True,reject = None,on_missing = 'warning')
            baseline_cond1_meg = mne.Epochs(raw, SelEve, event_id1, -0.2, 0, baseline=(None, 0),picks_eeg = picks,preload = True,reject = None,on_missing = 'warning')
            baseline_cond1_meeg= mne.Epochs(raw, SelEve, event_id1, -0.2, 0, baseline=(None, 0),picks_meeg= picks,preload = True,reject = None,on_missing = 'warning')
            
    	    # compute noise covariance matrix from emptyroom epochs #
            evokedcond1_meg = epochs_cond1.average()
	    evokedcond1_eeg = epochs_cond1.average()
            evokedcond1_meeg= epochs_cond1.average()
            noise_cov1_meg  = mne.compute_covariance(baseline_cond1_meg,keep_sample_mean=True, tmin=-0.2, tmax=0)
            noise_cov1_meg  = mne.cov.regularize(noise_cov1_meg, evokedcond1_meg.info, grad=0.1, mag=0.1, eeg=0.1)
            noise_cov1_eeg  = mne.compute_covariance(baseline_cond1_eeg,keep_sample_mean=True, tmin=-0.2, tmax=0)
            noise_cov1_eeg  = mne.cov.regularize(noise_cov1_eeg, evokedcond1_meg.info, grad=0.1, mag=0.1, eeg=0.1)
            noise_cov1_meeg = mne.compute_covariance(baseline_cond1_meeg,keep_sample_mean=True, tmin=-0.2, tmax=0)
            noise_cov1_meeg = mne.cov.regularize(noise_cov1_meeg, evokedcond1_meg.info, grad=0.1, mag=0.1, eeg=0.1)
            
    	    # append subject's meg runs
            if j == 0:
    			epochs_tot_cond1_meg = deepcopy(epochs_cond1_meg)
    			epochs_tot_base1_meg = deepcopy(baseline_cond1_meg)
    			COV1_meg = noise_cov1_meg
            else:
    			epochs_tmp_cond1_meg = epochs_cond1_meg
    			epochs_tmp_base1_meg = baseline_cond1_meg
     			COV1_meg['data'] += noise_cov1_meg['data']
    			COV1_meg['nfree'] += noise_cov1_meg['nfree']
    			COV1_meg = COV1_meg + noise_cov1_meg
                 
    			epochs_tot_cond1_meg._data = np.vstack((epochs_tot_cond1_meg._data,epochs_tmp_cond1_meg._data))
    			epochs_tot_cond1_meg.events = np.vstack((epochs_tot_cond1_meg.events,epochs_tmp_cond1_meg.events))
    			#epochs_tot_cond1.selection = np.concatenate((epochs_tot_cond1.selection,epochs_tmp_cond1.selection))
    			epochs_tot_base1_meg._data = np.vstack((epochs_tot_base1_meg._data,epochs_tmp_base1_meg._data))
    			epochs_tot_base1_meg.events = np.vstack((epochs_tot_base1_meg.events,epochs_tmp_base1_meg.events))
    			#epochs_tot_base1.selection = np.concatenate((epochs_tot_base1.selection,epochs_tmp_base1.selection))
            
            SelEve = None
	    
    	    # save evoked data
            evokedcond1_meg = epochs_tot_cond1_meg.average()
            write_evokeds("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"+ListSubj[i]+"/mne_python/MEEG_"+condnames+"_"+ListSubj[i]+"-ave.fif",evokedcond1_meeg)

            #compute noise covariance matrix from emptyroom epochs #
            NOISE_COV1_meg = mne.cov.regularize(COV1_meg, evokedcond1_meg.info, grad=0.1, mag=0.1, eeg=0.1)
    
	    # append subject's eeg runs
            if j == 0:
    			epochs_tot_cond1_eeg = deepcopy(epochs_cond1_eeg)
    			epochs_tot_base1_eeg = deepcopy(baseline_cond1_eeg)
    			COV1_eeg = noise_cov1_eeg
            else:
    			epochs_tmp_cond1_eeg = epochs_cond1_eeg
    			epochs_tmp_base1_eeg = baseline_cond1_eeg
     			COV1_eeg['data'] += noise_cov1_eeg['data']
    			COV1_eeg['nfree'] += noise_cov1_eeg['nfree']
    			COV1_eeg = COV1_eeg + noise_cov1_eeg
                 
    			epochs_tot_cond1_eeg._data = np.vstack((epochs_tot_cond1_eeg._data,epochs_tmp_cond1_eeg._data))
    			epochs_tot_cond1_eeg.events = np.vstack((epochs_tot_cond1_eeg.events,epochs_tmp_cond1_eeg.events))
    			#epochs_tot_cond1.selection = np.concatenate((epochs_tot_cond1.selection,epochs_tmp_cond1.selection))
    			epochs_tot_base1_eeg._data = np.vstack((epochs_tot_base1_eeg._data,epochs_tmp_base1_eeg._data))
    			epochs_tot_base1_eeg.events = np.vstack((epochs_tot_base1_eeg.events,epochs_tmp_base1_eeg.events))
    			#epochs_tot_base1.selection = np.concatenate((epochs_tot_base1.selection,epochs_tmp_base1.selection))
	    
    	    # save evoked data
            evokedcond1_eeg = epochs_tot_cond1_eeg.average()
            write_evokeds("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"+ListSubj[i]+"/mne_python/EEG_"+condnames+"_"+ListSubj[i]+"-ave.fif",evokedcond1_eeg)

            #compute noise covariance matrix from emptyroom epochs #
            NOISE_COV1_eeg = mne.cov.regularize(COV1_eeg, evokedcond1_eeg.info, grad=0.1, mag=0.1, eeg=0.1)

	    # append subject's meeg runs
            if j == 0:
    			epochs_tot_cond1_meeg = deepcopy(epochs_cond1_meeg)
    			epochs_tot_base1_meeg = deepcopy(baseline_cond1_meeg)
    			COV1_meeg = noise_cov1_meeg
            else:
    			epochs_tmp_cond1_meeg = epochs_cond1_meeg
    			epochs_tmp_base1_meeg = baseline_cond1_meeg
     			COV1_meeg['data'] += noise_cov1_meeg['data']
    			COV1_meeg['nfree'] += noise_cov1_meeg['nfree']
    			COV1_meeg = COV1_meeg + noise_cov1_meeg
                 
    			epochs_tot_cond1_meeg._data = np.vstack((epochs_tot_cond1_meeg._data,epochs_tmp_cond1_meeg._data))
    			epochs_tot_cond1_meeg.events = np.vstack((epochs_tot_cond1_meeg.events,epochs_tmp_cond1_meeg.events))
    			#epochs_tot_cond1.selection = np.concatenate((epochs_tot_cond1.selection,epochs_tmp_cond1.selection))
    			epochs_tot_base1_meeg._data = np.vstack((epochs_tot_base1_meeg._data,epochs_tmp_base1_meeg._data))
    			epochs_tot_base1_meeg.events = np.vstack((epochs_tot_base1_meeg.events,epochs_tmp_base1_meeg.events))
    			#epochs_tot_base1.selection = np.concatenate((epochs_tot_base1.selection,epochs_tmp_base1.selection))
	    
    	    # save evoked data
            evokedcond1_meeg = epochs_tot_cond1_meeg.average()
            write_evokeds("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"+ListSubj[i]+"/mne_python/MEEG_"+condnames+"_"+ListSubj[i]+"-ave.fif",evokedcond1_meeg)

            #compute noise covariance matrix from emptyroom epochs #
            NOISE_COV1_meeg = mne.cov.regularize(COV1_meeg, evokedcond1_meeg.info, grad=0.1, mag=0.1, eeg=0.1)

        print(NOISE_COV1_meeg)
    	# Show covariance
    	mne.viz.plot_cov(NOISE_COV1_meeg, raw.info, colorbar=True, proj=True,show_svd=False,show=False)
    	plt.savefig("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/plots/covmat/MEEG_"+ListSubj[i]+condnames+"covmat")
    	plt.close()
    	
    	# dSPM solution #
    	fname_fwd=("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"+ListSubj[i]+"/mne_python/run3_ico-5-fwd.fif") 
    	forward = mne.read_forward_solution(fname_fwd,surf_ori=True)

	# save evoked info (FIXME, used to be able to reuse evoked.info for dPSM)
	evokedcond1_meg.info.save("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"+ListSubj[i]+"/mne_python/MEGevokedinfo_"+condnames+"_"+ListSubj[i])
	evokedcond1_eeg.info.save("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"+ListSubj[i]+"/mne_python/EEGevokedinfo_"+condnames+"_"+ListSubj[i])
	evokedcond1_meeg.info.save("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"+ListSubj[i]+"/mne_python/MEEGevokedinfo_"+condnames+"_"+ListSubj[i])

    	inverse_operator1_meg  = make_inverse_operator(evokedcond1_meg.info,  forward, NOISE_COV1_meg,  loose=0.2, depth=0.8)
	inverse_operator1_eeg  = make_inverse_operator(evokedcond1_eeg.info,  forward, NOISE_COV1_eeg,  loose=0.2, depth=0.8)
	inverse_operator1_meeg = make_inverse_operator(evokedcond1_meeg.info, forward, NOISE_COV1_meeg, loose=0.2, depth=0.8)
	
	# dSPM solution #
    	snr = 3.0
    	lambda2 = 1.0 / snr **2
    
    	stccond1_meg = apply_inverse(evokedcond1_meg, inverse_operator1_meg, lambda2,method ='dSPM', pick_ori= None)
    	stccond1_meg.save("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"+ListSubj[i]+"/mne_python/MEG_"+ListSubj[i]+"_"+condnames+"_pick_oriNone_dPSMinverse_ico-5-fwd.fif")

    	stccond1bis_meg = apply_inverse(evokedcond1_meg, inverse_operator1_meg, lambda2,method ='dSPM', pick_ori= "normal")
    	stccond1bis_meg.save("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"+ListSubj[i]+"/mne_python/MEG_"+ListSubj[i]+"_"+condnames+"_pick_orinormal_dPSMinverse_ico-5-fwd.fif")
    
    	stc_fsaverage_cond1_meg = mne.morph_data(ListSubj[i], 'fsaverage', stccond1_meg)
    	stc_fsaverage_cond1_meg.save("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"+ListSubj[i]+"/mne_python/MEG_"+ListSubj[i]+"_"+condnames+"_pick_oriNone_dPSMinverse_ico-5-fwd-fsaverage.fif")

    	stc_fsaverage_cond1bis_meg = mne.morph_data(ListSubj[i], 'fsaverage', stccond1bis_meg)
    	stc_fsaverage_cond1bis_meg.save("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"+ListSubj[i]+"/mne_python/MEG_"+ListSubj[i]+"_"+condnames+"_pick_orinormal_dPSMinverse_ico-5-fwd-fsaverage.fif")
    
    
    
    
    
    
    
    
