# -*- coding: utf-8 -*-
"""
Created on Mon Nov  2 17:13:36 2015

@author: bgauthie
"""

def rank_decode_v3(subject, CondCombs, Classes, modality, window, alpha,Filt):

    import mne
    import numpy as np
    import itertools
    from sklearn.linear_model import Ridge
    from sklearn.cross_validation import cross_val_score, StratifiedShuffleSplit
    
    
    def CatEpochs(subject, CondComb, Classes, modality, window,Filt):
        
            if CondComb[0] != CondComb[1]:
                ClassesList = []
                EpochsList  = []
                for c,cond in enumerate(CondComb):
                    Epochs = []           
                    Epochs = mne.read_epochs("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/" + 
                    subject + "/mne_python/EPOCHS/MEEG_epochs_" + cond + "_" + 
                    subject + "_LP" + str(Filt) + "Hz-epo.fif") 
                    Epochs.crop(window[0],window[1])
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
          
          
    def rank_scorer(clf, X, y):
        y_pred = clf.predict(X)
        comb = itertools.combinations(range(len(y)), 2)
        k = 0
        score = 0.
    
        for i, j in comb:
            if y[i] == y[j]:
                continue
            score += np.sign((y[i] - y[j]) * (y_pred[i] - y_pred[j])) > 0.
            confusion[y[i] - 1, y[j] - 1] += np.sign((y[i] - y[j]) *
                                                     (y_pred[i] - y_pred[j])) > 0.
            confusion[y[j] - 1, y[i] - 1] += np.sign((y[i] - y[j]) *
                                                     (y_pred[i] - y_pred[j])) > 0.
            count[y[i] - 1, y[j] - 1] += 1
            count[y[j] - 1, y[i] - 1] += 1
            k += 1
    
        return score / float(k)      
        
    ###############################################################################
    ###############################################################################
    # get X and Y with the right format    
    savedir = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/decoding_context_yousra/MVPA_time/ranking'

    X,Y = [],[]
    Epochs, n_times, X, Y  = CatEpochs(subject, CondCombs, Classes,modality,window,Filt)
    X = X.reshape(X.shape[0], X.shape[1] * X.shape[2])
    X /= X.std() 
    Y  = Y.astype(np.int)
     
    rng = np.random.RandomState(42)
    order = np.argsort(rng.randn(len(Y)))
    Y = Y[order]
    X = X[order]       
    
    clf = Ridge(alpha=alpha)
    cv = StratifiedShuffleSplit(Y, 10, test_size=0.2, random_state=0) 
    
    # Run cross-validation
    count = np.zeros((3, 3))
    confusion = np.zeros((3, 3))
    scores_t = cross_val_score(clf, X, Y, cv=cv, scoring=rank_scorer)  
    # bug with n_jobs = 4        
    
    scores = scores_t.mean()
    std_scores = scores_t.std()
    
    count_all = count
    confusion_all = confusion / count
    
    CONFMAT = np.array(confusion_all)
    np.save(savedir + '/SCORES/'+ str(subject) + "_vs_".join([str(cond) for cond in CondCombs])
    + str(alpha) + str(window) + str(Filt),CONFMAT)
    
   


