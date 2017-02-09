function temprod_OLD_freqgdaverage(freqband,subject)

fig = figure('position',[1 1 1280 1024]);
[Gradslong, Gradslat] = grads_for_layouts;
channeltype = {'MEG*1';Gradslong;Gradslat};

for a = 1:6
    eval(['datapath' num2str(a) '= [''/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/OLD/processed_'...
    subject '/run' num2str(a) '.mat'']']);
end

for k = 1:6
    eval(['load(datapath' num2str(k) ');']); 
    for l = 1:3
        mysubplot(3,6,(l-1)*6 + k);
        clear cfg
        cfg.channel            = channeltype{l};
        cfg.method             = 'mtmfft';
        cfg.output             = 'pow';
        cfg.taper              = 'hanning';
        cfg.foilim             = freqband;
        foi                    = cfg.foilim;
        cfg.tapsmofrq          = 0.5;
        cfg.pad                = 'maxperlen';
        cfg.trials             = 'all';
        cfg.keeptrials         = 'no';
        cfg.keeptapers         = 'no';
        freq                   = ft_freqanalysis(cfg,data);
%         Vmax(k)                = max(mean(freq.powspctrm'));
%         Vmin(k)                = min(mean(freq.powspctrm'));
        
        clear cfg
        cfg.channel           = channeltype{l};
        cfg.xparam            = 'freq';
        cfg.zparam            = 'powspctrm';
        cfg.xlim              = freqband;
        cfg.baseline          = 'no';
        cfg.trials            = 'all';
        cfg.colormap          = jet;
        cfg.marker            = 'off';
        cfg.markersymbol      = 'o';
        cfg.markercolor       = [0 0 0];
        cfg.markersize        = 2;
        cfg.markerfontsize    = 8;
        cfg.colorbar          = 'no';
        cfg.interplimits      = 'head';
        cfg.interpolation     = 'v4';
        cfg.style             = 'both';
        cfg.gridscale         = 67;
        cfg.shading           = 'flat';
        cfg.interactive       = 'no';
        cfg.comment           = ['cond' num2str(k)];
        cfg.layout            = '/neurospin/meg_tmp/ResonanceMeg_Baptiste_2009/SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
        lay                   = ft_prepare_layout(cfg,freq);
        if l               == 2
            for i          = 1:102
                lay.label{i,1} = Gradslong{1,i};
            end
        elseif l           == 3
            for i          = 1:102
                lay.label{i,1} = Gradslat{1,i};
            end
        elseif l           == 1
            for i          = 1:102
                lay.label{i,1} = ['MEG' lay.label{i,1}];
            end
        end
        cfg.layout             = lay;
        ft_topoplotER(cfg,freq)
    end
end
% Vup                        = max(Vmax);
% Vdown                      = min(Vmin);

% for k = 1:6
%     subplot(2,3,k)
%     %     par.ProcDataDir        = '/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/OLD/processed/';
%     eval(['load(datapath' num2str(k) ');']);
%     %% fourier analysis %%
% [GradsLong, GradsLat]  = grads_for_layouts;
% if strcmp(chantype,'Mags')     == 1
%     channeltype        =  {'MEG*1'};  
% elseif strcmp(chantype,'Gradslong') == 1;
%     channeltype        =  GradsLong;
% elseif strcmp(chantype,'Gradslat')
%     channeltype        =  GradsLat;
% end
% 
%     clear cfg
%     cfg.channel            = channeltype;      
%     cfg.method             = 'mtmfft';
%     cfg.output             = 'pow';
%     cfg.taper              = 'hanning';
%     cfg.foilim             = freqband;
%     foi                    = cfg.foilim;
%     cfg.tapsmofrq          = 0.5;
%     cfg.pad                = 'maxperlen';
%     cfg.trials             = 'all';
%     cfg.keeptrials         = 'no';
%     cfg.keeptapers         = 'no';
%     freq                   = ft_freqanalysis(cfg,data);

   

print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/OLD/Plots_' subject...
    '/topomean-' num2str(freqband(1)) '-' num2str(freqband(2)) 'hz.png']); 
    
    
    
    
    
