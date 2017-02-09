function temprod_timelock_t0(index,subject,savetag,show,target,tag)

% set root
root = SetPath(tag);

Dir = [root '/DATA/NEW/processed_' subject];
chantypefull  = {'Mags';'Gradslong';'Gradslat'};
tagblock      = {'Mags';'Grads1';'Grads2'};
[label2,label3,label1]     = grads_for_layouts(tag);

for j = 1:3
    chantype = chantypefull{j};
    if show == 1  
        fig                 = figure('position',[1 1 1280 1024]);
    end
    %% trial-by-trial fourier analysis %%
    [GradsLong, GradsLat]  = grads_for_layouts(tag);
    if strcmp(chantype,'Mags')     == 1
        channeltype        =  {'MEG*1'};
    elseif strcmp(chantype,'Gradslong') == 1;
        channeltype        =  GradsLong;
    elseif strcmp(chantype,'Gradslat')
        channeltype        =  GradsLat;
    end
    data = load(fullfile(Dir,['/FT_trials/BLOCKTRIALS_FOR_ERFtend_' tagblock{j} '_RUN0' num2str(index) '.mat']));
    %% sorting data and other things %%
    data = Temprod_DataSelect(data,'yes','yes',target);    
    clear cfg
    cfg.channel            = channeltype;
    cfg.trials             = 'all';
    cfg.covariance         = 'no';
    cfg.keeptrials         = 'no';
    cfg.removemean         = 'yes';
    cfg.vartrllength       = 2;
    tendlocked             = ft_timelockanalysis(cfg,data);
    
    ERFpath               = [Dir '/FT_ERFs/' chantype 'tendLocked_'...
        'run' num2str(index) '.mat'];
    save(ERFpath,'-struct','tendlocked');
    
    cfg.axes               = 'no';
    cfg.xparam             = 'time';
    cfg.zparam             = 'avg';
    cfg.xlim               = [0 1.5];
    cfg.ylim               = 'maxmin';
    cfg.channel            = 'all';
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
    cfg.comment            = chantype;
    cfg.layout        = [root '/SCRIPTS/Layouts_fieldtrip/NM306mag.lay'];
    lay               = ft_prepare_layout(cfg,tendlocked);
    eval(['lay.label  = (label' num2str(j) ')'';']);
    cfg.layout       = lay;
    
    if show == 1
        ft_multiplotER(cfg,tendlocked)
    end
    
    if savetag == 1
        print('-dpng',[root '/DATA/NEW/Plots_' subject...
            '/MULTIs_ERFtendlocked_' chantype num2str(index) '.png']);
    end
    
end

if show == 1
    fig                 = figure('position',[1 1 1280 1024]);
    for j = 1:3
        chantype = chantypefull{j};
        %% trial-by-trial fourier analysis %%
        [GradsLong, GradsLat]  = grads_for_layouts(tag);
        if strcmp(chantype,'Mags')     == 1
            channeltype        =  {'MEG*1'};
        elseif strcmp(chantype,'Gradslong') == 1;
            channeltype        =  GradsLong;
        elseif strcmp(chantype,'Gradslat')
            channeltype        =  GradsLat;
        end
        data = load(fullfile(Dir,['/FT_trials/BLOCKTRIALS_FOR_ERFtend_' tagblock{j} '_RUN0' num2str(index) '.mat']));
        %% sorting data and other things %%
        data = Temprod_DataSelect(data,'yes','yes',target);
        
        clear cfg
        cfg.channel            = channeltype;
        cfg.trials             = 'all';
        cfg.covariance         = 'no';
        cfg.keeptrials         = 'no';
        cfg.removemean         = 'yes';
        cfg.vartrllength       = 2;
        tendlocked             = ft_timelockanalysis(cfg,data);
        Sm = mean(std(tendlocked.avg'));
        Mm = mean(mean(tendlocked.avg'));
        
        for X = 1:20
            cfg                    = [];
            cfg.axes               = 'no';
            cfg.xparam             = 'time';
            cfg.zparam             = 'avg';
            cfg.xlim               = [0.080 *(X-1) 0.080*X];
            cfg.zlim               = [(0-3*Sm) (0+3*Sm)];
            cfg.channel            = 'all';
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
            cfg.colorbar           = 'no';
            cfg.interplimits       = 'head';
            cfg.interpolation      = 'v4';
            cfg.style              = 'straight';
            cfg.gridscale          = 67;
            cfg.shading            = 'flat';
            cfg.interactive        = 'yes';
            cfg.comment            = [chantype ' ' num2str(0.080 *(X-0.5)) 's' ];
            cfg.layout        = [root '/SCRIPTS/Layouts_fieldtrip/NM306mag.lay'];
            lay               = ft_prepare_layout(cfg,tendlocked);
            eval(['lay.label  = (label' num2str(j) ')'';']);
            cfg.layout       = lay;
            subplot(4,5,X)
            ft_topoplotER(cfg,tendlocked)
        end
        
        if savetag == 1
            print('-dpng',[root '/DATA/NEW/Plots_' subject...
                '/TOPOs_ERFtendlocked_' chantype num2str(index) '.png']);
        end
        
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%% SHORT VS LONG TRIALS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for j = 1:3
    chantype = chantypefull{j};
    if show == 1  
        fig                 = figure('position',[1 1 1280 1024]);
    end
    %% trial-by-trial fourier analysis %%
    [GradsLong, GradsLat]  = grads_for_layouts(tag);
    if strcmp(chantype,'Mags')     == 1
        channeltype        =  {'MEG*1'};
    elseif strcmp(chantype,'Gradslong') == 1;
        channeltype        =  GradsLong;
    elseif strcmp(chantype,'Gradslat')
        channeltype        =  GradsLat;
    end
    data = load(fullfile(Dir,['/FT_trials/BLOCKTRIALS_FOR_ERFtend_' tagblock{j} '_RUN0' num2str(index) '.mat']));
    
    %% sorting data and other things %%
    data = Temprod_DataSelect(data,'yes','yes',target);
    
%     m                      = (round(length(data.durationsorted)/2));
    m                      = median(data.durationsorted(:,1));
    M = 0;
    for ind = 1:length(data.durationsorted(:,1))
        if data.durationsorted(ind,1) < m
        M = M +1;
        end
    end
    
    clear cfg
    cfg.channel            = channeltype;
    cfg.trials             = data.durationsorted(1:M,2);
    cfg.covariance         = 'no';
    cfg.keeptrials         = 'no';
    cfg.removemean         = 'yes';
    cfg.vartrllength       = 2;
    tendlocked_short         = ft_timelockanalysis(cfg,data);
    clear cfg
    cfg.channel            = channeltype;
    cfg.trials             = data.durationsorted((M+1):end,2);
    cfg.covariance         = 'no';
    cfg.keeptrials         = 'no';
    cfg.removemean         = 'yes';
    cfg.vartrllength       = 2;
    tendlocked_long        = ft_timelockanalysis(cfg,data);    
    
    ERFpath               = [Dir '/FT_ERFs/' chantype 'tendLocked_S+L_'...
        'run' num2str(index) '.mat'];
    save(ERFpath,'tendlocked_short','tendlocked_long');
    
    cfg.axes               = 'no';
    cfg.xparam             = 'time';
    cfg.zparam             = 'avg';
    cfg.xlim               = [0 1.5];
    cfg.ylim               = 'maxmin';
    cfg.channel            = 'all';
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
    cfg.comment            = chantype;
    cfg.layout        = [root '/SCRIPTS/Layouts_fieldtrip/NM306mag.lay'];
    lay               = ft_prepare_layout(cfg,tendlocked_short);
    eval(['lay.label  = (label' num2str(j) ')'';']);
    cfg.layout       = lay;
    
    if show == 1
        ft_multiplotER(cfg,tendlocked_short,tendlocked_long)
    end
    
    if savetag == 1
        print('-dpng',[root '/DATA/NEW/Plots_' subject...
            '/MULTIs_ERFtendlocked_S+L' chantype num2str(index) '.png']);
    end
    
end

