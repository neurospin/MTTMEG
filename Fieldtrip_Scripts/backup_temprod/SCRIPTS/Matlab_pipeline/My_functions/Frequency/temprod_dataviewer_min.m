function temprod_dataviewer_min(index,subject,freqband,K,debiasing,interpnoise,chandisplay,savetag)

DIR = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];
chantypefull            = {'Mags';'Gradslong';'Gradslat'};

for j = 1:3
    
    Fullspctrm          = [];
    Fullfreq            = [];
    chantype            = chantypefull{j};
    Fullspctrm_path     = [DIR 'FT_spectra/FullspctrmMin_' chantype num2str(index) '.mat'];
    load(Fullspctrm_path);
    tmp = unique(Fullfreq); clear Fullfreq;
    Fullfreq            = tmp;
    
    %% estimate alpha for power law bias 1/f^alpha, by Maximum likelyhood estimation
    if debiasing == 1
        n                   = length(unique(Fullfreq));
        tmp                 = find(Fullfreq <= 50);
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
                '/FullspctrmMin_' chantype '_' num2str(freqband(1)) '-' num2str(freqband(2)) '_' num2str(index) '.png']);
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
                '/FullspctrmMin_zscores_' chantype '_' num2str(freqband(1)) '-' num2str(freqband(2)) '_' num2str(index) '.png']);
        end
    end
    %% rename data for averaging
    eval(['Fullspctrm' chantype '= Fullspctrm;']);
end

%% plot results, zscores, averages across channels
fig                 = figure('position',[1 1 1280/1.5 1024]);
set(fig,'PaperPosition',[1 1 1280 1024])
set(fig,'PaperPositionMode','auto')
%% psd data
zscoretag = 0;
%% magnetometers

sub1 = subplot(4,3,1);
if zscoretag == 1
    z = zscore((squeeze(mean(FullspctrmMags,2))),0,2);
    imagesc(z);
else
    imagesc((squeeze(mean(FullspctrmMags,2))));
end
xlabel('frequency');
ylabel('trials');
title('mags Power');
% colorbar;
set(sub1,'XTick',10:16:length(Fullfreq),'XTickLabel',round(Fullfreq(10:16:end)*10)/10);
%% longitudinal gradiometers
sub2 = subplot(4,3,2);
if zscoretag == 1
    z = zscore((squeeze(mean(FullspctrmGradslong,2))),0,2);
    imagesc(z);
else
    imagesc((squeeze(mean(FullspctrmGradslong,2))));
end
xlabel('frequency');
ylabel('trials');
title('gradslong Power');
% colorbar;
set(sub2,'XTick',10:16:length(Fullfreq),'XTickLabel',round(Fullfreq(10:16:end)*10)/10);
%% latitudinal gradiometers
sub3 = subplot(4,3,3);
if zscoretag == 1
    z = zscore((squeeze(mean(FullspctrmGradslat,2))),0,2);
    imagesc(z);
else
    imagesc((squeeze(mean(FullspctrmGradslat,2))));
end
xlabel('frequency');
ylabel('trials');
title('gradslat Power');
% colorbar
set(sub3,'XTick',10:16:length(Fullfreq),'XTickLabel',round(Fullfreq(10:16:end)*10)/10);

% sub4 = subplot(4,3,4);
% plot(asc_ord(:,1)/250,((length(asc_ord)):-1:1));
% axis([min(asc_ord(:,1))/250 max(asc_ord(:,1))/250 1 length(asc_ord)])
% set(gca,'Ytick',1:10:length(asc_ord),'Yticklabel',length(asc_ord):-10:1)
% ylabel('trials'); xlabel('duration (s)')
%% Z-scores data
zscoretag = 1;
%% magnetometers
sub1 = subplot(4,3,4);
if zscoretag == 1
    z = zscore((squeeze(mean(FullspctrmMags,2))),0,2);
    imagesc(z);
else
    imagesc((squeeze(mean(FullspctrmMags,2))));
end
xlabel('frequency');
ylabel('trials');
title('mags Power zscore');
% colorbar;
set(sub1,'XTick',10:16:length(Fullfreq),'XTickLabel',round(Fullfreq(10:16:end)*10)/10);
%% longitudinal gradiometers
sub2 = subplot(4,3,5);
if zscoretag == 1
    z = zscore((squeeze(mean(FullspctrmGradslong,2))),0,2);
    imagesc(z);
else
    imagesc((squeeze(mean(FullspctrmGradslong,2))));
end
xlabel('frequency');
ylabel('trials');
title('gradslong Power zscore');
% colorbar;
set(sub2,'XTick',10:16:length(Fullfreq),'XTickLabel',round(Fullfreq(10:16:end)*10)/10);
%% latitudinal gradiometers
sub3 = subplot(4,3,6);
if zscoretag == 1
    z = zscore((squeeze(mean(FullspctrmGradslat,2))),0,2);
    imagesc(z);
else
    imagesc((squeeze(mean(FullspctrmGradslat,2))));
end
xlabel('frequency');
ylabel('trials');
title('gradslat Power zscore');
% colorbar
set(sub3,'XTick',10:16:length(Fullfreq),'XTickLabel',round(Fullfreq(10:16:end)*10)/10);

% sub4 = subplot(4,3,8)
% plot(asc_ord(:,1)/250,((length(asc_ord)):-1:1));
% axis([min(asc_ord(:,1))/250 max(asc_ord(:,1))/250 1 length(asc_ord)])
% set(gca,'Ytick',1:10:length(asc_ord),'Yticklabel',length(asc_ord):-10:1)
% ylabel('trials'); xlabel('duration (s)')

%% plot correlations 

% get frequency of the power peak
for i = 1:size(bandFullspctrm,1)
    [MaxPSD(i), MaxPSDfreq(i)] = max(mean(squeeze(FullspctrmMags(i,:,:))));
end
[R,p] = corr([asc_ord(:,1) FullfreqSave(MaxPSDfreq)'],'type','Pearson');
subplot(4,3,7)
plot(FullfreqSave(MaxPSDfreq),(length(asc_ord)):-1:1,'marker','*','linestyle','none')   
axis([min(FullfreqSave) max(FullfreqSave) 0 (length(asc_ord) +1)]) ;
set(gca,'Ytick',1:10:length(asc_ord),'Yticklabel',asc_ord(end:-10:1,1)/0.250);
title(['Corr coeff : ' num2str(R(2,1)) ', pval = ' num2str(p(2,1))])
ylabel('duration (s)');
xlabel('frequency');

for i = 1:size(bandFullspctrm,1)
    [MaxPSD(i), MaxPSDfreq(i)] = max(mean(squeeze(FullspctrmGradslong(i,:,:))));
end
[R,p] = corr([asc_ord(:,1) FullfreqSave(MaxPSDfreq)'],'type','Pearson');
subplot(4,3,8)
plot(FullfreqSave(MaxPSDfreq),(length(asc_ord)):-1:1,'marker','*','linestyle','none')   
axis([min(FullfreqSave) max(FullfreqSave) 0 (length(asc_ord) +1)]) ;
set(gca,'Ytick',1:10:length(asc_ord),'Yticklabel',asc_ord(end:-10:1,1)/0.250);
title(['Corr coeff : ' num2str(R(2,1)) ', pval = ' num2str(p(2,1))])
ylabel('duration (s)');
xlabel('frequency');

for i = 1:size(bandFullspctrm,1)
    [MaxPSD(i), MaxPSDfreq(i)] = max(mean(squeeze(FullspctrmGradslat(i,:,:))));
end
[R,p] = corr([asc_ord(:,1) FullfreqSave(MaxPSDfreq)'],'type','Pearson');
subplot(4,3,9)
plot(FullfreqSave(MaxPSDfreq),(length(asc_ord)):-1:1,'marker','*','linestyle','none')   
axis([min(FullfreqSave) max(FullfreqSave) 0 (length(asc_ord) +1)]) ;
set(gca,'Ytick',1:10:length(asc_ord),'Yticklabel',asc_ord(end:-10:1,1)/0.250);
title(['Corr coeff : ' num2str(R(2,1)) ', pval = ' num2str(p(2,1))])
ylabel('duration (s)');
xlabel('frequency');

% subplot(3,4,7)
% plot(FullfreqSave(MaxPSDfreq),asc_ord(end:-1:1,1)/0.250 ,'marker','o','linestyle','none');
% axis([min(FullfreqSave) max(FullfreqSave) min(asc_ord(:,1))/0.250 max(asc_ord(:,1))/0.250]) ;
% set(gca,'Ytick',1:10:length(asc_ord),'Yticklabel',asc_ord(end:-10:1));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% plot mean topographies
[label2,label3,label1]     = grads_for_layouts;
chantypefull               = {'Mags';'Gradslong';'Gradslat'};
for x = 1:3
    chantypefull{x};   
    % load full spectra array
    chantype               = chantypefull{x};
    % select the corresponding power
    eval(['freq.powspctrm         = Fullspctrm' chantype]);
    freq.freq              = Fullfreq;
    trialnumber            = size(Fullspctrm,1);
    % complete dummy fieldtrip structure
    freq.dimord            = 'rpt_chan_freq';
    eval(['freq.label      = label' num2str(x) ';']);
    freq.cumtapcnt         = ones(trialnumber,length(freq.freq));
    
    clear cfg
    cfg.channel           = 'all';
    cfg.xparam            = 'freq';
    cfg.zparam            = 'powspctrm';
    cfg.xlim              = [Fullfreq(1) Fullfreq(end)];
    %     cfg.zlim              = [m M];
    cfg.baseline          = 'no';
    cfg.trials            = 'all';
    cfg.colormap          = jet;
    cfg.marker            = 'off';
    cfg.markersymbol      = 'o';
    cfg.markercolor       = [0 0 0];
    cfg.markersize        = 2;
    cfg.markerfontsize    = 8;
    cfg.colorbar          = 'yes';
    cfg.interplimits      = 'head';
    cfg.interpolation     = 'v4';
    cfg.style             = 'straight';
    cfg.gridscale         = 67;
    cfg.shading           = 'flat';
    cfg.interactive       = 'yes';
    cfg.comment           = ['average power' chantype];
    cfg.layout            = '/neurospin/meg_tmp/ResonanceMeg_Baptiste_2009/SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
    lay                   = ft_prepare_layout(cfg,freq);
    lay.label             = freq.label;
    cfg.layout            = lay;
    
    subplot(4,3,9+x)
    ft_topoplotER(cfg,freq)
end

if savetag == 1
    print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
        '/FullspctrmMin_overview_' num2str(freqband(1)) '-' num2str(freqband(2)) '_' num2str(index) '.png']);
end



