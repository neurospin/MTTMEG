function timelock_mtt(run, nip)

% define channel types
[Grads1,Grads2,Mags]   = grads_for_layouts('Laptop');

load(['C:\MTT_MEG\data\' nip '\processed\TSCue_Space_filt40_' run '.mat']);

%%

cfg.trials             = 'all';
cfg.minlength          = 'maxperlen';
cfg.offset             = -100;
dataraS                = ft_redefinetrial(cfg, data);

cfg.channel            = Mags;
cfg.trials             = 'all';
cfg.keeptrials         = 'no';
cfg.removemean         = 'yes';
cfg.covariance         = 'yes';
cfg.covariancewindow   = [0 1.5];
datalockmagsS          = ft_timelockanalysis(cfg, dataraS);
cfg.channel            = Grads1;
datalockgrads1S        = ft_timelockanalysis(cfg, dataraS);
cfg.channel            = Grads2;
datalockgrads2S        = ft_timelockanalysis(cfg, dataraS);

cfg                    = [];
cfg.baseline           = [-0.2 0]; 
cfg.channel            = 'all';
timelockbasemagsS      = ft_timelockbaseline(cfg, datalockmagsS);
timelockbasegrads1S    = ft_timelockbaseline(cfg, datalockgrads1S);
timelockbasegrads2S    = ft_timelockbaseline(cfg, datalockgrads2S);

%%
load(['C:\MTT_MEG\data\' nip '\processed\TSCue_Time_filt40_' run '.mat']);

cfg.trials             = 'all';
cfg.minlength          = 'maxperlen';
cfg.offset             = -0.4*data.fsample;
dataraT                = ft_redefinetrial(cfg, data);

cfg.channel            = Mags;
cfg.trials             = 'all';
cfg.keeptrials         = 'no';
cfg.removemean         = 'yes';
cfg.covariance         = 'yes';
cfg.covariancewindow   = [0 1];
datalockmagsT          = ft_timelockanalysis(cfg, dataraT);
cfg.channel            = Grads1;
datalockgrads1T        = ft_timelockanalysis(cfg, dataraT);
cfg.channel            = Grads2;
datalockgrads2T        = ft_timelockanalysis(cfg, dataraT);

cfg                    = [];
cfg.baseline           = [-0.2 0]; 
cfg.channel            = 'all';
timelockbasemagsT      = ft_timelockbaseline(cfg, datalockmagsT);
timelockbasegrads1T    = ft_timelockbaseline(cfg, datalockgrads1T);
timelockbasegrads2T    = ft_timelockbaseline(cfg, datalockgrads2T);

%%

cfg                    = [];
cfg.axes               = 'no';
cfg.xparam             = 'time';
cfg.zparam             = 'avg';
cfg.xlim               = [0 1];
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

% cfg.layout             = 'C:\FIELDTRIP\fieldtrip-20120402\template\layout/NM306mag.lay';
% lay                    = ft_prepare_layout(cfg,timelockbase1);
% lay.label              = Mags;
% cfg.layout             = lay;

% ft_multiplotER(cfg,timelockbase1,timelockbase2)

save(['C:\MTT_MEG\data\' nip '\processed\Mags_TSCue_lock' run '.mat'], ...
'timelockbasemagsT','timelockbasemagsS')

save(['C:\MTT_MEG\data\' nip '\processed\Grads1_TSCue_lock' run '.mat'], ...
'timelockbasegrads1T','timelockbasegrads1S')
  
save(['C:\MTT_MEG\data\' nip '\processed\Grads2_TSCue_lock' run '.mat'], ...
'timelockbasegrads2T','timelockbasegrads2S') 
  




