# -*- coding: utf-8 -*-
"""
Created on Thu Oct  1 18:50:19 2015

@author: bgauthie
"""
# adapted from
# http://martinos.org/mne/stable/auto_examples/decoding/plot_decoding_sensors.html

import mne
import numpy as np
import itertools

from sklearn.svm import SVC  # noqa
from sklearn.cross_validation import cross_val_score, ShuffleSplit  # noqa
from matplotlib import pyplot as plt

ListSubj = (
	   'sd130343','cb130477', 
        'rb130313', 'jm100109', 'sb120316', 'tk130502',
        'lm130479', 'ms130534', 'ma100253', 'sl130503', 'mb140004',
        'mp140019', 'dm130250', 'hr130504', 'wl130316', 'rl130571')

condcombs = (
	('Qt_all','Qs_all'),
	('Et_all','Es_all'),
	('EsDsq1G_QRT3','EsDsq2G_QRT3','EsDsq3G_QRT3'),
	('EtDtq1G_QRT3','EtDtq2G_QRT3','EtDtq3G_QRT3'),
	('EtDtq1G_QRT2','EtDtq2G_QRT2'),
     ('EsDsq1G_QRT2','EsDsq2G_QRT2'),
	('QtPast','QtPre','QtFut'),
	('QsWest','QsPar','QsEast'),
	('EtPast','EtPre','EtFut'),
	('EsWest','EsPar','EsEast'))    

###############################################################################
############################# SUBFUNCTIONS ####################################
###############################################################################
def CatEpochs(Subject, CondComb, Classes):

    if CondComb[0] != CondComb[1]:
        ClassesList = []
        EpochsList  = []
        for c,cond in enumerate(CondComb):
            Epochs = []
            Epochs = mne.read_epochs("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/" + 
            Subject + "/mne_python/EPOCHS/MEEG_epochs_" + cond + "_" + Subject + "-epo.fif")
            picks = mne.pick_types(Epochs.info, meg='mag')
            EpochsList.append(Epochs)
            ClassesList.append(np.ones(len(Epochs.events))*Classes[c])
            
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
        scores_t = cross_val_score(clf, Xt, Y, cv=cv, n_jobs=4)
        scores[t] = scores_t.mean()
        std_scores[t] = scores_t.std() 
    
    print 'done'      

    return scores, std_scores

###############################################################################
###############################################################################
for cc in range(len(condcombs)):
    for s,subject in enumerate(ListSubj):
        # classify for each 2-class combinations
        scores, scores_std = [], []
        for c,comb in enumerate(itertools.permutations(condcombs[cc],2)):  
            Epochs, n_times, X, Y = CatEpochs(subject, comb, range(2))
            s, sd = decode_2classes(X,Y,n_times,Epochs)
            scores.append(s)
            scores_std.append(sd)
            
        colors = ('b','r','g')  
        plt.axhline(50, color='k', linestyle='--', label="Chance level")
        plt.axvline(0, color='k', label='stim onset')   
        for c,comb in enumerate(itertools.permutations(condcombs[cc],2)): 
            
            plt.plot(Epochs.times*1000, scores[c]*100, label="Score " +
                     " vs ".join([str(cond) for cond in comb]),linewidth=2.0)
            plt.legend()
            hyp_limits = (scores[c]*100 - scores_std[c]*100, scores[c]*100 + scores_std[c]*100)
            plt.fill_between(Epochs.times*1000, hyp_limits[0], y2=hyp_limits[1], color= colors[c], alpha=0.2)
            plt.xlabel('Times (ms)')
            plt.ylabel('CV classification score (% correct)')
            plt.ylim([30, 100])
            plt.title('Sensor space decoding')
        
        plt.savefig("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/decoding_context_yousra/" +  
        "MVPA_time/" + subject + "_vs_".join([str(cond) for cond in comb]) + "_GDAVG_mags")
        plt.close()

###############################################################################
###############################################################################



