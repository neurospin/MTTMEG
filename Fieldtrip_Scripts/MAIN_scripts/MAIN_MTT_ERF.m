% MAIN SCRIPT MTT

close all
clear all

bcktmprd = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/backup_temprod/SCRIPTS';
bcktmprd2 = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/backup_temprod/FIELDTRIP';

%addpath('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/fieldtrip-20130901')
addpath('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/fieldtrip-20151209')
% addpath('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/fieldtrip-20160719')
addpath(genpath([bcktmprd '/Matlab_pipeline/Ref_functions']));
addpath([bcktmprd '/Matlab_pipeline/My_functions/Preprocessing']);
addpath(bcktmprd2);
addpath('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts');
addpath('/neurospin/meg/meg_tmp/temprod_Baptiste_2010/SCRIPTS/Matlab_pipeline/My_functions/Misc')

ft_defaults

niplist = {'sd130343';'cb130477';'sl130503';'lm130479';'ma100253';'sg120518';'ms130534';'tk130502'; ...
           'sb120316';'jm100109';'rb130313';'jm100042';'wl130316';'mm130405';'dm130250';'hr130504' ; ...       
           'mp140019'; 'mb140004';'rl130571'};    


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% GROUP analysis %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% chansel   = {'Mags';'Grads2';'Grads1'};
% condnames = {'allEventsavbACT';'allEventsavbBASE'};
% PlotColors = [[0.5 0.5 0.5];[0.2 0.2 0.2]];
% for c = 1:3
%     TLSL_GROUPlvl_actvsblt(niplist,chansel{c},condnames,[0 1],PlotColors)
% end

%% Regression scores vs zero
niplist = {'sd130343' ;'cb130477' ;'jm100042' ;'jm100109';'sb120316';...
    'tk130502'  ;'lm130479' ;'ms130534';'ma100253';'sl130503';...
    'mb140004';'mp140019';'dm130250';'hr130504' ;'wl130316';'rl130571'};
chansel         = {'Mags';'Grads2';'Grads1'};
condnames1 = {'REGEVTegoT';'ZERO'};
PlotColors1 = [[1 0 0];[0 0 0]];
TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{1},condnames1,[0 1],PlotColors1,'Reg')
TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{2},condnames1,[0 1],PlotColors1,'Reg')
TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{3},condnames1,[0 1],PlotColors1,'Reg')

%% int
chansel         = {'Mags';'Grads2';'Grads1';'EEG'};
condnames1      =  {'rPast_int';'rFut_int';'rPast_cou';'rFut_cou'};
condnames2      =  {'rPast_int';'rFut_int';'rPast_cou';'rFut_cou'};
PlotColors1 = [[1 0 0];[1 0 0];[1 0.5 0.5];[1 0.5 0.5]];
for c = 1:4
    TLSL_GROUPlvl_INT_select_from_mne(niplist,chansel{1},condnames1,condnames2,[1 3],[2 4],[0 1],PlotColors1,'T')
end

%% congruence
chansel         = {'Mags';'Grads2';'Grads1';'EEG'};
condnames1      =  {'Reltime_con';'Reltime_incon'};
PlotColors1 = [[0 0 0];[0.5 0.5 0.5]];
for c =1:4
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames1,[0 1],PlotColors1,'T')
end

chansel         = {'Mags';'EEG';'Grads2';'Grads1'};
condnames1      =  {'Relspace_con';'Relspace_incon'};
PlotColors1 = [[0 0 0];[0.5 0.5 0.5]];
for c =1:4
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames1,[0 1],PlotColors1,'T')
end

%% conflict
PlotColors1 = [[0 0 0];[0.5 0.5 0.5];[0 0 0.5]];
chansel         = {'Mags';'EEG';'Grads2';'Grads1'};
condnames1      =  {'QtSpaceShiftEVT';'QtNoShiftEVT';'QtTimeShiftEVT'}
condnames2      =  {'QsSpaceShiftEVS';'QsNoShiftEVS';'QsTimeShiftEVS'};
for c =1:4
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames1,[0 1],PlotColors1,'F')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames2,[0 1],PlotColors1,'F')
end

PlotColors1 = [[0 0 0];[0.5 0.5 0.5];[0 0 0.5];[0.5 0 0];[0.5 0 0.5]];
chansel         = {'Mags';'EEG';'Grads2';'Grads1'};
condnames1      =  {'QsWestEVS';'QsEastEVS';'QsParEVS';'QsPastEVS';'QsFutEVS'}
condnames2      =  {'QtWestEVT';'QtEastEVT';'QtParEVT';'QtPastEVT';'QtFutEVT'};
for c =1:4
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames1,[0 1],PlotColors1,'F')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames2,[0 1],PlotColors1,'F')
end

PlotColors1 = [[0 0 0];[0.5 0.5 0.5]];
chansel         = {'Mags';'EEG';'Grads2';'Grads1'};
condnames1      =  {'Q_conflict';'Q_noconflict'};
for c =3
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames1,[0 1],PlotColors1,'T')
end

%% ordinal judgements
chansel         = {'Mags';'Grads2';'Grads1';'EEG'};
condnames1 =  {'RelPast'   ;'RelFut'};
condnames2 =  {'RelPastG' ;'RelFutG'};
condnames3 =  {'RelWest'  ;'RelEast'};
condnames4 =  {'RelWestG';'RelEastG'};
condnames5  = {'RelPastG_intmap'   ;'RelFutG_intmap'};
condnames6  = {'RelPastG_coumap' ;'RelFutG_coumap'};
condnames7  = {'RelWestG_intmap'  ;'RelEastG_intmap'};
condnames8  = {'RelWestG_coumap';'RelEastG_coumap'};
PlotColors1    = [[1 0.5 0.5];[1 0 0]];
PlotColors2    = [[1 0.5 0.5];[1 0 0]];
PlotColors3    = [[0.5 0.5 1];[0 0 1]];
PlotColors4    = [[0.5 0.5 1];[0 0 1]];
PlotColors5    = [[1 0.5 0.5];[1 0 0]];
PlotColors6    = [[1 0.5 0.5];[1 0 0]];
PlotColors7    = [[0.5 0.5 1];[0 0 1]];
PlotColors8    = [[0.5 0.5 1];[0 0 1]];

for c =1:4
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames1,[0 1],PlotColors1,'T')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames2,[0 1],PlotColors2,'T')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames3,[0 1],PlotColors3,'T')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames4,[0 1],PlotColors4,'T')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames1,[1 1.8],PlotColors1,'T')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames2,[1 1.8],PlotColors2,'T')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames3,[1 1.8],PlotColors3,'T')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames4,[1 1.8],PlotColors4,'T')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames5,[0 1],PlotColors1,'T')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames6,[0 1],PlotColors2,'T')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames7,[0 1],PlotColors3,'T')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames8,[0 1],PlotColors4,'T')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames5,[1 1.8],PlotColors1,'T')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames6,[1 1.8],PlotColors2,'T')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames7,[1 1.8],PlotColors3,'T')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames8,[1 1.8],PlotColors4,'T')
end

chansel     = {'Mags';'Grads2';'Grads1';'EEG'};
PlotColors1 = [[1 0.5 0.5];[1 0 0]];
condnames1  = {'RelWestG_intmap'  ;'RelEastG_intmap'};
condnames2  = {'RelWestG_coumap'   ;'RelEastG_coumap'};
TLSL_GROUPlvl_INT_from_mne_save(niplist,chansel{1},condnames1,condnames2,[1 1.8],PlotColors1,'T')

%% Relative Time Distance Effects -EVENTS

chansel    = {'Mags';'Grads2';'Grads1';'EEG'};
condnames1 = {'EtDtq1A';'EtDtq2A'};
condnames2 = {'EtDtq1G';'EtDtq2G'};
condnames3 = {'EtDtq1G_Past';'EtDtq2G_Past'};
condnames4 = {'EtDtq1G_Fut';'EtDtq2G_Fut'};
condnames5 = {'EtDtq1G_Pre';'EtDtq2G_Pre'};
condnames6 = {'EtDtq1A';'EtDtq2A';'EtDtq3A'};
condnames7 = {'EtDtq1G';'EtDtq2G';'EtDtq3G'};
condnames8 = {'EtDtq1A';'EtDtq2A';'EtDtq3A';'EtDtq4A'};
condnames9 = {'EtDtq1G';'EtDtq2G';'EtDtq3G';'EtDtq4G'};

PlotColors1 = [[1 0 0];[1 0.75 0.3]];
PlotColors2 = [[1 0 0];[1 0.75 0.3]];
PlotColors3 = [[1 0 0];[1 0.75 0.3]];
PlotColors4 = [[1 0 0];[1 0.75 0.3]];
PlotColors5 = [[1 0 0];[1 0.75 0.3]];
PlotColors6 = [[1 0 0];[1 0.37 0.15];[1 0.75 0.3]];
PlotColors7 = [[1 0 0];[1 0.37 0.15];[1 0.75 0.3]];
PlotColors8 = [[1 0 0];[1 0.25 0.1];[1 0.5 0.2];[1 0.75 0.3]];
PlotColors9 = [[1 0 0];[1 0.25 0.1];[1 0.5 0.2];[1 0.75 0.3]];

for c =1:4
    
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames1,[0 1],PlotColors1,'T')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames2,[0 1],PlotColors2,'T')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames3,[0 1],PlotColors3,'T')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames4,[0 1],PlotColors4,'T')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames5,[0 1],PlotColors5,'T')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames6,[0 1],PlotColors6,'Reg')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames7,[0 1],PlotColors7,'Reg')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames8,[0 1],PlotColors8,'Reg')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames9,[0 1],PlotColors9,'Reg')
    
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames1,[1 1.8],PlotColors1,'T')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames2,[1 1.8],PlotColors2,'T')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames3,[1 1.8],PlotColors3,'T')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames4,[1 1.8],PlotColors4,'T')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames5,[1 1.8],PlotColors5,'T')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames6,[1 1.8],PlotColors6,'Reg')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames7,[1 1.8],PlotColors7,'Reg')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames8,[1 1.8],PlotColors8,'Reg')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames9,[1 1.8],PlotColors9,'Reg')
    
end

%% "handmade" regression
chansel    = {'Mags';'Grads2';'Grads1';'EEG'};
PlotColors1 = [[1 0 0];[0 0 0]];
PlotColors2 = [[0 0 1];[0 0 0]];
for c = 1:4
    RegFull_Grouplvl_from_mne(niplist,chansel{c},'EVSdistS',[0 1],PlotColors1,'T')
    RegFull_Grouplvl_from_mne(niplist,chansel{c},'EVTdistT',[0 1],PlotColors2,'T')
    RegFull_Grouplvl_from_mne(niplist,chansel{c},'distS',[0 1],PlotColors1,'T')
    RegFull_Grouplvl_from_mne(niplist,chansel{c},'distT',[0 1],PlotColors2,'T')
end

chansel    = {'Mags';'Grads2';'Grads1';'EEG'};
PlotColors1 = [[1 0 0];[0 0 1]];
condnames1 = {'REG_QtPast_QtPre_QtFut'}
condnames2 = {'REG_QsWest_QsPar_QsEast'}
for c = 1:4
    TLSL_GROUPlvl_from_mne_august(niplist,chansel{c},condnames1,condnames2,[0 1],PlotColors1,'T')
end

chansel    = {'Mags';'Grads2';'Grads1';'EEG'};
condnames8 = {'EsDtq1G';'EsDtq2G';'EsDtq3G';'EsDtq4G'};
condnames9 = {'EtDsq1G';'EtDsq2G';'EtDsq3G';'EtDsq4G'};
PlotColors8   = [[1 0 0];[1 0.25 0.1];[1 0.5 0.2];[1 0.75 0.3]];
PlotColors9   = [[1 0 0];[1 0.25 0.1];[1 0.5 0.2];[1 0.75 0.3]];
for c =1:4
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames8,[0 1],PlotColors8,'Reg')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames9,[0 1],PlotColors9,'Reg')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames8,[1 1.8],PlotColors8,'Reg')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames9,[1 1.8],PlotColors9,'Reg')
end

%% hand
chansel         = {'Mags';'Grads2';'Grads1';'EEG'};
condnames6 = {'EtDtq1G_L';'EtDtq2G_L';'EtDtq3G_L';'EtDtq4G_L'};
condnames7 = {'EtDtq1G_R';'EtDtq2G_R';'EtDtq3G_R';'EtDtq4G_R'};
PlotColors6   = [[1 0 0];[1 0.25 0.1];[1 0.5 0.2];[1 0.75 0.3]];
PlotColors7   = [[1 0 0];[1 0.25 0.1];[1 0.5 0.2];[1 0.75 0.3]];

for c =1:4
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames6,[0 1],PlotColors6,'Reg')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames7,[0 1],PlotColors7,'Reg')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames6,[1 1.8],PlotColors6,'Reg')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames7,[1 1.8],PlotColors7,'Reg')
end

chansel         = {'Mags';'Grads2';'Grads1';'EEG'};
condnames6 = {'EsDsq1G_L';'EsDsq2G_L';'EsDsq3G_L';'EsDsq4G_L'};
condnames7 = {'EsDsq1G_R';'EsDsq2G_R';'EsDsq3G_R';'EsDsq4G_R'};
PlotColors6 = [[0 0 1];[0.1 0.2 1];[0.2 0.4 1];[0.3 0.6 1]];
PlotColors7 = [[0 0 1];[0.1 0.2 1];[0.2 0.4 1];[0.3 0.6 1]];

for c =1:4
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames6,[0 1],PlotColors6,'Reg')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames7,[0 1],PlotColors7,'Reg')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames6,[1 1.8],PlotColors6,'Reg')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames7,[1 1.8],PlotColors7,'Reg')
end

%% Relative Space Distance Effects -EVENTS

chansel         = {'Mags';'Grads2';'Grads1';'EEG'};
condnames1 = {'EsDsq1A';'EsDsq2A'};
condnames2 = {'EsDsq1G';'EsDsq2G'};
condnames3 = {'EsDsq1G_W';'EsDsq2G_W'};
condnames4 = {'EsDsq1G_E';'EsDsq2G_E'};
condnames5 = {'EsDsq1G_Par';'EsDsq2G_Par'};
condnames6 = {'EsDsq1A';'EsDsq2A';'EsDsq3A'};
condnames7 = {'EsDsq1G';'EsDsq2G';'EsDsq3G'};
condnames8 = {'EsDsq1A';'EsDsq2A';'EsDsq3A';'EsDsq4A'};
condnames9 = {'EsDsq1G';'EsDsq2G';'EsDsq3G';'EsDsq4G'};

PlotColors1 = [[0 0 1];[0.3 0.6 1]];
PlotColors2 = [[0 0 1];[0.3 0.6 1]];
PlotColors3 = [[0 0 1];[0.3 0.6 1]];
PlotColors4 = [[0 0 1];[0.3 0.6 1]];
PlotColors5 = [[0 0 1];[0.3 0.6 1]];
PlotColors6 = [[0 0 1];[0.15 0.3 1 ];[0.3 0.6 1]];
PlotColors7 = [[0 0 1];[0.15 0.3 1 ];[0.3 0.6 1]];
PlotColors8 = [[0 0 1];[0.1 0.2 1];[0.2 0.4 1];[0.3 0.6 1]];
PlotColors9 = [[0 0 1];[0.1 0.2 1];[0.2 0.4 1];[0.3 0.6 1]];

for c =1:4
    
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames1,[0 1],PlotColors1,'T')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames2,[0 1],PlotColors2,'T')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames3,[0 1],PlotColors3,'T')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames4,[0 1],PlotColors4,'T')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames5,[0 1],PlotColors5,'T')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames6,[0 1],PlotColors6,'Reg')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames7,[0 1],PlotColors7,'Reg')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames8,[0 1],PlotColors8,'Reg')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames9,[0 1],PlotColors9,'Reg')
    
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames1,[1 1.8],PlotColors1,'T')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames2,[1 1.8],PlotColors2,'T')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames3,[1 1.8],PlotColors3,'T')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames4,[1 1.8],PlotColors4,'T')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames5,[1 1.8],PlotColors5,'T')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames6,[1 1.8],PlotColors6,'Reg')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames7,[1 1.8],PlotColors7,'Reg')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames8,[1 1.8],PlotColors8,'Reg')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames9,[1 1.8],PlotColors9,'Reg')
    
end

%% Absolute Time Distance Effects -EVENTS

chansel    = {'Mags';'Grads2';'Grads1';'EEG'};
condnames1 = {'EtPre';'EtFut'};
condnames2 = {'EtPre';'EtPast'};
condnames3 = {'EtPre';'EtnoPre'};
condnames4 = {'EtPast';'EtPre';'EtFut'};
condnames5 = {'EtPastG';'EtPreG';'EtFutG'};
condnames6 = {'EtPreG';'EtPastG';'EtFutG';'EtWestG';'EtEastG'}

PlotColors1 = [[1 0 0];[1 0.75 0.3]];
PlotColors2 = [[1 0 0];[1 0.75 0.3]];
PlotColors3 = [[1 0 0];[1 0.75 0.3]];
PlotColors4 = [[1 0 0];[1 0.37 0.15];[1 0.75 0.3]];
PlotColors5 = [[0 0 0];[0.5 0 0];[1 0 0]];
PlotColors6 = [[0 0 0];[0.5 0 0];[1 0 0];[0.15 0.3 1 ];[0.3 0.6 1]];

for c = 1
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames6,[0 1],PlotColors6,'F')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames6,[1 1.8],PlotColors6,'F')
end
for c = 2
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames6,[0 1],PlotColors6,'F')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames6,[1 1.8],PlotColors6,'F')
end
for c = 3
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames6,[0 1],PlotColors6,'F')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames6,[1 1.8],PlotColors6,'F')
end
for c = 4
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames6,[0 1],PlotColors6,'F')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames6,[1 1.8],PlotColors6,'F')
end

%% Absolute Time Distance Effects -EVENTS

chansel    = {'Mags';'Grads2' ;'Grads1' ;'EEG'};
condnames1 = {'EtPast_L' ;'EtPre_L';'EtFut_L'};
condnames2 = {'EtPast_R' ;'EtPre_R';'EtFut_R'};

PlotColors1 = [[1 0 0];[1 0.37 0.15];[1 0.75 0.3]];
PlotColors2 = [[1 0 0];[1 0.37 0.15];[1 0.75 0.3]];

for c =1:4
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames1,[0 1],PlotColors1,'Reg')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames2,[0 1],PlotColors2,'Reg')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames1,[0 1],PlotColors1,'F')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames2,[0 1],PlotColors2,'F')
end

for c =1:4
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames1,[1 1.8],PlotColors1,'Reg')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames2,[1 1.8],PlotColors2,'Reg')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames1,[1 1.8],PlotColors1,'F')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames2,[1 1.8],PlotColors2,'F')
end

%% Absolute Space Distance Effects-EVENTS

chansel       = {'Mags';'Grads2';'Grads1';'EEG'};
condnames1 = {'EsPar';'EsWest'};
condnames2 = {'EsPar';'EsEast'};
condnames3 = {'EsPar';'EsnoPar'};
condnames4 = {'EsWest';'EsPar';'EsEast'};
condnames5 = {'EsWestG';'EsParG';'EsEastG'};
condnames6 = {'EsParG';'EsPastG';'EsFutG';'EsWestG';'EsEastG'};

PlotColors1 =  [[0 0 1];[0.3 0.6 1]];
PlotColors2 =  [[0 0 1];[0.3 0.6 1]];
PlotColors3 =  [[0 0 1];[0.3 0.6 1]];
PlotColors4 =  [[0 0 1];[0.15 0.3 1 ];[0.3 0.6 1]];
PlotColors5 =  [[0 0 1];[0.15 0.3 1 ];[0.3 0.6 1]];
PlotColors6 =  [[0 0 0];[0.5 0 0];[1 0 0];[0.15 0.3 1 ];[0.3 0.6 1]];

for c = 1:4
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames5,[0 1],PlotColors5,'Reg')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames5,[1 1.8],PlotColors5,'Reg')
end


%% Absolute Time Distance Effects - QUESTIONS

chansel         = {'Mags';'Grads2';'Grads1';'EEG'};
condnames1 = {'QtPre';'QtFut'};
condnames2 = {'QtPre';'QtPast'};
condnames3 = {'QtPast';'QtPre';'QtFut'};
condnames4 = {'Qtpre';'QtnoPre'};
condnames3 = {'QtPast';'QtPre';'QtFut'};
condnames6 = {'QtPastEVS';'QtPreEVS';'QtFutEVS'};


PlotColors1   =  [[1 0 0];[1 0.75 0.3]];
PlotColors2   =  [[1 0 0];[1 0.75 0.3]];
PlotColors3   =  [[1 0 0];[1 0.37 0.15];[1 0.75 0.3]];
PlotColors6   =  [[1 0 0];[1 0.37 0.15];[1 0.75 0.3]];

for c =1:4
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames1,[0 1],PlotColors1,'T')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames2,[0 1],PlotColors2,'T')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames3,[0 1],PlotColors3,'Reg')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames4,[0 1],PlotColors1,'T')
end

for c =1:4
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames6,[0 1],PlotColors6,'Reg')
end

%% Absolute Space Distance Effects - QUESTIONS

chansel    = {'Mags';'Grads2';'Grads1';'EEG'};
condnames1 = {'QsPar' ;'QsEast' };
condnames2 = {'QsPar' ;'QsWest' };
condnames3 = {'QsWest';'QsPar'  ;'QsEast'};
condnames4 = {'QsPar' ;'QsnoPar'};
condnames5 = {'QsWest';'QsEast' };
condnames6 = {'QsWestEVT';'QsParEVT';'QsEastEVT'};

PlotColors1   =  [[0 0 1];[0.3 0.6 1]];
PlotColors2   =  [[0 0 1];[0.3 0.6 1]];
PlotColors3   =  [[0 0 1];[0.15 0.3 1 ];[0.3 0.6 1]];
PlotColors5   =  [[0 0 1];[0.3 0.6 1]];
PlotColors6   =  [[0 0 1];[0.15 0.3 1 ];[0.3 0.6 1]];

for c =1:4
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames6,[0 1],PlotColors6,'Reg')
end

for c =1:4
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames3,[0 1],PlotColors3,'F')
end

for c =1:4
    RegFull_Grouplvl_from_mne_spearman(niplist,chansel{c},condnames3,'RefTimeRegSpearman',[0 1],PlotColors3,'Reg')
end

%% Across time and space

chansel      = {'Mags';'Grads2';'Grads1';'EEG'};
condnames1   = {'Et_all';'Es_all'};
condnames2   = {'Qt_all';'Qs_all'};

PlotColors1   =  [[1 0 0];[0 0 1]];
PlotColors2   =  [[1 0 0];[0 0 1]];

for c =1:4
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames1,[0 1],PlotColors1,'T')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames2,[0 1],PlotColors2,'T')
end

%% Reference effects
chansel      = {'Mags';'Grads2';'Grads1';'EEG'};
%condnames1   = {'RefPast';'RefPre';'RefFut';'RefW';'RefE'};
condnames2   = {'RefW';'RefPar';'RefE'};
condnames3   = {'RefPast';'RefPre';'RefFut'};
condnames4   = {'Sproj';'NoProj';'Tproj'};

%PlotColors1   =  [[0.5 0 0 ];[0 0 0];[1 0 0];[0 0 0.5];[0 0 1]];
PlotColors2   =  [[0 0 0.5];[0 0 0 ];[0 0 1]];
PlotColors3   = [[0.5 0 0];[0 0 0];[1 0 0]];
PlotColors4   = [[0 0 1];[0 0 0];[1 0 0]];

for c = 1:4
    %     TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames3,[0 0.3],PlotColors3,'Reg')
    %     TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames3,[0.3 1.1],PlotColors3,'F')
        RegFull_Grouplvl_from_mne(niplist,chansel{c},condnames3,'RefTimeRegKendall',[0.3 1],PlotColors3,'Reg')
        RegFull_Grouplvl_from_mne(niplist,chansel{c},condnames3,'RefTimeRegKendall',[1.1 2],PlotColors3,'Reg')
        RegFull_Grouplvl_from_mne(niplist,chansel{c},condnames3,'RefTimeRegKendall',[2.2 3.4],PlotColors3,'Reg')
        RegFull_Grouplvl_from_mne(niplist,chansel{c},condnames3,'RefTimeRegKendall',[3.4 4.6],PlotColors3,'Reg')
    %     TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames2,[0 0.3],PlotColors2,'F')
    %     TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames2,[0.3 1.1],PlotColors2,'F')
    %     TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames2,[1.1 2],PlotColors2,'F')
    %     TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames2,[2.2 3.4],PlotColors2,'F')
    %     TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames2,[3.4 4.6],PlotColors2,'F')
end


chansel      = {'Mags';'Grads2';'Grads1';'EEG'};
condnames2   = {'RelPastG';'RelFutG'};
PlotColors2   =  [[0 0 1];[0.15 0.3 1 ];[0.3 0.6 1]];

for c = 1
    TLSL_GROUPlvl_save(niplist,chansel{c},condnames2,[0 1],PlotColors2,'T')
end
for c = 2
    TLSL_GROUPlvl_save(niplist,chansel{c},condnames2,[0 1],PlotColors2,'T')
end
for c = 3
    TLSL_GROUPlvl_save(niplist,chansel{c},condnames2,[0 1],PlotColors2,'T')
end
for c = 4
    TLSL_GROUPlvl_save(niplist,chansel{c},condnames2,[0 1],PlotColors2,'T')
end

chansel      = {'Mags';'Grads2';'Grads1';'EEG'};
condnames2   = {'RelWestG';'RelEastG'};
PlotColors2   =  [[0 0 1];[0.15 0.3 1 ];[0.3 0.6 1]];

for c = 1
    TLSL_GROUPlvl_save(niplist,chansel{c},condnames2,[0 1],PlotColors2,'T')
end
for c = 2
    TLSL_GROUPlvl_save(niplist,chansel{c},condnames2,[0 1],PlotColors2,'T')
end
for c = 3
    TLSL_GROUPlvl_save(niplist,chansel{c},condnames2,[0 1],PlotColors2,'T')
end
for c = 4
    TLSL_GROUPlvl_save(niplist,chansel{c},condnames2,[0 1],PlotColors2,'T')
end


chansel      = {'Mags';'Grads2';'Grads1';'EEG'};
condnames0   = {'RefW';'RefE'};
condnames1   = {'RefPar';'RefW'};
condnames2   = {'RefPar';'RefE';};
condnames3   = {'RefPre';'RefPast'};
condnames4   = {'RefPre';'RefFut'};
condnames5   = {'RefPast';'RefFut'};

PlotColors5   = [[0.5 0 0];[1 0 0]]
for c =1:4
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames0,[0 0.3],PlotColors5,'T')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames0,[0.3 1.1],PlotColors5,'T')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames5,[1.1 2],PlotColors5,'T')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames0,[2.2 3.4],PlotColors5,'T')
    TLSL_GROUPlvl_GENERAL_from_mne(niplist,chansel{c},condnames0,[3.4 4.6],PlotColors5,'T')
end

chansel    = {'Mags';'Grads2';'Grads1';'EEG'};
condnames1 = {'QtPast';'QtPre';'QtFut'};
condnames2 = {'QsWest';'QsPar'  ;'QsEast'};
PlotColors1   = [[0.5 0 0];[0 0 0];[1 0 0]];
PlotColors2   = [[0 0 1];[0 0 0];[1 0 0]];

for c = 1
    RegFull_Grouplvl_from_mne_v2(niplist,chansel{c},condnames1,'QtT',[0 1],PlotColors1,'T')
    RegFull_Grouplvl_from_mne_v2(niplist,chansel{c},condnames2,'QtS',[0 1],PlotColors2,'T')
end

for c = 2
    RegFull_Grouplvl_from_mne_v2(niplist,chansel{c},condnames1,'QtT',[0 1],PlotColors1,'T')
    RegFull_Grouplvl_from_mne_v2(niplist,chansel{c},condnames2,'QtS',[0 1],PlotColors2,'T')
end

for c = 3
    RegFull_Grouplvl_from_mne_v2(niplist,chansel{c},condnames1,'QtT',[0 1],PlotColors1,'T')
    RegFull_Grouplvl_from_mne_v2(niplist,chansel{c},condnames2,'QtS',[0 1],PlotColors2,'T')
end

for c = 4
    RegFull_Grouplvl_from_mne_v2(niplist,chansel{c},condnames1,'QtT',[0 1],PlotColors1,'T')
    RegFull_Grouplvl_from_mne_v2(niplist,chansel{c},condnames2,'QtS',[0 1],PlotColors2,'T')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%chansel    = {'Mags';'Grads2';'Grads1';'EEG'};
PlotColors1   = [[0 0 0];[0.5 0.5 0.5]];
chansel    = {'Mags';'Grads2';'Grads1';'EEG'};
RegFull_Grouplvl_from_mne(niplist,chansel{1},'SignEVSdistS_Sproj',[0 1],PlotColors1,'T')

PlotColors1   = [[0 0 0];[0.5 0.5 0.5]];
chansel    = {'Mags';'Grads2';'Grads1';'EEG'};
RegFull_Grouplvl_from_mne(niplist,chansel{1},'SignEVSdistS_Sproj',[0 1],PlotColors1,'T')

PlotColors1   = [[0 0 0];[0.5 0.5 0.5]];
chansel    = {'Mags';'Grads2';'Grads1';'EEG'};
RegFull_Grouplvl_from_mne(niplist,chansel{1},'SignEVSdistS_Sproj',[0 1],PlotColors1,'T')

PlotColors1   = [[0 0 0];[0.5 0.5 0.5]];
chansel    = {'Mags';'Grads2';'Grads1';'EEG'};
RegFull_Grouplvl_from_mne(niplist,chansel{1},'SignEVSdistS_Sproj',[0 1],PlotColors1,'T')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%

chansel    = {'Mags';'Grads2';'Grads1';'EEG'};
condnames1 = {'Qtpast';'RelFutG_intmap'};
condnames2 = {'RelPastG_coumap';'RelFutG_coumap'};
PlotColors = [[1 0 0];[1 0.75 0.3];[0 0 1];[0.3 0.6 1]];
for c = 1:4
    TLSL_GROUPlvl_INT_from_mne(niplist,chansel{c},condnames1,condnames2,[0 1],PlotColors,'T')
    TLSL_GROUPlvl_INT_from_mne(niplist,chansel{c},condnames1,condnames2,[1 1.8],PlotColors,'T')
end

chansel    = {'Mags';'Grads2';'Grads1';'EEG'};
condnames1 = {'RelPastG_intmap';'RelFutG_intmap'};
condnames2 = {'RelPastG_coumap';'RelFutG_coumap'};
PlotColors = [[1 0 0];[1 0.75 0.3];[0 0 1];[0.3 0.6 1]];
for c = 1:4
    TLSL_GROUPlvl_INT_from_mne(niplist,chansel{c},condnames1,condnames2,[0 1],PlotColors,'T')
    TLSL_GROUPlvl_INT_from_mne(niplist,chansel{c},condnames1,condnames2,[1 1.8],PlotColors,'T')
end

chansel    = {'Mags';'Grads2';'Grads1';'EEG'};
condnames1 = {'RelWestG_intmap';'RelEastG_intmap'};
condnames2 = {'RelWestG_coumap';'RelEastG_coumap'};
PlotColors = [[1 0 0];[1 0.75 0.3];[0 0 1];[0.3 0.6 1]];
for c = 1:4
    TLSL_GROUPlvl_INT_from_mne(niplist,chansel{c},condnames1,condnames2,[0 1],PlotColors,'T')
    TLSL_GROUPlvl_INT_from_mne(niplist,chansel{c},condnames1,condnames2,[1 1.8],PlotColors,'T')
end

chansel    = {'Mags';'Grads2';'Grads1';'EEG'};
condnames1 = {'RelPastG';'RelFutG'};
condnames2 = {'RelWestG';'RelEastG'};
PlotColors = [[1 0 0];[1 0.75 0.3];[0 0 1];[0.3 0.6 1]];
for c = 1:4
    TLSL_GROUPlvl_INT_from_mne(niplist,chansel{c},condnames1,condnames2,[0 1],PlotColors,'T')
    TLSL_GROUPlvl_INT_from_mne(niplist,chansel{c},condnames1,condnames2,[1 1.8],PlotColors,'T')
end

chansel    = {'Mags';'Grads2';'Grads1';'EEG'};
condnames1 = {'RelPastG_coumap';'RelFutG_coumap'};
condnames2 = {'RelWestG_coumap';'RelEastG_coumap'};
PlotColors = [[1 0 0];[1 0.75 0.3];[0 0 1];[0.3 0.6 1]];
for c = 1:4
    TLSL_GROUPlvl_INT_from_mne(niplist,chansel{c},condnames1,condnames2,[0 1],PlotColors,'T')
    TLSL_GROUPlvl_INT_from_mne(niplist,chansel{c},condnames1,condnames2,[1 1.8],PlotColors,'T')
end

chansel    = {'Mags';'Grads2';'Grads1';'EEG'};
condnames1 = {'RelPastG_intmap';'RelFutG_intmap'};
condnames2 = {'RelWestG_intmap';'RelEastG_intmap'};
PlotColors = [[1 0 0];[1 0.75 0.3];[0 0 1];[0.3 0.6 1]];
for c = 1:4
    TLSL_GROUPlvl_INT_from_mne(niplist,chansel{c},condnames1,condnames2,[0 1],PlotColors,'T')
    TLSL_GROUPlvl_INT_from_mne(niplist,chansel{c},condnames1,condnames2,[1 1.8],PlotColors,'T')
end

chansel   = {'Mags';'Grads2';'Grads1'};
condnames1 = {'EtDtq1G_Past';'EtDtq2G_Past'};
condnames2 = {'EtDtq1G_Pre';'EtDtq2G_Pre'};
condnames3 = {'EtDtq1G_Fut';'EtDtq2G_Fut'};
PlotColors = [[1 0 0];[1 0.75 0.3];[1 0 0];[1 0.75 0.3];[1 0 0];[1 0.75 0.3]];
for c = 1:3
    TLSL_GROUPlvl_REG_INT(niplist,chansel{c},condnames1,condnames2,condnames3,[0 1],PlotColors)
end

chansel   = {'Mags';'Grads2';'Grads1'};
condnames1 = {'EsDsq1G_W';'EsDsq2G_W'};
condnames2 = {'EsDsq1G_Par';'EsDsq2G_Par'};
condnames3 = {'EsDsq1G_E';'EsDsq2G_E'};
PlotColors = [[1 0 0];[1 0.75 0.3];[1 0 0];[1 0.75 0.3];[1 0 0];[1 0.75 0.3]];
for c = 1:3
    TLSL_GROUPlvl_REG_INT(niplist,chansel{c},condnames1,condnames2,condnames3,[0 1],PlotColors)
end

%%%

chansel   = {'Mags';'Grads2';'Grads1'};
PlotColors = [[1 0 0];[1 0.75 0.3]];
condclust    = {'EtDtq1G';'EtDtq2G'};
condnames = {{'EtDtq1G_Past';'EtDtq2G_Past'};...
    {'EtDtq1G_Pre';'EtDtq2G_Pre'};...
    {'EtDtq1G_Fut';'EtDtq2G_Fut'}};
for c = 1:3
    TLSL_GROUPlvl_PLOT(niplist,chansel{c},condclust,condnames,[0 1],PlotColors)
end

chansel   = {'Mags';'Grads2';'Grads1'};
PlotColors = [[1 0 0];[1 0.75 0.3]];
condclust    = {'EsDsq1A';'EsDsq2A'};
condnames = {{'EsDsq1G_W';'EsDsq2G_W'};...
    {'EsDsq1G_Par';'EsDsq2G_Par'};...
    {'EsDsq1G_E';'EsDsq2G_E'}};
for c = 1:3
    TLSL_GROUPlvl_PLOT(niplist,chansel{c},condclust,condnames,[0 1],PlotColors)
end

chansel   = {'Mags';'Grads2';'Grads1'};
PlotColors = [[1 0 0];[1 0.37 0.15];[1 0.75 0.3]];
condclust    = {'EtDtq1G';'EtDtq2G'};
condnames = {{'EtPast';'EtPre';'EtFut'}};
for c = 1:3
    TLSL_GROUPlvl_PLOT3(niplist,chansel{c},condclust,condnames,[0 1],PlotColors)
end

chansel   = {'Mags';'Grads2';'Grads1'};
PlotColors = [[1 0.7 0.7];[1 0.5 0.5];[1 0.7 0.7]];
condclust    = {'EsDsq1A';'EsDsq2A'};
condnames = {{'EsWest';'EsPar';'EsEast'}};
for c = 1:3
    TLSL_GROUPlvl_PLOT3(niplist,chansel{c},condclust,condnames,[0 1],PlotColors)
end

chansel   = {'Mags';'Grads2';'Grads1'};
PlotColors = [[0 0 1];[0.1 0.2 1];[0.2 0.4 1];[0.3 0.6 1]];
condclust    = {'EsDsq1G';'EsDsq2G';'EsDsq3G';'EsDsq4G'};
condnames = {{'EtDsq1G';'EtDsq2G';'EtDsq3G';'EtDsq4G'}};
for c = 1:3
    TLSL_GROUPlvl_PLOT4_v2(niplist,chansel{c},condclust,condnames,[0 1],PlotColors)
end

chansel   = {'Mags';'Grads2';'Grads1'};
PlotColors = [[1 0 0];[1 0.25 0.1];[1 0.5 0.2];[1 0.75 0.3]];
condclust    = {'EtDtq1G';'EtDtq2G';'EtDtq3G';'EtDtq4G'};
condnames = {{'EsDtq1G';'EsDtq2G';'EsDtq3G';'EsDtq4G'}};
for c = 1:3
    TLSL_GROUPlvl_PLOT4_v2(niplist,chansel{c},condclust,condnames,[0 1],PlotColors)
end

chansel   = {'Mags';'Grads2';'Grads1'};
PlotColors = [[0 0 1];[0.1 0.2 1];[0.2 0.4 1];[0.3 0.6 1]];
condclust    = {'EsDsq1G';'EsDsq2G';'EsDsq3G';'EsDsq4G'};
condnames = {{'EtDsq1G';'EtDsq2G';'EtDsq3G';'EtDsq4G'}};
for c = 1:3
    TLSL_GROUPlvl_PLOT4_v2(niplist,chansel{c},condclust,condnames,[1 1.8],PlotColors)
end

chansel   = {'Mags';'Grads2';'Grads1'};
PlotColors = [[1 0 0];[1 0.25 0.1];[1 0.5 0.2];[1 0.75 0.3]];
condclust    = {'EtDtq1G';'EtDtq2G';'EtDtq3G';'EtDtq4G'};
condnames = {{'EsDtq1G';'EsDtq2G';'EsDtq3G';'EsDtq4G'}};
for c = 1:3
    TLSL_GROUPlvl_PLOT4_v2(niplist,chansel{c},condclust,condnames,[1 1.8],PlotColors)
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

chansel   = {'Mags';'Grads2';'Grads1'};
for c = 1
    for i = 1:19
        
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_DIST2_EVS,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_DIST2_EVS_True,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_DIST3_EVS,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_DIST3_EVS_True,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_DIST4_EVS,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_DIST4_EVS_True,[0.3 2.5],[-0.2 2])
        
        %         TLSL_SUBJlvl_emptyroom(niplist{i},chansel{c})
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT'},@make_AVG_DIST2_EVT,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT'},@make_AVG_DIST2_EVT_True,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT'},@make_AVG_DIST3_EVT,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT'},@make_AVG_DIST3_EVT_True,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT'},@make_AVG_DIST4_EVT,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT'},@make_AVG_DIST4_EVT_True,[0.3 2.5],[-0.2 2])
        
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'QTT'},@make_AVG_QTfutvspre,[0.3 1.2],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'QTT'},@make_AVG_QTpastvspre,[0.3 1.2],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'QTT'},@make_AVG_QTfutvsprevspast,[0.3 1.2],[-0.2 2])
        
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'QTS'},@make_AVG_QTwvspar,[0.3 1.2],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'QTS'},@make_AVG_QTevspar,[0.3 1.2],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'QTS'},@make_AVG_QTwvsparvse,[0.3 1.2],[-0.2 2])
        
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT'},@make_AVG_EVfutvspre,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT'},@make_AVG_EVpastvspre,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT'},@make_AVG_EVpastvsprevsfut,[0.3 2.5],[-0.2 2])
        
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_EVwvspar,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_EVevspar,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_EVevsparvsw,[0.3 2.5],[-0.2 2])
        
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT';'EVS'},@make_AVG_EVTvsEVS,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'QTT';'QTS'},@make_AVG_QTTvsQTS,[0.3 1.2],[-0.2 2])
        
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT'},@make_AVG_DIST2_EVT_True_Past,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT'},@make_AVG_DIST2_EVT_True_Pre,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT'},@make_AVG_DIST2_EVT_True_Fut,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_DIST2_EVS_True_W,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_DIST2_EVS_True_par,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_DIST2_EVS_True_E,[0.3 2.5],[-0.2 2])
        
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_EVevsparvsw_true,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT'},@make_AVG_EVpastvsprevsfut_true,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT'},@make_AVG_EVpre_vs_nonpre,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_EVparvsnonpar,[0.3 2.5],[-0.2 2])
    end
end

chansel   = {'Mags';'Grads2';'Grads1'};
for c = 2
    for i = 1:19
        
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_DIST2_EVS,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_DIST2_EVS_True,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_DIST3_EVS,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_DIST3_EVS_True,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_DIST4_EVS,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_DIST4_EVS_True,[0.3 2.5],[-0.2 2])
        
        %         TLSL_SUBJlvl_emptyroom(niplist{i},chansel{c})
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT'},@make_AVG_DIST2_EVT,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT'},@make_AVG_DIST2_EVT_True,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT'},@make_AVG_DIST3_EVT,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT'},@make_AVG_DIST3_EVT_True,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT'},@make_AVG_DIST4_EVT,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT'},@make_AVG_DIST4_EVT_True,[0.3 2.5],[-0.2 2])
        
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'QTT'},@make_AVG_QTfutvspre,[0.3 1.2],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'QTT'},@make_AVG_QTpastvspre,[0.3 1.2],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'QTT'},@make_AVG_QTfutvsprevspast,[0.3 1.2],[-0.2 2])
        
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'QTS'},@make_AVG_QTwvspar,[0.3 1.2],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'QTS'},@make_AVG_QTevspar,[0.3 1.2],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'QTS'},@make_AVG_QTwvsparvse,[0.3 1.2],[-0.2 2])
        
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT'},@make_AVG_EVfutvspre,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT'},@make_AVG_EVpastvspre,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT'},@make_AVG_EVpastvsprevsfut,[0.3 2.5],[-0.2 2])
        
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_EVwvspar,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_EVevspar,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_EVevsparvsw,[0.3 2.5],[-0.2 2])
        
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT';'EVS'},@make_AVG_EVTvsEVS,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'QTT';'QTS'},@make_AVG_QTTvsQTS,[0.3 2.5],[-0.2 2])
        
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT'},@make_AVG_DIST2_EVT_True_Past,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT'},@make_AVG_DIST2_EVT_True_Pre,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT'},@make_AVG_DIST2_EVT_True_Fut,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_DIST2_EVS_True_W,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_DIST2_EVS_True_par,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_DIST2_EVS_True_E,[0.3 2.5],[-0.2 2])
        
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_EVevsparvsw_true,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT'},@make_AVG_EVpastvsprevsfut_true,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT'},@make_AVG_EVpre_vs_nonpre,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_EVparvsnonpar,[0.3 2.5],[-0.2 2])
    end
end

chansel   = {'Mags';'Grads2';'Grads1'};
for c = 1:3
    for i = 1:19
        %
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_DIST2_EVS,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_DIST2_EVS_True,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_DIST3_EVS,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_DIST3_EVS_True,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_DIST4_EVS,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_DIST4_EVS_True,[0.3 2.5],[-0.2 2])
        %         TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_TDIST4_EVS_True,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT'},@make_AVG_DIST2_EVT,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT'},@make_AVG_DIST2_EVT_True,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT'},@make_AVG_DIST3_EVT,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT'},@make_AVG_DIST3_EVT_True,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT'},@make_AVG_DIST4_EVT,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT'},@make_AVG_DIST4_EVT_True,[0.3 2.5],[-0.2 2])
    end
end

chansel   = {'Mags';'Grads2';'Grads1'};
for c = 1:3
    for i = 1:19
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'QTT'},@make_AVG_QTfutvspre,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'QTT'},@make_AVG_QTpastvspre,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'QTT'},@make_AVG_QTfutvsprevspast,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'QTS'},@make_AVG_QTwvspar,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'QTS'},@make_AVG_QTevspar,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'QTS'},@make_AVG_QTwvsparvse,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'QTS'},@make_AVG_QTpar_vsnopar,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'QTT'},@make_AVG_QTpre_nvsnopre,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'QTT';'QTS'},@make_AVG_QTTvsQTS,[0.3 2.5],[-0.2 2])
    end
end

chansel   = {'Mags';'Grads2';'Grads1'};
for c = 1:3
    for i = 1:19
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT'},@make_AVG_EVfutvspre,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT'},@make_AVG_EVpastvspre,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT'},@make_AVG_EVpastvsprevsfut,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT'},@make_AVG_EVpastvsprevsfut_Left,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT'},@make_AVG_EVpastvsprevsfut_Right,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_EVwvspar,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_EVevspar,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_EVevsparvsw,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT';'EVS'},@make_AVG_EVTvsEVS,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_EVevsparvsw_true,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT'},@make_AVG_EVpastvsprevsfut_true,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT'},@make_AVG_EVpre_vs_nonpre,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_EVparvsnonpar,[0.3 2.5],[-0.2 2])
    end
end


%         TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT'},@make_AVG_DIST2_EVT_True_Past,[0.3 2.5],[-0.2 2])
%         TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT'},@make_AVG_DIST2_EVT_True_Pre,[0.3 2.5],[-0.2 2])
%         TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT'},@make_AVG_DIST2_EVT_True_Fut,[0.3 2.5],[-0.2 2])
%         TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_DIST2_EVS_True_W,[0.3 2.5],[-0.2 2])
%         TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_DIST2_EVS_True_par,[0.3 2.5],[-0.2 2])
%         TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_DIST2_EVS_True_E,[0.3 2.5],[-0.2 2])

chansel   = {'Mags';'Grads2';'Grads1'};
for c = 1:3
    for i = 1:19
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT'},@make_AVG_EVpre_vs_nonpre_Left,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_EVparvsnonpar_Left,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT'},@make_AVG_EVpre_vs_nonpre_Right,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_EVparvsnonpar_Right,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_EVevsparvsw_Left,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_EVevsparvsw_Right,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT'},@make_AVG_DIST4_EVT_Left,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT'},@make_AVG_DIST4_EVT_Right,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_DIST4_EVS_Left,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_DIST4_EVS_Right,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT'},@make_AVG_relPastRelFut,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT'},@make_AVG_relPastG_RelFutG,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_relWestRelEast,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_relWestG_RelEastG,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT'},@make_AVG_relPastG_RelFutG_intmap,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVT'},@make_AVG_relPastG_RelFutG_coumap,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_relWestG_RelEastG_intmap,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_from_MNE(niplist{i},chansel{c},{'EVS'},@make_AVG_relWestG_RelEastG_coumap,[0.3 2.5],[-0.2 2])
    end
end

chansel   = {'Mags';'Grads2';'Grads1'};
% chansel   = {'GradComb'};
for c = 1
    for i = 1:19
        RegFull_SUBJlvl_from_mne(niplist{i},chansel{c},{'EVT'},@make_AVG_signDIST36_EVT_TPROJ_True,[0.3 2.5],[-0.2 2])
    end
end

chansel   = {'Mags';'Grads2';'Grads1'};
for c = 2
    for i = 1:19
        RegFull_SUBJlvl_from_mne(niplist{i},chansel{c},{'EVT'},@make_AVG_signDIST36_EVT_TPROJ_True,[0.3 2.5],[-0.2 2])
    end
end

chansel   = {'Mags';'Grads2';'Grads1'};
for c = 3
    for i = 1:19
        RegFull_SUBJlvl_from_mne(niplist{i},chansel{c},{'EVT'},@make_AVG_signDIST36_EVT_TPROJ_True,[0.3 2.5],[-0.2 2])
    end
end

for i = 1:19
        RegFull_SUBJlvl_from_mne(niplist{i},'EEG',{'EVT'},@make_AVG_signDIST36_EVT_TPROJ_True,[0.3 2.5],[-0.2 2])
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
chansel   = {'Mags';'Grads2';'Grads1'};
% chansel   = {'GradComb'};
for c = 1
    for i = 1:19
        RegFull_SUBJlvl_from_mne(niplist{i},chansel{c},{'EVS'},@make_AVG_signDIST36_EVS_SPROJ_True,[0.3 2.5],[-0.2 2])
    end
end

chansel   = {'Mags';'Grads2';'Grads1'};
for c = 2
    for i = 1:19
        RegFull_SUBJlvl_from_mne(niplist{i},chansel{c},{'EVS'},@make_AVG_signDIST36_EVS_SPROJ_True,[0.3 2.5],[-0.2 2])
    end
end

chansel   = {'Mags';'Grads2';'Grads1'};
for c = 3
    for i = 1:19
        RegFull_SUBJlvl_from_mne(niplist{i},chansel{c},{'EVS'},@make_AVG_signDIST36_EVS_SPROJ_True,[0.3 2.5],[-0.2 2])
    end
end

for i = 1:19
    RegFull_SUBJlvl_from_mne(niplist{i},'EEG',{'EVS'},@make_AVG_signDIST36_EVS_SPROJ_True,[0.3 2.5],[-0.2 2])
end

TLSL_SUBJlvl_redefined('sd130343','Mags',{'REF'},{'QTT';'QTS'},@make_AVG_REF_W_Par_E,[0.3 5],[-0.2 4])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%% REGRESSION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
chansel   = {'Mags';'Grads2';'Grads1';'EEG'};
for c = 1
    for i = 1:19
        RegFull_SUBJlvl_from_mne(niplist{i},chansel{c},{'EVT'},@make_AVG_signDIST36_EVT_True,[0.3 2.5],[-0.2 2])
        RegFull_SUBJlvl_from_mne(niplist{i},chansel{c},{'EVS'},@make_AVG_signDIST36_EVS_True,[0.3 2.5],[-0.2 2])
    end
end

chansel   = {'Mags';'Grads2';'Grads1';'EEG'};
for c = 2
    for i = 1:19
        RegFull_SUBJlvl_from_mne(niplist{i},chansel{c},{'EVT'},@make_AVG_signDIST36_EVT_True,[0.3 2.5],[-0.2 2])
        RegFull_SUBJlvl_from_mne(niplist{i},chansel{c},{'EVS'},@make_AVG_signDIST36_EVS_True,[0.3 2.5],[-0.2 2])
    end
end

chansel   = {'Mags';'Grads2';'Grads1';'EEG'};
for c = 3
    for i = 1:19
        RegFull_SUBJlvl_from_mne(niplist{i},chansel{c},{'EVT'},@make_AVG_signDIST36_EVT_True,[0.3 2.5],[-0.2 2])
        RegFull_SUBJlvl_from_mne(niplist{i},chansel{c},{'EVS'},@make_AVG_signDIST36_EVS_True,[0.3 2.5],[-0.2 2])
    end
end

chansel   = {'Mags';'Grads2';'Grads1';'EEG'};
for c = 4
    for i = 1:19
        RegFull_SUBJlvl_from_mne(niplist{i},chansel{c},{'EVT'},@make_AVG_signDIST36_EVT_True,[0.3 2.5],[-0.2 2])
        RegFull_SUBJlvl_from_mne(niplist{i},chansel{c},{'EVS'},@make_AVG_signDIST36_EVS_True,[0.3 2.5],[-0.2 2])
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%% REGRESSION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
chansel   = {'Mags';'Grads2';'Grads1';'EEG'};
for c = 1
    for i = 1:19
        RegOrd_SUBJlvl_from_mne(niplist{i},chansel{c},{'QTS'},@make_AVG_QTwvsparvse,[0.3 2.5],[-0.2 2])
        RegOrd_SUBJlvl_from_mne(niplist{i},chansel{c},{'QTT'},@make_AVG_QTfutvsprevspast,[0.3 2.5],[-0.2 2])
    end
end

chansel   = {'Mags';'Grads2';'Grads1';'EEG'};
for c = 2
    for i = 1:19
        RegOrd_SUBJlvl_from_mne(niplist{i},chansel{c},{'QTS'},@make_AVG_QTwvsparvse,[0.3 2.5],[-0.2 2])
        RegOrd_SUBJlvl_from_mne(niplist{i},chansel{c},{'QTT'},@make_AVG_QTfutvsprevspast,[0.3 2.5],[-0.2 2])
    end
end

chansel   = {'Mags';'Grads2';'Grads1';'EEG'};
for c = 3
    for i = 1:19
        RegOrd_SUBJlvl_from_mne(niplist{i},chansel{c},{'QTS'},@make_AVG_QTwvsparvse,[0.3 2.5],[-0.2 2])
        RegOrd_SUBJlvl_from_mne(niplist{i},chansel{c},{'QTT'},@make_AVG_QTfutvsprevspast,[0.3 2.5],[-0.2 2])
    end
end

chansel   = {'Mags';'Grads2';'Grads1';'EEG'};
for c = 4
    for i = 1:19
        RegOrd_SUBJlvl_from_mne(niplist{i},chansel{c},{'QTS'},@make_AVG_QTwvsparvse,[0.3 2.5],[-0.2 2])
        RegOrd_SUBJlvl_from_mne(niplist{i},chansel{c},{'QTT'},@make_AVG_QTfutvsprevspast,[0.3 2.5],[-0.2 2])
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
chansel   = {'Mags';'Grads2';'Grads1'};
for i = 1:19
    TLSL_SUBJlvl_from_MNE_empty(niplist{i},chansel{1},{'EVS'},@make_AVG_SignedDistperRefSpaceFullRange, [0.3 2.5],[-0.2 2])
    TLSL_SUBJlvl_from_MNE_empty(niplist{i},chansel{1},{'EVT'},@make_AVG_SignedDistperRefTimeFullRange,[0.3 2.5],[-0.2 2])
end

chansel   = {'Mags';'Grads2';'Grads1'};
for i = 1:19
    TLSL_SUBJlvl_from_MNE_empty(niplist{i},chansel{2},{'EVS'},@make_AVG_SignedDistperRefSpaceFullRange, [0.3 2.5],[-0.2 2])
    TLSL_SUBJlvl_from_MNE_empty(niplist{i},chansel{2},{'EVT'},@make_AVG_SignedDistperRefTimeFullRange,[0.3 2.5],[-0.2 2])
end

chansel   = {'Mags';'Grads2';'Grads1'};
for i = 1:19
    TLSL_SUBJlvl_from_MNE_empty(niplist{i},chansel{3},{'EVS'},@make_AVG_SignedDistperRefSpaceFullRange, [0.3 2.5],[-0.2 2])
    TLSL_SUBJlvl_from_MNE_empty(niplist{i},chansel{3},{'EVT'},@make_AVG_SignedDistperRefTimeFullRange,[0.3 2.5],[-0.2 2])
end

chansel   = {'EEG'};
for i = 1:19
    TLSL_SUBJlvl_EEG_from_mne_empty(niplist{i},chansel{1},{'EVS'},@make_AVG_SignedDistperRefSpaceFullRange,[0.3 2.5],[-0.2 2])
    TLSL_SUBJlvl_EEG_from_mne_empty(niplist{i},chansel{1},{'EVT'},@make_AVG_SignedDistperRefTimeFullRange,[0.3 2.5],[-0.2 2])
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%% REGRESSION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
chansel   = {'Mags';'Grads2';'Grads1';'EEG'};
for c = 1
    for i = 1:19
        Reg_SUBJlvl_from_mne(niplist{i},chansel{c},{'QTS'},@make_AVG_QTwvsparvse,[0.3 2.5],[-0.2 2])
        Reg_SUBJlvl_from_mne(niplist{i},chansel{c},{'QTT'},@make_AVG_QTfutvsprevspast,[0.3 2.5],[-0.2 2])
        Reg_SUBJlvl_from_mne(niplist{i},chansel{c},{'REF'},@make_AVG_REF_W_Par_E,[0.3 2.5],[-0.2 2.2])
        Reg_SUBJlvl_from_mne(niplist{i},chansel{c},{'REF'},@make_AVG_REF_Past_Pre_Fut,[0.3 2.5],[-0.2 2.2])
    end
end

chansel   = {'Mags';'Grads2';'Grads1';'EEG'};
for c = 2
    for i = 1:19
        Reg_SUBJlvl_from_mne(niplist{i},chansel{c},{'QTS'},@make_AVG_QTwvsparvse,[0.3 2.5],[-0.2 2])
        Reg_SUBJlvl_from_mne(niplist{i},chansel{c},{'QTT'},@make_AVG_QTfutvsprevspast,[0.3 2.5],[-0.2 2])
        Reg_SUBJlvl_from_mne(niplist{i},chansel{c},{'REF'},@make_AVG_REF_W_Par_E,[0.3 2.5],[-0.2 2.2])
        Reg_SUBJlvl_from_mne(niplist{i},chansel{c},{'REF'},@make_AVG_REF_Past_Pre_Fut,[0.3 2.5],[-0.2 2.2])
    end
end

chansel   = {'Mags';'Grads2';'Grads1';'EEG'};
for c = 3
    for i = 1:19
        Reg_SUBJlvl_from_mne(niplist{i},chansel{c},{'QTS'},@make_AVG_QTwvsparvse,[0.3 2.5],[-0.2 2])
        Reg_SUBJlvl_from_mne(niplist{i},chansel{c},{'QTT'},@make_AVG_QTfutvsprevspast,[0.3 2.5],[-0.2 2])
        Reg_SUBJlvl_from_mne(niplist{i},chansel{c},{'REF'},@make_AVG_REF_W_Par_E,[0.3 2.5],[-0.2 2.2])
        Reg_SUBJlvl_from_mne(niplist{i},chansel{c},{'REF'},@make_AVG_REF_Past_Pre_Fut,[0.3 2.5],[-0.2 2.2])
    end
end

chansel   = {'Mags';'Grads2';'Grads1';'EEG'};
for c = 4
    for i = 1:19
        Reg_SUBJlvl_from_mne(niplist{i},chansel{c},{'QTS'},@make_AVG_QTwvsparvse,[0.3 2.5],[-0.2 2])
        Reg_SUBJlvl_from_mne(niplist{i},chansel{c},{'QTT'},@make_AVG_QTfutvsprevspast,[0.3 2.5],[-0.2 2])
        Reg_SUBJlvl_from_mne(niplist{i},chansel{c},{'REF'},@make_AVG_REF_W_Par_E,[0.3 2.5],[-0.2 2.2])
        Reg_SUBJlvl_from_mne(niplist{i},chansel{c},{'REF'},@make_AVG_REF_Past_Pre_Fut,[0.3 2.5],[-0.2 2.2])
    end
end




