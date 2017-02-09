function Temprod_Preproc_Timelock(subject,run,PCA_param,tag)

% set root
root = SetPath(tag);

%% (1) generate epoched fieldtrip dataset %%
% define data paths
SSSDataDir            = [root '/DATA/NEW/Trans_sss_' subject '/'];
ProcDataDir           = [root '/DATA/NEW/processed_' subject '/'];

for i                           = run
    
    % if there's ecg/eog/both ecg & eog data
    if strcmp(PCA_param,'nocorr') ~= 1
        
        % compute artifacts components
        cfg = [];
        cfg.dataset                 = [SSSDataDir subject '_run' num2str(i) '_raw_sss.fif'];
        hdr                         = ft_read_header(cfg.dataset);
        [EEG, MEGm, MEGg, MEG, ALL] = loadchan_fieldtrip(hdr.label);
        cfg.chantypes               = {MEGg, MEGm};
        cfg.channel                 = {'all', '-CHPI*'};
        cfg.threshold_eog           = 2;
        cfg.mode_reject_ecg         = 'fix_num';
        cfg.mode_reject_eog         = 'comp_other';
        data_corr                   = cwbg_correct_ecgeog(cfg,PCA_param);
        
        % trial & epoch definition
        cfg                         = [];
        cfg.dataset                 = [SSSDataDir subject '_run' num2str(i) '_raw_sss.fif'];
        cfg.continuous              = 'yes';
%         cfg.headerformat            = 'neuromag_fif';
%         cfg.dataformat              = 'neuromag_fif';
        cfg.trialdef.channel        = 'STI101';
%         cfg.photodelay              = 0.004;
        cfg.trialdef.prestim        = + cfg.photodelay;
        cfg.trialdef.poststim       = - cfg.photodelay;
        if strcmp(subject,'s10')
            cfg.trialfun                = 'trialfun_temprod_timelock_s10';
        else
            cfg.trialfun                = 'trialfun_temprod_timelock';
        end
        cfg.channel                 = {'all'};
        cfg.run                     = i;
        disp(['processing run ' num2str(i)]);
        cfg_loc{1,i}                = ft_definetrial(cfg);
        cfg.lpfreq                  = 40; 
        cfg.lpfilter                = 'yes';
        data{1,i}                   = cw_epoch_trials(cfg_loc{1,i}, data_corr);
        MaxLength{1,i}              = (max(cfg_loc{1,i}.trl(:,2) - cfg_loc{1,i}.trl(:,1)))/data{1,i}.fsample;
        MinLength{1,i}              = (min(cfg_loc{1,i}.trl(:,2) - cfg_loc{1,i}.trl(:,1)))/data{1,i}.fsample;
        sampleinfo{1,i}             = data{1,i}.sampleinfo;
        
        % if there's no ecg/eog/both ecg & eog data or if you don't want to apply it
    else
        
        cfg                         = [];
        cfg.dataset                 = [SSSDataDir subject '_run' num2str(i) '_raw_sss.fif'];
        cfg.continuous              = 'yes';
        cfg.headerformat            = 'neuromag_mne';
        cfg.dataformat              = 'neuromag_mne';
        cfg.trialdef.channel        = 'STI101';
%         cfg.photodelay              = 0.004;
        cfg.trialdef.prestim        = + cfg.photodelay;
        cfg.trialdef.poststim       = - cfg.photodelay;
        if strcmp(subject,'s10')
            cfg.trialfun                = 'trialfun_temprod_timelock_s10';
        else
            cfg.trialfun                = 'trialfun_temprod_timelock';
        end
        cfg.channel                 = 'all';
        cfg.run                     = i;
        cfg_loc{1,i}                = ft_definetrial(cfg);
        cfg.trl                     = cfg_loc{1,i}.trl;
        cfg.padding                 = 0;
        cfg.continuous              = 'yes';
        cfg.lpfreq                  = 40; 
        cfg.lpfilter                = 'yes';
        disp(['processing run ' num2str(i)]);
        data{1,i}                   = ft_preprocessing(cfg);
        MaxLength{1,i}              = (max(cfg_loc{1,i}.trl(:,2) - cfg_loc{1,i}.trl(:,1)))/data{1,i}.fsample;
        sampleinfo{1,i}             = data{1,i}.sampleinfo;
        
    end
end

%% (2) append data in one structure if the run is splitted
datatmp.trial              = {};
datatmp.time               = {};
datatmp.sampleinfo         = [];

for i = 1:length(data)
    if isempty(data{1,i}) ~= 1
        datatmp.hdr        = data{1,i}.hdr;
        if isfield(data{1,i},'grad')
            datatmp.grad       = data{1,i}.grad;
        end
        if isfield(data{1,i},'elec')
            datatmp.elec       = data{1,i}.elec;
        end        
        datatmp.fsample    = data{1,i}.fsample;
        datatmp.cfg        = data{1,i}.cfg;
        datatmp.label      = data{1,i}.label;
        datatmp.trial      = [datatmp.trial data{1,i}.trial];
        datatmp.time       = [datatmp.time  data{1,i}.time ];
        datatmp.sampleinfo = [datatmp.sampleinfo ; data{1,i}.sampleinfo];
    end
end

clear data
data = datatmp;
sampleinfo = datatmp.sampleinfo;

% load external meg channel definition because of a bug not yet identified
tmp       = load('C:\TEMPROD\SCRIPTS\Matlab_pipeline\My_functions\NewPipeline\graddef');
data.grad = tmp.graddef;

%% (3) downsample data to save memory
cfg                    = [];
cfg.resamplefs         = 250;
cfg.detrend            = 'no';
cfg.blc                = 'no';
cfg.feedback           = 'no';
cfg.trials             = 'all';
data                   = ft_resampledata(cfg,data);

%% (4) segment data into mags, grads1, grads2 and EEG
% load meg/eeg channel type list
[Grads1,Grads2,Mags]   = grads_for_layouts(tag);
Eeg                    = EEG_for_layouts(tag);

% check the presence of the labels in the data
[magsel1   , magsel2  ]   = match_str(Mags , data.label);
[grads1sel1, grads1sel2]  = match_str(Grads1, data.label);
[grads2sel1, grads2sel2]  = match_str(Grads2, data.label);
[eegsel1   , eegsel2  ]   = match_str(Eeg  , data.label);


%% (5) visual artifact detection %%
%% (6) save datasets cleaned for ecg/eog artifacts and containing informations for rejecting/sorting trials afterwards

% reject trials with length < minlength
sampleinfook = [];   a = 1;
for i = 1:length(data.trial)
    if length(data.time{1,i}) >= 4*data.fsample        
        dataok.trial{1,a} = data.trial{1,i};
        dataok.time{1,a}  = data.time{1,i};
        sampleinfook(a,:) = sampleinfo(i,:);
        a = a + 1;
    end
end
data.trial     = dataok.trial;
data.time      = dataok.time;
data.samplinfo = sampleinfook;
sampleinfo     = sampleinfook;

% if there is mags, build mags data structure
if isempty(magsel2) ~= 1
    
    dataMags                    = data;
    for i = 1:length(data.trial)
        dataMags.trial{1,i}     = data.trial{1,i}(magsel2,:);
    end
    dataMags.label              = Mags';
    
    cfg                    = [];
    cfg.method             = 'summary';
    cfg.keepchannel        = 'yes';
    cfg.channel            = Mags;
    dataMags               = ft_rejectvisual(cfg,dataMags);
    
    if isfield(dataMags,'badtrialvisual') == 0
       dataMags.badtrialvisual = [];
    end
    if isfield(dataMags,'badchanvisual') == 0
        dataMags.badchanvisual  = [];
    end
    
    % segment for t0-locking 
    minlength = 2*dataMags.fsample;
    for i = 1:length(dataMags.trial)
        dataMags.trial{1,i} = dataMags.trial{1,i}(:,1:minlength);
        dataMags.time{1,i} = dataMags.time{1,i}(1:minlength);
    end
    
    datapath           = [ProcDataDir 'FT_trials/BLOCKTRIALS_FOR_ERFt0_Mags_RUN' num2str(run(1),'%02i') '.mat'];
    save(datapath,'-struct','dataMags','grad','trial','time','hdr','fsample','cfg','label','sampleinfo','badtrialvisual','badchanvisual','-v7.3');
    
    
    dataMags                    = data;
    for i = 1:length(data.trial)
        dataMags.trial{1,i}     = data.trial{1,i}(magsel2,:);
    end
    dataMags.label              = Mags';
    
    cfg                    = [];
    cfg.method             = 'summary';
    cfg.keepchannel        = 'yes';
    cfg.channel            = Mags;
    dataMags               = ft_rejectvisual(cfg,dataMags);
    
    if isfield(dataMags,'badtrialvisual') == 0
       dataMags.badtrialvisual = [];
    end
    if isfield(dataMags,'badchanvisual') == 0
        dataMags.badchanvisual  = [];
    end
    
    % segment for tend-locking
    for i = 1:length(dataMags.trial)
        l(i) = size(dataMags.trial{1,i},2);
        dataMags.trial{1,i} = dataMags.trial{1,i}(:,(l(i)-minlength):end);
        dataMags.time{1,i}  = dataMags.time{1,i}(1:minlength);
    end
    
    datapath           = [ProcDataDir 'FT_trials/BLOCKTRIALS_FOR_ERFtend_Mags_RUN' num2str(run(1),'%02i') '.mat'];
    save(datapath,'-struct','dataMags','grad','trial','time','hdr','fsample','cfg','label','sampleinfo','badtrialvisual','badchanvisual','-v7.3');
    
end

% if there is grads1, build grads1 data structure
if isempty(grads1sel2) ~= 1
    dataGrads1                  = data;
    for i = 1:length(data.trial)
        dataGrads1.trial{1,i}   = data.trial{1,i}(grads1sel2,:);
    end
    dataGrads1.label            = Grads1';
    
    cfg                    = [];
    cfg.method             = 'summary';
    cfg.keepchannel        = 'yes';
    cfg.channel            = Grads1;
    dataGrads1             = ft_rejectvisual(cfg,dataGrads1);
    
    if isfield(dataGrads1,'badtrialvisual') == 0
       dataGrads1.badtrialvisual = [];
    end
    if isfield(dataGrads1,'badchanvisual') == 0
       dataGrads1.badchanvisual  = [];
    end   
    
    % segment for t0-locking 
    minlength = 2*dataGrads1.fsample;
    for i = 1:length(dataGrads1.trial)
        dataGrads1.trial{1,i} = dataGrads1.trial{1,i}(:,1:minlength);
        dataGrads1.time{1,i} = dataGrads1.time{1,i}(1:minlength);
    end
    
    datapath           = [ProcDataDir 'FT_trials/BLOCKTRIALS_FOR_ERFt0_Grads1_RUN' num2str(run(1),'%02i') '.mat'];
    save(datapath,'-struct','dataGrads1','grad','trial','time','hdr','fsample','cfg','sampleinfo','label','badtrialvisual','badchanvisual','-v7.3');
    
    dataGrads1                  = data;
    for i = 1:length(data.trial)
        dataGrads1.trial{1,i}   = data.trial{1,i}(grads1sel2,:);
    end
    dataGrads1.label            = Grads1';
    
    cfg                    = [];
    cfg.method             = 'summary';
    cfg.keepchannel        = 'yes';
    cfg.channel            = Grads1;
    dataGrads1             = ft_rejectvisual(cfg,dataGrads1);
    
    if isfield(dataGrads1,'badtrialvisual') == 0
       dataGrads1.badtrialvisual = [];
    end
    if isfield(dataGrads1,'badchanvisual') == 0
       dataGrads1.badchanvisual  = [];
    end  
    
    % segment for tend-locking
    for i = 1:length(dataGrads1.trial)
        l(i) = size(dataGrads1.trial{1,i},2);
        dataGrads1.trial{1,i} = dataGrads1.trial{1,i}(:,(l(i)-minlength):end);
        dataGrads1.time{1,i}  = dataGrads1.time{1,i}(1:minlength);
    end
    
    datapath           = [ProcDataDir 'FT_trials/BLOCKTRIALS_FOR_ERFtend_Grads1_RUN' num2str(run(1),'%02i') '.mat'];
    save(datapath,'-struct','dataGrads1','grad','trial','time','hdr','fsample','cfg','sampleinfo','label','badtrialvisual','badchanvisual','-v7.3');
    
end
% if there is grads2, build grads2 data structure
if isempty(grads2sel2) ~= 1
    dataGrads2                  = data;
    for i = 1:length(data.trial)
        dataGrads2.trial{1,i}   = data.trial{1,i}(grads2sel2,:);
    end
    dataGrads2.label            = Grads2';
    
    cfg                    = [];
    cfg.method             = 'summary';
    cfg.keepchannel        = 'yes';
    cfg.channel            = Grads2;
    dataGrads2             = ft_rejectvisual(cfg,dataGrads2);
    
    if isfield(dataGrads2,'badtrialvisual') == 0
       dataGrads2.badtrialvisual = [];
    end
    if isfield(dataGrads2,'badchanvisual') == 0
       dataGrads2.badchanvisual  = [];
    end   
    
    % segment for t0-locking 
    minlength = 2*dataGrads2.fsample;
    for i = 1:length(dataGrads2.trial)
        dataGrads2.trial{1,i} = dataGrads2.trial{1,i}(:,1:minlength);
        dataGrads2.time{1,i} = dataGrads2.time{1,i}(1:minlength);
    end
    
    datapath           = [ProcDataDir 'FT_trials/BLOCKTRIALS_FOR_ERFt0_Grads2_RUN' num2str(run(1),'%02i') '.mat'];
    save(datapath,'-struct','dataGrads2','grad','trial','time','hdr','fsample','cfg','sampleinfo','label','badtrialvisual','badchanvisual','-v7.3');
    
    dataGrads2                  = data;
    for i = 1:length(data.trial)
        dataGrads2.trial{1,i}   = data.trial{1,i}(grads2sel2,:);
    end
    dataGrads2.label            = Grads2';
    
    cfg                    = [];
    cfg.method             = 'summary';
    cfg.keepchannel        = 'yes';
    cfg.channel            = Grads2;
    dataGrads2             = ft_rejectvisual(cfg,dataGrads2);
    
    if isfield(dataGrads2,'badtrialvisual') == 0
       dataGrads2.badtrialvisual = [];
    end
    if isfield(dataGrads2,'badchanvisual') == 0
       dataGrads2.badchanvisual  = [];
    end 
    
    % segment for tend-locking
    for i = 1:length(dataGrads2.trial)
        l(i) = size(dataGrads2.trial{1,i},2);
        dataGrads2.trial{1,i} = dataGrads2.trial{1,i}(:,(l(i)-minlength):end);
        dataGrads2.time{1,i}  = dataGrads2.time{1,i}(1:minlength);
    end
    
    datapath           = [ProcDataDir 'FT_trials/BLOCKTRIALS_FOR_ERFtend_Grads2_RUN' num2str(run(1),'%02i') '.mat'];
    save(datapath,'-struct','dataGrads2','grad','trial','time','hdr','fsample','cfg','sampleinfo','label','badtrialvisual','badchanvisual','-v7.3');
   
end
% if there is eeg, build eeg data structure
if isempty(eegsel2) ~= 1
    dataEeg                     = data;
    for i = 1:length(data.trial)
        dataEeg.trial{1,i}      = data.trial{1,i}(eegsel2,:);
    end
    dataEeg.label               = Eeg';
    
    cfg                    = [];
    cfg.method             = 'summary';
    cfg.keepchannel        = 'yes';
    cfg.channel            = Eeg;
    dataEeg                = ft_rejectvisual(cfg,dataEeg);
    
    if isfield(dataEeg,'badtrialvisual') == 0
       dataEeg.badtrialvisual = [];
    end
    if isfield(dataEeg,'badchanvisual') == 0
       dataEeg.badchanvisual  = [];
    end   
    
    % segment for t0-locking 
    minlength = 2*dataEeg.fsample;
    for i = 1:length(dataEeg.trial)
        dataEeg.trial{1,i} = dataEeg.trial{1,i}(:,1:minlength);
        dataEeg.time{1,i}  = dataEeg.time{1,i}(1:minlength);
    end
    
    datapath           = [ProcDataDir 'FT_trials/BLOCKTRIALS_FOR_ERFt0_Eeg_RUN' num2str(run(1),'%02i') '.mat'];
    save(datapath,'-struct','dataEeg','grad','trial','time','hdr','fsample','cfg','sampleinfo','label','badtrialvisual','badchanvisual','-v7.3');
    
    dataEeg                     = data;
    for i = 1:length(data.trial)
        dataEeg.trial{1,i}      = data.trial{1,i}(eegsel2,:);
    end
    dataEeg.label               = Eeg';
    
    cfg                    = [];
    cfg.method             = 'summary';
    cfg.keepchannel        = 'yes';
    cfg.channel            = Eeg;
    dataEeg                = ft_rejectvisual(cfg,dataEeg);
    
    if isfield(dataEeg,'badtrialvisual') == 0
       dataEeg.badtrialvisual = [];
    end
    if isfield(dataEeg,'badchanvisual') == 0
       dataEeg.badchanvisual  = [];
    end   
    
    % segment for tend-locking
    for i = 1:length(dataEeg.trial)
        l(i) = size(dataEeg.trial{1,i},2);
        dataEeg.trial{1,i} = dataEeg.trial{1,i}(:,(l(i)-minlength):end);
        dataEeg.time{1,i}  = dataEeg.time{1,i}(1:minlength);
    end
    
    datapath           = [ProcDataDir 'FT_trials/BLOCKTRIALS_FOR_ERFtend_Eeg_RUN' num2str(run(1),'%02i') '.mat'];
    save(datapath,'-struct','dataEeg','grad','trial','time','hdr','fsample','cfg','sampleinfo','label','badtrialvisual','badchanvisual','-v7.3');
    
end
