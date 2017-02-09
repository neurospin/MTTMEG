function resonance_localizer_ERF(nip,tag)

root = SetPath(tag);
[Grads1,Grads2,Mags]   = grads_for_layouts(tag);

chantype = {'Mags','Grads1','Grads2'};


for i = 1:3
    % face
    
    load(['C:\RESONANCE_MEG\DATA\' nip '\processed\localizer_face.mat'])
    
    clear cfg
    eval(['cfg.channel     = ' chantype{i} ]);
    cfg.trials             = 'all';
    cfg.covariance         = 'no';
    cfg.keeptrials         = 'no';
    cfg.removemean         = 'yes';
    cfg.vartrllength       = 2;
    ERF_face{i}            = ft_timelockanalysis(cfg,data);
    
    cfg.baseline           = [0 0.2];
    ERF_face{i}            = ft_timelockbaseline(cfg,ERF_face{i});
    
    tmp                    = ERF_face{i};
    
    save(['C:\RESONANCE_MEG\DATA\' nip '\processed\' chantype{i} 'localizer_face.mat'],'tmp');
    
    % place
    load(['C:\RESONANCE_MEG\DATA\' nip '\processed\localizer_place.mat'])
    
    clear cfg
    eval(['cfg.channel     = ' chantype{i} ]);
    cfg.trials             = 'all';
    cfg.covariance         = 'no';
    cfg.keeptrials         = 'no';
    cfg.removemean         = 'yes';
    cfg.vartrllength       = 2;
    ERF_place{i}           = ft_timelockanalysis(cfg,data);
    
    cfg.baseline           = [0 0.2];
    ERF_place{i}           = ft_timelockbaseline(cfg,ERF_place{i});
    
    tmp                    = ERF_place{i};
    
    save(['C:\RESONANCE_MEG\DATA\' nip '\processed\' chantype{i} 'localizer_place.mat'],'tmp');
    
    
    % object
    load(['C:\RESONANCE_MEG\DATA\' nip '\processed\localizer_object.mat'])
    
    clear cfg
    eval(['cfg.channel     = ' chantype{i} ]);
    cfg.trials             = 'all';
    cfg.covariance         = 'no';
    cfg.keeptrials         = 'no';
    cfg.removemean         = 'yes';
    cfg.vartrllength       = 2;
    ERF_object{i}          = ft_timelockanalysis(cfg,data);
    
    cfg.baseline           = [0 0.2];
    ERF_object{i}          = ft_timelockbaseline(cfg,ERF_object{i});
    
    tmp                    = ERF_object{i};
    
    save(['C:\RESONANCE_MEG\DATA\' nip '\processed\' chantype{i} 'localizer_object.mat'],'tmp');
    
end

% plot
for i = 1:3
    cfg                    = [];
    cfg.axes               = 'no';
    cfg.xparam             = 'time';
    cfg.zparam             = 'avg';
    cfg.xlim               = [0 0.7];
    cfg.ylim               = 'maxmin';
    eval(['cfg.channel     = ' chantype{i} ]);
    cfg.baseline           = 'no';
    cfg.baselinetype       = 'absolute';
    cfg.trials             = 'all';
    cfg.showlabels         = 'yes';
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
    cfg.layout             = [root '/SCRIPTS/Layouts_fieldtrip/NM306mag.lay'];
    lay                    = ft_prepare_layout(cfg,ERF_object{i});
    lay.label              = ERF_object{i}.label;
    cfg.layout             = lay;  
    
    scrsz = get(0,'ScreenSize');
    fig   = figure('position',scrsz);
    set(fig,'PaperPosition',scrsz)
    set(fig,'PaperPositionMode','auto')
    
    ft_multiplotER(cfg,ERF_face{1,i}, ERF_place{1,i}, ERF_object{1,i})
end

print('-dpng',['C:\RESONANCE_MEG\DATA\' nip '\plots\' chantype{i} '_localizer_all.png']);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% STATS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:3
    % face
    
    load(['C:\RESONANCE_MEG\DATA\' nip '\processed\localizer_face.mat'])
    
    clear cfg
    eval(['cfg.channel     = ' chantype{i} ]);
    cfg.trials             = 'all';
    cfg.covariance         = 'no';
    cfg.keeptrials         = 'yes';
    cfg.removemean         = 'yes';
    cfg.vartrllength       = 2;
    ERF_face{i}            = ft_timelockanalysis(cfg,data);
    
    cfg.baseline           = [0 0.2];
    ERF_face{i}            = ft_timelockbaseline(cfg,ERF_face{i});
    
    % place
    load(['C:\RESONANCE_MEG\DATA\' nip '\processed\localizer_place.mat'])
    
    clear cfg
    eval(['cfg.channel     = ' chantype{i} ]);
    cfg.trials             = 'all';
    cfg.covariance         = 'no';
    cfg.keeptrials         = 'yes';
    cfg.removemean         = 'yes';
    cfg.vartrllength       = 2;
    ERF_place{i}           = ft_timelockanalysis(cfg,data);
    
    cfg.baseline           = [0 0.2];
    ERF_place{i}           = ft_timelockbaseline(cfg,ERF_place{i});
    
    % object
    load(['C:\RESONANCE_MEG\DATA\' nip '\processed\localizer_object.mat'])
    
    clear cfg
    eval(['cfg.channel     = ' chantype{i} ]);
    cfg.trials             = 'all';
    cfg.covariance         = 'no';
    cfg.keeptrials         = 'yes';
    cfg.removemean         = 'yes';
    cfg.vartrllength       = 2;
    ERF_object{i}          = ft_timelockanalysis(cfg,data);
    
    cfg.baseline           = [0 0.2];
    ERF_object{i}          = ft_timelockbaseline(cfg,ERF_object{i});
    
end

% plot
for i = 1:3
    cfg                    = [];
    cfg.axes               = 'no';
    cfg.xparam             = 'time';
    cfg.zparam             = 'avg';
    cfg.xlim               = [0 0.7];
    cfg.ylim               = 'maxmin';
    eval(['cfg.channel     = ' chantype{i} ]);
    cfg.baseline           = 'no';
    cfg.baselinetype       = 'absolute';
    cfg.trials             = 'all';
    cfg.showlabels         = 'yes';
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
    cfg.layout             = [root '/SCRIPTS/Layouts_fieldtrip/NM306mag.lay'];
    lay                    = ft_prepare_layout(cfg,ERF_object{i});
    lay.label              = ERF_object{i}.label;
    cfg.layout             = lay;
    
    scrsz = get(0,'ScreenSize');
    fig   = figure('position',scrsz);
    set(fig,'PaperPosition',scrsz)
    set(fig,'PaperPositionMode','auto')
    
    ft_multiplotER(cfg,ERF_face{1,i}, ERF_place{1,i}, ERF_object{1,i})
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
    cfg.clusteralpha     = 0.005;
    cfg.clusterstatistic = 'maxsum';
    cfg.minnbchan        = 2;
    cfg.tail             = 1;
    %     cfg.computecritval   ='yes';
    cfg.clustertail      = 1;
    cfg.alpha            = 0.0025;
    cfg.numrandomization = 500;
    cfg.neighbours       = neighbours;
    
    face_trl   = size(ERF_face{1,i}.trial,1);
    place_trl  = size(ERF_place{1,i}.trial,1);
    object_trl = size(ERF_object{1,i}.trial,1);
    
    cfg.design = [ones(1,face_trl) ones(1,place_trl)*2 ones(1,object_trl)*3];
    cfg.ivar  = 1;
    
    stat{i} = ft_timelockstatistics(cfg,ERF_face{1,i},ERF_place{1,i},ERF_object{1,i});
    
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
                cfg.comment    = num2str(stat{1,i}.time(k));
                mysubplot(12,12,k)
                topoplot(cfg, stat{1,i}.stat(:,k))

            else
                cfg = [];
                cfg.maplimits = [-5 5];
                cfg.style = 'straight';
                cfg.electrodes = 'off';
                cfg.hlmarkersize = 4;
                cfg.layout = 'C:\TEMPROD\SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
                cfg.comment    = num2str(stat{1,i}.time(k));
                mysubplot(12,12,k)
                topoplot(cfg, stat{1,i}.stat(:,k))
                
            end
        end
    end
    print('-dpng',['C:\RESONANCE_MEG\DATA\' nip '\plots\' chantype{i} 'Ftest_ERF.png']);
end

save(['C:\RESONANCE_MEG\DATA\' nip '\freq\STATS.mat'],'stat','ERF_face','ERF_place','ERF_object','pos')


