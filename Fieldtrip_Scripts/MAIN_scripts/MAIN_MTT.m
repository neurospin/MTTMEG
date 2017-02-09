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
% rmpath(' /neurospin/local/fieldtrip/')

% fieldtrip
ft_defaults

%% PREPROCESSING: EPOCHING, FILTERING, DENOISING

niplist = {'sd130343' ;'cb130477' ;'rb130313'   ;'jm100042' ;'jm100109';'sb120316';...
    'tk130502'  ;'lm130479' ;'sg120518'   ;'ms130534';'ma100253';'sl130503';...
    'mb140004';'mp140019';'mm130405';'dm130250';'hr130504' ;'wl130316'};
% niplist = {'sl130503';...
%               'mb140004';'mp140019';'mm130405';'dm130250';'hr130504' ;'wl130316'};
% niplist = {'cb130477' ;'rb130313'   ;'jm100042' ;'jm100109';'sb120316';...
%               'tk130502'  ;'lm130479' ;'sg120518'   ;'ms130534';'ma100253';'sl130503';...
%               'mb140004';'mp140019';'mm130405';'dm130250';'hr130504' ;'wl130316'};
% niplist = {'mm130405';'dm130250';'hr130504' ;'wl130316'};
% niplist = {'lm130479' ;'sg120518'   ;'ms130534';'ma100253';'sl130503';...
%               'mb140004';'mp140019';'mm130405';'dm130250';'hr130504' ;'wl130316'};

runlist = {{'run1_GD';'run2_GD';'run3_DG';'run4_DG';'run5_GD'};...
    {'run1_GD';'run2_GD';'run3_DG';'run4_DG';'run5_GD'};...
    {'run2_GD';'run3_DG';'run4_DG'};...
    {'run1_GD';'run2_GD';'run3_DG';'run4_DG'};...
    {'run1_GD';'run2_GD';'run3_DG';'run4_DG';'run5_GD'};...
    {'run1_GD';'run2_GD';'run3_DG';'run4_DG';'run5_GD'};...
    {'run1_GD';'run2_GD';'run3_DG';'run4_DG';'run5_GD'};...
    {'run1_GD';'run2_GD';'run3_DG';'run4_DG';'run5_GD'};...
    {'run1_GD';'run2_GD';'run3_DG';'run4_DG';'run5_GD'};...
    {'run1_GD';'run2_GD';'run3_DG';'run4_DG';'run5_GD'};...
    {'run1_GD';'run2_GD';'run3_DG';'run4_DG';'run5_GD'};...
    {'run1_GD';'run2_GD';'run3_DG';'run4_DG'};...
    {'run1_GD';'run2_GD';'run3_DG';'run4_DG';'run5_GD'};...
    {'run1_GD';'run2_GD';'run3_DG';'run4_DG'};...
    {'run1_GD';'run2_GD';'run3_DG';'run4_DG'};...
    {'run1_GD';'run2_GD';'run3_DG';'run4_DG';'run5_GD'};...
    {'run1_GD';'run2_GD';'run3_DG';'run4_DG'};...
    {'run1_GD';'run2_GD';'run3_DG';'run4_DG';'run5_GD'}};
% runlist = {{'run1_GD';'run2_GD';'run3_DG';'run4_DG'};...
%     {'run1_GD';'run2_GD';'run3_DG';'run4_DG';'run5_GD'};...
%     {'run1_GD';'run2_GD';'run3_DG';'run4_DG'};...
%     {'run1_GD';'run2_GD';'run3_DG';'run4_DG'};...
%     {'run1_GD';'run2_GD';'run3_DG';'run4_DG';'run5_GD'};...
%     {'run1_GD';'run2_GD';'run3_DG';'run4_DG'};...
%     {'run1_GD';'run2_GD';'run3_DG';'run4_DG';'run5_GD'}};
% runlist = { {'run1_GD';'run2_GD';'run3_DG';'run4_DG';'run5_GD'};...
%     {'run2_GD';'run3_DG';'run4_DG'};...
%     {'run1_GD';'run2_GD';'run3_DG';'run4_DG'};...
%     {'run1_GD';'run2_GD';'run3_DG';'run4_DG';'run5_GD'};...
%     {'run1_GD';'run2_GD';'run3_DG';'run4_DG';'run5_GD'};...
%     {'run1_GD';'run2_GD';'run3_DG';'run4_DG';'run5_GD'};...
%     {'run1_GD';'run2_GD';'run3_DG';'run4_DG';'run5_GD'};...
%     {'run1_GD';'run2_GD';'run3_DG';'run4_DG';'run5_GD'};...
%     {'run1_GD';'run2_GD';'run3_DG';'run4_DG';'run5_GD'};...
%     {'run1_GD';'run2_GD';'run3_DG';'run4_DG';'run5_GD'};...
%     {'run1_GD';'run2_GD';'run3_DG';'run4_DG'};...
%     {'run1_GD';'run2_GD';'run3_DG';'run4_DG';'run5_GD'};...
%     {'run1_GD';'run2_GD';'run3_DG';'run4_DG'};...
%     {'run1_GD';'run2_GD';'run3_DG';'run4_DG'};...
%     {'run1_GD';'run2_GD';'run3_DG';'run4_DG';'run5_GD'};...
%     {'run1_GD';'run2_GD';'run3_DG';'run4_DG'};...
%     {'run1_GD';'run2_GD';'run3_DG';'run4_DG';'run5_GD'}};

% runlist = {{'run1_GD';'run2_GD';'run3_DG';'run4_DG';'run5_GD'};...
%     {'run1_GD';'run2_GD';'run3_DG';'run4_DG';'run5_GD'};...
%     {'run1_GD';'run2_GD';'run3_DG';'run4_DG';'run5_GD'};...
%     {'run1_GD';'run2_GD';'run3_DG';'run4_DG';'run5_GD'};...
%     {'run1_GD';'run2_GD';'run3_DG';'run4_DG'};...
%     {'run1_GD';'run2_GD';'run3_DG';'run4_DG';'run5_GD'};...
%     {'run1_GD';'run2_GD';'run3_DG';'run4_DG'};...
%     {'run1_GD';'run2_GD';'run3_DG';'run4_DG'};...
%     {'run1_GD';'run2_GD';'run3_DG';'run4_DG';'run5_GD'};...
%     {'run1_GD';'run2_GD';'run3_DG';'run4_DG'};...
%     {'run1_GD';'run2_GD';'run3_DG';'run4_DG';'run5_GD'}};

% runlist = {{'run1_GD';'run2_GD';'run3_DG';'run4_DG'};...
%     {'run1_GD';'run2_GD';'run3_DG';'run4_DG';'run5_GD'};...
%     {'run1_GD';'run2_GD';'run3_DG';'run4_DG'};...
%     {'run1_GD';'run2_GD';'run3_DG';'run4_DG';'run5_GD'}};

EEGbadlist = {[25 36];[35 36];[25 35 36];[35];[17 25];[26 36];...
    [];[25 35 36 37];[02 55];[25 35];[];[35 57];[43];[35];...
    [17 25 35];[25 35];[25 35];[25 35 36]};
% EEGbadlist = {[35 57];[43];[35];...
%     [25 35];[25 35];[25 35];[25 35 36]};
% EEGbadlist = {[35 36];[25 35 36];[35];[17 25];[26 36];...
%              [];[25 35 36 37];[02 55];[25 35];[];[35 57];[43];[35];...
%              [25 35];[25 35];[25 35];[25 35 36]};
% EEGbadlist = {[25 35];[25 35];[25 35];[25 35 36]};
% EEGbadlist = {[25 35 36 37];[02 55];[25 35];[];[35 57];[43];[35];...
%              [25 35];[25 35];[25 35];[25 35 36]};


for n = 1:length(niplist)
    
    delay       = 0.05;
    window      = [1.15 3];
    nip         = niplist{n};
    condname{1} = 'REF1';
    condname{2} = 'REF2';
    condname{3} = 'REF3';
    condname{4} = 'REF4';
    condname{5} = 'REF5';
    trialfun{1} = 'trialfun_mtt_REF1';
    trialfun{2} = 'trialfun_mtt_REF2';
    trialfun{3} = 'trialfun_mtt_REF3';
    trialfun{4} = 'trialfun_mtt_REF4';
    trialfun{5} = 'trialfun_mtt_REF5';
%     PREPROC2(runlist{n},delay,window,trialfun{1},condname{1},nip)
%     PREPROC2(runlist{n},delay,window,trialfun{2},condname{2},nip)
%     PREPROC2(runlist{n},delay,window,trialfun{3},condname{3},nip)
%     PREPROC2(runlist{n},delay,window,trialfun{4},condname{4},nip)
%     PREPROC2(runlist{n},delay,window,trialfun{5},condname{5},nip)
    PREPROC_EEG2(runlist{n},delay,window,trialfun{1},condname{1},nip,EEGbadlist{n})
    PREPROC_EEG2(runlist{n},delay,window,trialfun{2},condname{2},nip,EEGbadlist{n})
    PREPROC_EEG2(runlist{n},delay,window,trialfun{3},condname{3},nip,EEGbadlist{n})
    PREPROC_EEG2(runlist{n},delay,window,trialfun{4},condname{4},nip,EEGbadlist{n})
    PREPROC_EEG2(runlist{n},delay,window,trialfun{5},condname{5},nip,EEGbadlist{n})
    
    delay       = 0.05;
    window      = [1.1 2.2];
    nip         = niplist{n};
    condname{1} = 'TIMEQT1';
    condname{2} = 'TIMEQT2';
    condname{3} = 'TIMEQT3';
    condname{4} = 'TIMEQT4';
    condname{5} = 'TIMEQT5';
    trialfun{1} = 'trialfun_mtt_TIMEQT1';
    trialfun{2} = 'trialfun_mtt_TIMEQT2';
    trialfun{3} = 'trialfun_mtt_TIMEQT3';
    trialfun{4} = 'trialfun_mtt_TIMEQT4';
    trialfun{5} = 'trialfun_mtt_TIMEQT5';
    PREPROC2(runlist{n},delay,window,trialfun{1},condname{1},nip)
%     PREPROC2(runlist{n},delay,window,trialfun{2},condname{2},nip)
%     PREPROC2(runlist{n},delay,window,trialfun{3},condname{3},nip)
%     PREPROC2(runlist{n},delay,window,trialfun{4},condname{4},nip)
%     PREPROC2(runlist{n},delay,window,trialfun{5},condname{5},nip)
    PREPROC_EEG2(runlist{n},delay,window,trialfun{1},condname{1},nip,EEGbadlist{n})
    PREPROC_EEG2(runlist{n},delay,window,trialfun{2},condname{2},nip,EEGbadlist{n})
    PREPROC_EEG2(runlist{n},delay,window,trialfun{3},condname{3},nip,EEGbadlist{n})
    PREPROC_EEG2(runlist{n},delay,window,trialfun{4},condname{4},nip,EEGbadlist{n})
    PREPROC_EEG2(runlist{n},delay,window,trialfun{5},condname{5},nip,EEGbadlist{n})
    
    delay       = 0.05;
    window      = [1.1 2.2];
    nip         = niplist{n};
    condname{1} = 'SPACEQT1';
    condname{2} = 'SPACEQT2';
    condname{3} = 'SPACEQT3';
    condname{4} = 'SPACEQT4';
    condname{5} = 'SPACEQT5';
    trialfun{1} = 'trialfun_mtt_SPACEQT1';
    trialfun{2} = 'trialfun_mtt_SPACEQT2';
    trialfun{3} = 'trialfun_mtt_SPACEQT3';
    trialfun{4} = 'trialfun_mtt_SPACEQT4';
    trialfun{5} = 'trialfun_mtt_SPACEQT5';
%     PREPROC2(runlist{n},delay,window,trialfun{1},condname{1},nip)
%     PREPROC2(runlist{n},delay,window,trialfun{2},condname{2},nip)
%     PREPROC2(runlist{n},delay,window,trialfun{3},condname{3},nip)
%     PREPROC2(runlist{n},delay,window,trialfun{4},condname{4},nip)
%     PREPROC2(runlist{n},delay,window,trialfun{5},condname{5},nip)
    PREPROC_EEG2(runlist{n},delay,window,trialfun{1},condname{1},nip,EEGbadlist{n})
    PREPROC_EEG2(runlist{n},delay,window,trialfun{2},condname{2},nip,EEGbadlist{n})
    PREPROC_EEG2(runlist{n},delay,window,trialfun{3},condname{3},nip,EEGbadlist{n})
    PREPROC_EEG2(runlist{n},delay,window,trialfun{4},condname{4},nip,EEGbadlist{n})
    PREPROC_EEG2(runlist{n},delay,window,trialfun{5},condname{5},nip,EEGbadlist{n})
    
    delay         = 0.06;
    window        = [1.1 2.2];
    nip           = niplist{n};
    condname{1}   = 'TimeDist1_REF1';
    condname{2}   = 'TimeDist1_REF2';
    condname{3}   = 'TimeDist1_REF3';
    condname{4}   = 'TimeDist1_REF4';
    condname{5}   = 'TimeDist1_REF5';
    condname{6}   = 'TimeDist2_REF1';
    condname{7}   = 'TimeDist2_REF2';
    condname{8}   = 'TimeDist2_REF3';
    condname{9}   = 'TimeDist2_REF4';
    condname{10}  = 'TimeDist2_REF5';
    condname{11}  = 'SpaceDist1_REF1';
    condname{12}  = 'SpaceDist1_REF2';
    condname{13}  = 'SpaceDist1_REF3';
    condname{14}  = 'SpaceDist1_REF4';
    condname{15}  = 'SpaceDist1_REF5';
    condname{16}  = 'SpaceDist2_REF1';
    condname{17}  = 'SpaceDist2_REF2';
    condname{18}  = 'SpaceDist2_REF3';
    condname{19}  = 'SpaceDist2_REF4';
    condname{20}  = 'SpaceDist2_REF5';
    trialfun{1}   = 'trialfun_mtt_TimeDist1_REF1';
    trialfun{2}   = 'trialfun_mtt_TimeDist1_REF2';
    trialfun{3}   = 'trialfun_mtt_TimeDist1_REF3';
    trialfun{4}   = 'trialfun_mtt_TimeDist1_REF4';
    trialfun{5}   = 'trialfun_mtt_TimeDist1_REF5';
    trialfun{6}   = 'trialfun_mtt_TimeDist2_REF1';
    trialfun{7}   = 'trialfun_mtt_TimeDist2_REF2';
    trialfun{8}   = 'trialfun_mtt_TimeDist2_REF3';
    trialfun{9}   = 'trialfun_mtt_TimeDist2_REF4';
    trialfun{10}  = 'trialfun_mtt_TimeDist2_REF5';
    trialfun{11}  = 'trialfun_mtt_SpaceDist1_REF1';
    trialfun{12}  = 'trialfun_mtt_SpaceDist1_REF2';
    trialfun{13}  = 'trialfun_mtt_SpaceDist1_REF3';
    trialfun{14}  = 'trialfun_mtt_SpaceDist1_REF4';
    trialfun{15}  = 'trialfun_mtt_SpaceDist1_REF5';
    trialfun{16}  = 'trialfun_mtt_SpaceDist2_REF1';
    trialfun{17}  = 'trialfun_mtt_SpaceDist2_REF2';
    trialfun{18}  = 'trialfun_mtt_SpaceDist2_REF3';
    trialfun{19}  = 'trialfun_mtt_SpaceDist2_REF4';
    trialfun{20}  = 'trialfun_mtt_SpaceDist2_REF5';
%     PREPROC2(runlist{n},delay,window,trialfun{1},condname{1},nip)
%     PREPROC2(runlist{n},delay,window,trialfun{2},condname{2},nip)
%     PREPROC2(runlist{n},delay,window,trialfun{3},condname{3},nip)
%     PREPROC2(runlist{n},delay,window,trialfun{4},condname{4},nip)
%     PREPROC2(runlist{n},delay,window,trialfun{5},condname{5},nip)
%     PREPROC2(runlist{n},delay,window,trialfun{6},condname{6},nip)
%     PREPROC2(runlist{n},delay,window,trialfun{7},condname{7},nip)
%     PREPROC2(runlist{n},delay,window,trialfun{8},condname{8},nip)
%     PREPROC2(runlist{n},delay,window,trialfun{9},condname{9},nip)
%     PREPROC2(runlist{n},delay,window,trialfun{10},condname{10},nip)
%     PREPROC2(runlist{n},delay,window,trialfun{11},condname{11},nip)
%     PREPROC2(runlist{n},delay,window,trialfun{12},condname{12},nip)
%     PREPROC2(runlist{n},delay,window,trialfun{13},condname{13},nip)
%     PREPROC2(runlist{n},delay,window,trialfun{14},condname{14},nip)
%     PREPROC2(runlist{n},delay,window,trialfun{15},condname{15},nip)
%     PREPROC2(runlist{n},delay,window,trialfun{16},condname{16},nip)
%     PREPROC2(runlist{n},delay,window,trialfun{17},condname{17},nip)
%     PREPROC2(runlist{n},delay,window,trialfun{18},condname{18},nip)
%     PREPROC2(runlist{n},delay,window,trialfun{19},condname{19},nip)
%     PREPROC2(runlist{n},delay,window,trialfun{20},condname{20},nip)
    
    PREPROC_EEG2(runlist{n},delay,window,trialfun{1},condname{1},nip,EEGbadlist{n})
    PREPROC_EEG2(runlist{n},delay,window,trialfun{2},condname{2},nip,EEGbadlist{n})
    PREPROC_EEG2(runlist{n},delay,window,trialfun{3},condname{3},nip,EEGbadlist{n})
    PREPROC_EEG2(runlist{n},delay,window,trialfun{4},condname{4},nip,EEGbadlist{n})
    PREPROC_EEG2(runlist{n},delay,window,trialfun{5},condname{5},nip,EEGbadlist{n})
    PREPROC_EEG2(runlist{n},delay,window,trialfun{6},condname{6},nip,EEGbadlist{n})
    PREPROC_EEG2(runlist{n},delay,window,trialfun{7},condname{7},nip,EEGbadlist{n})
    PREPROC_EEG2(runlist{n},delay,window,trialfun{8},condname{8},nip,EEGbadlist{n})
    PREPROC_EEG2(runlist{n},delay,window,trialfun{9},condname{9},nip,EEGbadlist{n})
    PREPROC_EEG2(runlist{n},delay,window,trialfun{10},condname{10},nip,EEGbadlist{n})
    PREPROC_EEG2(runlist{n},delay,window,trialfun{11},condname{11},nip,EEGbadlist{n})
    PREPROC_EEG2(runlist{n},delay,window,trialfun{12},condname{12},nip,EEGbadlist{n})
    PREPROC_EEG2(runlist{n},delay,window,trialfun{13},condname{13},nip,EEGbadlist{n})
    PREPROC_EEG2(runlist{n},delay,window,trialfun{14},condname{14},nip,EEGbadlist{n})
    PREPROC_EEG2(runlist{n},delay,window,trialfun{15},condname{15},nip,EEGbadlist{n})
    PREPROC_EEG2(runlist{n},delay,window,trialfun{16},condname{16},nip,EEGbadlist{n})
    PREPROC_EEG2(runlist{n},delay,window,trialfun{17},condname{17},nip,EEGbadlist{n})
    PREPROC_EEG2(runlist{n},delay,window,trialfun{18},condname{18},nip,EEGbadlist{n})
    PREPROC_EEG2(runlist{n},delay,window,trialfun{19},condname{19},nip,EEGbadlist{n})
    PREPROC_EEG2(runlist{n},delay,window,trialfun{20},condname{20},nip,EEGbadlist{n})
    
end

%% VISUAL-BASED REJECTION OF ARTIFACTS
niplist = {'sd130343' ;'cb130477' ;'rb130313'   ;'jm100042' ;'jm100109';'sb120316';...
    'tk130502'  ;'lm130479' ;'sg120518'   ;'ms130534';'ma100253';'sl130503';...
    'mb140004';'mp140019';'mm130405';'dm130250';'hr130504' ;'wl130316'};
% niplist = {'sd130343'};

for i = 1:length(niplist)
    
    condarray = {'REF1';'REF2';'REF3';'REF4';'REF5'};
    REJECTVISUAL(niplist{i},condarray)
    
    condarray = {'TIMEQT1';'TIMEQT2';'TIMEQT3';'TIMEQT4';'TIMEQT5';...
        'SPACEQT1';'SPACEQT2';'SPACEQT3';'SPACEQT4';'SPACEQT5'};
    REJECTVISUAL(niplist{i},condarray)
    
    condarray = {'SpaceDist1_REF1';'SpaceDist1_REF2';'SpaceDist1_REF3';'SpaceDist1_REF4';'SpaceDist1_REF5';...
        'SpaceDist2_REF1';'SpaceDist2_REF2';'SpaceDist2_REF3';'SpaceDist2_REF4';'SpaceDist2_REF5'};
    REJECTVISUAL(niplist{i},condarray)
    
    condarray = {'TimeDist1_REF1';'TimeDist1_REF2';'TimeDist1_REF3';'TimeDist1_REF4';'TimeDist1_REF5';...
        'TimeDist2_REF1';'TimeDist2_REF2';'TimeDist2_REF3';'TimeDist2_REF4';'TimeDist2_REF5'};
    REJECTVISUAL(niplist{i},condarray)
    
end

%% VISUAL-BASED REJECTION OF ARTIFACTS
niplist = {'sd130343' ;'cb130477' ;'rb130313'   ;'jm100042' ;'jm100109';'sb120316';...
    'tk130502'  ;'lm130479' ;'sg120518'   ;'ms130534';'ma100253';'sl130503';...
    'mb140004';'mp140019';'mm130405';'dm130250';'hr130504' ;'wl130316'};

for i = 1:length(niplist)
    
    condarray = {'REF1';'REF2';'REF3';'REF4';'REF5'};
    REJECTVISUAL_EEG(niplist{i},condarray)
    
    condarray = {'TIMEQT1';'TIMEQT2';'TIMEQT3';'TIMEQT4';'TIMEQT5';...
        'SPACEQT1';'SPACEQT2';'SPACEQT3';'SPACEQT4';'SPACEQT5'};
    REJECTVISUAL_EEG(niplist{i},condarray)
    
    condarray = {'SpaceDist1_REF1';'SpaceDist1_REF2';'SpaceDist1_REF3';'SpaceDist1_REF4';'SpaceDist1_REF5';...
        'SpaceDist2_REF1';'SpaceDist2_REF2';'SpaceDist2_REF3';'SpaceDist2_REF4';'SpaceDist2_REF5'};
    REJECTVISUAL_EEG(niplist{i},condarray)
    
    condarray = {'TimeDist1_REF1';'TimeDist1_REF2';'TimeDist1_REF3';'TimeDist1_REF4';'TimeDist1_REF5';...
        'TimeDist2_REF1';'TimeDist2_REF2';'TimeDist2_REF3';'TimeDist2_REF4';'TimeDist2_REF5'};
    REJECTVISUAL_EEG(niplist{i},condarray)
    
end


















