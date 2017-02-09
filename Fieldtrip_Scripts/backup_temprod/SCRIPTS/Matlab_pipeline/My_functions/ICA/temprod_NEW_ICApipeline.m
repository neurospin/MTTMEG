function temprod_NEW_ICApipeline(index,subject,bandpass,freqband,K,method,numcomponent)

for a = 1:8
    eval(['datapath' num2str(a) '= [''/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_'...
        subject '/run' num2str(a) '.mat'']']);
end

[Gradslong, Gradslat] = grads_for_layouts;
channeltype = {'MEG*1';Gradslong;Gradslat};
chan_index  = {'Mags';'Gradslong';'Gradslat'};

[GradsLong,GradsLat,Mags]     = grads_for_layouts;

fig = figure('position',[1 1 1280 1024]);
for k = 1:3
    
    eval(['load(datapath' num2str(index) ');']);
    par.ProcDataDir         = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];
    
    for i = 1:size(data.time,2)
        trialduration(1,i) = length(data.time{i});
        trialduration(2,i) = i;
    end
    asc_ord = sortrows(trialduration');
    X = asc_ord(:,1)';
    % W = round((X/X(1))*10);
    W = ceil(abs(zscore(X))*10);
    
    %% remove eog label and timecourses
    if length(data.label) > 306
        data.label([307;308]) = [];
        for i = 1:length(data.trial)
            data.trial{1,i}(307:308,:) = [];
        end
    end
    
    %% band-pass filtering
    for i                  = 1:length(data.trial)
        data.trial{i}      = ft_preproc_bandpassfilter(data.trial{i},data.fsample,bandpass);
    end
    
    %% rescale data matrix to avoid error in fastica
    % rescfactor     = 1/abs(min(min(dat))); % scaling factor : minimum value = 1
    for i = 1:length(data.trial)
        data.trial{1,i} = data.trial{1,i}*10^11; % 10^11 works fine, but I don't really know how it impacts
    end
    
    %% compute pca, get 10 components
    clear cfg
    cfg.method            = method;
    cfg.fastica           = struct('numofIC',numcomponent);
    cfg.runica            = struct('pca',numcomponent);
    cfg.binica            = struct('ncomps',numcomponent);
    cfg.channel           = channeltype{k};
    cfg.trials            = 'all';
    cfg.numcomponent      = numcomponent;
    cfg.blc               = 'yes';
    %     cfg.demean            = 'no';
    comp_topo             = ft_componentanalysis(cfg, data);
    %     comppath              = [par.ProcDataDir '20comp_pca_' num2str(chan_index{k}) num2str(index) '.mat'];
    %     save(comppath,'comp','cfg','-v7.3');
    clear data
    
    %% compute corresponding pca timecourses
    clear cfg
    cfg.method            = method;
    cfg.topo              = comp_topo.topo;
    cfg.topo              = comp_topo.topolabel;
    %     cfg.blc               = 'yes';
    comp_timecourse       = ft_componentanalysis(cfg, comp_topo);
    
    %% compute power spectra density on pca components
    clear cfg
    cfg.channel            = 'all';
    cfg.method             = 'mtmwelch';
    cfg.output             = 'pow';
    cfg.taper              = 'hanning';
    cfg.foi                = freqband(1):0.1:freqband(2);
    cfg.t_ftimwin          = ones(1,length(cfg.foi))*1;
    cfg.toi                = ones(1,2*length(cfg.foi))*0.5;
    cfg.trials             = 'all';
    cfg.keeptrials         = 'yes';
    cfg.keeptapers         = 'no';
    cfg.pad                = 'maxperlen';
    freq                   = ft_freqanalysis(cfg, comp_timecourse);
    freq                   = freq;
    freqcomppath              = [par.ProcDataDir 'runica-comp' num2str(numcomponent) '_freq' num2str(chan_index{k}) num2str(index) '.mat'];
    save(freqcomppath,'freq','comp_timecourse','cfg');
    
    %% specifiy layout for plotting topographies
    clear cfg
    cfg.channel           = channeltype{k};
    cfg.xparam            = 'comp';
    cfg.zparam            = 'topo';
    cfg.zlim              = 'maxabs';
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
    cfg.interactive       = 'no';
    cfg.layout            = '/neurospin/meg_tmp/ResonanceMeg_Baptiste_2009/SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
    lay                   = ft_prepare_layout(cfg,comp_topo);
    tmp                   = chan_index{k};
    eval(['lay.label             = ' tmp]);
    cfg.layout            = lay;
    
    %% plot the 10 first components topographies
    Fullspctrm          = freq.powspctrm;
    h =[];
    for x               = 1:size(Fullspctrm,2)
        g = [];
        for y           = 1:size(Fullspctrm,3)
            v           = squeeze(Fullspctrm(:,x,y))';
            f           = conv(v,K,'same');
            g(:,y) = f;
            clear f
        end
        h = cat(3,h,g);
    end
    h = permute(h,[1 3 2]);
    Fullspctrm = h;
    
    for i = 1:numcomponent
        mysubplot(10,12,((k-1)*3*numcomponent + (i*3)-2))
        cfg.comment = [chan_index{k} 'comp' num2str(numcomponent)];
        topoplot(cfg,comp_topo.topo(:,i));
        mysubplot(10,12,((k-1)*3*numcomponent + (i*3)-1))
        imagesc(freq.freq,1:size(freq.powspctrm,1),squeeze(Fullspctrm(:,i,:)));
        mysubplot(10,12,((k-1)*3*numcomponent + (i*3)))
        imagesc(freq.freq,1:size(freq.powspctrm,1),zscore(squeeze(Fullspctrm(:,i,:)),0,2));
    end
    hold on
end

 print('-r0','-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
        '/ICAspectra_overview_' num2str(freqband(1)) '-' num2str(freqband(2)) '_' num2str(index) '_' chan_index{k} '_' num2str(numcomponent) '.png']);




