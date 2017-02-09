function temprode_preproc_new(run,subject,runref,tag)

% set root
root = SetPath(tag);

%% (1) generate epoched fieldtrip dataset %%
% define data paths
SSSDataDir            = [root '/DATA/NEW/Trans_sss_' subject '/'];
ProcDataDir           = [root '/DATA/NEW/processed_' subject '/'];

% subject information, trigger definition and trial function
par.DataDir            = [root '/trans_sss/'];
par.ProcDataDir        = [root '/processed/'];
par.run                = run;

% ECG/EOG PCA projection
par.pcaproj            = ['/' runref '_raw_trans_sss.fif'];
par.projfile_id        = 'PCA';

% generate epoched fieldtrip dataset
cfg                         = [];
cfg.continuous              = 'no';
cfg.headerformat            = 'neuromag_mne';
cfg.dataformat              = 'neuromag_mne';
cfg.trialdef.channel        = 'STI101';
cfg.trialdef.prestim        = 0;
cfg.trialdef.poststim       = 0;
cfg.photodelay              = 0.0038;
if strcmp(subject,'s10')
    cfg.trialfun                = 'trialfun_temprod_OLD_cond2_s10';
else
    cfg.trialfun                = 'trialfun_temprod_OLD_cond2';
end
cfg.lpfreq                  = 'no';
cfg.dftfilter               = 'yes';

% trial definition and preprocessing
disp(['processing ' run]);
cfg.dataset             = [SSSDataDir subject '_' run '_raw_sss.fif'];
dataset                 = cfg.dataset;
cfg.channel             = {'MEG*'};
cfg_loc                 = ft_definetrial(cfg);
data{1,1}               = ft_preprocessing(cfg_loc);
MaxLength{1,1}          = (max(cfg_loc.trl(:,2) - cfg_loc.trl(:,1)))/data{1,1}.fsample;
sampleinfo{1,1}         = data{1,1}.sampleinfo;

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

clear data;
data = datatmp;
sampleinfo = datatmp.sampleinfo;

% % load external meg channel definition because of a bug not yet identified
% tmp       = load('C:\TEMPROD\SCRIPTS\Matlab_pipeline\My_functions\NewPipeline\graddef');
% data.grad = tmp.graddef;

% apply pca matrix for cardiac and blink artifacts
[M,allchan] = computeprojmatrix_onselectedchannels(par.DataDir,dataset,par.projfile_id);
allchan = 1:306;
for i = 1:length(data.trial)
    data.trial{i} = M(allchan,allchan)*data.trial{i};
end;

%% (3) downsample data to save memory
cfg                    = [];
cfg.resamplefs         = 250;
cfg.detrend            = 'no';
cfg.demean             = 'yes';
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
    
    datapath           = [ProcDataDir 'FT_trials/BLOCKTRIALS_Mags_' run '.mat'];
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
    
    datapath           = [ProcDataDir 'FT_trials/BLOCKTRIALS_Grads1_' run '.mat'];
    save(datapath,'-struct','dataGrads1','grad','trial','time','hdr','fsample','cfg','label','sampleinfo','badtrialvisual','badchanvisual','-v7.3');
    
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
    
    datapath           = [ProcDataDir 'FT_trials/BLOCKTRIALS_Grads2_' run '.mat'];
    save(datapath,'-struct','dataGrads2','grad','trial','time','hdr','fsample','cfg','label','sampleinfo','badtrialvisual','badchanvisual','-v7.3');
   
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
    
    datapath           = [ProcDataDir 'FT_trials/BLOCKTRIALS_Eeg_' run '.mat'];
    save(datapath,'-struct','dataEeg','trial','time','hdr','fsample','cfg','label','sampleinfo','badtrialvisual','badchanvisual','-v7.3');
    
end

