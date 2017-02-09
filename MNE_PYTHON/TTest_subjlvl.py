# -*- coding: utf-8 -*-
"""
Created on Thu Jul  7 16:04:31 2016

@author: bgauthie
"""

# -*- coding: utf-8 -*-

import mne
import os
import numpy as np

from scipy import stats as stats 
from mne.minimum_norm import apply_inverse_epochs, make_inverse_operator
from mne import spatial_tris_connectivity, grade_to_tris, compute_morph_matrix

wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"

def TTest_subjlvl(subject, condition, covsource,twin,modality):
    ###############################################################################
    ############################# SUBFUNCTIONS ####################################
    ###############################################################################
    def CatEpochs(subject, CondComb, covsource, method, modality,twin):
        
        snr = 3.0
        lambda2 = 1.0 / snr **2        
    
        if CondComb[0] != CondComb[1]:
            X,  stcs = [], []
            epochs_list, evoked_list, inverse_operator_list = [], [], []
            index = []
            for c,cond in enumerate(CondComb):        
    
                epochs  = mne.read_epochs(wdir + subject + 
                                          "/mne_python/EPOCHS/MEEG_epochs_icacorr_" + cond +
                                          '_' + subject + "-epo.fif")
                epochs.crop(tmin = twin[0], tmax = twin[1])
                index.append(len(epochs))            
                                             
                # which modality? Import forward model accordingly
                if modality   == 'MEG':
                    fname_fwd = (wdir + subject +
                                 "/mne_python/run3_ico5_megonly_icacorr_-fwd.fif")
                    megtag = True
                    eegtag = False
                    epochs.pick_types(meg=megtag, eeg = eegtag)
                elif modality == 'EEG':
                    fname_fwd = (wdir + subject +
                                 "/mne_python/run3_ico5_eegonly_icacorr_-fwd.fif") 
                    megtag = False
                    eegtag = True
                    epochs.pick_types(meg=megtag, eeg = eegtag)
                elif modality == 'MEEG':
                    fname_fwd = (wdir + subject +
                                 "/mne_python/run3_ico5_meeg_icacorr_-fwd.fif")
                    megtag = True
                    eegtag = True
                    epochs.pick_types(meg=megtag, eeg = eegtag)
                
                epochs_list.append(epochs)
                
                # import nose_cov
                noise_cov = mne.read_cov((wdir + subject + "/mne_python/COVMATS/" +
                                         modality + "_noisecov_icacorr_" + covsource + "_" +
                                         subject + "-cov.fif"))   
                # import forward
                forward = mne.read_forward_solution(fname_fwd ,surf_ori=True)
                 
                # load  epochs, then pick    
                picks = mne.pick_types(epochs.info, meg=megtag,  eeg=eegtag, stim=False , eog=False)
        
                # compute evoked
                evoked       = epochs.average(picks = picks)   
                evoked_list.append(evoked)                           
                
                # compute inverse operator
                inverse_operator  = make_inverse_operator(evoked.info,  
                                                              forward,
                                                              noise_cov,  
                                                              loose=0.2, 
                                                              depth=0.8) 
                inverse_operator_list.append(inverse_operator)
                                                                                             
        n_epochs  = len(epochs_list[0].events)+len(epochs_list[1].events)
        n_times   = len(epochs_list[0].times)
        n_vertices = forward['nsource']
        X = np.zeros([n_epochs, n_vertices, n_times]) 
        
        for condition_count, ep in zip([0, epochs_list[0].events.shape[0]], epochs_list):
            print(str(condition_count))
            print(str(ep))
            
            stcs = apply_inverse_epochs(ep, inverse_operator, lambda2,
                            method, pick_ori=None,  # saves us memory
                            return_generator=True)
                            
            for jj, stc in enumerate(stcs):
                X[condition_count + jj] = stc.data
    
            Y = np.repeat(range(len(CondComb)), len(X) / len(CondComb))   
            n_times = X.shape[2]
        
        return stc, n_times, X, Y, forward, index
    ###############################################################################
    ###############################################################################
    def sublevel_spatial_stats(X,subject,index,stc,clust_p,modality,method,condition):
        
        con = mne.spatial_tris_connectivity(grade_to_tris(5))
       
        # morphing data
        subjects_dir = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/mri/'
       
        fsave_vertices = [np.arange(10242), np.arange(10242)]  
        subject_vertices  = [stc.lh_vertno,stc.rh_vertno]
        morph_mat = compute_morph_matrix(subject, 'fsaverage', subject_vertices,
                                         fsave_vertices, 20, subjects_dir)
        n_vertices_fsave = morph_mat.shape[0]
        
        nobs      = index[0]
        ncond     = len(index) 
        ntimes    = X.shape[2]
        nvertices = stc.lh_vertno.shape[0]+stc.rh_vertno.shape[0]
        
        #    We have to change the shape for the dot() to work properly
        X = np.transpose(X,[1,2,0]) # vertices * times * obs
        X = X.reshape(nvertices, ntimes * nobs * ncond)
        print('Morphing data.')
        X = morph_mat.dot(X)  # morph_mat is a sparse matrix
        X = X.reshape(n_vertices_fsave, ntimes, nobs, ncond)   
       
        # list of array of shapes ncond*(obs, time, vertices)
        X = np.transpose(X, [2,1,0,3])
        X = [np.squeeze(x) for x in np.split(X, 2, axis=-1)]
        
        # average over time to clusterize only on spatial dimension
        X = [np.mean(x,1) for x in X]
    
        p_threshold = clust_p
        t_threshold = stats.distributions.f.ppf(1-p_threshold/2, nobs -1,nobs-1)
        
        # use default function one-way anova (not repeated measures!)
        T_obs, clu, clu_p_val, H0  = mne.stats.permutation_cluster_test(X, threshold=t_threshold,
                                                                        connectivity=con, n_jobs=4,
                                                                        verbose=True, seed = 666) 
                                                                        
        wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"
        save_path = (wdir+ subject+'/mne_python/STATS')  
        
        if not os.path.exists(save_path):
            os.makedirs(save_path)  
        
        # save cluster stats
        spatial_clust_T = np.array((T_obs, clu, clu_p_val, H0))
        np.save((save_path+'/' + modality + '_' +'cluster_stats_'+ "_vs_".join(condition)),spatial_clust_T)        
        
        # save F-Map                                                
        tmp = T_obs
        tmp = tmp[:,np.newaxis]
        fsave_vertices = [np.arange(10242), np.arange(10242)]
        stc_Ftest = mne.SourceEstimate(tmp,fsave_vertices,0,stc.tstep) 
        stc_Ftest.save((save_path + '/'  + modality + '_' + "_vs_".join(condition)))
        
        # to create probability maps: threshold the map at p < 0.05 and binarize    
        ind      = np.where(np.abs(T_obs) >= t_threshold)[0]
        VertKept = np.empty((len(T_obs)))
        for v, vertices in enumerate(VertKept):
            if v in ind:
                VertKept[v] = 1
            else:
                VertKept[v] = 0
                
        VertKept = VertKept[:,np.newaxis]
        fsave_vertices = [np.arange(10242), np.arange(10242)]
        stc_Ttest = mne.SourceEstimate(VertKept,fsave_vertices,0,stc.tstep) 
        stc_Ttest.save((save_path + '/' + modality + '_' + 'BinForProb_' + "_vs_".join(condition)))    
            
        return T_obs, clu, clu_p_val, H0  
    
    ###############################################################################    
    ################################ MAIN SCRIPT ##################################
    ###############################################################################    
    #ListSubj   = ('sd130343', 'cb130477', 'rb130313', 'jm100042', 
    #        'jm100109', 'sb120316', 'tk130502', 'lm130479', 
    #        'ms130534', 'ma100253', 'sl130503', 'mb140004',
    #        'mp140019', 'dm130250', 'hr130504', 'wl130316',
    #        'rl130571','sg120518','mm130405')
    #condition  = ('EsWest','EsPar','EsEast')   
    #covsource  = 'EV'
    method     = 'dSPM'
    #twin       = (0.5,1)
    clust_p    = 0.05
    #      
    #for s, subject in enumerate(ListSubj):  
        
    # single trial source reconstruction in nativ espace for each condition
    stc, n_times, X, Y, forward, index = CatEpochs(subject, condition, covsource,
                                                method, modality,twin)  
    # F-test and spatial clustering after smooting and morhing on fsaverage                                            
    F_obs, clu, clu_p_val, H0 = sublevel_spatial_stats(X,subject,index,stc,clust_p,modality,method,condition)
    
    
        
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    