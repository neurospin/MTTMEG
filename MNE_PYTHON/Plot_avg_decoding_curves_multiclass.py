# -*- coding: utf-8 -*-
"""
Created on Thu Dec 17 18:18:12 2015

@author: bgauthie
"""


import itertools
import numpy as np
import mne
from matplotlib import pyplot as pl

# define parameters
subjects_dir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG"
path_script  = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS/MNE_PYTHON"

ListSubj = (
	   'sd130343',
        'rb130313', 'jm100109', 'sb120316', 'tk130502',
        'lm130479', 'ms130534', 'ma100253', 'sl130503', 'mb140004',
        'mp140019', 'dm130250', 'hr130504', 'wl130316', 'rl130571')

allcondcombs = (
	('QtPast','QtPre','QtFut'),
	('QsWest','QsPar','QsEast'),
	('EtPast','EtPre','EtFut'),
	('EsWest','EsPar','EsEast'))  

modalities = ('mag',)

###############################################################################
# get timescale
Epochs = mne.read_epochs("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/jm100109/mne_python/EPOCHS/" 
          + "MEEG_epochs_EsDsq2G_QRT3_jm100109-epo.fif")
ntimes = Epochs.times          

###############################################################################
for m,modality in enumerate(modalities):
    for cc,comb in enumerate(allcondcombs):
        pl.figure(figsize = (8,8))   
        count = 0
                    
        PlotDir  = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/' + 
               'decoding_context_yousra/MVPA_time/multiclass/PLOTS/' +
               '_vs_'.join([str(cond) for cond in comb]) + '/')  
        
        count = count + 1            
        ScoreDir = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/' + 
                    'decoding_context_yousra/MVPA_time/multiclass/SCORES/' +
                    '_vs_'.join([str(cond) for cond in comb]) + '/')  
                
        Scores, MeanScore, StdScore = [], [], []    
        for s,subject in enumerate(ListSubj):
            Scores.append(np.load(ScoreDir + subject + "_" + modality + '_multiclass.npy'))
         
        MeanScore = np.mean(np.asarray(Scores),axis = 0)
        StdScore  = np.std(np.asarray(Scores),axis = 0)/np.sqrt(len(ListSubj)) 
        for i in range(len(comb)):
            for j in range(len(comb)):
                pl.subplot(len(comb),len(comb),count)
                pl.plot(Epochs.times,MeanScore[i,j,:],linewidth = 2)
                pl.axhline(1/len(comb), color='k', linestyle='--', label="Chance level")
                pl.axvline(0, color='k', label='stim onset')   
                pl.ylim([0.15, 0.66])
                pl.xlim([-0.17, 1.07])
                pl.text(0.1,0.63,('true label: ' + comb[i]),fontsize = 8)
                pl.text(0.1,0.6,('predicted label: ' + comb[j]),fontsize = 8)
                pl.ylabel('% correct')
                pl.xlabel('Times (ms)')
                pl.tight_layout()
                count = count + 1  
            
        pl.savefig(PlotDir 
                   + " vs ".join([str(cond) for cond in comb])
                   + "_stratified_kfold_" + str(m))
        pl.close()      
         
    ###############################################################################
###############################################################################
Filters = range(4,47,4)     
for cc,condcombs in enumerate(allcondcombs):
    
    Scores, MeanScore, StdScore = [], [], []  
    for c,condcouple in enumerate(itertools.combinations(condcombs,2)):  
        ScoreDir = (subjects_dir 
        + '/GROUP/decoding_context_yousra/MVPA_time/Scores/' 
        + '_vs_'.join([str(cond) for cond in condcouple]) + '/')    
        
        MS = []
        for f,filt in enumerate (Filters):  
            for s,subject in enumerate(ListSubj):
                Scores.append(np.load(ScoreDir + subject + "_grad"+str(filt)+"Hz.npy"))
                
            MeanScore = np.mean(np.asarray(Scores),axis = 0)
            MS.append(MeanScore)
        
        
        imgplot = pl.imshow(MS, interpolation='none', aspect='auto',cmap = 'jet')
        imgplot.set_clim(0.25, 0.75)
        pl.colorbar()
        pl.ylabel('filter frequency (Hz)')
        pl.xlabel('time (ms)')
        pl.xticks(range(0,261,40),ntimes[range(0,261,40)])
        pl.yticks(range(len(Filters)),Filters)
        pl.title('Classification scores = f(time, filter freq)')
        
        pl.savefig(SavePlotDir 
                   + " vs ".join([str(cond) for cond in condcouple])
                   + "_grad_allfreqfilter")
        pl.close()     
     
     
     
     