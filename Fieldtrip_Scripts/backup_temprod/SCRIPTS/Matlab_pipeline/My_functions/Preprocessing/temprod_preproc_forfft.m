function datapath = temprod_preproc_forfft(run,isdownsample,subject,runref)

% subject information, trigger definition and trial function %%
par.Sub_Num            = subject;
par.RawDir             = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Raw_' subject '/'];
par.DirHead            = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/HeadMvt_' subject '/'];
par.DataDir            = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Trans_sss_' subject '/'];
par.ProcDataDir        = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];
par.run                = run; 

% MaxFilter parameters
par.DirMaxFil          = '/neurospin/meg_tmp/temprod_Baptiste_2010/SCRIPTS/Maxfilter_scripts/';
par.NameMaxFil         = ['Maxfilter_temprod_OLD_' subject];
% ECG/EOG PCA projection
par.pcaproj            = ['_run' num2str(runref) '_raw_sss.fif'];
par.projfile_id        = 'comp';
% correct for Head Movement between runs %%
% made outside of fieldtrip
% perform MaxFilter processing %%
% made outside of fieldtrip

% generate epoched fieldtrip dataset %%

% define parameters from par %%
cfg                         = [];
cfg.continuous              = 'no';
cfg.headerformat            = 'neuromag_mne';
cfg.dataformat              = 'neuromag_mne';
cfg.trialdef.channel        = 'STI101';
cfg.trialdef.prestim        = 0;
cfg.trialdef.poststim       = 0;
cfg.photodelay              = 0.0038; 
cfg.trialfun                = 'trialfun_temprod_OLD_uniquetrial';
cfg.Sub_Num                 = par.Sub_Num;
cfg.lpfreq                  = 'no';
cfg.dftfilter               = 'yes';
    

% trial definition and preprocessing
for i                       = par.run
    disp(['processing run ' num2str(i)]);   
    cfg.dataset             = [par.DataDir par.Sub_Num '_run' num2str(i) '_raw_sss.fif'];
    cfg.DataDir             = par.DataDir;
    cfg.channel             = {'MEG*'};
    cfg.run                 = i;
    cfg_loc                 = ft_definetrial(cfg);
    MaxLength(i)            = (max(cfg_loc.trl(:,2) - cfg_loc.trl(:,1)))/1000;
    cfg.padding             = MaxLength(i);
    data                    = ft_preprocessing(cfg_loc);
    cfg                     = [];
end;

% remove electric line noise 
% for i                  = 1:length(data.trial)
%     data.trial{i}      = ft_preproc_bandstopfilter(data.trial{i},data.fsample, [49 51]);
%     data.trial{i}      = ft_preproc_bandstopfilter(data.trial{i},data.fsample, [99 101]);
%     data.trial{i}      = ft_preproc_bandstopfilter(data.trial{i},data.fsample, [149 151]);
% end

% downsampling data
cfg                    = [];
cfg.resamplefs         = 500;
cfg.detrend            = 'no';
cfg.blc                = 'no';
cfg.feedback           = 'no';
cfg.trials             = 'all';
if isdownsample        == 1
    data               = ft_resampledata(cfg,data);
end

% artifact correction by removing PCA components computed with graph %%
% data                   = temprod_pca(par,data);

% cut data into 5s data chunks in order to avoid future memory crashs
N = length(data.time{1})/(5*data.fsample);
timeresol = 1/data.fsample;

for i = 1:floor(N)
    tmp.time{i} = 0:timeresol:5;
    tmp.trial{i} = data.trial{1,1}(1:306,((i-1)*(5*data.fsample)+1):(i*(5*data.fsample)));
end   
% tmp.time{i+1} = (5*i):timeresol:(data.time{1}(end));
% tmp.trial{i+1} = data.trial{1,1}(1:306,((i*(5*data.fsample))+1):length(data.time{1,1}));

data.time = tmp.time;
data.trial = tmp.trial;

% save data 

datasave = data; 
clear data
MaxLength = [];
for i = 1:size(datasave.time,2)
    MaxLength = max([MaxLength length(datasave.time{i})]);
end

for i = 1:length(datasave.time)
    data = [];
    data           = datasave;
    data.trial = datasave.trial(i);
    data.time  = datasave.time(i);
    datapath               = [par.ProcDataDir 'forfft_run' num2str(run) 'trial' num2str(i,'%03i') '.mat'];
    save(datapath,'data','par','MaxLength');
end


close all
