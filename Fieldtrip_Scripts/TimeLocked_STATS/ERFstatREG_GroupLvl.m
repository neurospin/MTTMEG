function fig = ERFstatREG_GroupLvl(condnames,GDAVG,GDAVGt,data1,data2,data3)

if strcmp(data1.label{1,1},'MEG0111') == 1
    chantype = 'Mags';
    
    load('/neurospin/meg/meg_tmp/tools_tmp/Pipeline/pipeline/neuromag306mag_neighb.mat')
   
    
elseif strcmp(data1.label{1,1},'MEG0113') == 1 || strcmp(data1.label{1,1},'MEG0112') == 1
    chantype = 'Grads';
    
    load('/neurospin/meg/meg_tmp/tools_tmp/Pipeline/pipeline/neuromag306planar_neighb.mat')
    
elseif strcmp(data1.label{1,1},'EEG001') == 1
    chantype = 'EEG';
    
    cfg = [];
    EEG = EEG_for_layouts('Network');
    cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/eeg_64_NM20884N.lay';
    lay                       = ft_prepare_layout(cfg,GDAVG{1});
    lay.label               = EEG;
    
    cfg                          = [];
    myneighbourdist      = 0.17;
    cfg.method              = 'distance';
    cfg.channel              = EEG;
    cfg.layout                 = lay;
    cfg.minnbchan          = 2;
    cfg.neighbourdist      = myneighbourdist;
    cfg.feedback            = 'no';
    neighbours            = ft_prepare_neighbours(cfg, GDAVG{1});
    
    % to complete
end

[Grads1,Grads2,Mags]   = grads_for_layouts('Network');
% data1.label = Mags';
% data2.label = Mags';

% prepare layout
cfg                           = [];
if strcmp(chantype,'EEG') == 0
    cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/fieldtrip-20130901/template/layout/NM306mag.lay';
else
    cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/eeg_64_NM20884N.lay';
end
lay                           = ft_prepare_layout(cfg,data1);
lay.label                     = data1.label;

% test based on fieldtrip tutorial
cfg = [];
cfg.channel               = 'all';
cfg.latency                = 'all';
cfg.frequency            = 'all';
cfg.method               = 'montecarlo';
cfg.statistic               = 'depsamplesT';
cfg.correctm             = 'cluster';
cfg.clusteralpha         = 0.05;
cfg.clusterstatistic       = 'maxsum';
cfg.minnbchan           = 2;
cfg.tail                       = 0;
cfg.clustertail              = 0;
cfg.alpha                    = 0.025;
cfg.numrandomization = 1000;
cfg.neighbours       = neighbours;

ntrialdim1 = size(data1.individual,1);
ntrialdim2 = size(data2.individual,1);
ntrialdim3 = size(data2.individual,1);

design1 = [1:ntrialdim1 1:ntrialdim1];

design2 = zeros(1,ntrialdim1 + ntrialdim2);
design2(1,1:ntrialdim1) = 1;
design2(1,(ntrialdim1+1):(ntrialdim1 + ntrialdim2))= 2;

cfg.design           = [design1; design2];
cfg.uvar  = 1;
cfg.ivar  = 2;

[stat] = ft_timelockstatistics(cfg,data1,data2);

%% compure 3 significance masks
posmask007 = [];
posmask005 = [];
posmask0005 = [];
if isfield(stat,'posclusterslabelmat') == 1;
    storesigposclust007 = [];
    storesigposclust005 = [];
    storesigposclust0005 = [];
    posmask007 = zeros(size(stat.posclusterslabelmat,1),size(stat.posclusterslabelmat,2));
    posmask005 = zeros(size(stat.posclusterslabelmat,1),size(stat.posclusterslabelmat,2));
    posmask0005 = zeros(size(stat.posclusterslabelmat,1),size(stat.posclusterslabelmat,2));
    for i = 1:length(stat.posclusters)
        if (stat.posclusters(1,i).prob <= 0.07) && (stat.posclusters(1,i).prob > 0.05) 
            storesigposclust = [storesigposclust007 i];
            posmask007          = posmask007 + (stat.posclusterslabelmat == i);
        elseif (stat.posclusters(1,i).prob <= 0.05) && (stat.posclusters(1,i).prob > 0.005) 
            storesigposclust = [storesigposclust005 i];
            posmask005          = posmask005 + (stat.posclusterslabelmat == i);
        elseif (stat.posclusters(1,i).prob <= 0.005)
            storesigposclust = [storesigposclust0005 i];
            posmask0005          = posmask0005 + (stat.posclusterslabelmat == i);
        end
    end
end
negmask007 = [];
negmask005 = [];
negmask0005 = [];
if isfield(stat,'negclusterslabelmat') == 1;
    storesignegclust007 = [];
    storesignegclust005 = [];
    storesignegclust0005 = [];
    negmask007 = zeros(size(stat.negclusterslabelmat,1),size(stat.negclusterslabelmat,2));
    negmask005 = zeros(size(stat.negclusterslabelmat,1),size(stat.negclusterslabelmat,2));
    negmask0005 = zeros(size(stat.negclusterslabelmat,1),size(stat.negclusterslabelmat,2));
    for i = 1:length(stat.negclusters)
        if (stat.negclusters(1,i).prob <= 0.07) && (stat.negclusters(1,i).prob > 0.05) 
            storesignegclust = [storesignegclust007 i];
            negmask007          = negmask007 + (stat.negclusterslabelmat == i);
        elseif (stat.negclusters(1,i).prob <= 0.05) && (stat.negclusters(1,i).prob > 0.005) 
            storesignegclust = [storesignegclust005 i];
            negmask005          = negmask005 + (stat.negclusterslabelmat == i);
        elseif (stat.negclusters(1,i).prob <= 0.005)
            storesignegclust = [storesignegclust0005 i];
            negmask0005          = negmask0005 + (stat.negclusterslabelmat == i);
        end
    end
end

if isempty(posmask007) == 0 && isempty(negmask007) == 0
    Mask007 = negmask007 + posmask007;
elseif isempty(posmask007) == 0 && isempty(negmask007) == 1
    Mask007 = posmask007;
elseif isempty(posmask007) == 1 && isempty(negmask007) == 0
    Mask007 = negmask007 ;
elseif isempty(posmask007) == 1 && isempty(negmask007) == 1
    Mask007 = zeros(size(stat.stat,1),size(stat.stat,2));
end

if isempty(posmask0005) == 0 && isempty(negmask0005) == 0
    Mask0005 = negmask0005 + posmask0005;
elseif isempty(posmask0005) == 0 && isempty(negmask0005) == 1
    Mask0005 = posmask0005;
elseif isempty(posmask0005) == 1 && isempty(negmask0005) == 0
    Mask0005 = negmask0005 ;
elseif isempty(posmask0005) == 1 && isempty(negmask0005) == 1
    Mask0005 = zeros(size(stat.stat,1),size(stat.stat,2));
end

if isempty(posmask005) == 0 && isempty(negmask005) == 0
    Mask005 = negmask005 + posmask005;
elseif isempty(posmask005) == 0 && isempty(negmask005) == 1
    Mask005 = posmask005;
elseif isempty(posmask005) == 1 && isempty(negmask005) == 0
    Mask005 = negmask005 ;
elseif isempty(posmask005) == 1 && isempty(negmask005) == 1
    Mask005 = zeros(size(stat.stat,1),size(stat.stat,2));
end

Mask = Mask005+ Mask0005; % only sign masks, marginal mask is for plot

fig = figure('position',[1 1 1000 1000]);
set(fig,'PaperPosition',[1 1 1000 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

% listtopo = [25:72];
% subplot(9,8,[1 2 3 4 5 6 7 8 9 10 11 12])
% lim = [-max(max(stat.stat)) max(max(stat.stat))];
% mask = (Mask ~= 0);
% imagesc(stat.stat.*(mask),lim)
% xlabel('Time samples'); ylabel('channels');
% 
% titlec = 'T-values masked for p<0.05: ';
% for i = 1:length(condnames)
%     titlec = [titlec condnames{i} '-'];
% end
% titlec(end) = [];
% title(titlec)
% 
% sample = (stat.time(end) - stat.time(1))./length(stat.time);
% n = round(0.1/sample);
% nfull = floor(length(stat.time)/n);
% set(gca,'xtick',1:n:nfull*n,'xticklabel',stat.time(1:n:nfull*n))
% colorbar

% marginal mask
listtopo = [25:72];
subplot(9,8,[1 2 3 4 9 10 11 12])
lim = [-max(max(stat.stat)) max(max(stat.stat))];
mask = (Mask007 ~= 0);
imagesc(stat.stat.*(mask),lim)
xlabel('Time samples'); ylabel('channels');

titlec = 'T-values masked for 0.05<p<0.07: ';
for i = 1:length(condnames)
    titlec = [titlec condnames{i} '-'];
end
titlec(end) = [];
title(titlec)

sample = (stat.time(end) - stat.time(1))./length(stat.time);
n = round(0.1/sample);
nfull = floor(length(stat.time)/n);
set(gca,'xtick',1:n:nfull*n,'xticklabel',stat.time(1:n:nfull*n))

listtopo = [25:72];
subplot(9,8,[ 5 6 7 8 13 14 15 16])
lim = [-max(max(stat.stat)) max(max(stat.stat))];
mask = (Mask ~= 0);
imagesc(stat.stat.*(mask),lim)
xlabel('Time samples'); ylabel('channels');

titlec = 'T-values masked for p<0.05: ';
for i = 1:length(condnames)
    titlec = [titlec condnames{i} '-'];
end
titlec(end) = [];
title(titlec)

sample = (stat.time(end) - stat.time(1))./length(stat.time);
n = round(0.1/sample);
nfull = floor(length(stat.time)/n);
set(gca,'xtick',1:n:nfull*n,'xticklabel',stat.time(1:n:nfull*n))
colorbar

for j = 1:(min(nfull+1,30))
    mysubplot(9,8,listtopo(j))
    chansel = Mask(:,1+n*(j-1));
    if sum(chansel) == 0 
        cfg                          = [];
        cfg.layout                 = lay;
        cfg.xlim                   = [stat.time(1+n*(j-1)) stat.time(1+n*(j-1))];
        cfg.zlim                   = lim;
        cfg.style                   = 'straight';
        cfg.parameter          = 'stat';
        cfg.marker               = 'off';
        cfg.comment            = [num2str(stat.time(1+n*(j-1))) ' ms'];
        ft_topoplotER(cfg,stat);
    else
        [x,y] = find(chansel ~= 0);
        cfg                           = [];
        cfg.highlight              = 'on';
        cfg.highlightchannel   = x;
        cfg.highlightsymbol    = '.';
        cfg.layout                  = lay;
        cfg.xlim                     = [stat.time(1+n*(j-1)) stat.time(1+n*(j-1))];
        cfg.zlim                     = lim;
        cfg.style                     = 'straight';
        cfg.parameter            = 'stat';
        cfg.marker                 = 'off';
        cfg.comment              = [num2str(stat.time(1+n*(j-1))) ' ms'];
        ft_topoplotER(cfg,stat);
    end
end
jloop1 = j;

clust = {[57 58 65 66];[59 60 67 68];[61 62 69 70];[63 64 71 72]};
count = 1;
if isfield(stat,'posclusters') == 1
    if isempty(stat.posclusters) == 0
        for k = 1:length(stat.posclusters)
            if stat.posclusters(1,k).prob < 0.07
                subplot(9,8,clust{count});
                linmask = [];
                linmask = (sum((stat.posclusterslabelmat == k)') ~= 0);
                cfg                          = [];
                cfg.ylim                   = [mean([min(min(GDAVG{1}.avg)) min(min(GDAVG{2}.avg))])*1 ...
                    mean([max(max(GDAVG{1}.avg)) mean(max(max(GDAVG{2}.avg)))*1])];
                cfg.linewidth            = 3;
                cfg.channel              = stat.label(linmask);
                ft_singleplotER(cfg,GDAVG{1},GDAVG{2});
                title(['poscluster' num2str(count)]); xlabel([' p= ' num2str(stat.posclusters(1,k).prob)]);
                legend(condnames)
                count = count + 1;
            end
        end
    end
end

if isfield(stat,'negclusters') == 1
    if isempty(stat.negclusters) == 0
        for k = 1:length(stat.negclusters)
            if stat.negclusters(1,k).prob < 0.07
                if count <=4 % to fix
                    subplot(9,8,clust{count});
                    linmask = [];
                    linmask = (sum((stat.negclusterslabelmat == k)') ~= 0);
                    cfg                          = [];
                    cfg.ylim                   = [mean([min(min(GDAVG{1}.avg)) min(min(GDAVG{2}.avg))])*1 ...
                        mean([max(max(GDAVG{1}.avg)) mean(max(max(GDAVG{2}.avg)))*1])];
                    cfg.linewidth            = 3;
                    cfg.channel              = stat.label(linmask);
                    ft_singleplotER(cfg,GDAVG{1},GDAVG{2});
                    legend(condnames)
                    title(['negcluster' num2str(count)]); xlabel([' p= ' num2str(stat.negclusters(1,k).prob)]);
                    count = count + 1;
                end
            end
        end
    end
end

% GDAVGt_diff{1,1}.individual = GDAVGt{1,1}.individual  - GDAVGt{1,2}.individual;
%  [FIND,BIND,VIND,LIND,RIND,FCHANS,BCHANS,VCHANS,LCHANS,RCHANS] = clusteranat('Network');
% cmap                   = colormap('jet');
% colplot                 = cmap(1:3:17*3,:);
%  
% if isfield(stat,'posclusters') == 1
%     if isempty(stat.posclusters) == 0
%         for k = 1:length(stat.posclusters)
%             if stat.posclusters(1,k).prob < 0.07
%                x = find(mean((stat.posclusterslabelmat == k),2) ~= 0);
%   
%                figure
%                for i = 1:size(GDAVGt{1,1}.individual,1)
%                    mysubplot(5,4,i)
%                
%                    plot(GDAVGt{1,1}.time,squeeze(mean(GDAVGt{1,1}.individual(i,x,:),2)),'linewidth',2,'color','k');
%                    hold on
%                    plot(GDAVGt{1,2}.time,squeeze(mean(GDAVGt{1,2}.individual(i,x,:),2)),'linewidth',2,'color','k','linestyle','-.');
%                    hold on
%                    plot(GDAVGt{1,1}.time,squeeze(mean(GDAVGt_diff{1,1}.individual(i,x,:),2)),'linewidth',2,'color',colplot(i,:));
%                    hold on
%                    line([-0.1 0.9],[0 0 ],'linewidth',3,'color','k')
%                    axis([-0.1 0.9 -1e-13 1e-13])
%                end
%             end
%         end
%     end
% end









