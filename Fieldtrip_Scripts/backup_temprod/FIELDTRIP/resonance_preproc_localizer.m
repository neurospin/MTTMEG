function resonance_preproc_localizer(run,nip,runref,tag)

%% face localizer

root = ['C:\RESONANCE_MEG\DATA\' nip];

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
cfg.photodelay              = 0.03;
cfg.trialfun                = 'trialfun_resonance_localizerface';
cfg.dftfilter               = 'yes';
cfg.lpfilter                = 'yes'; 
cfg.lpfreq                  = 40;

% trial definition and preprocessing
disp(['processing ' run]);
cfg.dataset             = [par.DataDir run '_raw_trans_sss.fif'];
dataset                 = cfg.dataset;
cfg.channel             = {'MEG*'};
cfg_loc                 = ft_definetrial(cfg);
data                    = ft_preprocessing(cfg_loc);
sampleinfo              = data.sampleinfo;

% resmaple dataset
cfg                    = [];
cfg.resamplefs         = 250;
cfg.detrend            = 'no';
cfg.blc                = 'no';
cfg.feedback           = 'no';
cfg.trials             = 'all';
data                   = ft_resampledata(cfg,data);

% apply pca matrix for cardiac and blink artifacts
[M,allchan] = computeprojmatrix_onselectedchannels(par.DataDir,dataset,par.projfile_id);
for i = 1:length(data.trial)
    data.trial{i} = M(allchan,allchan)*data.trial{i};
end;

% define channel types
[Grads1,Grads2,Mags]   = grads_for_layouts(tag);

cfg                    = [];
cfg.method             = 'summary';
cfg.keepchannel        = 'yes';
cfg.channel            = Mags;
data                   = ft_rejectvisual(cfg,data);
cfg.channel            = Grads1;
data                   = ft_rejectvisual(cfg,data);
cfg.channel            = Grads2;
data                   = ft_rejectvisual(cfg,data);

save([par.ProcDataDir 'localizer_face.mat'],'data')


%% place localizer

root = ['C:\RESONANCE_MEG\DATA\' nip];

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
cfg.photodelay              = 0.03;
cfg.trialfun                = 'trialfun_resonance_localizerplace';
cfg.dftfilter               = 'yes';
cfg.lpfilter                = 'yes'; 
cfg.lpfreq                  = 40;

% trial definition and preprocessing
disp(['processing ' run]);
cfg.dataset             = [par.DataDir run '_raw_trans_sss.fif'];
dataset                 = cfg.dataset;
cfg.channel             = {'MEG*'};
cfg_loc                 = ft_definetrial(cfg);
data                    = ft_preprocessing(cfg_loc);
sampleinfo              = data.sampleinfo;

% resmaple dataset
cfg                    = [];
cfg.resamplefs         = 250;
cfg.detrend            = 'no';
cfg.blc                = 'no';
cfg.feedback           = 'no';
cfg.trials             = 'all';
data                   = ft_resampledata(cfg,data);

% apply pca matrix for cardiac and blink artifacts
[M,allchan] = computeprojmatrix_onselectedchannels(par.DataDir,dataset,par.projfile_id);
for i = 1:length(data.trial)
    data.trial{i} = M(allchan,allchan)*data.trial{i};
end;

% define channel types
[Grads1,Grads2,Mags]   = grads_for_layouts(tag);

cfg                    = [];
cfg.method             = 'summary';
cfg.keepchannel        = 'yes';
cfg.channel            = Mags;
data                   = ft_rejectvisual(cfg,data);
cfg.channel            = Grads1;
data                   = ft_rejectvisual(cfg,data);
cfg.channel            = Grads2;
data                   = ft_rejectvisual(cfg,data);

save([par.ProcDataDir 'localizer_place.mat'],'data')

%% object localizer

root = ['C:\RESONANCE_MEG\DATA\' nip];

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
cfg.photodelay              = 0.03;
cfg.trialfun                = 'trialfun_resonance_localizerobject';
cfg.dftfilter               = 'yes';
cfg.lpfilter                = 'yes'; 
cfg.lpfreq                  = 40;

% trial definition and preprocessing
disp(['processing ' run]);
cfg.dataset             = [par.DataDir run '_raw_trans_sss.fif'];
dataset                 = cfg.dataset;
cfg.channel             = {'MEG*'};
cfg_loc                 = ft_definetrial(cfg);
data                    = ft_preprocessing(cfg_loc);
sampleinfo              = data.sampleinfo;

% resmaple dataset
cfg                    = [];
cfg.resamplefs         = 250;
cfg.detrend            = 'no';
cfg.blc                = 'no';
cfg.feedback           = 'no';
cfg.trials             = 'all';
data                   = ft_resampledata(cfg,data);

% apply pca matrix for cardiac and blink artifacts
[M,allchan] = computeprojmatrix_onselectedchannels(par.DataDir,dataset,par.projfile_id);
for i = 1:length(data.trial)
    data.trial{i} = M(allchan,allchan)*data.trial{i};
end;

% define channel types
[Grads1,Grads2,Mags]   = grads_for_layouts(tag);

cfg                    = [];
cfg.method             = 'summary';
cfg.keepchannel        = 'yes';
cfg.channel            = Mags;
data                   = ft_rejectvisual(cfg,data);
cfg.channel            = Grads1;
data                   = ft_rejectvisual(cfg,data);
cfg.channel            = Grads2;
data                   = ft_rejectvisual(cfg,data);

save([par.ProcDataDir 'localizer_object.mat'],'data')


