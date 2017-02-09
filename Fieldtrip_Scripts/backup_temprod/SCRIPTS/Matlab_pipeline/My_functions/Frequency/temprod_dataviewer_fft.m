function temprod_dataviewer_fft(indexrun,subject,debiasing,savetag)

Dir = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];
chantypefull  = {'Mags';'Gradslong';'Gradslat'};
[label2,label3,label1]     = grads_for_layouts;

frange = {[85 95]};

fig                 = figure('position',[1 1 1280 1024]);
for i = 1:3
    for j = 1:length(frange)
        chantype            = chantypefull{i};
        Fullspctrm_path     = [Dir 'FullspctrmFFT_' chantype num2str(indexrun) '.mat'];
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
        
        chantypefull{i};
        % load full spectra array
        chantype               = chantypefull{i};
        % select the corresponding power
        freq.powspctrm         = Fullspctrm;
        freq.freq              = Fullfreq;
        trialnumber            = size(Fullspctrm,1);
        % complete dummy fieldtrip structure
        freq.dimord            = 'chan_freq';
        eval(['freq.label      = label' num2str(i) ';']);
        freq.cumtapcnt         = ones(trialnumber,length(freq.freq));
        
        clear cfg
        cfg.channel           = 'all';
        cfg.xparam            = 'freq';
        cfg.zparam            = 'powspctrm';
        cfg.xlim              = [8 14];
        %     cfg.zlim              = [-1e-25 1e-25];
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
        cfg.comment           = ['average power ' num2str(frange{j}(1)) '-' num2str(frange{j}(2)) ' ' chantype];
        cfg.layout            = '/neurospin/meg_tmp/ResonanceMeg_Baptiste_2009/SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
        lay                   = ft_prepare_layout(cfg,freq);
        lay.label             = freq.label;
        cfg.layout            = lay;
        
        subplot(5,3,j*3 -3 +i)
        ft_topoplotER(cfg,freq)
        
    end
end

if savetag == 1
    print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
        '/FullspctrmFFT_topos_' num2str(indexrun) '.png']);
end

fig                 = figure('position',[1 1 1280 1024]);
for i = 1:3
    chantype            = chantypefull{i};
    Fullspctrm_path     = [Dir 'FullspctrmFFT_' chantype num2str(indexrun) '.mat'];
    load(Fullspctrm_path)
    subplot(3,3,i)
    plot(Fullfreq,Fullspctrm')
    
    subplot(3,3,i+3)
    plot(Fullfreq,mean(Fullspctrm))
end

if savetag == 1
    print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
        '/FullspctrmFFT_spectra_' num2str(indexrun) '.png']);
end

fig                 = figure('position',[1 1 1280 1024]);
for i = 1:3
    for j = 1:length(frange)
        chantype            = chantypefull{i};
        Fullspctrm_path     = [Dir 'FullspctrmFFT_' chantype num2str(indexrun) '.mat'];
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
        
        chantypefull{i};
        % load full spectra array
        chantype               = chantypefull{i};
        % select the corresponding power
        freq.powspctrm         = Fullspctrm;
        freq.freq              = Fullfreq;
        trialnumber            = size(Fullspctrm,1);
        % complete dummy fieldtrip structure
        freq.dimord            = 'chan_freq';
        eval(['freq.label      = label' num2str(i) ';']);
        freq.cumtapcnt         = ones(trialnumber,length(freq.freq));
        
        clear cfg
        cfg.channel           = 'all';
        cfg.xparam            = 'freq';
        cfg.zparam            = 'powspctrm';
        cfg.xlim              = 'maxmin';
        %     cfg.zlim              = [-1e-25 1e-25];
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
        cfg.comment           = [num2str(Fullfreq(1)) ' ' num2str(Fullfreq(end)) ' ' chantype];
        cfg.layout            = '/neurospin/meg_tmp/ResonanceMeg_Baptiste_2009/SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
        lay                   = ft_prepare_layout(cfg,freq);
        lay.label             = freq.label;
        cfg.layout            = lay;

        figure
        ft_multiplotER(cfg,freq)
        
        if savetag == 1
            print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
                '/FullspctrmFFT_multiplot_' num2str(indexrun) '_' num2str(Fullfreq(1)) ' ' num2str(Fullfreq(end)) '_' chantype '.png']);
        end
        
    end
end





