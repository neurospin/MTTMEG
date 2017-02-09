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
tag = 'Laptop';

% temprod_BehaviorSummary(subject,RunNum,fsample,TD,savetag)
RunNum     = 2:7;
fsample    = [1 1 1 1 1 1]*1000; 
TD         = [5.7 8.5 5.7 5.7 8.5 5.7];  
subject    = 's14';
[meds14,meAns14,SDs14,meAnnorms14] = temprod_BehaviorSummary(subject,RunNum,fsample,TD,1);
temprod_BehaviorFFT_RT_v2(subject,RunNum,fsample,tag)

RunNum     = 2:6;
fsample    = [1 1 1 1 1]*1000; 
TD         = [6.5 8.5 6.5 6.5 8.5];  
subject    = 's08';
[meds08,meAns08,SDs08,meAnnorms08] = temprod_BehaviorSummary(subject,RunNum,fsample,TD,1);

RunNum     = 1:6;
fsample    = [2 2 1 1 1 1]*1000; 
TD         = [6.5 8.5 6.5 6.5 8.5 8.5];  
subject    = 's07';
[meds07,meAns07,SDs07,meAnnorms07] = temprod_BehaviorSummary(subject,RunNum,fsample,TD,1);

RunNum     = 1:4;
fsample    = [1 1 1 1]*1000; 
TD         = [6.5 8.5 6.5 8.5];  
subject    = 's06';
[meds06,meAns06,SDs06,meAnnorms06] = temprod_BehaviorSummary(subject,RunNum,fsample,TD,1);

RunNum     = 1:3;
fsample    = [1 1 1]*1000; 
TD         = [6.5 8.5 6.5];  
subject    = 's05';
[meds05,meAns05,SDs05,meAnnorms05] = temprod_BehaviorSummary(subject,RunNum,fsample,TD,1);

RunNum     = 1:3;
fsample    = [1 1 1]*1000; 
TD         = [5.7 12.8 9.3];  
subject    = 's04';
[meds04,meAns04,SDs04,meAnnorms04] = temprod_BehaviorSummary(subject,RunNum,fsample,TD,1);

RunNum     = 1:6;
fsample    = [1 1 1 1 1 1]*1000; 
TD         = [17.3 0.75 11.7 2.8 1.7 5.2];  
subject    = 's03';
[meds03,meAns03,SDs03,meAnnorms03] = temprod_BehaviorSummary(subject,RunNum,fsample,TD,1);


%% PROCESSING %%
% temprod_preproc(run,isdownsample,subject,runref,rejection)
% temprod_removetrial(indexrun,subject,trialvector)

temprod_preproc_ICA(1,1,'s04',2,1)
temprod_preproc_ICA(2,1,'s04',2,1)
temprod_preproc_ICA(3,1,'s04',2,1)
temprod_preproc_ICA(4,1,'s04',2,1)
temprod_preproc_ICA(1,1,'s05',2,1)
temprod_preproc_ICA(2,1,'s05',2,1)
temprod_preproc_ICA(3,1,'s05',2,1)
temprod_preproc_ICA(1,1,'s06',2,1)
temprod_preproc_ICA(2,1,'s06',2,1)
temprod_preproc_ICA(3,1,'s06',2,1)
temprod_preproc_ICA(4,1,'s06',2,1)
temprod_preproc_ICA(1,1,'s07',4,1)
temprod_preproc_ICA(2,1,'s07',4,1)
temprod_preproc_ICA(3,1,'s07',4,1)
temprod_preproc_ICA(4,1,'s07',4,1)
temprod_preproc_ICA(5,1,'s07',4,1)
temprod_preproc_ICA(6,1,'s07',4,1)
temprod_preproc_ICA(2,1,'s08',2,1)
temprod_preproc_ICA(3,1,'s08',2,1)
temprod_preproc_ICA(4,1,'s08',2,1)
temprod_preproc_ICA(5,1,'s08',2,1)
temprod_preproc_ICA(6,1,'s08',2,1)

temprod_preproc_ICA_EEG(1,1,'s06',2,1)
temprod_preproc_ICA_EEG(2,1,'s06',2,1)
temprod_preproc_ICA_EEG(3,1,'s06',2,1)
temprod_preproc_ICA_EEG(4,1,'s06',2,1)

% temprod_preproc_rest(run,isdownsample,runref,subject,runcomp)
temprod_preproc_rest(7,1,2,'s04',1)
temprod_preproc_rest(7,1,2,'s04',2)
temprod_preproc_rest(7,1,2,'s04',3)
temprod_preproc_rest(7,1,2,'s04',4)
temprod_freqanalysis_rest(1,'s04',[1 100])
temprod_freqanalysis_rest(2,'s04',[1 100])
temprod_freqanalysis_rest(3,'s04',[1 100])
temprod_freqanalysis_rest(4,'s04',[1 100])
temprod_preproc_rest(4,1,2,'s05',1)
temprod_preproc_rest(4,1,2,'s05',2)
temprod_preproc_rest(4,1,2,'s05',3)
temprod_freqanalysis_rest(1,'s05',[1 100])
temprod_freqanalysis_rest(2,'s05',[1 100])
temprod_freqanalysis_rest(3,'s05',[1 100])
temprod_preproc_rest(5,1,2,'s06',1)
temprod_preproc_rest(5,1,2,'s06',2)
temprod_preproc_rest(5,1,2,'s06',3)
temprod_preproc_rest(5,1,2,'s06',4)
temprod_freqanalysis_rest(1,'s06',[1 100])
temprod_freqanalysis_rest(2,'s06',[1 100])
temprod_freqanalysis_rest(3,'s06',[1 100])
temprod_freqanalysis_rest(4,'s06',[1 100])
temprod_preproc_rest(7,1,2,'s07',1)
temprod_preproc_rest(7,1,2,'s07',2)
temprod_preproc_rest(7,1,2,'s07',3)
temprod_preproc_rest(7,1,2,'s07',4)
temprod_preproc_rest(7,1,2,'s07',5)
temprod_preproc_rest(7,1,2,'s07',6)
temprod_freqanalysis_rest(1,'s07',[1 100])
temprod_freqanalysis_rest(2,'s07',[1 100])
temprod_freqanalysis_rest(3,'s07',[1 100])
temprod_freqanalysis_rest(4,'s07',[1 100])
temprod_freqanalysis_rest(5,'s07',[1 100])
temprod_freqanalysis_rest(6,'s07',[1 100])
temprod_preproc_rest(1,1,2,'s08',2)
temprod_preproc_rest(1,1,2,'s08',3)
temprod_preproc_rest(1,1,2,'s08',4)
temprod_preproc_rest(1,1,2,'s08',5)
temprod_preproc_rest(1,1,2,'s08',6)
temprod_freqanalysis_rest(2,'s08',[1 100])
temprod_freqanalysis_rest(3,'s08',[1 100])
temprod_freqanalysis_rest(4,'s08',[1 100])
temprod_freqanalysis_rest(5,'s08',[1 100])
temprod_freqanalysis_rest(6,'s08',[1 100])

temprod_preproc_TF(1,1,'s04',2,1)
temprod_preproc_TF(2,1,'s04',2,1)
temprod_preproc_TF(3,1,'s04',2,1)
temprod_preproc_TF(4,1,'s04',2,1)
temprod_TF_freqanalysis(1,'s04',[2 50])
temprod_TF_freqanalysis(2,'s04',[2 50])
temprod_TF_freqanalysis(3,'s04',[2 50])
temprod_TF_freqanalysis(4,'s04',[2 50])
temprod_dataviewer_TF(1,'s04',[2 30],[3 0.3])
temprod_dataviewer_TF(2,'s04',[2 8],0.5)
temprod_dataviewer_TF(3,'s04',[2 8],0.5)
temprod_dataviewer_TF(4,'s04',[2 8],0.5)

temprod_preproc_rest(4,isdownsample,2,'s05',runcomp)
temprod_preproc_rest(5,isdownsample,2,'s06',runcomp)
temprod_preproc_rest(7,isdownsample,4,'s07',runcomp)
temprod_preproc_rest(1,isdownsample,2,'s08',runcomp)

appendspectra_V2_rest(1,'s04',[1 100])
appendspectra_V2_rest(2,'s04',[1 100])
appendspectra_V2_rest(3,'s04',[1 100])
appendspectra_V2_rest(4,'s04',[1 100])

temprod_preproc([1 11],1,'s03',3,1)
temprod_preproc(2,1,'s03',3,1)
temprod_preproc([3 31],1,'s03',3,1)
temprod_preproc(4,1,'s03',3,1)
temprod_preproc(5,1,'s03',3,1)
temprod_preproc(6,1,'s03',3,1)
temprod_preproc_ICA([1 11],1,'s03',3,1)
temprod_preproc_ICA(2,1,'s03',3,1)
temprod_preproc_ICA([3 31],1,'s03',3,1)
temprod_preproc_ICA(4,1,'s03',3,1)
temprod_preproc_ICA(5,1,'s03',3,1)
temprod_preproc_ICA(6,1,'s03',3,1)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% s14 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
temprod_preproc(2,1,'s14',4,1)
temprod_preproc(3,1,'s14',4,1)
temprod_preproc(4,1,'s14',4,1)
temprod_preproc(5,1,'s14',4,1)
temprod_preproc(6,1,'s14',4,1)
temprod_preproc(7,1,'s14',4,1)
temprod_freqanalysis(2,'s14',[1 120])
temprod_freqanalysis(3,'s14',[1 120])
temprod_freqanalysis(4,'s14',[1 120])
temprod_freqanalysis(5,'s14',[1 120])
temprod_freqanalysis(6,'s14',[1 120])
temprod_freqanalysis(7,'s14',[1 120])
appendspectra_V2(2,'s14',[1 120])
appendspectra_V2(3,'s14',[1 120])
appendspectra_V2(4,'s14',[1 120])
appendspectra_V2(5,'s14',[1 120])
appendspectra_V2(6,'s14',[1 120])
appendspectra_V2(7,'s14',[1 120])
temprod_dataviewer(2,'s14',[1 5],[1 2 1],0,0,0,1);
temprod_dataviewer(3,'s14',[1 5],[1 2 1],0,0,0,1);
temprod_dataviewer(4,'s14',[1 5],[1 2 1],0,0,0,1);
temprod_dataviewer(5,'s14',[1 5],[1 2 1],0,0,0,1);
temprod_dataviewer(6,'s14',[1 5],[1 2 1],0,0,0,1);
temprod_dataviewer(7,'s14',[1 5],[1 2 1],0,0,0,1);
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
temprod_dataviewer_var_clusters([2 3 4 5 6 7],'s14',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_clusters([2 3 4 5 6 7],'s14',[1 50],0,0,'STD','old',1);
temprod_dataviewer_var_clusters([2 3 4 5 6 7],'s14',[50 120],0,0,'MEAN','old',1);
temprod_dataviewer_var_clusters([2 3 4 5 6 7],'s14',[50 120],0,0,'STD','old',1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


temprod_freqanalysis(1,'s03',[1 120])
temprod_freqanalysis(2,'s03',[1 120])
temprod_freqanalysis(3,'s03',[1 120])
temprod_freqanalysis(4,'s03',[1 120])
temprod_freqanalysis(5,'s03',[1 120])
temprod_freqanalysis(6,'s03',[1 120])
appendspectra_V2(1,'s03',[1 120])
appendspectra_V2(2,'s03',[1 120])
appendspectra_V2(3,'s03',[1 120])
appendspectra_V2(4,'s03',[1 120])
appendspectra_V2(5,'s03',[1 120])
appendspectra_V2(6,'s03',[1 120])

temprod_dataviewer(3,'s03',[15 30],[1],0,0,0,1)

temprod_dataviewer(5,'s03',[4 8],[1],0,0,0,1)
temprod_dataviewer(5,'s03',[8 14],[1],0,0,0,1)
temprod_dataviewer(5,'s03',[15 30],[1],0,0,0,1)
temprod_dataviewer(5,'s03',[30 80],[1],0,0,0,1)

temprod_dataviewer_clusters(2,'s03',[4 6],[1],0,0,0,1)

temprod_freqanalysis(1,'s06',[1 100])
temprod_freqanalysis(2,'s06',[1 100])
temprod_freqanalysis(3,'s06',[1 100])
temprod_freqanalysis(4,'s06',[1 100])
temprod_freqanalysis(1,'s05',[1 100])
temprod_freqanalysis(2,'s05',[1 100])
temprod_freqanalysis(3,'s05',[1 100])
temprod_freqanalysis(1,'s04',[1 100])
temprod_freqanalysis(2,'s04',[1 100])
temprod_freqanalysis(3,'s04',[1 100])
temprod_freqanalysis(4,'s04',[1 100])
temprod_freqanalysis(1,'s07',[1 100])
temprod_freqanalysis(2,'s07',[1 100])
temprod_freqanalysis(3,'s07',[1 100])
temprod_freqanalysis(4,'s07',[1 100])
temprod_freqanalysis(5,'s07',[1 100])
temprod_freqanalysis(6,'s07',[1 100])
temprod_freqanalysis(2,'s08',[1 100])
temprod_freqanalysis(3,'s08',[1 100])
temprod_freqanalysis(4,'s08',[1 100])
temprod_freqanalysis(5,'s08',[1 100])
temprod_freqanalysis(6,'s08',[1 100])

appendspectra_V2(1,'s04',[1 100])
appendspectra_V2(2,'s04',[1 100])
appendspectra_V2(3,'s04',[1 100])
appendspectra_V2(4,'s04',[1 100])
appendspectra_V2(1,'s05',[1 100])
appendspectra_V2(2,'s05',[1 100])
appendspectra_V2(3,'s05',[1 100])
appendspectra_V2(1,'s06',[1 100])
appendspectra_V2(2,'s06',[1 100])
appendspectra_V2(3,'s06',[1 100])
appendspectra_V2(4,'s06',[1 100])
appendspectra_V2(1,'s07',[1 100])
appendspectra_V2(2,'s07',[1 100])
appendspectra_V2(3,'s07',[1 100])
appendspectra_V2(4,'s07',[1 100])
appendspectra_V2(5,'s07',[1 100])
appendspectra_V2(6,'s07',[1 100])
appendspectra_V2(2,'s08',[1 100])
appendspectra_V2(3,'s08',[1 100])
appendspectra_V2(4,'s08',[1 100])
appendspectra_V2(5,'s08',[1 100])
appendspectra_V2(6,'s08',[1 100])

% temprod_dataviewer(index,subject,freqband,K,debiasing,interpnoise,chandisplay,savetag)
temprod_dataviewer(1,'s04',[8 14],[1],1,1,0,1)
temprod_dataviewer(2,'s04',[8 14],[1],1,1,0,1)
temprod_dataviewer(3,'s04',[8 14],[1],1,1,0,1)
temprod_dataviewer(4,'s04',[8 14],[1],1,1,0,1)
temprod_dataviewer(1,'s05',[8 14],[1],1,1,0,1)
temprod_dataviewer(2,'s05',[8 14],[1],1,1,0,1)
temprod_dataviewer(3,'s05',[8 14],[1],1,1,0,1)
temprod_dataviewer(1,'s06',[8 14],[1],1,1,0,1)
temprod_dataviewer(2,'s06',[8 14],[1],1,1,0,1)
temprod_dataviewer(3,'s06',[8 14],[1],1,1,0,1)
temprod_dataviewer(4,'s06',[8 14],[1],1,1,0,1)
temprod_dataviewer(1,'s07',[9 15],[1],1,1,0,1)
temprod_dataviewer(2,'s07',[9 15],[1],1,1,0,1)
temprod_dataviewer(3,'s07',[9 15],[1],1,1,0,1)
temprod_dataviewer(4,'s07',[9 15],[1],1,1,0,1)
temprod_dataviewer(5,'s07',[9 15],[1],1,1,0,1)
temprod_dataviewer(6,'s07',[9 15],[1],1,1,0,1)
temprod_dataviewer(2,'s08',[7 12],[1],1,1,0,1)
temprod_dataviewer(3,'s08',[7 12],[1],1,1,0,1)
temprod_dataviewer(4,'s08',[7 12],[1],1,1,0,1)
temprod_dataviewer(5,'s08',[7 12],[1],1,1,0,1)
temprod_dataviewer(6,'s08',[7 12],[1],1,1,0,1)

% temprod_dataviewer_AP(index,subject,freqband,K,debiasing,interpnoise,chandisplay,APtag,LRtag,savetag)
temprod_dataviewer_AP(1,'s04',[8 14],[1],0,1,0,'P','L&R',1)
temprod_dataviewer_AP(1,'s04',[8 14],[1],0,1,0,'P','L&R',1)
temprod_dataviewer_AP(1,'s04',[8 14],[1],0,1,0,'P','L&R',1)
temprod_dataviewer_AP(1,'s04',[8 14],[1],0,1,0,'A','L&R',1)
temprod_dataviewer_AP(1,'s04',[8 14],[1],0,1,0,'A','L&R',1)
temprod_dataviewer_AP(1,'s04',[8 14],[1],0,1,0,'A','L&R',1)

% temprod_dataviewer_clusters(index,subject,freqband,K,debiasing,interpnoise,chandisplay,savetag)
temprod_dataviewer_clusters(1,'s04',[8 14],[1 2 1],1,1,0,1)
temprod_dataviewer_clusters(2,'s04',[8 14],[1 2 1],1,1,0,1)
temprod_dataviewer_clusters(3,'s04',[8 14],[1 2 1],1,1,0,1)
temprod_dataviewer_clusters(4,'s04',[8 14],[1 2 1],1,1,0,1)
temprod_dataviewer_clusters(1,'s05',[8 14],[1 2 1],1,1,0,1)
temprod_dataviewer_clusters(2,'s05',[8 14],[1 2 1],1,1,0,1)
temprod_dataviewer_clusters(3,'s05',[8 14],[1 2 1],1,1,0,1)
temprod_dataviewer_clusters(1,'s06',[8 14],[1 2 1],1,1,0,1)
temprod_dataviewer_clusters(2,'s06',[8 14],[1 2 1],1,1,0,1)
temprod_dataviewer_clusters(3,'s06',[8 14],[1 2 1],1,1,0,1)
temprod_dataviewer_clusters(4,'s06',[8 14],[1 2 1],1,1,0,1)
temprod_dataviewer_clusters(1,'s07',[9 15],[1 2 1],1,1,0,1)
temprod_dataviewer_clusters(2,'s07',[9 15],[1 2 1],1,1,0,1)
temprod_dataviewer_clusters(3,'s07',[9 15],[1 2 1],1,1,0,1)
temprod_dataviewer_clusters(4,'s07',[9 15],[1 2 1],1,1,0,1)
temprod_dataviewer_clusters(5,'s07',[9 15],[1 2 1],1,1,0,1)

temprod_dataviewer_clusters(6,'s07',[9 15],[1 2 1],1,1,0,1)
temprod_dataviewer_clusters(2,'s08',[7 12],[1 2 1],1,1,0,1)
temprod_dataviewer_clusters(3,'s08',[7 12],[1 2 1],1,1,0,1)
temprod_dataviewer_clusters(4,'s08',[7 12],[1 2 1],1,1,0,1)
temprod_dataviewer_clusters(5,'s08',[7 12],[1 2 1],1,1,0,1)
temprod_dataviewer_clusters(6,'s08',[7 12],[1 2 1],1,1,0,1)

% temprod_removetrial(indexrun,subject,trialvector)
temprod_removetrial_EEG(1,'s06',[29 67])
temprod_removetrial_EEG(2,'s06',[30 53 54 75])
temprod_removetrial_EEG(3,'s06',[3 16 56 69])
temprod_removetrial_EEG(4,'s06',[10 17 56 72])

temprod_removetrial_EEG(1,'s06',[])
temprod_removetrial_EEG(2,'s06',[52])
temprod_removetrial_EEG(3,'s06',[29])
temprod_removetrial_EEG(4,'s06',[52,63])

temprod_preproc_EEG(1,1,'s06',2,1)
temprod_preproc_EEG(2,1,'s06',2,1)
temprod_preproc_EEG(3,1,'s06',2,1)
temprod_preproc_EEG(4,1,'s06',2,1)

temprod_freqanalysis_eeg(0,1,'s06',[1 100])
temprod_freqanalysis_eeg(0,2,'s06',[1 100])
temprod_freqanalysis_eeg(0,3,'s06',[1 100])
temprod_freqanalysis_eeg(0,4,'s06',[1 100])

appendspectra_EEG(1,'s06',[1 100])
appendspectra_EEG(2,'s06',[1 100])
appendspectra_EEG(3,'s06',[1 100])
appendspectra_EEG(4,'s06',[1 100])

% temprod_dataviewer_EEG(index,subject,freqband,K,debiasing,interpnoise,chandisplay,savetag)
temprod_dataviewer_EEG(1,'s06',[5 15],[1],0,1,0,1)
temprod_dataviewer_EEG(2,'s06',[4 8],[1],0,1,0,1)
temprod_dataviewer_EEG(3,'s06',[4 8],[1],0,1,0,1)
temprod_dataviewer_EEG(4,'s06',[4 8],[1],0,1,0,1)

% function appendspectra_V2(indexrun,subject,freqband)
appendspectra_V2(1,'s04',[2 100])
appendspectra_V2(2,'s06',[2 100])
appendspectra_V2(3,'s06',[2 100])
appendspectra_V2(4,'s06',[2 100])
appendspectra_V2(5,'s06',[2 100])

% temprod_freqcorrchan(freqband,indexrun,ptreshold,subject)
temprod_freqcorrchan([8 14],1,0.05,'s06')
temprod_freqcorrchan([8 14],2,0.05,'s06')
temprod_freqcorrchan([8 14],3,0.05,'s06')
temprod_freqcorrchan([8 14],4,0.05,'s06')

%% RUN ICA %%
% temprod_ICA_V4(index,subject,freqband,method,numcomponent,show)
temprod_ICA_V6(1,'s04',[1 125],'sobi',15,1)
temprod_ICA_viewer(1,'s04',15,[2 125],'sobi')

temprod_ICA_V5(1,'s04',[1 125],'runica',15,1)
temprod_ICA_viewer(1,'s04',15,[2 125],'runica')

temprod_ICA_V6_parafac(1,'s04',[2 125],15)
temprod_ICA_V6_parafac(2,'s04',[2 125],15)
temprod_ICA_V6_parafac(3,'s04',[2 125],15)
temprod_ICA_V6_parafac(4,'s04',[2 125],15)
temprod_ICA_viewer(1,'s04',15,[2 125],'parafac')
temprod_ICA_viewer(2,'s04',15,[2 125],'parafac')
temprod_ICA_viewer(3,'s04',15,[2 125],'parafac')
temprod_ICA_viewer(4,'s04',15,[2 125],'parafac')

temprod_ICA_V5(1,'s03',[2 120],'runica',15,0.5)
temprod_ICA_V5(2,'s03',[2 120],'runica',15,0.5)
temprod_ICA_V5(3,'s03',[2 120],'runica',15,0.5)
temprod_ICA_V5(4,'s03',[2 120],'runica',15,0.5)
temprod_ICA_V5(5,'s03',[2 120],'runica',15,0.5)
temprod_ICA_V5(6,'s03',[2 120],'runica',15,0.5)

temprod_ICA_viewer(1,'s03',15,[2 120],'runica')
temprod_ICA_viewer(2,'s03',15,[2 120],'runica')
temprod_ICA_viewer(3,'s03',15,[2 120],'runica')
temprod_ICA_viewer(4,'s03',15,[2 120],'runica')
temprod_ICA_viewer(5,'s03',15,[2 120],'runica')
temprod_ICA_viewer(6,'s03',15,[2 120],'runica')

temprod_ICA_viewer(1,'s04',15,[2 120],'runica')
temprod_ICA_viewer(2,'s04',15,[2 120],'runica')
temprod_ICA_viewer(3,'s04',15,[2 120],'runica')
temprod_ICA_viewer(4,'s04',15,[2 120],'runica')

temprod_ICA_viewer_EEG(1,'s06',15,[2 30])
temprod_ICA_viewer_EEG(2,'s06',15,[2 30])
temprod_ICA_viewer_EEG(3,'s06',15,[2 30])
temprod_ICA_viewer_EEG(4,'s06',15,[2 30])

% temprod_ICA_MagsOnly(index,subject,freqband,method,numcomponent,show)
% temprod_ICA_GradslongOnly(index,subject,freqband,method,numcomponent,show)
% temprod_ICA_GradslatOnly(index,subject,freqband,method,numcomponent,show)

% temprod_ICA_globalview(index,subject,method,threshold,freqband,K,show,AxisHandle)
nrun = 2:6;
subject ='s08';
threshold = 0.05;
freqband = {[1 4];[4 8];[7 12];[14 25];[30 80]};
for x = 1:nrun
    for y = 1:length(freqband)
        temprod_ICA_globalview_v4(x,subject,'Pearson',threshold,freqband{y},[1 2 1],1);
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ERFs, ERPs analysis
% temprod_preproc_timelock(run,isdownsample,subject,runref,rejection)
% temprod_timelock(index,subject,savetag,show)
temprod_preproc_timelock(1,1,'s04',2,1)
temprod_preproc_timelock(2,1,'s04',2,1)
temprod_preproc_timelock(3,1,'s04',2,1)
temprod_preproc_timelock(1,1,'s05',2,1)
temprod_preproc_timelock(2,1,'s05',2,1)
temprod_preproc_timelock(3,1,'s05',2,1)
temprod_preproc_timelock(1,1,'s06',2,1)
temprod_preproc_timelock(2,1,'s06',2,1)
temprod_preproc_timelock(3,1,'s06',2,1)
temprod_preproc_timelock(4,1,'s06',2,1)
temprod_preproc_timelock(1,1,'s07',4,1)
temprod_preproc_timelock(2,1,'s07',4,1)
temprod_preproc_timelock(3,1,'s07',4,1)
temprod_preproc_timelock(4,1,'s07',4,1)
temprod_preproc_timelock(5,1,'s07',4,1)
temprod_preproc_timelock(6,1,'s07',4,1)

temprod_timelock_t0(1,'s04',1,1);
temprod_timelock_t0(2,'s04',1,1);
temprod_timelock_t0(3,'s04',1,1);
temprod_timelock_t0(1,'s05',1,1);
temprod_timelock_t0(2,'s05',1,1);
temprod_timelock_t0(3,'s05',1,1);
temprod_timelock_t0(1,'s06',1,1);
temprod_timelock_t0(2,'s06',1,1);
temprod_timelock_t0(3,'s06',1,1);
temprod_timelock_t0(4,'s06',1,1);
temprod_timelock_t0(1,'s07',1,1);
temprod_timelock_t0(2,'s07',1,1);
temprod_timelock_t0(3,'s07',1,1);
temprod_timelock_t0(4,'s07',1,1);
temprod_timelock_t0(5,'s07',1,1);
temprod_timelock_t0(6,'s07',1,1);


%% spectral variance
% temprod_dataviewer_var(indexes,subject,freqband,debiasing,loglogdetrend,datatoplot,mode,savetag)
[pkss08,locs08] = temprod_dataviewer_var([2 3 4 5 6],'s08',[1 50],0,0,'MEAN','old',1);
[pkss04,locs04] = temprod_dataviewer_var([1 2 3 4],'s04',[3 45],0,0,'MEAN','old',1);
[pkss05,locs05] = temprod_dataviewer_var([1 2 3],'s05',[1 50],0,0,'MEAN','old',1);
[pkss06,locs06] = temprod_dataviewer_var([1 2 3 4],'s06',[1 50],0,0,'MEAN','old',1);
[pkss07,locs07] = temprod_dataviewer_var([1 2 3 4 5 6],'s07',[1 50],0,0,'MEAN','old',1);
temprod_dataviewer_var([1 2 3 4 5 6],'s03',[50 120],0,0,'MEAN','old',1);
temprod_dataviewer_var([1 2 3 4 5 6],'s03',[50 120],0,0,'STD','old',1);
temprod_dataviewer_var_clusters([1 2 3 4 5 6],'s03',[1 15],0,0,'MEAN','old',1);
temprod_dataviewer_var_clusters([1 2 3 4 5 6],'s03',[1 15],0,0,'STD','old',1);

temprod_dataviewer_var_EEG([1 2 3 4],'s06',[2 50],1,0,'MEAN','old',1);
temprod_dataviewer_var_EEG([1 2 3 4],'s06',[50 100],1,0,'MEAN','old',1);
temprod_dataviewer_var_EEG([1 2 3 4],'s06',[2 50],1,0,'STD','old',1);
temprod_dataviewer_var_EEG([1 2 3 4],'s06',[50 100],1,0,'STD','old',1);
temprod_dataviewer_var([1 2 3 4],'s06',[1 50],1,0,'MEAN','old',1);
temprod_dataviewer_var([1 2 3 4],'s06',[50 100],1,0,'MEAN','old',1);
temprod_dataviewer_var([1 2 3 4],'s06',[1 50],1,0,'STD','old',1);
temprod_dataviewer_var([1 2 3 4],'s06',[50 100],1,0,'STD','old',1);

temprod_dataviewer_var_clusters([2 3 4 5 6],'s08',[2 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_clusters([1 2 3 4],'s04',[2 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_clusters([1 2 3],'s05',[2 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_clusters([1 2 3 4],'s06',[2 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_clusters([1 2 3 4 5 6],'s07',[2 50],0,0,'MEAN','old',1);

temprod_dataviewer_var_clusters([2 3 4 5 6],'s08',[2 50],0,0,'STD','old',1);
temprod_dataviewer_var_clusters([1 2 3 4],'s04',[2 50],0,0,'STD','old',1);
temprod_dataviewer_var_clusters([1 2 3],'s05',[2 50],0,0,'STD','old',1);
temprod_dataviewer_var_clusters([1 2 3 4],'s06',[2 50],0,0,'STD','old',1);
temprod_dataviewer_var_clusters([1 2 3 4 5 6],'s07',[2 50],0,0,'STD','old',1);

% temprod_dataviewer_var_clusters_half(indexrun,subject,freqband,debiasing,loglogdetrend,datatoplot,mode,savetag)
temprod_dataviewer_var_half(1,'s04',[2 50],0,0,'STD','old',1);
temprod_dataviewer_var_half(2,'s04',[2 50],0,0,'STD','old',1);
temprod_dataviewer_var_half(3,'s04',[2 50],0,0,'STD','old',1);
temprod_dataviewer_var_half(4,'s04',[2 50],0,0,'STD','old',1);
temprod_dataviewer_var_half(1,'s04',[2 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_half(2,'s04',[2 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_half(3,'s04',[2 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_half(4,'s04',[2 50],0,0,'MEAN','old',1);

temprod_dataviewer_var_half(1,'s05',[2 50],0,0,'STD','old',1);
temprod_dataviewer_var_half(2,'s05',[2 50],0,0,'STD','old',1);
temprod_dataviewer_var_half(3,'s05',[2 50],0,0,'STD','old',1);
temprod_dataviewer_var_half(1,'s05',[2 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_half(2,'s05',[2 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_half(3,'s05',[2 50],0,0,'MEAN','old',1);

temprod_dataviewer_var_half(1,'s06',[2 50],0,0,'STD','old',1);
temprod_dataviewer_var_half(2,'s06',[2 50],0,0,'STD','old',1);
temprod_dataviewer_var_half(3,'s06',[2 50],0,0,'STD','old',1);
temprod_dataviewer_var_half(4,'s06',[2 50],0,0,'STD','old',1);
temprod_dataviewer_var_half(1,'s06',[2 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_half(2,'s06',[2 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_half(3,'s06',[2 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_half(4,'s06',[2 50],0,0,'MEAN','old',1);

temprod_dataviewer_var_half(1,'s07',[2 50],0,0,'STD','old',1);
temprod_dataviewer_var_half(2,'s07',[2 50],0,0,'STD','old',1);
temprod_dataviewer_var_half(3,'s07',[2 50],0,0,'STD','old',1);
temprod_dataviewer_var_half(4,'s07',[2 50],0,0,'STD','old',1);
temprod_dataviewer_var_half(5,'s07',[2 50],0,0,'STD','old',1);
temprod_dataviewer_var_half(6,'s07',[2 50],0,0,'STD','old',1);
temprod_dataviewer_var_half(1,'s07',[2 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_half(2,'s07',[2 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_half(3,'s07',[2 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_half(4,'s07',[2 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_half(5,'s07',[2 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_half(6,'s07',[2 50],0,0,'MEAN','old',1);

temprod_dataviewer_var_half(2,'s08',[2 50],0,0,'STD','old',1);
temprod_dataviewer_var_half(3,'s08',[2 50],0,0,'STD','old',1);
temprod_dataviewer_var_half(4,'s08',[2 50],0,0,'STD','old',1);
temprod_dataviewer_var_half(5,'s08',[2 50],0,0,'STD','old',1);
temprod_dataviewer_var_half(6,'s08',[2 50],0,0,'STD','old',1);
temprod_dataviewer_var_half(2,'s08',[2 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_half(3,'s08',[2 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_half(4,'s08',[2 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_half(5,'s08',[2 50],0,0,'MEAN','old',1);
temprod_dataviewer_var_half(6,'s08',[2 50],0,0,'MEAN','old',1);

%% I got the pawaaaaaa!!!!

% function temprod_ICA_viewer(indexrun,subject,numcomponent)

% temprod_ICA_FreqPow_corr_V2(indexrun,subject,numcomponent,fsample,freqband)
indexrun       = [1:3 1:3 1:4 1:6 2:6];
subject        = {'s04';'s04';'s04';'s05';'s05';'s05';'s06';'s06';'s06';'s06';...
                  's07';'s07';'s07';'s07';'s07';'s07';'s08';'s08';'s08';'s08';'s08';};
freqband       = [1 7];
for i          = 1:length(indexrun)
    temprod_FreqPow_corr(indexrun(i),subject{i},freqband)
end
for i          = 1:length(indexrun)
    temprod_FreqPow_corr_V1(indexrun(i),subject{i},freqband)
end
for i          = 1:length(indexrun)
    temprod_FreqPow_corr_V2(indexrun(i),subject{i},freqband)
end

%% alpha-peak frequency vs behavioral correlations


%% correlations
temprod_FreqPow_corr_allbands(1,'s04')
temprod_FreqPow_corr_allbands(2,'s04')
temprod_FreqPow_corr_allbands(3,'s04')
temprod_FreqPow_corr_allbands(1,'s05')
temprod_FreqPow_corr_allbands(2,'s05')
temprod_FreqPow_corr_allbands(3,'s05')
temprod_FreqPow_corr_allbands(1,'s06')
temprod_FreqPow_corr_allbands(2,'s06')
temprod_FreqPow_corr_allbands(3,'s06')
temprod_FreqPow_corr_allbands(3,'s06')
temprod_FreqPow_corr_allbands(1,'s07')
temprod_FreqPow_corr_allbands(2,'s07')
temprod_FreqPow_corr_allbands(3,'s07')
temprod_FreqPow_corr_allbands(4,'s07')
temprod_FreqPow_corr_allbands(5,'s07')
temprod_FreqPow_corr_allbands(6,'s07')
temprod_FreqPow_corr_allbands(2,'s08')
temprod_FreqPow_corr_allbands(3,'s08')
temprod_FreqPow_corr_allbands(4,'s08')
temprod_FreqPow_corr_allbands(5,'s08')
temprod_FreqPow_corr_allbands(6,'s08')

temprod_FreqPow_corr_allbands_V1(1,'s04')
temprod_FreqPow_corr_allbands_V1(2,'s04')
temprod_FreqPow_corr_allbands_V1(3,'s04')
temprod_FreqPow_corr_allbands_V1(1,'s05')
temprod_FreqPow_corr_allbands_V1(2,'s05')
temprod_FreqPow_corr_allbands_V1(3,'s05')
temprod_FreqPow_corr_allbands_V1(1,'s06')
temprod_FreqPow_corr_allbands_V1(2,'s06')
temprod_FreqPow_corr_allbands_V1(3,'s06')
temprod_FreqPow_corr_allbands_V1(3,'s06')
temprod_FreqPow_corr_allbands_V1(1,'s07')
temprod_FreqPow_corr_allbands_V1(2,'s07')
temprod_FreqPow_corr_allbands_V1(3,'s07')
temprod_FreqPow_corr_allbands_V1(4,'s07')
temprod_FreqPow_corr_allbands_V1(5,'s07')
temprod_FreqPow_corr_allbands_V1(6,'s07')
temprod_FreqPow_corr_allbands_V1(2,'s08')
temprod_FreqPow_corr_allbands_V1(3,'s08')
temprod_FreqPow_corr_allbands_V1(4,'s08')
temprod_FreqPow_corr_allbands_V1(5,'s08')
temprod_FreqPow_corr_allbands_V1(6,'s08')

temprod_FreqPow_corr_allbands_V2(1,'s04')
temprod_FreqPow_corr_allbands_V2(2,'s04')
temprod_FreqPow_corr_allbands_V2(3,'s04')
temprod_FreqPow_corr_allbands_V2(1,'s05')
temprod_FreqPow_corr_allbands_V2(2,'s05')
temprod_FreqPow_corr_allbands_V2(3,'s05')
temprod_FreqPow_corr_allbands_V2(1,'s06')
temprod_FreqPow_corr_allbands_V2(2,'s06')
temprod_FreqPow_corr_allbands_V2(3,'s06')
temprod_FreqPow_corr_allbands_V2(3,'s06')
temprod_FreqPow_corr_allbands_V2(1,'s07')
temprod_FreqPow_corr_allbands_V2(2,'s07')
temprod_FreqPow_corr_allbands_V2(3,'s07')
temprod_FreqPow_corr_allbands_V2(4,'s07')
temprod_FreqPow_corr_allbands_V2(5,'s07')
temprod_FreqPow_corr_allbands_V2(6,'s07')
temprod_FreqPow_corr_allbands_V2(2,'s08')
temprod_FreqPow_corr_allbands_V2(3,'s08')
temprod_FreqPow_corr_allbands_V2(4,'s08')
temprod_FreqPow_corr_allbands_V2(5,'s08')
temprod_FreqPow_corr_allbands_V2(6,'s08')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%

