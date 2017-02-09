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
from sklearn.cross_validation import LabelShuffleSplit
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
        
        # then compute matching historical events for each condition combination couple
        # this will allow to split event train/test sets
        all_event_to_select = []
        for c,comb in enumerate(itertools.combinations_with_replacement(condcomb,2)): 
            DimRefs,HistEvent = [], []
            
            # for each conditions of a condition couple
            HistEvent_in_condcouple, DimRefs, HistEvent = [], [], []
            for cc, condition in enumerate(comb):   
                events_id = []
                events_id = epochs.event_id.values()
                # get the DIMREFcode of existing event (ex = 80)
                DimRefs.append(np.floor(np.array(events_id))-
                                    np.floor(np.array(events_id)/100)*100)
                # get the historical event code (ex = 59000)                   
                HistEvent.append(np.floor(np.array(events_id)/100)*100)  
                # get events_id indexes corresponding to the DIMREFcode of the condition
                indexes = []                
                indexes = np.where(DimRefs[cc] == DIMREFcode[condition])               
                HistEvent_in_condcouple.append([HistEvent[cc][x] for x in indexes[0]])
                
            tmp = []
            tmp = list(set(HistEvent_in_condcouple[0]) & set(HistEvent_in_condcouple[1]))
            Common_HistEvents = []
            Common_HistEvents = np.int32(tmp)
            # then get a list of event_id to select in each condition in a condition coupl
            event_to_select = []
            for cc, condition in enumerate(comb): 
                event_to_select.append(Common_HistEvents +
                np.int32(np.ones((len(Common_HistEvents)))*DIMREFcode[condition]) )
            
            all_event_to_select.append(event_to_select)
                               
        return all_event_to_select, epochs                       
        
    ###########################################################################  
    def CatEpochs(epochs,event_to_select,modality):
    
        if modality == 'mag' or modality == 'grad':
            epochs.pick_types(meg = modality, eeg = False)
        elif modality == 'eeg':
            epochs.pick_types(meg = False, eeg = True)
        elif modality == 'combined':
            epochs.pick_types(meg = True, eeg = True)    
    
        # balance the event repetition for cross-validation loops 
        indexlist, indexcountlist = [], []
        for el, evlist in enumerate(event_to_select[0]):
            count = 1
            index, indexcount = [], []
            for e, event_id in enumerate(evlist):
                index.append(np.where(epochs.events == event_id)[0])
                indexcount.append(np.ones(len(np.where(epochs.events == event_id)[0]))*count)
                count = count + 1    
            indexlist.append(np.concatenate(index))
            indexcountlist.append(np.concatenate(indexcount))
            
        # reshape the data to fit scikit-learn requirements  
        # for sklearn the Xt matrix should be 2d (n_samples x n_features)
        X = epochs.get_data()
        X1 = X[indexlist[0]]
        X2 = X[indexlist[1]]
        Xtot = np.vstack((X1,X2))
        Y = np.hstack((np.ones(X1.shape[0]),np.ones(X2.shape[0])*2))
        n_times = len(epochs.times)
        
        return  indexcountlist, n_times, Xtot, Y

    ###########################################################################
    def SVC_decode(X,Y, n_times, epochs, indexcountlist):
    
        clf = SVC(C=1, kernel='linear')
        # Define a monte-carlo cross-validation generator (reduce variance):
        #cv = ShuffleSplit(len(X), 10, test_size=0.2,random_state=0)
        #cv = StratifiedKFold(Y, n_folds=10, shuffle=True, random_state=0)
        cv = LeaveOneLabelOut(labels = np.concatenate(indexcountlist))
        #cv = LabelShuffleSplit(np.concatenate(indexcountlist), test_size=0.2,random_state=0)

        cm_return = np.ones((len(comb),len(comb),n_times))*(1/len(comb))
        for t in range(n_times):
            if t <= 4 or t >= n_times-4:
                Xt = X[:, :, t]
            else:
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
        
    ##########################################################################   
    def SVC_decode_full(X,Y, n_times, epochs, indexcountlist):
    
        clf = SVC(C=1, kernel='linear')
        # Define a monte-carlo cross-validation generator (reduce variance):
        #cv = ShuffleSplit(len(X), 10, test_size=0.2,random_state=0)
        cv = LeaveOneLabelOut(labels = np.concatenate(indexcountlist))
       # cv = LabelShuffleSplit(np.concatenate(indexcountlist), test_size=4,random_state=0)
        
        cm_return = np.ones((len(comb),len(comb)))*(1/len(comb))
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
     
    ###########################################################################
    ###########################################################################
    ##################### decoding mutliclass : subfunction calls #############
    ###########################################################################
    ###########################################################################
    all_event_to_select, epochs = balance_events(subject, condcomb, datasource)         

    for c,comb in enumerate(itertools.combinations_with_replacement(condcomb,2)):
        indexcountlist, n_times, X, Y = CatEpochs(epochs,all_event_to_select[c:c+1],modality)

        cm_overt = SVC_decode(X,Y, n_times, epochs, indexcountlist)
        cm = SVC_decode_full(X,Y, n_times, epochs, indexcountlist)
            
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
        tick_marks = np.arange(len(comb))
        plt.xticks(tick_marks, comb, rotation=45)
        plt.yticks(tick_marks, comb)
        plt.ylabel('True label')
        plt.xlabel('Predicted label')
        plt.show()
        plt.tight_layout()      
        
        plt.savefig(PlotDir + subject + "_" + modality + 'balanced_biclass_full.png')
        plt.close()  
        
        plt.figure(figsize=(10,10))
        count = 1
        for i in range(len(comb)):
            for j in range(len(comb)):
                plt.subplot(len(comb),len(comb),count)
                plt.plot(epochs.times,cm_overt[i,j,:],linewidth = 2)
                plt.axhline(1/len(comb), color='k', linestyle='--', label="Chance level")
                plt.axvline(0, color='k', label='stim onset')   
                plt.ylim([0,1])
                plt.text(0.1,0.63,('true label: ' + comb[i]),fontsize = 8)
                plt.text(0.1,0.6,('predicted label: ' + comb[j]),fontsize = 8)
                plt.ylabel('% correct')
                plt.xlabel('Times (ms)')
                plt.tight_layout()
                count = count + 1  
                
        plt.savefig(PlotDir + subject + "_" + modality + 'balanced_biclass.png')
        plt.close()
    
        np.save(ScoreDir + subject + "_" + modality + 'balanced_biclass',np.array(cm_overt))




