function temprod_dataviewer_V2(index,subject,freqband,K,debiasing,interpnoise,chandisplay,savetag,tag)

% set root
root = SetPath(tag);

DIR = [root '/DATA/NEW/processed_' subject '/'];
chantypefull            = {'Mags';'Gradslong';'Gradslat'};
[label2,label3,label1] = grads_for_layouts(tag);

for j = 1:3
    
    Fullspctrm          = [];
    Fullfreq            = [];
    chantype            = chantypefull{j};
    Fullspctrm_path     = [DIR 'FT_spectra/FullspctrmV2_' chantype num2str(index) '.mat'];
    load(Fullspctrm_path);
    tmp = unique(Fullfreq); clear Fullfreq;
    Fullfreq            = tmp;
    
 %% remove 1/f component
    if debiasing == 1
        [Fullfreq,Fullspctrm] = RemoveOneOverF(Fullfreq,Fullspctrm,'mean');
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
            subplot(11,10,k)
            imagesc((full)')
            eval(['title(label' num2str(j) '{k})'])
        end
        
        %% save plot
        if savetag == 1
            print('-dpng',[root '/DATA/NEW/Plots_' subject...
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
            subplot(11,10,k)
            imagesc(zscore((full)',0,2));
            eval(['title(label' num2str(j) '{k})'])
        end
        %% save plot
        if savetag == 1
            print('-dpng',[root '/DATA/NEW/Plots_' subject...
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
% prepare figure
scrsz = get(0,'ScreenSize');
fig                 = figure('position',scrsz);
set(fig,'PaperPosition',scrsz)
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
set(sub1,'Ytick',1:round(length(asc_ord_rs)/12):length(asc_ord_rs),'Yticklabel',asc_ord_rs(1:round(length(asc_ord_rs)/12):end,1)/1);

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
set(sub2,'Ytick',1:round(length(asc_ord_rs)/12):length(asc_ord_rs),'Yticklabel',asc_ord_rs(1:round(length(asc_ord_rs)/12):end,1)/1);

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
set(sub3,'Ytick',1:round(length(asc_ord_rs)/12):length(asc_ord_rs),'Yticklabel',asc_ord_rs(1:round(length(asc_ord_rs)/12):end,1)/1);

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
set(sub1,'Ytick',1:round(length(asc_ord_rs)/12):length(asc_ord_rs),'Yticklabel',asc_ord_rs(1:round(length(asc_ord_rs)/12):end,1)/1);

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
set(sub2,'Ytick',1:round(length(asc_ord_rs)/12):length(asc_ord_rs),'Yticklabel',asc_ord_rs(1:round(length(asc_ord_rs)/12):end,1)/1);

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
set(sub3,'Ytick',1:round(length(asc_ord_rs)/12):length(asc_ord_rs),'Yticklabel',asc_ord_rs(1:round(length(asc_ord_rs)/12):end,1)/1);

% sub4 = subplot(4,3,8)
% plot(asc_ord(:,1)/250,((length(asc_ord)):-1:1));
% axis([min(asc_ord(:,1))/250 max(asc_ord(:,1))/250 1 length(asc_ord)])
% set(gca,'Ytick',1:10:length(asc_ord),'Yticklabel',length(asc_ord):-10:1)
% ylabel('trials'); xlabel('duration (s)')

%% plot correlations 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[MaxPSD,MaxPSDfreq,R,p] = trial_by_trial_corr(FullfreqSave,FullspctrmMags,asc_ord,'freq','max','Pearson');
s = subplot(3,5,3);
plot(FullfreqSave(MaxPSDfreq),(asc_ord(:,1))/1,'marker','*','linestyle','none')   
axis([min(FullfreqSave) max(FullfreqSave) (min(asc_ord(:,1))/1) (max(asc_ord(:,1))/1)]);
set(gca,'YDir','reverse')
title(['Corr coeff : ' round(num2str(R(2,1))*1000)/1000 ', pval = ' round(num2str(p(2,1))*1000)/1000])
ylabel('duration (ms)');
xlabel('frequency (hz)');
[MaxPSD,MaxPSDfreq,R,p] = trial_by_trial_corr(FullfreqSave,FullspctrmMags,asc_ord,'pow','max','Pearson');
s = subplot(3,5,4);
plot(MaxPSD,(asc_ord(:,1))/1,'marker','*','linestyle','none')   
axis([min(MaxPSD) max(MaxPSD) (min(asc_ord(:,1))/1) (max(asc_ord(:,1))/1)]);
set(gca,'YDir','reverse')
title(['Corr coeff : ' round(num2str(R(2,1))*1000)/1000 ', pval = ' round(num2str(p(2,1))*1000)/1000])
ylabel('duration (ms)');
xlabel('power(T)');

[MaxPSD,MaxPSDfreq,R,p] = trial_by_trial_corr(FullfreqSave,FullspctrmGradslong,asc_ord,'freq','max','Pearson');
s = subplot(3,5,8);
plot(FullfreqSave(MaxPSDfreq),(asc_ord(:,1))/1,'marker','*','linestyle','none')   
axis([min(FullfreqSave) max(FullfreqSave) (min(asc_ord(:,1))/1) (max(asc_ord(:,1))/1)]);
set(gca,'YDir','reverse')
title(['Corr coeff : ' round(num2str(R(2,1))*1000)/1000 ', pval = ' round(num2str(p(2,1))*1000)/1000])
ylabel('duration (ms)');
xlabel('frequency (hz)');
[MaxPSD,MaxPSDfreq,R,p] = trial_by_trial_corr(FullfreqSave,FullspctrmGradslong,asc_ord,'pow','max','Pearson');
s = subplot(3,5,9);
plot(MaxPSD,(asc_ord(:,1))/1,'marker','*','linestyle','none')   
axis([min(MaxPSD) max(MaxPSD) (min(asc_ord(:,1))/1) (max(asc_ord(:,1))/1)]);
set(gca,'YDir','reverse')
title(['Corr coeff : ' round(num2str(R(2,1))*1000)/1000 ', pval = ' round(num2str(p(2,1))*1000)/1000])
ylabel('duration (ms)');
xlabel('power(T)');

[MaxPSD,MaxPSDfreq,R,p] = trial_by_trial_corr(FullfreqSave,FullspctrmGradslat,asc_ord,'freq','max','Pearson');
s = subplot(3,5,13);
plot(FullfreqSave(MaxPSDfreq),(asc_ord(:,1))/1,'marker','*','linestyle','none')   
axis([min(FullfreqSave) max(FullfreqSave) (min(asc_ord(:,1))/1) (max(asc_ord(:,1))/1)]);
set(gca,'YDir','reverse')
title(['Corr coeff : ' round(num2str(R(2,1))*1000)/1000 ', pval = ' round(num2str(p(2,1))*1000)/1000])
ylabel('duration (ms)');
xlabel('frequency (hz)');
[MaxPSD,MaxPSDfreq,R,p] = trial_by_trial_corr(FullfreqSave,FullspctrmGradslat,asc_ord,'pow','max','Pearson');
s = subplot(3,5,14);
plot(MaxPSD,(asc_ord(:,1))/1,'marker','*','linestyle','none')   
axis([min(MaxPSD) max(MaxPSD) (min(asc_ord(:,1))/1) (max(asc_ord(:,1))/1)]);
set(gca,'YDir','reverse')
title(['Corr coeff : ' round(num2str(R(2,1))*1000)/1000 ', pval = ' round(num2str(p(2,1))*1000)/1000])
ylabel('duration (ms)');
xlabel('power(T)');

% for i = 1:size(FullspctrmGradslat,1)
%     MinSide = min(mean(FullspctrmGradslat(i,:,:)));
%     C = cumsum((squeeze(mean(FullspctrmGradslat(i,:,:))) - ones(size(FullspctrmGradslat,3),1)*MinSide));
% %     test(i,:) = (squeeze(mean(Fullspctrm(i,:,:))))'; 
% %     mysubplot(7,10,i);
% %     plot(test(i,:))
%     j = 1;
%     while C(j) <= C(end)/2
%         clear Fpeak
%         if (j-numpoints)     <= 0
%             infbound         =  1;
%         elseif (j-numpoints) >  0
%             infbound         =  j - numpoints;
%         end
%         if (j+numpoints)     >= length(Fullfreq)
%             supbound         =  length(Fullfreq);
%         elseif (j+numpoints) <  length(Fullfreq)
%             supbound         =  j + numpoints;
%         end
%         Fpeak(i,:)           =  infbound:supbound;
%         Fpeakpow(i)          =  mean(squeeze((mean(FullspctrmGradslat(i,:,Fpeak(i,:))))));
%         j                    =  j+1;
%     end
% end
% MaxPSD     = Fpeakpow;
% MaxPSDfreq = Fpeak(i,:);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% plot mean topographies
[label2,label3,label1]     = grads_for_layouts(tag);
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
    cfg.colorbar          = 'no';
    cfg.interplimits      = 'head';
    cfg.interpolation     = 'v4';
    cfg.style             = 'straight';
    cfg.gridscale         = 67;
    cfg.shading           = 'flat';
    cfg.interactive       = 'yes';
    cfg.comment           = [subject ' run ' num2str(index) ' : average power' chantype];
    cfg.layout            = [root '/SCRIPTS/Layouts_fieldtrip/NM306mag.lay'];
    lay                   = ft_prepare_layout(cfg,freq);
    lay.label             = freq.label;
    cfg.layout            = lay;
    
    mysubplot(3,5,5*x)
    ft_topoplotER(cfg,freq)
end  

if savetag == 1
    print('-dpng',[root '/DATA/NEW/Plots_' subject...
        '/Fullspctrm_overview_' num2str(freqband(1)) '-' num2str(freqband(2)) '_' num2str(index) '.png']);
end

