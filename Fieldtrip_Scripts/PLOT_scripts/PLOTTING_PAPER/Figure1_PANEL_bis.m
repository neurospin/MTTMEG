%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%% PAST vs PRE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

addpath('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/PLOTTING_PAPER')

%% TEST INPUT 1 mags occipital
condnames_clust = {'RefPre';'RefPast'};
condnames    = {'RefPre';'RefPast'};
latency      = [0.3 1.1];
graphcolor   = [[0 0 0];[1 0.7 0.7]];
stat_test    = 'T';
chansel      = 'Mags';
clustnum     = 0;
clusttype    = 'posclust';
timetag      = '2016711143455';

[ch, cdn, cdn_clust, stat, GDAVG, GDAVGt] = prepare_comp(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

%% TEST INPUT 1 mags occipital
condnames_clust = {'RefPre';'RefFut'};
condnames    = {'RefPre';'RefFut'};
latency      = [0.3 1.1];
graphcolor   = [[0 0 0];[1 0 0]];
stat_test    = 'T';
chansel      = 'Mags';
clustnum     = 0;
clusttype    = 'negclust';
timetag      = '2016711154518';

[ch, cdn, cdn_clust, stat, GDAVG, GDAVGt] = prepare_comp(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

%% TEST INPUT 1 mags occipital
condnames_clust = {'RefPast';'RefFut'};
condnames    = {'RefPast';'RefFut'};
latency      = [0.3 1.1];
graphcolor   = [[1 0.7 0.7];[1 0 0]];
stat_test    = 'T';
chansel      = 'Mags';
clustnum     = 0;
clusttype    = 'negclust';
timetag      = '2016712104132';

[ch0, cdn0, cdn_clust0, stat0, GDAVG0, GDAVGt0] = prepare_comp(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)


%%%%%%%%%%%%%%%%%%%%%%%% prepare plotting layout %%%%%%%%%%%%%%%%%%%%%%%%%%
% select sensor datatype
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
























%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
times = sum(stat.prob <= 0.05);
plot(stat.time,times)
[x,y] = findpeaks(times);

fig = figure('position',[1 1 1500 1000]);
set(fig,'PaperPosition',[1 1 1500 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
count = 1;
for index = y
    subplot (5,5,count)
    cfg                    = [];
    cfg.layout             = lay;
    cfg.xlim               = [stat.time(index) stat.time(index)];
    cfg.zlim               = [-10 10]; % F-values
    cfg.colormap           = 'jet';
    cfg.style              = 'straight';
    cfg.parameter          = 'stat';
    cfg.marker             = 'off';
    cfg.highlight          = 'on';
    indchan = []; indchan = find(stat.prob(:,index) <0.05);
    cfg.highlightchannel   = stat.label(indchan);
    cfg.highlightsymbol    = '.';
    cfg.highlightsize      = 20;
    cfg.comment            = num2str(stat.time(index));
    ft_topoplotER(cfg,stat);
    count = count +1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
times = sum(stat2.prob <= 0.05);
plot(stat2.time,times)
[x,y] = findpeaks(times);

fig = figure('position',[1 1 1500 1000]);
set(fig,'PaperPosition',[1 1 1500 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
count = 1;
for index = y
    subplot (5,5,count)
    cfg                    = [];
    cfg.layout             = lay;
    cfg.xlim               = [stat2.time(index) stat2.time(index)];
    cfg.zlim               = [-10 10]; % F-values
    cfg.colormap           = 'jet';
    cfg.style              = 'straight';
    cfg.parameter          = 'stat';
    cfg.marker             = 'off';
    cfg.highlight          = 'on';
    indchan = []; indchan = find(stat2.prob(:,index) <0.05);
    cfg.highlightchannel   = stat2.label(indchan);
    cfg.highlightsymbol    = '.';
    cfg.highlightsize      = 20;
    cfg.comment            = num2str(stat2.time(index));
    ft_topoplotER(cfg,stat2);
    count = count +1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% select sensor datatype
[Grads1,Grads2,Mags]   = grads_for_layouts('Network');

% prepare layout
cfg                           = [];
if strcmp(chansel,'EEG') == 0
    cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/fieldtrip-20130901/template/layout/NM306mag.lay';
else
    cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/eeg_64_NM20884N.lay';
end
lay                        = ft_prepare_layout(cfg,GDAVGt3{1});
lay.label                = GDAVGt3{1}.label;

%%
times = sum(stat3.prob <= 0.05);
plot(stat3.time,times)
[x,y] = findpeaks(times);

fig = figure('position',[1 1 1500 1000]);
set(fig,'PaperPosition',[1 1 1500 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
count = 1;
for index = y
    subplot (5,5,count)
    cfg                    = [];
    cfg.layout             = lay;
    cfg.xlim               = [stat3.time(index) stat3.time(index)];
    cfg.zlim               = [-10 10]; % F-values
    cfg.colormap           = 'jet';
    cfg.style              = 'straight';
    cfg.parameter          = 'stat';
    cfg.marker             = 'off';
    cfg.highlight          = 'on';
    indchan = []; indchan = find(stat3.prob(:,index) <0.05);
    cfg.highlightchannel   = stat3.label(indchan);
    cfg.highlightsymbol    = '.';
    cfg.highlightsize      = 20;
    cfg.comment            = num2str(stat3.time(index));
    ft_topoplotER(cfg,stat3);
    count = count +1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% cluster 1 for common chans
alpha = 0.05
indchan1 = []; indchan1 = find(stat.prob(:,y(4)) <alpha);
indchan2 = []; indchan2 = find(stat.prob(:,y(12)) <alpha);
indchan = []; indchan = intersect(indchan1,indchan2)

fig = figure('position',[1 1 300 300]);
set(fig,'PaperPosition',[1 1 300 300])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
cmap = colormap('gray');
index = y(4);
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat.time(index) stat.time(index)];
cfg.zlim               = [-5 5]; % F-values
cfg.colormap           = cmap;
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
cfg.highlight          = {'on'};
cfg.highlightchannel   = {stat.label(indchan)};
cfg.highlightsymbol    = {'.'};
cfg.highlightsize      = {30,30} ;
cfg.highlightcolor     = {'k'};
cfg.comment            = num2str(stat.time(index));
ft_topoplotER(cfg,stat);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 1000 1000]);
set(fig,'PaperPosition',[1 1 1000 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
subplot(2,1,1)

clust  = find(sum(stat.prob <= alpha) > 0);

% determine figure size base on amplitude on avg cluster activity
valmax = max([max(mean(GDAVG{1}.avg(indchan,:))) ...
         max(mean(GDAVG{2}.avg(indchan,:)))]);
valmin = min([min(mean(GDAVG{1}.avg(indchan,:))) ...
         min(mean(GDAVG{2}.avg(indchan,:)))]);
% fmult
fmult = 1e14; % for express in uV
% define axes limit and plot properties
set_axes(-0.7, 5, -6.5,5)

% stimulus onsets
line([0 0]    ,[-6.5 5],'linestyle',':','linewidth',2,'color','k'); hold on
line([1.1 1.1],[-6.5 5],'linestyle',':','linewidth',2,'color','k'); hold on
line([2.2 2.2],[-6.5 5],'linestyle',':','linewidth',2,'color','k'); hold on
line([3.4 3.4],[-6.5 5],'linestyle',':','linewidth',2,'color','k'); hold on
line([4.6 4.6],[-6.5 5],'linestyle',':','linewidth',2,'color','k'); hold on

% cluster shade
plot_lin_shade(clust,0.05, stat,-6.5,5,[0.7 0.7 0.7],-6.2)

% timecourse
plot(GDAVG{1}.time,mean(GDAVG{2}.avg(indchan,:)*fmult),'linewidth',4,'color',graphcolor(2,:));hold on
plot(GDAVG{1}.time,mean(GDAVG{1}.avg(indchan,:)*fmult),'linewidth',4,'color',graphcolor(1,:));hold on

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/MISC_PLOTS/Figures_PAPER/mags_reftime_post_timecourse')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% cluster 1 for common chans
times = sum(stat2.prob <= 0.05);
plot(stat2.time,times)
[x,y] = findpeaks(times);

alpha = 0.05
indchan = []; indchan = find(stat2.prob(:,y(4)) <alpha);

fig = figure('position',[1 1 300 300]);
set(fig,'PaperPosition',[1 1 300 300])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
cmap = colormap('gray');
index = y(4);
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat2.time(index) stat2.time(index)];
cfg.zlim               = [-5 5]; % F-values
cfg.colormap           = cmap;
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
cfg.highlight          = {'on'};
cfg.highlightchannel   = {stat2.label(indchan)};
cfg.highlightsymbol    = {'.'};
cfg.highlightsize      = {30,30} ;
cfg.highlightcolor     = {'k'};
cfg.comment            = num2str(stat2.time(index));
ft_topoplotER(cfg,stat2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 1000 1000]);
set(fig,'PaperPosition',[1 1 1000 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
subplot(2,1,1)

clust = [];clust  = find(sum(stat2.prob <= alpha) > 0);

% determine figure size base on amplitude on avg cluster activity
valmax = max([max(mean(GDAVG{1}.avg(indchan,:))) ...
         max(mean(GDAVG{2}.avg(indchan,:)))]);
valmin = min([min(mean(GDAVG{1}.avg(indchan,:))) ...
         min(mean(GDAVG{2}.avg(indchan,:)))]);
% fmult
fmult = 1e14; % for express in uV
% define axes limit and plot properties
set_axes(-0.7, 5, -3.5,6.5)

% stimulus onsets
line([0 0]    ,[-3.5 6.5],'linestyle',':','linewidth',2,'color','k'); hold on
line([1.1 1.1],[-3.5 6.5],'linestyle',':','linewidth',2,'color','k'); hold on
line([2.2 2.2],[-3.5 6.5],'linestyle',':','linewidth',2,'color','k'); hold on
line([3.4 3.4],[-3.5 6.5],'linestyle',':','linewidth',2,'color','k'); hold on
line([4.6 4.6],[-3.5 6.5],'linestyle',':','linewidth',2,'color','k'); hold on

% cluster shade
plot_lin_shade(clust,0.05, stat2,-3.5,6.5,[0.7 0.7 0.7],-3)

% timecourse
plot(GDAVG{1}.time,mean(GDAVG{1}.avg(indchan,:)*fmult),'linewidth',4,'color',graphcolor(1,:));hold on
plot(GDAVG{1}.time,mean(GDAVG{2}.avg(indchan,:)*fmult),'linewidth',4,'color',graphcolor(2,:));hold on

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/MISC_PLOTS/Figures_PAPER/mags_reftime_ant_timecourse')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% cluster 1 for common chans
alpha = 0.05
indchan3 = []; indchan3 = find(stat3.prob(:,y(6)) <alpha);

times = sum(stat3.prob <= 0.05);
plot(stat3.time,times)
[x,y] = findpeaks(times);

fig = figure('position',[1 1 300 300]);
set(fig,'PaperPosition',[1 1 300 300])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
cmap = colormap('gray');
index = y(6);
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat3.time(index) stat3.time(index)];
cfg.zlim               = [-5 5]; % F-values
cfg.colormap           = cmap;
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
cfg.highlight          = {'on'};
cfg.highlightchannel   = {stat3.label(indchan3)};
cfg.highlightsymbol    = {'.'};
cfg.highlightsize      = {30,30} ;
cfg.highlightcolor     = {'k'};
cfg.comment            = num2str(stat3.time(index));
ft_topoplotER(cfg,stat3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 1000 1000]);
set(fig,'PaperPosition',[1 1 1000 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
subplot(2,1,1)

clust = [];clust  = find(sum(stat3.prob <= alpha) > 0);

% determine figure size base on amplitude on avg cluster activity
valmax = max([max(mean(GDAVG3{1}.avg(indchan3,:))) ...
         max(mean(GDAVG3{2}.avg(indchan3,:)))]);
valmin = min([min(mean(GDAVG3{1}.avg(indchan3,:))) ...
         min(mean(GDAVG3{2}.avg(indchan3,:)))]);
% fmult
fmult = 1e6; % for express in uV
% define axes limit and plot properties
set_axes(-0.7, 5, -2.5,4.5)

% stimulus onsets
line([0 0]    ,[-2.5 4.5],'linestyle',':','linewidth',2,'color','k'); hold on
line([1.1 1.1],[-2.5 4.5],'linestyle',':','linewidth',2,'color','k'); hold on
line([2.2 2.2],[-2.5 4.5],'linestyle',':','linewidth',2,'color','k'); hold on
line([3.4 3.4],[-2.5 4.5],'linestyle',':','linewidth',2,'color','k'); hold on
line([4.6 4.6],[-2.5 4.5],'linestyle',':','linewidth',2,'color','k'); hold on

% cluster shade
plot_lin_shade(clust,0.05, stat3,-2.5,4.5,[0.7 0.7 0.7],-2.2)

% timecourse
plot(GDAVG3{1}.time,mean(GDAVG3{1}.avg(indchan,:)*fmult),'linewidth',4,'color',graphcolor(1,:));hold on
plot(GDAVG3{1}.time,mean(GDAVG3{2}.avg(indchan,:)*fmult),'linewidth',4,'color',graphcolor(2,:));hold on

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/MISC_PLOTS/Figures_PAPER/eeg_reftime_ant_timecourse')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%% FUT vs PRE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/PLOTTING_PAPER')

%% TEST INPUT 1 mags occipital
condnames_clust = {'RefPre';'RefFut'};
condnames    = {'RefPre';'RefFut'};
latency      = [0.3 1.1];
graphcolor   = [[0 0 0];[1 0 0]];
stat_test    = 'T';
chansel      = 'Mags';
clustnum     = 0;
clusttype    = 'negclust';
timetag      = '2016711154518';

[ch, cdn, cdn_clust, stat, GDAVG, GDAVGt] = prepare_comp(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

%%%%%%%%%%%%%%%%%%%%%%%% prepare plotting layout %%%%%%%%%%%%%%%%%%%%%%%%%%
% select sensor datatype
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
times = sum(stat.prob <= 0.05);
plot(stat.time,times)
[x,y] = findpeaks(times);

fig = figure('position',[1 1 1500 1000]);
set(fig,'PaperPosition',[1 1 1500 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
count = 1;
for index = y
    subplot (5,5,count)
    cfg                    = [];
    cfg.layout             = lay;
    cfg.xlim               = [stat.time(index) stat.time(index)];
    cfg.zlim               = [-10 10]; % F-values
    cfg.colormap           = 'jet';
    cfg.style              = 'straight';
    cfg.parameter          = 'stat';
    cfg.marker             = 'off';
    cfg.highlight          = 'on';
    indchan = []; indchan = find(stat.prob(:,index) <0.05);
    cfg.highlightchannel   = stat.label(indchan);
    cfg.highlightsymbol    = '.';
    cfg.highlightsize      = 20;
    cfg.comment            = num2str(stat.time(index));
    ft_topoplotER(cfg,stat);
    count = count +1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% cluster 1 for common chans
alpha = 0.05
indchan = []; indchan = find(stat.prob(:,y(1)) <alpha);

fig = figure('position',[1 1 300 300]);
set(fig,'PaperPosition',[1 1 300 300])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
cmap = colormap('gray');
index = y(1);
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat.time(index) stat.time(index)];
cfg.zlim               = [-5 5]; % F-values
cfg.colormap           = cmap;
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
cfg.highlight          = {'on'};
cfg.highlightchannel   = {stat.label(indchan)};
cfg.highlightsymbol    = {'.'};
cfg.highlightsize      = {30,30} ;
cfg.highlightcolor     = {'k'};
cfg.comment            = num2str(stat.time(index));
ft_topoplotER(cfg,stat);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 1000 1000]);
set(fig,'PaperPosition',[1 1 1000 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
subplot(2,1,1)

clust  = find(sum(stat.prob(y(1)) <= alpha) > 0);

% determine figure size base on amplitude on avg cluster activity
valmax = max([max(mean(GDAVG{1}.avg(indchan,:))) ...
         max(mean(GDAVG{2}.avg(indchan,:)))]);
valmin = min([min(mean(GDAVG{1}.avg(indchan,:))) ...
         min(mean(GDAVG{2}.avg(indchan,:)))]);
% fmult
fmult = 1e14; % for express in uV
% define axes limit and plot properties
set_axes(-0.7, 5, -4,6)

% stimulus onsets
line([0 0]    ,[-4 6],'linestyle',':','linewidth',2,'color','k'); hold on
line([1.1 1.1],[-4 6],'linestyle',':','linewidth',2,'color','k'); hold on
line([2.2 2.2],[-4 6],'linestyle',':','linewidth',2,'color','k'); hold on
line([3.4 3.4],[-4 6],'linestyle',':','linewidth',2,'color','k'); hold on
line([4.6 4.6],[-4 6],'linestyle',':','linewidth',2,'color','k'); hold on

% cluster shade
plot_lin_shade(clust,0.05, stat,-4, 6,[0.7 0.7 0.7],-3.7)

% timecourse
plot(GDAVG{1}.time,mean(GDAVG{2}.avg(indchan,:)*fmult),'linewidth',4,'color',graphcolor(2,:));hold on
plot(GDAVG{1}.time,mean(GDAVG{1}.avg(indchan,:)*fmult),'linewidth',4,'color',graphcolor(1,:));hold on

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/MISC_PLOTS/Figures_PAPER/mags_fut-pre_post_timecourse')

%% TEST INPUT 1 eeg frontal
condnames_clust = {'RefPre';'RefFut'};
condnames    = {'RefPre';'RefFut'};
latency      = [1.1 2];
graphcolor   = [[0 0 0];[1 0 0]];
stat_test    = 'T';
chansel      = 'EEG';
clustnum     = 0;
clusttype    = 'posclust';
timetag      = '201671116715';

[ch, cdn, cdn_clust, stat, GDAVG, GDAVGt] = prepare_comp(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

%% TEST INPUT 1 eeg frontal
condnames_clust = {'RefPre';'RefFut'};
condnames    = {'RefPre';'RefFut'};
latency      = [2.2 3.4];
graphcolor   = [[0 0 0];[1 0 0]];
stat_test    = 'T';
chansel      = 'EEG';
clustnum     = 0;
clusttype    = 'posclust';
timetag      = '20167111694';

[ch2, cdn2, cdn_clust2, stat2, GDAVG2, GDAVGt2] = prepare_comp(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

%% TEST INPUT 1 eeg frontal
condnames_clust = {'RefPre';'RefFut'};
condnames    = {'RefPre';'RefFut'};
latency      = [3.4 4.6];
graphcolor   = [[0 0 0];[1 0 0]];
stat_test    = 'T';
chansel      = 'EEG';
clustnum     = 0;
clusttype    = 'posclust';
timetag      = '2016711161120';

[ch3, cdn3, cdn_clust3, stat3, GDAVG3, GDAVGt3] = prepare_comp(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

%%%%%%%%%%%%%%%%%%%%%%%% prepare plotting layout %%%%%%%%%%%%%%%%%%%%%%%%%%
% select sensor datatype
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


%%
times = sum(stat.prob <= 0.05);
plot(stat.time,times)
[x,y] = findpeaks(times);

fig = figure('position',[1 1 1500 1000]);
set(fig,'PaperPosition',[1 1 1500 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
count = 1;
for index = y
    subplot (5,5,count)
    cfg                    = [];
    cfg.layout             = lay;
    cfg.xlim               = [stat.time(index) stat.time(index)];
    cfg.zlim               = [-10 10]; % F-values
    cfg.colormap           = 'jet';
    cfg.style              = 'straight';
    cfg.parameter          = 'stat';
    cfg.marker             = 'off';
    cfg.highlight          = 'on';
    indchan = []; indchan = find(stat.prob(:,index) <0.05);
    cfg.highlightchannel   = stat.label(indchan);
    cfg.highlightsymbol    = '.';
    cfg.highlightsize      = 20;
    cfg.comment            = num2str(stat.time(index));
    ft_topoplotER(cfg,stat);
    count = count +1;
end

%%
alpha = 0.05
indchan= []; indchan = find(stat.prob(:,y(10)) <alpha);

fig = figure('position',[1 1 300 300]);
set(fig,'PaperPosition',[1 1 300 300])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
cmap = colormap('gray');
index = y(10);
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat.time(index) stat.time(index)];
cfg.zlim               = [-5 5]; % F-values
cfg.colormap           = cmap;
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
cfg.highlight          = {'on'};
cfg.highlightchannel   = {stat.label(indchan)};
cfg.highlightsymbol    = {'.'};
cfg.highlightsize      = {30} ;
cfg.highlightcolor     = {'k'};
cfg.comment            = num2str(stat.time(index));
ft_topoplotER(cfg,stat);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
times = sum(stat2.prob <= 0.05);
plot(stat2.time,times)
[x,y] = findpeaks(times);

fig = figure('position',[1 1 1500 1000]);
set(fig,'PaperPosition',[1 1 1500 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
count = 1;
for index = y
    subplot (5,5,count)
    cfg                    = [];
    cfg.layout             = lay;
    cfg.xlim               = [stat2.time(index) stat2.time(index)];
    cfg.zlim               = [-5 5]; % F-values
    cfg.colormap           = 'jet';
    cfg.style              = 'straight';
    cfg.parameter          = 'stat';
    cfg.marker             = 'off';
    cfg.highlight          = 'on';
    indchan = []; indchan = find(stat2.prob(:,index) <0.05);
    cfg.highlightchannel   = stat2.label(indchan);
    cfg.highlightsymbol    = '.';
    cfg.highlightsize      = 20;
    cfg.comment            = num2str(stat2.time(index));
    ft_topoplotER(cfg,stat2);
    count = count +1;
end

%%
alpha = 0.05
indchan= []; indchan = find(stat2.prob(:,y(4)) <alpha);

fig = figure('position',[1 1 300 300]);
set(fig,'PaperPosition',[1 1 300 300])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
cmap = colormap('gray');
index = y(4);
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat2.time(index) stat2.time(index)];
cfg.zlim               = [-5 5]; % F-values
cfg.colormap           = cmap;
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
cfg.highlight          = {'on'};
cfg.highlightchannel   = {stat2.label(indchan)};
cfg.highlightsymbol    = {'.'};
cfg.highlightsize      = {30} ;
cfg.highlightcolor     = {'k'};
cfg.comment            = num2str(stat2.time(index));
ft_topoplotER(cfg,stat2);

%%
times = sum(stat3.prob <= 0.05);
plot(stat3.time,times)
[x,y] = findpeaks(times);

fig = figure('position',[1 1 1500 1000]);
set(fig,'PaperPosition',[1 1 1500 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
count = 1;
for index = y
    subplot (5,5,count)
    cfg                    = [];
    cfg.layout             = lay;
    cfg.xlim               = [stat3.time(index) stat3.time(index)];
    cfg.zlim               = [-5 5]; % F-values
    cfg.colormap           = 'jet';
    cfg.style              = 'straight';
    cfg.parameter          = 'stat';
    cfg.marker             = 'off';
    cfg.highlight          = 'on';
    indchan = []; indchan = find(stat3.prob(:,index) <0.05);
    cfg.highlightchannel   = stat3.label(indchan);
    cfg.highlightsymbol    = '.';
    cfg.highlightsize      = 20;
    cfg.comment            = num2str(stat3.time(index));
    ft_topoplotER(cfg,stat3);
    count = count +1;
end

%%
alpha = 0.05
indchan= []; indchan = find(stat3.prob(:,y(7)) <alpha);

fig = figure('position',[1 1 300 300]);
set(fig,'PaperPosition',[1 1 300 300])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
cmap = colormap('gray');
index = y(7);
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat3.time(index) stat3.time(index)];
cfg.zlim               = [-5 5]; % F-values
cfg.colormap           = cmap;
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
cfg.highlight          = {'on'};
cfg.highlightchannel   = {stat3.label(indchan)};
cfg.highlightsymbol    = {'.'};
cfg.highlightsize      = {30} ;
cfg.highlightcolor     = {'k'};
cfg.comment            = num2str(stat3.time(index));
ft_topoplotER(cfg,stat3);

%%
fig = figure('position',[1 1 1000 1000]);
set(fig,'PaperPosition',[1 1 1000 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
subplot(2,1,1)

%
alpha = 0.05
clust   = find(sum(stat.prob <= alpha) > 0);
clust2  = find(sum(stat2.prob <= alpha) > 0);
clust3  = find(sum(stat3.prob <= alpha) > 0);

indchan1= []; indchan1  = find(stat.prob(:,y(10)) <alpha);
indchan2= []; indchan2 = find(stat2.prob(:,y(4)) <alpha);
indchan3= []; indchan3 = find(stat3.prob(:,y(7)) <alpha);
indchan = intersect(intersect(indchan1,indchan2),indchan3)

% determine figure size base on amplitude on avg cluster activity
valmax = max([max(mean(GDAVG{1}.avg(indchan,:))) ...
         max(mean(GDAVG{2}.avg(indchan,:)))]);
valmin = min([min(mean(GDAVG{1}.avg(indchan,:))) ...
         min(mean(GDAVG{2}.avg(indchan,:)))]);
% fmult
fmult = 1e6; % for express in uV
% define axes limit and plot properties
set_axes(-0.7, 5, -4,6)

% stimulus onsets
line([0 0]    ,[-4 6],'linestyle',':','linewidth',2,'color','k'); hold on
line([1.1 1.1],[-4 6],'linestyle',':','linewidth',2,'color','k'); hold on
line([2.2 2.2],[-4 6],'linestyle',':','linewidth',2,'color','k'); hold on
line([3.4 3.4],[-4 6],'linestyle',':','linewidth',2,'color','k'); hold on
line([4.6 4.6],[-4 6],'linestyle',':','linewidth',2,'color','k'); hold on

% cluster shade
plot_lin_shade(clust,0.05, stat,-4, 6,[0.7 0.7 0.7],-3.7)
plot_lin_shade(clust2,0.05, stat2,-4, 6,[0.7 0.7 0.7],-3.7)
plot_lin_shade(clust3,0.05, stat3,-4, 6,[0.7 0.7 0.7],-3.7)

% timecourse
plot(GDAVG{1}.time,mean(GDAVG{2}.avg(indchan,:)*fmult),'linewidth',4,'color',graphcolor(2,:));hold on
plot(GDAVG{1}.time,mean(GDAVG{1}.avg(indchan,:)*fmult),'linewidth',4,'color',graphcolor(1,:));hold on

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/MISC_PLOTS/Figures_PAPER/eeg_fut-pre_post_timecourse')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%% FUT vs PAST %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/PLOTTING_PAPER')

%% TEST INPUT 1 mags occipital
condnames_clust = {'RefPast';'RefFut'};
condnames    = {'RefPast';'RefFut'};
latency      = [0.3 1.1];
graphcolor   = [[1 0.7 0.7];[1 0 0]];
stat_test    = 'T';
chansel      = 'Mags';
clustnum     = 0;
clusttype    = 'negclust';
timetag      = '2016712104132';

[ch0, cdn0, cdn_clust0, stat0, GDAVG0, GDAVGt0] = prepare_comp(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

%% TEST INPUT 1 mags occipital
condnames_clust = {'RefPast';'RefFut'};
condnames    = {'RefPast';'RefFut'};
latency      = [0.3 1.1];
graphcolor   = [[1 0.7 0.7];[1 0 0]];
stat_test    = 'T';
chansel      = 'Mags';
clustnum     = 0;
clusttype    = 'posclust';
timetag      = '2016712104132';

[ch, cdn, cdn_clust, stat, GDAVG, GDAVGt] = prepare_comp(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

%% TEST INPUT 1 mags occipital
condnames_clust = {'RefPast';'RefFut'};
condnames    = {'RefPast';'RefFut'};
latency      = [1.1 2];
graphcolor   = [[1 0.7 0.7];[1 0 0]];
stat_test    = 'T';
chansel      = 'Mags';
clustnum     = 0;
clusttype    = 'posclust';
timetag      = '2016712104337';

[ch2, cdn2, cdn_clust2, stat2, GDAVG2, GDAVGt2] = prepare_comp(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

%% TEST INPUT 1 mags occipital
condnames_clust = {'RefPast';'RefFut'};
condnames    = {'RefPast';'RefFut'};
latency      = [1.1 2];
graphcolor   = [[1 0.7 0.7];[1 0 0]];
stat_test    = 'T';
chansel      = 'EEG';
clustnum     = 0;
clusttype    = 'posclust';
timetag      = '201671211120';

[ch4, cdn4, cdn_clust4, stat4, GDAVG4, GDAVGt4] = prepare_comp(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

%%%%%%%%%%%%%%%%%%%%%%%% prepare plotting layout %%%%%%%%%%%%%%%%%%%%%%%%%%
% select sensor datatype
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

%%%%%%%%%%%%%%%%%%%%%%%% prepare plotting layout %%%%%%%%%%%%%%%%%%%%%%%%%%
% select sensor datatype
[Grads1,Grads2,Mags]   = grads_for_layouts('Network');

% prepare layout
cfg                           = [];
if strcmp(chansel,'EEG') == 0
    cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/fieldtrip-20130901/template/layout/NM306mag.lay';
else
    cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/eeg_64_NM20884N.lay';
end
lay                        = ft_prepare_layout(cfg,GDAVGt4{1});
lay.label                = GDAVGt4{1}.label;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
times = sum(stat0.prob <= 0.05);
plot(stat0.time,times)
[x,y] = findpeaks(times);

fig = figure('position',[1 1 1500 1000]);
set(fig,'PaperPosition',[1 1 1500 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
count = 1;
for index = y
    subplot (5,5,count)
    cfg                    = [];
    cfg.layout             = lay;
    cfg.xlim               = [stat0.time(index) stat0.time(index)];
    cfg.zlim               = [-5 5]; % F-values
    cfg.colormap           = 'jet';
    cfg.style              = 'straight';
    cfg.parameter          = 'stat';
    cfg.marker             = 'off';
    cfg.highlight          = 'on';
    indchan = []; indchan = find(stat0.prob(:,index) <0.05);
    cfg.highlightchannel   = stat0.label(indchan);
    cfg.highlightsymbol    = '.';
    cfg.highlightsize      = 20;
    cfg.comment            = num2str(stat0.time(index));
    ft_topoplotER(cfg,stat0);
    count = count +1;
end

%%
alpha = 0.05
indchan= []; indchan = find(stat0.prob(:,y(5)) <alpha);

fig = figure('position',[1 1 300 300]);
set(fig,'PaperPosition',[1 1 300 300])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
cmap = colormap('gray');
index = y(5);
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat0.time(index) stat0.time(index)];
cfg.zlim               = [-5 5]; % F-values
cfg.colormap           = cmap;
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
cfg.highlight          = {'on'};
cfg.highlightchannel   = {stat0.label(indchan)};
cfg.highlightsymbol    = {'.'};
cfg.highlightsize      = {30} ;
cfg.highlightcolor     = {'k'};
cfg.comment            = num2str(stat0.time(index));
ft_topoplotER(cfg,stat0);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
times = sum(stat.prob <= 0.05);
plot(stat.time,times)
[x,y] = findpeaks(times);

fig = figure('position',[1 1 1500 1000]);
set(fig,'PaperPosition',[1 1 1500 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
count = 1;
for index = y
    subplot (5,5,count)
    cfg                    = [];
    cfg.layout             = lay;
    cfg.xlim               = [stat.time(index) stat.time(index)];
    cfg.zlim               = [-5 5]; % F-values
    cfg.colormap           = 'jet';
    cfg.style              = 'straight';
    cfg.parameter          = 'stat';
    cfg.marker             = 'off';
    cfg.highlight          = 'on';
    indchan = []; indchan = find(stat.prob(:,index) <0.05);
    cfg.highlightchannel   = stat.label(indchan);
    cfg.highlightsymbol    = '.';
    cfg.highlightsize      = 20;
    cfg.comment            = num2str(stat.time(index));
    ft_topoplotER(cfg,stat);
    count = count +1;
end

%%
alpha = 0.05
indchan= []; indchan = find(stat.prob(:,y(5)) <alpha);

fig = figure('position',[1 1 300 300]);
set(fig,'PaperPosition',[1 1 300 300])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
cmap = colormap('gray');
index = y(5);
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat.time(index) stat.time(index)];
cfg.zlim               = [-5 5]; % F-values
cfg.colormap           = cmap;
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
cfg.highlight          = {'on'};
cfg.highlightchannel   = {stat.label(indchan)};
cfg.highlightsymbol    = {'.'};
cfg.highlightsize      = {30} ;
cfg.highlightcolor     = {'k'};
cfg.comment            = num2str(stat.time(index));
ft_topoplotER(cfg,stat);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
times = sum(stat2.prob <= 0.05);
plot(stat2.time,times)
[x,y] = findpeaks(times);

fig = figure('position',[1 1 1500 1000]);
set(fig,'PaperPosition',[1 1 1500 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
count = 1;
for index = y
    subplot (5,5,count)
    cfg                    = [];
    cfg.layout             = lay;
    cfg.xlim               = [stat2.time(index) stat2.time(index)];
    cfg.zlim               = [-5 5]; % F-values
    cfg.colormap           = 'jet';
    cfg.style              = 'straight';
    cfg.parameter          = 'stat';
    cfg.marker             = 'off';
    cfg.highlight          = 'on';
    indchan = []; indchan = find(stat2.prob(:,index) <0.05);
    cfg.highlightchannel   = stat2.label(indchan);
    cfg.highlightsymbol    = '.';
    cfg.highlightsize      = 20;
    cfg.comment            = num2str(stat2.time(index));
    ft_topoplotER(cfg,stat2);
    count = count +1;
end

%%
alpha = 0.05
indchan= []; indchan = find(stat2.prob(:,y(19)) <alpha);

fig = figure('position',[1 1 300 300]);
set(fig,'PaperPosition',[1 1 300 300])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
cmap = colormap('gray');
index = y(19);
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat2.time(index) stat2.time(index)];
cfg.zlim               = [-5 5]; % F-values
cfg.colormap           = cmap;
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
cfg.highlight          = {'on'};
cfg.highlightchannel   = {stat2.label(indchan)};
cfg.highlightsymbol    = {'.'};
cfg.highlightsize      = {30} ;
cfg.highlightcolor     = {'k'};
cfg.comment            = num2str(stat2.time(index));
ft_topoplotER(cfg,stat2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
times = sum(stat4.prob <= 0.05);
plot(stat4.time,times)
[x,y] = findpeaks(times);

fig = figure('position',[1 1 1500 1000]);
set(fig,'PaperPosition',[1 1 1500 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
count = 1;
for index = y
    subplot (5,5,count)
    cfg                    = [];
    cfg.layout             = lay;
    cfg.xlim               = [stat4.time(index) stat4.time(index)];
    cfg.zlim               = [-5 5]; % F-values
    cfg.colormap           = 'jet';
    cfg.style              = 'straight';
    cfg.parameter          = 'stat';
    cfg.marker             = 'off';
    cfg.highlight          = 'on';
    indchan = []; indchan = find(stat4.prob(:,index) <0.05);
    cfg.highlightchannel   = stat4.label(indchan);
    cfg.highlightsymbol    = '.';
    cfg.highlightsize      = 20;
    cfg.comment            = num2str(stat4.time(index));
    ft_topoplotER(cfg,stat4);
    count = count +1;
end

%%
alpha = 0.05
indchan= []; indchan = find(stat4.prob(:,y(2)) <alpha);

fig = figure('position',[1 1 300 300]);
set(fig,'PaperPosition',[1 1 300 300])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
cmap = colormap('gray');
index = y(2);
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat4.time(index) stat4.time(index)];
cfg.zlim               = [-5 5]; % F-values
cfg.colormap           = cmap;
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
cfg.highlight          = {'on'};
cfg.highlightchannel   = {stat4.label(indchan)};
cfg.highlightsymbol    = {'.'};
cfg.highlightsize      = {30} ;
cfg.highlightcolor     = {'k'};
cfg.comment            = num2str(stat4.time(index));
ft_topoplotER(cfg,stat4);

%%
fig = figure('position',[1 1 1000 1000]);
set(fig,'PaperPosition',[1 1 1000 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
subplot(2,1,1)

%
alpha = 0.05

clust1  = find(sum(stat.prob <= alpha) > 0);
clust2  = find(sum(stat2.prob <= alpha) > 0);

indchan1= []; indchan1 = find(stat.prob(:,y(10)) <alpha);
indchan2= []; indchan2 = find(stat2.prob(:,y(19)) <alpha);
indchan = intersect(indchan2,indchan1)

% determine figure size base on amplitude on avg cluster activity
valmax = max([max(mean(GDAVG{1}.avg(indchan,:))) ...
         max(mean(GDAVG{2}.avg(indchan,:)))]);
valmin = min([min(mean(GDAVG{1}.avg(indchan,:))) ...
         min(mean(GDAVG{2}.avg(indchan,:)))]);
% fmult
fmult = 1e14; % for express in uV
% define axes limit and plot properties
set_axes(-0.7, 5, -5,5)

% stimulus onsets
line([0 0]    ,[-5,5],'linestyle',':','linewidth',2,'color','k'); hold on
line([1.1 1.1],[-5,5],'linestyle',':','linewidth',2,'color','k'); hold on
line([2.2 2.2],[-5,5],'linestyle',':','linewidth',2,'color','k'); hold on
line([3.4 3.4],[-5,5],'linestyle',':','linewidth',2,'color','k'); hold on
line([4.6 4.6],[-5,5],'linestyle',':','linewidth',2,'color','k'); hold on

% cluster shade
plot_lin_shade(clust1,0.05, stat,-5,5,[0.7 0.7 0.7],-4.8)
plot_lin_shade(clust2,0.05, stat2,-5,5,[0.7 0.7 0.7],-4.8)

% timecourse
plot(GDAVG{1}.time,mean(GDAVG{2}.avg(indchan,:)*fmult),'linewidth',4,'color',graphcolor(2,:));hold on
plot(GDAVG{1}.time,mean(GDAVG{1}.avg(indchan,:)*fmult),'linewidth',4,'color',graphcolor(1,:));hold on

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/MISC_PLOTS/Figures_PAPER/mags_past_fut_post_timecourse')

%%
times = sum(stat4.prob <= 0.05);
plot(stat4.time,times)
[x,y] = findpeaks(times);

fig = figure('position',[1 1 1000 1000]);
set(fig,'PaperPosition',[1 1 1000 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
subplot(2,1,1)

alpha = 0.05
clust  = find(sum(stat4.prob <= alpha) > 0);
indchan= []; indchan = find(stat4.prob(:,y(2)) <alpha);

% determine figure size base on amplitude on avg cluster activity
valmax = max([max(mean(GDAVG{1}.avg(indchan,:))) ...
         max(mean(GDAVG{2}.avg(indchan,:)))]);
valmin = min([min(mean(GDAVG{1}.avg(indchan,:))) ...
         min(mean(GDAVG{2}.avg(indchan,:)))]);
% fmult
fmult = 1e6; % for express in uV
% define axes limit and plot properties
set_axes(-0.7, 5, -5,5)

% stimulus onsets
line([0 0]    ,[-5,5],'linestyle',':','linewidth',2,'color','k'); hold on
line([1.1 1.1],[-5,5],'linestyle',':','linewidth',2,'color','k'); hold on
line([2.2 2.2],[-5,5],'linestyle',':','linewidth',2,'color','k'); hold on
line([3.4 3.4],[-5,5],'linestyle',':','linewidth',2,'color','k'); hold on
line([4.6 4.6],[-5,5],'linestyle',':','linewidth',2,'color','k'); hold on

% cluster shade
plot_lin_shade(clust,0.05, stat4,-5,5,[0.7 0.7 0.7],-4.8)

% timecourse
plot(GDAVG4{1}.time,mean(GDAVG4{2}.avg(indchan,:)*fmult),'linewidth',4,'color',graphcolor(2,:));hold on
plot(GDAVG4{1}.time,mean(GDAVG4{1}.avg(indchan,:)*fmult),'linewidth',4,'color',graphcolor(1,:));hold on

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/MISC_PLOTS/Figures_PAPER/eeg_past_fut_post_timecourse')

%%
times = sum(stat0.prob <= 0.05);
plot(stat0.time,times)
[x,y] = findpeaks(times);

fig = figure('position',[1 1 1000 1000]);
set(fig,'PaperPosition',[1 1 1000 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
subplot(2,1,1)

alpha = 0.05
clust0  = find(sum(stat0.prob <= alpha) > 0);
indchan= []; indchan = find(stat0.prob(:,y(5)) <alpha);

% determine figure size base on amplitude on avg cluster activity
valmax = max([max(mean(GDAVG0{1}.avg(indchan,:))) ...
         max(mean(GDAVG0{2}.avg(indchan,:)))]);
valmin = min([min(mean(GDAVG0{1}.avg(indchan,:))) ...
         min(mean(GDAVG0{2}.avg(indchan,:)))]);
% fmult
fmult = 1e14; % for express in uV
% define axes limit and plot properties
set_axes(-0.7, 5, -5,5)

% stimulus onsets
line([0 0]    ,[-5,5],'linestyle',':','linewidth',2,'color','k'); hold on
line([1.1 1.1],[-5,5],'linestyle',':','linewidth',2,'color','k'); hold on
line([2.2 2.2],[-5,5],'linestyle',':','linewidth',2,'color','k'); hold on
line([3.4 3.4],[-5,5],'linestyle',':','linewidth',2,'color','k'); hold on
line([4.6 4.6],[-5,5],'linestyle',':','linewidth',2,'color','k'); hold on

% cluster shade
plot_lin_shade(clust0,0.05, stat0,-5,5,[0.7 0.7 0.7],-4.8)

% timecourse
plot(GDAVG0{1}.time,mean(GDAVG0{2}.avg(indchan,:)*fmult),'linewidth',4,'color',graphcolor(2,:));hold on
plot(GDAVG0{1}.time,mean(GDAVG0{1}.avg(indchan,:)*fmult),'linewidth',4,'color',graphcolor(1,:));hold on

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/MISC_PLOTS/Figures_PAPER/mag_past_fut_occ_timecourse')

