function resonance_freq_gdavg_plot_v2(nip)

freqvalues = [50 75 100 150 200 300 400 600];

scrsz = get(0,'ScreenSize');
fig   = figure('position',scrsz);
set(fig,'PaperPosition',scrsz)
set(fig,'PaperPositionMode','auto')

for i = 1:length(freqvalues)
    load(['C:\RESONANCE_MEG\DATA\' nip '\freq\freqsub_' num2str(freqvalues(i)) '.mat']);
    load(['C:\RESONANCE_MEG\DATA\' nip '\freq\freqsub_' num2str(freqvalues(i)) '_baseline.mat']);    
    subplot(4,2,i)
    loglog(log2(FREQSUB.freq),mean(FREQSUB.powspctrm),'linewidth',2,'color','b'); hold on
    loglog(FREQbSUB.freq,mean(FREQbSUB.powspctrm),'linewidth',2,'color','r'); hold on
    set(gca,'xtick',[0.8 1.25 1.7 2.5 3.3 5 6.7 10 13.3 20 40 80],'xticklabel',[0.83 1.25 1.67 2.5 3.3 5 6.7 10 13.3 20 40 80])
    axis([0.5 120 (min(mean(FREQSUB.powspctrm(:,10:end)))) (max(mean(FREQSUB.powspctrm(:,10:end))))])
    title([num2str(freqvalues(i)) ' ms'],'fontsize',12)
    xlabel('frequency');ylabel('power');
end

print('-dpng',['C:\RESONANCE_MEG\DATA\' nip '\plots\freqsub_' nip '.png'])

freqvalues = [50 75 100 150 200 300 400 600];

scrsz = get(0,'ScreenSize');
fig   = figure('position',scrsz);
set(fig,'PaperPosition',scrsz)
set(fig,'PaperPositionMode','auto')

for i = 1:length(freqvalues)
    load(['C:\RESONANCE_MEG\DATA\' nip '\freq\freqsub_' num2str(freqvalues(i)) '.mat']);
    load(['C:\RESONANCE_MEG\DATA\' nip '\freq\freqsub_' num2str(freqvalues(i)) '_baseline.mat']);    
    subplot(4,2,i)
    tmp = [];
    tmp = mean(FREQSUB.powspctrm) - mean(FREQbSUB.powspctrm);
    semilogx(FREQSUB.freq,tmp,'linewidth',2,'color','k'); hold on
    set(gca,'xtick',[0.8 1.25 1.7 2.5 3.3 5 6.7 10 13.3 20 40 80],'xticklabel',[0.83 1.25 1.67 2.5 3.3 5 6.7 10 13.3 20 40 80])
    axis([0.8 120 (min(tmp(:,10:end))) (max(tmp(:,10:end)))])
    title([nip ' : ' num2str(freqvalues(i)) ' ms'],'fontsize',12)
    xlabel('frequency');ylabel('power');
end

print('-dpng',['C:\RESONANCE_MEG\DATA\' nip '\plots\freqdiffsub_' nip '.png'])