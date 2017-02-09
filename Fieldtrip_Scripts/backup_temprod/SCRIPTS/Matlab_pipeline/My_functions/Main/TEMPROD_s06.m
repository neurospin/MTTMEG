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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
temprod_preproc_jr_s06(1,'s06',1,'ecg&eog',tag)
temprod_preproc_jr_s06(2,'s06',1,'ecg&eog',tag)
temprod_preproc_jr_s06(3,'s06',1,'ecg&eog',tag)
temprod_preproc_jr_s06(4,'s06',1,'ecg&eog',tag)

% temprod_BehaviorSummary(subject,RunNum,fsample,TD,savetag)
RunNum     = 2:5;
fsample    = [1 1 1 1]*1000; 
TD         = [5.7 8.5 5.7 5.7];  
subject    = 's06';
[meds06,meAns06,SDs06,meAnnorms06] = temprod_BehaviorSummary(subject,RunNum,fsample,TD,1);

temprod_preproc(2,1,'s06',4,1)
temprod_preproc(3,1,'s06',4,1)
temprod_preproc(4,1,'s06',4,1)
temprod_preproc(5,1,'s06',4,1)

temprod_freqanalysis(1,'s06',[1 120])
temprod_freqanalysis(2,'s06',[1 120])
temprod_freqanalysis(3,'s06',[1 120])
temprod_freqanalysis(4,'s06',[1 120])
appendspectra_V2(1,'s06',[1 120])
appendspectra_V2(2,'s06',[1 120])
appendspectra_V2(3,'s06',[1 120])
appendspectra_V2(4,'s06',[1 120])

temprod_dataviewer(2,'s06',[30 80],[1 2 1],0,0,0,1);
temprod_dataviewer(3,'s06',[30 80],[1 2 1],0,0,0,1);
temprod_dataviewer(4,'s06',[30 80],[1 2 1],0,0,0,1);
temprod_dataviewer(5,'s06',[30 80],[1 2 1],0,0,0,1);

temprod_preproc_ICA(2,1,'s06',4,1)
temprod_preproc_ICA(3,1,'s06',4,1)
temprod_preproc_ICA(4,1,'s06',4,1)
temprod_preproc_ICA(5,1,'s06',4,1)

temprod_ICA_V5(2,'s06',[1 120],'runica',15,0.5)
temprod_ICA_V5(3,'s06',[1 120],'runica',15,0.5)
temprod_ICA_V5(4,'s06',[1 120],'runica',15,0.5)
temprod_ICA_V5(5,'s06',[1 120],'runica',15,0.5)

temprod_ICA_viewer(2,'s06',15,[1 30],'runica')
temprod_ICA_viewer(3,'s06',15,[1 30],'runica')
temprod_ICA_viewer(4,'s06',15,[1 30],'runica')
temprod_ICA_viewer(5,'s06',15,[1 30],'runica')

temprod_dataviewer_var([2 3 4 5],'s06',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var([2 3 4 5],'s06',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var([2 3 4 5],'s06',[50 120],0,0,'MEAN','old',1);
temprod_dataviewer_var([2 3 4 5],'s06',[50 120],0,0,'STD','old',1);

temprod_dataviewer_var_clusters([1 2 3 4],'s06',[1 6],1,[8 12],'MEAN','old',1);
temprod_dataviewer_var_clusters([1 2 3 4],'s06',[1 6],1,[8 12],'STD','old',1);
temprod_dataviewer_var_clusters([1 2 3 4],'s06',[6 15],1,[8 12],'MEAN','old',1);
temprod_dataviewer_var_clusters([1 2 3 4],'s06',[6 15],1,[8 12],'STD','old',1);
temprod_dataviewer_var_clusters([1 2 3 4],'s06',[15 30],1,[8 12],'MEAN','old',1);
temprod_dataviewer_var_clusters([1 2 3 4],'s06',[15 30],1,[8 12],'STD','old',1);
temprod_dataviewer_var_clusters([1 2 3 4],'s06',[30 120],1,[8 12],'MEAN','old',1);
temprod_dataviewer_var_clusters([1 2 3 4],'s06',[30 120],1,[8 12],'STD','old',1);

temprod_dataviewer_var_half([1],'s06',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_half([1],'s06',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_half([2],'s06',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_half([2],'s06',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_half([3],'s06',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_half([3],'s06',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_half([4],'s06',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_half([4],'s06',[1 50],0,0,'STD','old',1);

temprod_dataviewer_var_EEG_half([1],'s06',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_EEG_half([1],'s06',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_EEG_half([2],'s06',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_EEG_half([2],'s06',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_EEG_half([3],'s06',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_EEG_half([3],'s06',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_EEG_half([4],'s06',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_EEG_half([4],'s06',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_EEG_half([5],'s06',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_EEG_half([5],'s06',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_EEG_half([6],'s06',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_EEG_half([6],'s06',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_EEG_half([7],'s06',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_EEG_half([7],'s06',[1 50],0,0,'STD','old',1);

temprod_dataviewer_var_clusters([2 3 4 5],'s06',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_clusters([2 3 4 5],'s06',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_clusters([2 3 4 5],'s06',[50 120],0,0,'MEAN','old',1);
temprod_dataviewer_var_clusters([2 3 4 5],'s06',[50 120],0,0,'STD','old',1);

temprod_freqslope(1,'s06',[1 4],1)
temprod_freqslope(2,'s06',[1 4],1)
temprod_freqslope(3,'s06',[1 4],1)
temprod_freqslope(4,'s06',[1 4],1)
temprod_freqslope(1,'s06',[4 7],1)
temprod_freqslope(2,'s06',[4 7],1)
temprod_freqslope(3,'s06',[4 7],1)
temprod_freqslope(4,'s06',[4 7],1)
temprod_freqslope(1,'s06',[1 7],1)
temprod_freqslope(2,'s06',[1 7],1)
temprod_freqslope(3,'s06',[1 7],1)
temprod_freqslope(4,'s06',[1 7],1)
temprod_freqslope(1,'s06',[30 80],1)
temprod_freqslope(2,'s06',[30 80],1)
temprod_freqslope(3,'s06',[30 80],1)
temprod_freqslope(4,'s06',[30 80],1)
temprod_freqslope(1,'s06',[30 120],1)
temprod_freqslope(2,'s06',[30 120],1)
temprod_freqslope(3,'s06',[30 120],1)
temprod_freqslope(4,'s06',[30 120],1)

temprod_FreqPow_corr_allbands_V2(1,'s06')
temprod_FreqPow_corr_allbands_V2(2,'s06')
temprod_FreqPow_corr_allbands_V2(3,'s06')
temprod_FreqPow_corr_allbands_V2(4,'s06')

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

temprod_preproc_EEG(2,1,'s06',2,1,[bad1 ; flat1])
temprod_preproc_EEG(3,1,'s06',2,1,[bad2 ; flat2])
temprod_preproc_EEG(4,1,'s06',2,1,[bad3 ; flat3])
temprod_preproc_EEG(5,1,'s06',2,1,[bad4 ; flat4])

temprod_freqanalysis_eeg(0,2,'s06',[1 120])
temprod_freqanalysis_eeg(0,3,'s06',[1 120])
temprod_freqanalysis_eeg(0,4,'s06',[1 120])
temprod_freqanalysis_eeg(0,5,'s06',[1 120])

appendspectra_EEG(2,'s06',[1 120])
appendspectra_EEG(3,'s06',[1 120])
appendspectra_EEG(4,'s06',[1 120])
appendspectra_EEG(5,'s06',[1 120])

temprod_dataviewer_EEG(1,'s06',[4 7],[1 2 1],0,0,0,1)
temprod_dataviewer_EEG(2,'s06',[4 7],[1 2 1],0,0,0,1)
temprod_dataviewer_EEG(3,'s06',[4 7],[1 2 1],0,0,0,1)
temprod_dataviewer_EEG(4,'s06',[4 7],[1 2 1],0,0,0,1)

temprod_dataviewer_var_EEG([1 2 3 4],'s06',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_EEG([1 2 3 4],'s06',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_EEG([1 2 3 4],'s06',[50 120],0,0,'MEAN','old',1);
temprod_dataviewer_var_EEG([1 2 3 4],'s06',[50 120],0,0,'STD','old',1);
temprod_dataviewer_var_EEG([1 2 3 4],'s06',[1 15],0,0,'MEAN','old',1);
temprod_dataviewer_var_EEG([1 2 3 4],'s06',[1 15],0,0,'STD','old',1);
temprod_dataviewer_var_EEG([1 2 3 4],'s06',[15 30],0,0,'MEAN','old',1);
temprod_dataviewer_var_EEG([1 2 3 4],'s06',[15 30],0,0,'STD','old',1);

temprod_freqslope_EEG(2,'s06',[1 4],1)
temprod_freqslope_EEG(3,'s06',[1 4],1)
temprod_freqslope_EEG(4,'s06',[1 4],1)
temprod_freqslope_EEG(5,'s06',[1 4],1)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% grand averages %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
temprod_freqGDAVG_half_v2([1 3      ],'s06',[0.5 120],'2M_Est_6.5');
temprod_freqGDAVG_half_v2([2 4      ],'s06',[0.5 120],'2M_Est_8.5');
temprod_freqGDAVG_half_v2([1 2 3 4  ],'s06',[0.5 120],'2M_Est_all');

subjects       = {'s06'};
tag            = '2M_Est_6.5';
GDAVG_half_viewer_V2(subjects,[7 14],tag)
tag            = '2M_Est_8.5';
GDAVG_half_viewer_V2(subjects,[7 14],tag)
tag            = '2M_Est_all';
GDAVG_half_viewer_V2(subjects,[7 14],tag)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% grand averages %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
temprod_preproc_quarter(1,1,'s06',4,1,tag)
temprod_preproc_quarter(2,1,'s06',4,1,tag)
temprod_preproc_quarter(3,1,'s06',4,1,tag)
temprod_preproc_quarter(4,1,'s06',4,1,tag)

M = 12600;
temprod_freqanalysis_quarter_V3(1,'s06',M,[1 120],'Laptop');
temprod_freqanalysis_quarter_V3(2,'s06',M,[1 120],'Laptop');
temprod_freqanalysis_quarter_V3(3,'s06',M,[1 120],'Laptop');
temprod_freqanalysis_quarter_V3(4,'s06',M,[1 120],'Laptop');

temprod_freqGDAVG_quarter_clusters([1 3      ],'s06',[1 120],'2M_Est_6.5',tag);
temprod_freqGDAVG_quarter_clusters([2 4      ],'s06',[1 120],'2M_Est_8.5',tag);
temprod_freqGDAVG_quarter_clusters([1 2 3 4  ],'s06',[1 120],'2M_Est_all',tag);

f = {[1 7];[7 14];[14 30];[30 120];[1 120]};
for i = 1:length(f)
    subjects       = {'s06'};
    cond            = '2M_Est_6.5';
    GDAVG_quarter_clusters_viewer(subjects,f{i},cond,tag)
    cond            = '2M_Est_8.5';
    GDAVG_quarter_clusters_viewer(subjects,f{i},cond,tag)
    cond            = '2M_Est_all';
    GDAVG_quarter_clusters_viewer(subjects,f{i},cond,tag)
end
