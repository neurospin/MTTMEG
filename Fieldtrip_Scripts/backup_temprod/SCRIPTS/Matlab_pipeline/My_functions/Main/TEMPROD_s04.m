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
subject    = 's04';
[meds04,meAns04,SDs04,meAnnorms04] = temprod_BehaviorSummary_s04(subject,RunNum,fsample,TD,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

temprod_preproc_jr(1,'s04',1,'ecg&eog',tag)
temprod_preproc_jr(2,'s04',1,'ecg&eog',tag)
temprod_preproc_jr(3,'s04',1,'ecg&eog',tag)
temprod_preproc_jr(4,'s04',1,'ecg&eog',tag)
temprod_preproc_jr(5,'s04',1,'ecg&eog',tag)

temprod_preproc_s04(2,1,'s04',4,1)
temprod_preproc_s04(3,1,'s04',4,1)
temprod_preproc_s04(4,1,'s04',4,1)
temprod_preproc_s04(5,1,'s04',4,1)
temprod_preproc_s04(6,1,'s04',4,1)
temprod_preproc_s04(7,1,'s04',4,1)

temprod_freqanalysis(1,'s04',[1 120])
temprod_freqanalysis(2,'s04',[1 120])
temprod_freqanalysis(3,'s04',[1 120])
temprod_freqanalysis(4,'s04',[1 120])
appendspectra_V2(1,'s04',[1 120])
appendspectra_V2(2,'s04',[1 120])
appendspectra_V2(3,'s04',[1 120])
appendspectra_V2(4,'s04',[1 120])

temprod_dataviewer(2,'s04',[30 80],[1 2 1],0,0,0,1);
temprod_dataviewer(3,'s04',[30 80],[1 2 1],0,0,0,1);
temprod_dataviewer(4,'s04',[30 80],[1 2 1],0,0,0,1);
temprod_dataviewer(5,'s04',[30 80],[1 2 1],0,0,0,1);
temprod_dataviewer(6,'s04',[30 80],[1 2 1],0,0,0,1);
temprod_dataviewer(7,'s04',[30 80],[1 2 1],0,0,0,1);

temprod_preproc_ICA_s04(2,1,'s04',4,1)
temprod_preproc_ICA_s04(3,1,'s04',4,1)
temprod_preproc_ICA_s04(4,1,'s04',4,1)
temprod_preproc_ICA_s04(5,1,'s04',4,1)
temprod_preproc_ICA_s04(6,1,'s04',4,1)
temprod_preproc_ICA_s04(7,1,'s04',4,1)

temprod_ICA_V5(2,'s04',[1 120],'runica',15,0.5)
temprod_ICA_V5(3,'s04',[1 120],'runica',15,0.5)
temprod_ICA_V5(4,'s04',[1 120],'runica',15,0.5)
temprod_ICA_V5(5,'s04',[1 120],'runica',15,0.5)
temprod_ICA_V5(6,'s04',[1 120],'runica',15,0.5)
temprod_ICA_V5(7,'s04',[1 120],'runica',15,0.5)

temprod_ICA_viewer(2,'s04',15,[1 30],'runica')
temprod_ICA_viewer(3,'s04',15,[1 30],'runica')
temprod_ICA_viewer(4,'s04',15,[1 30],'runica')
temprod_ICA_viewer(5,'s04',15,[1 30],'runica')
temprod_ICA_viewer(6,'s04',15,[1 30],'runica')
temprod_ICA_viewer(7,'s04',15,[1 30],'runica')

temprod_dataviewer_var([2 3 4 5 6 7],'s04',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var([2 3 4 5 6 7],'s04',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var([2 3 4 5 6 7],'s04',[50 120],0,0,'MEAN','old',1);
temprod_dataviewer_var([2 3 4 5 6 7],'s04',[50 120],0,0,'STD','old',1);

temprod_dataviewer_var_half([1],'s04',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_half([1],'s04',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_half([2],'s04',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_half([2],'s04',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_half([3],'s04',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_half([3],'s04',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_half([4],'s04',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_half([4],'s04',[1 50],0,0,'STD','old',1);

temprod_dataviewer_var_clusters([1 2 3 4],'s04',[1 6],1,[8 12],'MEAN','old',1);
temprod_dataviewer_var_clusters([1 2 3 4],'s04',[1 6],1,[8 12],'STD','old',1);
temprod_dataviewer_var_clusters([1 2 3 4],'s04',[6 15],1,[8 12],'MEAN','old',1);
temprod_dataviewer_var_clusters([1 2 3 4],'s04',[6 15],1,[8 12],'STD','old',1);
temprod_dataviewer_var_clusters([1 2 3 4],'s04',[15 30],1,[8 12],'MEAN','old',1);
temprod_dataviewer_var_clusters([1 2 3 4],'s04',[15 30],1,[8 12],'STD','old',1);
temprod_dataviewer_var_clusters([1 2 3 4],'s04',[30 120],1,[30 120],'MEAN','old',1);
temprod_dataviewer_var_clusters([1 2 3 4],'s04',[30 120],1,[30 120],'STD','old',1);

temprod_tbt_spectra(1,'s04',[1 120],1)
temprod_tbt_spectra(2,'s04',[1 120],1)
temprod_tbt_spectra(3,'s04',[1 120],1)
temprod_tbt_spectra(4,'s04',[1 120],1)
temprod_tbt_spectra(5,'s04',[1 120],1)
temprod_tbt_spectra(6,'s04',[1 120],1)
temprod_tbt_spectra(7,'s04',[1 120],1)

temprod_freqslope(1,'s04',[1 4],1)
temprod_freqslope(2,'s04',[1 4],1)
temprod_freqslope(3,'s04',[1 4],1)
temprod_freqslope(4,'s04',[1 4],1)
temprod_freqslope(1,'s04',[1 7],1)
temprod_freqslope(2,'s04',[1 7],1)
temprod_freqslope(3,'s04',[1 7],1)
temprod_freqslope(4,'s04',[1 7],1)
temprod_freqslope(1,'s04',[4 7],1)
temprod_freqslope(2,'s04',[4 7],1)
temprod_freqslope(3,'s04',[4 7],1)
temprod_freqslope(4,'s04',[4 7],1)
temprod_freqslope(1,'s04',[30 80],1)
temprod_freqslope(2,'s04',[30 80],1)
temprod_freqslope(3,'s04',[30 80],1)
temprod_freqslope(4,'s04',[30 80],1)
temprod_freqslope(1,'s04',[30 120],1)
temprod_freqslope(2,'s04',[30 120],1)
temprod_freqslope(3,'s04',[30 120],1)
temprod_freqslope(4,'s04',[30 120],1)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% temprod_freqGDAVG_half_v2(arrayindex,subject,freqband,tag)
temprod_freqGDAVG_half_v2([1        ],'s04',[0.5 120],'2M_Est_5.7');
temprod_freqGDAVG_half_v2([3        ],'s04',[0.5 120],'2M_Est_9.3');
temprod_freqGDAVG_half_v2([2        ],'s04',[0.5 120],'2M_Est_12.8');
temprod_freqGDAVG_half_v2([1 2 3    ],'s04',[0.5 120],'2M_Est_all');

subjects       = {'s04'};
tag            = '2M_Est_5.7';
GDAVG_half_viewer_V2(subjects,[7 14],tag)
tag            = '2M_Est_9.3';
GDAVG_half_viewer_V2(subjects,[7 14],tag)
tag            = '2M_Est_12.8';
GDAVG_half_viewer_V2(subjects,[7 14],tag)
tag            = '2M_Est_all';
GDAVG_half_viewer_V2(subjects,[7 14],tag)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
temprod_freqGDAVG_quarter_clusters([1        ],'s04',[0.5 120],'2M_Est_5.7');
temprod_freqGDAVG_quarter_clusters([3        ],'s04',[0.5 120],'2M_Est_9.3');
temprod_freqGDAVG_quarter_clusters([2        ],'s04',[0.5 120],'2M_Est_12.8');
temprod_freqGDAVG_quarter_clusters([1 2 3    ],'s04',[0.5 120],'2M_Est_all');

subjects       = {'s04'};
tag            = '2M_Est_5.7';
GDAVG_quarter_clusters_viewer(subjects,[7 14],tag)
tag            = '2M_Est_9.3';
GDAVG_quarter_clusters_viewer(subjects,[7 14],tag)
tag            = '2M_Est_12.8';
GDAVG_quarter_clusters_viewer(subjects,[7 14],tag)
tag            = '2M_Est_all';
GDAVG_quarter_clusters_viewer(subjects,[7 14],tag)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
temprod_preproc_quarter(1,1,'s04',4,1,tag)
temprod_preproc_quarter(2,1,'s04',4,1,tag)
temprod_preproc_quarter(3,1,'s04',4,1,tag)

M = 12600;
temprod_freqanalysis_quarter_V3(1,'s04',M,[1 120],'Laptop');
temprod_freqanalysis_quarter_V3(2,'s04',M,[1 120],'Laptop');
temprod_freqanalysis_quarter_V3(3,'s04',M,[1 120],'Laptop');

temprod_freqGDAVG_quarter_clusters([1      ],'s04',[1 120],'2M_Est_5.7',tag);
temprod_freqGDAVG_quarter_clusters([3      ],'s04',[1 120],'2M_Est_9.3',tag);
temprod_freqGDAVG_quarter_clusters([2      ],'s04',[1 120],'2M_Est_12.8',tag);
temprod_freqGDAVG_quarter_clusters([1 2 3  ],'s04',[1 120],'2M_Est_all',tag);

f = {[1 7];[7 14];[14 30];[30 120];[1 120]};
for i = 1:length(f)
    subjects       = {'s04'};
    cond            = '2M_Est_5.7';
    GDAVG_quarter_clusters_viewer(subjects,f{i},cond,tag)
    cond            = '2M_Est_9.3';
    GDAVG_quarter_clusters_viewer(subjects,f{i},cond,tag)
    cond            = '2M_Est_12.8';
    GDAVG_quarter_clusters_viewer(subjects,f{i},cond,tag)
end