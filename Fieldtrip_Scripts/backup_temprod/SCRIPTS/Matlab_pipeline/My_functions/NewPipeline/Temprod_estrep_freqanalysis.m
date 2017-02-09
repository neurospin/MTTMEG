function Temprod_estrep_freqanalysis(subject,RunArray,chantype,Pad,tag)

% % test set
% subject  = 's10';
% RunArray = [2 4];
% chantype = 'Mags';
% tag      = 'Laptop';
% freqband = [5 15];
% Pad      = 12600;
% freq4stat = 10;

% set root
root = SetPath(tag);

% load data
for i = 1:2
    ProcDataDir                = [root '/DATA/NEW/processed_' subject '/'];
    DataDir                    = [ProcDataDir 'FT_trials/BLOCKTRIALS_' chantype '_RUN' num2str(RunArray(i),'%02i') '.mat'];
    eval(['data' num2str(i) ' = load(DataDir)']);
end

% load matching indexes
ProcDataDir                    = [root '/DATA/NEW/processed_' subject '/'];
DataDir                        = [ProcDataDir 'FT_trials/matchestrep_' chantype '_RUN' num2str(RunArray(i),'%02i') '.mat'];
load(DataDir)

% keep only matching data
[x2,y2] = find((isnan(matchest(:,1)) == 0) == 1);
matchest = matchest(x2,:);
[x1,y1] = find((isnan(matchrep(:,1)) == 0) == 1);
matchrep = matchrep(x1,:);

cfg                    = [];
cfg.channel            = 'all';
cfg.method             = 'mtmfft';
cfg.output             = 'pow';
cfg.taper              = 'dpss';
cfg.foi                = 0.5:0.1:45;
cfg.tapsmofrq          = 0.5;
cfg.trials             = matchest(:,2);
cfg.keeptrials         = 'yes';
cfg.pad                = Pad/data1.fsample;
cfg.polyremoval        = 1;
freqest                = ft_freqanalysis(cfg,data1);
freqest2               = freqest;
freqest2.powspctrm     = log(freqest2.powspctrm);
freqest2.freq          = log(freqest2.freq);

cfg                    = [];
cfg.channel            = 'all';
cfg.method             = 'mtmfft';
cfg.output             = 'pow';
cfg.taper              = 'dpss';
cfg.foi                = 0.5:0.1:45;
cfg.tapsmofrq          = 0.5;
cfg.trials             = matchrep(:,2);
cfg.keeptrials         = 'yes';
cfg.polyremoval        = 1;
cfg.pad                = Pad/data2.fsample;
freqrep                = ft_freqanalysis(cfg,data2);
freqrep2               = freqrep;
freqrep2.powspctrm     = log(freqrep2.powspctrm);
freqrep2.freq          = log(freqrep2.freq);

% multiplot
cfg               = [];
cfg.parameter     = 'powspctrm';
cfg.xlim          = log([0.5 45]);
cfg.ylim          = 'maxmin';
cfg.channel       = 'all';
cfg.baseline      = 'no';
cfg.baselinetype  = 'absolute';
cfg.trials        = 'all';
cfg.axes          = 'yes';
cfg.box           = 'no';
cfg.showlabels    = 'yes';
cfg.showoutline   = 'yes';
cfg.interactive   = 'yes';
cfg.linewidth     = 2;
cfg.layout        = [root '/SCRIPTS/Layouts_fieldtrip/NM306mag.lay'];
lay1              = ft_prepare_layout(cfg,freqest2);
lay1.label        = freqest2.label;
cfg.layout        = lay1;

fig                 = figure('position',[1 1 1920 1080]);
set(fig,'PaperPosition',[1 1 1280 1024])
set(fig,'PaperPositionMode','auto')

ft_multiplotER(cfg,freqest2,freqrep2)

print('-dpng',[root '/DATA/NEW/plots_' subject '\STATSPOW_ESTREP_RUN' num2str(RunArray(1),'%02i') ...
        '-' num2str(RunArray(2),'%02i') '_0.5-45Hz.png'])

ProcDataDir            = [root '/DATA/NEW/processed_' subject '/'];
save( [ProcDataDir 'FT_spectra/FREQ_matchestrep_' chantype '_RUN' num2str(RunArray(i),'%02i') '.mat'],'freqest','freqrep');
