function fig = ERFstatT_subjectlevel(latency,data1,data2)

if strcmp(data1.label{1,1},'MEG0111') == 1
    chantype = 'Mags';
    
    load('/neurospin/meg/meg_tmp/tools_tmp/Pipeline/pipeline/neuromag306mag_neighb.mat')
    
elseif strcmp(data1.label{1,1},'MEG0113') == 1 || strcmp(data1.label{1,1},'MEG0112') == 1
    chantype = 'Grads';
    
    load('/neurospin/meg/meg_tmp/tools_tmp/Pipeline/pipeline/neuromag306planar_neighb.mat')
    
elseif strcmp(data1.label{1,1},'EEG001') == 1
    chantype = 'EEG';
    
    % to complete
end

[Grads1,Grads2,Mags]   = grads_for_layouts('Network');
data1.label = Mags';
data2.label = Mags';

% prepare layout
cfg                           = [];
cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/fieldtrip-20130901/template/layout/NM306mag.lay';
lay                           = ft_prepare_layout(cfg,data1);
lay.label                     = data1.label;

% test based on fieldtrip tutorial
cfg = [];
cfg.channel          = 'all';
cfg.latency          = latency;
cfg.frequency        = 'all';
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

ntrialdim1 = size(data1.trial,1);
ntrialdim2 = size(data2.trial,1);

design = zeros(1,ntrialdim1 + ntrialdim2);
design(1,1:ntrialdim1) = 1;
design(1,(ntrialdim1+1):(ntrialdim1 + ntrialdim2))= 2;

cfg.design           = design;
cfg.ivar  = 1;

[stat] = ft_timelockstatistics(cfg,data1,data2);
stat.rawdiff = (data1.avg - data2.avg);

posmask = [];
if isfield(stat,'posclusterslabelmat') == 1;
    storesigposclust = [];
    posmask = zeros(size(stat.posclusterslabelmat,1),size(stat.posclusterslabelmat,2));
    for i = 1:length(stat.posclusters)
        if stat.posclusters(1,i).prob <= 0.05
            storesigposclust = [storesigposclust i];
            posmask          = posmask + (stat.posclusterslabelmat == i);
        end
    end
end
negmask = [];
if isfield(stat,'negclusterslabelmat') == 1;
    storesignegclust = [];
    negmask = zeros(size(stat.negclusterslabelmat,1),size(stat.negclusterslabelmat,2));
    for i = 1:length(stat.negclusters)
        if stat.negclusters(1,i).prob <= 0.05
            storesignegclust = [storesignegclust i];
            negmask          = negmask - (stat.negclusterslabelmat == i);
        end
    end
end

if isempty(posmask) == 0 && isempty(negmask) == 0
    Mask = negmask + posmask;
elseif isempty(posmask) == 0 && isempty(negmask) == 1
    Mask = posmask;
elseif isempty(posmask) == 1 && isempty(negmask) == 0
    Mask = negmask ;
elseif isempty(posmask) == 1 && isempty(negmask) == 1
    Mask = zeros(size(stat.stat,1),size(stat.stat,2))
end

fig = figure('position',[1 1 800 1000]);
set(fig,'PaperPosition',[1 1 800 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','off')

listtopo = [19:54];
subplot(9,6,[1 2 3 4 5 6 7 8 9 10 11 12])
lim = [-max(max(stat.stat)) max(max(stat.stat))];
mask = (Mask ~= 0);
imagesc(stat.stat.*(mask),lim)
xlabel('Time samples'); ylabel('channels');
set(gca,'xtick',1:20:length(stat.time(1:20:end))*20,'xticklabel',stat.time(1:20:end))
colorbar
[pox,posy] = find(stat.time >= 0);
set(gca,'xtick',(posy(1)):20:length(stat.time(1:20:end))*20,'xticklabel',(floor(stat.time((posy(1)):20:end)*100))./100);
colorbar

for j = 1:(min((length(stat.time((posy(1) ):20:end))-1),30))
    mysubplot(9,6,listtopo(j))
    chansel = mask(:,1+20*(j-1));
    if sum(chansel) == 0
        cfg                    = [];
        cfg.layout             = lay;
        cfg.xlim               = [stat.time(1+20*(j-1)) stat.time(1+20*(j-1))];
        cfg.zlim               = lim;
        cfg.style              = 'straight';
        cfg.parameter          = 'stat';
        cfg.marker              = 'off';
        cfg.comment            = [num2str(stat.time(1+20*(j-1))) ' ms'];
        ft_topoplotER(cfg,stat);
    else
        [x,y] = find(chansel ~= 0);
        cfg                    = [];
        cfg.highlight          = 'on';
        cfg.highlightchannel   = x;
        cfg.highlightsymbol    = '.';
        cfg.layout             = lay;
        cfg.xlim               = [stat.time(1+20*(j-1)) stat.time(1+20*(j-1))];
        cfg.zlim               = lim;
        cfg.style              = 'straight';
        cfg.parameter          = 'stat';
        cfg.marker              = 'off';
        cfg.comment            = [num2str(stat.time(1+20*(j-1))) ' ms'];
        ft_topoplotER(cfg,stat);
    end
end

fig = figure('position',[1 1 800 1000]);
set(fig,'PaperPosition',[1 1 800 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','off')

lim = [-max(max(stat.stat)) max(max(stat.stat))];
[pox,posy] = find(stat.time >= 0);
listtopo = [1:54];

for j = 1:(min((length(stat.time((posy(1) ):20:end))-1),30))
    mysubplot(9,6,listtopo(j))
    cfg                    = [];
    cfg.layout             = lay;
    cfg.xlim               = [stat.time(1+20*(j-1)) stat.time(1+20*(j-1))];
    cfg.zlim               = lim;
    cfg.style              = 'straight';
    cfg.parameter          = 'stat';
    cfg.marker             = 'off';
    cfg.comment            = [num2str(stat.time(1+20*(j-1))) ' ms'];
    
    ft_topoplotER(cfg,stat);
    
end