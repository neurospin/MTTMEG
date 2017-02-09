function timelock_ref(nip)

% define channel types
[Grads1,Grads2,Mags]   = grads_for_layouts('Laptop');

clear datafilt40
data1 = load(['C:\MTT_MEG\data\' nip '\processed\REF1_filt40.mat']);
data2 = load(['C:\MTT_MEG\data\' nip '\processed\REF2_filt40.mat']);
data3 = load(['C:\MTT_MEG\data\' nip '\processed\REF3_filt40.mat']);
data4 = load(['C:\MTT_MEG\data\' nip '\processed\REF4_filt40.mat']);
data5 = load(['C:\MTT_MEG\data\' nip '\processed\REF5_filt40.mat']);

%% T1

% cfg.trials             = 'all';
% cfg.minlength          = 'maxperlen';
% cfg.offset             = 0.4*data.fsample;
% dataraT1               = ft_redefinetrial(cfg, datafilt40);
dataraREF1               = data1.datafilt40;
dataraREF2               = data2.datafilt40;
dataraREF3               = data3.datafilt40;
dataraREF4               = data4.datafilt40;
dataraREF5               = data5.datafilt40;

for i = 1:length(dataraREF1.time)
    dataraREF1.time{1,i} = dataraREF1.time{1,i} - ones(1,length(dataraREF1.time{1,i}))*(0.45);
end
for i = 1:length(dataraREF2.time)
    dataraREF2.time{1,i} = dataraREF2.time{1,i} - ones(1,length(dataraREF2.time{1,i}))*(0.45);
end
for i = 1:length(dataraREF3.time)
    dataraREF3.time{1,i} = dataraREF3.time{1,i} - ones(1,length(dataraREF3.time{1,i}))*(0.45);
end
for i = 1:length(dataraREF4.time)
    dataraREF4.time{1,i} = dataraREF4.time{1,i} - ones(1,length(dataraREF4.time{1,i}))*(0.45);
end
for i = 1:length(dataraREF5.time)
    dataraREF5.time{1,i} = dataraREF5.time{1,i} - ones(1,length(dataraREF5.time{1,i}))*(0.45);
end

cfg.channel            = Mags;
cfg.trials             = 'all';
cfg.keeptrials         = 'no';
cfg.removemean         = 'yes';
cfg.covariance         = 'yes';
% cfg.covariancewindow   = [0 1.5];
datalockmagsREF1       = ft_timelockanalysis(cfg, dataraREF1);
datalockmagsREF2       = ft_timelockanalysis(cfg, dataraREF2);
datalockmagsREF3       = ft_timelockanalysis(cfg, dataraREF3);
datalockmagsREF4       = ft_timelockanalysis(cfg, dataraREF4);
datalockmagsREF5       = ft_timelockanalysis(cfg, dataraREF5);
cfg.keeptrials         = 'yes';
datalockmagsREF1t      = ft_timelockanalysis(cfg, dataraREF1);
datalockmagsREF2t      = ft_timelockanalysis(cfg, dataraREF2);
datalockmagsREF3t      = ft_timelockanalysis(cfg, dataraREF3);
datalockmagsREF4t      = ft_timelockanalysis(cfg, dataraREF4);
datalockmagsREF5t      = ft_timelockanalysis(cfg, dataraREF5);

cfg.channel            = Grads1;
cfg.keeptrials         = 'no';
datalockgrads1REF1     = ft_timelockanalysis(cfg, dataraREF1);
datalockgrads1REF2     = ft_timelockanalysis(cfg, dataraREF2);
datalockgrads1REF3     = ft_timelockanalysis(cfg, dataraREF3);
datalockgrads1REF4     = ft_timelockanalysis(cfg, dataraREF4);
datalockgrads1REF5     = ft_timelockanalysis(cfg, dataraREF5);
cfg.keeptrials         = 'yes';
datalockgrads1REF1t    = ft_timelockanalysis(cfg, dataraREF1);
datalockgrads1REF2t    = ft_timelockanalysis(cfg, dataraREF2);
datalockgrads1REF3t    = ft_timelockanalysis(cfg, dataraREF3);
datalockgrads1REF4t    = ft_timelockanalysis(cfg, dataraREF4);
datalockgrads1REF5t    = ft_timelockanalysis(cfg, dataraREF5);

cfg.channel            = Grads2;
cfg.keeptrials         = 'no';
datalockgrads2REF1     = ft_timelockanalysis(cfg, dataraREF1);
datalockgrads2REF2     = ft_timelockanalysis(cfg, dataraREF2);
datalockgrads2REF3     = ft_timelockanalysis(cfg, dataraREF3);
datalockgrads2REF4     = ft_timelockanalysis(cfg, dataraREF4);
datalockgrads2REF5     = ft_timelockanalysis(cfg, dataraREF5);
cfg.keeptrials         = 'yes';
datalockgrads2REF1t    = ft_timelockanalysis(cfg, dataraREF1);
datalockgrads2REF2t    = ft_timelockanalysis(cfg, dataraREF2);
datalockgrads2REF3t    = ft_timelockanalysis(cfg, dataraREF3);
datalockgrads2REF4t    = ft_timelockanalysis(cfg, dataraREF4);
datalockgrads2REF5t    = ft_timelockanalysis(cfg, dataraREF5);

cfg                    = [];
cfg.baseline           = [-0.25 0]; 
cfg.channel            = 'all';
timelockbasemagsREF1   = ft_timelockbaseline(cfg, datalockmagsREF1);
timelockbasemagsREF2   = ft_timelockbaseline(cfg, datalockmagsREF2);
timelockbasemagsREF3   = ft_timelockbaseline(cfg, datalockmagsREF3);
timelockbasemagsREF4   = ft_timelockbaseline(cfg, datalockmagsREF4);
timelockbasemagsREF5   = ft_timelockbaseline(cfg, datalockmagsREF5);
timelockbasegrads1REF1 = ft_timelockbaseline(cfg, datalockgrads1REF1);
timelockbasegrads1REF2 = ft_timelockbaseline(cfg, datalockgrads1REF2);
timelockbasegrads1REF3 = ft_timelockbaseline(cfg, datalockgrads1REF3);
timelockbasegrads1REF4 = ft_timelockbaseline(cfg, datalockgrads1REF4);
timelockbasegrads1REF5 = ft_timelockbaseline(cfg, datalockgrads1REF5);
timelockbasegrads2REF1 = ft_timelockbaseline(cfg, datalockgrads2REF1);
timelockbasegrads2REF2 = ft_timelockbaseline(cfg, datalockgrads2REF2);
timelockbasegrads2REF3 = ft_timelockbaseline(cfg, datalockgrads2REF3);
timelockbasegrads2REF4 = ft_timelockbaseline(cfg, datalockgrads2REF4);
timelockbasegrads2REF5 = ft_timelockbaseline(cfg, datalockgrads2REF5);

timelockbasemagsREF1t   = ft_timelockbaseline(cfg, datalockmagsREF1t);
timelockbasemagsREF2t   = ft_timelockbaseline(cfg, datalockmagsREF2t);
timelockbasemagsREF3t   = ft_timelockbaseline(cfg, datalockmagsREF3t);
timelockbasemagsREF4t   = ft_timelockbaseline(cfg, datalockmagsREF4t);
timelockbasemagsREF5t   = ft_timelockbaseline(cfg, datalockmagsREF5t);
timelockbasegrads1REF1t = ft_timelockbaseline(cfg, datalockgrads1REF1t);
timelockbasegrads1REF2t = ft_timelockbaseline(cfg, datalockgrads1REF2t);
timelockbasegrads1REF3t = ft_timelockbaseline(cfg, datalockgrads1REF3t);
timelockbasegrads1REF4t = ft_timelockbaseline(cfg, datalockgrads1REF4t);
timelockbasegrads1REF5t = ft_timelockbaseline(cfg, datalockgrads1REF5t);
timelockbasegrads2REF1t = ft_timelockbaseline(cfg, datalockgrads2REF1t);
timelockbasegrads2REF2t = ft_timelockbaseline(cfg, datalockgrads2REF2t);
timelockbasegrads2REF3t = ft_timelockbaseline(cfg, datalockgrads2REF3t);
timelockbasegrads2REF4t = ft_timelockbaseline(cfg, datalockgrads2REF4t);
timelockbasegrads2REF5t = ft_timelockbaseline(cfg, datalockgrads2REF5t);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[Grads1,Grads2,Mags]   = grads_for_layouts('Laptop');
%%
cfg                    = [];
cfg.axes               = 'no';
cfg.xlim               = [0 2.5];
cfg.zlim               = 'maxabs';
cfg.channel            = 'all';
cfg.baseline           = 'no';
cfg.baselinetype       = 'absolute';
cfg.trials             = 'all';
cfg.showlabels         = 'no';
cfg.colormap           = jet;
cfg.marker             = 'off';
cfg.markersymbol       = 'o';
cfg.markercolor        = [0 0 0];
cfg.markersize         = 2;
cfg.markerfontsize     = 8;
cfg.linewidth          = 2;
cfg.axes               = 'yes';
cfg.colorbar           = 'yes';
cfg.showoutline        = 'no';
cfg.interplimits       = 'head';
cfg.interpolation      = 'v4';
cfg.style              = 'straight';
cfg.gridscale          = 67;
cfg.shading            = 'flat';
cfg.interactive        = 'yes';
cfg.graphcolor         = [[0 0 0];[0 0 0.7];[0.5 0.5 1];[0.7 0 0];[1 0.5 0.5]];
cfg.graphcolor         = [[0 0 0];[0.7 0 0];[1 0.5 0.5]];

cfg.layout             = 'C:\FIELDTRIP\fieldtrip-20120402\template\layout/NM306mag.lay';
lay                    = ft_prepare_layout(cfg,timelockbasemagsREF1);
lay.label              = Mags;
cfg.layout             = lay;
figure
ft_multiplotER(cfg,timelockbasemagsREF1,timelockbasemagsREF2,timelockbasemagsREF3,...
    timelockbasemagsREF4,timelockbasemagsREF5)
ft_multiplotER(cfg,timelockbasemagsREF1,timelockbasemagsREF2,timelockbasemagsREF3)
ft_multiplotER(cfg,timelockbasemagsREF1,timelockbasemagsREF4,timelockbasemagsREF5)
ft_multiplotER(cfg,timelockbasemagsREF1,timelockbasemagsREF2)
ft_multiplotER(cfg,timelockbasemagsREF1,timelockbasemagsREF3)
ft_multiplotER(cfg,timelockbasemagsREF1,timelockbasemagsREF4)
ft_multiplotER(cfg,timelockbasemagsREF1,timelockbasemagsREF5)


cfg.layout             = 'C:\FIELDTRIP\fieldtrip-20120402\template\layout/NM306mag.lay';
lay                    = ft_prepare_layout(cfg,timelockbasegrads1REF1);
lay.label              = Grads1;
cfg.layout             = lay;
figure
ft_multiplotER(cfg,timelockbasegrads1REF1,timelockbasegrads1REF2,timelockbasegrads1REF3,...
    timelockbasegrads1REF4,timelockbasegrads1REF5)
ft_multiplotER(cfg,timelockbasegrads1REF1,timelockbasegrads1REF2,timelockbasegrads1REF3)
ft_multiplotER(cfg,timelockbasegrads1REF1,timelockbasegrads1REF4,timelockbasegrads1REF5)
ft_multiplotER(cfg,timelockbasegrads1REF1,timelockbasegrads1REF2)
ft_multiplotER(cfg,timelockbasegrads1REF1,timelockbasegrads1REF3)
ft_multiplotER(cfg,timelockbasegrads1REF1,timelockbasegrads1REF4)
ft_multiplotER(cfg,timelockbasegrads1REF1,timelockbasegrads1REF5)

cfg.layout             = 'C:\FIELDTRIP\fieldtrip-20120402\template\layout/NM306mag.lay';
lay                    = ft_prepare_layout(cfg,timelockbasegrads2REF1);
lay.label              = Grads2;
cfg.layout             = lay;
figure
ft_multiplotER(cfg,timelockbasegrads2REF1,timelockbasegrads2REF2,timelockbasegrads2REF3,...
    timelockbasegrads2REF4,timelockbasegrads2REF5)
ft_multiplotER(cfg,timelockbasegrads2REF1,timelockbasegrads2REF2,timelockbasegrads2REF3)
ft_multiplotER(cfg,timelockbasegrads2REF1,timelockbasegrads2REF4,timelockbasegrads2REF5)
ft_multiplotER(cfg,timelockbasegrads2REF1,timelockbasegrads2REF2)
ft_multiplotER(cfg,timelockbasegrads2REF1,timelockbasegrads2REF3)
ft_multiplotER(cfg,timelockbasegrads2REF1,timelockbasegrads2REF4)
ft_multiplotER(cfg,timelockbasegrads2REF1,timelockbasegrads2REF5)

%% compute REFs F-stats
ERFstatF_subjectlevel(timelockbasemagsREF1t,timelockbasemagsREF2t,timelockbasemagsREF3t,...
timelockbasemagsREF4t,timelockbasemagsREF5t)
ERFstatF_subjectlevel(timelockbasegrads1REF1t,timelockbasegrads1REF2t,timelockbasegrads1REF3t,...
timelockbasegrads1REF4t,timelockbasegrads1REF5t)
ERFstatF_subjectlevel(timelockbasegrads2REF1t,timelockbasegrads2REF2t,timelockbasegrads2REF3t,...
timelockbasegrads2REF4t,timelockbasegrads2REF5t)

ERFstatF_subjectlevel(timelockbasemagsREF1t,timelockbasemagsREF2t,timelockbasemagsREF3t)
ERFstatF_subjectlevel(timelockbasemagsREF1t,timelockbasemagsREF4t,timelockbasemagsREF5t)

ERFstatF_subjectlevel(timelockbasegrads1REF1t,timelockbasegrads1REF2t,timelockbasegrads1REF3t)
ERFstatF_subjectlevel(timelockbasegrads1REF1t,timelockbasegrads1REF4t,timelockbasegrads1REF5t)

ERFstatF_subjectlevel(timelockbasegrads2REF1t,timelockbasegrads2REF2t,timelockbasegrads2REF3t)
ERFstatF_subjectlevel(timelockbasegrads2REF1t,timelockbasegrads2REF4t,timelockbasegrads2REF5t)


ERFstatT_subjectlevel(timelockbasemagsREF1t,timelockbasemagsREF2t)
ERFstatT_subjectlevel(timelockbasemagsREF1t,timelockbasemagsREF3t)
ERFstatT_subjectlevel(timelockbasemagsREF1t,timelockbasemagsREF4t)
ERFstatT_subjectlevel(timelockbasemagsREF1t,timelockbasemagsREF5t)

ERFstatT_subjectlevel(timelockbasegrads1REF1t,timelockbasegrads1REF2t)
ERFstatT_subjectlevel(timelockbasegrads1REF1t,timelockbasegrads1REF3t)
ERFstatT_subjectlevel(timelockbasegrads1REF1t,timelockbasegrads1REF4t)
ERFstatT_subjectlevel(timelockbasegrads1REF1t,timelockbasegrads1REF5t)

