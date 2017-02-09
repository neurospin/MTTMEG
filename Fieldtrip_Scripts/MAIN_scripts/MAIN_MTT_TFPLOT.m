% MAIN SCRIPT MTT

close all
clear all

bcktmprd = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/backup_temprod/SCRIPTS';
bcktmprd2 = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/backup_temprod/FIELDTRIP';

%addpath('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/fieldtrip-20130901')
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
chansel      = {'Mags';'EEG'};
condnames1   = {'Et_all';'Es_all'};
condnames2   = {'Qt_all';'Qs_all'};

for c = 1:2
    TFSL_PLOT_GROUPlvl(niplist,chansel{c},condnames2,[-0.5 1.5])
end

chansel      = {'Mags';'EEG'};
condnames1   = {'RefW';'RefPar';'RefE'};
condnames2   = {'RefPast';'RefPre';'RefFut'};
for c = 1
     %TFindSL_PLOT_GROUPlvl(niplist,chansel{c},condnames1,[-0.5 6])
     TFindSL_PLOT_GROUPlvl(niplist,chansel{c},condnames1,[-0.5 2.5])
%      TFSL_PLOT_GROUPlvl(niplist,chansel{c},condnames2,[-0.5 6])
end

chansel      = {'Mags';'EEG'};
condnames1   = {'Sproj';'NoProj';'Tproj'};
for c = 1
     TFindSL_PLOT_GROUPlvl(niplist,chansel{c},condnames1,[-0.5 2.5])
end

chansel      = {'Mags';'EEG'};
condnames1 = {'EtPastG';'EtPreG';'EtFutG'};
condnames2 = {'EsWestG';'EsParG';'EsEastG'};
for c = 1:2
     TFSL_PLOT_GROUPlvl(niplist,chansel{c},condnames1)
     TFSL_PLOT_GROUPlvl(niplist,chansel{c},condnames2)
end


chansel      = {'Mags';'EEG'};
condnames1 = {'EsPar';'EsnoPar'};
condnames2 = {'EtPre';'EtnoPre'};
for c = 1:2
     TFSL_PLOT_GROUPlvl(niplist,chansel{c},condnames1)
     TFSL_PLOT_GROUPlvl(niplist,chansel{c},condnames2)
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% Induced %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
chansel      = {'Mags';'EEG'};
condnames1   = {'Et_all';'Es_all'};
condnames2   = {'Qt_all';'Qs_all'};

for c = 1:2
    TFindSL_PLOT_GROUPlvl(niplist,chansel{c},condnames1)
    TFindSL_PLOT_GROUPlvl(niplist,chansel{c},condnames2)
end

chansel      = {'Mags';'EEG'};
condnames1   = {'RefW';'RefPar';'RefE'};
condnames2   = {'RefPast';'RefPre';'RefFut'};
for c = 1:2
     TFindSL_PLOT_GROUPlvl(niplist,chansel{c},condnames1)
     TFindSL_PLOT_GROUPlvl(niplist,chansel{c},condnames2)
end

chansel      = {'Mags';'EEG'};
condnames1 = {'EtPastG';'EtPreG';'EtFutG'};
condnames2 = {'EsWestG';'EsParG';'EsEastG'};
for c = 1:2
     TFindSL_PLOT_GROUPlvl(niplist,chansel{c},condnames1)
     TFindSL_PLOT_GROUPlvl(niplist,chansel{c},condnames2)
end


chansel      = {'Mags';'EEG'};
condnames1 = {'EsPar';'EsnoPar'};
condnames2 = {'EtPre';'EtnoPre'};
for c = 1:2
     TFindSL_PLOT_GROUPlvl(niplist,chansel{c},condnames1)
     TFindSL_PLOT_GROUPlvl(niplist,chansel{c},condnames2)
end

