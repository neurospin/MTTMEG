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
for run           = [2 3 4 5 6 7]
    Temprod_Preproc_Timelock_v2('s14',run,'ecg&eog','Laptop')    
end
% s13
for run           = [2 3 4 5 6 7]
    Temprod_Preproc_Timelock_v2('s13',run,'ecg&eog','Laptop')    
end
% s12
for run           = [2 3]
    Temprod_Preproc_Timelock_v2('s12',run,'nocorr','Laptop') 
end

for run           = [4 5 6 7]
    Temprod_Preproc_Timelock_v2('s12',run,'ecg&eog','Laptop') 
end

for run           = [2 3 4 5]
    Temprod_Preproc_Timelock_v2('s11',run,'ecg&eog','Laptop') 
end

for run           = [2 3 4 5 6]
    Temprod_Preproc_Timelock_v2('s10',run,'ecg&eog','Laptop') 
end

for run           = [7]
    Temprod_Preproc_Timelock_v2('s10',run,'nocorr','Laptop') 
end

for run           = [2 3 4 5 6]
    Temprod_Preproc_Timelock_v2('s08',run,'ecg&eog',tag)
end

for run           = [1 2]
    Temprod_Preproc_Timelock_v2('s07',run,'nocorr',tag) 
end

for run           = [3 4 5 6]
    Temprod_Preproc_Timelock_v2('s07',run,'ecg&eog',tag) 
end

for run           = [1 2 3 4]
    Temprod_Preproc_Timelock_v2('s06',run,'nocorr',tag) 
end

for run           = [1 2 3]
    Temprod_Preproc_Timelock_v2('s05',run,'ecg&eog',tag) 
end

for run           = [1 2 3]
    Temprod_Preproc_Timelock_v2('s04',run,'ecg&eog',tag)
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% code : 5.7estimation = 5.7; 8.5estimation = 8.5; 5.7replay = 100
temprod_timelock_t0([2 5],'s14',[5.7 5.7])
temprod_timelock_t0([3 6],'s14',[8.5 8.5],5)
temprod_timelock_t0([4 7],'s14',[5.7 5.7],5)

temprod_timelock_tend([2 5],'s14',[5.7 5.7],5)
temprod_timelock_tend([3 6],'s14',[8.5 8.5],5)
temprod_timelock_tend([4 7],'s14',[5.7 5.7],5)

temprod_timelock_t0([2 5],'s13',[5.7 5.7],5)
temprod_timelock_t0([3 6],'s13',[8.5 8.5],5)
temprod_timelock_t0([4 7],'s13',[5.7 5.7],5)

temprod_timelock_t0([2 5],'s12',[5.7 5.7],5)
temprod_timelock_t0([3 6],'s12',[8.5 8.5],5)
temprod_timelock_t0([4 7],'s12',[5.7 5.7],5)

temprod_timelock_t0([2 5],'s11',[5.7 5.7],5)
temprod_timelock_t0([3],'s11',[8.5],5)
temprod_timelock_t0([4],'s11',[5.7],5)

temprod_timelock_t0([2 4 5],'s08',[6.5 6.5 6.5],5)
temprod_timelock_t0([3 6],'s08',[8.5 8.5],5)

temprod_timelock_t0([1 3 4],'s07',[6.5 6.5 6.5],5)
temprod_timelock_t0([2 5 6],'s07',[8.5 8.5 8.5],5)

temprod_timelock_t0([1 3],'s06',[6.5 6.5],5)
temprod_timelock_t0([2 4],'s06',[8.5 8.5],5)

temprod_timelock_t0([1 3],'s05',[6.5 6.5],5)
temprod_timelock_t0([2],'s05',[8.5],5)

% temprod_timelock_t0([1],'s04',[5.7],5)
% temprod_timelock_t0([2],'s04',[12.9],5)
% temprod_timelock_t0([3],'s04',[9.3],5)







