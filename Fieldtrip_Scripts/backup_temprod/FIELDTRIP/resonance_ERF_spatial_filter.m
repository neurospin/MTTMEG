function SPF = resonance_ERF_spatial_filter(nip,stim,plottag,tag)

root = SetPath(tag);
[Grads1,Grads2,Mags]   = grads_for_layouts(tag);

chantype = {'Mags','Grads1','Grads2'};

% face
for i = 1:3
    
    load(['C:\RESONANCE_MEG\DATA\' nip '\processed\localizer_' stim '.mat'])
    
    clear cfg
    eval(['cfg.channel     = ' chantype{i} ]);
    cfg.trials             = 'all';
    cfg.covariance         = 'no';
    cfg.keeptrials         = 'no';
    cfg.removemean         = 'yes';
    cfg.vartrllength       = 2;
    ERF{i}                 = ft_timelockanalysis(cfg,data);
    
    cfg.baseline           = [0 0.05];
    ERF{i}                 = ft_timelockbaseline(cfg,ERF{i});
    
    tmp                    = ERF{i};
    
    save(['C:\RESONANCE_MEG\DATA\' nip '\processed\' chantype{i} 'localizer_' stim '.mat'],'tmp');
    
    cfg                    = [];
    cfg.axes               = 'no';
    cfg.xparam             = 'time';
    cfg.zparam             = 'avg';
    cfg.xlim               = [0 0.5];
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
    cfg.comment            = [chantype{i} ' : ' nip];
    cfg.commentpos         = 'leftbottom';
    cfg.interactive        = 'yes';
    cfg.layout             = [root '/SCRIPTS/Layouts_fieldtrip/NM306mag.lay'];
    lay                    = ft_prepare_layout(cfg,ERF{i});
    lay.label              = ERF{i}.label;
    cfg.layout             = lay;
    
    if strcmp(plottag,'yes')
        scrsz = get(0,'ScreenSize');
        fig   = figure('position',scrsz);
        set(fig,'PaperPosition',scrsz)
        set(fig,'PaperPositionMode','auto')
        
        ft_multiplotER(cfg,ERF{i})
    end
    
end

LatencyERF = input('please input the chosen latency: ');

lbegin              = find(ERF{1,1}.time >= (LatencyERF(1)-0.005));
lend                = find(ERF{1,1}.time <= (LatencyERF(1)+0.005));
lband               = lbegin(1):lend(end);

for i = 1:3
    
    sel = [];
    sel = mean(abs(ERF{1,i}.avg(:,lband))')';
    sel = [sel (1:102)'];
    sel = sortrows(sel);
    sel(92:102,1) = ones(11,1);
    sel(1:91,1)   = zeros(91,1);
    sel = [sel(:,2) sel(:,1)];
    sel = sortrows(sel);
    sel = sel(:,2);
    
    SPF{i} = sel;
end

% plot ERF topography and check loaction of selected channels
scrsz = get(0,'ScreenSize');
fig   = figure('position',scrsz);
set(fig,'PaperPosition',scrsz)
set(fig,'PaperPositionMode','auto')

for i = 1:3
    % plotting parameters
    cfg                    = [];
    cfg.channel            = 'all';
    cfg.parameter          = 'avg';
    cfg.xlim               = ERF{1,1}.time([lband(1) lband(2)]);
    cfg.ylim               = 'maxmin';
    cfg.zlim               = 'maxmin';
    cfg.interplimits       = 'head';
    cfg.interpolation      = 'v4';
    cfg.style              = 'straight';
    cfg.gridscale          = 67;
    cfg.shading            = 'flat';
    cfg.hlmarker           = 'o';
    cfg.hlcolor            = [0 0 0];
    cfg.hlmarkersize       = 10;
    cfg.hllinewidth        = 10;
    cfg.highlight          = 'on';
    [x,y] = find(SPF{i} == (ones(102,1)));
    cfg.highlightchannel   = x;
    cfg.fontsize           = 10;
    cfg.colormap           = hot;
    cfg.layout             = [root '/SCRIPTS/Layouts_fieldtrip/NM306mag.lay'];
    lay                    = ft_prepare_layout(cfg,ERF{1,i});
    lay.label              = ERF{1,i}.label;
    cfg.layout             = lay;
    cfg.colorbar           = 'yes';
    
    mysubplot(1,3,i)
    ft_topoplotER(cfg,ERF{1,i})
    
end

print('-dpng',['C:\RESONANCE_MEG\DATA\' nip '\plots\selectedchans_on_ERF.png'])






