function resonance_freq_gdavg_trl(nip,varargin)

freqvalues = [50 75 100 150 200 300 400 600];

for f = 1:length(freqvalues)
    
    for i = 1:length(varargin)
        freq{i} = load(['C:\RESONANCE_MEG\DATA\' nip '\freq\Mags_freq_' varargin{i} '_' num2str(freqvalues(f)) '_stimfreq.mat']);
    end
    
    cfg                = [];
    cfg.keepindividual = 'no';
    cfg.foilim         = 'all';
    cfg.channel        = 'all';
    
    instruct           = [];
    instruct           = ['FREQSUB = ft_freqgrandaverage(cfg'];
    for i = 1:length(varargin)
        instruct = [instruct ',freq{1,' num2str(i) '}.FREQ'];
    end
    
    eval([instruct ')']);
    
    save(['C:\RESONANCE_MEG\DATA\' nip '\freq\Mags_freqsub_' num2str(freqvalues(f)) '_stimfreq.mat'],'FREQSUB')
        
end

for f = 1:length(freqvalues)
    
    for i = 1:length(varargin)
        freq{i} = load(['C:\RESONANCE_MEG\DATA\' nip '\freq\Grads1_freq_' varargin{i} '_' num2str(freqvalues(f)) '_stimfreq.mat']);
    end
    
    cfg                = [];
    cfg.keepindividual = 'no';
    cfg.foilim         = 'all';
    cfg.channel        = 'all';
    
    instruct           = [];
    instruct           = ['FREQSUB = ft_freqgrandaverage(cfg'];
    for i = 1:length(varargin)
        instruct = [instruct ',freq{1,' num2str(i) '}.FREQ'];
    end
    
    eval([instruct ')']);
    
    save(['C:\RESONANCE_MEG\DATA\' nip '\freq\Grads1_freqsub_' num2str(freqvalues(f)) '_stimfreq.mat'],'FREQSUB')
        
end


for f = 1:length(freqvalues)
    
    for i = 1:length(varargin)
        freq{i} = load(['C:\RESONANCE_MEG\DATA\' nip '\freq\Grads2_freq_' varargin{i} '_' num2str(freqvalues(f)) '_stimfreq.mat']);
    end
    
    cfg                = [];
    cfg.keepindividual = 'no';
    cfg.foilim         = 'all';
    cfg.channel        = 'all';
    
    instruct           = [];
    instruct           = ['FREQSUB = ft_freqgrandaverage(cfg'];
    for i = 1:length(varargin)
        instruct = [instruct ',freq{1,' num2str(i) '}.FREQ'];
    end
    
    eval([instruct ')']);
    
    save(['C:\RESONANCE_MEG\DATA\' nip '\freq\Grads2_freqsub_' num2str(freqvalues(f)) '_stimfreq.mat'],'FREQSUB')
        
end

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
        
end

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
        
end

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
        
end

