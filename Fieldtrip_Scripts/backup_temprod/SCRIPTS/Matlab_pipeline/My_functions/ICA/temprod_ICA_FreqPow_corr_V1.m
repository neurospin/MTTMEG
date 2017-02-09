function temprod_ICA_FreqPow_corr_V1(indexrun,subject,numcomponent,fsample,freqbandview)

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
        MinSide = min(squeeze(Fullspctrm(l,i,:)));
        C = cumsum((squeeze(Fullspctrm(l,i,:)) - ones(size(Fullspctrm,3),1)*MinSide));
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
            Fpeak(l,:)           =  infbound:supbound;
            Fpeakpow(l)          =  mean(squeeze((Fullspctrm(l,i,Fpeak(l,:)))));
            j                    =  j+1;
            MaxPSDfreq(l)        =  j;
        end
    end
    MaxPSD     = Fpeakpow;
    DUR        = asc_ord/(fsample);
    POW        = Fpeakpow';
    [x,y]      = corr([POW DUR],'type','Pearson');
    RHO(i,2)   = x(2,1);
    PVAL(i,2)  = y(2,1);
    FREQ                = (Fullfreq(MaxPSDfreq)');
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
        '/ICA_CorrV1_' num2str(numcomponent) '_' num2str(freqbandview(1)) '-' num2str(freqbandview(2)) '_' num2str(indexrun) '_' num2str(numcomponent) 'comp.png']);
