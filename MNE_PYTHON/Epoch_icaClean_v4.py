# -*- coding: utf-8 -*-
"""
Created on Fri Sep 30 18:31:51 2016

@author: bgauthie
"""


# -*- coding: utf-8 -*-
"""
Created on Wed Mar 30 18:45:58 2016

@author: bgauthie
"""

def Epoch_icaClean_v4(conditions,datasource,subject,runpersubject,r, badeeg):

    import matplotlib
    matplotlib.use('Agg')

    import mne
    # import random
    # import itertools
    import numpy as np
    import os   
    from scipy import io
    from copy import deepcopy
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
        raw = mne.io.Raw(wdir + subject + "/" + run +
                        "ICAcorr_trans_sss.fif",preload = True)
        raw.filter(l_freq=None, h_freq=30, method = 'iir')
        raw.info['bads'] += badEEG    
        if subject == 'cb130477':
            'fixme'
        else:
            raw.interpolate_bads(reset_bads = False) 
        # define events : import trial definition from fieldtrip processing and with mne_function
        # find events corresponding to run j for FT events definition       
        fileE = io.loadmat(ft_wdir + 'Subjects/' + subject + "/PsychData/events_ICAcorr_run" +
                        str(runind+1) + "_v2.mat")
        eventsFT = fileE['fullsubj'] 
        eventsMNE = mne.find_events(raw, stim_channel=['STI101'],consecutive = False)     
        itemindex = np.where(eventsFT[:,7]==(runind+1))
        eventsFT = eventsFT[itemindex[0],:]

        # set the "zero point" to a target event in MNE event (FT to MNE sample matching strategy, because different zero time convention))
        # set the "zero point" to a target event in FT event
        # FIXME
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
                    'QTS':[7,9,11,13,15],
                    'REF':[1,2,3,4,5]}

        # find events corresponding to original "Historical events" stimuli
        # reject bad trial based on previous fieldtrip "ft_rejectvisual"
        index_list2 = []
        index_list  = [np.where(eventsFT[:,6] == k)[0].tolist() for k in origtrig[datasource]]
        for i in range(len(origtrig[datasource])):
            index_list2.extend(index_list[i]) 
        eventsFT = eventsFT[index_list2,:]
        badtrials = []
        badtrials = eventsFT[:,8]+eventsFT[:,9] 
        eventsFT = eventsFT[np.where(badtrials== 2)[0],:] # add eegbad

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


    #def CovCompute(wdir, epochs, baseline, epoch_tmin, epoch_tmax, baseline_tmin, baseline_tmax):

        # compute noise covariance matrix from baseline epochs (MNE,dSPM,sLORETA) and activation epochs (LCMV) 
        # evoked     = epochs.average()
        # noise_cov  = mne.compute_covariance(baseline, keep_sample_mean=True, tmin=baseline_tmin, tmax=baseline_tmax,method = 'auto')
        # data_cov   = mne.compute_covariance(epochs  , keep_sample_mean=True, tmin=epoch_tmin   , tmax=epoch_tmax   ,method = 'auto')  
        # noise_cov  = mne.cov.regularize(noise_cov,  evoked.info,  grad=0.1, mag=0.1, eeg=0.1)
        # data_cov   = mne.cov.regularize(data_cov,   evoked.info,  grad=0.1, mag=0.1, eeg=0.1)

        #return noise_cov, data_cov 
 

    def EpochAppend(wdir, epoch_list):
        
        for i in range(len(epoch_list)):
            if i == 0:
                epoch_tot          = deepcopy(epoch_list[i])
            else:
                epoch_tmp          = epoch_list[i]
                epoch_tot._data    = np.vstack((epoch_tot._data ,epoch_tmp._data))
                epoch_tot.events   = np.vstack((epoch_tot.events,epoch_tmp.events))

        return epoch_tot
	    

    #def writeInverse(wdir, epoch, noise_cov, data_cov, modality, Subj, condnames):
	
        #if modality == 'MEG':
        #    mod = 'meg'
        #    fname_fwd  = (wdir+Subj+"/mne_python/run3_ico-5_megonly_-fwd.fif") 
        #elif modality == 'EEG':
        #    mod = 'eeg'
        #    fname_fwd  = (wdir+Subj+"/mne_python/run3_ico-5_eegonly_-fwd.fif") 
        #elif modality == 'MEEG':
        #    mod = 'meeg'
        #    fname_fwd = (wdir+Subj+"/mne_python/run3_ico-5_meeg_-fwd.fif")

        # save evoked data
        #evoked            = epoch.average()
        #mne.write_evokeds(wdir+Subj+"/mne_python/"+ modality +"_"+condnames+"_"+Subj+"-ave.fif",evoked)

        #compute noise covariance matrix from baseline & epochs 
        #noise_cov.save(wdir+Subj+"/mne_python/COVMATS/"+ modality +"noisecov_"+condnames+"_"+Subj+"-cov.fif")
        #data_cov.save(wdir+Subj+"/mne_python/COVMATS/"+ modality +"datacov_"+condnames+"_"+Subj+"-cov.fif")
        
        # save a covariance picture for visual inspection
        #mne.viz.plot_cov(noise_cov, epoch.info, colorbar=True, proj=True,show_svd=False,show=False)
        #pl.savefig("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"+Subj+"/plots_cov/"+modality+"_"+Subj+"_covmat")
        #pl.close()

        # compute and save inverse operators
        #forward           = mne.read_forward_solution(fname_fwd,surf_ori=True)
        #inverse_operator  = make_inverse_operator(evoked.info,  forward, noise_cov,  loose=0.2, depth=0.8)
        #write_inverse_operator(wdir+Subj+"/mne_python/INVS/"+condnames+"_"+ mod +"_ico5-inv.fif",inverse_operator)



        
#        # wouhou! list comprehension!
#        nbtrial          = [epochs_list[i].events.shape[0] for i in range(len(epochs_list))]
#        n_event_toremove = [epochs_list[i].events.shape[0]-np.min(nbtrial) for i in range(len(epochs_list))]
#	
#        # prioritize the removal of event that aren't matched by design construction
#        event_list  = [epochs_list[c].event_id.values() for c in range(len(epochs_list))]
#        
#        # for that compute global intersection of event codes
#        # currently works fine to match 3 cond, need to be generalized (FIXME)
#        # at first, generate all conditions couples, then get common historical events
#        # do it again until intersection remain the same
#        
#        combevent   = list(itertools.combinations(event_list, 2))
#        intersect   = [np.intersect1d([combevent[ce][0][n]/1000 for n in range(len(combevent[ce][0]))],
#        [combevent[ce][1][n]/1000 for n in range(len(combevent[ce][1]))]) for ce in range(len(combevent))]
#        combevent2  = list(itertools.combinations(intersect, 2))
#        intersect2  = [np.intersect1d([combevent2[ce][0][n] for n in range(len(combevent2[ce][0]))],
#        [combevent2[ce][1][n] for n in range(len(combevent2[ce][1]))]) for ce in range(len(combevent2))]
#        combevent3  = list(itertools.combinations(intersect2, 2))
#        blah  = [np.intersect1d([combevent3[ce][0][n] for n in range(len(combevent3[ce][0]))],
#        [combevent3[ce][1][n] for n in range(len(combevent3[ce][1]))]) for ce in range(len(combevent3))]
#        if len(nbtrial) == 2:
#            blah = intersect
#
#        # for each condition, set a list of events you will remove first (index_ok_rm)
#        # and a list of event to keep if possible (index_kept_prio)
#        index_kept_prio             = blah[0]
#        index_ok_rm                 = []
#        index_kept_prio_percond     = []
#        for c in range(len(epochs_list)):
#            event_tag, event_ok_rm, event_kept_prio = [], [], []
#            event_tag        = np.transpose([event_list[c][n]/1000 for n in range(len(event_list[c]))], axes = 0)
#            event_ok_rm      = [x for x in event_tag if x not in index_kept_prio]
#            event_kept_prio  = [x for x in event_tag if x in index_kept_prio]
#            index_ok_rm.append([np.where(event_tag == event_ok_rm[n])[0][0] for n in range(len(event_ok_rm))])
#            index_kept_prio_percond.append([np.where(event_tag == event_kept_prio[n])[0][0] for n in range(len(event_kept_prio))])
#
#        # remove events for each condition to match trial number between condition according to removal priority
#        event_toremove_ind = []
#        for c in range(len(epochs_list)):
#            if n_event_toremove[c] > 0:
#                if n_event_toremove[c] <= len(index_ok_rm[c]):
#                    event_toremove_ind.append(random.sample(index_ok_rm[c], n_event_toremove[c].astype(int)))  
#                    epochs_list[c].drop_epochs(event_toremove_ind[c]) 
#                elif n_event_toremove[c] > len(index_ok_rm[c]):
#                    tmp2rm = []
#                    tmp2rm = random.sample(index_kept_prio_percond[c], n_event_toremove[c] - len(index_ok_rm[c]))
#                    event_toremove_ind.append(index_ok_rm[c])
#                    event_toremove_ind[c].extend(tmp2rm)   
#                    epochs_list[c].drop_epochs(event_toremove_ind[c]) 
#            else:
#                    event_toremove_ind.append([])
        
    def match_trialnb(epochs_list):        
        # still need to do something fancier but let's find some results before the fancy stuff...
        mne.epochs.equalize_epoch_counts(epochs_list)
        
        return epochs_list
            
#############################################################################################################
########################################### Subfunctions Call ###############################################
######################################### General Processing ################################################ 
#############################################################################################################

    # Test parameters
    
    #subject       = 'cb130477'
    #runpersubject = ('run1_GD','run2_GD','run3_DG','run4_DG')
    #badeeg        = ['EEG035', 'EEG036']
    #conditions    = ('RefPast','RefPre','RefFut')
    #datasource    = ('REF','REF','REF')
    #meg_tag        = 'True'
    #eeg_tag        = 'True'
    modality = 'MEEG'

    # Process a single subject
    # epochs_list_subj, noise_cov_list_subj, data_cov_list_subj = [], [], []
    epochs_list_subj = []

    # Process a subset of runs
    # Process a given combination of conditions 
    for j,run in enumerate(runpersubject):
        epochs_list  = []
        tag_match    = 0
        
        for c,cond in enumerate(conditions):
            raw, event_id, SelEve = [], [], [] 
            raw, event_id, SelEve = Trldef(wdir, cond, datasource[c],subject,run,r[j],badeeg)
            epochs_list.append(Epoch(wdir, raw, SelEve, event_id.tolist(), -0.2, 5, -0.2, 0)) 
            #(epochs)
            # baseline_list.append(baseline)
        
        for c,cond in enumerate(conditions):
            if epochs_list[c].events.shape[0]  == 1:  
                tag_match = 1
        
        if tag_match == 0:
        # match the number of trial between conditions per run and per subject
            epochs_list_subj.append(match_trialnb(epochs_list))  
        #baseline_list_eq = match_trialnb(baseline_list)  
    
        #noise_cov_list, data_cov_list   = [], []
        # compute covariance on trialnb-matched epochs
        #for c in range(len(conditions)):
        #    noise_cov, data_cov = CovCompute(wdir, epochs_list_eq[c], baseline_list_eq[c], -0.2, 1.1, -0.2, 0) 
        #    noise_cov_list.append(noise_cov)
        #    data_cov_list.append(data_cov)
    
        #noise_cov_list_subj.append(noise_cov_list)
        #data_cov_list_subj.append(data_cov_list)

    # pool epochs and covariance of all runs of a given conditions
    # write inverse solution, save evoked (avg epochs) and covariance matrices
    for c,cond in enumerate(conditions):

        # epochs2pool  = []
        # epoch_tot    = []
           
        # epochs2pool    = 
        #noise_cov2pool = [noise_cov_list_subj[e][c] for e in range(len(noise_cov_list_subj))]
        #data_cov2pool  = [data_cov_list_subj[e][c] for e in range(len(data_cov_list_subj))]
        epoch_tot = mne.epochs.concatenate_epochs([epochs_list_subj[e][c] for e in range(len(epochs_list_subj))])
        epoch_tot.save(wdir + subject + "/mne_python/EPOCHS/" + modality +"_epochs_icacorr_" +
                       conditions[c] + "_" + subject + "-epo.fif")

        #writeInverse(wdir, epoch_tot, noise_cov_tot, data_cov_tot,modality, subject, conditions[c])
        del epoch_tot





