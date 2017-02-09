function stats = temprod_freqstats_half_clusterstats(freqband,design,corrm,Title,varargin)

fig                 = figure('position',[1 1 1280 1024]);
set(fig,'PaperPosition',[1 1 1280 1024])
set(fig,'PaperPositionMode','auto')

disp('**************************************************************')
disp(varargin)
disp('**************************************************************')

for j = 1:3
    % compute statistics
    cfg.channel          = 'all';
    cfg.latency          = 'all';
    cfg.frequency        = freqband;
    cfg.avgoverchan      = 'no';
    cfg.avgovertime      = 'yes';
    cfg.avgoverfreq      = 'yes';
    cfg.parameter        = 'powspctrm';
    cfg.method           = 'montecarlo';
    cfg.design           = design;
    cfg.ivar             = size(design,1) - 1;
    cfg.uvar             = size(design,1);
    cfg.numrandomization = 'all';
    cfg.correctm         = corrm;
    cfg.alpha            = 0.05;
    cfg.tail             = 0;
    cfg.correcttail      = 'no';
    %   cfg.wvar           = number or list with indices, within-cell variable(s)
    %   cfg.cvar           = number or list with indices, control variable(s)
    cfg.feedback         = 'text';
    cfg.randomseed       = 'yes';
    cfg.statistic        = 'depsamplesT';
    
    % cluster definition
    
    % The configuration can contain
    cfg.method        = 'distance';
    cfg.neighbourdist = 2;
%     lay                   = ft_prepare_layout(cfg,freq);
%     lay.label             = freq.label;
%     cfg.layout            = lay;
    cfg.layout            = '/neurospin/meg/meg_tmp/ResonanceMeg_Baptiste_2009/SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
    cfg.grad          = structure with MEG gradiometer positions
    cfg.elecfile      = filename containing EEG electrode positions
    cfg.gradfile      = filename containing MEG gradiometer positions
    cfg.feedback      = 'yes' or 'no' (default = 'no')
    
    neighbours = ft_prepare_neighbours(cfg, data)
    
    % cluster definition parameters
    cfg.clusterstatistic = 'maxsum';
    cfg.clusterthreshold = 'parametric';
    cfg.clusteralpha = 0.05
    %  cfg.clustercritval   = for parametric thresholding (default is determined by the statfun)
    cfg.clustertail      = 0 (default = 0);
    cfg.neighbours       =
    
    
    
    tmp = 'stats = ft_freqstatistics(cfg,';
    for k = 1:size(varargin,2)
        if k < size(varargin,2)
            tmp = [tmp ' varargin{1,' num2str(k) '}{1,j} ,'];
        elseif k == size(varargin,2)
            tmp = [tmp ' varargin{1,' num2str(k) '}{1,j})'];
        end
    end
    eval(tmp)
    
    disp('**************************************************************')
    disp(varargin{1,1}{1,1})
    disp('**************************************************************')
    
    % plot T-topographies
    
    [Label2,Label3,Label1]     = grads_for_layouts;
    cfg.xparam            = 'freq';
    cfg.zparam            = 'powspctrm';
    cfg.zlim              = 'maxabs';
    cfg.baseline          = 'no';
    cfg.trials            = 'all';
    cfg.colormap          = jet;
    cfg.marker            = 'off';
    cfg.markersymbol      = 'none';
    cfg.markercolor       = [0 0 0];
    cfg.markersize        = 2;
    cfg.markerfontsize    = 8;
    cfg.colorbar          = 'yes';
    cfg.interplimits      = 'head';
    cfg.interpolation     = 'v4';
    cfg.style             = 'straight';
    cfg.gridscale         = 67;
    cfg.shading           = 'flat';
    cfg.interactive       = 'no';
    cfg.layout            = '/neurospin/meg/meg_tmp/ResonanceMeg_Baptiste_2009/SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
    lay                   = ft_prepare_layout(cfg,varargin{1,1}{1,1});
    eval(['lay.label             = Label' num2str(j)]);
    cfg.layout            = lay;
    
    [x,y] = find(stats.mask' == 1);
    
    if length(y) > 0
        cfg.highlight         = y';
        cfg.electrodes        = 'highlights';
    end
    
    subplot(3,3,j)
    topoplot(cfg,stats.stat)
    
end

print('-dpng',['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/across_subjects_plots/'...
    Title '_' num2str(freqband(1)) '-' num2str(freqband(2))]);
