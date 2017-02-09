function resonance_freqanalysis_v2(run,nip,tag)

freqvalues = [50 75 100 150 200 300 400 600];

% define channel types
[Grads1,Grads2,Mags]   = grads_for_layouts(tag);

for i = 1:length(freqvalues)
    
    load(['C:\RESONANCE_MEG\DATA\' nip '\processed\' run '_' num2str(freqvalues(i)) '_stimfreq.mat']);
    
    cfg                    = [];
    cfg.method             = 'mtmfft';
    cfg.channel            = Mags;
    cfg.taper              = 'hanning';
    cfg.output             = 'pow';
    cfg.taper              = 'dpss';
    cfg.foi                = 0.1:0.05:95;
    cfg.tapsmofrq          = 0.083;
    cfg.trials             = 'all';
    cfg.keeptrials         = 'yes';
    cfg.polyremoval        = -1;    
    
    FREQ                   = ft_freqanalysis(cfg,DATA);
    save(['C:\RESONANCE_MEG\DATA\' nip '\freq\Mags_freq_' run '_' num2str(freqvalues(i)) '_stimfreq_v2.mat'],'FREQ');
    
    cfg.channel            = Grads1;
    FREQ                   = ft_freqanalysis(cfg,DATA);
    save(['C:\RESONANCE_MEG\DATA\' nip '\freq\Grads1_freq_' run '_' num2str(freqvalues(i)) '_stimfreq_v2.mat'],'FREQ');

    cfg.channel            = Grads2;
    FREQ                   = ft_freqanalysis(cfg,DATA);
    save(['C:\RESONANCE_MEG\DATA\' nip '\freq\Grads2_freq_' run '_' num2str(freqvalues(i)) '_stimfreq_v2.mat'],'FREQ');    
    
end

for i = 1:length(freqvalues)
    
    load(['C:\RESONANCE_MEG\DATA\' nip '\processed\' run '_' num2str(freqvalues(i)) '_baseline.mat']);
    
    cfg                    = [];
    cfg.method             = 'mtmfft';
    cfg.channel            = Mags;
    cfg.taper              = 'hanning';
    cfg.output             = 'pow';
    cfg.taper              = 'dpss';
    cfg.foi                = 0.1:0.05:95;
    cfg.tapsmofrq          = 0.083;
    cfg.trials             = 'all';
    cfg.keeptrials         = 'yes';
    cfg.polyremoval        = -1;
    
    FREQb                   = ft_freqanalysis(cfg,DATA);
    save(['C:\RESONANCE_MEG\DATA\' nip '\freq\Mags_freq_' run '_' num2str(freqvalues(i)) '_baseline_v2.mat'],'FREQb');
    
    cfg.channel            = Grads1;
    FREQb                   = ft_freqanalysis(cfg,DATA);
    save(['C:\RESONANCE_MEG\DATA\' nip '\freq\Grads1_freq_' run '_' num2str(freqvalues(i)) '_baseline_v2.mat'],'FREQb');

    cfg.channel            = Grads2;
    FREQb                   = ft_freqanalysis(cfg,DATA);
    save(['C:\RESONANCE_MEG\DATA\' nip '\freq\Grads2_freq_' run '_' num2str(freqvalues(i)) '_baseline_v2.mat'],'FREQb');    
    
end

