%% TEMPROD ANALYSIS
clear all
close all

tag = 'Laptop';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if strcmp(tag,'Laptop') == 1
    
    %% SET PATHS %%
    addpath('C:\FIELDTRIP\fieldtrip-20120402');
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
chantype = {'Mags';'Grads1';'Grads2'};
subjects = {'s14';'s13';'s12';'s11';'s10'};
for j = 1:5
    for i = 1:3
        Temprod_cond_ratio_FIGTHESIS(subjects{j},[2 4],chantype{i},12600,[1 120],5.7,tag)
    end
end

chantype = {'Mags';'Grads1';'Grads2'};
subjects = {'s14';'s13';'s12';'s10'};
for j = 1:5
    for i = 1:3
        Temprod_cond_ratio_FIGTHESIS(subjects{j},[5 7],chantype{i},12600,[1 120],5.7,tag)
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
chantype = {'Mags';'Grads1';'Grads2'};
subjects = {'s14';'s13';'s12';'s10'};
FreqArray = {[9 9],[8.5 8.5],[9 9],[10 10]};
for j = 1:4
    for i = 1:3
        Temprod_estrep_compare_v3(subjects{j},{[2 4],[5 7]},chantype{i},FreqArray{j},'alpha',{[-2e-28 2e-28],[-2e-26 2e-26]},'Laptop')
    end
end

chantype = {'Mags';'Grads1';'Grads2'};
subjects = {'s11'};
FreqArray = {[8 8]};
for j = 1:1
    for i = 1:3
        Temprod_estrep_compare_v3(subjects{j},{[2 4]},chantype{i},FreqArray{j},'alpha',{[-2e-28 2e-28],[-2e-26 2e-26]},'Laptop')
    end
end

chantype = {'Mags';'Grads1';'Grads2'};
subjects = {'s14';'s13';'s12';'s10'};
FreqArray = {[21 21],[18 18],[20 20],[22 22]};
for j = 1:4
    for i = 1:3
        Temprod_estrep_compare_v3(subjects{j},{[2 4],[5 7]},chantype{i},FreqArray{j},'beta',{[-5e-29 5e-29],[-5e-27 5e-27]},'Laptop')
    end
end

chantype = {'Mags';'Grads1';'Grads2'};
subjects = {'s11'};
FreqArray = {[18 18]};
for j = 1
    for i = 1:3
        Temprod_estrep_compare_v3(subjects{j},{[2 4]},chantype{i},FreqArray{j},'beta',{[-5e-29 5e-29],[-5e-27 5e-27]},'Laptop')
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% get summary of all correlations
SubjArray = {'s14','s13','s12','s11','s10','s08','s07','s06','s05','s04'};
FreqArray = {[6.5 10.5],[6.5 10.5],[7 11],[5.5 9.5],[8 12],[6 10],[10 14],[8.5 12.5],[8.5 12.5],[9 13]};
RunArray  = {[2 3 5 6],[2 3 5 6],[2 3 5 6],[2 3 5],[2 3 5 6],2:6,2:6,1:4,1:3,1:3};
ChanArray = {'Mags','Grads1','Grads2'};

for a = 1:3
    for b = 1:length(SubjArray)
        for c = 1:length(RunArray{b})
            Temprod_Dataviewer_FIGTHESIS(SubjArray{b},RunArray{b}(c),FreqArray{b},ChanArray{a},0,tag)
        end
    end
end

SubjArray = {'s14','s13','s12','s11','s10','s08','s07','s06','s05','s04'};
FreqArray = {[15 25],[15 25],[15 25],[15 25],[20 30],[15 25],[15 25],[15 25],[15 25],[15 25]};
RunArray  = {[2 3 5 6],[2 3 5 6],[2 3 5 6],[2 3 5],[2 3 5 6],2:6,2:6,1:4,1:3,1:3};
ChanArray = {'Mags','Grads1','Grads2'};

for a = 1:3
    for b = 1:length(SubjArray)
        for c = 1:length(RunArray{b})
            Temprod_Dataviewer_FIGTHESIS(SubjArray{b},RunArray{b}(c),FreqArray{b},ChanArray{a},0,tag)
        end
    end
end

SubjArray = {'s14','s13','s12','s11','s10','s08','s07','s06','s05','s04'};
FreqArray = {[2 5],[2 5],[2 5],[2 5],[2 5],[2 5],[2 5],[2 5],[2 5],[2 5]};
RunArray  = {[2 3 5 6],[2 3 5 6],[2 3 5 6],[2 3 5],[2 3 5 6],2:6,2:6,1:4,1:3,1:3};
ChanArray = {'Mags','Grads1','Grads2'};

for a = 1:3
    for b = 1:length(SubjArray)
        for c = 1:length(RunArray{b})
            Temprod_Dataviewer_FIGTHESIS(SubjArray{b},RunArray{b}(c),FreqArray{b},ChanArray{a},0,tag)
        end
    end
end

%%%%% REPLAY %%%%%
% get summary of all correlations
SubjArray = {'s14','s13','s12','s11','s10'};
FreqArray = {[6.5 10.5],[6.5 10.5],[7 11],[5.5 9.5],[8 12]};
RunArray  = {[4 7],[4 7],[4 7],[ 4 ],[4 7]};
ChanArray = {'Mags','Grads1','Grads2'};

for a = 1:3
    for b = 1:length(SubjArray)
        for c = 1:length(RunArray{b})
            Temprod_Dataviewer_FIGTHESIS(SubjArray{b},RunArray{b}(c),FreqArray{b},ChanArray{a},0,tag)
        end
    end
end

SubjArray = {'s14','s13','s12','s11','s10'};
FreqArray = {[15 25],[15 25],[15 25],[15 25],[20 30]};
RunArray  = {[4 7],[4 7],[4 7],[ 4 ],[4 7]};
ChanArray = {'Mags','Grads1','Grads2'};

for a = 1:3
    for b = 1:length(SubjArray)
        for c = 1:length(RunArray{b})
            Temprod_Dataviewer_FIGTHESIS(SubjArray{b},RunArray{b}(c),FreqArray{b},ChanArray{a},0,tag)
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sub  = {'s10','s11','s12','s13','s14'};
peak = [9 8 9 8.5 9];
name = 'alpha';

for i = 1:5
%     temprod_vs_baseline(sub{i},peak(i),name)
    temprod_vs_baseline_V2(sub{i},peak(i),name,[2 12])    
end

sub  = {'s10','s11','s12','s13','s14'};
peak = [15 18 13 16 11];
name = 'beta';

for i = 1:5
    temprod_vs_baseline_V2(sub{i},peak(i),name,[13 30])
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sub  = {'s10','s11','s12','s13','s14'};
peak = [9 8 9 8.5 9];
for i = 1:5
    temprod_CFC(sub{i},peak,'ALPHA')
end

sub  = {'s10','s11','s12','s13','s14'};
peak = [15 18 13 16 11];
for i = 1:5
    temprod_CFC(sub{i},peak,'BETA')
end

convertdata_forcanoltyplot('s14','Grads1')
convertdata_forcanoltyplot('s13','Grads1')
convertdata_forcanoltyplot('s12','Grads1')
convertdata_forcanoltyplot('s11','Grads1')
convertdata_forcanoltyplot('s10','Grads1')
convertdata_forcanoltyplot('s14','Grads2')
convertdata_forcanoltyplot('s13','Grads2')
convertdata_forcanoltyplot('s12','Grads2')
convertdata_forcanoltyplot('s11','Grads2')
convertdata_forcanoltyplot('s10','Grads2')
convertdata_forcanoltyplot('s14','Mags')
convertdata_forcanoltyplot('s13','Mags')
convertdata_forcanoltyplot('s12','Mags')
convertdata_forcanoltyplot('s11','Mags')
convertdata_forcanoltyplot('s10','Mags')


