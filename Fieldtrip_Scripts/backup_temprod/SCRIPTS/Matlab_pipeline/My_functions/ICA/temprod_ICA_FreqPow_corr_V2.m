function temprod_ICA_FreqPow_corr_V2(indexrun,subject,numcomponent,fsample,freqbandview)

chunksband = {[1 4];[4 7.5];[7.5 14];[15 25];[25 80]};

for iind = 1:length(chunksband);
    freqband = chunksband{iind};
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Dir = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject];

par.ProcDataDir         = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];
load([par.ProcDataDir 'FT_ICs/runica-comp' num2str(numcomponent) 'V4_freq' num2str(indexrun) '.mat']);

Fullfreq                = freq.freq;
Fullspctrm              = freq.powspctrm;
asc_ord                 = freq.cumsumcnt;

fig                     = figure('position',[1 1 1280 1024*0.6]);
set(fig,'PaperPosition',[1 1 1280 1024])
set(fig,'PaperPositionMode','auto')

chantypefull            = {'Mags';'Gradslong';'Gradslat'};

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
fbegin              = find(Fullfreq >= freqbandview(1));
fend                = find(Fullfreq <= freqbandview(2));
fband               = fbegin(1):fend(end);
bandFullspctrm      = Fullspctrm(:,:,fband);
bandFullfreq        = Fullfreq(fband);
clear Fullspctrm Fullfreq
Fullspctrm          = bandFullspctrm;
Fullfreq            = bandFullfreq;

RHO = []; PVAL = [];
for i = 1:numcomponent
    clear POW DUR FREQ
    
    numpoints = round(1/((Fullfreq(end) - Fullfreq(1))/length(Fullfreq)));
    for l = 1:size(Fullspctrm,1)
        [MaxPSD(l), MaxPSDfreq(l)] = max(squeeze(Fullspctrm(l,i,:)));
        
        if (MaxPSDfreq(l)-numpoints)     <= 0
            infbound    =  1;
        elseif (MaxPSDfreq(l)-numpoints) >  0
            infbound    =  MaxPSDfreq(l) - numpoints;
        end
        if (MaxPSDfreq(l)+numpoints)     >= length(Fullfreq)
            supbound    =  length(Fullfreq);
        elseif (MaxPSDfreq(l)+numpoints) <  length(Fullfreq)
            supbound    =  MaxPSDfreq(l) + numpoints;
        end
        dataf           =  infbound:supbound;
        Fpeakpow(l)     =  mean(squeeze((Fullspctrm(l,i,dataf))));
    end
    MaxPSD              = Fpeakpow;
    POW                 = MaxPSD';
    DUR                 = asc_ord/(fsample);
    [x,y]               = corr([POW DUR],'type','Pearson');
    RHO(i,2)            = x(2,1);
    PVAL(i,2)           = y(2,1);
     
    for l = 1:size(Fullspctrm,1)
        [MaxPSD(l), MaxPSDfreq(l)] = max(squeeze(Fullspctrm(l,i,:)));
    end
    FREQ                = Fullfreq(MaxPSDfreq)';
    [xf,yf]             = corr([FREQ DUR],'type','Pearson');  
    RHO(i,1)            = xf(2,1);
    PVAL(i,1)           = yf(2,1);
    
    subplot(3,6,i)
    bar(RHO(i,:))
    for k = 1:2
        if (PVAL(i,k) <= 0.01) && (RHO(i,k) >= 0)
            text(k,RHO(i,k),'**','FontSize',15)
        elseif (PVAL(i,k) <= 0.05) && (RHO(i,k) >= 0)
            text(k,RHO(i,k),'*','FontSize',15)
        elseif (PVAL(i,k) <= 0.01) && (RHO(i,k) <= 0)
            text(k,RHO(i,k)-0.3,'**','FontSize',15)
        elseif (PVAL(i,k) <= 0.05) && (RHO(i,k) <= 0)
            text(k,RHO(i,k)-0.3,'*','FontSize',15)
        end
    end
    axis([0 3 -1 1])
    set(gca,'Ytick',-1:0.25:1,'Yticklabel',-1:0.25:1);
    title([subject ' run ' num2str(indexrun) ' : comp ' num2str(i)])
    set(gca,'Xtick',1:2,'Xticklabel',{'Freq';'Pow'});
    xlabel('corrtype');
    ylabel('Pearson corrcoef');
end

print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
        '/ICA_CorrV2_' num2str(numcomponent) '_' num2str(freqbandview(1)) '-' num2str(freqbandview(2)) '_' num2str(indexrun) '_' num2str(numcomponent) 'comp.png']);
