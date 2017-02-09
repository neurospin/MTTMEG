function freqGdAvg_mtt_v2(nip,window)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[Grads1,Grads2,Mags]   = grads_for_layouts('Laptop');

dataPastFar   = load(['C:\MTT_MEG\data\' nip '\processed\PastFar_nofilt']);
dataPastClose = load(['C:\MTT_MEG\data\' nip '\processed\PastClose_nofilt']);

cfg                    = [];
cfg.method             = 'mtmconvol';
cfg.output             = 'pow';
cfg.trials             = 'all';
cfg.keeptrials         = 'no';
cfg.keeptapers         = 'no';
cfg.pad                = 'maxperlen';
cfg.polyremoval        = 0;
cfg.foi                = 1:35;
cfg.t_ftimwin          = 2./cfg.foi;
cfg.toi                = 0:0.05:2;
cfg.tapsmofrq          = 0.5*cfg.foi;

cfg.channel            = Mags;
dataPaCmagsfreq        = ft_freqanalysis(cfg, dataPastClose.data);
dataPaFmagsfreq        = ft_freqanalysis(cfg, dataPastFar.data);
cfg.channel            = Grads1;
dataPaCgrads1freq      = ft_freqanalysis(cfg, dataPastClose.data);
dataPaFgrads1freq      = ft_freqanalysis(cfg, dataPastFar.data);
cfg.channel            = Grads2;
dataPaCgrads2freq      = ft_freqanalysis(cfg, dataPastClose.data);
dataPaFgrads2freq      = ft_freqanalysis(cfg, dataPastFar.data);

cfg                    = [];
cfg.baseline           = [0.2 0.4]; 
cfg.channel            = 'all';
dataPaCmagsfreq        = ft_freqbaseline(cfg, dataPaCmagsfreq);
dataPaFmagsfreq        = ft_freqbaseline(cfg, dataPaFmagsfreq);
dataPaCgrads1freq      = ft_freqbaseline(cfg, dataPaCgrads1freq);
dataPaFgrads1freq      = ft_freqbaseline(cfg, dataPaFgrads1freq);
dataPaCgrads2freq      = ft_freqbaseline(cfg, dataPaCgrads2freq);
dataPaFgrads2freq      = ft_freqbaseline(cfg, dataPaFgrads2freq);

[Grads1,Grads2,Mags]   = grads_for_layouts('Laptop');
%%
cfg                  = [];
cfg.parameter        = 'powspctrm';
cfg.xlim             = 'maxmin';
cfg.ylim             = 'maxmin';
cfg.zlim             = [-5.e-27 5.e-27];
cfg.channel          = 'all';
cfg.baseline         = 'no';
cfg.trials           = 'all';
cfg.box              = 'yes';
cfg.colorbar         = 'no';
cfg.colormap         = jet;
cfg.showlabels       = 'no';
cfg.showoutline      = 'no';
cfg.interactive      = 'yes';
cfg.masknans         = 'yes';
cfg.layout           = 'C:\FIELDTRIP\fieldtrip-20120402\template\layout/NM306mag.lay';

lay                  = ft_prepare_layout(cfg,dataPaCmagsfreq);
lay.label            = Mags;
cfg.layout           = lay;
figure
ft_multiplotTFR(cfg,dataPaCmagsfreq)
figure
ft_multiplotTFR(cfg,dataPaFmagsfreq)

lay                  = ft_prepare_layout(cfg,dataPaFgrads1freq);
lay.label            = Grads1;
cfg.layout           = lay;
cfg.zlim             = [-5.e-24 5.e-24];
figure
ft_multiplotTFR(cfg,dataPaCgrads1freq)
figure
ft_multiplotTFR(cfg,dataPaFgrads1freq)

lay                  = ft_prepare_layout(cfg,dataPaFgrads2freq);
lay.label            = Grads2;
cfg.layout           = lay;
cfg.zlim             = [-5.e-24 5.e-24];
figure
ft_multiplotTFR(cfg,dataPaCgrads2freq)
figure
ft_multiplotTFR(cfg,dataPaFgrads2freq)

%%

dataFutureFar   = load(['C:\MTT_MEG\data\' nip '\processed\FutureFar_nofilt']);
dataFutureClose = load(['C:\MTT_MEG\data\' nip '\processed\FutureClose_nofilt']);

cfg                    = [];
cfg.method             = 'mtmconvol';
cfg.output             = 'pow';
cfg.trials             = 'all';
cfg.keeptrials         = 'no';
cfg.keeptapers         = 'no';
cfg.pad                = 'maxperlen';
cfg.polyremoval        = 0;
cfg.foi                = 1:35;
cfg.t_ftimwin          = 2./cfg.foi;
cfg.toi                = 0:0.05:2;
cfg.tapsmofrq          = 0.5*cfg.foi;

% cfg                    = [];
% cfg.method             = 'mtmconvol';
% cfg.output             = 'pow';
% cfg.trials             = 'all';
% cfg.keeptrials         = 'no';
% cfg.keeptapers         = 'no';
% cfg.pad                = 'maxperlen';
% cfg.polyremoval        = 0;
% cfg.foi                = 35:5:120;
% cfg.t_ftimwin          = 10./cfg.foi;
% cfg.toi                = 0:0.01:2;
% cfg.tapsmofrq          = 0.5*cfg.foi;

cfg.channel            = Mags;
dataFCmagsfreq         = ft_freqanalysis(cfg, dataFutureClose.data);
dataFFmagsfreq         = ft_freqanalysis(cfg, dataFutureFar.data);
cfg.channel            = Grads1;
dataFCgrads1freq       = ft_freqanalysis(cfg, dataFutureClose.data);
dataFFgrads1freq       = ft_freqanalysis(cfg, dataFutureFar.data);
cfg.channel            = Grads2;
dataFCgrads2freq       = ft_freqanalysis(cfg, dataFutureClose.data);
dataFFgrads2freq       = ft_freqanalysis(cfg, dataFutureFar.data);

cfg                    = [];
cfg.baseline           = [0.2 0.4]; 
cfg.channel            = 'all';
dataFCmagsfreq         = ft_freqbaseline(cfg, dataFCmagsfreq);
dataFFmagsfreq         = ft_freqbaseline(cfg, dataFFmagsfreq);
dataFCgrads1freq       = ft_freqbaseline(cfg, dataFCgrads1freq);
dataFFgrads1freq       = ft_freqbaseline(cfg, dataFFgrads1freq);
dataFCgrads2freq       = ft_freqbaseline(cfg, dataFCgrads2freq);
dataFFgrads2freq       = ft_freqbaseline(cfg, dataFFgrads2freq);

[Grads1,Grads2,Mags]   = grads_for_layouts('Laptop');
%%
cfg                  = [];
cfg.parameter        = 'powspctrm';
cfg.xlim             = 'maxmin';
cfg.ylim             = 'maxmin';
cfg.zlim             = [-5.e-27 5.e-27];
% cfg.zlim             = [-1.e-28 1.e-28];
cfg.channel          = Mags;
cfg.baseline         = 'no';
cfg.trials           = 'all';
cfg.box              = 'yes';
cfg.colorbar         = 'no';
cfg.colormap         = jet;
cfg.showlabels       = 'no';
cfg.showoutline      = 'no';
cfg.interactive      = 'yes';
cfg.masknans         = 'yes';
cfg.layout           = 'C:\FIELDTRIP\fieldtrip-20120402\template\layout/NM306mag.lay';

lay                  = ft_prepare_layout(cfg,dataFCmagsfreq);
lay.label            = Mags;
cfg.layout           = lay;
figure
ft_multiplotTFR(cfg,dataFCmagsfreq)
figure
ft_multiplotTFR(cfg,dataFFmagsfreq)

lay                  = ft_prepare_layout(cfg,dataFCgrads1freq);
lay.label            = Grads1;
cfg.layout           = lay;
cfg.zlim             = [-5.e-24 5.e-24];
% cfg.zlim             = [-1.e-22 1.e-22];
figure
ft_multiplotTFR(cfg,dataFCgrads1freq)
figure
ft_multiplotTFR(cfg,dataFFgrads1freq)

lay                  = ft_prepare_layout(cfg,dataFCgrads2freq);
lay.label            = Grads2;
cfg.layout           = lay;
cfg.zlim             = [-5.e-24 5.e-24];
% cfg.zlim             = [-1.e-22 1.e-22];
figure
ft_multiplotTFR(cfg,dataFCgrads2freq)
figure
ft_multiplotTFR(cfg,dataFFgrads2freq)

%
dataPresentFar   = load(['C:\MTT_MEG\data\' nip '\processed\PresentFar_nofilt']);
dataPresentClose = load(['C:\MTT_MEG\data\' nip '\processed\PresentClose_nofilt']);

cfg                    = [];
cfg.method             = 'mtmconvol';
cfg.output             = 'pow';
cfg.trials             = 'all';
cfg.keeptrials         = 'no';
cfg.keeptapers         = 'no';
cfg.pad                = 'maxperlen';
cfg.polyremoval        = 0;
cfg.foi                = 1:35;
cfg.t_ftimwin          = 2./cfg.foi;
cfg.toi                = 0:0.05:2;
cfg.tapsmofrq          = 0.5*cfg.foi;

% cfg                    = [];
% cfg.method             = 'mtmconvol';
% cfg.output             = 'pow';
% cfg.trials             = 'all';
% cfg.keeptrials         = 'no';
% cfg.keeptapers         = 'no';
% cfg.pad                = 'maxperlen';
% cfg.polyremoval        = 0;
% cfg.foi                = 35:5:120;
% cfg.t_ftimwin          = 10./cfg.foi;
% cfg.toi                = 0:0.01:2;
% cfg.tapsmofrq          = 0.5*cfg.foi;

cfg.channel            = Mags;
dataPrCmagsfreq        = ft_freqanalysis(cfg, dataPresentClose.data);
dataPrFmagsfreq        = ft_freqanalysis(cfg, dataPresentFar.data);
cfg.channel            = Grads1;
dataPrCgrads1freq      = ft_freqanalysis(cfg, dataPresentClose.data);
dataPrFgrads1freq      = ft_freqanalysis(cfg, dataPresentFar.data);
cfg.channel            = Grads2;
dataPrCgrads2freq      = ft_freqanalysis(cfg, dataPresentClose.data);
dataPrFgrads2freq      = ft_freqanalysis(cfg, dataPresentFar.data);

cfg                    = [];
cfg.baseline           = [0.2 0.4]; 
cfg.channel            = 'all';
dataPrCmagsfreq        = ft_freqbaseline(cfg, dataPrCmagsfreq);
dataPrFmagsfreq        = ft_freqbaseline(cfg, dataPrFmagsfreq);
dataPrCgrads1freq      = ft_freqbaseline(cfg, dataPrCgrads1freq);
dataPrFgrads1freq      = ft_freqbaseline(cfg, dataPrFgrads1freq);
dataPrCgrads2freq      = ft_freqbaseline(cfg, dataPrCgrads2freq);
dataPrFgrads2freq      = ft_freqbaseline(cfg, dataPrFgrads2freq);

[Grads1,Grads2,Mags]   = grads_for_layouts('Laptop');
%%
cfg                  = [];
cfg.parameter        = 'powspctrm';
cfg.xlim             = 'maxmin';
cfg.ylim             = 'maxmin';
cfg.zlim             = [-5.e-27 5.e-27];
% cfg.zlim             = [-1.e-28 1.e-28];
cfg.channel          = Mags;
cfg.baseline         = 'no';
cfg.trials           = 'all';
cfg.box              = 'yes';
cfg.colorbar         = 'no';
cfg.colormap         = jet;
cfg.showlabels       = 'no';
cfg.showoutline      = 'no';
cfg.interactive      = 'yes';
cfg.masknans         = 'yes';
cfg.layout           = 'C:\FIELDTRIP\fieldtrip-20120402\template\layout/NM306mag.lay';

lay                  = ft_prepare_layout(cfg,dataPrCmagsfreq);
lay.label            = Mags;
cfg.layout           = lay;
figure
ft_multiplotTFR(cfg,dataPrCmagsfreq)
figure
ft_multiplotTFR(cfg,dataPrFmagsfreq)

lay                  = ft_prepare_layout(cfg,dataPrCgrads1freq);
lay.label            = Grads1;
cfg.layout           = lay;
cfg.zlim             = [-5.e-24 5.e-24];
% cfg.zlim             = [-1.e-22 1.e-22];
figure
ft_multiplotTFR(cfg,dataPrCgrads1freq)
figure
ft_multiplotTFR(cfg,dataPrFgrads1freq)

lay                  = ft_prepare_layout(cfg,dataPrCgrads2freq);
lay.label            = Grads2;
cfg.layout           = lay;
cfg.zlim             = [-5.e-24 5.e-24];
% cfg.zlim             = [-1.e-22 1.e-22];
figure
ft_multiplotTFR(cfg,dataPrCgrads2freq)
figure
ft_multiplotTFR(cfg,dataPrFgrads2freq)


