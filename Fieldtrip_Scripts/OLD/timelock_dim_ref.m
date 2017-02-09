function timelock_dim_ref(nip)

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

dataraQTREF1              = ft_appenddata([],dataraTIME1,dataraSPACE1);
dataraQTREF2              = ft_appenddata([],dataraTIME2,dataraSPACE2);
dataraQTREF3              = ft_appenddata([],dataraTIME3,dataraSPACE3);
dataraQTREF4              = ft_appenddata([],dataraTIME4,dataraSPACE4);
dataraQTREF5              = ft_appenddata([],dataraTIME5,dataraSPACE5);

cfg.channel            = Mags;
cfg.trials             = 'all';
cfg.keeptrials         = 'no';
cfg.removemean         = 'yes';
cfg.covariance         = 'yes';
% cfg.covariancewindow   = [0 1.5];
datalockmagsTIME1      = ft_timelockanalysis(cfg, dataraTIME1);
datalockmagsTIME2      = ft_timelockanalysis(cfg, dataraTIME2);
datalockmagsTIME3      = ft_timelockanalysis(cfg, dataraTIME3);
datalockmagsTIME4      = ft_timelockanalysis(cfg, dataraTIME4);
datalockmagsTIME5      = ft_timelockanalysis(cfg, dataraTIME5);
datalockmagsSPACE1     = ft_timelockanalysis(cfg, dataraSPACE1);
datalockmagsSPACE2     = ft_timelockanalysis(cfg, dataraSPACE2);
datalockmagsSPACE3     = ft_timelockanalysis(cfg, dataraSPACE3);
datalockmagsSPACE4     = ft_timelockanalysis(cfg, dataraSPACE4);
datalockmagsSPACE5     = ft_timelockanalysis(cfg, dataraSPACE5);
datalockmagsQTREF1     = ft_timelockanalysis(cfg, dataraQTREF1);
datalockmagsQTREF2     = ft_timelockanalysis(cfg, dataraQTREF2);
datalockmagsQTREF3     = ft_timelockanalysis(cfg, dataraQTREF3);
datalockmagsQTREF4     = ft_timelockanalysis(cfg, dataraQTREF4);
datalockmagsQTREF5     = ft_timelockanalysis(cfg, dataraQTREF5);
cfg.keeptrials         = 'yes';
datalockmagsTIME1t     = ft_timelockanalysis(cfg, dataraTIME1);
datalockmagsTIME2t     = ft_timelockanalysis(cfg, dataraTIME2);
datalockmagsTIME3t     = ft_timelockanalysis(cfg, dataraTIME3);
datalockmagsTIME4t     = ft_timelockanalysis(cfg, dataraTIME4);
datalockmagsTIME5t     = ft_timelockanalysis(cfg, dataraTIME5);
datalockmagsSPACE1t    = ft_timelockanalysis(cfg, dataraSPACE1);
datalockmagsSPACE2t    = ft_timelockanalysis(cfg, dataraSPACE2);
datalockmagsSPACE3t    = ft_timelockanalysis(cfg, dataraSPACE3);
datalockmagsSPACE4t    = ft_timelockanalysis(cfg, dataraSPACE4);
datalockmagsSPACE5t    = ft_timelockanalysis(cfg, dataraSPACE5);
datalockmagsQTREF1t     = ft_timelockanalysis(cfg, dataraQTREF1);
datalockmagsQTREF2t     = ft_timelockanalysis(cfg, dataraQTREF2);
datalockmagsQTREF3t     = ft_timelockanalysis(cfg, dataraQTREF3);
datalockmagsQTREF4t     = ft_timelockanalysis(cfg, dataraQTREF4);
datalockmagsQTREF5t     = ft_timelockanalysis(cfg, dataraQTREF5);

cfg.channel            = Grads1;
cfg.keeptrials         = 'no';
datalockgrads1TIME1    = ft_timelockanalysis(cfg, dataraTIME1);
datalockgrads1TIME2    = ft_timelockanalysis(cfg, dataraTIME2);
datalockgrads1TIME3    = ft_timelockanalysis(cfg, dataraTIME3);
datalockgrads1TIME4    = ft_timelockanalysis(cfg, dataraTIME4);
datalockgrads1TIME5    = ft_timelockanalysis(cfg, dataraTIME5);
datalockgrads1SPACE1   = ft_timelockanalysis(cfg, dataraSPACE1);
datalockgrads1SPACE2   = ft_timelockanalysis(cfg, dataraSPACE2);
datalockgrads1SPACE3   = ft_timelockanalysis(cfg, dataraSPACE3);
datalockgrads1SPACE4   = ft_timelockanalysis(cfg, dataraSPACE4);
datalockgrads1SPACE5   = ft_timelockanalysis(cfg, dataraSPACE5);
datalockgrads1QTREF1   = ft_timelockanalysis(cfg, dataraQTREF1);
datalockgrads1QTREF2   = ft_timelockanalysis(cfg, dataraQTREF2);
datalockgrads1QTREF3   = ft_timelockanalysis(cfg, dataraQTREF3);
datalockgrads1QTREF4   = ft_timelockanalysis(cfg, dataraQTREF4);
datalockgrads1QTREF5   = ft_timelockanalysis(cfg, dataraQTREF5);
cfg.keeptrials         = 'yes';
datalockgrads1TIME1t    = ft_timelockanalysis(cfg, dataraTIME1);
datalockgrads1TIME2t    = ft_timelockanalysis(cfg, dataraTIME2);
datalockgrads1TIME3t    = ft_timelockanalysis(cfg, dataraTIME3);
datalockgrads1TIME4t    = ft_timelockanalysis(cfg, dataraTIME4);
datalockgrads1TIME5t    = ft_timelockanalysis(cfg, dataraTIME5);
datalockgrads1SPACE1t   = ft_timelockanalysis(cfg, dataraSPACE1);
datalockgrads1SPACE2t   = ft_timelockanalysis(cfg, dataraSPACE2);
datalockgrads1SPACE3t   = ft_timelockanalysis(cfg, dataraSPACE3);
datalockgrads1SPACE4t   = ft_timelockanalysis(cfg, dataraSPACE4);
datalockgrads1SPACE5t   = ft_timelockanalysis(cfg, dataraSPACE5);
datalockgrads1QTREF1t   = ft_timelockanalysis(cfg, dataraQTREF1);
datalockgrads1QTREF2t   = ft_timelockanalysis(cfg, dataraQTREF2);
datalockgrads1QTREF3t   = ft_timelockanalysis(cfg, dataraQTREF3);
datalockgrads1QTREF4t   = ft_timelockanalysis(cfg, dataraQTREF4);
datalockgrads1QTREF5t   = ft_timelockanalysis(cfg, dataraQTREF5);

cfg.channel            = Grads2;
cfg.keeptrials         = 'no';
datalockgrads2TIME1    = ft_timelockanalysis(cfg, dataraTIME1);
datalockgrads2TIME2    = ft_timelockanalysis(cfg, dataraTIME2);
datalockgrads2TIME3    = ft_timelockanalysis(cfg, dataraTIME3);
datalockgrads2TIME4    = ft_timelockanalysis(cfg, dataraTIME4);
datalockgrads2TIME5    = ft_timelockanalysis(cfg, dataraTIME5);
datalockgrads2SPACE1   = ft_timelockanalysis(cfg, dataraSPACE1);
datalockgrads2SPACE2   = ft_timelockanalysis(cfg, dataraSPACE2);
datalockgrads2SPACE3   = ft_timelockanalysis(cfg, dataraSPACE3);
datalockgrads2SPACE4   = ft_timelockanalysis(cfg, dataraSPACE4);
datalockgrads2SPACE5   = ft_timelockanalysis(cfg, dataraSPACE5);
datalockgrads2QTREF1   = ft_timelockanalysis(cfg, dataraQTREF1);
datalockgrads2QTREF2   = ft_timelockanalysis(cfg, dataraQTREF2);
datalockgrads2QTREF3   = ft_timelockanalysis(cfg, dataraQTREF3);
datalockgrads2QTREF4   = ft_timelockanalysis(cfg, dataraQTREF4);
datalockgrads2QTREF5   = ft_timelockanalysis(cfg, dataraQTREF5);
cfg.keeptrials         = 'yes';
datalockgrads2TIME1t    = ft_timelockanalysis(cfg, dataraTIME1);
datalockgrads2TIME2t    = ft_timelockanalysis(cfg, dataraTIME2);
datalockgrads2TIME3t    = ft_timelockanalysis(cfg, dataraTIME3);
datalockgrads2TIME4t    = ft_timelockanalysis(cfg, dataraTIME4);
datalockgrads2TIME5t    = ft_timelockanalysis(cfg, dataraTIME5);
datalockgrads2SPACE1t   = ft_timelockanalysis(cfg, dataraSPACE1);
datalockgrads2SPACE2t   = ft_timelockanalysis(cfg, dataraSPACE2);
datalockgrads2SPACE3t   = ft_timelockanalysis(cfg, dataraSPACE3);
datalockgrads2SPACE4t   = ft_timelockanalysis(cfg, dataraSPACE4);
datalockgrads2SPACE5t   = ft_timelockanalysis(cfg, dataraSPACE5);
datalockgrads2QTREF1t   = ft_timelockanalysis(cfg, dataraQTREF1);
datalockgrads2QTREF2t   = ft_timelockanalysis(cfg, dataraQTREF2);
datalockgrads2QTREF3t   = ft_timelockanalysis(cfg, dataraQTREF3);
datalockgrads2QTREF4t   = ft_timelockanalysis(cfg, dataraQTREF4);
datalockgrads2QTREF5t   = ft_timelockanalysis(cfg, dataraQTREF5);

cfg                    = [];
cfg.baseline           = [-0.2 0]; 
cfg.channel            = 'all';
timelockbasemagsTIME1  = ft_timelockbaseline(cfg, datalockmagsTIME1);
timelockbasemagsTIME2  = ft_timelockbaseline(cfg, datalockmagsTIME2);
timelockbasemagsTIME3  = ft_timelockbaseline(cfg, datalockmagsTIME3);
timelockbasemagsTIME4  = ft_timelockbaseline(cfg, datalockmagsTIME4);
timelockbasemagsTIME5  = ft_timelockbaseline(cfg, datalockmagsTIME5);
timelockbasemagsSPACE1  = ft_timelockbaseline(cfg, datalockmagsSPACE1);
timelockbasemagsSPACE2  = ft_timelockbaseline(cfg, datalockmagsSPACE2);
timelockbasemagsSPACE3  = ft_timelockbaseline(cfg, datalockmagsSPACE3);
timelockbasemagsSPACE4  = ft_timelockbaseline(cfg, datalockmagsSPACE4);
timelockbasemagsSPACE5  = ft_timelockbaseline(cfg, datalockmagsSPACE5);
timelockbasemagsQTREF1  = ft_timelockbaseline(cfg, datalockmagsQTREF1);
timelockbasemagsQTREF2  = ft_timelockbaseline(cfg, datalockmagsQTREF2);
timelockbasemagsQTREF3  = ft_timelockbaseline(cfg, datalockmagsQTREF3);
timelockbasemagsQTREF4  = ft_timelockbaseline(cfg, datalockmagsQTREF4);
timelockbasemagsQTREF5  = ft_timelockbaseline(cfg, datalockmagsQTREF5);

timelockbasegrads1TIME1  = ft_timelockbaseline(cfg, datalockgrads1TIME1);
timelockbasegrads1TIME2  = ft_timelockbaseline(cfg, datalockgrads1TIME2);
timelockbasegrads1TIME3  = ft_timelockbaseline(cfg, datalockgrads1TIME3);
timelockbasegrads1TIME4  = ft_timelockbaseline(cfg, datalockgrads1TIME4);
timelockbasegrads1TIME5  = ft_timelockbaseline(cfg, datalockgrads1TIME5);
timelockbasegrads1SPACE1  = ft_timelockbaseline(cfg, datalockgrads1SPACE1);
timelockbasegrads1SPACE2  = ft_timelockbaseline(cfg, datalockgrads1SPACE2);
timelockbasegrads1SPACE3  = ft_timelockbaseline(cfg, datalockgrads1SPACE3);
timelockbasegrads1SPACE4  = ft_timelockbaseline(cfg, datalockgrads1SPACE4);
timelockbasegrads1SPACE5  = ft_timelockbaseline(cfg, datalockgrads1SPACE5);
timelockbasegrads1QTREF1  = ft_timelockbaseline(cfg, datalockgrads1QTREF1);
timelockbasegrads1QTREF2  = ft_timelockbaseline(cfg, datalockgrads1QTREF2);
timelockbasegrads1QTREF3  = ft_timelockbaseline(cfg, datalockgrads1QTREF3);
timelockbasegrads1QTREF4  = ft_timelockbaseline(cfg, datalockgrads1QTREF4);
timelockbasegrads1QTREF5  = ft_timelockbaseline(cfg, datalockgrads1QTREF5);

timelockbasegrads2TIME1  = ft_timelockbaseline(cfg, datalockgrads2TIME1);
timelockbasegrads2TIME2  = ft_timelockbaseline(cfg, datalockgrads2TIME2);
timelockbasegrads2TIME3  = ft_timelockbaseline(cfg, datalockgrads2TIME3);
timelockbasegrads2TIME4  = ft_timelockbaseline(cfg, datalockgrads2TIME4);
timelockbasegrads2TIME5  = ft_timelockbaseline(cfg, datalockgrads2TIME5);
timelockbasegrads2SPACE1  = ft_timelockbaseline(cfg, datalockgrads2SPACE1);
timelockbasegrads2SPACE2  = ft_timelockbaseline(cfg, datalockgrads2SPACE2);
timelockbasegrads2SPACE3  = ft_timelockbaseline(cfg, datalockgrads2SPACE3);
timelockbasegrads2SPACE4  = ft_timelockbaseline(cfg, datalockgrads2SPACE4);
timelockbasegrads2SPACE5  = ft_timelockbaseline(cfg, datalockgrads2SPACE5);
timelockbasegrads2QTREF1  = ft_timelockbaseline(cfg, datalockgrads2QTREF1);
timelockbasegrads2QTREF2  = ft_timelockbaseline(cfg, datalockgrads2QTREF2);
timelockbasegrads2QTREF3  = ft_timelockbaseline(cfg, datalockgrads2QTREF3);
timelockbasegrads2QTREF4  = ft_timelockbaseline(cfg, datalockgrads2QTREF4);
timelockbasegrads2QTREF5  = ft_timelockbaseline(cfg, datalockgrads2QTREF5);

timelockbasemagsTIME1t  = ft_timelockbaseline(cfg, datalockmagsTIME1t);
timelockbasemagsTIME2t  = ft_timelockbaseline(cfg, datalockmagsTIME2t);
timelockbasemagsTIME3t  = ft_timelockbaseline(cfg, datalockmagsTIME3t);
timelockbasemagsTIME4t  = ft_timelockbaseline(cfg, datalockmagsTIME4t);
timelockbasemagsTIME5t  = ft_timelockbaseline(cfg, datalockmagsTIME5t);
timelockbasemagsSPACE1t  = ft_timelockbaseline(cfg, datalockmagsSPACE1t);
timelockbasemagsSPACE2t  = ft_timelockbaseline(cfg, datalockmagsSPACE2t);
timelockbasemagsSPACE3t  = ft_timelockbaseline(cfg, datalockmagsSPACE3t);
timelockbasemagsSPACE4t  = ft_timelockbaseline(cfg, datalockmagsSPACE4t);
timelockbasemagsSPACE5t  = ft_timelockbaseline(cfg, datalockmagsSPACE5t);
timelockbasemagsQTREF1t  = ft_timelockbaseline(cfg, datalockmagsQTREF1t);
timelockbasemagsQTREF2t  = ft_timelockbaseline(cfg, datalockmagsQTREF2t);
timelockbasemagsQTREF3t  = ft_timelockbaseline(cfg, datalockmagsQTREF3t);
timelockbasemagsQTREF4t  = ft_timelockbaseline(cfg, datalockmagsQTREF4t);
timelockbasemagsQTREF5t  = ft_timelockbaseline(cfg, datalockmagsQTREF5t);

timelockbasegrads1TIME1t  = ft_timelockbaseline(cfg, datalockgrads1TIME1t);
timelockbasegrads1TIME2t  = ft_timelockbaseline(cfg, datalockgrads1TIME2t);
timelockbasegrads1TIME3t  = ft_timelockbaseline(cfg, datalockgrads1TIME3t);
timelockbasegrads1TIME4t  = ft_timelockbaseline(cfg, datalockgrads1TIME4t);
timelockbasegrads1TIME5t  = ft_timelockbaseline(cfg, datalockgrads1TIME5t);
timelockbasegrads1SPACE1t  = ft_timelockbaseline(cfg, datalockgrads1SPACE1t);
timelockbasegrads1SPACE2t  = ft_timelockbaseline(cfg, datalockgrads1SPACE2t);
timelockbasegrads1SPACE3t  = ft_timelockbaseline(cfg, datalockgrads1SPACE3t);
timelockbasegrads1SPACE4t  = ft_timelockbaseline(cfg, datalockgrads1SPACE4t);
timelockbasegrads1SPACE5t  = ft_timelockbaseline(cfg, datalockgrads1SPACE5t);
timelockbasegrads1QTREF1t  = ft_timelockbaseline(cfg, datalockgrads1QTREF1t);
timelockbasegrads1QTREF2t  = ft_timelockbaseline(cfg, datalockgrads1QTREF2t);
timelockbasegrads1QTREF3t  = ft_timelockbaseline(cfg, datalockgrads1QTREF3t);
timelockbasegrads1QTREF4t  = ft_timelockbaseline(cfg, datalockgrads1QTREF4t);
timelockbasegrads1QTREF5t  = ft_timelockbaseline(cfg, datalockgrads1QTREF5t);

timelockbasegrads2TIME1t  = ft_timelockbaseline(cfg, datalockgrads2TIME1t);
timelockbasegrads2TIME2t  = ft_timelockbaseline(cfg, datalockgrads2TIME2t);
timelockbasegrads2TIME3t  = ft_timelockbaseline(cfg, datalockgrads2TIME3t);
timelockbasegrads2TIME4t  = ft_timelockbaseline(cfg, datalockgrads2TIME4t);
timelockbasegrads2TIME5t  = ft_timelockbaseline(cfg, datalockgrads2TIME5t);
timelockbasegrads2SPACE1t  = ft_timelockbaseline(cfg, datalockgrads2SPACE1t);
timelockbasegrads2SPACE2t  = ft_timelockbaseline(cfg, datalockgrads2SPACE2t);
timelockbasegrads2SPACE3t  = ft_timelockbaseline(cfg, datalockgrads2SPACE3t);
timelockbasegrads2SPACE4t  = ft_timelockbaseline(cfg, datalockgrads2SPACE4t);
timelockbasegrads2SPACE5t  = ft_timelockbaseline(cfg, datalockgrads2SPACE5t);
timelockbasegrads2QTREF1t  = ft_timelockbaseline(cfg, datalockgrads2QTREF1t);
timelockbasegrads2QTREF2t  = ft_timelockbaseline(cfg, datalockgrads2QTREF2t);
timelockbasegrads2QTREF3t  = ft_timelockbaseline(cfg, datalockgrads2QTREF3t);
timelockbasegrads2QTREF4t  = ft_timelockbaseline(cfg, datalockgrads2QTREF4t);
timelockbasegrads2QTREF5t  = ft_timelockbaseline(cfg, datalockgrads2QTREF5t);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[Grads1,Grads2,Mags]   = grads_for_layouts('Laptop');
%%
cfg                    = [];
cfg.axes               = 'no';
cfg.xparam             = 'time';
cfg.zparam             = 'avg';
cfg.xlim               = [-0.3 1.2];
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
lay                    = ft_prepare_layout(cfg,timelockbasemagsTIME1);
lay.label              = Mags;
cfg.layout             = lay;
figure
ft_multiplotER(cfg,timelockbasemagsTIME1,timelockbasemagsTIME2,...
                   timelockbasemagsTIME3,timelockbasemagsTIME4,timelockbasemagsTIME5)

ft_multiplotER(cfg,timelockbasemagsTIME1,timelockbasemagsTIME2, timelockbasemagsTIME3)
               
cfg.layout             = 'C:\FIELDTRIP\fieldtrip-20120402\template\layout/NM306mag.lay';
lay                    = ft_prepare_layout(cfg,timelockbasegrads1TIME1);
lay.label              = Grads1;
cfg.layout             = lay;
figure
ft_multiplotER(cfg,timelockbasegrads1TIME1,timelockbasegrads1TIME2,...
                        timelockbasegrads1TIME3,timelockbasegrads1TIME4,timelockbasegrads1TIME5)

ft_multiplotER(cfg,timelockbasegrads1TIME1,timelockbasegrads1TIME2, timelockbasegrads1TIME3)
                    
cfg.layout             = 'C:\FIELDTRIP\fieldtrip-20120402\template\layout/NM306mag.lay';
lay                    = ft_prepare_layout(cfg,timelockbasegrads2TIME1);
lay.label              = Grads2;
cfg.layout             = lay;
figure
ft_multiplotER(cfg,timelockbasegrads2TIME1,timelockbasegrads2TIME2,...
                        timelockbasegrads2TIME3,timelockbasegrads2TIME4,timelockbasegrads2TIME5)

ft_multiplotER(cfg,timelockbasegrads2TIME1,timelockbasegrads2TIME2,timelockbasegrads2TIME3)


%%

[Grads1,Grads2,Mags]   = grads_for_layouts('Laptop');
%%
cfg                    = [];
cfg.axes               = 'no';
cfg.xparam             = 'time';
cfg.zparam             = 'avg';
cfg.xlim               = [-0.3 1.2];
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
cfg.graphcolor         = [[0 0 0];[0.7 0 0];[1 0.5 0.5]];

cfg.layout             = 'C:\FIELDTRIP\fieldtrip-20120402\template\layout/NM306mag.lay';
lay                    = ft_prepare_layout(cfg,timelockbasemagsSPACE1);
lay.label              = Mags;
cfg.layout             = lay;
figure
ft_multiplotER(cfg,timelockbasemagsSPACE1,timelockbasemagsSPACE2,...
                   timelockbasemagsSPACE3,timelockbasemagsSPACE4,timelockbasemagsSPACE5)
                         
figure
ft_multiplotER(cfg,timelockbasemagsSPACE1,timelockbasemagsSPACE2,timelockbasemagsSPACE3)               
               
cfg.layout             = 'C:\FIELDTRIP\fieldtrip-20120402\template\layout/NM306mag.lay';
lay                    = ft_prepare_layout(cfg,timelockbasegrads1SPACE1);
lay.label              = Grads1;
cfg.layout             = lay;
figure
ft_multiplotER(cfg,timelockbasegrads1SPACE1,timelockbasegrads1SPACE2,...
                        timelockbasegrads1SPACE3,timelockbasegrads1SPACE4,timelockbasegrads1SPACE5)
                    
ft_multiplotER(cfg,timelockbasegrads1SPACE1,timelockbasegrads1SPACE2, timelockbasegrads1SPACE3)                    

cfg.layout             = 'C:\FIELDTRIP\fieldtrip-20120402\template\layout/NM306mag.lay';
lay                    = ft_prepare_layout(cfg,timelockbasegrads2SPACE1);
lay.label              = Grads2;
cfg.layout             = lay;
figure
ft_multiplotER(cfg,timelockbasegrads2SPACE1,timelockbasegrads2SPACE2,...
                        timelockbasegrads2SPACE3,timelockbasegrads2SPACE4,timelockbasegrads2SPACE5)

ft_multiplotER(cfg,timelockbasegrads2SPACE1,timelockbasegrads2SPACE2,timelockbasegrads2SPACE3)                    

%%
cfg.layout             = 'C:\FIELDTRIP\fieldtrip-20120402\template\layout/NM306mag.lay';
lay                    = ft_prepare_layout(cfg,timelockbasemagsQTREF1);
lay.label              = Mags;
cfg.layout             = lay;
figure
ft_multiplotER(cfg,timelockbasemagsQTREF1,timelockbasemagsQTREF2,...
                   timelockbasemagsQTREF3,timelockbasemagsQTREF4,timelockbasemagsQTREF5)

cfg.layout             = 'C:\FIELDTRIP\fieldtrip-20120402\template\layout/NM306mag.lay';
lay                    = ft_prepare_layout(cfg,timelockbasegrads1QTREF1);
lay.label              = Grads1;
cfg.layout             = lay;
figure
ft_multiplotER(cfg,timelockbasegrads1QTREF1,timelockbasegrads1QTREF2,...
                        timelockbasegrads1QTREF3,timelockbasegrads1QTREF4,timelockbasegrads1QTREF5)

cfg.layout             = 'C:\FIELDTRIP\fieldtrip-20120402\template\layout/NM306mag.lay';
lay                    = ft_prepare_layout(cfg,timelockbasegrads2QTREF1);
lay.label              = Grads2;
cfg.layout             = lay;
figure
ft_multiplotER(cfg,timelockbasegrads2QTREF1,timelockbasegrads2QTREF2,...
                        timelockbasegrads2QTREF3,timelockbasegrads2QTREF4,timelockbasegrads2QTREF5)

                    
%% compute REFs F-stats
ERFstatF_subjectlevel(timelockbasemagsTIME1t,timelockbasemagsTIME2t,timelockbasemagsTIME3t,...
timelockbasemagsTIME4t,timelockbasemagsTIME5t)
ERFstatF_subjectlevel(timelockbasegrads1TIME1t,timelockbasegrads1TIME2t,timelockbasegrads1TIME3t,...
timelockbasegrads1TIME4t,timelockbasegrads1TIME5t)
ERFstatF_subjectlevel(timelockbasegrads2TIME1t,timelockbasegrads2TIME2t,timelockbasegrads2TIME3t,...
timelockbasegrads2TIME4t,timelockbasegrads2TIME5t)                    
                    
ERFstatF_subjectlevel(timelockbasemagsTIME1t,timelockbasemagsTIME2t,timelockbasemagsTIME3t)
ERFstatF_subjectlevel(timelockbasegrads1TIME1t,timelockbasegrads1TIME2t,timelockbasegrads1TIME3t)
ERFstatF_subjectlevel(timelockbasegrads2TIME1t,timelockbasegrads2TIME2t,timelockbasegrads2TIME3t)   

ERFstatF_subjectlevel(timelockbasemagsSPACE1t,timelockbasemagsSPACE2t,timelockbasemagsSPACE3t,...
timelockbasemagsSPACE4t,timelockbasemagsSPACE5t)
ERFstatF_subjectlevel(timelockbasegrads1SPACE1t,timelockbasegrads1SPACE2t,timelockbasegrads1SPACE3t,...
timelockbasegrads1SPACE4t,timelockbasegrads1SPACE5t)
ERFstatF_subjectlevel(timelockbasegrads2SPACE1t,timelockbasegrads2SPACE2t,timelockbasegrads2SPACE3t,...
timelockbasegrads2SPACE4t,timelockbasegrads2SPACE5t) 

ERFstatF_subjectlevel(timelockbasemagsSPACE1t,timelockbasemagsSPACE4t,timelockbasemagsSPACE5t)
ERFstatF_subjectlevel(timelockbasegrads1SPACE1t,timelockbasegrads1SPACE4t,timelockbasegrads1SPACE5t)
ERFstatF_subjectlevel(timelockbasegrads2SPACE1t,timelockbasegrads2SPACE4t,timelockbasegrads2SPACE5t) 

ERFstatF_subjectlevel(timelockbasemagsQTREF1t,timelockbasemagsQTREF2t,timelockbasemagsQTREF3t,...
timelockbasemagsQTREF4t,timelockbasemagsQTREF5t)
ERFstatF_subjectlevel(timelockbasegrads1QTREF1t,timelockbasegrads1QTREF2t,timelockbasegrads1QTREF3t,...
timelockbasegrads1QTREF4t,timelockbasegrads1QTREF5t)
ERFstatF_subjectlevel(timelockbasegrads2QTREF1t,timelockbasegrads2QTREF2t,timelockbasegrads2QTREF3t,...
timelockbasegrads2QTREF4t,timelockbasegrads2QTREF5t) 

ERFstatF_subjectlevel(timelockbasemagsQTREF1t,timelockbasemagsQTREF2t,timelockbasemagsQTREF3t)
ERFstatF_subjectlevel(timelockbasegrads1QTREF1t,timelockbasegrads1QTREF2t,timelockbasegrads1QTREF3t)
ERFstatF_subjectlevel(timelockbasegrads2QTREF1t,timelockbasegrads2QTREF2t,timelockbasegrads2QTREF3t) 

ERFstatF_subjectlevel(timelockbasemagsQTREF3t,timelockbasemagsQTREF4t,timelockbasemagsQTREF5t)
ERFstatF_subjectlevel(timelockbasegrads1QTREF3t,timelockbasegrads1QTREF4t,timelockbasegrads1QTREF5t)
ERFstatF_subjectlevel(timelockbasegrads2QTREF3t,timelockbasegrads2QTREF4t,timelockbasegrads2QTREF5t) 


