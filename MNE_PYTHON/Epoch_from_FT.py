# -*- coding: utf-8 -*-
"""
Created on Wed Dec  9 15:11:42 2015

@author: bgauthie
"""

def Epoch_from_FT(datasource,subject,runpersubject, badeeg, meg_tag, eeg_tag):

    import matplotlib
    matplotlib.use('Agg')

    import mne
    import numpy as np
    import os   
    import MatchEventsFT2MNE as match
    from scipy import io
    from copy import deepcopy


    os.chdir('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS/MNE_PYTHON')
    os.environ['SUBJECTS_DIR'] = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/mri'
    os.environ['MNE_ROOT'] = '/neurospin/local/mne'
    
    wdir    = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"
    ft_wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/"

    # convert trial definition from fieldtrip .mat variable to mne-python
    def Trldef(wdir, datasource, subject, run, runind, badEEG):

        # load trans_sss data, band-pass filter 1-35Hz, Specify EEG bad channels
        raw = mne.io.Raw(wdir + subject + "/mne_python/preproc_" + run +
                        "_trans_sss_raw.fif", preload = True)
        raw.filter(l_freq=None, h_freq=30, method = 'iir', n_jobs=2)
        raw.info['bads'] += badEEG     
        #raw.interpolate_bads(reset_bads = False) (FIXME)

        # define events : import trial definition from fieldtrip processing and with mne_function
        # find events corresponding to run j for FT events definition       
        fileE = io.loadmat(ft_wdir + 'Subjects/' + subject + "/PsychData/events" +
                        str(runind+1) + ".mat")
        eventsFT = fileE['fullsubj'] 
        eventsMNE = mne.find_events(raw, stim_channel=['STI101'],consecutive = False)     
        itemindex = np.where(eventsFT[:,7]==(runind+1))
        eventsFT = eventsFT[itemindex[0],:]

        # set the "zero point" to a target event in MNE event ...
        # ... (FT to MNE sample matching strategy, because different zero time convention))
        # set the "zero point" to a target event in FT event
        initsampmne = eventsMNE[np.where(eventsMNE[:,2] == 18)[0][0],0]
        eventsMNE[:,0] = [eventsMNE[l,0]-initsampmne for l in range(eventsMNE.shape[0])]
        initsampft = eventsFT[np.where(eventsFT[:,6] == 18)[0][0],0]
        eventsFT[:,0] = [eventsFT[l,0]-initsampft for l in range(eventsFT.shape[0])]

        # Select original event trigger according to the condition and the source dataset
        origtrig = {'EVT' :[16,20,24,28,32,17,21,25,29,33],
                    'EVS' :[18,22,26,30,34,19,23,27,31,35],
                    'QTT' :[6,8,10,12,14],
                    'QTS' :[7,9,11,13,15],
                    'REF' :[1,2,3,4,5],
                    'RESP':[1024, 32768]}

        # find events corresponding to original "Historical events" stimuli
        # reject bad trial based on previous fieldtrip "ft_rejectvisual"
        index_list2 = []
        index_list  = [np.where(eventsFT[:,6] == k)[0].tolist() for k in origtrig[datasource]]
        for i in range(len(origtrig[datasource])):
            index_list2.extend(index_list[i]) 
        eventsFT = eventsFT[index_list2,:]
        eventsFT = eventsFT[np.where(eventsFT[:,8]== 1)[0],:]

        # match temporally the FT event and MNE events (should be the same but a small sample of events isn't matched (FIXME)
        # get back to mne timing
        # correct for photodelay 
        SelEve = match.MatchEventsFT2MNE(eventsMNE,eventsFT)
        SelEve[:,0] = [SelEve[m,0] + initsampmne for m in range(SelEve.shape[0])]
        SelEve[:,0] = [SelEve[n,0] + 60 for n in range(SelEve.shape[0])]

        return raw, SelEve

    def make_epochs(wdir, raw, SelEve, epoch_tmin, epoch_tmax, baseline_tmin, baseline_tmax, meg_tag, eeg_tag):
        
        # epoch data (I do not decimat the baseline in order to get more data to compute covariance)
        picks      = mne.pick_types(raw.info, meg=meg_tag,  eeg=eeg_tag,
                                    stim=True , eog=False, include=[], exclude='bads')
        epochs     = mne.Epochs(raw, SelEve,SelEve[:,2].astype(int).tolist(), epoch_tmin , epoch_tmax,
                                baseline=(baseline_tmin, baseline_tmax),
                                picks = picks, preload = True, decim=5,
                                reject = None,on_missing    = 'warning')

        return epochs

    def Epoch_append(wdir, epoch_list):
        
        for i in range(len(epoch_list)):

    	    # append one's subject's epochs and covariance matrices
            if i == 0:
                epoch_tot          = deepcopy(epoch_list[i])
            else:
                epoch_tmp          = epoch_list[i]
                epoch_tot._data    = np.vstack((epoch_tot._data ,epoch_tmp._data))
                epoch_tot.events   = np.vstack((epoch_tot.events,epoch_tmp.events))

        return epoch_tot
        
    def CovCompute(wdir, epochs, baseline, epoch_tmin, epoch_tmax, baseline_tmin, baseline_tmax):

        # compute noise covariance matrix from baseline epochs (MNE,dSPM,sLORETA) and activation epochs (LCMV) 
        evoked     = epochs.average()
        noise_cov  = mne.compute_covariance(baseline, keep_sample_mean=True, tmin=baseline_tmin, tmax=baseline_tmax)
        data_cov   = mne.compute_covariance(epochs  , keep_sample_mean=True, tmin=epoch_tmin   , tmax=epoch_tmax   )  
        noise_cov  = mne.cov.regularize(noise_cov,  evoked.info,  grad=0.1, mag=0.1, eeg=0.1)
        data_cov   = mne.cov.regularize(data_cov,   evoked.info,  grad=0.1, mag=0.1, eeg=0.1)
        
        return noise_cov, data_cov 

#############################################################################################################
########################################### Subfunctions Call ###############################################
######################################### General Processing ################################################ 
#############################################################################################################

    #test input
    #datasource    = 'EVS'
    #subject       = 'dm130250'
    #runpersubject = ('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD')
    #badeeg        = ('EEG025','EEG035')
    #meg_tag       = True
    #eeg_tag       = True
    
    if meg_tag :
        if eeg_tag:
            modality = 'MEEG'
        else:
            modality = 'MEG'
    elif eeg_tag:
        modality = 'EEG'

    # Process a single subject
    # Process a subset of runs
    epochs_list = []
    for j,run in enumerate(runpersubject):
        raw,SelEve = Trldef(wdir, datasource,subject,run,j,badeeg)
        epochs  = make_epochs(wdir, raw, SelEve, -0.2, 1.1, -0.2, 0, meg_tag, eeg_tag) 
        epochs_list.append(epochs)
        del raw,  SelEve
    
    # pool epochs in a single epoch object for all runs
    epochs2pool    = [epochs_list[e] for e in range(len(epochs_list))]
    epoch_tot = Epoch_append(wdir, epochs2pool) 
    
    # save the result
    epoch_tot.save(wdir + subject + "/mne_python/EPOCHS/" + modality + "_epochs_" +
                   'all' + datasource + "_" + subject + "-epo.fif")









