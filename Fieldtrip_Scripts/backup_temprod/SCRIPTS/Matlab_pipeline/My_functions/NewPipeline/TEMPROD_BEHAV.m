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
    addpath 'C:\TEMPROD\SCRIPTS/Matlab_pipeline/My_functions/ForR'
    
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
    addpath 'C:\TEMPROD\SCRIPTS/Matlab_pipeline/My_functions/ForR'
    
end

% temprod_BehaviorSummary(subject,RunNum,fsample,TD,savetag)
RunNum{1,14}    = [2 3 5 6];
fsample{1,14}   = [1 1 1 1]*1000; 
% TD{1,14}        = [5.7 8.5 5.7 5.7 8.5 5.7];  
TD{1,14}        = [5.7 8.5 5.7 8.5]; 
subject{1,14}   = 's14';
ER{1,14}        = [1 1 1 1];
% [meds14,meAns14,SDs14,meAnnorms14,DUR14] = temprod_BehaviorSummary(subject{1,14},RunNum{1,14},fsample{1,14},TD{1,14},'Laptop');
[Qm14, Qstd14, Rcorr14, Pcorr14] = temprod_BehaviorQuartile(subject{1,14},RunNum{1,14},fsample{1,14},TD{1,14},'Laptop');
meds{1,14} = meds14; means{1,14} = meAns14; sds{1,14} = SDs14;

RunNum{1,13}    = 2:7;
fsample{1,13}   = [1 1 1 1 1 1]*1000; 
TD{1,13}        = [5.7 8.5 5.7 5.7 8.5 5.7];  
subject{1,13}   = 's13';
ER{1,13}        = [1 1 0 1 1 0];
[meds13,meAns13,SDs13,meAnnorms13,DUR13] = temprod_BehaviorSummary(subject{1,13},RunNum{1,13},fsample{1,13},TD{1,13},'Laptop');
meds{1,13} = meds13; means{1,13} = meAns13; sds{1,13} = SDs13;

RunNum{1,12}    = 2:7;
fsample{1,12}   = [1 1 1 1 1 1]*1000; 
TD{1,12}        = [5.7 8.5 5.7 5.7 8.5 5.7];  
subject{1,12}   = 's12';
ER{1,12}        = [1 1 0 1 1 0];
[meds12,meAns12,SDs12,meAnnorms12,DUR12] = temprod_BehaviorSummary(subject{1,12},RunNum{1,12},fsample{1,12},TD{1,12},'Laptop');
meds{1,12} = meds12; means{1,12} = meAns12; sds{1,12} = SDs12;

RunNum{1,11}    = 2:5;
fsample{1,11}   = [1 1 1 1]*1000; 
TD{1,11}        = [5.7 8.5 5.7 5.7];  
subject{1,11}   = 's11';
ER{1,11}        = [1 1 0 1];
[meds11,meAns11,SDs11,meAnnorms11,DUR11] = temprod_BehaviorSummary(subject{1,11},RunNum{1,11},fsample{1,11},TD{1,11},'Laptop');
meds{1,11} = meds11; means{1,11} = meAns11; sds{1,11} = SDs11;

RunNum{1,10}    = 2:7;
fsample{1,10}   = [1 1 1 1 1 1]*1000; 
TD{1,10}        = [5.7 8.5 5.7 5.7 8.5 5.7];  
subject{1,10}   = 's10';
ER{1,10}        = [1 1 0 1 1 0];
[meds10,meAns10,SDs10,meAnnorms10,DUR10] = temprod_BehaviorSummary_s10(subject{1,10},RunNum{1,10},fsample{1,10},TD{1,10},'Laptop');
meds{1,10} = meds10; means{1,10} = meAns10; sds{1,10} = SDs10;

RunNum{1,8}     = 2:6;
fsample{1,8}    = [1 1 1 1 1]*1000; 
TD{1,8}         = [6.5 8.5 6.5 6.5 8.5]; 
ER{1,8}         = [1 1 1 1 1];
subject{1,8}    = 's08';
[meds08,meAns08,SDs08,meAnnorms08,DUR08] = temprod_BehaviorSummary(subject{1,8},RunNum{1,8},fsample{1,8},TD{1,8},'Laptop');
meds{1,8} = meds08; means{1,8} = meAns08; sds{1,8} = SDs08;

RunNum{1,7}     = 1:6;
fsample{1,7}    = [2 2 1 1 1 1]*1000; 
TD{1,7}         = [6.5 8.5 6.5 6.5 8.5 8.5];  
ER{1,7}         = [1 1 1 1 1 1];
subject{1,7}    = 's07';
[meds07,meAns07,SDs07,meAnnorms07,DUR07] = temprod_BehaviorSummary(subject{1,7},RunNum{1,7},fsample{1,7},TD{1,7},'Laptop');
meds{1,7} = meds07; means{1,7} = meAns07; sds{1,7} = SDs07;

RunNum{1,6}     = 1:4;
fsample{1,6}    = [1 1 1 1]*1000; 
TD{1,6}         = [6.5 8.5 6.5 8.5];  
ER{1,6}         = [1 1 1 1];
subject{1,6}    = 's06';
[meds06,meAns06,SDs06,meAnnorms06,DUR06] = temprod_BehaviorSummary(subject{1,6},RunNum{1,6},fsample{1,6},TD{1,6},'Laptop');
meds{1,6} = meds06; means{1,6} = meAns06; sds{1,6} = SDs06;

RunNum{1,5}     = 1:3;
fsample{1,5}    = [1 1 1]*1000; 
TD{1,5}         = [6.5 8.5 6.5]; 
ER{1,5}         = [1 1 1];
subject{1,5}    = 's05';
[meds05,meAns05,SDs05,meAnnorms05,DUR05] = temprod_BehaviorSummary(subject{1,5},RunNum{1,5},fsample{1,5},TD{1,5},'Laptop');
meds{1,5} = meds05; means{1,5} = meAns05; sds{1,5} = SDs05;

RunNum{1,4}     = 1:3;
fsample{1,4}    = [1 1 1]*1000; 
TD{1,4}         = [5.7 12.8 9.3];  
subject{1,4}    = 's04';
ER{1,4}         = [1 1 1];
[meds04,meAns04,SDs04,meAnnorms04,DUR04] = temprod_BehaviorSummary(subject{1,4},RunNum{1,4},fsample{1,4},TD{1,4},'Laptop');
meds{1,4} = meds04; means{1,4} = meAns04; sds{1,4} = SDs04;

RunNum{1,3}     = 1:6;
fsample{1,3}    = [1 1 1 1 1 1]*1000; 
TD{1,3}         = [17.3 0.75 11.7 2.8 1.7 5.2];  
subject{1,3}    = 's03';
ER{1,3}         = [1 1 1 1 1 1];
[meds03,meAns03,SDs03,meAnnorms03,DUR03] = temprod_BehaviorSummary(subject{1,3},RunNum{1,3},fsample{1,3},TD{1,3},'Laptop');
meds{1,3} = meds03; means{1,3} = meAns03; sds{1,3} = SDs03;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
close all
tag = 'Laptop';

subjectArray{1} = 's14'; RunNum{1} = [2 3 5 6];fsample{1} = [1000 1000 1000 1000];
% [f14,p14,ps14] = temprod_BehaviorFFT_RT_v5(subjectArray(1),RunNum(1),fsample(1),tag);
[pxx14] = temprod_BehaviorFFT_RT_v6(subjectArray(1),RunNum(1),fsample(1),tag);

subjectArray{2} = 's13'; RunNum{2} = [2 3 5 6];fsample{2} = [1000 1000 1000 1000];
% [f13,p13,ps13] = temprod_BehaviorFFT_RT_v5(subjectArray(2),RunNum(2),fsample(2),tag);
[pxx13] = temprod_BehaviorFFT_RT_v6(subjectArray(2),RunNum(2),fsample(2),tag);

subjectArray{3} = 's12'; RunNum{3} = [2 3 5 6];fsample{3} = [1000 1000 1000 1000];
% [f12,p12,ps12] = temprod_BehaviorFFT_RT_v5(subjectArray(3),RunNum(3),fsample(3),tag);
[pxx12] = temprod_BehaviorFFT_RT_v6(subjectArray(3),RunNum(3),fsample(3),tag);

subjectArray{4} = 's11'; RunNum{4} = [2 3 5];fsample{4} = [1000 1000 1000];
% [f11,p11,ps11] = temprod_BehaviorFFT_RT_v5(subjectArray(4),RunNum(4),fsample(4),tag);
[pxx11] = temprod_BehaviorFFT_RT_v6(subjectArray(4),RunNum(4),fsample(4),tag);

subjectArray{5} = 's10'; RunNum{5} = [2 3 5];fsample{5} = [1000 1000 1000];
% [f10,p10,ps10] = temprod_BehaviorFFT_RT_v5(subjectArray(5),RunNum(5),fsample(5),tag);
[pxx10] = temprod_BehaviorFFT_RT_v6(subjectArray(5),RunNum(5),fsample(5),tag);

subjectArray{6} = 's08'; RunNum{6} = 2:6;fsample{6} = [1000 1000 1000 1000 1000];
% [f8,p8,ps8] = temprod_BehaviorFFT_RT_v5(subjectArray(6),RunNum(6),fsample(6),tag);
[pxx8] = temprod_BehaviorFFT_RT_v6(subjectArray(6),RunNum(6),fsample(6),tag);

subjectArray{7} = 's07'; RunNum{7} = 1:6;fsample{7} = [2000 2000 1000 1000 1000 1000];
% [f7,p7,ps7] = temprod_BehaviorFFT_RT_v5(subjectArray(7),RunNum(7),fsample(7),tag);
[pxx7] = temprod_BehaviorFFT_RT_v6(subjectArray(7),RunNum(7),fsample(7),tag);

subjectArray{8} = 's06'; RunNum{8} = 1:4;fsample{8} = [1000 1000 1000 1000];
% [f6,p6,ps6] = temprod_BehaviorFFT_RT_v5(subjectArray(8),RunNum(8),fsample(8),tag);
[pxx8] = temprod_BehaviorFFT_RT_v6(subjectArray(8),RunNum(8),fsample(8),tag);

subjectArray{9} = 's05'; RunNum{9} = 1:3;fsample{9} = [1000 1000 1000];
% [f5,p5,ps5] = temprod_BehaviorFFT_RT_v5(subjectArray(9),RunNum(9),fsample(9),tag);
[pxx9] = temprod_BehaviorFFT_RT_v6(subjectArray(9),RunNum(9),fsample(9),tag);

subjectArray{10} = 's04'; RunNum{10} = 1:3;fsample{10} = [1000 1000 1000];
% [f4,p4,ps4] = temprod_BehaviorFFT_RT_v5(subjectArray(10),RunNum(10),fsample(10),tag);
[pxx10] = temprod_BehaviorFFT_RT_v6(subjectArray(10),RunNum(10),fsample(10),tag);

subjectArray{11} = 's03'; RunNum{11} = 1:6;fsample{11} = [1000 1000 1000 1000 1000 10000];
% [f3,p3,ps3] = temprod_BehaviorFFT_RT_v5(subjectArray(11),RunNum(11),fsample(11),tag);
[pxx11] = temprod_BehaviorFFT_RT_v6(subjectArray(11),RunNum(11),fsample(11),tag);

% [f,p] = temprod_BehaviorFFT_RT_v5(subjectArray,RunNum,fsample,tag);
% 
% p12_bis = resample(ps12,1,2);
% p13_bis = resample(ps13,1,2);
% p14_bis = resample(ps14,1,2);
% p8_bis  = resample(ps8,1,2);
% p7_bis  = resample(ps7,1,2);
% p6_bis  = resample(ps6,1,2);
% p5_bis  = resample(ps5,1,2);
% p4_bis  = resample(ps4,1,2);
% p3_bis  = resample(ps3,1,4);
% 
% MeanPow = mean([p3_bis' p4_bis' p5_bis' p6_bis' p7_bis' p8_bis' ...
%                 p10' p11' p12_bis' p13_bis' p14_bis']');
% 
% plot(f10,MeanPow)

MeanPsd = mean([pxx9(1:129) pxx8(1:129) pxx7(1:129) pxx10(1:129) pxx11(1:129) ...
                pxx12(1:129) pxx13(1:129) pxx14(1:129)]');
plot(MeanPsd)            


