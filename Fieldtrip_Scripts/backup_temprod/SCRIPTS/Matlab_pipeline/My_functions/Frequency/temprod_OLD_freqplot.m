function temprod_OLD_freqplot(datapath,freqband,index,chantype,subject)

datapath = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/OLD/processed_' subject '/run'];

%% Plot trial-by-trial peak frequency topographies %%

load([datapath num2str(index) '.mat'])
par.ProcDataDir            = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/OLD/processed_' subject '/'];
chantypefull               = {'Mags';'Gradslong';'Gradslat'};

fig                        = figure('position',[1 1 1280 1024]);
for j = 1:3
    % load full spectra array
    chantype               = chantypefull{j};
    load([par.ProcDataDir 'Fullspctrm_' chantype num2str(index) '.mat']);
    % select frequency band of interest
    freqinit               = find(Fullfreq == freqband(1));
    freqend                = find(Fullfreq == freqband(2));
    freqresolution         = Fullfreq(2) - Fullfreq(1);
    freq.freq              = Fullfreq(freqinit:freqend);
    clear FullFreq
    % select the corresponding power
    freq.powspctrm         = Fullspctrm;            
    freq.powspctrm         = freq.powspctrm(:,:,(freqinit:freqend));
    clear Fullspctrm
    % select frequency and power peaks
    for a                  = 1:size(freq.powspctrm,1)
        for b              = 1:size(freq.powspctrm,2)
            PowPeak(a,b)   = max(squeeze(freq.powspctrm(a,b,:)));
            tmp(a,b)       = find(squeeze(freq.powspctrm(a,b,:)) == PowPeak(a,b));
            FreqPeak(a,b)  = freq.freq(tmp(a,b));
        end
    end
    
    [GradsLong, GradsLat, Mags]  = grads_for_layouts;
    if strcmp(chantype,'Mags')     == 1
        channeltype        =  Mags;
    elseif strcmp(chantype,'Gradslong') == 1;
        channeltype        =  GradsLong;
    elseif strcmp(chantype,'Gradslat')
        channeltype        =  GradsLat;
    end
    
    
    mysubplot(10,10,k) 
    clear cfg
    cfg.channel        = channeltype; 
    cfg.xparam         = 'freq';
    cfg.zparam         = 'powspctrm';
    cfg.xlim           = [Freqband];
%     cfg.zlim           = [(mean(pmin) - 0*std(pmin)) (mean(pmax) + 0*std(pmax))];
    cfg.baseline       = 'no';
    cfg.trials         = 'all';
    cfg.colormap       = jet;
    cfg.marker         = 'on';
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
    cfg.comment        = ['peak frequency : ' num2str(Freq(Peak(k)))];
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
            lay.label{i,1} = ['MEG' lay.label{i,1}];
        end
    end
    cfg.layout             = lay;
    ft_topoplotER(cfg,freq)
end   
print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/OLD/Plots_' subject...
    '/trialbytrial_topopeak_' chantype '-' num2str(freqband(1)) '-' num2str(freqband(2)) 'hz.png']); 

fig = figure('position',[1 1 1280 1024]);
for k  = 1:length(Sample)
    clear cfg
    cfg.channel        = channeltype;
    cfg.method         = 'mtmfft';
    cfg.output         = 'pow';
    cfg.taper          = 'hanning';
    cfg.foilim         = freqband;
    foi                = cfg.foilim;
    cfg.tapsmofrq      = 0.5;
    cfg.pad            = 'maxperlen';
    cfg.trials         = k;
    cfg.keeptrials     = 'no';
    cfg.keeptapers     = 'no';
    eval(['freq' num2str(k) '= ft_freqanalysis(cfg,data);']);
    hold on
    mysubplot(10,10,k) 
    clear cfg
    cfg.channel        = {'MEG*1'}; %% magnetometers
    cfg.xparam         = 'freq';
    cfg.zparam         = 'powspctrm';
    cfg.xlim           = freqband;
%     cfg.zlim           = [(mean(pmin) - 0*std(pmin)) (mean(pmax) + 0*std(pmax))];
    cfg.baseline       = 'no';
    cfg.trials         = 'all';
    cfg.colormap       = jet;
    cfg.marker         = 'on';
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
    cfg.comment        = ['peak frequency : ' num2str(Freq(Peak(k)))];
    cfg.layout             = '/neurospin/meg_tmp/ResonanceMeg_Baptiste_2009/SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
    lay                    = ft_prepare_layout(cfg,freq);
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
            lay.label{i,1} = ['MEG' lay.label{i,1}];
        end
    end
    cfg.layout             = lay;
    ft_topoplotER(cfg,freq)
end

print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/OLD/Plots_' subject...
    '/trialbytrial_topomean_' chantype '-' num2str(freqband(1)) '-' num2str(freqband(2)) '_' num2str(index) 'hz.png']); 

