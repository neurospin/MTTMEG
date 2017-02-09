function timelock_dist(nip)

% define channel types
[Grads1,Grads2,Mags]   = grads_for_layouts('Laptop');

clear datafilt40
datat1  = load(['C:\MTT_MEG\data\' nip '\processed\TimeDist1_REF1_filt40.mat']);
datat2  = load(['C:\MTT_MEG\data\' nip '\processed\TimeDist1_REF2_filt40.mat']);
datat3  = load(['C:\MTT_MEG\data\' nip '\processed\TimeDist1_REF3_filt40.mat']);
datat4  = load(['C:\MTT_MEG\data\' nip '\processed\TimeDist1_REF4_filt40.mat']);
datat5  = load(['C:\MTT_MEG\data\' nip '\processed\TimeDist1_REF5_filt40.mat']);
datat6  = load(['C:\MTT_MEG\data\' nip '\processed\TimeDist2_REF1_filt40.mat']);
datat7  = load(['C:\MTT_MEG\data\' nip '\processed\TimeDist2_REF2_filt40.mat']);
datat8  = load(['C:\MTT_MEG\data\' nip '\processed\TimeDist2_REF3_filt40.mat']);
datat9  = load(['C:\MTT_MEG\data\' nip '\processed\TimeDist2_REF4_filt40.mat']);
datat10 = load(['C:\MTT_MEG\data\' nip '\processed\TimeDist2_REF5_filt40.mat']);

datas1  = load(['C:\MTT_MEG\data\' nip '\processed\SpaceDist1_REF1_filt40.mat']);
datas2  = load(['C:\MTT_MEG\data\' nip '\processed\SpaceDist1_REF2_filt40.mat']);
datas3  = load(['C:\MTT_MEG\data\' nip '\processed\SpaceDist1_REF3_filt40.mat']);
datas4  = load(['C:\MTT_MEG\data\' nip '\processed\SpaceDist1_REF4_filt40.mat']);
datas5  = load(['C:\MTT_MEG\data\' nip '\processed\SpaceDist1_REF5_filt40.mat']);
datas6  = load(['C:\MTT_MEG\data\' nip '\processed\SpaceDist2_REF1_filt40.mat']);
datas7  = load(['C:\MTT_MEG\data\' nip '\processed\SpaceDist2_REF2_filt40.mat']);
datas8  = load(['C:\MTT_MEG\data\' nip '\processed\SpaceDist2_REF3_filt40.mat']);
datas9  = load(['C:\MTT_MEG\data\' nip '\processed\SpaceDist2_REF4_filt40.mat']);
datas10 = load(['C:\MTT_MEG\data\' nip '\processed\SpaceDist2_REF5_filt40.mat']);

%% T1

% cfg.trials             = 'all';
% cfg.minlength          = 'maxperlen';
% cfg.offset             = 0.4*data.fsample;
% dataraT1               = ft_redefinetrial(cfg, datafilt40);
dataraTD1REF1             = datat1.datafilt40;
dataraTD1REF2             = datat2.datafilt40;
dataraTD1REF3             = datat3.datafilt40;
dataraTD1REF4             = datat4.datafilt40;
dataraTD1REF5             = datat5.datafilt40;
dataraTD2REF1             = datat6.datafilt40;
dataraTD2REF2             = datat7.datafilt40;
dataraTD2REF3             = datat8.datafilt40;
dataraTD2REF4             = datat9.datafilt40;
dataraTD2REF5             = datat10.datafilt40;
dataraSD1REF1             = datas1.datafilt40;
dataraSD1REF2             = datas2.datafilt40;
dataraSD1REF3             = datas3.datafilt40;
dataraSD1REF4             = datas4.datafilt40;
dataraSD1REF5             = datas5.datafilt40;
dataraSD2REF1             = datas6.datafilt40;
dataraSD2REF2             = datas7.datafilt40;
dataraSD2REF3             = datas8.datafilt40;
dataraSD2REF4             = datas9.datafilt40;
dataraSD2REF5             = datas10.datafilt40;

%%
for i = 1:length(dataraTD1REF1.time)
    dataraTD1REF1.time{1,i} = dataraTD1REF1.time{1,i} - ones(1,length(dataraTD1REF1.time{1,i}))*(0.35);
end
for i = 1:length(dataraTD1REF2.time)
    dataraTD1REF2.time{1,i} = dataraTD1REF2.time{1,i} - ones(1,length(dataraTD1REF2.time{1,i}))*(0.35);
end
for i = 1:length(dataraTD1REF3.time)
    dataraTD1REF3.time{1,i} = dataraTD1REF3.time{1,i} - ones(1,length(dataraTD1REF3.time{1,i}))*(0.35);
end
for i = 1:length(dataraTD1REF4.time)
    dataraTD1REF4.time{1,i} = dataraTD1REF4.time{1,i} - ones(1,length(dataraTD1REF4.time{1,i}))*(0.35);
end
for i = 1:length(dataraTD1REF5.time)
    dataraTD1REF5.time{1,i} = dataraTD1REF5.time{1,i} - ones(1,length(dataraTD1REF5.time{1,i}))*(0.35);
end
for i = 1:length(dataraTD2REF1.time)
    dataraTD2REF1.time{1,i} = dataraTD2REF1.time{1,i} - ones(1,length(dataraTD2REF1.time{1,i}))*(0.35);
end
for i = 1:length(dataraTD2REF2.time)
    dataraTD2REF2.time{1,i} = dataraTD2REF2.time{1,i} - ones(1,length(dataraTD2REF2.time{1,i}))*(0.35);
end
for i = 1:length(dataraTD2REF3.time)
    dataraTD2REF3.time{1,i} = dataraTD2REF3.time{1,i} - ones(1,length(dataraTD2REF3.time{1,i}))*(0.35);
end
for i = 1:length(dataraTD2REF4.time)
    dataraTD2REF4.time{1,i} = dataraTD2REF4.time{1,i} - ones(1,length(dataraTD2REF4.time{1,i}))*(0.35);
end
for i = 1:length(dataraTD2REF5.time)
    dataraTD2REF5.time{1,i} = dataraTD2REF5.time{1,i} - ones(1,length(dataraTD2REF5.time{1,i}))*(0.35);
end

for i = 1:length(dataraSD1REF1.time)
    dataraSD1REF1.time{1,i} = dataraSD1REF1.time{1,i} - ones(1,length(dataraSD1REF1.time{1,i}))*(0.35);
end
for i = 1:length(dataraSD1REF2.time)
    dataraSD1REF2.time{1,i} = dataraSD1REF2.time{1,i} - ones(1,length(dataraSD1REF2.time{1,i}))*(0.35);
end
for i = 1:length(dataraSD1REF3.time)
    dataraSD1REF3.time{1,i} = dataraSD1REF3.time{1,i} - ones(1,length(dataraSD1REF3.time{1,i}))*(0.35);
end
for i = 1:length(dataraSD1REF4.time)
    dataraSD1REF4.time{1,i} = dataraSD1REF4.time{1,i} - ones(1,length(dataraSD1REF4.time{1,i}))*(0.35);
end
for i = 1:length(dataraSD1REF5.time)
    dataraSD1REF5.time{1,i} = dataraSD1REF5.time{1,i} - ones(1,length(dataraSD1REF5.time{1,i}))*(0.35);
end
for i = 1:length(dataraSD2REF1.time)
    dataraSD2REF1.time{1,i} = dataraSD2REF1.time{1,i} - ones(1,length(dataraSD2REF1.time{1,i}))*(0.35);
end
for i = 1:length(dataraSD2REF2.time)
    dataraSD2REF2.time{1,i} = dataraSD2REF2.time{1,i} - ones(1,length(dataraSD2REF2.time{1,i}))*(0.35);
end
for i = 1:length(dataraSD2REF3.time)
    dataraSD2REF3.time{1,i} = dataraSD2REF3.time{1,i} - ones(1,length(dataraSD2REF3.time{1,i}))*(0.35);
end
for i = 1:length(dataraSD2REF4.time)
    dataraSD2REF4.time{1,i} = dataraSD2REF4.time{1,i} - ones(1,length(dataraSD2REF4.time{1,i}))*(0.35);
end
for i = 1:length(dataraSD2REF5.time)
    dataraSD2REF5.time{1,i} = dataraSD2REF5.time{1,i} - ones(1,length(dataraSD2REF5.time{1,i}))*(0.35);
end

dataraTD1              = ft_appenddata([],dataraTD1REF1,dataraTD1REF2,dataraTD1REF3,dataraTD1REF4,dataraTD1REF5);
dataraTD2              = ft_appenddata([],dataraTD2REF1,dataraTD2REF2,dataraTD2REF3,dataraTD2REF4,dataraTD2REF5);
dataraSD1              = ft_appenddata([],dataraSD1REF1,dataraSD1REF2,dataraSD1REF3,dataraSD1REF4,dataraSD1REF5);
dataraSD2              = ft_appenddata([],dataraSD2REF1,dataraSD2REF2,dataraSD2REF3,dataraSD2REF4,dataraSD2REF5);

dataraTD               = ft_appenddata([],dataraTD1REF1,dataraTD1REF2,dataraTD1REF3,dataraTD1REF4,dataraTD1REF5,...
                         dataraTD2REF1,dataraTD2REF2,dataraTD2REF3,dataraTD2REF4,dataraTD2REF5);
dataraSD               = ft_appenddata([],dataraSD1REF1,dataraSD1REF2,dataraSD1REF3,dataraSD1REF4,dataraSD1REF5,...
                         dataraSD2REF1,dataraSD2REF2,dataraSD2REF3,dataraSD2REF4,dataraSD2REF5);
                     
dataraD1               = ft_appenddata([],dataraTD1REF1,dataraTD1REF2,dataraTD1REF3,dataraTD1REF4,dataraTD1REF5,...
                         dataraSD1REF1,dataraSD1REF2,dataraSD1REF3,dataraSD1REF4,dataraSD1REF5);
dataraD2               = ft_appenddata([],dataraTD2REF1,dataraTD2REF2,dataraTD2REF3,dataraTD2REF4,dataraTD1REF5,...
                         dataraSD2REF1,dataraSD2REF2,dataraSD2REF3,dataraSD2REF4,dataraSD2REF5);  
                     
dataraREF1             = ft_appenddata([],dataraTD1REF1,dataraTD2REF1,dataraSD1REF1,dataraSD2REF1);
dataraREF2             = ft_appenddata([],dataraTD1REF2,dataraTD2REF2,dataraSD1REF1,dataraSD2REF1);
dataraREF3             = ft_appenddata([],dataraTD1REF3,dataraTD2REF3,dataraSD1REF1,dataraSD2REF1);
dataraREF4             = ft_appenddata([],dataraTD1REF4,dataraTD2REF4,dataraSD1REF1,dataraSD2REF1);
dataraREF5             = ft_appenddata([],dataraTD1REF5,dataraTD2REF5,dataraSD1REF1,dataraSD2REF1);

dataraTDREF1           = ft_appenddata([],dataraTD1REF1,dataraTD2REF1);
dataraTDREF2           = ft_appenddata([],dataraTD1REF2,dataraTD2REF2);
dataraTDREF3           = ft_appenddata([],dataraTD1REF3,dataraTD2REF3);
dataraTDREF4           = ft_appenddata([],dataraTD1REF4,dataraTD2REF4);
dataraTDREF5           = ft_appenddata([],dataraTD1REF5,dataraTD2REF5);
dataraSDREF1           = ft_appenddata([],dataraSD1REF1,dataraSD2REF1);
dataraSDREF2           = ft_appenddata([],dataraSD1REF2,dataraSD2REF2);
dataraSDREF3           = ft_appenddata([],dataraSD1REF3,dataraSD2REF3);
dataraSDREF4           = ft_appenddata([],dataraSD1REF4,dataraSD2REF4);
dataraSDREF5           = ft_appenddata([],dataraSD1REF5,dataraSD2REF5);


cfg.channel            = Mags;
cfg.trials             = 'all';
cfg.keeptrials         = 'no';
cfg.removemean         = 'yes';
cfg.covariance         = 'yes';
% cfg.covariancewindow   = [0 1.5];
datalockmagsTD1REF1  = ft_timelockanalysis(cfg, dataraTD1REF1);
datalockmagsTD1REF2  = ft_timelockanalysis(cfg, dataraTD1REF2);
datalockmagsTD1REF3  = ft_timelockanalysis(cfg, dataraTD1REF3);
datalockmagsTD1REF4  = ft_timelockanalysis(cfg, dataraTD1REF4);
datalockmagsTD1REF5  = ft_timelockanalysis(cfg, dataraTD1REF5);
datalockmagsTD2REF1  = ft_timelockanalysis(cfg, dataraTD2REF1);
datalockmagsTD2REF2  = ft_timelockanalysis(cfg, dataraTD2REF2);
datalockmagsTD2REF3  = ft_timelockanalysis(cfg, dataraTD2REF3);
datalockmagsTD2REF4  = ft_timelockanalysis(cfg, dataraTD2REF4);
datalockmagsTD2REF5  = ft_timelockanalysis(cfg, dataraTD2REF5);
datalockmagsSD1REF1  = ft_timelockanalysis(cfg, dataraSD1REF1);
datalockmagsSD1REF2  = ft_timelockanalysis(cfg, dataraSD1REF2);
datalockmagsSD1REF3  = ft_timelockanalysis(cfg, dataraSD1REF3);
datalockmagsSD1REF4  = ft_timelockanalysis(cfg, dataraSD1REF4);
datalockmagsSD1REF5  = ft_timelockanalysis(cfg, dataraSD1REF5);
datalockmagsSD2REF1  = ft_timelockanalysis(cfg, dataraSD2REF1);
datalockmagsSD2REF2  = ft_timelockanalysis(cfg, dataraSD2REF2);
datalockmagsSD2REF3  = ft_timelockanalysis(cfg, dataraSD2REF3);
datalockmagsSD2REF4  = ft_timelockanalysis(cfg, dataraSD2REF4);
datalockmagsSD2REF5  = ft_timelockanalysis(cfg, dataraSD2REF5);

datalockmagsREF1     = ft_timelockanalysis(cfg, dataraREF1);
datalockmagsREF2     = ft_timelockanalysis(cfg, dataraREF2);
datalockmagsREF3     = ft_timelockanalysis(cfg, dataraREF3);
datalockmagsREF4     = ft_timelockanalysis(cfg, dataraREF4);
datalockmagsREF5     = ft_timelockanalysis(cfg, dataraREF5);

datalockmagsTD       = ft_timelockanalysis(cfg, dataraTD);
datalockmagsSD       = ft_timelockanalysis(cfg, dataraSD);

datalockmagsTD1       = ft_timelockanalysis(cfg, dataraTD1);
datalockmagsSD1       = ft_timelockanalysis(cfg, dataraSD1);
datalockmagsTD2       = ft_timelockanalysis(cfg, dataraTD2);
datalockmagsSD2       = ft_timelockanalysis(cfg, dataraSD2);

datalockmagsD1       = ft_timelockanalysis(cfg, dataraD1);
datalockmagsD2       = ft_timelockanalysis(cfg, dataraD2);

cfg.keeptrials         = 'yes';
datalockmagsTD1REF1t  = ft_timelockanalysis(cfg, dataraTD1REF1);
datalockmagsTD1REF2t  = ft_timelockanalysis(cfg, dataraTD1REF2);
datalockmagsTD1REF3t  = ft_timelockanalysis(cfg, dataraTD1REF3);
datalockmagsTD1REF4t  = ft_timelockanalysis(cfg, dataraTD1REF4);
datalockmagsTD1REF5t  = ft_timelockanalysis(cfg, dataraTD1REF5);
datalockmagsTD2REF1t  = ft_timelockanalysis(cfg, dataraTD2REF1);
datalockmagsTD2REF2t  = ft_timelockanalysis(cfg, dataraTD2REF2);
datalockmagsTD2REF3t  = ft_timelockanalysis(cfg, dataraTD2REF3);
datalockmagsTD2REF4t  = ft_timelockanalysis(cfg, dataraTD2REF4);
datalockmagsTD2REF5t  = ft_timelockanalysis(cfg, dataraTD2REF5);
datalockmagsSD1REF1t  = ft_timelockanalysis(cfg, dataraSD1REF1);
datalockmagsSD1REF2t  = ft_timelockanalysis(cfg, dataraSD1REF2);
datalockmagsSD1REF3t  = ft_timelockanalysis(cfg, dataraSD1REF3);
datalockmagsSD1REF4t  = ft_timelockanalysis(cfg, dataraSD1REF4);
datalockmagsSD1REF5t  = ft_timelockanalysis(cfg, dataraSD1REF5);
datalockmagsSD2REF1t  = ft_timelockanalysis(cfg, dataraSD2REF1);
datalockmagsSD2REF2t  = ft_timelockanalysis(cfg, dataraSD2REF2);
datalockmagsSD2REF3t  = ft_timelockanalysis(cfg, dataraSD2REF3);
datalockmagsSD2REF4t  = ft_timelockanalysis(cfg, dataraSD2REF4);
datalockmagsSD2REF5t  = ft_timelockanalysis(cfg, dataraSD2REF5);

datalockmagsREF1t     = ft_timelockanalysis(cfg, dataraREF1);
datalockmagsREF2t     = ft_timelockanalysis(cfg, dataraREF2);
datalockmagsREF3t     = ft_timelockanalysis(cfg, dataraREF3);
datalockmagsREF4t     = ft_timelockanalysis(cfg, dataraREF4);
datalockmagsREF5t     = ft_timelockanalysis(cfg, dataraREF5);

datalockmagsTDt       = ft_timelockanalysis(cfg, dataraTD);
datalockmagsSDt       = ft_timelockanalysis(cfg, dataraSD);

datalockmagsD1t       = ft_timelockanalysis(cfg, dataraD1);
datalockmagsD2t       = ft_timelockanalysis(cfg, dataraD2);

datalockmagsTD1t       = ft_timelockanalysis(cfg, dataraTD1);
datalockmagsSD1t       = ft_timelockanalysis(cfg, dataraSD1);
datalockmagsTD2t       = ft_timelockanalysis(cfg, dataraTD2);
datalockmagsSD2t       = ft_timelockanalysis(cfg, dataraSD2);

cfg                    = [];
cfg.baseline           = [-0.15 0]; 
cfg.channel            = 'all';

timelockbasemagsTD1REF1   = ft_timelockbaseline(cfg, datalockmagsTD1REF1);
timelockbasemagsTD1REF2   = ft_timelockbaseline(cfg, datalockmagsTD1REF2);
timelockbasemagsTD1REF3   = ft_timelockbaseline(cfg, datalockmagsTD1REF3);
timelockbasemagsTD1REF4   = ft_timelockbaseline(cfg, datalockmagsTD1REF4);
timelockbasemagsTD1REF5   = ft_timelockbaseline(cfg, datalockmagsTD1REF5);
timelockbasemagsTD2REF1   = ft_timelockbaseline(cfg, datalockmagsTD2REF1);
timelockbasemagsTD2REF2   = ft_timelockbaseline(cfg, datalockmagsTD2REF2);
timelockbasemagsTD2REF3   = ft_timelockbaseline(cfg, datalockmagsTD2REF3);
timelockbasemagsTD2REF4   = ft_timelockbaseline(cfg, datalockmagsTD2REF4);
timelockbasemagsTD2REF5   = ft_timelockbaseline(cfg, datalockmagsTD2REF5);
timelockbasemagsSD1REF1   = ft_timelockbaseline(cfg, datalockmagsSD1REF1);
timelockbasemagsSD1REF2   = ft_timelockbaseline(cfg, datalockmagsSD1REF2);
timelockbasemagsSD1REF3   = ft_timelockbaseline(cfg, datalockmagsSD1REF3);
timelockbasemagsSD1REF4   = ft_timelockbaseline(cfg, datalockmagsSD1REF4);
timelockbasemagsSD1REF5   = ft_timelockbaseline(cfg, datalockmagsSD1REF5);
timelockbasemagsSD2REF1   = ft_timelockbaseline(cfg, datalockmagsSD2REF1);
timelockbasemagsSD2REF2   = ft_timelockbaseline(cfg, datalockmagsSD2REF2);
timelockbasemagsSD2REF3   = ft_timelockbaseline(cfg, datalockmagsSD2REF3);
timelockbasemagsSD2REF4   = ft_timelockbaseline(cfg, datalockmagsSD2REF4);
timelockbasemagsSD2REF5   = ft_timelockbaseline(cfg, datalockmagsSD2REF5);

timelockbasemagsTD1REF1t   = ft_timelockbaseline(cfg, datalockmagsTD1REF1t);
timelockbasemagsTD1REF2t   = ft_timelockbaseline(cfg, datalockmagsTD1REF2t);
timelockbasemagsTD1REF3t   = ft_timelockbaseline(cfg, datalockmagsTD1REF3t);
timelockbasemagsTD1REF4t   = ft_timelockbaseline(cfg, datalockmagsTD1REF4t);
timelockbasemagsTD1REF5t   = ft_timelockbaseline(cfg, datalockmagsTD1REF5t);
timelockbasemagsTD2REF1t   = ft_timelockbaseline(cfg, datalockmagsTD2REF1t);
timelockbasemagsTD2REF2t   = ft_timelockbaseline(cfg, datalockmagsTD2REF2t);
timelockbasemagsTD2REF3t   = ft_timelockbaseline(cfg, datalockmagsTD2REF3t);
timelockbasemagsTD2REF4t   = ft_timelockbaseline(cfg, datalockmagsTD2REF4t);
timelockbasemagsTD2REF5t   = ft_timelockbaseline(cfg, datalockmagsTD2REF5t);
timelockbasemagsSD1REF1t   = ft_timelockbaseline(cfg, datalockmagsSD1REF1t);
timelockbasemagsSD1REF2t   = ft_timelockbaseline(cfg, datalockmagsSD1REF2t);
timelockbasemagsSD1REF3t   = ft_timelockbaseline(cfg, datalockmagsSD1REF3t);
timelockbasemagsSD1REF4t   = ft_timelockbaseline(cfg, datalockmagsSD1REF4t);
timelockbasemagsSD1REF5t   = ft_timelockbaseline(cfg, datalockmagsSD1REF5t);
timelockbasemagsSD2REF1t   = ft_timelockbaseline(cfg, datalockmagsSD2REF1t);
timelockbasemagsSD2REF2t   = ft_timelockbaseline(cfg, datalockmagsSD2REF2t);
timelockbasemagsSD2REF3t   = ft_timelockbaseline(cfg, datalockmagsSD2REF3t);
timelockbasemagsSD2REF4t   = ft_timelockbaseline(cfg, datalockmagsSD2REF4t);
timelockbasemagsSD2REF5t   = ft_timelockbaseline(cfg, datalockmagsSD2REF5t);

timelockbasemagsREF1      = ft_timelockbaseline(cfg, datalockmagsREF1);
timelockbasemagsREF2      = ft_timelockbaseline(cfg, datalockmagsREF2);
timelockbasemagsREF3      = ft_timelockbaseline(cfg, datalockmagsREF3);
timelockbasemagsREF4      = ft_timelockbaseline(cfg, datalockmagsREF4);
timelockbasemagsREF5      = ft_timelockbaseline(cfg, datalockmagsREF5);

timelockbasemagsREF1t      = ft_timelockbaseline(cfg, datalockmagsREF1t);
timelockbasemagsREF2t      = ft_timelockbaseline(cfg, datalockmagsREF2t);
timelockbasemagsREF3t      = ft_timelockbaseline(cfg, datalockmagsREF3t);
timelockbasemagsREF4t      = ft_timelockbaseline(cfg, datalockmagsREF4t);
timelockbasemagsREF5t      = ft_timelockbaseline(cfg, datalockmagsREF5t);

timelockbasemagsTD       = ft_timelockbaseline(cfg, datalockmagsTD);
timelockbasemagsSD       = ft_timelockbaseline(cfg, datalockmagsSD);

timelockbasemagsD1       = ft_timelockbaseline(cfg, datalockmagsD1);
timelockbasemagsD2       = ft_timelockbaseline(cfg, datalockmagsD2);

timelockbasemagsTDt       = ft_timelockbaseline(cfg, datalockmagsTDt);
timelockbasemagsSDt       = ft_timelockbaseline(cfg, datalockmagsSDt);

timelockbasemagsTD1       = ft_timelockbaseline(cfg, datalockmagsTD1);
timelockbasemagsSD1       = ft_timelockbaseline(cfg, datalockmagsSD1);
timelockbasemagsTD2       = ft_timelockbaseline(cfg, datalockmagsTD2);
timelockbasemagsSD2       = ft_timelockbaseline(cfg, datalockmagsSD2);

timelockbasemagsTD1t       = ft_timelockbaseline(cfg, datalockmagsTD1t);
timelockbasemagsSD1t       = ft_timelockbaseline(cfg, datalockmagsSD1t);
timelockbasemagsTD2t       = ft_timelockbaseline(cfg, datalockmagsTD2t);
timelockbasemagsSD2t       = ft_timelockbaseline(cfg, datalockmagsSD2t);

timelockbasemagsD1t       = ft_timelockbaseline(cfg, datalockmagsD1t);
timelockbasemagsD2t       = ft_timelockbaseline(cfg, datalockmagsD2t);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% REF %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
lay                    = ft_prepare_layout(cfg,datalockmagsREF1);
lay.label              = Mags;
cfg.layout             = lay;
figure
ft_multiplotER(cfg,timelockbasemagsREF1,timelockbasemagsREF2,timelockbasemagsREF3,timelockbasemagsREF4,timelockbasemagsREF5)

ERFstatF_subjectlevel(timelockbasemagsREF1t,timelockbasemagsREF2t,timelockbasemagsREF3t,timelockbasemagsREF4t,timelockbasemagsREF5t)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% DIM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
lay                    = ft_prepare_layout(cfg,datalockmagsTD);
lay.label              = Mags;
cfg.layout             = lay;
figure
ft_multiplotER(cfg,timelockbasemagsTD,timelockbasemagsSD)

ERFstatT_subjectlevel(timelockbasemagsTDt,timelockbasemagsSDt)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% DIST %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
cfg.graphcolor         = [[0 0 1];[0.5 0.5 1];[1 0 0];[1 0.5 0.5]];

cfg.layout             = 'C:\FIELDTRIP\fieldtrip-20120402\template\layout/NM306mag.lay';
lay                    = ft_prepare_layout(cfg,datalockmagsTD);
lay.label              = Mags;
cfg.layout             = lay;
figure
ft_multiplotER(cfg,timelockbasemagsTD1,timelockbasemagsTD2,timelockbasemagsSD1,timelockbasemagsSD2)
ft_multiplotER(cfg,timelockbasemagsTD1,timelockbasemagsTD2)
ft_multiplotER(cfg,timelockbasemagsSD1,timelockbasemagsSD2)
ft_multiplotER(cfg,timelockbasemagsD1,timelockbasemagsD2)
cfg.graphcolor         = [[0 0 1];[1 0 0]];
ft_multiplotER(cfg,timelockbasemagsTD,timelockbasemagsSD)

cfg.graphcolor         = [[0 0 0];[0 0 0.7];[0.5 0.5 1];[0.7 0 0];[1 0.5 0.5]];
ft_multiplotER(cfg,timelockbasemagsTD1REF1,timelockbasemagsTD2REF1)
ft_multiplotER(cfg,timelockbasemagsTD1REF2,timelockbasemagsTD2REF2)
ft_multiplotER(cfg,timelockbasemagsTD1REF3,timelockbasemagsTD2REF3)
ft_multiplotER(cfg,timelockbasemagsTD1REF4,timelockbasemagsTD2REF4)
ft_multiplotER(cfg,timelockbasemagsTD1REF5,timelockbasemagsTD2REF5)

ERFstatT_subjectlevel(timelockbasemagsTD1t,timelockbasemagsTD2t)
ERFstatT_subjectlevel(timelockbasemagsSD1t,timelockbasemagsSD2t)

ERFstatT_subjectlevel(timelockbasemagsD1t,timelockbasemagsD2t)
ERFstatT_subjectlevel(timelockbasemagsTDt,timelockbasemagsSDt)

ERFstatT_subjectlevel(timelockbasemagsTD1REF1t,timelockbasemagsTD2REF1t)
ERFstatT_subjectlevel(timelockbasemagsTD1REF2t,timelockbasemagsTD2REF2t)
ERFstatT_subjectlevel(timelockbasemagsTD1REF3t,timelockbasemagsTD2REF3t)
ERFstatT_subjectlevel(timelockbasemagsTD1REF4t,timelockbasemagsTD2REF4t)
ERFstatT_subjectlevel(timelockbasemagsTD1REF5t,timelockbasemagsTD2REF5t)

ERFstatT_subjectlevel(timelockbasemagsSD1REF1t,timelockbasemagsSD2REF1t)
ERFstatT_subjectlevel(timelockbasemagsSD1REF2t,timelockbasemagsSD2REF2t)
ERFstatT_subjectlevel(timelockbasemagsSD1REF3t,timelockbasemagsSD2REF3t)
ERFstatT_subjectlevel(timelockbasemagsSD1REF4t,timelockbasemagsSD2REF4t)
ERFstatT_subjectlevel(timelockbasemagsSD1REF5t,timelockbasemagsSD2REF5t)

