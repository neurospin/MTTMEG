# -*- coding: utf-8 -*-
"""
Created on Thu Oct 29 19:02:03 2015

@author: bgauthie
"""

def rank_decode_v2(ListSubjs, CondCombs, Classes, modality, window, alpha,Filt):

    import mne
    import numpy as np
    import itertools
    import matplotlib
    matplotlib.use('Agg') 
    from matplotlib import pyplot as plt
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
    
    CMAT = []
    #figManager = plt.get_current_fig_manager()
    #figManager.window.showMaximized() 
    #mng = plt.get_current_fig_manager()
    #mng.frame.Maximize(True)
    #mng = plt.get_current_fig_manager()
    #mng.resize(*mng.window.maxsize())
    fig1 = plt.figure(1,figsize=(20,12))
    for s,subject in enumerate(ListSubjs):
        X,Y = [],[]
        Epochs, n_times, X, Y  = CatEpochs(ListSubjs[s], CondCombs, Classes,modality,window,Filt)
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
        
        plt.subplot(4,5,s + 1)
        imgplot = plt.imshow(confusion_all,interpolation = 'none',cmap = 'jet')
        imgplot.set_clim(0, 1)
        plt.title(subject,fontsize = 8)
        plt.xticks(range(len(CondCombs)),CondCombs,fontsize = 8)
        plt.xticks(rotation=45)
        plt.yticks(range(len(CondCombs)),CondCombs,fontsize = 8)
        plt.yticks(rotation=45)

        CMAT.append(confusion_all)
    
    CMATarr = np.array(CMAT)
    np.save(savedir + '/SCORES/' + "_vs_".join([str(cond) for cond in CondCombs]) + str(alpha) + str(window) + str(Filt),CMATarr)
    
    plt.subplot(4,5,s + 2)
    #plt.tight_layout()
    imgplot = plt.imshow(np.mean(CMAT,axis = 0),interpolation = 'none',cmap = 'jet')
    imgplot.set_clim(0, 1)
    plt.title('MEAN')
    plt.xticks(range(len(CondCombs)),CondCombs)
    plt.xticks(rotation=45)
    plt.yticks(range(len(CondCombs)),CondCombs)
    plt.yticks(rotation=45)
    plt.colorbar()     
     
    plt.savefig((savedir + '/PLOTS/' + "_vs_".join([str(cond) for cond in CondCombs])
                + str(alpha) + '_t' + "_".join([str(w) for w in window])) + str(Filt)+ '.eps')  
    plt.close()





