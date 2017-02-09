function preproc_mtt(run,nip)

root = ['C:\MTT_MEG\data\' nip '\'];

% ECG/EOG PCA projection
projfile_id        = 'PCA';

% generate epoched fieldtrip dataset
cfg1                         = [];
cfg1.continuous              = 'no';
cfg1.headerformat            = 'neuromag_mne';
cfg1.dataformat              = 'neuromag_mne';
cfg1.trialdef.channel        = 'STI101';
cfg1.trialdef.prestim        = 0.2;
cfg1.trialdef.poststim       = 0.8;
cfg1.photodelay              = 0.03;

cfg1.dataset                 = [root run '_trans_sss.fif'];
cfg1.trialfun                = 'trialfun_mtt_cue_time';

cfg1.dftfilter               = 'yes';
cfg1.lpfilter                = 'yes'; 
cfg1.lpfreq                  = 40;
cfg1.channel                 = {'MEG*'};

% trial definition and preprocessing
cfg2                    = ft_definetrial(cfg1);
data                    = ft_preprocessing(cfg2);
sampleinfo              = data.sampleinfo;

% resample dataset
cfg                    = [];
cfg.channel            = {'MEG*'};
cfg.resamplefs         = 250;
cfg.detrend            = 'no';
cfg.blc                = 'no';
cfg.feedback           = 'no';
cfg.trials             = 'all';
data                   = ft_resampledata(cfg,data);

% apply pca matrix for cardiac and blink artifacts
[M,allchan] = computeprojmatrix(root,[root run '_trans_sss.fif'],projfile_id);
for i = 1:length(data.trial)
    data.trial{i} = M(allchan,allchan)*data.trial{i};
end;

% define channel types
[Grads1,Grads2,Mags]   = grads_for_layouts('Laptop');

cfg                    = [];
cfg.method             = 'summary';
cfg.keepchannel        = 'yes';
cfg.channel            = Mags;
data                   = ft_rejectvisual(cfg,data);
cfg.channel            = Grads1;
data                   = ft_rejectvisual(cfg,data);
cfg.channel            = Grads2;
data                   = ft_rejectvisual(cfg,data);

save(['C:\MTT_MEG\data\' nip '\processed\TSCue_Time' run '.mat'],'data')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

root = ['C:\MTT_MEG\data\' nip '\'];

% ECG/EOG PCA projection
projfile_id        = 'PCA';

% generate epoched fieldtrip dataset
cfg1                         = [];
cfg1.continuous              = 'no';
cfg1.headerformat            = 'neuromag_mne';
cfg1.dataformat              = 'neuromag_mne';
cfg1.trialdef.channel        = 'STI101';
cfg1.trialdef.prestim        = 0.2;
cfg1.trialdef.poststim       = 0.8;
cfg1.photodelay              = 0.03;

cfg1.dataset                 = [root run '_trans_sss.fif'];
cfg1.trialfun                = 'trialfun_mtt_cue_space';

cfg1.dftfilter               = 'yes';
cfg1.lpfilter                = 'yes'; 
cfg1.lpfreq                  = 40;
cfg1.channel                 = {'MEG*'};

% trial definition and preprocessing
cfg2                    = ft_definetrial(cfg1);
data                    = ft_preprocessing(cfg2);
sampleinfo              = data.sampleinfo;

% resample dataset
cfg                    = [];
cfg.channel            = {'MEG*'};
cfg.resamplefs         = 250;
cfg.detrend            = 'no';
cfg.blc                = 'no';
cfg.feedback           = 'no';
cfg.trials             = 'all';
data                   = ft_resampledata(cfg,data);

% apply pca matrix for cardiac and blink artifacts
[M,allchan] = computeprojmatrix(root,[root run '_trans_sss.fif'],projfile_id);
for i = 1:length(data.trial)
    data.trial{i} = M(allchan,allchan)*data.trial{i};
end;

% define channel types
[Grads1,Grads2,Mags]   = grads_for_layouts('Laptop');

cfg                    = [];
cfg.method             = 'summary';
cfg.keepchannel        = 'yes';
cfg.channel            = Mags;
data                   = ft_rejectvisual(cfg,data);
cfg.channel            = Grads1;
data                   = ft_rejectvisual(cfg,data);
cfg.channel            = Grads2;
data                   = ft_rejectvisual(cfg,data);

save(['C:\MTT_MEG\data\' nip '\processed\TSCue_Space' run '.mat'],'data')




