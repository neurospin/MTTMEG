addpath('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/PLOTTING_PAPER')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%%%%% MAGS CLUSTERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

[ch_prefut, cdn_prefut, cdn_clust_prefut, stat_prefut, GDAVG_prefut, GDAVGt_prefut] = prepare_comp(niplist,condnames,...
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

[ch_pasfut, cdn_pasfut, cdn_clust_pasfut, stat_pasfut, GDAVG_pasfut, GDAVGt_pasfut] = prepare_comp(niplist,condnames,...
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

[ch_pasfut2, cdn_pasfut2, cdn_clust_pasfut2, stat_pasfut2, GDAVG_pasfut2, GDAVGt_pasfut2] = prepare_comp(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

%% TEST INPUT 1 mags occipital
condnames_clust = {'RefPre';'RefPast'};
condnames    = {'RefPre';'RefPast'};
latency      = [3.4 4.6];
graphcolor   = [[1 0 0];[1 0.7 0.7];];
stat_test    = 'T';
chansel      = 'Mags';
clustnum     = 0;
clusttype    = 'negclust';
timetag      = '201671114402';

[ch_prepas, cdn_prepas, cdn_clust_prepas, stat_prepas, GDAVG_prepas, GDAVGt_prepas] = prepare_comp(niplist,condnames,...
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
lay                        = ft_prepare_layout(cfg,GDAVG_prefut{1});
lay.label                = GDAVGt_prefut{1}.label;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
times = sum(stat_pasfut2.prob <= 0.05);
plot(stat_pasfut2.time,times)
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
    cfg.xlim               = [stat_pasfut2.time(index) stat_pasfut2.time(index)];
    cfg.zlim               = [-10 10]; % F-values
    cfg.colormap           = 'jet';
    cfg.style              = 'straight';
    cfg.parameter          = 'stat';
    cfg.marker             = 'off';
    cfg.highlight          = 'on';
    indchan = []; indchan = find(stat_pasfut2.prob(:,index) <0.05);
    cfg.highlightchannel   = stat_pasfut2.label(indchan);
    cfg.highlightsymbol    = '.';
    cfg.highlightsize      = 20;
    cfg.comment            = num2str(stat_pasfut2.time(index));
    ft_topoplotER(cfg,stat_pasfut2);
    count = count +1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
times = sum(stat_prepas.prob <= 0.05);
plot(stat_prepas.time,times)
[x,y] = findpeaks(times);
indchan_prepas = find(stat_prepas.prob(:,y(2)) <0.05);
clust_prepas  = find(sum(stat_prepas.prob <= 0.05) > 0);

times = sum(stat_pasfut.prob <= 0.05);
plot(stat_pasfut.time,times)
[x,y] = findpeaks(times);
indchan_pasfut = find(stat_pasfut.prob(:,y(15)) <0.05);
clust_pasfut  = find(sum(stat_pasfut.prob <= 0.05) > 0);

times = sum(stat_pasfut2.prob <= 0.05);
plot(stat_pasfut2.time,times)
[x,y] = findpeaks(times);
indchan_pasfut2 = find(stat_pasfut2.prob(:,y(19)) <0.05);
clust_pasfut2  = find(sum(stat_pasfut2.prob <= 0.05) > 0);

indchan_mags = intersect(indchan_prepas,intersect(indchan_pasfut, indchan_pasfut2))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 300 300]);
set(fig,'PaperPosition',[1 1 300 300])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
cmap = colormap('gray');
index = y(4);
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat_pasfut2.time(index) stat_pasfut2.time(index)];
cfg.zlim               = [-5 5]; % F-values
cfg.colormap           = cmap;
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
cfg.highlight          = {'on'};
cfg.highlightchannel   = {stat_pasfut2.label(indchan_mags)};
cfg.highlightsymbol    = {'.'};
cfg.highlightsize      = {30,30} ;
cfg.highlightcolor     = {'k'};
cfg.comment            = num2str(stat_pasfut2.time(index));
ft_topoplotER(cfg,stat_pasfut2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 1000 1000]);
set(fig,'PaperPosition',[1 1 1000 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
subplot(2,1,1)

% color of each conditions
graphcolor   = [[0 0 0];[1 0.7 0.7];[1 0 0]];

% determine figure size base on amplitude on avg cluster activity
valmax = max([max(mean(GDAVG_prepas{1}.avg(indchan_mags,:))) ...
         max(mean(GDAVG_prepas{2}.avg(indchan_mags,:)))]);
valmin = min([min(mean(GDAVG_prepas{1}.avg(indchan_mags,:))) ...
         min(mean(GDAVG_prepas{2}.avg(indchan_mags,:)))]);
% fmult
fmult = 1e14; % for express in uV
% define axes limit and plot properties
set_axes(-0.7, 5, -8,5.5)

% stimulus onsets
line([0 0]    ,[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on
line([1.1 1.1],[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on
line([2.2 2.2],[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on
line([3.4 3.4],[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on
line([4.6 4.6],[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on

% cluster shade
cmap = colormap('jet')
cmap_inv = cmap(end:-1:1,:)
plot_lin_shade_v2(clust_prepas ,0.05 , stat_prepas ,-6.5,5,[0.7 0.7 0.7],-6,indchan_mags,cmap_inv,[-5 5])
plot_lin_shade_v2(clust_pasfut ,0.05 , stat_pasfut ,-6.5,5,[0.7 0.7 0.7],-7,indchan_mags,cmap_inv,[-5 5])
plot_lin_shade_v2(clust_pasfut2 ,0.05, stat_pasfut2,-6.5,5,[0.7 0.7 0.7],-7,indchan_mags,cmap_inv,[-5 5])

% timecourse
plot(GDAVG_prepas{1}.time,mean(GDAVG_prepas{1}.avg(indchan_mags,:)*fmult),'linewidth',4,'color',graphcolor(1,:));hold on
plot(GDAVG_prepas{1}.time,mean(GDAVG_prepas{2}.avg(indchan_mags,:)*fmult),'linewidth',4,'color',graphcolor(2,:));hold on
plot(GDAVG_pasfut{1}.time,mean(GDAVG_pasfut{2}.avg(indchan_mags,:)*fmult),'linewidth',4,'color',graphcolor(3,:));hold on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 300 300]);
set(fig,'PaperPosition',[1 1 300 300])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

times = sum(stat_prepas.prob <= 0.05);
plot(stat_prepas.time,times)
[x,y] = findpeaks(times);

cmap = colormap('jet');
index = y(2);
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat_prepas.time(index) stat_prepas.time(index)];
cfg.zlim               = [-5 5]; % F-values / T-values
cfg.colormap           = cmap(end:-1:1,:);
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
cfg.highlight          = {'on'};
cfg.highlightchannel   = {stat_prepas.label(indchan_mags)};
cfg.highlightsymbol    = {'.'};
cfg.highlightsize      = {20} ;
cfg.highlightcolor     = {'w'};
cfg.comment            = num2str(stat_prepas.time(index));
ft_topoplotER(cfg,stat_prepas);
colorbar

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 300 300]);
set(fig,'PaperPosition',[1 1 300 300])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

times = sum(stat_pasfut2.prob <= 0.05);
plot(stat_pasfut2.time,times)
[x,y] = findpeaks(times);

cmap = colormap('jet');
index = y(19);
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat_pasfut2.time(index) stat_pasfut2.time(index)];
cfg.zlim               = [-5 5]; % F-values / T-values
cfg.colormap           = cmap(end:-1:1,:);
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
cfg.highlight          = {'on'};
cfg.highlightchannel   = {stat_pasfut2.label(indchan_mags)};
cfg.highlightsymbol    = {'.'};
cfg.highlightsize      = {20} ;
cfg.highlightcolor     = {'w'};
cfg.comment            = num2str(stat_pasfut2.time(index));
ft_topoplotER(cfg,stat_pasfut2);
colorbar



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%%%%%% EEG CLUSTERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

[ch_prefut, cdn_prefut, cdn_clust_prefut, stat_prefut, GDAVG_prefut, GDAVGt_prefut] = prepare_comp(niplist,condnames,...
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

[ch_prefut2, cdn_prefut2, cdn_clust_prefut2, stat_prefut2, GDAVG_prefut2, GDAVGt_prefut2] = prepare_comp(niplist,condnames,...
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

[ch_prefut3, cdn_prefut3, cdn_clust_prefut3, stat_prefut3, GDAVG_prefut3, GDAVGt_prefut3] = prepare_comp(niplist,condnames,...
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

[ch_pasfut, cdn_pasfut, cdn_clust_pasfut, stat_pasfut, GDAVG_pasfut, GDAVGt_pasfut] = prepare_comp(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

%% TEST INPUT 1 eeg occipital
condnames_clust = {'RefPre';'RefPast'};
condnames    = {'RefPre';'RefPast'};
latency      = [2.2 3.4];
graphcolor   = [[1 0 0];[1 0.7 0.7];];
stat_test    = 'T';
chansel      = 'EEG';
clustnum     = 0;
clusttype    = 'posclust';
timetag      = '2016711145949';

[ch_prepas, cdn_prepas, cdn_clust_prepas, stat_prepas, GDAVG_prepas, GDAVGt_prepas] = prepare_comp(niplist,condnames,...
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
lay                        = ft_prepare_layout(cfg,GDAVG_prefut{1});
lay.label                = GDAVGt_prefut{1}.label;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
times = sum(stat_pasfut.prob <= 0.05);
plot(stat_pasfut.time,times)
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
    cfg.xlim               = [stat_pasfut.time(index) stat_pasfut.time(index)];
    cfg.zlim               = [-10 10]; % F-values
    cfg.colormap           = 'jet';
    cfg.style              = 'straight';
    cfg.parameter          = 'stat';
    cfg.marker             = 'off';
    cfg.highlight          = 'on';
    indchan = []; indchan = find(stat_pasfut.prob(:,index) <0.05);
    cfg.highlightchannel   = stat_pasfut.label(indchan);
    cfg.highlightsymbol    = '.';
    cfg.highlightsize      = 20;
    cfg.comment            = num2str(stat_pasfut.time(index));
    ft_topoplotER(cfg,stat_pasfut);
    count = count +1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
times = sum(stat_prepas.prob <= 0.05);
plot(stat_prepas.time,times)
[x,y] = findpeaks(times);
indchan_prepas = find(stat_prepas.prob(:,y(6)) <0.05);
clust_prepas  = find(sum(stat_prepas.prob <= 0.05) > 0);

times = sum(stat_prefut.prob <= 0.05);
plot(stat_prefut.time,times)
[x,y] = findpeaks(times);
indchan_prefut = find(stat_prefut.prob(:,y(9)) <0.05);
clust_prefut  = find(sum(stat_prefut.prob <= 0.05) > 0);

times = sum(stat_prefut2.prob <= 0.05);
plot(stat_prefut2.time,times)
[x,y] = findpeaks(times);
indchan_prefut2 = find(stat_prefut2.prob(:,y(2)) <0.05);
clust_prefut2  = find(sum(stat_prefut2.prob <= 0.05) > 0);

times = sum(stat_prefut3.prob <= 0.05);
plot(stat_prefut3.time,times)
[x,y] = findpeaks(times);
indchan_prefut3 = find(stat_prefut3.prob(:,y(9)) <0.05);
clust_prefut3  = find(sum(stat_prefut3.prob <= 0.05) > 0);

times = sum(stat_pasfut.prob <= 0.05);
plot(stat_pasfut.time,times)
[x,y] = findpeaks(times);
indchan_pasfut = find(stat_pasfut.prob(:,y(2)) <0.05);
clust_pasfut  = find(sum(stat_pasfut.prob <= 0.05) > 0);

indchan_tmp1 = intersect(indchan_prefut2 ,intersect(indchan_prefut3,indchan_prefut))
indchan_tmp2 = intersect(indchan_pasfut,indchan_prepas)
indchantimes = sum(stat_prepas.prob <= 0.05);
plot(stat_prepas.time,times)
[x,y] = findpeaks(times);
indchan_prepas = find(stat_prepas.prob(:,y(6)) <0.05);
clust_prepas  = find(sum(stat_prepas.prob <= 0.05) > 0);
_eeg  = intersect(indchan_tmp1,indchan_tmp2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 300 300]);
set(fig,'PaperPosition',[1 1 300 300])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
cmap = colormap('gray');
index = y(2);
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat_pasfut2.time(index) stat_pasfut2.time(index)];
cfg.zlim               = [-5 5]; % F-values
cfg.colormap           = cmap;
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
cfg.highlight          = {'on'};
cfg.highlightchannel   = {stat_pasfut2.label(indchan_eeg)};
cfg.highlightsymbol    = {'.'};
cfg.highlightsize      = {30,30} ;
cfg.highlightcolor     = {'k'};
cfg.comment            = num2str(stat_pasfut2.time(index));
ft_topoplotER(cfg,stat_pasfut2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 1000 1000]);
set(fig,'PaperPosition',[1 1 1000 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
subplot(2,1,1)

% color of each conditions
graphcolor   = [[0 0 0];[1 0.7 0.7];[1 0 0]];

% fmult
fmult = 1e6; % for express in uV
% define axes limit and plot properties
set_axes(-0.7, 5, -5,6)

% stimulus onsets
line([0 0]    ,[-3 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on
line([1.1 1.1],[-3 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on
line([2.2 2.2],[-3 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on
line([3.4 3.4],[-3 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on
line([4.6 4.6],[-3 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on

% cluster shade
cmap = colormap('jet')
cmap_inv = cmap(end:-1:1,:)
plot_lin_shade_v2(clust_prepas ,0.05 , stat_prepas ,-6.5,5,[0.7 0.7 0.7],-2.5,indchan_eeg,cmap_inv,[-5 5])
plot_lin_shade_v2(clust_prefut ,0.05 , stat_prefut ,-6.5,5,[0.7 0.7 0.7],-3.5,indchan_eeg,cmap_inv,[-5 5])
plot_lin_shade_v2(clust_prefut2,0.05 , stat_prefut2,-6.5,5,[0.7 0.7 0.7],-3.5,indchan_eeg,cmap_inv,[-5 5])
plot_lin_shade_v2(clust_prefut3,0.05 , stat_prefut3,-6.5,5,[0.7 0.7 0.7],-3.5,indchan_eeg,cmap_inv,[-5 5])
plot_lin_shade_v2(clust_pasfut ,0.05 , stat_pasfut ,-6.5,5,[0.7 0.7 0.7],-4.5,indchan_eeg,cmap_inv,[-5 5])

% timecourse
plot(GDAVG_prepas{1}.time,mean(GDAVG_prepas{1}.avg(indchan_eeg,:)*fmult),'linewidth',4,'color',graphcolor(1,:));hold on
plot(GDAVG_prepas{1}.time,mean(GDAVG_prepas{2}.avg(indchan_eeg,:)*fmult),'linewidth',4,'color',graphcolor(2,:));hold on
plot(GDAVG_pasfut{1}.time,mean(GDAVG_pasfut{2}.avg(indchan_eeg,:)*fmult),'linewidth',4,'color',graphcolor(3,:));hold on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 300 300]);
set(fig,'PaperPosition',[1 1 300 300])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

times = sum(stat_prepas.prob <= 0.05);
plot(stat_prepas.time,times)
[x,y] = findpeaks(times);

cmap = colormap('jet');
index = y(6);
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat_prepas.time(index) stat_prepas.time(index)];
cfg.zlim               = [-5 5]; % F-values / T-values
cfg.colormap           = cmap(end:-1:1,:);
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
cfg.highlight          = {'on'};
cfg.highlightchannel   = {stat_prepas.label(indchan_eeg)};
cfg.highlightsymbol    = {'.'};
cfg.highlightsize      = {20} ;
cfg.highlightcolor     = {'w'};
cfg.comment            = num2str(stat_prepas.time(index));
ft_topoplotER(cfg,stat_prepas);
colorbar

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 300 300]);
set(fig,'PaperPosition',[1 1 300 300])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

times = sum(stat_prefut.prob <= 0.05);
plot(stat_prefut.time,times)
[x,y] = findpeaks(times);

cmap = colormap('jet');
index = y(9);
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat_prefut.time(index) stat_prefut.time(index)];
cfg.zlim               = [-5 5]; % F-values / T-values
cfg.colormap           = cmap(end:-1:1,:);
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
cfg.highlight          = {'on'};
cfg.highlightchannel   = {stat_prefut.label(indchan_eeg)};
cfg.highlightsymbol    = {'.'};
cfg.highlightsize      = {20} ;
cfg.highlightcolor     = {'w'};
cfg.comment            = num2str(stat_prefut.time(index));
ft_topoplotER(cfg,stat_prefut);
colorbar

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 300 300]);
set(fig,'PaperPosition',[1 1 300 300])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

times = sum(stat_pasfut.prob <= 0.05);
plot(stat_pasfut.time,times)
[x,y] = findpeaks(times);

cmap = colormap('jet');
index = y(2);
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat_pasfut.time(index) stat_pasfut.time(index)];
cfg.zlim               = [-5 5]; % F-values / T-values
cfg.colormap           = cmap(end:-1:1,:);
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
cfg.highlight          = {'on'};
cfg.highlightchannel   = {stat_pasfut.label(indchan_eeg)};
cfg.highlightsymbol    = {'.'};
cfg.highlightsize      = {20} ;
cfg.highlightcolor     = {'w'};
cfg.comment            = num2str(stat_pasfut.time(index));
ft_topoplotER(cfg,stat_pasfut);
colorbar


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
times = sum(stat_pasfut2.prob <= 0.05);
plot(stat_pasfut2.time,times)
[x,y] = findpeaks(times);

figure
count = 1;
for i = y
    subplot(5,5,count)
    cmap                   = colormap('jet');
    cfg                    = [];
    cfg.layout             = lay;
    cfg.xlim               = [stat_pasfut2.time(i) stat_pasfut2.time(i)];
    cfg.zlim               = [-5 5]; % F-values
    cfg.style              = 'straight';      
    cfg.colormap           = cmap;
    cfg.parameter          = 'stat';
    cfg.marker             = 'off';
    cfg.highlight          = 'on';
    indchan = []; indchan = find(stat_pasfut2.prob(:,i) <0.05);
    cfg.highlight          = 'off';
    cfg.highlightchannel   = stat_pasfut2.label(indchan);
    cfg.highlightsymbol    = '.';
    cfg.highlightsize      = 20;
    cfg.highlightcolor     = 'w';
    cfg.comment            = num2str(stat_pasfut2.time(i));
    ft_topoplotER(cfg,stat_pasfut2);
    count = count + 1;
end
