% RESONANCE MEG MAIN
clear all
close all

addpath('C:\RESONANCE_MEG\NEW_SCRIPTS')
addpath(genpath('C:\FIELDTRIP\fieldtrip-20120402'));
% addpath('C:\FIELDTRIP\fieldtrip-20120402');
% addpath(genpath('C:\FIELDTRIP\fieldtrip-20111020'));
addpath(genpath('C:\TEMPROD\SCRIPTS\Matlab_pipeline\Ref_functions'));
addpath(genpath('C:\RESONANCE_fMRI\Resonance2010_batched'))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load('C:\RESONANCE_MEG\DATA\cb100118\processed\run1_100_stimfreq.mat');
fiff_write_evoked('C:\RESONANCE_MEG\DATA\cb100118\for_mne_python\run 1_100_stimfreq',DATA);