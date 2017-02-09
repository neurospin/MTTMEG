function Temprod_estrep_compare(subject,RunArray,chantype,tag)

% % test set
% subject  = 's14';
% RunArray = [2 4];
% chantype = 'Mags';
% tag      = 'Laptop';
% freqband = [5 15];
% Pad      = 12600;

% set root
root = SetPath(tag);

% load data
ProcDataDir                = [root '/DATA/NEW/processed_' subject '/'];
DataDir                    = [ProcDataDir 'FT_spectra/FREQ_matchestrep_' chantype '_RUN' num2str(RunArray(2),'%02i') '.mat'];
load(DataDir)

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
lay1.label                    = freqest.label;

for i = 1:45
    
    % test based on fieldtrip tutorial
    cfg = [];
    cfg.channel          = 'all';
    cfg.latency          = 'all';
    cfg.frequency        = [i i];
    cfg.method           = 'montecarlo';
    cfg.statistic        = 'indepsamplesT';
    cfg.correctm         = 'cluster';
    cfg.clusteralpha     = 0.05;
    cfg.clusterstatistic = 'maxsum';
    cfg.minnbchan        = 2;
    cfg.tail             = 0;
    cfg.clustertail      = 0;
    cfg.alpha            = 0.025;
    cfg.numrandomization = 500;
    cfg.neighbours       = neighbours;
    
    design = zeros(1,size(freqest.powspctrm,1) + size(freqrep.powspctrm,1));
    design(1,1:size(freqest.powspctrm,1)) = 1;
    design(1,(size(freqrep.powspctrm,1)+1):(size(freqest.powspctrm,1)+size(freqrep.powspctrm,1))) = 2;
    
    cfg.design           = design;
    cfg.ivar  = 1;
    
    [stat] = ft_freqstatistics(cfg,freqest,freqrep);
    STATS{i} = stat;
    
    cfg = [];
    cfg.alpha                     = 0.05;
    cfg.highlightseries           = {'on','on','on','on','on'};
    cfg.highlightsymbolseries     = ['o','o','o','o','o'];
    cfg.highlightsizeseries       = [10 10 10 10 10 10];
    cfg.highlightcolorpos         = [0 0 0];
    cfg.highlightcolorneg         = [1 1 1];
    cfg.style                     = 'straight';
    
    cfg.zparam                    = 'stat';
    cfg.zlim                      = 'maxabs';
    cfg.colorbar                  = 'yes';
    cfg.layout                    = lay1;
    cfg.comment                   = [num2str(i) 'Hz'];
    
    if sum(stat.mask) ~= 0
        
        ft_clusterplot(cfg, stat);
        
        %% save data %%
        print('-dpng',[root '/DATA/NEW/plots_' subject '\STATSPOW_TMAP_ESTREP_RUN' num2str(RunArray(1),'%02i') ...
            '-' num2str(RunArray(2),'%02i') '_' num2str(i) 'Hz.png'])
    
        
    end
    
end

fig1 = figure('position',[1 1 1920 1080]);
set(fig1,'PaperPosition',[1 1 1900 1080])
set(fig1,'PaperPositionmode','auto')

for i = 1:45
    mysubplot(5,9,i)
 
    if isfield(STATS{i},'posclusterslabelmat') == 1
        [x,y] = find(STATS{i}.posclusterslabelmat ~= 0);
    end
    x = [];
    
    cfg                 = [];
    cfg.colormap        = 'jet';
    cfg.colorbar        = 'no';
    cfg.interplimits    = 'head';
    cfg.gridscale       = 67;
    cfg.maplimits       = [-10 10];
    cfg.style           = 'straight';
    cfg.contournum      = 6;
    cfg.shading         = 'flat';
    cfg.interpolation   = 'v4';
    cfg.headcolor       = [0,0,0];
    cfg.hlinewidth      = 2;
    cfg.contcolor       = [0 0 0];
    cfg.emarker         = '.';
    cfg.ecolor          = [0 0 0];
    cfg.emarkersize     = 10;
    cfg.efontsize       = 8;
    cfg.comment         = ['positive clusters: ' num2str(i) ' Hz'];
    cfg.commentpos      = 'leftbottom';
    cfg.fontsize        = 8;
    if isempty(x) == 0
        cfg.electrodes      = 'highlights';    
        cfg.highlight       = x;
    else
        cfg.electrodes      = 'off';    
        cfg.highlight       = 'off';
    end
    cfg.hlmarker        = 'o';
    cfg.hlcolor         = [0 0 0];
    cfg.hlmarkersize    = 5;
    cfg.hllinewidth     = 5;
    cfg.layout          = [root '/SCRIPTS/Layouts_fieldtrip/NM306mag.lay'];
    lay                 = ft_prepare_layout(cfg,stat);
    lay.label           = stat.label;
    cfg.layout          = lay;
    
    topoplot(cfg,STATS{i}.stat)

end
    
print('-dpng',[root '/DATA/NEW/plots_' subject '\STATSPOW_TMAP_ESTREP_RUN' num2str(RunArray(1),'%02i') ...
    '-' num2str(RunArray(2),'%02i') '_ALLFREQ.png'])
    
fig1 = figure('position',[1 1 1920 1080]);
set(fig1,'PaperPosition',[1 1 1900 1080])
set(fig1,'PaperPositionmode','auto')

for i = 1:45
    mysubplot(5,9,i)
 
    if isfield(STATS{i},'negclusterslabelmat') == 1
        [x,y] = find(STATS{i}.posclusterslabelmat ~= 0);
    end
    x = [];
    
    cfg                 = [];
    cfg.colormap        = 'jet';
    cfg.colorbar        = 'no';
    cfg.interplimits    = 'head';
    cfg.gridscale       = 67;
    cfg.maplimits       = [-10 10];
    cfg.style           = 'straight';
    cfg.contournum      = 6;
    cfg.shading         = 'flat';
    cfg.interpolation   = 'v4';
    cfg.headcolor       = [0,0,0];
    cfg.hlinewidth      = 2;
    cfg.contcolor       = [0 0 0];
    cfg.emarker         = '.';
    cfg.ecolor          = [0 0 0];
    cfg.emarkersize     = 10;
    cfg.efontsize       = 8;
    cfg.comment         = ['negative clusters: ' num2str(i) ' Hz'];
    cfg.commentpos      = 'leftbottom';
    cfg.fontsize        = 8;
    if isempty(x) == 0
        cfg.electrodes      = 'highlights';    
        cfg.highlight       = x;
    else
        cfg.electrodes      = 'off';    
        cfg.highlight       = 'off';
    end
    cfg.hlmarker        = 'o';
    cfg.hlcolor         = [0 0 0];
    cfg.hlmarkersize    = 5;
    cfg.hllinewidth     = 5;
    cfg.layout          = [root '/SCRIPTS/Layouts_fieldtrip/NM306mag.lay'];
    lay                 = ft_prepare_layout(cfg,stat);
    lay.label           = stat.label;
    cfg.layout          = lay;
    
    topoplot(cfg,STATS{i}.stat)

end
    
print('-dpng',[root '/DATA/NEW/plots_' subject '\STATSPOW_TMAP_ESTREP_RUN' num2str(RunArray(1),'%02i') ...
    '-' num2str(RunArray(2),'%02i') '_ALLFREQ.png'])    

