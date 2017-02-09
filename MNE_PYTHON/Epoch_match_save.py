# -*- coding: utf-8 -*-
"""
Created on Wed Feb  3 11:04:51 2016

@author: bgauthie
"""


def Epoch_match_save(conditions,datasource,subject,runpersubject, badeeg):

    import matplotlib
    matplotlib.use('Agg')

    import mne
    # import random
    # import itertools
    import numpy as np
    import os   
    from scipy import io
    # from mne.minimum_norm import (make_inverse_operator, write_inverse_operator)
    # from matplotlib import pyplot as pl

    os.chdir('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS/MNE_PYTHON')
    os.environ['SUBJECTS_DIR'] = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/mri'
    os.environ['MNE_ROOT'] = '/neurospin/local/mne'
    
    import MatchEventsFT2MNE as match

    wdir    = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"
    ft_wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/"

    # convert trial definition from fieldtrip .mat variable to mne-python
    def Trldef(wdir, condition, datasource, subject, run, runind, badEEG):

        # load trans_sss data, band-pass filter 1-30Hz,  Specify EEG bad channels
        raw = mne.io.Raw(wdir + subject + "/mne_python/preproc_" + run +
                        "_trans_sss_raw.fif",preload = True)
        raw.filter(l_freq=None, h_freq=30, method = 'iir')
        raw.info['bads'] += badEEG    
        if subject == 'cb130477':
            'fixme'
        else:
            raw.interpolate_bads(reset_bads = False) 
        # define events : import trial definition from fieldtrip processing and with mne_function
        # find events corresponding to run j for FT events definition       
        fileE = io.loadmat(ft_wdir + 'Subjects/' + subject + "/PsychData/events" +
                        str(runind+1) + ".mat")
        eventsFT = fileE['fullsubj'] 
        eventsMNE = mne.find_events(raw, stim_channel=['STI101'],consecutive = False)     
        itemindex = np.where(eventsFT[:,7]==(runind+1))
        eventsFT = eventsFT[itemindex[0],:]

        # set the "zero point" to a target event in MNE event (FT to MNE sample matching strategy, because different zero time convention))
        # set the "zero point" to a target event in FT event
        if subject == 'jm100042':
            initsampmne = eventsMNE[np.where(eventsMNE[:,2] == 6)[0][0],0]
            eventsMNE[:,0] = [eventsMNE[l,0]-initsampmne for l in range(eventsMNE.shape[0])]
            initsampft = eventsFT[np.where(eventsFT[:,6] == 6)[0][0],0]
            eventsFT[:,0] = [eventsFT[l,0]-initsampft for l in range(eventsFT.shape[0])]
        else:
            initsampmne = eventsMNE[np.where(eventsMNE[:,2] == 18)[0][0],0]
            eventsMNE[:,0] = [eventsMNE[l,0]-initsampmne for l in range(eventsMNE.shape[0])]
            initsampft = eventsFT[np.where(eventsFT[:,6] == 18)[0][0],0]
            eventsFT[:,0] = [eventsFT[l,0]-initsampft for l in range(eventsFT.shape[0])]

        # Select original event trigger according to the condition and the source dataset
        origtrig = {'EVT':[16,20,24,28,32,17,21,25,29,33],
                    'EVS':[18,22,26,30,34,19,23,27,31,35],
                    'QTT':[6,8,10,12,14],
                    'QTS':[7,9,11,13,15]}

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
        TMPset1 = io.loadmat(ft_wdir + "Scripts/event_def_for_mne/" + condition + ".mat")
        DATASET1 = TMPset1['cond']

        # get trials corresponding to the wanted condition
        SelEve = SelEve.astype(int)
        event_id1 = np.intersect1d(SelEve[:,2].astype(int).tolist(),DATASET1[:,0].tolist())

        return raw, event_id1, SelEve


    def Epoch(wdir, raw, SelEve, event_id, epoch_tmin, epoch_tmax, baseline_tmin, baseline_tmax):
        
        # epoch data (I do not decimat the baseline in order to get more data to compute covariance)
        picks      = mne.pick_types(raw.info, meg=True,  eeg=True, stim=True , eog=False, include=[], exclude='bads')
        epochs     = mne.Epochs(raw, SelEve, event_id, epoch_tmin   , epoch_tmax   , baseline=(baseline_tmin, baseline_tmax), picks = picks, preload = True, decim=5,reject = None,on_missing    = 'warning')
        # baseline   = mne.Epochs(raw, SelEve, event_id, baseline_tmin, baseline_tmax, baseline=(None, 0)                     , picks = picks, preload = True, reject = None, on_missing = 'warning')

        return epochs
	    
        
    def match_trialnb(epochs_list):        
        # still need to do something fancier but let's find some results before the fancy stuff...
        mne.epochs.equalize_epoch_counts(epochs_list)
        
        return epochs_list
            
#############################################################################################################
########################################### Subfunctions Call ###############################################
######################################### General Processing ################################################ 
#############################################################################################################

    # Test parameters
    
#    subject       = 'cb130477'
#    runpersubject = ('run1_GD','run2_GD','run3_DG','run4_DG')
#    badeeg        = ['EEG035', 'EEG036']
#    conditions    = ('Qt_all','Qs_all')
#    datasource    = ('QTT','QTS')
    modality      = 'MEEG'

    # Process a single subject
    # epochs_list_subj, noise_cov_list_subj, data_cov_list_subj = [], [], []
    epochs_list_eq   = []

    # Process a subset of runs
    # Process a given combination of conditions 
    for j,run in enumerate(runpersubject):
        
        epochs_list  = []
        for c,cond in enumerate(conditions):
            raw,event_id,SelEve = Trldef(wdir, cond, datasource[c],subject,run,j,badeeg)
            epochs   = Epoch(wdir, raw, SelEve, event_id.tolist(), -0.2, 1.1, -0.2, 0) 
            epochs_list.append(epochs)
            # baseline_list.append(baseline)
            del raw, event_id, SelEve
        
        # match the number of trial between conditions per run and per subject
        epochs_list_eq   = match_trialnb(epochs_list)  
        #baseline_list_eq = match_trialnb(baseline_list)  
        
        for c,cond in enumerate(conditions):
            epochs_list_eq[c].save(wdir + subject + "/mne_python/EPOCHS/" + modality +"_epochs_" +
                           conditions[c] + "_" + subject + '_' + run + "-epo.fif")






