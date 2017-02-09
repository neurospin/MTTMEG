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
subject    = 's07';
[meds07,meAns07,SDs07,meAnnorms07] = temprod_BehaviorSummary_s07(subject,RunNum,fsample,TD,1);

temprod_preproc_jr(1,'s07',1,'nocorr',tag)
temprod_preproc_jr(2,'s07',1,'nocorr',tag)
temprod_preproc_jr(3,'s07',1,'ecg&eog',tag)
temprod_preproc_jr(4,'s07',1,'ecg&eog',tag)
temprod_preproc_jr(5,'s07',1,'ecg&eog',tag)
temprod_preproc_jr(6,'s07',1,'ecg&eog',tag)
temprod_freqanalysis_jrcw(1,'s07',[1 120],tag)
temprod_freqanalysis_jrcw(2,'s07',[1 120],tag)
temprod_freqanalysis_jrcw(3,'s07',[1 120],tag)
temprod_freqanalysis_jrcw(4,'s07',[1 120],tag)
temprod_freqanalysis_jrcw(5,'s07',[1 120],tag)
temprod_freqanalysis_jrcw(6,'s07',[1 120],tag)
appendspectra_jrcw(1,'s07',[1 120],tag)
appendspectra_jrcw(2,'s07',[1 120],tag)
appendspectra_jrcw(3,'s07',[1 120],tag)
appendspectra_jrcw(4,'s07',[1 120],tag)
appendspectra_jrcw(5,'s07',[1 120],tag)
appendspectra_jrcw(6,'s07',[1 120],tag)
% temprod_dataviewer_jrcw(index,subject,freqband,K,debiasing,interpnoise,chandisplay,savetag,tag)
temprod_dataviewer_jrcw(1,'s07',[15 40],[1 2 3 2 1],0,1,0,1,tag);
temprod_dataviewer_jrcw(2,'s07',[40 120],[1 2 3 2 1],0,1,0,1,tag);
temprod_dataviewer_jrcw(3,'s07',[15 40],[1 2 3 2 1],0,1,0,1,tag);
temprod_dataviewer_jrcw(4,'s07',[15 40],[1 2 3 2 1],0,1,0,1,tag);
temprod_dataviewer_jrcw(5,'s07',[15 40],[1 2 3 2 1],0,1,0,1,tag);
temprod_dataviewer_jrcw(6,'s07',[15 40],[1 2 3 2 1],0,1,0,1,tag);


temprod_preproc_V2(1,1,'s07',4,1)
temprod_preproc_V2(2,1,'s07',4,1)
temprod_preproc_V2(3,1,'s07',4,1)
temprod_preproc_V2(4,1,'s07',4,1)
temprod_preproc_V2(5,1,'s07',4,1)
temprod_preproc_V2(6,1,'s07',4,1)

[Max1,Min1] = temprod_preproc_half(1,1,'s07',4,1,tag);
[Max2,Min2] = temprod_preproc_half(2,1,'s07',4,1,tag);
[Max3,Min3] = temprod_preproc_half(3,1,'s07',4,1,tag);
[Max4,Min4] = temprod_preproc_half(4,1,'s07',4,1,tag);
[Max5,Min5] = temprod_preproc_half(5,1,'s07',4,1,tag);
[Max6,Min6] = temprod_preproc_half(6,1,'s07',4,1,tag);

temprod_preproc_quarter(1,1,'s07',4,1,tag);
temprod_preproc_quarter(2,1,'s07',4,1,tag);
temprod_preproc_quarter(3,1,'s07',4,1,tag);
temprod_preproc_quarter(4,1,'s07',4,1,tag);
temprod_preproc_quarter(5,1,'s07',4,1,tag);
temprod_preproc_quarter(6,1,'s07',4,1,tag);

temprod_freqanalysis_quarter(2,'s07',12600,[1 120],tag)
temprod_freqanalysis_quarter(3,'s07',12600,[1 120],tag)
temprod_freqanalysis_quarter(4,'s07',12600,[1 120],tag)
temprod_freqanalysis_quarter(5,'s07',12600,[1 120],tag)
temprod_freqanalysis_quarter(6,'s07',12600,[1 120],tag)
temprod_freqanalysis_quarter(1,'s07',12600,[1 120],tag)

temprod_freqanalysis(1,'s07',[1 120])
temprod_freqanalysis(2,'s07',[1 120])
temprod_freqanalysis(3,'s07',[1 120])
temprod_freqanalysis(4,'s07',[1 120])
temprod_freqanalysis(5,'s07',[1 120])
temprod_freqanalysis(6,'s07',[1 120])
appendspectra_V2(1,'s07',[1 120])
appendspectra_V2(2,'s07',[1 120])
appendspectra_V2(3,'s07',[1 120])
appendspectra_V2(4,'s07',[1 120])
appendspectra_V2(5,'s07',[1 120])
appendspectra_V2(6,'s07',[1 120])

temprod_preproc_ECG(2,1,'s07',4,1,[1 120])
temprod_preproc_ECG(3,1,'s07',4,1,[1 120])
temprod_preproc_ECG(4,1,'s07',4,1,[1 120])
temprod_preproc_ECG(5,1,'s07',4,1,[1 120])
temprod_preproc_ECG(6,1,'s07',4,1,[1 120])
temprod_preproc_ECG(7,1,'s07',4,1,[1 120])
temprod_dataviewer_ECG(2,'s07',[1 5],[1 2 3 2 1],1,1,1)
temprod_dataviewer_ECG(3,'s07',[1 5],[1 2 3 2 1],1,1,1)
temprod_dataviewer_ECG(4,'s07',[1 5],[1 2 3 2 1],1,1,1)
temprod_dataviewer_ECG(5,'s07',[1 5],[1 2 3 2 1],1,1,1)
temprod_dataviewer_ECG(6,'s07',[1 5],[1 2 3 2 1],1,1,1)
temprod_dataviewer_ECG(7,'s07',[1 5],[1 2 3 2 1],1,1,1)

temprod_preproc_ECG_v2(2,1,'s07',4,1,tag)
temprod_preproc_ECG_v2(3,1,'s07',4,1,tag)
temprod_preproc_ECG_v2(4,1,'s07',4,1,tag)
temprod_preproc_ECG_v2(5,1,'s07',4,1,tag)
temprod_preproc_ECG_v2(6,1,'s07',4,1,tag)
temprod_preproc_ECG_v2(7,1,'s07',4,1,tag)

temprod_dataviewer(1,'s07',[15 30],[1 2 1],0,0,0,1);
temprod_dataviewer(2,'s07',[15 30],[1 2 1],0,0,0,1);
temprod_dataviewer(3,'s07',[15 30],[1 2 1],0,0,0,1);
temprod_dataviewer(4,'s07',[15 30],[1 2 1],0,0,0,1);
temprod_dataviewer(5,'s07',[15 30],[1 2 1],0,0,0,1);
temprod_dataviewer(6,'s07',[15 30],[1 2 1],0,0,0,1);

temprod_dataviewer_accuracy(1,'s07',[7 15],[1 2 3 2 1],1,1,0,8500,1,tag);
temprod_dataviewer_accuracy(2,'s07',[7 15],[1 2 3 2 1],1,1,0,5700,1,tag);
temprod_dataviewer_accuracy(3,'s07',[7 15],[1 2 3 2 1],1,1,0,8500,1,tag);
temprod_dataviewer_accuracy(4,'s07',[7 15],[1 2 3 2 1],1,1,0,5700,1,tag);
temprod_dataviewer_accuracy(5,'s07',[7 15],[1 2 3 2 1],1,1,0,5700,1,tag);
temprod_dataviewer_accuracy(6,'s07',[7 15],[1 2 3 2 1],1,1,0,8500,1,tag);

temprod_preproc_ICA_s07(2,1,'s07',4,1)
temprod_preproc_ICA_s07(3,1,'s07',4,1)
temprod_preproc_ICA_s07(4,1,'s07',4,1)
temprod_preproc_ICA_s07(5,1,'s07',4,1)
temprod_preproc_ICA_s07(6,1,'s07',4,1)
temprod_preproc_ICA_s07(7,1,'s07',4,1)

temprod_ICA_V5(2,'s07',[1 120],'runica',15,0.5)
temprod_ICA_V5(3,'s07',[1 120],'runica',15,0.5)
temprod_ICA_V5(4,'s07',[1 120],'runica',15,0.5)
temprod_ICA_V5(5,'s07',[1 120],'runica',15,0.5)
temprod_ICA_V5(6,'s07',[1 120],'runica',15,0.5)
temprod_ICA_V5(7,'s07',[1 120],'runica',15,0.5)

temprod_ICA_viewer(2,'s07',15,[1 30],'runica')
temprod_ICA_viewer(3,'s07',15,[1 30],'runica')
temprod_ICA_viewer(4,'s07',15,[1 30],'runica')
temprod_ICA_viewer(5,'s07',15,[1 30],'runica')
temprod_ICA_viewer(6,'s07',15,[1 30],'runica')
temprod_ICA_viewer(7,'s07',15,[1 30],'runica')

temprod_dataviewer_var_clusters([1 2 3 4 5 6 ],'s07',[1 6],1,[8 12],'MEAN','old',1);
temprod_dataviewer_var_clusters([1 2 3 4 5 6 ],'s07',[1 6],1,[8 12],'STD','old',1);
temprod_dataviewer_var_clusters([1 2 3 4 5 6 ],'s07',[6 15],1,[8 12],'MEAN','old',1);
temprod_dataviewer_var_clusters([1 2 3 4 5 6 ],'s07',[6 15],1,[8 12],'STD','old',1);
temprod_dataviewer_var_clusters([1 2 3 4 5 6 ],'s07',[15 30],1,[8 12],'MEAN','old',1);
temprod_dataviewer_var_clusters([1 2 3 4 5 6 ],'s07',[15 30],1,[8 12],'STD','old',1);
temprod_dataviewer_var_clusters([1 2 3 4 5 6 ],'s07',[30 120],1,[8 12],'MEAN','old',1);
temprod_dataviewer_var_clusters([1 2 3 4 5 6 ],'s07',[30 120],1,[8 12],'STD','old',1);

temprod_dataviewer_var_half([1],'s07',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_half([1],'s07',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_half([2],'s07',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_half([2],'s07',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_half([3],'s07',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_half([3],'s07',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_half([4],'s07',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_half([4],'s07',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_half([5],'s07',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_half([5],'s07',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_half([6],'s07',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_half([6],'s07',[1 50],0,0,'STD','old',1);

temprod_dataviewer_var_clusters([2 3 4 5 6 7],'s07',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_clusters([2 3 4 5 6 7],'s07',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_clusters([2 3 4 5 6 7],'s07',[50 120],0,0,'MEAN','old',1);
temprod_dataviewer_var_clusters([2 3 4 5 6 7],'s07',[50 120],0,0,'STD','old',1);

temprod_freqslope(1,'s07',[30 80],1,'Laptop')
temprod_freqslope(2,'s07',[30 80],1,'Laptop')
temprod_freqslope(3,'s07',[30 80],1,'Laptop')
temprod_freqslope(4,'s07',[30 80],1,'Laptop')
temprod_freqslope(5,'s07',[30 80],1,'Laptop')
temprod_freqslope(6,'s07',[30 80],1,'Laptop')

temprod_freqslope_V2({[1 3];[2 3];[4 6];[5 6]},'s07',[1 4],1)
temprod_freqslope_V2({[1 3];[2 3];[4 6];[5 6]},'s07',[1 7],1)
temprod_freqslope_V2({[1 3];[2 3];[4 6];[5 6]},'s07',[4 7],1)
temprod_freqslope_V2({[1 3];[2 3];[4 6];[5 6]},'s07',[30 80],1)
temprod_freqslope_V2({[1 3];[2 3];[4 6];[5 6]},'s07',[30 120],1)

temprod_FreqPow_corr_allbands_V2(1,'s07')
temprod_FreqPow_corr_allbands_V2(2,'s07')
temprod_FreqPow_corr_allbands_V2(3,'s07')
temprod_FreqPow_corr_allbands_V2(4,'s07')
temprod_FreqPow_corr_allbands_V2(5,'s07')
temprod_FreqPow_corr_allbands_V2(6,'s07')

temprod_freqanalysis_weighted(2,'s07',[1 120],10,0.9)
temprod_freqanalysis_weighted(3,'s07',[1 120],10,0.9)
temprod_freqanalysis_weighted(4,'s07',[1 120],10,0.9)
temprod_freqanalysis_weighted(5,'s07',[1 120],10,0.9)
temprod_freqanalysis_weighted(6,'s07',[1 120],10,0.9)
temprod_freqanalysis_weighted(7,'s07',[1 120],10,0.9)
appendspectra_weighted(2,'s07',[1 120],10,0.9)
appendspectra_weighted(3,'s07',[1 120],10,0.9)
appendspectra_weighted(4,'s07',[1 120],10,0.9)
appendspectra_weighted(5,'s07',[1 120],10,0.9)
appendspectra_weighted(6,'s07',[1 120],10,0.9)
appendspectra_weighted(7,'s07',[1 120],10,0.9)
temprod_tbt_spectra_weighted(2,'s07',[1 120],1,10,0.9)
temprod_tbt_spectra_weighted(3,'s07',[1 120],1,10,0.9)
temprod_tbt_spectra_weighted(4,'s07',[1 120],1,10,0.9)
temprod_tbt_spectra_weighted(5,'s07',[1 120],1,10,0.9)
temprod_tbt_spectra_weighted(6,'s07',[1 120],1,10,0.9)
temprod_tbt_spectra_weighted(7,'s07',[1 120],1,10,0.9)
temprod_freqslope_weighted(2,'s07',[1 4],1,10,0.9)
temprod_freqslope_weighted(3,'s07',[1 4],1,10,0.9)
temprod_freqslope_weighted(4,'s07',[1 4],1,10,0.9)
temprod_freqslope_weighted(5,'s07',[1 4],1,10,0.9)
temprod_freqslope_weighted(6,'s07',[1 4],1,10,0.9)
temprod_freqslope_weighted(7,'s07',[1 4],1,10,0.9)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% grand averages %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% temprod_freqGDAVG_half_v2(arrayindex,subject,freqband,tag)
temprod_freqGDAVG_half_v2([1 4    ],'s07',[1 120],'2M_Est_5.7',tag);
temprod_freqGDAVG_half_v2([2 5    ],'s07',[1 120],'2M_Est_8.5',tag);
temprod_freqGDAVG_half_v2([1 2 4 5],'s07',[1 120],'2M_Est_all',tag);
temprod_freqGDAVG_half_v2([3 6    ],'s07',[1 120],'2M_Replay',tag);
temprod_freqGDAVG_half_v2([3      ],'s07',[1 120],'2M_Replay_5.7',tag);
temprod_freqGDAVG_half_v2([6      ],'s07',[1 120],'2M_Replay_8.5',tag);

temprod_freqGDAVG_half_v3([1 4    ],'s07',[1 120],'2M_Est_5.7',tag);
temprod_freqGDAVG_half_v3([2 5    ],'s07',[1 120],'2M_Est_8.5',tag);
temprod_freqGDAVG_half_v3([1 2 4 5],'s07',[1 120],'2M_Est_all',tag);
temprod_freqGDAVG_half_v3([3 6    ],'s07',[1 120],'2M_Replay',tag);
temprod_freqGDAVG_half_v3([3      ],'s07',[1 120],'2M_Replay_5.7',tag);
temprod_freqGDAVG_half_v3([6      ],'s07',[1 120],'2M_Replay_8.5',tag);

subjects       = {'s07'};
cond            = '2M_Est_5.7';
GDAVG_half_viewer_V2(subjects,[1 7],cond,tag)
cond            = '2M_Est_8.5';
GDAVG_half_viewer_V2(subjects,[1 7],cond,tag)
cond            = '2M_Est_all';
GDAVG_half_viewer_V2(subjects,[1 7],cond,tag)
cond            = '2M_Replay';
GDAVG_half_viewer_V2(subjects,[1 7],cond,tag)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
temprod_freqGDAVG_quarter_V3([1 4    ],'s07',[1 120],'2M_Est_5.7',tag);
temprod_freqGDAVG_quarter_V3([2 5    ],'s07',[1 120],'2M_Est_8.5',tag);
temprod_freqGDAVG_quarter_V3([1 2 4 5],'s07',[1 120],'2M_Est_all',tag);
temprod_freqGDAVG_quarter_V3([3 6    ],'s07',[1 120],'2M_Replay',tag);
temprod_freqGDAVG_quarter_V3([3      ],'s07',[1 120],'2M_Replay_5.7',tag);
temprod_freqGDAVG_quarter_V3([6      ],'s07',[1 120],'2M_Replay_8.5',tag);

subjects       = {'s07'};
cond            = '2M_Est_5.7';
GDAVG_quarter_viewer(subjects,[1 120],cond,tag)
cond            = '2M_Est_8.5';
GDAVG_quarter_viewer(subjects,[1 120],cond,tag)
cond            = '2M_Est_all';
GDAVG_quarter_viewer(subjects,[1 120],cond,tag)
cond            = '2M_Replay';
GDAVG_quarter_viewer(subjects,[1 120],cond,tag)
