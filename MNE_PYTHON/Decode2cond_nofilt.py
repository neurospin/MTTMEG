# -*- coding: utf-8 -*-
"""
Created on Mon Oct 26 15:58:56 2015

@author: bgauthie
"""
# adapted from
# http://martinos.org/mne/stable/auto_examples/decoding/plot_decoding_sensors.html

def Decode2cond_nofilt(subject, condcombs, modality):

    import mne
    import numpy as np
    import itertools
    import os
    
    from sklearn.svm import SVC  # noqa
    from sklearn.cross_validation import cross_val_score, ShuffleSplit  
    import matplotlib
    matplotlib.use('Agg') 
    from matplotlib import pyplot as plt  
   
    ###############################################################################
    ############################# SUBFUNCTIONS ####################################
    ###############################################################################
    def CatEpochs(Subject, CondComb, Classes, modality):
    
        if CondComb[0] != CondComb[1]:
            ClassesList = []
            EpochsList  = []
            for c,cond in enumerate(CondComb):
                Epochs = []           
                Epochs = mne.read_epochs("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/" + 
                Subject + "/mne_python/EPOCHS/MEEG_epochs_" + cond + "_" + 
                subject + "-epo.fif") 
                EpochsList.append(Epochs)
                ClassesList.append(np.ones(len(Epochs.events))*Classes[c])
              
            if modality == 'mag' or modality == 'grad':
                picks = mne.pick_types(Epochs.info, meg=modality, eeg=False)
            elif modality == 'EEG':
                picks = mne.pick_types(Epochs.info, meg=False, eeg=True)
            elif modality == 'combined':
                picks = mne.pick_types(Epochs.info, meg=True, eeg=True)  
              
            X = [e.get_data()[:, picks, :] for e in EpochsList]
            X1 = np.concatenate(X)
            Y = np.concatenate(ClassesList)
            n_times = len(EpochsList[0].times)
        
        return Epochs, n_times, X1, Y
    
    def decode_2classes(X,Y, ntime, epochs):
    
        clf = SVC(C=1, kernel='linear')
        # Define a monte-carlo cross-validation generator (reduce variance):
        cv = ShuffleSplit(len(X), 10, test_size=0.2,random_state=0)
        
        scores = np.empty(n_times)
        std_scores = np.empty(n_times)
        
        for t in range(n_times):
            Xt = X[:, :, t]
            # Standardize features
            Xt -= Xt.mean(axis=0)
            Xt /= Xt.std(axis=0)
            # Run cross-validation
            # Note : for sklearn the Xt matrix should be 2d (n_samples x n_features)
            scores_t = cross_val_score(clf, Xt, Y, cv=cv, n_jobs=5)
            scores[t] = scores_t.mean()
            std_scores[t] = scores_t.std() 
        
        print 'done'      
    
        return scores, std_scores
    
    ###############################################################################
    ###############################################################################
    colors = ('b','r','g','k','c','m')  
    # classify for each 2-class combinations for mags
    for c,comb in enumerate(itertools.combinations(condcombs,2)):  
        scores, scores_std = [], []
        Epochs, n_times, X, Y = CatEpochs(subject, comb, range(2),modality)
        scores, scores_std = decode_2classes(X,Y,n_times,Epochs)
        
        plt.axhline(50, color='k', linestyle='--', label="Chance level")
        plt.axvline(0, color='k', label='stim onset')   
        plt.plot(Epochs.times*1000, scores*100, label="Score " +
                 " vs ".join([str(cond) for cond in comb]),linewidth=2.0, color= colors[c])
        plt.legend()
        hyp_limits = (scores*100 - scores_std*100, scores*100 + scores_std*100)
        plt.fill_between(Epochs.times*1000, hyp_limits[0], y2=hyp_limits[1], color= colors[c], alpha=0.2)
        plt.xlabel('Times (ms)')
        plt.ylabel('CV classification score (% correct)')
        plt.ylim([30, 100])
        plt.title('Sensor space decoding')
        
        PlotDir = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/decoding_context_yousra/MVPA_time/Plots/' 
        + '_vs_'.join([str(cond) for cond in comb]) + '/')  
        
        ScoreDir = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/decoding_context_yousra/MVPA_time/Scores/' 
        + '_vs_'.join([str(cond) for cond in comb]) + '/')  
        
        if not os.path.exists(PlotDir):
            os.makedirs(PlotDir)
            
        if not os.path.exists(ScoreDir):
            os.makedirs(ScoreDir)
            
        plt.savefig(PlotDir + subject + "_nofilt" + modality)
        plt.close()
        
        Scores = np.array(scores)
        np.save(ScoreDir + subject + "_nofilt"+modality,Scores)





