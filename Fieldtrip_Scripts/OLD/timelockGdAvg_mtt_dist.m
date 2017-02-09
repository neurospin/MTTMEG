function timelockGdAvg_mtt_dist(nip,window)

load(['C:\MTT_MEG\data\' nip '\processed\Mags_DIST_lock_filt40'])
load(['C:\MTT_MEG\data\' nip '\processed\Grads1_DIST_lock_filt40'])
load(['C:\MTT_MEG\data\' nip '\processed\Grads2_DIST_lock_filt40'])

[Grads1,Grads2,Mags]   = grads_for_layouts('Laptop');
%%
cfg                    = [];
cfg.axes               = 'no';
cfg.xlim               = [0 2.5];
cfg.zparam             = 'avg';
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
cfg.linewidth          = 1;
cfg.axes               = 'yes';
cfg.colorbar           = 'yes';
cfg.showoutline        = 'no';
cfg.interplimits       = 'head';
cfg.interpolation      = 'v4';
cfg.style              = 'straight';
cfg.gridscale          = 67;
cfg.shading            = 'flat';
cfg.interactive        = 'yes';
cfg.comment            = 'yes';

cfg.layout             = 'C:\FIELDTRIP\fieldtrip-20120402\template\layout/NM306mag.lay';
lay                    = ft_prepare_layout(cfg,timelockbasemagsPaF);
lay.label              = Mags;
cfg.layout             = lay;
figure
ft_multiplotER(cfg,timelockbasemagsPaF, timelockbasemagsPaC)

cfg.layout             = 'C:\FIELDTRIP\fieldtrip-20120402\template\layout/NM306mag.lay';
lay                    = ft_prepare_layout(cfg,timelockbasegrads1PaF);
lay.label              = Grads1;
cfg.layout             = lay;
figure
ft_multiplotER(cfg,timelockbasegrads1PaF, timelockbasegrads1PaC)

cfg.layout             = 'C:\FIELDTRIP\fieldtrip-20120402\template\layout/NM306mag.lay';
lay                    = ft_prepare_layout(cfg,timelockbasegrads2PaF);
lay.label              = Grads2;
cfg.layout             = lay;
figure
ft_multiplotER(cfg,timelockbasegrads2PaF, timelockbasegrads2PaC)

%%
cfg.layout             = 'C:\FIELDTRIP\fieldtrip-20120402\template\layout/NM306mag.lay';
lay                    = ft_prepare_layout(cfg,timelockbasemagsPaF);
lay.label              = Mags;
cfg.layout             = lay;
figure
ft_multiplotER(cfg,timelockbasemagsPrF, timelockbasemagsPrC)

cfg.layout             = 'C:\FIELDTRIP\fieldtrip-20120402\template\layout/NM306mag.lay';
lay                    = ft_prepare_layout(cfg,timelockbasegrads1PaF);
lay.label              = Grads1;
cfg.layout             = lay;
figure
ft_multiplotER(cfg,timelockbasegrads1PrF, timelockbasegrads1PrC)

cfg.layout             = 'C:\FIELDTRIP\fieldtrip-20120402\template\layout/NM306mag.lay';
lay                    = ft_prepare_layout(cfg,timelockbasegrads2PaF);
lay.label              = Grads2;
cfg.layout             = lay;
figure
ft_multiplotER(cfg,timelockbasegrads2PrF, timelockbasegrads2PrC)

%%
cfg.layout             = 'C:\FIELDTRIP\fieldtrip-20120402\template\layout/NM306mag.lay';
lay                    = ft_prepare_layout(cfg,timelockbasemagsPaF);
lay.label              = Mags;
cfg.layout             = lay;
figure
ft_multiplotER(cfg,timelockbasemagsFF, timelockbasemagsFC)

cfg.layout             = 'C:\FIELDTRIP\fieldtrip-20120402\template\layout/NM306mag.lay';
lay                    = ft_prepare_layout(cfg,timelockbasegrads1PaF);
lay.label              = Grads1;
cfg.layout             = lay;
figure
ft_multiplotER(cfg,timelockbasegrads1FF, timelockbasegrads1FC)

cfg.layout             = 'C:\FIELDTRIP\fieldtrip-20120402\template\layout/NM306mag.lay';
lay                    = ft_prepare_layout(cfg,timelockbasegrads2PaF);
lay.label              = Grads2;
cfg.layout             = lay;
figure
ft_multiplotER(cfg,timelockbasegrads2FF, timelockbasegrads2FC)



