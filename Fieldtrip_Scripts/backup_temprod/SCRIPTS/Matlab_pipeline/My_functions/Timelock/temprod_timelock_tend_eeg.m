function temprod_timelock_tend_eeg(index,subject,savetag,show,tag)

% set root
root = SetPath(tag);

Dir = [root '/DATA/NEW/processed_' subject];
EEG  = EEG_for_layouts(tag);

if show == 1
    fig                 = figure('position',[1 1 1280 1024]);
end
%% trial-by-trial fourier analysis %%

data = load(fullfile(Dir,['/FT_trials/BLOCKTRIALS_FOR_ERFtend_Eeg_RUN0' num2str(index) '.mat']));
%% sorting data and other things %%
data = Temprod_DataSelect(data,'yes','yes',target);

clear cfg
cfg.channel            = 'EEG*';
cfg.trials             = 'all';
cfg.covariance         = 'no';
cfg.keeptrials         = 'no';
cfg.removemean         = 'yes';
cfg.vartrllength       = 2;
tendlocked               = ft_timelockanalysis(cfg,data);

ERFpath               = [Dir '/FT_ERFs/EEG_tendLocked_'...
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
cfg.comment            = 'EEG';
cfg.layout             = [root '/SCRIPTS/Layouts_fieldtrip/eeg_64_NM20884N.lay'];
lay                    = ft_prepare_layout(cfg,tendlocked);
lay.label              = EEG;
cfg.layout             = lay;

if show == 1
    ft_multiplotER(cfg,tendlocked)
end

if savetag == 1
    print('-dpng',[root '/DATA/NEW/Plots_' subject...
        '/MULTIs_ERPtendlocked_EEG' num2str(index) '.png']);
end


if show == 1
    fig                 = figure('position',[1 1 1280 1024]);
    
    data = load(fullfile(Dir,['/FT_trials/BLOCKTRIALS_FOR_ERFtend_Eeg_RUN0' num2str(index) '.mat']));
    %% sorting data and other things %%
    data = Temprod_DataSelect(data,'yes','yes',target);
    
    clear cfg
    cfg.channel            = 'EEG*';
    cfg.trials             = 'all';
    cfg.covariance         = 'no';
    cfg.keeptrials         = 'no';
    cfg.removemean         = 'yes';
    cfg.vartrllength       = 2;
    tendlocked               = ft_timelockanalysis(cfg,data);
    Sm = mean(std(tendlocked.avg'));
    Mm = mean(mean(tendlocked.avg'));
    
    for X = 1:20
        cfg                    = [];
        cfg.axes               = 'no';
        cfg.xparam             = 'time';
        cfg.zparam             = 'avg';
        cfg.xlim               = [0.050 *(X-1) 0.050*X];
        cfg.zlim               = [(0-5*Sm) (0+5*Sm)];
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
        cfg.comment            = ['EEG ' num2str((0.050 *(X-0.5)) - 0.5) 's' ];
        cfg.layout             = [root '/SCRIPTS/Layouts_fieldtrip/eeg_64_NM20884N.lay'];
        lay                    = ft_prepare_layout(cfg,tendlocked);
        lay.label              = EEG;
        cfg.layout             = lay;
        subplot(4,5,X)
        ft_topoplotER(cfg,tendlocked)
    end
    
    if savetag == 1
        print('-dpng',[root '/DATA/NEW/Plots_' subject...
            '/TOPOs_ERPtendlocked_' num2str(index) '.png']);
    end
    
end



