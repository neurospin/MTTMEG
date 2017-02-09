function resonance_preproc(run,nip,runref,tag)

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
cfg.photodelay              = 0.0038;
cfg.trialfun                = 'trialfun_resonance_stimfreq';
cfg.lpfreq                  = 'no';
cfg.dftfilter               = 'yes';

% trial definition and preprocessing
disp(['processing ' run]);
cfg.dataset             = [par.DataDir run '_raw_trans_sss.fif'];
dataset                 = cfg.dataset;
cfg.channel             = {'MEG*'};
cfg_loc                 = ft_definetrial(cfg);
data                    = ft_preprocessing(cfg_loc);

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

% trial number attribution
num = xlsread(['C:\RESONANCE_MEG\STIMS\' nip '\' run '.xls']);

cfg                         = [];
cfg.method                  = 'summary';
cfg.keepchannel             = 'yes';
cfg.channel                 = Mags;
data                        = ft_rejectvisual(cfg,data);
tmp1                        = data.badtrialvisual;
cfg.channel                 = Grads1;
data                        = ft_rejectvisual(cfg,data);
tmp2                        = data.badtrialvisual;
cfg.channel                 = Grads2;
data                        = ft_rejectvisual(cfg,data);
tmp3                        = data.badtrialvisual;
tmp4                        = union(tmp1,tmp2);
tmp5                        = union(tmp4,tmp3);

for i = [40 65 90 140 190 290 390 590]
    x = [];y = [];
    [x,y] = find(num(:,1) == i);
    cfg = [];
    cfg.trials = intersect(x',setxor(x',tmp5));
    DATA      = redefinetrial(cfg,data);
    save([par.ProcDataDir run '_' num2str(i+10) '_stimfreq.mat'],'DATA')
end

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
cfg.photodelay              = 0.0038;
cfg.trialfun                = 'trialfun_resonance_baseline';
cfg.lpfreq                  = 'no';
cfg.dftfilter               = 'yes';

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

% trial number attribution
num = xlsread(['C:\RESONANCE_MEG\STIMS\' nip '\' run '.xls']);

cfg                         = [];
cfg.method                  = 'summary';
cfg.keepchannel             = 'yes';
cfg.channel                 = Mags;
data                        = ft_rejectvisual(cfg,data);
tmp1                        = data.badtrialvisual;
cfg.channel                 = Grads1;
data                        = ft_rejectvisual(cfg,data);
tmp2                        = data.badtrialvisual;
cfg.channel                 = Grads2;
data                        = ft_rejectvisual(cfg,data);
tmp3                        = data.badtrialvisual;
tmp4                        = union(tmp1,tmp2);
tmp5                        = union(tmp4,tmp3);

for i = [40 65 90 140 190 290 390 590]
    x = [];
    y = [];
    [x,y] = find(num(:,1) == i);
    cfg = [];
    cfg.trials = intersect(x',setxor(x',tmp5));
    DATA      = redefinetrial(cfg,data);
    save([par.ProcDataDir run '_' num2str(i+10) '_baseline.mat'],'DATA')
end


