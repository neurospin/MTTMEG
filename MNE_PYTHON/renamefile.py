# -*- coding: utf-8 -*-
"""
Created on Tue Oct 13 14:01:02 2015

@author: bgauthie
"""

# rename files

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

modalityold  = ('mags','grads')
modalitynew  = ('mag' ,'grad' )

###############################################################################
import os
import itertools

for s,subject in enumerate(ListSubj):
    for c,comb in enumerate(condcombs):
        for c,condcouple in enumerate(itertools.combinations(comb,2)): 
        
            plotname, scorename = [], []
            for m,mod in enumerate(modalityold):
        
                PlotDir = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/decoding_context_yousra/MVPA_time/Plots/' 
                + '_vs_'.join([str(cond) for cond in condcouple]) + '/')  
                
                ScoreDir = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/decoding_context_yousra/MVPA_time/Scores/' 
                + '_vs_'.join([str(cond) for cond in condcouple]) + '/')  
                
                #plotnameold = PlotDir + subject + "_" + modalityold[m] + '.png'   
                #plotnamenew = PlotDir + subject + "_" + modalitynew[m] + '.png'  
                
                scorenameold  = ScoreDir + subject + "_" + mod + '.npy'
                scorenamenew  = ScoreDir + subject + "_" + modalitynew[m] + '.npy'
                
                #os.rename(plotnameold,plotnamenew)
                if os.path.exists(scorenameold):
                    os.rename(scorenameold,scorenamenew)
                
                
            
            
            