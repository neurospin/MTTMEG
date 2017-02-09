function timelock_distref(nip)

% define channel types
[Grads1,Grads2,Mags]   = grads_for_layouts('Laptop');

clear datafilt40
data1 = load(['C:\MTT_MEG\data\' nip '\processed\DISTREF1_filt40.mat']);
data2 = load(['C:\MTT_MEG\data\' nip '\processed\DISTREF2_filt40.mat']);
data3 = load(['C:\MTT_MEG\data\' nip '\processed\DISTREF3_filt40.mat']);
data4 = load(['C:\MTT_MEG\data\' nip '\processed\DISTREF4_filt40.mat']);
data5 = load(['C:\MTT_MEG\data\' nip '\processed\DISTREF5_filt40.mat']);

%% T1

% cfg.trials             = 'all';
% cfg.minlength          = 'maxperlen';
% cfg.offset             = 0.4*data.fsample;
% dataraT1               = ft_redefinetrial(cfg, datafilt40);
dataraDISTREF1          = data1.datafilt40;
dataraDISTREF2          = data2.datafilt40;
dataraDISTREF3          = data3.datafilt40;
dataraDISTREF4          = data4.datafilt40;
dataraDISTREF5          = data5.datafilt40;

cfg.channel            = Mags;
cfg.trials             = 'all';
cfg.keeptrials         = 'no';
cfg.removemean         = 'yes';
cfg.covariance         = 'yes';
cfg.covariancewindow   = [0 1.5];
datalockmagsDISTREF1  = ft_timelockanalysis(cfg, dataraDISTREF1);
datalockmagsDISTREF2  = ft_timelockanalysis(cfg, dataraDISTREF2);
datalockmagsDISTREF3  = ft_timelockanalysis(cfg, dataraDISTREF3);
datalockmagsDISTREF4  = ft_timelockanalysis(cfg, dataraDISTREF4);
datalockmagsDISTREF5  = ft_timelockanalysis(cfg, dataraDISTREF5);

cfg.channel             = Grads1;
datalockgrads1DISTREF1 = ft_timelockanalysis(cfg, dataraDISTREF1);
datalockgrads1DISTREF2 = ft_timelockanalysis(cfg, dataraDISTREF2);
datalockgrads1DISTREF3 = ft_timelockanalysis(cfg, dataraDISTREF3);
datalockgrads1DISTREF4 = ft_timelockanalysis(cfg, dataraDISTREF4);
datalockgrads1DISTREF5 = ft_timelockanalysis(cfg, dataraDISTREF5);

cfg.channel             = Grads2;
datalockgrads2DISTREF1 = ft_timelockanalysis(cfg, dataraDISTREF1);
datalockgrads2DISTREF2 = ft_timelockanalysis(cfg, dataraDISTREF2);
datalockgrads2DISTREF3 = ft_timelockanalysis(cfg, dataraDISTREF3);
datalockgrads2DISTREF4 = ft_timelockanalysis(cfg, dataraDISTREF4);
datalockgrads2DISTREF5 = ft_timelockanalysis(cfg, dataraDISTREF5);

cfg                     = [];
cfg.baseline            = [0.15 0.3]; 
cfg.channel             = 'all';
timelockbasemagsDISTREF1   = ft_timelockbaseline(cfg, datalockmagsDISTREF1);
timelockbasemagsDISTREF2   = ft_timelockbaseline(cfg, datalockmagsDISTREF2);
timelockbasemagsDISTREF3   = ft_timelockbaseline(cfg, datalockmagsDISTREF3);
timelockbasemagsDISTREF4   = ft_timelockbaseline(cfg, datalockmagsDISTREF4);
timelockbasemagsDISTREF5   = ft_timelockbaseline(cfg, datalockmagsDISTREF5);

timelockbasegrads1DISTREF1   = ft_timelockbaseline(cfg, datalockgrads1DISTREF1);
timelockbasegrads1DISTREF2   = ft_timelockbaseline(cfg, datalockgrads1DISTREF2);
timelockbasegrads1DISTREF3   = ft_timelockbaseline(cfg, datalockgrads1DISTREF3);
timelockbasegrads1DISTREF4   = ft_timelockbaseline(cfg, datalockgrads1DISTREF4);
timelockbasegrads1DISTREF5   = ft_timelockbaseline(cfg, datalockgrads1DISTREF5);

timelockbasegrads2DISTREF1   = ft_timelockbaseline(cfg, datalockgrads2DISTREF1);
timelockbasegrads2DISTREF2   = ft_timelockbaseline(cfg, datalockgrads2DISTREF2);
timelockbasegrads2DISTREF3   = ft_timelockbaseline(cfg, datalockgrads2DISTREF3);
timelockbasegrads2DISTREF4   = ft_timelockbaseline(cfg, datalockgrads2DISTREF4);
timelockbasegrads2DISTREF5   = ft_timelockbaseline(cfg, datalockgrads2DISTREF5);

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
cfg.graphcolor         = [[0 0 0];[0 0 0.7];[0.5 0.5 1];[0.7 0 0];[1 0.5 0.5]];

cfg.layout             = 'C:\FIELDTRIP\fieldtrip-20120402\template\layout/NM306mag.lay';
lay                    = ft_prepare_layout(cfg,timelockbasemagsDISTREF1);
lay.label              = Mags;
cfg.layout             = lay;
figure
ft_multiplotER(cfg,timelockbasemagsDISTREF1,timelockbasemagsDISTREF2,timelockbasemagsDISTREF3,...
                   timelockbasemagsDISTREF4,timelockbasemagsDISTREF5)

cfg.layout             = 'C:\FIELDTRIP\fieldtrip-20120402\template\layout/NM306mag.lay';
lay                    = ft_prepare_layout(cfg,timelockbasegrads1DISTREF1);
lay.label              = Grads1;
cfg.layout             = lay;
figure
ft_multiplotER(cfg,timelockbasegrads1DISTREF1,timelockbasegrads1DISTREF2,timelockbasegrads1DISTREF3,...
                   timelockbasegrads1DISTREF4,timelockbasegrads1DISTREF5)

cfg.layout             = 'C:\FIELDTRIP\fieldtrip-20120402\template\layout/NM306mag.lay';
lay                    = ft_prepare_layout(cfg,timelockbasegrads2DISTREF1);
lay.label              = Grads2;
cfg.layout             = lay;
figure
ft_multiplotER(cfg,timelockbasegrads2DISTREF1,timelockbasegrads2DISTREF2,timelockbasegrads2DISTREF3,...
                   timelockbasegrads2DISTREF4,timelockbasegrads2DISTREF5)

               