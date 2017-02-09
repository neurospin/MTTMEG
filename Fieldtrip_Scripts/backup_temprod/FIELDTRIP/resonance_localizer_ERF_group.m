clear all
close all

niparray = {'cb100118','nr110115','pe110338','ns110383','cd100449'}; 
chantype = {'Mags','Grads1','Grads2'};

for i = 1:length(niparray)
    load(['C:\RESONANCE_MEG\DATA\' niparray{i} '\freq\STATS']);
    ERF_FACE{i,1} = ERF_face{1,1};
    ERF_FACE{i,2} = ERF_face{1,2};
    ERF_FACE{i,3} = ERF_face{1,3};
    ERF_PLACE{i,1} = ERF_place{1,1};
    ERF_PLACE{i,2} = ERF_place{1,2};
    ERF_PLACE{i,3} = ERF_place{1,3};
    ERF_OBJECT{i,1} = ERF_object{1,1};
    ERF_OBJECT{i,2} = ERF_object{1,2};
    ERF_OBJECT{i,3} = ERF_object{1,3};
end

% grandaverage step
cfg                 = [];
cfg.channel         = 'all';
cfg.latency         = 'all';
cfg.keepindividual  = 'yes';

for i = 1:3
    FACE_avg{i}   = ft_timelockgrandaverage(cfg,ERF_FACE{1,i},ERF_FACE{2,i},ERF_FACE{3,i},ERF_FACE{4,i},ERF_FACE{5,i});
    PLACE_avg{i}  = ft_timelockgrandaverage(cfg,ERF_PLACE{1,i},ERF_PLACE{2,i},ERF_PLACE{3,i},ERF_PLACE{4,i},ERF_PLACE{5,i});
    OBJECT_avg{i} = ft_timelockgrandaverage(cfg,ERF_OBJECT{1,i},ERF_OBJECT{2,i},ERF_OBJECT{3,i},ERF_OBJECT{4,i},ERF_OBJECT{5,i});
end

% stats
for i = 1:3
    
    fig1 = figure('position',[1 1 1000 1000]);
    set(fig1,'PaperPosition',[1 1 1000 1000])
    set(fig1,'PaperPositionmode','auto')
    
    % get neighbourgs for statistical testing
    load('C:\TEMPROD\SCRIPTS\Matlab_pipeline\tools_tmp\pipeline_tmp\neighbours.mat')
    for a = 1:104
        neighbours{1,a}.label = ['MEG' neighbours{1,a}.label];
        for b = 1:length(neighbours{1,a}.neighblabel)
            neighbours{1,a}.neighblabel{b} = ['MEG' neighbours{1,a}.neighblabel{b}];
        end
    end
    
    % prepare layout
    cfg                           = [];
    cfg.layout                    = 'C:\TEMPROD\SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
    lay1                          = ft_prepare_layout(cfg,ERF_face{1,1});
    lay1.label                    = ERF_face{1,1}.label;
    
    % F test
    cfg = [];
    cfg.channel          = 'all';
    cfg.latency          = 'all';
    cfg.method           = 'montecarlo';
    cfg.statistic        = 'indepsamplesF';
    cfg.correctm         = 'cluster';
    cfg.clusteralpha     = 0.01;
    cfg.clusterstatistic = 'maxsum';
    cfg.minnbchan        = 2;
    cfg.tail             = 1;
    % cfg.computecritval   ='yes';
    cfg.clustertail      = 1;
    cfg.alpha            = 0.005;
    cfg.numrandomization = 500;
    cfg.neighbours       = neighbours;
    
    cfg.design = [1 2 3 4 5 1 2 3 4 5 1 2 3 4 5];
    cfg.ivar  = 1;
    
    stat{i} = ft_timelockstatistics(cfg,FACE_avg{1,i},PLACE_avg{1,i},OBJECT_avg{1,i});
    
    % Make a vector of all p-values associated with the clusters from ft_timelockstatistics.
    if isfield(stat{1,i}, 'posclusters')
        pos_cluster_pvals = [stat{1,i}.posclusters(:).prob];
        % Then, find which clusters are significant, outputting their indices as held in stat.posclusters
        pos_signif_clust = find(pos_cluster_pvals < stat{1,i}.cfg.alpha);
        % (stat.cfg.alpha is the alpha level we specified earlier for cluster comparisons; In this case, 0.025)
        % make a boolean matrix of which (channel,time)-pairs are part of a significant cluster
        pos = ismember(stat{1,i}.posclusterslabelmat, pos_signif_clust);
        
        for k = 1:size(stat{1,i}.time,2)
            [x,y] = find(pos(:,k) == 1);
            if isempty(x) == 0
                cfg = [];
                cfg.maplimits = [-5 5];
                cfg.highlight = x';
                cfg.style = 'straight';
                cfg.electrodes = 'highlights';
                cfg.hlmarkersize = 4;
                cfg.layout = 'C:\TEMPROD\SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
                cfg.comment    = (num2str(stat{1,i}.time(k) - 0.2));
                mysubplot(12,12,k)
                topoplot(cfg, stat{1,i}.stat(:,k))

            else
                cfg = [];
                cfg.maplimits = [-5 5];
                cfg.style = 'straight';
                cfg.electrodes = 'off';
                cfg.hlmarkersize = 4;
                cfg.layout = 'C:\TEMPROD\SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
                cfg.comment    = (num2str(stat{1,i}.time(k) - 0.2));
                mysubplot(12,12,k)
                topoplot(cfg, stat{1,i}.stat(:,k))
                
            end
        end
    end
    print('-dpng',['C:\RESONANCE_MEG\DATA\across_sub\' chantype{i} 'Ftest_ERF.png']);
end




