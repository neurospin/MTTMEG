function temprod_FreqPow_corr_V2(index,subject,freqband)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

DIR = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];
chantypefull            = {'Mags';'Gradslong';'Gradslat'};

for j = 1:3
    
    Fullspctrm          = [];
    Fullfreq            = [];
    chantype            = chantypefull{j};
    Fullspctrm_path     = [DIR 'FT_spectra/FullspctrmV2_' chantype num2str(index) '.mat'];
    load(Fullspctrm_path);
    tmp = unique(Fullfreq); clear Fullfreq;
    Fullfreq            = tmp;
    
    % line noise removal
    LNfbegin                = find(Fullfreq >= 47);
    LNfend                  = find(Fullfreq <= 53);
    LNfband                 = LNfbegin(1):LNfend(end);
    for i = 1:size(Fullspctrm,1)
        for j = 1:size(Fullspctrm,2)
            L = linspace(Fullspctrm(i,j,LNfbegin(1)),... % beginning of the range
                Fullspctrm(i,j,LNfend(end)),... % end of the range
                LNfend(end) - LNfbegin(1) + 1); % number of frequency bins to replace
            Fullspctrm(i,j,LNfband) = L;
        end
    end
    
    % select frequency band
    fbegin              = find(Fullfreq >= freqband(1));
    fend                = find(Fullfreq <= freqband(2));
    fband               = fbegin(1):fend(end);
    bandFullspctrm      = Fullspctrm(:,:,fband);
    bandFullfreq        = Fullfreq(fband);
    clear Fullspctrm Fullfreq
    Fullspctrm          = bandFullspctrm;
    Fullfreq            = bandFullfreq;
    
    eval(['Fullspctrm' chantype '= Fullspctrm;']);
    
end
  
fig                 = figure('position',[1 1 1280 1024*0.6]);
set(fig,'PaperPosition',[1 1 1280 1024])
set(fig,'PaperPositionMode','auto')
set(fig,'PaperType','A4')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% MAGS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i = 1:size(FullspctrmMags,1)
    [MaxPSD(i), MaxPSDfreq(i)] = max(mean(squeeze(FullspctrmMags(i,:,:))));
end

[R1,p1] = corr([asc_ord(:,1) Fullfreq(MaxPSDfreq)'],'type','Pearson');
s = subplot(2,4,1);
plot(Fullfreq(MaxPSDfreq),(asc_ord(:,1))/0.250,'marker','*','linestyle','none')   
axis([min(Fullfreq) max(Fullfreq) (min(asc_ord(:,1))/0.250) (max(asc_ord(:,1))/0.250)]);
set(gca,'YDir','reverse')
title(['Corr coeff : ' round(num2str(R1(2,1))*1000)/1000 ', pval = ' round(num2str(p1(2,1))*1000)/1000])
ylabel('duration (ms)');
xlabel('frequency (hz)');

for i = 1:size(FullspctrmGradslong,1)
    [MaxPSD(i), MaxPSDfreq(i)] = max(mean(squeeze(FullspctrmGradslong(i,:,:))));
end

[R2,p2] = corr([asc_ord(:,1) Fullfreq(MaxPSDfreq)'],'type','Pearson');
s = subplot(2,4,2);
plot(Fullfreq(MaxPSDfreq),(asc_ord(:,1))/0.250,'marker','*','linestyle','none')   
axis([min(Fullfreq) max(Fullfreq) (min(asc_ord(:,1))/0.250) (max(asc_ord(:,1))/0.250)]);
set(gca,'YDir','reverse')
title(['Corr coeff : ' round(num2str(R2(2,1))*1000)/1000 ', pval = ' round(num2str(p2(2,1))*1000)/1000])
ylabel('duration (ms)');
xlabel('frequency (hz)');

for i = 1:size(FullspctrmGradslat,1)
    [MaxPSD(i), MaxPSDfreq(i)] = max(mean(squeeze(FullspctrmGradslat(i,:,:))));
end
[R3,p3] = corr([asc_ord(:,1) Fullfreq(MaxPSDfreq)'],'type','Pearson');
s = subplot(2,4,3);
plot(Fullfreq(MaxPSDfreq),(asc_ord(:,1))/0.250,'marker','*','linestyle','none')   
axis([min(Fullfreq) max(Fullfreq) (min(asc_ord(:,1))/0.250) (max(asc_ord(:,1))/0.250)]);
set(gca,'YDir','reverse')
title(['Corr coeff : ' round(num2str(R3(2,1))*1000)/1000 ', pval = ' round(num2str(p3(2,1))*1000)/1000])
ylabel('duration (ms)');
xlabel('frequency (hz)');



subplot(2,4,4)
RHO = [R1(1,2) R2(1,2) R3(1,2)];
PVAL = [p1(1,2) p2(1,2) p3(1,2)];
bar(RHO)
for k = 1:3
    if (PVAL(k) <= 0.05) && (RHO(k) >= 0)
        text(k,RHO(k),'*','FontSize',15)
    elseif (PVAL(k) <= 0.01) && (RHO(k) >= 0)
        text(k,RHO(k),'**','FontSize',15)
    elseif (PVAL(k) <= 0.05) && (RHO(k) <= 0)
        text(k,RHO(k)-0.3,'*','FontSize',15)
    elseif (PVAL(k) <= 0.01) && (RHO(k) <= 0)
        text(k,RHO(k)-0.3,'**','FontSize',15)
    end
end
axis([0 4 -1 1])
set(gca,'Ytick',-1:0.25:1,'Yticklabel',-1:0.25:1);
set(gca,'Xtick',1:3,'Xticklabel',{'M';'G1';'G2'});
xlabel('chantype');
ylabel('Pearson corrcoef');
title([subject ' run ' num2str(index)]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear Fpeak MaxPSDfreq MaxPSD Fpeakpow
numpoints = round(2/((Fullfreq(end) - Fullfreq(1))/length(Fullfreq)));

for i = 1:size(FullspctrmMags,1)
    [MaxPSD(i), MaxPSDfreq(i)] = max(mean(squeeze(FullspctrmMags(i,:,:))));
    
    if (MaxPSDfreq(i)-numpoints)     <= 0
        infbound         =  1;
    elseif (MaxPSDfreq(i)-numpoints) >  0
        infbound         =  MaxPSDfreq(i) - numpoints;
    end
    if (MaxPSDfreq(i)+numpoints)     >= length(Fullfreq)
        supbound         =  length(Fullfreq);
    elseif (MaxPSDfreq(i)+numpoints) <  length(Fullfreq)
        supbound         =  MaxPSDfreq(i) + numpoints;
    end
    dataf          =  infbound:supbound;
    Fpeakpow(i)          =  mean(squeeze((mean(FullspctrmMags(i,:,dataf)))));
end
MaxPSD     = Fpeakpow;

[R1,p1] = corr([asc_ord(:,1) MaxPSD'],'type','Pearson');
s = subplot(2,4,5);
plot(MaxPSD,(asc_ord(:,1))/0.250,'marker','*','linestyle','none')   
axis([min(MaxPSD) max(MaxPSD) (min(asc_ord(:,1))/0.250) (max(asc_ord(:,1))/0.250)]);
% set(s,'Ytick',1:round(length(asc_ord)/12):length(asc_ord),'Yticklabel',(asc_ord(1:round(length(asc_ord)/12):end,1)/0.250)');
set(gca,'YDir','reverse')
title(['Corr coeff : ' round(num2str(R1(2,1))*1000)/1000 ', pval = ' round(num2str(p1(2,1))*1000)/1000])
ylabel('duration (ms)');
xlabel('power');

for i = 1:size(FullspctrmGradslong,1)
    [MaxPSD(i), MaxPSDfreq(i)] = max(mean(squeeze(FullspctrmGradslong(i,:,:))));
    
    if (MaxPSDfreq(i)-numpoints)     <= 0
        infbound         =  1;
    elseif (MaxPSDfreq(i)-numpoints) >  0
        infbound         =  MaxPSDfreq(i) - numpoints;
    end
    if (MaxPSDfreq(i)+numpoints)     >= length(Fullfreq)
        supbound         =  length(Fullfreq);
    elseif (MaxPSDfreq(i)+numpoints) <  length(Fullfreq)
        supbound         =  MaxPSDfreq(i) + numpoints;
    end
    dataf          =  infbound:supbound;
    Fpeakpow(i)          =  mean(squeeze((mean(FullspctrmGradslong(i,:,dataf)))));
end
MaxPSD     = Fpeakpow;

[R2,p2] = corr([asc_ord(:,1) MaxPSD'],'type','Pearson');
s = subplot(2,4,6);
plot(MaxPSD,(asc_ord(:,1))/0.250,'marker','*','linestyle','none')   
axis([min(MaxPSD) max(MaxPSD) (min(asc_ord(:,1))/0.250) (max(asc_ord(:,1))/0.250)]);
% set(s,'Ytick',1:round(length(asc_ord)/12):length(asc_ord),'Yticklabel',(asc_ord(1:round(length(asc_ord)/12):end,1)/0.250)');
set(gca,'YDir','reverse')
title(['Corr coeff : ' round(num2str(R2(2,1))*1000)/1000 ', pval = ' round(num2str(p2(2,1))*1000)/1000])
ylabel('duration (ms)');
xlabel('power');

for i = 1:size(FullspctrmGradslat,1)
    [MaxPSD(i), MaxPSDfreq(i)] = max(mean(squeeze(FullspctrmGradslat(i,:,:))));
    
    if (MaxPSDfreq(i)-numpoints)     <= 0
        infbound         =  1;
    elseif (MaxPSDfreq(i)-numpoints) >  0
        infbound         =  MaxPSDfreq(i) - numpoints;
    end
    if (MaxPSDfreq(i)+numpoints)     >= length(Fullfreq)
        supbound         =  length(Fullfreq);
    elseif (MaxPSDfreq(i)+numpoints) <  length(Fullfreq)
        supbound         =  MaxPSDfreq(i) + numpoints;
    end
    dataf          =  infbound:supbound;
    Fpeakpow(i)          =  mean(squeeze((mean(FullspctrmGradslat(i,:,dataf)))));
end
MaxPSD     = Fpeakpow;

[R3,p3] = corr([asc_ord(:,1) MaxPSD'],'type','Pearson');
s = subplot(2,4,7);
plot(MaxPSD,(asc_ord(:,1))/0.250,'marker','*','linestyle','none')   
axis([min(MaxPSD) max(MaxPSD) (min(asc_ord(:,1))/0.250) (max(asc_ord(:,1))/0.250)]);
% set(s,'Ytick',1:round(length(asc_ord)/12):length(asc_ord),'Yticklabel',(asc_ord(1:round(length(asc_ord)/12):end,1)/0.250)');
set(gca,'YDir','reverse')
title(['Corr coeff : ' round(num2str(R3(2,1))*1000)/1000 ', pval = ' round(num2str(p3(2,1))*1000)/1000])
ylabel('duration (ms)');
xlabel('power');

subplot(2,4,8)
RHO = [R1(1,2) R2(1,2) R3(1,2)];
PVAL = [p1(1,2) p2(1,2) p3(1,2)];
bar(RHO)
for k = 1:3
    if (PVAL(k) <= 0.05) && (RHO(k) >= 0)
        text(k,RHO(k),'*','FontSize',15)
    elseif (PVAL(k) <= 0.01) && (RHO(k) >= 0)
        text(k,RHO(k),'**','FontSize',15)
    elseif (PVAL(k) <= 0.05) && (RHO(k) <= 0)
        text(k,RHO(k)-0.3,'*','FontSize',15)
    elseif (PVAL(k) <= 0.01) && (RHO(k) <= 0)
        text(k,RHO(k)-0.3,'**','FontSize',15)
    end
end
axis([0 4 -1 1])
set(gca,'Ytick',-1:0.25:1,'Yticklabel',-1:0.25:1);
set(gca,'Xtick',1:3,'Xticklabel',{'M';'G1';'G2'});
xlabel('chantype');
ylabel('Pearson corrcoef');
title([subject ' run ' num2str(index)]);

print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
    '/FullcorrV2_' num2str(freqband(1)) '-' num2str(freqband(2)) '_' num2str(index) '.png']);
