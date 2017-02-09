function temprod_dataviewer_AP(index,subject,freqband,K,debiasing,interpnoise,chandisplay,APtag,LRtag,savetag)

DIR = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];
chantypefull            = {'Mags';'Gradslong';'Gradslat'};
[MPL,MPR,MAL,MAR,G1PL,G1PR,G1AL,G1AR,G2PL,G2PR,G2AL,G2AR] = APLRchannels;
[G1,G2,M]               = grads_for_layouts;

for jind = 1:3
    
    Fullspctrm          = [];
    Fullfreq            = [];
    chantype            = chantypefull{jind};
    Fullspctrm_path     = [DIR 'FT_spectra/FullspctrmV2_' chantype num2str(index) '.mat'];
    load(Fullspctrm_path);
    tmp = unique(Fullfreq); clear Fullfreq;
    Fullfreq            = tmp;
    
    %% select only channels of interest on A-P and L-R axes
    % mags
    if jind == 3
        
        if (strcmp(APtag,'A') == 1) && (strcmp(LRtag,'L'))
            for i = 1:length(MAL)
                ind(i) = find(ismember(M,MAL{i}) == 1);
            end
        elseif (strcmp(APtag,'A') == 1) && (strcmp(LRtag,'R'))
            for i = 1:length(MAR)
                ind(i) = find(ismember(M,MAR{i}) == 1);
            end
        elseif (strcmp(APtag,'P') == 1) && (strcmp(LRtag,'L'))
            for i = 1:length(MPL)
                ind(i) = find(ismember(M,MPL{i}) == 1);
            end
        elseif (strcmp(APtag,'P') == 1) && (strcmp(LRtag,'R'))
            for i = 1:length(MPR)
                ind(i) = find(ismember(M,MPR{i}) == 1);
            end
        elseif (strcmp(APtag,'A&P') == 1) && (strcmp(LRtag,'L'))
            for i = 1:length(MPL)
                MPLind(i) = find(ismember(M,MPL{i}) == 1);
            end
            for i = 1:length(MAL)
                MALind(i) = find(ismember(M,MAL{i}) == 1);
            end
            ind = [MPLind MALind];
        elseif (strcmp(APtag,'A&P') == 1) && (strcmp(LRtag,'R'))
            for i = 1:length(MPR)
                MPRind(i) = find(ismember(M,MPR{i}) == 1);
            end
            for i = 1:length(MAR)
                MARind(i) = find(ismember(M,MAR{i}) == 1);
            end
            ind = [MPRind MARind];
        elseif (strcmp(APtag,'P') == 1) && (strcmp(LRtag,'L&R'))
            for i = 1:length(MPR)
                MPRind(i) = find(ismember(M,MPR{i}) == 1);
            end
            for i = 1:length(MPL)
                MPLind(i) = find(ismember(M,MPL{i}) == 1);
            end
            ind = [MPRind MPLind];
        elseif (strcmp(APtag,'A') == 1) && (strcmp(LRtag,'L&R'))
            for i = 1:length(MAR)
                MARind(i) = find(ismember(M,MAR{i}) == 1);
            end
            for i = 1:length(MAL)
                MALind(i) = find(ismember(M,MAL{i}) == 1);
            end
            ind = [MARind MALind];
        end
        
        Fullspctrm =  Fullspctrm(:,ind,:);
        
    elseif jind == 2
               
        if (strcmp(APtag,'A') == 1) && (strcmp(LRtag,'L'))
            for i = 1:length(G1AL)
                ind(i) = find(ismember(G1,G1AL{i}) == 1);
            end
        elseif (strcmp(APtag,'A') == 1) && (strcmp(LRtag,'R'))
            for i = 1:length(G1AR)
                ind(i) = find(ismember(G1,G1AR{i}) == 1);
            end
        elseif (strcmp(APtag,'P') == 1) && (strcmp(LRtag,'L'))
            for i = 1:length(G1PL)
                ind(i) = find(ismember(G1,G1PL{i}) == 1);
            end
        elseif (strcmp(APtag,'P') == 1) && (strcmp(LRtag,'R'))
            for i = 1:length(G1PR)
                ind(i) = find(ismember(G1,G1PR{i}) == 1);
            end
        elseif (strcmp(APtag,'A&P') == 1) && (strcmp(LRtag,'L'))
            for i = 1:length(G1PL)
                G1PLind(i) = find(ismember(G1,G1PL{i}) == 1);
            end
            for i = 1:length(G1AL)
                G1ALind(i) = find(ismember(G1,G1AL{i}) == 1);
            end
            ind = [G1PLind G1ALind];
        elseif (strcmp(APtag,'A&P') == 1) && (strcmp(LRtag,'R'))
            for i = 1:length(G1PR)
                G1PRind(i) = find(ismember(G1,G1PR{i}) == 1);
            end
            for i = 1:length(G1AR)
                G1ARind(i) = find(ismember(G1,G1AR{i}) == 1);
            end
            ind = [G1PRind G1ARind];
        elseif (strcmp(APtag,'P') == 1) && (strcmp(LRtag,'L&R'))
            for i = 1:length(G1PR)
                G1PRind(i) = find(ismember(G1,G1PR{i}) == 1);
            end
            for i = 1:length(G1PL)
                G1PLind(i) = find(ismember(G1,G1PL{i}) == 1);
            end
            ind = [G1PRind G1PLind];
        elseif (strcmp(APtag,'A') == 1) && (strcmp(LRtag,'L&R'))
            for i = 1:length(G1AR)
                G1ARind(i) = find(ismember(G1,G1AR{i}) == 1);
            end
            for i = 1:length(G1AL)
                G1ALind(i) = find(ismember(G1,G1AL{i}) == 1);
            end
            ind = [G1ARind G1ALind];
        end
        
        Fullspctrm =  Fullspctrm(:,ind,:);
        
    elseif jind == 3
        
        if (strcmp(APtag,'A') == 1) && (strcmp(LRtag,'L'))
            for i = 1:length(G2AL)
                ind(i) = find(ismember(G2,G2AL{i}) == 1);
            end
        elseif (strcmp(APtag,'A') == 1) && (strcmp(LRtag,'R'))
            for i = 1:length(G2AR)
                ind(i) = find(ismember(G2,G2AR{i}) == 1);
            end
        elseif (strcmp(APtag,'P') == 1) && (strcmp(LRtag,'L'))
            for i = 1:length(G2PL)
                ind(i) = find(ismember(G2,G2PL{i}) == 1);
            end
        elseif (strcmp(APtag,'P') == 1) && (strcmp(LRtag,'R'))
            for i = 1:length(G2PR)
                ind(i) = find(ismember(G2,G2PR{i}) == 1);
            end
        elseif (strcmp(APtag,'A&P') == 1) && (strcmp(LRtag,'L'))
            for i = 1:length(G2PL)
                G2PLind(i) = find(ismember(G2,G2PL{i}) == 1);
            end
            for i = 1:length(G2AL)
                G2ALind(i) = find(ismember(G2,G2AL{i}) == 1);
            end
            ind = [G2PLind G2ALind];
        elseif (strcmp(APtag,'A&P') == 1) && (strcmp(LRtag,'R'))
            for i = 1:length(G2PR)
                G2PRind(i) = find(ismember(G2,G2PR{i}) == 1);
            end
            for i = 1:length(G2AR)
                G2ARind(i) = find(ismember(G2,G2AR{i}) == 1);
            end
            ind = [G2PRind G2ARind];
        elseif (strcmp(APtag,'P') == 1) && (strcmp(LRtag,'L&R'))
            for i = 1:length(G2PR)
                G2PRind(i) = find(ismember(G2,G2PR{i}) == 1);
            end
            for i = 1:length(G2PL)
                G2PLind(i) = find(ismember(G2,G2PL{i}) == 1);
            end
            ind = [G2PRind G2PLind];
        elseif (strcmp(APtag,'A') == 1) && (strcmp(LRtag,'L&R'))
            for i = 1:length(G2AR)
                G2ARind(i) = find(ismember(G2,G2AR{i}) == 1);
            end
            for i = 1:length(G2AL)
                G2ALind(i) = find(ismember(G2,G2AL{i}) == 1);
            end
            ind = [G2ARind G2ALind];
        end
        
        Fullspctrm =  Fullspctrm(:,ind,:);
        
    end
    
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
    
    
    %% smooting by convolution
    h =[];
    for x               = 1:size(Fullspctrm,2)
        g = [];
        for y           = 1:size(Fullspctrm,3)
            v           = squeeze(Fullspctrm(:,x,y))';
            f           = conv(v,K,'same');
            g(:,y) = f;
            clear f
        end
        h = cat(3,h,g);
    end
    h = permute(h,[1 3 2]);
    Fullspctrm = h;
    
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
            print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
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
            print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
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

%% plot results, zscores, averages across channels
fig                 = figure('position',[1 1 1280 1024*0.6]);
set(fig,'PaperPosition',[1 1 1280 1024])
set(fig,'PaperPositionMode','auto')
% set(fig,'PaperType','A4')
%% psd data
zscoretag = 0;
%% magnetometers
sub1 = subplot(3,5,1);
if zscoretag == 1
    z = zscore((squeeze(mean(FullspctrmRSMags,2))),0,2);
    imagesc(z);
else
    imagesc((squeeze(mean(FullspctrmRSMags,2))));
end
xlabel('frequency (hz)');
ylabel('durations (ms)');
title('mags Power');
% colorbar;
set(sub1,'XTick',5:round(length(Fullfreq)/5):length(Fullfreq),'XTickLabel',round(Fullfreq(1:round(length(Fullfreq)/5):length(Fullfreq))*10)/10);
set(sub1,'Ytick',1:round(length(asc_ord_rs)/12):length(asc_ord_rs),'Yticklabel',asc_ord_rs(1:round(length(asc_ord_rs)/12):end,1)/0.250);

%% longitudinal gradiometers
sub2 = subplot(3,5,6);
if zscoretag == 1
    z = zscore((squeeze(mean(FullspctrmRSGradslong,2))),0,2);
    imagesc(z);
else
    imagesc((squeeze(mean(FullspctrmRSGradslong,2))));
end
xlabel('frequency (hz)');
ylabel('durations (ms)');
title('gradslong Power');
% colorbar;
set(sub2,'XTick',5:round(length(Fullfreq)/5):length(Fullfreq),'XTickLabel',round(Fullfreq(1:round(length(Fullfreq)/5):length(Fullfreq))*10)/10);
set(sub2,'Ytick',1:round(length(asc_ord_rs)/12):length(asc_ord_rs),'Yticklabel',asc_ord_rs(1:round(length(asc_ord_rs)/12):end,1)/0.250);

%% latitudinal gradiometers
sub3 = subplot(3,5,11);
if zscoretag == 1
    z = zscore((squeeze(mean(FullspctrmRSGradslat,2))),0,2);
    imagesc(z);
else
    imagesc((squeeze(mean(FullspctrmRSGradslat,2))));
end
xlabel('frequency (hz)');
ylabel('durations (ms)');
title('gradslat Power');
% colorbar;
set(sub3,'XTick',5:round(length(Fullfreq)/5):length(Fullfreq),'XTickLabel',round(Fullfreq(1:round(length(Fullfreq)/5):length(Fullfreq))*10)/10);
set(sub3,'Ytick',1:round(length(asc_ord_rs)/12):length(asc_ord_rs),'Yticklabel',asc_ord_rs(1:round(length(asc_ord_rs)/12):end,1)/0.250);

% sub4 = subplot(4,3,4);
% plot(asc_ord(:,1)/250,((length(asc_ord)):-1:1));
% axis([min(asc_ord(:,1))/250 max(asc_ord(:,1))/250 1 length(asc_ord)])
% set(gca,'Ytick',1:10:length(asc_ord),'Yticklabel',length(asc_ord):-10:1)
% ylabel('trials'); xlabel('duration (s)')
%% Z-scores data
zscoretag = 1;
%% magnetometers
sub1 = subplot(3,5,2);
if zscoretag == 1
    z = zscore((squeeze(mean(FullspctrmRSMags,2))),0,2);
    imagesc(z);
else
    imagesc((squeeze(mean(FullspctrmRSMags,2))));
end
xlabel('frequency (hz)');
ylabel('durations (ms)');
title('mags Power zscore');
% colorbar;
set(sub1,'XTick',5:round(length(Fullfreq)/5):length(Fullfreq),'XTickLabel',round(Fullfreq(1:round(length(Fullfreq)/5):length(Fullfreq))*10)/10);
set(sub1,'Ytick',1:round(length(asc_ord_rs)/12):length(asc_ord_rs),'Yticklabel',asc_ord_rs(1:round(length(asc_ord_rs)/12):end,1)/0.250);

%% longitudinal gradiometers
sub2 = subplot(3,5,7);
if zscoretag == 1
    z = zscore((squeeze(mean(FullspctrmRSGradslong,2))),0,2);
    imagesc(z);
else
    imagesc((squeeze(mean(FullspctrmRSGradslong,2))));
end
xlabel('frequency (hz)');
ylabel('durations (ms)');
title('gradslong Power zscore');
% colorbar;
set(sub2,'XTick',5:round(length(Fullfreq)/5):length(Fullfreq),'XTickLabel',round(Fullfreq(1:round(length(Fullfreq)/5):length(Fullfreq))*10)/10);
set(sub2,'Ytick',1:round(length(asc_ord_rs)/12):length(asc_ord_rs),'Yticklabel',asc_ord_rs(1:round(length(asc_ord_rs)/12):end,1)/0.250);

%% latitudinal gradiometers
sub3 = subplot(3,5,12);
if zscoretag == 1
    z = zscore((squeeze(mean(FullspctrmRSGradslat,2))),0,2);
    imagesc(z);
else
    imagesc((squeeze(mean(FullspctrmRSGradslat,2))));
end
xlabel('frequency (hz)');
ylabel('durations (ms)');
title('gradslat Power zscore');
% colorbar;
set(sub3,'XTick',5:round(length(Fullfreq)/5):length(Fullfreq),'XTickLabel',round(Fullfreq(1:round(length(Fullfreq)/5):length(Fullfreq))*10)/10);
set(sub3,'Ytick',1:round(length(asc_ord_rs)/12):length(asc_ord_rs),'Yticklabel',asc_ord_rs(1:round(length(asc_ord_rs)/12):end,1)/0.250);

% sub4 = subplot(4,3,8)
% plot(asc_ord(:,1)/250,((length(asc_ord)):-1:1));
% axis([min(asc_ord(:,1))/250 max(asc_ord(:,1))/250 1 length(asc_ord)])
% set(gca,'Ytick',1:10:length(asc_ord),'Yticklabel',length(asc_ord):-10:1)
% ylabel('trials'); xlabel('duration (s)')

%% plot correlations

% get frequency of the power peak
%%%%%%%%%%%%%%%%%%%%%%%%%%% max method %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for i = 1:size(Fullspctrm,1)
%     [MaxPSD(i), MaxPSDfreq(i)] = max(mean(squeeze(FullspctrmMags(i,:,:))));
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% gravity center-like method %%%%%%%%%%%%%%%%%%%%%%%%%%
% for i = 1:size(Fullspctrm,1)
%     MinSide = min([mean(Fullspctrm(i,:,:))]);
%     C = cumsum((squeeze(mean(Fullspctrm(i,:,:))) - ones(size(Fullspctrm,3),1)*MinSide));
% %     test(i,:) = (squeeze(mean(Fullspctrm(i,:,:))))';
% %     mysubplot(7,10,i);
% %     plot(test(i,:))
%     j = 1;
%     while C(j) <= C(end)/2
%         Fpeak(i) = j;
%         Fpeakpow(i) = mean(Fullspctrm(i,:,Fpeak(i)));
%         j = j+1;
%     end
% end
% MaxPSD     = Fpeakpow;
% MaxPSDfreq = Fpeak;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:size(FullspctrmMags,1)
    MinSide = min(mean(FullspctrmMags(i,:,:)));
    C = cumsum((squeeze(mean(FullspctrmMags(i,:,:))) - ones(size(FullspctrmMags,3),1)*MinSide));
    %     test(i,:) = (squeeze(mean(Fullspctrm(i,:,:))))';
    %     mysubplot(7,10,i);
    %     plot(test(i,:))
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
s = subplot(3,5,3);
plot(FullfreqSave(MaxPSDfreq),(asc_ord(:,1))/0.250,'marker','*','linestyle','none')
axis([min(FullfreqSave) max(FullfreqSave) (min(asc_ord(:,1))/0.250) (max(asc_ord(:,1))/0.250)]);
% set(s,'Ytick',1:round(length(asc_ord)/12):length(asc_ord),'Yticklabel',(asc_ord(1:round(length(asc_ord)/12):end,1)/0.250)');
set(gca,'YDir','reverse')
title(['Corr coeff : ' round(num2str(R(2,1))*1000)/1000 ', pval = ' round(num2str(p(2,1))*1000)/1000])
ylabel('duration (ms)');
xlabel('frequency (hz)');

for i = 1:size(FullspctrmGradslong,1)
    MinSide = min(mean(FullspctrmGradslong(i,:,:)));
    C = cumsum((squeeze(mean(FullspctrmGradslong(i,:,:))) - ones(size(FullspctrmGradslong,3),1)*MinSide));
    %     test(i,:) = (squeeze(mean(Fullspctrm(i,:,:))))';
    %     mysubplot(7,10,i);
    %     plot(test(i,:));
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
s = subplot(3,5,8);
plot(FullfreqSave(MaxPSDfreq),(asc_ord(:,1))/0.250,'marker','*','linestyle','none')
axis([min(FullfreqSave) max(FullfreqSave) (min(asc_ord(:,1))/0.250) (max(asc_ord(:,1))/0.250)]);
% set(s,'Ytick',1:round(length(asc_ord)/12):length(asc_ord),'Yticklabel',(asc_ord(1:round(length(asc_ord)/12):end,1)/0.250)');
set(gca,'YDir','reverse')
title(['Corr coeff : ' round(num2str(R(2,1))*1000)/1000 ', pval = ' round(num2str(p(2,1))*1000)/1000])
ylabel('duration (ms)');
xlabel('frequency (hz)');

for i = 1:size(FullspctrmGradslat,1)
    MinSide = min([mean(FullspctrmGradslat(i,:,:))]);
    C = cumsum((squeeze(mean(FullspctrmGradslat(i,:,:))) - ones(size(FullspctrmGradslat,3),1)*MinSide));
    %     test(i,:) = (squeeze(mean(Fullspctrm(i,:,:))))';
    %     mysubplot(7,10,i);
    %     plot(test(i,:))
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
s = subplot(3,5,13);
plot(FullfreqSave(MaxPSDfreq),(asc_ord(:,1))/0.250,'marker','*','linestyle','none')
axis([min(FullfreqSave) max(FullfreqSave) (min(asc_ord(:,1))/0.250) (max(asc_ord(:,1))/0.250)]);
% set(s,'Ytick',1:round(length(asc_ord)/12):length(asc_ord),'Yticklabel',(asc_ord(1:round(length(asc_ord)/12):end,1)/0.250)');
set(gca,'YDir','reverse')
title(['Corr coeff : ' round(num2str(R(2,1))*1000)/1000 ', pval = ' round(num2str(p(2,1))*1000)/1000])
ylabel('duration (ms)');
xlabel('frequency (hz)');

% subplot(3,4,7)
% plot(FullfreqSave(MaxPSDfreq),asc_ord(end:-1:1,1)/0.250 ,'marker','o','linestyle','none');
% axis([min(FullfreqSave) max(FullfreqSave) min(asc_ord(:,1))/0.250 max(asc_ord(:,1))/0.250]) ;
% set(gca,'Ytick',1:10:length(asc_ord),'Yticklabel',asc_ord(end:-10:1));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear Fpeak MaxPSDfreq
numpoints = round(1/((Fullfreq(end) - Fullfreq(1))/length(Fullfreq)));

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

[R,p] = corr([asc_ord(:,1) MaxPSD'],'type','Pearson');
s = subplot(3,5,4);
plot(MaxPSD,(asc_ord(:,1))/0.250,'marker','*','linestyle','none')
axis([min(MaxPSD) max(MaxPSD) (min(asc_ord(:,1))/0.250) (max(asc_ord(:,1))/0.250)]);
% set(s,'Ytick',1:round(length(asc_ord)/12):length(asc_ord),'Yticklabel',(asc_ord(1:round(length(asc_ord)/12):end,1)/0.250)');
set(gca,'YDir','reverse')
title(['Corr coeff : ' round(num2str(R(2,1))*1000)/1000 ', pval = ' round(num2str(p(2,1))*1000)/1000])
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

[R,p] = corr([asc_ord(:,1) MaxPSD'],'type','Pearson');
s = subplot(3,5,9);
plot(MaxPSD,(asc_ord(:,1))/0.250,'marker','*','linestyle','none')
axis([min(MaxPSD) max(MaxPSD) (min(asc_ord(:,1))/0.250) (max(asc_ord(:,1))/0.250)]);
% set(s,'Ytick',1:round(length(asc_ord)/12):length(asc_ord),'Yticklabel',(asc_ord(1:round(length(asc_ord)/12):end,1)/0.250)');
set(gca,'YDir','reverse')
title(['Corr coeff : ' round(num2str(R(2,1))*1000)/1000 ', pval = ' round(num2str(p(2,1))*1000)/1000])
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

[R,p] = corr([asc_ord(:,1) MaxPSD'],'type','Pearson');
s = subplot(3,5,14);
plot(MaxPSD,(asc_ord(:,1))/0.250,'marker','*','linestyle','none')
axis([min(MaxPSD) max(MaxPSD) (min(asc_ord(:,1))/0.250) (max(asc_ord(:,1))/0.250)]);
% set(s,'Ytick',1:round(length(asc_ord)/12):length(asc_ord),'Yticklabel',(asc_ord(1:round(length(asc_ord)/12):end,1)/0.250)');
set(gca,'YDir','reverse')
title(['Corr coeff : ' round(num2str(R(2,1))*1000)/1000 ', pval = ' round(num2str(p(2,1))*1000)/1000])
ylabel('duration (ms)');
xlabel('power');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if savetag == 1
    print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
        '/Fullspctrm_overview_' num2str(freqband(1)) '-' num2str(freqband(2)) '_' num2str(index) '_' ...
        num2str(APtag) '_' num2str(LRtag) '.png']);
end

