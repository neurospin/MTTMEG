function temprod_freqcorrchan(freqband,indexrun,ptreshold,subject,tag)

% set root
root = SetPath(tag);
Dir = [root '/DATA/NEW/processed_' subject];

[Gradslong, Gradslat] = grads_for_layouts(tag);
channeltype = {'MEG*1';Gradslong;Gradslat};
chan_index  = {'Mags';'Gradslong';'Gradslat'};

ProcDataDir         = [root '/DATA/NEW/processed_' subject '/'];

figure
for j = 1:3 
    load([ProcDataDir 'FT_spectra\FullspctrmV2_' chan_index{j} num2str(indexrun) '.mat']);
    tmp = unique(Fullfreq); clear Fullfreq; Fullfreq = tmp;
    fbegin              = find(Fullfreq >= freqband(1));
    fend                = find(Fullfreq <= freqband(2));
    fband               = fbegin(1):fend(end);
    bandFullspctrm      = Fullspctrm(:,:,fband);
    bandFullfreq        = Fullfreq(fband);
    clear Fullspctrm Fullfreq
    Fullspctrm          = bandFullspctrm;
    Fullfreq            = bandFullfreq;
    clear bandFullspctrm bandFullfreq
    
    [GradsLong, GradsLat]  = grads_for_layouts(tag);
    if strcmp(chan_index{j},'Mags')     == 1
        channeltype        =  {'MEG*1'};
    elseif strcmp(chan_index{j},'Gradslong') == 1;
        channeltype        =  GradsLong;
    elseif strcmp(chan_index{j},'Gradslat')
        channeltype        =  GradsLat;
    end
    
    trialduration = sortrows([asc_ord(:,2) asc_ord(:,1)])
    
    tmp = 1; selected = [];
    clear pval rho 
    for i = 1:102
        % linear correlation
        [MaxPSD(i,:),MaxPSDfreq(i,:)] = max((squeeze(Fullspctrm(:,i,:)))');
        [R,p] = corr([trialduration(:,2) Fullfreq(MaxPSDfreq(i,:))']);
        % linear regression
%         observations(i,:) = (Fullfreq(MaxPSDfreq(i,:)))';
%         regressors = [ones(size(Fullspctrm,1),1) trialduration(:,1)];
%         [RegCoef,confI,Res,ResConfI,Stats] = regress(observations(i,:)',regressors);
%         model = RegCoef(1)*(ones(size(Fullspctrm,1),1))' + trialduration(1,:)*RegCoef(2);
        rho(i) = R(1,2);
        pval(i) = p(1,2);
        
        if pval(i) <= ptreshold
            selected(tmp)    = i;
            tmp = tmp + 1;
        end
        
%         indexcomp(i) = i;
    end
    
    [label2,label3,label1]     = grads_for_layouts(tag);
    chantypefull               = {'Mags';'Gradslong';'Gradslat'};
    
    chantypefull{j};   
    % load full spectra array
    chantype               = chantypefull{j};
    % select the corresponding power
    eval(['freq.powspctrm         = Fullspctrm']);
    freq.freq              = Fullfreq;
    trialnumber            = size(Fullspctrm,1);
    % complete dummy fieldtrip structure
    freq.dimord            = 'rpt_chan_freq';
    eval(['freq.label      = label' num2str(j) ';']);
    freq.cumtapcnt         = ones(trialnumber,length(freq.freq));
    
    clear cfg
    cfg.channel           = channeltype{1};
    cfg.xparam            = 'comp';
    cfg.zparam            = 'topo';
    cfg.zlim              = 'maxabs';
    cfg.baseline          = 'no';
    cfg.trials            = 'all';
    cfg.colormap          = jet;
    cfg.marker            = 'off';
    cfg.markersymbol      = 'none';
    cfg.markercolor       = [0 0 0];
    cfg.markersize        = 2;
    cfg.markerfontsize    = 8;
    cfg.colorbar          = 'yes';
    cfg.interplimits      = 'head';
    cfg.interpolation     = 'v4';
    cfg.style             = 'straight';
    cfg.gridscale         = 67;
    cfg.shading           = 'flat';
    cfg.interactive       = 'no';
    if isempty(selected)       ~= 1;
        cfg.highlight         = selected;
    else
        cfg.highlight         = 'off';
    end
    cfg.layout            = [root '/SCRIPTS/Layouts_fieldtrip/NM306mag.lay'];
    lay                   = ft_prepare_layout(cfg,freq);
    tmp                   = chan_index{1};
    lay.label             = 'MEG*1';
    cfg.layout            = lay;

    subplot(2,3,j)
    if isempty(selected)       ~= 1;
        cfg.electrodes = 'highlights';
    else
        cfg.electrodes = 'off';
    end
    topoplot(cfg,rho(1:102)');
    
end 
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
   