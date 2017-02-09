# -*- coding: utf-8 -*-
"""
Created on Mon Dec  7 14:17:16 2015

@author: bgauthie
"""

# adapted from
# http://martinos.org/mne/stable/auto_examples/decoding/plot_decoding_sensors.html
# http://martinos.org/mne/stable/auto_examples/decoding/plot_decoding_xdawn_eeg.html
# http://scikit-learn.org/stable/auto_examples/linear_model/plot_iris_logistic.html

def Decode_multiclass(subject, condcombs, modality,Filt):

    import mne
    import numpy as np
    import os
    
    from sklearn.svm import SVC  
    from sklearn.cross_validation import StratifiedKFold  
    from sklearn.metrics import confusion_matrix
    import matplotlib
    matplotlib.use('Agg') 
    from matplotlib import pyplot as plt  
   
    ###############################################################################
    ############################# SUBFUNCTIONS ####################################
    ###############################################################################
    def CatEpochs(subject, CondComb, Classes, modality,Filt):
        
        if CondComb[0] != CondComb[1]:
            ClassesList = []
            EpochsList  = []
            for c,cond in enumerate(CondComb):
                Epochs = []        
                if Filt != 0.3:
                    Epochs = mne.read_epochs("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/" + 
                    subject + "/mne_python/EPOCHS/MEEG_epochs_icacorr_" + cond + "_" + 
                    subject + "_LP" + str(Filt) + "Hz-epo.fif") 
                elif Filt == 0.3:
                    Epochs = mne.read_epochs("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/" + 
                    subject + "/mne_python/EPOCHS/MEEG_epochs_icacorr_" + cond + "_" + 
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

    
    def SVC_decode(X,Y, n_times, epochs):
    
        clf = SVC(C=1, kernel='linear')
        # Define a monte-carlo cross-validation generator (reduce variance):
        #cv = ShuffleSplit(len(X), 10, test_size=0.2,random_state=0)
        cv = StratifiedKFold(Y, n_folds=10, shuffle=True, random_state=0)
        
        cm_return = np.ones((len(condcombs),len(condcombs),n_times))*(1/len(condcombs))
        for t in range(5,n_times-5):
            Xt = X[:, :, (t-5):(t+5)]
            Xt = Xt.reshape(Xt.shape[0], Xt.shape[1] * Xt.shape[2])
            # Standardize features
            Xt -= Xt.mean(axis=0)
            Xt /= Xt.std(axis=0)
            # Run cross-validation
            # Note : for sklearn the Xt matrix should be 2d (n_samples x n_features)
            preds = np.empty(len(Y))
            for train, test in cv:
                clf.fit(Xt[train], Y[train])
                preds[test] = clf.predict(Xt[test])
        
            # Normalized confusion matrix
            cm = confusion_matrix(Y, preds)
            cm_normalized = cm.astype(float) / cm.sum(axis=1)[:, np.newaxis]
            cm_return[:,:,t] = cm_normalized 
    
        print 'done'
    
        return cm_return

    def SVC_decode_full(X,Y, n_times, epochs):
    
        clf = SVC(C=1, kernel='linear')
        # Define a monte-carlo cross-validation generator (reduce variance):
        #cv = ShuffleSplit(len(X), 10, test_size=0.2,random_state=0)
        cv = StratifiedKFold(Y, n_folds=10, shuffle=True, random_state=0)
        
        cm_return = np.ones((len(condcombs),len(condcombs)))*(1/len(condcombs))
        Xa = X.reshape(X.shape[0], X.shape[1] * X.shape[2])
        # Standardize features
        Xa -= Xa.mean(axis=0)
        Xa /= Xa.std(axis=0)
        # Run cross-validation
        # Note : for sklearn the Xt matrix should be 2d (n_samples x n_features)
        preds = np.empty(len(Y))
        for train, test in cv:
            clf.fit(Xa[train], Y[train])
            preds[test] = clf.predict(Xa[test])
    
        # Normalized confusion matrix
        cm = confusion_matrix(Y, preds)
        cm_normalized = cm.astype(float) / cm.sum(axis=1)[:, np.newaxis]
        cm_return[:,:] = cm_normalized 
    
        print 'done'
    
        return cm_return
  
    ###############################################################################
    ###############################################################################
    Epochs, n_times, X, Y = CatEpochs(subject, condcombs, range(len(condcombs)),modality, Filt)
    cm_overt  = SVC_decode(X,Y,n_times,Epochs)
    cm  = SVC_decode_full(X,Y,n_times,Epochs)
    #cm_overt2 = LogReg_decode(X,Y,n_times,Epochs)
    
    PlotDir  = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/' + 
               'decoding_context_yousra/MVPA_time/multiclass/PLOTS/' +
               '_vs_'.join([str(cond) for cond in condcombs]) + '/')  
    
    ScoreDir = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/' + 
                'decoding_context_yousra/MVPA_time/multiclass/SCORES/' +
                '_vs_'.join([str(cond) for cond in condcombs]) + '/')     
    
    if not os.path.exists(PlotDir):
        os.makedirs(PlotDir)
        
    if not os.path.exists(ScoreDir):
        os.makedirs(ScoreDir)    
    
    plt.figure(figsize=(4,4))
    plt.imshow(cm, interpolation='nearest', cmap=plt.cm.Blues)
    plt.title('Normalized Confusion matrix')
    plt.colorbar()
    tick_marks = np.arange(len(condcombs))
    plt.xticks(tick_marks, condcombs, rotation=45)
    plt.yticks(tick_marks, condcombs)
    plt.ylabel('True label')
    plt.xlabel('Predicted label')
    plt.show()
    plt.tight_layout()
    
    plt.savefig(PlotDir + subject + "_" + modality + '_multiclass_full.png')
    plt.close()    
    
    plt.figure(figsize=(10,10))
    count = 1
    for i in range(len(condcombs)):
        for j in range(len(condcombs)):
            plt.subplot(len(condcombs),len(condcombs),count)
            plt.plot(Epochs.times,cm_overt[i,j,:],linewidth = 2)
            plt.axhline(1/len(condcombs), color='k', linestyle='--', label="Chance level")
            plt.axvline(0, color='k', label='stim onset')   
            plt.ylim([0.15, 0.66])
            plt.text(0.1,0.63,('true label: ' + condcombs[i]),fontsize = 8)
            plt.text(0.1,0.6,('predicted label: ' + condcombs[j]),fontsize = 8)
            plt.ylabel('% correct')
            plt.xlabel('Times (ms)')
            plt.tight_layout()
            count = count + 1  
    

        
    plt.savefig(PlotDir + subject + "_" + modality + '_multiclass.png')
    plt.close()
    
    np.save(ScoreDir + subject + "_" + modality + '_multiclass',np.array(cm_overt))





