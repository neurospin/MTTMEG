# MAIN MNE ERF
import os
os.chdir('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS/MNE_PYTHON')
# import GDAVG_source_trialsfromFT_1cond as proc_ERF1
import EpochAndAverage_eq as Preproc
import SourceReconstruction as Source
import GetTimeCourseFromSTC as GetSourceTC
import GetTimeCourseFromSTC2 as GetSourceTC

# get a full list of subject and associated runs
#ListSubj= ('sd130343', 'cb130477', 'rb130313', 'jm100042',  'jm100109', 'sb120316', 'tk130502', 'lm130479',
#'sg120518','ms130534','ma100253', 'sl130503','mb140004', 'mp140019', 'dm130250', 'hr130504', 'wl130316', 'rl130571')
    
ListSubj= ('sd130343', 'cb130477', 'rb130313', 'jm100042', 'jm100109', 'sb120316', 'tk130502', 'lm130479',
           'ms130534', 'ma100253', 'sl130503', 'mb140004', 'mp140019', 'dm130250', 'hr130504', 'wl130316', 'rl130571')
ListSubj2= ('sd130343', 'cb130477', 'rb130313',            'jm100109', 'sb120316', 'tk130502', 'lm130479',
           'ms130534', 'ma100253', 'sl130503', 'mb140004', 'mp140019', 'dm130250', 'hr130504', 'wl130316', 'rl130571')
# good trials % meg
LKMEG  = (0.84, 0.84, 0.86, 0.85, 0.90, 0.78, 0.93, 0.86,
               0.84, 0.90, 0.90, 0.74, 0.89, 0.88, 0.91, 0.80, 0.80)
# good trial % eeg
LKEEG  = (0.75, 0.76, 0.94, 0.70, 0.86, 0.87, 0.88, 0.89, 
               0.83, 0.89, 0.86, 0.83, 0.94, 0.79, 0.96, 0.9, 0.92)
# good trial % meeg
LKMEEG = (0.69, 0.67, 0.85, 0.6, 0.79, 0.73, 0.83, 0.79, 
               0.74, 0.81, 0.80, 0.70, 0.86, 0.74, 0.88, 0.77, 0.78)
# good trials % meg
LKMEG2  =  (0.84, 0.84, 0.86,     0.90, 0.78, 0.93, 0.86,
               0.84, 0.90, 0.90, 0.74, 0.89, 0.88, 0.91, 0.80, 0.80)
# good trial % eeg
LKEEG2  = (0.75, 0.76, 0.94,      0.86, 0.87, 0.88, 0.89, 
               0.83, 0.89, 0.86, 0.83, 0.94, 0.79, 0.96, 0.9, 0.92)
# good trial % meeg
LKMEEG2 = (0.69, 0.67, 0.85,     0.79, 0.73, 0.83, 0.79, 
               0.74, 0.81, 0.80, 0.70, 0.86, 0.74, 0.88, 0.77, 0.78)

#listRunPerSubj = (('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
#('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
#('run2_GD','run3_DG','run4_DG'),
#('run1_GD','run2_GD','run3_DG','run4_DG'),
#('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
#('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
#('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
#('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
#('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
#('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
#('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
#('run1_GD','run2_GD','run3_DG','run4_DG'),
#('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
#('run1_GD','run2_GD','run3_DG','run4_DG'),
#('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
#('run1_GD','run2_GD','run3_DG','run4_DG'),
#('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
#('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'))
    
listRunPerSubj = (('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
('run2_GD','run3_DG','run4_DG'),
('run2_GD','run3_DG','run4_DG'),
('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
('run1_GD','run2_GD','run3_DG','run4_DG'),
('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
('run1_GD','run2_GD','run3_DG','run4_DG'),
('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
('run1_GD','run2_GD','run3_DG','run4_DG'),
('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'))

listRunPerSubj2 = (('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
('run2_GD','run3_DG','run4_DG'),
('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
('run1_GD','run2_GD','run3_DG','run4_DG'),
('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
('run1_GD','run2_GD','run3_DG','run4_DG'),
('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
('run1_GD','run2_GD','run3_DG','run4_DG'),
('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'))


# list of bad EEG channels for EEG processing
#EEGbadlist= (['EEG025', 'EEG036'],['EEG035', 'EEG036'],['EEG025', 'EEG035',  'EEG036'],['EEG035'],['EEG017', 'EEG025'],['EEG026', 'EEG036'],[],['EEG025', 'EEG035', 'EEG036'  #'EEG037'],['EEG002', 'EEG055'],['EEG025',  'EEG035'],
#['EEG009', 'EEG022',  'EEG045',   'EEG046',  'EEG053', 'EEG054',  'EEG059'],
#['EEG035', 'EEG057'],['EEG043'],[ 'EEG035'],['EEG025', 'EEG035'],
#['EEG025', 'EEG035'],['EEG025',   'EEG035',  'EEG036', 'EEG017'],['EEG0017', 'EEG0025', 'EEG0036', 'EEG0026', 'EEG0034'])

EEGbadlist= (['EEG025', 'EEG036'],['EEG035', 'EEG036'],['EEG025', 'EEG035',  'EEG036'],['EEG035'],['EEG017', 'EEG025'],['EEG026', 'EEG036'],[],['EEG025', 'EEG035', 'EEG036'  'EEG037'],['EEG025',  'EEG035'],
['EEG009', 'EEG022',  'EEG045',   'EEG046',  'EEG053', 'EEG054',  'EEG059'],
['EEG035', 'EEG057'],['EEG043'],[ 'EEG035'],['EEG025', 'EEG035'],
['EEG025', 'EEG035'],['EEG025',   'EEG035',  'EEG036', 'EEG017'],['EEG0017', 'EEG0025', 'EEG0036', 'EEG0026', 'EEG0034'])

EEGbadlist2= (['EEG025', 'EEG036'],['EEG035', 'EEG036'],['EEG025', 'EEG035',  'EEG036'],          ['EEG017', 'EEG025'],['EEG026', 'EEG036'],[],['EEG025', 'EEG035', 'EEG036'  'EEG037'],['EEG025',  'EEG035'],
['EEG009', 'EEG022',  'EEG045',   'EEG046',  'EEG053', 'EEG054',  'EEG059'],
['EEG035', 'EEG057'],['EEG043'],[ 'EEG035'],['EEG025', 'EEG035'],
['EEG025', 'EEG035'],['EEG025',   'EEG035',  'EEG036', 'EEG017'],['EEG0017', 'EEG0025', 'EEG0036', 'EEG0026', 'EEG0034'])

# process separately each condition chunk
Preproc.EpochAndAverage_eq('EsDsq1G_QRT2','EVS',ListSubj,listRunPerSubj,EEGbadlist,66,LKMEG,LKEEG,LKMEEG)
Preproc.EpochAndAverage_eq('EtDtq2G_QRT2','EVT',ListSubj,listRunPerSubj,EEGbadlist,66,LKMEG,LKEEG,LKMEEG)
Preproc.EpochAndAverage_eq('EtDtq1G_QRT2','EVT',ListSubj,listRunPerSubj,EEGbadlist,66,LKMEG,LKEEG,LKMEEG)
Preproc.EpochAndAverage_eq('EsDsq2G_QRT2','EVS',ListSubj,listRunPerSubj,EEGbadlist,66,LKMEG,LKEEG,LKMEEG)

Preproc.EpochAndAverage_eq('EtDtq1G_QRT3','EVT',ListSubj,listRunPerSubj,EEGbadlist,44,LKMEG,LKEEG,LKMEEG)
Preproc.EpochAndAverage_eq('EsDsq1G_QRT3','EVS',ListSubj,listRunPerSubj,EEGbadlist,44,LKMEG,LKEEG,LKMEEG)
Preproc.EpochAndAverage_eq('EsDsq2G_QRT3','EVS',ListSubj,listRunPerSubj,EEGbadlist,44,LKMEG,LKEEG,LKMEEG)
Preproc.EpochAndAverage_eq('EtDtq2G_QRT3','EVT',ListSubj,listRunPerSubj,EEGbadlist,44,LKMEG,LKEEG,LKMEEG)
Preproc.EpochAndAverage_eq('EsDsq3G_QRT3','EVS',ListSubj,listRunPerSubj,EEGbadlist,44,LKMEG,LKEEG,LKMEEG)
Preproc.EpochAndAverage_eq('EtDtq3G_QRT3','EVT',ListSubj,listRunPerSubj,EEGbadlist,44,LKMEG,LKEEG,LKMEEG)

Preproc.EpochAndAverage_eq('EsEast','EVS',ListSubj,listRunPerSubj,EEGbadlist,24,LKMEG,LKEEG,LKMEEG)
Preproc.EpochAndAverage_eq('EsWest','EVS',ListSubj,listRunPerSubj,EEGbadlist,24,LKMEG,LKEEG,LKMEEG)
Preproc.EpochAndAverage_eq('EsPar' ,'EVS',ListSubj,listRunPerSubj,EEGbadlist,24,LKMEG,LKEEG,LKMEEG)
Preproc.EpochAndAverage_eq('EtPast' ,'EVT',ListSubj,listRunPerSubj,EEGbadlist,24,LKMEG,LKEEG,LKMEEG)
Preproc.EpochAndAverage_eq('EtPre'  ,'EVT',ListSubj,listRunPerSubj,EEGbadlist,24,LKMEG,LKEEG,LKMEEG)
Preproc.EpochAndAverage_eq('EtFut'  ,'EVT',ListSubj,listRunPerSubj,EEGbadlist,24,LKMEG,LKEEG,LKMEEG)

Preproc.EpochAndAverage_eq('QtFut'  ,'QTT',ListSubj2,listRunPerSubj2,EEGbadlist2,24,LKMEG2,LKEEG2,LKMEEG2)
Preproc.EpochAndAverage_eq('QtPast' ,'QTT',ListSubj2,listRunPerSubj2,EEGbadlist2,24,LKMEG2,LKEEG2,LKMEEG2)
Preproc.EpochAndAverage_eq('QtPre'  ,'QTT',ListSubj2,listRunPerSubj2,EEGbadlist2,24,LKMEG2,LKEEG2,LKMEEG2)
Preproc.EpochAndAverage_eq('QsWest' ,'QTS',ListSubj,listRunPerSubj,EEGbadlist,24,LKMEG,LKEEG,LKMEEG)
Preproc.EpochAndAverage_eq('QsPar'  ,'QTS',ListSubj,listRunPerSubj,EEGbadlist,24,LKMEG,LKEEG,LKMEEG)
Preproc.EpochAndAverage_eq('QsEast' ,'QTS',ListSubj,listRunPerSubj,EEGbadlist,24,LKMEG,LKEEG,LKMEEG)

Preproc.EpochAndAverage_eq('Es_all' ,'EVS',ListSubj,listRunPerSubj,EEGbadlist,132,LKMEG,LKEEG,LKMEEG)
Preproc.EpochAndAverage_eq('Et_all' ,'EVT',ListSubj,listRunPerSubj,EEGbadlist,132,LKMEG,LKEEG,LKMEEG)
Preproc.EpochAndAverage_eq('Qs_all' ,'QTS',ListSubj,listRunPerSubj,EEGbadlist,132,LKMEG,LKEEG,LKMEEG)
Preproc.EpochAndAverage_eq('Qt_all' ,'QTT',ListSubj2,listRunPerSubj2,EEGbadlist2,132,LKMEG2,LKEEG2,LKMEEG2)

# process separately each condition chunk
Source.SourceReconstruction('EsDsq1G_QRT2',ListSubj)
Source.SourceReconstruction('EtDtq1G_QRT2',ListSubj)
Source.SourceReconstruction('EsDsq2G_QRT2',ListSubj)
Source.SourceReconstruction('EtDtq2G_QRT2',ListSubj)

Source.SourceReconstruction('EsDsq1G_QRT3',ListSubj)
Source.SourceReconstruction('EtDtq1G_QRT3',ListSubj)
Source.SourceReconstruction('EsDsq2G_QRT3',ListSubj)
Source.SourceReconstruction('EtDtq2G_QRT3',ListSubj)
Source.SourceReconstruction('EsDsq3G_QRT3',ListSubj)
Source.SourceReconstruction('EtDtq3G_QRT3',ListSubj)

Source.SourceReconstruction('EsEast',ListSubj)
Source.SourceReconstruction('EsWest',ListSubj)
Source.SourceReconstruction('EsPar' ,ListSubj)
Source.SourceReconstruction('EtPast' ,ListSubj)
Source.SourceReconstruction('EtPre'  ,ListSubj)
Source.SourceReconstruction('EtFut'  ,ListSubj)

Source.SourceReconstruction('Qt_all' ,ListSubj2)
Source.SourceReconstruction('Qs_all' ,ListSubj)
Source.SourceReconstruction('Et_all' ,ListSubj)
Source.SourceReconstruction('Es_all' ,ListSubj)

Source.SourceReconstruction('QtFut'  ,ListSubj2)
Source.SourceReconstruction('QtPast' ,ListSubj2)
Source.SourceReconstruction('QtPre'  ,ListSubj2)
Source.SourceReconstruction('QsWest' ,ListSubj)
Source.SourceReconstruction('QsPar'  ,ListSubj)
Source.SourceReconstruction('QsEast' ,ListSubj)

# get timecourses across diffeent conditions of interest
wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj2,('Qt_all','Qs_all'),'MEG','dSPM','aparc',('r','b'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj2,('Qt_all','Qs_all'),'MEEG','dSPM','aparc',('r','b'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj2,('Qt_all','Qs_all'),'EEG','dSPM','aparc',('r','b'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj2,('Qt_all','Qs_all'),'MEG','LCMV','aparc',('r','b'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj2,('Qt_all','Qs_all'),'MEEG','LCMV','aparc',('r','b'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj2,('Qt_all','Qs_all'),'EEG','LCMV','aparc',('r','b'))

# get timecourses across diffeent conditions of interest
wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj2,('Et_all','Es_all'),'MEG','dSPM','aparc',('r','b'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj2,('Et_all','Es_all'),'MEEG','dSPM','aparc',('r','b'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj2,('Et_all','Es_all'),'EEG','dSPM','aparc',('r','b'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj2,('Et_all','Es_all'),'MEG','LCMV','aparc',('r','b'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj2,('Et_all','Es_all'),'MEEG','LCMV','aparc',('r','b'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj2,('Et_all','Es_all'),'EEG','LCMV','aparc',('r','b'))

wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj2,('QtPast','QtPre','QtFut'),'MEG','dSPM','aparc',('r','y','g'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj2,('QtPast','QtPre','QtFut'),'MEEG','dSPM','aparc',('r','y','g'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj2,('QtPast','QtPre','QtFut'),'EEG','dSPM','aparc',('r','y','g'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj2,('QtPast','QtPre','QtFut'),'MEG','LCMV','aparc',('r','y','g'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj2,('QtPast','QtPre','QtFut'),'MEEG','LCMV','aparc',('r','y','g'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj2,('QtPast','QtPre','QtFut'),'EEG','LCMV','aparc',('r','y','g'))

wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('QsWest','QsPar','QsEast'),'MEG','dSPM','aparc',('k','b','c'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('QsWest','QsPar','QsEast'),'MEEG','dSPM','aparc',('k','b','c'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('QsWest','QsPar','QsEast'),'EEG','dSPM','aparc',('k','b','c'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('QsWest','QsPar','QsEast'),'MEG','LCMV','aparc',('k','b','c'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('QsWest','QsPar','QsEast'),'MEEG','LCMV','aparc',('k','b','c'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('QsWest','QsPar','QsEast'),'EEG','LCMV','aparc',('k','b','c'))

wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EtPast','EtPre','EtFut'),'MEG','dSPM','aparc',('r','y','g'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EtPast','EtPre','EtFut'),'MEEG','dSPM','aparc',('r','y','g'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EtPast','EtPre','EtFut'),'EEG','dSPM','aparc',('r','y','g'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EtPast','EtPre','EtFut'),'MEG','LCMV','aparc',('r','y','g'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EtPast','EtPre','EtFut'),'MEEG','LCMV','aparc',('r','y','g'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EtPast','EtPre','EtFut'),'EEG','LCMV','aparc',('r','y','g'))

wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EsWest','EsPar','EsEast'),'MEG','dSPM','aparc',('k','b','c'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EsWest','EsPar','EsEast'),'MEEG','dSPM','aparc',('k','b','c'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EsWest','EsPar','EsEast'),'EEG','dSPM','aparc',('k','b','c'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EsWest','EsPar','EsEast'),'MEG','LCMV','aparc',('k','b','c'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EsWest','EsPar','EsEast'),'MEEG','LCMV','aparc',('k','b','c'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EsWest','EsPar','EsEast'),'EEG','LCMV','aparc',('k','b','c'))

wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EsDsq1G_QRT3','EsDsq2G_QRT3','EsDsq3G_QRT3'),'MEG','dSPM','aparc',('k','b','c'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EsDsq1G_QRT3','EsDsq2G_QRT3','EsDsq3G_QRT3'),'MEEG','dSPM','aparc',('k','b','c'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EsDsq1G_QRT3','EsDsq2G_QRT3','EsDsq3G_QRT3'),'EEG','dSPM','aparc',('k','b','c'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EsDsq1G_QRT3','EsDsq2G_QRT3','EsDsq3G_QRT3'),'MEG','LCMV','aparc',('k','b','c'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EsDsq1G_QRT3','EsDsq2G_QRT3','EsDsq3G_QRT3'),'MEEG','LCMV','aparc',('k','b','c'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EsDsq1G_QRT3','EsDsq2G_QRT3','EsDsq3G_QRT3'),'EEG','LCMV','aparc',('k','b','c'))

wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EtDtq1G_QRT3','EtDtq2G_QRT3','EtDtq3G_QRT3'),'MEG','dSPM','aparc',('r','y','g'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EtDtq1G_QRT3','EtDtq2G_QRT3','EtDtq3G_QRT3'),'MEEG','dSPM','aparc',('r','y','g'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EtDtq1G_QRT3','EtDtq2G_QRT3','EtDtq3G_QRT3'),'EEG','dSPM','aparc',('r','y','g'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EtDtq1G_QRT3','EtDtq2G_QRT3','EtDtq3G_QRT3'),'MEG','LCMV','aparc',('r','y','g'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EtDtq1G_QRT3','EtDtq2G_QRT3','EtDtq3G_QRT3'),'MEEG','LCMV','aparc',('r','y','g'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EtDtq1G_QRT3','EtDtq2G_QRT3','EtDtq3G_QRT3'),'EEG','LCMV','aparc',('r','y','g'))

wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EtDtq1G_QRT2','EtDtq2G_QRT2'),'MEG','dSPM','aparc',('r','y','g'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EtDtq1G_QRT2','EtDtq2G_QRT2'),'MEEG','dSPM','aparc',('r','y','g'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EtDtq1G_QRT2','EtDtq2G_QRT2'),'EEG','dSPM','aparc',('r','y','g'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EtDtq1G_QRT2','EtDtq2G_QRT2'),'MEG','LCMV','aparc',('r','y','g'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EtDtq1G_QRT2','EtDtq2G_QRT2'),'MEEG','LCMV','aparc',('r','y','g'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EtDtq1G_QRT2','EtDtq2G_QRT2'),'EEG','LCMV','aparc',('r','y','g'))

wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EsDsq1G_QRT2','EsDsq2G_QRT2'),'MEG','dSPM','aparc',('k','b','c'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EsDsq1G_QRT2','EsDsq2G_QRT2'),'MEEG','dSPM','aparc',('k','b','c'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EsDsq1G_QRT2','EsDsq2G_QRT2'),'EEG','dSPM','aparc',('k','b','c'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EsDsq1G_QRT2','EsDsq2G_QRT2'),'MEG','LCMV','aparc',('k','b','c'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EsDsq1G_QRT2','EsDsq2G_QRT2'),'MEEG','LCMV','aparc',('k','b','c'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EsDsq1G_QRT2','EsDsq2G_QRT2'),'EEG','LCMV','aparc',('k','b','c'))

##############################################################################################################################
# get timecourses across diffeent conditions of interest
wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"
GetSourceTC.GetTimeCourseFromSTC2(wdir,ListSubj2,('Qt_all','Qs_all'),'MEG','dSPM','aparc.a2009s',((1,0,0),(0,0,1)))
GetSourceTC.GetTimeCourseFromSTC2(wdir,ListSubj2,('Qt_all','Qs_all'),'MEEG','dSPM','aparc.a2009s',('r','b'))
GetSourceTC.GetTimeCourseFromSTC2(wdir,ListSubj2,('Qt_all','Qs_all'),'EEG','dSPM','aparc.a2009s',('r','b'))
GetSourceTC.GetTimeCourseFromSTC2(wdir,ListSubj2,('Qt_all','Qs_all'),'MEG','LCMV','aparc.a2009s',('r','b'))
GetSourceTC.GetTimeCourseFromSTC2(wdir,ListSubj2,('Qt_all','Qs_all'),'MEEG','LCMV','aparc.a2009s',('r','b'))
GetSourceTC.GetTimeCourseFromSTC2(wdir,ListSubj2,('Qt_all','Qs_all'),'EEG','LCMV','aparc.a2009s',('r','b'))

# get timecourses across diffeent conditions of interest
wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj2,('Et_all','Es_all'),'MEG','dSPM','aparc.a2009s',('r','b'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj2,('Et_all','Es_all'),'MEEG','dSPM','aparc.a2009s',('r','b'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj2,('Et_all','Es_all'),'EEG','dSPM','aparc.a2009s',('r','b'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj2,('Et_all','Es_all'),'MEG','LCMV','aparc.a2009s',('r','b'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj2,('Et_all','Es_all'),'MEEG','LCMV','aparc.a2009s',('r','b'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj2,('Et_all','Es_all'),'EEG','LCMV','aparc.a2009s',('r','b'))

wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj2,('QtPast','QtPre','QtFut'),'MEG','dSPM','aparc.a2009s',('r','y','g'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj2,('QtPast','QtPre','QtFut'),'MEEG','dSPM','aparc.a2009s',('r','y','g'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj2,('QtPast','QtPre','QtFut'),'EEG','dSPM','aparc.a2009s',('r','y','g'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj2,('QtPast','QtPre','QtFut'),'MEG','LCMV','aparc.a2009s',('r','y','g'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj2,('QtPast','QtPre','QtFut'),'MEEG','LCMV','aparc.a2009s',('r','y','g'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj2,('QtPast','QtPre','QtFut'),'EEG','LCMV','aparc.a2009s',('r','y','g'))

wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('QsWest','QsPar','QsEast'),'MEG','dSPM','aparc.a2009s',('k','b','c'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('QsWest','QsPar','QsEast'),'MEEG','dSPM','aparc.a2009s',('k','b','c'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('QsWest','QsPar','QsEast'),'EEG','dSPM','aparc.a2009s',('k','b','c'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('QsWest','QsPar','QsEast'),'MEG','LCMV','aparc.a2009s',('k','b','c'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('QsWest','QsPar','QsEast'),'MEEG','LCMV','aparc.a2009s',('k','b','c'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('QsWest','QsPar','QsEast'),'EEG','LCMV','aparc.a2009s',('k','b','c'))

wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EtPast','EtPre','EtFut'),'MEG','dSPM','aparc.a2009s',('r','y','g'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EtPast','EtPre','EtFut'),'MEEG','dSPM','aparc.a2009s',('r','y','g'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EtPast','EtPre','EtFut'),'EEG','dSPM','aparc.a2009s',('r','y','g'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EtPast','EtPre','EtFut'),'MEG','LCMV','aparc.a2009s',('r','y','g'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EtPast','EtPre','EtFut'),'MEEG','LCMV','aparc.a2009s',('r','y','g'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EtPast','EtPre','EtFut'),'EEG','LCMV','aparc.a2009s',('r','y','g'))

wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EsWest','EsPar','EsEast'),'MEG','dSPM','aparc.a2009s',('k','b','c'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EsWest','EsPar','EsEast'),'MEEG','dSPM','aparc.a2009s',('k','b','c'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EsWest','EsPar','EsEast'),'EEG','dSPM','aparc.a2009s',('k','b','c'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EsWest','EsPar','EsEast'),'MEG','LCMV','aparc.a2009s',('k','b','c'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EsWest','EsPar','EsEast'),'MEEG','LCMV','aparc.a2009s',('k','b','c'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EsWest','EsPar','EsEast'),'EEG','LCMV','aparc.a2009s',('k','b','c'))

wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EsDsq1G_QRT3','EsDsq2G_QRT3','EsDsq3G_QRT3'),'MEG','dSPM','aparc.a2009s',('k','b','c'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EsDsq1G_QRT3','EsDsq2G_QRT3','EsDsq3G_QRT3'),'MEEG','dSPM','aparc.a2009s',('k','b','c'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EsDsq1G_QRT3','EsDsq2G_QRT3','EsDsq3G_QRT3'),'EEG','dSPM','aparc.a2009s',('k','b','c'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EsDsq1G_QRT3','EsDsq2G_QRT3','EsDsq3G_QRT3'),'MEG','LCMV','aparc.a2009s',('k','b','c'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EsDsq1G_QRT3','EsDsq2G_QRT3','EsDsq3G_QRT3'),'MEEG','LCMV','aparc.a2009s',('k','b','c'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EsDsq1G_QRT3','EsDsq2G_QRT3','EsDsq3G_QRT3'),'EEG','LCMV','aparc.a2009s',('k','b','c'))

wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EtDtq1G_QRT3','EtDtq2G_QRT3','EtDtq3G_QRT3'),'MEG','dSPM','aparc.a2009s',('r','y','g'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EtDtq1G_QRT3','EtDtq2G_QRT3','EtDtq3G_QRT3'),'MEEG','dSPM','aparc.a2009s',('r','y','g'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EtDtq1G_QRT3','EtDtq2G_QRT3','EtDtq3G_QRT3'),'EEG','dSPM','aparc.a2009s',('r','y','g'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EtDtq1G_QRT3','EtDtq2G_QRT3','EtDtq3G_QRT3'),'MEG','LCMV','aparc.a2009s',('r','y','g'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EtDtq1G_QRT3','EtDtq2G_QRT3','EtDtq3G_QRT3'),'MEEG','LCMV','aparc.a2009s',('r','y','g'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EtDtq1G_QRT3','EtDtq2G_QRT3','EtDtq3G_QRT3'),'EEG','LCMV','aparc.a2009s',('r','y','g'))

wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EtDtq1G_QRT2','EtDtq2G_QRT2'),'MEG','dSPM','aparc.a2009s',('r','y','g'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EtDtq1G_QRT2','EtDtq2G_QRT2'),'MEEG','dSPM','aparc.a2009s',('r','y','g'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EtDtq1G_QRT2','EtDtq2G_QRT2'),'EEG','dSPM','aparc.a2009s',('r','y','g'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EtDtq1G_QRT2','EtDtq2G_QRT2'),'MEG','LCMV','aparc.a2009s',('r','y','g'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EtDtq1G_QRT2','EtDtq2G_QRT2'),'MEEG','LCMV','aparc.a2009s',('r','y','g'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EtDtq1G_QRT2','EtDtq2G_QRT2'),'EEG','LCMV','aparc.a2009s',('r','y','g'))

wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EsDsq1G_QRT2','EsDsq2G_QRT2'),'MEG','dSPM','aparc.a2009s',('k','b','c'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EsDsq1G_QRT2','EsDsq2G_QRT2'),'MEEG','dSPM','aparc.a2009s',('k','b','c'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EsDsq1G_QRT2','EsDsq2G_QRT2'),'EEG','dSPM','aparc.a2009s',('k','b','c'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EsDsq1G_QRT2','EsDsq2G_QRT2'),'MEG','LCMV','aparc.a2009s',('k','b','c'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EsDsq1G_QRT2','EsDsq2G_QRT2'),'MEEG','LCMV','aparc.a2009s',('k','b','c'))
GetSourceTC.GetTimeCourseFromTSC(wdir,ListSubj,('EsDsq1G_QRT2','EsDsq2G_QRT2'),'EEG','LCMV','aparc.a2009s',('k','b','c'))

