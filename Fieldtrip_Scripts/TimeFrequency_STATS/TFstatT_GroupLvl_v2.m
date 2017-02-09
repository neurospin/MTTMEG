function [fig1,fig2] = TFstatT_GroupLvl_v2(condnames,GDAVG,data1,data2,foi)

[Grads1,Grads2,Mags] = grads_for_layouts('Network');

if strcmp(data1.label{1,1},'MEG0111') == 1
    chantype = 'Mags';
    
        load('/neurospin/meg/meg_tmp/tools_tmp/Pipeline/pipeline/neuromag306mag_neighb.mat')
    
%     cfg                          = [];
%     cfg.layout                = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/fieldtrip-20130901/template/layout/NM306mag.lay';
%     lay                          = ft_prepare_layout(cfg,GDAVG{1});
%     lay.label                  = Mags;
%     myneighbourdist      = 0.15;
%     cfg.method              = 'distance';
%     cfg.channel              = Mags;
%     cfg.layout                 = lay;
%     cfg.minnbchan          = 2;
%     cfg.neighbourdist      = myneighbourdist;
%     cfg.feedback            = 'no';
%     neighbours               = ft_prepare_neighbours(cfg, GDAVG{1});
    
elseif strcmp(data1.label{1,1},'MEG0113') == 1 
    chantype = 'Grads1';
        load('/neurospin/meg/meg_tmp/tools_tmp/Pipeline/pipeline/neuromag306planar_neighb.mat')
    
%     cfg                          = [];
%     cfg.layout                = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/fieldtrip-20130901/template/layout/NM306mag.lay';
%     lay                          = ft_prepare_layout(cfg,GDAVG{1});
%     lay.label                  = Mags;
%     myneighbourdist      = 0.15;
%     cfg.method              = 'distance';
%     cfg.channel              = Grads1;
%     cfg.layout                 = lay;
%     cfg.minnbchan          = 2;
%     cfg.neighbourdist      = myneighbourdist;
%     cfg.feedback            = 'no';
%     neighbours               = ft_prepare_neighbours(cfg, GDAVG{1});
  
    elseif strcmp(data1.label{1,1},'MEG0112') == 1 
    chantype = 'Grads2';
        load('/neurospin/meg/meg_tmp/tools_tmp/Pipeline/pipeline/neuromag306planar_neighb.mat')
    
%     cfg                          = [];
%     cfg.layout                = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/fieldtrip-20130901/template/layout/NM306mag.lay';
%     lay                          = ft_prepare_layout(cfg,GDAVG{1});
%     lay.label                  = Mags;
%     myneighbourdist      = 0.15;
%     cfg.method              = 'distance';
%     cfg.channel              = Grads2;
%     cfg.layout                 = lay;
%     cfg.minnbchan          = 2;
%     cfg.neighbourdist      = myneighbourdist;
%     cfg.feedback            = 'no';
%     neighbours               = ft_prepare_neighbours(cfg, GDAVG{1});
    
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
cfg                      = [];
if strcmp(chantype,'EEG') == 0
    cfg.layout           = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/fieldtrip-20130901/template/layout/NM306mag.lay';
else
    cfg.layout           = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/eeg_64_NM20884N.lay';
end
lay                             = ft_prepare_layout(cfg,data1);
lay.label                     = data1.label;

cfg = [];
cfg.foilim = foi;
cfg.keeptrials    = 'yes';
dat1 = ft_freqdescriptives(cfg,data1);
dat2 = ft_freqdescriptives(cfg,data2);

% test based on fieldtrip tutorial
cfg                             = [];
cfg.channel                 = 'all';
cfg.latency                  = 'all';
cfg.frequency              = foi;
% cfg.avgoverfreq          = 'yes';
cfg.parameter             = 'powspctrm';
cfg.method                 = 'montecarlo';
cfg.statistic                 = 'depsamplesT';
cfg.correctm               = 'cluster';
cfg.clusteralpha          = 0.05;
cfg.clusterstatistic       = 'maxsum';
cfg.minnbchan            = 2;
cfg.tail                        = 0;
cfg.clustertail               = 0;
cfg.alpha                     = 0.025;
cfg.numrandomization  = 500;
cfg.neighbours             = neighbours;

ntrialdim1  = size(data1.powspctrm,1);
ntrialdim2  = size(data2.powspctrm,1);

design1 = [1:ntrialdim1 1:ntrialdim1];

design2 = zeros(1,ntrialdim1 + ntrialdim2);
design2(1,1:ntrialdim1) = 1;
design2(1,(ntrialdim1+1):(ntrialdim1 + ntrialdim2))= 2;

cfg.design           = [design1; design2];
cfg.uvar  = 1;
cfg.ivar   = 2;

dat1.freq = round(dat1.freq); % "bug" correction to check further
dat2.freq = round(dat1.freq); % "bug" correction to check further

[stat] = ft_freqstatistics(cfg,dat1,dat2);

cfg = [];
cfg.foilim = foi;
diff1 = ft_freqdescriptives(cfg,dat1);
diff2 = ft_freqdescriptives(cfg,dat2);
diff = diff1;
diff.powspctrm = diff1.powspctrm - diff2.powspctrm;

%% compure 3 significance masks
posmask007 = [];
posmask005 = [];
posmask0005 = [];
if isfield(stat,'posclusterslabelmat') == 1;
    storesigposclust007 = [];
    storesigposclust005 = [];
    storesigposclust0005 = [];
    posmask007 = zeros(size(stat.posclusterslabelmat,1),size(stat.posclusterslabelmat,3));
    posmask005 = zeros(size(stat.posclusterslabelmat,1),size(stat.posclusterslabelmat,3));
    posmask0005 = zeros(size(stat.posclusterslabelmat,1),size(stat.posclusterslabelmat,3));
    for i = 1:length(stat.posclusters)
        if (stat.posclusters(1,i).prob <= 0.07) && (stat.posclusters(1,i).prob > 0.05)
            storesigposclust = [storesigposclust007 i];
            posmask007          = posmask007 + ((squeeze(sum(stat.posclusterslabelmat == i,2)))>= 1);
        elseif (stat.posclusters(1,i).prob <= 0.05) && (stat.posclusters(1,i).prob > 0.005)
            storesigposclust = [storesigposclust005 i];
            posmask005          = posmask005 + ((squeeze(sum(stat.posclusterslabelmat == i,2)))>= 1);
        elseif (stat.posclusters(1,i).prob <= 0.005)
            storesigposclust = [storesigposclust0005 i];
            posmask0005          = posmask0005 + ((squeeze(sum(stat.posclusterslabelmat == i,2)))>= 1);
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
    negmask007 = zeros(size(stat.negclusterslabelmat,1),size(stat.negclusterslabelmat,3));
    negmask005 = zeros(size(stat.negclusterslabelmat,1),size(stat.negclusterslabelmat,3));
    negmask0005 = zeros(size(stat.negclusterslabelmat,1),size(stat.negclusterslabelmat,3));
    for i = 1:length(stat.negclusters)
        if (stat.negclusters(1,i).prob <= 0.07) && (stat.negclusters(1,i).prob > 0.05)
            storesignegclust = [storesignegclust007 i];
            negmask007          = negmask007 + ((squeeze(sum(stat.negclusterslabelmat == i,2)))>= 1);
        elseif (stat.negclusters(1,i).prob <= 0.05) && (stat.negclusters(1,i).prob > 0.005)
            storesignegclust = [storesignegclust005 i];
            negmask005          = negmask005 + ((squeeze(sum(stat.negclusterslabelmat == i,2)))>= 1);
        elseif (stat.negclusters(1,i).prob <= 0.005)
            storesignegclust = [storesignegclust0005 i];
            negmask0005          = negmask0005 + ((squeeze(sum(stat.negclusterslabelmat == i,2)))>=1);
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

fig1 = figure('position',[1 1 1000 1000]);
set(fig1,'PaperPosition',[1 1 1000 1000])
set(fig1,'PaperPositionmode','auto')
set(fig1,'Visible','on')

% marginal mask
listtopo = [25:72];
subplot(9,8,[1 2 3 4 9 10 11 12])
limmax = [-max(max(squeeze(nanmean(diff.powspctrm,2)))) max(max((squeeze(nanmean(diff.powspctrm,2)))))];
limmin  = [min(min(squeeze(nanmean(diff.powspctrm,2)))) -min(min((squeeze(nanmean(diff.powspctrm,2)))))];
lim(1)   = min([limmax(1) limmin(1)]);
lim(2)   = max([limmax(2) limmin(2)]);
mask = (Mask007 ~= 0);
imagesc(squeeze(mean(diff.powspctrm,2)).*(mask),lim)
xlabel('Time samples'); ylabel('channels');

titlec = 'power difference masked for 0.05<p<0.07: ';
for i = 1:length(condnames)
    titlec = [titlec condnames{i} '-'];
end
titlec(end) = [];
title(titlec)

sample = (stat.time(end) - stat.time(1))./length(stat.time);
n = round(0.1/sample);
nfull = floor(length(stat.time)/n);
set(gca,'xtick',1:n:nfull*n,'xticklabel',stat.time(1:n:nfull*n))

listtopo = [25:57];
subplot(9,8,[ 5 6 7 8 13 14 15 16])
limmax = [-max(max(squeeze(nanmean(diff.powspctrm,2)))) max(max((squeeze(nanmean(diff.powspctrm,2)))))];
limmin  = [min(min(squeeze(nanmean(diff.powspctrm,2)))) -min(min((squeeze(nanmean(diff.powspctrm,2)))))];
lim(1)   = min([limmax(1) limmin(1)]);
lim(2)   = max([limmax(2) limmin(2)]);
mask = (Mask ~= 0);
imagesc(squeeze(mean(diff.powspctrm,2)).*(mask),lim)
xlabel('Time samples'); ylabel('channels');

titlec = 'Power difference masked for p<0.05: ';
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

for j = 2:(min(nfull+1,30)-1)
    mysubplot(9,8,listtopo(j))
    chansel = Mask(:,1+n*(j-1));
    if sum(chansel) == 0
        cfg                             = [];
        cfg.layout                   = lay;
        cfg.xlim                     = [stat.time(1+n*(j-1)) stat.time(1+n*(j))];
        cfg.zlim                     = lim;
        cfg.style                     = 'straight';
        cfg.parameter            = 'powspctrm';
        cfg.marker                 = 'off';
        cfg.comment              = [num2str(stat.time(1+n*(j-1))) ' ms'];
        ft_topoplotTFR(cfg,diff);
    else
        [x,y] = find(chansel ~= 0);
        cfg                          = [];
        cfg.highlight               = 'on';
        cfg.highlightchannel    = diff.label(x);
        cfg.highlightsymbol     = '.';
        cfg.layout                   = lay;
        cfg.xlim                     = [stat.time(1+n*(j-1)) stat.time(1+n*(j-1))];
        cfg.zlim                     = lim;
        cfg.style                    = 'straight';
        cfg.parameter                = 'powspctrm';
        cfg.marker                   = 'off';
        cfg.comment                  = [num2str(stat.time(1+n*(j-1))) ' ms'];
        ft_topoplotTFR(cfg,diff);
    end
end

fig2 = figure('position',[1 1 1000 1000]);
set(fig2,'PaperPosition',[1 1 1000 1000])
set(fig2,'PaperPositionmode','auto')
set(fig2,'Visible','on')

GDAVG_diff = GDAVG{1};
GDAVG_diff.powspctrm = GDAVG{1}.powspctrm - GDAVG{2}.powspctrm;

clust = {[25 26 33 34];[27 28 35 36];[29 30 37 38];[31 32 39 40];...
    [57 58 65 66];[59 60 67 68];[61 62 69 70];[63 64 71 72]};
count = 1;
if isempty(stat.posclusters) == 0
    for k = 1:length(stat.posclusters)
        if stat.posclusters(1,k).prob < 0.07
            subplot(9,8,clust{count});
            linmask = [];
            linmask = ceil(mean((squeeze(mean(stat.posclusterslabelmat(:,:,:)==k,2)))~=0,2));
            x = [];x = find(linmask == 1)
            cfg                          = [];
            cfg.linewidth            = 2;
            cfg.parameter          = 'powspctrm';
            cfg.channel              = (stat.label(find(linmask == 1)))';
            %             cfg.ylim                   =  [min([min(nanmean(nanmean(diff1.powspctrm(x,:,:),1),2)) min(nanmean(nanmean(diff2.powspctrm(x,:,:),1),2))])*0.5 ...
            %                     max([max(nanmean(nanmean(diff1.powspctrm(x,:,:),1),2)) max(nanmean(nanmean(diff2.powspctrm(x,:,:),1),2))])*0.5];
            cfg.ylim = 'maxabs';
            ft_singleplotER(cfg,diff1,diff2)
            title(['poscluster' num2str(count)]); xlabel([' p= ' num2str(stat.posclusters(1,k).prob)]);
            count = count + 1;
            %             legend(condnames)
        end
    end
end

count = 1;
if isempty(stat.negclusters) == 0
    for k = 1:length(stat.negclusters)
        if stat.negclusters(1,k).prob < 0.07
            subplot(9,8,clust{count});
            linmask = [];
            linmask = ceil(mean((squeeze(mean(stat.negclusterslabelmat(:,:,:)==k,2)))~=0,2));
            x = [];x = find(linmask == 1)
            cfg                          = [];
            cfg.linewidth            = 2;
            cfg.parameter          = 'powspctrm';
            cfg.channel              = (stat.label(find(linmask == 1)))';
            %             cfg.ylim                   =  [min([min(nanmean(nanmean(diff1.powspctrm(x,:,:),1),2)) min(nanmean(nanmean(diff2.powspctrm(x,:,:),1),2))])*0.5 ...
            %                     max([max(nanmean(nanmean(diff1.powspctrm(x,:,:),1),2)) max(nanmean(nanmean(diff2.powspctrm(x,:,:),1),2))])*0.5];
            cfg.ylim = 'maxabs';
            ft_singleplotER(cfg,diff1,diff2)
            title(['poscluster' num2str(count)]); xlabel([' p= ' num2str(stat.negclusters(1,k).prob)]);
            count = count + 1;
            %             legend(condnames)
        end
    end
end


