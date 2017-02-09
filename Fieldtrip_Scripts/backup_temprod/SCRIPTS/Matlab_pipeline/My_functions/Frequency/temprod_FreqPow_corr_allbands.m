function temprod_FreqPow_corr_allbands(index,subject)

chunksband = {[1 4];[4 7.5];[7.5 14];[15 25];[25 80]};

for iind = 1:length(chunksband);
    freqband = chunksband{iind};
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    DIR = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];
    chantypefull            = {'Mags';'Gradslong';'Gradslat'};
    
    for jind = 1:3
        
        Fullspctrm          = [];
        Fullfreq            = [];
        chantype            = chantypefull{jind};
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
        
        chunksFullspctrm{iind,jind} = Fullspctrm;
        chunksFullfreq{iind,jind}   = Fullfreq;
        
    end 
end

fig                 = figure('position',[1 1 1280*0.5 1024*0.3]);
set(fig,'PaperPosition',[1 1 1280 1024])
set(fig,'PaperPositionMode','auto')
set(fig,'PaperType','A4')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for iind = 1:length(chunksband);
    for jind = 1:3
        
        Fullspctrm = chunksFullspctrm{iind,jind} ;
        Fullfreq   = chunksFullfreq{iind,jind} ;
        
        clear Fpeakpow Fpeak
        
        for i = 1:size(Fullspctrm,1)
            MinSide = min(mean(Fullspctrm(i,:,:)));
            C = cumsum((squeeze(mean(Fullspctrm(i,:,:))) - ones(size(Fullspctrm,3),1)*MinSide));
            j = 1;
            while C(j) <= C(end)/2
                Fpeak(i) = j;
                Fpeakpow(i) = mean(Fullspctrm(i,:,Fpeak(i)));
                j = j+1;
            end
        end
        MaxPSD     = Fpeakpow;
        MaxPSDfreq = Fpeak;
        
        [R{iind,jind},p{iind,jind}] = corr([asc_ord(:,1) Fullfreq(MaxPSDfreq)'],'type','Pearson');
        RHO(iind,jind)  = R{iind,jind}(1,2);
        PVAL(iind,jind) = p{iind,jind}(1,2);
    end
end

subplot(1,2,1)
bar(RHO)
set(gca,'xtick',1:5,'xticklabel',{'delta';'theta';'alpha';'beta';'gamma'})
ylabel('corrcoeff freqpeaks vs duration')
legend('Mags','Grads1','Grads2')
axis([0 6 -0.75 0.75])

for iind = 1:length(chunksband);
    for jind = 1:3
        if (PVAL(iind,jind) <= 0.05) && (RHO(iind,jind) >= 0)
            text(iind + (jind -2.2)*0.3,RHO(iind,jind),'*','FontSize',15)
        elseif (PVAL(iind,jind) <= 0.01) && (RHO(iind,jind) >= 0)
            text(iind + (jind -2.2)*0.3,RHO(iind,jind),'**','FontSize',15)
        elseif (PVAL(iind,jind) <= 0.05) && (RHO(iind,jind) <= 0)
            text(iind + (jind -2.2)*0.3,RHO(iind,jind) - 0.06,'*','FontSize',15)
        elseif (PVAL(iind,jind) <= 0.01) && (RHO(iind,jind) <= 0)
            text(iind + (jind -2.2)*0.3,RHO(iind,jind)-0.06,'**','FontSize',15)
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numpoints = round(2/((Fullfreq(end) - Fullfreq(1))/length(Fullfreq)));

for iind = 1:length(chunksband);
    for jind = 1:3
        
        clear Fullfreq Fullspctrm
        
        Fullspctrm = chunksFullspctrm{iind,jind} ;
        Fullfreq   = chunksFullfreq{iind,jind} ;
        
        clear Fpeak MaxPSDfreq 
        
        for i = 1:size(Fullspctrm,1)
            MinSide = min(mean(Fullspctrm(i,:,:)));
            C = cumsum((squeeze(mean(Fullspctrm(i,:,:))) - ones(size(Fullspctrm,3),1)*MinSide));
            
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
                Fpeakpow(i)          =  mean(mean(squeeze((FullspctrmMags(i,:,Fpeak(i,:))))));
                j                    =  j+1;
            end
        end
        MaxPSD     = Fpeakpow;
        MaxPSDfreq = Fpeak(i,:);
        
        [R{iind,jind},p{iind,jind}] = corr([asc_ord(:,1) MaxPSD'],'type','Pearson');
        RHO(iind,jind)  = R{iind,jind}(1,2);
        PVAL(iind,jind) = p{iind,jind}(1,2);
    end
end

subplot(1,2,2)
bar(RHO)
set(gca,'xtick',1:5,'xticklabel',{'delta';'theta';'alpha';'beta';'gamma'})
ylabel('corrcoeff powpeaks vs duration')
legend('Mags','Grads1','Grads2')
axis([0 6 -0.75 0.75])

for iind = 1:length(chunksband);
    for jind = 1:3
        if (PVAL(iind,jind) <= 0.05) && (RHO(iind,jind) >= 0)
            text(iind + (jind -2.2)*0.3,RHO(iind,jind),'*','FontSize',15)
        elseif (PVAL(iind,jind) <= 0.01) && (RHO(iind,jind) >= 0)
            text(iind + (jind -2.2)*0.3,RHO(iind,jind),'**','FontSize',15)
        elseif (PVAL(iind,jind) <= 0.05) && (RHO(iind,jind) <= 0)
            text(iind + (jind -2.2)*0.3,RHO(iind,jind) - 0.06,'*','FontSize',15)
        elseif (PVAL(iind,jind) <= 0.01) && (RHO(iind,jind) <= 0)
            text(iind + (jind -2.2)*0.3,RHO(iind,jind)-0.06,'**','FontSize',15)
        end
    end
end

print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
    '/Fullcorrallbands_' num2str(freqband(1)) '-' num2str(freqband(2)) '_' num2str(index) '.png']);
