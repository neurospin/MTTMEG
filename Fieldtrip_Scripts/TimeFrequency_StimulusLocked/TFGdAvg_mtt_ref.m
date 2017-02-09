function TFGdAvg_mtt_ref(nip,window)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

directory = ['C:\MTT_MEG\data\' nip '\processed\'];
searchdir = ['C:\MTT_MEG\data\' nip '\processed\*.mat'];
listing = dir(fullfile(searchdir));

DATATimeRef1 = [];
counts = 0;
for i = 1:length(listing)
    if strfind(listing(i,1).name,'TimeRef1_filt40')
        counts = counts + 1;
        DATATimeRef1{counts} = load([directory '\' listing(i,1).name]);
    end
end

DATATimeRef2 = [];
countt = 0;
for i = 1:length(listing)
    if strfind(listing(i,1).name,'TimeRef2_filt40')
        countt = countt + 1;
        DATATimeRef2{countt} = load([directory '\' listing(i,1).name]);
    end
end

DATATimeRef3 = [];
countt = 0;
for i = 1:length(listing)
    if strfind(listing(i,1).name,'TimeRef3_filt40')
        countt = countt + 1;
        DATATimeRef3{countt} = load([directory '\' listing(i,1).name]);
    end
end

cfg = [];

datat1 = [];
datat2 = [];
datat3 = [];
instrt1 =  'datat1 = ft_appenddata(cfg';
instrt2 =  'datat2 = ft_appenddata(cfg';
instrt3 =  'datat3 = ft_appenddata(cfg';

for i = 1:length(DATATimeRef3)
    instrt1 = [instrt1 ',' 'DATATimeRef1{1,' num2str(i) '}.data'];
    instrt2 = [instrt2 ',' 'DATATimeRef2{1,' num2str(i) '}.data'];
    instrt3 = [instrt3 ',' 'DATATimeRef3{1,' num2str(i) '}.data'];
end

instrt1 = [instrt1 ');'];
instrt2 = [instrt2 ');'];
instrt3 = [instrt3 ');'];
eval(instrt1)
eval(instrt2)
eval(instrt3)

cfg.trials             = 'all';
cfg.minlength          = 'maxperlen';
cfg.offset             = -100;
datat1ra                = ft_redefinetrial(cfg, datat1);
datat2ra                = ft_redefinetrial(cfg, datat2);
datat3ra                = ft_redefinetrial(cfg, datat3);

[Grads1,Grads2,Mags]   = grads_for_layouts('Laptop');

cfg.channel            = Mags;
cfg.trials             = 'all';
cfg.keeptrials         = 'no';
cfg.removemean         = 'yes';
cfg.covariance         = 'yes';
cfg.covariancewindow   = [0 1.5];
datat1lock              = ft_timelockanalysis(cfg, datat1ra);
datat2lock              = ft_timelockanalysis(cfg, datat2ra);
datat3lock              = ft_timelockanalysis(cfg, datat3ra);

cfg                    = [];
cfg.baseline           = [-0.1 0]; 
cfg.channel            = 'all';
timelockbase1t1         = ft_timelockbaseline(cfg, datat1lock);
timelockbase1t2         = ft_timelockbaseline(cfg, datat2lock);
timelockbase1t3         = ft_timelockbaseline(cfg, datat3lock);

[Grads1,Grads2,Mags]   = grads_for_layouts('Laptop');
%%
cfg                    = [];
cfg.axes               = 'no';
cfg.xparam             = 'time';
cfg.zparam             = 'avg';
cfg.xlim               = window;
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
cfg.comment            = 'comment';

cfg.layout             = 'C:\FIELDTRIP\fieldtrip-20120402\template\layout/NM306mag.lay';
lay                    = ft_prepare_layout(cfg,timelockbase1t1);
lay.label              = Mags;
cfg.layout             = lay;

figure
ft_multiplotER(cfg,timelockbase1t1,timelockbase1t2,timelockbase1t3)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

directory = ['C:\MTT_MEG\data\' nip '\processed\'];
searchdir = ['C:\MTT_MEG\data\' nip '\processed\*.mat'];
listing = dir(fullfile(searchdir));

DATASpaceRef1 = [];
counts = 0;
for i = 1:length(listing)
    if strfind(listing(i,1).name,'SpaceRef1_filt40')
        counts = counts + 1;
        DATASpaceRef1{counts} = load([directory '\' listing(i,1).name]);
    end
end

DATASpaceRef2 = [];
countt = 0;
for i = 1:length(listing)
    if strfind(listing(i,1).name,'SpaceRef2_filt40')
        countt = countt + 1;
        DATASpaceRef2{countt} = load([directory '\' listing(i,1).name]);
    end
end

DATASpaceRef3 = [];
countt = 0;
for i = 1:length(listing)
    if strfind(listing(i,1).name,'SpaceRef3_filt40')
        countt = countt + 1;
        DATASpaceRef3{countt} = load([directory '\' listing(i,1).name]);
    end
end

cfg = [];

datat1 = [];
datat2 = [];
datat3 = [];
instrt1 =  'datat1 = ft_appenddata(cfg';
instrt2 =  'datat2 = ft_appenddata(cfg';
instrt3 =  'datat3 = ft_appenddata(cfg';

for i = 1:length(DATASpaceRef3)
    instrt1 = [instrt1 ',' 'DATASpaceRef1{1,' num2str(i) '}.data'];
    instrt2 = [instrt2 ',' 'DATASpaceRef2{1,' num2str(i) '}.data'];
    instrt3 = [instrt3 ',' 'DATASpaceRef3{1,' num2str(i) '}.data'];
end

instrt1 = [instrt1 ');'];
instrt2 = [instrt2 ');'];
instrt3 = [instrt3 ');'];
eval(instrt1)
eval(instrt2)
eval(instrt3)

cfg.trials             = 'all';
cfg.minlength          = 'maxperlen';
cfg.offset             = -100;
datat1ra                = ft_redefinetrial(cfg, datat1);
datat2ra                = ft_redefinetrial(cfg, datat2);
datat3ra                = ft_redefinetrial(cfg, datat3);

[Grads1,Grads2,Mags]   = grads_for_layouts('Laptop');

cfg.channel            = 'all';
cfg.trials             = 'all';
cfg.keeptrials         = 'no';
cfg.removemean         = 'yes';
cfg.covariance         = 'yes';
cfg.covariancewindow   = [0 1.5];
datat1lock              = ft_timelockanalysis(cfg, datat1ra);
datat2lock              = ft_timelockanalysis(cfg, datat2ra);
datat3lock              = ft_timelockanalysis(cfg, datat3ra);

cfg                    = [];
cfg.baseline           = [-0.1 0]; 
cfg.channel            = 'all';
timelockbase1t1         = ft_timelockbaseline(cfg, datat1lock);
timelockbase1t2         = ft_timelockbaseline(cfg, datat2lock);
timelockbase1t3         = ft_timelockbaseline(cfg, datat3lock);

[Grads1,Grads2,Mags]   = grads_for_layouts('Laptop');
%%
cfg                    = [];
cfg.axes               = 'no';
cfg.xparam             = 'time';
cfg.zparam             = 'avg';
cfg.xlim               = window;
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
cfg.comment            = 'comment';

cfg.layout             = 'C:\FIELDTRIP\fieldtrip-20120402\template\layout/NM306mag.lay';
lay                    = ft_prepare_layout(cfg,timelockbase1t1);
lay.label              = Mags;
cfg.layout             = lay;
figure
ft_multiplotER(cfg,timelockbase1t1,timelockbase1t2,timelockbase1t3)

cfg.layout             = 'C:\FIELDTRIP\fieldtrip-20120402\template\layout/NM306mag.lay';
lay                    = ft_prepare_layout(cfg,timelockbase1t1);
lay.label              = Grads1;
cfg.layout             = lay;
figure
ft_multiplotER(cfg,timelockbase1t1,timelockbase1t2,timelockbase1t3)

cfg.layout             = 'C:\FIELDTRIP\fieldtrip-20120402\template\layout/NM306mag.lay';
lay                    = ft_prepare_layout(cfg,timelockbase1t1);
lay.label              = Grads2;
cfg.layout             = lay;
figure
ft_multiplotER(cfg,timelockbase1t1,timelockbase1t2,timelockbase1t3)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

directory = ['C:\MTT_MEG\data\' nip '\processed\'];
searchdir = ['C:\MTT_MEG\data\' nip '\processed\*.mat'];
listing = dir(fullfile(searchdir));

DATATimeRef1 = [];
counts = 0;
for i = 1:length(listing)
    if strfind(listing(i,1).name,'TimeRef1_nofilt')
        counts = counts + 1;
        DATATimeRef1{counts} = load([directory '\' listing(i,1).name]);
    end
end

DATATimeRef2 = [];
countt = 0;
for i = 1:length(listing)
    if strfind(listing(i,1).name,'TimeRef2_nofilt')
        countt = countt + 1;
        DATATimeRef2{countt} = load([directory '\' listing(i,1).name]);
    end
end

DATATimeRef3 = [];
countt = 0;
for i = 1:length(listing)
    if strfind(listing(i,1).name,'TimeRef3_nofilt')
        countt = countt + 1;
        DATATimeRef3{countt} = load([directory '\' listing(i,1).name]);
    end
end

cfg = [];

datat1 = [];
datat2 = [];
datat3 = [];
instrt1 =  'datat1 = ft_appenddata(cfg';
instrt2 =  'datat2 = ft_appenddata(cfg';
instrt3 =  'datat3 = ft_appenddata(cfg';

for i = 1:length(DATATimeRef3)
    instrt1 = [instrt1 ',' 'DATATimeRef1{1,' num2str(i) '}.data'];
    instrt2 = [instrt2 ',' 'DATATimeRef2{1,' num2str(i) '}.data'];
    instrt3 = [instrt3 ',' 'DATATimeRef3{1,' num2str(i) '}.data'];
end

instrt1 = [instrt1 ');'];
instrt2 = [instrt2 ');'];
instrt3 = [instrt3 ');'];
eval(instrt1)
eval(instrt2)
eval(instrt3)

cfg.trials             = 'all';
cfg.minlength          = 'maxperlen';
cfg.offset             = -100;
datat1ra                = ft_redefinetrial(cfg, datat1);
datat2ra                = ft_redefinetrial(cfg, datat2);
datat3ra                = ft_redefinetrial(cfg, datat3);

[Grads1,Grads2,Mags]   = grads_for_layouts('Laptop');

cfg                    = [];
cfg.method             = 'mtmconvol';
cfg.output             = 'pow';
cfg.trials             = 'all';
cfg.keeptrials         = 'no';
cfg.keeptapers         = 'no';
cfg.pad                = 'maxperlen';
cfg.polyremoval        = 0;
cfg.foi                = 1:35;
cfg.t_ftimwin          = 3./cfg.foi;
cfg.toi                = -0.4:0.05:1.5;
cfg.tapsmofrq          = 0.5*cfg.foi;

datat1freq              = ft_freqanalysis(cfg, datat1ra);
datat2freq              = ft_freqanalysis(cfg, datat2ra);
datat3freq              = ft_freqanalysis(cfg, datat3ra);

cfg                    = [];
cfg.baseline           = [-0.1 0];
cfg.channel            = 'all';
freqbase1t1             = ft_freqbaseline(cfg, datat1freq);
freqbase1t2             = ft_freqbaseline(cfg, datat2freq);
freqbase1t3             = ft_freqbaseline(cfg, datat3freq);

[Grads1,Grads2,Mags]   = grads_for_layouts('Laptop');
%%
cfg                  = [];
cfg.parameter        = 'powspctrm';
cfg.xlim             = 'maxmin';
cfg.ylim             = 'maxmin';
cfg.zlim             = 'maxabs';
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
lay                  = ft_prepare_layout(cfg,freqbase1t1);
lay.label            = Mags;
cfg.layout           = lay;

figure
ft_multiplotTFR(cfg,freqbase1t1)
figure
ft_multiplotTFR(cfg,freqbase1t2)
figure
ft_multiplotTFR(cfg,freqbase1t3)

lay.label            = Grads1;
cfg.layout           = lay;
figure
ft_multiplotTFR(cfg,freqbase1t1)
figure
ft_multiplotTFR(cfg,freqbase1t2)
figure
ft_multiplotTFR(cfg,freqbase1t3)

cfg                    = [];
cfg.method             = 'mtmconvol';
cfg.output             = 'pow';
cfg.trials             = 'all';
cfg.keeptrials         = 'no';
cfg.keeptapers         = 'no';
cfg.pad                = 'maxperlen';
cfg.polyremoval        = 0;
cfg.foi                = 35:5:120;
cfg.t_ftimwin          = 10./cfg.foi;
cfg.toi                = -0.4:0.05:1.5;
cfg.tapsmofrq          = 0.5*cfg.foi;

datat1freq              = ft_freqanalysis(cfg, datat1ra);
datat2freq              = ft_freqanalysis(cfg, datat2ra);
datat3freq              = ft_freqanalysis(cfg, datat3ra);

cfg                    = [];
cfg.baseline           = [-0.1 0];
cfg.channel            = 'all';
freqbase1t1             = ft_freqbaseline(cfg, datat1freq);
freqbase1t2             = ft_freqbaseline(cfg, datat2freq);
freqbase1t3             = ft_freqbaseline(cfg, datat3freq);

[Grads1,Grads2,Mags]   = grads_for_layouts('Laptop');
%%
cfg                  = [];
cfg.parameter        = 'powspctrm';
cfg.xlim             = 'maxmin';
cfg.ylim             = 'maxmin';
cfg.zlim             = [-1.e-28 1.e-28];
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
lay                  = ft_prepare_layout(cfg,freqbase1t1);
lay.label            = Mags;
cfg.layout           = lay;

figure
ft_multiplotTFR(cfg,freqbase1t1)
figure
ft_multiplotTFR(cfg,freqbase1t2)
figure
ft_multiplotTFR(cfg,freqbase1t3)

lay.label            = Grads1;
cfg.layout           = lay;
cfg.zlim             = [-5.e-26 5.e-26];
figure
ft_multiplotTFR(cfg,freqbase1t1)
figure
ft_multiplotTFR(cfg,freqbase1t2)
figure
ft_multiplotTFR(cfg,freqbase1t3)

lay.label            = Grads2;
cfg.layout           = lay;
cfg.zlim             = [-5.e-26 5.e-26];
figure
ft_multiplotTFR(cfg,freqbase1t1)
figure
ft_multiplotTFR(cfg,freqbase1t2)
figure
ft_multiplotTFR(cfg,freqbase1t3)
