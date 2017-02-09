function [rho1,rho2,pval1,pval2] = temprod_OLD_freqstats(datapath,freqband,chantype,index,subject)

%% Plot basic correlation between frequency peak, frequency peak power and temporal
%% estimates
load(datapath)
load(['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/OLD/processed_' subject '/'...
'Fullspctrm_' chantype num2str(index) '.mat']);
% load(['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/OLD/processed_' subject '/freqdataplot_'...
%     num2str(freqband(1)) '_' num2str(freqband(2)) '_' chantype '.mat']);

Sample                 = [];
for i                  = 1:length(data.time)
    Sample             = [Sample ; length(data.time{i})];
end
fsample                = data.fsample;

freq.powspctrm         = Fullspctrm;
clear Fullspctrm;
freq.powspctrm         = freq.powspctrm(:,:,(length(4:0.2:freqband(1)):(length(4:0.2:freqband(2)))));
freq.freq              = Fullfreq((length(4:0.2:freqband(1)):(length(4:0.2:freqband(2)))));
clear FullFreq
Freq                   = freq.freq;

for k                  = 1:length(Sample)
    hold on
    pmax(k)            = max(mean(squeeze(freq.powspctrm(k,:,:))));
    pmin(k)            = min(mean(squeeze(freq.powspctrm(k,:,:))));
    Pmean              = mean(squeeze(freq.powspctrm(k,:,:)));
    Peak(k)            = find(Pmean == pmax(k));
end

% fig = figure('position',[1 1 1280 1024]);
% 
% %% variables distribution
% nbins = 1;
% subplot(3,4,1)
% hist(Sample/fsample,length(Sample)/nbins);
% title('temporal estimates distribution');
% subplot(3,4,2)
% hist(Freq(Peak),length(Freq(Peak))/nbins);
% title('frequency peaks distribution');
% subplot(3,4,3)
% hist(pmax,length(pmax)/nbins);
% title('frequency peaks power distribution');
% Cycles = [];
% for i = 1:length(Sample)
%     Cycles(i) = (Sample(i)*Freq(Peak(i)))/data.fsample;
% end
% subplot(3,4,4)
% hist(Cycles,length(Cycles)/nbins);
% title('cycles according to frequency peak');
% 
% %% variables boxplots
% hold on
% subplot(3,4,5)
% boxplot(Sample/fsample)
% title('temporal estimates');
% subplot(3,4,6)
% boxplot(Freq(Peak))
% title('Frequency peaks');
% subplot(3,4,7)
% boxplot(pmax);
% title('frequency peaks power distribution');
% subplot(3,4,8)
% boxplot(Cycles)
% title('cycles according to frequency peak');
% 
%% correlations
% hold on
% subplot(3,4,9)
% plot(Sample/fsample,Freq(Peak)','marker','o','LineStyle','none')
% hold on
% ylabel('frequency peaks');xlabel('duration estimates');
% hold on
% H = get(gca);
% line([TrueDur,TrueDur],[H.YLim(1) H.YLim(2)],'color','r','linewidth',2,'linestyle','--');
% hold on
% line([median(Dur/fsample),median(Dur/fsample)],[H.YLim(1) H.YLim(2)],'color','k','linewidth',2);
% [P] = polyfit(Sample/fsample,Freq(Peak),1);
% hold on
% plot(Sample/fsample,polyval(P,Sample/fsample));
[rho1,pval1] = corr((Sample/fsample),Freq(Peak)');
% title(['corr coef : ' num2str(rho1) ', pvalue : ' num2str(pval1)]);
% subplot(3,4,10)
% plot(Sample/fsample,pmax,'marker','o','LineStyle','none')
% hold on
% ylabel('frequency peaks power');xlabel('duration estimates');
% hold on
% % H = get(gca);
% % line([TrueDur,TrueDur],[H.YLim(1) H.YLim(2)],'color','r','linewidth',2,'linestyle','--');
% % hold on
% % line([median(Dur/fsample),median(Dur/fsample)],[H.YLim(1) H.YLim(2)],'color','k','linewidth',2);
% [P] = polyfit(Sample/fsample,pmax,1);
% hold on
% plot(Sample/fsample,polyval(P,Sample/fsample));
[rho2,pval2] = corr((Sample/fsample),pmax');
% title(['corr coef : ' num2str(rho2) ', pvalue : ' num2str(pval2)]);
% hold on 
% subplot(3,4,11)
% plot(Freq(Peak),pmax,'marker','o','LineStyle','none')
% ylabel('frequency peak power'); xlabel('frequency peak');
% 
% 
% print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/OLD/Plots_' subject...
%     '/globalcorr' chantype '-' num2str(freqband(1)) '-' num2str(freqband(2)) 'hz_' num2str(index) '.png']); 





% figure
% subplot(3,3,1)
% [P] = polyfit(Dur,Freq(PeakFreq),1);
% plot(Dur,Freq(PeakFreq)','marker','o','LineStyle','none')
% hold on
% plot(Dur,polyval(P,Dur));
% [rho,pval] = corr(Dur',Freq(PeakFreq)');
% title(['corr coef : ' num2str(rho) ', pvalue : ' num2str(pval)]);
% ylabel('frequency peaks');xlabel('duration estimates');
% hold on
% H = get(gca);
% line([TrueDur*data.fsample,TrueDur*data.fsample],[H.YLim(1)
% H.YLim(2)],'color','r','linewidth',2,'linestyle','--');

% subplot(3,3,2)
% [P] = polyfit(Dur,tmpmax,1);
% plot(Dur,tmpmax,'marker','o','LineStyle','none')
% hold on
% plot(Dur,polyval(P,Dur));
% [rho,pval] = corr(Dur',tmpmax');
% title(['corr coef : ' num2str(rho) ', pvalue : ' num2str(pval)]);
% ylabel('frequency peaks power');xlabel('duration estimates');
% hold on
% H = get(gca);
% line([TrueDur*data.fsample,TrueDur*data.fsample],[H.YLim(1)
% H.YLim(2)],'color','r','linewidth',2,'linestyle','--');