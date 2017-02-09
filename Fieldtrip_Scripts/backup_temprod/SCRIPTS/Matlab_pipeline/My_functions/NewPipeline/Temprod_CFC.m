function temprod_hibert(sub,freq,namecond)

% sub = 's12';
% freq = 9;

base = load(['C:\TEMPROD\DATA\NEW\processed_' sub '\FT_trials\BLOCKTRIALS_Grads1_RUN01']);
cond = load(['C:\TEMPROD\DATA\NEW\processed_' sub '\FT_trials\BLOCKTRIALS_Grads1_RUN02']);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% envelloppe analysis

for i = 1:size(cond.time,2)
    cond.trial{1,i} = ft_preproc_bandpassfilter(cond.trial{1,i}, cond.fsample, [freq-1 freq+1]);
    cond.trial{1,i} = ft_preproc_hilbert(cond.trial{1,i},'abs');
end

for i = 1:size(base.time,2)
    base.trial{1,i} = ft_preproc_bandpassfilter(base.trial{1,i}, base.fsample, [freq-1 freq+1]);
    base.trial{1,i} = ft_preproc_hilbert(base.trial{1,i},'abs');
end

% frequency decomposition parameters
cfg                    = [];
cfg.channel            = 'all';
cfg.method             = 'mtmfft';
cfg.output             = 'pow';
cfg.taper              = 'dpss';
cfg.foi                = 0.1:0.05:5;
cfg.trials             = 'all';
cfg.keeptrials         = 'yes';
cfg.tapsmofrq          = 0.5;
cfg.pad                = 50;
cfg.polyremoval        = 1;
condfreq               = ft_freqanalysis(cfg,cond);
basefreq               = ft_freqanalysis(cfg,base);

figure

plot(condfreq.freq,squeeze(mean(mean(condfreq.powspctrm))));hold on
plot(basefreq.freq,squeeze(mean(mean(basefreq.powspctrm))),'color','r')

print('-dpng',['C:\Users\bgauthie\Desktop\TEMP_WORK\' namecond '_' sub '_HILBERT_abs'])

figure

sz = [];
for i = 1:size(condfreq.powspctrm,1)
    sz(i) = length(cond.time{1,i}); 
    plot(condfreq.freq,squeeze(mean(condfreq.powspctrm(i,:,:))),'linewidth',3);hold on
    data(i,:) = zscore(squeeze(mean(condfreq.powspctrm(i,:,:))));
end
sz = [sz ; 1:size(condfreq.powspctrm,1)];
sz = sz'; sz = sortrows(sz);
imagesc(data(sz(:,2),:));

print('-dpng',['C:\Users\bgauthie\Desktop\TEMP_WORK\' namecond '_' sub '_raster'])

fig1 = figure('position',[1 1 1000 1000]);
set(fig1,'PaperPosition',[1 1 1000 1000])
set(fig1,'PaperPositionmode','auto')

cfg                  = [];
cfg.layout           = 'C:\FIELDTRIP\fieldtrip-20120701\template\layout/NM306mag.lay';
lay                  = ft_prepare_layout(cfg,condfreq);
lay.label            = condfreq.label;
cfg.layout           = lay;

fig1 = figure('position',[1 1 1000 1000]);
set(fig1,'PaperPosition',[1 1 1000 1000])
set(fig1,'PaperPositionmode','auto')

ft_multiplotER(cfg,condfreq,basefreq)

print('-dpng',['C:\Users\bgauthie\Desktop\TEMP_WORK\multi' namecond '_' sub '_HILBERT_abs'])

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % frequency decomposition parameters
% cfg                    = [];
% cfg.channel            = 'all';
% cfg.method             = 'wavelet';
% cfg.output             = 'pow';
% cfg.taper              = 'dpss';
% cfg.foi                = 1:0.5:30;
% cfg.toi                = 0:0.05:15;
% cfg.trials             = 'all';
% cfg.keeptrials         = 'yes';
% cfg.width              = cfg.foi;
% cfg.gwidth             = 3;
% cfg.pad                = 15;
% cfg.polyremoval        = 1;
% condfreq               = ft_freqanalysis(cfg,cond);
% 
% % prepare layout
% cfg                  = [];
% cfg.layout           = 'C:\FIELDTRIP\fieldtrip-20120701\template\layout/NM306mag.lay';
% lay                  = ft_prepare_layout(cfg,condfreq);
% lay.label            = condfreq.label;
% cfg.layout           = lay;
% cfg.trials           = 50;
% cfg.colorbar         = 'yes';
% cfg.colormap         = jet;
% cfg.interactive      = 'yes';
% cfg.masknans         = 'no';
% ft_multiplotTFR(cfg,condfreq)
% 
% data = [];
% for j = 1:size(condfreq.powspctrm,2)
%     sz = [];
%     for i = 1:size(condfreq.powspctrm,1)
%         sz(i) = length(cond.time{1,i});
%         data{j}(i,:) = (squeeze(mean(condfreq.powspctrm(i,j,22:24,:))))';
%     end
%     sz = sz'; sz(:,2) = 1:i;
%     sz = sortrows(sz);
%     mysubplot(10,11,j);
%     imagesc(data{j}(sz(:,2)',:))
% end