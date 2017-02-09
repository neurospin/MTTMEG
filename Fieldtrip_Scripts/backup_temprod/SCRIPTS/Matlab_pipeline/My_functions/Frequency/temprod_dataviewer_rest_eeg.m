function temprod_dataviewer_rest(indexrun,subject,debiasing,savetag,fband)

Dir = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];
EEGlabel   = EEG_for_layouts;

frange = {fband};

fig                 = figure('position',[1 1 1280 1024]);

for j = 1:length(frange)
    Fullspctrm_path     = [Dir 'FullspctrmEEGRest_' num2str(indexrun) '.mat'];
    load(Fullspctrm_path)
    
    freqband            = frange{j};
    fbegin              = find(Fullfreq >= freqband(1));
    fend                = find(Fullfreq <= freqband(2));
    fband               = fbegin(1):fend(end);
    bandFullspctrm      = Fullspctrm(:,fband);
    bandFullfreq        = Fullfreq(fband);
    clear Fullspctrm Fullfreq
    Fullspctrm          = bandFullspctrm;
    Fullfreq            = bandFullfreq;
    
    % load full spectra array
    % select the corresponding power
    freq.powspctrm         = Fullspctrm;
    freq.freq              = Fullfreq;
    trialnumber            = size(Fullspctrm,1);
    % complete dummy fieldtrip structure
    freq.dimord            = 'chan_freq';
    freq.label             = EEGlabel;
    freq.cumtapcnt         = ones(trialnumber,length(freq.freq));
    
    clear cfg
    cfg.channel           = 'all';
    cfg.xparam            = 'freq';
    cfg.zparam            = 'powspctrm';
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
    cfg.style             = 'straight';
    cfg.gridscale         = 67;
    cfg.shading           = 'flat';
    cfg.interactive       = 'yes';
    cfg.comment           = ['average power ' num2str(frange{j}(1)) '-' num2str(frange{j}(2)) ' EEG'];
    cfg.layout            = '/neurospin/meg_tmp/ResonanceMeg_Baptiste_2009/SCRIPTS/Layouts_fieldtrip/eeg_64_NM20884N.lay';
    lay                   = ft_prepare_layout(cfg,freq);
    lay.label             = freq.label;
    cfg.layout            = lay;
    subplot(2,3,6)
    ft_topoplotER(cfg,freq)
    
end

% if savetag == 1
%     print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
%         '/FullspctrmEEGRest_topo_' num2str(indexrun) '_' num2str(freqband(1)) '-' num2str(freqband(2)) '.png']);
% end

Fullspctrm_path     = [Dir 'FullspctrmEEGRest_' num2str(indexrun) '.mat'];
load(Fullspctrm_path)

freqband            = frange{1};
fbegin              = find(Fullfreq >= freqband(1));
fend                = find(Fullfreq <= freqband(2));
fband               = fbegin(1):fend(end);
bandFullspctrm      = Fullspctrm(:,fband);
bandFullfreq        = Fullfreq(fband);
clear Fullspctrm Fullfreq
Fullspctrm          = bandFullspctrm;
Fullfreq            = bandFullfreq;

subplot(2,3,3)
plot(Fullfreq,mean(Fullspctrm))

% 
% if savetag == 1
%     print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
%         '/FullspctrmEEGRest_spectra_' num2str(indexrun) '_' num2str(freqband(1)) '-' num2str(freqband(2)) '.png']);
% end

for j = 1:length(frange)
    
    Fullspctrm_path     = [Dir 'FullspctrmEEGRest_' num2str(indexrun) '.mat'];
    load(Fullspctrm_path)
    
    freqband            = frange{j};
    fbegin              = find(Fullfreq >= freqband(1));
    fend                = find(Fullfreq <= freqband(2));
    fband               = fbegin(1):fend(end);
    bandFullspctrm      = Fullspctrm(:,fband);
    bandFullfreq        = Fullfreq(fband);
    clear Fullspctrm Fullfreq
    Fullspctrm          = bandFullspctrm;
    Fullfreq            = bandFullfreq;
    
    % load full spectra array
    % select the corresponding power
    freq.powspctrm         = Fullspctrm;
    freq.freq              = Fullfreq;
    trialnumber            = size(Fullspctrm,1);
    % complete dummy fieldtrip structure
    freq.dimord            = 'chan_freq';
    freq.label             = EEGlabel;
    freq.cumtapcnt         = ones(trialnumber,length(freq.freq));
    
    clear cfg
    cfg.channel           = 'all';
    cfg.xparam            = 'freq';
    cfg.zparam            = 'powspctrm';
    cfg.xlim              = 'maxmin';
    cfg.baseline          = 'no';
    cfg.trials            = 'all';
    cfg.axes              = 'no';
    cfg.box               = 'no';
    cfg.interplimits      = 'head';
    cfg.interpolation     = 'v4';
    cfg.style             = 'straight';
    cfg.gridscale         = 67;
    cfg.shading           = 'flat';
    cfg.interactive       = 'yes';
    cfg.showlabels        = 'yes';
    cfg.comment           = [num2str(Fullfreq(1)) ' ' num2str(Fullfreq(end)) ' EEG'];
    cfg.layout            = '/neurospin/meg_tmp/ResonanceMeg_Baptiste_2009/SCRIPTS/Layouts_fieldtrip/eeg_64_NM20884N.lay';
    lay                   = ft_prepare_layout(cfg,freq);
    lay.label             = freq.label;
    cfg.layout            = lay;
    
    subplot(2,3,[1 2 4 5])
    ft_multiplotER(cfg,freq)
    
    if savetag == 1
        print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
            '/FullspctrmEEGRest_overview_' num2str(indexrun) '_' num2str(freqband(1)) '-' num2str(freqband(2)) '.png']);
    end
    
end
end





