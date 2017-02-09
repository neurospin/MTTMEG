function temprod_ICA_viewer_sobi(indexrun,subject,numcomponent,freqbandview)

% initialization
Dir                 = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject];
par.ProcDataDir     = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];
load([par.ProcDataDir 'FT_ICs/sobi-comp' num2str(numcomponent) 'V5_freq' num2str(indexrun) '.mat']);
C = colormap(jet(30));
[Gradslong, Gradslat] = grads_for_layouts;
channeltype         = {'MEG*1';Gradslong;Gradslat};
chan_index          = {'Mags';'Gradslong';'Gradslat'};
chan_cmt            = {'M';'G1';'G2'};
[GradsLong,GradsLat,Mags]     = grads_for_layouts;
durinfopath         = [Dir '/FT_trials/runICA' num2str(indexrun) 'durinfo.mat'];
load(durinfopath)

% rename data according to ft format
Fullspctrm          = freq.powspctrm;
Fullfreq            = freq.freq;

% line noise removal and channel-by-channel linear interpolation replacemement
LNfbegin                = find(Fullfreq >= 48);
LNfend                  = find(Fullfreq <= 51);
LNfband                 = LNfbegin(1):LNfend(end);
for i = 1:size(Fullspctrm,1)
    for j = 1:size(Fullspctrm,2)
        L = linspace(Fullspctrm(i,j,LNfbegin(1)),... % beginning of the range
            Fullspctrm(i,j,LNfend(end)),... % end of the range
            LNfend(end) - LNfbegin(1) + 1); % number of frequency bins to replace
        Fullspctrm(i,j,LNfband) = L;
    end
end
LNfbegin                = find(Fullfreq >= 98);
LNfend                  = find(Fullfreq <= 101);
LNfband                 = LNfbegin(1):LNfend(end);
for i = 1:size(Fullspctrm,1)
    for j = 1:size(Fullspctrm,2)
        L = linspace(Fullspctrm(i,j,LNfbegin(1)),... % beginning of the range
            Fullspctrm(i,j,LNfend(end)),... % end of the range
            LNfend(end) - LNfbegin(1) + 1); % number of frequency bins to replace
        Fullspctrm(i,j,LNfband) = L;
    end
end


% remove linear trend for further plot
n                   = length(unique(Fullfreq));
tmp                 = find(Fullfreq <= 80);
for x = 1:size(Fullspctrm,1)
    for y = 1:size(Fullspctrm,2)
        cutoff                = Fullspctrm(x,y,tmp(1)); % i.e cutoff value chosed at 120hz
        AlphaEst(x,y)         = 1 + n*(sum(log(squeeze(Fullspctrm(x,y,:))/cutoff))).^(-1);
        Fullspctrm_debiased(x,y,:)   = squeeze(Fullspctrm(x,y,:))'./(Fullfreq).^(-AlphaEst(x,y));
    end
end

% select frequency band
fbegin              = find(Fullfreq >= freqbandview(1));
fend                = find(Fullfreq <= freqbandview(2));
fband               = fbegin(1):fend(end);
bandFullspctrm      = Fullspctrm(:,:,fband);
bandFullspctrm_debiased      = Fullspctrm_debiased(:,:,fband);
bandFullfreq        = Fullfreq(fband);
clear Fullspctrm Fullspctrm_debiased Fullfreq
Fullspctrm_debiased = bandFullspctrm_debiased;
Fullspctrm          = bandFullspctrm;
Fullfreq            = bandFullfreq;
clear freq.freq freq.powspctrm
freq.freq           = Fullfreq;
freq.powspctrm      = Fullspctrm;

% plot individual comps (amplitude scaled on comps)
fig                 = figure('position',[1 1 1280 1024]);
set(fig,'PaperPosition',[1 1 1280 1024])
set(fig,'PaperPositionMode','auto')
for i               = 1:numcomponent
    subplot(4,4,i)
    tmp             = [];
    tmp             = squeeze(mean(freq.powspctrm(:,i,:),1));
    plot(freq.freq,log(tmp),'linewidth',2,'color',C(i,:));
    xlabel('frequency');
    ylabel('log power');
    title(['comp' num2str(i)]);
end
print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
    '/ICAV5_individualcomps_' num2str(freqbandview(1)) '-' num2str(freqbandview(2)) '_' num2str(indexrun) '_' num2str(numcomponent) 'comp.png']);

% specifiy layout for plotting topographies
clear cfg
cfg.channel           = channeltype{1};
cfg.xparam            = 'comp';
cfg.zparam            = 'topo';
cfg.zlim              = 'maxabs';
cfg.baseline          = 'no';
cfg.trials            = 'all';
cfg.colormap          = jet;
cfg.marker            = 'off';
cfg.markersymbol      = 'none';
cfg.markercolor       = [0 0 0];
cfg.markersize        = 2;
cfg.markerfontsize    = 8;
cfg.colorbar          = 'no';
cfg.interplimits      = 'head';
cfg.interpolation     = 'v4';
cfg.style             = 'straight';
cfg.gridscale         = 67;
cfg.shading           = 'flat';
cfg.interactive       = 'no';
cfg.layout            = '/neurospin/meg_tmp/ResonanceMeg_Baptiste_2009/SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
lay                   = ft_prepare_layout(cfg,comp_topo);
tmp                   = chan_index{1};
eval(['lay.label             = ' tmp]);
cfg.layout            = lay;

% plot topographies
fig                   = figure('position',[1 1 1280 1024]);
set(fig,'PaperPosition',[1 1 1280 1024])
set(fig,'PaperPositionMode','auto')
for i                 = 1:numcomponent
    hold on
    mysubplot(8,8, i*4 - 1)
    cfg.comment       = [chan_cmt{1} 'comp' num2str(i)];
    cfg.commentpos    = 'lefttop';
    cfg.electrodes    = 'off';
    topoplot(cfg,comp_topo.topo(3:3:306,i));
    
    hold on
    mysubplot(8,8,i*4 - 2)
    cfg.comment       = [chan_cmt{2} 'comp' num2str(i)];
    cfg.commentpos    = 'lefttop';
    cfg.electrodes    = 'off';
    topoplot(cfg,comp_topo.topo(1:3:306,i));
    
    hold on 
    mysubplot(8,8,i*4 - 3)
    cfg.comment       = [subject ' r' num2str(indexrun) ' ' chan_cmt{3} 'comp' num2str(i)];
    cfg.commentpos    = 'lefttop';
    cfg.electrodes    = 'off';
    topoplot(cfg,comp_topo.topo(2:3:306,i));
end
print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
    '/ICAV5_topo_overview_' num2str(freqbandview(1)) '-' num2str(freqbandview(2)) '_' num2str(indexrun) '_' num2str(numcomponent) 'comp.png']);

% plot overview of comp spectra
fig                 = figure('position',[1 1 1280 1024]);
set(fig,'PaperPosition',[1 1 1280 1024])
set(fig,'PaperPositionMode','auto')
L = [];
for j = 1:numcomponent
    plot(freq.freq,log(squeeze(mean(freq.powspctrm(:,j,:),1))),'linewidth',2,'color',C(j,:));
    hold on
    L = [L '''comp' num2str(j) ''','];
end
Lfinal = ['legend(' L  '''Location'',''BestOutside'');'];
eval(Lfinal);
ylabel('log Power')
xlabel('frequency (Hz)')
title([subject ' run : ' num2str(indexrun) 'Components Mean power Spectrm averaged across trials'])

print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
    '/ICAV5_spectra_overview_' num2str(freqbandview(1)) '-' num2str(freqbandview(2)) '_' num2str(indexrun) '_' num2str(numcomponent) 'comp.png']);

% plot debiased spectra overviews
fig                 = figure('position',[1 1 1280 1024]);
set(fig,'PaperPosition',[1 1 1280 1024])
set(fig,'PaperPositionMode','auto')

Fullspctrm     = Fullspctrm_debiased; clear Fullspctrm_debiased

freq.freq      = Fullfreq;
freq.powspctrm = Fullspctrm;
L = [];
for j = 1:numcomponent
    plot(freq.freq,log(squeeze(mean(freq.powspctrm(:,j,:),1))),'linewidth',2,'color',C(j,:));
    hold on
    L = [L '''comp' num2str(j) ''','];
end
Lfinal = ['legend(' L  '''Location'',''BestOutside'');'];
eval(Lfinal);
ylabel('log Power')
xlabel('frequency (Hz)')
title([subject ' run : ' num2str(indexrun) 'Components Mean power Spectrm averaged across trials'])

print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
    '/ICAV5_overview_debiased_' num2str(freqbandview(1)) '-' num2str(freqbandview(2)) '_' num2str(indexrun) '_' num2str(numcomponent) 'comp.png']);


fig                 = figure('position',[1 1 1280 1024]);
set(fig,'PaperPosition',[1 1 1280 1024])
set(fig,'PaperPositionMode','auto')
for i = 1:numcomponent
    subplot(4,4,i)
    tmp = [];
    tmp = squeeze(mean(freq.powspctrm(:,i,:),1));
    plot(freq.freq,log(tmp),'linewidth',2,'color',C(i,:));
    xlabel('frequency');
    ylabel('log power');
    title(['comp' num2str(i)]);
end
print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
    '/ICAV5_individualcomps_debiased_' num2str(freqbandview(1)) '-' num2str(freqbandview(2)) '_' num2str(indexrun) '_' num2str(numcomponent) 'comp.png']);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
