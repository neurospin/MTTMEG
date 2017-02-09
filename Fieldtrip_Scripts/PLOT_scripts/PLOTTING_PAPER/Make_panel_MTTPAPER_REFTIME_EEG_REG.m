addpath('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/PLOTTING_PAPER')

%% data shaping: load cluster 1 and average data across subjects
condnames    = {'RefPast';'RefPre';'RefFut'};
condnames_clust   = {'RefPast';'RefPre';'RefFut'};
latency      = [1.1 2];
graphcolor   = [[1 0.7 0.7];[0 0 0];[1 0 0]];
stat_test    = 'Reg';
chansel      = 'Mags';
clustnum     = 0;
clusttype    = 'negclust';
timetag      = '201651018728';

[ch, cdn, cdn_clust, stat, GDAVG, GDAVGt] = prepare_comp(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Prepare plotting layout
[Grads1,Grads2,Mags]   = grads_for_layouts('Network');

% prepare layout
cfg                           = [];
if strcmp(chansel,'EEG') == 0
    cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/fieldtrip-20130901/template/layout/NM306mag.lay';
else
    cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/eeg_64_NM20884N.lay';
end
lay                        = ft_prepare_layout(cfg,GDAVGt{1});
lay.label                = GDAVGt{1}.label;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% get a representative spatial filter for the cluster
times = sum(stat.prob <= 0.05);
plot(stat.time,times)
[x,y] = findpeaks(times);
% 
% fig = figure('position',[1 1 1500 1000]);
% set(fig,'PaperPosition',[1 1 1500 1000])
% set(fig,'PaperPositionmode','auto')
% set(fig,'Visible','on')
% count = 1;
% for index = y
%     subplot (5,5,count)
%     cfg                    = [];
%     cfg.layout             = lay;
%     cfg.xlim               = [stat.time(index) stat.time(index)];
%     cfg.zlim               = [-4 4]; % T-values
%     cmap                   = colormap('parula')
%     cfg.colormap           = cmap
%     cfg.style              = 'straight';
%     cfg.parameter          = 'stat';
%     cfg.marker             = 'off';
%     cfg.highlight          = 'on';
%     indchan = []; indchan = find(stat.prob(:,index) <0.05);
%     cfg.highlightchannel   = stat.label(indchan);
%     cfg.highlightsymbol    = '.';
%     cfg.highlightsize      = 20;
%     cfg.comment            = num2str(stat.time(index));
%     ft_topoplotER(cfg,stat);
%     count = count +1;
% end
% subplot (3,3,count)
% cfg.colorbar = 'east';
% ft_topoplotER(cfg,stat);

% ==> select y(19) as representative topo
% ==> selectct y(5) as rep topo
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% cluster 1 for common chans
alpha = 0.05
indchan1 = []; indchan1 = find(stat.prob(:,y(19)) <alpha);
indchan2 = []; indchan2 = find(stat.prob(:,y(5)) <alpha);

%% data shaping: load cluster 2 and average data across subjects
condnames    = {'RefPast';'RefPre';'RefFut'};
condnames_clust = {'RefPast';'RefPre';'RefFut'};
latency      = [0.3 1.1];
graphcolor   = [[1 0.7 0.7];[0 0 0];[1 0 0]];
stat_test    = 'Reg';
chansel      = 'Mags';
clustnum     = 0;
clusttype    = 'negclust';
timetag      = '201651018538';

[ch, cdn, cdn_clust, stat, GDAVG, GDAVGt] = prepare_comp(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% get a representative spatial filter for the cluster
times = sum(stat.prob <= 0.05);
plot(stat.time,times)
[x,y] = findpeaks(times);

% fig = figure('position',[1 1 1500 1000]);
% set(fig,'PaperPosition',[1 1 1500 1000])
% set(fig,'PaperPositionmode','auto')
% set(fig,'Visible','on')
% count = 1;
% for index = y
%     subplot (5,5,count)
%     cfg                    = [];
%     cfg.layout             = lay;
%     cfg.xlim               = [stat.time(index) stat.time(index)];
%     cfg.zlim               = [-10 10]; % F-values
%     cfg.colormap           = 'jet';
%     cfg.style              = 'straight';
%     cfg.parameter          = 'stat';
%     cfg.marker             = 'off';
%     cfg.highlight          = 'on';
%     indchan = []; indchan = find(stat.prob(:,index) <0.05);
%     cfg.highlightchannel   = stat.label(indchan);
%     cfg.highlightsymbol    = '.';
%     cfg.highlightsize      = 20;
%     cfg.comment            = num2str(stat.time(index));
%     ft_topoplotER(cfg,stat);
%     count = count +1;
% end
% subplot (3,3,count)
% cfg.colorbar = 'east';
% ft_topoplotER(cfg,stat);

% y(15) ==> rep
% y(10) ==> rep
% y(5) ==> rep
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% cluster 1 for common chans
alpha = 0.05
indchan3 = []; indchan3 = find(stat.prob(:,y(10)) <alpha);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% common chans
indchan = []
indchancommon = intersect(intersect(indchan1,indchan2),indchan3)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% data shaping: load cluster 1 and average data across subjects
condnames    = {'RefPast';'RefPre';'RefFut'};
condnames_clust   = {'RefPast';'RefPre';'RefFut'};
latency      = [1.1 2];
graphcolor   = [[1 0.7 0.7];[0 0 0];[1 0 0]];
stat_test    = 'Reg';
chansel      = 'Mags';
clustnum     = 0;
clusttype    = 'negclust';
timetag      = '201651018728';

[ch, cdn, cdn_clust, stat, GDAVG, GDAVGt] = prepare_comp(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
times = sum(stat.prob <= 0.05);
plot(stat.time,times)
[x,y] = findpeaks(times);

fig = figure('position',[1 1 300 300]);
set(fig,'PaperPosition',[1 1 300 300])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

count = 1;
for index = y(5)
    
    cmap                   = colormap('jet');
    cfg                    = [];
    cfg.layout             = lay;
    cfg.xlim               = [stat.time(index) stat.time(index)];
    cfg.zlim               = [-5 5]; % F-values
    cfg.style              = 'straight';
    cmap                   = colormap('gray')          
    cfg.colormap           = cmap;
    cfg.parameter          = 'stat';
    cfg.marker             = 'off';
    cfg.highlight          = 'on';
    indchan = []; indchan = find(stat.prob(:,index) <0.05);
    cfg.highlight          = {'on','on'};
    cfg.highlightchannel   = {stat.label(indchan),stat.label(indchancommon)};
    cfg.highlightsymbol    = {'.','.'};
    cfg.highlightsize      = {30,30} ;
    cfg.highlightcolor     = {'k','w'};
    cfg.comment            = num2str(stat.time(index));
    ft_topoplotER(cfg,stat);
    count = count + 1;
end

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/MISC_PLOTS/RefRegTime_Mags')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
times = sum(stat.prob <= 0.05);
plot(stat.time,times)
[x,y] = findpeaks(times);

fig = figure('position',[1 1 300 300]);
set(fig,'PaperPosition',[1 1 300 300])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

count = 1;
for index = y(19)
    
    cmap                   = colormap('jet');
    cfg                    = [];
    cfg.layout             = lay;
    cfg.xlim               = [stat.time(index) stat.time(index)];
    cfg.zlim               = [-5 5]; % F-values
    cfg.style              = 'straight';
    cmap                   = colormap('gray')          
    cfg.colormap           = cmap;
    cfg.parameter          = 'stat';
    cfg.marker             = 'off';
    cfg.highlight          = 'on';
    indchan = []; indchan = find(stat.prob(:,index) <0.05);
    cfg.highlight          = {'on','on'};
    cfg.highlightchannel   = {stat.label(indchan),stat.label(indchancommon)};
    cfg.highlightsymbol    = {'.','.'};
    cfg.highlightsize      = {30,30} ;
    cfg.highlightcolor     = {'k','w'};
    cfg.comment            = num2str(stat.time(index));
    ft_topoplotER(cfg,stat);
    count = count + 1;
end

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/MISC_PLOTS/RefRegTime_Mags2')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% data shaping: load cluster 2 and average data across subjects
condnames    = {'RefPast';'RefPre';'RefFut'};
condnames_clust   = {'RefPast';'RefPre';'RefFut'};
latency      = [0.3 1.1];
graphcolor   = [[1 0.7 0.7];[0 0 0];[1 0 0]];
stat_test    = 'Reg';
chansel      = 'Mags';
clustnum     = 0;
clusttype    = 'negclust';
timetag      = '201651018538';

[ch, cdn, cdn_clust, stat, GDAVG, GDAVGt] = prepare_comp(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
times = sum(stat.prob <= 0.05);
plot(stat.time,times)
[x,y] = findpeaks(times);

fig = figure('position',[1 1 300 300]);
set(fig,'PaperPosition',[1 1 300 300])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

count = 1;
for index = y(10)
    
    cmap                   = colormap('jet');
    cfg                    = [];
    cfg.layout             = lay;
    cfg.xlim               = [stat.time(index) stat.time(index)];
    cfg.zlim               = [-5 5]; % F-values
    cfg.style              = 'straight';
    cmap                   = colormap('gray')          
    cfg.colormap           = cmap;
    cfg.parameter          = 'stat';
    cfg.marker             = 'off';
    cfg.highlight          = 'on';
    indchan = []; indchan = find(stat.prob(:,index) <0.05);
    cfg.highlight          = {'on','on'};
    cfg.highlightchannel   = {stat.label(indchan),stat.label(indchancommon)};
    cfg.highlightsymbol    = {'.','.'};
    cfg.highlightsize      = {30,30} ;
    cfg.highlightcolor     = {'k','w'};
    cfg.comment            = num2str(stat.time(index));
    ft_topoplotER(cfg,stat);
    count = count + 1;
end

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/MISC_PLOTS/RefRegTime_Mags3')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
times = sum(stat.prob <= 0.05);
plot(stat.time,times)
[x,y] = findpeaks(times);

fig = figure('position',[1 1 300 300]);
set(fig,'PaperPosition',[1 1 300 300])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

count = 1;
for index = y
    
    cmap                   = colormap('jet');
    cfg                    = [];
    cfg.layout             = lay;
    cfg.xlim               = [stat.time(index) stat.time(index)];
    cfg.zlim               = [-5 5]; % F-values
    cfg.style              = 'straight';     
    cfg.colormap           = cmap;
    cfg.parameter          = 'stat';
    cfg.marker             = 'off';
    cfg.highlight          = 'on';
    indchan = []; indchan = find(stat.prob(:,index) <0.05);
    cfg.highlight          = {'on','on'};
%     cfg.highlightchannel   = {stat.label(indchan),stat.label(indchancommon)};
    cfg.highlightsymbol    = {'.','.'};
    cfg.highlightsize      = {30,30} ;
    cfg.highlightcolor     = {'k','w'};
    cfg.comment            = num2str(stat.time(index));
    ft_topoplotER(cfg,stat);
    count = count + 1;
end

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/MISC_PLOTS/RefRegTime_Mags4')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% data shaping: load cluster 2 and average data across subjects
condnames    = {'RefPast';'RefPre';'RefFut'};
condnames_clust   = {'RefPast';'RefPre';'RefFut'};
latency      = [0.3 1.1];
graphcolor   = [[1 0.7 0.7];[0 0 0];[1 0 0]];
stat_test    = 'Reg';
chansel      = 'Mags';
clustnum     = 0;
clusttype    = 'negclust';
timetag      = '201651018538';

[ch, cdn, cdn_clust, stat1, GDAVG, GDAVGt] = prepare_comp(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)
clust1  = find(sum(stat1.prob <= 0.05) > 0);

%% data shaping: load cluster 1 and average data across subjects
condnames    = {'RefPast';'RefPre';'RefFut'};
condnames_clust   = {'RefPast';'RefPre';'RefFut'};
latency      = [1.1 2];
graphcolor   = [[1 0.7 0.7];[0 0 0];[1 0 0]];
stat_test    = 'Reg';
chansel      = 'Mags';
clustnum     = 0;
clusttype    = 'negclust';
timetag      = '201651018728';

[ch, cdn, cdn_clust, stat2, GDAVG, GDAVGt] = prepare_comp(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)
clust2  = find(sum(stat2.prob <= 0.05) > 0);

%% timecourse on common sensors
fig = figure('position',[1 1 1600 1100]);
set(fig,'PaperPosition',[1 1 1600 1100])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
subplot(2,1,1)

% determine figure size base on amplitude on avg cluster activity
clust  = find(sum(stat.prob <= alpha) > 0);
indchan = indchancommon
valmax = max([max(mean(GDAVG{1}.avg(indchan,:))) ...
         max(mean(GDAVG{2}.avg(indchan,:))) ...
         max(mean(GDAVG{3}.avg(indchan,:)))]);
valmin = min([min(mean(GDAVG{1}.avg(indchan,:))) ...
         min(mean(GDAVG{2}.avg(indchan,:))) ...
         min(mean(GDAVG{3}.avg(indchan,:)))]);
% fmult
fmult = 1e14; % for express in uV
% cluster shade
plot_clustshade(clust1,0.05, stat1,-5,5,[0.8 0.8 0.8])
plot_clustshade(clust2,0.05, stat2,-5,5,[0.8 0.8 0.8])

% stimulus onsets
line([0 0]    ,[-5 5],'linestyle',':','linewidth',3,'color','k'); hold on
line([1.1 1.1],[-5 5],'linestyle',':','linewidth',3,'color','k'); hold on
line([2.2 2.2],[-5 5],'linestyle',':','linewidth',3,'color','k'); hold on
line([3.4 3.4],[-5 5],'linestyle',':','linewidth',3,'color','k'); hold on

% define axes limit and plot properties
set_axes(-0.7, 5, -5,5)

% timecourse
plot(GDAVG{1}.time,mean(GDAVG{1}.avg(indchan,:)*fmult),'linewidth',4,'color',graphcolor(1,:));hold on
plot(GDAVG{1}.time,mean(GDAVG{2}.avg(indchan,:)*fmult),'linewidth',4,'color',graphcolor(2,:));hold on
plot(GDAVG{1}.time,mean(GDAVG{3}.avg(indchan,:)*fmult),'linewidth',4,'color',graphcolor(3,:));hold on

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/MISC_PLOTS/RefRegTime_Mags_timecourse')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% avg barplot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 300 300]);
set(fig,'PaperPosition',[1 1 300 300])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

data = barplotval(GDAVGt,alpha,stat,index,graphcolor,[0.3 3.7 -2 2],fmult);
print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/MISC_PLOTS/eeg_plot_barplot')

anova1(data)

