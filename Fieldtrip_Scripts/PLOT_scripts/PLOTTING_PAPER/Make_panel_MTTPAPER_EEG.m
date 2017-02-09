addpath('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/PLOTTING_PAPER')

%% TEST INPUT
condnames    = {'RefPast';'RefPre';'RefFut'};
condnames_clust   = {'RefPast';'RefPre';'RefFut'};
latency      = [1.1 2];
graphcolor   = [[1 0.7 0.7];[0 0 0];[1 0 0]];
stat_test    = 'F';
chansel      = 'EEG';
clustnum     = 0;
clusttype    = 'posclust';
timetag      = '201659184413';

[ch, cdn, cdn_clust, stat, GDAVG, GDAVGt] = prepare_comp(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%% THE BEST PLOTTING MODE %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
%%%%%%%%%%%%%%%%%%%%%%%% EXPLORATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/misc/inchancommon_eeg.mat')

% plot spatiotemporal structure of the cluster
% and get highest cluster covergae and the corresponding time
times = sum(stat.prob <= 0.05);
plot(stat.time,times)
[x,y] = findpeaks(times);

count = 1
for index = y
    subplot(5,5,count)
    cmap                   = colormap('jet');
    cfg                    = [];
    cfg.layout             = lay;
    cfg.xlim               = [stat.time(index) stat.time(index)];
    cfg.zlim               = [-10 10]; % F-values
    cfg.style              = 'straight';
    cmap = colormap('gray')
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
    
    count = count +1
end

%% get the common spatial filter
[x,y] = findpeaks(times);
timeofinterest1 = 165;
indchan1 = find(stat.prob(:,165) <0.05);

fig = figure('position',[1 1 300 300]);
set(fig,'PaperPosition',[1 1 300 300])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat.time(index) stat.time(index)];
cfg.zlim               = [0 10]; % F-values
cfg.style              = 'straight';
cmap = colormap('gray')
cfg.colormap           = cmap;
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
indchan = []; indchan = find(stat.prob(:,index) <0.05);
cfg.highlight          = {'on','on'};
cfg.highlightchannel   = {stat.label(indchan),stat.label(indchancommon)};
cfg.highlightsymbol    = {'.','.'};
cfg.highlightsize      = {30,40} ;
cfg.highlightcolor     = {'k','w'};
cfg.comment            = num2str(stat.time(index));
ft_topoplotER(cfg,stat);

%% TEST INPUT 2
condnames    = {'RefPast';'RefPre';'RefFut'};
condnames_clust   = {'RefPast';'RefPre';'RefFut'};
latency      = [2.2 3.4];
graphcolor   = [[1 0.7 0.7];[0 0 0];[1 0 0]];
stat_test    = 'F';
chansel      = 'EEG';
clustnum     = 0;
clusttype    = 'posclust';
timetag      = '201659191529';

[ch, cdn, cdn_clust, stat, GDAVG, GDAVGt] = prepare_comp(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%% THE BEST PLOTTING MODE %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
%%%%%%%%%%%%%%%%%%%%%%%% EXPLORATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot spatiotemporal structure of the cluster
% and get highest cluster covergae and the corresponding time
times = sum(stat.prob <= 0.051);
plot(stat.time,times)
[x,y] = findpeaks(times);

for index = y

    fig = figure('position',[1 1 500 500]);
    set(fig,'PaperPosition',[1 1 500 500])
    set(fig,'PaperPositionmode','auto')
    set(fig,'Visible','on')
    
    cmap                   = colormap('jet');
    cfg                    = [];
    cfg.layout             = lay;
    cfg.xlim               = [stat.time(index) stat.time(index)];
    cfg.zlim               = [-10 10]; % F-values
    cfg.style              = 'straight';
    cfg.colormap           = 'jet';
    cfg.parameter          = 'stat';
    cfg.marker             = 'off';
    cfg.highlight          = 'on';
    indchan = []; indchan = find(stat.prob(:,index) <0.051);
    cfg.highlight          = {'on','on'};
    cfg.highlightchannel   = {stat.label(indchan),stat.label(indchancommon)};
    cfg.highlightsymbol    = {'.','.'};
    cfg.highlightsize      = {30,60} ;
    cfg.highlightcolor     = {'k','w'};
    cfg.comment            = num2str(stat.time(index));
    ft_topoplotER(cfg,stat);
    
end
timeofinterest2 = 72;
indchan2 = find(stat.prob(:,72) <0.051);

fig = figure('position',[1 1 500 500]);
set(fig,'PaperPosition',[1 1 500 500])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

cfg.highlightchannel   = stat.label(indchan2);
ft_topoplotER(cfg,stat);

%% TEST INPUT 3
condnames    = {'RefPast';'RefPre';'RefFut'};
condnames_clust   = {'RefPast';'RefPre';'RefFut'};
latency      = [3.4 4.6];
graphcolor   = [[1 0.7 0.7];[0 0 0];[1 0 0]];
stat_test    = 'F';
chansel      = 'EEG';
clustnum     = 0;
clusttype    = 'posclust';
timetag      = '201659195910';

[ch, cdn, cdn_clust, stat, GDAVG, GDAVGt] = prepare_comp(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%% THE BEST PLOTTING MODE %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
%%%%%%%%%%%%%%%%%%%%%%%% EXPLORATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot spatiotemporal structure of the cluster
% and get highest cluster covergae and the corresponding time
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

for index = y

    fig = figure('position',[1 1 500 500]);
    set(fig,'PaperPosition',[1 1 500 500])
    set(fig,'PaperPositionmode','auto')
    set(fig,'Visible','on')
    
    cmap                   = colormap('jet');
    cfg                    = [];
    cfg.layout             = lay;
    cfg.xlim               = [stat.time(index) stat.time(index)];
    cfg.zlim               = [-10 10]; % F-values
    cfg.style              = 'straight';
    cfg.colormap           = 'jet';
    cfg.parameter          = 'stat';
    cfg.marker             = 'off';
    cfg.highlight          = 'on';
    indchan = []; indchan = find(stat.prob(:,index) <0.051);
    cfg.highlight          = {'on','on'};
    cfg.highlightchannel   = {stat.label(indchan),stat.label(indchancommon)};
    cfg.highlightsymbol    = {'.','.'};
    cfg.highlightsize      = {30,60} ;
    cfg.highlightcolor     = {'k','w'};
    cfg.comment            = num2str(stat.time(index));
    ft_topoplotER(cfg,stat);
    
end

timeofinterest3 = 183; 
indchan3 = find(stat.prob(:,183) <0.05);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%% Get common set of sensors for all clusters %%%%%%%%%%%%%
% indchancommon = intersect(intersect(indchan2 ,indchan1) , ...
%                 indchan3);
% save('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/misc/inchancommon_eeg','indchancommon')
%             
%% TEST INPUT
condnames    = {'RefPast';'RefPre';'RefFut'};
condnames_clust   = {'RefPast';'RefPre';'RefFut'};
latency      = [1.1 2];
graphcolor   = [[1 0.7 0.7];[0 0 0];[1 0 0]];
stat_test    = 'F';
chansel      = 'EEG';
clustnum     = 0;
clusttype    = 'posclust';
timetag      = '201659184413';

[ch, cdn, cdn_clust, stat1, GDAVG, GDAVGt] = prepare_comp(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

alpha1 = 0.05
clust1  = find(sum(stat1.prob <= alpha1) > 0);

%% TEST INPUT 2
condnames    = {'RefPast';'RefPre';'RefFut'};
condnames_clust   = {'RefPast';'RefPre';'RefFut'};
latency      = [2.2 3.4];
graphcolor   = [[1 0.7 0.7];[0 0 0];[1 0 0]];
stat_test    = 'F';
chansel      = 'EEG';
clustnum     = 0;
clusttype    = 'posclust';
timetag      = '201659191529';

[ch, cdn, cdn_clust, stat2, GDAVG, GDAVGt] = prepare_comp(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

alpha2 = 0.051
clust2  = find(sum(stat2.prob <= alpha2) > 0);

%% TEST INPUT 3
condnames    = {'RefPast';'RefPre';'RefFut'};
condnames_clust   = {'RefPast';'RefPre';'RefFut'};
latency      = [3.4 4.6];
graphcolor   = [[1 0.7 0.7];[0 0 0];[1 0 0]];
stat_test    = 'F';
chansel      = 'EEG';
clustnum     = 0;
clusttype    = 'posclust';
timetag      = '201659195910';

[ch, cdn, cdn_clust, stat3, GDAVG, GDAVGt] = prepare_comp(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

alpha3 = 0.05
clust3  = find(sum(stat3.prob <= alpha3) > 0);

%% plotting parameters
% determine figure size base on amplitude on avg cluster activity
valmax = max([max(mean(GDAVG{1}.avg(indchancommon,:))) ...
         max(mean(GDAVG{2}.avg(indchancommon,:))) ...
         max(mean(GDAVG{3}.avg(indchancommon,:)))]);
valmin = min([min(mean(GDAVG{1}.avg(indchancommon,:))) ...
         min(mean(GDAVG{2}.avg(indchancommon,:))) ...
         min(mean(GDAVG{3}.avg(indchancommon,:)))]);
% fmult
fmult = 1e6; % for express in uV

fig = figure('position',[1 1 1500 600]);
set(fig,'PaperPosition',[1 1 1500 600])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

% cluster shades

[list_start1, list_end1] = plot_clustshade(clust1,alpha1, stat1,-3,6,[0.5 0.5 0.5])   
[list_start2, list_end2] = plot_clustshade(clust2,alpha2, stat2,-2,4,[0.5 0.5 0.5])
[list_start3, list_end3] = plot_clustshade(clust3,alpha3, stat3,-2,4,[0.5 0.5 0.5])
   
% define axes limit and plot properties
set_axes(-0.7, 5, -3,6)

% stimulus onsets
line([0 0]    ,[-3 6],'linestyle',':','linewidth',3,'color',[0.5 0.5 0.5]); hold on
line([1.1 1.1],[-3 6],'linestyle',':','linewidth',3,'color',[0.5 0.5 0.5]); hold on
line([2.2 2.2],[-3 6],'linestyle',':','linewidth',3,'color',[0.5 0.5 0.5]); hold on
line([3.4 3.4],[-3 6],'linestyle',':','linewidth',3,'color',[0.5 0.5 0.5]); hold on

% timecourse
plot(GDAVG{1}.time,mean(GDAVG{1}.avg(indchancommon,:)*fmult),'linewidth',5,'color',graphcolor(1,:));hold on
plot(GDAVG{1}.time,mean(GDAVG{2}.avg(indchancommon,:)*fmult),'linewidth',5,'color',graphcolor(2,:));hold on
plot(GDAVG{1}.time,mean(GDAVG{3}.avg(indchancommon,:)*fmult),'linewidth',5,'color',graphcolor(3,:));hold on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% avg barplot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 300 400]);
set(fig,'PaperPosition',[1 1 300 400])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
data1 = barplotval(GDAVGt,alpha1,stat1,165,graphcolor,[0.3 3.7 -2 4],fmult);
print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/MISC_PLOTS/panel/clust1')

fig = figure('position',[1 1 300 400]);
set(fig,'PaperPosition',[1 1 300 400])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
data2 = barplotval(GDAVGt,alpha2,stat2,72,graphcolor,[0.3 3.7 -2 4],fmult);
print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/MISC_PLOTS/panel/clust2')

fig = figure('position',[1 1 300 400]);
set(fig,'PaperPosition',[1 1 300 400])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
data3 = barplotval(GDAVGt,alpha3,stat3,183,graphcolor,[0.3 3.7 -2 4],fmult);
print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/MISC_PLOTS/panel/clust3')


fig = figure('position',[1 1 300 500]);
set(fig,'PaperPosition',[1 1 300 500])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

data = (data1 + data2 + data3)/3;
plot(1, mean(data(:,1)),'color',graphcolor(1,:),'marker','.','markersize',50,'linewidth',4);hold on
plot(2, mean(data(:,2)),'color',graphcolor(2,:),'marker','.','markersize',50,'linewidth',4);hold on
plot(3, mean(data(:,3)),'color',graphcolor(3,:),'marker','.','markersize',50,'linewidth',4);hold on
errorbar(1,mean(data(:,1)),std(data(:,1))./sqrt(19),'linestyle','none','color',graphcolor(1,:),'linewidth',3)
errorbar(2,mean(data(:,2)),std(data(:,2))./sqrt(19),'linestyle','none','color',graphcolor(2,:),'linewidth',3)
errorbar(3,mean(data(:,3)),std(data(:,3))./sqrt(19),'linestyle','none','color',graphcolor(3,:),'linewidth',3)
axis([0 4 -1.5 2.5])
set(gca, 'box','off','linewidth',2,'fontsize',14,'fontweight','b');
print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/MISC_PLOTS/panel/avg_cluster')

% write for analysis in R
datafolder = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/for_R_data'

DataMat   = [[data(:,1); data(:,2); data(:,3)]...
            [ones(19,1); ones(19,1)*2; ones(19,1)*3]...
            [1:19 1:19 1:19]'];
CondNames = {'Amplitude','Tref','Subject'}

write_csv_for_anova_R(DataMat, CondNames, [datafolder '/EEG_TREF'])



