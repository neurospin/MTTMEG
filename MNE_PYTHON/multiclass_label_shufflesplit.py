# -*- coding: utf-8 -*-
"""
Created on Fri Dec 18 11:10:01 2015

@author: bgauthie
"""

# -*- coding: utf-8 -*-
"""
Created on Thu Dec 10 13:27:59 2015

@author: bgauthie
"""

import itertools
import numpy as np
import mne  
import os
import matplotlib
matplotlib.use('Agg') 

from sklearn.svm import SVC  
from sklearn.cross_validation import cross_val_score, ShuffleSplit ,StratifiedKFold, LeaveOneLabelOut 
from sklearn.cross_validation import LabelShuffleSplit, LabelKFold
from sklearn.metrics import confusion_matrix 

from matplotlib import pyplot as plt  


def balanced_decode(subject,condcomb,datasource, modality):

    def balance_events(subject, condcomb, datasource):         
            
        wdir    = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"    
        if datasource == 'EVT' or datasource == 'EVS':
            DIMREFcode = {'EtPast':8, 'EtPre':6, 'EtFut':10, 'EtWest':12, 'EtEast':14,
                          'EsPast':9, 'EsPar':7, 'EsFut':11, 'EsWest':13, 'EsEast':15}    
        elif datasource == 'QTT' or datasource == 'QTS': 
            DIMREFcode = {'QtPast':8, 'QtPre':6, 'QtFut':10, 'QtWest':12, 'QtEast':14,
              'QsPast':9, 'QsPar':7, 'QsFut':11, 'QsWest':13, 'QsEast':15} 
        
        events = range(37,73)
        # match historical events for decoding couples of conditions in a multiclass decoding
        
        # read epochs and get event_id
        # event_id is shaped by a triple code:
        # historical event id (ex: 59)*1000 + ref/dim id (ex: 80) + resp id (ex:1)
        # for example : 59081 is          
        datapath = (wdir+subject+'/mne_python/EPOCHS/MEG_epochs_all'+
                datasource + '_'+subject+'-epo.fif')          
        epochs = mne.read_epochs(datapath)
        
        # recode event_id to get rid of the response code (ex 59081==>5908)
        old_event_id = epochs.event_id
        new_event_id = []
        # create a new event_id dict
        for e,evid in enumerate(old_event_id):
            new_event_id.append((evid[0:4],int(old_event_id[evid]/10)))
        # and replace event_id in epochs object
        epochs.event_id = dict(new_event_id)  
        epochs.events[:,2] = np.int32(epochs.events[:,2]/10)
        
        DimRefs,HistEvent, HistEventIndex, indexes_cond, index_cond_eve = [], [], [], [], []
        for c,comb in enumerate(condcomb): 
            
            events_id = []
            events_id = epochs.events[:,2]
            # get the DIMREFcode of existing event (ex = 80)
            DimRefs.append(np.floor(np.array(events_id))-
                                np.floor(np.array(events_id)/100)*100)
            # get the historical event code (ex = 59000)                   
            HistEvent.append(np.floor(np.array(events_id)/100)*100)  
            HistEventIndex= [x-37 for x in HistEvent[c]/100]
            # get events_id indexes corresponding to the DIMREFcode of the condition 
            tmp = []
            tmp = np.where(DimRefs[c] == DIMREFcode[comb])[0]            
            indexes_cond.append(tmp) 
            index_cond_eve.append(
            [HistEventIndex[x] for x in indexes_cond[c]])
                               
        return indexes_cond, index_cond_eve, epochs                       
        
    ###########################################################################  
    def CatEpochs(epochs,indexes_cond ,modality):
    
        if modality == 'mag' or modality == 'grad':
            epochs.pick_types(meg = modality, eeg = False)
        elif modality == 'eeg':
            epochs.pick_types(meg = False, eeg = True)
        elif modality == 'combined':
            epochs.pick_types(meg = True, eeg = True)    
            
        # reshape the data to fit scikit-learn requirements  
        # for sklearn the Xt matrix should be 2d (n_samples x n_features)
        X = epochs.get_data()
        Xtot = X[np.concatenate(indexes_cond)]
        Y = []
        for i in range(len(indexes_cond)):
            Y.append(np.ones(len(indexes_cond[i]))*i)
        Y = np.concatenate(Y)
        n_times = len(epochs.times)
        
        return  n_times, Xtot, Y

    ###########################################################################
    def SVC_decode(X,Y, n_times, epochs, labels_percond):
        
        Y = Y.astype(int)
        labels_percond = np.concatenate(labels_percond).astype(int)
        clf = SVC(C=1, kernel='linear')
        # Define a monte-carlo cross-validation generator (reduce variance):
        #cv = ShuffleSplit(len(X), 10, test_size=0.2,random_state=0)
        #cv = StratifiedKFold(Y, n_folds=10, shuffle=True, random_state=0)
        #cv = LeaveOneLabelOut(labels = np.concatenate(indexcountlist))
        #cv = LabelShuffleSplit(np.concatenate(labels_percond),n_iter=10)
        cv = LabelKFold(labels_percond,n_folds = 5)

        cm_return = np.ones((Y[-1]+1,Y[-1]+1,n_times))*(1/Y[-1]+1)
        for t in range(n_times):
            Xt = X[:, :, t]
                
            # Standardize features
            Xt -= Xt.mean(axis=0)
            #Xt /= Xt.std(axis=0)
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
        
    ##########################################################################   
    def SVC_decode_full(X,Y, n_times, epochs, indexcountlist):
    
        clf = SVC(C=1, kernel='linear')
        # Define a monte-carlo cross-validation generator (reduce variance):
        #cv = ShuffleSplit(len(X), 10, test_size=0.2,random_state=0)
        #cv = LeaveOneLabelOut(labels = np.concatenate(indexcountlist))
        #cv = LabelShuffleSplit(np.concatenate(labels_percond))
        cv = LabelKFold(labels_percond,n_folds = 5)
        
        cm_return = np.ones((Y[-1]+1,Y[-1]+1))*(1/Y[-1]+1)
        Xa = X.reshape(X.shape[0], X.shape[1] * X.shape[2])
        # Standardize features
        Xa -= Xa.mean(axis=0)
        #Xa /= Xa.std(axis=0)
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
     
    ###########################################################################
    ###########################################################################
    ##################### decoding mutliclass : subfunction calls #############
    ###########################################################################
    ###########################################################################
    indexes_cond, labels_percond, epochs = balance_events(subject, condcomb, datasource)         
    n_times, X, Y = CatEpochs(epochs,indexes_cond ,modality)

    cm_overt = SVC_decode(X,Y, n_times, epochs, labels_percond)
    cm = SVC_decode_full(X,Y, n_times, epochs, labels_percond)
        
    PlotDir  = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/' + 
               'decoding_context_yousra/MVPA_time/multiclass/PLOTS/balanced_' +
               '_vs_'.join([str(cond) for cond in comb]) + '/')  
    
    ScoreDir = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/' + 
                'decoding_context_yousra/MVPA_time/multiclass/SCORES/balanced_' +
                '_vs_'.join([str(cond) for cond in comb]) + '/')          
    
    if not os.path.exists(PlotDir):
        os.makedirs(PlotDir)
    
    if not os.path.exists(ScoreDir):
        os.makedirs(ScoreDir) 
    
    plt.figure(figsize=(4,4))
    plt.imshow(cm, interpolation='nearest', cmap=plt.cm.Blues)
    plt.title('Normalized Confusion matrix')
    plt.colorbar()
    tick_marks = np.arange(len(condcomb))
    plt.xticks(tick_marks, condcomb, rotation=45)
    plt.yticks(tick_marks, condcomb)
    plt.ylabel('True label')
    plt.xlabel('Predicted label')
    plt.show()
    plt.tight_layout()      
    
    plt.savefig(PlotDir + subject + "_" + modality + 'balanced_biclass_full.png')
    plt.close()  
    
    plt.figure(figsize=(10,10))
    count = 1
    for i in range(len(condcomb)):
        for j in range(len(condcomb)):
            plt.subplot(len(condcomb),len(condcomb),count)
            plt.plot(epochs.times,cm_overt[i,j,:],linewidth = 2)
            plt.axhline(1/len(condcomb), color='k', linestyle='--', label="Chance level")
            plt.axvline(0, color='k', label='stim onset')   
            plt.ylim([0,1])
            plt.text(0.1,0.63,('true label: ' + condcomb[i]),fontsize = 8)
            plt.text(0.1,0.6,('predicted label: ' + condcomb[j]),fontsize = 8)
            plt.ylabel('% correct')
            plt.xlabel('Times (ms)')
            plt.tight_layout()
            count = count + 1  
            
    plt.savefig(PlotDir + subject + "_" + modality + 'balanced_biclass.png')
    plt.close()

    np.save(ScoreDir + subject + "_" + modality + 'balanced_biclass',np.array(cm_overt))




