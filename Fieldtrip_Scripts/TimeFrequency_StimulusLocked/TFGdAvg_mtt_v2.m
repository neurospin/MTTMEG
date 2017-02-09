function TFGdAvg_mtt_v2(nip,window)

directory = ['C:\MTT_MEG\data\' nip '\processed'];
listing = dir(directory);

DATA = [];
count = 0;
for i = 3:length(listing)
    if strfind(listing(i,1).name,'lock')
        count = count + 1;
        DATA{count} = load([directory '\' listing(i,1).name]);
    end
end

cfg.channel        = 'all';
cfg.latency        = 'all';
cfg.keepindividual = 'no';
cfg.normalizevar   = 'N-1';

instr1 =  'grandavgS = ft_timelockgrandaverage(cfg';
instr2 =  'grandavgT = ft_timelockgrandaverage(cfg';

for i = 1:length(DATA)
    instr1 = [instr1 ',' 'DATA{1,' num2str(i) '}.timelockbase1'];
    instr2 = [instr2 ',' 'DATA{1,' num2str(i) '}.timelockbase2'];
end

instr1 = [instr1 ');'];
instr2 = [instr2 ');'];

eval(instr1)
eval(instr2)

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
lay                    = ft_prepare_layout(cfg,grandavgS);
lay.label              = Mags;
cfg.layout             = lay;

figure
ft_multiplotER(cfg,grandavgT, grandavgS)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

directory = ['C:\MTT_MEG\data\' nip '\processed\'];
searchdir = ['C:\MTT_MEG\data\' nip '\processed\*.mat'];
listing = dir(fullfile(searchdir));

DATA = [];
counts = 0;
for i = 1:length(listing)
    if strfind(listing(i,1).name,'Space')
        counts = counts + 1;
        DATAspace{counts} = load([directory '\' listing(i,1).name]);
    end
end
DATA = [];

countt = 0;
for i = 1:length(listing)
    if strfind(listing(i,1).name,'Time')
        countt = countt + 1;
        DATAtime{countt} = load([directory '\' listing(i,1).name]);
    end
end

cfg = [];

datas = [];
datat = [];
instrt =  'datat = ft_appenddata(cfg';
instrs =  'datas = ft_appenddata(cfg';

for i = 1:length(DATAspace)
    instrt = [instrt ',' 'DATAtime{1,' num2str(i) '}.data'];
    instrs = [instrs ',' 'DATAspace{1,' num2str(i) '}.data'];
end

instrt = [instrt ');'];
instrs = [instrs ');'];

eval(instrt)
eval(instrs)

cfg.trials             = 'all';
cfg.minlength          = 'maxperlen';
cfg.offset             = -100;
datatra                = ft_redefinetrial(cfg, datat);
datasra                = ft_redefinetrial(cfg, datas);

cfg.channel            = Mags;
cfg.trials             = 'all';
cfg.keeptrials         = 'no';
cfg.removemean         = 'yes';
cfg.covariance         = 'yes';
cfg.covariancewindow   = [0 1.5];
datatlock              = ft_timelockanalysis(cfg, datatra);
dataslock              = ft_timelockanalysis(cfg, datasra);

cfg                    = [];
cfg.baseline           = [-0.1 0]; 
cfg.channel            = 'all';
timelockbase1t         = ft_timelockbaseline(cfg, datatlock);
timelockbase1s         = ft_timelockbaseline(cfg, dataslock);

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
lay                    = ft_prepare_layout(cfg,timelockbase1s);
lay.label              = Mags;
cfg.layout             = lay;

figure
ft_multiplotER(cfg,timelockbase1t, timelockbase1s)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

directory = ['C:\MTT_MEG\data\' nip '\processed\'];
searchdir = ['C:\MTT_MEG\data\' nip '\processed\*.mat'];
listing = dir(fullfile(searchdir));

DATA = [];
counts = 0;
for i = 1:length(listing)
    if strfind(listing(i,1).name,'Space')
        counts = counts + 1;
        DATAspace{counts} = load([directory '\' listing(i,1).name]);
    end
end
DATA = [];

countt = 0;
for i = 1:length(listing)
    if strfind(listing(i,1).name,'Time')
        countt = countt + 1;
        DATAtime{countt} = load([directory '\' listing(i,1).name]);
    end
end

cfg = [];

datas = [];
datat = [];
instrt =  'datat = ft_appenddata(cfg';
instrs =  'datas = ft_appenddata(cfg';

for i = 1:length(DATAspace)
    instrt = [instrt ',' 'DATAtime{1,' num2str(i) '}.data'];
    instrs = [instrs ',' 'DATAspace{1,' num2str(i) '}.data'];
end

instrt = [instrt ');'];
instrs = [instrs ');'];

eval(instrt)
eval(instrs)

cfg.trials             = 'all';
cfg.minlength          = 'maxperlen';
cfg.offset             = -50;
datasra                = ft_redefinetrial(cfg, datas);
datatra                = ft_redefinetrial(cfg, datat);

cfg                    = [];
cfg.method             = 'wavelet';
cfg.output             = 'pow';
cfg.channel            = Mags;
cfg.trials             = 'all';
cfg.keeptrials         = 'no';
cfg.keeptapers         = 'no';
cfg.pad                = 'maxperlen';
cfg.polyremoval        = 0;
cfg.foilim             = [1 35];
cfg.toi                = (-20:100)*0.01;
cfg.width              = 3;

datasfreq              = ft_freqanalysis(cfg, datasra);
datatfreq              = ft_freqanalysis(cfg, datatra);

cfg                    = [];
cfg.method             = 'mtmfft';
cfg.foilim             = [1 35];
cfg.tapsmofrq          = 1;
cfg.taper              = 'dpss';
datasfreq2             = ft_freqanalysis(cfg, datasra);
datatfreq2             = ft_freqanalysis(cfg, datatra);
datasfreq2.freq        = log(datasfreq2.freq);
datasfreq2.powspctrm   = log(datasfreq2.powspctrm);
datatfreq2.freq        = log(datatfreq2.freq);
datatfreq2.powspctrm   = log(datatfreq2.powspctrm);

cfg                    = [];
cfg.axes               = 'no';
cfg.xparam             = 'freq';
cfg.zparam             = 'powspctrm';
cfg.xlim               = log([1 35]);
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
lay                    = ft_prepare_layout(cfg,datatfreq2);
lay.label              = Mags;
cfg.layout             = lay;
ft_multiplotER(cfg,datatfreq2,datasfreq2)

cfg                    = [];
cfg.baseline           = [-0.1 0];
cfg.channel            = 'all';
freqbase1s             = ft_freqbaseline(cfg, datasfreq);
freqbase1t             = ft_freqbaseline(cfg, datatfreq);

[Grads1,Grads2,Mags]   = grads_for_layouts('Laptop');
%%
cfg                  = [];
cfg.parameter        = 'powspctrm';
cfg.xlim             = 'maxmin';
cfg.ylim             = 'maxmin';
cfg.zlim             = [-5.e-25 1.e-24];
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
lay                  = ft_prepare_layout(cfg,freqbase1t);
lay.label            = Mags;
cfg.layout           = lay;

figure
ft_multiplotTFR(cfg,freqbase1t)
figure
ft_multiplotTFR(cfg,freqbase1s)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

directory = ['C:\MTT_MEG\data\' nip '\processed\'];
searchdir = ['C:\MTT_MEG\data\' nip '\processed\*.mat'];
listing = dir(fullfile(searchdir));

DATA = [];
counts = 0;
for i = 1:length(listing)
    if strfind(listing(i,1).name,'Space')
        counts = counts + 1;
        DATAspace{counts} = load([directory '\' listing(i,1).name]);
    end
end
DATA = [];

countt = 0;
for i = 1:length(listing)
    if strfind(listing(i,1).name,'Time')
        countt = countt + 1;
        DATAtime{countt} = load([directory '\' listing(i,1).name]);
    end
end

cfg = [];

datas = [];
datat = [];
instrt =  'datat = ft_appenddata(cfg';
instrs =  'datas = ft_appenddata(cfg';

for i = 1:length(DATAspace)
    instrt = [instrt ',' 'DATAtime{1,' num2str(i) '}.data'];
    instrs = [instrs ',' 'DATAspace{1,' num2str(i) '}.data'];
end

instrt = [instrt ');'];
instrs = [instrs ');'];

eval(instrt)
eval(instrs)

cfg.trials             = 'all';
cfg.minlength          = 'maxperlen';
cfg.offset             = -50;
datasra                = ft_redefinetrial(cfg, datas);
datatra                = ft_redefinetrial(cfg, datat);

cfg.channel            = Mags;
cfg.trials             = 'all';
cfg.keeptrials         = 'no';
cfg.removemean         = 'yes';
cfg.covariance         = 'yes';
cfg.covariancewindow   = [0 1];
dataslock              = ft_timelockanalysis(cfg, datasra);
datatlock              = ft_timelockanalysis(cfg, datatra);

cfg                    = [];
cfg.baseline           = [-0.2 0];
cfg.channel            = 'all';
timelockbase1s         = ft_timelockbaseline(cfg, dataslock);
timelockbase1t         = ft_timelockbaseline(cfg, datatlock);

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

cfg.layout             = 'C:\FIELDTRIP\fieldtrip-20120402\template\layout/NM306mag.lay';
lay                    = ft_prepare_layout(cfg,timelockbase1t);
lay.label              = Mags;
cfg.layout             = lay;

figure
ft_multiplotER(cfg,timelockbase1t, timelockbase1s)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

directory = ['C:\MTT_MEG\data\' nip '\processed\'];
searchdir = ['C:\MTT_MEG\data\' nip '\processed\*.mat'];
listing = dir(fullfile(searchdir));

count1 = 0;
for i = 1:length(listing)
    if strfind(listing(i,1).name,'Timeref1')
        count1 = count1 + 1;
        DATAref1{count1} = load([directory '\' listing(i,1).name]);
    end
end
count2 = 0;
for i = 1:length(listing)
    if strfind(listing(i,1).name,'Timeref2')
        count2 = count2 + 1;
        DATAref2{count2} = load([directory '\' listing(i,1).name]);
    end
end
count3 = 0;
for i = 1:length(listing)
    if strfind(listing(i,1).name,'Timeref3')
        count3 = count3 + 1;
        DATAref3{count3} = load([directory '\' listing(i,1).name]);
    end
end

cfg = [];

dataref1 = [];
dataref2 = [];
dataref3 = [];
instrref1 =  'dataref1 = ft_appenddata(cfg';
instrref2 =  'dataref2 = ft_appenddata(cfg';
instrref3 =  'dataref3 = ft_appenddata(cfg';

for i = 1:length(DATAref1)
    instrref1 = [instrref1 ',' 'DATAref1{1,' num2str(i) '}.data'];
end
for i = 1:length(DATAref2)
    instrref2 = [instrref2 ',' 'DATAref2{1,' num2str(i) '}.data'];
end
for i = 1:length(DATAref3)
    instrref3 = [instrref3 ',' 'DATAref3{1,' num2str(i) '}.data'];
end

instrref1 = [instrref1 ');'];
instrref2 = [instrref2 ');'];
instrref3 = [instrref3 ');'];

eval(instrref1)
eval(instrref2)
eval(instrref3)

cfg.trials             = 'all';
cfg.minlength          = 'maxperlen';
cfg.offset             = -50;
dataref1ra             = ft_redefinetrial(cfg, dataref1);
dataref2ra             = ft_redefinetrial(cfg, dataref2);
dataref3ra             = ft_redefinetrial(cfg, dataref3);

cfg.channel            = Mags;
cfg.trials             = 'all';
cfg.keeptrials         = 'no';
cfg.removemean         = 'yes';
cfg.covariance         = 'yes';
cfg.covariancewindow   = [0 1];
dataref1lock           = ft_timelockanalysis(cfg, dataref1ra);
dataref2lock           = ft_timelockanalysis(cfg, dataref2ra);
dataref3lock           = ft_timelockanalysis(cfg, dataref3ra);

cfg                    = [];
cfg.baseline           = [-0.2 0];
cfg.channel            = 'all';
timelockbaseref1       = ft_timelockbaseline(cfg, dataref1lock);
timelockbaseref2       = ft_timelockbaseline(cfg, dataref2lock);
timelockbaseref3       = ft_timelockbaseline(cfg, dataref3lock);

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

cfg.layout             = 'C:\FIELDTRIP\fieldtrip-20120402\template\layout/NM306mag.lay';
lay                    = ft_prepare_layout(cfg,timelockbaseref1);
lay.label              = Mags;
cfg.layout             = lay;

figure
ft_multiplotER(cfg,timelockbaseref1,timelockbaseref2,timelockbaseref3)



