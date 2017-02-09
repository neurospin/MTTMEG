% TEST MAIN

close all
clear all

addpath('C:\FIELDTRIP\fieldtrip-20130901')
addpath(genpath('C:\TEMPROD\SCRIPTS\Matlab_pipeline\Ref_functions'));
addpath('C:\TEMPROD\SCRIPTS\Matlab_pipeline\My_functions\Preprocessing');
addpath('C:\TEMPROD\FIELDTRIP');
addpath('C:\MTT_MEG\scripts');
ft_defaults

%%% PREPROC TEST %%%%%%%
% params

niplist = {'jm100109'};       
runlist = {{'run1_GD';'run2_GD'}};
EEGbadlist = {[17 25 35]};

% cond1    
delay       = 0.049;
window      = [0.3 1.2];
nip         = niplist{1};
condname{1} = 'TIMEQT1';
trialfun{1} = 'trialfun_mtt_TIMEQT1';

PREPROC2(runlist{1},delay,window,trialfun{1},condname{1},nip)
PREPROC_EEG2(runlist{1},delay,window,trialfun{1},condname{1},nip,EEGbadlist{1})

% cond2    
delay       = 0.049;
window      = [0.3 1.2];
nip         = niplist{1};
condname{1} = 'SPACEQT1';
trialfun{1} = 'trialfun_mtt_SPACEQT1';

PREPROC2(runlist{1},delay,window,trialfun{1},condname{1},nip)
PREPROC_EEG2(runlist{1},delay,window,trialfun{1},condname{1},nip,EEGbadlist{1})   

%%% ERF TEST %%%%%%%%%%%
niplist   = {'jm100109'};
chansel   = {'Mags'};
condnames = {'TIMEQT_pre';'SPACEQT_pre'};
condarray = {{'TIMEQT1'},{'SPACEQT1'}};
PlotColors = [[0 0 0];[1 0 0]];

TLSL_SUBJlvl(niplist{1},chansel{1},condnames,condarray,[0 0.9],PlotColors)

chansel   = {'EEG'};
TLSL_SUBJlvl_EEG(niplist{1},chansel{1},condnames,condarray,[0 0.9],PlotColors)




