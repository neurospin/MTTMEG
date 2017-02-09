function resonance_freqanalysis_plot_v2(run,nip)

freqvalues = [50 75 100 150 200 300 400 600];

for i = 1:length(freqvalues)
    
    load(['C:\RESONANCE_MEG\DATA\' nip '\processed\' run '_' num2str(freqvalues(i)) '.mat']);
    
    cfg                    = [];
    cfg.method             = 'mtmfft';
    cfg.channel            = 'all';
    cfg.taper              = 'hanning';
    cfg.output             = 'pow';
    cfg.taper              = 'dpss';
    cfg.foi                = 0.1:0.1:95;
    cfg.tapsmofrq          = 0.1;
    cfg.trials             = 'all';
    cfg.keeptrials         = 'yes';
    
    FREQ                   = ft_freqanalysis(cfg,DATA);
    
    scrsz = get(0,'ScreenSize');
    fig   = figure('position',scrsz);
    set(fig,'PaperPosition',scrsz)
    set(fig,'PaperPositionMode','auto')
    
    for j = 1:4
        subplot(4,1,j)
        tmp = []; tmp = squeeze(mean(FREQ.powspctrm(j,:,:)));
        semilogx(FREQ.freq,tmp,'linewidth',2);
        set(gca,'xtick',[0.8 1.25 1.7 2.5 3.3 5 6.7 10 13.3 20 40 80],'xticklabel',[0.83 1.25 1.67 2.5 3.3 5 6.7 10 13.3 20 40 80])
        axis([0.8 120 (min(tmp(10:end))) (max(tmp(10:end)))])
        title([nip ' : ' num2str(freqvalues(i))])
    end
    
end