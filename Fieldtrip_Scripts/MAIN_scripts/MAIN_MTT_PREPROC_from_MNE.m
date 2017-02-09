close all
clear all

bcktmprd = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/backup_temprod/SCRIPTS';
bcktmprd2 = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/backup_temprod/FIELDTRIP';

addpath('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/fieldtrip-20130901')
%addpath('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/fieldtrip-20151209')
addpath(genpath([bcktmprd '/Matlab_pipeline/Ref_functions']));
addpath([bcktmprd '/Matlab_pipeline/My_functions/Preprocessing']);
addpath(bcktmprd2);
addpath('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts');
addpath('/neurospin/meg/meg_tmp/temprod_Baptiste_2010/SCRIPTS/Matlab_pipeline/My_functions/Misc')

ft_defaults

%% PREPROCESSING: EPOCHING, FILTERING, DENOISING, ETCING
% list of subjects to process
niplist = {'sd130343' ;'cb130477' ;'rb130313'   ;'jm100042' ;'jm100109';'sb120316';...
    'tk130502'  ;'lm130479' ;'sg120518'   ;'ms130534';'ma100253';'sl130503';...
    'mb140004';'mp140019';'mm130405';'dm130250';'hr130504' ;'wl130316';'rl130571'};

% list of run per subject to process
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
    {'run2_GD';'run3_DG'};...
    {'run1_GD';'run2_GD';'run3_DG';'run4_DG';'run5_GD'};...
    {'run1_GD';'run2_GD';'run3_DG';'run4_DG'};...
    {'run1_GD';'run2_GD';'run3_DG';'run4_DG';'run5_GD'};...
    {'run1_GD';'run2_GD';'run3_DG';'run4_DG';'run5_GD'}};

% list of bad EEG channels for EEG processing
EEGbadlist = {[25 36];[35 36];[25 35 36];[35];[17 25];[26 36];...
    [];[25 35 36 37];[02 55];[25 35];[09 22 45 46 53 54 59];[35 57];[43];[35];...
    [17 25 35];[25 35];[25 35];[25 35 36 17];[017 025 036 026 034]};

%% get back tel structure for mne pyhton
delays      = [repmat(0.05,1,10) repmat(0.05,1,10) repmat(0.05,1,10) repmat(0.06,1,20) repmat(0.06,1,20)];
windowsERF  = repmat([0.3 3.5],30,1);
% trialfun    = 'trialfun_mtt_for_mne_v2';
for n = 12
     PREPROC4_for_mne_v2(runlist{n},niplist{n});
end

%% stim-locked analysis

% list of photodelay per trigger
delays       = repmat(0.05,1,10);
% list of window of epoching (large for TF computations)
windowsTF      = [repmat([3 9],5,1)];
windowsERF    = [repmat([0.3 5],5,1)];
% trialfun general that epoch data according to all triggers
trialfun     = 'trialfun_mtt_REF';
% condnames attributed to epochs
condtag = 'REF';

for n = 15:19
    PREPROC_from_MNE(runlist{n},delays,windowsERF,windowsTF,trialfun,condtag,niplist{n})
end

for n = 15:19
    PREPROC4_EEG_from_MNE(runlist{n},delays,windowsERF,windowsTF,trialfun,condtag,niplist{n},EEGbadlist{n})
end

%% stim-locked analysis

% list of photodelay per trigger
delays       = repmat(0.05,1,10);
% list of window of epoching (large for TF computations)
windowsTF      = [repmat([1 4],5,1)];
windowsERF    = [repmat([0.3 3.5],5,1)];
% trialfun general that epoch data according to all triggers
trialfun     = 'trialfun_mtt_QTT_v2';
% condnames attributed to epochs
condtag = 'QTT';

for n = 15:19
    PREPROC_from_MNE(runlist{n},delays,windowsERF,windowsTF,trialfun,condtag,niplist{n})
end

for n = 1:19
    PREPROC4_EEG_from_MNE(runlist{n},delays,windowsERF,windowsTF,trialfun,condtag,niplist{n},EEGbadlist{n})
end

%% stim-locked analysis

% list of photodelay per trigger
delays       = repmat(0.05,1,10);
% list of window of epoching (large for TF computations)
windowsTF      = [repmat([1 4],5,1)];
windowsERF    = [repmat([0.3 3.5],5,1)];
% trialfun general that epoch data according to all triggers
trialfun     = 'trialfun_mtt_QTS_v2';
% condnames attributed to epochs
condtag = 'QTS';

for n = 15:19
    PREPROC_from_MNE(runlist{n},delays,windowsERF,windowsTF,trialfun,condtag,niplist{n})
end

for n = 1:19
    PREPROC4_EEG_from_MNE(runlist{n},delays,windowsERF,windowsTF,trialfun,condtag,niplist{n},EEGbadlist{n})
end

%% stim-locked analysis

% list of photodelay per trigger
delays       = repmat(0.06,1,20);
% list of window of epoching (large for TF computations)
windowsTF      = [repmat([1 4],10,1)];
windowsERF    = [repmat([0.3 3.5],10,1)];
% trialfun general that epoch data according to all triggers
trialfun     = 'trialfun_mtt_EVT_v2';
% condnames attributed to epochs
condtag = 'EVT';

for n = 15:19
    PREPROC_from_MNE(runlist{n},delays,windowsERF,windowsTF,trialfun,condtag,niplist{n})
end

for n = 1:19
    PREPROC4_EEG_from_MNE(runlist{n},delays,windowsERF,windowsTF,trialfun,condtag,niplist{n},EEGbadlist{n})
end

 
%% stim-locked analysis

% list of photodelay per trigger
delays       = repmat(0.06,1,20);
% list of window of epoching (large for TF computations)
windowsTF      = [repmat([1 4],10,1)];
windowsERF    = [repmat([0.3 3.5],10,1)];
% trialfun general that epoch data according to all triggers
trialfun     = 'trialfun_mtt_EVS_v2';
% condnames attributed to epochs
condtag = 'EVS';

for n = 15:19
    PREPROC_from_MNE(runlist{n},delays,windowsERF,windowsTF,trialfun,condtag,niplist{n})
end

for n = 1:19
    PREPROC4_EEG_from_MNE(runlist{n},delays,windowsERF,windowsTF,trialfun,condtag,niplist{n},EEGbadlist{n})
end

%% VISUAL-BASED REJECTION OF MEG ARTIFACTS FOR SIMILAR NOISE-LEVEL CONDITIONS GROUPS
for i =12
   
%     condarray = {'EVS'};
%     REJECTVISUAL_ERF_single(niplist{i},condarray)
%     condarray = {'EVT'};
%     REJECTVISUAL_ERF_single(niplist{i},condarray)
%     condarray = {'QTS'};
%     REJECTVISUAL_ERF_single(niplist{i},condarray) 
%     condarray = {'QTT'};
%     REJECTVISUAL_ERF_single(niplist{i},condarray)
    condarray = {'EVS'};
    REJECTVISUAL_ERF_single(niplist{i},condarray)
    
end

for i = 1:19
   
    condarray = {'EVS'};
    REJECTVISUAL_EEG_single(niplist{i},condarray)
%     condarray = {'EVT'};
%     REJECTVISUAL_EEG_single(niplist{i},condarray)
    condarray = {'QTS'};
    REJECTVISUAL_EEG_single(niplist{i},condarray) 
%     condarray = {'QTT'};
%     REJECTVISUAL_EEG_single(niplist{i},condarray)
%     condarray = {'REF'};
%     REJECTVISUAL_EEG_single(niplist{i},condarray)
    
end






