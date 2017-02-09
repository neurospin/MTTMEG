%% TEMPROD ANALYSIS
clear all
close all

tag = 'Laptop';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if strcmp(tag,'Laptop') == 1
    
    %% SET PATHS %%
%     addpath('C:\FIELDTRIP\fieldtrip-20120402');
    addpath(genpath('C:\FIELDTRIP\fieldtrip-20120701'));
%     addpath(genpath('C:\FIELDTRIP\fieldtrip-20111020'));
    %     ft_defaults
    %     addpath '/neurospin/local/mne/i686/share/matlab/'
    addpath 'C:\TEMPROD\SCRIPTS/Matlab_pipeline/My_functions/Main'
    addpath 'C:\TEMPROD\SCRIPTS/Matlab_pipeline/My_functions/Behavior'
    addpath 'C:\TEMPROD\SCRIPTS/Matlab_pipeline/My_functions/Preprocessing'
    addpath 'C:\TEMPROD\SCRIPTS/Matlab_pipeline/My_functions/Frequency'
    addpath 'C:\TEMPROD\SCRIPTS/Matlab_pipeline/My_functions/Timelock'
    addpath 'C:\TEMPROD\SCRIPTS/Matlab_pipeline/My_functions/ICA'
    addpath 'C:\TEMPROD\SCRIPTS/Matlab_pipeline/My_functions/Misc'
    addpath 'C:\TEMPROD\SCRIPTS/Matlab_pipeline/My_functions/Time-Frequency'
    addpath 'C:\TEMPROD\SCRIPTS/Matlab_pipeline/My_functions/n_way_toolbox'
    addpath 'C:\TEMPROD\SCRIPTS/Matlab_pipeline/My_functions/cw_entrainfreq'
    addpath 'C:\TEMPROD\SCRIPTS/Matlab_pipeline/My_functions/NewPipeline'
    addpath 'C:\TEMPROD\SCRIPTS/Matlab_pipeline/My_functions/ForR'
    
elseif strcmp(tag,'Network') == 1
    
    %% SET PATHS %%
    % rmpath(genpath('/neurospin/local/fieldtrip'))
    % addpath(genpath('/neurospin/meg/meg_tmp/fieldtrip-20110201'));
    % addpath(genpath('/neurospin/meg/meg_tmp/fieldtrip-20110404'));
    addpath(genpath('/neurospin/local/fieldtrip'));
    %     ft_defaults
    addpath '/neurospin/local/mne/i686/share/matlab/'
    addpath '/neurospin/meg/meg_tmp/temprod_Baptiste_2010/SCRIPTS/Matlab_pipeline/My_functions/Main'
    addpath '/neurospin/meg/meg_tmp/temprod_Baptiste_2010/SCRIPTS/Matlab_pipeline/My_functions/Behavior'
    addpath '/neurospin/meg/meg_tmp/temprod_Baptiste_2010/SCRIPTS/Matlab_pipeline/My_functions/Preprocessing'
    addpath '/neurospin/meg/meg_tmp/temprod_Baptiste_2010/SCRIPTS/Matlab_pipeline/My_functions/Frequency'
    addpath '/neurospin/meg/meg_tmp/temprod_Baptiste_2010/SCRIPTS/Matlab_pipeline/My_functions/Timelock'
    addpath '/neurospin/meg/meg_tmp/temprod_Baptiste_2010/SCRIPTS/Matlab_pipeline/My_functions/ICA'
    addpath '/neurospin/meg/meg_tmp/temprod_Baptiste_2010/SCRIPTS/Matlab_pipeline/My_functions/Misc'
    addpath '/neurospin/meg/meg_tmp/temprod_Baptiste_2010/SCRIPTS/Matlab_pipeline/My_functions/Time-Frequency'
    addpath '/neurospin/meg/meg_tmp/temprod_Baptiste_2010/SCRIPTS/Matlab_pipeline/My_functions/n_way_toolbox'
    addpath 'C:\TEMPROD\SCRIPTS/Matlab_pipeline/My_functions/NewPipeline'
    addpath 'C:\TEMPROD\SCRIPTS/Matlab_pipeline/My_functions/ForR'
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% STEP1: preprocessing
% s14
run           = {'run2','run3','run4','run5','run6','run7'};
for i = 1:6
    temprode_preproc_new(run{i},'s14','run1',tag)    
%     Temprod_Preproc_Timelock('s14',run,'ecg&eog',tag)    
end
% s13
for run           = [2 3 4 5 6 7]
%     Temprod_Preproc('s13',run,'ecg&eog',tag)
    Temprod_Preproc_Timelock('s13',run,'ecg&eog',tag)    
end
% s12
for run           = [2 3]
    Temprod_Preproc_Timelock('s12',run,'nocorr',tag) 
%     Temprod_Preproc('s12',run,'nocorr',tag)
end

for run           = [4 5 6 7]
    Temprod_Preproc_Timelock('s12',run,'ecg&eog',tag) 
%     Temprod_Preproc('s12',run,'ecg&eog',tag)
end

for run           = [2 3 4 5]
    Temprod_Preproc_Timelock('s11',run,'ecg&eog',tag) 
%     Temprod_Preproc('s11',run,'ecg&eog',tag)
end

for run           = [2 3 4 5 6]
%     Temprod_Preproc_Timelock('s10',run,'ecg&eog',tag) 
    Temprod_Preproc('s10',run,'nocorr',tag)
end

for run           = [7]
%     Temprod_Preproc_Timelock('s10',run,'nocorr',tag) 
    Temprod_Preproc('s10',run,'nocorr',tag)
end

for run           = [2 3 4 5 6]
    Temprod_Preproc_Timelock('s08',run,'ecg&eog',tag)
    %     Temprod_Preproc('s08',run,'ecg&eog',tag)
end

for run           = [1 2]
    Temprod_Preproc_Timelock('s07',run,'nocorr',tag) 
%     Temprod_Preproc('s07',run,'nocorr',tag)
end

for run           = [3 4 5 6]
    Temprod_Preproc_Timelock('s07',run,'ecg&eog',tag) 
%     Temprod_Preproc('s07',run,'ecg&eog',tag)
end

for run           = [1 2 3 4]
    Temprod_Preproc_Timelock('s06',run,'nocorr',tag) 
%     Temprod_Preproc('s06',run,'ecg&eog',tag)
end

for run           = [1 2 3]
    Temprod_Preproc_Timelock('s05',run,'ecg&eog',tag) 
%     Temprod_Preproc('s05',run,'ecg&eog',tag)
end

for run           = [1 2 3]
    Temprod_Preproc_Timelock('s04',run,'ecg&eog',tag)
%     Temprod_Preproc('s04',run,'ecg&eog',tag)
end

%% Preproc baseline
temprode_preproc_baseline('s10',1,'nocorr',tag)
temprode_preproc_baseline('s11',1,'nocorr',tag)
temprode_preproc_baseline('s12',1,'nocorr',tag)
temprode_preproc_baseline('s13',1,'nocorr',tag)
temprode_preproc_baseline('s14',1,'nocorr',tag)

%% STEP2: frequency analysis
% s14
chantype          = {'Mags';'Grads1';'Grads2'};
Targets           = [5.7 8.5 5.7 5.7 8.5 5.7];
run               = [2 3 4 5 6 7];
for i             = 1
    T             = Targets(i);
    R             = run(i);
    for j         = 1:3
        Temprod_Freqanalysis('s14',R,[1 120],chantype{j},T,12600,tag)
    end
end
% s13
chantype          = {'Mags';'Grads1';'Grads2'};
Targets           = [5.7 8.5 5.7 5.7 8.5 5.7];
run               = [2 3 4 5 6 7];
for i             = 1:length(run)
    T             = Targets(i);
    R             = run(i);
    for j         = 1:3
        Temprod_Freqanalysis('s13',R,[1 120],chantype{j},T,12600,tag)
    end
end
% s12
chantype          = {'Mags';'Grads1';'Grads2'};
Targets           = [5.7 8.5 5.7 5.7 8.5 5.7];
run               = [2 3 4 5 6 7];
for i             = 1:length(run)
    T             = Targets(i);
    R             = run(i);
    for j         = 1:3
        Temprod_Freqanalysis('s12',R,[1 120],chantype{j},T,12600,tag)
    end
end
% s11
chantype          = {'Mags';'Grads1';'Grads2'};
Targets           = [5.7 8.5 5.7 5.7];
run               = [2 3 4 5];
for i             = 1:length(run)
    T             = Targets(i);
    R             = run(i);
    for j         = 1:3
        Temprod_Freqanalysis('s11',R,[1 120],chantype{j},T,12600,tag)
    end
end
% s10
chantype          = {'Mags';'Grads1';'Grads2'};
Targets           = [5.7 8.5 5.7 5.7 8.5 5.7];
run               = [2 3 4 5 6 7];
for i             = 1:length(run)
    T             = Targets(i);
    R             = run(i);
    for j         = 1:3
        Temprod_Freqanalysis('s10',R,[1 120],chantype{j},T,12600,tag)
    end
end
%s08
chantype          = {'Mags';'Grads1';'Grads2'};
Targets           = [6.5 8.5 6.5 6.5 8.5];
run               = [2 3 4 5 6];
for i             = 1:length(run)
    T             = Targets(i);
    R             = run(i);
    for j         = 1:3
        Temprod_Freqanalysis('s08',R,[1 120],chantype{j},T,12600,tag)
    end
end
%s07
chantype          = {'Mags';'Grads1';'Grads2'};
Targets           = [6.5 8.5 6.5 6.5 8.5 8.5];
run               = [1 2 3 4 5 6];
for i             = 1:length(run)
    T             = Targets(i);
    R             = run(i);
    for j         = 1:3
        Temprod_Freqanalysis('s07',R,[1 120],chantype{j},T,12600,tag)
    end
end
%s06
chantype          = {'Mags';'Grads1';'Grads2'};
Targets           = [6.5 8.5 6.5 8.5];
run               = [1 2 3 4];
for i             = 1:length(run)
    T             = Targets(i);
    R             = run(i);
    for j         = 1:3
        Temprod_Freqanalysis('s06',R,[1 120],chantype{j},T,12600,tag)
    end
end
%s05
chantype          = {'Mags';'Grads1';'Grads2'};
Targets           = [6.5 8.5 6.5];
run               = [1 2 3];
for i             = 1:length(run)
    T             = Targets(i);
    R             = run(i);
    for j         = 1:3
        Temprod_Freqanalysis('s05',R,[1 120],chantype{j},T,12600,tag)
    end
end
%s04
chantype          = {'Mags';'Grads1';'Grads2'};
Targets           = [5.7 12.8 9.3];
run               = [1 2 3];
for i             = 1:length(run)
    T             = Targets(i);
    R             = run(i);
    for j         = 1:3
        Temprod_Freqanalysis('s04',R,[1 120],chantype{j},T,12600,tag)
    end
end

%% baseline
chantype          = {'Mags';'Grads1';'Grads2'};
for j         = 1:3
    Temprod_Freqanalysis('s06',5,[1 120],chantype{j},5,12600,tag)
    Temprod_Freqanalysis('s07',7,[1 120],chantype{j},5,12600,tag)
    Temprod_Freqanalysis('s08',1,[1 120],chantype{j},5,12600,tag)
%     Temprod_Freqanalysis('s10',1,[1 120],chantype{j},5,12600,tag)
%     Temprod_Freqanalysis('s11',1,[1 120],chantype{j},5,12600,tag)
%     Temprod_Freqanalysis('s12',1,[1 120],chantype{j},5,12600,tag)
%     Temprod_Freqanalysis('s13',1,[1 120],chantype{j},5,12600,tag)
%     Temprod_Freqanalysis('s14',1,[1 120],chantype{j},5,12600,tag)
end

%% STEP 2bis
% s14
Targets           = [5.7 8.5 5.7 5.7 8.5 5.7];
run               = [2 3 4 5 6 7];
for runind = 1:6
    temprod_timelock_t0(run(runind),'s14',1,1,Targets(runind),tag)
%     temprod_timelock_tend(run(runind),'s14',1,0,Targets(runind),tag)
end

% s13
Targets           = [5.7 8.5 5.7 5.7 8.5 5.7];
run               = [2 3 4 5 6 7];
for runind = 1:6
    temprod_timelock_t0(run(runind),'s13',1,1,Targets(runind),tag)
%     temprod_timelock_tend(run(runind),'s13',1,0,Targets(runind),tag)
end

% s12
Targets           = [5.7 8.5 5.7 5.7 8.5 5.7];
run               = [2 3 4 5 6 7];
for runind = 1:6
    temprod_timelock_t0(run(runind),'s12',1,0,Targets(runind),tag)
    temprod_timelock_tend(run(runind),'s12',1,0,Targets(runind),tag)
end

% s11
Targets           = [5.7 8.5 5.7 5.7];
run               = [2 3 4 5];
for runind = 1:4
    temprod_timelock_t0(run(runind),'s11',1,0,Targets(runind),tag)
    temprod_timelock_tend(run(runind),'s11',1,0,Targets(runind),tag)
end


% s10
Targets           = [5.7 8.5 5.7 5.7 8.5 5.7];
run               = [2 3 4 5 6 7];
for runind = 1:6
    temprod_timelock_t0(run(runind),'s10',1,0,Targets(runind),tag)
    temprod_timelock_tend(run(runind),'s10',1,0,Targets(runind),tag)
end

% s08
Targets           = [6.5 8.5 6.5 6.5 8.5];
run               = [2 3 4 5 6];
for runind = 1:5
    temprod_timelock_t0(run(runind),'s08',1,0,Targets(runind),tag)
    temprod_timelock_tend(run(runind),'s08',1,0,Targets(runind),tag)
end

% s07
Targets           = [6.5 8.5 6.5 6.5 8.5 8.5];
run               = [1 2 3 4 5 6];
for runind = 1:6
    temprod_timelock_t0(run(runind),'s07',1,0,Targets(runind),tag)
    temprod_timelock_tend(run(runind),'s07',1,0,Targets(runind),tag)
end

% s06
Targets           = [6.5 8.5 6.5 8.5];
run               = [1 2 3 4];
for runind = 1:6
    temprod_timelock_t0(run(runind),'s06',1,0,Targets(runind),tag)
    temprod_timelock_tend(run(runind),'s06',1,0,Targets(runind),tag)
end

% s05
Targets           = [6.5 8.5 6.5];
run               = [1 2 3];
for runind = 1:3
    temprod_timelock_t0(run(runind),'s05',1,0,Targets(runind),tag)
    temprod_timelock_tend(run(runind),'s05',1,0,Targets(runind),tag)
end

% s04
Targets           = [5.7 12.8 9.3];
run               = [1 2 3];
for runind = 1:3
    temprod_timelock_t0(run(runind),'s04',1,0,Targets(runind),tag)
    temprod_timelock_tend(run(runind),'s04',1,0,Targets(runind),tag)
end

%% compute, plot and store frequency and power peaks values
% Temprod_Dataviewer(subject,run,freqband,chantype,K,debiasing,visibility,tag)

Temprod_Dataviewer('s14',2,[1 120],'Mags',[1],0,1,tag)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SubjectArray = {'s14'     ;'s13'     ;'s12'    ;'s11'  ;'s10'    ;'s08' ;'s07'     ;'s06';'s05';'s04'};
% RunArray      = {[2 3 5 6];[2 3 5 6] ;[2 3 5 6];[2 3 5];[2 3 5 6];2:6   ;[1 2 4 5] ;1:4  ;1:3  ;1:3};
SubjectArray = {'s14'         ;'s13'         ;'s12'        ;'s11'        ;'s10' };
RunArray      = {[2 3 5 6]    ;[2 3 5 6]     ;[2 3 5 6]    ;[2 3 5]      ;[2 3 5 6] };
chantype      = {'Mags';'Grads1';'Grads2'};
freqband      = {[7 14]};
condname      = 'AllEstimation';
for k = 1
    for j = 1:3
        Temprod_GLM2( SubjectArray, RunArray, chantype{j}, freqband{k}, condname, tag);
    end
end

SubjectArray = {'s14'     ;'s13'     ;'s12'    ;'s11'  ;'s10' };
RunArray      = {[4 7]    ;[4 7]     ;[4 7]    ;4      ;[4 7] };
chantype      = {'Mags';'Grads1';'Grads2'};
freqband      = {[2 5];[7 14];[15 30]};
condname      = 'AllReplay';
for k = 1:3
    for j = 1:3
        Temprod_GLM3( SubjectArray, RunArray, chantype{j}, freqband{k}, condname, tag);
    end
end

%%%%%%%%%%%%%%%%%%%%%% timelock grand averages %%%%%%%%%%%%%%%%%%%%%%%%%%%%
subarray_est_MG = {'s14';'s13';'s12';'s11'  ;'s10';'s08';'s07';'s06';'s05'};
runarray_est_MG = {[2 3];[2 3];[2 3];[2 3 5];[3]  ;[6]  ;[4 5];[1 2];[1 2]};
condname    = 'est_MG';
temprod_timelock_GDAVG(subarray_est_MG,runarray_est_MG,condname,tag)

subarray_est_MD = {'s14';'s13';'s12';'s10';'s08'    ;'s07';'s06';'s05'};
runarray_est_MD = {[5 6];[5 6];[5 6];[5]  ;[2 3 4 5];[3 4];[3 4];[3]};
condname    = 'est_MD';
temprod_timelock_GDAVG(subarray_est_MD,runarray_est_MD,condname,tag)

subarray_rep_MG = {'s14';'s13';'s12';'s11';'s10';'s07'};
runarray_rep_MG = {[4]  ;[4]  ;[4]  ;[4]  ;[4]  ;[6]};
condname    = 'rep_MG';
temprod_timelock_GDAVG(subarray_rep_MG,runarray_rep_MG,condname,tag)

subarray_rep_MG = {'s14';'s13';'s12';'s10';'s07'};
runarray_rep_MG = {[7]  ;[7]  ;[7]  ;[7]  ;[3]};
condname    = 'rep_MG';
temprod_timelock_GDAVG(subarray_rep_MG,runarray_rep_MG,condname,tag)

%%%%%%%%%%%%%%%%%%%%%%%%%% Matrixes Bilan %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
SubjectArray = {'s14'     ;'s13'     ;'s12'    ;'s11'  ;'s10'    ;'s08' ;'s07'     ;'s06';'s05';'s04'};
RunArray      = {[2 3 5 6];[2 3 5 6] ;[2 3 5 6];[2 3 5];[2 3 5 6];2:6   ;[1 2 4 5] ;1:4  ;1:3  ;1:3};
chantype      = {'Mags';'Grads1';'Grads2'};
freqband      = {[2 5];[7 14];[15 30]};
condname      = 'AllEstimation';
Temprod_ResultsPutTogether(SubjectArray,RunArray,freqband{1},condname,tag)
Temprod_ResultsPutTogether(SubjectArray,RunArray,freqband{2},condname,tag)
Temprod_ResultsPutTogether(SubjectArray,RunArray,freqband{3},condname,tag)

SubjectArray = {'s14'     ;'s13'     ;'s12'    ;'s11'  ;'s10' };
RunArray      = {[4 7]    ;[4 7]     ;[4 7]    ;4      ;[4 7] };
chantype      = {'Mags';'Grads1';'Grads2'};
freqband      = {[2 5];[7 14];[15 30]};
condname      = 'AllReplay';
Temprod_ResultsPutTogether(SubjectArray,RunArray,freqband{1},condname,tag)
Temprod_ResultsPutTogether(SubjectArray,RunArray,freqband{2},condname,tag)
Temprod_ResultsPutTogether(SubjectArray,RunArray,freqband{3},condname,tag)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Temprod_estrep_match('s14',[2 4],'Grads2',[5.7 5.7],tag)
% Temprod_estrep_match('s14',[5 7],'Grads2',[5.7 5.7],tag)
% Temprod_estrep_match('s13',[2 4],'Grads2',[5.7 5.7],tag)
% Temprod_estrep_match('s13',[5 7],'Grads2',[5.7 5.7],tag)
% Temprod_estrep_match('s12',[2 4],'Grads2',[5.7 5.7],tag)
% Temprod_estrep_match('s12',[5 7],'Grads2',[5.7 5.7],tag)
% Temprod_estrep_match('s11',[2 4],'Grads2',[5.7 5.7],tag)
% Temprod_estrep_match('s10',[2 4],'Grads2',[5.7 5.7],tag)
% Temprod_estrep_match('s10',[5 7],'Grads2',[5.7 5.7],tag)
% 
% Temprod_estrep_match('s14',[2 4],'Grads1',[5.7 5.7],tag)
% Temprod_estrep_match('s14',[5 7],'Grads1',[5.7 5.7],tag)
% Temprod_estrep_match('s13',[2 4],'Grads1',[5.7 5.7],tag)
% Temprod_estrep_match('s13',[5 7],'Grads1',[5.7 5.7],tag)
% Temprod_estrep_match('s12',[2 4],'Grads1',[5.7 5.7],tag)
% Temprod_estrep_match('s12',[5 7],'Grads1',[5.7 5.7],tag)
% Temprod_estrep_match('s11',[2 4],'Grads1',[5.7 5.7],tag)
% Temprod_estrep_match('s10',[2 4],'Grads1',[5.7 5.7],tag)
% Temprod_estrep_match('s10',[5 7],'Grads1',[5.7 5.7],tag)
% 
% Temprod_estrep_match('s14',[2 4],'Mags',[5.7 5.7],tag)
% Temprod_estrep_match('s14',[5 7],'Mags',[5.7 5.7],tag)
% Temprod_estrep_match('s13',[2 4],'Mags',[5.7 5.7],tag)
% Temprod_estrep_match('s13',[5 7],'Mags',[5.7 5.7],tag)
% Temprod_estrep_match('s12',[2 4],'Mags',[5.7 5.7],tag)
% Temprod_estrep_match('s12',[5 7],'Mags',[5.7 5.7],tag)
% Temprod_estrep_match('s11',[2 4],'Mags',[5.7 5.7],tag)
% Temprod_estrep_match('s10',[2 4],'Mags',[5.7 5.7],tag)
% Temprod_estrep_match('s10',[5 7],'Mags',[5.7 5.7],tag)
% 
% chantype = {'Mags';'Grads1';'Grads2'};
% subjects = {'s14';'s13';'s12';'s11';'s10'};
% for j = 1:5
%     for i = 1:3
%         Temprod_cond_ratio(subjects{j},[2 4],chantype{i},12600,[1 120],5.7,tag)
%     end
% end
% chantype = {'Mags';'Grads1';'Grads2'};
% subjects = {'s14';'s13';'s12';'s10'};
% for j = 1:4
%     for i = 1:3
%         Temprod_cond_ratio(subjects{j},[5 7],chantype{i},12600,[1 120],5.7,tag)
%     end
% end
% 
% chantype = {'Mags','Grads1','Grads2'};
% freqband = {[2 5],[7 14],[15 30],[30 120]};
% subjects = {'s14','s13','s12','s11','s10'};
% for j = 3:5
%     for k = 1:4
%         for i = 1:3
%             Temprod_Dataviewer_ratio(subjects{j},[2 4],freqband{k},chantype{i},[1],'on',0.05,tag)
%         end
%     end
% end
%            
% Temprod_Dataviewer_Var_Ratio('s14',[2 4],[2 48],1,tag)
% Temprod_Dataviewer_Var_Ratio('s14',[5 7],[2 48],1,tag)
% Temprod_Dataviewer_Var_Ratio('s13',[2 4],[2 48],1,tag)
% Temprod_Dataviewer_Var_Ratio('s13',[5 7],[2 48],1,tag)
% Temprod_Dataviewer_Var_Ratio('s12',[5 7],[2 48],1,tag)
% Temprod_Dataviewer_Var_Ratio('s12',[2 4],[2 48],1,tag)
% Temprod_Dataviewer_Var_Ratio('s11',[2 4],[2 48],1,tag)
% Temprod_Dataviewer_Var_Ratio('s10',[2 4],[2 48],1,tag)
% Temprod_Dataviewer_Var_Ratio('s10',[5 7],[2 48],1,tag)
% 
% Temprod_Dataviewer_Var_Ratio('s14',[2 4],[52 98],1,tag)
% Temprod_Dataviewer_Var_Ratio('s14',[5 7],[52 98],1,tag)
% Temprod_Dataviewer_Var_Ratio('s13',[2 4],[52 98],1,tag)
% Temprod_Dataviewer_Var_Ratio('s13',[5 7],[52 98],1,tag)
% Temprod_Dataviewer_Var_Ratio('s12',[2 4],[52 98],1,tag)
% Temprod_Dataviewer_Var_Ratio('s12',[5 7],[52 98],1,tag)
% Temprod_Dataviewer_Var_Ratio('s11',[2 4],[52 98],1,tag)
% Temprod_Dataviewer_Var_Ratio('s10',[2 4],[52 98],1,tag)
% Temprod_Dataviewer_Var_Ratio('s10',[5 7],[52 98],1,tag)
% 
% Temprod_estrep_freqanalysis('s14',[2 4],'Mags',13000,'Laptop')
% Temprod_estrep_freqanalysis('s14',[5 7],'Mags',13000,'Laptop')
% Temprod_estrep_freqanalysis('s13',[2 4],'Mags',13000,'Laptop')
% Temprod_estrep_freqanalysis('s13',[5 7],'Mags',13000,'Laptop')
% Temprod_estrep_freqanalysis('s12',[2 4],'Mags',13000,'Laptop')
% Temprod_estrep_freqanalysis('s12',[5 7],'Mags',13000,'Laptop')
% Temprod_estrep_freqanalysis('s11',[2 4],'Mags',13000,'Laptop')
% Temprod_estrep_freqanalysis('s10',[2 4],'Mags',13000,'Laptop')
% Temprod_estrep_freqanalysis('s10',[5 7],'Mags',13000,'Laptop')
% 
% Temprod_estrep_freqanalysis('s14',[2 4],'grads1',13000,'Laptop')
% Temprod_estrep_freqanalysis('s14',[5 7],'grads1',13000,'Laptop')
% Temprod_estrep_freqanalysis('s13',[2 4],'grads1',13000,'Laptop')
% Temprod_estrep_freqanalysis('s13',[5 7],'grads1',13000,'Laptop')
% Temprod_estrep_freqanalysis('s12',[2 4],'grads1',13000,'Laptop')
% Temprod_estrep_freqanalysis('s12',[5 7],'grads1',13000,'Laptop')
% Temprod_estrep_freqanalysis('s11',[2 4],'grads1',13000,'Laptop')
% Temprod_estrep_freqanalysis('s10',[2 4],'grads1',13000,'Laptop')
% Temprod_estrep_freqanalysis('s10',[5 7],'grads1',13000,'Laptop')
% 
% Temprod_estrep_freqanalysis('s14',[2 4],'grads2',13000,'Laptop')
% Temprod_estrep_freqanalysis('s14',[5 7],'grads2',13000,'Laptop')
% Temprod_estrep_freqanalysis('s13',[2 4],'grads2',13000,'Laptop')
% Temprod_estrep_freqanalysis('s13',[5 7],'grads2',13000,'Laptop')
% Temprod_estrep_freqanalysis('s12',[2 4],'grads2',13000,'Laptop')
% Temprod_estrep_freqanalysis('s12',[5 7],'grads2',13000,'Laptop')
% Temprod_estrep_freqanalysis('s11',[2 4],'grads2',13000,'Laptop')
% Temprod_estrep_freqanalysis('s10',[2 4],'grads2',13000,'Laptop')
% Temprod_estrep_freqanalysis('s10',[5 7],'grads2',13000,'Laptop')
% 
% Temprod_estrep_compare('s14',[5 7],'Mags','Laptop')
% Temprod_estrep_compare('s13',[2 4],'Mags','Laptop')
% Temprod_estrep_compare('s13',[5 7],'Mags','Laptop')
% Temprod_estrep_compare('s12',[2 4],'Mags','Laptop')
% Temprod_estrep_compare('s12',[5 7],'Mags','Laptop')
% Temprod_estrep_compare('s11',[2 4],'Mags','Laptop')
% Temprod_estrep_compare('s10',[2 4],'Mags','Laptop')
% Temprod_estrep_compare('s10',[5 7],'Mags','Laptop')
% 
% Temprod_estrep_compare('s14',[2 4],'Grads1','Laptop')
% Temprod_estrep_compare('s14',[5 7],'Grads1','Laptop')
% Temprod_estrep_compare('s13',[2 4],'Grads1','Laptop')
% Temprod_estrep_compare('s13',[5 7],'Grads1','Laptop')
% Temprod_estrep_compare('s12',[2 4],'Grads1','Laptop')
% Temprod_estrep_compare('s12',[5 7],'Grads1','Laptop')
% Temprod_estrep_compare('s11',[2 4],'Grads1','Laptop')
% Temprod_estrep_compare('s10',[2 4],'Grads1','Laptop')
% Temprod_estrep_compare('s10',[5 7],'Grads1','Laptop')
% 
% Temprod_estrep_compare('s14',[2 4],'Grads2','Laptop')
% Temprod_estrep_compare('s14',[5 7],'Grads2','Laptop')
% Temprod_estrep_compare('s13',[2 4],'Grads2','Laptop')
% Temprod_estrep_compare('s13',[5 7],'Grads2','Laptop')
% Temprod_estrep_compare('s12',[2 4],'Grads2','Laptop')
% Temprod_estrep_compare('s12',[5 7],'Grads2','Laptop')
% Temprod_estrep_compare('s11',[2 4],'Grads2','Laptop')
% Temprod_estrep_compare('s10',[2 4],'Grads2','Laptop')
% Temprod_estrep_compare('s10',[5 7],'Grads2','Laptop')
% 
