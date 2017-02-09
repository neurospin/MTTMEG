function Temprod_estrep_compare_GDAVG(subjectArray,RunArray,chantype,Pad,freqband,freq4stat,tag)

% test set
subjectArray  = {'s12','s14'};
RunArray = {[2 4],[2 4]};
chantype = 'Mags';
tag      = 'Laptop';
freqband = [5 15];
Pad      = 12600;
freq4stat = 10;

% set root
root = SetPath(tag);

instruct_est = [];
instruct_rep = [];

for s = 1:length(subjectArray)
    
    % load data
    for i = 1:2
        ProcDataDir                = [root '/DATA/NEW/processed_' subjectArray{s} '/'];
        DataDir                    = [ProcDataDir 'FT_trials/BLOCKTRIALS_' chantype '_RUN' num2str(RunArray{s}(i),'%02i') '.mat'];
        eval(['data(' num2str(s) ',' num2str(i) ') = load(DataDir)']);
    end
    
    % load matching indexes
    ProcDataDir                    = [root '/DATA/NEW/processed_' subjectArray{s} '/'];
    DataDir                        = [ProcDataDir 'FT_trials/matchestrep_' chantype '_RUN' num2str(RunArray{s}(i),'%02i') '.mat'];
    eval(['match(' num2str(s) ',' num2str(i) ') = load(DataDir)']);
    
    % keep only matching data
    matchest = []; matchrep = [];
    [x2,y2] = find((isnan(match(s,i).matchest(:,1)) == 0) == 1);
    matchest = match(s,i).matchest(x2,:);
    [x1,y1] = find((isnan(match(s,i).matchrep(:,1)) == 0) == 1);
    matchrep = match(s,i).matchrep(x1,:);
    
    cfg                    = [];
    cfg.channel            = 'all';
    cfg.method             = 'mtmfft';
    cfg.output             = 'pow';
    cfg.taper              = 'dpss';
    cfg.foi                = freqband(1):0.1:freqband(2);
    cfg.tapsmofrq          = 1;
    cfg.trials             = matchest(:,2);
    cfg.keeptrials         = 'no';
    cfg.pad                = Pad/data(s,1).fsample;
    freqest(s)             = ft_freqanalysis(cfg,data(s,1));
    
    cfg                    = [];
    cfg.channel            = 'all';
    cfg.method             = 'mtmfft';
    cfg.output             = 'pow';
    cfg.taper              = 'dpss';
    cfg.foi                = freqband(1):0.1:freqband(2);
    cfg.tapsmofrq          = 1;
    cfg.trials             = matchrep(:,2);
    cfg.keeptrials         = 'no';
    cfg.pad                = Pad/data(s,2).fsample;
    freqrep(s)             = ft_freqanalysis(cfg,data(s,2));
    
    instruct_est           = [instruct_est ',freqest(1,' num2str(s) ')'];
    instruct_rep           = [instruct_rep ',freqrep(1,' num2str(s) ')'];    
end

% frequency grand average
cfg.keepindividual = 'yes';
cfg.foilim         = 'all';
cfg.toilim         = 'all';
cfg.channel        = 'all';
eval(['freq_est = ft_freqgrandaverage(cfg' instruct_est ');'])
eval(['freq_rep = ft_freqgrandaverage(cfg' instruct_rep ');'])
    

% multiplot
cfg               = [];
cfg.parameter     = 'powspctrm';
cfg.xlim          = [5 15];
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
lay1              = ft_prepare_layout(cfg,freqest);
lay1.label        = freqest.label;
cfg.layout        = lay1;

fig                 = figure('position',[1 1 1920 1080]);
set(fig,'PaperPosition',[1 1 1280 1024])
set(fig,'PaperPositionMode','auto')

ft_multiplotER(cfg,freqest,freqrep)

print('-dpng',[root '/DATA/NEW/plots_' subject '\STATSPOW_ESTREP_RUN' num2str(RunArray(1),'%02i') ...
    '-' num2str(RunArray(2),'%02i') '_' num2str(freqband(1)) '_' num2str(freqband(2)) 'Hz.png'])

% get neighbourgs for statistical testing
cfg               = [];
cfg.method        = 'distance';
% cfg.method        = 'template';
% cfg.layout        = 'C:\FIELDTRIP\fieldtrip-20111020\template\layout\NM306mag.lay';
% cfg.grad          = freqest.grad;
% lay2              = ft_prepare_layout(cfg,freqest);
% cfg.layout        = lay2;
neighbours        = ft_prepare_neighbours(cfg,freqest);

% test based on fieldtrip tutorial
cfg = [];
cfg.channel          = 'all';
cfg.latency          = 'all';
cfg.frequency        = [freq4stat freq4stat];
cfg.method           = 'montecarlo';
cfg.statistic        = 'indepsamplesT';
cfg.correctm         = 'cluster';
cfg.clusteralpha     = 0.05;
cfg.clusterstatistic = 'maxsum';
cfg.minnbchan        = 2;
cfg.tail             = 0;
cfg.clustertail      = 0;
cfg.alpha            = 0.05;
cfg.numrandomization = 500;
cfg.neighbours       = neighbours;

design = zeros(1,size(freqest.powspctrm,1) + size(freqrep.powspctrm,1));
design(1,1:size(freqest.powspctrm,1)) = 1;
design(1,(size(freqrep.powspctrm,1)+1):(size(freqest.powspctrm,1)+size(freqrep.powspctrm,1))) = 2;

cfg.design           = design;
cfg.ivar             = 1;

[stat] = ft_freqstatistics(cfg,freqest,freqrep);

% select frequency band
fbegin              = find(freqest.freq >= freq4stat);
fend                = find(freqest.freq <= freq4stat);
fband               = fbegin(1):fend(end);

M                   = mean(mean(freqest.powspctrm(:,:,fband) - freqrep.powspctrm(:,:,fband)));
S                   = std(freqest.powspctrm(:,:,fband) - freqrep.powspctrm(:,:,fband));
stat.zdiff          = (((mean(freqest.powspctrm(:,:,fband) - freqrep.powspctrm(:,:,fband))) - ones(1,102)*M)./S)';

cfg = [];
cfg.alpha                     = 0.05;
cfg.zparam                    = 'stat';
cfg.zlim                      = 'maxabs';
cfg.colorbar                  = 'yes';
cfg.layout                    = lay1;
ft_clusterplot(cfg, stat);

%% save data %%
print('-dpng',[root '/DATA/NEW/plots_' subject '\STATSPOW_TMAP_ESTREP_RUN' num2str(RunArray(1),'%02i') ...
    '-' num2str(RunArray(2),'%02i') '_' num2str(freqband(1)) '_' num2str(freqband(2)) 'Hz.png'])

cfg = [];
cfg.alpha                     = 0.05;
cfg.zparam                    = 'zdiff';
cfg.zlim                      = 'maxabs';
cfg.colorbar                  = 'yes';
cfg.layout                    = lay1;
ft_clusterplot(cfg, stat);

%% save data %%
print('-dpng',[root '/DATA/NEW/plots_' subject '\STATSPOW_ZMAP_ESTREP_RUN' num2str(RunArray(1),'%02i') ...
    '-' num2str(RunArray(2),'%02i') '_' num2str(freqband(1)) '_' num2str(freqband(2)) 'Hz.png'])

