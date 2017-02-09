function Temprod_estrep_compare_v3(subject,RunArray,chantype,freq,namecond,scales,tag)

% % test set
% subject  = 's14';
% RunArray = {[2 4],[5 7]};
% chantype = 'Grads1';
% tag      = 'Laptop';
% freq     = [10 10];
% Pad      = 12600;

[Grads1,Grads2,Mags] = grads_for_layouts(tag);

% set root
root = SetPath(tag);

% load data
ProcDataDir                = [root '/DATA/NEW/processed_' subject '/'];
DataDir                    = [ProcDataDir 'FT_spectra/FREQ_matchestrep_' chantype '_RUN' num2str(RunArray{1,1}(2),'%02i') '.mat'];
load(DataDir)

if length(RunArray) > 1
    ProcDataDir                = [root '/DATA/NEW/processed_' subject '/'];
    DataDir                    = [ProcDataDir 'FT_spectra/FREQ_matchestrep_' chantype '_RUN' num2str(RunArray{1,2}(2),'%02i') '.mat'];
    tmp = load(DataDir);
    freqest.powspctrm = cat(1,freqest.powspctrm,tmp.freqest.powspctrm);
    freqrep.powspctrm = cat(1,freqrep.powspctrm,tmp.freqrep.powspctrm);    
end



% get neighbourgs for statistical testing
load('C:\TEMPROD\SCRIPTS\Matlab_pipeline\tools_tmp\pipeline_tmp\neighbours.mat')
for a = 1:104
    neighbours{1,a}.label = ['MEG' neighbours{1,a}.label];
    for b = 1:length(neighbours{1,a}.neighblabel)
        neighbours{1,a}.neighblabel{b} = ['MEG' neighbours{1,a}.neighblabel{b}];
    end
end

cfg                           = [];
cfg.layout                    = [root '/SCRIPTS/Layouts_fieldtrip/NM306mag.lay'];
lay1                          = ft_prepare_layout(cfg,freqest);
lay1.label                    = Mags';
freqest.label                 = Mags';
freqrep.label                 = Mags';

% test based on fieldtrip tutorial
cfg = [];
cfg.channel          = 'all';
cfg.latency          = 'all';
cfg.frequency        = [freq freq];
cfg.method           = 'montecarlo';
cfg.statistic        = 'depsamplesT';
cfg.correctm         = 'cluster';
cfg.clusteralpha     = 0.05;
cfg.clusterstatistic = 'maxsum';
cfg.minnbchan        = 4;
cfg.tail             = 0;
cfg.clustertail      = 0;
cfg.alpha            = 0.025;
cfg.numrandomization = 500;
cfg.neighbours       = neighbours;

design = zeros(2,size(freqest.powspctrm,1) + size(freqrep.powspctrm,1));
design(1,1:size(freqest.powspctrm,1)) = 1;
design(1,(size(freqrep.powspctrm,1)+1):(size(freqest.powspctrm,1)+size(freqrep.powspctrm,1))) = 2;
design(2,1:size(freqest.powspctrm,1)) = 1:size(freqest.powspctrm,1);
design(2,(size(freqest.powspctrm,1)+1):((size(freqest.powspctrm,1)) + size(freqrep.powspctrm,1))) = 1:size(freqrep.powspctrm,1);

cfg.design           = design;
cfg.ivar  = 1;
cfg.uvar  = 2;

[stat] = ft_freqstatistics(cfg,freqest,freqrep);
STATS  = stat;

% compute avrage diff powspctrm

fbegin              = find(freqest.freq >= freq(1));
fend                = find(freqest.freq <= freq(1));
fband               = fbegin(1):fend(end);
stat.diff = (squeeze(mean(freqest.powspctrm(:,:,fband),1)) - squeeze(mean(freqrep.powspctrm(:,:,fband),1)))';

cfg = [];
cfg.alpha                     = 0.05;
cfg.highlightseries           = {'on','on','on','on','on'};
cfg.highlightsymbolseries     = ['.','.','.','.','.'];
cfg.highlightsizeseries       = [25 25 25 25 25 25];
cfg.highlightcolorpos         = [0 0 0];
cfg.highlightcolorneg         = [1 1 1];
cfg.style                     = 'straight';

cfg.zparam                    = 'diff';
if strcmp(chantype,'Mags') == 1
    cfg.zlim                      = [scales{1,1}(1) scales{1,1}(2)];
else
    cfg.zlim                      = [scales{1,2}(1) scales{1,2}(2)];
end
cfg.colorbar                  = 'yes';
cfg.layout                    = lay1;
cfg.comment                   = [num2str(freq(1)) 'Hz'];

if sum(stat.mask) ~= 0
    
    ft_clusterplot(cfg, stat);
    
    %% save data %%
    print('-dpng',['C:\TEMPROD\DATA\NEW\FIG_THESIS\estrep\STATSPOW_TMAP_ESTREP_RUN_' chantype '_' subject '_allrun_' namecond 'Hz.png'])
    
    
end
