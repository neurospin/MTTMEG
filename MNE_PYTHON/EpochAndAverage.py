def EpochAndAverage(condnames,datasource,ListSubj,listRunPerSubj,EEGbadlist):

    #ipython --pylab
    import mne
    import numpy as np
    from scipy import io
    from copy import deepcopy
    import os
    os.chdir('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS/MNE_PYTHON')
    import MatchEventsFT2MNE as match
    import time
    from mne.minimum_norm import (make_inverse_operator, apply_inverse, write_inverse_operator)
    
    os.environ['SUBJECTS_DIR'] = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/mri'
    os.environ['MNE_ROOT'] = '/neurospin/local/mne'

    #wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"
    wdir = "/media/bgauthie/Seagate Backup Plus Drive/TMP_MEG_SOURCE/MEG/"

    for i in range(len(ListSubj)):
    
    	# open a text logfile
	logfile = open(wdir+ListSubj[i]+"/mne_python/logfile_preproc.txt", "w")
	logfile.write(time.strftime("%d/%m/%Y")+"\n")
	logfile.write(time.strftime("%H:%M:%S")+"\n")
	fname_fwd_eeg  = (wdir+ListSubj[i]+"/mne_python/run3_ico-5_eegonly_-fwd.fif") 
	fname_fwd_meg  = (wdir+ListSubj[i]+"/mne_python/run3_ico-5_megonly_-fwd.fif") 
	fname_fwd_meeg = (wdir+ListSubj[i]+"/mne_python/run3_ico-5_meeg_-fwd.fif") 

        for j in range(len(listRunPerSubj[i])):
            print(j)
            print(i)
            # load trans_sss data 
            raw = mne.io.Raw(wdir+ListSubj[i]+"/mne_python/preproc_"+listRunPerSubj[i][j]+"_trans_sss_raw.fif", preload = True)
	       # band-pass filter 1-35Hz
            raw.filter(l_freq = 1, h_freq=35, method = 'iir',n_jobs=3)
	       # Specify bad channels
            raw.info['bads'] += EEGbadlist[i]           

            # define events : import trial definition from fieldtrip and with mne_function
            tmp = str(j+1)
            fileE = io.loadmat("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/"+ListSubj[i]+"/PsychData/events"+tmp+".mat")
            eventsFT  = fileE['fullsubj']
            eventsMNE = mne.find_events(raw, stim_channel=['STI101'],consecutive = False)
            
            print "%d events found" %len(eventsMNE)
            logfile.write("" "\n") 
            logfile.write("processing subject " +ListSubj[i]+""+listRunPerSubj[i][j]+"\n")
            logfile.write("%d mne events found " %len(eventsMNE)+"\n")  
            logfile.write("%d ft events found " %len(eventsFT)+"\n")  
            logfile.write("" "\n")           

            # find events corresponding to FT run j
            itemindex = np.where(eventsFT[:,7]==(j+1))
            eventsFT  = eventsFT[itemindex[0],:]
            
            # set the "zero point" to a target event in MNE event (Ft to MNE sample matching strategy, because different zero time convention))
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
			del init
            
            elif datasource == 'EVS':
    			origevent = [18,22,26,30,34,19,23,27,31,35]
    			# find events corresponding to "Historical events" stimuli
    			init      = np.where(eventsFT[:,6]== origevent[0])
    			for k in origevent[1:]:
    				init = np.append(init,np.where(eventsFT[:,6]== k)[0]) 
    
    			eventsFT = eventsFT[init,:]
			del init
            
            elif datasource == 'QTT':
    			origevent = [6,8,10,12,14]
    			# find events corresponding to "Historical events" stimuli
    			init      = np.where(eventsFT[:,6]== origevent[0])
    			for k in origevent[1:]:
    				init = np.append(init,np.where(eventsFT[:,6]== k)[0]) 
                 
    			eventsFT = eventsFT[init,:]
			del init
            
            elif datasource == 'QTS':
    			origevent = [7,9,11,13,15]
    			# find events corresponding to "Historical events" stimuli
    			init      = np.where(eventsFT[:,6]== origevent[0])
    			for k in origevent[1:]:
    				init = np.append(init,np.where(eventsFT[:,6]== k)[0]) 
                 
    			eventsFT = eventsFT[init,:]
			del init

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
            
            logfile.write("%d selected final events" %len(SelEve)+"\n")  

    	    # process cond1
	    SelEve[:,2].astype(int)
            event_id1, tmin, tmax = np.intersect1d(SelEve[:,2].astype(int).tolist(),DATASET1[:,0].tolist()
), -0.2,1.1 
            
    	    # epoched data
            picksmeg  = mne.pick_types(raw.info, meg=True,  eeg=False, stim=True , eog=False, include=[], exclude='bads')
            pickseeg  = mne.pick_types(raw.info, meg=False, eeg=True,  stim=True , eog=False, include=[], exclude='bads')
            picksmeeg = mne.pick_types(raw.info, meg=True , eeg=True,  stim=True , eog=False, include=[], exclude='bads')
            
            epochs_cond1_meg = mne.Epochs(raw, SelEve, event_id1, tmin, tmax, baseline=(-0.2, 0),picks = picksmeg,preload = True,decim=4,reject = None,on_missing = 'warning')
            epochs_cond1_eeg = mne.Epochs(raw, SelEve, event_id1, tmin, tmax, baseline=(-0.2, 0),picks = pickseeg,preload = True,decim=4,reject = None,on_missing = 'warning')
            epochs_cond1_meeg= mne.Epochs(raw, SelEve, event_id1, tmin, tmax, baseline=(-0.2, 0),picks = picksmeeg,preload = True,decim=4,reject = None,on_missing = 'warning')
            
            baseline_cond1_meg = mne.Epochs(raw, SelEve, event_id1, -0.2, 0, baseline=(None, 0),picks = picksmeg,preload = True,reject = None,on_missing = 'warning')
            baseline_cond1_eeg = mne.Epochs(raw, SelEve, event_id1, -0.2, 0, baseline=(None, 0),picks = pickseeg,preload = True,reject = None,on_missing = 'warning')
            baseline_cond1_meeg= mne.Epochs(raw, SelEve, event_id1, -0.2, 0, baseline=(None, 0),picks= picksmeeg,preload = True,reject = None,on_missing = 'warning')
            
    	    # compute noise covariance matrix from baseline epochs #
            evokedcond1_meg = epochs_cond1_meg.average()
            evokedcond1_eeg = epochs_cond1_eeg.average()
            evokedcond1_meeg= epochs_cond1_meeg.average()
            
            noise_cov1_meg  = mne.compute_covariance(baseline_cond1_meg, keep_sample_mean=True, tmin=-0.2, tmax=0)
            noise_cov1_eeg  = mne.compute_covariance(baseline_cond1_eeg, keep_sample_mean=True, tmin=-0.2, tmax=0)
            noise_cov1_meeg = mne.compute_covariance(baseline_cond1_meeg,keep_sample_mean=True, tmin=-0.2, tmax=0)
            
            noise_cov1_meg  = mne.cov.regularize(noise_cov1_meg,  evokedcond1_meg.info,  grad=0.1, mag=0.1, eeg=0.1)
            noise_cov1_eeg  = mne.cov.regularize(noise_cov1_eeg,  evokedcond1_eeg.info,  grad=0.1, mag=0.1, eeg=0.1)
            noise_cov1_meeg = mne.cov.regularize(noise_cov1_meeg, evokedcond1_meeg.info, grad=0.1, mag=0.1, eeg=0.1)
            
            data_cov1_meg   = mne.compute_covariance(epochs_cond1_meg, keep_sample_mean=True, tmin=0, tmax=1.1)    
            data_cov1_eeg   = mne.compute_covariance(epochs_cond1_eeg, keep_sample_mean=True, tmin=0, tmax=1.1)  
            data_cov1_meeg  = mne.compute_covariance(epochs_cond1_meeg,keep_sample_mean=True, tmin=0, tmax=1.1)          
		
	    logfile.write("computing average on run" + listRunPerSubj[i][j] +"\n")
	    logfile.write("computing noise convariance on baseline period on run + listRunPerSubj[i][j]" +"\n")
	    logfile.write("computing data convariance on activation period on run + listRunPerSubj[i][j]" +"\n")
 
    	    # append subject's meg runs
            if j == 0:
    			epochs_tot_cond1_meg = deepcopy(epochs_cond1_meg)
    			epochs_tot_base1_meg = deepcopy(baseline_cond1_meg)
    			COV1_meg             = noise_cov1_meg
			COV_MEGdata          = data_cov1_meg
            else:
    			epochs_tmp_cond1_meg = epochs_cond1_meg
    			epochs_tmp_base1_meg = baseline_cond1_meg
     			COV1_meg['data']     += noise_cov1_meg['data']
    			COV1_meg['nfree']    += noise_cov1_meg['nfree']
    			COV1_meg = COV1_meg  + noise_cov1_meg
     			COV_MEGdata['data']  += data_cov1_meg['data']
    			COV_MEGdata['nfree'] += data_cov1_meg['nfree']
			COV_MEGdata          = COV_MEGdata + data_cov1_meg
                 
    			epochs_tot_cond1_meg._data  = np.vstack((epochs_tot_cond1_meg._data,epochs_tmp_cond1_meg._data))
    			epochs_tot_cond1_meg.events = np.vstack((epochs_tot_cond1_meg.events,epochs_tmp_cond1_meg.events))
    			#epochs_tot_cond1.selection = np.concatenate((epochs_tot_cond1.selection,epochs_tmp_cond1.selection))
    			epochs_tot_base1_meg._data  = np.vstack((epochs_tot_base1_meg._data,epochs_tmp_base1_meg._data))
    			epochs_tot_base1_meg.events = np.vstack((epochs_tot_base1_meg.events,epochs_tmp_base1_meg.events))
    			#epochs_tot_base1.selection = np.concatenate((epochs_tot_base1.selection,epochs_tmp_base1.selection))
            
            SelEve = None
	    
    	    # save evoked data
            evokedcond1_meg = epochs_tot_cond1_meg.average()
            mne.write_evokeds(wdir+ListSubj[i]+"/mne_python/MEG_"+condnames+"_"+ListSubj[i]+"-ave.fif",evokedcond1_meg)
	    logfile.write("saving all runs MEG evoked data" +"\n")

            #compute noise covariance matrix from emptyroom epochs #
            NOISE_COV1_meg = mne.cov.regularize(COV1_meg, evokedcond1_meg.info, grad=0.1, mag=0.1, eeg=0.1)
            NOISE_COV1_meg.save(wdir+ListSubj[i]+"/mne_python/MEGnoisecov_"+condnames+"_"+ListSubj[i]+"-cov.fif")
            COV_MEGdata.save(wdir+ListSubj[i]+"/mne_python/MEGdatacov_"+condnames+"_"+ListSubj[i]+"-cov.fif")
	
	    logfile.write("regularizing MEG noise covariance matrix from all runs" +"\n")
            logfile.write("saving MEG noise covariance matrix " +"\n")
            logfile.write("saving MEG data covariance matrix  from all runs" +"\n")

	    # append subject's eeg runs
            if j == 0:
    			epochs_tot_cond1_eeg = deepcopy(epochs_cond1_eeg)
    			epochs_tot_base1_eeg = deepcopy(baseline_cond1_eeg)
    			COV1_eeg             = noise_cov1_eeg
			COV_EEGdata          = data_cov1_eeg
            else:
    			epochs_tmp_cond1_eeg = epochs_cond1_eeg
    			epochs_tmp_base1_eeg = baseline_cond1_eeg
     			COV1_eeg['data']     += noise_cov1_eeg['data']
    			COV1_eeg['nfree']    += noise_cov1_eeg['nfree']
    			COV1_eeg = COV1_eeg  + noise_cov1_eeg
     			COV_EEGdata['data']  += data_cov1_eeg['data']
    			COV_EEGdata['nfree'] += data_cov1_eeg['nfree']
			COV_EEGdata          = COV_EEGdata + data_cov1_eeg
                 
    			epochs_tot_cond1_eeg._data  = np.vstack((epochs_tot_cond1_eeg._data,epochs_tmp_cond1_eeg._data))
    			epochs_tot_cond1_eeg.events = np.vstack((epochs_tot_cond1_eeg.events,epochs_tmp_cond1_eeg.events))
    			#epochs_tot_cond1.selection = np.concatenate((epochs_tot_cond1.selection,epochs_tmp_cond1.selection))
    			epochs_tot_base1_eeg._data  = np.vstack((epochs_tot_base1_eeg._data,epochs_tmp_base1_eeg._data))
    			epochs_tot_base1_eeg.events = np.vstack((epochs_tot_base1_eeg.events,epochs_tmp_base1_eeg.events))
    			#epochs_tot_base1.selection = np.concatenate((epochs_tot_base1.selection,epochs_tmp_base1.selection))
	    
    	    # save evoked data
            evokedcond1_eeg = epochs_tot_cond1_eeg.average()
            mne.write_evokeds(wdir+ListSubj[i]+"/mne_python/EEG_"+condnames+"_"+ListSubj[i]+"-ave.fif",evokedcond1_eeg)
            logfile.write("saving all runs EEG evoked data" +"\n")

            #compute noise covariance matrix from emptyroom epochs #
            NOISE_COV1_eeg = mne.cov.regularize(COV1_eeg, evokedcond1_eeg.info, grad=0.1, mag=0.1, eeg=0.1)
            NOISE_COV1_eeg.save(wdir+ListSubj[i]+"/mne_python/EEGnoisecov_"+condnames+"_"+ListSubj[i]+"-cov.fif")
            COV_EEGdata.save(wdir+ListSubj[i]+"/mne_python/EEGdatacov_"+condnames+"_"+ListSubj[i]+"-cov.fif")

	    logfile.write("regularizing EEG noise covariance matrix from all runs" +"\n")
            logfile.write("saving EEG noise covariance matrix " +"\n")
            logfile.write("saving EEG data covariance matrix  from all runs" +"\n")

	    # append subject's meeg runs
            if j == 0:
    			epochs_tot_cond1_meeg = deepcopy(epochs_cond1_meeg)
    			epochs_tot_base1_meeg = deepcopy(baseline_cond1_meeg)
    			COV1_meeg             = noise_cov1_meeg
			COV_MEEGdata          = data_cov1_meeg
            else:
    			epochs_tmp_cond1_meeg = epochs_cond1_meeg
    			epochs_tmp_base1_meeg = baseline_cond1_meeg
     			COV1_meeg['data']     += noise_cov1_meeg['data']
    			COV1_meeg['nfree']    += noise_cov1_meeg['nfree']
    			COV1_meeg = COV1_meeg + noise_cov1_meeg
     			COV_MEEGdata['data']  += data_cov1_meeg['data']
    			COV_MEEGdata['nfree'] += data_cov1_meeg['nfree']
			COV_MEEGdata          = COV_MEEGdata + data_cov1_meeg
                 
    			epochs_tot_cond1_meeg._data  = np.vstack((epochs_tot_cond1_meeg._data,epochs_tmp_cond1_meeg._data))
    			epochs_tot_cond1_meeg.events = np.vstack((epochs_tot_cond1_meeg.events,epochs_tmp_cond1_meeg.events))
    			#epochs_tot_cond1.selection = np.concatenate((epochs_tot_cond1.selection,epochs_tmp_cond1.selection))
    			epochs_tot_base1_meeg._data  = np.vstack((epochs_tot_base1_meeg._data,epochs_tmp_base1_meeg._data))
    			epochs_tot_base1_meeg.events = np.vstack((epochs_tot_base1_meeg.events,epochs_tmp_base1_meeg.events))
    			#epochs_tot_base1.selection = np.concatenate((epochs_tot_base1.selection,epochs_tmp_base1.selection))
	    
    	    # save evoked data
            evokedcond1_meeg = epochs_tot_cond1_meeg.average()
            mne.write_evokeds(wdir+ListSubj[i]+"/mne_python/MEEG_"+condnames+"_"+ListSubj[i]+"-ave.fif",evokedcond1_meeg)
            logfile.write("saving all runs MEEG evoked data" +"\n")

            #compute noise covariance matrix from emptyroom epochs #
            NOISE_COV1_meeg = mne.cov.regularize(COV1_meeg, evokedcond1_meeg.info, grad=0.1, mag=0.1, eeg=0.1)
            NOISE_COV1_meeg.save(wdir+ListSubj[i]+"/mne_python/MEEGnoisecov_"+condnames+"_"+ListSubj[i]+"-cov.fif")
            COV_MEEGdata.save(wdir+ListSubj[i]+"/mne_python/MEEGdatacov_"+condnames+"_"+ListSubj[i]+"-cov.fif")

	    logfile.write("regularizing MEEG noise covariance matrix from all runs" +"\n")
            logfile.write("saving MEEG noise covariance matrix " +"\n")
            logfile.write("saving MEEG data covariance matrix  from all runs" +"\n")

	    # compute and save inverse operators
            forward_meeg = mne.read_forward_solution(fname_fwd_meeg,surf_ori=True)
	    forward_eeg  = mne.read_forward_solution(fname_fwd_eeg,surf_ori=True)
	    forward_meg  = mne.read_forward_solution(fname_fwd_meg,surf_ori=True)


            inverse_operator1_meg  = make_inverse_operator(evokedcond1_meg.info,  forward_meg, NOISE_COV1_meg,  loose=0.2, depth=0.8)
	    inverse_operator1_eeg  = make_inverse_operator(evokedcond1_eeg.info,  forward_eeg, NOISE_COV1_eeg,  loose=0.2, depth=0.8)
	    inverse_operator1_meeg = make_inverse_operator(evokedcond1_meeg.info, forward_meeg, NOISE_COV1_meeg, loose=0.2, depth=0.8)

	    write_inverse_operator(wdir+ListSubj[i]+"/mne_python/"+condnames+"_meg_ico5-inv",inverse_operator1_meg)
	    write_inverse_operator(wdir+ListSubj[i]+"/mne_python/"+condnames+"_eeg_ico5-inv",inverse_operator1_eeg)
	    write_inverse_operator(wdir+ListSubj[i]+"/mne_python/"+condnames+"_meeg_ico5-inv",inverse_operator1_meeg)
		
	    logfile.write("compute and save MEG inverse operator from all runs" +"\n")
            logfile.write("compute and save EEG inverse operator from all runs" +"\n")
            logfile.write("compute and save MEEG inverse operator from all runs" +"\n")
		

    print(NOISE_COV1_meeg)
    	# Show covariance
    mne.viz.plot_cov(NOISE_COV1_meeg, raw.info, colorbar=True, proj=True,show_svd=False,show=False)

    logfile.write("print and save MEEG noise covariance matrices from all runs" +"\n")
    
    logfile.close()

