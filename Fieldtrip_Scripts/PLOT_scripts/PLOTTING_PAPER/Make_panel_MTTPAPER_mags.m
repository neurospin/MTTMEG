addpath('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/PLOTTING_PAPER')

%% TEST INPUT
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
subplot (3,3,count)
cfg.colorbar = 'east';
ft_topoplotER(cfg,stat);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PLOT PART2
alpha = 0.051

times = sum(stat.prob <= alpha);
plot(stat.time,times)
[x,y] = findpeaks(times);
clust  = find(sum(stat.prob <= alpha) > 0);

fig = figure('position',[1 1 400 400]);
set(fig,'PaperPosition',[1 1 400 400])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
statdummy = stat;
statdummy.stat = zeros(size(stat.stat));
cmap = colormap('gray');
index = y(9);
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat.time(index) stat.time(index)];
cfg.zlim               = [-10 10]; % F-values
cfg.colormap           = cmap;
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
indchan = []; indchan = find(stat.prob(:,index) <alpha);
indchanbest = find(stat.stat(:,index) == max(stat.stat(:,index)));
indchan(find(indchan == indchanbest)) = [];
cfg.highlight          = {'on','on'};
cfg.highlightchannel   = {stat.label(indchan),stat.label(indchanbest)};
cfg.highlightsymbol    = {'.','.'};
cfg.highlightsize      = {30,60} ;
cfg.highlightcolor     = {'k','w'};
cfg.comment            = num2str(stat.time(index));
ft_topoplotER(cfg,statdummy);
print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/MISC_PLOTS/dummytopo_mags')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[x,y] = findpeaks(times);
timeofinterest1 = 79;
indchan1 = find(stat.prob(:,79) <0.051);

fig = figure('position',[1 1 300 300]);
set(fig,'PaperPosition',[1 1 300 300])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat.time(index) stat.time(index)];
cfg.zlim               = [-10 10]; % F-values
cfg.colormap           = 'jet';
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
cfg.highlightchannel   = stat.label(indchan1);
cfg.highlightsymbol    = '.';
cfg.highlightsize      = 20;
cfg.comment            = num2str(stat.time(index));
ft_topoplotER(cfg,stat);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% timecourses cluster
alpha = 0.05;

fig = figure('position',[1 1 1600 1100]);
set(fig,'PaperPosition',[1 1 1600 1100])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

%% cluster avg
subplot(2,1,1)

% determine figure size base on amplitude on avg cluster activity
clust  = find(sum(stat.prob <= alpha) > 0);
indchan = []; indchan = find(stat.prob(:,index) <alpha);
valmax = max([max(mean(GDAVG{1}.avg(indchan,:))) ...
         max(mean(GDAVG{2}.avg(indchan,:))) ...
         max(mean(GDAVG{3}.avg(indchan,:)))]);
valmin = min([min(mean(GDAVG{1}.avg(indchan,:))) ...
         min(mean(GDAVG{2}.avg(indchan,:))) ...
         min(mean(GDAVG{3}.avg(indchan,:)))]);
% fmult
fmult = 1e14; % for express in uV
% cluster shade
plot_clustshade(clust,alpha, stat,-2,4,[0.9 0.9 0.9])

% define axes limit and plot properties
set_axes(-0.7, 5, -2,4)

% timecourse
plot(GDAVG{1}.time,mean(GDAVG{1}.avg(indchan,:)*fmult),'linewidth',4,'color',graphcolor(1,:));hold on
plot(GDAVG{1}.time,mean(GDAVG{2}.avg(indchan,:)*fmult),'linewidth',4,'color',graphcolor(2,:));hold on
plot(GDAVG{1}.time,mean(GDAVG{3}.avg(indchan,:)*fmult),'linewidth',4,'color',graphcolor(3,:));hold on

%% cluster best chan
subplot(2,1,2)

% determine figure size base on amplitude on bets channel activity
index = y(9);
% indchanbest = find(stat.stat(:,index) == max(stat.stat(:,index)));
indchanbest = 97
valmax = max([max(GDAVG{1}.avg(indchanbest,:)) ...
         max(GDAVG{2}.avg(indchanbest,:)) ...
         max(GDAVG{3}.avg(indchanbest,:))]);
valmin = min([min(GDAVG{1}.avg(indchanbest,:)) ...
         min(GDAVG{2}.avg(indchanbest,:)) ...
         min(GDAVG{3}.avg(indchanbest,:))]);
% fmult
fmult = 1e14; % for express in uV
% cluster shade
plot_clustshade(clust,alpha, stat, -4,8,[0.9 0.9 0.9])
% define axes limit and plot properties
set_axes(-0.7, 5, -4,8)

% timecourse
plot(GDAVG{1}.time,GDAVG{1}.avg(indchanbest,:)*fmult,'linewidth',4,'color',graphcolor(1,:));hold on
plot(GDAVG{1}.time,GDAVG{2}.avg(indchanbest,:)*fmult,'linewidth',4,'color',graphcolor(2,:));hold on
plot(GDAVG{1}.time,GDAVG{3}.avg(indchanbest,:)*fmult,'linewidth',4,'color',graphcolor(3,:));hold on

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/MISC_PLOTS/mags_counterplot_timecourse')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 1500 600]);
set(fig,'PaperPosition',[1 1 1500 600])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

clust  = find(sum(stat.prob <= 0.051) > 0);
indchan = []; indchan = find(stat.prob(:,index) <alpha);

% define axes limit and plot properties
set_axes(-0.7, 5, -2,3)

% cluster shade
plot_clustshade(clust,alpha, stat, -4,8,[0.5 0.5 0.5])

% stimulus onsets
line([0 0]    ,[-3 6],'linestyle',':','linewidth',3,'color',[0.5 0.5 0.5]); hold on
line([1.1 1.1],[-3 6],'linestyle',':','linewidth',3,'color',[0.5 0.5 0.5]); hold on
line([2.2 2.2],[-3 6],'linestyle',':','linewidth',3,'color',[0.5 0.5 0.5]); hold on
line([3.4 3.4],[-3 6],'linestyle',':','linewidth',3,'color',[0.5 0.5 0.5]); hold on

% timecourse
plot(GDAVG{1}.time,mean(GDAVG{1}.avg(indchan,:))*fmult,'linewidth',4,'color',graphcolor(1,:));hold on
plot(GDAVG{1}.time,mean(GDAVG{2}.avg(indchan,:))*fmult,'linewidth',4,'color',graphcolor(2,:));hold on
plot(GDAVG{1}.time,mean(GDAVG{3}.avg(indchan,:))*fmult,'linewidth',4,'color',graphcolor(3,:));hold on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% avg barplot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
limaxis = [0.3 3.7 -2 2]

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

dat = {};
for i = 1:length(Tstart)
    figure
    
    dat1 = mean(mean(GDAVGt{1}.individual(:,indchan,Tstart(i):Tend(i)),2),3)*fmult;
    dat2 = mean(mean(GDAVGt{2}.individual(:,indchan,Tstart(i):Tend(i)),2),3)*fmult;
    dat3 = mean(mean(GDAVGt{3}.individual(:,indchan,Tstart(i):Tend(i)),2),3)*fmult;

    bar([mean(dat1) 0 0],'facecolor',graphcolor(1,:),'edgecolor','k','linewidth',2);hold on
    bar([0 mean(dat2) 0],'facecolor',graphcolor(2,:),'edgecolor','k','linewidth',2);hold on
    bar([0 0 mean(dat3)],'facecolor',graphcolor(3,:),'edgecolor','k','linewidth',2);hold on
        errorbar(mean([dat1 dat2,dat3]),std([dat1 dat2,dat3])./sqrt(19),'linestyle',...
            'none','color','k','linewidth',3)
    line([0.5 3.5],[0 0],'color','k','linewidth',2);hold on
    axis(limaxis)
    set(gca, 'box','off','linewidth',2,'fontsize',14,'fontweight','b');
    
    dat{i} = [dat1 dat2 dat3];
end

fig = figure('position',[1 1 300 500]);
set(fig,'PaperPosition',[1 1 300 500])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

plot(1, mean(dat{1}(:,1)),'color',graphcolor(1,:),'marker','.','markersize',50,'linewidth',4);hold on
plot(2, mean(dat{1}(:,2)),'color',graphcolor(2,:),'marker','.','markersize',50,'linewidth',4);hold on
plot(3, mean(dat{1}(:,3)),'color',graphcolor(3,:),'marker','.','markersize',50,'linewidth',4);hold on
errorbar(1,mean(dat{1}(:,1)),std(dat{1}(:,1))./sqrt(19),'linestyle','none','color',graphcolor(1,:),'linewidth',3)
errorbar(2,mean(dat{1}(:,2)),std(dat{1}(:,2))./sqrt(19),'linestyle','none','color',graphcolor(2,:),'linewidth',3)
errorbar(3,mean(dat{1}(:,3)),std(dat{1}(:,3))./sqrt(19),'linestyle','none','color',graphcolor(3,:),'linewidth',3)
axis([0 4 -1.5 2.5])
set(gca, 'box','off','linewidth',2,'fontsize',14,'fontweight','b');
print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/MISC_PLOTS/panel/avg_cluster_mag1')

fig = figure('position',[1 1 300 500]);
set(fig,'PaperPosition',[1 1 300 500])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

plot(1, mean(dat{2}(:,1)),'color',graphcolor(1,:),'marker','.','markersize',50,'linewidth',4);hold on
plot(2, mean(dat{2}(:,2)),'color',graphcolor(2,:),'marker','.','markersize',50,'linewidth',4);hold on
plot(3, mean(dat{2}(:,3)),'color',graphcolor(3,:),'marker','.','markersize',50,'linewidth',4);hold on
errorbar(1,mean(dat{2}(:,1)),std(dat{2}(:,1))./sqrt(19),'linestyle','none','color',graphcolor(1,:),'linewidth',3)
errorbar(2,mean(dat{2}(:,2)),std(dat{2}(:,2))./sqrt(19),'linestyle','none','color',graphcolor(2,:),'linewidth',3)
errorbar(3,mean(dat{2}(:,3)),std(dat{2}(:,3))./sqrt(19),'linestyle','none','color',graphcolor(3,:),'linewidth',3)
axis([0 4 -1.5 2.5])
set(gca, 'box','off','linewidth',2,'fontsize',14,'fontweight','b');
print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/MISC_PLOTS/panel/avg_cluster_mag2')


[h,p] = ttest(dat{1}(:,1), dat{1}(:,2))
[h,p] = ttest(dat{1}(:,3), dat{1}(:,2))

[h,p] = ttest(dat{2}(:,1), dat{2}(:,2))
[h,p] = ttest(dat{2}(:,3), dat{2}(:,2))

% write for analysis in R
datafolder = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/for_R_data'

DataMat   = [[dat{1}(:,1);dat{1}(:,2);dat{1}(:,3) ]...
            [ones(19,1); ones(19,1)*2; ones(19,1)*3]...
            [1:19 1:19 1:19]'];
CondNames = {'Amplitude','Tref','Subject'}
write_csv_for_anova_R(DataMat, CondNames, [datafolder '/Mags1_TREF'])

DataMat   = [[dat{2}(:,1);dat{2}(:,2);dat{2}(:,3) ]...
            [ones(19,1); ones(19,1)*2; ones(19,1)*3]...
            [1:19 1:19 1:19]'];
CondNames = {'Amplitude','Tref','Subject'}
write_csv_for_anova_R(DataMat, CondNames, [datafolder '/Mags2_TREF'])

%% TEST INPUT
