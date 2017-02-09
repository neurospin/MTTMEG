function preproc_mtt_ref(run,nip)

root = ['C:\MTT_MEG\data\' nip '\'];

% ECG/EOG PCA projection
projfile_id        = 'PCA';

% generate epoched fieldtrip dataset
cfg1                         = [];
cfg1.continuous              = 'no';
cfg1.headerformat            = 'neuromag_mne';
cfg1.dataformat              = 'neuromag_mne';
cfg1.trialdef.channel        = 'STI101';
cfg1.trialdef.prestim        = 0.4;
cfg1.trialdef.poststim       = 1.5;
cfg1.photodelay              = 0.055;
% cfg1.psychinfo               = psychfile;

cfg1.dataset                 = [root run '_trans_sss.fif'];
cfg1.trialfun                = 'trialfun_mtt_reftime1_v2';

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

save(['C:\MTT_MEG\data\' nip '\processed\TimeRef1_filt40_' run '.mat'],'data')

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
cfg1.trialdef.prestim        = 0.4;
cfg1.trialdef.poststim       = 1.5;
cfg1.photodelay              = 0.055;
% cfg1.psychinfo               = psychfile;

cfg1.dataset                 = [root run '_trans_sss.fif'];
cfg1.trialfun                = 'trialfun_mtt_reftime2_v2';

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

save(['C:\MTT_MEG\data\' nip '\processed\TimeRef2_filt40_' run '.mat'],'data')

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
cfg1.trialdef.prestim        = 0.4;
cfg1.trialdef.poststim       = 1.5;
cfg1.photodelay              = 0.055;
% cfg1.psychinfo               = psychfile;

cfg1.dataset                 = [root run '_trans_sss.fif'];
cfg1.trialfun                = 'trialfun_mtt_reftime3_v2';

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

save(['C:\MTT_MEG\data\' nip '\processed\TimeRef3_filt40_' run '.mat'],'data')

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
cfg1.trialdef.prestim        = 0.4;
cfg1.trialdef.poststim       = 1.5;
cfg1.photodelay              = 0.055;
% cfg1.psychinfo               = psychfile;

cfg1.dataset                 = [root run '_trans_sss.fif'];
cfg1.trialfun                = 'trialfun_mtt_reftime1_v2';

cfg1.dftfilter               = 'no';
cfg1.lpfilter                = 'no'; 
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

save(['C:\MTT_MEG\data\' nip '\processed\TimeRef1_nofilt_' run '.mat'],'data')

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
cfg1.trialdef.prestim        = 0.4;
cfg1.trialdef.poststim       = 1.5;
cfg1.photodelay              = 0.055;
% cfg1.psychinfo               = psychfile;

cfg1.dataset                 = [root run '_trans_sss.fif'];
cfg1.trialfun                = 'trialfun_mtt_reftime2_v2';

cfg1.dftfilter               = 'no';
cfg1.lpfilter                = 'no'; 
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

save(['C:\MTT_MEG\data\' nip '\processed\TimeRef2_nofilt_' run '.mat'],'data')

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
cfg1.trialdef.prestim        = 0.4;
cfg1.trialdef.poststim       = 1.5;
cfg1.photodelay              = 0.055;
% cfg1.psychinfo               = psychfile;

cfg1.dataset                 = [root run '_trans_sss.fif'];
cfg1.trialfun                = 'trialfun_mtt_reftime3_v2';

cfg1.dftfilter               = 'no';
cfg1.lpfilter                = 'no'; 
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

save(['C:\MTT_MEG\data\' nip '\processed\TimeRef3_nofilt_' run '.mat'],'data')

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
cfg1.trialdef.prestim        = 0.4;
cfg1.trialdef.poststim       = 1.5;
cfg1.photodelay              = 0.055;
% cfg1.psychinfo               = psychfile;

cfg1.dataset                 = [root run '_trans_sss.fif'];
cfg1.trialfun                = 'trialfun_mtt_refspace1_v2';

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

save(['C:\MTT_MEG\data\' nip '\processed\SpaceRef1_filt40_' run '.mat'],'data')

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
cfg1.trialdef.prestim        = 0.4;
cfg1.trialdef.poststim       = 1.5;
cfg1.photodelay              = 0.055;
% cfg1.psychinfo               = psychfile;

cfg1.dataset                 = [root run '_trans_sss.fif'];
cfg1.trialfun                = 'trialfun_mtt_refspace2_v2';

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

save(['C:\MTT_MEG\data\' nip '\processed\SpaceRef2_filt40_' run '.mat'],'data')

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
cfg1.trialdef.prestim        = 0.4;
cfg1.trialdef.poststim       = 1.5;
cfg1.photodelay              = 0.055;
% cfg1.psychinfo               = psychfile;

cfg1.dataset                 = [root run '_trans_sss.fif'];
cfg1.trialfun                = 'trialfun_mtt_refspace3_v2';

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

save(['C:\MTT_MEG\data\' nip '\processed\SpaceRef3_filt40_' run '.mat'],'data')

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
cfg1.trialdef.prestim        = 0.4;
cfg1.trialdef.poststim       = 1.5;
cfg1.photodelay              = 0.055;
% cfg1.psychinfo               = psychfile;

cfg1.dataset                 = [root run '_trans_sss.fif'];
cfg1.trialfun                = 'trialfun_mtt_refspace1_v2';

cfg1.dftfilter               = 'no';
cfg1.lpfilter                = 'no'; 
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

save(['C:\MTT_MEG\data\' nip '\processed\SpaceRef1_nofilt_' run '.mat'],'data')

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
cfg1.trialdef.prestim        = 0.4;
cfg1.trialdef.poststim       = 1.5;
cfg1.photodelay              = 0.055;
% cfg1.psychinfo               = psychfile;

cfg1.dataset                 = [root run '_trans_sss.fif'];
cfg1.trialfun                = 'trialfun_mtt_refspace2_v2';

cfg1.dftfilter               = 'no';
cfg1.lpfilter                = 'no'; 
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

save(['C:\MTT_MEG\data\' nip '\processed\SpaceRef2_nofilt_' run '.mat'],'data')

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
cfg1.trialdef.prestim        = 0.4;
cfg1.trialdef.poststim       = 1.5;
cfg1.photodelay              = 0.055;
% cfg1.psychinfo               = psychfile;

cfg1.dataset                 = [root run '_trans_sss.fif'];
cfg1.trialfun                = 'trialfun_mtt_refspace3_v2';

cfg1.dftfilter               = 'no';
cfg1.lpfilter                = 'no'; 
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

save(['C:\MTT_MEG\data\' nip '\processed\SpaceRef3_nofilt_' run '.mat'],'data')




