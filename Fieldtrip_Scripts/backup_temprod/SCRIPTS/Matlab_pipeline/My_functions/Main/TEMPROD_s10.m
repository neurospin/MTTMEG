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
subject    = 's10';
[meds10,meAns10,SDs10,meAnnorms10] = temprod_BehaviorSummary_s10(subject,RunNum,fsample,TD,1);

temprod_preproc_s10_V2(2,1,'s10',4,1)
temprod_preproc_s10_V2(3,1,'s10',4,1)
temprod_preproc_s10_V2(4,1,'s10',4,1)
temprod_preproc_s10_V2(5,1,'s10',4,1)
temprod_preproc_s10_V2(6,1,'s10',4,1)
temprod_preproc_s10_V2(7,1,'s10',4,1)

[Max2,Min2] = temprod_preproc_half_s10(2,1,'s10',4,1,tag);
[Max3,Min3] = temprod_preproc_half_s10(3,1,'s10',4,1,tag);
[Max4,Min4] = temprod_preproc_half_s10(4,1,'s10',4,1,tag);
[Max5,Min5] = temprod_preproc_half_s10(5,1,'s10',4,1,tag);
[Max6,Min6] = temprod_preproc_half_s10(6,1,'s10',4,1,tag);
[Max7,Min7] = temprod_preproc_half_s10(7,1,'s10',4,1,tag);

temprod_preproc_quarter_s10(2,1,'s10',4,1,tag);
temprod_preproc_quarter_s10(3,1,'s10',4,1,tag);
temprod_preproc_quarter_s10(4,1,'s10',4,1,tag);
temprod_preproc_quarter_s10(5,1,'s10',4,1,tag);
temprod_preproc_quarter_s10(6,1,'s10',4,1,tag);
temprod_preproc_quarter_s10(7,1,'s10',4,1,tag);

temprod_freqanalysis_quarter(2,'s10',12600,[1 120],tag)
temprod_freqanalysis_quarter(3,'s10',12600,[1 120],tag)
temprod_freqanalysis_quarter(4,'s10',12600,[1 120],tag)
temprod_freqanalysis_quarter(5,'s10',12600,[1 120],tag)
temprod_freqanalysis_quarter(6,'s10',12600,[1 120],tag)
temprod_freqanalysis_quarter(7,'s10',12600,[1 120],tag)

temprod_freqanalysis(2,'s10',[1 120])
temprod_freqanalysis(3,'s10',[1 120])
temprod_freqanalysis(4,'s10',[1 120])
temprod_freqanalysis(5,'s10',[1 120])
temprod_freqanalysis(6,'s10',[1 120])
temprod_freqanalysis(7,'s10',[1 120])
appendspectra_V2(2,'s10',[1 120])
appendspectra_V2(3,'s10',[1 120])
appendspectra_V2(4,'s10',[1 120])
appendspectra_V2(5,'s10',[1 120])
appendspectra_V2(6,'s10',[1 120])
appendspectra_V2(7,'s10',[1 120])

temprod_preproc_ECG(2,1,'s10',4,1,[1 120])
temprod_preproc_ECG(3,1,'s10',4,1,[1 120])
temprod_preproc_ECG(4,1,'s10',4,1,[1 120])
temprod_preproc_ECG(5,1,'s10',4,1,[1 120])
temprod_preproc_ECG(6,1,'s10',4,1,[1 120])
temprod_preproc_ECG(7,1,'s10',4,1,[1 120])
temprod_dataviewer_ECG(2,'s10',[1 5],[1 2 3 2 1],1,1,1)
temprod_dataviewer_ECG(3,'s10',[1 5],[1 2 3 2 1],1,1,1)
temprod_dataviewer_ECG(4,'s10',[1 5],[1 2 3 2 1],1,1,1)
temprod_dataviewer_ECG(5,'s10',[1 5],[1 2 3 2 1],1,1,1)
temprod_dataviewer_ECG(6,'s10',[1 5],[1 2 3 2 1],1,1,1)
temprod_dataviewer_ECG(7,'s10',[1 5],[1 2 3 2 1],1,1,1)

temprod_preproc_ECG_v2(2,1,'s10',4,1,tag)
temprod_preproc_ECG_v2(3,1,'s10',4,1,tag)
temprod_preproc_ECG_v2(4,1,'s10',4,1,tag)
temprod_preproc_ECG_v2(5,1,'s10',4,1,tag)
temprod_preproc_ECG_v2(6,1,'s10',4,1,tag)
temprod_preproc_ECG_v2(7,1,'s10',4,1,tag)

temprod_dataviewer_V2(2,'s10',[1 6],[1 2 3 2 1],1,[8 12],1,1,1);
temprod_dataviewer_V2(3,'s10',[1 6],[1 2 3 2 1],1,[8 12],1,1,1);
temprod_dataviewer_V2(4,'s10',[1 6],[1 2 3 2 1],1,[8 12],1,1,1);
temprod_dataviewer_V2(5,'s10',[1 6],[1 2 3 2 1],1,[8 12],1,1,1);
temprod_dataviewer_V2(6,'s10',[1 6],[1 2 3 2 1],1,[8 12],1,1,1);
temprod_dataviewer_V2(7,'s10',[1 6],[1 2 3 2 1],1,[8 12],1,1,1);

% temprod_dataviewer_accuracy(index,subject,freqband,K,debiasing,interpnoise,chandisplay,target,savetag,tag)
temprod_dataviewer_accuracy(2,'s10',[7 14],[1 2 3 2 1],1,1,0,5700,1,tag);
temprod_dataviewer_accuracy(3,'s10',[7 14],[1 2 3 2 1],1,1,0,8500,1,tag);
temprod_dataviewer_accuracy(4,'s10',[7 14],[1 2 3 2 1],1,1,0,5700,1,tag);
temprod_dataviewer_accuracy(5,'s10',[7 14],[1 2 3 2 1],1,1,0,5700,1,tag);
temprod_dataviewer_accuracy(6,'s10',[7 14],[1 2 3 2 1],1,1,0,8500,1,tag);
temprod_dataviewer_accuracy(7,'s10',[7 14],[1 2 3 2 1],1,1,0,5700,1,tag);

temprod_preproc_ICA_s10(2,1,'s10',4,1)
temprod_preproc_ICA_s10(3,1,'s10',4,1)
temprod_preproc_ICA_s10(4,1,'s10',4,1)
temprod_preproc_ICA_s10(5,1,'s10',4,1)
temprod_preproc_ICA_s10(6,1,'s10',4,1)
temprod_preproc_ICA_s10(7,1,'s10',4,1)

temprod_ICA_V5(2,'s10',[1 120],'runica',15,0.5)
temprod_ICA_V5(3,'s10',[1 120],'runica',15,0.5)
temprod_ICA_V5(4,'s10',[1 120],'runica',15,0.5)
temprod_ICA_V5(5,'s10',[1 120],'runica',15,0.5)
temprod_ICA_V5(6,'s10',[1 120],'runica',15,0.5)
temprod_ICA_V5(7,'s10',[1 120],'runica',15,0.5)

temprod_ICA_viewer(2,'s10',15,[1 30],'runica')
temprod_ICA_viewer(3,'s10',15,[1 30],'runica')
temprod_ICA_viewer(4,'s10',15,[1 30],'runica')
temprod_ICA_viewer(5,'s10',15,[1 30],'runica')
temprod_ICA_viewer(6,'s10',15,[1 30],'runica')
temprod_ICA_viewer(7,'s10',15,[1 30],'runica')

temprod_dataviewer_var_clusters([2 3 4 5 6 7],'s10',[1 6],1,[8 12],'MEAN','old',1);
temprod_dataviewer_var_clusters([2 3 4 5 6 7],'s10',[1 6],1,[8 12],'STD','old',1);
temprod_dataviewer_var_clusters([2 3 4 5 6 7],'s10',[6 15],1,[8 12],'MEAN','old',1);
temprod_dataviewer_var_clusters([2 3 4 5 6 7],'s10',[6 15],1,[8 12],'STD','old',1);
temprod_dataviewer_var_clusters([2 3 4 5 6 7],'s10',[15 30],1,[8 12],'MEAN','old',1);
temprod_dataviewer_var_clusters([2 3 4 5 6 7],'s10',[15 30],1,[8 12],'STD','old',1);
temprod_dataviewer_var_clusters([2 3 4 5 6 7],'s10',[30 120],1,[8 12],'MEAN','old',1);
temprod_dataviewer_var_clusters([2 3 4 5 6 7],'s10',[30 120],1,[8 12],'STD','old',1);

temprod_dataviewer_var([2 3 4 5 6 7],'s10',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var([2 3 4 5 6 7],'s10',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var([2 3 4 5 6 7],'s10',[50 120],0,0,'MEAN','old',1);
temprod_dataviewer_var([2 3 4 5 6 7],'s10',[50 120],0,0,'STD','old',1);

temprod_dataviewer_var_half([2],'s11',[7 14],0,0,'MEAN','old',1);
temprod_dataviewer_var_half([2],'s10',[7 14],0,0,'STD','old',1);
temprod_dataviewer_var_half([3],'s10',[7 14],0,0,'MEAN','old',1);
temprod_dataviewer_var_half([3],'s10',[7 14],0,0,'STD','old',1);
temprod_dataviewer_var_half([4],'s10',[7 14],0,0,'MEAN','old',1);
temprod_dataviewer_var_half([4],'s10',[7 14],0,0,'STD','old',1);
temprod_dataviewer_var_half([5],'s10',[7 14],0,0,'MEAN','old',1);
temprod_dataviewer_var_half([5],'s10',[7 14],0,0,'STD','old',1);
temprod_dataviewer_var_half([6],'s10',[7 14],0,0,'MEAN','old',1);
temprod_dataviewer_var_half([6],'s10',[7 14],0,0,'STD','old',1);
temprod_dataviewer_var_half([7],'s10',[7 14],0,0,'MEAN','old',1);
temprod_dataviewer_var_half([7],'s10',[7 14],0,0,'STD','old',1);

temprod_dataviewer_var_clusters([2 3 4 5 6 7],'s10',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_clusters([2 3 4 5 6 7],'s10',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_clusters([2 3 4 5 6 7],'s10',[50 120],0,0,'MEAN','old',1);
temprod_dataviewer_var_clusters([2 3 4 5 6 7],'s10',[50 120],0,0,'STD','old',1);

temprod_tbt_spectra(2,'s10',[1 50],1)
temprod_tbt_spectra(3,'s10',[1 120],1)
temprod_tbt_spectra(4,'s10',[1 120],1)
temprod_tbt_spectra(5,'s10',[1 120],1)
temprod_tbt_spectra(6,'s10',[1 120],1)
temprod_tbt_spectra(7,'s10',[1 120],1)

temprod_freqslope(2,'s10',[30 80],1,'Laptop')
temprod_freqslope(3,'s10',[30 80],1,'Laptop')
temprod_freqslope(4,'s10',[30 80],1,'Laptop')
temprod_freqslope(5,'s10',[30 80],1,'Laptop')
temprod_freqslope(6,'s10',[30 80],1,'Laptop')
temprod_freqslope(7,'s10',[30 80],1,'Laptop')

temprod_freqslope_V2({[2 4];[3 4];[5 7];[6 7]},'s10',[1 4],1)
temprod_freqslope_V2({[2 4];[3 4];[5 7];[6 7]},'s10',[1 7],1)
temprod_freqslope_V2({[2 4];[3 4];[5 7];[6 7]},'s10',[4 7],1)
temprod_freqslope_V2({[2 4];[3 4];[5 7];[6 7]},'s10',[30 80],1)
temprod_freqslope_V2({[2 4];[3 4];[5 7];[6 7]},'s10',[30 120],1)

temprod_FreqPow_corr_allbands_V2(2,'s10')
temprod_FreqPow_corr_allbands_V2(3,'s10')
temprod_FreqPow_corr_allbands_V2(4,'s10')
temprod_FreqPow_corr_allbands_V2(5,'s10')
temprod_FreqPow_corr_allbands_V2(6,'s10')
temprod_FreqPow_corr_allbands_V2(7,'s10')

temprod_freqanalysis_weighted(2,'s10',[1 120],10,0.9)
temprod_freqanalysis_weighted(3,'s10',[1 120],10,0.9)
temprod_freqanalysis_weighted(4,'s10',[1 120],10,0.9)
temprod_freqanalysis_weighted(5,'s10',[1 120],10,0.9)
temprod_freqanalysis_weighted(6,'s10',[1 120],10,0.9)
temprod_freqanalysis_weighted(7,'s10',[1 120],10,0.9)
appendspectra_weighted(2,'s10',[1 120],10,0.9)
appendspectra_weighted(3,'s10',[1 120],10,0.9)
appendspectra_weighted(4,'s10',[1 120],10,0.9)
appendspectra_weighted(5,'s10',[1 120],10,0.9)
appendspectra_weighted(6,'s10',[1 120],10,0.9)
appendspectra_weighted(7,'s10',[1 120],10,0.9)
temprod_tbt_spectra_weighted(2,'s10',[1 120],1,10,0.9)
temprod_tbt_spectra_weighted(3,'s10',[1 120],1,10,0.9)
temprod_tbt_spectra_weighted(4,'s10',[1 120],1,10,0.9)
temprod_tbt_spectra_weighted(5,'s10',[1 120],1,10,0.9)
temprod_tbt_spectra_weighted(6,'s10',[1 120],1,10,0.9)
temprod_tbt_spectra_weighted(7,'s10',[1 120],1,10,0.9)
temprod_freqslope_weighted(2,'s10',[1 4],1,10,0.9)
temprod_freqslope_weighted(3,'s10',[1 4],1,10,0.9)
temprod_freqslope_weighted(4,'s10',[1 4],1,10,0.9)
temprod_freqslope_weighted(5,'s10',[1 4],1,10,0.9)
temprod_freqslope_weighted(6,'s10',[1 4],1,10,0.9)
temprod_freqslope_weighted(7,'s10',[1 4],1,10,0.9)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% grand averages %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% temprod_freqGDAVG_half_v2(arrayindex,subject,freqband,tag)
temprod_freqGDAVG_half_v2([5      ],'s10',[1 120],'2M_Est_5.7',tag);
temprod_freqGDAVG_half_v2([3      ],'s10',[1 120],'2M_Est_8.5',tag);
temprod_freqGDAVG_half_v2([3 5    ],'s10',[1 120],'2M_Est_all',tag);
temprod_freqGDAVG_half_v2([4 7    ],'s10',[1 120],'2M_Replay',tag);
temprod_freqGDAVG_half_v2([4      ],'s10',[1 120],'2M_Replay_5.7',tag);
temprod_freqGDAVG_half_v2([  7    ],'s10',[1 120],'2M_Replay_8.5',tag);

temprod_freqGDAVG_half_v3([5      ],'s10',[1 120],'2M_Est_5.7',tag);
temprod_freqGDAVG_half_v3([3      ],'s10',[1 120],'2M_Est_8.5',tag);
temprod_freqGDAVG_half_v3([3 5    ],'s10',[1 120],'2M_Est_all',tag);
temprod_freqGDAVG_half_v3([4 7    ],'s10',[1 120],'2M_Replay',tag);
temprod_freqGDAVG_half_v3([4      ],'s10',[1 120],'2M_Replay_5.7',tag);
temprod_freqGDAVG_half_v3([  7    ],'s10',[1 120],'2M_Replay_8.5',tag);

subjects       = {'s10'};
cond            = '2M_Est_5.7';
GDAVG_half_viewer_V2(subjects,[1 7],cond,tag)
cond            = '2M_Est_8.5';
GDAVG_half_viewer_V2(subjects,[1 7],cond,tag)
cond            = '2M_Est_all';
GDAVG_half_viewer_V2(subjects,[1 7],cond,tag)
cond            = '2M_Replay';
GDAVG_half_viewer_V2(subjects,[1 7],cond,tag)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
temprod_freqGDAVG_quarter_V3([5      ],'s10',[1 120],'2M_Est_5.7',tag);
temprod_freqGDAVG_quarter_V3([3      ],'s10',[1 120],'2M_Est_8.5',tag);
temprod_freqGDAVG_quarter_V3([3 5    ],'s10',[1 120],'2M_Est_all',tag);
temprod_freqGDAVG_quarter_V3([4 7    ],'s10',[1 120],'2M_Replay',tag);
temprod_freqGDAVG_quarter_V3([4      ],'s10',[1 120],'2M_Replay_5.7',tag);
temprod_freqGDAVG_quarter_V3([  7    ],'s10',[1 120],'2M_Replay_8.5',tag);

subjects       = {'s10'};
cond            = '2M_Est_5.7';
GDAVG_quarter_viewer(subjects,[1 120],cond,tag)
cond            = '2M_Est_8.5';
GDAVG_quarter_viewer(subjects,[1 120],cond,tag)
cond            = '2M_Est_all';
GDAVG_quarter_viewer(subjects,[1 120],cond,tag)
cond            = '2M_Replay';
GDAVG_quarter_viewer(subjects,[1 120],cond,tag)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
temprod_freqGDAVG_quarter_clusters([5      ],'s10',[1 120],'2M_Est_5.7',tag);
temprod_freqGDAVG_quarter_clusters([3      ],'s10',[1 120],'2M_Est_8.5',tag);
temprod_freqGDAVG_quarter_clusters([3 5    ],'s10',[1 120],'2M_Est_all',tag);
temprod_freqGDAVG_quarter_clusters([4 7    ],'s10',[1 120],'2M_Replay',tag);
temprod_freqGDAVG_quarter_clusters([4      ],'s10',[1 120],'2M_Replay_5.7',tag);
temprod_freqGDAVG_quarter_clusters([  7    ],'s10',[1 120],'2M_Replay_8.5',tag);

f = {[1 7];[7 14];[14 30];[30 120];[1 120]};
for i = 1:length(f)
    subjects       = {'s10'};
    cond            = '2M_Est_5.7';
    GDAVG_quarter_clusters_viewer(subjects,f{i},cond,tag)
    cond            = '2M_Est_8.5';
    GDAVG_quarter_clusters_viewer(subjects,f{i},cond,tag)
    cond            = '2M_Est_all';
    GDAVG_quarter_clusters_viewer(subjects,f{i},cond,tag)
    cond            = '2M_Replay';
    GDAVG_quarter_clusters_viewer(subjects,f{i},cond,tag)
end


