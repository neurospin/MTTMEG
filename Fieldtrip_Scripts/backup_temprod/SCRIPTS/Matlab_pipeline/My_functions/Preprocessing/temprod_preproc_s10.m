function datapath = temprod_preproc(run,isdownsample,subject,runref,rejection)

% subject information, trigger definition and trial function %%
par.Sub_Num            = subject;
par.RawDir             = ['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Raw_' subject '/'];
par.DirHead            = ['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/HeadMvt_' subject '/'];
par.DataDir            = ['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Trans_sss_' subject '/'];
par.ProcDataDir        = ['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];
par.run                = run; 

% MaxFilter parameters
par.DirMaxFil          = '/neurospin/meg/meg_tmp/temprod_Baptiste_2010/SCRIPTS/Maxfilter_scripts/';
par.NameMaxFil         = ['Maxfilter_temprod_OLD_' subject];
% ECG/EOG PCA projection
par.pcaproj            = ['_run' num2str(runref) '_raw_sss.fif'];
par.projfile_id        = 'compmeg';
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
cfg.trialfun                = 'trialfun_temprod_OLD_cond2_s10';
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
    cfg_loc{1,i}            = ft_definetrial(cfg);
    data{1,i}               = ft_preprocessing(cfg_loc{1,i});
    MaxLength{1,i}          = (max(cfg_loc{1,i}.trl(:,2) - cfg_loc{1,i}.trl(:,1)))/data{1,i}.fsample;
    sampleinfo{1,i}         = data{1,i}.sampleinfo;
end;

datatmp.trial              = {};
datatmp.time               = {};
datatmp.sampleinfo         = [];

for i = 1:length(data)
    if isempty(data{1,i}) ~= 1
        datatmp.hdr        = data{1,i}.hdr;
%         datatmp.grad       = data{1,i}.grad;
        datatmp.fsample    = data{1,i}.fsample;
        datatmp.cfg        = data{1,i}.cfg;
        datatmp.label      = data{1,i}.label;
        datatmp.trial      = [datatmp.trial data{1,i}.trial];
        datatmp.time       = [datatmp.time  data{1,i}.time ];
        datatmp.sampleinfo = [datatmp.sampleinfo ; data{1,i}.sampleinfo];
    end
end

clear data;
data = datatmp;
sampleinfo = datatmp.sampleinfo;
MaxLength = max(max(sampleinfo)); 

% remove electric line noise 
% for i                  = 1:length(data.trial)
%     data.trial{i}      = ft_preproc_bandstopfilter(data.trial{i},data.fsample, [49 51]);
%     data.trial{i}      = ft_preproc_bandstopfilter(data.trial{i},data.fsample, [99 101]);
%     data.trial{i}      = ft_preproc_bandstopfilter(data.trial{i},data.fsample, [149 151]);
% end

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


% rejection of outliers trials (based on trial duration)
if rejection == 1;
    for i = 1:length(data.trial)
        durations(i) = size(data.trial{1,i},2);
    end
    
    q1                  = prctile(durations,25); % first quartile
    q3                  = prctile(durations,75); % third quartile
    myiqr               = iqr(durations);        % interquartile range
    lower_inner_fence   = q1 - 2*myiqr;
    upper_inner_fence   = q3 + 2*myiqr;
    
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
                info(a,:) = sampleinfo(i,:);
                a = a + 1;
            elseif i == index(b) && b ~= length(index)
                b = b + 1;
            else i == index(b) && b == length(index)
            end
        end
        data.trial = tmp.trial;
        data.time  = tmp.time;
        data.sampleinfo = info;
    end
end

if isempty(info)
    info = sampleinfo;
end

% visual artifact detection %%
cfg                    =[];
cfg.method             ='summary';
cfg.channel            = {'MEG','EOG'};
cfg.alim               = 4e-11;
cfg.megscale           = 1;
cfg.eogscale           = 5e-7;
cfg.keepchannel        = 'no';
data                   = ft_rejectvisual(cfg,data);


durinfopath = [par.ProcDataDir 'FT_trials/run' num2str(run) 'durinfo.mat'];
save(durinfopath,'info');

datasave = data; 
clear data
MaxLength = [];
MinLength = [];
for i = 1:size(datasave.time,2)
    MaxLength = max([MaxLength length(datasave.time{i})]);
    MinLength = min([MinLength length(datasave.time{i})]);
end
% save data 
for i = 1:length(datasave.time)
    data = [];
    data           = datasave;
    data.trial = datasave.trial(i);
    data.time  = datasave.time(i);
    datapath               = [par.ProcDataDir 'FT_trials/run' num2str(run(1)) 'trial' num2str(i,'%03i') '.mat'];
    save(datapath,'data','par','MaxLength','MinLength');
end


