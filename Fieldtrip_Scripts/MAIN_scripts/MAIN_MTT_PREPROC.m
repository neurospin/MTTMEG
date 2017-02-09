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

%% TMP for MNE
for i = 1:19
    blah{i}        = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' niplist{i} '/PsychData/events1.mat']);
    p_rejectmeg(i) = (sum(blah{1,i}.fullsubj(:,9)))./length(blah{1,i}.fullsubj(:,9));
    p_rejecteeg(i) = (sum(blah{1,i}.fullsubj(:,10)))./length(blah{1,i}.fullsubj(:,10));
    p_rejectmeeg(i) = (sum((blah{1,i}.fullsubj(:,10).*blah{1,i}.fullsubj(:,9))))./length(blah{1,i}.fullsubj(:,10));
end

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
    {'run1_GD';'run2_GD';'run3_DG';'run4_DG'};...
    {'run1_GD';'run2_GD';'run3_DG';'run4_DG';'run5_GD'};...
    {'run1_GD';'run2_GD';'run3_DG';'run4_DG'};...
    {'run1_GD';'run2_GD';'run3_DG';'run4_DG';'run5_GD'};...
    {'run1_GD';'run2_GD';'run3_DG';'run4_DG';'run5_GD'}};

% list of bad EEG channels for EEG processing
EEGbadlist = {[25 36];[35 36];[25 35 36];[35];[17 25];[26 36];...
    [];[25 35 36 37];[02 55];[25 35];[09 22 45 46 53 54 59];[35 57];[43];[35];...
    [17 25 35];[25 35];[25 35];[25 35 36 17];[017 025 036 026 034]};

%% emptyroom preproc
% PREPROC4_emptyroom('sd130343','trialfun_mtt_emptyroom')

%% get back tel structure for mne pyhton
delays          = [repmat(0.05,1,10) repmat(0.06,1,20)];
windowsERF  = repmat([0 0],30,1);
trialfun         = 'trialfun_mtt_for_mne';
for n =1:19
    cfg               = PREPROC4fake(runlist{n},delays,windowsERF,trialfun,niplist{n});
end

%% stim-locked analysis

% list of photodelay per trigger
delays       = repmat(0.05,1,10);
% list of window of epoching (large for TF computations)
windowsTF      = [repmat([1 3],5,1)];
windowsERF    = [repmat([0.3 5],5,1)];
% trialfun general that epoch data according to all triggers
trialfun     = 'trialfun_mtt_REF';
% condnames attributed to epochs
condtag = 'REF';

for n = 1:19
    PREPROC4(runlist{n},delays,windowsERF,windowsTF,trialfun,condtag,niplist{n})
end

for n = 1:19
    PREPROC4_EEG(runlist{n},delays,windowsERF,windowsTF,trialfun,condtag,niplist{n},EEGbadlist{n})
end

%% stim-locked analysis

% list of photodelay per trigger
delays       = repmat(0.05,1,10);
% list of window of epoching (large for TF computations)
windowsTF      = [repmat([1 2],5,1)];
windowsERF    = [repmat([0.3 1.2],5,1)];
% trialfun general that epoch data according to all triggers
trialfun     = 'trialfun_mtt_QTT_v2';
% condnames attributed to epochs
condtag = 'QTT';

for n = 1:19
    PREPROC4(runlist{n},delays,windowsERF,windowsTF,trialfun,condtag,niplist{n})
end

for n = 1:19
    PREPROC4_EEG(runlist{n},delays,windowsERF,windowsTF,trialfun,condtag,niplist{n},EEGbadlist{n})
end

%% stim-locked analysis

% list of photodelay per trigger
delays       = repmat(0.05,1,10);
% list of window of epoching (large for TF computations)
windowsTF      = [repmat([1 2],5,1)];
windowsERF    = [repmat([0.3 1.2],5,1)];
% trialfun general that epoch data according to all triggers
trialfun     = 'trialfun_mtt_QTS_v2';
% condnames attributed to epochs
condtag = 'QTS';

for n = 1:19
    PREPROC4(runlist{n},delays,windowsERF,windowsTF,trialfun,condtag,niplist{n})
end

for n = 1:19
    PREPROC4_EEG(runlist{n},delays,windowsERF,windowsTF,trialfun,condtag,niplist{n},EEGbadlist{n})
end

%% stim-locked analysis

% list of photodelay per trigger
delays       = repmat(0.06,1,20);
% list of window of epoching (large for TF computations)
windowsTF      = [repmat([1 3.5],10,1)];
windowsERF    = [repmat([0.3 2.5],10,1)];
% trialfun general that epoch data according to all triggers
trialfun     = 'trialfun_mtt_EVT_v2';
% condnames attributed to epochs
condtag = 'EVT';

for n = 1:19
    PREPROC4(runlist{n},delays,windowsERF,windowsTF,trialfun,condtag,niplist{n})
end

for n = 1:19
    PREPROC4_EEG(runlist{n},delays,windowsERF,windowsTF,trialfun,condtag,niplist{n},EEGbadlist{n})
end

 PREPROC4_forfiff(runlist{1},delays,windowsERF,windowsTF,trialfun,condtag,niplist{1})

%% stim-locked analysis

% list of photodelay per trigger
delays       = repmat(0.06,1,20);
% list of window of epoching (large for TF computations)
windowsTF      = [repmat([1 3.5],10,1)];
windowsERF    = [repmat([0.3 2.5],10,1)];
% trialfun general that epoch data according to all triggers
trialfun     = 'trialfun_mtt_EVS_v2';
% condnames attributed to epochs
condtag = 'EVS';

for n = 1:19
    PREPROC4(runlist{n},delays,windowsERF,windowsTF,trialfun,condtag,niplist{n})
end

for n = 1:19
    PREPROC4_EEG(runlist{n},delays,windowsERF,windowsTF,trialfun,condtag,niplist{n},EEGbadlist{n})
end

%% VISUAL-BASED REJECTION OF MEG ARTIFACTS FOR SIMILAR NOISE-LEVEL CONDITIONS GROUPS

for i =15:19
   
%     condarray = {'EVS'};
%     REJECTVISUAL_ERF_single(niplist{i},condarray)
%     condarray = {'EVT'};
%     REJECTVISUAL_EEG_single(niplist{i},condarray)
%     condarray = {'QTS'};
%     REJECTVISUAL_EEG_single(niplist{i},condarray) 
%     condarray = {'QTT'};
%     REJECTVISUAL_EEG_single(niplist{i},condarray)
    condarray = {'REF'};
    REJECTVISUAL_ERF_single(niplist{i},condarray)
    
end

for i = 1:19
   
%     condarray = {'EVS'};
%     REJECTVISUAL_EEG_single(niplist{i},condarray)
%     condarray = {'EVT'};
%     REJECTVISUAL_EEG_single(niplist{i},condarray)
%     condarray = {'QTS'};
%     REJECTVISUAL_EEG_single(niplist{i},condarray) 
%     condarray = {'QTT'};
%     REJECTVISUAL_EEG_single(niplist{i},condarray)
    condarray = {'REF'};
    REJECTVISUAL_EEG_single(niplist{i},condarray)
    
end
