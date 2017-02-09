clear all
close all

niparray = {'cb100118','nr110115','pe110338','ns110383','cd100449'}; 

freqvalues = [50 75 100 150 200 300 400 600];
r_freqvalues = [50 83.3 100 150 200 300 400 600];

fig   = figure('position',[1 1 1080 500]);
set(fig,'PaperPosition',[1 1 1080 500])
set(fig,'PaperPositionMode','auto')


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
    cfg.statistic        = 'indepsamplesT';
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
    
    cfg.design           = design(2,:);
%     cfg.uvar  = 1;
    cfg.ivar  = 1;
    
    [stat] = ft_freqstatistics(cfg,FREQCOND_gdavg{1,i},FREQBASE_gdavg{1,i});
    stat.rawdiff = (squeeze(mean(FREQCOND_gdavg{1,i}.powspctrm(:,:,f_fund_ind),1)) - squeeze(mean(FREQBASE_gdavg{1,i}.powspctrm(:,:,f_fund_ind))))';
    STATS{i} = stat;
    
end
    
for i = 1:8
    if sum(STATS{1,i}.mask) == 0
        mysubplot(8,3,3*i-2)
        cfg = [];
        cfg.maplimits = [-1e-27 1e-27]; 
        cfg.style = 'straight';
        cfg.electrodes = 'off';
        cfg.layout = 'C:\TEMPROD\SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
        topoplot(cfg, STATS{1,i}.rawdiff)
    else
        mysubplot(8,3,3*i-2)
        [x,y] = find(STATS{1,i}.mask ~= 0);
        cfg = [];
        cfg.maplimits = [-1e-27 1e-27];         
        cfg.highlight = x';
        cfg.style = 'straight';
        cfg.electrodes = 'highlights';
        cfg.hlmarkersize = 4;
        cfg.layout = 'C:\TEMPROD\SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
        topoplot(cfg, STATS{1,i}.rawdiff)
    end    
end

fig   = figure('position',[1 1 250 250]);
set(fig,'PaperPosition',[1 1 250 250])
set(fig,'PaperPositionMode','auto')
imagesc([-1e-27 1e-27]) 
colorbar('location','Southoutside','fontsize',12)
print('-dpng','C:\RESONANCE_MEG\DATA\across_sub\colorbar_mags');

fig   = figure('position',[1 1 250 250]);
set(fig,'PaperPosition',[1 1 250 250])
set(fig,'PaperPositionMode','auto')
imagesc([-1e-24 1e-24]) 
colorbar('location','Southoutside','fontsize',12)
print('-dpng','C:\RESONANCE_MEG\DATA\across_sub\colorbar_grads');

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
    cfg.statistic        = 'indepsamplesT';
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
    
    cfg.design           = design(2,:);
%     cfg.uvar  = 1;
    cfg.ivar  = 1;
    
    [stat] = ft_freqstatistics(cfg,FREQCOND_gdavg{1,i},FREQBASE_gdavg{1,i});
    stat.rawdiff = (squeeze(mean(FREQCOND_gdavg{1,i}.powspctrm(:,:,f_fund_ind),1)) - squeeze(mean(FREQBASE_gdavg{1,i}.powspctrm(:,:,f_fund_ind))))';
    STATS{i} = stat; 
end
    
for i = 1:8
    if sum(STATS{1,i}.mask) == 0
        mysubplot(8,3,3*i-1)
        cfg = [];
        cfg.maplimits = [-10e-25 10e-25];
        cfg.style = 'straight';
        cfg.electrodes = 'off';
        cfg.layout = 'C:\TEMPROD\SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
        topoplot(cfg, STATS{1,i}.rawdiff)
    else
        mysubplot(8,3,3*i-1)
        [x,y] = find(STATS{1,i}.mask ~= 0);
        cfg = [];
        cfg.maplimits = [-10e-25 10e-25];        
        cfg.highlight = x';
        cfg.style = 'straight';
        cfg.electrodes = 'highlights';
        cfg.hlmarkersize = 4;
        cfg.layout = 'C:\TEMPROD\SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
        topoplot(cfg, STATS{1,i}.rawdiff)
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
    cfg.statistic        = 'indepsamplesT';
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
    
    cfg.design           = design(2,:);
%     cfg.uvar  = 1;
    cfg.ivar  = 1;
    
    [stat] = ft_freqstatistics(cfg,FREQCOND_gdavg{1,i},FREQBASE_gdavg{1,i});
    stat.rawdiff = (squeeze(mean(FREQCOND_gdavg{1,i}.powspctrm(:,:,f_fund_ind),1)) - squeeze(mean(FREQBASE_gdavg{1,i}.powspctrm(:,:,f_fund_ind))))';
    STATS{i} = stat;
    
end
    
for i = 1:8
    if sum(STATS{1,i}.mask) == 0
        mysubplot(8,3,3*i)
        cfg = [];
        cfg.maplimits = [-10e-25 10e-25];
        cfg.style = 'straight';
        cfg.electrodes = 'off';
        cfg.layout = 'C:\TEMPROD\SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
        topoplot(cfg, STATS{1,i}.rawdiff)
    else
        mysubplot(8,3,3*i)
        [x,y] = find(STATS{1,i}.mask ~= 0);
        cfg = [];
        cfg.maplimits = [-10e-25 10e-25];
        cfg.highlight = x';
        cfg.style = 'straight';
        cfg.electrodes = 'highlights';
        cfg.hlmarkersize = 4;
        cfg.layout = 'C:\TEMPROD\SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
        topoplot(cfg, STATS{1,i}.rawdiff)
    end    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all

niparray = {'cb100118','nr110115','pe110338','ns110383','cd100449'}; 

freqvalues = [50 75 100 150 200 300 400 600];
r_freqvalues = [50 83.3 100 150 200 300 400 600];

fig   = figure('position',[1 1 1080 500]);
set(fig,'PaperPosition',[1 1 1080 500])
set(fig,'PaperPositionMode','auto')


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
    
end
    
for i = 1:8
    if sum(STATS{1,i}.mask) == 0
        mysubplot(8,3,3*i-2)
        cfg = [];
        cfg.zlim                      = [-2e-27 2e-27];         
        cfg.style = 'straight';
        cfg.electrodes = 'off';
        cfg.layout = 'C:\TEMPROD\SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
        topoplot(cfg, STATS{1,i}.rawdiff)
    else
        mysubplot(8,3,3*i-2)
        [x,y] = find(STATS{1,i}.mask ~= 0);
        cfg = [];
        cfg.zlim                      = [-2e-27 2e-27];         
        cfg.highlight = x';
        cfg.style = 'straight';
        cfg.electrodes = 'highlights';
        cfg.hlmarkersize = 4;
        cfg.layout = 'C:\TEMPROD\SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
        topoplot(cfg, STATS{1,i}.rawdiff)
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
end
    
for i = 1:8
    if sum(STATS{1,i}.mask) == 0
        mysubplot(8,3,3*i-1)
        cfg = [];
        cfg.zlim                      = [-8e-25 8e-25];        
        cfg.style = 'straight';
        cfg.electrodes = 'off';
        cfg.layout = 'C:\TEMPROD\SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
        topoplot(cfg, STATS{1,i}.rawdiff)
    else
        mysubplot(8,3,3*i-1)
        [x,y] = find(STATS{1,i}.mask ~= 0);
        cfg = [];
        cfg.zlim                      = [-8e-25 8e-25];        
        cfg.highlight = x';
        cfg.style = 'straight';
        cfg.electrodes = 'highlights';
        cfg.hlmarkersize = 4;
        cfg.layout = 'C:\TEMPROD\SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
        topoplot(cfg, STATS{1,i}.rawdiff)
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
    
end
    
for i = 1:8
    if sum(STATS{1,i}.mask) == 0
        mysubplot(8,3,3*i)
        cfg = [];
        cfg.zlim                      = [-8e-25 8e-25];        
        cfg.style = 'straight';
        cfg.electrodes = 'off';
        cfg.layout = 'C:\TEMPROD\SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
        topoplot(cfg, STATS{1,i}.rawdiff)
    else
        mysubplot(8,3,3*i)
        [x,y] = find(STATS{1,i}.mask ~= 0);
        cfg = [];
        cfg.zlim                      = [-8e-25 8e-25];        
        cfg.highlight = x';
        cfg.style = 'straight';
        cfg.electrodes = 'highlights';
        cfg.hlmarkersize = 4;
        cfg.layout = 'C:\TEMPROD\SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
        topoplot(cfg, STATS{1,i}.rawdiff)
    end    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all

niparray = {'cb100118','nr110115','pe110338','ns110383','cd100449'}; 

freqvalues = [50 75 100 150 200 300 400 600];
r_freqvalues = [50 83.3 100 150 200 300 400 600];

fig   = figure('position',[1 1 1080 500]);
set(fig,'PaperPosition',[1 1 1080 500])
set(fig,'PaperPositionMode','auto')


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
    fbegin              = find(FREQCOND_gdavg{1,i}.freq >= (500/r_freqvalues(i)));
    fend                = find(FREQCOND_gdavg{1,i}.freq < (500/r_freqvalues(i)));
    if abs(1000/r_freqvalues(i) - FREQCOND_gdavg{1,i}.freq(fbegin(1))) <= abs(500/r_freqvalues(i) - FREQCOND_gdavg{1,i}.freq(fend(end)))
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
    cfg.statistic        = 'indepsamplesT';
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
    
    cfg.design           = design(2,:);
%     cfg.uvar  = 1;
    cfg.ivar  = 1;
    
    [stat] = ft_freqstatistics(cfg,FREQCOND_gdavg{1,i},FREQBASE_gdavg{1,i});
    stat.rawdiff = (squeeze(mean(FREQCOND_gdavg{1,i}.powspctrm(:,:,f_fund_ind),1)) - squeeze(mean(FREQBASE_gdavg{1,i}.powspctrm(:,:,f_fund_ind))))';
    STATS{i} = stat;
    
end
    
for i = 1:8
    if sum(STATS{1,i}.mask) == 0
        mysubplot(8,3,3*i-2)
        cfg = [];
        cfg.zlim                      = [-2e-27 2e-27];
        cfg.style = 'straight';
        cfg.electrodes = 'off';
        cfg.layout = 'C:\TEMPROD\SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
        topoplot(cfg, STATS{1,i}.rawdiff)
    else
        mysubplot(8,3,3*i-2)
        [x,y] = find(STATS{1,i}.mask ~= 0);
        cfg = [];
        cfg.zlim                      = [-2e-27 2e-27];
        cfg.highlight = x';
        cfg.style = 'straight';
        cfg.electrodes = 'highlights';
        cfg.hlmarkersize = 4;
        cfg.layout = 'C:\TEMPROD\SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
        topoplot(cfg, STATS{1,i}.rawdiff)
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
    fbegin              = find(FREQCOND_gdavg{1,i}.freq >= (500/r_freqvalues(i)));
    fend                = find(FREQCOND_gdavg{1,i}.freq < (500/r_freqvalues(i)));
    if abs(1000/r_freqvalues(i) - FREQCOND_gdavg{1,i}.freq(fbegin(1))) <= abs(500/r_freqvalues(i) - FREQCOND_gdavg{1,i}.freq(fend(end)))
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
    cfg.statistic        = 'indepsamplesT';
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
    
    cfg.design           = design(2,:);
%     cfg.uvar  = 1;
    cfg.ivar  = 1;
    
    [stat] = ft_freqstatistics(cfg,FREQCOND_gdavg{1,i},FREQBASE_gdavg{1,i});
    stat.rawdiff = (squeeze(mean(FREQCOND_gdavg{1,i}.powspctrm(:,:,f_fund_ind),1)) - squeeze(mean(FREQBASE_gdavg{1,i}.powspctrm(:,:,f_fund_ind))))';
    STATS{i} = stat; 
end
    
for i = 1:8
    if sum(STATS{1,i}.mask) == 0
        mysubplot(8,3,3*i-1)
        cfg = [];
        cfg.zlim                      = [-8e-25 8e-25];
        cfg.style = 'straight';
        cfg.electrodes = 'off';
        cfg.layout = 'C:\TEMPROD\SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
        topoplot(cfg, STATS{1,i}.rawdiff)
    else
        mysubplot(8,3,3*i-1)
        [x,y] = find(STATS{1,i}.mask ~= 0);
        cfg = [];
        cfg.zlim                      = [-8e-25 8e-25];
        cfg.highlight = x';
        cfg.style = 'straight';
        cfg.electrodes = 'highlights';
        cfg.hlmarkersize = 4;
        cfg.layout = 'C:\TEMPROD\SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
        topoplot(cfg, STATS{1,i}.rawdiff)
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
    fbegin              = find(FREQCOND_gdavg{1,i}.freq >= (500/r_freqvalues(i)));
    fend                = find(FREQCOND_gdavg{1,i}.freq < (500/r_freqvalues(i)));
    if abs(1000/r_freqvalues(i) - FREQCOND_gdavg{1,i}.freq(fbegin(1))) <= abs(500/r_freqvalues(i) - FREQCOND_gdavg{1,i}.freq(fend(end)))
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
    cfg.statistic        = 'indepsamplesT';
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
    
    cfg.design           = design(2,:);
%     cfg.uvar  = 1;
    cfg.ivar  = 1;
    
    [stat] = ft_freqstatistics(cfg,FREQCOND_gdavg{1,i},FREQBASE_gdavg{1,i});
    stat.rawdiff = (squeeze(mean(FREQCOND_gdavg{1,i}.powspctrm(:,:,f_fund_ind),1)) - squeeze(mean(FREQBASE_gdavg{1,i}.powspctrm(:,:,f_fund_ind))))';
    STATS{i} = stat;
    
end
    
for i = 1:8
    if sum(STATS{1,i}.mask) == 0
        mysubplot(8,3,3*i)
        cfg = [];
        cfg.zlim                      = [-8e-25 8e-25];
        cfg.style = 'straight';
        cfg.electrodes = 'off';
        cfg.layout = 'C:\TEMPROD\SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
        topoplot(cfg, STATS{1,i}.rawdiff)
    else
        mysubplot(8,3,3*i)
        [x,y] = find(STATS{1,i}.mask ~= 0);
        cfg = [];
        cfg.zlim                      = [-8e-25 8e-25];
        cfg.highlight = x';
        cfg.style = 'straight';
        cfg.electrodes = 'highlights';
        cfg.hlmarkersize = 4;
        cfg.layout = 'C:\TEMPROD\SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
        topoplot(cfg, STATS{1,i}.rawdiff)
    end    
end






















