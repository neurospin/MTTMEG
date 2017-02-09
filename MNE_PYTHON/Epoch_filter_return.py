# -*- coding: utf-8 -*-
"""
Created on Wed Oct 14 18:58:06 2015

@author: bgauthie
"""

def Epoch_filter_return(conditions,datasource,subject,runpersubject, badeeg, Filt):

    import matplotlib
    matplotlib.use('Agg')

    import mne
    import random
    import itertools
    import numpy as np
    import os   
    from scipy import io
    from copy import deepcopy

    os.chdir('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS/MNE_PYTHON')
    os.environ['SUBJECTS_DIR'] = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/mri'
    os.environ['MNE_ROOT'] = '/neurospin/local/mne'
    
    import MatchEventsFT2MNE as match

    wdir    = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"
    ft_wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/"

    # convert trial definition from fieldtrip .mat variable to mne-python
    def Trldef(wdir, condition, datasource, subject, run, runind, badEEG, Filt):

        # load trans_sss data, band-pass filter 1-35Hz,  Specify EEG bad channels
        raw = mne.io.Raw(wdir + subject + "/mne_python/preproc_" + run +
                        "_trans_sss_raw.fif", preload = True)
        raw.filter(l_freq=Filt -2, h_freq=Filt + 2, method = 'iir', n_jobs=5)
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

        # set the "zero point" to a target event in MNE event (FT to MNE sample matching strategy, because different zero time convention))
        # set the "zero point" to a target event in FT event
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
        SelEve[:,2].astype(int)
        event_id1 = np.intersect1d(SelEve[:,2].astype(int).tolist(),DATASET1[:,0].tolist())

        return raw, event_id1, SelEve


    def DoEpoch(wdir, raw, SelEve, event_id, epoch_tmin, epoch_tmax, baseline_tmin, baseline_tmax):
        
        # epoch data (I do not decimat the baseline in order to get more data to compute covariance)
        picks      = mne.pick_types(raw.info, meg=True,  eeg=True, stim=True , eog=False, include=[], exclude='bads')
        epochs     = mne.Epochs(raw, SelEve, event_id, epoch_tmin   , epoch_tmax , baseline=(baseline_tmin, baseline_tmax), picks = picks, preload = True, decim=5,reject = None,on_missing    = 'warning')

        return epochs
 

    def AvgAppend(wdir, epoch_list):
        for i in range(len(epoch_list)):

    	    # append one's subject's epochs and covariance matrices
            if i == 0:
                epoch_tot          = deepcopy(epoch_list[i])
            else:
                epoch_tmp          = epoch_list[i]
                epoch_tot._data    = np.vstack((epoch_tot._data ,epoch_tmp._data))
                epoch_tot.events   = np.vstack((epoch_tot.events,epoch_tmp.events))

        return epoch_tot	    

    def match_trialnb(epochs_list):
        
    mne.epochs.equalize_epoch_counts(epochs_list)
        
        return epochs_list
            
#############################################################################################################
########################################### Subfunctions Call ###############################################
######################################### General Processing ############################################# 
#############################################################################################################

    # test input
    #conditions    = ('EsDsq1G_QRT2','EsDsq2G_QRT2')
    #datasource    = ('EVS','EVS')
    #subject       = 'dm130250'
    #runpersubject = ('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD')
    #badeeg        = ('EEG025','EEG035')
    #meg_tag       = True
    #eeg_tag       = False


    # Process a single subject
    epochs_list_subj = []

    # Process a given combination of conditions 
    for j,run in enumerate(runpersubject):
        epochs_list  = []
        
        for c,cond in enumerate(conditions):
            raw,event_id,SelEve = Trldef(wdir, cond, datasource[c],subject,run,j,badeeg,Filt)
            epochs    = DoEpoch(wdir, raw, SelEve, event_id.tolist(), -0.2, 1.1, -0.2, 0) 
            epochs_list.append(epochs)
            del raw, event_id, SelEve
        
        # match the number of trial between conditions per run and per subject
        epochs_list_eq   = match_trialnb(epochs_list)  
        epochs_list_subj.append(epochs_list_eq)

    # append epochs of one condition for one subject
    for c,cond in enumerate(conditions):

        epochs2pool  = []
        epoch_tot    = []
    
        epochs2pool  = [epochs_list_subj[e][c] for e in range(len(epochs_list_subj))]
        epoch_tot    = AvgAppend(wdir, epochs2pool) 
        epoch_tot.save(wdir + subject + "/mne_python/EPOCHS/MEEG_epochs_" +
         conditions[c] + "_" + subject + "_" + str(Filt) + "Hz-epo.fif")

    return epoch_tot




