%% TEMPROD ANALYSIS
clear all
close all

%% SET PATHS %%
% rmpath(genpath('/neurospin/local/fieldtrip'))
% addpath(genpath('/neurospin/meg/meg_tmp/fieldtrip-20110201'));
% addpath(genpath('/neurospin/meg/meg_tmp/fieldtrip-20110404'));
addpath(genpath('/neurospin/local/fieldtrip'));
ft_defaults
addpath '/neurospin/local/mne/i686/share/matlab/'
addpath '/neurospin/meg/meg_tmp/temprod_Baptiste_2010/SCRIPTS/Matlab_pipeline/My_functions/Main'
addpath '/neurospin/meg/meg_tmp/temprod_Baptiste_2010/SCRIPTS/Matlab_pipeline/My_functions/Behavior'
addpath '/neurospin/meg/meg_tmp/temprod_Baptiste_2010/SCRIPTS/Matlab_pipeline/My_functions/Preprocessing'
addpath '/neurospin/meg/meg_tmp/temprod_Baptiste_2010/SCRIPTS/Matlab_pipeline/My_functions/Frequency'
addpath '/neurospin/meg/meg_tmp/temprod_Baptiste_2010/SCRIPTS/Matlab_pipeline/My_functions/Timelock'
addpath '/neurospin/meg/meg_tmp/temprod_Baptiste_2010/SCRIPTS/Matlab_pipeline/My_functions/ICA'
addpath '/neurospin/meg/meg_tmp/temprod_Baptiste_2010/SCRIPTS/Matlab_pipeline/My_functions/Misc'
addpath '/neurospin/meg/meg_tmp/temprod_Baptiste_2010/SCRIPTS/Matlab_pipeline/My_functions/n_way_toolbox'

% temprod_BehaviorSummary(subject,RunNum,fsample,TD,savetag)
RunNum     = 2:7;
fsample    = [1 1 1 1 1 1]*1000; 
TD         = [5.7 8.5 5.7 5.7 8.5 5.7];  
subject    = 's03';
[meds03,meAns03,SDs03,meAnnorms03] = temprod_BehaviorSummary_s03(subject,RunNum,fsample,TD,1);

temprod_preproc_s03(2,1,'s03',4,1)
temprod_preproc_s03(3,1,'s03',4,1)
temprod_preproc_s03(4,1,'s03',4,1)
temprod_preproc_s03(5,1,'s03',4,1)
temprod_preproc_s03(6,1,'s03',4,1)
temprod_preproc_s03(7,1,'s03',4,1)

temprod_freqanalysis(2,'s03',[1 120])
temprod_freqanalysis(3,'s03',[1 120])
temprod_freqanalysis(4,'s03',[1 120])
temprod_freqanalysis(5,'s03',[1 120])
temprod_freqanalysis(6,'s03',[1 120])
temprod_freqanalysis(7,'s03',[1 120])

appendspectra_V2(2,'s03',[1 120])
appendspectra_V2(3,'s03',[1 120])
appendspectra_V2(4,'s03',[1 120])
appendspectra_V2(5,'s03',[1 120])
appendspectra_V2(6,'s03',[1 120])
appendspectra_V2(7,'s03',[1 120])

temprod_dataviewer(2,'s03',[30 80],[1 2 1],0,0,0,1);
temprod_dataviewer(3,'s03',[30 80],[1 2 1],0,0,0,1);
temprod_dataviewer(4,'s03',[30 80],[1 2 1],0,0,0,1);
temprod_dataviewer(5,'s03',[30 80],[1 2 1],0,0,0,1);
temprod_dataviewer(6,'s03',[30 80],[1 2 1],0,0,0,1);
temprod_dataviewer(7,'s03',[30 80],[1 2 1],0,0,0,1);

temprod_preproc_ICA_s03(2,1,'s03',4,1)
temprod_preproc_ICA_s03(3,1,'s03',4,1)
temprod_preproc_ICA_s03(4,1,'s03',4,1)
temprod_preproc_ICA_s03(5,1,'s03',4,1)
temprod_preproc_ICA_s03(6,1,'s03',4,1)
temprod_preproc_ICA_s03(7,1,'s03',4,1)

temprod_ICA_V5(2,'s03',[1 120],'runica',15,0.5)
temprod_ICA_V5(3,'s03',[1 120],'runica',15,0.5)
temprod_ICA_V5(4,'s03',[1 120],'runica',15,0.5)
temprod_ICA_V5(5,'s03',[1 120],'runica',15,0.5)
temprod_ICA_V5(6,'s03',[1 120],'runica',15,0.5)
temprod_ICA_V5(7,'s03',[1 120],'runica',15,0.5)

temprod_ICA_viewer(2,'s03',15,[1 30],'runica')
temprod_ICA_viewer(3,'s03',15,[1 30],'runica')
temprod_ICA_viewer(4,'s03',15,[1 30],'runica')
temprod_ICA_viewer(5,'s03',15,[1 30],'runica')
temprod_ICA_viewer(6,'s03',15,[1 30],'runica')
temprod_ICA_viewer(7,'s03',15,[1 30],'runica')

temprod_dataviewer_var([2 3 4 5 6 7],'s03',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var([2 3 4 5 6 7],'s03',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var([2 3 4 5 6 7],'s03',[50 120],0,0,'MEAN','old',1);
temprod_dataviewer_var([2 3 4 5 6 7],'s03',[50 120],0,0,'STD','old',1);

temprod_dataviewer_var_clusters([2 3 4 5 6 7],'s03',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_clusters([2 3 4 5 6 7],'s03',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_clusters([2 3 4 5 6 7],'s03',[50 120],0,0,'MEAN','old',1);
temprod_dataviewer_var_clusters([2 3 4 5 6 7],'s03',[50 120],0,0,'STD','old',1);

temprod_tbt_spectra(1,'s03',[1 120],1)
temprod_tbt_spectra(2,'s03',[1 120],1)
temprod_tbt_spectra(3,'s03',[1 120],1)
temprod_tbt_spectra(4,'s03',[1 120],1)
temprod_tbt_spectra(5,'s03',[1 120],1)
temprod_tbt_spectra(6,'s03',[1 120],1)
temprod_tbt_spectra(7,'s03',[1 120],1)
