addpath('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/PLOTTING_PAPER')

%% TEST INPUT
condnames_clust= {'RefPast';'RefPre';'RefFut'};
condnames    = {'RefPast';'RefPre';'RefFut'};
latency      = [0.3 1.1];
graphcolor   = [[1 0.7 0.7];[0 0 0];[1 0 0]];
stat_test    = 'F';
chansel      = 'Mags';
clustnum     = 0;
clusttype    = 'posclust';
timetag      = '2016510191545';

[ch, cdn, cdn_clust, stat, GDAVG, GDAVGt] = prepare_comp(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

clust  = find(sum(stat.prob <= 0.05) > 0);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% cluster frontal
times = sum(stat.prob <= 0.05);
plot(stat.time,times)
[x,y] = findpeaks(times);

chan_front =  {'MEG0111', 'MEG0121', 'MEG0131', 'MEG0141', 'MEG0211', 'MEG0221',...
    'MEG0231', 'MEG0241', 'MEG0311', 'MEG0321', 'MEG0331', 'MEG0341', 'MEG0411',...
    'MEG0421', 'MEG0431', 'MEG0441', 'MEG0511', 'MEG0521', 'MEG0531', 'MEG0541',...
    'MEG0611', 'MEG0621', 'MEG0631', 'MEG0641', 'MEG0711', 'MEG0721', 'MEG0731',...
    'MEG0741', 'MEG0811', 'MEG0821', 'MEG0911', 'MEG0921', 'MEG0931', 'MEG0941',...
    'MEG1011', 'MEG1021', 'MEG1031', 'MEG1041', 'MEG1111', 'MEG1121', 'MEG1131',...
    'MEG1141', 'MEG1211', 'MEG1221', 'MEG1231', 'MEG1241', 'MEG1311', 'MEG1321',...
    'MEG1331', 'MEG1341', 'MEG1411', 'MEG1421', 'MEG1431', 'MEG1441', 'MEG1511',...
    'MEG1521', 'MEG1541', 'MEG1611', 'MEG1621', 'MEG1811', 'MEG1821', 'MEG1831',...
    'MEG1841', 'MEG2211', 'MEG2221', 'MEG2231', 'MEG2241', 'MEG2411', 'MEG2421',...
    'MEG2611', 'MEG2621', 'MEG2641'}
% chan_post  = {'MEG1521', 'MEG1531', 'MEG1541', 'MEG1611', 'MEG1621', 'MEG1631',...
%               'MEG1641', 'MEG1711', 'MEG1721', 'MEG1731', 'MEG1741', 'MEG1811',...
%               'MEG1911', 'MEG1941'}
indchan = []; indchan = find(stat.prob(:,y(5)) <0.05);  

% get the channel list exclusing forntal sensors     
posterior_chan = setdiff(stat.label ,chan_front)

% get the indexes of posterior sensor
ind_post = []
count = 1;
for i = 1:length(stat.label)
    for j = 1:length(posterior_chan)
        if strcmp(stat.label{i},posterior_chan{j})
            ind_post(count) = i;
            count = count +1;
        end
    end
end

% get the indexes of posterior sensor
ind_ant = []
count = 1;
for i = 1:length(stat.label)
    for j = 1:length(chan_front)
        if strcmp(stat.label{i},chan_front{j})
            ind_ant(count) = i;
            count = count +1;
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%% load REG clusters %%%%%%%%%%%%%%%%%%%%%%%%
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

[ch2, cdn2, cdn_clust2, stat2, GDA2VG2, GDAVGt2] = prepare_comp(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)
clust2  = find(sum(stat2.prob <= 0.05) > 0);

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

[ch3, cdn3, cdn_clust3, stat3, GDAVG3, GDAVG3t] = prepare_comp(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)
clust3  = find(sum(stat3.prob <= 0.05) > 0);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%%%%%% PLOT TIMECOURSE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/MISC_data/indchan_common_mags_reftime_reg.mat')

%% cluster avg post clust
fig = figure('position',[1 1 1300 1000]);
set(fig,'PaperPosition',[1 1 1300 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
subplot(2,1,1)

% determine figure size base on amplitude on avg cluster activity
valmax = max([max(mean(GDAVG{1}.avg(indchancommon,:))) ...
         max(mean(GDAVG{2}.avg(indchancommon,:))) ...
         max(mean(GDAVG{3}.avg(indchancommon,:)))]);
valmin = min([min(mean(GDAVG{1}.avg(indchancommon,:))) ...
         min(mean(GDAVG{2}.avg(indchancommon,:))) ...
         min(mean(GDAVG{3}.avg(indchancommon,:)))]);
% fmult
fmult = 1e14; % for express in uV

% define axes limit and plot properties
set_axes(-0.7, 5, -6,5)

% stimulus onsets
line([0 0]    ,[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on
line([1.1 1.1],[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on
line([2.2 2.2],[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on
line([3.4 3.4],[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on
line([4.6 4.6],[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on

% timecourse
plot(GDAVG{1}.time,mean(GDAVG{1}.avg(indchancommon,:)*fmult),'linewidth',4,'color',graphcolor(1,:));hold on
plot(GDAVG{1}.time,mean(GDAVG{2}.avg(indchancommon,:)*fmult),'linewidth',4,'color',graphcolor(2,:));hold on
plot(GDAVG{1}.time,mean(GDAVG{3}.avg(indchancommon,:)*fmult),'linewidth',4,'color',graphcolor(3,:));hold on

% cluster stats line
cmap = colormap('jet')
plot_lin_shade_v2(clust2,0.05, stat2,-5,5,[0 0.5 1],-5.5,indchancommon,cmap,[-5 5])
plot_lin_shade_v2(clust3,0.05, stat3,-5,5,[0 0.5 1],-5.5,indchancommon,cmap,[-5 5])

%% cluster avg post clust
subplot(2,1,2)

indchan = find(stat.prob(:,y(5)) <0.05)
indchanpost = intersect(ind_post, indchan)
% determine figure size base on amplitude on avg cluster activity
valmax = max([max(mean(GDAVG{1}.avg(indchanpost,:))) ...
         max(mean(GDAVG{2}.avg(indchanpost,:))) ...
         max(mean(GDAVG{3}.avg(indchanpost,:)))]);
valmin = min([min(mean(GDAVG{1}.avg(indchanpost,:))) ...
         min(mean(GDAVG{2}.avg(indchanpost,:))) ...
         min(mean(GDAVG{3}.avg(indchanpost,:)))]);
% fmult
fmult = 1e14; % for express in uV

% define axes limit and plot properties
set_axes(-0.7, 5, -10,10)

% stimulus onsets
line([0 0]    ,[-7 9],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on
line([1.1 1.1],[-7 9],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on
line([2.2 2.2],[-7 9],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on
line([3.4 3.4],[-7 9],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on
line([4.6 4.6],[-7 9],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on

% cluster stats line
cmap = colormap('gray')
cmap = cmap(end:-1:1,:)
plot_lin_shade_v2(clust,0.05, stat,-5,5,[0 0.5 1],-9,indchanpost,cmap,[0 5])

% timecourse
plot(GDAVG{1}.time,mean(GDAVG{1}.avg(indchanpost,:)*fmult),'linewidth',4,'color',graphcolor(1,:));hold on
plot(GDAVG{1}.time,mean(GDAVG{2}.avg(indchanpost,:)*fmult),'linewidth',4,'color',graphcolor(2,:));hold on
plot(GDAVG{1}.time,mean(GDAVG{3}.avg(indchanpost,:)*fmult),'linewidth',4,'color',graphcolor(3,:));hold on

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/MISC_PLOTS/Figures_PAPER/reg_mags_timecourse_ref_timeforPANEL')

%% PART: 2 TOPOGRAPHY OF REGRESSION TEST


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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% cluster 1 for common chans
alpha = 0.05
indchan1 = []; indchan1 = find(stat.prob(:,y(19)) <alpha);
indchan2 = []; indchan2 = find(stat.prob(:,y(5)) <alpha);

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
% %% get a representative spatial filter for the cluster
times = sum(stat.prob <= 0.05);
plot(stat.time,times)
[x,y] = findpeaks(times);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% cluster 1 for common chans
alpha = 0.05
indchan3 = []; indchan3 = find(stat.prob(:,y(10)) <alpha);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% common chans
indchan = []
indchancommon = intersect(intersect(indchan1,indchan2),indchan3)

%%  
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

times = sum(stat.prob <= 0.05);
plot(stat.time,times)
[x,y] = findpeaks(times);

%% plot topo

times = sum(stat.prob <= 0.05);
plot(stat.time,times)
[x,y] = findpeaks(times);

fig = figure('position',[1 1 300 300]);
set(fig,'PaperPosition',[1 1 300 300])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

count = 1
for index = y
    subplot(5,5,count)
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
cfg.highlight          = 'on';
cfg.highlightchannel   = stat.label(indchan);
cfg.highlightsymbol    = '.';
cfg.highlightsize      = 20;
cfg.highlightcolor     = 'w';
cfg.comment            = num2str(stat.time(index));
ft_topoplotER(cfg,stat);
count = count +1
end
colorbar

%% plot barplots

%%
fmult  = 1e14
clust  = find(sum(stat.prob <= alpha) > 0);
indchan = []; indchan = find(stat.prob(:,index) <alpha);

% cluster pieces
t = [];
for i = 1:length(clust)-1
    if abs(clust(i+1) - clust(i)) > 1
        t = [t i i+1];
    end
end

interval = [];

if length(t) >2

    Tstart(1) = find(abs(GDAVGt{3}.time - stat.time(clust(1))) < 1e-6);
    Tend(1)   = find(abs(GDAVGt{3}.time - stat.time(clust(t(1)))) < 1e-6);
    interval = [Tstart(1):Tend(1)];
    
    for i = 2:2:length(t)-1 
        Tstart(i/2+1) = find(abs(GDAVGt{3}.time - stat.time(clust(t(i)))) < 1e-6);
        Tend(i/2+1)   = find(abs(GDAVGt{3}.time - stat.time(clust(t(i+1)))) < 1e-6);
        interval = [interval Tstart(i/2+1):Tend(i/2+1)];
    end
    
    Tstart(i/2+2) = find(abs(GDAVGt{3}.time - stat.time(clust(t(i)))) < 1e-6);
    Tend(i/2+2)   = find(abs(GDAVGt{3}.time - stat.time(clust(end))) < 1e-6);   
    interval = [interval Tstart(i/2+2):Tend(i/2+2)];

elseif length(t) == 2
    Tstart(1) = find(abs(GDAVGt{3}.time - stat.time(clust(1))) < 1e-6);
    Tend(1)   = find(abs(GDAVGt{3}.time - stat.time(clust(t(1)))) < 1e-6);
    Tstart(2) = find(abs(GDAVGt{3}.time - stat.time(clust(t(2)))) < 1e-6);
    Tend(2)   = find(abs(GDAVGt{3}.time - stat.time(clust(end))) < 1e-6);  
    interval  = [Tstart(1):Tend(1) Tstart(2):Tend(2)];
else
    Tstart(1) = find(abs(GDAVGt{3}.time - stat.time(clust(1))) < 1e-6);
    Tend(1)   = find(abs(GDAVGt{3}.time - stat.time(clust(end))) < 1e-6);
    interval = [Tstart(1):Tend(1)];
    
end

data1 = mean(mean(GDAVGt{1}.individual(:,indchan,Tstart(2):Tend(2)),2),3)*fmult;
data2 = mean(mean(GDAVGt{2}.individual(:,indchan,Tstart(2):Tend(2)),2),3)*fmult;
data3 = mean(mean(GDAVGt{3}.individual(:,indchan,Tstart(2):Tend(2)),2),3)*fmult;

%
fig = figure('position',[1 1 300 400]);
set(fig,'PaperPosition',[1 1 300 400])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

bar([mean(data1) 0 0],'facecolor',graphcolor(1,:),'edgecolor',graphcolor(1,:));hold on
bar([0 mean(data2) 0],'facecolor',graphcolor(2,:),'edgecolor',graphcolor(1,:));hold on
bar([0 0 mean(data3)],'facecolor',graphcolor(3,:),'edgecolor',graphcolor(1,:));hold on
errorbar(1,mean(data1),std(data1)./sqrt(19),'linestyle','none','color',graphcolor(1,:),'linewidth',3)
errorbar(2,mean(data2),std(data2)./sqrt(19),'linestyle','none','color',graphcolor(2,:),'linewidth',3)
errorbar(3,mean(data3),std(data3)./sqrt(19),'linestyle','none','color',graphcolor(3,:),'linewidth',3)
axis([0 4 -4 4])
set(gca, 'box','off','linewidth',2,'fontsize',20,'fontweight','b');

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/MISC_PLOTS/panel/Cluster_REG_REFTIME')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
times = sum(stat3.prob <= 0.05);
plot(stat3.time,times)
[x,y] = findpeaks(times);

figure
count = 1;
for i = y
    subplot(5,5,count)
    cmap                   = colormap('jet');
    cfg                    = [];
    cfg.layout             = lay;
    cfg.xlim               = [stat3.time(i) stat3.time(i)];
    cfg.zlim               = [-5 5]; % F-values
    cfg.style              = 'straight';      
    cfg.colormap           = cmap;
    cfg.parameter          = 'stat';
    cfg.marker             = 'off';
    cfg.highlight          = 'on';
    indchan = []; indchan = find(stat3.prob(:,i) <0.05);
    cfg.highlight          = 'off';
    cfg.highlightchannel   = stat3.label(indchan);
    cfg.highlightsymbol    = '.';
    cfg.highlightsize      = 20;
    cfg.highlightcolor     = 'w';
    cfg.comment            = num2str(stat3.time(i));
    ft_topoplotER(cfg,stat3);
    count = count + 1;
end

