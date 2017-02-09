clear all
close all

niparray = {'cb100118','nr110115','pe110338','ns110383','cd100449'}; 

freqvalues = [50 75 100 150 200 300 400 600];
r_freqvalues = [50 83.3 100 150 200 300 400 600];

% Mags

for j = 1:length(freqvalues)
    for i = 1:length(niparray)
        FREQCOND{i,j} = load(['C:\RESONANCE_MEG\DATA\' niparray{i} '\freq\Mags_freqsub_' num2str(freqvalues(j)) '_stimfreq.mat']);
        FREQBASE{i,j} = load(['C:\RESONANCE_MEG\DATA\' niparray{i} '\freq\Mags_freqsub_'  num2str(freqvalues(j))  '_baseline.mat']);
    end
    cfg                = [];
    cfg.keepindividual = 'yes';
    FREQCOND_gdavg{j}  = ft_freqgrandaverage(cfg,FREQCOND{1,j}.FREQSUB,FREQCOND{2,j}.FREQSUB,FREQCOND{3,j}.FREQSUB,FREQCOND{4,j}.FREQSUB,FREQCOND{5,j}.FREQSUB);
    FREQBASE_gdavg{j}  = ft_freqgrandaverage(cfg,FREQBASE{1,j}.FREQbSUB,FREQBASE{2,j}.FREQbSUB,FREQBASE{3,j}.FREQbSUB,FREQBASE{4,j}.FREQbSUB,FREQBASE{5,j}.FREQbSUB);
end

fig   = figure('position',[1 1 1000 1000]);
set(fig,'PaperPosition',[1 1 1000 1000])
set(fig,'PaperPositionMode','auto')

for i = 1:length(freqvalues)
    subplot(4,2,i)
    loglog(FREQCOND_gdavg{j}.freq,squeeze(mean(mean(FREQCOND_gdavg{i}.powspctrm))),'linewidth',2,'color','b'); hold on
    loglog(FREQBASE_gdavg{j}.freq,squeeze(mean(mean(FREQBASE_gdavg{i}.powspctrm))),'linewidth',2,'color','r'); hold on
    set(gca,'xtick',[0.8 1.25 1.7 2.5 3.3 5 6.7 10 13.3 20 40 80],'xticklabel',[0.83 1.25 1.67 2.5 3.3 5 6.7 10 13.3 20 40 80])
    axis([0.5 120 (min(mean(FREQCOND_gdavg{i}.powspctrm(:,10:end)))) (max(mean(FREQCOND_gdavg{i}.powspctrm(:,10:end))))])
%     title([num2str(freqvalues(i)) ' ms'],'fontsize',12)
    xlabel('frequency (hz)','Fontsize',12);ylabel('power','Fontsize',12);
    set(gca,'box','off','linewidth',2,'Fontsize',12)
    xticklabel_rotate([],90,[],'Fontsize',12)
end

print('-dpng',['C:\RESONANCE_MEG\DATA\across_sub\Mags_freq_all.png'])

for i = 1:length(freqvalues)
    
    % get neighbourgs for statistical testing
    load('C:\TEMPROD\SCRIPTS\Matlab_pipeline\tools_tmp\pipeline_tmp\neighbours.mat')
    for a = 1:104
         neighbours{1,a}.label = ['MEG' neighbours{1,a}.label];
        for b = 1:length(neighbours{1,a}.neighblabel)
            neighbours{1,a}.neighblabel{b} = ['MEG' neighbours{1,a}.neighblabel{b}];
        end
    end
    
    
    % prepare layout
    cfg                           = [];
    cfg.layout                    = 'C:\TEMPROD\SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
    lay1                          = ft_prepare_layout(cfg,FREQCOND_gdavg{1,i});
    lay1.label                    = FREQCOND_gdavg{1,i}.label;
    
    % find SSR fund power valuevalue
    fbegin = []; fend = [];
    fbegin              = find(FREQCOND_gdavg{1,i}.freq >= (1000/r_freqvalues(i)));
    fend                = find(FREQCOND_gdavg{1,i}.freq < (1000/r_freqvalues(i)));
    if abs(1000/r_freqvalues(i) - FREQCOND_gdavg{1,i}.freq(fbegin(1))) <= abs(1000/r_freqvalues(i) - FREQCOND_gdavg{1,i}.freq(fend(end)))
        f_fund_ind      = fbegin(1);
    else
        f_fund_ind      = fend(end);
    end
    
    % test based on fieldtrip tutorial
    cfg = [];
    cfg.channel          = 'all';
    cfg.latency          = 'all';
    cfg.frequency        = [FREQCOND_gdavg{1,i}.freq(f_fund_ind) FREQCOND_gdavg{1,i}.freq(f_fund_ind)];
    cfg.method           = 'montecarlo';
    cfg.statistic        = 'depsamplesT';
    cfg.correctm         = 'cluster';
    cfg.clusteralpha     = 0.05;
    cfg.clusterstatistic = 'maxsum';
    cfg.minnbchan        = 2;
    cfg.tail             = 0;
    cfg.clustertail      = 0;
    cfg.alpha            = 0.025;
    cfg.numrandomization = 500;
    cfg.neighbours       = neighbours;
    
    nsub = size(FREQCOND_gdavg{1,i}.powspctrm,1);
    
    design = zeros(2,nsub + nsub);
    design(1,1:nsub) = 1:nsub;
    design(1,(nsub+1):2*nsub) = 1:nsub;
    design(2,1:nsub) = 1;
    design(2,(nsub+1):2*nsub) = 2;
    
    cfg.design           = design;
    cfg.uvar  = 1;
    cfg.ivar  = 2;
    
    [stat] = ft_freqstatistics(cfg,FREQCOND_gdavg{1,i},FREQBASE_gdavg{1,i});
    stat.rawdiff = (squeeze(mean(FREQCOND_gdavg{1,i}.powspctrm(:,:,f_fund_ind),1)) - squeeze(mean(FREQBASE_gdavg{1,i}.powspctrm(:,:,f_fund_ind))))';
    STATS{i} = stat;
    
    figure
    if sum(STATS{i}.mask) ~= 0
        cfg                           = [];
        cfg.layout                    = lay1;
        cfg.alpha                     = 0.05;
        cfg.highlightseries           = {'on','on','off','off','off'}; 
        cfg.highlightsymbolseries     = ['.','.','.','.','.'];
        cfg.highlightsizeseries       = [40 40 40 40 40];
        cfg.highlightcolorpos         = [0 0 0];
        cfg.highlightcolorneg         = [1 1 1];
        cfg.parameter                 = 'rawdiff';
        cfg.style                     = 'straight';
        cfg.zlim                      = [-2e-27 2e-27];
        ft_clusterplot(cfg, STATS{1,i});
        print('-dpng',['C:\RESONANCE_MEG\DATA\across_sub\Mags_depsamplesT_' num2str(freqvalues(i))]);
    else
        cfg = [];
        cfg.style = 'straight';
        cfg.electrodes = 'off';
        cfg.layout = 'C:\TEMPROD\SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
        topoplot(cfg, STATS{1,i}.rawdiff)
        print('-dpng',['C:\RESONANCE_MEG\DATA\across_sub\Mags_depsamplesT_' num2str(freqvalues(i))]);        
    end
    
end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Grads1
for j = 1:length(freqvalues)
    for i = 1:length(niparray)
        FREQCOND{i,j} = load(['C:\RESONANCE_MEG\DATA\' niparray{i} '\freq\Grads1_freqsub_' num2str(freqvalues(j)) '_stimfreq.mat']);
        FREQBASE{i,j} = load(['C:\RESONANCE_MEG\DATA\' niparray{i} '\freq\Grads1_freqsub_'  num2str(freqvalues(j)) '_baseline.mat']);
    end
    cfg                = [];
    cfg.keepindividual = 'yes';
    FREQCOND_gdavg{j}  = ft_freqgrandaverage(cfg,FREQCOND{1,j}.FREQSUB,FREQCOND{2,j}.FREQSUB,FREQCOND{3,j}.FREQSUB,FREQCOND{4,j}.FREQSUB,FREQCOND{5,j}.FREQSUB);
    FREQBASE_gdavg{j}  = ft_freqgrandaverage(cfg,FREQBASE{1,j}.FREQbSUB,FREQBASE{2,j}.FREQbSUB,FREQBASE{3,j}.FREQbSUB,FREQBASE{4,j}.FREQbSUB,FREQBASE{5,j}.FREQbSUB);
end

fig   = figure('position',[1 1 1000 1000]);
set(fig,'PaperPosition',[1 1 1000 1000])
set(fig,'PaperPositionMode','auto')

for i = 1:length(freqvalues)
    subplot(4,2,i)
    loglog(FREQCOND_gdavg{j}.freq,squeeze(mean(mean(FREQCOND_gdavg{i}.powspctrm))),'linewidth',2,'color','b'); hold on
    loglog(FREQBASE_gdavg{j}.freq,squeeze(mean(mean(FREQBASE_gdavg{i}.powspctrm))),'linewidth',2,'color','r'); hold on
    set(gca,'xtick',[0.8 1.25 1.7 2.5 3.3 5 6.7 10 13.3 20 40 80],'xticklabel',[0.83 1.25 1.67 2.5 3.3 5 6.7 10 13.3 20 40 80])
    axis([0.5 120 (min(mean(FREQCOND_gdavg{i}.powspctrm(:,10:end)))) (max(mean(FREQCOND_gdavg{i}.powspctrm(:,10:end))))])
%     title([num2str(freqvalues(i)) ' ms'],'fontsize',12)
    xlabel('frequency (hz)','Fontsize',12);ylabel('power','Fontsize',12);
    set(gca,'box','off','linewidth',2,'Fontsize',12)
    xticklabel_rotate([],90,[],'Fontsize',12)
end

print('-dpng',['C:\RESONANCE_MEG\DATA\across_sub\Grads1_freq_all.png'])

for i = 1:length(freqvalues)
    
    % get neighbourgs for statistical testing
    load('C:\TEMPROD\SCRIPTS\Matlab_pipeline\tools_tmp\pipeline_tmp\neighbours.mat')
    for a = 1:104
         neighbours{1,a}.label = ['MEG' neighbours{1,a}.label];
        for b = 1:length(neighbours{1,a}.neighblabel)
            neighbours{1,a}.neighblabel{b} = ['MEG' neighbours{1,a}.neighblabel{b}];
        end
    end
    
    
    % prepare layout
    cfg                           = [];
    cfg.layout                    = 'C:\TEMPROD\SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
    lay2                          = ft_prepare_layout(cfg,FREQCOND_gdavg{1,i});
    FREQCOND_gdavg{1,i}.label     = lay1.label;
    FREQBASE_gdavg{1,i}.label     = lay1.label;    
    lay2.label                    = FREQCOND_gdavg{1,i}.label;
    
    
    % find SSR fund power valuevalue
    fbegin = []; fend = [];
    fbegin              = find(FREQCOND_gdavg{1,i}.freq >= (1000/r_freqvalues(i)));
    fend                = find(FREQCOND_gdavg{1,i}.freq < (1000/r_freqvalues(i)));
    if abs(1000/r_freqvalues(i) - FREQCOND_gdavg{1,i}.freq(fbegin(1))) <= abs(1000/r_freqvalues(i) - FREQCOND_gdavg{1,i}.freq(fend(end)))
        f_fund_ind      = fbegin(1);
    else
        f_fund_ind      = fend(end);
    end
    
    % test based on fieldtrip tutorial
    cfg = [];
    cfg.channel          = 'all';
    cfg.latency          = 'all';
    cfg.frequency        = [FREQCOND_gdavg{1,i}.freq(f_fund_ind) FREQCOND_gdavg{1,i}.freq(f_fund_ind)];
    cfg.method           = 'montecarlo';
    cfg.statistic        = 'depsamplesT';
    cfg.correctm         = 'cluster';
    cfg.clusteralpha     = 0.05;
    cfg.clusterstatistic = 'maxsum';
    cfg.minnbchan        = 2;
    cfg.tail             = 0;
    cfg.clustertail      = 0;
    cfg.alpha            = 0.025;
    cfg.numrandomization = 500;
    cfg.neighbours       = neighbours;
    
    nsub = size(FREQCOND_gdavg{1,i}.powspctrm,1);
    
    design = zeros(2,nsub + nsub);
    design(1,1:nsub) = 1:nsub;
    design(1,(nsub+1):2*nsub) = 1:nsub;
    design(2,1:nsub) = 1;
    design(2,(nsub+1):2*nsub) = 2;
    
    cfg.design           = design;
    cfg.uvar  = 1;
    cfg.ivar  = 2;
    
    [stat] = ft_freqstatistics(cfg,FREQCOND_gdavg{1,i},FREQBASE_gdavg{1,i});
    stat.rawdiff = (squeeze(mean(FREQCOND_gdavg{1,i}.powspctrm(:,:,f_fund_ind),1)) - squeeze(mean(FREQBASE_gdavg{1,i}.powspctrm(:,:,f_fund_ind))))';
    STATS{i} = stat;
    
    figure
    if sum(STATS{i}.mask) ~= 0
        cfg                           = [];
        cfg.layout                    = lay1;
        cfg.alpha                     = 0.05;
        cfg.highlightseries           = {'on','on','off','off','off'}; 
        cfg.highlightsymbolseries     = ['.','.','.','.','.'];
        cfg.highlightsizeseries       = [40 40 40 40 40];
        cfg.highlightcolorpos         = [0 0 0];
        cfg.highlightcolorneg         = [1 1 1];
        cfg.parameter                 = 'rawdiff';
        cfg.style                     = 'straight';
        cfg.zlim                      = [-8e-25 8e-25];
        ft_clusterplot(cfg, STATS{1,i});
        print('-dpng',['C:\RESONANCE_MEG\DATA\across_sub\Grads1_indepsamplesT_' num2str(freqvalues(i))]);
    else
        cfg = [];
        cfg.style = 'straight';
        cfg.electrodes = 'off';
        cfg.layout = 'C:\TEMPROD\SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
        topoplot(cfg, STATS{1,i}.rawdiff)
        print('-dpng',['C:\RESONANCE_MEG\DATA\across_sub\Grads1_indepsamplesT_' num2str(freqvalues(i))]);        
    end
    
end
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Grads2
for j = 1:length(freqvalues)
    for i = 1:length(niparray)
        FREQCOND{i,j} = load(['C:\RESONANCE_MEG\DATA\' niparray{i} '\freq\Grads2_freqsub_' num2str(freqvalues(j)) '_stimfreq.mat']);
        FREQBASE{i,j} = load(['C:\RESONANCE_MEG\DATA\' niparray{i} '\freq\Grads2_freqsub_'  num2str(freqvalues(j)) '_baseline.mat']);
    end
    cfg                = [];
    cfg.keepindividual = 'yes';
    FREQCOND_gdavg{j}  = ft_freqgrandaverage(cfg,FREQCOND{1,j}.FREQSUB,FREQCOND{2,j}.FREQSUB,FREQCOND{3,j}.FREQSUB,FREQCOND{4,j}.FREQSUB,FREQCOND{5,j}.FREQSUB);
    FREQBASE_gdavg{j}  = ft_freqgrandaverage(cfg,FREQBASE{1,j}.FREQbSUB,FREQBASE{2,j}.FREQbSUB,FREQBASE{3,j}.FREQbSUB,FREQBASE{4,j}.FREQbSUB,FREQBASE{5,j}.FREQbSUB);
end

fig   = figure('position',[1 1 1000 1000]);
set(fig,'PaperPosition',[1 1 1000 1000])
set(fig,'PaperPositionMode','auto')

for i = 1:length(freqvalues)
    subplot(4,2,i)
    loglog(FREQCOND_gdavg{j}.freq,squeeze(mean(mean(FREQCOND_gdavg{i}.powspctrm))),'linewidth',2,'color','b'); hold on
    loglog(FREQBASE_gdavg{j}.freq,squeeze(mean(mean(FREQBASE_gdavg{i}.powspctrm))),'linewidth',2,'color','r'); hold on
    set(gca,'xtick',[0.8 1.25 1.7 2.5 3.3 5 6.7 10 13.3 20 40 80],'xticklabel',[0.83 1.25 1.67 2.5 3.3 5 6.7 10 13.3 20 40 80])
    axis([0.5 120 (min(mean(FREQCOND_gdavg{i}.powspctrm(:,10:end)))) (max(mean(FREQCOND_gdavg{i}.powspctrm(:,10:end))))])
%     title([num2str(freqvalues(i)) ' ms'],'fontsize',12)
    xlabel('frequency (hz)','Fontsize',12);ylabel('power','Fontsize',12);
    set(gca,'box','off','linewidth',2,'Fontsize',12)
    xticklabel_rotate([],90,[],'Fontsize',12)
end

print('-dpng',['C:\RESONANCE_MEG\DATA\across_sub\Grads2_freq_all.png'])

for i = 1:length(freqvalues)
    
    % get neighbourgs for statistical testing
    load('C:\TEMPROD\SCRIPTS\Matlab_pipeline\tools_tmp\pipeline_tmp\neighbours.mat')
    for a = 1:104
         neighbours{1,a}.label = ['MEG' neighbours{1,a}.label];
        for b = 1:length(neighbours{1,a}.neighblabel)
            neighbours{1,a}.neighblabel{b} = ['MEG' neighbours{1,a}.neighblabel{b}];
        end
    end
    
    
    % prepare layout
    cfg                           = [];
    cfg.layout                    = 'C:\TEMPROD\SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
    lay2                          = ft_prepare_layout(cfg,FREQCOND_gdavg{1,i});
    FREQCOND_gdavg{1,i}.label     = lay1.label;
    FREQBASE_gdavg{1,i}.label     = lay1.label;    
    lay2.label                    = FREQCOND_gdavg{1,i}.label;
    
    
    % find SSR fund power valuevalue
    fbegin = []; fend = [];
    fbegin              = find(FREQCOND_gdavg{1,i}.freq >= (1000/r_freqvalues(i)));
    fend                = find(FREQCOND_gdavg{1,i}.freq < (1000/r_freqvalues(i)));
    if abs(1000/r_freqvalues(i) - FREQCOND_gdavg{1,i}.freq(fbegin(1))) <= abs(1000/r_freqvalues(i) - FREQCOND_gdavg{1,i}.freq(fend(end)))
        f_fund_ind      = fbegin(1);
    else
        f_fund_ind      = fend(end);
    end
    
    % test based on fieldtrip tutorial
    cfg = [];
    cfg.channel          = 'all';
    cfg.latency          = 'all';
    cfg.frequency        = [FREQCOND_gdavg{1,i}.freq(f_fund_ind) FREQCOND_gdavg{1,i}.freq(f_fund_ind)];
    cfg.method           = 'montecarlo';
    cfg.statistic        = 'depsamplesT';
    cfg.correctm         = 'cluster';
    cfg.clusteralpha     = 0.05;
    cfg.clusterstatistic = 'maxsum';
    cfg.minnbchan        = 2;
    cfg.tail             = 0;
    cfg.clustertail      = 0;
    cfg.alpha            = 0.025;
    cfg.numrandomization = 500;
    cfg.neighbours       = neighbours;
    
    nsub = size(FREQCOND_gdavg{1,i}.powspctrm,1);
    
    design = zeros(2,nsub + nsub);
    design(1,1:nsub) = 1:nsub;
    design(1,(nsub+1):2*nsub) = 1:nsub;
    design(2,1:nsub) = 1;
    design(2,(nsub+1):2*nsub) = 2;
    
    cfg.design           = design;
    cfg.uvar  = 1;
    cfg.ivar  = 2;
    
    [stat] = ft_freqstatistics(cfg,FREQCOND_gdavg{1,i},FREQBASE_gdavg{1,i});
    stat.rawdiff = (squeeze(mean(FREQCOND_gdavg{1,i}.powspctrm(:,:,f_fund_ind),1)) - squeeze(mean(FREQBASE_gdavg{1,i}.powspctrm(:,:,f_fund_ind))))';
    STATS{i} = stat;
    
    figure
    if sum(STATS{i}.mask) ~= 0
        cfg                           = [];
        cfg.layout                    = lay1;
        cfg.alpha                     = 0.05;
        cfg.highlightseries           = {'on','on','off','off','off'}; 
        cfg.highlightsymbolseries     = ['.','.','.','.','.'];
        cfg.highlightsizeseries       = [40 40 40 40 40];
        cfg.highlightcolorpos         = [0 0 0];
        cfg.highlightcolorneg         = [1 1 1];
        cfg.parameter                 = 'rawdiff';
        cfg.style                     = 'straight';
        cfg.zlim                      = [-8e-25 8e-25];
        ft_clusterplot(cfg, STATS{1,i});
        print('-dpng',['C:\RESONANCE_MEG\DATA\across_sub\Grads2_depsamplesT_' num2str(freqvalues(i))]);
    else
        cfg = [];
        cfg.style = 'straight';
        cfg.electrodes = 'off';
        cfg.layout = 'C:\TEMPROD\SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
        topoplot(cfg, STATS{1,i}.rawdiff)
        print('-dpng',['C:\RESONANCE_MEG\DATA\across_sub\Grads2_depsamplesT_' num2str(freqvalues(i))]);        
    end
    
end
    














