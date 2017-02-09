function timelock_dim(nip)

% define channel types
[Grads1,Grads2,Mags]   = grads_for_layouts('Laptop');

clear datafilt40
datat1 = load(['C:\MTT_MEG\data\' nip '\processed\TIMEQT1_filt40.mat']);
datat2 = load(['C:\MTT_MEG\data\' nip '\processed\TIMEQT2_filt40.mat']);
datat3 = load(['C:\MTT_MEG\data\' nip '\processed\TIMEQT3_filt40.mat']);
datat4 = load(['C:\MTT_MEG\data\' nip '\processed\TIMEQT4_filt40.mat']);
datat5 = load(['C:\MTT_MEG\data\' nip '\processed\TIMEQT5_filt40.mat']);

datas1 = load(['C:\MTT_MEG\data\' nip '\processed\SPACEQT1_filt40.mat']);
datas2 = load(['C:\MTT_MEG\data\' nip '\processed\SPACEQT2_filt40.mat']);
datas3 = load(['C:\MTT_MEG\data\' nip '\processed\SPACEQT3_filt40.mat']);
datas4 = load(['C:\MTT_MEG\data\' nip '\processed\SPACEQT4_filt40.mat']);
datas5 = load(['C:\MTT_MEG\data\' nip '\processed\SPACEQT5_filt40.mat']);

%% T1

% cfg.trials             = 'all';
% cfg.minlength          = 'maxperlen';
% cfg.offset             = 0.4*data.fsample;
% dataraT1               = ft_redefinetrial(cfg, datafilt40);
dataraTIME1               = datat1.datafilt40;
dataraTIME2               = datat2.datafilt40;
dataraTIME3               = datat3.datafilt40;
dataraTIME4               = datat4.datafilt40;
dataraTIME5               = datat5.datafilt40;
dataraSPACE1              = datas1.datafilt40;
dataraSPACE2              = datas2.datafilt40;
dataraSPACE3              = datas3.datafilt40;
dataraSPACE4              = datas4.datafilt40;
dataraSPACE5              = datas5.datafilt40;

for i = 1:length(dataraTIME1.time)
    dataraTIME1.time{1,i} = dataraTIME1.time{1,i} - ones(1,length(dataraTIME1.time{1,i}))*(0.35);
end
for i = 1:length(dataraTIME2.time)
    dataraTIME2.time{1,i} = dataraTIME2.time{1,i} - ones(1,length(dataraTIME2.time{1,i}))*(0.35);
end
for i = 1:length(dataraTIME3.time)
    dataraTIME3.time{1,i} = dataraTIME3.time{1,i} - ones(1,length(dataraTIME3.time{1,i}))*(0.35);
end
for i = 1:length(dataraTIME4.time)
    dataraTIME4.time{1,i} = dataraTIME4.time{1,i} - ones(1,length(dataraTIME4.time{1,i}))*(0.35);
end
for i = 1:length(dataraTIME5.time)
    dataraTIME5.time{1,i} = dataraTIME5.time{1,i} - ones(1,length(dataraTIME5.time{1,i}))*(0.35);
end

for i = 1:length(dataraSPACE1.time)
    dataraSPACE1.time{1,i} = dataraSPACE1.time{1,i} - ones(1,length(dataraSPACE1.time{1,i}))*(0.35);
end
for i = 1:length(dataraSPACE2.time)
    dataraSPACE2.time{1,i} = dataraSPACE2.time{1,i} - ones(1,length(dataraSPACE2.time{1,i}))*(0.35);
end
for i = 1:length(dataraSPACE3.time)
    dataraSPACE3.time{1,i} = dataraSPACE3.time{1,i} - ones(1,length(dataraSPACE3.time{1,i}))*(0.35);
end
for i = 1:length(dataraSPACE4.time)
    dataraSPACE4.time{1,i} = dataraSPACE4.time{1,i} - ones(1,length(dataraSPACE4.time{1,i}))*(0.35);
end
for i = 1:length(dataraSPACE5.time)
    dataraSPACE5.time{1,i} = dataraSPACE5.time{1,i} - ones(1,length(dataraSPACE5.time{1,i}))*(0.35);
end

dataraDIM1                = ft_appenddata([],dataraTIME1,dataraTIME2,dataraTIME3,dataraTIME4,dataraTIME5);
dataraDIM2                = ft_appenddata([],dataraSPACE1,dataraSPACE2,dataraSPACE3,dataraSPACE4,dataraSPACE5);

cfg                    = [];
cfg.channel            = Mags;
cfg.trials             = 'all';
cfg.keeptrials         = 'no';
% cfg.removemean         = 'yes';
% cfg.covariance         = 'yes';
% cfg.covariancewindow   = [0 1.5];
datalockmagsDIM1       = ft_timelockanalysis(cfg, dataraDIM1);
datalockmagsDIM2       = ft_timelockanalysis(cfg, dataraDIM2);
cfg.keeptrials         = 'yes';
datalockmagsDIM1t      = ft_timelockanalysis(cfg, dataraDIM1);
datalockmagsDIM2t      = ft_timelockanalysis(cfg, dataraDIM2);

cfg.channel            = Grads1;
cfg.keeptrials         = 'no';
datalockgrads1DIM1     = ft_timelockanalysis(cfg, dataraDIM1);
datalockgrads1DIM2     = ft_timelockanalysis(cfg, dataraDIM2);
cfg.keeptrials         = 'yes';
datalockgrads1DIM1t    = ft_timelockanalysis(cfg, dataraDIM1);
datalockgrads1DIM2t    = ft_timelockanalysis(cfg, dataraDIM2);

cfg.channel            = Grads2;
cfg.keeptrials         = 'no';
datalockgrads2DIM1     = ft_timelockanalysis(cfg, dataraDIM1);
datalockgrads2DIM2     = ft_timelockanalysis(cfg, dataraDIM2);
cfg.keeptrials         = 'yes';
datalockgrads2DIM1t    = ft_timelockanalysis(cfg, dataraDIM1);
datalockgrads2DIM2t    = ft_timelockanalysis(cfg, dataraDIM2);

cfg                    = [];
cfg.baseline           = [-0.15 0];
cfg.channel            = 'all';
timelockbasemagsDIM1   = ft_timelockbaseline(cfg, datalockmagsDIM1);
timelockbasemagsDIM2   = ft_timelockbaseline(cfg, datalockmagsDIM2);
timelockbasemagsDIM1t  = ft_timelockbaseline(cfg, datalockmagsDIM1t);
timelockbasemagsDIM2t  = ft_timelockbaseline(cfg, datalockmagsDIM2t);

timelockbasegrads1DIM1  = ft_timelockbaseline(cfg, datalockgrads1DIM1);
timelockbasegrads1DIM2  = ft_timelockbaseline(cfg, datalockgrads1DIM2);
timelockbasegrads1DIM1t = ft_timelockbaseline(cfg, datalockgrads1DIM1t);
timelockbasegrads1DIM2t = ft_timelockbaseline(cfg, datalockgrads1DIM2t);

timelockbasegrads2DIM1  = ft_timelockbaseline(cfg, datalockgrads2DIM1);
timelockbasegrads2DIM2  = ft_timelockbaseline(cfg, datalockgrads2DIM2);
timelockbasegrads2DIM1t = ft_timelockbaseline(cfg, datalockgrads2DIM1t);
timelockbasegrads2DIM2t = ft_timelockbaseline(cfg, datalockgrads2DIM2t);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[Grads1,Grads2,Mags]   = grads_for_layouts('Laptop');
%%
cfg                    = [];
cfg.axes               = 'no';
cfg.xlim               = [0 2];
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
cfg.graphcolor         = [[1 0 0];[0 0 1]];

cfg.layout             = 'C:\FIELDTRIP\fieldtrip-20120402\template\layout/NM306mag.lay';
lay                    = ft_prepare_layout(cfg,timelockbasemagsDIM1);
lay.label              = Mags;
cfg.layout             = lay;
figure
ft_multiplotER(cfg,timelockbasemagsDIM1,timelockbasemagsDIM2)

cfg.layout             = 'C:\FIELDTRIP\fieldtrip-20120402\template\layout/NM306mag.lay';
lay                    = ft_prepare_layout(cfg,timelockbasegrads1DIM1);
lay.label              = Grads1;
cfg.layout             = lay;
figure
ft_multiplotER(cfg,timelockbasegrads1DIM1,timelockbasegrads1DIM2)

cfg.layout             = 'C:\FIELDTRIP\fieldtrip-20120402\template\layout/NM306mag.lay';
lay                    = ft_prepare_layout(cfg,timelockbasegrads2DIM1);
lay.label              = Grads2;
cfg.layout             = lay;
figure
ft_multiplotER(cfg,timelockbasegrads2DIM1,timelockbasegrads2DIM2)

%% compute ERFs T-stats
ERFstatT_subjectlevel(timelockbasemagsDIM1t,timelockbasemagsDIM2t)
ERFstatT_subjectlevel(timelockbasegrads1DIM1t,timelockbasegrads1DIM2t)
ERFstatT_subjectlevel(timelockbasegrads2DIM1t,timelockbasegrads2DIM2t)

