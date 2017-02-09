function Temprod_Dataviewer_ratio(subject,RunArray,freqband,chantype,K,visibility,plim,tag)

% set root
root = SetPath(tag);

%% (1) set data path and load data
ProcDataDir                = [root '/DATA/NEW/processed_' subject '/'];
freqpath                   = [ProcDataDir 'FT_spectra/BLOCKFREQ_RATIO_' chantype '_est' num2str(RunArray(1),'%02i') 'rep' num2str(RunArray(2),'%02i')...
    '_1_120Hz.mat'];
freq                       = load(freqpath);

%% round behav data
freq.durationsorted       = sortrows(freq.duration);

%store behavioural
freq.accuracysave         = freq.accuracy;
freq.durationsave         = freq.duration;
freq.durationsortedsave   = freq.durationsorted;
freq.mediandeviationsave  = freq.mediandeviation;

freq.accuracy(:,1)        = round((freq.accuracy(:,1))*100)/100;
freq.duration(:,1)        = round((freq.duration(:,1))*100)/100;
freq.durationsorted(:,1)  = round((freq.durationsorted(:,1))*100)/100;
freq.mediandeviation(:,1) = round((freq.mediandeviation(:,1))*100)/100;

% channel type definition
[Grads1,Grads2,Mags]     = grads_for_layouts(tag);
Eeg                      = EEG_for_layouts(tag);

% cluster index definition
[FIND,BIND,VIND,LIND,RIND,FCHANS,BCHANS,VCHANS,LCHANS,RCHANS] = clusteranat(tag);
if strcmp('Mags',chantype)
    clustindex = [LIND(1,:) RIND(1,:) BIND(1,:) VIND(1,:) FIND(1,:)];
elseif strcmp('Grads1',chantype)
    clustindex = [LIND(2,:) RIND(2,:) BIND(2,:) VIND(2,:) FIND(2,:)];
elseif strcmp('Grads2',chantype)
    clustindex = [LIND(3,:) RIND(3,:) BIND(3,:) VIND(3,:) FIND(3,:)];
end

%% (3) line noise removal by channel-by-channel linear interpolation replacemement
[freq.freq,freq.powspctrm] = LineNoiseInterp(freq.freq,freq.powspctrm);

%% (4) remove 1/f component
% if strcmp(debiasing,'yes')     == 1
%     [freq.freq,freq.powspctrm] = RemoveOneOverF(freq.freq,freq.powspctrm,'mean');
% end

%% (5) select frequency band
fbegin              = find(freq.freq >= freqband(1));
fend                = find(freq.freq <= freqband(2));
fband               = fbegin(1):fend(end);
freq.powspctrm      = freq.powspctrm(:,:,fband);
freq.freq           = freq.freq(fband);

freq.powspctrm      = exp(freq.powspctrm*log(10));

if strcmp(visibility,'on')
    
    %% plot results, zscores, averages across channels
    % prepare figure
    scrsz = get(0,'ScreenSize');
    fig                 = figure('position',scrsz);
    set(fig,'PaperPosition',scrsz)
    set(fig,'PaperPositionMode','auto')
    set(fig,'visible',visibility)
    % set(fig,'PaperType','A4')
    
    % index comments
    x = size(freq.powspctrm,3);
    y = size(freq.powspctrm,1);
    
    %% deviation to the median estimate
    sub1 = subplot(3,5,1);
    %% (6) smooting by convolution along the trial dimension
    freq.powspctrm1 = freq.powspctrm(freq.mediandeviation(:,2),:,:);
    datatoplot1     = ConvSmoothing(freq.powspctrm1,K);
    Max1            = max(max(squeeze(mean(datatoplot1,2))));
    Min1            = min(min(squeeze(mean(datatoplot1,2))));
    Mlim            = max(abs(1-Min1),abs(1-Max1));
    imagesc((squeeze(mean(datatoplot1,2))));
    xlabel('frequency (hz)');
    ylabel('deviation to median estimate (s)');
    title([chantype ': AVG est/rep pow ratio']);
    colorbar
    set(sub1,'XTick',5:round(length(freq.freq)/5):length(freq.freq),'XTickLabel',round(freq.freq(1:round(length(freq.freq)/5):length(freq.freq))*10)/10);
    set(sub1,'Ytick',1:round(length(freq.mediandeviation)/12):length(freq.mediandeviation),'Yticklabel',(freq.mediandeviation(1:round(length(freq.mediandeviation)/12):end,1)/1)');
    
    % compute freq correlations
    [MaxPSD,MaxPSDfreq,slope,Rf_med,pf_med] = trial_by_trial_corr(freq.freq,freq.powspctrm,freq.mediandeviationsave,'freq','max','Pearson');
    text([-x/0.8],[4*y/8] ,['fcorrR    = ' num2str(Rf_med(1,2)) ])
    text([-x/0.8],[5*y/8] ,['fcorrPval = ' num2str(pf_med(1,2))])
    % compute power correlations
    [MaxPSD,MaxPSDfreq,slope,Rp_med,pp_med] = trial_by_trial_corr(freq.freq,freq.powspctrm,freq.mediandeviationsave,'pow','max','Pearson');
    text([-x/0.8],[1*y/8],['PcorrR    = ' num2str(Rp_med(1,2)) ])
    text([-x/0.8],[2*y/8],['PcorrPval = ' num2str(pp_med(1,2))])
    % compute slope correlations
%     [MaxPSD,MaxPSDfreq,slope,Rs_med,ps_med] = trial_by_trial_corr(freq.freq,freq.powspctrm,freq.mediandeviationsave,'slope','max','Pearson');
%     text([-x/0.8],[7*y/8],['ScorrR    = ' num2str(Rs_med(1,2)) ])
%     text([-x/0.8],[8*y/8],['ScorrPval = ' num2str(ps_med(1,2))])
    
    %% sorted durations
    
    sub2 = subplot(3,5,6);
    %% (6) smooting by convolution along the trial dimension
    freq.powspctrm2 = freq.powspctrm(freq.durationsorted(:,2),:,:);
    datatoplot2     = ConvSmoothing(freq.powspctrm2,K);
    imagesc((squeeze(mean(datatoplot1,2))));
    xlabel('frequency (hz)');
    ylabel('Sorted durations (s)');
    title([chantype ': AVG est/rep pow ratio ']);
    colorbar
    set(sub2,'XTick',5:round(length(freq.freq)/5):length(freq.freq),'XTickLabel',round(freq.freq(1:round(length(freq.freq)/5):length(freq.freq))*10)/10);
    set(sub2,'Ytick',1:round(length(freq.durationsorted)/12):length(freq.durationsorted),'Yticklabel',(freq.durationsorted(1:round(length(freq.durationsorted)/12):end,1)/1)');
    
    % compute freq correlations
    [MaxPSD,MaxPSDfreq,slope,Rf_dur,pf_dur] = trial_by_trial_corr(freq.freq,freq.powspctrm,freq.durationsortedsave,'freq','max','Pearson');
    text([-x/0.8],[4*y/8] ,['fcorrR    = ' num2str(Rf_dur(1,2)) ])
    text([-x/0.8],[5*y/8] ,['fcorrPval = ' num2str(pf_dur(1,2))])
    % compute power correlations
    [MaxPSD,MaxPSDfreq,slope,Rp_dur,pp_dur] = trial_by_trial_corr(freq.freq,freq.powspctrm,freq.durationsortedsave,'pow','max','Pearson');
    text([-x/0.8],[1*y/8],['PcorrR    = ' num2str(Rp_dur(1,2)) ])
    text([-x/0.8],[2*y/8],['PcorrPval = ' num2str(pp_dur(1,2))])
    % compute slope correlations
%     [MaxPSD,MaxPSDfreq,slope,Rs_dur,ps_dur] = trial_by_trial_corr(freq.freq,freq.powspctrm,freq.durationsortedsave,'slope','max','Pearson');
%     text([-x/0.8],[7*y/8],['ScorrR    = ' num2str(Rs_dur(1,2)) ])
%     text([-x/0.8],[8*y/8],['ScorrPval = ' num2str(ps_dur(1,2))])
    
    %% sorted accuracies
    
    sub3 = subplot(3,5,11);
    %% (6) smooting by convolution along the trial dimension
    freq.powspctrm3 = freq.powspctrm(freq.accuracy(:,2),:,:);  
    datatoplot3     = ConvSmoothing(freq.powspctrm3,K);
    imagesc((squeeze(mean(datatoplot3,2))));
    xlabel('frequency (hz)');
    ylabel('Sorted accuracy');
    title([chantype ': AVG est/rep pow ratio']);
    colorbar
    set(sub3,'XTick',5:round(length(freq.freq)/5):length(freq.freq),'XTickLabel',round(freq.freq(1:round(length(freq.freq)/5):length(freq.freq))*10)/10);
    set(sub3,'Ytick',1:round(length(freq.accuracy)/12):length(freq.accuracy),'Yticklabel',(freq.accuracy(1:round(length(freq.accuracy)/12):end,1)/1)');
    
    % compute freq correlations
    [MaxPSD,MaxPSDfreq,slope,Rf_acc,pf_acc] = trial_by_trial_corr(freq.freq,freq.powspctrm,freq.accuracysave,'freq','max','Pearson');
    text([-x/0.8],[4*y/8] ,['fcorrR    = ' num2str(Rf_acc(1,2))])
    text([-x/0.8],[5*y/8] ,['fcorrPval = ' num2str(pf_acc(1,2))])
    % compute power correlations
    [MaxPSD,MaxPSDfreq,slope,Rp_acc,pp_acc] = trial_by_trial_corr(freq.freq,freq.powspctrm,freq.accuracysave,'pow','max','Pearson');
    text([-x/0.8],[1*y/8],['PcorrR    = ' num2str(Rp_acc(1,2))])
    text([-x/0.8],[2*y/8],['PcorrPval = ' num2str(pp_acc(1,2))])
    % compute slope correlations
%     [MaxPSD,MaxPSDfreq,slope,Rs_acc,ps_acc] = trial_by_trial_corr(freq.freq,freq.powspctrm,freq.accuracysave,'slope','max','Pearson');
%     text([-x/0.8],[7*y/8],['ScorrR    = ' num2str(Rs_acc(1,2))])
%     text([-x/0.8],[8*y/8],['ScorrPval = ' num2str(ps_acc(1,2))])
    
    %% plot topographies
    clear cfg
    cfg.channel           = 'all';
    cfg.xparam            = 'freq';
    cfg.zparam            = 'powspctrm';
    cfg.xlim              = [freq.freq(1) freq.freq(end)];
%     cfg.zlim              = [Min1 Max1];
    cfg.baseline          = 'no';
    cfg.trials            = 'all';
    cfg.colormap          = hot;
    cfg.marker            = 'off';
    cfg.markersymbol      = 'o';
    cfg.markercolor       = [0 1 1];
    cfg.markersize        = 2;
    cfg.markerfontsize    = 8;
    cfg.colorbar          = 'no';
    cfg.interplimits      = 'head';
    cfg.interpolation     = 'v4';
    cfg.style             = 'straight';
    cfg.gridscale         = 67;
    cfg.shading           = 'flat';
    cfg.interactive       = 'yes';
    cfg.fontsize          = 10;
    cfg.commentpos        = 'title';
    cfg.comment           = [subject ' ' chantype ];
    cfg.layout            = [root '/SCRIPTS/Layouts_fieldtrip/NM306mag.lay'];
    lay                   = ft_prepare_layout(cfg,freq);
    lay.label             = freq.label;
    cfg.layout            = lay;
    
    selectorp_cbc_med =[];
    a = 1;
    for i = 1:size(freq.powspctrm1,2)
        [MaxPSD_tosave{i},MaxPSDfreq_tosave{i},Slope_tosave{i},Rp_cbc_med,pp_cbc_med] = trial_by_trial_corr(freq.freq,freq.powspctrm1(:,i,:),freq.mediandeviationsave,'pow','max','Pearson');
        MaxPSDfreq_tosave{i} = freq.freq(MaxPSDfreq_tosave{i});
        pval(i) = pp_cbc_med(1,2);
        powtoplot(:,i) = MaxPSD_tosave{i}';
        if pval(i) < plim
            selectorp_cbc_med(a) = i;
            a = a+1;
        end
    end
    % MaxPSD_ts     = MaxPSD_tosave;
    % MaxPSDfreq_ts = MaxPSDfreq_tosave;
    
    % plot trial-by-trial and chan-by-chan power
    sub4 = subplot(3,5,2);
    imagesc(ConvSmoothing(powtoplot(:,clustindex),K))
    xlabel('channel numbers')
    set(sub4,'Xtick',[12 37 62 80 94],'Xticklabel',{'L';'R';'O';'C';'F'});
    set(sub4,'Ytick',1:round(length(freq.mediandeviation)/12):length(freq.mediandeviation),'Yticklabel',(freq.mediandeviation(1:round(length(freq.mediandeviation)/12):end,1)/1)');
    colorbar
    title(['tbt cbc pow ratio '])
    
    if isempty(selectorp_cbc_med) ~= 1
        cfg.highlight          = 'on' ;
        cfg.colormap           = hot;
        cfg.highlightchannel   =  selectorp_cbc_med';
        cfg.highlightsize      = 20;
        cfg.highlightfonts     = 20;
        cfg.highlightsymbol    = '.';
        cfg.highlightcolor     = [0 0 0];
        cfg.fontsize           = 10;
        cfg.comment            = [subject '-' chantype  ', corr: pow ratio vs med deviation'];
        cfg.commentpos         = 'title';
        subplot(3,5,3)
%         cfg.zlim               = [Min1 Max1];
        topoplotER(cfg,freq)
    else
        cfg.fontsize          = 10;
        cfg.colormap          = hot;
        cfg.commentpos        = 'title';
        cfg.comment           = [subject '-' chantype  ', corr: pow ratio vs med deviation'];
        subplot(3,5,3)
%         cfg.zlim               = [Min1 Max1];
        topoplotER(cfg,freq)
    end
    colorbar
    
    selectorf_cbc_med = [];
    a = 1;
    for i = 1:size(freq.powspctrm1,2)
        [MaxPSD_med{i},MaxPSDfreq_med{i},Slope_tosave{i},Rf_cbc_med,pf_cbc_med] = trial_by_trial_corr(freq.freq,freq.powspctrm1(:,i,:),freq.mediandeviationsave,'freq','max','Pearson');
        pval(i)         = pf_cbc_med(1,2);
        freqtoplot(:,i) = freq.freq(MaxPSDfreq_med{i});
        if pval(i) < plim
            selectorf_cbc_med(a) = i;
            a = a+1;
        end
    end
    clear MaxPSD_med MaxPSDfreq_med
    colorbar
    
    % plot trial-by-trial and chan-by-chan frequency
    sub5 = subplot(3,5,4);
    imagesc(ConvSmoothing(freqtoplot(:,clustindex),K),freqband)
    xlabel('channel numbers')
    set(sub5,'Xtick',[12 37 62 80 94],'Xticklabel',{'L';'R';'O';'C';'F'});
    set(sub5,'Ytick',1:round(length(freq.mediandeviation)/12):length(freq.mediandeviation),'Yticklabel',(freq.mediandeviation(1:round(length(freq.mediandeviation)/12):end,1)/1)');
    colorbar
    title(['tbt cbc frequency peak)'])
    
    if isempty(selectorf_cbc_med) ~= 1
        cfg                    = [];
        cfg.interplimits      = 'head';
        cfg.interpolation     = 'v4';
        cfg.style             = 'straight';
        cfg.gridscale         = 67;
        cfg.shading           = 'flat';
        cfg.layout             = lay;
        cfg.highlight          = selectorf_cbc_med' ;
        cfg.electrodes         = 'highlights';
        cfg.hlmarker           = 'o';
        cfg.hlcolor            = [0 0 0];
        cfg.maplimits          = 'maxmin';
        cfg.hlmarkersize       = 1.5;
        cfg.hllinewidth        = 6;
        cfg.fontsize           = 10;
        cfg.colormap           = hot;
        cfg.commentpos         = 'title';
        cfg.comment            = [subject '-' chantype  ', corr: FP vs med deviation'];
        subplot(3,5,5)
        cfg.zlim               = freqband;
        topoplot(cfg,(mean(freqtoplot)'))
    else
        cfg                    = [];
        cfg.interplimits       = 'head';
        cfg.interpolation      = 'v4';
        cfg.style              = 'straight';
        cfg.gridscale          = 67;
        cfg.shading            = 'flat';
        cfg.layout             = lay;
        cfg.electrodes         = 'off' ;
        cfg.hlmarker           = 'o';
        cfg.hlcolor            = [0 0 0];
        cfg.maplimits          = 'maxmin';
        cfg.hlmarkersize       = 1.5;
        cfg.hllinewidth        = 6;
        cfg.colormap           = hot;
        cfg.fontsize           = 10;
        cfg.commentpos         = 'title';
        cfg.comment            = [subject '-' chantype  ', corr: FP vs med deviation'];
        subplot(3,5,5)
        cfg.zlim               = freqband;
        topoplot(cfg,(mean(freqtoplot)'))
    end
    colorbar
    
    %%
    selectorp_cbc_dur     = [];
    clear cfg
    cfg.channel           = 'all';
    cfg.xparam            = 'freq';
    cfg.zparam            = 'powspctrm';
    cfg.xlim              = freqband;
%     cfg.zlim              = [Min1 Max1];
    cfg.baseline          = 'no';
    cfg.trials            = 'all';
    cfg.colormap          = hot;
    cfg.marker            = 'off';
    cfg.markersymbol      = 'o';
    cfg.markercolor       = [0 1 1];
    cfg.markersize        = 2;
    cfg.markerfontsize    = 8;
    cfg.colorbar          = 'no';
    cfg.interplimits      = 'head';
    cfg.interpolation     = 'v4';
    cfg.style             = 'straight';
    cfg.gridscale         = 67;
    cfg.shading           = 'flat';
    cfg.interactive       = 'yes';
    cfg.fontsize          = 10;
    cfg.commentpos        = 'title';
    cfg.comment           = [subject '_' chantype ];
    cfg.layout            = [root '/SCRIPTS/Layouts_fieldtrip/NM306mag.lay'];
    lay                   = ft_prepare_layout(cfg,freq);
    lay.label             = freq.label;
    cfg.layout            = lay;
    a = 1;
    for i = 1:size(freq.powspctrm2,2)
        [MaxPSD_tosave{i},MaxPSDfreq_tosave{i},Slope_tosave{i},Rp_cbc_dur,pp_cbc_dur] = trial_by_trial_corr(freq.freq,freq.powspctrm2(:,i,:),freq.durationsortedsave,'pow','max','Pearson');
        pval(i) = pp_cbc_dur(1,2);
        powtoplot(:,i) = MaxPSD_tosave{i}';
        if pval(i) < plim
            selectorp_cbc_dur(a) = i;
            a = a+1;
        end
    end
    clear MaxPSD_tosave MaxPSDfreq_tosave
    
    % plot trial-by-trial and chan-by-chan power
    sub7 = subplot(3,5,7);
    imagesc(ConvSmoothing(powtoplot(:,clustindex),K))
    xlabel('channel numbers')
    set(sub7,'Xtick',[12 37 62 80 94],'Xticklabel',{'L';'R';'O';'C';'F'});
    set(sub7,'Ytick',1:round(length(freq.durationsorted)/12):length(freq.durationsorted),'Yticklabel',(freq.durationsorted(1:round(length(freq.durationsorted)/12):end,1)/1)');
    colorbar
    title(['tbt cbc pow ratio '])
    
    if isempty(selectorp_cbc_dur) ~= 1
        cfg.colormap          = hot;
        cfg.highlight          = 'on' ;
        cfg.highlightchannel   = selectorp_cbc_dur';
        cfg.highlightsize      = 20;
        cfg.highlightfonts     = 20;
        cfg.highlightsymbol    = '.';
        cfg.highlightcolor     = [0 0 0];
        cfg.fontsize          = 10;
        cfg.commentpos        = 'title';
        cfg.comment           = [subject '-' chantype  ', corr: pow ratio vs sorted durations'];
        subplot(3,5,8)
%         cfg.zlim              = [Min1 Max1];
        topoplotER(cfg,freq)
    else
        cfg.colormap          = hot;
        cfg.fontsize          = 10;
        cfg.commentpos        = 'title';
        cfg.comment           = [subject '-' chantype  ', corr: pow ratio vs sorted durations'];
        subplot(3,5,8)
%         cfg.zlim              = [Min1 Max1];
        topoplotER(cfg,freq)
    end
    colorbar
    
    selectorf_cbc_dur = [];
    a = 1;
    for i = 1:size(freq.powspctrm2,2)
        [MaxPSD_SortedD{i},MaxPSDfreq_SortedD{i},Slope_tosave{i},Rf_cbc_dur,pf_cbc_dur] = trial_by_trial_corr(freq.freq,freq.powspctrm2(:,i,:),freq.durationsortedsave,'freq','max','Pearson');
        pval(i)         = pf_cbc_dur(1,2);
        freqtoplot(:,i) = freq.freq(MaxPSDfreq_SortedD{i});
        if pval(i) < plim
            selectorf_cbc_dur(a) = i;
            a = a+1;
        end
    end
    clear MaxPSD_SortedD MaxPSDfreq_SortedD
    
    % plot trial-by-trial and chan-by-chan frequency
    sub9 = subplot(3,5,9);
    imagesc(ConvSmoothing(freqtoplot(:,clustindex),K),freqband)
    xlabel('channel numbers')
    set(sub9,'Xtick',[12 37 62 80 94],'Xticklabel',{'L';'R';'O';'C';'F'});
    set(sub9,'Ytick',1:round(length(freq.durationsorted)/12):length(freq.durationsorted),'Yticklabel',(freq.durationsorted(1:round(length(freq.durationsorted)/12):end,1)/1)');
    colorbar
    title(['tbt cbc frequency peak)'])
    
    if isempty(selectorf_cbc_dur) ~= 1
        cfg                    = [];
        cfg.colormap          = hot;
        cfg.interplimits      = 'head';
        cfg.interpolation     = 'v4';
        cfg.style             = 'straight';
        cfg.gridscale         = 67;
        cfg.shading           = 'flat';
        cfg.layout             = lay;
        cfg.highlight          = selectorf_cbc_dur' ;
        cfg.electrodes         = 'highlights';
        cfg.hlmarker           = 'o';
        cfg.hlcolor            = [0 0 0];
        cfg.maplimits          = 'maxmin';
        cfg.hlmarkersize       = 1.5;
        cfg.hllinewidth        = 6;
        cfg.fontsize          = 10;
        cfg.commentpos        = 'title';
        cfg.comment            = [subject '-' chantype  ', corr: FP vs sorted durations'];
        subplot(3,5,10)
        cfg.zlim              = freqband;
        topoplot(cfg,(mean(freqtoplot)'))
    else
        cfg                    = [];
        cfg.colormap          = hot;
        cfg.interplimits       = 'head';
        cfg.interpolation      = 'v4';
        cfg.style              = 'straight';
        cfg.gridscale          = 67;
        cfg.shading            = 'flat';
        cfg.layout             = lay;
        cfg.electrodes         = 'off' ;
        cfg.hlmarker           = 'o';
        cfg.hlcolor            = [0 0 0];
        cfg.maplimits          = 'maxmin';
        cfg.hlmarkersize       = 1.5;
        cfg.hllinewidth        = 6;
        cfg.fontsize          = 10;
        cfg.commentpos        = 'title';
        cfg.comment            = [subject '-' chantype  ', corr: FP vs sorted durations'];
        subplot(3,5,10)
        cfg.zlim              = freqband;
        topoplot(cfg,(mean(freqtoplot)'))
    end
    colorbar
    
    %%
    selectorp_cbc_acc     = [];
    clear cfg
    cfg.channel           = 'all';
    cfg.xparam            = 'freq';
    cfg.zparam            = 'powspctrm';
    cfg.xlim              = freqband;
%     cfg.zlim              = [Min1 Max1];
    cfg.baseline          = 'no';
    cfg.trials            = 'all';
    cfg.colormap          = hot;
    cfg.marker            = 'off';
    cfg.markersymbol      = 'o';
    cfg.markercolor       = [0 1 1];
    cfg.markersize        = 2;
    cfg.markerfontsize    = 8;
    cfg.colorbar          = 'no';
    cfg.interplimits      = 'head';
    cfg.interpolation     = 'v4';
    cfg.style             = 'straight';
    cfg.gridscale         = 67;
    cfg.shading           = 'flat';
    cfg.interactive       = 'yes';
    cfg.layout            = [root '/SCRIPTS/Layouts_fieldtrip/NM306mag.lay'];
    lay                   = ft_prepare_layout(cfg,freq);
    lay.label             = freq.label;
    cfg.layout            = lay;
    a = 1;
    for i = 1:size(freq.powspctrm3,2)
        [MaxPSD_acc{i},MaxPSDfreq_acc{i},Slope_tosave{i},Rp_cbc_acc,pp_cbc_acc] = trial_by_trial_corr(freq.freq,freq.powspctrm3(:,i,:),freq.accuracysave,'pow','max','Pearson');
        pval(i) = pp_cbc_acc(1,2);
        powtoplot(:,i) = MaxPSD_acc{i}';
        if pval(i) < plim
            selectorp_cbc_acc(a) = i;
            a = a+1;
        end
    end
    clear MaxPSD_acc MaxPSDfreq_acc
    
    % plot trial-by-trial and chan-by-chan power
    sub12 = subplot(3,5,12);
    imagesc(ConvSmoothing(powtoplot(:,clustindex),K))
    xlabel('channel numbers')
    set(sub12,'Xtick',[12 37 62 80 94],'Xticklabel',{'L';'R';'O';'C';'F'});
    set(sub12,'Ytick',1:round(length(freq.accuracy)/12):length(freq.accuracy),'Yticklabel',(freq.accuracy(1:round(length(freq.accuracy)/12):end,1)/1)');
    colorbar
    title(['tbt cbc pow ratio '])
    
    if isempty(selectorp_cbc_acc) ~= 1
        cfg.colormap          = hot;
        cfg.highlight          = 'on' ;
        cfg.highlightchannel   = selectorp_cbc_acc';
        cfg.highlightsize      = 20;
        cfg.highlightfonts     = 20;
        cfg.highlightsymbol    = '.';
        cfg.highlightcolor     = [0 0 0];
        cfg.fontsize          = 10;
        cfg.commentpos        = 'title';
        cfg.comment           = [subject '-' chantype  ', corr: pow ratio vs accuracy'];
        subplot(3,5,13)
%         cfg.zlim              = [Min1 Max1];
        topoplotER(cfg,freq)
    else
        cfg.colormap          = hot;
        cfg.fontsize          = 10;
        cfg.commentpos        = 'title';
        cfg.comment           = [subject '-' chantype  ', corr: pow ratio vs accuracy'];
        subplot(3,5,13)
%         cfg.zlim              = [Min1 Max1];
        topoplotER(cfg,freq)
    end
    colorbar
    
    selectorf_cbc_acc = [];
    a = 1;
    for i = 1:size(freq.powspctrm3,2)
        [MaxPSD_acc{i},MaxPSDfreq_acc{i},Slope_tosave{i},Rf_cbc_acc,pf_cbc_acc] = trial_by_trial_corr(freq.freq,freq.powspctrm3(:,i,:),freq.accuracysave,'freq','max','Pearson');
        pval(i)         = pf_cbc_acc(1,2);
        freqtoplot(:,i) = freq.freq(MaxPSDfreq_acc{i});
        if pval(i) < plim
            selectorf_cbc_acc(a) = i;
            a = a+1;
        end
    end
    clear MaxPSD_acc MaxPSDfreq_acc
    
    % plot trial-by-trial and chan-by-chan frequency
    sub14 = subplot(3,5,14);
    imagesc(ConvSmoothing(freqtoplot(:,clustindex),K),freqband)
    xlabel('channel numbers')
    set(sub14,'Xtick',[12 37 62 80 94],'Xticklabel',{'L';'R';'O';'C';'F'});
    set(sub14,'Ytick',1:round(length(freq.accuracy)/12):length(freq.accuracy),'Yticklabel',(freq.accuracy(1:round(length(freq.accuracy)/12):end,1)/1)');
    colorbar
    title(['tbt cbc frequency peak)'])
    
    if isempty(selectorf_cbc_acc) ~= 1
        cfg                    = [];
        cfg.colormap          = hot;
        cfg.interplimits      = 'head';
        cfg.interpolation     = 'v4';
        cfg.style             = 'straight';
        cfg.gridscale         = 67;
        cfg.shading           = 'flat';
        cfg.layout             = lay;
        cfg.highlight          = selectorf_cbc_acc' ;
        cfg.electrodes         = 'highlights';
        cfg.hlmarker           = 'o';
        cfg.hlcolor            = [0 0 0];
        cfg.maplimits          = 'maxmin';
        cfg.hlmarkersize       = 1.5;
        cfg.hllinewidth        = 6;
        cfg.fontsize          = 10;
        cfg.commentpos        = 'title';
        cfg.comment            = [subject '-' chantype  ', corr: FP vs accuracy'];
        subplot(3,5,15)
        cfg.zlim              = freqband;
        topoplot(cfg,(mean(freqtoplot)'))
    else
        cfg                    = [];
        cfg.colormap          = hot;
        cfg.interplimits       = 'head';
        cfg.interpolation      = 'v4';
        cfg.style              = 'straight';
        cfg.gridscale          = 67;
        cfg.shading            = 'flat';
        cfg.layout             = lay;
        cfg.electrodes         = 'off' ;
        cfg.hlmarker           = 'o';
        cfg.hlcolor            = [0 0 0];
        cfg.maplimits          = 'maxmin';
        cfg.hlmarkersize       = 1.5;
        cfg.hllinewidth        = 6;
        cfg.fontsize          = 10;
        cfg.commentpos        = 'title';
        cfg.comment            = [subject '-' chantype  ', corr: FP vs accuracy'];
        subplot(3,5,15)
        cfg.zlim              = freqband;
        topoplot(cfg,(mean(freqtoplot)'))
    end
    colorbar
    
    a = 1;
    for i = 1:size(freq.powspctrm,2)
        [MaxPSD_tosave{i},MaxPSDfreq_tosave{i},Slope_tosave{i},R,p] = trial_by_trial_corr(freq.freq,freq.powspctrm(:,i,:),freq.durationsave,'pow','max','Pearson');
        MaxPSDfreq_tosave{i} = freq.freq(MaxPSDfreq_tosave{i});
        pval(i) = p(1,2);
        powtoplot(:,i) = MaxPSD_tosave{i}';
        if pval(i) < plim
            selector(a) = i;
            a = a+1;
        end
    end
    
    POWER           = MaxPSD_tosave;
    FREQUENCY       = MaxPSDfreq_tosave;
    SLOPE           = Slope_tosave;
    DURATIONSORTED  = freq.durationsortedsave;
    ACCURACY        = freq.accuracysave;
    MEDDEVIATION    = freq.mediandeviationsave;
    
    
    savepath = [ProcDataDir 'FT_spectra/POW+FREQ_' chantype '_RUN' num2str(RunArray(1),'%02i') ...
        '-' num2str(RunArray(2),'%02i') '_' num2str(freqband(1)) '_' num2str(freqband(2)) 'Hz_' num2str(plim) '.mat'];
    save(savepath,'POWER','FREQUENCY','DURATIONSORTED','ACCURACY','MEDDEVIATION',...
        'Rf_dur'    ,'Rf_med'    ,'Rf_acc'    ,'pf_dur'    ,'pf_med'    ,'pf_acc'    ,...
        'Rp_dur'    ,'Rp_med'    ,'Rp_acc'    ,'pp_dur'    ,'pp_med'    ,'pp_acc'    ,...
        'Rf_cbc_dur','Rf_cbc_med','Rf_cbc_acc','pf_cbc_dur','pf_cbc_med','pf_cbc_acc',...
        'Rp_cbc_dur','Rp_cbc_med','Rp_cbc_acc','pp_cbc_dur','pp_cbc_med','pp_cbc_acc',...
        'selectorf_cbc_dur','selectorp_cbc_dur',...
        'selectorf_cbc_med','selectorp_cbc_med',...
        'selectorf_cbc_acc','selectorp_cbc_acc','-v7.3');
end

colormap('jet')

print('-dpng',['C:\TEMPROD\DATA\NEW\Plots_' subject '\POW+FREQ_RATIO_' chantype '_RUN' num2str(RunArray(1),'%02i') ...
        '-' num2str(RunArray(2),'%02i') '_' num2str(freqband(1)) '_' num2str(freqband(2)) 'Hz.png'])

