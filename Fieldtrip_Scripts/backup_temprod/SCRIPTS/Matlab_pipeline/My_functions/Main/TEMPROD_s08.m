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
temprod_preproc_jr(2,'s08',1,'ecg&eog',tag)
temprod_preproc_jr(3,'s08',1,'ecg&eog',tag)
temprod_preproc_jr(4,'s08',1,'ecg&eog',tag)
temprod_preproc_jr(5,'s08',1,'ecg&eog',tag)
temprod_preproc_jr(6,'s08',1,'ecg&eog',tag)

% temprod_BehaviorSummary(subject,RunNum,fsample,TD,savetag)
RunNum     = 2:7;
fsample    = [1 1 1 1 1 1]*1000; 
TD         = [5.7 8.5 5.7 5.7 8.5 5.7];  
subject    = 's08';
[meds08,meAns08,SDs08,meAnnorms08] = temprod_BehaviorSummary_s08(subject,RunNum,fsample,TD,1);

temprod_preproc_V2(2,1,'s08',4,1)
temprod_preproc_V2(3,1,'s08',4,1)
temprod_preproc_V2(4,1,'s08',4,1)
temprod_preproc_V2(5,1,'s08',4,1)
temprod_preproc_V2(6,1,'s08',4,1)
temprod_freqanalysis(2,'s08',[1 120])
temprod_freqanalysis(3,'s08',[1 120])
temprod_freqanalysis(4,'s08',[1 120])
temprod_freqanalysis(5,'s08',[1 120])
temprod_freqanalysis(6,'s08',[1 120])
appendspectra_V2(2,'s08',[1 120])
appendspectra_V2(3,'s08',[1 120])
appendspectra_V2(4,'s08',[1 120])
appendspectra_V2(5,'s08',[1 120])
appendspectra_V2(6,'s08',[1 120])

temprod_dataviewer_V2(2,'s08',[1 6],[1 2 3 2 1],1,1,1,1);
temprod_dataviewer_V2(3,'s08',[1 6],[1 2 3 2 1],1,1,1,1);
temprod_dataviewer_V2(4,'s08',[1 6],[1 2 3 2 1],1,1,1,1);
temprod_dataviewer_V2(5,'s08',[1 6],[1 2 3 2 1],1,1,1,1);
temprod_dataviewer_V2(6,'s08',[1 6],[1 2 3 2 1],1,1,1,1);

temprod_preproc_ICA_s08(2,1,'s08',4,1)
temprod_preproc_ICA_s08(3,1,'s08',4,1)
temprod_preproc_ICA_s08(4,1,'s08',4,1)
temprod_preproc_ICA_s08(5,1,'s08',4,1)
temprod_preproc_ICA_s08(6,1,'s08',4,1)
temprod_preproc_ICA_s08(7,1,'s08',4,1)

temprod_ICA_V5(2,'s08',[1 120],'runica',15,0.5)
temprod_ICA_V5(3,'s08',[1 120],'runica',15,0.5)
temprod_ICA_V5(4,'s08',[1 120],'runica',15,0.5)
temprod_ICA_V5(5,'s08',[1 120],'runica',15,0.5)
temprod_ICA_V5(6,'s08',[1 120],'runica',15,0.5)
temprod_ICA_V5(7,'s08',[1 120],'runica',15,0.5)

temprod_ICA_viewer(2,'s08',15,[1 30],'runica')
temprod_ICA_viewer(3,'s08',15,[1 30],'runica')
temprod_ICA_viewer(4,'s08',15,[1 30],'runica')
temprod_ICA_viewer(5,'s08',15,[1 30],'runica')
temprod_ICA_viewer(6,'s08',15,[1 30],'runica')
temprod_ICA_viewer(7,'s08',15,[1 30],'runica')

temprod_dataviewer_var([2 3 4 5 6 7],'s08',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var([2 3 4 5 6 7],'s08',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var([2 3 4 5 6 7],'s08',[50 120],0,0,'MEAN','old',1);
temprod_dataviewer_var([2 3 4 5 6 7],'s08',[50 120],0,0,'STD','old',1);

temprod_dataviewer_var_clusters([2 3 4 5 6 ],'s08',[1 6],1,[8 12],'MEAN','old',1);
temprod_dataviewer_var_clusters([2 3 4 5 6 ],'s08',[1 6],1,[8 12],'STD','old',1);
temprod_dataviewer_var_clusters([2 3 4 5 6 ],'s08',[6 15],1,[8 12],'MEAN','old',1);
temprod_dataviewer_var_clusters([2 3 4 5 6 ],'s08',[6 15],1,[8 12],'STD','old',1);
temprod_dataviewer_var_clusters([2 3 4 5 6 ],'s08',[15 30],1,[8 12],'MEAN','old',1);
temprod_dataviewer_var_clusters([2 3 4 5 6 ],'s08',[15 30],1,[8 12],'STD','old',1);
temprod_dataviewer_var_clusters([2 3 4 5 6 ],'s08',[30 120],1,[8 12],'MEAN','old',1);
temprod_dataviewer_var_clusters([2 3 4 5 6 ],'s08',[30 120],1,[8 12],'STD','old',1);

temprod_dataviewer_var_half([2],'s08',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_half([2],'s08',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_half([3],'s08',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_half([3],'s08',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_half([4],'s08',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_half([4],'s08',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_half([5],'s08',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_half([5],'s08',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_half([6],'s08',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_half([6],'s08',[1 50],0,0,'STD','old',1);

temprod_dataviewer_var_clusters([2 3 4 5 6 7],'s09',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_clusters([2 3 4 5 6 7],'s09',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_clusters([2 3 4 5 6 7],'s09',[50 120],0,0,'MEAN','old',1);
temprod_dataviewer_var_clusters([2 3 4 5 6 7],'s09',[50 120],0,0,'STD','old',1);

temprod_tbt_spectra(2,'s08',[1 50],1)
temprod_tbt_spectra(3,'s08',[1 120],1)
temprod_tbt_spectra(4,'s08',[1 120],1)
temprod_tbt_spectra(5,'s08',[1 120],1)
temprod_tbt_spectra(6,'s08',[1 120],1)
temprod_tbt_spectra(7,'s08',[1 120],1)

temprod_freqslope(2,'s08',[1 4],1)
temprod_freqslope(3,'s08',[1 4],1)
temprod_freqslope(4,'s08',[1 4],1)
temprod_freqslope(5,'s08',[1 4],1)
temprod_freqslope(6,'s08',[1 4],1)
temprod_freqslope(2,'s08',[4 7],1)
temprod_freqslope(3,'s08',[4 7],1)
temprod_freqslope(4,'s08',[4 7],1)
temprod_freqslope(5,'s08',[4 7],1)
temprod_freqslope(6,'s08',[4 7],1)
temprod_freqslope(2,'s08',[1 7],1)
temprod_freqslope(3,'s08',[1 7],1)
temprod_freqslope(4,'s08',[1 7],1)
temprod_freqslope(5,'s08',[1 7],1)
temprod_freqslope(6,'s08',[1 7],1)
temprod_freqslope(2,'s08',[30 80],1)
temprod_freqslope(3,'s08',[30 80],1)
temprod_freqslope(4,'s08',[30 80],1)
temprod_freqslope(5,'s08',[30 80],1)
temprod_freqslope(6,'s08',[30 80],1)
temprod_freqslope(2,'s08',[30 120],1)
temprod_freqslope(3,'s08',[30 120],1)
temprod_freqslope(4,'s08',[30 120],1)
temprod_freqslope(5,'s08',[30 120],1)
temprod_freqslope(6,'s08',[30 120],1)

temprod_FreqPow_corr_allbands_V2(2,'s08')
temprod_FreqPow_corr_allbands_V2(3,'s08')
temprod_FreqPow_corr_allbands_V2(4,'s08')
temprod_FreqPow_corr_allbands_V2(5,'s08')
temprod_FreqPow_corr_allbands_V2(6,'s08')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% grand averages %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
temprod_freqGDAVG_half_v2([2 4 5    ],'s08',[0.5 120],'2M_Est_5.7');
temprod_freqGDAVG_half_v2([2 6      ],'s08',[0.5 120],'2M_Est_8.5');
temprod_freqGDAVG_half_v2([2 3 4 5 6],'s08',[0.5 120],'2M_Est_all');

subjects       = {'s08'};
tag            = '2M_Est_5.7';
GDAVG_half_viewer_V2(subjects,[7 14],tag)
tag            = '2M_Est_8.5';
GDAVG_half_viewer_V2(subjects,[7 14],tag)
tag            = '2M_Est_all';
GDAVG_half_viewer_V2(subjects,[7 14],tag)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% grand averages %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
temprod_preproc_quarter(2,1,'s08',4,1,tag)
temprod_preproc_quarter(3,1,'s08',4,1,tag)
temprod_preproc_quarter(4,1,'s08',4,1,tag)
temprod_preproc_quarter(5,1,'s08',4,1,tag)
temprod_preproc_quarter(6,1,'s08',4,1,tag)

M = 12600;
temprod_freqanalysis_quarter_V3(2,'s08',M,[1 120],'Laptop');
temprod_freqanalysis_quarter_V3(3,'s08',M,[1 120],'Laptop');
temprod_freqanalysis_quarter_V3(4,'s08',M,[1 120],'Laptop');
temprod_freqanalysis_quarter_V3(5,'s08',M,[1 120],'Laptop');
temprod_freqanalysis_quarter_V3(6,'s08',M,[1 120],'Laptop');

temprod_freqGDAVG_quarter_clusters([2 4 5    ],'s08',[1 120],'2M_Est_5.7',tag);
temprod_freqGDAVG_quarter_clusters([2 6      ],'s08',[1 120],'2M_Est_8.5',tag);
temprod_freqGDAVG_quarter_clusters([2 3 4 5 6],'s08',[1 120],'2M_Est_all',tag);

f = {[1 7];[7 14];[14 30];[30 120];[1 120]};
for i = 1:length(f)
    subjects       = {'s08'};
    cond            = '2M_Est_5.7';
    GDAVG_quarter_clusters_viewer(subjects,f{i},cond,tag)
    cond            = '2M_Est_8.5';
    GDAVG_quarter_clusters_viewer(subjects,f{i},cond,tag)
    cond            = '2M_Est_all';
    GDAVG_quarter_clusters_viewer(subjects,f{i},cond,tag)
end


