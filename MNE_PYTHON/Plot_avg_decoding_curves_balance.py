# -*- coding: utf-8 -*-
"""
Created on Wed Dec 16 13:20:37 2015

@author: bgauthie
"""

# -*- coding: utf-8 -*-
"""
Created on Mon Oct 12 09:13:32 2015

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
    for cc,condcombs in enumerate(allcondcombs):
        pl.figure(figsize = (12,12))   
        count = 0
        for c,comb in enumerate(itertools.combinations_with_replacement(condcombs,2)):
            
            count = count + 1            
            ScoreDir = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/' + 
                        'decoding_context_yousra/MVPA_time/multiclass/SCORES/balanced_' +
                        '_vs_'.join([str(cond) for cond in comb]) + '/')  
                    
            PlotDir  = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/' + 
           'decoding_context_yousra/MVPA_time/multiclass/PLOTS/balanced_' +
           '_vs_'.join([str(cond) for cond in comb]) + '/')  
                    
            Scores, MeanScore, StdScore = [], [], []    
            for s,subject in enumerate(ListSubj):
                Scores.append(np.load(ScoreDir + subject + "_" + modality + 'balanced_biclass.npy'))
             
            MeanScore = np.mean(np.asarray(Scores),axis = 0)
            StdScore  = np.std(np.asarray(Scores),axis = 0)/np.sqrt(len(ListSubj))
            pl.subplot(2,3,count)
            pl.plot(ntimes,MeanScore[0,0]*100,linewidth=2.0,
                    label=" vs ".join([str(cond) for cond in comb]) + ' ' + modality)
            hyp_limits = (MeanScore[0,0]*100 - StdScore[0,0]*100, 
                          MeanScore[0,0]*100 + StdScore[0,0]*100)
            pl.fill_between(ntimes, hyp_limits[0], y2=hyp_limits[1], alpha=0.1)
            pl.legend()
            pl.axhline(50, color='k', linestyle='--', label="Chance level")
            pl.axvline(0, color='k', label='stim onset')  
            pl.xlabel('Times (ms)')
            pl.ylabel('CV classification score (% correct)')
            pl.ylim([40, 70])
            pl.title('Sensor space decoding')
        
        pl.savefig(PlotDir + " vs ".join([str(cond) for cond in comb])
                   + str(m) + 'labelsufflesplit')
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
     
     
     
     