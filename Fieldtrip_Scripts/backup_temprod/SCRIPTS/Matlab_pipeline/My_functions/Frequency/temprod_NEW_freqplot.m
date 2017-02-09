function temprod_NEW_freqplot(freqband,index,subject)

datapath = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/run'];

%% Plot trial-by-trial peak frequency topographies %%

load([datapath num2str(index) '.mat'])
par.ProcDataDir            = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];
chantypefull               = {'Mags';'Gradslong';'Gradslat'};
[label2,label3,label1]  = grads_for_layouts;

for j = 1:3
    % load full spectra array
    chantype               = chantypefull{j};
    load([par.ProcDataDir 'Fullspctrm_' chantype num2str(index) '.mat']);
    % select frequency band of interest
    freqinit               = find(floor(Fullfreq) == freqband(1));
    freqend                = find(ceil(Fullfreq) == freqband(2));
    freqresolution         = Fullfreq(2) - Fullfreq(1);
    freq.freq              = Fullfreq(freqinit(1):freqend(end));
    clear FullFreq
    % select the corresponding power
    freq.powspctrm         = Fullspctrm;
    freq.powspctrm         = freq.powspctrm(:,:,(freqinit:freqend));
    trialnumber            = size(Fullspctrm,1);
    clear Fullspctrm
    % complete dummy fieldtrip structure
    freq.dimord            = 'rpt_chan_freq';
    eval(['freq.label      = label' num2str(j) ';']);
    freq.cumtapcnt         = ones(trialnumber,length(freq.freq));
    
    % select frequency and power peaks
    for a                  = 1:size(freq.powspctrm,1)
        PowPeak(a)         = max(squeeze(mean(freq.powspctrm(a,:,:))));
        tmp(a)             = find(squeeze(mean(freq.powspctrm(a,:,:))) == PowPeak(a));
        FreqPeak(a)        = freq.freq(tmp(a));
    end
    
    % specify channel type for plotting purpose
    [GradsLong, GradsLat, Mags]  = grads_for_layouts;
    if strcmp(chantype,'Mags')     == 1
        channeltype        =  {'MEG*1'};
    elseif strcmp(chantype,'Gradslong') == 1;
        channeltype        =  GradsLong;
    elseif strcmp(chantype,'Gradslat')
        channeltype        =  GradsLat;
    end
    
    fig                    = figure('position',[1 1 1280 1024]);
    % plot single trial peak power topographies
    for k = 1:trialnumber
        mysubplot(8,10,k)
        clear cfg
        cfg.channel        = channeltype;
        cfg.xparam         = 'freq';
        cfg.zparam         = 'powspctrm';
        cfg.xlim           = [FreqPeak(k) FreqPeak(k)];
        cfg.baseline       = 'no';
        cfg.trials         = k;
        cfg.colormap       = jet;
        cfg.marker         = 'off';
        cfg.markersymbol   = 'o';
        cfg.markercolor    = [0 0 0];
        cfg.markersize     = 2;
        cfg.markerfontsize = 8;
        cfg.colorbar       = 'no';
        cfg.interplimits   = 'head';
        cfg.interpolation  = 'v4';
        cfg.style          = 'both';
        cfg.gridscale      = 67;
        cfg.shading        = 'flat';
        cfg.interactive    = 'no';
        cfg.comment        = [num2str(FreqPeak(k))];
        cfg.layout         = '/neurospin/meg_tmp/ResonanceMeg_Baptiste_2009/SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
        lay                = ft_prepare_layout(cfg,freq);
        if strcmp(chantype,'Gradslong')     == 1
            for i          = 1:102
                lay.label{i,1} = GradsLong{1,i};
            end
        elseif strcmp(chantype,'Gradslat')     == 1
            for i          = 1:102
                lay.label{i,1} = GradsLat{1,i};
            end
        elseif strcmp(chantype,'Mags')     == 1
            for i          = 1:102
                lay.label{i,1} = Mags{1,i};
            end
        end
        cfg.layout             = lay;
        ft_topoplotER(cfg,freq);

    end
    print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
        '/trialbytrial_topopeakfreq_' chantype '-' num2str(freqband(1)) '-' num2str(freqband(2)) 'hz.png']);
    
    % plot single trial spectra
    fig                    = figure('position',[1 1 1280 1024]);
    for k = 1:trialnumber
        mysubplot(8,10,k)
        plot(squeeze(mean(freq.powspctrm(k,:,:))));
    end
    
    print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
        '/trialbytrial_spectra_' chantype '_' num2str(freqband(1)) '_' num2str(freqband(2)) '_' num2str(index) 'hz.png']);
end
