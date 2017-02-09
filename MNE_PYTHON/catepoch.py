# -*- coding: utf-8 -*-
"""
Created on Wed Feb  3 11:09:57 2016

@author: bgauthie
"""


import mne

wdir    = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"
modality = 'MEEG'

def catepoch(conditions,datasource,subject,runpersubject, badeeg):

    epochs_list_subj = []
    for j,run in enumerate(runpersubject): 
        epochs_list  = []
        for c,cond in enumerate(conditions):
            epochs = []
            epochs = mne.read_epochs(wdir + subject + "/mne_python/EPOCHS/" + modality +"_epochs_" +
                           conditions[c] + "_" + subject + '_' + run + "-epo.fif")
            epochs_list.append(epochs)

        epochs_list_subj.append(epochs_list)
    
        mne.read_epochs(wdir + subject + "/mne_python/EPOCHS/" + modality +"_epochs_" +
                       conditions[c] + "_" + subject + "-epo.fif")
    
    for c,cond in enumerate(conditions):
        epochs2pool = []
        epochs2pool = [epochs_list_subj[run][c] for run in range(len(epochs_list_subj))]
        epoch_tot   = mne.epochs.concatenate_epochs(epochs2pool)
        
        epoch_tot.save(wdir + subject + "/mne_python/EPOCHS/" + modality +"_epochs_" +
                       conditions[c] + "_" + subject + "-epo.fif")
