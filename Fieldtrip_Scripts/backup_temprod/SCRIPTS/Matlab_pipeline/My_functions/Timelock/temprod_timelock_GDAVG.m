function temprod_timelock_GDAVG(subarray,runarray,condname,tag)

% set root
root                     = SetPath(tag);
[label2, label3, label1] = grads_for_layouts(tag);
chantype  = {'Mags';'Gradslong';'Gradslat'};
[IND1,IND2,IND3,IND4,IND5,CHAN1,CHAN2,CHAN3,CHAN4,CHAN5] = clusteranat(tag);
clustname = {'Front';'Back';'Vertex';'Left';'right'};
limchan = {[-8e-14 8e-14];[-5e-14 5e-14]*50;[-5e-14 5e-14]*50};

for k = 1:3
    
    clear GDAVG_t0 GDAVG_te strforeval_t0 strforeval_t0
    
    cfg                     = [];
    cfg.channel             = 'all';
    cfg.latency             = 'all';
    cfg.keepindividual      = 'no';
    cfg.normalizevar        = 'N-1';
    strforeval_GDAVG_t0     = 'GDAVG_t0 = ft_timelockgrandaverage(cfg';
    strforeval_GDAVG_te     = 'GDAVG_te = ft_timelockgrandaverage(cfg';
    
    for i = 1:length(subarray)
        strforeval_t0       = 'ft_timelockgrandaverage(cfg';
        strforeval_te       = 'ft_timelockgrandaverage(cfg';
        
        for j = 1:length([runarray{i}])
            clear data
            datat0locked{j} = load([root '\DATA\NEW\processed_' subarray{i} '\FT_ERFs\' chantype{k} 't0Locked_run' num2str(runarray{i}(j)) '.mat']);
            datatelocked{j} = load([root '\DATA\NEW\processed_' subarray{i} '\FT_ERFs\' chantype{k} 'tendLocked_run' num2str(runarray{i}(j)) '.mat']);
            strforeval_t0   = [strforeval_t0 ', datat0locked{' num2str(j) '}'];
            strforeval_te   = [strforeval_te ', datatelocked{' num2str(j) '}'];
            
        end
        eval(['sublvlGDAVG' num2str(i) '_t0 = ' strforeval_t0 ')']);
        eval(['sublvlGDAVG' num2str(i) '_te = ' strforeval_te ')']);
        strforeval_GDAVG_t0 = [strforeval_GDAVG_t0 ',sublvlGDAVG' num2str(i) '_t0'];
        strforeval_GDAVG_te = [strforeval_GDAVG_te ',sublvlGDAVG' num2str(i) '_te'];
        
    end
    
    eval([strforeval_GDAVG_t0 ')']);
    eval([strforeval_GDAVG_te ')']);
    
    % plot GrandAverage multiplot
    
    % set figure parameters
    fig  = figure('position',[1 1 1200 1000]);
    set(fig,'PaperPosition',[1 1 1200 1000])
    set(fig,'PaperPositionMode','auto')
    % set(fig,'visible',visibility)
    
    cfg                    = [];
    cfg.axes               = 'no';
    cfg.xparam             = 'time';
    cfg.zparam             = 'avg';
    cfg.xlim               = [0 1.5];
    cfg.ylim               = 'maxmin';
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
    cfg.axes               = 'yes';
    cfg.colorbar           = 'yes';
    cfg.showoutline        = 'no';
    cfg.interplimits       = 'head';
    cfg.interpolation      = 'v4';
    cfg.style              = 'straight';
    cfg.gridscale          = 67;
    cfg.shading            = 'flat';
    cfg.interactive        = 'yes';
    cfg.comment            = [chantype{k} 't0locked'];
    cfg.layout             = [root '/SCRIPTS/Layouts_fieldtrip/NM306mag.lay'];
    lay                    = ft_prepare_layout(cfg,GDAVG_t0);
    eval(['lay.label       = (label' num2str(k) ')'';']);
    cfg.layout             = lay;
    ft_multiplotER(cfg,GDAVG_t0)
    
    print('-dpng',[root '/DATA/NEW/across_subjects_plots/MULTIs_ERFt0locked_' chantype{k} '_' condname '.png']);
    
    % set figure parameters
    fig  = figure('position',[1 1 1200 1000]);
    set(fig,'PaperPosition',[1 1 1200 1000])
    set(fig,'PaperPositionMode','auto')
    % set(fig,'visible',visibility)
    
    cfg.comment            = [chantype{k} 'telocked'];
    ft_multiplotER(cfg,GDAVG_te)
    
    print('-dpng',[root '/DATA/NEW/across_subjects_plots/MULTIs_ERFtendlocked_' chantype{k} '_' condname '.png']);
    
    % plot single plot on rough anatomical clusters
    
    % set figure parameters
    fig  = figure('position',[1 1 1900 600]);
    set(fig,'PaperPosition',[1 1 1900 600])
    set(fig,'PaperPositionMode','auto')
    % set(fig,'visible',visibility)
    
    cfg               = [];
    cfg.parameter     = 'avg';
    cfg.ylim          = limchan{k};    
    cfg.baseline      = 'no';
    cfg.baselinetype  = 'absolute';
    cfg.trials        = 'all';
    cfg.interactive   = 'yes';
    cfg.linewidth     = 2;
    for cl = 1:5
        eval(['cfg.channel = GDAVG_t0.label(IND' num2str(cl) '(' num2str(k) '));'])
        subplot(2,3,cl)
        ft_singleplotER(cfg,GDAVG_t0)
        xlabel(clustname{cl});
        set(gca,'xtick',0:0.5:2,'xticklabel',-0.5:0.5:1.5)
    end
    
    print('-dpng',[root '/DATA/NEW/across_subjects_plots/SINGLEs_ERFt0locked_' chantype{k} '_' condname '.png']);
    
    % set figure parameters
    fig  = figure('position',[1 1 1900 600]);
    set(fig,'PaperPosition',[1 1 1900 600])
    set(fig,'PaperPositionMode','auto')
    % set(fig,'visible',visibility)
    
    cfg               = [];
    cfg.ylim          = limchan{k};   
    cfg.parameter     = 'avg';
    cfg.baseline      = 'no';
    cfg.baselinetype  = 'absolute';
    cfg.trials        = 'all';
    cfg.interactive   = 'yes';
    cfg.linewidth     = 2;    
    for cl = 1:5
        eval(['cfg.channel = GDAVG_t0.label(IND' num2str(cl) '(' num2str(k) '));'])
        subplot(2,3,cl)
        ft_singleplotER(cfg,GDAVG_te)
        xlabel(clustname{cl});        
        set(gca,'xtick',0:0.5:2,'xticklabel',-2:0.5:0)        
    end
    
    print('-dpng',[root '/DATA/NEW/across_subjects_plots/SINGLEs_ERFtendlocked_' chantype{k} '_' condname '.png']);
    
    % plot GrandAverage topoplot
    
    clear cfg
    Sm_t0 = mean(std(GDAVG_t0.avg'));
    Mm_t0 = mean(mean(GDAVG_t0.avg'));
    Sm_te = mean(std(GDAVG_te.avg'));
    Mm_te = mean(mean(GDAVG_te.avg'));
    
    % set figure parameters
    fig  = figure('position',[1 1 1200 1000]);
    set(fig,'PaperPosition',[1 1 1200 1000])
    set(fig,'PaperPositionMode','auto')
    % set(fig,'visible',visibility)
    
    for X = 1:20
        cfg                    = [];
        cfg.axes               = 'no';
        cfg.xparam             = 'time';
        cfg.zparam             = 'avg';
        cfg.xlim               = [(0.1*X -0.05) (0.1*X +0.05)];
        cfg.zlim               = [(0-4*Sm_t0) (0+4*Sm_t0)];
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
        cfg.colorbar           = 'no';
        cfg.interplimits       = 'head';
        cfg.interpolation      = 'v4';
        cfg.style              = 'straight';
        cfg.gridscale          = 67;
        cfg.shading            = 'flat';
        cfg.interactive        = 'yes';
        cfg.comment            = [chantype{k} ' ' num2str(0.1*X*1000 -500) 'ms' ];
        cfg.layout             = [root '/SCRIPTS/Layouts_fieldtrip/NM306mag.lay'];
        lay                    = ft_prepare_layout(cfg,GDAVG_t0);
        eval(['lay.label       = (label' num2str(k) ')'';']);
        cfg.layout             = lay;
        subplot(4,5,X)
        ft_topoplotER(cfg,GDAVG_t0)
    end
    
    print('-dpng',[root '/DATA/NEW/across_subjects_plots/TOPOs_ERFt0locked_' chantype{k} '_' condname '.png']);
    
    % set figure parameters
    fig  = figure('position',[1 1 1200 1000]);
    set(fig,'PaperPosition',[1 1 1200 1000])
    set(fig,'PaperPositionMode','auto')
    % set(fig,'visible',visibility)
    
    for X = 1:20
        cfg                    = [];
        cfg.axes               = 'no';
        cfg.xparam             = 'time';
        cfg.zparam             = 'avg';
        cfg.xlim               = [(0.1*X -0.05) (0.1*X +0.05)];
        cfg.zlim               = [(0-4*Sm_te) (0+4*Sm_te)];
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
        cfg.colorbar           = 'no';
        cfg.interplimits       = 'head';
        cfg.interpolation      = 'v4';
        cfg.style              = 'straight';
        cfg.gridscale          = 67;
        cfg.shading            = 'flat';
        cfg.interactive        = 'yes';
        cfg.comment            = [chantype{k} ' ' num2str(0.1*X*1000 -2000) 'ms' ];
        cfg.layout             = [root '/SCRIPTS/Layouts_fieldtrip/NM306mag.lay'];
        lay                    = ft_prepare_layout(cfg,GDAVG_te);
        eval(['lay.label       = (label' num2str(k) ')'';']);
        cfg.layout             = lay;
        subplot(4,5,X)
        ft_topoplotER(cfg,GDAVG_te)
    end
    
    print('-dpng',[root '/DATA/NEW/across_subjects_plots/TOPOs_ERFtendlocked_' chantype{k} '_' condname '.png']);
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%% Short and long %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for k = 1:3
    
    clear GDAVG_t0 GDAVG_te strforeval_t0 strforeval_t0
    
    cfg                     = [];
    cfg.channel             = 'all';
    cfg.latency             = 'all';
    cfg.keepindividual      = 'no';
    cfg.normalizevar        = 'N-1';
    strforeval_GDAVG_t0_short     = 'GDAVG_t0_short = ft_timelockgrandaverage(cfg';
    strforeval_GDAVG_te_short     = 'GDAVG_te_short = ft_timelockgrandaverage(cfg';
    strforeval_GDAVG_t0_long      = 'GDAVG_t0_long  = ft_timelockgrandaverage(cfg';
    strforeval_GDAVG_te_long      = 'GDAVG_te_long  = ft_timelockgrandaverage(cfg';
    
    for i = 1:length(subarray)
        strforeval_t0_short       = 'ft_timelockgrandaverage(cfg';
        strforeval_te_short       = 'ft_timelockgrandaverage(cfg';
        strforeval_t0_long        = 'ft_timelockgrandaverage(cfg';
        strforeval_te_long        = 'ft_timelockgrandaverage(cfg';
        
        for j = 1:length([runarray{i}])
            clear data
            datat0locked{j} = load([root '\DATA\NEW\processed_' subarray{i} '\FT_ERFs\' chantype{k} 't0Locked_S+L_run' num2str(runarray{i}(j)) '.mat']);
            datatelocked{j} = load([root '\DATA\NEW\processed_' subarray{i} '\FT_ERFs\' chantype{k} 'tendLocked_S+L_run' num2str(runarray{i}(j)) '.mat']);
            strforeval_t0_short   = [strforeval_t0_short ', datat0locked{' num2str(j) '}.t0locked_short'];
            strforeval_t0_long    = [strforeval_t0_long ', datat0locked{' num2str(j) '}.t0locked_long'];
            strforeval_te_short   = [strforeval_te_short ', datatelocked{' num2str(j) '}.tendlocked_short'];
            strforeval_te_long    = [strforeval_te_long ', datatelocked{' num2str(j) '}.tendlocked_long'];
            
        end
        eval(['sublvlGDAVG' num2str(i) '_t0_short = ' strforeval_t0_short ')']);
        eval(['sublvlGDAVG' num2str(i) '_te_short = ' strforeval_te_short ')']);
        eval(['sublvlGDAVG' num2str(i) '_t0_long  = ' strforeval_t0_long  ')']);
        eval(['sublvlGDAVG' num2str(i) '_te_long  = ' strforeval_te_long  ')']);
        strforeval_GDAVG_t0_short = [strforeval_GDAVG_t0_short ',sublvlGDAVG' num2str(i) '_t0_short'];
        strforeval_GDAVG_te_short = [strforeval_GDAVG_te_short ',sublvlGDAVG' num2str(i) '_te_short'];
        strforeval_GDAVG_t0_long  = [strforeval_GDAVG_t0_long  ',sublvlGDAVG' num2str(i) '_t0_long'];
        strforeval_GDAVG_te_long  = [strforeval_GDAVG_te_long  ',sublvlGDAVG' num2str(i) '_te_long'];
        
    end
    
    eval([strforeval_GDAVG_t0_short ')']);
    eval([strforeval_GDAVG_te_short ')']);
    eval([strforeval_GDAVG_t0_long ')']);
    eval([strforeval_GDAVG_te_long ')']);
    
    % plot GrandAverage multiplot
    
    % set figure parameters
    fig  = figure('position',[1 1 1200 1000]);
    set(fig,'PaperPosition',[1 1 1200 1000])
    set(fig,'PaperPositionMode','auto')
    % set(fig,'visible',visibility)
    
    cfg                    = [];
    cfg.axes               = 'no';
    cfg.xparam             = 'time';
    cfg.zparam             = 'avg';
    cfg.xlim               = [0 1.5];
    cfg.ylim               = 'maxmin';
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
    cfg.axes               = 'yes';
    cfg.colorbar           = 'yes';
    cfg.showoutline        = 'no';
    cfg.interplimits       = 'head';
    cfg.interpolation      = 'v4';
    cfg.style              = 'straight';
    cfg.gridscale          = 67;
    cfg.shading            = 'flat';
    cfg.interactive        = 'yes';
    cfg.comment            = [chantype{k} 't0locked'];
    cfg.layout             = [root '/SCRIPTS/Layouts_fieldtrip/NM306mag.lay'];
    lay                    = ft_prepare_layout(cfg,GDAVG_t0_short);
    eval(['lay.label       = (label' num2str(k) ')'';']);
    cfg.layout             = lay;
    ft_multiplotER(cfg,GDAVG_t0_short,GDAVG_t0_long)
    
    print('-dpng',[root '/DATA/NEW/across_subjects_plots/MULTIs_ERFt0locked_L+S_' chantype{k} '_' condname '.png']);
    
    % set figure parameters
    fig  = figure('position',[1 1 1200 1000]);
    set(fig,'PaperPosition',[1 1 1200 1000])
    set(fig,'PaperPositionMode','auto')
    % set(fig,'visible',visibility)
    
    cfg.comment            = [chantype{k} 'telocked'];
    ft_multiplotER(cfg,GDAVG_te_short,GDAVG_te_long)
    
    print('-dpng',[root '/DATA/NEW/across_subjects_plots/MULTIs_ERFtendlocked_L+S_' chantype{k} '_' condname '.png']);
    
    % set figure parameters
    fig  = figure('position',[1 1 1900 600]);
    set(fig,'PaperPosition',[1 1 1900 600])
    set(fig,'PaperPositionMode','auto')
    % set(fig,'visible',visibility)
    
    cfg               = [];
    cfg.parameter     = 'avg';
    cfg.ylim          = limchan{k};      
    cfg.baseline      = 'no';
    cfg.baselinetype  = 'absolute';
    cfg.trials        = 'all';
    cfg.interactive   = 'yes';
    cfg.linewidth     = 2;    
    for cl = 1:5
        eval(['cfg.channel = GDAVG_t0_short.label(IND' num2str(cl) '(' num2str(k) '));'])
        subplot(2,3,cl)
        ft_singleplotER(cfg,GDAVG_t0_short,GDAVG_t0_long)
        xlabel(clustname{cl});  
        set(gca,'xtick',0:0.5:2,'xticklabel',-0.5:0.5:1.5)        
    end
    
    print('-dpng',[root '/DATA/NEW/across_subjects_plots/SINGLEs_ERFt0locked_S+L_' chantype{k} '_' condname '.png']);
    
    % set figure parameters
    fig  = figure('position',[1 1 1900 600]);
    set(fig,'PaperPosition',[1 1 1900 600])
    set(fig,'PaperPositionMode','auto')
    % set(fig,'visible',visibility)
    
    cfg               = [];
    cfg.parameter     = 'avg';
    cfg.ylim          = limchan{k};     
    cfg.baseline      = 'no';
    cfg.baselinetype  = 'absolute';
    cfg.trials        = 'all';
    cfg.interactive   = 'yes';
    cfg.linewidth     = 2;    
    for cl = 1:5
        eval(['cfg.channel = GDAVG_te_short.label(IND' num2str(cl) '(' num2str(k) '));'])
        subplot(2,3,cl)
        ft_singleplotER(cfg,GDAVG_te_short,GDAVG_te_long)
        xlabel(clustname{cl});    
        set(gca,'xtick',0:0.5:2,'xticklabel',-2:0.5:0)        
    end
    
    print('-dpng',[root '/DATA/NEW/across_subjects_plots/SINGLEs_ERFtendlocked_S+L_' chantype{k} '_' condname '.png']);
    
end

