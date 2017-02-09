# -*- coding: utf-8 -*-
"""
Created on Thu Oct 22 19:55:16 2015

@author: bgauthie
"""
import numpy as np
import mne

wdir = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/'

'ms130534/mne_python/EPOCHS/MEEG_epochs_EsDsq1G_QRT3_ms130534-epo.fif'

ListSubj = (
	  'sd130343','cb130477', 
        'rb130313', 'jm100109', 'sb120316', 'tk130502',
        'lm130479', 'ms130534', 'ma100253', 'sl130503', 'mb140004',
        'mp140019', 'dm130250', 'hr130504', 'wl130316', 'rl130571')

CondComb = (
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

Epochlist3 = []
for cc,condcomb in enumerate(CondComb):
    
    Epochlist2 = []
    for c,cond in enumerate(condcomb):
        
        Epochlist1 = []
        for s,subject in enumerate(ListSubj):
            Epoch = []
            Epoch = mne.read_epochs(wdir + subject + 
            '/mne_python/EPOCHS/MEEG_epochs_' + cond + '_' +
            subject + '-epo.fif')
            Epochlist1.append(len(Epoch.get_data()))     
        
        Epochlist2.append(Epochlist1)
    allepochs = np.array(Epochlist2)

    Epochlist3.append(Epochlist2)



