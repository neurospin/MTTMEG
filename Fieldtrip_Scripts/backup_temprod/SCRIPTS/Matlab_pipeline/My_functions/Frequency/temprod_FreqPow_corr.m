function temprod_FreqPow_corr_V1(index,subject,freqband)

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
    
    % reduce broadband to 1-80Hz for noise interpolation and linear trend removal
    fbegin              = find(Fullfreq >= 1);
    fend                = find(Fullfreq <= 80);
    fband               = fbegin(1):fend(end);
    bandFullspctrm      = Fullspctrm(:,:,fband);
    bandFullfreq        = Fullfreq(fband);
    clear Fullspctrm Fullfreq
    Fullspctrm          = bandFullspctrm;
    Fullfreq            = bandFullfreq;
    
    eval(['Fullspctrm' chantype '= Fullspctrm;']);
    
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
    
    % 1/f^a debiasing 
    n                   = length(unique(Fullfreq));
    tmp                 = find(Fullfreq <= 80);
    for x = 1:size(Fullspctrm,1)
        for y = 1:size(Fullspctrm,2)
            cutoff                = Fullspctrm(x,y,tmp(1)); % i.e cutoff value chosed at 50hz
            AlphaEst(x,y)         = 1 + n*(sum(log(squeeze(Fullspctrm(x,y,:))/cutoff))).^(-1);
            Fullspctrm_debiased(x,y,:)   = squeeze(Fullspctrm(x,y,:))'./(unique(Fullfreq)).^(-AlphaEst(x,y));
        end
    end
    Fullspctrm = Fullspctrm_debiased; clear Fullspctrm_debiased
    
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
    MinSide = min(mean(FullspctrmMags(i,:,:)));
    C = cumsum((squeeze(mean(FullspctrmMags(i,:,:))) - ones(size(FullspctrmMags,3),1)*MinSide));
    j = 1;
    while C(j) <= C(end)/2
        Fpeak(i) = j;
        Fpeakpow(i) = mean(FullspctrmMags(i,:,Fpeak(i)));
        j = j+1;
    end
end
MaxPSD     = Fpeakpow;
MaxPSDfreq = Fpeak;

[R1,p1] = corr([asc_ord(:,1) Fullfreq(MaxPSDfreq)'],'type','Pearson');
s = subplot(2,4,1);
plot(Fullfreq(MaxPSDfreq),(asc_ord(:,1))/0.250,'marker','*','linestyle','none')   
axis([min(Fullfreq) max(Fullfreq) (min(asc_ord(:,1))/0.250) (max(asc_ord(:,1))/0.250)]);
set(gca,'YDir','reverse')
title(['Corr coeff : ' round(num2str(R1(2,1))*1000)/1000 ', pval = ' round(num2str(p1(2,1))*1000)/1000])
ylabel('duration (ms)');
xlabel('frequency (hz)');

for i = 1:size(FullspctrmGradslong,1)
    MinSide = min(mean(FullspctrmGradslong(i,:,:)));
    C = cumsum((squeeze(mean(FullspctrmGradslong(i,:,:))) - ones(size(FullspctrmGradslong,3),1)*MinSide));
    j = 1;
    while C(j) <= C(end)/2
        Fpeak(i) = j;
        Fpeakpow(i) = mean(FullspctrmGradslong(i,:,Fpeak(i)));
        j = j+1;
    end
end
MaxPSD     = Fpeakpow;
MaxPSDfreq = Fpeak;

[R2,p2] = corr([asc_ord(:,1) Fullfreq(MaxPSDfreq)'],'type','Pearson');
s = subplot(2,4,2);
plot(Fullfreq(MaxPSDfreq),(asc_ord(:,1))/0.250,'marker','*','linestyle','none')   
axis([min(Fullfreq) max(Fullfreq) (min(asc_ord(:,1))/0.250) (max(asc_ord(:,1))/0.250)]);
set(gca,'YDir','reverse')
title(['Corr coeff : ' round(num2str(R2(2,1))*1000)/1000 ', pval = ' round(num2str(p2(2,1))*1000)/1000])
ylabel('duration (ms)');
xlabel('frequency (hz)');

for i = 1:size(FullspctrmGradslat,1)
    MinSide = min([mean(FullspctrmGradslat(i,:,:))]);
    C = cumsum((squeeze(mean(FullspctrmGradslat(i,:,:))) - ones(size(FullspctrmGradslat,3),1)*MinSide));
    j = 1;
    while C(j) <= C(end)/2
        Fpeak(i) = j;
        Fpeakpow(i) = mean(FullspctrmGradslat(i,:,Fpeak(i)));
        j = j+1;
    end
end
MaxPSD     = Fpeakpow;
MaxPSDfreq = Fpeak;

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
clear Fpeak MaxPSDfreq
numpoints = round(2/((Fullfreq(end) - Fullfreq(1))/length(Fullfreq)));

for i = 1:size(FullspctrmMags,1)
    MinSide = min(mean(FullspctrmMags(i,:,:)));
    C = cumsum((squeeze(mean(FullspctrmMags(i,:,:))) - ones(size(FullspctrmMags,3),1)*MinSide));
%     test(i,:) = (squeeze(mean(Fullspctrm(i,:,:))))'; 
%     mysubplot(7,10,i);
%     plot(test(i,:))
    j = 1;
    while C(j) <= C(end)/2
        clear Fpeak
        if (j-numpoints)     <= 0
            infbound         =  1;
        elseif (j-numpoints) >  0
            infbound         =  j - numpoints;
        end
        if (j+numpoints)     >= length(Fullfreq)
            supbound         =  length(Fullfreq);
        elseif (j+numpoints) <  length(Fullfreq)
            supbound         =  j + numpoints;
        end
        Fpeak(i,:)           =  infbound:supbound;
        Fpeakpow(i)          =  mean(squeeze((mean(FullspctrmMags(i,:,Fpeak(i,:))))));
        j                    =  j+1;
    end
end
MaxPSD     = Fpeakpow;
MaxPSDfreq = Fpeak(i,:);

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
    MinSide = min(mean(FullspctrmGradslong(i,:,:)));
    C = cumsum((squeeze(mean(FullspctrmGradslong(i,:,:))) - ones(size(FullspctrmGradslong,3),1)*MinSide));
%     test(i,:) = (squeeze(mean(Fullspctrm(i,:,:))))'; 
%     mysubplot(7,10,i);
%     plot(test(i,:))
    j = 1;
    while C(j) <= C(end)/2
        clear Fpeak
        if (j-numpoints)     <= 0
            infbound         =  1;
        elseif (j-numpoints) >  0
            infbound         =  j - numpoints;
        end
        if (j+numpoints)     >= length(Fullfreq)
            supbound         =  length(Fullfreq);
        elseif (j+numpoints) <  length(Fullfreq)
            supbound         =  j + numpoints;
        end
        Fpeak(i,:)           =  infbound:supbound;
        Fpeakpow(i)          =  mean(squeeze((mean(FullspctrmGradslong(i,:,Fpeak(i,:))))));
        j                    =  j+1;
    end
end
MaxPSD     = Fpeakpow;
MaxPSDfreq = Fpeak(i,:);

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
    MinSide = min(mean(FullspctrmGradslat(i,:,:)));
    C = cumsum((squeeze(mean(FullspctrmGradslat(i,:,:))) - ones(size(FullspctrmGradslat,3),1)*MinSide));
%     test(i,:) = (squeeze(mean(Fullspctrm(i,:,:))))'; 
%     mysubplot(7,10,i);
%     plot(test(i,:))
    j = 1;
    while C(j) <= C(end)/2
        clear Fpeak
        if (j-numpoints)     <= 0
            infbound         =  1;
        elseif (j-numpoints) >  0
            infbound         =  j - numpoints;
        end
        if (j+numpoints)     >= length(Fullfreq)
            supbound         =  length(Fullfreq);
        elseif (j+numpoints) <  length(Fullfreq)
            supbound         =  j + numpoints;
        end
        Fpeak(i,:)           =  infbound:supbound;
        Fpeakpow(i)          =  mean(squeeze((mean(FullspctrmGradslat(i,:,Fpeak(i,:))))));
        j                    =  j+1;
    end
end
MaxPSD     = Fpeakpow;
MaxPSDfreq = Fpeak(i,:);

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
    '/Fullcorr_' num2str(freqband(1)) '-' num2str(freqband(2)) '_' num2str(index) '.png']);
