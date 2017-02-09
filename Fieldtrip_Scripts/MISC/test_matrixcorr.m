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

figure
for i =1:19
    root = ['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/' niplist{i} '/raw_sss/ecg_eogv/'];
    projfile_id        = 'PCA_MEG';
    [M,allchan] = computeprojmatrix_mtt(root,['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/' niplist{i} '/raw_sss/' runlist{i}{1} '_trans_sss.fif'],projfile_id);
    subplot(4,5,i)
    imagesc(M(1:306,1:306),[-0.05 0.05])
end

figure
m = [];
for i =1:19
    root = ['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/' niplist{i} '/raw_sss/'];
    projfile_id        = 'PCA_MEG';
    [M,allchan] = computeprojmatrix_mtt(root,[root runlist{i}{1} '_trans_sss.fif'],projfile_id);
    m = [m (M(306,306))];
end

figure
for i =1:19
    root = ['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/' niplist{i} '/raw_sss/'];
    projfile_id        = 'PCA_EEG';
    [M] = computeprojmatrix_mtt_eeg(root,[root runlist{i}{1} '_trans_sss.fif'],projfile_id,EEGbadlist{i});
    subplot(4,5,i)
    imagesc(M,[-0.05 0.05])
end

%% comapre with marco canonical function
par = [];
for i =1:19
    par.pcapath    = ['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/' niplist{i} '/raw_sss/ecg_eogv/' ];
    par.samplefile  = ['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/' niplist{i} '/raw_sss/' runlist{i}{1} '_trans_sss.fif'];
    par.chansel      = 'MEG';
    [M,allchan,badchannels] = ns_projmat(par);
    subplot(4,5,i)
    imagesc(M,[-0.05 0.05])
end




