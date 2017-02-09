# -*- coding: utf-8 -*-
"""
Created on Thu Nov 19 16:07:52 2015

@author: bgauthie
"""

# -*- coding: utf-8 -*-
"""
Created on Thu Nov  5 18:22:27 2015

@author: bgauthie
"""

def rank_decode_source_label(subject, CondCombs, Classes, modality, window, alpha, Filt, index):

    import mne
    import os
    import numpy as np
    import itertools
    from sklearn.linear_model import Ridge
    from sklearn.cross_validation import cross_val_score, StratifiedShuffleSplit
    from sklearn.grid_search import GridSearchCV
    from mne.minimum_norm import apply_inverse_epochs, make_inverse_operator
    
    wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"
    Method = 'dSPM'
    
    os.environ['SUBJECTS_DIR'] = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/mri'
    os.environ['MNE_ROOT'] = '/neurospin/local/mne'
    parc = 'aparc'
    
    subjects_dir = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/mri/'
    labels = mne.read_labels_from_annot(subject,
                                    parc, 
                                    hemi = 'both', 
                                    subjects_dir = subjects_dir)
    
    def CatEpochs(subject, CondComb, Classes, modality, Method, window, Filt, label):
        
        snr = 3.0
        lambda2 = 1.0 / snr **2               
        if CondComb[0] != CondComb[1]:
            
            Epochs_List  = []
            for c,cond in enumerate(CondComb):
                
                Epochs = []        
                if Filt != 0.3:
                    Epochs = mne.read_epochs("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/" + 
                    subject + "/mne_python/EPOCHS/MEEG_epochs_" + cond + "_" + 
                    subject + "_LP" + str(Filt) + "Hz-epo.fif") 
                elif Filt == 0.3:
                    Epochs = mne.read_epochs("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/" + 
                    subject + "/mne_python/EPOCHS/MEEG_epochs_" + cond + "_" + 
                    subject + "-epo.fif") 
                    
                Epochs.crop(window[0],window[1])
                Epochs.pick_types(meg=True)
                Epochs_List.append(Epochs)
                                                         
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
                fr = mne.forward.restrict_forward_to_label(forward,
                                                                label)
                                               
                evoked = mne.read_evokeds((wdir + subject + "/mne_python/" + 
                 modality + "_" + cond  + "_" + subject 
                 + "-ave.fif"), baseline = (-0.2, 0))
                 
                inverse_operator  = make_inverse_operator(evoked[0].info,  
                                                              forward,
                                                              noise_cov,  
                                                              loose=0.2, 
                                                              depth=0.8)         
                                                                                             
        n_epochs  = len(Epochs_List[0].events)*2
        n_times   = len(Epochs_List[0].times)
        n_vertices = fr['nsource']
        X = np.zeros([n_epochs, n_vertices, n_times])  
        for condition_count, ep in zip([0, n_epochs / 2], Epochs_List):
            stcs = apply_inverse_epochs(ep, inverse_operator, lambda2,
                            Method, pick_ori=None,  # saves us memory
                            return_generator=True)
            for jj, stc in enumerate(stcs):
                X[condition_count + jj] = stc.in_label(label).data
        
            Y = np.repeat(range(1,len(CondComb)+1), (len(X) / len(CondComb)))   
            n_times = X.shape[2]        
        
        return Epochs, n_times, X, Y
          
          
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
    Epochs, n_times, X, Y  = CatEpochs(subject, CondCombs, Classes,modality,
                                       Method,window,Filt,labels[index])
    X = X.reshape(X.shape[0], X.shape[1] * X.shape[2])
    X /= X.std() 
    Y  = Y.astype(np.int)
     
    rng = np.random.RandomState(42)
    order = np.argsort(rng.randn(len(Y)))
    Y = Y[order]
    X = X[order]       
    
    clf = Ridge(alpha=alpha)
    #clf = GridSearchCV(Ridge(alpha=alpha),{'alpha':[0.001, 0.01, 0.1, 1, 10,
                       100, 1000]},cv = 5, scoring=rank_scorer)    
    
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
    np.save(savedir + '/SCORES/source_' + Method + '_' + modality +
            str(subject) + "_vs_".join([str(cond) for cond in CondCombs])
            + str(alpha) + str(window) + str(Filt) + str(index),CONFMAT)
    
   


