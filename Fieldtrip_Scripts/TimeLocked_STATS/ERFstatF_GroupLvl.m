function fig = ERFstatF_GroupLvl(condnames,GDAVG,varargin)

for i = 1:length(varargin)
    eval(['data' num2str(i) ' = varargin{1,i}']);
end

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
cfg                             = [];
cfg.channel                 = 'all';
cfg.latency                  = 'all';
cfg.frequency              = 'all';
cfg.method                 = 'montecarlo';
cfg.statistic                 = 'depsamplesF';
cfg.correctm               = 'cluster';
cfg.clusteralpha          = 0.05;
cfg.clusterstatistic       = 'maxsum';
cfg.minnbchan            = 2;
cfg.tail                       =1;
% cfg.clustertail              = 0;
cfg.alpha                    = 0.05;
cfg.numrandomization = 500;
cfg.neighbours            = neighbours;

ntrialdim     = [];
intervalcount = 0;
for i = 1:length(varargin)
    ntrialdim(i)      = size(varargin{1,i}.individual,1);
    ntrialinterval{i} = [intervalcount+1 intervalcount+ntrialdim(i)];
    intervalcount     = intervalcount+ntrialdim(i);
end
design2 = zeros(1,sum(ntrialdim));
for i = 1:length(varargin)
    design2(1,[ntrialinterval{i}(1):ntrialinterval{i}(2)]) = i;
end

design1 = [];
for i = unique(design2);
    design1 = [design1 1:length(design2)/(length(unique(design2)))];
end

cfg.design = [design1;design2];
cfg.uvar  = 1;
cfg.ivar  = 2;

instr = '[stat] = ft_timelockstatistics(cfg';
for i = 1:length(varargin)
    instr = [instr ',data' num2str(i)];
end
eval([instr ');']);

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

Mask007 = posmask007;
Mask0005 = posmask0005;
Mask005 = posmask005;

Mask = Mask005+ Mask0005; % only sign masks, marginal mask is for plot

fig = figure('position',[1 1 1000 1000]);
set(fig,'PaperPosition',[1 1 1000 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','off')

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
for k = 1:length(stat.posclusters)
    if stat.posclusters(1,k).prob < 0.07
        if count <= 4
            subplot(9,8,clust{count});
            linmask = [];
            linmask = (sum((stat.posclusterslabelmat == k)') ~= 0);
            cfg                          = [];
            cfg.ylim                   = [min(min(min(GDAVG{1}.avg)),min(min(min(GDAVG{2}.avg))))*0.8...
                max(max(max(GDAVG{1}.avg)),max(max(max(GDAVG{2}.avg))))*0.8];
            cfg.linewidth            = 2;
            cfg.channel              = stat.label(linmask);
            
            instr = 'ft_singleplotER(cfg,';
            for i =1:length(GDAVG)
                instr = [instr 'GDAVG{' num2str(i) '},'];
            end
            instr(end) = []; instr = [instr ');'];
            eval(instr);
            
            title(['poscluster' num2str(count)]); xlabel([' p= ' num2str(stat.posclusters(1,k).prob)]);
            legend(condnames)
            count = count + 1;
        end
    end
end


