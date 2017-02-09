function timelockGdAvg_mtt(nip,window)

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

