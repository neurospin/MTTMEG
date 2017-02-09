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
subject    = 's13';
[meds13,meAns13,SDs13,meAnnorms13] = temprod_BehaviorSummary(subject,RunNum,fsample,TD,1);

temprod_preproc_jr(2,'s13',1,tag)
temprod_preproc_jr(3,'s13',1,tag)
temprod_preproc_jr(4,'s13',1,tag)
temprod_preproc_jr(5,'s13',1,tag)
temprod_preproc_jr(6,'s13',1,tag)
temprod_preproc_jr(7,'s13',1,tag)
temprod_freqanalysis_jrcw(2,'s13',[1 120],tag)
temprod_freqanalysis_jrcw(3,'s13',[1 120],tag)
temprod_freqanalysis_jrcw(4,'s13',[1 120],tag)
temprod_freqanalysis_jrcw(5,'s13',[1 120],tag)
temprod_freqanalysis_jrcw(6,'s13',[1 120],tag)
temprod_freqanalysis_jrcw(7,'s13',[1 120],tag)
appendspectra_jrcw(2,'s13',[1 120],tag)
appendspectra_jrcw(3,'s13',[1 120],tag)
appendspectra_jrcw(4,'s13',[1 120],tag)
appendspectra_jrcw(5,'s13',[1 120],tag)
appendspectra_jrcw(6,'s13',[1 120],tag)
appendspectra_jrcw(7,'s13',[1 120],tag)
% temprod_dataviewer_jrcw(index,subject,freqband,K,debiasing,interpnoise,chandisplay,savetag,tag)
temprod_dataviewer_jrcw(2,'s13',[40 120],[1 2 3 2 1],0,1,0,1,tag);
temprod_dataviewer_jrcw(3,'s13',[15 40],[1 2 3 2 1],0,1,0,1,tag);
temprod_dataviewer_jrcw(4,'s13',[15 40],[1 2 3 2 1],0,1,0,1,tag);
temprod_dataviewer_jrcw(5,'s13',[15 40],[1 2 3 2 1],0,1,0,1,tag);
temprod_dataviewer_jrcw(6,'s13',[15 40],[1 2 3 2 1],0,1,0,1,tag);
temprod_dataviewer_jrcw(7,'s13',[15 40],[1 2 3 2 1],0,1,0,1,tag);


temprod_preproc_V2(2,1,'s13',4,1)
temprod_preproc_V2(3,1,'s13',4,1)
temprod_preproc_V2(4,1,'s13',4,1)
temprod_preproc_V2(5,1,'s13',4,1)
temprod_preproc_V2(6,1,'s13',4,1)
temprod_preproc_V2(7,1,'s13',4,1)

[Max2,Min2] = temprod_preproc_half(2,1,'s13',4,1,tag);
[Max3,Min3] = temprod_preproc_half(3,1,'s13',4,1,tag);
[Max4,Min4] = temprod_preproc_half(4,1,'s13',4,1,tag);
[Max5,Min5] = temprod_preproc_half(5,1,'s13',4,1,tag);
[Max6,Min6] = temprod_preproc_half(6,1,'s13',4,1,tag);
[Max7,Min7] = temprod_preproc_half(7,1,'s13',4,1,tag);

temprod_preproc_quarter(2,1,'s13',4,1,tag);
temprod_preproc_quarter(3,1,'s13',4,1,tag);
temprod_preproc_quarter(4,1,'s13',4,1,tag);
temprod_preproc_quarter(5,1,'s13',4,1,tag);
temprod_preproc_quarter(6,1,'s13',4,1,tag);
temprod_preproc_quarter(7,1,'s13',4,1,tag);

temprod_freqanalysis_quarter(2,'s13',12600,[1 120],tag)
temprod_freqanalysis_quarter(3,'s13',12600,[1 120],tag)
temprod_freqanalysis_quarter(4,'s13',12600,[1 120],tag)
temprod_freqanalysis_quarter(5,'s13',12600,[1 120],tag)
temprod_freqanalysis_quarter(6,'s13',12600,[1 120],tag)
temprod_freqanalysis_quarter(7,'s13',12600,[1 120],tag)

temprod_preproc_ECG(2,1,'s13',4,1,[1 120])
temprod_preproc_ECG(3,1,'s13',4,1,[1 120])
temprod_preproc_ECG(4,1,'s13',4,1,[1 120])
temprod_preproc_ECG(5,1,'s13',4,1,[1 120])
temprod_preproc_ECG(6,1,'s13',4,1,[1 120])
temprod_preproc_ECG(7,1,'s13',4,1,[1 120])
temprod_dataviewer_ECG(2,'s13',[1 5],[1 2 3 2 1],1,1,1)
temprod_dataviewer_ECG(3,'s13',[1 5],[1 2 3 2 1],1,1,1)
temprod_dataviewer_ECG(4,'s13',[1 5],[1 2 3 2 1],1,1,1)
temprod_dataviewer_ECG(5,'s13',[1 5],[1 2 3 2 1],1,1,1)
temprod_dataviewer_ECG(6,'s13',[1 5],[1 2 3 2 1],1,1,1)
temprod_dataviewer_ECG(7,'s13',[1 5],[1 2 3 2 1],1,1,1)

temprod_preproc_ECG_v2(2,1,'s13',4,1,tag)
temprod_preproc_ECG_v2(3,1,'s13',4,1,tag)
temprod_preproc_ECG_v2(4,1,'s13',4,1,tag)
temprod_preproc_ECG_v2(5,1,'s13',4,1,tag)
temprod_preproc_ECG_v2(6,1,'s13',4,1,tag)
temprod_preproc_ECG_v2(7,1,'s13',4,1,tag)

temprod_freqanalysis(2,'s13',[1 120])
temprod_freqanalysis(3,'s13',[1 120])
temprod_freqanalysis(4,'s13',[1 120])
temprod_freqanalysis(5,'s13',[1 120])
temprod_freqanalysis(6,'s13',[1 120])
temprod_freqanalysis(7,'s13',[1 120])
appendspectra_V2(2,'s13',[1 120])
appendspectra_V2(3,'s13',[1 120])
appendspectra_V2(4,'s13',[1 120])
appendspectra_V2(5,'s13',[1 120])
appendspectra_V2(6,'s13',[1 120])
appendspectra_V2(7,'s13',[1 120])

temprod_dataviewer_V2(2,'s13',[0.5 3],[1 2 3 2 1],1,1,0,1);
temprod_dataviewer_V2(3,'s13',[1 6],[1 2 3 2 1],1,1,0,1);
temprod_dataviewer_V2(4,'s13',[1 6],[1 2 3 2 1],1,1,0,1);
temprod_dataviewer_V2(5,'s13',[1 6],[1 2 3 2 1],1,1,0,1);
temprod_dataviewer_V2(6,'s13',[1 6],[1 2 3 2 1],1,1,0,1);
temprod_dataviewer_V2(7,'s13',[1 6],[1 2 3 2 1],1,1,0,1);

% temprod_dataviewer_accuracy(index,subject,freqband,K,debiasing,interpnoise,chandisplay,target,savetag,tag)
temprod_dataviewer_accuracy(2,'s13',[7 14],[1 2 3 2 1],1,1,0,5700,1,tag);
temprod_dataviewer_accuracy(3,'s13',[7 14],[1 2 3 2 1],1,1,0,8500,1,tag);
temprod_dataviewer_accuracy(4,'s13',[7 14],[1 2 3 2 1],1,1,0,5700,1,tag);
temprod_dataviewer_accuracy(5,'s13',[7 14],[1 2 3 2 1],1,1,0,5700,1,tag);
temprod_dataviewer_accuracy(6,'s13',[7 14],[1 2 3 2 1],1,1,0,8500,1,tag);
temprod_dataviewer_accuracy(7,'s13',[7 14],[1 2 3 2 1],1,1,0,5700,1,tag);

temprod_preproc_ICA(2,1,'s13',4,1)
temprod_preproc_ICA(3,1,'s13',4,1)
temprod_preproc_ICA(4,1,'s13',4,1)
temprod_preproc_ICA(5,1,'s13',4,1)
temprod_preproc_ICA(6,1,'s13',4,1)
temprod_preproc_ICA(7,1,'s13',4,1)

temprod_ICA_V5(2,'s13',[1 120],'runica',15,0.5)
temprod_ICA_V5(3,'s13',[1 120],'runica',15,0.5)
temprod_ICA_V5(4,'s13',[1 120],'runica',15,0.5)
temprod_ICA_V5(5,'s13',[1 120],'runica',15,0.5)
temprod_ICA_V5(6,'s13',[1 120],'runica',15,0.5)
temprod_ICA_V5(7,'s13',[1 120],'runica',15,0.5)

temprod_ICA_viewer(2,'s13',15,[1 30],'runica')
temprod_ICA_viewer(3,'s13',15,[1 30],'runica')
temprod_ICA_viewer(4,'s13',15,[1 30],'runica')
temprod_ICA_viewer(5,'s13',15,[1 30],'runica')
temprod_ICA_viewer(6,'s13',15,[1 30],'runica')
temprod_ICA_viewer(7,'s13',15,[1 30],'runica')

temprod_dataviewer_var([2 3 4 5 6 7],'s13',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var([2 3 4 5 6 7],'s13',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var([2 3 4 5 6 7],'s13',[50 120],0,0,'MEAN','old',1);
temprod_dataviewer_var([2 3 4 5 6 7],'s13',[50 120],0,0,'STD','old',1);

temprod_dataviewer_var_clusters([2 3 4 5 6 7],'s13',[1 6],1,[8 12],'MEAN','old',1);
temprod_dataviewer_var_clusters([2 3 4 5 6 7],'s13',[1 6],1,[8 12],'STD','old',1);
temprod_dataviewer_var_clusters([2 3 4 5 6 7],'s13',[6 15],1,[8 12],'MEAN','old',1);
temprod_dataviewer_var_clusters([2 3 4 5 6 7],'s13',[6 15],1,[8 12],'STD','old',1);
temprod_dataviewer_var_clusters([2 3 4 5 6 7],'s13',[15 30],1,[8 12],'MEAN','old',1);
temprod_dataviewer_var_clusters([2 3 4 5 6 7],'s13',[15 30],1,[8 12],'STD','old',1);
temprod_dataviewer_var_clusters([2 3 4 5 6 7],'s13',[30 120],1,[8 12],'MEAN','old',1);
temprod_dataviewer_var_clusters([2 3 4 5 6 7],'s13',[30 120],1,[8 12],'STD','old',1);

temprod_dataviewer_var_half([2],'s13',[7 14],0,0,'MEAN','old',1);
temprod_dataviewer_var_half([2],'s13',[7 14],0,0,'STD','old',1);
temprod_dataviewer_var_half([3],'s13',[7 14],0,0,'MEAN','old',1);
temprod_dataviewer_var_half([3],'s13',[7 14],0,0,'STD','old',1);
temprod_dataviewer_var_half([4],'s13',[7 14],0,0,'MEAN','old',1);
temprod_dataviewer_var_half([4],'s13',[7 14],0,0,'STD','old',1);
temprod_dataviewer_var_half([5],'s13',[7 14],0,0,'MEAN','old',1);
temprod_dataviewer_var_half([5],'s13',[7 14],0,0,'STD','old',1);
temprod_dataviewer_var_half([6],'s13',[7 14],0,0,'MEAN','old',1);
temprod_dataviewer_var_half([6],'s13',[7 14],0,0,'STD','old',1);
temprod_dataviewer_var_half([7],'s13',[7 14],0,0,'MEAN','old',1);
temprod_dataviewer_var_half([7],'s13',[7 14],0,0,'STD','old',1);

temprod_dataviewer_var_EEG_half([2],'s13',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_EEG_half([2],'s13',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_EEG_half([3],'s13',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_EEG_half([3],'s13',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_EEG_half([4],'s13',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_EEG_half([4],'s13',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_EEG_half([5],'s13',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_EEG_half([5],'s13',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_EEG_half([6],'s13',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_EEG_half([6],'s13',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_EEG_half([7],'s13',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_EEG_half([7],'s13',[1 50],0,0,'STD','old',1);

temprod_dataviewer_var_clusters([2 3 4 5 6 7],'s13',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_clusters([2 3 4 5 6 7],'s13',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_clusters([2 3 4 5 6 7],'s13',[50 120],0,0,'MEAN','old',1);
temprod_dataviewer_var_clusters([2 3 4 5 6 7],'s13',[50 120],0,0,'STD','old',1);

temprod_dataviewer_var_clusters_half([2],'s13',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_clusters_half([2],'s13',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_clusters_half([3],'s13',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_clusters_half([3],'s13',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_clusters_half([4],'s13',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_clusters_half([4],'s13',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_clusters_half([5],'s13',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_clusters_half([5],'s13',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_clusters_half([6],'s13',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_clusters_half([6],'s13',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_clusters_half([7],'s13',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_clusters_half([7],'s13',[1 50],0,0,'STD','old',1);

temprod_tbt_spectra(2,'s13',[1 50],1)
temprod_tbt_spectra(3,'s13',[1 50],1)
temprod_tbt_spectra(4,'s13',[1 50],1)
temprod_tbt_spectra(5,'s13',[1 50],1)
temprod_tbt_spectra(6,'s13',[1 50],1)
temprod_tbt_spectra(7,'s13',[1 50],1)

temprod_freqslope(2,'s13',[30 80],1,'Laptop')
temprod_freqslope(3,'s13',[30 80],1,'Laptop')
temprod_freqslope(4,'s13',[30 80],1,'Laptop')
temprod_freqslope(5,'s13',[30 80],1,'Laptop')
temprod_freqslope(6,'s13',[30 80],1,'Laptop')
temprod_freqslope(7,'s13',[30 80],1,'Laptop')

temprod_freqslope_V2({[2 4];[3 4];[5 7];[6 7]},'s13',[1 4],1)
temprod_freqslope_V2({[2 4];[3 4];[5 7];[6 7]},'s13',[1 7],1)
temprod_freqslope_V2({[2 4];[3 4];[5 7];[6 7]},'s13',[4 7],1)
temprod_freqslope_V2({[2 4];[3 4];[5 7];[6 7]},'s13',[30 80],1)
temprod_freqslope_V2({[2 4];[3 4];[5 7];[6 7]},'s13',[30 120],1)

temprod_FreqPow_corr_allbands_V2(2,'s13')
temprod_FreqPow_corr_allbands_V2(3,'s13')
temprod_FreqPow_corr_allbands_V2(4,'s13')
temprod_FreqPow_corr_allbands_V2(5,'s13')
temprod_FreqPow_corr_allbands_V2(6,'s13')
temprod_FreqPow_corr_allbands_V2(7,'s13')

temprod_freqanalysis_weighted(2,'s13',[1 120],10,0.9)
temprod_freqanalysis_weighted(3,'s13',[1 120],10,0.9)
temprod_freqanalysis_weighted(4,'s13',[1 120],10,0.9)
temprod_freqanalysis_weighted(5,'s13',[1 120],10,0.9)
temprod_freqanalysis_weighted(6,'s13',[1 120],10,0.9)
temprod_freqanalysis_weighted(7,'s13',[1 120],10,0.9)
appendspectra_weighted(2,'s13',[1 120],10,0.9)
appendspectra_weighted(3,'s13',[1 120],10,0.9)
appendspectra_weighted(4,'s13',[1 120],10,0.9)
appendspectra_weighted(5,'s13',[1 120],10,0.9)
appendspectra_weighted(6,'s13',[1 120],10,0.9)
appendspectra_weighted(7,'s13',[1 120],10,0.9)
temprod_tbt_spectra_weighted(2,'s13',[1 120],1,10,0.9)
temprod_tbt_spectra_weighted(3,'s13',[1 120],1,10,0.9)
temprod_tbt_spectra_weighted(4,'s13',[1 120],1,10,0.9)
temprod_tbt_spectra_weighted(5,'s13',[1 120],1,10,0.9)
temprod_tbt_spectra_weighted(6,'s13',[1 120],1,10,0.9)
temprod_tbt_spectra_weighted(7,'s13',[1 120],1,10,0.9)
temprod_freqslope_weighted(2,'s13',[1 4],1,10,0.9)
temprod_freqslope_weighted(3,'s13',[1 4],1,10,0.9)
temprod_freqslope_weighted(4,'s13',[1 4],1,10,0.9)
temprod_freqslope_weighted(5,'s13',[1 4],1,10,0.9)
temprod_freqslope_weighted(6,'s13',[1 4],1,10,0.9)
temprod_freqslope_weighted(7,'s13',[1 4],1,10,0.9)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

bad2 = {'EEG016';'EEG024';'EEG025';'EEG045';'EEG056'};
bad3 = {'EEG024';'EEG025';'EEG032';'EEG045'};
bad4 = {'EEG009';'EEG016';'EEG024';'EEG025';'EEG032';'EEG056';'EEG058'};
bad5 = {'EEG009';'EEG016';'EEG024';'EEG025';'EEG058'};
bad6 = {'EEG009';'EEG016';'EEG024';'EEG025';'EEG030';'EEG032';'EEG045';'EEG058'};
bad7 = {'EEG009';'EEG016';'EEG024';'EEG025';'EEG030';'EEG032';'EEG045';'EEG058'};

flat2 = {'EEG003';'EEG008';'EEG014';'EEG016';'EEG023';'EEG032'};
flat3 = {'EEG003';'EEG008';'EEG013';'EEG014';'EEG023'};
flat4 = {'EEG003';'EEG008';'EEG013';'EEG016';'EEG023'};
flat5 = {'EEG003';'EEG008';'EEG013';'EEG014';'EEG023';'EEG032'};
flat6 = {'EEG003';'EEG008';'EEG013';'EEG014';'EEG023'};
flat7 = {'EEG003';'EEG008';'EEG013';'EEG014';'EEG033'};

temprod_preproc_EEG(2,1,'s13',2,1,[flat2 ; bad2])
temprod_preproc_EEG(3,1,'s13',2,1,[flat3 ; bad3])
temprod_preproc_EEG(4,1,'s13',2,1,[flat4 ; bad4])
temprod_preproc_EEG(5,1,'s13',2,1,[flat5 ; bad5])
temprod_preproc_EEG(6,1,'s13',2,1,[flat6 ; bad6])
temprod_preproc_EEG(7,1,'s13',2,1,[flat7 ; bad7])

temprod_freqanalysis_eeg(0,2,'s13',[1 120])
temprod_freqanalysis_eeg(0,3,'s13',[1 120])
temprod_freqanalysis_eeg(0,4,'s13',[1 120])
temprod_freqanalysis_eeg(0,5,'s13',[1 120])
temprod_freqanalysis_eeg(0,6,'s13',[1 120])
temprod_freqanalysis_eeg(0,7,'s13',[1 120])

appendspectra_EEG(2,'s13',[1 120])
appendspectra_EEG(3,'s13',[1 120])
appendspectra_EEG(4,'s13',[1 120])
appendspectra_EEG(5,'s13',[1 120])
appendspectra_EEG(6,'s13',[1 120])
appendspectra_EEG(7,'s13',[1 120])

temprod_dataviewer_EEG(2,'s13',[30 80],[1 2 1],0,0,0,1)
temprod_dataviewer_EEG(3,'s13',[30 80],[1 2 1],0,0,0,1)
temprod_dataviewer_EEG(4,'s13',[30 80],[1 2 1],0,0,0,1)
temprod_dataviewer_EEG(5,'s13',[30 80],[1 2 1],0,0,0,1)
temprod_dataviewer_EEG(6,'s13',[30 80],[1 2 1],0,0,0,1)
temprod_dataviewer_EEG(7,'s13',[30 80],[1 2 1],0,0,0,1)

temprod_dataviewer_var_EEG([2 3 4 5 6 7],'s13',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_EEG([2 3 4 5 6 7],'s13',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_EEG([2 3 4 5 6 7],'s13',[50 120],0,0,'MEAN','old',1);
temprod_dataviewer_var_EEG([2 3 4 5 6 7],'s13',[50 120],0,0,'STD','old',1);
temprod_dataviewer_var_EEG([2 3 4 5 6 7],'s13',[1 15],0,0,'MEAN','old',1);
temprod_dataviewer_var_EEG([2 3 4 5 6 7],'s13',[1 15],0,0,'STD','old',1);
temprod_dataviewer_var_EEG([2 3 4 5 6 7],'s13',[15 30],0,0,'MEAN','old',1);
temprod_dataviewer_var_EEG([2 3 4 5 6 7],'s13',[15 30],0,0,'STD','old',1);

temprod_preproc_ICA_EEG(2,1,'s13',4,1,[bad2 ; flat2])
temprod_preproc_ICA_EEG(3,1,'s13',4,1,[bad3 ; flat3])
temprod_preproc_ICA_EEG(4,1,'s13',4,1,[bad4 ; flat4])
temprod_preproc_ICA_EEG(5,1,'s13',4,1,[bad5 ; flat5])
temprod_preproc_ICA_EEG(6,1,'s13',4,1,[bad4 ; flat4])
temprod_preproc_ICA_EEG(7,1,'s13',4,1,[bad5 ; flat5])

temprod_ICA_V5_EEG(2,'s13',[1 120],'runica',10,0.5)
temprod_ICA_V5_EEG(3,'s13',[1 120],'runica',10,0.5)
temprod_ICA_V5_EEG(4,'s13',[1 120],'runica',10,0.5)
temprod_ICA_V5_EEG(5,'s13',[1 120],'runica',10,0.5)
temprod_ICA_V5_EEG(6,'s13',[1 120],'runica',10,0.5)
temprod_ICA_V5_EEG(7,'s13',[1 120],'runica',10,0.5)

temprod_ICA_viewer_EEG(2,'s13',10,[2 50])
temprod_ICA_viewer_EEG(3,'s13',10,[2 50])
temprod_ICA_viewer_EEG(4,'s13',10,[2 50])
temprod_ICA_viewer_EEG(5,'s13',10,[2 50])
temprod_ICA_viewer_EEG(6,'s13',10,[2 50])
temprod_ICA_viewer_EEG(7,'s13',10,[2 50])

temprod_tbt_spectra(2,'s13',[1 120],1)
temprod_tbt_spectra(3,'s13',[1 120],1)
temprod_tbt_spectra(4,'s13',[1 120],1)
temprod_tbt_spectra(5,'s13',[1 120],1)
temprod_tbt_spectra(6,'s13',[1 120],1)
temprod_tbt_spectra(7,'s13',[1 120],1)

temprod_freqslope_EEG(2,'s13',[1 4],1)
temprod_freqslope_EEG(3,'s13',[1 4],1)
temprod_freqslope_EEG(4,'s13',[1 4],1)
temprod_freqslope_EEG(5,'s13',[1 4],1)
temprod_freqslope_EEG(6,'s13',[1 4],1)
temprod_freqslope_EEG(7,'s13',[1 4],1)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% STATS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[ST_13_2,LT_13_2,Max_13_2] = temprod_preproc_half(2,1,'s13',4,1);
[ST_13_3,LT_13_3,Max_13_3] = temprod_preproc_half(3,1,'s13',4,1);
[ST_13_5,LT_13_5,Max_13_5] = temprod_preproc_half(5,1,'s13',4,1);
[ST_13_6,LT_13_6,Max_13_6] = temprod_preproc_half(6,1,'s13',4,1);

M = max([Max_13_2 Max_13_3 Max_13_5 Max_13_6]);

[SF_13_2,LF_13_2]          = temprod_freqanalysis_half(ST_13_2,LT_13_2,M,[1 100]);
[SF_13_3,LF_13_3]          = temprod_freqanalysis_half(ST_13_3,LT_13_3,M,[1 100]);
[SF_13_5,LF_13_5]          = temprod_freqanalysis_half(ST_13_5,LT_13_5,M,[1 100]);
[SF_13_6,LF_13_6]          = temprod_freqanalysis_half(ST_13_6,LT_13_6,M,[1 100]);

design = [1 1 1 1 2 2 2 2; 1 2 3 4 1 2 3 4];

stats = temprod_freqstats_half([1 7],design,'s13_Tmap_1-4Hz_Mags',...
    SF_13_2,SF_13_3,SF_13_5,SF_13_6,...
    LF_13_2,LF_13_3,LF_13_5,LF_13_6);
stats = temprod_freqstats_half([4 7],design,'s13_Tmap_4-7Hz_Mags',...
    SF_13_2,SF_13_3,SF_13_5,SF_13_6,...
    LF_13_2,LF_13_3,LF_13_5,LF_13_6);
stats = temprod_freqstats_half([1 7],design,'s13_Tmap_1-7Hz_Mags',...
    SF_13_2,SF_13_3,SF_13_5,SF_13_6,...
    LF_13_2,LF_13_3,LF_13_5,LF_13_6);
stats = temprod_freqstats_half([7 14],design,'s13_Tmap_7-14Hz_Mags',...
    SF_13_2,SF_13_3,SF_13_5,SF_13_6,...
    LF_13_2,LF_13_3,LF_13_5,LF_13_6);
stats = temprod_freqstats_half([15 30],design,'s13_Tmap_15-30Hz_Mags',...
    SF_13_2,SF_13_3,SF_13_5,SF_13_6,...
    LF_13_2,LF_13_3,LF_13_5,LF_13_6);
stats = temprod_freqstats_half([30 100],design,'s13_Tmap_30 100Hz_Mags',...
    SF_13_2,SF_13_3,SF_13_5,SF_13_6,...
    LF_13_2,LF_13_3,LF_13_5,LF_13_6);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% grand averages %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% temprod_freqGDAVG_half_v2(arrayindex,subject,freqband,tag)
temprod_freqGDAVG_half_v2([2 5    ],'s13',[1 120],'2M_Est_5.7',tag);
temprod_freqGDAVG_half_v2([3 6    ],'s13',[1 120],'2M_Est_8.5',tag);
temprod_freqGDAVG_half_v2([2 3 5 6],'s13',[1 120],'2M_Est_all',tag);
temprod_freqGDAVG_half_v2([4 7    ],'s13',[1 120],'2M_Replay',tag);
temprod_freqGDAVG_half_v2([4      ],'s13',[1 120],'2M_Replay_5.7',tag);
temprod_freqGDAVG_half_v2([  7    ],'s13',[1 120],'2M_Replay_8.5',tag);

temprod_freqGDAVG_half_v3([2 5    ],'s13',[1 120],'2M_Est_5.7',tag);
temprod_freqGDAVG_half_v3([3 6    ],'s13',[1 120],'2M_Est_8.5',tag);
temprod_freqGDAVG_half_v3([2 3 5 6],'s13',[1 120],'2M_Est_all',tag);
temprod_freqGDAVG_half_v3([4 7    ],'s13',[1 120],'2M_Replay',tag);
temprod_freqGDAVG_half_v3([4      ],'s13',[1 120],'2M_Replay_5.7',tag);
temprod_freqGDAVG_half_v3([7      ],'s13',[1 120],'2M_Replay_8.5',tag);

subjects       = {'s13'};
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
temprod_freqGDAVG_quarter_V3([2 5    ],'s13',[1 120],'2M_Est_5.7',tag);
temprod_freqGDAVG_quarter_V3([3 6    ],'s13',[1 120],'2M_Est_8.5',tag);
temprod_freqGDAVG_quarter_V3([2 3 5 6],'s13',[1 120],'2M_Est_all',tag);
temprod_freqGDAVG_quarter_V3([4 7    ],'s13',[1 120],'2M_Replay',tag);
temprod_freqGDAVG_quarter_V3([4      ],'s13',[1 120],'2M_Replay_5.7',tag);
temprod_freqGDAVG_quarter_V3([  7    ],'s13',[1 120],'2M_Replay_8.5',tag);

subjects       = {'s13'};
cond            = '2M_Est_5.7';
GDAVG_quarter_viewer(subjects,[1 120],cond,tag)
cond            = '2M_Est_8.5';
GDAVG_quarter_viewer(subjects,[1 120],cond,tag)
cond            = '2M_Est_all';
GDAVG_quarter_viewer(subjects,[1 120],cond,tag)
cond            = '2M_Replay';
GDAVG_quarter_viewer(subjects,[1 120],cond,tag)

temprod_freqGDAVG_quarter_clusters([2 5    ],'s13',[1 120],'2M_Est_5.7',tag);
temprod_freqGDAVG_quarter_clusters([3 6    ],'s13',[1 120],'2M_Est_8.5',tag);
temprod_freqGDAVG_quarter_clusters([2 3 5 6],'s13',[1 120],'2M_Est_all',tag);
temprod_freqGDAVG_quarter_clusters([4 7    ],'s13',[1 120],'2M_Replay',tag);
temprod_freqGDAVG_quarter_clusters([4      ],'s13',[1 120],'2M_Replay_5.7',tag);
temprod_freqGDAVG_quarter_clusters([  7    ],'s13',[1 120],'2M_Replay_8.5',tag);

f = {[1 7];[7 14];[14 30];[30 120];[1 120]};
for i = 1:length(f)
    subjects       = {'s13'};
    cond            = '2M_Est_5.7';
    GDAVG_quarter_clusters_viewer(subjects,f{i},cond,tag)
    cond            = '2M_Est_8.5';
    GDAVG_quarter_clusters_viewer(subjects,f{i},cond,tag)
    cond            = '2M_Est_all';
    GDAVG_quarter_clusters_viewer(subjects,f{i},cond,tag)
    cond            = '2M_Replay';
    GDAVG_quarter_clusters_viewer(subjects,f{i},cond,tag)
end
