%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% MAGS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all

subjectArray  = {'s10','s11','s12','s13','s14'};
RunArray      = {{[2 4] [5 7]},{[2 4]},{[2 4] [5 7]},{[2 4] [5 7]},{[2 4] [5 7]}};
chantype      = 'Mags';
tag           = 'Laptop';
freqband      = [10 10];
Pad           = 12600;

% set root
root = SetPath(tag);

for i = 1:length(subjectArray)
    instr_est = 'FREQAVG_est = ft_freqgrandaverage([],';
    instr_rep = 'FREQAVG_rep = ft_freqgrandaverage([],';
    for j = 1:length(RunArray{1,i})
        % load data
        ProcDataDir                = [root '/DATA/NEW/processed_' subjectArray{1,i} '/'];
        DataDir                    = [ProcDataDir 'FT_spectra/FREQ_matchestrep_' chantype '_RUN' num2str(RunArray{1,i}{1,j}(2),'%02i') '.mat'];
        eval(['FREQ' num2str(j) ' = load(DataDir)']);
        eval(['FREQ' num2str(j) '.freqest = ft_freqdescriptives([],FREQ' num2str(j) '.freqest)']);
        eval(['FREQ' num2str(j) '.freqrep = ft_freqdescriptives([],FREQ' num2str(j) '.freqrep)']);
        instr_est = [instr_est ' FREQ' num2str(j) '.freqest,'];
        instr_rep = [instr_rep ' FREQ' num2str(j) '.freqrep,'];
    end
    instr_est(end) = [];
    instr_rep(end) = [];
    eval([instr_est ');' ]);
    eval([instr_rep ');' ]);
    freqest{1,i} = FREQAVG_est;
    freqrep{1,i} = FREQAVG_rep;
end

cfg                = [];
cfg.keepindividual = 'yes';
FREQ_estimation    = ft_freqgrandaverage(cfg,freqest{1,1},freqest{1,2},freqest{1,3},freqest{1,4},freqest{1,5});
FREQ_replay        = ft_freqgrandaverage(cfg,freqrep{1,1},freqrep{1,2},freqrep{1,3},freqrep{1,4},freqrep{1,5});

% get neighbourgs for statistical testing
load('C:\TEMPROD\SCRIPTS\Matlab_pipeline\tools_tmp\pipeline_tmp\neighbours.mat')
for a = 1:104
    neighbours{1,a}.label = ['MEG' neighbours{1,a}.label];
    for b = 1:length(neighbours{1,a}.neighblabel)
        neighbours{1,a}.neighblabel{b} = ['MEG' neighbours{1,a}.neighblabel{b}];
    end
end

cfg                           = [];
cfg.layout                    = [root '/SCRIPTS/Layouts_fieldtrip/NM306mag.lay'];
lay1                          = ft_prepare_layout(cfg,FREQ_estimation);
lay1.label                    = FREQ_estimation.label;

for i = 1:45
    % test based on fieldtrip tutorial
    cfg = [];
    cfg.channel          = 'all';
    cfg.latency          = 'all';
    cfg.frequency        = [i i];
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
    
    cfg.design           = [1 1 1 1 1 2 2 2 2 2];
    cfg.ivar  = 1;
    
    [stat] = ft_freqstatistics(cfg,FREQ_estimation,FREQ_replay);
    STATS  = stat;
    
    % compute avrage diff powspctrm
    fbegin              = find(FREQ_estimation.freq >= i);
    fend                = find(FREQ_estimation.freq <= i);
    fband               = fbegin(1):fend(end);
    freq.powspctrm      = FREQ_estimation.powspctrm(:,:,fband);
    freq.freq           = FREQ_estimation.freq(fband);
    
    stat.diff = squeeze(mean((FREQ_estimation.powspctrm(:,:,freq.freq) - FREQ_replay.powspctrm(:,:,freq.freq))))';
    
    cfg = [];
    cfg.alpha                     = 0.05;
    cfg.highlightseries           = {'on','on','on','on','on'};
    cfg.highlightsymbolseries     = ['.','.','.','.','.'];
    cfg.highlightsizeseries       = [20 20 20 20 20 20];
    cfg.highlightcolorpos         = [0 0 0];
    cfg.highlightcolorneg         = [1 1 1];
    cfg.style                     = 'straight';
    
    cfg.zparam                    = 'diff';
    cfg.zlim                      = [-10e-29 10e-29];
    cfg.colorbar                  = 'yes';
    cfg.layout                    = lay1;
    cfg.comment                   = [num2str(i) 'Hz'];
    
    if sum(stat.mask) ~= 0
        
        ft_clusterplot(cfg, stat);
        
        %% save data %%
        print('-dpng',['C:\TEMPROD\DATA\NEW\FIG_THESIS\SCANALLF\estrep\STATSPOW_TMAP_ESTREP_RUN_all_mags_' ...
            '_' num2str(i) 'Hz.png'])
        
        
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% GRADS1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all

[Grads1,Grads2,Mags] = grads_for_layouts('Laptop');

subjectArray  = {'s10','s11','s12','s13','s14'};
RunArray      = {{[2 4] [5 7]},{[2 4]},{[2 4] [5 7]},{[2 4] [5 7]},{[2 4] [5 7]}};
chantype      = 'Grads1';
tag           = 'Laptop';
freqband      = [10 10];
Pad           = 12600;

% set root
root = SetPath(tag);

for i = 1:length(subjectArray)
    instr_est = 'FREQAVG_est = ft_freqgrandaverage([],';
    instr_rep = 'FREQAVG_rep = ft_freqgrandaverage([],';
    for j = 1:length(RunArray{1,i})
        % load data
        ProcDataDir                = [root '/DATA/NEW/processed_' subjectArray{1,i} '/'];
        DataDir                    = [ProcDataDir 'FT_spectra/FREQ_matchestrep_' chantype '_RUN' num2str(RunArray{1,i}{1,j}(2),'%02i') '.mat'];
        eval(['FREQ' num2str(j) ' = load(DataDir)']);
        eval(['FREQ' num2str(j) '.freqest = freqdescriptives([],FREQ' num2str(j) '.freqest)']);
        eval(['FREQ' num2str(j) '.freqrep = freqdescriptives([],FREQ' num2str(j) '.freqrep)']);
        instr_est = [instr_est ' FREQ' num2str(j) '.freqest,'];
        instr_rep = [instr_rep ' FREQ' num2str(j) '.freqrep,'];
    end
    instr_est(end) = [];
    instr_rep(end) = [];
    eval([instr_est ');' ]);
    eval([instr_rep ');' ]);
    freqest{1,i} = FREQAVG_est;
    freqrep{1,i} = FREQAVG_rep;
end

cfg                = [];
cfg.keepindividual = 'yes';
FREQ_estimation    = ft_freqgrandaverage(cfg,freqest{1,1},freqest{1,2},freqest{1,3},freqest{1,4},freqest{1,5});
FREQ_replay        = ft_freqgrandaverage(cfg,freqrep{1,1},freqrep{1,2},freqrep{1,3},freqrep{1,4},freqrep{1,5});

% get neighbourgs for statistical testing
load('C:\TEMPROD\SCRIPTS\Matlab_pipeline\tools_tmp\pipeline_tmp\neighbours.mat')
for a = 1:104
    neighbours{1,a}.label = ['MEG' neighbours{1,a}.label];
    for b = 1:length(neighbours{1,a}.neighblabel)
        neighbours{1,a}.neighblabel{b} = ['MEG' neighbours{1,a}.neighblabel{b}];
    end
end

cfg                           = [];
cfg.layout                    = [root '/SCRIPTS/Layouts_fieldtrip/NM306mag.lay'];
lay1                          = ft_prepare_layout(cfg,FREQ_estimation);
lay1.label                    = Mags';
FREQ_estimation.label         = Mags';
FREQ_replay.label             = Mags;

for i = 1:45
    % test based on fieldtrip tutorial
    cfg = [];
    cfg.channel          = 'all';
    cfg.latency          = 'all';
    cfg.frequency        = [i i];
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
    
    cfg.design           = [1 1 1 1 1 2 2 2 2 2];
    cfg.ivar  = 1;
    
    [stat] = ft_freqstatistics(cfg,FREQ_estimation,FREQ_replay);
    STATS  = stat;
    
    % compute avrage diff powspctrm
    fbegin              = find(FREQ_estimation.freq >= i);
    fend                = find(FREQ_estimation.freq <= i);
    fband               = fbegin(1):fend(end);
    freq.powspctrm      = FREQ_estimation.powspctrm(:,:,fband);
    freq.freq           = FREQ_estimation.freq(fband);
    
    stat.diff = squeeze(mean((FREQ_estimation.powspctrm(:,:,freq.freq) - FREQ_replay.powspctrm(:,:,freq.freq))))';
    
    cfg = [];
    cfg.alpha                     = 0.05;
    cfg.highlightseries           = {'on','on','on','on','on'};
    cfg.highlightsymbolseries     = ['.','.','.','.','.'];
    cfg.highlightsizeseries       = [20 20 20 20 20 20];
    cfg.highlightcolorpos         = [0 0 0];
    cfg.highlightcolorneg         = [1 1 1];
    cfg.style                     = 'straight';
    
    cfg.zparam                    = 'diff';
    cfg.zlim                      = [-10e-29 10e-29];
    cfg.colorbar                  = 'yes';
    cfg.layout                    = lay1;
    cfg.comment                   = [num2str(i) 'Hz'];
    
    if sum(stat.mask) ~= 0
        
        ft_clusterplot(cfg, stat);
        
        %% save data %%
        print('-dpng',['C:\TEMPROD\DATA\NEW\FIG_THESIS\SCANALLF\estrep\STATSPOW_TMAP_ESTREP_RUN_all_mags_' ...
            '_' num2str(i) 'Hz.png'])
        
        
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% GRADS2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all

[Grads1,Grads2,Mags] = grads_for_layouts('Laptop');

subjectArray  = {'s10','s11','s12','s13','s14'};
RunArray      = {{[2 4] [5 7]},{[2 4]},{[2 4] [5 7]},{[2 4] [5 7]},{[2 4] [5 7]}};
chantype      = 'Grads2';
tag           = 'Laptop';
freqband      = [10 10];
Pad           = 12600;

% set root
root = SetPath(tag);

for i = 1:length(subjectArray)
    instr_est = 'FREQAVG_est = ft_freqgrandaverage([],';
    instr_rep = 'FREQAVG_rep = ft_freqgrandaverage([],';
    for j = 1:length(RunArray{1,i})
        % load data
        ProcDataDir                = [root '/DATA/NEW/processed_' subjectArray{1,i} '/'];
        DataDir                    = [ProcDataDir 'FT_spectra/FREQ_matchestrep_' chantype '_RUN' num2str(RunArray{1,i}{1,j}(2),'%02i') '.mat'];
        eval(['FREQ' num2str(j) ' = load(DataDir)']);
        eval(['FREQ' num2str(j) '.freqest = freqdescriptives([],FREQ' num2str(j) '.freqest)']);
        eval(['FREQ' num2str(j) '.freqrep = freqdescriptives([],FREQ' num2str(j) '.freqrep)']);
        instr_est = [instr_est ' FREQ' num2str(j) '.freqest,'];
        instr_rep = [instr_rep ' FREQ' num2str(j) '.freqrep,'];
    end
    instr_est(end) = [];
    instr_rep(end) = [];
    eval([instr_est ');' ]);
    eval([instr_rep ');' ]);
    freqest{1,i} = FREQAVG_est;
    freqrep{1,i} = FREQAVG_rep;
end

cfg                = [];
cfg.keepindividual = 'yes';
FREQ_estimation    = ft_freqgrandaverage(cfg,freqest{1,1},freqest{1,2},freqest{1,3},freqest{1,4},freqest{1,5});
FREQ_replay        = ft_freqgrandaverage(cfg,freqrep{1,1},freqrep{1,2},freqrep{1,3},freqrep{1,4},freqrep{1,5});

% get neighbourgs for statistical testing
load('C:\TEMPROD\SCRIPTS\Matlab_pipeline\tools_tmp\pipeline_tmp\neighbours.mat')
for a = 1:104
    neighbours{1,a}.label = ['MEG' neighbours{1,a}.label];
    for b = 1:length(neighbours{1,a}.neighblabel)
        neighbours{1,a}.neighblabel{b} = ['MEG' neighbours{1,a}.neighblabel{b}];
    end
end

cfg                           = [];
cfg.layout                    = [root '/SCRIPTS/Layouts_fieldtrip/NM306mag.lay'];
lay1                          = ft_prepare_layout(cfg,FREQ_estimation);
lay1.label                    = Mags';
FREQ_estimation.label         = Mags';
FREQ_replay.label             = Mags;

for i = 1:45
    % test based on fieldtrip tutorial
    cfg = [];
    cfg.channel          = 'all';
    cfg.latency          = 'all';
    cfg.frequency        = [i i];
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
    
    cfg.design           = [1 1 1 1 1 2 2 2 2 2];
    cfg.ivar  = 1;
    
    [stat] = ft_freqstatistics(cfg,FREQ_estimation,FREQ_replay);
    STATS  = stat;
    
    % compute avrage diff powspctrm
    fbegin              = find(FREQ_estimation.freq >= i);
    fend                = find(FREQ_estimation.freq <= i);
    fband               = fbegin(1):fend(end);
    freq.powspctrm      = FREQ_estimation.powspctrm(:,:,fband);
    freq.freq           = FREQ_estimation.freq(fband);
    
    stat.diff = squeeze(mean((FREQ_estimation.powspctrm(:,:,freq.freq) - FREQ_replay.powspctrm(:,:,freq.freq))))';
    
    cfg = [];
    cfg.alpha                     = 0.05;
    cfg.highlightseries           = {'on','on','on','on','on'};
    cfg.highlightsymbolseries     = ['.','.','.','.','.'];
    cfg.highlightsizeseries       = [20 20 20 20 20 20];
    cfg.highlightcolorpos         = [0 0 0];
    cfg.highlightcolorneg         = [1 1 1];
    cfg.style                     = 'straight';
    
    cfg.zparam                    = 'diff';
    cfg.zlim                      = [-10e-29 10e-29];
    cfg.colorbar                  = 'yes';
    cfg.layout                    = lay1;
    cfg.comment                   = [num2str(i) 'Hz'];
    
    if sum(stat.mask) ~= 0
        
        ft_clusterplot(cfg, stat);
        
        %% save data %%
        print('-dpng',['C:\TEMPROD\DATA\NEW\FIG_THESIS\SCANALLF\estrep\STATSPOW_TMAP_ESTREP_RUN_all_mags_' ...
            '_' num2str(i) 'Hz.png'])
        
        
    end
end

