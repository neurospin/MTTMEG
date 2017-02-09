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
addpath '/neurospin/meg/meg_tmp/temprod_Baptiste_2010/SCRIPTS/Matlab_pipeline/My_functions/Time-Frequency'
addpath '/neurospin/meg/meg_tmp/temprod_Baptiste_2010/SCRIPTS/Matlab_pipeline/My_functions/n_way_toolbox'

% temprod_BehaviorSummary(subject,RunNum,fsample,TD,savetag)
RunNum     = 2:7;
fsample    = [1 1 1 1 1 1]*1000;
TD         = [5.7 8.5 5.7 5.7 8.5 5.7];
subject    = 's14';
[meds14,meAns14,SDs14,meAnnorms14] = temprod_BehaviorSummary(subject,RunNum,fsample,TD,1);

temprod_preproc_V2(2,1,'s14',4,1)
temprod_preproc_V2(3,1,'s14',4,1)
temprod_preproc_V2(4,1,'s14',4,1)
temprod_preproc_V2(5,1,'s14',4,1)
temprod_preproc_V2(6,1,'s14',4,1)
temprod_preproc_V2(7,1,'s14',4,1)

temprod_preproc_jr(2,'s14',1,tag)
temprod_preproc_jr(3,'s14',1,tag)
temprod_preproc_jr(4,'s14',1,tag)
temprod_preproc_jr(5,'s14',1,tag)
temprod_preproc_jr(6,'s14',1,tag)
temprod_preproc_jr(7,'s14',1,tag)
temprod_freqanalysis_jrcw(2,'s14',[1 120],tag)
temprod_freqanalysis_jrcw(3,'s14',[1 120],tag)
temprod_freqanalysis_jrcw(4,'s14',[1 120],tag)
temprod_freqanalysis_jrcw(5,'s14',[1 120],tag)
temprod_freqanalysis_jrcw(6,'s14',[1 120],tag)
temprod_freqanalysis_jrcw(7,'s14',[1 120],tag)
appendspectra_jrcw(2,'s14',[1 120],tag)
appendspectra_jrcw(3,'s14',[1 120],tag)
appendspectra_jrcw(4,'s14',[1 120],tag)
appendspectra_jrcw(5,'s14',[1 120],tag)
appendspectra_jrcw(6,'s14',[1 120],tag)
appendspectra_jrcw(7,'s14',[1 120],tag)
% temprod_dataviewer_jrcw(index,subject,freqband,K,debiasing,interpnoise,chandisplay,savetag,tag)
temprod_dataviewer_jrcw(2,'s14',[40 120],[1 2 3 2 1],0,1,0,1,tag);
temprod_dataviewer_jrcw(3,'s14',[15 40],[1 2 3 2 1],0,1,0,1,tag);
temprod_dataviewer_jrcw(4,'s14',[15 40],[1 2 3 2 1],0,1,0,1,tag);
temprod_dataviewer_jrcw(5,'s14',[15 40],[1 2 3 2 1],0,1,0,1,tag);
temprod_dataviewer_jrcw(6,'s14',[15 40],[1 2 3 2 1],0,1,0,1,tag);
temprod_dataviewer_jrcw(7,'s14',[15 40],[1 2 3 2 1],0,1,0,1,tag);

[Max2,Min2] = temprod_preproc_half(2,1,'s14',4,1,tag);
[Max3,Min3] = temprod_preproc_half(3,1,'s14',4,1,tag);
[Max4,Min4] = temprod_preproc_half(4,1,'s14',4,1,tag);
[Max5,Min5] = temprod_preproc_half(5,1,'s14',4,1,tag);
[Max6,Min6] = temprod_preproc_half(6,1,'s14',4,1,tag);
[Max7,Min7] = temprod_preproc_half(7,1,'s14',4,1,tag);

temprod_preproc_quarter(2,1,'s14',4,1,tag);
temprod_preproc_quarter(3,1,'s14',4,1,tag);
temprod_preproc_quarter(4,1,'s14',4,1,tag);
temprod_preproc_quarter(5,1,'s14',4,1,tag);
temprod_preproc_quarter(6,1,'s14',4,1,tag);
temprod_preproc_quarter(7,1,'s14',4,1,tag);

temprod_preproc_ECG(2,1,'s14',4,1,[1 120])
temprod_preproc_ECG(3,1,'s14',4,1,[1 120])
temprod_preproc_ECG(4,1,'s14',4,1,[1 120])
temprod_preproc_ECG(5,1,'s14',4,1,[1 120])
temprod_preproc_ECG(6,1,'s14',4,1,[1 120])
temprod_preproc_ECG(7,1,'s14',4,1,[1 120])
temprod_dataviewer_ECG(2,'s14',[1 5],[1 2 3 2 1],1,1,1)
temprod_dataviewer_ECG(3,'s14',[1 5],[1 2 3 2 1],1,1,1)
temprod_dataviewer_ECG(4,'s14',[1 5],[1 2 3 2 1],1,1,1)
temprod_dataviewer_ECG(5,'s14',[1 5],[1 2 3 2 1],1,1,1)
temprod_dataviewer_ECG(6,'s14',[1 5],[1 2 3 2 1],1,1,1)
temprod_dataviewer_ECG(7,'s14',[1 5],[1 2 3 2 1],1,1,1)

% temprod_preproc_ECG_v2(run,isdownsample,subject,runref,rejection,tag)
temprod_preproc_ECG_v2(2,1,'s14',4,1,tag)
temprod_preproc_ECG_v2(3,1,'s14',4,1,tag)
temprod_preproc_ECG_v2(4,1,'s14',4,1,tag)
temprod_preproc_ECG_v2(5,1,'s14',4,1,tag)
temprod_preproc_ECG_v2(6,1,'s14',4,1,tag)
temprod_preproc_ECG_v2(7,1,'s14',4,1,tag)

temprod_freqanalysis(2,'s14',[1 120])
temprod_freqanalysis(3,'s14',[1 120])
temprod_freqanalysis(4,'s14',[1 120])
temprod_freqanalysis(5,'s14',[1 120])
temprod_freqanalysis(6,'s14',[1 120])
temprod_freqanalysis(7,'s14',[1 120])

temprod_freqanalysis_quarter(2,'s14',12600,[1 120],tag)
temprod_freqanalysis_quarter(3,'s14',12600,[1 120],tag)
temprod_freqanalysis_quarter(4,'s14',12600,[1 120],tag)
temprod_freqanalysis_quarter(5,'s14',12600,[1 120],tag)
temprod_freqanalysis_quarter(6,'s14',12600,[1 120],tag)
temprod_freqanalysis_quarter(7,'s14',12600,[1 120],tag)

appendspectra_V2(2,'s14',[1 120])
appendspectra_V2(3,'s14',[1 120])
appendspectra_V2(4,'s14',[1 120])
appendspectra_V2(5,'s14',[1 120])
appendspectra_V2(6,'s14',[1 120])
appendspectra_V2(7,'s14',[1 120])

% temprod_dataviewer_V2(index,subject,freqband,K,debiasing,interpnoise,chandisplay,savetag)
temprod_dataviewer_V2(2,'s14',[1 6],[1 2 3 2 1],1,1,1,1,tag);
temprod_dataviewer_V2(3,'s14',[1 6],[1 2 3 2 1],1,1,1,1,tag);
temprod_dataviewer_V2(4,'s14',[1 6],[1 2 3 2 1],1,1,1,1,tag);
temprod_dataviewer_V2(5,'s14',[1 6],[1 2 3 2 1],1,1,1,1,tag);
temprod_dataviewer_V2(6,'s14',[1 6],[1 2 3 2 1],1,1,1,1,tag);
temprod_dataviewer_V2(7,'s14',[1 6],[1 2 3 2 1],1,1,1,1,tag);

% temprod_dataviewer_accuracy(index,subject,freqband,K,debiasing,interpnoise,chandisplay,target,savetag,tag)
temprod_dataviewer_accuracy(2,'s14',[2 7],[1 2 3 2 1],1,1,0,5700,1,tag);
temprod_dataviewer_accuracy(3,'s14',[2 7],[1 2 3 2 1],1,1,0,8500,1,tag);
temprod_dataviewer_accuracy(4,'s14',[2 7],[1 2 3 2 1],1,1,0,5700,1,tag);
temprod_dataviewer_accuracy(5,'s14',[2 7],[1 2 3 2 1],1,1,0,5700,1,tag);
temprod_dataviewer_accuracy(6,'s14',[2 7],[1 2 3 2 1],1,1,0,8500,1,tag);
temprod_dataviewer_accuracy(7,'s14',[2 7],[1 2 3 2 1],1,1,0,5700,1,tag);

temprod_dataviewer_clusters(2,'s14',[1 6],[1],1,[8 12],1,0,1);
temprod_dataviewer_clusters(3,'s14',[1 6],[1],1,[8 12],1,1,1);
temprod_dataviewer_clusters(4,'s14',[1 6],[1],1,[8 12],1,1,1);
temprod_dataviewer_clusters(5,'s14',[1 6],[1],1,[8 12],1,1,1);
temprod_dataviewer_clusters(6,'s14',[1 6],[1],1,[8 12],1,1,1);
temprod_dataviewer_clusters(7,'s14',[1 6],[1],1,[8 12],1,1,1);

temprod_preproc_ICA(2,1,'s14',4,1)
temprod_preproc_ICA(3,1,'s14',4,1)
temprod_preproc_ICA(4,1,'s14',4,1)
temprod_preproc_ICA(5,1,'s14',4,1)
temprod_preproc_ICA(6,1,'s14',4,1)
temprod_preproc_ICA(7,1,'s14',4,1)

temprod_ICA_V5(2,'s14',[1 120],'runica',15,0.5)
temprod_ICA_V5(3,'s14',[1 120],'runica',15,0.5)
temprod_ICA_V5(4,'s14',[1 120],'runica',15,0.5)
temprod_ICA_V5(5,'s14',[1 120],'runica',15,0.5)
temprod_ICA_V5(6,'s14',[1 120],'runica',15,0.5)
temprod_ICA_V5(7,'s14',[1 120],'runica',15,0.5)

temprod_ICA_viewer(2,'s14',15,[1 30],'runica')
temprod_ICA_viewer(3,'s14',15,[1 30],'runica')
temprod_ICA_viewer(4,'s14',15,[1 30],'runica')
temprod_ICA_viewer(5,'s14',15,[1 30],'runica')
temprod_ICA_viewer(6,'s14',15,[1 30],'runica')
temprod_ICA_viewer(7,'s14',15,[1 30],'runica')

temprod_dataviewer_var([2 3 4 5 6 7],'s14',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var([2 3 4 5 6 7],'s14',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var([2 3 4 5 6 7],'s14',[50 120],0,0,'MEAN','old',1);
temprod_dataviewer_var([2 3 4 5 6 7],'s14',[50 120],0,0,'STD','old',1);

% temprod_dataviewer_var_clusters(indexes,subject,freqband,debiasing,alphapeak,datatoplot,mode,savetag)
temprod_dataviewer_var_clusters([2 3 4 5 6 7],'s14',[1 6],1,[8 12],'MEAN','old',1);
temprod_dataviewer_var_clusters([2 3 4 5 6 7],'s14',[1 6],1,[8 12],'STD','old',1);
temprod_dataviewer_var_clusters([2 3 4 5 6 7],'s14',[6 15],1,[8 12],'MEAN','old',1);
temprod_dataviewer_var_clusters([2 3 4 5 6 7],'s14',[6 15],1,[8 12],'STD','old',1);
temprod_dataviewer_var_clusters([2 3 4 5 6 7],'s14',[15 30],1,[8 12],'MEAN','old',1);
temprod_dataviewer_var_clusters([2 3 4 5 6 7],'s14',[15 30],1,[8 12],'STD','old',1);
temprod_dataviewer_var_clusters([2 3 4 5 6 7],'s14',[30 120],1,[8 12],'MEAN','old',1);
temprod_dataviewer_var_clusters([2 3 4 5 6 7],'s14',[30 120],1,[8 12],'STD','old',1);


temprod_dataviewer_var_clusters_half([2],'s14',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_clusters_half([2],'s14',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_clusters_half([3],'s14',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_clusters_half([3],'s14',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_clusters_half([4],'s14',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_clusters_half([4],'s14',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_clusters_half([5],'s14',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_clusters_half([5],'s14',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_clusters_half([6],'s14',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_clusters_half([6],'s14',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_clusters_half([7],'s14',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_clusters_half([7],'s14',[1 50],0,0,'STD','old',1);

temprod_dataviewer_var_half([2 3],'s14',[7 14],0,0,'MEAN','old',1);
temprod_dataviewer_var_half([2],'s14',[7 14],0,0,'STD','old',1);
temprod_dataviewer_var_half([3],'s14',[7 14],0,0,'MEAN','old',1);
temprod_dataviewer_var_half([3],'s14',[7 14],0,0,'STD','old',1);
temprod_dataviewer_var_half([4],'s14',[7 14],0,0,'MEAN','old',1);
temprod_dataviewer_var_half([4],'s14',[7 14],0,0,'STD','old',1);
temprod_dataviewer_var_half([5],'s14',[7 14],0,0,'MEAN','old',1);
temprod_dataviewer_var_half([5],'s14',[7 14],0,0,'STD','old',1);
temprod_dataviewer_var_half([6],'s14',[7 14],0,0,'MEAN','old',1);
temprod_dataviewer_var_half([6],'s14',[7 14],0,0,'STD','old',1);
temprod_dataviewer_var_half([7],'s14',[7 14],0,0,'MEAN','old',1);
temprod_dataviewer_var_half([7],'s14',[7 14],0,0,'STD','old',1);

temprod_dataviewer_var_EEG_half([2],'s14',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_EEG_half([2],'s14',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_EEG_half([3],'s14',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_EEG_half([3],'s14',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_EEG_half([4],'s14',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_EEG_half([4],'s14',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_EEG_half([5],'s14',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_EEG_half([5],'s14',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_EEG_half([6],'s14',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_EEG_half([6],'s14',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_EEG_half([7],'s14',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_EEG_half([7],'s14',[1 50],0,0,'STD','old',1);

temprod_tbt_spectra(2,'s14',[1 50],1)
temprod_tbt_spectra(3,'s14',[1 50],1)
temprod_tbt_spectra(4,'s14',[1 50],1)
temprod_tbt_spectra(5,'s14',[1 50],1)
temprod_tbt_spectra(6,'s14',[1 50],1)
temprod_tbt_spectra(7,'s14',[1 50],1)

temprod_freqslope(2,'s14',[1 4],1)
temprod_freqslope(3,'s14',[1 4],1)
temprod_freqslope(4,'s14',[1 4],1)
temprod_freqslope(5,'s14',[1 4],1)
temprod_freqslope(6,'s14',[1 4],1)
temprod_freqslope(7,'s14',[1 4],1)
temprod_freqslope(2,'s14',[4 7],1)
temprod_freqslope(3,'s14',[4 7],1)
temprod_freqslope(4,'s14',[4 7],1)
temprod_freqslope(5,'s14',[4 7],1)
temprod_freqslope(6,'s14',[4 7],1)
temprod_freqslope(7,'s14',[4 7],1)
temprod_freqslope(2,'s14',[1 7],1)
temprod_freqslope(3,'s14',[1 7],1)
temprod_freqslope(4,'s14',[1 7],1)
temprod_freqslope(5,'s14',[1 7],1)
temprod_freqslope(6,'s14',[1 7],1)
temprod_freqslope(7,'s14',[1 7],1)
temprod_freqslope(2,'s14',[30 80],1)
temprod_freqslope(3,'s14',[30 80],1)
temprod_freqslope(4,'s14',[30 80],1)
temprod_freqslope(5,'s14',[30 80],1)
temprod_freqslope(6,'s14',[30 80],1)
temprod_freqslope(7,'s14',[30 80],1)
temprod_freqslope(2,'s14',[30 120],1)
temprod_freqslope(3,'s14',[30 120],1)
temprod_freqslope(4,'s14',[30 120],1)
temprod_freqslope(5,'s14',[30 120],1)
temprod_freqslope(6,'s14',[30 120],1)
temprod_freqslope(7,'s14',[30 120],1)

temprod_freqslope_V2({[2 4];[3 4];[5 7];[6 7]},'s14',[1 4],1)
temprod_freqslope_V2({[2 4];[3 4];[5 7];[6 7]},'s14',[1 7],1)
temprod_freqslope_V2({[2 4];[3 4];[5 7];[6 7]},'s14',[4 7],1)
temprod_freqslope_V2({[2 4];[3 4];[5 7];[6 7]},'s14',[30 80],1)
temprod_freqslope_V2({[2 4];[3 4];[5 7];[6 7]},'s14',[30 120],1)

% temprod_freqanalysis_transientVSsteadystate(2,'s14',[1 50])
% appendspectra_V2_begend(2,'s14',[1 50])
% temprod_tbt_spectra_begend(2,'s14',[1 50],1)

temprod_freqanalysis_weighted(2,'s14',[1 120],10,0.9)
temprod_freqanalysis_weighted(3,'s14',[1 120],10,0.9)
temprod_freqanalysis_weighted(4,'s14',[1 120],10,0.9)
temprod_freqanalysis_weighted(5,'s14',[1 120],10,0.9)
temprod_freqanalysis_weighted(6,'s14',[1 120],10,0.9)
temprod_freqanalysis_weighted(7,'s14',[1 120],10,0.9)
appendspectra_weighted(2,'s14',[1 120],10,0.9)
appendspectra_weighted(3,'s14',[1 120],10,0.9)
appendspectra_weighted(4,'s14',[1 120],10,0.9)
appendspectra_weighted(5,'s14',[1 120],10,0.9)
appendspectra_weighted(6,'s14',[1 120],10,0.9)
appendspectra_weighted(7,'s14',[1 120],10,0.9)
temprod_tbt_spectra_weighted(2,'s14',[1 120],1,10,0.9)
temprod_tbt_spectra_weighted(3,'s14',[1 120],1,10,0.9)
temprod_tbt_spectra_weighted(4,'s14',[1 120],1,10,0.9)
temprod_tbt_spectra_weighted(5,'s14',[1 120],1,10,0.9)
temprod_tbt_spectra_weighted(6,'s14',[1 120],1,10,0.9)
temprod_tbt_spectra_weighted(7,'s14',[1 120],1,10,0.9)
temprod_freqslope_weighted(2,'s14',[1 4],1,10,0.9)
temprod_freqslope_weighted(3,'s14',[1 4],1,10,0.9)
temprod_freqslope_weighted(4,'s14',[1 4],1,10,0.9)
temprod_freqslope_weighted(5,'s14',[1 4],1,10,0.9)
temprod_freqslope_weighted(6,'s14',[1 4],1,10,0.9)
temprod_freqslope_weighted(7,'s14',[1 4],1,10,0.9)

temprod_betaERD(2,1,'s14',4,1)
temprod_betaERD(2,1,'s14',4,1)
temprod_betaERD(3,1,'s14',4,1)
temprod_betaERD(4,1,'s14',4,1)
temprod_betaERD(5,1,'s14',4,1)
temprod_betaERD(6,1,'s14',4,1)

temprod_FreqPow_corr_allbands_V2(2,'s14')
temprod_FreqPow_corr_allbands_V2(3,'s14')
temprod_FreqPow_corr_allbands_V2(4,'s14')
temprod_FreqPow_corr_allbands_V2(5,'s14')
temprod_FreqPow_corr_allbands_V2(6,'s14')
temprod_FreqPow_corr_allbands_V2(7,'s14')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

bad2 = {'EEG002';'EEG014';'EEG032';'EEG018';'EEG003'};
bad3 = {'EEG002';'EEG014';'EEG018';'EEG032'};
bad4 = {'EEG002';'EEG014';'EEG018';'EEG025'};
bad5 = {'EEG002';'EEG008';'EEG014';'EEG018';'EEG032';'EEG035'};
bad6 = {'EEG002';'EEG008';'EEG014';'EEG018';'EEG023';'EEG024';'EEG032';'EEG035';'EEG039';'EEG040'};
bad7 = {'EEG002';'EEG014';'EEG018';'EEG24';'EEG032';'EEG035'};

flat2 = {'EEG008';'EEG018';'EEG023';'EEG024';'EEG027';'EEG035'};
flat3 = {'EEG008';'EEG018';'EEG023';'EEG024';'EEG027';'EEG035'};
flat4 = {'EEG008';'EEG018';'EEG023';'EEG024';'EEG027';'EEG032';'EEG035'};
flat5 = {'EEG027'};
flat6 = {'EEG027'};
flat7 = {'EEG008';'EEG023';'EEG027'};

temprod_preproc_EEG(2,1,'s14',2,1,[bad2 ; flat2])
temprod_preproc_EEG(3,1,'s14',2,1,[bad3 ; flat3])
temprod_preproc_EEG(4,1,'s14',2,1,[bad4 ; flat4])
temprod_preproc_EEG(5,1,'s14',2,1,[bad5 ; flat5])
temprod_preproc_EEG(6,1,'s14',2,1,[bad6 ; flat6])
temprod_preproc_EEG(7,1,'s14',2,1,[bad7 ; flat7])

temprod_freqanalysis_eeg(0,2,'s14',[1 120])
temprod_freqanalysis_eeg(0,3,'s14',[1 120])
temprod_freqanalysis_eeg(0,4,'s14',[1 120])
temprod_freqanalysis_eeg(0,5,'s14',[1 120])
temprod_freqanalysis_eeg(0,6,'s14',[1 120])
temprod_freqanalysis_eeg(0,7,'s14',[1 120])

appendspectra_EEG(2,'s14',[1 120])
appendspectra_EEG(3,'s14',[1 120])
appendspectra_EEG(4,'s14',[1 120])
appendspectra_EEG(5,'s14',[1 120])
appendspectra_EEG(6,'s14',[1 120])
appendspectra_EEG(7,'s14',[1 120])

temprod_dataviewer_EEG(2,'s14',[30 80],[1 2 1],0,0,0,1)
temprod_dataviewer_EEG(3,'s14',[30 80],[1 2 1],0,0,0,1)
temprod_dataviewer_EEG(4,'s14',[30 80],[1 2 1],0,0,0,1)
temprod_dataviewer_EEG(5,'s14',[30 80],[1 2 1],0,0,0,1)
temprod_dataviewer_EEG(6,'s14',[30 80],[1 2 1],0,0,0,1)
temprod_dataviewer_EEG(7,'s14',[30 80],[1 2 1],0,0,0,1)

temprod_dataviewer_var_EEG([2 3 4 5 6 7],'s14',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_EEG([2 3 4 5 6 7],'s14',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_EEG([2 3 4 5 6 7],'s14',[50 120],0,0,'MEAN','old',1);
temprod_dataviewer_var_EEG([2 3 4 5 6 7],'s14',[50 120],0,0,'STD','old',1);
temprod_dataviewer_var_EEG([2 3 4 5 6 7],'s14',[1 15],0,0,'MEAN','old',1);
temprod_dataviewer_var_EEG([2 3 4 5 6 7],'s14',[1 15],0,0,'STD','old',1);
temprod_dataviewer_var_EEG([2 3 4 5 6 7],'s14',[15 30],0,0,'MEAN','old',1);
temprod_dataviewer_var_EEG([2 3 4 5 6 7],'s14',[15 30],0,0,'STD','old',1);

temprod_freqslope(2,'s14',[30 80],1,'Laptop')
temprod_freqslope(3,'s14',[30 80],1,'Laptop')
temprod_freqslope(4,'s14',[30 80],1,'Laptop')
temprod_freqslope(5,'s14',[30 80],1,'Laptop')
temprod_freqslope(6,'s14',[30 80],1,'Laptop')
temprod_freqslope(7,'s14',[30 80],1,'Laptop')

temprod_freqanalysis_slide10(2,'s14',[1 50])
appendspectra_s10(2,'s14',[1 50])
temprod_freqslope_s10(2,'s14',[1 4],1)
temprod_tbt_spectra_s10(2,'s14',[1 50],1)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% STATS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[ST_14_2,LT_14_2,Max_14_2] = temprod_preproc_half(2,1,'s14',4,1);
[ST_14_3,LT_14_3,Max_14_3] = temprod_preproc_half(3,1,'s14',4,1);
[ST_14_5,LT_14_5,Max_14_5] = temprod_preproc_half(5,1,'s14',4,1);
[ST_14_6,LT_14_6,Max_14_6] = temprod_preproc_half(6,1,'s14',4,1);

M = max([Max_14_2 Max_14_3 Max_14_5 Max_14_6]);

[SF_14_2,LF_14_2]          = temprod_freqanalysis_half(ST_14_2,LT_14_2,M,[1 100]);
[SF_14_3,LF_14_3]          = temprod_freqanalysis_half(ST_14_3,LT_14_3,M,[1 100]);
[SF_14_5,LF_14_5]          = temprod_freqanalysis_half(ST_14_5,LT_14_5,M,[1 100]);
[SF_14_6,LF_14_6]          = temprod_freqanalysis_half(ST_14_6,LT_14_6,M,[1 100]);

design = [1 1 1 1 2 2 2 2; 1 2 3 4 1 2 3 4];

stats = temprod_freqstats_half([1 7],design,'Tmap_1-4Hz_Mags',...
    SF_14_2,SF_14_3,SF_14_5,SF_14_6,...
    LF_14_2,LF_14_3,LF_14_5,LF_14_6);
stats = temprod_freqstats_half([4 7],design,'Tmap_4-7Hz_Mags',...
    SF_14_2,SF_14_3,SF_14_5,SF_14_6,...
    LF_14_2,LF_14_3,LF_14_5,LF_14_6);
stats = temprod_freqstats_half([1 7],design,'Tmap_1-7Hz_Mags',...
    SF_14_2,SF_14_3,SF_14_5,SF_14_6,...
    LF_14_2,LF_14_3,LF_14_5,LF_14_6);
stats = temprod_freqstats_half([7 14],design,'Tmap_7-14Hz_Mags',...
    SF_14_2,SF_14_3,SF_14_5,SF_14_6,...
    LF_14_2,LF_14_3,LF_14_5,LF_14_6);
stats = temprod_freqstats_half([15 30],design,'Tmap_15-30Hz_Mags',...
    SF_14_2,SF_14_3,SF_14_5,SF_14_6,...
    LF_14_2,LF_14_3,LF_14_5,LF_14_6);
stats = temprod_freqstats_half([30 100],design,'Tmap_30 100Hz_Mags',...
    SF_14_2,SF_14_3,SF_14_5,SF_14_6,...
    LF_14_2,LF_14_3,LF_14_5,LF_14_6);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

temprod_betaERD(3,1,'s14',4,1)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% grand averages %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% temprod_freqGDAVG_half_v2(arrayindex,subject,freqband,tag)
temprod_freqGDAVG_half_v2([2 5    ],'s14',[1 120],'2M_Est_5.7',tag);
temprod_freqGDAVG_half_v2([3 6    ],'s14',[1 120],'2M_Est_8.5',tag);
temprod_freqGDAVG_half_v2([2 3 5 6],'s14',[1 120],'2M_Est_all',tag);
temprod_freqGDAVG_half_v2([4 7    ],'s14',[1 120],'2M_Replay',tag);
temprod_freqGDAVG_half_v2([4      ],'s14',[1 120],'2M_Replay_5.7',tag);
temprod_freqGDAVG_half_v2([  7    ],'s14',[1 120],'2M_Replay_8.5',tag);

temprod_freqGDAVG_half_v3([2 5    ],'s14',[1 120],'2M_Est_5.7',tag);
temprod_freqGDAVG_half_v3([3 6    ],'s14',[1 120],'2M_Est_8.5',tag);
temprod_freqGDAVG_half_v3([2 3 5 6],'s14',[1 120],'2M_Est_all',tag);
temprod_freqGDAVG_half_v3([4 7    ],'s14',[1 120],'2M_Replay',tag);
temprod_freqGDAVG_half_v3([4      ],'s14',[1 120],'2M_Replay_5.7',tag);
temprod_freqGDAVG_half_v3([7      ],'s14',[1 120],'2M_Replay_8.5',tag);

subjects       = {'s14'};
cond            = '2M_Est_5.7';
GDAVG_half_viewer_V2(subjects,[1 7],cond,tag)
cond            = '2M_Est_8.5';
GDAVG_half_viewer_V2(subjects,[1 7],cond,tag)
cond            = '2M_Est_all';
GDAVG_half_viewer_V2(subjects,[1 7],cond,tag)
cond            = '2M_Replay';
GDAVG_half_viewer_V2(subjects,[1 7],cond,tag)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% quarter-cut data grandaverage
temprod_freqGDAVG_quarter_V3([2 5    ],'s14',[1 120],'2M_Est_5.7',tag);
temprod_freqGDAVG_quarter_V3([3 6    ],'s14',[1 120],'2M_Est_8.5',tag);
temprod_freqGDAVG_quarter_V3([2 3 5 6],'s14',[1 120],'2M_Est_all',tag);
temprod_freqGDAVG_quarter_V3([4 7    ],'s14',[1 120],'2M_Replay',tag);
temprod_freqGDAVG_quarter_V3([4      ],'s14',[1 120],'2M_Replay_5.7',tag);
temprod_freqGDAVG_quarter_V3([  7    ],'s14',[1 120],'2M_Replay_8.5',tag);

subjects       = {'s14'};
cond            = '2M_Est_5.7';
GDAVG_quarter_viewer(subjects,[1 120],cond,tag)
cond            = '2M_Est_8.5';
GDAVG_quarter_viewer(subjects,[1 120],cond,tag)
cond            = '2M_Est_all';
GDAVG_quarter_viewer(subjects,[1 120],cond,tag)
cond            = '2M_Replay';
GDAVG_quarter_viewer(subjects,[1 120],cond,tag)

temprod_freqGDAVG_quarter_clusters([2 5    ],'s14',[1 120],'2M_Est_5.7',tag);
temprod_freqGDAVG_quarter_clusters([3 6    ],'s14',[1 120],'2M_Est_8.5',tag);
temprod_freqGDAVG_quarter_clusters([2 3 5 6],'s14',[1 120],'2M_Est_all',tag);
temprod_freqGDAVG_quarter_clusters([4 7    ],'s14',[1 120],'2M_Replay',tag);
temprod_freqGDAVG_quarter_clusters([4      ],'s14',[1 120],'2M_Replay_5.7',tag);
temprod_freqGDAVG_quarter_clusters([  7    ],'s14',[1 120],'2M_Replay_8.5',tag);

f = {[1 7];[7 14];[14 30];[30 120];[1 120]};
for i = 1:length(f)
    subjects       = {'s14'};
    cond            = '2M_Est_5.7';
    GDAVG_quarter_clusters_viewer(subjects,f{i},cond,tag)
    cond            = '2M_Est_8.5';
    GDAVG_quarter_clusters_viewer(subjects,f{i},cond,tag)
    cond            = '2M_Est_all';
    GDAVG_quarter_clusters_viewer(subjects,f{i},cond,tag)
    cond            = '2M_Replay';
    GDAVG_quarter_clusters_viewer(subjects,f{i},cond,tag)
end




