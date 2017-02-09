# -*- coding: utf-8 -*-
"""
Created on Wed Oct 28 18:38:17 2015

@author: bgauthie
"""

# adapted from
# http://martinos.org/mne/stable/auto_examples/decoding/plot_decoding_spatio_temporal_source.html


condcombs = ('Qt_all','Qs_all')
subject  = 'rb130313'
modality  = 'MEG'
Method    = 'dSPM'
    
def Decode2cond_nofilt(subject, condcombs, modality):

    import mne
    import numpy as np
    import itertools
    import os
    
    from mne.minimum_norm import apply_inverse_epochs, make_inverse_operator
    from sklearn.svm import SVC  # noqa
    from sklearn.cross_validation import cross_val_score, ShuffleSplit  
    import matplotlib
    matplotlib.use('Agg') 
    from matplotlib import pyplot as plt  
   
    wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"
    ###############################################################################
    ############################# SUBFUNCTIONS ####################################
    ###############################################################################
    def CatEpochs(subject, CondComb, Classes, Method, modality):
        
        snr = 3.0
        lambda2 = 1.0 / snr **2        
    
        if CondComb[0] != CondComb[1]:
            X,  Y, stcs = [], [], []
            epochs_list = []
            for c,cond in enumerate(CondComb):        

                epochs  = mne.read_epochs(wdir + subject + 
                                          "/mne_python/EPOCHS/MEEG_epochs_" + cond +
                                          '_' + subject + "-epo.fif")
                epochs.pick_types(meg=True)
                epochs_list.append(epochs)
                                                         
                # which modality? Import forward model accordingly
                if modality   == 'MEG':
                    fname_fwd = (wdir + subject +
                                 "/mne_python/run3_oct6_megonly_-fwd.fif") 
                elif modality == 'EEG':
                    fname_fwd = (wdir + subject +
                                 "/mne_python/run3_oct6_eegonly_-fwd.fif") 
                elif modality == 'MEEG':
                    fname_fwd = (wdir + subject +
                                 "/mne_python/run3_oct6_meeg_-fwd.fif")
                
                noise_cov = mne.read_cov((wdir + subject + "/mne_python/COVMATS/" +
                                         modality + "noisecov_" + cond + "_" +
                                         subject + "-cov.fif"))                 
                
                forward = mne.read_forward_solution(fname_fwd ,surf_ori=True)
                                               
                evoked = mne.read_evokeds((wdir + subject + "/mne_python/" + 
                 modality + "_" + cond  + "_" + subject 
                 + "-ave.fif"), baseline = (-0.2, 0))
                 
                inverse_operator  = make_inverse_operator(evoked[0].info,  
                                                              forward,
                                                              noise_cov,  
                                                              loose=0.2, 
                                                              depth=0.8)         
                                                                                             
        n_epochs  = len(epochs_list[0].events)*2
        n_times   = len(epochs_list[0].times)
        n_vertices = 8193
        X = np.zeros([n_epochs, n_vertices, n_times])  
        for condition_count, ep in zip([0, n_epochs / 2], epochs_list):
            stcs = apply_inverse_epochs(ep, inverse_operator, lambda2,
                            Method, pick_ori="normal",  # saves us memory
                            return_generator=True)
            for jj, stc in enumerate(stcs):
                X[condition_count + jj] = stc.data


            Y = np.repeat(range(len(CondComb)), len(X) / len(CondComb))   # belongs to the second class
            
            n_times = X.shape[2]
        
        return stc, n_times, X, Y
    
    def decode_2classes(X,Y, ntime, epochs):
    
        clf = SVC(C=1, kernel='linear')
        # Define a monte-carlo cross-validation generator (reduce variance):
        cv = ShuffleSplit(len(X), 10, test_size=0.2,random_state=0)
        
        scores = np.empty(ntime)
        std_scores = np.empty(ntime)
        
        for t in range(149,ntime):
            Xt = X[:, :, t]
            # Standardize features
            Xt -= Xt.mean(axis=0)
            Xt /= Xt.std(axis=0)
            # Run cross-validation
            # Note : for sklearn the Xt matrix should be 2d (n_samples x n_features)
            scores_t = cross_val_score(clf, Xt, Y, cv=cv, n_jobs=4)
            scores[t] = scores_t.mean()
            std_scores[t] = scores_t.std() 
        
        print 'done'      
    
        return scores, std_scores, clf.class_weight
    
    ###############################################################################
    ###############################################################################
    colors = ('b','r','g','k','c','m')  
    # classify for each 2-class combinations for mags
    for c,comb in enumerate(itertools.combinations(condcombs,2)):  
        scores, scores_std = [], []
        stc, n_times, X, Y = CatEpochs(subject, 
                                        comb, 
                                        range(2),
                                        Method, 
                                        modality)
        scores, scores_std = decode_2classes(X,Y,n_times,Stcs)
        
        plt.axhline(50, color='k', linestyle='--', label="Chance level")
        plt.axvline(0, color='k', label='stim onset')   
        plt.plot(stc.times*1000, scores*100, label="Score " +
                 " vs ".join([str(cond) for cond in comb]),linewidth=2.0, color= colors[c])
        plt.legend()
        hyp_limits = (scores*100 - scores_std*100, scores*100 + scores_std*100)
        plt.fill_between(stc.times*1000, hyp_limits[0], y2=hyp_limits[1], color= colors[c], alpha=0.2)
        plt.xlabel('Times (ms)')
        plt.ylabel('CV classification score (% correct)')
        plt.ylim([30, 100])
        plt.title('Sensor space decoding')
        
        PlotDir = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/decoding_context_yousra/MVPA_time/Plots/SOURCE/' 
        + '_vs_'.join([str(cond) for cond in comb]) + '/')  
        
        ScoreDir = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/decoding_context_yousra/MVPA_time/Scores/SOURCE/' 
        + '_vs_'.join([str(cond) for cond in comb]) + '/')  
        
        if not os.path.exists(PlotDir):
            os.makedirs(PlotDir)
            
        if not os.path.exists(ScoreDir):
            os.makedirs(ScoreDir)
            
        plt.savefig(PlotDir + subject + "_nofilt" + modality)
        plt.close()
        
        Scores = np.array(scores)
        np.save(ScoreDir + subject + "_nofilt"+modality,Scores)



