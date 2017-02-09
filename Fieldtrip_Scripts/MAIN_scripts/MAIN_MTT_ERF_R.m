% MAIN SCRIPT MTT

close all
clear all

bcktmprd = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/backup_temprod/SCRIPTS';
bcktmprd2 = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/backup_temprod/FIELDTRIP';

addpath('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/fieldtrip-20130901')
addpath(genpath([bcktmprd '/Matlab_pipeline/Ref_functions']));
addpath([bcktmprd '/Matlab_pipeline/My_functions/Preprocessing']);
addpath(bcktmprd2);
addpath('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts');

ft_defaults


niplist = {'sd130343' ;'cb130477' ;'rb130313'   ;'jm100042' ;'jm100109';'sb120316';...
              'tk130502'  ;'lm130479' ;'sg120518'   ;'ms130534';'ma100253';'sl130503';...
              'mb140004';'mp140019';'mm130405';'dm130250';'hr130504' ;'wl130316';'rl130571'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% GROUP analysis %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
niplist = {'sd130343' ;'cb130477' ;'rb130313'   ;'jm100042' ;'jm100109';'sb120316';...
              'tk130502'  ;'lm130479' ;'sg120518'   ;'ms130534';'ma100253';'sl130503';...
              'mp140019';'mm130405';'dm130250';'hr130504' ;'wl130316'};
     
chansel   = {'cmb';'Mags';'Grads2';'Grads1'};
condnames = {'RESPCLOSE';'RESPFAR'};
PlotColors = [[0 0 0];[1 0 0]];
for c = 1:4
    TLSL_GROUPlvl(niplist,chansel{c},condnames)
end

chansel   = {'cmb';'Mags';'Grads2';'Grads1'};
condnames = {'RESPTIMECLOSE';'RESPTIMEFAR'};
PlotColors = [[0 0 0];[1 0 0]];
for c = 1:4
    TLSL_GROUPlvl(niplist,chansel{c},condnames)
end

chansel   = {'cmb';'Mags';'Grads2';'Grads1'};
condnames = {'RESPSPACCLOSE';'RESPSPACEFAR'};
PlotColors = [[0 0 0];[1 0 0]];
for c = 1:4
    TLSL_GROUPlvl(niplist,chansel{c},condnames)
end

chansel   = {'cmb';'Mags';'Grads2';'Grads1'};
condnames = {'RESPTIME';'RESPSPACE'};
PlotColors = [[0 0 0];[1 0 0]];
for c = 1:4
    TLSL_GROUPlvl(niplist,chansel{c},condnames)
end
          
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% REF conds %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

chansel   = {'cmb';'Mags';'Grads2';'Grads1'};
condnames = {'RESPCLOSE';'RESPFAR'};
condarray = {{'TD1_1_L';'TD1_2_L';'TD1_3_L';'TD1_4_L';'TD1_5_L';'SD1_1_L';'SD1_2_L';'SD1_3_L';'SD1_4_L';'SD1_5_L';...
                     'TD1_1_R';'TD1_2_R';'TD1_3_R';'TD1_4_R';'TD1_5_R';'SD1_1_R';'SD1_2_R';'SD1_3_R';'SD1_4_R';'SD1_5_R'}, ...
                    {'TD2_1_L';'TD2_2_L';'TD2_3_L';'TD2_4_L';'TD2_5_L';'SD2_1_L';'SD2_2_L';'SD2_3_L';'SD2_4_L';'SD2_5_L';...
                    'TD2_1_R';'TD2_2_R';'TD2_3_R';'TD2_4_R';'TD2_5_R';'SD2_1_R';'SD2_2_R';'SD2_3_R';'SD2_4_R';'SD2_5_R'}};
PlotColors = [[0 0 0];[1 0 0]];
for i = 1:length(niplist)
    TLRL_SUBJlvl_cmb(niplist{i},condnames,condarray,[0.4 0.5],[-0.1 0.5],PlotColors)
    for c = 2:4
        TLRL_SUBJlvl(niplist{i},chansel{c},condnames,condarray,[0.4 0.5],[-0.1 0.5],PlotColors)
    end
end

chansel   = {'cmb';'Mags';'Grads2';'Grads1'};
condnames = {'RESPTIMECLOSE';'RESPTIMEFAR'};
condarray = {{'TD1_1_L';'TD1_2_L';'TD1_3_L';'TD1_4_L';'TD1_5_L';...
                     'TD1_1_R';'TD1_2_R';'TD1_3_R';'TD1_4_R';'TD1_5_R'}, ...
                    {'TD2_1_L';'TD2_2_L';'TD2_3_L';'TD2_4_L';'TD2_5_L';...
                    'TD2_1_R';'TD2_2_R';'TD2_3_R';'TD2_4_R';'TD2_5_R'}};
PlotColors = [[0 0 0];[1 0 0]];
for i = 1:length(niplist)
    TLRL_SUBJlvl_cmb(niplist{i},condnames,condarray,[4 0.5],[-1 0.5],PlotColors)
    for c = 2:4
        TLRL_SUBJlvl(niplist{i},chansel{c},condnames,condarray,[4 0.5],[-1 0.5],PlotColors)
    end
end

chansel   = {'cmb';'Mags';'Grads2';'Grads1'};
condnames = {'RESPSPACCLOSE';'RESPSPACEFAR'};
condarray = {{'SD1_1_L';'SD1_2_L';'SD1_3_L';'SD1_4_L';'SD1_5_L';...
                     'SD1_1_R';'SD1_2_R';'SD1_3_R';'SD1_4_R';'SD1_5_R'}, ...
                    {'SD2_1_L';'SD2_2_L';'SD2_3_L';'SD2_4_L';'SD2_5_L';...
                    'SD2_1_R';'SD2_2_R';'SD2_3_R';'SD2_4_R';'SD2_5_R'}};
PlotColors = [[0 0 0];[1 0 0]];
for i = 1:length(niplist)
    TLRL_SUBJlvl_cmb(niplist{i},condnames,condarray,[4 0.5],[-1 0.5],PlotColors)
    for c = 2:4
        TLRL_SUBJlvl(niplist{i},chansel{c},condnames,condarray,[4 0.5],[-1 0.5],PlotColors)
    end
end

chansel   = {'cmb';'Mags';'Grads2';'Grads1'};
condnames = {'RESPTIME';'RESPSPACE'};
condarray = {{'TD1_1_L';'TD1_2_L';'TD1_3_L';'TD1_4_L';'TD1_5_L';...
                     'TD1_1_R';'TD1_2_R';'TD1_3_R';'TD1_4_R';'TD1_5_R';...
                     'TD2_1_L';'TD2_2_L';'TD2_3_L';'TD2_4_L';'TD2_5_L';...
                     'TD2_1_R';'TD2_2_R';'TD2_3_R';'TD2_4_R';'TD2_5_R'},...
                     {'SD1_1_R';'SD1_2_R';'SD1_3_R';'SD1_4_R';'SD1_5_R';...
                     'SD1_1_L';'SD1_2_L';'SD1_3_L';'SD1_4_L';'SD1_5_L';...
                     'SD2_1_L';'SD2_2_L';'SD2_3_L';'SD2_4_L';'SD2_5_L';...
                     'SD2_1_R';'SD2_2_R';'SD2_3_R';'SD2_4_R';'SD2_5_R'}};
PlotColors = [[0 0 0];[1 0 0]];
for i = 1:length(niplist)
    TLRL_SUBJlvl_cmb(niplist{i},condnames,condarray,[4 0.5],[-1 0.5],PlotColors)
    for c = 2:4
        TLRL_SUBJlvl(niplist{i},chansel{c},condnames,condarray,[4 0.5],[-1 0.5],PlotColors)
    end
end