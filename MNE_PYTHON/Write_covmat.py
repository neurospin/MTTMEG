# -*- coding: utf-8 -*-
"""
Created on Tue Jan 19 17:11:22 2016

@author: bgauthie
"""

def Write_covmat(datasource,subject,runpersubject, badeeg, meg_tag, eeg_tag):

    import matplotlib
    matplotlib.use('Agg')

    import mne
    # import random
    # import itertools
    import numpy as np
    import os   
    from scipy import io
    #from copy import deepcopy
    # from mne.minimum_norm import (make_inverse_operator, write_inverse_operator)
    # from matplotlib import pyplot as pl

    os.chdir('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS/MNE_PYTHON')
    os.environ['SUBJECTS_DIR'] = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/mri'
    os.environ['MNE_ROOT'] = '/neurospin/local/mne'
    
    import MatchEventsFT2MNE as match

    wdir    = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"
    ft_wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/"

    # convert trial definition from fieldtrip .mat variable to mne-python
    def Trldef(wdir, datasource, subject, run, runind, badEEG):

        # load trans_sss data, band-pass filter 1-30Hz,  Specify EEG bad channels
        raw = mne.io.Raw(wdir + subject + "/mne_python/preproc_" + run +
                        "_trans_sss_raw.fif", preload = True)
        raw.filter(l_freq=None, h_freq=30, method = 'iir', n_jobs=4)
        raw.info['bads'] += badEEG     
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
        initsampmne = eventsMNE[np.where(eventsMNE[:,2] == 18)[0][0],0]
        eventsMNE[:,0] = [eventsMNE[l,0]-initsampmne for l in range(eventsMNE.shape[0])]
        initsampft = eventsFT[np.where(eventsFT[:,6] == 18)[0][0],0]
        eventsFT[:,0] = [eventsFT[l,0]-initsampft for l in range(eventsFT.shape[0])]

        # Select original event trigger according to the condition and the source dataset
        origtrig = {'EV':[16,20,24,28,32,17,21,25,29,33,18,22,26,30,34,19,23,27,31,35],
                    'QT':[6,8,10,12,14,7,9,11,13,15]}

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

        # get trials corresponding to the wanted condition
        SelEve = SelEve.astype(int)

        return raw, SelEve


    def Epoch(wdir, raw, SelEve, event_id, epoch_tmin, epoch_tmax, baseline_tmin, baseline_tmax):
        
        # epoch data (I do not decimat the baseline in order to get more data to compute covariance)
        picks      = mne.pick_types(raw.info, meg=True,  eeg=True, stim=True , eog=False, include=[], exclude='bads')
        #epochs     = mne.Epochs(raw, SelEve, event_id, epoch_tmin   , epoch_tmax   , baseline=(baseline_tmin, baseline_tmax), picks = picks, preload = True, decim=5,reject = None,on_missing    = 'warning')
        baseline   = mne.Epochs(raw, SelEve, None, baseline_tmin, baseline_tmax, baseline=(None, 0)                     , picks = picks, preload = True, reject = None, on_missing = 'warning')

        return baseline


    def CovCompute(wdir, baseline, epoch_tmin, epoch_tmax, baseline_tmin, baseline_tmax):

        # compute noise covariance matrix from baseline epochs (MNE,dSPM,sLORETA) and activation epochs (LCMV) 
        # evoked     = epochs.average()
        noise_cov  = mne.compute_covariance(baseline, keep_sample_mean=True, tmin=baseline_tmin,
                                            tmax=baseline_tmax,method = 'shrunk')
        # data_cov   = mne.compute_covariance(epochs  , keep_sample_mean=True, tmin=epoch_tmin   , tmax=epoch_tmax   ,method = 'auto')  
        # noise_cov  = mne.cov.regularize(noise_cov,  evoked.info,  grad=0.1, mag=0.1, eeg=0.1)
        # data_cov   = mne.cov.regularize(data_cov,   evoked.info,  grad=0.1, mag=0.1, eeg=0.1)

        return noise_cov
 

    def CovAppend(wdir, noise_cov_list):
        for i in range(len(noise_cov_list)):

    	    # append one's subject's epochs and covariance matrices
            if i == 0:
                # epoch_tot          = deepcopy(epoch_list[i])
                NCOV_tot           = noise_cov_list[i]
                # DCOV_tot           = data_cov_list[i]
            else:
                #epoch_tmp          = epoch_list[i]
                #epoch_tot._data    = np.vstack((epoch_tot._data ,epoch_tmp._data))
                #epoch_tot.events   = np.vstack((epoch_tot.events,epoch_tmp.events))
                NCOV_tot['data']    += noise_cov_list[i]['data']
                NCOV_tot['nfree']   += noise_cov_list[i]['nfree']
                NCOV_tot            = NCOV_tot + noise_cov_list[i]
                # DCOV_tot['data']    += data_cov_list[i]['data']
                # DCOV_tot['nfree']   += data_cov_list[i]['nfree']
                # DCOV_tot            = DCOV_tot + data_cov_list[i]

        return NCOV_tot
	    

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



            
#############################################################################################################
########################################### Subfunctions Call ###############################################
######################################### General Processing ################################################ 
#############################################################################################################

    #subject       = 'rb130313'
    #runpersubject = ('run2_GD','run3_DG','run4_DG')
    #badeeg        = ['EEG025', 'EEG035',  'EEG036']
    #datasource    = ('QT')
    #meg_tag        = 'True'
    #eeg_tag        = 'True'
    modality = 'MEEG'

    # Process a single subject
    # epochs_list_subj, noise_cov_list_subj, data_cov_list_subj = [], [], []
    baseline_list_subj  = []
    noise_cov_list_subj = []

    # Process a subset of runs
    # Process the baseline of all conditions
    for j,run in enumerate(runpersubject):
        baseline_list  = []
        
        raw,SelEve = Trldef(wdir, datasource,subject,run,j,badeeg)
        baseline   = Epoch(wdir, raw, SelEve, None, -0.2, 1.1, -0.2, 0) 
        #epochs_list.append(epochs)
        baseline_list.append(baseline)
        del raw, SelEve
        
        # match the number of trial between conditions per run and per subject
        baseline_list_subj.append(baseline_list)
        
        # compute covariance on trialnb-matched epochs
        noise_cov = []
        noise_cov = CovCompute(wdir, baseline_list, -0.2, 1.1, -0.2, 0) 
        noise_cov_list_subj.append(noise_cov)

    # pool epochs and covariance of all runs of a given conditions
    # write inverse solution, save evoked (avg epochs) and covariance matrices

    noise_cov2pool = [noise_cov_list_subj[e] for e in range(len(noise_cov_list_subj))]

    noisecov_tot = CovAppend(wdir, noise_cov2pool) 
    noisecov_tot.save(wdir + subject + "/mne_python/COVMATS/" + modality +"_noisecov_" +
                       datasource + "_" + subject + "-cov.fif")

    #writeInverse(wdir, epoch_tot, noise_cov_tot, data_cov_tot,modality, subject, conditions[c])
    del noisecov_tot





