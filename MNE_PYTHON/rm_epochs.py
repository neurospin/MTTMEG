# -*- coding: utf-8 -*-
"""
Created on Thu Oct 15 09:53:30 2015

@author: bgauthie
"""

# erase epoch files

def rm_epochs(subjectlist,Filt,comb):
    
    import os 
    
    wdir    = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"    
    
    for s,subject in enumerate(subjectlist):
        for c,conditions in enumerate(comb):
            epoch_file = []
            epoch_file = (wdir + subject + "/mne_python/EPOCHS/MEEG_epochs_" +
            conditions + "_" + subject + "_LP" + str(Filt) + "Hz-epo.fif")
            if os.path.exists(epoch_file):
                os.remove(epoch_file)
        
###############################################################################
ListSubj = (
	   'sd130343','cb130477', 
        'rb130313', 'jm100042', 'jm100109', 'sb120316', 'tk130502',
        'lm130479', 'ms130534', 'ma100253', 'sl130503', 'mb140004',
        'mp140019', 'dm130250', 'hr130504', 'wl130316', 'rl130571')  

condcomb = (
      ('Qt_all','Qs_all'),
	('Et_all','Es_all'),
	('QtPast','QtPre','QtFut'),
	('QsWest','QsPar','QsEast'),
	('EtPast','EtPre','EtFut'),
	('EsWest','EsPar','EsEast'),
	('EsDsq1G_QRT3','EsDsq2G_QRT3','EsDsq3G_QRT3'),
	('EtDtq1G_QRT3','EtDtq2G_QRT3','EtDtq3G_QRT3'),
	('EtDtq1G_QRT2','EtDtq2G_QRT2'),
	('EsDsq1G_QRT2','EsDsq2G_QRT2'))

   
for c, cond in enumerate(condcomb):    
    for f, filt in enumerate((0.5,1.5,1.0,2.0)):
        rm_epochs(ListSubj,filt,cond)














