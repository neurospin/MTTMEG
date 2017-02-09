function temprod_vs_baseline_v2(sub,freqsel,nameband,rangeplot)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 1000 1000]);
set(fig1,'PaperPosition',[1 1 1000 1000])
set(fig1,'PaperPositionmode','auto')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% sub       = 's14';
% freqsel   = 15;
% namebande = 'alpha';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

base = load(['C:\TEMPROD\DATA\NEW\processed_' sub '\FT_spectra\BLOCKFREQ_Mags_RUN01_1_120Hz']);
cond = load(['C:\TEMPROD\DATA\NEW\processed_' sub '\FT_spectra\BLOCKFREQ_Mags_RUN02_1_120Hz']);
cfg = [];
cfg.keeptrials = 'yes';
ntrial     = size(base.powspctrm,1);
cfg.trials = 1:ntrial;

base = ft_freqdescriptives(cfg,base);
cond = ft_freqdescriptives(cfg,cond);
diff_bc = base.powspctrm - cond.powspctrm;
mean_bc = (base.powspctrm + cond.powspctrm)/2;

[Fullfreq,Fullspctrm_b] = LineNoiseInterp(base.freq,base.powspctrm);
[Fullfreq,Fullspctrm_c] = LineNoiseInterp(cond.freq,cond.powspctrm);
[Fullfreq,Fullspctrm_b,Toremove_b,index] = linear_detrend(Fullfreq,Fullspctrm_b,[1 100]);
[Fullfreq,Fullspctrm_c,Toremove_c,index] = linear_detrend(Fullfreq,Fullspctrm_c,[1 100]);

base.freq = base.freq(1:index);
cond.freq = cond.freq(1:index);
base.powspctrm = base.powspctrm(:,:,1:index) - Toremove_b;
cond.powspctrm = cond.powspctrm(:,:,1:index) - Toremove_c;

%%%%%%%%%%%%% separate offset component and frequency component %%%%%%%%%%%


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
cfg.layout                    = 'C:\FIELDTRIP\fieldtrip-20120701\template\layout/NM306mag.lay';
lay1                          = ft_prepare_layout(cfg,base);
lay1.label                    = base.label;
    
    
% test based on fieldtrip tutorial
cfg = [];
cfg.channel          = 'all';
cfg.latency          = 'all';
cfg.frequency        = [freqsel freqsel];
cfg.method           = 'montecarlo';
cfg.statistic        = 'indepsamplesT';
cfg.correctm         = 'cluster';
cfg.clusteralpha     = 0.05;
cfg.clusterstatistic = 'maxsum';
cfg.minnbchan        = 4;
cfg.tail             = 0;
cfg.clustertail      = 0;
cfg.alpha            = 0.025;
cfg.numrandomization = 500;
cfg.neighbours       = neighbours;


design = [ones(1, ntrial) ones(1, ntrial)*2];

cfg.design           = design;
cfg.ivar  = 1;
    
[stat] = ft_freqstatistics(cfg,cond, base);

% compute avrage diff powspctrm
[rte,index] = min(abs(freqsel  - base.freq));

stat.rawdiff = squeeze(mean((cond.powspctrm(:,:,index))) - squeeze(mean(base.powspctrm(:,:,index))))';

for i = 1:8
    if sum(stat.mask) == 0
        cfg = [];
        cfg.maplimits = 'maxabs';         
        cfg.style = 'straight';
        cfg.electrodes = 'off';
        cfg.layout =  'C:\FIELDTRIP\fieldtrip-20120701\template\layout/NM306mag.lay';
        cfg.colorbar        = 'yes'
        mysubplot(3,3,1)
        topoplot(cfg,stat.rawdiff)
    else
        [x,y] = find(stat.mask ~= 0);
        cfg = [];
        cfg.highlight = x';
        cfg.maplimits   = 'maxabs';        
        cfg.style = 'straight';
        cfg.electrodes = 'highlights';
        cfg.hlmarkersize = 4;
        cfg.layout = 'C:\FIELDTRIP\fieldtrip-20120701\template\layout/NM306mag.lay';
        cfg.colorbar        = 'yes'
        mysubplot(3,3,1)
        topoplot(cfg, stat.rawdiff)
    end    
end

basemags = base;
condmags = cond;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[Grads1,Grads2,Mags] = grads_for_layouts('Laptop');
base = load(['C:\TEMPROD\DATA\NEW\processed_' sub '\FT_spectra\BLOCKFREQ_Grads1_RUN01_1_120Hz']);
cond = load(['C:\TEMPROD\DATA\NEW\processed_' sub '\FT_spectra\BLOCKFREQ_Grads1_RUN02_1_120Hz']);
cfg = [];
cfg.keeptrials = 'yes';
ntrial     = size(base.powspctrm,1);
cfg.trials = 1:ntrial;

base = ft_freqdescriptives(cfg,base);
cond = ft_freqdescriptives(cfg,cond);
    
[Fullfreq,Fullspctrm_b] = LineNoiseInterp(base.freq,base.powspctrm);
[Fullfreq,Fullspctrm_c] = LineNoiseInterp(cond.freq,cond.powspctrm);
[Fullfreq,Fullspctrm_b,Toremove_b,index] = linear_detrend(Fullfreq,Fullspctrm_b,[1 100]);
[Fullfreq,Fullspctrm_c,Toremove_c,index] = linear_detrend(Fullfreq,Fullspctrm_c,[1 100]);

base.freq = base.freq(1:index);
cond.freq = cond.freq(1:index);
base.powspctrm = base.powspctrm(:,:,1:index) - Toremove_b;
cond.powspctrm = cond.powspctrm(:,:,1:index) - Toremove_c;

% get neighbourgs for statistical testing
load('C:\TEMPROD\SCRIPTS\Matlab_pipeline\tools_tmp\pipeline_tmp\neighbours.mat')
for a = 1:104
    neighbours{1,a}.label = ['MEG' neighbours{1,a}.label];
    for b = 1:length(neighbours{1,a}.neighblabel)
        neighbours{1,a}.neighblabel{b} = ['MEG' neighbours{1,a}.neighblabel{b}];
    end
end
    
base.label = Mags';   
cond.label = Mags';   

% prepare layout
cfg                           = [];
cfg.layout                    = 'C:\FIELDTRIP\fieldtrip-20120701\template\layout/NM306mag.lay';
lay1                          = ft_prepare_layout(cfg,base);
lay1.label                    = base.label;  
    
% test based on fieldtrip tutorial
cfg = [];
cfg.channel          = 'all';
cfg.latency          = 'all';
cfg.frequency        = [freqsel freqsel];
cfg.method           = 'montecarlo';
cfg.statistic        = 'indepsamplesT';
cfg.correctm         = 'cluster';
cfg.clusteralpha     = 0.05;
cfg.clusterstatistic = 'maxsum';
cfg.minnbchan        = 4;
cfg.tail             = 0;
cfg.clustertail      = 0;
cfg.alpha            = 0.025;
cfg.numrandomization = 500;
cfg.neighbours       = neighbours;


design = [ones(1, ntrial) ones(1, ntrial)*2];

cfg.design           = design;
cfg.ivar  = 1;
    
[stat] = ft_freqstatistics(cfg,cond, base);

% compute avrage diff powspctrm
[rte,index] = min(abs(freqsel  - base.freq));

stat.rawdiff = squeeze(mean((cond.powspctrm(:,:,index))) - squeeze(mean(base.powspctrm(:,:,index))))';

for i = 1:8
    if sum(stat.mask) == 0
        cfg = [];
        cfg.maplimits = 'maxabs';         
        cfg.style = 'straight';
        cfg.electrodes = 'off';
        cfg.layout =  'C:\FIELDTRIP\fieldtrip-20120701\template\layout/NM306mag.lay';
        cfg.colorbar        = 'yes'
        mysubplot(3,3,2)
        topoplot(cfg,stat.rawdiff)
    else
        [x,y] = find(stat.mask ~= 0);
        cfg = [];
        cfg.highlight = x';
        cfg.maplimits   = 'maxabs';        
        cfg.style = 'straight';
        cfg.electrodes = 'highlights';
        cfg.hlmarkersize = 4;
        cfg.layout = 'C:\FIELDTRIP\fieldtrip-20120701\template\layout/NM306mag.lay';
        cfg.colorbar        = 'yes'
        mysubplot(3,3,2)
        topoplot(cfg, stat.rawdiff)
    end    
end

basegrads1 = base;
condgrads1 = cond;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[Grads1,Grads2,Mags] = grads_for_layouts('Laptop');
base = load(['C:\TEMPROD\DATA\NEW\processed_' sub '\FT_spectra\BLOCKFREQ_Grads2_RUN01_1_120Hz']);
cond = load(['C:\TEMPROD\DATA\NEW\processed_' sub '\FT_spectra\BLOCKFREQ_Grads2_RUN02_1_120Hz']);
cfg = [];
cfg.keeptrials = 'yes';
ntrial     = size(base.powspctrm,1);
cfg.trials = 1:ntrial;

base = ft_freqdescriptives(cfg,base);
cond = ft_freqdescriptives(cfg,cond);
    
[Fullfreq,Fullspctrm_b] = LineNoiseInterp(base.freq,base.powspctrm);
[Fullfreq,Fullspctrm_c] = LineNoiseInterp(cond.freq,cond.powspctrm);
[Fullfreq,Fullspctrm_b,Toremove_b,index] = linear_detrend(Fullfreq,Fullspctrm_b,[1 100]);
[Fullfreq,Fullspctrm_c,Toremove_c,index] = linear_detrend(Fullfreq,Fullspctrm_c,[1 100]);

base.freq = base.freq(1:index);
cond.freq = cond.freq(1:index);
base.powspctrm = base.powspctrm(:,:,1:index) - Toremove_b;
cond.powspctrm = cond.powspctrm(:,:,1:index) - Toremove_c;

% get neighbourgs for statistical testing
load('C:\TEMPROD\SCRIPTS\Matlab_pipeline\tools_tmp\pipeline_tmp\neighbours.mat')
for a = 1:104
    neighbours{1,a}.label = ['MEG' neighbours{1,a}.label];
    for b = 1:length(neighbours{1,a}.neighblabel)
        neighbours{1,a}.neighblabel{b} = ['MEG' neighbours{1,a}.neighblabel{b}];
    end
end
 
base.label = Mags';   
cond.label = Mags'; 
    
% prepare layout
cfg                           = [];
cfg.layout                    = 'C:\FIELDTRIP\fieldtrip-20120701\template\layout/NM306mag.lay';
lay1                          = ft_prepare_layout(cfg,base);
lay1.label                    = base.label;
    
% test based on fieldtrip tutorial
cfg = [];
cfg.channel          = 'all';
cfg.latency          = 'all';
cfg.frequency        = [freqsel freqsel];
cfg.method           = 'montecarlo';
cfg.statistic        = 'indepsamplesT';
cfg.correctm         = 'cluster';
cfg.clusteralpha     = 0.05;
cfg.clusterstatistic = 'maxsum';
cfg.minnbchan        = 4;
cfg.tail             = 0;
cfg.clustertail      = 0;
cfg.alpha            = 0.025;
cfg.numrandomization = 500;
cfg.neighbours       = neighbours;


design = [ones(1, ntrial) ones(1, ntrial)*2];

cfg.design           = design;
cfg.ivar  = 1;
    
[stat] = ft_freqstatistics(cfg,cond, base);

% compute avrage diff powspctrm
[rte,index] = min(abs(freqsel  - base.freq));

stat.rawdiff = squeeze(mean((cond.powspctrm(:,:,index))) - squeeze(mean(base.powspctrm(:,:,index))))';

for i = 1:8
    if sum(stat.mask) == 0
        cfg = [];
        cfg.maplimits = 'maxabs';         
        cfg.style = 'straight';
        cfg.electrodes = 'off';
        cfg.layout =  'C:\FIELDTRIP\fieldtrip-20120701\template\layout/NM306mag.lay';
        cfg.colorbar        = 'yes'
        mysubplot(3,3,3)
        topoplot(cfg,stat.rawdiff)
    else
        [x,y] = find(stat.mask ~= 0);
        cfg = [];
        cfg.highlight = x';
        cfg.maplimits   = 'maxabs';        
        cfg.style = 'straight';
        cfg.electrodes = 'highlights';
        cfg.hlmarkersize = 4;
        cfg.layout = 'C:\FIELDTRIP\fieldtrip-20120701\template\layout/NM306mag.lay';
        cfg.colorbar        = 'yes'   
        mysubplot(3,3,3)
        topoplot(cfg, stat.rawdiff)
    end    
end

print('-dpng',['C:\Users\bgauthie\Desktop\TEMP_WORK\' sub 'topo_CondVsBaseline_modal-' nameband '_v2.png']);

basegrads2 = base;
condgrads2 = cond;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 1000 1000]);
set(fig1,'PaperPosition',[1 1 1000 1000])
set(fig1,'PaperPositionmode','auto')

cfg = []; cfg.layout = lay1; cfg.xlim = rangeplot; cfg.linewidth = 1;
cfg.axes = 'no';
cond.powspctrm = (condmags.powspctrm);
base.powspctrm = (basemags.powspctrm);
ft_multiplotER(cfg,cond,base)

print('-dpng',['C:\Users\bgauthie\Desktop\TEMP_WORK\Mags' sub 'multi_CondVsBaseline_modal-alpha_v2.png']);

fig1 = figure('position',[1 1 1000 1000]);
set(fig1,'PaperPosition',[1 1 1000 1000])
set(fig1,'PaperPositionmode','auto')

cfg = []; cfg.layout = lay1; cfg.xlim = rangeplot; cfg.linewidth = 1;
cfg.axes = 'no';
cond.powspctrm = (condgrads1.powspctrm);
base.powspctrm = (basegrads1.powspctrm);
ft_multiplotER(cfg,cond,base)

print('-dpng',['C:\Users\bgauthie\Desktop\TEMP_WORK\Grads1' sub 'multi_CondVsBaseline_modal-alpha_v2.png']);

fig1 = figure('position',[1 1 1000 1000]);
set(fig1,'PaperPosition',[1 1 1000 1000])
set(fig1,'PaperPositionmode','auto')

cfg = []; cfg.layout = lay1; cfg.xlim = rangeplot; cfg.linewidth = 1;
cfg.axes = 'no';
cond.powspctrm = (condgrads2.powspctrm);
base.powspctrm = (basegrads2.powspctrm);
ft_multiplotER(cfg,cond,base)

print('-dpng',['C:\Users\bgauthie\Desktop\TEMP_WORK\Grads2' sub 'multi_CondVsBaseline_modal-alpha_v2.png']);

