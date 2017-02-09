function fig = TFstatT_subjectlevel(data1,data2,foi)

load('C:\TEMPROD\SCRIPTS\Matlab_pipeline\tools_tmp\pipeline_tmp\neighbours.mat')
for a = 1:104
    neighbours{1,a}.label = ['MEG' neighbours{1,a}.label];
    for b = 1:length(neighbours{1,a}.neighblabel)
        neighbours{1,a}.neighblabel{b} = ['MEG' neighbours{1,a}.neighblabel{b}];
    end
end

[Grads1,Grads2,Mags]   = grads_for_layouts('Laptop');
data1.label = Mags';
data2.label = Mags';

% prepare layout
cfg                           = [];
cfg.layout                    = 'C:\TEMPROD\SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
lay                           = ft_prepare_layout(cfg,data1);
lay.label                     = data1.label;

% test based on fieldtrip tutorial

cfg = [];
cfg.channel          = 'all';
cfg.latency          = 'all';
cfg.frequency        = foi;
cfg.method           = 'montecarlo';
cfg.statistic        = 'indepsamplesT';
cfg.correctm         = 'cluster';
cfg.clusteralpha     = 0.05;
cfg.clusterstatistic = 'maxsum';
cfg.minnbchan        = 2;
cfg.tail             = 0;
cfg.clustertail      = 0;
cfg.alpha            = 0.025;
cfg.numrandomization = 100;
cfg.neighbours       = neighbours;

ntrialdim1 = size(data1.powspctrm,1);
ntrialdim2 = size(data2.powspctrm,1);

design = zeros(1,ntrialdim1 + ntrialdim2);
design(1,1:ntrialdim1) = 1;
design(1,(ntrialdim1+1):(ntrialdim1 + ntrialdim2))= 2;

cfg.design           = design;
cfg.ivar  = 1;

[stat] = ft_freqstatistics(cfg,data1,data2);
stat.rawdiff = (squeeze(nanmean(data1.powspctrm(:,:,:,:),1)) - ...
                squeeze(nanmean(data2.powspctrm(:,:,:,:),1)));

storesigposclust = [];
posmask = zeros(size(squeeze(sum(stat.posclusterslabelmat,2)),1),size(squeeze(sum(stat.posclusterslabelmat,2)),2));
for i = 1:length(stat.posclusters)
    if stat.posclusters(1,i).prob <= 0.05
        storesigposclust = [storesigposclust i];
        posmask          = posmask + (squeeze(sum(stat.posclusterslabelmat == i,2)));
    end
end
storesignegclust = [];
negmask = zeros(size(squeeze(sum(stat.negclusterslabelmat,2)),1),size(squeeze(sum(stat.negclusterslabelmat,2)),2));
for i = 1:length(stat.negclusters)
    if stat.negclusters(1,i).prob <= 0.05
        storesignegclust = [storesignegclust i];
        negmask          = negmask - (squeeze(sum(stat.negclusterslabelmat == i,2)));
    end
end

if isempty(posmask) == 0 && isempty(negmask) == 0
    Mask = negmask + posmask;
elseif isempty(posmask) == 0 && isempty(negmask) == 1
    Mask = posmask;
elseif isempty(posmask) == 1 && isempty(negmask) == 0
    Mask = negmask ;
end

fig = figure('position',[1 1 1000 800]);
set(fig,'PaperPosition',[1 1 1000 800])
set(fig,'PaperPositionmode','auto')
set(fig,'visible','off')

subplot(9,6,[1 2 3 4 5 6 7 8 9 10 11 12])
lim = [-nanmax(nanmax(squeeze(nanmean(stat.rawdiff,2)))) nanmax(nanmax(squeeze(nanmean(stat.rawdiff,2))))];
mask = (Mask ~= 0);
imagesc((squeeze(nanmean(stat.rawdiff,2)).*(mask)),lim)
xlabel('Time samples'); ylabel('channels');
colorbar
count = 19;
for j = 1:2:(min(length(stat.time),36))
    mysubplot(9,6,count)
    chansel = mask(:,j);
    if sum(chansel) == 0
        cfg                    = [];
        cfg.layout             = lay;
        cfg.xlim               = [stat.time(j) stat.time(j)];
        cfg.zlim               = lim;
        cfg.style              = 'straight';
        cfg.parameter          = 'rawdiff';
        cfg.marker             = 'off';
        cfg.comment            = [num2str(stat.time(j)) ' ms'];
        ft_topoplotTFR(cfg,stat)
        count = count + 1;
    else
        [x,y] = find(chansel ~= 0);
        cfg                    = [];
        cfg.highlight          = 'on';
        cfg.highlightchannel   = x;
        cfg.highlightsymbol    = '.';
        cfg.layout             = lay;
        cfg.xlim               = [stat.time(j) stat.time(j)];
        cfg.zlim               = lim;
        cfg.style              = 'straight';
        cfg.parameter          = 'rawdiff';
        cfg.marker              = 'off';
        cfg.comment            = [stat.time(j) ' ms'];
        ft_topoplotTFR(cfg,stat)
        count = count + 1;
    end
end
