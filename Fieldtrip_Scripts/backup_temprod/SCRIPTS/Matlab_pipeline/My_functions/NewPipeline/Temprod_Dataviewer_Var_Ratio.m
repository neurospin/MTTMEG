function Temprod_Dataviewer_Var_Ratio(subject,RunArray,freqband,savetag,tag)

% set root
root = SetPath(tag);

DIR = [root '/DATA/NEW/processed_' subject ];
chantype            = {'Mags';'Grads1';'Grads2'};

fig                 = figure('position',[1 1 1920 1080]);
set(fig,'PaperPosition',[1 1 1280 1024])
set(fig,'PaperPositionMode','auto')

c = colormap('jet');
C = c(1:10:end,:);

colors = {'-k';'-b';'-r';'-g';'-y'};
colors_bis = {C(1,:);C(2,:);C(3,:);C(4,:);C(5,:);C(6,:);C(7,:)};

for j = 1:3
    Fullspctrm          = [];
    Fullfreq            = [];
    Fullspctrm_path     = [DIR '\FT_spectra\BLOCKFREQ_RATIO_' chantype{j} '_est' num2str(RunArray(1),'%02i') 'rep' num2str(RunArray(2),'%02i') '_1_120Hz'];
    freq                = load(Fullspctrm_path);
    
    Fullfreq            = freq.freq;
    Fullspctrm          = freq.powspctrm;
    
    % select frequency band
    fbegin              = find(Fullfreq >= freqband(1));
    fend                = find(Fullfreq <= freqband(2));
    fband               = fbegin(1):fend(end);
    bandFullspctrm      = Fullspctrm(:,:,fband);
    bandFullfreq        = Fullfreq(fband);
    clear Fullspctrm Fullfreq Fullspctrmrest Fullfreqrest
    Fullspctrm          = bandFullspctrm;
    Fullfreq            = bandFullfreq;
    
    MEANspctrm = mean(squeeze(mean(exp(Fullspctrm*log(10)),2)));
    STD = std(squeeze(mean(exp(Fullspctrm*log(10)),2)));
    
    freq.powspctrm = exp( freq.powspctrm*log(10));
    
    subplot(3,3,j)    
    shadedErrorBar((Fullfreq),MEANspctrm,(STD),{'markerfacecolor',[1 0 0]},0)
    line(([freqband(1) freqband(2)]),[1 1],'linestyle',':')
    title([chantype{j} ': ratio est/rep'])
    set(gca,'ytick',0:0.1:2,'yticklabel',-100:10:100)
    set(gca,'xtick',freqband(1):round((freqband(2) - freqband(1))/5):freqband(2),'xticklabel',freqband(1):round((freqband(2) - freqband(1))/5):freqband(2))
    ylabel('% of mean power change (+-STD)')
    xlabel('frequency')
   
    tmp = ones(size(Fullspctrm,1),size(Fullspctrm,3));
    tmp = squeeze(mean(exp(Fullspctrm*log(10)),2)) - tmp;
    tmp = tmp*100;
    
    subplot(3,3,j+3)
    imagesc(tmp,[-100 100])
    set(gca,'xtick',1:((size(Fullspctrm,3))/5):(size(Fullspctrm,3)),'xticklabel',freqband(1):round((freqband(2) - freqband(1))/5):freqband(2))
    colorbar
    title('% of power change')
    ylabel('trials')
    
    % plot topographies
    
    cfg                   = [];
    cfg.channel           = 'all';
    cfg.xparam            = 'freq';
    cfg.zparam            = 'powspctrm';
    cfg.xlim              = [10 12];
    cfg.baseline          = 'no';
    cfg.trials            = 'all';
    cfg.colormap          = jet;
    cfg.marker            = 'off';
    cfg.markersymbol      = 'o';
    cfg.markercolor       = [0 1 1];
    cfg.markersize        = 2;
    cfg.markerfontsize    = 8;
    cfg.colorbar          = 'no';
    cfg.interplimits      = 'head';
    cfg.interpolation     = 'v4';
    cfg.style             = 'straight';
    cfg.gridscale         = 67;
    cfg.shading           = 'flat';
    cfg.interactive       = 'yes';
    cfg.fontsize          = 10;
    cfg.commentpos        = 'title';
    cfg.comment           = ['alpha band'];
    cfg.layout            = [root '/SCRIPTS/Layouts_fieldtrip/NM306mag.lay'];
    lay                   = ft_prepare_layout(cfg,freq);
    lay.label             = freq.label;
    cfg.layout            = lay;    
    
    subplot(3,3,j+6)
    ft_topoplotER(cfg,freq);
    
end

print('-dpng',[root '/DATA/NEW/plots_' subject '\POWRATIO_ESTREP_RUN' num2str(RunArray(1),'%02i') ...
        '-' num2str(RunArray(2),'%02i') '_' num2str(freqband(1)) '_' num2str(freqband(2)) 'Hz.png'])


