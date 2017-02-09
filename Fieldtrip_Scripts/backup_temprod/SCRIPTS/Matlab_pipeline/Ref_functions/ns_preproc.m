%% ns_preproc %%
% Preprocessing pipeline of raw recordings leading to clean, averaged
% data. Uses MaxFilter, Fieldtrip. 
% Parameters par are specific for each subject and experiment.
%
% Marco Buiatti, INSERM U992 Cognitive Neuroimaging Unit (France), 2010.


%% set path %%
addpath '/neurospin/local/mne/i686/share/matlab/'                               % MNE path
addpath '/neurospin/meg_tmp/tools_tmp/pipeline/'                                % path to processing scripts
fieldtrip
fieldtripdefs                                                                   % fieldtrip path

%% subject information, trigger definition and trial function %%
par = ns_par;

%% correct for Head Movement between runs %%
% Generate an SH script that computes head position for each run and save it in a txt file
ns_getheadmv(par);

% plot head movement rotation/translation coordinates across runs
dataheadmv=ns_checkheadmv(par); % dataheadmv contains all info on head movements for each run

% Based on the rotation/translation plot, choose a run as the ref for head movement (3 in this example) %
par.RunRef = 3;                                                                                                                                       

%% perform MaxFilter processing %%
% data saved in a folder specified by par.
% ref: www.unicog.org/pmwiki/pmwiki.php/Main/AnalysisWithMaxfilter
ns_maxfilter(par);

%% generate epoched fieldtrip dataset %%
data=ns_fif2ft(par);

%% artifact correction by removing PCA components computed with graph %%
% ref: www.unicog.org/pmwiki/pmwiki.php/Main/CheckingDataWithNeuromagTools section (3)
data=ns_pca(par,data);

%% baseline correction %%
for j=1:length(data.trial)
    data.trial{j} = ft_preproc_baselinecorrect(data.trial{j}, 1, data.fsample*par.PreStim);
end

%% visual artifact detection %%
% Load the sensor label file
load /neurospin/meg_tmp/tools_tmp/pipeline/SensorClassification.mat     % contains sensor label sets for plotting  
% select channel type and scale
cfg=[];
cfg.method='summary';
cfg.channel={'MEG','EOG'};
cfg.alim     = 4e-11; 
cfg.megscale = 1;
cfg.eogscale = 5e-7;
cfg.keepchannel='no';
data=ft_rejectvisual(cfg,data);     % ref: help ft_rejectvisual in matlab

%% save preprocessed data %%
save([par.DataDir par.Sub_Num '_pp'],'data','par','-v7.3');


%% Examples of further analysis and plotting %%

%% low-pass filtering %%
par.lpf = 40;           % low-pass frequency (Hz)
datalpf=data;
for j=1:length(datalpf.trial)
    disp(['low-pass filtering trial ' num2str(j)])
    datalpf.trial{j} = ft_preproc_lowpassfilter(datalpf.trial{j}, datalpf.fsample, par.lpf);
end

%% trial selection and average %%
trlvala=[1];      % example of trial values associated with condition a
trlvalb=[11];      % example of trial values associated with condition b
da = ns_trlsel_avg(data,trlvala);
db = ns_trlsel_avg(data,trlvalb);
data = ns_trlsel_avg(data,[]);  % average across all trials

%% plot %%
% to match labels in 'NM306all.lay'
da.avg.label=All;
db.avg.label=All;
data.avg.label=All;

% plot time courses arranged on the sensor location layout
figure
cfg = [];
cfg.showlabels = 'yes'; 
cfg.fontsize = 8; 
cfg.layout = 'NM306all.lay';
ft_multiplotER(cfg, data.avg);
figure;
ft_multiplotER(cfg, da.avg, db.avg);    % plot time courses of both conditions overlapped (a: blue line, b: red line)

% plot topographies for each sensor type at specified latencies
tlim=[0:0.1:0.4;0.1:0.1:0.5];       % tlim = [tmin; tmax] where tmin(tmax) are the start(end) point of each time interval 
zmax=3*10^(-12);
ns_multitopoplotER(data.avg,tlim,zmax);

%% grand average %%
% example with 6 subjects, two conditions (a and b)
daga=ft_timelockgrandaverage([],da1.avg,da2.avg,da3.avg,da4.avg,da5.avg,da6.avg);
dbga=ft_timelockgrandaverage([],db1.avg,db2.avg,db3.avg,db4.avg,db5.avg,db6.avg);