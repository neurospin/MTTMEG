function TLSL_REF(nip,chansel,cond1,cond2)

% define channel types
[Grads1,Grads2,Mags]   = grads_for_layouts('Laptop');
EEG  = EEG_for_layouts('Laptop');

ch = [];
if strcmp(chansel,'Mags')
    ch = Mags;
elseif strcmp(chansel,'Grads1')
    ch = Grads1;
elseif strcmp(chansel,'Grads2')
    ch = Grads2;
elseif strcmp(chansel,'GradComb')
    ch = Grads1; %temporary
else strcmp(chansel,'EEG')
    ch = EEG;
end

statstag = 'T';


%% COMPUTE TFRs

% process REF condition of interest
data1 = load(['C:\MTT_MEG\data\' nip '\processed\' cond1 '_nofilt.mat']);
data2 = load(['C:\MTT_MEG\data\' nip '\processed\' cond2 '_nofilt.mat']);

% temporal realignment
for j = 1:length(data1.data.time)
    data1.data.time{1,j} = data1.data.time{1,j} - ones(1,length(data1.data.time{1,j}))*(0.45);
end
for j = 1:length(data2.data.time)
    data2.data.time{1,j} = data2.data.time{1,j} - ones(1,length(data2.data.time{1,j}))*(0.45);
end


cfg                    = [];
cfg.channel            = ch;
cfg.method             = 'mtmconvol';
cfg.output             = 'pow';
cfg.trials             = 'all';
cfg.keeptrials         = 'no';
cfg.keeptapers         = 'no';
cfg.pad                = 'maxperlen';
cfg.polyremoval        = 0;
cfg.foi                = 3:35;
cfg.t_ftimwin          = 3./cfg.foi;
cfg.toi                = -0.4:0.05:2.2;
cfg.tapsmofrq          = 0.5*cfg.foi;

% for plot
cfg.keeptrials         = 'no';
cfg.polyremoval        = 0;
datalock1              = ft_freqanalysis(cfg, data1.data);
datalock2              = ft_freqanalysis(cfg, data2.data);

% for stats
cfg.keeptrials         = 'yes';
cfg.polyremoval        = 0;
datalockt1             = ft_freqanalysis(cfg, data1.data);
datalockt2             = ft_freqanalysis(cfg, data2.data);

% baseline correction
cfg                    = [];
cfg.baseline           = [-0.25 0];
cfg.baselinetype       = 'absolute';
cfg.channel            = 'all';
cfg.param              = 'powspctrm';
timelockbase1          = ft_freqbaseline(cfg, datalock1);
timelockbaset1         = ft_freqbaseline(cfg, datalockt1);
timelockbase2          = ft_freqbaseline(cfg, datalock2);
timelockbaset2         = ft_freqbaseline(cfg, datalockt2);

timelockbase1.powspctrm = timelockbase1.powspctrm - timelockbase2.powspctrm;

%% PLOT
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
lay                  = ft_prepare_layout(cfg,timelockbase1);
lay.label            = ch;
cfg.layout           = lay;

%% build plot instructions
fig = figure('position',[1 1 1000 1000]);
set(fig,'PaperPosition',[1 1 1000 1000])
set(fig,'PaperPositionmode','auto')

ft_multiplotTFR(cfg,timelockbase1)

% save plots
filename = ['C:\MTT_MEG\results\' nip '\TF_TOPO_' cond1 'vs' cond2];
print('-dpng',filename)

%% compute REFs stats

TFstatT_subjectlevel(timelockbaset1,timelockbaset2)

% save plots
filename = ['C:\MTT_MEG\results\' nip '\TF_STATS_' cond1 'vs' cond2];
print('-dpng',filename)




    
