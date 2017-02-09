% MAIN SCRIPT MTT

close all
clear all

bcktmprd = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/backup_temprod/SCRIPTS';
bcktmprd2 = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/backup_temprod/FIELDTRIP';

% addpath('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/fieldtrip-20130901')
addpath('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/fieldtrip-20151209')
addpath(genpath([bcktmprd '/Matlab_pipeline/Ref_functions']));
addpath([bcktmprd '/Matlab_pipeline/My_functions/Preprocessing']);
addpath(bcktmprd2);
addpath('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts');
addpath('/neurospin/meg/meg_tmp/temprod_Baptiste_2010/SCRIPTS/Matlab_pipeline/My_functions/Misc')

ft_defaults

niplist = {'sd130343' ;'cb130477' ;'rb130313'   ;'jm100042' ;'jm100109';'sb120316';...
    'tk130502'  ;'lm130479' ;'sg120518'   ;'ms130534';'ma100253';'sl130503';...
    'mb140004';'mp140019';'mm130405';'dm130250';'hr130504' ;'wl130316';'rl130571'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% GROUP analysis %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% niplist = {'sd130343' ;'cb130477' ;'rb130313'   ;'jm100042' ;'jm100109';'sb120316';...
%     'tk130502'  ;'lm130479' ;'sg120518'   ;'ms130534';'ma100253';'sl130503';...
%     'mp140019';'dm130250';'hr130504' ;'wl130316'};

condnames = {'allEventsavbACT';'allEventsavbBASE'};
PlotColors = [[0.5 0.5 0.5];[0.2 0.2 0.2]];
TLSL_GROUPlvl_actvsblt(niplist,'EEG',condnames,PlotColors)

condnames = {'EtDtq1A';'EtDtq2A';'EtDtq3A';'EtDtq4A'};
PlotColors = [[1 0 0];[1 0.25 0.1];[1 0.5 0.2];[1 0.75 0.3]];
TLSL_GROUPlvl_REG4lvl(niplist,'EEG',condnames,[0 1],PlotColors)

condnames = {'EtDtq1G';'EtDtq2G';'EtDtq3G';'EtDtq4G'};
PlotColors = [[1 0 0];[1 0.25 0.1];[1 0.5 0.2];[1 0.75 0.3]];
TLSL_GROUPlvl_REG4lvl(niplist,'EEG',condnames,[0 1],PlotColors)

condnames = {'EtDtq1A';'EtDtq2A';'EtDtq3A'};
PlotColors = [[1 0 0];[1 0.37 0.15];[1 0.75 0.3]];
TLSL_GROUPlvl_REG(niplist,'EEG',condnames,[0 1],PlotColors)

condnames = {'EtDtq1G';'EtDtq2G';'EtDtq3G'};
PlotColors = [[1 0 0];[1 0.37 0.15];[1 0.75 0.3]];
TLSL_GROUPlvl_REG(niplist,'EEG',condnames,[0 1],PlotColors)

condnames = {'EtDtq1G';'EtDtq2G'};
PlotColors = [[1 0 0];[1 0.75 0.3]];
TLSL_GROUPlvl(niplist,'EEG',condnames,[0 1],PlotColors)

condnames = {'EtDtq1A';'EtDtq2A'};
PlotColors = [[1 0 0];[1 0.75 0.3]];
TLSL_GROUPlvl(niplist,'EEG',condnames,[0 1],PlotColors)

condnames = {'EsDsq1A';'EsDsq2A';'EsDsq3A';'EsDsq4A'};
PlotColors = [[0 0 1];[0.1 0.2 1];[0.2 0.4 1];[0.3 0.6 1]];
TLSL_GROUPlvl_REG4lvl(niplist,'EEG',condnames,[0 1],PlotColors)

condnames = {'EsDsq1G';'EsDsq2G';'EsDsq3G';'EsDsq4G'};
PlotColors = [[0 0 1];[0.1 0.2 1];[0.2 0.4 1];[0.3 0.6 1]];
TLSL_GROUPlvl_REG4lvl(niplist,'EEG',condnames,[0 1],PlotColors)

condnames = {'EsDsq1A';'EsDsq2A';'EsDsq3A'};
PlotColors = [[0 0 1];[0.15 0.3 1 ];[0.3 0.6 1]];
TLSL_GROUPlvl_REG(niplist,'EEG',condnames,[0 1],PlotColors)

condnames = {'EsDsq1G';'EsDsq2G';'EsDsq3G'};
PlotColors = [[0 0 1];[0.15 0.3 1 ];[0.3 0.6 1]];
TLSL_GROUPlvl_REG(niplist,'EEG',condnames,[0 1],PlotColors)

condnames = {'EsDsq1A';'EsDsq2A'};
PlotColors = [[0 0 1];[0.3 0.6 1]];
TLSL_GROUPlvl(niplist,'EEG',condnames,[0 1],PlotColors)

condnames = {'EsDsq1G';'EsDsq2G'};
PlotColors = [[0 0 1];[0.3 0.6 1]];
TLSL_GROUPlvl(niplist,'EEG',condnames,[0 1],PlotColors)

condnames = {'EtPre';'EtFut'};
PlotColors = [[1 0.5 0.5];[1 0.3 .3]];
TLSL_GROUPlvl(niplist,'EEG',condnames,[0 1],PlotColors)

condnames = {'EtPre';'EtPast'};
PlotColors = [[1 0.5 0.5];[1 0.7 0.7]];
TLSL_GROUPlvl(niplist,'EEG',condnames,[0 1],PlotColors)

condnames = {'EtPast';'EtPre';'EtFut'};
PlotColors = [[1 0.7 0.7];[1 0.5 0.5];[1 0.7 0.7]];
TLSL_GROUPlvl_REG(niplist,'EEG',condnames,[0 1],PlotColors)

condnames = {'EsPar';'EsEast'};
PlotColors = [[0.5 0.5 1];[0.3 0.3 1]];
TLSL_GROUPlvl(niplist,'EEG',condnames,[0 1],PlotColors)

condnames = {'EsPar';'EsWest'};
PlotColors = [[0.5 0.5 1];[0.7 0.7 1]];
TLSL_GROUPlvl(niplist,'EEG',condnames,[0 1],PlotColors)

condnames = {'EsWest';'EsPar';'EsEast'};
PlotColors = [[0.7 0.7 1];[0.5 0.5 1];[0.7 0.7 1]];
TLSL_GROUPlvl_REG(niplist,'EEG',condnames,[0 1],PlotColors)

condnames1 = {'EtDtq1G';'EtDtq2G'};
condnames2 = {'EsDsq1G';'EsDsq2G'};
PlotColors = [[1 0 0];[1 0.75 0.3];[0 0 1];[0.3 0.6 1]];
TLSL_GROUPlvl_INT(niplist,'EEG',condnames1,condnames2,[0 1],PlotColors)

condnames = {'Et_all';'Es_all'};
PlotColors = [[1 0 0];[0 0 1]];
TLSL_GROUPlvl(niplist,'EEG',condnames,[0 1],PlotColors)

condnames = {'Qt_all';'Qs_all'};
PlotColors = [[1 0 0];[0 0 1]];
TLSL_GROUPlvl(niplist,'EEG',condnames,[0 1],PlotColors)

%%%
%%
condnames = {'EtDtq1G_Past';'EtDtq2G_Past'};
PlotColors = [[0 0 1];[0.1 0.2 1];[0.2 0.4 1];[0.3 0.6 1]];
TLSL_GROUPlvl(niplist,'EEG',condnames,[0 1],PlotColors)

condnames = {'EtDtq1G_Pre';'EtDtq2G_Pre'};
PlotColors = [[0 0 1];[0.1 0.2 1];[0.2 0.4 1];[0.3 0.6 1]];
TLSL_GROUPlvl(niplist,'EEG',condnames,[0 1],PlotColors)

condnames = {'EtDtq1G_Fut';'EtDtq2G_Fut'};
PlotColors = [[0 0 1];[0.1 0.2 1];[0.2 0.4 1];[0.3 0.6 1]];
TLSL_GROUPlvl(niplist,'EEG',condnames,[0 1],PlotColors)

condnames = {'EsDsq1G_W';'EsDsq2G_W'};
PlotColors = [[0 0 1];[0.1 0.2 1];[0.2 0.4 1];[0.3 0.6 1]];
TLSL_GROUPlvl(niplist,'EEG',condnames,[0 1],PlotColors)

condnames = {'EsDsq1G_E';'EsDsq2G_E'};
PlotColors = [[0 0 1];[0.1 0.2 1];[0.2 0.4 1];[0.3 0.6 1]];
TLSL_GROUPlvl(niplist,'EEG',condnames,[0 1],PlotColors)

condnames = {'EsDsq1G_Par';'EsDsq2G_Par'};
PlotColors = [[0 0 1];[0.1 0.2 1];[0.2 0.4 1];[0.3 0.6 1]];
TLSL_GROUPlvl(niplist,'EEG',condnames,[0 1],PlotColors)

condnames = {'EsWestG';'EsParG';'EsEastG'};
PlotColors = [[1 0.7 0.7];[1 0.5 0.5];[1 0.7 0.7]];
TLSL_GROUPlvl_REG(niplist,'EEG',condnames,[0 1],PlotColors)

condnames = {'EtPastG';'EtPreG';'EtFutG'};
PlotColors = [[1 0.7 0.7];[1 0.5 0.5];[1 0.7 0.7]];
TLSL_GROUPlvl_REG(niplist,'EEG',condnames,[0 1],PlotColors)

condnames = {'EsWest';'EsPar';'EsEast'};
PlotColors = [[0.7 0.7 1];[0.5 0.5 1];[0.7 0.7 1]];
TLSL_GROUPlvl_REG(niplist,'EEG',condnames,[0 1],PlotColors)

condnames =  {'EsPar';'EsnoPar'};
PlotColors = [[1 0.5 0.5];[1 0.7 0.7]];
TLSL_GROUPlvl(niplist,'EEG',condnames,[0 1],PlotColors)

condnames =  {'EtPre';'EtnoPre'};
PlotColors = [[1 0.5 0.5];[1 0.7 0.7]];
TLSL_GROUPlvl(niplist,'EEG',condnames,[0 1],PlotColors)

%%%

condnames1 = {'EtDtq1G';'EtDtq2G'};
condnames2 = {'EsDsq1G';'EsDsq2G'};
PlotColors = [[1 0 0];[1 0.75 0.3];[0 0 1];[0.3 0.6 1]];
TLSL_GROUPlvl_INT(niplist,'EEG',condnames1,condnames2,[0 1],PlotColors)

chansel   = {'Mags';'Grads2';'Grads1'};
condnames1 = {'EtDtq1G_Past';'EtDtq2G_Past'};
condnames2 = {'EtDtq1G_Pre';'EtDtq2G_Pre'};
condnames3 = {'EtDtq1G_Fut';'EtDtq2G_Fut'};
PlotColors = [[1 0 0];[1 0.75 0.3];[1 0 0];[1 0.75 0.3];[1 0 0];[1 0.75 0.3]];
TLSL_GROUPlvl_REG_INT(niplist,'EEG',condnames1,condnames2,condnames3,[0 1],PlotColors)

chansel   = {'Mags';'Grads2';'Grads1'};
condnames1 = {'EsDsq1G_W';'EsDsq2G_W'};
condnames2 = {'EsDsq1G_Par';'EsDsq2G_Par'};
condnames3 = {'EsDsq1G_E';'EsDsq2G_E'};
PlotColors = [[1 0 0];[1 0.75 0.3];[1 0 0];[1 0.75 0.3];[1 0 0];[1 0.75 0.3]];
TLSL_GROUPlvl_REG_INT(niplist,'EEG',condnames1,condnames2,condnames3,[0 1],PlotColors)

%%%
PlotColors = [[1 0 0];[1 0.75 0.3]];
condclust    = {'EtDtq1G';'EtDtq2G'};
condnames = {{'EtDtq1G_Past';'EtDtq2G_Past'};...
    {'EtDtq1G_Pre';'EtDtq2G_Pre'};...
    {'EtDtq1G_Fut';'EtDtq2G_Fut'}};
TLSL_GROUPlvl_PLOT(niplist,'EEG',condclust,condnames,[0 1],PlotColors)

PlotColors = [[1 0 0];[1 0.75 0.3]];
condclust    = {'EsDsq1A';'EsDsq2A'};
condnames = {{'EsDsq1G_W';'EsDsq2G_W'};...
    {'EsDsq1G_Par';'EsDsq2G_Par'};...
    {'EsDsq1G_E';'EsDsq2G_E'}};
TLSL_GROUPlvl_PLOT(niplist,'EEG',condclust,condnames,[0 1],PlotColors)

PlotColors = [[1 0 0];[1 0.37 0.15];[1 0.75 0.3]];
condclust    = {'EtDtq1G';'EtDtq2G'};
condnames = {{'EtPast';'EtPre';'EtFut'}};
TLSL_GROUPlvl_PLOT3(niplist,'EEG',condclust,condnames,[0 1],PlotColors)

PlotColors = [[1 0.7 0.7];[1 0.5 0.5];[1 0.7 0.7]];
condclust    = {'EsDsq1A';'EsDsq2A'};
condnames = {{'EsWest';'EsPar';'EsEast'}};
TLSL_GROUPlvl_PLOT3(niplist,'EEG',condclust,condnames,[0 1],PlotColors)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% REF conds %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i = 1:length(niplist)
    %
    TLSL_SUBJlvl_EEG_from_mne(niplist{i},'EEG',{'EVS'},@make_AVG_DIST2_EVS,[0.3 2.5],[-0.2 2])
    TLSL_SUBJlvl_EEG_from_mne(niplist{i},'EEG',{'EVS'},@make_AVG_DIST2_EVS_True,[0.3 2.5],[-0.2 2])
    TLSL_SUBJlvl_EEG_from_mne(niplist{i},'EEG',{'EVS'},@make_AVG_DIST3_EVS,[0.3 2.5],[-0.2 2])
    TLSL_SUBJlvl_EEG_from_mne(niplist{i},'EEG',{'EVS'},@make_AVG_DIST3_EVS_True,[0.3 2.5],[-0.2 2])
    TLSL_SUBJlvl_EEG_from_mne(niplist{i},'EEG',{'EVS'},@make_AVG_DIST4_EVS,[0.3 2.5],[-0.2 2])
    TLSL_SUBJlvl_EEG_from_mne(niplist{i},'EEG',{'EVS'},@make_AVG_DIST4_EVS_True,[0.3 2.5],[-0.2 2])
    
    TLSL_SUBJlvl_EEG_from_mne(niplist{i},'EEG',{'EVT'},@make_AVG_DIST2_EVT_True,[0.3 2.5],[-0.2 2])
    TLSL_SUBJlvl_EEG_from_mne(niplist{i},'EEG',{'EVT'},@make_AVG_DIST2_EVT,[0.3 2.5],[-0.2 2])
    TLSL_SUBJlvl_EEG_from_mne(niplist{i},'EEG',{'EVT'},@make_AVG_DIST3_EVT,[0.3 2.5],[-0.2 2])
    TLSL_SUBJlvl_EEG_from_mne(niplist{i},'EEG',{'EVT'},@make_AVG_DIST3_EVT_True,[0.3 2.5],[-0.2 2])
    TLSL_SUBJlvl_EEG_from_mne(niplist{i},'EEG',{'EVT'},@make_AVG_DIST4_EVT,[0.3 2.5],[-0.2 2])
    TLSL_SUBJlvl_EEG_from_mne(niplist{i},'EEG',{'EVT'},@make_AVG_DIST4_EVT_True,[0.3 2.5],[-0.2 2])
    
    TLSL_SUBJlvl_EEG_from_mne(niplist{i},'EEG',{'QTT'},@make_AVG_QTfutvspre,[0.3 1.2],[-0.2 2])
    TLSL_SUBJlvl_EEG_from_mne(niplist{i},'EEG',{'QTT'},@make_AVG_QTpastvspre,[0.3 1.2],[-0.2 2])
    TLSL_SUBJlvl_EEG_from_mne(niplist{i},'EEG',{'QTT'},@make_AVG_QTfutvsprevspast,[0.3 1.2],[-0.2 2])
    
    TLSL_SUBJlvl_EEG_from_mne(niplist{i},'EEG',{'QTS'},@make_AVG_QTwvspar,[0.3 1.2],[-0.2 2])
    TLSL_SUBJlvl_EEG_from_mne(niplist{i},'EEG',{'QTS'},@make_AVG_QTevspar,[0.3 1.2],[-0.2 2])
    TLSL_SUBJlvl_EEG_from_mne(niplist{i},'EEG',{'QTS'},@make_AVG_QTwvsparvse,[0.3 1.2],[-0.2 2])
    
    TLSL_SUBJlvl_EEG_from_mne(niplist{i},'EEG',{'EVT'},@make_AVG_EVfutvspre,[0.3 2.5],[-0.2 2])
    TLSL_SUBJlvl_EEG_from_mne(niplist{i},'EEG',{'EVT'},@make_AVG_EVpastvspre,[0.3 2.5],[-0.2 2])
    TLSL_SUBJlvl_EEG_from_mne(niplist{i},'EEG',{'EVT'},@make_AVG_EVpastvsprevsfut,[0.3 2.5],[-0.2 2])
    
    TLSL_SUBJlvl_EEG_from_mne(niplist{i},'EEG',{'EVS'},@make_AVG_EVwvspar,[0.3 2.5],[-0.2 2])
    TLSL_SUBJlvl_EEG_from_mne(niplist{i},'EEG',{'EVS'},@make_AVG_EVevspar,[0.3 2.5],[-0.2 2])
    TLSL_SUBJlvl_EEG_from_mne(niplist{i},'EEG',{'EVS'},@make_AVG_EVevsparvsw,[0.3 2.5],[-0.2 2])
    
    TLSL_SUBJlvl_EEG_from_mne(niplist{i},'EEG',{'EVT';'EVS'},@make_AVG_EVTvsEVS,[0.3 2.5],[-0.2 2])
    TLSL_SUBJlvl_EEG_from_mne(niplist{i},'EEG',{'QTT';'QTS'},@make_AVG_QTTvsQTS,[0.3 1.2],[-0.2 2])
    
    TLSL_SUBJlvl_EEG_from_mne(niplist{i},'EEG',{'EVT'},@make_AVG_DIST2_EVT_True_Past,[0.3 2.5],[-0.2 2])
    TLSL_SUBJlvl_EEG_from_mne(niplist{i},'EEG',{'EVT'},@make_AVG_DIST2_EVT_True_Pre,[0.3 2.5],[-0.2 2])
    TLSL_SUBJlvl_EEG_from_mne(niplist{i},'EEG',{'EVT'},@make_AVG_DIST2_EVT_True_Fut,[0.3 2.5],[-0.2 2])
    TLSL_SUBJlvl_EEG_from_mne(niplist{i},'EEG',{'EVS'},@make_AVG_DIST2_EVS_True_W,[0.3 2.5],[-0.2 2])
    TLSL_SUBJlvl_EEG_from_mne(niplist{i},'EEG',{'EVS'},@make_AVG_DIST2_EVS_True_par,[0.3 2.5],[-0.2 2])
    TLSL_SUBJlvl_EEG_from_mne(niplist{i},'EEG',{'EVS'},@make_AVG_DIST2_EVS_True_E,[0.3 2.5],[-0.2 2])
    
    TLSL_SUBJlvl_EEG_from_mne(niplist{i},'EEG',{'EVS'},@make_AVG_EVevsparvsw_true,[0.3 2.5],[-0.2 2])
    TLSL_SUBJlvl_EEG_from_mne(niplist{i},'EEG',{'EVT'},@make_AVG_EVpastvsprevsfut_true,[0.3 2.5],[-0.2 2])
    TLSL_SUBJlvl_EEG_from_mne(niplist{i},'EEG',{'EVT'},@make_AVG_EVpre_vs_nonpre,[0.3 2.5],[-0.2 2])
    TLSL_SUBJlvl_EEG_from_mne(niplist{i},'EEG',{'EVS'},@make_AVG_EVparvsnonpar,[0.3 2.5],[-0.2 2])
    
end

for i = 1:19
    
    TLSL_SUBJlvl_EEG_from_mne(niplist{i},'EEG',{'REF'},@make_AVG_REF_W_Par_E,[0.3 2.2],[-0.2 2])
    TLSL_SUBJlvl_EEG_from_mne(niplist{i},'EEG',{'REF'},@make_AVG_REF_W_Par,[0.3 2.2],[-0.2 2])
    TLSL_SUBJlvl_EEG_from_mne(niplist{i},'EEG',{'REF'},@make_AVG_REF_Pre_Fut,[0.3 2.2],[-0.2 2])
    TLSL_SUBJlvl_EEG_from_mne(niplist{i},'EEG',{'REF'},@make_AVG_REF_Past_Pre_Fut,[0.3 2.2],[-0.2 2])
    TLSL_SUBJlvl_EEG_from_mne(niplist{i},'EEG',{'REF'},@make_AVG_REF_Past_Pre,[0.3 2.2],[-0.2 2])
    TLSL_SUBJlvl_EEG_from_mne(niplist{i},'EEG',{'REF'},@make_AVG_REF_Par_E,[0.3 2.2],[-0.2 2])
    
end

chansel   = {'EEG'};
for c = 1
    for i = 1:19
        %
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'EVS'},@make_AVG_DIST2_EVS,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'EVS'},@make_AVG_DIST2_EVS_True,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'EVS'},@make_AVG_DIST3_EVS,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'EVS'},@make_AVG_DIST3_EVS_True,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'EVS'},@make_AVG_DIST4_EVS,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'EVS'},@make_AVG_DIST4_EVS_True,[0.3 2.5],[-0.2 2])
%         TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'EVS'},@make_AVG_TDIST4_EVS_True,[0.3 2.5],[-0.2 2])

        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'EVT'},@make_AVG_DIST2_EVT,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'EVT'},@make_AVG_DIST2_EVT_True,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'EVT'},@make_AVG_DIST3_EVT,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'EVT'},@make_AVG_DIST3_EVT_True,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'EVT'},@make_AVG_DIST4_EVT,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'EVT'},@make_AVG_DIST4_EVT_True,[0.3 2.5],[-0.2 2])

        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'QTT'},@make_AVG_QTfutvspre,[0.3 1.2],[-0.2 2])
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'QTT'},@make_AVG_QTpastvspre,[0.3 1.2],[-0.2 2])
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'QTT'},@make_AVG_QTfutvsprevspast,[0.3 1.2],[-0.2 2])
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'QTS'},@make_AVG_QTwvspar,[0.3 1.2],[-0.2 2])
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'QTS'},@make_AVG_QTevspar,[0.3 1.2],[-0.2 2])
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'QTS'},@make_AVG_QTwvsparvse,[0.3 1.2],[-0.2 2])
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'QTS'},@make_AVG_QTpar_vsnopar,[0.3 2.5],[-0.2 2]) 
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'QTT'},@make_AVG_QTpre_nvsnopre,[0.3 2.5],[-0.2 2])  

    end
end


chansel   = {'EEG'};
for c = 1
    for i = 1:19
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'EVT'},@make_AVG_EVfutvspre,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'EVT'},@make_AVG_EVpastvspre,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'EVT'},@make_AVG_EVpastvsprevsfut,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'EVT'},@make_AVG_EVpastvsprevsfut_Left,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'EVT'},@make_AVG_EVpastvsprevsfut_Right,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'EVS'},@make_AVG_EVwvspar,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'EVS'},@make_AVG_EVevspar,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'EVS'},@make_AVG_EVevsparvsw,[0.3 2.5],[-0.2 2])
        
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'EVT';'EVS'},@make_AVG_EVTvsEVS,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'QTT';'QTS'},@make_AVG_QTTvsQTS,[0.3 1.2],[-0.2 2])
        
%         TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'EVT'},@make_AVG_DIST2_EVT_True_Past,[0.3 2.5],[-0.2 2])
%         TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'EVT'},@make_AVG_DIST2_EVT_True_Pre,[0.3 2.5],[-0.2 2])
%         TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'EVT'},@make_AVG_DIST2_EVT_True_Fut,[0.3 2.5],[-0.2 2])
%         TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'EVS'},@make_AVG_DIST2_EVS_True_W,[0.3 2.5],[-0.2 2])
%         TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'EVS'},@make_AVG_DIST2_EVS_True_par,[0.3 2.5],[-0.2 2])
%         TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'EVS'},@make_AVG_DIST2_EVS_True_E,[0.3 2.5],[-0.2 2])

        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'EVS'},@make_AVG_EVevsparvsw_true,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'EVT'},@make_AVG_EVpastvsprevsfut_true,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'EVT'},@make_AVG_EVpre_vs_nonpre,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'EVS'},@make_AVG_EVparvsnonpar,[0.3 2.5],[-0.2 2])    
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'EVT'},@make_AVG_EVpre_vs_nonpre_Left,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'EVS'},@make_AVG_EVparvsnonpar_Left,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'EVT'},@make_AVG_EVpre_vs_nonpre_Right,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'EVS'},@make_AVG_EVparvsnonpar_Right,[0.3 2.5],[-0.2 2])   
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'EVS'},@make_AVG_EVevsparvsw_Left,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'EVS'},@make_AVG_EVevsparvsw_Right,[0.3 2.5],[-0.2 2]) 
        
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'EVT'},@make_AVG_DIST4_EVT_Left,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'EVT'},@make_AVG_DIST4_EVT_Right,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'EVS'},@make_AVG_DIST4_EVS_Left,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'EVS'},@make_AVG_DIST4_EVS_Right,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'EVT'},@make_AVG_relPastRelFut,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'EVT'},@make_AVG_relPastG_RelFutG,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'EVS'},@make_AVG_relWestRelEast,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'EVS'},@make_AVG_relWestG_RelEastG,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'EVT'},@make_AVG_relPastG_RelFutG_intmap,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'EVT'},@make_AVG_relPastG_RelFutG_coumap,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'EVS'},@make_AVG_relWestG_RelEastG_intmap,[0.3 2.5],[-0.2 2])
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'EVS'},@make_AVG_relWestG_RelEastG_coumap,[0.3 2.5],[-0.2 2])          
    end
end

chansel   = {'EEG'};
for c = 1:1
    for i = 1:19
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'REF'},@make_AVG_REF_W_Par_E,[0.3 5],[-0.2 5])
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'REF'},@make_AVG_REF_W_Par,[0.3 5],[-0.2 5])
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'REF'},@make_AVG_REF_Pre_Fut,[0.3 5],[-0.2 5])
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'REF'},@make_AVG_REF_Past_Pre_Fut,[0.3 5],[-0.2 5])
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'REF'},@make_AVG_REF_Past_Pre,[0.3 5],[-0.2 5])
        TLSL_SUBJlvl_EEG_from_mne(niplist{i},chansel{c},{'REF'},@make_AVG_REF_Par_E,[0.3 5],[-0.2 5]) 
    end
end
