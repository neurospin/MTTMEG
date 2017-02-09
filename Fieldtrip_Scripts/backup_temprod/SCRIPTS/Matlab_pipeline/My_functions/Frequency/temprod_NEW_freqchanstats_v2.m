function temprod_NEW_freqchanstats_v2(freqband,index,ptreshold,subject)

datapath = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/run'];

%% Plot basic correlation between frequency peak, frequency peak power and temporal
%% estimates
load([datapath num2str(index) '.mat'])
par.ProcDataDir            = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];
chantypefull               = {'Mags';'Gradslong';'Gradslat'};
[label2,label3,label1]     = grads_for_layouts;

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
    % NORMALIZATION (remove the mean across trial)
%     F = squeeze(mean(mean(Fullspctrm)))';
%     F2 = repmat(F,size(Fullspctrm,2),1); F3 = [];
%     for i = 1:size(Fullspctrm,1)
%         F3 = cat(3,F3,F2);
%     end
%     F4 = shiftdim(F3,2);
%     Fullspctrm = Fullspctrm - F4;   
    % select the corresponding power
    freq.powspctrm         = Fullspctrm;
    freq.powspctrm         = freq.powspctrm(:,:,(freqinit:freqend));
    trialnumber            = size(Fullspctrm,1);
    clear Fullspctrm
    % complete dummy fieldtrip structure
    freq.dimord            = 'rpt_chan_freq';
    eval(['freq.label      = label' num2str(j) ';']);
    freq.cumtapcnt         = ones(trialnumber,length(freq.freq));
    
    tmp = cell(size(freq.powspctrm,1),size(freq.powspctrm,2));
    FreqPeaks = cell(size(freq.powspctrm,1),size(freq.powspctrm,2));
    PowPeaks = cell(size(freq.powspctrm,1),size(freq.powspctrm,2));
    for a                  = 1:size(freq.powspctrm,1)
        for b              = 1:size(freq.powspctrm,2)
            PowPeaks{a,b}  = findpeaks(squeeze(freq.powspctrm(a,b,:)));
            for i = 1:length(PowPeaks{a,b})
                tmp{a,b}   = [tmp{a,b} find(squeeze(freq.powspctrm(a,b,:)) == PowPeaks{a,b}(i))];
                FreqPeaks{a,b} = [FreqPeaks{a,b} freq.freq(tmp{a,b}(i))];
            end
        end
    end

    X = [];
    for a = 1:74
        for b = 1:102
            X = [X FreqPeaks{a,b}];
        end
    end
    hist(X,length(X))
    
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
    cfg.colorbar           = 'yes';
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
    cfg.colorbar           = 'yes';
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

  print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
    '/topocorrchan_' num2str(freqband(1)) '-' num2str(freqband(2)) 'hz_' num2str(index) '.png']); 

