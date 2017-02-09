function fig = ERPstatT_subjectlevel(data1,data2,latency)

% load eeg channel names
EEG                    = EEG_for_layouts('Laptop');

% define EEG neighbours
cfg                    = [];
cfg.layout             = 'C:\MTT_MEG\scripts\NMeeg_Standard.lay';
lay                    = ft_prepare_layout(cfg, data1);

% convert cm to mm coordinates
lay.pos                = lay.pos*10;
lay.width              = lay.width*10;
lay.height             = lay.height*10;
for l                  = 1:length(lay.outline)
    lay.outline{l}     = lay.outline{l}*10;
end
lay.mask{1}            = lay.mask{1}*10;

% compute neighbours for each eeg channel
cfg                    = [];
tmp = fieldnames(data1);
for i = 1:length(tmp)
    if strcmp(tmp{i},'grad')
       data1 = rmfield(data1,'grad');
    end
end
cfg.method             = 'distance';
cfg.channel            = EEG;
cfg.layout             = lay;
cfg.minnbchan          = 2;
cfg.neighbourdist      = 1.5;
cfg.feedback           = 'no';
allneighbours          = ft_prepare_neighbours(cfg, data1);

% prepare layout
cfg                           = [];
cfg.layout                    = 'C:\MTT_MEG\scripts\NMeeg_Standard.lay';
lay                           = ft_prepare_layout(cfg,data1);
lay.label                     = data1.label;

% cluster permutation test based on fieldtrip tutorial
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
cfg.numrandomization = 1000;
cfg.neighbours       = allneighbours;

ntrialdim1 = size(data1.trial,1);
ntrialdim2 = size(data2.trial,1);

design = zeros(1,ntrialdim1 + ntrialdim2);
design(1,1:ntrialdim1) = 1;
design(1,(ntrialdim1+1):(ntrialdim1 + ntrialdim2))= 2;

cfg.design           = design;
cfg.ivar  = 1;

[stat] = ft_timelockstatistics(cfg,data1,data2);
stat.rawdiff = (data1.avg - data2.avg);

% plot raw and masked diff and t-value between conditions across channels and time
% get significant positive clusters
storesigposclust = [];
posmask = zeros(size(stat.posclusterslabelmat,1),size(stat.posclusterslabelmat,2));
for i = 1:length(stat.posclusters)
    if stat.posclusters(1,i).prob <= 0.05
        storesigposclust = [storesigposclust i];
        posmask          = posmask + (stat.posclusterslabelmat == i);
    end
end
% get significant negative clusters
storesignegclust = [];
negmask = zeros(size(stat.negclusterslabelmat,1),size(stat.negclusterslabelmat,2));
for i = 1:length(stat.negclusters)
    if stat.negclusters(1,i).prob <= 0.05
        storesignegclust = [storesignegclust i];
        negmask          = negmask - (stat.negclusterslabelmat == i);
    end
end

% compute a mask for both significant positive and negative clusters
if isempty(posmask) == 0 && isempty(negmask) == 0
    Mask = negmask + posmask;
elseif isempty(posmask) == 0 && isempty(negmask) == 1
    Mask = posmask;
elseif isempty(posmask) == 1 && isempty(negmask) == 0
    Mask = negmask ;
end

% plot rasters and topographies
fig = figure('position',[1 1 1000 800]);
set(fig,'PaperPosition',[1 1 1000 800])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

listtopo = [17:48];
limraw = [-max(max(stat.rawdiff)) max(max(stat.rawdiff))];
mask = (Mask ~= 0);
subplot(6,8,[1 2 3 4]); imagesc(stat.time,1:length(stat.label),stat.rawdiff,limraw);colorbar;
xlabel('Time samples'); ylabel('channels');title('raw differences (s)');
subplot(6,8,[5 6 7 8]); imagesc(stat.time,1:length(stat.label),stat.rawdiff.*(mask),limraw);colorbar;
xlabel('Time samples');title('significant differences (s)');

posx0 = find(stat.time >= 0);
sp    = (stat.time(end) - stat.time(1))/length(stat.time);
limnegplot = 0.2/sp;
tpt   = stat.time(limnegplot:25:end);

for j = 1:(min((length(tpt)-1),30))
    mysubplot(6,8,listtopo(j))
    chansel = mask(:,1+25*(j-1));
    if sum(chansel) == 0
        cfg                    = [];
        cfg.layout             = lay;
        cfg.xlim               = [(tpt(j)-0.025) (tpt(j)+0.025)];
        cfg.zlim               = limraw;
        cfg.style              = 'straight';
        cfg.parameter          = 'rawdiff';
        cfg.marker              = 'off';
        cfg.comment            = [num2str(tpt(j)) ' ms'];
        ft_topoplotER(cfg,stat)
    else
        [x,y] = find(chansel ~= 0);
        cfg                    = [];
        cfg.highlight          = 'on';
        cfg.highlightchannel   = x;
        cfg.highlightsymbol    = '.';
        cfg.layout             = lay;
        cfg.xlim               = [(tpt(j)-0.025) (tpt(j)+0.025)];
        cfg.zlim               = limraw;
        cfg.style              = 'straight';
        cfg.parameter          = 'rawdiff';
        cfg.marker              = 'off';
        cfg.comment            = [num2str(tpt(j)) ' ms'];
        ft_topoplotER(cfg,stat)
    end
end
