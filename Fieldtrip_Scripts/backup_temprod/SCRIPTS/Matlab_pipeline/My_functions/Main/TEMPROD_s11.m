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
RunNum     = 2:5;
fsample    = [1 1 1 1]*1000; 
TD         = [5.7 8.5 5.7 5.7];  
subject    = 's11';
[meds11,meAns11,SDs11,meAnnorms11] = temprod_BehaviorSummary(subject,RunNum,fsample,TD,1);

temprod_preproc_jr(2,'s11',1,tag)
temprod_preproc_jr(3,'s11',1,tag)
temprod_preproc_jr(4,'s11',1,tag)
temprod_preproc_jr(5,'s11',1,tag)
temprod_freqanalysis_jrcw(2,'s11',[1 120],tag)
temprod_freqanalysis_jrcw(3,'s11',[1 120],tag)
temprod_freqanalysis_jrcw(4,'s11',[1 120],tag)
temprod_freqanalysis_jrcw(5,'s11',[1 120],tag)
appendspectra_jrcw(2,'s11',[1 120],tag)
appendspectra_jrcw(3,'s11',[1 120],tag)
appendspectra_jrcw(4,'s11',[1 120],tag)
appendspectra_jrcw(5,'s11',[1 120],tag)
% temprod_dataviewer_jrcw(index,subject,freqband,K,debiasing,interpnoise,chandisplay,savetag,tag)
temprod_dataviewer_jrcw(2,'s11',[40 120],[1 2 3 2 1],0,1,0,1,tag);
temprod_dataviewer_jrcw(3,'s11',[15 40],[1 2 3 2 1],0,1,0,1,tag);
temprod_dataviewer_jrcw(4,'s11',[15 40],[1 2 3 2 1],0,1,0,1,tag);
temprod_dataviewer_jrcw(5,'s11',[15 40],[1 2 3 2 1],0,1,0,1,tag);

temprod_preproc_V2(2,1,'s11',4,1)
temprod_preproc_V2(3,1,'s11',4,1)
temprod_preproc_V2(4,1,'s11',4,1)
temprod_preproc_V2(5,1,'s11',4,1)

[Max2,Min2] = temprod_preproc_half(2,1,'s11',4,1,tag);
[Max3,Min3] = temprod_preproc_half(3,1,'s11',4,1,tag);
[Max4,Min4] = temprod_preproc_half(4,1,'s11',4,1,tag);
[Max5,Min5] = temprod_preproc_half(5,1,'s11',4,1,tag);

temprod_preproc_quarter(2,1,'s11',4,1,tag);
temprod_preproc_quarter(3,1,'s11',4,1,tag);
temprod_preproc_quarter(4,1,'s11',4,1,tag);
temprod_preproc_quarter(5,1,'s11',4,1,tag);

temprod_freqanalysis_quarter(2,'s11',12600,[1 120],tag)
temprod_freqanalysis_quarter(3,'s11',12600,[1 120],tag)
temprod_freqanalysis_quarter(4,'s11',12600,[1 120],tag)
temprod_freqanalysis_quarter(5,'s11',12600,[1 120],tag)

temprod_freqanalysis(2,'s11',[1 120])
temprod_freqanalysis(3,'s11',[1 120])
temprod_freqanalysis(4,'s11',[1 120])
temprod_freqanalysis(5,'s11',[1 120])
appendspectra_V2(2,'s11',[1 120])
appendspectra_V2(3,'s11',[1 120])
appendspectra_V2(4,'s11',[1 120])
appendspectra_V2(5,'s11',[1 120])

temprod_preproc_ECG(2,1,'s11',4,1,[1 120])
temprod_preproc_ECG(3,1,'s11',4,1,[1 120])
temprod_preproc_ECG(4,1,'s11',4,1,[1 120])
temprod_preproc_ECG(5,1,'s11',4,1,[1 120])
temprod_dataviewer_ECG(2,'s11',[1 5],[1 2 3 2 1],1,1,1)
temprod_dataviewer_ECG(3,'s11',[1 5],[1 2 3 2 1],1,1,1)
temprod_dataviewer_ECG(4,'s11',[1 5],[1 2 3 2 1],1,1,1)
temprod_dataviewer_ECG(5,'s11',[1 5],[1 2 3 2 1],1,1,1)

temprod_preproc_ECG_v2(2,1,'s11',4,1,tag)
temprod_preproc_ECG_v2(3,1,'s11',4,1,tag)
temprod_preproc_ECG_v2(4,1,'s11',4,1,tag)
temprod_preproc_ECG_v2(5,1,'s11',4,1,tag)

temprod_dataviewer_V2(2,'s11',[1 6],[1 2 3 2 1],1,[8 12],1,1,1);
temprod_dataviewer_V2(3,'s11',[1 6],[1 2 3 2 1],1,[8 12],1,1,1);
temprod_dataviewer_V2(4,'s11',[1 6],[1 2 3 2 1],1,[8 12],1,1,1);
temprod_dataviewer_V2(5,'s11',[1 6],[1 2 3 2 1],1,[8 12],1,1,1);

% temprod_dataviewer_accuracy(index,subject,freqband,K,debiasing,interpnoise,chandisplay,target,savetag,tag)
temprod_dataviewer_accuracy(2,'s11',[7 14],[1 2 3 2 1],1,1,0,5700,1,tag);
temprod_dataviewer_accuracy(3,'s11',[7 14],[1 2 3 2 1],1,1,0,8500,1,tag);
temprod_dataviewer_accuracy(4,'s11',[7 14],[1 2 3 2 1],1,1,0,5700,1,tag);
temprod_dataviewer_accuracy(5,'s11',[7 14],[1 2 3 2 1],1,1,0,5700,1,tag);

temprod_preproc_ICA(2,1,'s11',4,1)
temprod_preproc_ICA(3,1,'s11',4,1)
temprod_preproc_ICA(4,1,'s11',4,1)
temprod_preproc_ICA(5,1,'s11',4,1)

temprod_ICA_V5(2,'s11',[1 120],'runica',15,0.5)
temprod_ICA_V5(3,'s11',[1 120],'runica',15,0.5)
temprod_ICA_V5(4,'s11',[1 120],'runica',15,0.5)
temprod_ICA_V5(5,'s11',[1 120],'runica',15,0.5)

temprod_ICA_viewer(2,'s11',15,[1 30],'runica')
temprod_ICA_viewer(3,'s11',15,[1 30],'runica')
temprod_ICA_viewer(4,'s11',15,[1 30],'runica')
temprod_ICA_viewer(5,'s11',15,[1 30],'runica')

temprod_dataviewer_var([2 3 4 5],'s11',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var([2 3 4 5],'s11',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var([2 3 4 5],'s11',[50 120],0,0,'MEAN','old',1);
temprod_dataviewer_var([2 3 4 5],'s11',[50 120],0,0,'STD','old',1);

temprod_dataviewer_var_half([2],'s11',[7 14],0,0,'MEAN','old',1);
temprod_dataviewer_var_half([2],'s11',[7 14],0,0,'STD','old',1);
temprod_dataviewer_var_half([3],'s11',[7 14],0,0,'MEAN','old',1);
temprod_dataviewer_var_half([3],'s11',[7 14],0,0,'STD','old',1);
temprod_dataviewer_var_half([4],'s11',[7 14],0,0,'MEAN','old',1);
temprod_dataviewer_var_half([4],'s11',[7 14],0,0,'STD','old',1);
temprod_dataviewer_var_half([5],'s11',[7 14],0,0,'MEAN','old',1);
temprod_dataviewer_var_half([5],'s11',[7 14],0,0,'STD','old',1);

temprod_dataviewer_var_EEG_half([2],'s11',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_EEG_half([2],'s11',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_EEG_half([3],'s11',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_EEG_half([3],'s11',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_EEG_half([4],'s11',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_EEG_half([4],'s11',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_EEG_half([5],'s11',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_EEG_half([5],'s11',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_EEG_half([6],'s11',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_EEG_half([6],'s11',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_EEG_half([7],'s11',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_EEG_half([7],'s11',[1 50],0,0,'STD','old',1);

temprod_dataviewer_var_clusters([2 3 4 5],'s11',[1 6],1,[8 12],'MEAN','old',1);
temprod_dataviewer_var_clusters([2 3 4 5],'s11',[1 6],1,[8 12],'STD','old',1);
temprod_dataviewer_var_clusters([2 3 4 5],'s11',[6 15],1,[8 12],'MEAN','old',1);
temprod_dataviewer_var_clusters([2 3 4 5],'s11',[6 15],1,[8 12],'STD','old',1);
temprod_dataviewer_var_clusters([2 3 4 5],'s11',[15 30],1,[8 12],'MEAN','old',1);
temprod_dataviewer_var_clusters([2 3 4 5],'s11',[15 30],1,[8 12],'STD','old',1);
temprod_dataviewer_var_clusters([2 3 4 5],'s11',[30 120],1,[8 12],'MEAN','old',1);
temprod_dataviewer_var_clusters([2 3 4 5],'s11',[30 120],1,[8 12],'STD','old',1);

temprod_dataviewer_var_clusters_half([2],'s11',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_clusters_half([2],'s11',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_clusters_half([3],'s11',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_clusters_half([3],'s11',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_clusters_half([4],'s11',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_clusters_half([4],'s11',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_clusters_half([5],'s11',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_clusters_half([5],'s11',[1 50],0,0,'STD','old',1);

temprod_tbt_spectra(2,'s11',[1 50],1)
temprod_tbt_spectra(3,'s11',[1 120],1)
temprod_tbt_spectra(4,'s11',[1 120],1)
temprod_tbt_spectra(5,'s11',[1 120],1)

temprod_freqslope(2,'s11',[30 80],1,'Laptop')
temprod_freqslope(3,'s11',[30 80],1,'Laptop')
temprod_freqslope(4,'s11',[30 80],1,'Laptop')
temprod_freqslope(5,'s11',[30 80],1,'Laptop')

temprod_freqslope_V2({[2 4];[3 4]},'s11',[1 4],1)
temprod_freqslope_V2({[2 4];[3 4]},'s11',[1 7],1)
temprod_freqslope_V2({[2 4];[3 4]},'s11',[4 7],1)
temprod_freqslope_V2({[2 4];[3 4]},'s11',[30 80],1)
temprod_freqslope_V2({[2 4];[3 4]},'s11',[30 120],1)

temprod_FreqPow_corr_allbands_V2(2,'s11')
temprod_FreqPow_corr_allbands_V2(3,'s11')
temprod_FreqPow_corr_allbands_V2(4,'s11')
temprod_FreqPow_corr_allbands_V2(5,'s11')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% bad channels EEG
bad1 = {'EEG013';'EEG025';'EEG032';'EEG037';'EEG046';'EEG056'};
bad2 = {'EEG025';'EEG028';'EEG037';'EEG046';'EEG056'};
bad3 = {'EEG013';'EEG037';'EEG046';'EEG056';'EEG025'};
bad4 = {'EEG013';'EEG028';'EEG037';'EEG056'};

flat1 = {'EEG003';'EEG008';'EEG014';'EEG023';'EEG024';'EEG028';'EEG052'};
flat2 = {'EEG003';'EEG008';'EEG014';'EEG023';'EEG024';'EEG032';'EEG052'};
flat3 = {'EEG003';'EEG008';'EEG014';'EEG023';'EEG024';'EEG028';'EEG032';'EEG058'};
flat4 = {'EEG003';'EEG008';'EEG014';'EEG023';'EEG024';'EEG032';'EEG058'};

temprod_preproc_EEG(2,1,'s11',2,1,[bad1 ; flat1])
temprod_preproc_EEG(3,1,'s11',2,1,[bad2 ; flat2])
temprod_preproc_EEG(4,1,'s11',2,1,[bad3 ; flat3])
temprod_preproc_EEG(5,1,'s11',2,1,[bad4 ; flat4])

temprod_freqanalysis_eeg(0,2,'s11',[1 120])
temprod_freqanalysis_eeg(0,3,'s11',[1 120])
temprod_freqanalysis_eeg(0,4,'s11',[1 120])
temprod_freqanalysis_eeg(0,5,'s11',[1 120])

appendspectra_EEG(2,'s11',[1 120])
appendspectra_EEG(3,'s11',[1 120])
appendspectra_EEG(4,'s11',[1 120])
appendspectra_EEG(5,'s11',[1 120])

temprod_dataviewer_EEG(2,'s11',[13 20],[1 2 1],0,0,0,1)
temprod_dataviewer_EEG(3,'s11',[13 20],[1 2 1],0,0,0,1)
temprod_dataviewer_EEG(4,'s11',[13 20],[1 2 1],0,0,0,1)
temprod_dataviewer_EEG(5,'s11',[13 20],[1 2 1],0,0,0,1)

temprod_dataviewer_var_EEG([2 3 4 5],'s11',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_EEG([2 3 4 5],'s11',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_EEG([2 3 4 5],'s11',[50 120],0,0,'MEAN','old',1);
temprod_dataviewer_var_EEG([2 3 4 5],'s11',[50 120],0,0,'STD','old',1);
temprod_dataviewer_var_EEG([2 3 4 5],'s11',[1 15],0,0,'MEAN','old',1);
temprod_dataviewer_var_EEG([2 3 4 5],'s11',[1 15],0,0,'STD','old',1);
temprod_dataviewer_var_EEG([2 3 4 5],'s11',[15 30],0,0,'MEAN','old',1);
temprod_dataviewer_var_EEG([2 3 4 5],'s11',[15 30],0,0,'STD','old',1);

temprod_preproc_ICA_EEG(2,1,'s11',4,1,[bad2 ; flat2])
temprod_preproc_ICA_EEG(3,1,'s11',4,1,[bad3 ; flat3])
temprod_preproc_ICA_EEG(4,1,'s11',4,1,[bad4 ; flat4])
temprod_preproc_ICA_EEG(5,1,'s11',4,1,[bad5 ; flat5])

temprod_ICA_V5_EEG(2,'s11',[1 120],'runica',10,0.5)
temprod_ICA_V5_EEG(3,'s11',[1 120],'runica',10,0.5)
temprod_ICA_V5_EEG(4,'s11',[1 120],'runica',10,0.5)
temprod_ICA_V5_EEG(5,'s11',[1 120],'runica',10,0.5)

temprod_ICA_viewer_EEG(2,'s11',10,[2 50])
temprod_ICA_viewer_EEG(3,'s11',10,[2 50])
temprod_ICA_viewer_EEG(4,'s11',10,[2 50])
temprod_ICA_viewer_EEG(5,'s11',10,[2 50])

temprod_tbt_spectra(2,'s11',[1 120],1)
temprod_tbt_spectra(3,'s11',[1 120],1)
temprod_tbt_spectra(4,'s11',[1 120],1)
temprod_tbt_spectra(5,'s11',[1 120],1)

temprod_freqslope_EEG(2,'s11',[1 4],1)
temprod_freqslope_EEG(3,'s11',[1 4],1)
temprod_freqslope_EEG(4,'s11',[1 4],1)
temprod_freqslope_EEG(5,'s11',[1 4],1)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% grand averages %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% temprod_freqGDAVG_half_v2(arrayindex,subject,freqband,tag)
temprod_freqGDAVG_half_v2([2 5    ],'s11',[1 120],'2M_Est_5.7',tag);
temprod_freqGDAVG_half_v2([3      ],'s11',[1 120],'2M_Est_8.5',tag);
temprod_freqGDAVG_half_v2([2 3 5  ],'s11',[1 120],'2M_Est_all',tag);
temprod_freqGDAVG_half_v2([4      ],'s11',[1 120],'2M_Replay',tag);
temprod_freqGDAVG_half_v2([4      ],'s11',[1 120],'2M_Replay_5.7',tag);

temprod_freqGDAVG_half_v3([2 5    ],'s11',[1 120],'2M_Est_5.7',tag);
temprod_freqGDAVG_half_v3([3      ],'s11',[1 120],'2M_Est_8.5',tag);
temprod_freqGDAVG_half_v3([2 3 5  ],'s11',[1 120],'2M_Est_all',tag);
temprod_freqGDAVG_half_v3([4      ],'s11',[1 120],'2M_Replay',tag);
temprod_freqGDAVG_half_v3([4      ],'s11',[1 120],'2M_Replay_5.7',tag);

subjects       = {'s11'};
cond            = '2M_Est_5.7';
GDAVG_half_viewer_V2(subjects,[1 7],cond,tag)
cond            = '2M_Est_8.5';
GDAVG_half_viewer_V2(subjects,[1 7],cond,tag)
cond            = '2M_Est_all';
GDAVG_half_viewer_V2(subjects,[1 7],cond,tag)
cond            = '2M_Replay';
GDAVG_half_viewer_V2(subjects,[1 7],cond,tag)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
temprod_freqGDAVG_quarter_V3([2 5    ],'s11',[1 120],'2M_Est_5.7',tag);
temprod_freqGDAVG_quarter_V3([3      ],'s11',[1 120],'2M_Est_8.5',tag);
temprod_freqGDAVG_quarter_V3([2 3 5  ],'s11',[1 120],'2M_Est_all',tag);
temprod_freqGDAVG_quarter_V3([4      ],'s11',[1 120],'2M_Replay',tag);
temprod_freqGDAVG_quarter_V3([4      ],'s11',[1 120],'2M_Replay_5.7',tag);

subjects       = {'s11'};
cond            = '2M_Est_5.7';
GDAVG_quarter_viewer(subjects,[1 120],cond,tag)
cond            = '2M_Est_8.5';
GDAVG_quarter_viewer(subjects,[1 120],cond,tag)
cond            = '2M_Est_all';
GDAVG_quarter_viewer(subjects,[1 120],cond,tag)
cond            = '2M_Replay';
GDAVG_quarter_viewer(subjects,[1 120],cond,tag)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

temprod_freqGDAVG_quarter_clusters([2 5    ],'s11',[1 120],'2M_Est_5.7',tag);
temprod_freqGDAVG_quarter_clusters([3      ],'s11',[1 120],'2M_Est_8.5',tag);
temprod_freqGDAVG_quarter_clusters([2 3 5  ],'s11',[1 120],'2M_Est_all',tag);
temprod_freqGDAVG_quarter_clusters([4      ],'s11',[1 120],'2M_Replay',tag);
temprod_freqGDAVG_quarter_clusters([4      ],'s11',[1 120],'2M_Replay_5.7',tag);

f = {[1 7];[7 14];[14 30];[30 120];[1 120]};
for i = 1:length(f)
    subjects       = {'s11'};
    cond            = '2M_Est_5.7';
    GDAVG_quarter_clusters_viewer(subjects,f{i},cond,tag)
    cond            = '2M_Est_8.5';
    GDAVG_quarter_clusters_viewer(subjects,f{i},cond,tag)
    cond            = '2M_Est_all';
    GDAVG_quarter_clusters_viewer(subjects,f{i},cond,tag)
    cond            = '2M_Replay';
    GDAVG_quarter_clusters_viewer(subjects,f{i},cond,tag)
end

