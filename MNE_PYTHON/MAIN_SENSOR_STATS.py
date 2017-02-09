# -*- coding: utf-8 -*-
"""
Created on Mon Oct  5 16:41:37 2015

@author: bgauthie
"""

# MAIN SENSOR STATS

import os
os.chdir('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS/MNE_PYTHON')

import SensorStatsPlot2 as SSP

ListSubj = ('sd130343', 'cb130477', 'rb130313' , 'jm100109', 
             'sb120316', 'tk130502', 'lm130479' ,'ms130534', 'ma100253', 
             'sl130503', 'mb140004', 'mp140019' ,'dm130250', 'hr130504', 
             'wl130316', 'rl130571')       
             
condcomb1 = ('QtPast' ,'QtPre','QtFut' )
condcomb2 = ('QsWest' ,'QsPar','QsEast')
condcomb3 = ('Qt_all','Qs_all')
condcomb4 = ('Et_all','Es_all')
condcomb5 = ('EsDsq1G_QRT3','EsDsq2G_QRT3','EsDsq3G_QRT3')
condcomb6 = ('EtDtq1G_QRT3','EtDtq2G_QRT3','EtDtq3G_QRT3')
condcomb7 = ('EtDtq1G_QRT2','EtDtq2G_QRT2')
condcomb8 = ('EsDsq1G_QRT2','EsDsq2G_QRT2')

SSP.SensorStatsPlot(condcomb1, ListSubj,('red','orange','yellow'))
SSP.SensorStatsPlot(condcomb2, ListSubj,('blue','cyan','green'))
SSP.SensorStatsPlot(condcomb3, ListSubj,('red','blue'))
SSP.SensorStatsPlot(condcomb4, ListSubj,('red','blue' ))
SSP.SensorStatsPlot(condcomb5, ListSubj,('blue','cyan','green'))
SSP.SensorStatsPlot(condcomb6, ListSubj,('red','orange','yellow'))
SSP.SensorStatsPlot(condcomb7, ListSubj,('red','yellow'))
SSP.SensorStatsPlot(condcomb8, ListSubj,('blue','green'))



