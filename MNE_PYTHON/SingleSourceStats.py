# -*- coding: utf-8 -*-
"""
Created on Tue Feb  2 14:19:48 2016

@author: bgauthie
"""

import mne
import os
import numpy as np

from scipy import stats as stats 
from mne.minimum_norm import apply_inverse_epochs, make_inverse_operator
from mne import spatial_tris_connectivity, grade_to_tris


def  SingleSourceStats(subject, CondComb, CovSource, Method, modality):
   
    wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"
    ###############################################################################
    ############################# SUBFUNCTIONS ####################################
    ###############################################################################
    def CatEpochs(subject, CondComb, CovSource, Method, modality):
        
        snr = 3.0
        lambda2 = 1.0 / snr **2        
    
        if CondComb[0] != CondComb[1]:
            X,  stcs = [], []
            epochs_list, evoked_list, inverse_operator_list = [], [], []
            for c,cond in enumerate(CondComb):        
    
                epochs  = mne.read_epochs(wdir + subject + 
                                          "/mne_python/EPOCHS/MEEG_epochs_" + cond +
                                          '_' + subject + "-epo.fif")
                epochs.crop(tmin = 0, tmax = 0.9)
                                                         
                # which modality? Import forward model accordingly
                if modality   == 'MEG':
                    fname_fwd = (wdir + subject +
                                 "/mne_python/run3_oct6_megonly_-fwd.fif")
                    megtag = True
                    eegtag = False
                    epochs.pick_types(meg=megtag, eeg = eegtag)
                elif modality == 'EEG':
                    fname_fwd = (wdir + subject +
                                 "/mne_python/run3_ico-5_eegonly_-fwd.fif") 
                    megtag = False
                    eegtag = True
                    epochs.pick_types(meg=megtag, eeg = eegtag)
                elif modality == 'MEEG':
                    fname_fwd = (wdir + subject +
                                 "/mne_python/run3_ico-5_meeg_-fwd.fif")
                    megtag = True
                    eegtag = True
                    epochs.pick_types(meg=megtag, eeg = eegtag)
                
                epochs_list.append(epochs)
                
                # import nose_cov
                noise_cov = mne.read_cov((wdir + subject + "/mne_python/COVMATS/" +
                                         modality + "_noisecov_" + CovSource + "_" +
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
                                                                                             
        n_epochs  = len(epochs_list[0].events)*2
        n_times   = len(epochs_list[0].times)
        n_vertices = forward['nsource']
        X = np.zeros([n_epochs, n_vertices, n_times])  
        for condition_count, ep in zip([0, n_epochs / 2], epochs_list):
            stcs = apply_inverse_epochs(ep, inverse_operator, lambda2,
                            Method, pick_ori="normal",  # saves us memory
                            return_generator=True)
            for jj, stc in enumerate(stcs):
                X[condition_count + jj] = stc.data
    
    
            Y = np.repeat(range(len(CondComb)), len(X) / len(CondComb))   # belongs to the second class
            n_times = X.shape[2]
        
        return stc, n_times, X, Y, forward
        
    ###############################################################################
    def subject_Ttest(X,Y,forward,stc,CondComb):
    
        # Compute statistic
        np.random.seed(42)
        
        # compute subject-by-subject difference            
        X = X[0:(len(X)/2),:,:] - X[len(X)/2:len(X),:,:]
        
        # smooth the data (optional)
        #fsave_vertices = [np.arange(10242), np.arange(10242)]
        #morph_mat = compute_morph_matrix('sample', 'fsaverage', sample_vertices,
        #                                 fsave_vertices, 20, subjects_dir)
        #n_vertices_fsave = morph_mat.shape[0]
        
        # optional: restrict computation to temporal window of interest
        #lower_bound = np.where(stc0.times >= 0.4)[0][0]
        #upper_bound = np.where(stc0.times >= 0.9)[0][0]
        #X = X[:,lower_bound:upper_bound,:]
        
        con = mne.spatial_src_connectivity(forward['src'])
        #con = spatial_tris_connectivity(grade_to_tris(5))
        X = np.transpose(X, [0, 2, 1])
        	
        p_threshold = 0.05
        t_threshold = -stats.distributions.t.ppf(p_threshold / 2., X.shape[0] -1)
        n_permutations = 1024
        
        T_obs, clusters, cluster_p_values, H0  = mne.stats.spatio_temporal_cluster_1samp_test(X, connectivity=con, n_jobs=1,
        	                                       threshold=t_threshold, n_permutations=n_permutations, verbose=True)                                       
    
        # Replace the values & # save the stc
        tmp = np.transpose(np.mean(X,axis = 0),[1,0])
        fsave_vertices = [np.arange(len(stc.vertices[0])), np.arange(len(stc.vertices[1]))]
        stc_Diff = mne.SourceEstimate(tmp,fsave_vertices,stc.tmin,stc.tstep)   
        PlotDir = []
        PlotDir = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/' + subject + '/mne_python/STCS_diff/fromsingle_'
                   + CondComb[0] + '-' + CondComb[1]) 
                   
        if not os.path.exists(PlotDir):
            os.makedirs(PlotDir)    
            
        stc_Diff.save(PlotDir + '/' + modality + '_' + Method + '_' + subject 
                    + '_' + CondComb[0] + '-' + CondComb[1] 
                    + '_' + '_ico-5-fwd-fsaverage-'
                    +'.stc')  
        
        
        return T_obs, clusters, cluster_p_values, H0         
        
    ###########################################################################     
    def save_object(obj, filename):
        import pickle
        with open(filename, 'wb') as output:
            pickle.dump(obj, output, pickle.HIGHEST_PROTOCOL)        
    ###########################################################################    
        
    stc, n_times, X, Y, forward = CatEpochs(subject, CondComb, CovSource, Method, modality)
    T_obs, clusters, cluster_p_values, H0 = clu = subject_Ttest(X,Y,forward,stc,CondComb)   
    
    PlotDir = []
    PlotDir = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/' + subject + '/mne_python/CLUST/'
               + "-".join([cond for cond in CondComb])) 
    
    if not os.path.exists(PlotDir):
        os.makedirs(PlotDir)   
    
    save_object(clu, (PlotDir + '/spatio_temporal_cluster_1samp_test'))
    stc.save(PlotDir + '/spatio_temporal_cluster_1samp_test-forplot')
  
