function datapath = temprod_preproc_jr(run,subject,rejection,corrtag,tag)

% set root
root = SetPath(tag);

% subject information, trigger definition and trial function %%
par.Sub_Num            = subject;
par.RawDir             = [root '/DATA/NEW/Raw_' subject '/'];
par.DirHead            = [root '/DATA/NEW/HeadMvt_' subject '/'];
par.DataDir            = [root '/DATA/NEW/Trans_sss_' subject '/'];
par.ProcDataDir        = [root '/DATA/NEW/processed_' subject '/'];
par.run                = run;

% generate epoched fieldtrip dataset %%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i                           = par.run
    % compute artifacts components
    cfg = [];
    cfg.dataset                 = [par.DataDir par.Sub_Num '_run' num2str(i) '_raw_sss.fif'];
    hdr                         = ft_read_header(cfg.dataset);
    [EEG, MEGm, MEGg, MEG, ALL] = loadchan_fieldtrip(hdr.label);
    cfg.chantypes               = {MEGg, MEGm};
    cfg.channel                 = {'all', '-CHPI*'};
    cfg.threshold_eog           = 2;
    cfg.mode_reject_ecg         = 'fix_num';
    cfg.mode_reject_eog         = 'comp_other';
    data_corr                   = cw_correct_ecgeog_megeeg(cfg,corrtag);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % trial & epoch definition
    cfg                         = [];
    cfg.dataset                 = [par.DataDir par.Sub_Num '_run' num2str(i) '_raw_sss.fif'];
    cfg.continuous              = 'no';
    cfg.headerformat            = 'neuromag_mne';
    cfg.dataformat              = 'neuromag_mne';
    cfg.trialdef.channel        = 'STI101';
    cfg.trialdef.prestim        = 0;
    cfg.trialdef.poststim       = 0;
    cfg.photodelay              = 0.0038;
    cfg.trialfun                = 'trialfun_temprod_OLD_cond2';
    cfg.Sub_Num                 = par.Sub_Num;
    cfg.lpfreq                  = 'no';
    cfg.dftfilter               = 'yes';
    
    disp(['processing run ' num2str(i)]);
    
    %     cfg.DataDir                 = par.DataDir;
    cfg.channel                 = {'MEG*'};
    cfg.run                     = i;
    cfg_loc{1,i}                = ft_definetrial(cfg);
    data{1,i}                   = cw_epoch_trials(cfg_loc{1,i}, data_corr);
    MaxLength{1,i}              = (max(cfg_loc{1,i}.trl(:,2) - cfg_loc{1,i}.trl(:,1)))/data{1,i}.fsample;
    MinLength{1,i}              = (min(cfg_loc{1,i}.trl(:,2) - cfg_loc{1,i}.trl(:,1)))/data{1,i}.fsample;
    sampleinfo{1,i}             = data{1,i}.sampleinfo;
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

% downsampling data
cfg                    = [];
cfg.resamplefs         = 250;
cfg.detrend            = 'no';
cfg.blc                = 'no';
cfg.feedback           = 'no';
cfg.trials             = 'all';
data                   = ft_resampledata(cfg,data);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% temporary : select MEG channel only

for i = 1:length(data.trial)
    data.trial{1,i}(307:size(data.trial{1,i},1),:) = [];
end
a = 1;
for i = 1:length(data.label)
    if strcmp('MEG',data.label{i,1}(1:3))
        data.labeltmp{a,1} = data.label{i,1};
        a = a + 1;
    end
end
data.label             = data.labeltmp;
data.labeltmp          = [];

% rejection of outliers trials (based on trial duration)
if rejection == 1;
    for i = 1:length(data.trial)
        durations(i) = log((size(data.trial{1,i},2))/data.fsample);
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
dataclean              = ft_rejectvisual(cfg,data);

durinfopath = [par.ProcDataDir 'FT_trials/run' num2str(run) 'durinfo.mat'];
save(durinfopath,'info');

datasave = dataclean;
clear data
clear dataclean
MaxLength = [];
MinLength = [];
for i = 1:size(datasave.time,2)
    MaxLength = max([MaxLength length(datasave.time{i})]);
    MinLength = min([MinLength length(datasave.time{i})]);
end
% save data
for i = 1:length(datasave.time)
    data = [];
    data       = datasave;
    data.trial = datasave.trial(i);
    data.time  = datasave.time(i);
    datapath               = [par.ProcDataDir 'FT_trials/run_jrcw_' num2str(run(1)) 'trial' num2str(i,'%03i') '.mat'];
    save(datapath,'data','par','MaxLength','MinLength');
end


