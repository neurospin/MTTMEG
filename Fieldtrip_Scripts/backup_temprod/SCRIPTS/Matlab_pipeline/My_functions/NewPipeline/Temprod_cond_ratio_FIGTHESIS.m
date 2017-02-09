function Temprod_cond_ratio(subject,RunArray,chantype,Pad,freqband,Target,tag)

% % test set
% subject  = 's14';
% RunArray = [2 4];
% chantype = 'Mags';
% tag      = 'Laptop';
% freqband = [1 120];
% Pad      = 12600;
% Target   = 5.7;

% set root
root = SetPath(tag);

% load data
for i = 1:2
    ProcDataDir                = [root '/DATA/NEW/processed_' subject '/'];
    DataDir                    = [ProcDataDir 'FT_trials/BLOCKTRIALS_' chantype '_RUN' num2str(RunArray(i),'%02i') '.mat'];
    eval(['data' num2str(i) ' = load(DataDir)']);
end

% load matching indexes
ProcDataDir                    = [root '/DATA/NEW/processed_' subject '/'];
DataDir                        = [ProcDataDir 'FT_trials/matchestrep_' chantype '_RUN' num2str(RunArray(i),'%02i') '.mat'];
load(DataDir)

% keep only matching data
[x2,y2] = find((isnan(matchest(:,1)) == 0) == 1);
matchest = matchest(x2,:);
[x1,y1] = find((isnan(matchrep(:,1)) == 0) == 1);
matchrep = matchrep(x1,:);

cfg                    = [];
cfg.channel            = 'all';
cfg.method             = 'mtmfft';
cfg.output             = 'pow';
cfg.taper              = 'dpss';
cfg.foi                = freqband(1):0.2:freqband(2);
cfg.tapsmofrq          = 0.5;
cfg.trials             = matchest(:,2);
cfg.keeptrials         = 'yes';
cfg.pad                = Pad/data1.fsample;
cfg.polyremoval        = 0;
freq1                  = ft_freqanalysis(cfg,data1);
[freq1.freq,freq1.powspctrm]  = LineNoiseInterp(freq1.freq,freq1.powspctrm);

cfg                    = [];
cfg.channel            = 'all';
cfg.method             = 'mtmfft';
cfg.output             = 'pow';
cfg.taper              = 'dpss';
cfg.foi                = freqband(1):0.2:freqband(2);
cfg.tapsmofrq          = 0.5;
cfg.trials             = matchrep(:,2);
cfg.keeptrials         = 'yes';
cfg.pad                = Pad/data2.fsample;
cfg.polyremoval        = 0;
freq2                  = ft_freqanalysis(cfg,data2);
[freq2.freq,freq2.powspctrm]  = LineNoiseInterp(freq2.freq,freq2.powspctrm);

% remove 1/f common component
% freq3.freq                    = freq1.freq;
% freq3.powspctrm               = cat(1,freq1.powspctrm,freq2.powspctrm);
% [freq3.freq,freq3.powspctrm]  = RemoveOneOverF(freq3.freq,freq3.powspctrm,'mean');
% 
% freq1_bis.powspctrm           = freq3.powspctrm(1:(size(freq3.powspctrm,1)/2),:,:);
% freq2_bis.powspctrm           = freq3.powspctrm(((size(freq3.powspctrm,1)/2)+1):(size(freq3.powspctrm,1)),:,:);

fig1 = figure('position',[1 1 1000 1000]);
set(fig1,'PaperPosition',[1 1 1000 1000])
set(fig1,'PaperPositionmode','auto')
subplot(6,6,[1 2 3 7 8 9 13 14 15])
loglog(freq1.freq, squeeze(mean(mean(freq1.powspctrm))),'color','b','linewidth',3);hold on
loglog(freq2.freq, squeeze(mean(mean(freq2.powspctrm))),'color','r','linewidth',3);
xlabel('Fréquence (Hz)','fontsize',15); ylabel('log-Puissance (u.a.)','fontsize',15);
MIN1 = min(squeeze(mean(mean(freq1.powspctrm))));MIN2  = min(squeeze(mean(mean(freq2.powspctrm))));
MAX1 = max(squeeze(mean(mean(freq1.powspctrm))));MAX2  = max(squeeze(mean(mean(freq2.powspctrm))));
axis([1 100 min(MIN1,MIN2) max(MAX1,MAX2)])
set(gca,'xtick',[1 2 5 10 20 40 100],'xticklabel',[1 2 5 10 20 40 100],'fontsize',15,'box','off','linewidth',3);

cfg                   = [];
cfg.channel           = 'all';
cfg.xparam            = 'freq';
cfg.zparam            = 'powspctrm';
cfg.xlim              = [8 12];
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
lay                   = ft_prepare_layout(cfg,freq1);
lay.label             = freq1.label;
cfg.layout            = lay;

subplot(6,6,4); ft_topoplotER(cfg,freq1);
subplot(6,6,5); ft_topoplotER(cfg,freq2);
freqsub = freq1;
freqsub.powspctrm = freq1.powspctrm - freq2.powspctrm;
subplot(6,6,6); ft_topoplotER(cfg,freqsub);

cfg                   = [];
cfg.channel           = 'all';
cfg.xparam            = 'freq';
cfg.zparam            = 'powspctrm';
cfg.xlim              = [15 30];
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
cfg.comment           = ['beta band'];
cfg.layout            = [root '/SCRIPTS/Layouts_fieldtrip/NM306mag.lay'];
lay                   = ft_prepare_layout(cfg,freq1);
lay.label             = freq1.label;
cfg.layout            = lay;

subplot(6,6,10); ft_topoplotER(cfg,freq1);
subplot(6,6,11); ft_topoplotER(cfg,freq2);
freqsub = freq1;
freqsub.powspctrm = freq1.powspctrm - freq2.powspctrm;
subplot(6,6,12); ft_topoplotER(cfg,freqsub);

cfg                   = [];
cfg.channel           = 'all';
cfg.xparam            = 'freq';
cfg.zparam            = 'powspctrm';
cfg.xlim              = [30 100];
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
cfg.comment           = ['gamma band'];
cfg.layout            = [root '/SCRIPTS/Layouts_fieldtrip/NM306mag.lay'];
lay                   = ft_prepare_layout(cfg,freq1);
lay.label             = freq1.label;
cfg.layout            = lay;

subplot(6,6,16); ft_topoplotER(cfg,freq1);
subplot(6,6,17); ft_topoplotER(cfg,freq2);
freqsub = freq1;
freqsub.powspctrm = freq1.powspctrm - freq2.powspctrm;
subplot(6,6,18); ft_topoplotER(cfg,freqsub);

cfg                   = [];
cfg.channel           = 'all';
cfg.xparam            = 'freq';
cfg.zparam            = 'powspctrm';
cfg.xlim              = [3 7];
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
cfg.comment           = ['theta band'];
cfg.layout            = [root '/SCRIPTS/Layouts_fieldtrip/NM306mag.lay'];
lay                   = ft_prepare_layout(cfg,freq1);
lay.label             = freq1.label;
cfg.layout            = lay;

subplot(6,6,22); ft_topoplotER(cfg,freq1);
subplot(6,6,23); ft_topoplotER(cfg,freq2);
freqsub = freq1;
freqsub.powspctrm = freq1.powspctrm - freq2.powspctrm;
subplot(6,6,24); ft_topoplotER(cfg,freqsub);

print('-dpng',['C:\TEMPROD\DATA\NEW\FIG_THESIS\' chantype '_' subject '_' num2str(RunArray(1)) '_' num2str(RunArray(2)) '.png'])
