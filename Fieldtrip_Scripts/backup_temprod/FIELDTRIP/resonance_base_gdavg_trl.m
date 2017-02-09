function resonance_base_gdavg_trl(nip,varargin)

freqvalues = [50 75 100 150 200 300 400 600];

% Mags
for f = 1:length(freqvalues)
    
    for i = 1:length(varargin)
        freq{i} = load(['C:\RESONANCE_MEG\DATA\' nip '\freq\Mags_freq_' varargin{i} '_' num2str(freqvalues(f)) '_baseline.mat']);
    end
    
    cfg                = [];
    cfg.keepindividual = 'no';
    cfg.foilim         = 'all';
    cfg.channel        = 'all';
    
    instruct           = [];
    instruct           = ['FREQbSUB = ft_freqgrandaverage(cfg'];
    for i = 1:length(varargin)
        instruct = [instruct ',freq{1,' num2str(i) '}.FREQb'];
    end
    
    eval([instruct ')']);
    
    save(['C:\RESONANCE_MEG\DATA\' nip '\freq\Mags_freqsub_' num2str(freqvalues(f)) '_baseline.mat'],'FREQbSUB')
        
    FREQB{f} = FREQbSUB;
    
end

cfg                = [];
cfg.keepindividual = 'no';
cfg.foilim         = 'all';
cfg.channel        = 'all';

FREQB_allcond = ft_freqgrandaverage(cfg,FREQB{1},FREQB{2},FREQB{3},FREQB{4},FREQB{5},FREQB{6},FREQB{7},FREQB{8});

save(['C:\RESONANCE_MEG\DATA\' nip '\freq\Mags_freqsuball_baseline.mat'],'FREQB_allcond')

% Grads1
for f = 1:length(freqvalues)
    
    for i = 1:length(varargin)
        freq{i} = load(['C:\RESONANCE_MEG\DATA\' nip '\freq\Grads1_freq_' varargin{i} '_' num2str(freqvalues(f)) '_baseline.mat']);
    end
    
    cfg                = [];
    cfg.keepindividual = 'no';
    cfg.foilim         = 'all';
    cfg.channel        = 'all';
    
    instruct           = [];
    instruct           = ['FREQbSUB = ft_freqgrandaverage(cfg'];
    for i = 1:length(varargin)
        instruct = [instruct ',freq{1,' num2str(i) '}.FREQb'];
    end
    
    eval([instruct ')']);
    
    save(['C:\RESONANCE_MEG\DATA\' nip '\freq\Grads1_freqsub_' num2str(freqvalues(f)) '_baseline.mat'],'FREQbSUB')
        
    FREQB{f} = FREQbSUB;
    
end

cfg                = [];
cfg.keepindividual = 'no';
cfg.foilim         = 'all';
cfg.channel        = 'all';

FREQB_allcond = ft_freqgrandaverage(cfg,FREQB{1},FREQB{2},FREQB{3},FREQB{4},FREQB{5},FREQB{6},FREQB{7},FREQB{8});

save(['C:\RESONANCE_MEG\DATA\' nip '\freq\Grads1_freqsuball_baseline.mat'],'FREQB_allcond')

% Grads2
for f = 1:length(freqvalues)
    
    for i = 1:length(varargin)
        freq{i} = load(['C:\RESONANCE_MEG\DATA\' nip '\freq\Grads2_freq_' varargin{i} '_' num2str(freqvalues(f)) '_baseline.mat']);
    end
    
    cfg                = [];
    cfg.keepindividual = 'no';
    cfg.foilim         = 'all';
    cfg.channel        = 'all';
    
    instruct           = [];
    instruct           = ['FREQbSUB = ft_freqgrandaverage(cfg'];
    for i = 1:length(varargin)
        instruct = [instruct ',freq{1,' num2str(i) '}.FREQb'];
    end
    
    eval([instruct ')']);
    
    save(['C:\RESONANCE_MEG\DATA\' nip '\freq\Grads2_freqsub_' num2str(freqvalues(f)) '_baseline.mat'],'FREQbSUB')
        
    FREQB{f} = FREQbSUB;
    
end

cfg                = [];
cfg.keepindividual = 'no';
cfg.foilim         = 'all';
cfg.channel        = 'all';

FREQB_allcond = ft_freqgrandaverage(cfg,FREQB{1},FREQB{2},FREQB{3},FREQB{4},FREQB{5},FREQB{6},FREQB{7},FREQB{8});

save(['C:\RESONANCE_MEG\DATA\' nip '\freq\Grads2_freqsuball_baseline.mat'],'FREQB_allcond')



