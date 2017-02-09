%% TEMPROD ANALYSIS
clear all
close all

tag = 'Laptop';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if strcmp(tag,'Laptop') == 1
    
    %% SET PATHS %%
    
    addpath(genpath('C:\FIELDTRIP\fieldtrip-20111020'));
%     ft_defaults
%     addpath '/neurospin/local/mne/i686/share/matlab/'
    addpath 'C:\TEMPROD\SCRIPTS/Matlab_pipeline/My_functions/Main'
    addpath 'C:\TEMPROD\SCRIPTS/Matlab_pipeline/My_functions/Behavior'
    addpath 'C:\TEMPROD\SCRIPTS/Matlab_pipeline/My_functions/Preprocessing'
    addpath 'C:\TEMPROD\SCRIPTS/Matlab_pipeline/My_functions/Frequency'
    addpath 'C:\TEMPROD\SCRIPTS/Matlab_pipeline/My_functions/Timelock'
    addpath 'C:\TEMPROD\SCRIPTS/Matlab_pipeline/My_functions/ICA'
    addpath 'C:\TEMPROD\SCRIPTS/Matlab_pipeline/My_functions/Misc'
    addpath 'C:\TEMPROD\SCRIPTS/Matlab_pipeline/My_functions/Time-Frequency'
    addpath 'C:\TEMPROD\SCRIPTS/Matlab_pipeline/My_functions/n_way_toolbox'
    addpath 'C:\TEMPROD\SCRIPTS/Matlab_pipeline/My_functions/cw_entrainfreq'
    addpath 'C:\TEMPROD\SCRIPTS/Matlab_pipeline/My_functions/NewPipeline'
    
elseif strcmp(tag,'Network') == 1
    
    %% SET PATHS %%
    % rmpath(genpath('/neurospin/local/fieldtrip'))
    % addpath(genpath('/neurospin/meg/meg_tmp/fieldtrip-20110201'));
    % addpath(genpath('/neurospin/meg/meg_tmp/fieldtrip-20110404'));
    addpath(genpath('/neurospin/local/fieldtrip'));
%     ft_defaults
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
    addpath 'C:\TEMPROD\SCRIPTS/Matlab_pipeline/My_functions/NewPipeline'   
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% temprod_BehaviorSummary(subject,RunNum,fsample,TD,savetag)
RunNum     = 2:7;
fsample    = [1 1 1 1 1 1]*1000;
TD         = [5.7 8.5 5.7 5.7 8.5 5.7];
subject    = 's14';
[meds14,meAns14,SDs14,meAnnorms14] = temprod_BehaviorSummary(subject,RunNum,fsample,TD,1);
% temprod_BehaviorFFT_RT(subject,RunNum,fsample,TD)

RunNum     = 2:7;
fsample    = [1 1 1 1 1 1]*1000;
TD         = [5.7 8.5 5.7 5.7 8.5 5.7];
subject    = 's13';
% [meds13,meAns13,SDs13,meAnnorms13] = temprod_BehaviorSummary(subject,RunNum,fsample,TD,1);
temprod_BehaviorFFT_RT(subject,RunNum,fsample,TD)

RunNum     = 2:7;
fsample    = [1 1 1 1 1 1]*1000;
TD         = [5.7 8.5 5.7 5.7 8.5 5.7];
subject    = 's12';
% [meds12,meAns12,SDs12,meAnnorms12] = temprod_BehaviorSummary(subject,RunNum,fsample,TD,1);
temprod_BehaviorFFT_RT(subject,RunNum,fsample,TD)
temprod_BehaviorFFT_RT(subject,RunNum,fsample,TD)

RunNum     = 2:5;
fsample    = [1 1 1 1]*1000;
TD         = [5.7 8.5 5.7 5.7];
subject    = 's11';
% [meds11,meAns11,SDs11,meAnnorms11] = temprod_BehaviorSummary(subject,RunNum,fsample,TD,1);
temprod_BehaviorFFT_RT(subject,RunNum,fsample,TD)

RunNum     = 2:7;
fsample    = [1 1 1 1 1 1]*1000;
TD         = [5.7 8.5 5.7 5.7 8.5 5.7];
subject    = 's10';
% [meds10,meAns10,SDs10,meAnnorms10] = temprod_BehaviorSummary_s10(subject,RunNum,fsample,TD,1);
temprod_BehaviorFFT_RT(subject,RunNum,fsample,TD)

RunNum     = 2:6;
fsample    = [1 1 1 1 1]*1000;
TD         = [6.5 8.5 6.5 6.5 8.5];
subject    = 's08';
% [meds08,meAns08,SDs08,meAnnorms08] = temprod_BehaviorSummary(subject,RunNum,fsample,TD,1);
temprod_BehaviorFFT_RT(subject,RunNum,fsample,TD)

RunNum     = 1:6;
fsample    = [2 2 1 1 1 1]*1000;
TD         = [6.5 8.5 6.5 6.5 8.5 8.5];
subject    = 's07';
% [meds07,meAns07,SDs07,meAnnorms07] = temprod_BehaviorSummary(subject,RunNum,fsample,TD,1);
temprod_BehaviorFFT_RT(subject,RunNum,fsample,TD)

RunNum     = 1:4;
fsample    = [1 1 1 1]*1000;
TD         = [6.5 8.5 6.5 8.5];
subject    = 's06';
% [meds06,meAns06,SDs06,meAnnorms06] = temprod_BehaviorSummary(subject,RunNum,fsample,TD,1);
temprod_BehaviorFFT_RT(subject,RunNum,fsample,TD)

RunNum     = 1:3;
fsample    = [1 1 1]*1000;
TD         = [6.5 8.5 6.5];
subject    = 's05';
% [meds05,meAns05,SDs05,meAnnorms05] = temprod_BehaviorSummary(subject,RunNum,fsample,TD,1);
temprod_BehaviorFFT_RT(subject,RunNum,fsample,TD)

RunNum     = 1:3;
fsample    = [1 1 1]*1000;
TD         = [5.7 12.8 9.3];
subject    = 's04';
% [meds04,meAns04,SDs04,meAnnorms04] = temprod_BehaviorSummary(subject,RunNum,fsample,TD,1);
temprod_BehaviorFFT_RT(subject,RunNum,fsample,TD)

RunNum     = 1:6;
fsample    = [1 1 1 1 1 1]*1000;
TD         = [17.3 0.75 11.7 2.8 1.7 5.2];
subject    = 's03';
% [meds03,meAns03,SDs03,meAnnorms03] = temprod_BehaviorSummary(subject,RunNum,fsample,TD,1);
temprod_BehaviorFFT_RT(subject,RunNum,fsample,TD)

[pkss03,locs03] = temprod_dataviewer_var([1 2 3 4 5 6],'s03',[4 15],0,0,'MEAN','old',1);
[pkss04,locs04] = temprod_dataviewer_var([1 2 3 4],'s04',[4 15],0,0,'MEAN','old',1);
[pkss05,locs05] = temprod_dataviewer_var([1 2 3],'s05',[4 15],0,0,'MEAN','old',1);
[pkss06,locs06] = temprod_dataviewer_var([1 2 3 4],'s06',[4 15],0,0,'MEAN','old',1);
[pkss07,locs07] = temprod_dataviewer_var([1 2 3 4 5 6],'s07',[4 15],0,0,'MEAN','old',1);
[pkss08,locs08] = temprod_dataviewer_var([2 3 4 5 6],'s08',[4 15],0,0,'MEAN','old',1);
[pkss10,locs10] = temprod_dataviewer_var([2 3 4 5 6 7],'s10',[4 15],0,0,'MEAN','old',1);
[pkss11,locs11] = temprod_dataviewer_var([2 3 4 5],'s11',[4 15],0,0,'MEAN','old',1);
[pkss12,locs12] = temprod_dataviewer_var([2 3 4 5 6 7],'s12',[4 15],0,0,'MEAN','old',1);
[pkss13,locs13] = temprod_dataviewer_var([2 3 4 5 6 7],'s13',[4 15],0,0,'MEAN','old',1);
[pkss14,locs14] = temprod_dataviewer_var([2 3 4 5 6 7],'s14',[4 15],0,0,'MEAN','old',1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

arraysubject = {'s03';'s04';'s05';'s06';'s07';'s08';'s10';'s11';'s12';'s13';'s14'};
arrayindex   = {[1:6];[1:4];[1:3];[2:4];[1:6];[2:6];[2:7];[2:5];[2:7];[2:7];[2:7]};
freqband     = [1 4];
temprod_corrslope(arraysubject,arrayindex,freqband)

arraysubject = {'s03';'s04';'s05';'s06';'s07';'s08';'s10';'s11';'s12';'s13';'s14'};
arrayindex   = {[1:6];[1:4];[1:3];[2:4];[1:6];[2:6];[2:7];[2:5];[2:7];[2:7];[2:7]};
freqband     = [1 7];
temprod_corrslope(arraysubject,arrayindex,freqband)

arraysubject = {'s03';'s04';'s05';'s06';'s07';'s08';'s10';'s11';'s12';'s13';'s14'};
arrayindex   = {[1:6];[1:4];[1:3];[2:4];[1:6];[2:6];[2:7];[2:5];[2:7];[2:7];[2:7]};
freqband     = [4 7];
temprod_corrslope(arraysubject,arrayindex,freqband)

arraysubject = {'s03';'s04';'s05';'s06';'s07';'s08';'s10';'s11';'s12';'s13';'s14'};
arrayindex   = {[1:6];[1:4];[1:3];[2:4];[1:6];[2:6];[2:7];[2:5];[2:7];[2:7];[2:7]};
freqband     = [30 80];
temprod_corrslope(arraysubject,arrayindex,freqband)

arraysubject = {'s03';'s04';'s05';'s06';'s07';'s08';'s10';'s11';'s12';'s13';'s14'};
arrayindex   = {[1:6];[1:4];[1:3];[2:4];[1:6];[2:6];[2:7];[2:5];[2:7];[2:7];[2:7]};
freqband     = [30 120];
temprod_corrslope(arraysubject,arrayindex,freqband)

arraysubject = {'s06';'s11';'s12';'s13';'s14'};
arrayindex   = {[2:4];[2:5];[2:7];[2:7];[2:7]};
freqband     = [1 4];
temprod_corr_slope_EEG(arraysubject,arrayindex,freqband)

arraysubject = {'s07';'s10';'s11';'s12';'s13';'s14'};
freqband = [1 4];
temprod_corrslope_V2(arraysubject,freqband,tag)
freqband = [1 7];
temprod_corrslope_V2(arraysubject,freqband,tag)
freqband = [4 7];
temprod_corrslope_V2(arraysubject,freqband,tag)
freqband = [30 80];
temprod_corrslope_V2(arraysubject,freqband,tag)
freqband = [30 120];
temprod_corrslope_V2(arraysubject,freqband,tag)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% estimation runs
arraysubject  = {'s04' ;'s05' ;'s06' ;'s07' ;'s08' ;'s10' ;'s11' ;'s12' ;'s13' ;'s14'};
arrayindex    = {[1:4] ;[1:3] ;[1:4] ;[1 2 3 5 6] ;[2 3 5 6] ;[2 3 5 6] ;[2 3 5] ;[2 3 5 6] ;[2 3 5 6] ;[2 3 5 6]};
arrayfreqband = {[7 14];[7 14];[7 14];[7 14];[7 14];[7 14];[7 14];[7 14];[7 14];[7 14]};
PowSubNormAlphaEst = temprod_halfdiff(arrayindex,arraysubject,arrayfreqband,'alphaestimation',1);
% replay runs
arraysubject  = {'s10' ;'s11' ;'s12' ;'s13' ;'s14'};
arrayindex    = {[4 7] ;[4] ;[4 7] ;[4 7] ;[4 7]};
arrayfreqband = {[7 14];[7 14];[7 14];[7 14];[7 14];[7 14]};
PowSubNormAlphaRep = temprod_halfdiff(arrayindex,arraysubject,arrayfreqband,'alphareplay',1);

% estimation runs
arraysubject  = {'s04' ;'s05' ;'s06' ;'s07' ;'s08' ;'s10' ;'s11' ;'s12' ;'s13' ;'s14'};
arrayindex    = {[1:4] ;[1:3] ;[1:4] ;[1 2 3 5 6] ;[2 3 5 6] ;[2 3 5 6] ;[2 3 5] ;[2 3 5 6] ;[2 3 5 6] ;[2 3 5 6]};
arrayfreqband = {[1 4];[1 4];[1 4];[1 4];[1 4];[1 4];[1 4];[1 4];[1 4];[1 4]};
PowSubNormDeltaEst = temprod_halfdiff(arrayindex,arraysubject,arrayfreqband,'deltaestimation',1);
% replay runs
arraysubject  = {'s10' ;'s11' ;'s12' ;'s13' ;'s14'};
arrayindex    = {[4 7] ;[4] ;[4 7] ;[4 7] ;[4 7]};
arrayfreqband = {[1 4];[1 4];[1 4];[1 4];[1 4];[1 4];[1 4];[1 4];[1 4];[1 4]};
PowSubNormDeltaRep = temprod_halfdiff(arrayindex,arraysubject,arrayfreqband,'deltaereplay',1);

% estimation runs
arraysubject  = {'s04' ;'s05' ;'s06' ;'s07' ;'s08' ;'s10' ;'s11' ;'s12' ;'s13' ;'s14'};
arrayindex    = {[1:4] ;[1:3] ;[1:4] ;[1 2 3 5 6] ;[2 3 5 6] ;[2 3 5 6] ;[2 3 5] ;[2 3 5 6] ;[2 3 5 6] ;[2 3 5 6]};
arrayfreqband = {[4 7];[4 7];[4 7];[4 7];[4 7];[4 7];[4 7];[4 7];[4 7];[4 7]};
PowSubNormThetaEst = temprod_halfdiff(arrayindex,arraysubject,arrayfreqband,'thetaestimation',1);
% replay runs
arraysubject  = {'s10' ;'s11' ;'s12' ;'s13' ;'s14'};
arrayindex    = {[4 7] ;[4] ;[4 7] ;[4 7] ;[4 7]};
arrayfreqband = {[4 7];[4 7];[4 7];[4 7];[4 7];[4 7];[4 7];[4 7];[4 7];[4 7]};
PowSubNormThetaRep = temprod_halfdiff(arrayindex,arraysubject,arrayfreqband,'thetareplay',1);

% estimation runs
arraysubject  = {'s04' ;'s05' ;'s06' ;'s07' ;'s08' ;'s10' ;'s11' ;'s12' ;'s13' ;'s14'};
arrayindex    = {[1:4] ;[1:3] ;[1:4] ;[1 2 3 5 6] ;[2 3 5 6] ;[2 3 5 6] ;[2 3 5] ;[2 3 5 6] ;[2 3 5 6] ;[2 3 5 6]};
arrayfreqband = {[1 7];[1 7];[1 7];[1 7];[1 7];[1 7];[1 7];[1 7];[1 7];[1 7]};
PowSubNormSlowEst = temprod_halfdiff(arrayindex,arraysubject,arrayfreqband,'slowestimation',1);
% replay runs
arraysubject  = {'s10' ;'s11' ;'s12' ;'s13' ;'s14'};
arrayindex    = {[4 7] ;[4] ;[4 7] ;[4 7] ;[4 7]};
arrayfreqband = {[1 7];[1 7];[1 7];[1 7];[1 7];[1 7];[1 7];[1 7];[1 7];[1 7]};
PowSubNormSlowRep = temprod_halfdiff(arrayindex,arraysubject,arrayfreqband,'slowreplay',1);

% estimation runs
arraysubject  = {'s04' ;'s05' ;'s06' ;'s07' ;'s08' ;'s10' ;'s11' ;'s12' ;'s13' ;'s14'};
arrayindex    = {[1:4] ;[1:3] ;[1:4] ;[1 2 3 5 6] ;[2 3 5 6] ;[2 3 5 6] ;[2 3 5] ;[2 3 5 6] ;[2 3 5 6] ;[2 3 5 6]};
arrayfreqband = {[15 30];[15 30];[15 30];[15 30];[15 30];[15 30];[15 30];[15 30];[15 30];[15 30]};
PowSubNormBetaEst = temprod_halfdiff(arrayindex,arraysubject,arrayfreqband,'betastimation',1);
% replay runs
arraysubject  = {'s10' ;'s11' ;'s12' ;'s13' ;'s14'};
arrayindex    = {[4 7] ;[4] ;[4 7] ;[4 7] ;[4 7]};
arrayfreqband = {[15 30];[15 30];[15 30];[15 30];[15 30];[15 30];[15 30];[15 30];[15 30];[15 30]};
PowSubNormBetaRep = temprod_halfdiff(arrayindex,arraysubject,arrayfreqband,'betareplay',1);

% estimation runs
arraysubject  = {'s04' ;'s05' ;'s06' ;'s07' ;'s08' ;'s10' ;'s11' ;'s12' ;'s13' ;'s14'};
arrayindex    = {[1:4] ;[1:3] ;[1:4] ;[1 2 3 5 6] ;[2 3 5 6] ;[2 3 5 6] ;[2 3 5] ;[2 3 5 6] ;[2 3 5 6] ;[2 3 5 6]};
arrayfreqband = {[30 80];[30 80];[30 80];[30 80];[30 80];[30 80];[30 80];[30 80];[30 80];[30 80]};
PowSubNormGammaEst = temprod_halfdiff(arrayindex,arraysubject,arrayfreqband,'gammaestimation',1);
% replay runs
arraysubject  = {'s10' ;'s11' ;'s12' ;'s13' ;'s14'};
arrayindex    = {[4 7] ;[4] ;[4 7] ;[4 7] ;[4 7]};
arrayfreqband = {[30 80];[30 80];[30 80];[30 80];[30 80];[30 80];[30 80];[30 80];[30 80];[30 80]};
PowSubNormGammaRep = temprod_halfdiff(arrayindex,arraysubject,arrayfreqband,'gammareplay',1);

%% est vs replay

[h,pslow] = ttest2(mean([PowSubNormSlowEst(:,1) PowSubNormSlowEst(:,2)]'),...
    mean([PowSubNormSlowRep(:,1) PowSubNormSlowRep(:,2)]'));

[h,pdelta] = ttest2(mean([PowSubNormDeltaEst(:,1) PowSubNormDeltaEst(:,2)]'),...
    mean([PowSubNormDeltaRep(:,1) PowSubNormDeltaRep(:,2)]'));

[h,ptheta] = ttest2(mean([PowSubNormThetaEst(:,1) PowSubNormThetaEst(:,2)]'),...
    mean([PowSubNormThetaRep(:,1) PowSubNormThetaRep(:,2)]'));

[h,palpha] = ttest2(mean([PowSubNormAlphaEst(:,1) PowSubNormAlphaEst(:,2)]'),...
    mean([PowSubNormAlphaRep(:,1) PowSubNormAlphaRep(:,2)]'));

[h,pbeta] = ttest2(mean([PowSubNormBetaEst(:,1) PowSubNormBetaEst(:,2)]'),...
    mean([PowSubNormBetaRep(:,1) PowSubNormBetaRep(:,2)]'));

[h,pgamma] = ttest2(mean([PowSubNormGammaEst(:,1) PowSubNormGammaEst(:,2)]'),...
    mean([PowSubNormGammaRep(:,1) PowSubNormGammaRep(:,2)]'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% STATS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% compute average normalized power 
Max_14_2 = temprod_preproc_half(2,1,'s14',4,1);
Max_14_4 = temprod_preproc_half(3,1,'s14',4,1);
Max_14_3 = temprod_preproc_half(4,1,'s14',4,1);
Max_14_5 = temprod_preproc_half(5,1,'s14',4,1);
Max_14_6 = temprod_preproc_half(6,1,'s14',4,1);
Max_14_3 = temprod_preproc_half(7,1,'s14',4,1);

Max_13_2 = temprod_preproc_half(2,1,'s13',4,1);
Max_13_3 = temprod_preproc_half(3,1,'s13',4,1);
Max_13_4 = temprod_preproc_half(4,1,'s13',4,1);
Max_13_5 = temprod_preproc_half(5,1,'s13',4,1);
Max_13_6 = temprod_preproc_half(6,1,'s13',4,1);
Max_13_7 = temprod_preproc_half(7,1,'s13',4,1);

Max_12_2 = temprod_preproc_half(2,1,'s12',4,1);
Max_12_3 = temprod_preproc_half(3,1,'s12',4,1);
Max_12_4 = temprod_preproc_half(4,1,'s12',4,1);
Max_12_5 = temprod_preproc_half(5,1,'s12',4,1);
Max_12_6 = temprod_preproc_half(6,1,'s12',4,1);
Max_12_7 = temprod_preproc_half(7,1,'s12',4,1);

Max_11_2 = temprod_preproc_half(2,1,'s11',4,1);
Max_11_3 = temprod_preproc_half(3,1,'s11',4,1);
Max_11_4 = temprod_preproc_half(4,1,'s11',4,1);
Max_11_5 = temprod_preproc_half(5,1,'s11',4,1);

Max_10_2 = temprod_preproc_half_s10(2,1,'s10',4,1);
Max_10_3 = temprod_preproc_half_s10(3,1,'s10',4,1);
Max_10_4 = temprod_preproc_half_s10(4,1,'s10',4,1);
Max_10_5 = temprod_preproc_half_s10(5,1,'s10',4,1);
Max_10_6 = temprod_preproc_half_s10(6,1,'s10',4,1);
Max_10_7 = temprod_preproc_half_s10(7,1,'s10',4,1);

Max_08_2 = temprod_preproc_half(2,1,'s08',4,1);
Max_08_3 = temprod_preproc_half(3,1,'s08',4,1);
Max_08_4 = temprod_preproc_half(4,1,'s08',4,1);
Max_08_5 = temprod_preproc_half(5,1,'s08',4,1);
Max_08_6 = temprod_preproc_half(6,1,'s08',4,1);

Max_07_1 = temprod_preproc_half(1,1,'s07',4,1);
Max_07_2 = temprod_preproc_half(2,1,'s07',4,1);
Max_07_3 = temprod_preproc_half(3,1,'s07',4,1);
Max_07_3 = temprod_preproc_half(4,1,'s07',4,1);
Max_07_5 = temprod_preproc_half(5,1,'s07',4,1);
Max_07_6 = temprod_preproc_half(6,1,'s07',4,1);

Max_06_1 = temprod_preproc_half(1,1,'s06',4,1);
Max_06_2 = temprod_preproc_half(2,1,'s06',4,1);
Max_06_3 = temprod_preproc_half(3,1,'s06',4,1);
Max_06_4 = temprod_preproc_half(4,1,'s06',4,1);

Max_05_1 = temprod_preproc_half(1,1,'s05',4,1);
Max_05_2 = temprod_preproc_half(2,1,'s05',4,1);
Max_05_3 = temprod_preproc_half(3,1,'s05',4,1);

Max_04_1 = temprod_preproc_half(1,1,'s04',4,1);
Max_04_2 = temprod_preproc_half(2,1,'s04',4,1);
Max_04_3 = temprod_preproc_half(3,1,'s04',4,1);
Max_04_4 = temprod_preproc_half(4,1,'s04',4,1);

M = max([Max_14_2 Max_14_3 Max_14_5 Max_14_6          ...
         Max_13_2 Max_13_3 Max_13_5 Max_13_6          ...
         Max_12_2 Max_12_3 Max_12_5 Max_12_6          ...
         Max_11_2 Max_11_3 Max_11_5                   ...
         Max_10_2 Max_10_3 Max_10_5 Max_10_6          ...
         Max_08_2 Max_08_3 Max_08_5 Max_08_6          ...
         Max_07_1 Max_07_2 Max_07_3 Max_07_5 Max_07_6 ...
         Max_06_1 Max_06_2 Max_06_3 Max_06_4          ...
         Max_05_1 Max_05_2 Max_05_3                   ...
         Max_04_1 Max_04_2 Max_04_3 Max_04_4]);

M = 12600;
     
temprod_freqanalysis_half_V2(2,'s14',M,[0.3 120]);
temprod_freqanalysis_half_V2(3,'s14',M,[0.3 120]);
temprod_freqanalysis_half_V2(5,'s14',M,[0.3 120]);
temprod_freqanalysis_half_V2(6,'s14',M,[0.3 120]);

temprod_freqanalysis_half_V2(2,'s13',M,[0.3 120]);
temprod_freqanalysis_half_V2(3,'s13',M,[0.3 120]);
temprod_freqanalysis_half_V2(5,'s13',M,[0.3 120]);
temprod_freqanalysis_half_V2(6,'s13',M,[0.3 120]);

temprod_freqanalysis_half_V2(2,'s12',M,[0.3 120]);
temprod_freqanalysis_half_V2(3,'s12',M,[0.3 120]);
temprod_freqanalysis_half_V2(5,'s12',M,[0.3 120]);
temprod_freqanalysis_half_V2(6,'s12',M,[0.3 120]);

temprod_freqanalysis_half_V2(2,'s11',M,[0.3 120]);
temprod_freqanalysis_half_V2(3,'s11',M,[0.3 120]);
temprod_freqanalysis_half_V2(5,'s11',M,[0.3 120]);

temprod_freqanalysis_half_V2(2,'s10',M,[0.3 120]);
temprod_freqanalysis_half_V2(3,'s10',M,[0.3 120]);
temprod_freqanalysis_half_V2(5,'s10',M,[0.3 120]);
temprod_freqanalysis_half_V2(6,'s10',M,[0.3 120]);

temprod_freqanalysis_half_V2(2,'s08',M,[0.3 120]);
temprod_freqanalysis_half_V2(3,'s08',M,[0.3 120]);
temprod_freqanalysis_half_V2(5,'s08',M,[0.3 120]);
temprod_freqanalysis_half_V2(6,'s08',M,[0.3 120]);

temprod_freqanalysis_half_V2(1,'s07',M,[0.3 120]);
temprod_freqanalysis_half_V2(2,'s07',M,[0.3 120]);
temprod_freqanalysis_half_V2(3,'s07',M,[0.3 120]);
temprod_freqanalysis_half_V2(4,'s07',M,[0.3 120]);
temprod_freqanalysis_half_V2(5,'s07',M,[0.3 120]);
temprod_freqanalysis_half_V2(6,'s07',M,[0.3 120]);

temprod_freqanalysis_half_V2(1,'s06',M,[0.3 120]);
temprod_freqanalysis_half_V2(2,'s06',M,[0.3 120]);
temprod_freqanalysis_half_V2(3,'s06',M,[0.3 120]);
temprod_freqanalysis_half_V2(4,'s06',M,[0.3 120]);

temprod_freqanalysis_half_V2(1,'s05',M,[0.3 120]);
temprod_freqanalysis_half_V2(2,'s05',M,[0.3 120]);
temprod_freqanalysis_half_V2(3,'s05',M,[0.3 120]);

temprod_freqanalysis_half_V2(1,'s04',M,[0.3 120]);
temprod_freqanalysis_half_V2(2,'s04',M,[0.3 120]);
temprod_freqanalysis_half_V2(3,'s04',M,[0.3 120]);
temprod_freqanalysis_half_V2(4,'s04',M,[0.3 120]);

[SF_GAVG_14,LF_GAVG_14] = temprod_freqGDAVG_half([2 3 5 6  ],'s14',[0.3 120],'Estimation');
[SF_GAVG_13,LF_GAVG_13] = temprod_freqGDAVG_half([2 3 5 6  ],'s13',[0.3 120],'Estimation');
[SF_GAVG_12,LF_GAVG_12] = temprod_freqGDAVG_half([2 3 5 6  ],'s12',[0.3 120],'Estimation');
[SF_GAVG_11,LF_GAVG_11] = temprod_freqGDAVG_half([2 3 5    ],'s11',[0.3 120],'Estimation');
[SF_GAVG_10,LF_GAVG_10] = temprod_freqGDAVG_half([2 3 5 6  ],'s10',[0.3 120],'Estimation');
[SF_GAVG_08,LF_GAVG_08] = temprod_freqGDAVG_half([2 3 5 6  ],'s08',[0.3 120],'Estimation');
[SF_GAVG_07,LF_GAVG_07] = temprod_freqGDAVG_half([1 2 3 5 6],'s07',[0.3 120],'Estimation');
[SF_GAVG_06,LF_GAVG_06] = temprod_freqGDAVG_half([1 2 3 4  ],'s06',[0.3 120],'Estimation');
[SF_GAVG_05,LF_GAVG_05] = temprod_freqGDAVG_half([1 2 3    ],'s05',[0.3 120],'Estimation');
[SF_GAVG_04,LF_GAVG_04] = temprod_freqGDAVG_half([1 2 3 4  ],'s04',[0.3 120],'Estimation');

design = [ones(1,10) ones(1,10)*2 ; 1:10 1:10];

stats = temprod_freqstats_half([0.3 120],design,'max','Estimation_shortvsLong_max',...
SF_GAVG_14,SF_GAVG_13,SF_GAVG_12,SF_GAVG_11,SF_GAVG_10,...
SF_GAVG_08,SF_GAVG_07,SF_GAVG_06,SF_GAVG_05,SF_GAVG_04,...
LF_GAVG_14,LF_GAVG_13,LF_GAVG_12,LF_GAVG_11,LF_GAVG_10,...
LF_GAVG_08,LF_GAVG_07,LF_GAVG_06,LF_GAVG_05,LF_GAVG_04);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% STATS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

M = 12600;
% function [ShortFreq,LongFreq] = temprod_freqanalysis_half_v2(run,subject,Pad,freqband,alphapeak)     
temprod_freqanalysis_half_v2(2,'s14',M,[1 120],'Laptop');
temprod_freqanalysis_half_v2(3,'s14',M,[1 120],'Laptop');
temprod_freqanalysis_half_v2(4,'s14',M,[1 120],'Laptop');
temprod_freqanalysis_half_v2(5,'s14',M,[1 120],'Laptop');
temprod_freqanalysis_half_v2(6,'s14',M,[1 120],'Laptop');
temprod_freqanalysis_half_v2(7,'s14',M,[1 120],'Laptop');

temprod_freqanalysis_half_v2(2,'s13',M,[1 120],'Laptop');
temprod_freqanalysis_half_v2(3,'s13',M,[1 120],'Laptop');
temprod_freqanalysis_half_v2(4,'s13',M,[1 120],'Laptop');
temprod_freqanalysis_half_v2(5,'s13',M,[1 120],'Laptop');
temprod_freqanalysis_half_v2(6,'s13',M,[1 120],'Laptop');
temprod_freqanalysis_half_v2(7,'s13',M,[1 120],'Laptop');

temprod_freqanalysis_half_v2(2,'s12',M,[1 120],'Laptop');
temprod_freqanalysis_half_v2(3,'s12',M,[1 120],'Laptop');
temprod_freqanalysis_half_v2(4,'s12',M,[1 120],'Laptop');
temprod_freqanalysis_half_v2(5,'s12',M,[1 120],'Laptop');
temprod_freqanalysis_half_v2(6,'s12',M,[1 120],'Laptop');
temprod_freqanalysis_half_v2(7,'s12',M,[1 120],'Laptop');

temprod_freqanalysis_half_v2(2,'s11',M,[1 120],'Laptop');
temprod_freqanalysis_half_v2(3,'s11',M,[1 120],'Laptop');
temprod_freqanalysis_half_v2(4,'s11',M,[1 120],'Laptop');
temprod_freqanalysis_half_v2(5,'s11',M,[1 120],'Laptop');

temprod_freqanalysis_half_v2(2,'s10',M,[1 120],'Laptop');
temprod_freqanalysis_half_v2(3,'s10',M,[1 120],'Laptop');
temprod_freqanalysis_half_v2(4,'s10',M,[1 120],'Laptop');
temprod_freqanalysis_half_v2(5,'s10',M,[1 120],'Laptop');
temprod_freqanalysis_half_v2(6,'s10',M,[1 120],'Laptop');
temprod_freqanalysis_half_v2(7,'s10',M,[1 120],'Laptop');

temprod_freqanalysis_half_v2(2,'s08',M,[1 120]);
temprod_freqanalysis_half_v2(3,'s08',M,[1 120]);
temprod_freqanalysis_half_v2(4,'s08',M,[1 120]);
temprod_freqanalysis_half_v2(5,'s08',M,[1 120]);
temprod_freqanalysis_half_v2(6,'s08',M,[1 120]);

temprod_freqanalysis_half_v2(1,'s07',M,[1 120],'Laptop');
temprod_freqanalysis_half_v2(2,'s07',M,[1 120],'Laptop');
temprod_freqanalysis_half_v2(3,'s07',M,[1 120],'Laptop');
temprod_freqanalysis_half_v2(4,'s07',M,[1 120],'Laptop');
temprod_freqanalysis_half_v2(5,'s07',M,[1 120],'Laptop');
temprod_freqanalysis_half_v2(6,'s07',M,[1 120],'Laptop');

temprod_freqanalysis_half_v2(1,'s06',M,[0.5 120]);
temprod_freqanalysis_half_v2(2,'s06',M,[0.5 120]);
temprod_freqanalysis_half_v2(3,'s06',M,[0.5 120]);
temprod_freqanalysis_half_v2(4,'s06',M,[0.5 120]);

temprod_freqanalysis_half_v2(1,'s05',M,[0.5 120]);
temprod_freqanalysis_half_v2(2,'s05',M,[0.5 120]);
temprod_freqanalysis_half_v2(3,'s05',M,[0.5 120]);

temprod_freqanalysis_half_v2(1,'s04',M,[0.5 120]);
temprod_freqanalysis_half_v2(2,'s04',M,[0.5 120]);
temprod_freqanalysis_half_v2(3,'s04',M,[0.5 120]);
temprod_freqanalysis_half_v2(4,'s04',M,[0.5 120]);

% left hand

[SF_GAVG_14,LF_GAVG_14] = temprod_freqGDAVG_half_V2([2 3      ],'s14',[14 16],'MG_Estimation');
[SF_GAVG_13,LF_GAVG_13] = temprod_freqGDAVG_half_V2([2 3      ],'s13',[14 16],'MG_Estimation');
[SF_GAVG_12,LF_GAVG_12] = temprod_freqGDAVG_half_V2([2 3      ],'s12',[14 16],'MG_Estimation');
[SF_GAVG_11,LF_GAVG_11] = temprod_freqGDAVG_half_V2([2 3 5    ],'s11',[14 16],'MG_Estimation');
[SF_GAVG_10,LF_GAVG_10] = temprod_freqGDAVG_half_V2([2 3      ],'s10',[14 16],'MG_Estimation');
[SF_GAVG_08,LF_GAVG_08] = temprod_freqGDAVG_half_V2([6        ],'s08',[14 16],'MG_Estimation');
[SF_GAVG_07,LF_GAVG_07] = temprod_freqGDAVG_half_V2([4 5      ],'s07',[14 16],'MG_Estimation');
[SF_GAVG_06,LF_GAVG_06] = temprod_freqGDAVG_half_V2([1 2      ],'s06',[14 16],'MG_Estimation');
[SF_GAVG_05,LF_GAVG_05] = temprod_freqGDAVG_half_V2([1        ],'s05',[14 16],'MG_Estimation');
% [SF_GAVG_04,LF_GAVG_04] = temprod_freqGDAVG_half([1 2      ],'s04',[0.3 120],'Estimation');

design = [ones(1,9) ones(1,9)*2 ; 1:9 1:9];
stats = temprod_freqstats_half([14 16],design,'fdr','Estimation_shortvsLong_MG_fd_V2',...
SF_GAVG_14,SF_GAVG_13,SF_GAVG_12,SF_GAVG_11,SF_GAVG_10,...
SF_GAVG_08,SF_GAVG_07,SF_GAVG_06,SF_GAVG_05,...
LF_GAVG_14,LF_GAVG_13,LF_GAVG_12,LF_GAVG_11,LF_GAVG_10,...
LF_GAVG_08,LF_GAVG_07,LF_GAVG_06,LF_GAVG_05);
stats = temprod_freqstats_half([14 16],design,'no','Estimation_shortvsLong_MG_nocorrm_V2',...
SF_GAVG_14,SF_GAVG_13,SF_GAVG_12,SF_GAVG_11,SF_GAVG_10,...
SF_GAVG_08,SF_GAVG_07,SF_GAVG_06,SF_GAVG_05,...
LF_GAVG_14,LF_GAVG_13,LF_GAVG_12,LF_GAVG_11,LF_GAVG_10,...
LF_GAVG_08,LF_GAVG_07,LF_GAVG_06,LF_GAVG_05);

% right hand

[SF_GAVG_14,LF_GAVG_14] = temprod_freqGDAVG_half_V2([5 6      ],'s14',[14 16],'MD_Estimation');
[SF_GAVG_13,LF_GAVG_13] = temprod_freqGDAVG_half_V2([5 6      ],'s13',[14 16],'MD_Estimation');
[SF_GAVG_12,LF_GAVG_12] = temprod_freqGDAVG_half_V2([5 6      ],'s12',[14 16],'MD_Estimation');
[SF_GAVG_10,LF_GAVG_10] = temprod_freqGDAVG_half_V2([5 6      ],'s10',[14 16],'MD_Estimation');
[SF_GAVG_08,LF_GAVG_08] = temprod_freqGDAVG_half_V2([2 3 5    ],'s08',[14 16],'MD_Estimation');
[SF_GAVG_07,LF_GAVG_07] = temprod_freqGDAVG_half_V2([1 2      ],'s07',[14 16],'MD_Estimation');
[SF_GAVG_06,LF_GAVG_06] = temprod_freqGDAVG_half_V2([3 4      ],'s06',[14 16],'MD_Estimation');
[SF_GAVG_05,LF_GAVG_05] = temprod_freqGDAVG_half_V2([2 3      ],'s05',[14 16],'MD_Estimation');
% [SF_GAVG_04,LF_GAVG_04] = temprod_freqGDAVG_half([1 2      ],'s04',[0.3 120],'Estimation');

design = [ones(1,9) ones(1,9)*2 ; 1:9 1:9];
stats = temprod_freqstats_half([14 16],design,'fdr','Estimation_shortvsLong_MD_fdr_V2',...
SF_GAVG_14,SF_GAVG_13,SF_GAVG_12,SF_GAVG_11,SF_GAVG_10,...
SF_GAVG_08,SF_GAVG_07,SF_GAVG_06,SF_GAVG_05,...
LF_GAVG_14,LF_GAVG_13,LF_GAVG_12,LF_GAVG_11,LF_GAVG_10,...
LF_GAVG_08,LF_GAVG_07,LF_GAVG_06,LF_GAVG_05);
stats = temprod_freqstats_half([14 16],design,'no','Estimation_shortvsLong_MD_nocorrm_V2',...
SF_GAVG_14,SF_GAVG_13,SF_GAVG_12,SF_GAVG_11,SF_GAVG_10,...
SF_GAVG_08,SF_GAVG_07,SF_GAVG_06,SF_GAVG_05,...
LF_GAVG_14,LF_GAVG_13,LF_GAVG_12,LF_GAVG_11,LF_GAVG_10,...
LF_GAVG_08,LF_GAVG_07,LF_GAVG_06,LF_GAVG_05);


% both hands

[SF_GAVG_14,LF_GAVG_14] = temprod_freqGDAVG_half_V2([2 3 5 6  ],'s14',[1 3],'2M_Estimation');
[SF_GAVG_13,LF_GAVG_13] = temprod_freqGDAVG_half_V2([2 3 5 6  ],'s13',[1 3],'2M_Estimation');
[SF_GAVG_12,LF_GAVG_12] = temprod_freqGDAVG_half_V2([2 3 5 6  ],'s12',[1 3],'2M_Estimation');
[SF_GAVG_11,LF_GAVG_11] = temprod_freqGDAVG_half_V2([2 3 5    ],'s11',[1 3],'2M_Estimation');
[SF_GAVG_10,LF_GAVG_10] = temprod_freqGDAVG_half_V2([2 3 5 6  ],'s10',[1 3],'2M_Estimation');
[SF_GAVG_08,LF_GAVG_08] = temprod_freqGDAVG_half_V2([2 3 5 6  ],'s08',[1 3],'2M_Estimation');
[SF_GAVG_07,LF_GAVG_07] = temprod_freqGDAVG_half_V2([2 3 5 6  ],'s07',[1 3],'2M_Estimation');
[SF_GAVG_06,LF_GAVG_06] = temprod_freqGDAVG_half_V2([1 2 3 4  ],'s06',[1 3],'2M_Estimation');
[SF_GAVG_05,LF_GAVG_05] = temprod_freqGDAVG_half_V2([1 2 3    ],'s05',[1 3],'2M_Estimation');
[SF_GAVG_04,LF_GAVG_04] = temprod_freqGDAVG_half_V2([1 2 3    ],'s04',[1 3],'2M_Estimation');

design = [ones(1,10) ones(1,10)*2 ; 1:10 1:10];
stats = temprod_freqstats_half([1 3],design,'no','Estimation_shortvsLong_2M_nocoorm_V2',...
SF_GAVG_14,SF_GAVG_13,SF_GAVG_12,SF_GAVG_11,SF_GAVG_10,...
SF_GAVG_08,SF_GAVG_07,SF_GAVG_06,SF_GAVG_05,SF_GAVG_04,...
LF_GAVG_14,LF_GAVG_13,LF_GAVG_12,LF_GAVG_11,LF_GAVG_10,...
LF_GAVG_08,LF_GAVG_07,LF_GAVG_06,LF_GAVG_05,LF_GAVG_04);
stats = temprod_freqstats_half([1 3],design,'fdr','Estimation_shortvsLong_2M_fdr_V2',...
SF_GAVG_14,SF_GAVG_13,SF_GAVG_12,SF_GAVG_11,SF_GAVG_10,...
SF_GAVG_08,SF_GAVG_07,SF_GAVG_06,SF_GAVG_05,SF_GAVG_04,...
LF_GAVG_14,LF_GAVG_13,LF_GAVG_12,LF_GAVG_11,LF_GAVG_10,...
LF_GAVG_08,LF_GAVG_07,LF_GAVG_06,LF_GAVG_05,LF_GAVG_04);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% REPLAY %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% both hands
[SF_GAVG_14,LF_GAVG_14] = temprod_freqGDAVG_half_V2([4 7],'s14',[1 3],'2M_Replay');
[SF_GAVG_13,LF_GAVG_13] = temprod_freqGDAVG_half_V2([4 7],'s13',[1 3],'2M_Replay');
[SF_GAVG_12,LF_GAVG_12] = temprod_freqGDAVG_half_V2([4 7],'s12',[1 3],'2M_Replay');
[SF_GAVG_11,LF_GAVG_11] = temprod_freqGDAVG_half_V2([4  ],'s11',[1 3],'2M_Replay');
[SF_GAVG_10,LF_GAVG_10] = temprod_freqGDAVG_half_V2([4 7],'s10',[1 3],'2M_Replay');
[SF_GAVG_07,LF_GAVG_07] = temprod_freqGDAVG_half_V2([1 6],'s07',[1 3],'2M_Replay');

design = [ones(1,6) ones(1,6)*2 ; 1:6 1:6];
stats = temprod_freqstats_half([1 3],design,'no','Replay_shortvsLong_2M_nocoorm_V2',...
SF_GAVG_14,SF_GAVG_13,SF_GAVG_12,SF_GAVG_11,SF_GAVG_10,SF_GAVG_07,...
LF_GAVG_14,LF_GAVG_13,LF_GAVG_12,LF_GAVG_11,LF_GAVG_10,LF_GAVG_07);
stats = temprod_freqstats_half([1 3],design,'fdr','Replay_shortvsLong_2M_fdr_V2',...
SF_GAVG_14,SF_GAVG_13,SF_GAVG_12,SF_GAVG_11,SF_GAVG_10,SF_GAVG_07,...
LF_GAVG_14,LF_GAVG_13,LF_GAVG_12,LF_GAVG_11,LF_GAVG_10,LF_GAVG_07);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% with 1/F removal
tagdetrend     = 'withdetrend';
root           = SetPath(tag);
freqbandselect = [1 120];
subjects       = {'s07';'s10';'s11';'s12';'s13';'s14'};
cond           = '2M_Est_5.7';
[xaxis,est_diff_57] = GDAVG_half_viewer_V2(subjects,[1 120],cond,tag);
%
subjects       = {'s07';'s10';'s11';'s12';'s13';'s14'};
cond           = '2M_Est_8.5';
[xaxis,est_diff_85] = GDAVG_half_viewer_V2(subjects,[1 120],cond,tag);
%
subjects       = {'s07';'s10';'s11';'s12';'s13';'s14'};
cond           = '2M_Est_all';
[xaxis,est_diff] = GDAVG_half_viewer_V2(subjects,[1 120],cond,tag);
%
subjects       = {'s07';'s10';'s11';'s12';'s13';'s14'};
cond           = '2M_Replay';
[xaxis,rep_diff] = GDAVG_half_viewer_V2(subjects,[1 120],cond,tag);
%
subjects       = {'s07';'s10';'s11';'s12';'s13';'s14'};
cond           = '2M_Replay_5.7';
[xaxis,rep_diff_57] = GDAVG_half_viewer_V2(subjects,[1 120],cond,tag);
%
subjects       = {'s07';'s10';'s12';'s13';'s14'};
cond           = '2M_Replay_8.5';
[xaxis,rep_diff_85] = GDAVG_half_viewer_V2(subjects,[1 120],cond,tag);

% without 1/F removal
tagdetrend     = 'nodetrend';
root           = SetPath(tag);
freqbandselect = [1 120];
subjects       = {'s07';'s10';'s11';'s12';'s13';'s14'};
cond           = '2M_Est_5.7';
[xaxis,est_diff_57] = GDAVG_half_viewer_v3(subjects,[1 120],cond,tag);
%
subjects       = {'s07';'s10';'s11';'s12';'s13';'s14'};
cond           = '2M_Est_8.5';
[xaxis,est_diff_85] = GDAVG_half_viewer_v3(subjects,[1 120],cond,tag);
%
subjects       = {'s07';'s10';'s11';'s12';'s13';'s14'};
cond           = '2M_Est_all';
[xaxis,est_diff] = GDAVG_half_viewer_v3(subjects,[1 120],cond,tag);
%
subjects       = {'s07';'s10';'s11';'s12';'s13';'s14'};
cond           = '2M_Replay';
[xaxis,rep_diff] = GDAVG_half_viewer_v3(subjects,[1 120],cond,tag);
%
subjects       = {'s07';'s10';'s11';'s12';'s13';'s14'};
cond           = '2M_Replay_5.7';
[xaxis,rep_diff_57] = GDAVG_half_viewer_v3(subjects,[1 120],cond,tag);
%
subjects       = {'s07';'s10';'s12';'s13';'s14'};
cond           = '2M_Replay_8.5';
[xaxis,rep_diff_85] = GDAVG_half_viewer_v3(subjects,[1 120],cond,tag);

% mags
semilogx(xaxis,(est_diff(1,:) - rep_diff(1,:)),'linewidth',2)
axis([min(xaxis) max(xaxis) min(est_diff(1,:) - rep_diff(1,:)) max(est_diff(1,:) - rep_diff(1,:))])
title('Estall(Long-Short) - Repall(Long-Short)')
set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
line([min(xaxis) max(xaxis)],[0 0],'color','k','linewidth',2)
grid('on')
print('-dpng',TheSlasher([root '/DATA/NEW/across_subjects_plots' ...
        '/Estall(L-S)-Repall(L-S)_mags_' num2str(freqbandselect(1)) '-' num2str(freqbandselect(2)) '_GAVG_' tagdetrend '_V2.png'],tag));
% grads1
semilogx(xaxis,(est_diff(2,:) - rep_diff(2,:)),'linewidth',2)
axis([min(xaxis) max(xaxis) min(est_diff(2,:) - rep_diff(2,:)) max(est_diff(2,:) - rep_diff(2,:))])
title('Estall(Long-Short) - Repall(Long-Short)')
set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
line([min(xaxis) max(xaxis)],[0 0],'color','k','linewidth',2)
grid('on')
print('-dpng',TheSlasher([root '/DATA/NEW/across_subjects_plots' ...
        '/Estall(L-S)-Repall(L-S)_grads1_' num2str(freqbandselect(1)) '-' num2str(freqbandselect(2)) '_GAVG_' tagdetrend '_V2.png'],tag));
% grads1
semilogx(xaxis,(est_diff(3,:) - rep_diff(3,:)),'linewidth',2)
axis([min(xaxis) max(xaxis) min(est_diff(3,:) - rep_diff(3,:)) max(est_diff(3,:) - rep_diff(3,:))])
title('Estall(Long-Short) - Repall(Long-Short)')
set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
line([min(xaxis) max(xaxis)],[0 0],'color','k','linewidth',2)
grid('on')
print('-dpng',TheSlasher([root '/DATA/NEW/across_subjects_plots' ...
        '/Estall(L-S)-Repall(L-S)_grads2_' num2str(freqbandselect(1)) '-' num2str(freqbandselect(2)) '_GAVG_' tagdetrend '_V2.png'],tag));
% 5.7s
% mags
semilogx(xaxis,(est_diff_57(1,:) - rep_diff_57(1,:)),'linewidth',2)
axis([min(xaxis) max(xaxis) min(est_diff_57(1,:) - rep_diff_57(1,:)) max(est_diff_57(1,:) - rep_diff_57(1,:))])
title('Est57(Long-Short) - Rep57(Long-Short)')
set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
line([min(xaxis) max(xaxis)],[0 0],'color','k','linewidth',2)
grid('on')
print('-dpng',TheSlasher([root '/DATA/NEW/across_subjects_plots' ...
        '/Est57(L-S)-Rep57(L-S)_mags_' num2str(freqbandselect(1)) '-' num2str(freqbandselect(2)) '_GAVG_' tagdetrend '_V2.png'],tag));
% grads1
semilogx(xaxis,(est_diff_57(2,:) - rep_diff_57(2,:)),'linewidth',2)
axis([min(xaxis) max(xaxis) min(est_diff_57(2,:) - rep_diff_57(2,:)) max(est_diff_57(2,:) - rep_diff_57(2,:))])
title('Est57(Long-Short) - Rep57(Long-Short)')
set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
line([min(xaxis) max(xaxis)],[0 0],'color','k','linewidth',2)
grid('on')
print('-dpng',TheSlasher([root '/DATA/NEW/across_subjects_plots' ...
        '/Est57(L-S)-Rep57(L-S)_grads1_' num2str(freqbandselect(1)) '-' num2str(freqbandselect(2)) '_GAVG_' tagdetrend '_V2.png'],tag));
% grads1
semilogx(xaxis,(est_diff(3,:) - rep_diff_57(3,:)),'linewidth',2)
axis([min(xaxis) max(xaxis) min(est_diff_57(3,:) - rep_diff_57(3,:)) max(est_diff_57(3,:) - rep_diff_57(3,:))])
title('Est57(Long-Short) - Rep57(Long-Short)')
set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
line([min(xaxis) max(xaxis)],[0 0],'color','k','linewidth',2)
grid('on')
print('-dpng',TheSlasher([root '/DATA/NEW/across_subjects_plots' ...
        '/Est57(L-S)-Rep57(L-S)_grads2_' num2str(freqbandselect(1)) '-' num2str(freqbandselect(2)) '_GAVG_' tagdetrend '_V2.png'],tag));
% 8.5s
% mags
semilogx(xaxis,(est_diff_85(1,:) - rep_diff_85(1,:)),'linewidth',2)
axis([min(xaxis) max(xaxis) min(est_diff_85(1,:) - rep_diff_85(1,:)) max(est_diff_85(1,:) - rep_diff_85(1,:))])
title('Est85(Long-Short) - Rep85(Long-Short)')
set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
line([min(xaxis) max(xaxis)],[0 0],'color','k','linewidth',2)
grid('on')
print('-dpng',TheSlasher([root '/DATA/NEW/across_subjects_plots' ...
        '/Est85(L-S)-Rep85(L-S)_mags_' num2str(freqbandselect(1)) '-' num2str(freqbandselect(2)) '_GAVG_' tagdetrend '_V2.png'],tag));
% grads1
semilogx(xaxis,(est_diff_85(2,:) - rep_diff_85(2,:)),'linewidth',2)
axis([min(xaxis) max(xaxis) min(est_diff_85(2,:) - rep_diff_85(2,:)) max(est_diff_85(2,:) - rep_diff_85(2,:))])
title('Est85(Long-Short) - Rep85(Long-Short)')
set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
line([min(xaxis) max(xaxis)],[0 0],'color','k','linewidth',2)
grid('on')
print('-dpng',TheSlasher([root '/DATA/NEW/across_subjects_plots' ...
        '/Est85(L-S)-Rep85(L-S)_grads1_' num2str(freqbandselect(1)) '-' num2str(freqbandselect(2)) '_GAVG_' tagdetrend '_V2.png'],tag));
% grads1
semilogx(xaxis,(est_diff_85(3,:) - rep_diff_85(3,:)),'linewidth',2)
axis([min(xaxis) max(xaxis) min(est_diff_85(3,:) - rep_diff_85(3,:)) max(est_diff_85(3,:) - rep_diff_85(3,:))])
title('Est85(Long-Short) - Rep85(Long-Short)')
set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
line([min(xaxis) max(xaxis)],[0 0],'color','k','linewidth',2)
grid('on')
print('-dpng',TheSlasher([root '/DATA/NEW/across_subjects_plots' ...
        '/Est85(L-S)-Rep85(L-S)_grads2_' num2str(freqbandselect(1)) '-' num2str(freqbandselect(2)) '_GAVG_' tagdetrend '_V2.png'],tag));
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subjects       = {'s07';'s10';'s11';'s12';'s13';'s14'};
freqbandselect = [7 14];
[SF_57, SP_57, LF_57, LP_57]                     = temprod_GDAVG_powerstats(subjects,freqbandselect,'2M_Est_5.7',tag);
[SF_85, SP_85, LF_85, LP_85]                     = temprod_GDAVG_powerstats(subjects,freqbandselect,'2M_Est_8.5',tag);
[SF_estall,SP_estall,LF_estall,LP_estall]        = temprod_GDAVG_powerstats(subjects,freqbandselect,'2M_Est_all',tag);
[SF_repall, SP_repall, LF_repall, LP_repall]     = temprod_GDAVG_powerstats(subjects,freqbandselect,'2M_replay',tag);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
arraysubjects = {'s07';'s10';'s11';'s12';'s13';'s14'};
arrayindex    = {[1:6];[2:7];[2:5];[2:7];[2:7];[2:7]};
[Min,Max] = temprod_getMinMax(arrayindex, arraysubjects, tag);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M = 12600;
temprod_freqanalysis_half_v3(2,'s14',M,[1 120],'Laptop');
temprod_freqanalysis_half_v3(3,'s14',M,[1 120],'Laptop');
temprod_freqanalysis_half_v3(4,'s14',M,[1 120],'Laptop');
temprod_freqanalysis_half_v3(5,'s14',M,[1 120],'Laptop');
temprod_freqanalysis_half_v3(6,'s14',M,[1 120],'Laptop');
temprod_freqanalysis_half_v3(7,'s14',M,[1 120],'Laptop');

temprod_freqanalysis_half_v3(2,'s13',M,[1 120],'Laptop');
temprod_freqanalysis_half_v3(3,'s13',M,[1 120],'Laptop');
temprod_freqanalysis_half_v3(4,'s13',M,[1 120],'Laptop');
temprod_freqanalysis_half_v3(5,'s13',M,[1 120],'Laptop');
temprod_freqanalysis_half_v3(6,'s13',M,[1 120],'Laptop');
temprod_freqanalysis_half_v3(7,'s13',M,[1 120],'Laptop');

temprod_freqanalysis_half_v3(2,'s12',M,[1 120],'Laptop');
temprod_freqanalysis_half_v3(3,'s12',M,[1 120],'Laptop');
temprod_freqanalysis_half_v3(4,'s12',M,[1 120],'Laptop');
temprod_freqanalysis_half_v3(5,'s12',M,[1 120],'Laptop');
temprod_freqanalysis_half_v3(6,'s12',M,[1 120],'Laptop');
temprod_freqanalysis_half_v3(7,'s12',M,[1 120],'Laptop');

temprod_freqanalysis_half_v3(2,'s11',M,[1 120],'Laptop');
temprod_freqanalysis_half_v3(3,'s11',M,[1 120],'Laptop');
temprod_freqanalysis_half_v3(4,'s11',M,[1 120],'Laptop');
temprod_freqanalysis_half_v3(5,'s11',M,[1 120],'Laptop');

temprod_freqanalysis_half_v3(2,'s10',M,[1 120],'Laptop');
temprod_freqanalysis_half_v3(3,'s10',M,[1 120],'Laptop');
temprod_freqanalysis_half_v3(4,'s10',M,[1 120],'Laptop');
temprod_freqanalysis_half_v3(5,'s10',M,[1 120],'Laptop');
temprod_freqanalysis_half_v3(6,'s10',M,[1 120],'Laptop');
temprod_freqanalysis_half_v3(7,'s10',M,[1 120],'Laptop');

temprod_freqanalysis_half_v3(1,'s07',M,[1 120],'Laptop');
temprod_freqanalysis_half_v3(2,'s07',M,[1 120],'Laptop');
temprod_freqanalysis_half_v3(3,'s07',M,[1 120],'Laptop');
temprod_freqanalysis_half_v3(4,'s07',M,[1 120],'Laptop');
temprod_freqanalysis_half_v3(5,'s07',M,[1 120],'Laptop');
temprod_freqanalysis_half_v3(6,'s07',M,[1 120],'Laptop');

temprod_freqanalysis_quarter_V3(2,'s14',M,[1 120],'Laptop');
temprod_freqanalysis_quarter_V3(3,'s14',M,[1 120],'Laptop');
temprod_freqanalysis_quarter_V3(4,'s14',M,[1 120],'Laptop');
temprod_freqanalysis_quarter_V3(5,'s14',M,[1 120],'Laptop');
temprod_freqanalysis_quarter_V3(6,'s14',M,[1 120],'Laptop');
temprod_freqanalysis_quarter_V3(7,'s14',M,[1 120],'Laptop');

temprod_freqanalysis_quarter_V3(2,'s13',M,[1 120],'Laptop');
temprod_freqanalysis_quarter_V3(3,'s13',M,[1 120],'Laptop');
temprod_freqanalysis_quarter_V3(4,'s13',M,[1 120],'Laptop');
temprod_freqanalysis_quarter_V3(5,'s13',M,[1 120],'Laptop');
temprod_freqanalysis_quarter_V3(6,'s13',M,[1 120],'Laptop');
temprod_freqanalysis_quarter_V3(7,'s13',M,[1 120],'Laptop');

temprod_freqanalysis_quarter_V3(2,'s12',M,[1 120],'Laptop');
temprod_freqanalysis_quarter_V3(3,'s12',M,[1 120],'Laptop');
temprod_freqanalysis_quarter_V3(4,'s12',M,[1 120],'Laptop');
temprod_freqanalysis_quarter_V3(5,'s12',M,[1 120],'Laptop');
temprod_freqanalysis_quarter_V3(6,'s12',M,[1 120],'Laptop');
temprod_freqanalysis_quarter_V3(7,'s12',M,[1 120],'Laptop');

temprod_freqanalysis_quarter_V3(2,'s11',M,[1 120],'Laptop');
temprod_freqanalysis_quarter_V3(3,'s11',M,[1 120],'Laptop');
temprod_freqanalysis_quarter_V3(4,'s11',M,[1 120],'Laptop');
temprod_freqanalysis_quarter_V3(5,'s11',M,[1 120],'Laptop');

temprod_freqanalysis_quarter_V3(2,'s10',M,[1 120],'Laptop');
temprod_freqanalysis_quarter_V3(3,'s10',M,[1 120],'Laptop');
temprod_freqanalysis_quarter_V3(4,'s10',M,[1 120],'Laptop');
temprod_freqanalysis_quarter_V3(5,'s10',M,[1 120],'Laptop');
temprod_freqanalysis_quarter_V3(6,'s10',M,[1 120],'Laptop');
temprod_freqanalysis_quarter_V3(7,'s10',M,[1 120],'Laptop');

temprod_freqanalysis_quarter_V3(1,'s07',M,[1 120],'Laptop');
temprod_freqanalysis_quarter_V3(2,'s07',M,[1 120],'Laptop');
temprod_freqanalysis_quarter_V3(3,'s07',M,[1 120],'Laptop');
temprod_freqanalysis_quarter_V3(4,'s07',M,[1 120],'Laptop');
temprod_freqanalysis_quarter_V3(5,'s07',M,[1 120],'Laptop');
temprod_freqanalysis_quarter_V3(6,'s07',M,[1 120],'Laptop');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

GDAVG_quarter_viewer_V3({'s07';'s10';'s11';'s12';'s13';'s14'},[2 120],'2M_Est_5.7','Laptop')
GDAVG_quarter_viewer({'s07';'s10';'s11';'s12';'s13';'s14'},[2 120],'2M_Est_5.7','Laptop')

interaction_script('s07')
interaction_script('s10')
interaction_script('s12')
interaction_script('s13')
interaction_script('s14')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

temprod_freqcorrchan([8 14],2,0.05,'s14','Laptop')
temprod_freqcorrchan([8 14],3,0.05,'s14','Laptop')
temprod_freqcorrchan([8 14],4,0.05,'s14','Laptop')
temprod_freqcorrchan([8 14],5,0.05,'s14','Laptop')
temprod_freqcorrchan([8 14],6,0.05,'s14','Laptop')
temprod_freqcorrchan([8 14],7,0.05,'s14','Laptop')

temprod_freqcorrchan([8 14],2,0.05,'s13','Laptop')
temprod_freqcorrchan([8 14],3,0.05,'s13','Laptop')
temprod_freqcorrchan([8 14],4,0.05,'s13','Laptop')
temprod_freqcorrchan([8 14],5,0.05,'s13','Laptop')
temprod_freqcorrchan([8 14],6,0.05,'s13','Laptop')
temprod_freqcorrchan([8 14],7,0.05,'s13','Laptop')

temprod_freqcorrchan([8 14],2,0.05,'s12','Laptop')
temprod_freqcorrchan([8 14],3,0.05,'s12','Laptop')
temprod_freqcorrchan([8 14],4,0.05,'s12','Laptop')
temprod_freqcorrchan([8 14],5,0.05,'s12','Laptop')
temprod_freqcorrchan([8 14],6,0.05,'s12','Laptop')
temprod_freqcorrchan([8 14],7,0.05,'s12','Laptop')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
temprod_FreqPow_corr_allbands_accuracy([2 3 4 5 6 7],[5700 8500 5700 5700 8500 5700],'s14',tag)
temprod_FreqPow_corr_allbands_accuracy([2 3 4 5 6 7],[5700 8500 5700 5700 8500 5700],'s13',tag)
temprod_FreqPow_corr_allbands_accuracy([2 3 4 5 6 7],[5700 8500 5700 5700 8500 5700],'s12',tag)
temprod_FreqPow_corr_allbands_accuracy([2 3 4 5    ],[5700 8500 5700 5700          ],'s11',tag)
temprod_FreqPow_corr_allbands_accuracy([2 3 4 5 6 7],[5700 8500 5700 5700 8500 5700],'s10',tag)
temprod_FreqPow_corr_allbands_accuracy([1 2 3 4 5 6],[5700 8500 5700 5700 8500 8500],'s07',tag)

