function temprod_preproc_timelock(run,isdownsample,subject,runref,rejection,tag)

root = SetPath(tag);
% subject information, trigger definition and trial function %%
par.Sub_Num            = subject;
par.RawDir             = [root '/DATA/NEW/Raw_' subject '/'];
par.DirHead            = [root '/DATA/NEW/HeadMvt_' subject '/'];
par.DataDir            = [root '/DATA/NEW/Trans_sss_' subject '/'];
par.ProcDataDir        = [root '/DATA/NEW/processed_' subject '/'];
par.run                = run; 

% MaxFilter parameters
par.DirMaxFil          = [root '/SCRIPTS/Maxfilter_scripts/'];
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
cfg.trialfun                = 'trialfun_temprod_timelock';
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
    cfg.lpfreq              = 40;
    data                    = ft_preprocessing(cfg_loc);
    cfg                     = [];
end;

% remove high frequencies
for i                  = 1:length(data.trial)
    data.trial{i}      = ft_preproc_lowpassfilter(data.trial{i},data.fsample, 40);
end

% downsampling data
cfg                    = [];
cfg.resamplefs         = 250;
cfg.detrend            = 'no';
cfg.blc                = 'no';
cfg.feedback           = 'no';
cfg.trials             = 'all';
if isdownsample        == 1
    data               = ft_resampledata(cfg,data);
end

% artifact correction by removing PCA components computed with graph %%
data                   = temprod_pca(par,data);

% visual artifact detection %%
cfg                    =[];
cfg.method             ='summary';
cfg.channel            = {'MEG'};
cfg.alim               = 4e-11;
cfg.megscale           = 1;
cfg.eogscale           = 5e-7;
cfg.keepchannel        = 'no';
datasave               = ft_rejectvisual(cfg,data);
clear data
data                   = datasave;

% rejection of outliers trials (based on trial duration)
if rejection == 1;
    for i = 1:length(data.trial)
        durations(i) = size(data.trial{1,i},2);
    end
    
    q1                  = prctile(durations,25); % first quartile
    q3                  = prctile(durations,75); % third quartile
    myiqr               = iqr(durations);        % interquartile range
    lower_inner_fence   = q1 - 3*myiqr;
    upper_inner_fence   = q3 + 3*myiqr;
    
    index = [];
    a = 0;
    for i = 1:length(durations)
        if durations(i) < lower_inner_fence || durations(i) > upper_inner_fence
            a = a + 1;
            index(a) = i;
        end
    end
    

    info = [];
    if isempty(index) == 0
        a = 1; b = 1;
        for i = 1:length(data.trial)
            if i ~= index(b)
                tmp.trial{1,a} = data.trial{1,i};
                tmp.time{1,a}  = data.time{1,i};
%                 info(a,:) = data.sampleinfo(i,:);
                a = a + 1;
            elseif i == index(b) && b ~= length(index)
                b = b + 1;
            else i == index(b) && b == length(index)
            end
        end
        data.trial = tmp.trial;
        data.time  = tmp.time;
%         data.sampleinfo = info;
    end
end

datasave = data;

% minlength = min(data.sampleinfo(:,2)-data.sampleinfo(:,1));
minlength = 2*data.fsample;
for i = 1:length(data.trial)
    data.trial{1,i} = data.trial{1,i}(:,1:minlength);
    data.time{1,i} = data.time{1,i}(1:minlength);
end

datapath               = [par.ProcDataDir 'FT_trials/run' num2str(run) 't0locked.mat'];
save(datapath,'data','par');

data = datasave;

for i = 1:length(data.trial)
    l(i) = size(data.trial{1,i},2);
    data.trial{1,i} = data.trial{1,i}(:,(l(i)-minlength):end);
    data.time{1,i} = data.time{1,i}(1:minlength);
end

datapath               = [par.ProcDataDir 'FT_trials/run' num2str(run) 'tendlocked.mat'];
save(datapath,'data','par');






