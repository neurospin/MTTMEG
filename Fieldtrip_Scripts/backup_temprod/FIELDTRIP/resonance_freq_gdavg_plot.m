function resonance_freq_gdavg_plot(nip)

freqvalues = [50 75 100 150 200 300 400 600];
r_freqvalues = [50 83.3 100 150 200 300 400 600];

% Mags

scrsz = get(0,'ScreenSize');
fig   = figure('position',scrsz);
set(fig,'PaperPosition',scrsz)
set(fig,'PaperPositionMode','auto')

for i = 1:length(freqvalues)
    load(['C:\RESONANCE_MEG\DATA\' nip '\freq\Mags_freqsub_' num2str(freqvalues(i)) '_stimfreq.mat']);
    load(['C:\RESONANCE_MEG\DATA\' nip '\freq\Mags_freqsuball_baseline.mat']);    
    subplot(4,2,i)
    loglog(FREQSUB.freq,mean(FREQSUB.powspctrm),'linewidth',2,'color','b'); hold on
    loglog(FREQB_allcond.freq,mean(FREQB_allcond.powspctrm),'linewidth',2,'color','r'); hold on
    set(gca,'xtick',[0.8 1.25 1.7 2.5 3.3 5 6.7 10 13.3 20 40 80],'xticklabel',[0.83 1.25 1.67 2.5 3.3 5 6.7 10 13.3 20 40 80])
    axis([0.5 120 (min(mean(FREQSUB.powspctrm(:,10:end)))) (max(mean(FREQSUB.powspctrm(:,10:end))))])
    title([num2str(freqvalues(i)) ' ms'],'fontsize',12)
    xlabel('frequency');ylabel('power');
end

print('-dpng',['C:\RESONANCE_MEG\DATA\' nip '\plots\Mags_freqsub_' nip '.png'])

for i = 1:length(freqvalues)
   
    load(['C:\RESONANCE_MEG\DATA\' nip '\freq\Mags_freqsub_' num2str(freqvalues(i)) '_stimfreq_keep.mat']);
    load(['C:\RESONANCE_MEG\DATA\' nip '\freq\Mags_freqsub_' num2str(freqvalues(i)) '_baseline_keep.mat']);      
    
    % get neighbourgs for statistical testing
    load('C:\TEMPROD\SCRIPTS\Matlab_pipeline\tools_tmp\pipeline_tmp\neighbours.mat')
%     load('C:\TEMPROD\SCRIPTS\Layouts_fieldtrip\neuromag306_neighb.mat')
    for a = 1:104
         neighbours{1,a}.label = ['MEG' neighbours{1,a}.label];
        for b = 1:length(neighbours{1,a}.neighblabel)
            neighbours{1,a}.neighblabel{b} = ['MEG' neighbours{1,a}.neighblabel{b}];
        end
    end
    
    
    % prepare layout
    cfg                           = [];
    cfg.layout                    = 'C:\TEMPROD\SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
    lay1                          = ft_prepare_layout(cfg,FREQSUB);
    lay1.label                    = FREQSUB.label;
    
    % find SSR fund power valuevalue
    fbegin = []; fend = [];
    fbegin              = find(FREQSUB.freq >= (1000/r_freqvalues(i)));
    fend                = find(FREQSUB.freq < (1000/r_freqvalues(i)));
    if abs(1000/r_freqvalues(i) - FREQSUB.freq(fbegin(1))) <= abs(1000/r_freqvalues(i) - FREQSUB.freq(fend(end)))
        f_fund_ind      = fbegin(1);
    else
        f_fund_ind      = fend(end);
    end
    
    % test based on fieldtrip tutorial
    cfg = [];
    cfg.channel          = 'all';
    cfg.latency          = 'all';
    cfg.frequency        = [FREQSUB.freq(f_fund_ind) FREQSUB.freq(f_fund_ind)];
    cfg.method           = 'montecarlo';
    cfg.statistic        = 'indepsamplesT';
    cfg.correctm         = 'cluster';
    cfg.clusteralpha     = 0.05;
    cfg.clusterstatistic = 'maxsum';
    cfg.minnbchan        = 0;
    cfg.tail             = 0;
    cfg.clustertail      = 0;
    cfg.alpha            = 0.025;
    cfg.numrandomization = 500;
    cfg.neighbours       = neighbours;
    
    nsub = size(FREQSUB.powspctrm,1);
    
    design = zeros(2,nsub + nsub);
    design(1,1:nsub) = 1:nsub;
    design(1,(nsub+1):2*nsub) = 1:nsub;
    design(2,1:nsub) = 1;
    design(2,(nsub+1):2*nsub) = 2;
    
    cfg.design           = design(2,:);
%     cfg.uvar  = 1;
    cfg.ivar  = 1;
    
    [stat] = ft_freqstatistics(cfg,FREQSUB,FREQbSUB);
    STATS{i} = stat;
    
    if sum(STATS{i}.mask) ~= 0
        cfg                           = [];
        cfg.layout                    = lay1;
        cfg.alpha                     = 0.05;
        cfg.highlightseries           = {'on','on','off','off','off'}; 
        cfg.highlightsymbolseries     = ['.','.','.','.','.'];
        cfg.highlightsizeseries       = [25 25 25 25 25];
        cfg.highlightcolorpos         = [0 0 0];
        cfg.highlightcolorneg         = [1 1 1];
        cfg.parameter                 = 'stat';
        cfg.style                     = 'straight';
        cfg.zlim                      = [-20 20];
        ft_clusterplot(cfg, STATS{1,i});
        print('-dpng',['C:\RESONANCE_MEG\DATA\' nip '\plots\Mags_indepsamplesT_' num2str(freqvalues(i))]);
    end
    
end
    

freqvalues = [50 75 100 150 200 300 400 600];

scrsz = get(0,'ScreenSize');
fig   = figure('position',scrsz);
set(fig,'PaperPosition',scrsz)
set(fig,'PaperPositionMode','auto')

for i = 1:length(freqvalues)
    load(['C:\RESONANCE_MEG\DATA\' nip '\freq\Mags_freqsub_' num2str(freqvalues(i)) '_stimfreq.mat']);
    load(['C:\RESONANCE_MEG\DATA\' nip '\freq\Mags_freqsuball_baseline.mat']);  
    subplot(4,2,i)
    tmp = [];
    tmp = mean(FREQSUB.powspctrm) - mean(FREQB_allcond.powspctrm);
    semilogx(FREQSUB.freq,tmp,'linewidth',2,'color','k'); hold on
    set(gca,'xtick',[0.8 1.25 1.7 2.5 3.3 5 6.7 10 13.3 20 40 80],'xticklabel',[0.83 1.25 1.67 2.5 3.3 5 6.7 10 13.3 20 40 80])
    axis([0.8 120 (min(tmp(:,10:end))) (max(tmp(:,10:end)))])
    title([nip ' : ' num2str(freqvalues(i)) ' ms'],'fontsize',12)
    xlabel('frequency');ylabel('power');
end

print('-dpng',['C:\RESONANCE_MEG\DATA\' nip '\plots\Mags_freqdiffsub_' nip '.png'])

% GradS1
scrsz = get(0,'ScreenSize');
fig   = figure('position',scrsz);
set(fig,'PaperPosition',scrsz)
set(fig,'PaperPositionMode','auto')

for i = 1:length(freqvalues)
    load(['C:\RESONANCE_MEG\DATA\' nip '\freq\Grads1_freqsub_' num2str(freqvalues(i)) '_stimfreq.mat']);
    load(['C:\RESONANCE_MEG\DATA\' nip '\freq\Grads1_freqsuball_baseline.mat']);    
    subplot(4,2,i)
    loglog(FREQSUB.freq,mean(FREQSUB.powspctrm),'linewidth',2,'color','b'); hold on
    loglog(FREQB_allcond.freq,mean(FREQB_allcond.powspctrm),'linewidth',2,'color','r'); hold on
    set(gca,'xtick',[0.8 1.25 1.7 2.5 3.3 5 6.7 10 13.3 20 40 80],'xticklabel',[0.83 1.25 1.67 2.5 3.3 5 6.7 10 13.3 20 40 80])
    axis([0.5 120 (min(mean(FREQSUB.powspctrm(:,10:end)))) (max(mean(FREQSUB.powspctrm(:,10:end))))])
    title([num2str(freqvalues(i)) ' ms'],'fontsize',12)
    xlabel('frequency');ylabel('power');
end

print('-dpng',['C:\RESONANCE_MEG\DATA\' nip '\plots\Grads1_freqsub_' nip '.png'])


for i = 1:length(freqvalues)
   
    load(['C:\RESONANCE_MEG\DATA\' nip '\freq\Grads1_freqsub_' num2str(freqvalues(i)) '_stimfreq_keep.mat']);
    load(['C:\RESONANCE_MEG\DATA\' nip '\freq\Grads1_freqsub_' num2str(freqvalues(i)) '_baseline_keep.mat']);      
    
    FREQSUB.label  = lay1.label;
    FREQbSUB.label = lay1.label;
    
    % get neighbourgs for statistical testing
    load('C:\TEMPROD\SCRIPTS\Matlab_pipeline\tools_tmp\pipeline_tmp\neighbours.mat')
%     load('C:\TEMPROD\SCRIPTS\Layouts_fieldtrip\neuromag306_neighb.mat')
    for a = 1:104
         neighbours{1,a}.label = ['MEG' neighbours{1,a}.label];
        for b = 1:length(neighbours{1,a}.neighblabel)
            neighbours{1,a}.neighblabel{b} = ['MEG' neighbours{1,a}.neighblabel{b}];
        end
    end
    
    
    % prepare layout
    cfg                           = [];
    cfg.layout                    = 'C:\TEMPROD\SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
    lay1                          = ft_prepare_layout(cfg,FREQSUB);
    lay1.label                    = FREQSUB.label;
    
    % find SSR fund power valuevalue
    fbegin = []; fend = [];
    fbegin              = find(FREQSUB.freq >= (1000/r_freqvalues(i)));
    fend                = find(FREQSUB.freq < (1000/r_freqvalues(i)));
    if abs(1000/r_freqvalues(i) - FREQSUB.freq(fbegin(1))) <= abs(1000/r_freqvalues(i) - FREQSUB.freq(fend(end)))
        f_fund_ind      = fbegin(1);
    else
        f_fund_ind      = fend(end);
    end
    
    % test based on fieldtrip tutorial
    cfg = [];
    cfg.channel          = 'all';
    cfg.latency          = 'all';
    cfg.frequency        = [FREQSUB.freq(f_fund_ind) FREQSUB.freq(f_fund_ind)];
    cfg.method           = 'montecarlo';
    cfg.statistic        = 'indepsamplesT';
    cfg.correctm         = 'cluster';
    cfg.clusteralpha     = 0.05;
    cfg.clusterstatistic = 'maxsum';
    cfg.minnbchan        = 0;
    cfg.tail             = 0;
    cfg.clustertail      = 0;
    cfg.alpha            = 0.025;
    cfg.numrandomization = 500;
    cfg.neighbours       = neighbours;
    
    nsub = size(FREQSUB.powspctrm,1);
    
    design = zeros(2,nsub + nsub);
    design(1,1:nsub) = 1:nsub;
    design(1,(nsub+1):2*nsub) = 1:nsub;
    design(2,1:nsub) = 1;
    design(2,(nsub+1):2*nsub) = 2;
    
    cfg.design           = design(2,:);
%     cfg.uvar  = 1;
    cfg.ivar  = 1;
    
    [stat] = ft_freqstatistics(cfg,FREQSUB,FREQbSUB);
    STATS{i} = stat;
    
    if sum(STATS{i}.mask) ~= 0
        cfg                           = [];
        cfg.layout                    = lay1;
        cfg.alpha                     = 0.05;
        cfg.highlightseries           = {'on','on','off','off','off'}; 
        cfg.highlightsymbolseries     = ['.','.','.','.','.'];
        cfg.highlightsizeseries       = [25 25 25 25 25];
        cfg.highlightcolorpos         = [0 0 0];
        cfg.highlightcolorneg         = [1 1 1];
        cfg.parameter                 = 'stat';
        cfg.style                     = 'straight';
        cfg.zlim                      = [-20 20];
        ft_clusterplot(cfg, STATS{1,i});
        print('-dpng',['C:\RESONANCE_MEG\DATA\' nip '\plots\Grads1_indepsamplesT_' num2str(freqvalues(i))]);
    end
    
end

freqvalues = [50 75 100 150 200 300 400 600];

scrsz = get(0,'ScreenSize');
fig   = figure('position',scrsz);
set(fig,'PaperPosition',scrsz)
set(fig,'PaperPositionMode','auto')

for i = 1:length(freqvalues)
    load(['C:\RESONANCE_MEG\DATA\' nip '\freq\Grads1_freqsub_' num2str(freqvalues(i)) '_stimfreq.mat']);
    load(['C:\RESONANCE_MEG\DATA\' nip '\freq\Grads1_freqsuball_baseline.mat']);  
    subplot(4,2,i)
    tmp = [];
    tmp = mean(FREQSUB.powspctrm) - mean(FREQB_allcond.powspctrm);
    semilogx(FREQSUB.freq,tmp,'linewidth',2,'color','k'); hold on
    set(gca,'xtick',[0.8 1.25 1.7 2.5 3.3 5 6.7 10 13.3 20 40 80],'xticklabel',[0.83 1.25 1.67 2.5 3.3 5 6.7 10 13.3 20 40 80])
    axis([0.8 120 (min(tmp(:,10:end))) (max(tmp(:,10:end)))])
    title([nip ' : ' num2str(freqvalues(i)) ' ms'],'fontsize',12)
    xlabel('frequency');ylabel('power');
end

print('-dpng',['C:\RESONANCE_MEG\DATA\' nip '\plots\Grads1_freqdiffsub_' nip '.png'])

% Grads2
scrsz = get(0,'ScreenSize');
fig   = figure('position',scrsz);
set(fig,'PaperPosition',scrsz)
set(fig,'PaperPositionMode','auto')

for i = 1:length(freqvalues)
    load(['C:\RESONANCE_MEG\DATA\' nip '\freq\Grads2_freqsub_' num2str(freqvalues(i)) '_stimfreq.mat']);
    load(['C:\RESONANCE_MEG\DATA\' nip '\freq\Grads2_freqsuball_baseline.mat']);    
    subplot(4,2,i)
    loglog(FREQSUB.freq,mean(FREQSUB.powspctrm),'linewidth',2,'color','b'); hold on
    loglog(FREQB_allcond.freq,mean(FREQB_allcond.powspctrm),'linewidth',2,'color','r'); hold on
    set(gca,'xtick',[0.8 1.25 1.7 2.5 3.3 5 6.7 10 13.3 20 40 80],'xticklabel',[0.83 1.25 1.67 2.5 3.3 5 6.7 10 13.3 20 40 80])
    axis([0.5 120 (min(mean(FREQSUB.powspctrm(:,10:end)))) (max(mean(FREQSUB.powspctrm(:,10:end))))])
    title([num2str(freqvalues(i)) ' ms'],'fontsize',12)
    xlabel('frequency');ylabel('power');
end

print('-dpng',['C:\RESONANCE_MEG\DATA\' nip '\plots\Grads2_freqsub_' nip '.png'])

freqvalues = [50 75 100 150 200 300 400 600];

scrsz = get(0,'ScreenSize');
fig   = figure('position',scrsz);
set(fig,'PaperPosition',scrsz)
set(fig,'PaperPositionMode','auto')

for i = 1:length(freqvalues)
    load(['C:\RESONANCE_MEG\DATA\' nip '\freq\Grads2_freqsub_' num2str(freqvalues(i)) '_stimfreq.mat']);
    load(['C:\RESONANCE_MEG\DATA\' nip '\freq\Grads2_freqsuball_baseline.mat']);  
    subplot(4,2,i)
    tmp = [];
    tmp = mean(FREQSUB.powspctrm) - mean(FREQB_allcond.powspctrm);
    semilogx(FREQSUB.freq,tmp,'linewidth',2,'color','k'); hold on
    set(gca,'xtick',[0.8 1.25 1.7 2.5 3.3 5 6.7 10 13.3 20 40 80],'xticklabel',[0.83 1.25 1.67 2.5 3.3 5 6.7 10 13.3 20 40 80])
    axis([0.8 120 (min(tmp(:,10:end))) (max(tmp(:,10:end)))])
    title([nip ' : ' num2str(freqvalues(i)) ' ms'],'fontsize',12)
    xlabel('frequency');ylabel('power');
end

print('-dpng',['C:\RESONANCE_MEG\DATA\' nip '\plots\Grads2_freqdiffsub_' nip '.png'])


for i = 1:length(freqvalues)
   
    load(['C:\RESONANCE_MEG\DATA\' nip '\freq\Grads2_freqsub_' num2str(freqvalues(i)) '_stimfreq_keep.mat']);
    load(['C:\RESONANCE_MEG\DATA\' nip '\freq\Grads2_freqsub_' num2str(freqvalues(i)) '_baseline_keep.mat']);      
    
    FREQSUB.label  = lay1.label;
    FREQbSUB.label = lay1.label;
    
    % get neighbourgs for statistical testing
    load('C:\TEMPROD\SCRIPTS\Matlab_pipeline\tools_tmp\pipeline_tmp\neighbours.mat')
%     load('C:\TEMPROD\SCRIPTS\Layouts_fieldtrip\neuromag306_neighb.mat')
    for a = 1:104
         neighbours{1,a}.label = ['MEG' neighbours{1,a}.label];
        for b = 1:length(neighbours{1,a}.neighblabel)
            neighbours{1,a}.neighblabel{b} = ['MEG' neighbours{1,a}.neighblabel{b}];
        end
    end
    
    
    % prepare layout
    cfg                           = [];
    cfg.layout                    = 'C:\TEMPROD\SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
    lay1                          = ft_prepare_layout(cfg,FREQSUB);
    lay1.label                    = FREQSUB.label;
    
    % find SSR fund power valuevalue
    fbegin = []; fend = [];
    fbegin              = find(FREQSUB.freq >= (1000/r_freqvalues(i)));
    fend                = find(FREQSUB.freq < (1000/r_freqvalues(i)));
    if abs(1000/r_freqvalues(i) - FREQSUB.freq(fbegin(1))) <= abs(1000/r_freqvalues(i) - FREQSUB.freq(fend(end)))
        f_fund_ind      = fbegin(1);
    else
        f_fund_ind      = fend(end);
    end
    
    % test based on fieldtrip tutorial
    cfg = [];
    cfg.channel          = 'all';
    cfg.latency          = 'all';
    cfg.frequency        = [FREQSUB.freq(f_fund_ind) FREQSUB.freq(f_fund_ind)];
    cfg.method           = 'montecarlo';
    cfg.statistic        = 'indepsamplesT';
    cfg.correctm         = 'cluster';
    cfg.clusteralpha     = 0.05;
    cfg.clusterstatistic = 'maxsum';
    cfg.minnbchan        = 0;
    cfg.tail             = 0;
    cfg.clustertail      = 0;
    cfg.alpha            = 0.025;
    cfg.numrandomization = 500;
    cfg.neighbours       = neighbours;
    
    nsub = size(FREQSUB.powspctrm,1);
    
    design = zeros(2,nsub + nsub);
    design(1,1:nsub) = 1:nsub;
    design(1,(nsub+1):2*nsub) = 1:nsub;
    design(2,1:nsub) = 1;
    design(2,(nsub+1):2*nsub) = 2;
    
    cfg.design           = design(2,:);
%     cfg.uvar  = 1;
    cfg.ivar  = 1;
    
    [stat] = ft_freqstatistics(cfg,FREQSUB,FREQbSUB);
    STATS{i} = stat;
    
    if sum(STATS{i}.mask) ~= 0
        cfg                           = [];
        cfg.layout                    = lay1;
        cfg.alpha                     = 0.05;
        cfg.highlightseries           = {'on','on','off','off','off'}; 
        cfg.highlightsymbolseries     = ['.','.','.','.','.'];
        cfg.highlightsizeseries       = [25 25 25 25 25];
        cfg.highlightcolorpos         = [0 0 0];
        cfg.highlightcolorneg         = [1 1 1];
        cfg.parameter                 = 'stat';
        cfg.style                     = 'straight';
        cfg.zlim                      = [-20 20];
        ft_clusterplot(cfg, STATS{1,i});
        print('-dpng',['C:\RESONANCE_MEG\DATA\' nip '\plots\Grads2_indepsamplesT_' num2str(freqvalues(i))]);
    end
    
end