function timelockGdAvg_mtt_v2(nip,window)

directory = ['C:\MTT_MEG\data\' nip '\processed\'];
searchdir = ['C:\MTT_MEG\data\' nip '\processed\*.mat'];
listing = dir(fullfile(searchdir));

%%
DATAtimemags = [];
count = 0;
for i = 1:length(listing)
    if (isempty(strfind(listing(i,1).name,'Time_filt40')) == 0) 
        count = count + 1;
        DATAtimemags{count} = load([directory '\' listing(i,1).name]);
    end
end
DATAtimegrads1 = [];
count = 0;
for i = 1:length(listing)
    if (isempty(strfind(listing(i,1).name,'Time_filt40')) == 0) 
        count = count + 1;
        DATAtimegrads1{count} = load([directory '\' listing(i,1).name]);
    end
end
DATAtimegrads2 = [];
count = 0;
for i = 1:length(listing)
    if (isempty(strfind(listing(i,1).name,'Time_filt40')) == 0) 
        count = count + 1;
        DATAtimegrads2{count} = load([directory '\' listing(i,1).name]);
    end
end

%%
DATAspacemags = [];
count = 0;
for i = 1:length(listing)
    if (isempty(strfind(listing(i,1).name,'Space_filt40')) == 0) 
        count = count + 1;
        DATAspacemags{count} = load([directory '\' listing(i,1).name]);
    end
end
DATAspacegrads1 = [];
count = 0;
for i = 1:length(listing)
    if (isempty(strfind(listing(i,1).name,'Space_filt40')) == 0)
        count = count + 1;
        DATAspacegrads1{count} = load([directory '\' listing(i,1).name]);
    end
end
DATAspacegrads2 = [];
count = 0;
for i = 1:length(listing)
    if (isempty(strfind(listing(i,1).name,'Space_filt40')) == 0) 
        count = count + 1;
        DATAspacegrads2{count} = load([directory '\' listing(i,1).name]);
    end
end

cfg = [];

dataSmags   = [];
dataTmags   = [];
dataSgrads1 = [];
dataTgrads1 = [];
dataSgrads2 = [];
dataTgrads2 = [];

instrTmags   =  'dataTmags   = ft_appenddata(cfg';
instrSmags   =  'dataSmags   = ft_appenddata(cfg';
instrTgrads1 =  'dataTgrads1 = ft_appenddata(cfg';
instrSgrads1 =  'dataSgrads1 = ft_appenddata(cfg';
instrTgrads2 =  'dataTgrads2 = ft_appenddata(cfg';
instrSgrads2 =  'dataSgrads2 = ft_appenddata(cfg';

for i = 1:length(DATAspacemags)
    instrTmags   = [instrTmags ',' 'DATAtimemags{1,' num2str(i) '}.data'];
    instrSmags   = [instrSmags ',' 'DATAspacemags{1,' num2str(i) '}.data'];
    instrTgrads1 = [instrTgrads1 ',' 'DATAtimegrads1{1,' num2str(i) '}.data'];
    instrSgrads1 = [instrSgrads1 ',' 'DATAspacegrads1{1,' num2str(i) '}.data'];
    instrTgrads2 = [instrTgrads2 ',' 'DATAtimegrads2{1,' num2str(i) '}.data'];
    instrSgrads2 = [instrSgrads2 ',' 'DATAspacegrads2{1,' num2str(i) '}.data'];
end

instrTmags = [instrTmags ');'];
instrSmags = [instrSmags ');'];
instrTgrads1 = [instrTgrads1 ');'];
instrSgrads1 = [instrSgrads1 ');'];
instrTgrads2 = [instrTgrads2 ');'];
instrSgrads2 = [instrSgrads2 ');'];

eval(instrTmags)
eval(instrSmags)
eval(instrTgrads1)
eval(instrSgrads1)
eval(instrTgrads2)
eval(instrSgrads2)

cfg.trials             = 'all';
cfg.minlength          = 'maxperlen';
cfg.offset             = -0.4*dataTmags.fsample;
dataTmagsra            = ft_redefinetrial(cfg, dataTmags);
dataSmagsra            = ft_redefinetrial(cfg, dataSmags);
dataTgrads1ra          = ft_redefinetrial(cfg, dataTgrads1);
dataSgrads1ra          = ft_redefinetrial(cfg, dataSgrads1);
dataTgrads2ra          = ft_redefinetrial(cfg, dataTgrads2);
dataSgrads2ra          = ft_redefinetrial(cfg, dataSgrads2);

cfg.trials             = 'all';
cfg.keeptrials         = 'no';
cfg.removemean         = 'yes';
cfg.covariance         = 'yes';
cfg.covariancewindow   = [0 1];
dataTmagslock          = ft_timelockanalysis(cfg, dataTmagsra);
dataSmagslock          = ft_timelockanalysis(cfg, dataSmagsra);
dataTgrads1lock        = ft_timelockanalysis(cfg, dataTgrads1ra);
dataSgrads1lock        = ft_timelockanalysis(cfg, dataSgrads1ra);
dataTgrads2lock        = ft_timelockanalysis(cfg, dataTgrads2ra);
dataSgrads2lock        = ft_timelockanalysis(cfg, dataSgrads2ra);

cfg                    = [];
cfg.baseline           = [-0.2 0]; 
cfg.channel            = 'all';
timelockbaseTmags      = ft_timelockbaseline(cfg, dataTmagslock);
timelockbaseSmags      = ft_timelockbaseline(cfg, dataSmagslock);
timelockbaseTgrads1    = ft_timelockbaseline(cfg, dataTgrads1lock);
timelockbaseSgrads1    = ft_timelockbaseline(cfg, dataSgrads1lock);
timelockbaseTgrads2    = ft_timelockbaseline(cfg, dataTgrads2lock);
timelockbaseSgrads2    = ft_timelockbaseline(cfg, dataSgrads2lock);

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
lay                    = ft_prepare_layout(cfg,timelockbaseTmags);
lay.label              = Mags;
cfg.layout             = lay;
figure
ft_multiplotER(cfg,timelockbaseTmags, timelockbaseSmags)

cfg.layout             = 'C:\FIELDTRIP\fieldtrip-20120402\template\layout/NM306mag.lay';
lay                    = ft_prepare_layout(cfg,timelockbaseTgrads1);
lay.label              = Grads1;
cfg.layout             = lay;
figure
ft_multiplotER(cfg,timelockbaseTgrads1, timelockbaseSgrads1)

cfg.layout             = 'C:\FIELDTRIP\fieldtrip-20120402\template\layout/NM306mag.lay';
lay                    = ft_prepare_layout(cfg,timelockbaseTgrads2);
lay.label              = Grads2;
cfg.layout             = lay;
figure
ft_multiplotER(cfg,timelockbaseTgrads2, timelockbaseSgrads2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


