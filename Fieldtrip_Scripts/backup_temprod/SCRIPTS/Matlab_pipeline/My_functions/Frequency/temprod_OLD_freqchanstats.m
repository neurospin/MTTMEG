function temprod_OLD_freqchanstats(freqband,index,ptreshold,subject)

datapath = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/OLD/processed_' subject '/run'];

%% Plot basic correlation between frequency peak, frequency peak power and temporal
%% estimates
load([datapath num2str(index) '.mat'])
par.ProcDataDir            = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/OLD/processed_' subject '/'];
chantypefull               = {'Mags';'Gradslong';'Gradslat'};

fig                        = figure('position',[1 1 1280 1024]);
for j = 1:3
    
    chantype               = chantypefull{j};
    load([par.ProcDataDir 'Fullspctrm_' chantype num2str(index) '.mat']);
    freq.powspctrm         = Fullspctrm;
    clear Fullspctrm;
    freq.powspctrm         = freq.powspctrm(:,:,(length(4:0.2:freqband(1)):(length(4:0.2:freqband(2)))));
    freq.freq = Fullfreq((length(4:0.2:freqband(1)):(length(4:0.2:freqband(2)))));
    clear FullFreq
    
    [GradsLong, GradsLat]  = grads_for_layouts;
    if strcmp(chantype,'Mags')     == 1
        channeltype        =  {'MEG*1'};
    elseif strcmp(chantype,'Gradslong') == 1;
        channeltype        =  GradsLong;
    elseif strcmp(chantype,'Gradslat')
        channeltype        =  GradsLat;
    end
    
    for a                  = 1:size(freq.powspctrm,1)
        for b              = 1:size(freq.powspctrm,2)
            PowPeak(a,b)   = max(squeeze(freq.powspctrm(a,b,:)));
            tmp(a,b)       = find(squeeze(freq.powspctrm(a,b,:)) == PowPeak(a,b));
            FreqPeak(a,b)  = freq.freq(tmp(a,b));
        end
    end

    Sample                 = [];
    for i                  = 1:length(data.time)
        Sample             = [Sample ; length(data.time{i})];
    end
    fsample                = 500;
    tmp                    = 1;
    select = [];
    for b                  = 1:size(freq.powspctrm,2)
        [rho(b),pval(b)]   = corr((Sample/fsample),FreqPeak(:,b));
        if pval(b) <= ptreshold
            select(tmp)    = b;
            tmp = tmp + 1;
        end
    end
    
    cfg.channel            = 'all';
    cfg.xparam             = 'freq';
    cfg.zparam             = 'powspctrm';
    cfg.xlim               = [1 1];
    cfg.zlim               = [-0.5 0.5];
    cfg.baseline           = 'no';
    cfg.trials             = 'all';
    cfg.colormap           = jet;
    cfg.marker             = 'on';
    cfg.markersymbol       = 'o';
    cfg.markercolor        = [0 0 0];
    cfg.markersize         = 2;
    cfg.markerfontsize     = 8;
    cfg.colorbar           = 'no';
    cfg.interplimits       = 'head';
    cfg.interpolation      = 'v4';
    cfg.style              = 'both';
    cfg.gridscale          = 67;
    cfg.shading            = 'flat';
    cfg.interactive        = 'no';
    if isempty(select)     == 1
        cfg.highlight      = 'off';
    else
        cfg.highlight      = select;
    end
    cfg.comment            = ['FreqPeak corr' chantype '-' num2str(freqband(1)) '-' num2str(freqband(2)) 'hz'];
    cfg.layout             = '/neurospin/meg_tmp/ResonanceMeg_Baptiste_2009/SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
    lay                    = ft_prepare_layout(cfg,freq);
    if strcmp(chantype,'GradsLong')     == 1
        for i          = 1:102
            lay.label{i,1} = GradsLong{1,i};
        end
    elseif strcmp(chantype,'GradsLat')     == 1
        for i          = 1:102
            lay.label{i,1} = GradsLat{1,i};
        end
    elseif strcmp(chantype,'Mags')     == 1
        for i          = 1:102
            lay.label{i,1} = ['MEG' lay.label{i,1}];
        end
    end
    cfg.layout             = lay;
    
    mysubplot(2,3,j)
    topoplot(cfg,rho')
    
    Sample                 = [];
    for i                  = 1:length(data.time)
        Sample             = [Sample ; length(data.time{i})];
    end
    fsample                = 500;
    tmp                    = 1;
    select = [];
    for b                  = 1:size(freq.powspctrm,2)
        [rho(b),pval(b)]   = corr((Sample/fsample),PowPeak(:,b));
        if pval(b) <= ptreshold
            select(tmp)    = b;
            tmp = tmp + 1;
        end
    end 
    
    cfg.channel            = 'all';
    cfg.xparam             = 'freq';
    cfg.zparam             = 'powspctrm';
    cfg.xlim               = [1 1];
    cfg.zlim               = [-0.5 0.5];
    cfg.baseline           = 'no';
    cfg.trials             = 'all';
    cfg.colormap           = jet;
    cfg.marker             = 'on';
    cfg.markersymbol       = 'o';
    cfg.markercolor        = [0 0 0];
    cfg.markersize         = 2;
    cfg.markerfontsize     = 8;
    cfg.colorbar           = 'no';
    cfg.interplimits       = 'head';
    cfg.interpolation      = 'v4';
    cfg.style              = 'both';
    cfg.gridscale          = 67;
    cfg.shading            = 'flat';
    cfg.interactive        = 'no';
    if isempty(select)     == 1
        cfg.highlight      = 'off';
    else
        cfg.highlight      = select;
    end
    cfg.comment            = ['PowPeak corr' chantype '-' num2str(freqband(1)) '-' num2str(freqband(2)) 'hz'];
    cfg.layout             = '/neurospin/meg_tmp/ResonanceMeg_Baptiste_2009/SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
    lay                    = ft_prepare_layout(cfg,freq);
    if strcmp(chantype,'GradsLong')     == 1
        for i          = 1:102
            lay.label{i,1} = GradsLong{1,i};
        end
    elseif strcmp(chantype,'GradsLat')     == 1
        for i          = 1:102
            lay.label{i,1} = GradsLat{1,i};
        end
    elseif strcmp(chantype,'Mags')     == 1
        for i          = 1:102
            lay.label{i,1} = ['MEG' lay.label{i,1}];
        end
    end
    cfg.layout             = lay;
    
    mysubplot(2,3,j+3)
    topoplot(cfg,rho')
       
end

  print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/OLD/Plots_' subject...
    '/topocorrchan_' num2str(freqband(1)) '-' num2str(freqband(2)) 'hz_' num2str(index) '.png']); 

