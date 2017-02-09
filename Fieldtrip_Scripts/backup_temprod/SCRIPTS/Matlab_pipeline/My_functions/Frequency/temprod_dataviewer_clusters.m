function temprod_dataviewer_clusters(index,subject,freqband,K,debiasing,alphapeak,interpnoise,chandisplay,savetag)

DIR = ['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];
chantypefull            = {'Mags';'Gradslong';'Gradslat'};
[Find, Bind, Vind, Lind, Rind] = clusteranat;

%% plot results, zscores, averages across channels
fig                 = figure('position',[1 1 1280 1024]);
set(fig,'PaperPosition',[1 1 1280 1024])
set(fig,'PaperPositionMode','auto')
% set(fig,'PaperType','A4')

for clustind = 1:5
    
    if clustind == 1
        indsel = Find; clustname = 'FRONT';
    elseif clustind == 2
        indsel = Bind; clustname = 'BACK';
    elseif clustind == 3
        indsel = Vind; clustname = 'VERTEX';
    elseif clustind == 4
        indsel = Lind; clustname = 'LEFT';
    elseif clustind == 5
        indsel = Rind; clustname = 'RIGHT';
    end
    
    for jind = 1:3
        
        Fullspctrm          = [];
        Fullfreq            = [];
        chantype            = chantypefull{jind};
        Fullspctrm_path     = [DIR 'FT_spectra/FullspctrmV2_' chantype num2str(index) '.mat'];
        load(Fullspctrm_path);
        tmp = unique(Fullfreq); clear Fullfreq;
        Fullfreq            = tmp;
        
        %% select channels cluster-wise
        
        Fullspctrm = Fullspctrm(:,indsel(jind,:),:);
        
        %% remove 1/f component
        if debiasing == 1
            [Fullfreq,Fullspctrm] = RemoveOneOverF(Fullfreq,Fullspctrm,alphapeak);
        end
        
        %% noise removal and channel-by-channel linear interpolation replacemement
        if debiasing == 1
            [Fullfreq,Fullspctrm] = LineNoiseInterp(Fullfreq,Fullspctrm);
        end
        
        %% select frequency band
        fbegin              = find(Fullfreq >= freqband(1));
        fend                = find(Fullfreq <= freqband(2));
        fband               = fbegin(1):fend(end);
        bandFullspctrm      = Fullspctrm(:,:,fband);
        bandFullfreq        = Fullfreq(fband);
        clear Fullspctrm Fullfreq
        Fullspctrm          = bandFullspctrm;
        Fullfreq            = bandFullfreq;
        
        FullfreqSave        = Fullfreq;
        FullspctrmSave      = Fullspctrm;
        
        
        %% smooting by convolution along the trial dimension
        Fullspctrm = ConvSmoothing(Fullspctrm,K);
        
        
        if chandisplay == 1
            %% plot channel-by-channel data
            fig                 = figure('position',[1 1 1280 1024]);
            for k               = 1:102
                full            = [];
                for i           = 1:size(Fullspctrm,1)
                    Pmean       = squeeze((Fullspctrm(i,k,:)));
                    full        = [full Pmean];
                end
                mysubplot(11,10,k)
                imagesc((full)')
            end
            
            %% save plot
            if savetag == 1
                print('-dpng',['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
                    '/Fullspctrm_' chantype '_' num2str(freqband(1)) '-' num2str(freqband(2)) '_' num2str(index) '.png']);
            end
            
            %% plot-channel-by-channel zscores
            fig                 = figure('position',[1 1 1280 1024]);
            for k               = 1:102
                full            = [];
                for i           = 1:size(Fullspctrm,1)
                    Pmean       = squeeze((Fullspctrm(i,k,:)));
                    full        = [full Pmean];
                end
                mysubplot(11,10,k)
                imagesc(zscore((full)',0,2));
            end
            %% save plot
            if savetag == 1
                print('-dpng',['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
                    '/Fullspctrm_zscores_' chantype '_' num2str(freqband(1)) '-' num2str(freqband(2)) '_' num2str(index) '.png']);
            end
        end
        
        %% real duration plotting mode
        
        TMP = [];
        for a = 1:size(Fullspctrm,1)
            TMP = cat(1,TMP,repmat(Fullspctrm(a,:,:),[round(asc_ord(a,1)/100) 1 1]));
        end
        FullspctrmRS = TMP;
        
        asc_ord_rs = [];
        for a = 1:size(Fullspctrm,1)
            asc_ord_rs = cat(1,asc_ord_rs,repmat(asc_ord(a,:),[round(asc_ord(a,1)/100) 1]));
        end
        
        %% rename data for averaging
        eval(['Fullspctrm' chantype '= Fullspctrm;']);
        eval(['FullspctrmRS' chantype '= FullspctrmRS;']);
    end
    
    %% psd data
    zscoretag = 0;
    %% magnetometers
    sub1 = subplot(6,5,clustind);
    if zscoretag == 1
        z = zscore((squeeze(mean(FullspctrmRSMags,2))),0,2);
        imagesc(z);
    else
        imagesc((squeeze(mean(FullspctrmRSMags,2))));
    end
    xlabel('frequency (hz)');
    ylabel('durations (ms)');
    title([clustname ' : mags Power']);
    % colorbar;
    set(sub1,'XTick',5:round(length(Fullfreq)/5):length(Fullfreq),'XTickLabel',round(Fullfreq(1:round(length(Fullfreq)/5):length(Fullfreq))*10)/10);
    set(sub1,'Ytick',1:round(length(asc_ord_rs)/6):length(asc_ord_rs),'Yticklabel',asc_ord_rs(1:round(length(asc_ord_rs)/6):end,1)/0.250);
    
    %% longitudinal gradiometers
    sub2 = subplot(6,5,5 + clustind);
    if zscoretag == 1
        z = zscore((squeeze(mean(FullspctrmRSGradslong,2))),0,2);
        imagesc(z);
    else
        imagesc((squeeze(mean(FullspctrmRSGradslong,2))));
    end
    xlabel('frequency (hz)');
    ylabel('durations (ms)');
    title([clustname ' : gradslong Power']);
    % colorbar;
    set(sub2,'XTick',5:round(length(Fullfreq)/5):length(Fullfreq),'XTickLabel',round(Fullfreq(1:round(length(Fullfreq)/5):length(Fullfreq))*10)/10);
    set(sub2,'Ytick',1:round(length(asc_ord_rs)/6):length(asc_ord_rs),'Yticklabel',asc_ord_rs(1:round(length(asc_ord_rs)/6):end,1)/0.250);
    
    %% latitudinal gradiometers
    sub3 = subplot(6,5,10 + clustind);
    if zscoretag == 1
        z = zscore((squeeze(mean(FullspctrmRSGradslat,2))),0,2);
        imagesc(z);
    else
        imagesc((squeeze(mean(FullspctrmRSGradslat,2))));
    end
    xlabel('frequency (hz)');
    ylabel('durations (ms)');
    title([clustname ' : gradslat Power']);
    % colorbar;
    set(sub3,'XTick',5:round(length(Fullfreq)/5):length(Fullfreq),'XTickLabel',round(Fullfreq(1:round(length(Fullfreq)/5):length(Fullfreq))*10)/10);
    set(sub3,'Ytick',1:round(length(asc_ord_rs)/6):length(asc_ord_rs),'Yticklabel',asc_ord_rs(1:round(length(asc_ord_rs)/6):end,1)/0.250);
    
    % sub4 = subplot(4,3,4);
    % plot(asc_ord(:,1)/250,((length(asc_ord)):-1:1));
    % axis([min(asc_ord(:,1))/250 max(asc_ord(:,1))/250 1 length(asc_ord)])
    % set(gca,'Ytick',1:10:length(asc_ord),'Yticklabel',length(asc_ord):-10:1)
    % ylabel('trials'); xlabel('duration (s)')
    %% Z-scores data
    zscoretag = 1;
    %% magnetometers
    sub1 = subplot(6,5,15 + clustind);
    if zscoretag == 1
        z = zscore((squeeze(mean(FullspctrmRSMags,2))),0,2);
        imagesc(z);
    else
        imagesc((squeeze(mean(FullspctrmRSMags,2))));
    end
    xlabel('frequency (hz)');
    ylabel('durations (ms)');
    title([clustname ' : mags Power zscore']);
    % colorbar;
    set(sub1,'XTick',5:round(length(Fullfreq)/5):length(Fullfreq),'XTickLabel',round(Fullfreq(1:round(length(Fullfreq)/5):length(Fullfreq))*10)/10);
    set(sub1,'Ytick',1:round(length(asc_ord_rs)/6):length(asc_ord_rs),'Yticklabel',asc_ord_rs(1:round(length(asc_ord_rs)/6):end,1)/0.250);
    
    %% longitudinal gradiometers
    sub2 = subplot(6,5,20 + clustind);
    if zscoretag == 1
        z = zscore((squeeze(mean(FullspctrmRSGradslong,2))),0,2);
        imagesc(z);
    else
        imagesc((squeeze(mean(FullspctrmRSGradslong,2))));
    end
    xlabel('frequency (hz)');
    ylabel('durations (ms)');
    title([clustname ' : gradslong Power zscore']);
    % colorbar;
    set(sub2,'XTick',5:round(length(Fullfreq)/5):length(Fullfreq),'XTickLabel',round(Fullfreq(1:round(length(Fullfreq)/5):length(Fullfreq))*10)/10);
    set(sub2,'Ytick',1:round(length(asc_ord_rs)/6):length(asc_ord_rs),'Yticklabel',asc_ord_rs(1:round(length(asc_ord_rs)/6):end,1)/0.250);
    
    %% latitudinal gradiometers
    sub3 = subplot(6,5,25 + clustind);
    if zscoretag == 1
        z = zscore((squeeze(mean(FullspctrmRSGradslat,2))),0,2);
        imagesc(z);
    else
        imagesc((squeeze(mean(FullspctrmRSGradslat,2))));
    end
    xlabel('frequency (hz)');
    ylabel('durations (ms)');
    title([clustname ' : gradslat Power zscore']);
    % colorbar;
    set(sub3,'XTick',5:round(length(Fullfreq)/5):length(Fullfreq),'XTickLabel',round(Fullfreq(1:round(length(Fullfreq)/5):length(Fullfreq))*10)/10);
    set(sub3,'Ytick',1:round(length(asc_ord_rs)/6):length(asc_ord_rs),'Yticklabel',asc_ord_rs(1:round(length(asc_ord_rs)/6):end,1)/0.250);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

if savetag == 1
    print('-dpng',['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
        '/Fullspctrm_clusters' num2str(freqband(1)) '-' num2str(freqband(2)) '_' num2str(index) '.png']);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% plot results, zscores, averages across channels
fig                 = figure('position',[1281 1 1280 1024]);
set(fig,'PaperPosition',[1281 1 1280 1024])
set(fig,'PaperPositionMode','auto')
% set(fig,'PaperType','A4')

for clustind = 1:5
    
    if clustind == 1
        indsel = Find; clustname = 'FRONT';
    elseif clustind == 2
        indsel = Bind; clustname = 'BACK';
    elseif clustind == 3
        indsel = Vind; clustname = 'VERTEX';
    elseif clustind == 4
        indsel = Lind; clustname = 'LEFT';
    elseif clustind == 5
        indsel = Rind; clustname = 'RIGHT';
    end
    
    for jind = 1:3
        
        Fullspctrm          = [];
        Fullfreq            = [];
        chantype            = chantypefull{jind};
        Fullspctrm_path     = [DIR 'FT_spectra/FullspctrmV2_' chantype num2str(index) '.mat'];
        load(Fullspctrm_path);
        tmp = unique(Fullfreq); clear Fullfreq;
        Fullfreq            = tmp;
        
        %% select channels cluster-wise
        
        Fullspctrm = Fullspctrm(:,indsel(jind,:),:);
        
        %% estimate alpha for power law bias 1/f^alpha, by Maximum likelyhood estimation
        if debiasing == 1
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
        end
        
        % noise removal and channel-by-channel linear interpolation replacemement
        
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
        
        % specific noise temporary removal + interpolation
        clear  FullfreqSave FullspctrmSave
        FullfreqSave        = Fullfreq;
        FullspctrmSave      = Fullspctrm;
        
        if interpnoise == 1
            Nfbegin                = find(Fullfreq >= 90);
            Nfend                  = find(Fullfreq <= 94);
            Nfband                 = Nfbegin(1):Nfend(end);
            for i = 1:size(Fullspctrm,1)
                for j = 1:size(Fullspctrm,2)
                    L = linspace(Fullspctrm(i,j,Nfbegin(1)),... % beginning of the range
                        Fullspctrm(i,j,Nfend(end)),... % end of the range
                        Nfend(end) - Nfbegin(1) + 1); % number of frequency bins to replace
                    Fullspctrm(i,j,Nfband) = L;
                end
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
        
        FullfreqSave        = Fullfreq;
        FullspctrmSave      = Fullspctrm;
        
        if chandisplay == 1
            %% plot channel-by-channel data
            fig                 = figure('position',[1 1 1280 1024]);
            for k               = 1:102
                full            = [];
                for i           = 1:size(Fullspctrm,1)
                    Pmean       = squeeze((Fullspctrm(i,k,:)));
                    full        = [full Pmean];
                end
                mysubplot(11,10,k)
                imagesc((full)')
                endif savetag == 1
                print('-dpng',['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
                    '/Fullspctrm_clusters_FPcorr' num2str(freqband(1)) '-' num2str(freqband(2)) '_' num2str(index) '.png']);
            end
            
            %% save plot
            if savetag == 1
                print('-dpng',['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
                    '/Fullspctrm_' chantype '_' num2str(freqband(1)) '-' num2str(freqband(2)) '_' num2str(index) '.png']);
            end
            
            %% plot-channel-by-channel zscores
            fig                 = figure('position',[1 1 1280 1024]);
            for k               = 1:102
                full            = [];
                for i           = 1:size(Fullspctrm,1)
                    Pmean       = squeeze((Fullspctrm(i,k,:)));
                    full        = [full Pmean];
                end
                mysubplot(11,10,k)
                imagesc(zscore((full)',0,2));
            end
            %% save plot
            if savetag == 1
                print('-dpng',['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
                    '/Fullspctrm_zscores_' chantype '_' num2str(freqband(1)) '-' num2str(freqband(2)) '_' num2str(index) '.png']);
            end
        end
        
        %% real duration plotting mode
        
        TMP = [];
        for a = 1:size(Fullspctrm,1)
            TMP = cat(1,TMP,repmat(Fullspctrm(a,:,:),[round(asc_ord(a,1)/100) 1 1]));
        end
        FullspctrmRS = TMP;
        
        asc_ord_rs = [];
        for a = 1:size(Fullspctrm,1)
            asc_ord_rs = cat(1,asc_ord_rs,repmat(asc_ord(a,:),[round(asc_ord(a,1)/100) 1]));
        end
        
        %% rename data for averaging
        eval(['Fullspctrm' chantype '= Fullspctrm;']);
        eval(['FullspctrmRS' chantype '= FullspctrmRS;']);
    end
    
    %% plot correlations
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    clear MaxPSDfreq MaxPSD Fpeak Fpeakpow
    
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
    
    [R,p] = corr([asc_ord(:,1) FullfreqSave(MaxPSDfreq)'],'type','Pearson');
    s = subplot(6,5,clustind);
    plot(FullfreqSave(MaxPSDfreq),(asc_ord(:,1))/0.250,'marker','*','linestyle','none')
    axis([min(FullfreqSave) max(FullfreqSave) (min(asc_ord(:,1))/0.250) (max(asc_ord(:,1))/0.250)]);
    
    set(gca,'YDir','reverse')
    ttl = [round(R(2,1)*1000)/1000 round(p(2,1)*1000)/1000];
    ttl2 = sprintf('%6.2f',ttl(1));
    ttl3 = sprintf('%6.3f',ttl(2));
    title([clustname ' : coeff :' ttl2 ', pval = ' ttl3])
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
    
    [R,p] = corr([asc_ord(:,1) FullfreqSave(MaxPSDfreq)'],'type','Pearson');
    s = subplot(6,5,clustind+5);
    plot(FullfreqSave(MaxPSDfreq),(asc_ord(:,1))/0.250,'marker','*','linestyle','none')
    axis([min(FullfreqSave) max(FullfreqSave) (min(asc_ord(:,1))/0.250) (max(asc_ord(:,1))/0.250)]);
    
    set(gca,'YDir','reverse')
    ttl = [round(R(2,1)*1000)/1000 round(p(2,1)*1000)/1000];
    ttl2 = sprintf('%6.2f',ttl(1));
    ttl3 = sprintf('%6.3f',ttl(2));
    title([clustname ' : coeff :' ttl2 ', pval = ' ttl3])
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
    
    [R,p] = corr([asc_ord(:,1) FullfreqSave(MaxPSDfreq)'],'type','Pearson');
    s = subplot(6,5,clustind+10);
    plot(FullfreqSave(MaxPSDfreq),(asc_ord(:,1))/0.250,'marker','*','linestyle','none')
    axis([min(FullfreqSave) max(FullfreqSave) (min(asc_ord(:,1))/0.250) (max(asc_ord(:,1))/0.250)]);
    
    set(gca,'YDir','reverse')
    ttl = [round(R(2,1)*1000)/1000 round(p(2,1)*1000)/1000];
    ttl2 = sprintf('%6.2f',ttl(1));
    ttl3 = sprintf('%6.3f',ttl(2));
    title([clustname ' : coeff :' ttl2 ', pval = ' ttl3])
    ylabel('duration (ms)');
    xlabel('frequency (hz)');
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    clear Fpeak MaxPSDfreq
    numpoints = round(1/((Fullfreq(end) - Fullfreq(1))/length(Fullfreq)));
    
    for i = 1:size(FullspctrmMags,1)
        MinSide = min(mean(FullspctrmMags(i,:,:)));
        C = cumsum((squeeze(mean(FullspctrmMags(i,:,:))) - ones(size(FullspctrmMags,3),1)*MinSide));
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
    
    [R,p] = corr([asc_ord(:,1) MaxPSD'],'type','Pearson');
    s = subplot(6,5,clustind+15);
    plot(MaxPSD,(asc_ord(:,1))/0.250,'marker','*','linestyle','none')
    axis([min(MaxPSD) max(MaxPSD) (min(asc_ord(:,1))/0.250) (max(asc_ord(:,1))/0.250)]);
    
    set(gca,'YDir','reverse')
    ttl = [round(R(2,1)*1000)/1000 round(p(2,1)*1000)/1000];
    ttl2 = sprintf('%6.2f',ttl(1));
    ttl3 = sprintf('%6.3f',ttl(2));
    title([clustname ': coeff :' ttl2 ', pval = ' ttl3])
    ylabel('duration (ms)');
    xlabel('power');
    
    for i = 1:size(FullspctrmGradslong,1)
        MinSide = min(mean(FullspctrmGradslong(i,:,:)));
        C = cumsum((squeeze(mean(FullspctrmGradslong(i,:,:))) - ones(size(FullspctrmGradslong,3),1)*MinSide));
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
    
    [R,p] = corr([asc_ord(:,1) MaxPSD'],'type','Pearson');
    s = subplot(6,5,clustind+20);
    plot(MaxPSD,(asc_ord(:,1))/0.250,'marker','*','linestyle','none')
    axis([min(MaxPSD) max(MaxPSD) (min(asc_ord(:,1))/0.250) (max(asc_ord(:,1))/0.250)]);
    
    set(gca,'YDir','reverse')
    ttl = [round(R(2,1)*1000)/1000 round(p(2,1)*1000)/1000];
    ttl2 = sprintf('%6.2f',ttl(1));
    ttl3 = sprintf('%6.3f',ttl(2));
    title([clustname ': coeff :' ttl2 ', pval = ' ttl3])
    ylabel('duration (ms)');
    xlabel('power');
    
    for i = 1:size(FullspctrmGradslat,1)
        MinSide = min(mean(FullspctrmGradslat(i,:,:)));
        C = cumsum((squeeze(mean(FullspctrmGradslat(i,:,:))) - ones(size(FullspctrmGradslat,3),1)*MinSide));
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
    
    [R,p] = corr([asc_ord(:,1) MaxPSD'],'type','Pearson');
    s = subplot(6,5,clustind+25);
    plot(MaxPSD,(asc_ord(:,1))/0.250,'marker','*','linestyle','none')
    axis([min(MaxPSD) max(MaxPSD) (min(asc_ord(:,1))/0.250) (max(asc_ord(:,1))/0.250)]);
    
    set(gca,'YDir','reverse')
    ttl = [round(R(2,1)*1000)/1000 round(p(2,1)*1000)/1000];
    ttl2 = sprintf('%6.2f',ttl(1));
    ttl3 = sprintf('%6.3f',ttl(2));
    title([clustname ': coeff :' ttl2 ', pval = ' ttl3])
    ylabel('duration (ms)');
    xlabel('power');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[label2,label3,label1]     = grads_for_layouts;
chantypefull               = {'Mags';'Gradslong';'Gradslat'};
figure
for clustind = 1:5
    
    subplot(2,3,clustind)
    
    if clustind == 1
        indsel = Find; clustname = 'FRONT';
    elseif clustind == 2
        indsel = Bind; clustname = 'BACK';
    elseif clustind == 3
        indsel = Vind; clustname = 'VERTEX';
    elseif clustind == 4
        indsel = Lind; clustname = 'LEFT';
    elseif clustind == 5
        indsel = Rind; clustname = 'RIGHT';
    end
    
    freq.powspctrm         = ones(2,102,length(Fullfreq));
    freq.freq              = Fullfreq;
    trialnumber            = 2;
    freq.dimord            = 'rpt_chan_freq';
    freq.cumtapcnt         = ones(2,length(freq.freq));
    freq.label             = label1;
    cfg.channel            = 'all';
    cfg.xparam             = 'freq';
    cfg.zparam             = 'powspctrm';
    cfg.xlim               = [1 1];
    cfg.zlim               = [-0.5 0.5];
    cfg.baseline           = 'no';
    cfg.trials             = 'all';
    cfg.colormap           = 'jet';
    cfg.marker             = 'on';
    cfg.markersymbol       = 'o';
    cfg.markercolor        = [0 0 0];
    cfg.markersize         = 2;
    cfg.markerfontsize     = 8;
    cfg.colorbar           = 'no';
    cfg.interplimits       = 'head';
    cfg.interpolation      = 'v4';
    cfg.style              = 'blank';
    cfg.gridscale          = 67;
    cfg.shading            = 'flat';
    cfg.interactive        = 'no';
    cfg.highlight          = indsel(1,:);
    cfg.layout             = '/neurospin/meg/meg_tmp/ResonanceMeg_Baptiste_2009/SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
    lay                    = ft_prepare_layout(cfg,freq);
    if strcmp(chantype,'GradsLong')     == 1
        for i          = 1:102
            lay.label{i,1} = GradsLong{1,i};
        end
    elseif strcmp(chantype,'GradsLat')     == 1
        for i          = 1:102
            lay.label{i,1} = GradsLat{1,i};
        end
    elseif strcmp(chantype,'Mags')     == 1
        for i          = 1:102
            lay.label{i,1} = ['MEG' lay.label{i,1}];
        end
    end
    cfg.layout             = lay;
    topoplot(cfg,ones(102,1))
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


if savetag == 1
    print('-dpng',['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
        '/Fullspctrm_clusters_FPcorr' num2str(freqband(1)) '-' num2str(freqband(2)) '_' num2str(index) '.png']);
end

