addpath('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/PLOTTING_PAPER')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
condnames_clust= {'QsWest';'QsPar';'QsEast'};
condnames    = {'QsWest';'QsPar';'QsEast'};
latency      = [0 1];
graphcolor   = [[1 0.7 0.7];[0 0 0];[1 0 0]];
stat_test    = '';
chansel      = 'EEG';
clustnum     = 0;
clusttype    = 'posclust';
timetag      = '2016330125654';

[ch_f1, cdn_f1, cdn_clust_f1, stat_f1, GDAVG_f1, GDAVGt_f1] = prepare_comp(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
condnames_clust= {'QsWest';'QsPar';'QsEast'};
condnames    = {'QsWest';'QsPar';'QsEast'};
latency      = [0 1];
graphcolor   = [[1 0.7 0.7];[0 0 0];[1 0 0]];
stat_test    = 'Reg';
chansel      = 'EEG';
clustnum     = 0;
clusttype    = 'negclust';
timetag      = '2016720183544';

[ch1, cdn1, cdn_clust1, stat1, GDAVG1, GDAVGt1] = prepare_comp(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
condnames_clust= {'QsWest';'QsPar';'QsEast'};
condnames    = {'QsWest';'QsPar';'QsEast'};
latency      = [0 1];
graphcolor   = [[1 0.7 0.7];[0 0 0];[1 0 0]];
stat_test    = 'Reg';
chansel      = 'Mags';
clustnum     = 0;
clusttype    = 'posclust';
timetag      = '2016720181610';

[ch3, cdn3, cdn_clust3, stat3, GDAVG3, GDAVGt3] = prepare_comp(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
condnames_clust= {'QsPar';'QsEast'};
condnames    = {'QsPar';'QsEast'};
latency      = [0 1];
graphcolor   = [[1 0.7 0.7];[0 0 0];[1 0 0]];
stat_test    = 'T';
chansel      = 'EEG';
clustnum     = 0;
clusttype    = 'posclust';
timetag      = '2016720183257';

[ch_pare, cdn_pare, cdn_clust_pare, stat_pare, GDAVG_pare, GDAVGt_pare] = prepare_comp(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
condnames_clust= {'QsWest';'QsEast'};
condnames    = {'QsWest';'QsEast'};
latency      = [0 1];
graphcolor   = [[1 0.7 0.7];[0 0 0];[1 0 0]];
stat_test    = 'T';
chansel      = 'Mags';
clustnum     = 0;
clusttype    = 'negclust';
timetag      = '2016720152333';

[ch_we, cdn_we, cdn_clust_we, stat_we, GDAVG_we, GDAVGt_we] = prepare_comp(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
condnames_clust= {'QsWest';'QsEast'};
condnames    = {'QsWest';'QsEast'};
latency      = [0 1];
graphcolor   = [[1 0.7 0.7];[0 0 0];[1 0 0]];
stat_test    = 'T';
chansel      = 'EEG';
clustnum     = 0;
clusttype    = 'posclust';
timetag      = '2016720183738';

[ch_we1, cdn_we1, cdn_clust_we1, stat_we1, GDAVG_we1, GDAVGt_we1] = prepare_comp(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

%%%%%%%%%%%%%%%%%%%%%%%% prepare plotting layout %%%%%%%%%%%%%%%%%%%%%%%%%%
% select sensor datatype
[Grads1,Grads2,Mags]   = grads_for_layouts('Network');
chansel = 'EEG'
% prepare layout
cfg                           = [];
if strcmp(chansel,'EEG') == 0
    cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/fieldtrip-20130901/template/layout/NM306mag.lay';
else
    cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/eeg_64_NM20884N.lay';
end
lay                        = ft_prepare_layout(cfg,GDAVGt_f1{1});
lay.label                = GDAVGt_f1{1}.label;

%%%%%%%%%%%%%%%%%%%%%%%% prepare plotting layout %%%%%%%%%%%%%%%%%%%%%%%%%%
% select sensor datatype
[Grads1,Grads2,Mags]   = grads_for_layouts('Network');
chansel = 'Mags'
% prepare layout
cfg                           = [];
if strcmp(chansel,'EEG') == 0
    cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/fieldtrip-20130901/template/layout/NM306mag.lay';
else
    cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/eeg_64_NM20884N.lay';
end
lay                        = ft_prepare_layout(cfg,GDAVGt_we{1});
lay.label                = GDAVGt_we{1}.label;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
times = sum(stat_we1.prob <= 0.05);
plot(stat_we1.time,times)
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
    cfg.xlim               = [stat_we1.time(index) stat_we1.time(index)];
    cfg.zlim               = [-10 10]; % F-values
    cfg.colormap           = 'jet';
    cfg.style              = 'straight';
    cfg.parameter          = 'stat';
    cfg.marker             = 'off';
    cfg.highlight          = 'on';
    indchan = []; indchan  = find(stat_we1.prob(:,index) <0.05);
    cfg.highlightchannel   = stat_we1.label(indchan);
    cfg.highlightsymbol    = '.';
    cfg.highlightsize      = 20;
    cfg.comment            = num2str(stat_we1.time(index));
    ft_topoplotER(cfg,stat_we1);
    count = count +1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
times = sum(stat_f1.prob <= 0.05);
plot(stat_f1.time,times)
[x,y] = findpeaks(times);
indchan_f1 = find(stat_f1.prob(:,y(2)) <0.05);
clust_f1  = find(sum(stat_f1.prob <= 0.05) > 0);

times = sum(stat1.prob <= 0.05);
plot(stat1.time,times)
[x,y] = findpeaks(times);
indchan1 = find(stat1.prob(:,y(5)) <0.05);
clust1  = find(sum(stat1.prob <= 0.05) > 0);

times = sum(stat_pare.prob <= 0.05);
plot(stat_pare.time,times)
[x,y] = findpeaks(times);
indchan_pare = find(stat_pare.prob(:,y(3)) <0.05);
clust_pare  = find(sum(stat_pare.prob <= 0.05) > 0);

times = sum(stat_we.prob <= 0.05);
plot(stat_we.time,times)
[x,y] = findpeaks(times);
indchan_we = find(stat_we.prob(:,y(2)) <0.05);
clust_we  = find(sum(stat_we.prob <= 0.05) > 0);

times = sum(stat3.prob <= 0.05);
plot(stat3.time,times)
[x,y] = findpeaks(times);
indchan3 = find(stat3.prob(:,y(2)) <0.05);
clust3  = find(sum(stat3.prob <= 0.05) > 0);

times = sum(stat_we1.prob <= 0.05);
plot(stat_we1.time,times)
[x,y] = findpeaks(times);
indchan_we1 = find(stat_we1.prob(:,y(5)) <0.05);
clust_we1  = find(sum(stat_we1.prob <= 0.05) > 0);


indchan_mags = intersect(indchan3,indchan_we)
indchan_eeg = intersect(intersect(indchan_f1,indchan1),indchan_pare)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 500 1000]);
set(fig,'PaperPosition',[1 1 500 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
subplot(2,1,1)

% color of each conditions
graphcolor   = [[0 0 0];[0.7 0.7 1];[0 0 1]];

% fmult
fmult = 1e14; % for express in uV
% define axes limit and plot properties
set_axes(-0.7, 1.2, -8,4)

% stimulus onsets
line([0 0]    ,[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on
line([1.1 1.1],[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on
line([2.2 2.2],[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on
line([3.4 3.4],[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on
line([4.6 4.6],[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on

% cluster shade
cmap = colormap('jet')
cmap_inv = cmap(end:-1:1,:)
plot_lin_shade_v2(clust_we ,0.05 , stat_we ,-6.5,5,[0.7 0.7 0.7],-6,indchan_mags,cmap_inv,[-5 5])
plot_lin_shade_v2(clust3 ,0.05 , stat3 ,-6.5,5,[0.7 0.7 0.7],-7,indchan_mags,cmap_inv,[-5 5])

% timecourse
plot(GDAVG3{1}.time,mean(GDAVG3{1}.avg(indchan_mags,:)*fmult),'linewidth',4,'color',graphcolor(2,:));hold on
plot(GDAVG3{1}.time,mean(GDAVG3{2}.avg(indchan_mags,:)*fmult),'linewidth',4,'color',graphcolor(1,:));hold on
plot(GDAVG3{1}.time,mean(GDAVG3{3}.avg(indchan_mags,:)*fmult),'linewidth',4,'color',graphcolor(3,:));hold on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 500 1000]);
set(fig,'PaperPosition',[1 1 500 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
subplot(2,1,1)

% color of each conditions
graphcolor   = [[0 0 0];[0.7 0.7 1];[0 0 1]];

% fmult
fmult = 1e6; % for express in uV
% define axes limit and plot properties
set_axes(-0.7, 1.2, -3.5,2)

% stimulus onsets
line([0 0]    ,[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on
line([1.1 1.1],[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on
line([2.2 2.2],[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on
line([3.4 3.4],[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on
line([4.6 4.6],[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on

% cluster shade
cmap = colormap('jet')
cmap_inv = cmap(end:-1:1,:)
plot_lin_shade_v2(clust1     ,0.05 , stat1     ,-6.5,5,[0.7 0.7 0.7],-1.5,indchan_eeg,cmap,[-5 5])
plot_lin_shade_v2(clust_pare ,0.05 , stat_pare ,-6.5,5,[0.7 0.7 0.7],-2,indchan_eeg,cmap_inv,[-5 5])
plot_lin_shade_v2(clust_we1 ,0.05 , stat_we1 ,-6.5,5,[0.7 0.7 0.7],-2.5,indchan_eeg,cmap_inv,[-5 5])
cmap = colormap('gray')
cmap_inv = cmap(end:-1:1,:)
plot_lin_shade_v2(clust_f1   ,0.05 , stat_f1   ,-6.5,5,[0.7 0.7 0.7],-3,indchan_eeg,cmap_inv,[-5 5])

% timecourse
plot(GDAVG_f1{1}.time,mean(GDAVG_f1{1}.avg(indchan_eeg,:)*fmult),'linewidth',4,'color',graphcolor(2,:));hold on
plot(GDAVG_f1{1}.time,mean(GDAVG_f1{2}.avg(indchan_eeg,:)*fmult),'linewidth',4,'color',graphcolor(1,:));hold on
plot(GDAVG_f1{1}.time,mean(GDAVG_f1{3}.avg(indchan_eeg,:)*fmult),'linewidth',4,'color',graphcolor(3,:));hold on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
times = sum(stat_we.prob <= 0.05);
plot(stat_we.time,times)
[x,y] = findpeaks(times);

fig = figure('position',[1 1 300 300]);
set(fig,'PaperPosition',[1 1 300 300])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

index = y(2)
cmap  = colormap('jet')
cmap  = cmap(end:-1:1,:)
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat_we.time(index) stat_we.time(index)];
cfg.zlim               = [-5 5]; % F-values
cfg.colormap           = cmap;
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
indchan = []; indchan  = find(stat_we.prob(:,index) <0.05);
cfg.highlightchannel   = stat_we.label(indchan);
cfg.highlightsymbol    = '.';
cfg.highlightsize      = 20;
cfg.highlightcolor     = 'w';
cfg.comment            = num2str(stat_we.time(index));
ft_topoplotER(cfg,stat_we);
colorbar

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
times = sum(stat_f1.prob <= 0.05);
plot(stat_f1.time,times)
[x,y] = findpeaks(times);

fig = figure('position',[1 1 300 300]);
set(fig,'PaperPosition',[1 1 300 300])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

index = y(2)
cmap  = colormap('gray')
cmap  = cmap(end:-1:1,:)
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat_f1.time(index) stat_f1.time(index)];
cfg.zlim               = [0 5]; % F-values
cfg.colormap           = cmap;
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
indchan = []; indchan  = find(stat_f1.prob(:,index) <0.05);
cfg.highlightchannel   = stat_f1.label(indchan);
cfg.highlightsymbol    = '.';
cfg.highlightsize      = 20;
cfg.highlightcolor     = 'w';
cfg.comment            = num2str(stat_f1.time(index));
ft_topoplotER(cfg,stat_f1);
colorbar

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
times = sum(stat_pare.prob <= 0.05);
plot(stat_pare.time,times)
[x,y] = findpeaks(times);

fig = figure('position',[1 1 300 300]);
set(fig,'PaperPosition',[1 1 300 300])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

index = y(3)
cmap  = colormap('jet')
cmap  = cmap(end:-1:1,:)
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat_pare.time(index) stat_pare.time(index)];
cfg.zlim               = [-5 5]; % F-values
cfg.colormap           = cmap;
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
indchan = []; indchan  = find(stat_pare.prob(:,index) <0.05);
cfg.highlightchannel   = stat_pare.label(indchan);
cfg.highlightsymbol    = '.';
cfg.highlightsize      = 20;
cfg.highlightcolor     = 'w';
cfg.comment            = num2str(stat_pare.time(index));
ft_topoplotER(cfg,stat_pare);
colorbar

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
times = sum(stat_we1.prob <= 0.05);
plot(stat_we1.time,times)
[x,y] = findpeaks(times);

fig = figure('position',[1 1 300 300]);
set(fig,'PaperPosition',[1 1 300 300])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

index = y(5)
cmap  = colormap('jet')
cmap  = cmap(end:-1:1,:)
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat_we1.time(index) stat_we1.time(index)];
cfg.zlim               = [-5 5]; % F-values
cfg.colormap           = cmap;
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
indchan = []; indchan  = find(stat_we1.prob(:,index) <0.05);
cfg.highlightchannel   = stat_we1.label(indchan);
cfg.highlightsymbol    = '.';
cfg.highlightsize      = 20;
cfg.highlightcolor     = 'w';
cfg.comment            = num2str(stat_we1.time(index));
ft_topoplotER(cfg,stat_we1);
colorbar


