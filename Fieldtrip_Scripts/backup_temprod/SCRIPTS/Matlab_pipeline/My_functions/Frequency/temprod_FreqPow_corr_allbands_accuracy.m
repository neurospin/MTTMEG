function temprod_FreqPow_corr_allbands_accuracy(arrayindex,target,subject,tag)

% set root
root = SetPath(tag);

chunksband = {[1 4];[4 7];[7 14];[15 30];[30 80]};

for aa = 1:length(arrayindex)
    index = arrayindex(aa);
    
    for iind = 1:length(chunksband);
        freqband = chunksband{iind};
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        DIR = [root '/DATA/NEW/processed_' subject '/'];
        chantypefull            = {'Mags';'Gradslong';'Gradslat'};
        
        for jind = 1:3
            
            Fullspctrm          = [];
            Fullfreq            = [];
            asc_ord             = [];
            MaxPSD              = [];
            MaxPSDfreq          = [];
            R                   = []; 
            chantype            = chantypefull{jind};
            Fullspctrm_path     = [DIR 'FT_spectra/FullspctrmV2_' chantype num2str(index) '.mat'];
            load(Fullspctrm_path);
            tmp = unique(Fullfreq); clear Fullfreq;
            Fullfreq            = tmp;
            
            %% sorting by estimation accuracy
            asc_ord             = [asc_ord (1:length(asc_ord))'];
            asc_ord             = asc_ord + [ -ones(length(asc_ord),1)*target(aa) zeros(length(asc_ord),1) zeros(length(asc_ord),1)];
            asc_ord(:,1)        = abs(asc_ord(:,1));
            asc_ord             = sortrows(asc_ord);
            
            Fullspctrm          = Fullspctrm(asc_ord(:,3),:,:);           
            
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
            
            clear Fullfreq Fullspctrm
            
            Fullspctrm = chunksFullspctrm{iind,jind} ;
            Fullfreq   = chunksFullfreq{iind,jind} ;
            
            clear Fpeakpow Fpeak
            
            for i = 1:size(Fullspctrm,1)
                [MaxPSD(i), MaxPSDfreq(i)] = max(mean(squeeze(Fullspctrm(i,:,:))));
            end
            
            [R{iind,jind},p{iind,jind}] = corr([asc_ord(:,1) Fullfreq(MaxPSDfreq)'],'type','Pearson');
            RHO(iind,jind)  = R{iind,jind}(1,2);
            PVAL(iind,jind) = p{iind,jind}(1,2);
        end
    end
    
    subplot(1,2,1)
    bar(RHO)
    set(gca,'xtick',1:5,'xticklabel',{'delta';'theta';'alpha';'beta';'gamma'})
    ylabel('corrcoeff freqpeaks vs estimation error')
    legend('Mags','Grads1','Grads2','location','NorthWest')
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
            
            clear Fpeak MaxPSDfreq Fpeakpow
            
            for i = 1:size(Fullspctrm,1)
                [MaxPSD(i), MaxPSDfreq(i)] = max(mean(squeeze(Fullspctrm(i,:,:))));
                
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
                Fpeakpow(i)          =  mean(mean(squeeze((Fullspctrm(i,:,dataf)))));
            end
            MaxPSD     = Fpeakpow;
            
            [R{iind,jind},p{iind,jind}] = corr([asc_ord(:,1) MaxPSD'],'type','Pearson');
            RHO(iind,jind)  = R{iind,jind}(1,2);
            PVAL(iind,jind) = p{iind,jind}(1,2);
        end
    end
    
    subplot(1,2,2)
    bar(RHO)
    set(gca,'xtick',1:5,'xticklabel',{'delta';'theta';'alpha';'beta';'gamma'})
    ylabel('corrcoeff powpeaks vs estimation error')
    legend('Mags','Grads1','Grads2','location','NorthWest')
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
    
end

print('-dpng',[root '/DATA/NEW/Plots_' subject...
    '/Fullcorrallbands_accuracy_' num2str(freqband(1)) '-' num2str(freqband(2)) '_' num2str(index) '.png']);
