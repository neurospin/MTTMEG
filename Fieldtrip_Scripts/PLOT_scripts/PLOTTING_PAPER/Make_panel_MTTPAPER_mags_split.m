
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[x,y] = findpeaks(times);
timeofinterest1 = y(9);
indchan1 = find(stat.prob(:,timeofinterest1) <0.05);

fig = figure('position',[1 1 300 300]);
set(fig,'PaperPosition',[1 1 300 300])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat.time(index) stat.time(index)];
cfg.zlim               = [-10 10]; % F-values
cmap                   = colormap('gray')       
cfg.colormap           = cmap;
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

%% cluster frontal
times = sum(stat.prob <= 0.05);
plot(stat.time,times)
[x,y] = findpeaks(times);

chan_front = {'MEG0121', 'MEG0211', 'MEG0221', 'MEG0311', 'MEG0321', 'MEG0331',...
               'MEG0341', 'MEG0411', 'MEG0421', 'MEG0511', 'MEG0521', 'MEG0531',...
               'MEG0541', 'MEG0611', 'MEG0621', 'MEG0631', 'MEG0641', 'MEG0811',...
               'MEG0821', 'MEG0911', 'MEG0921', 'MEG0931', 'MEG0941', 'MEG1011',...
               'MEG1021', 'MEG1031', 'MEG1041', 'MEG1111', 'MEG1121', 'MEG1211',...
               'MEG1231', 'MEG1241', 'MEG1311'}
indchan = []; indchan = find(stat.prob(:,y(9)) <0.05);  

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
[x,y] = findpeaks(times);
timeofinterest1 = y(5);
indchan1 = find(stat.prob(:,timeofinterest1) <0.05);
indchanpost = intersect(indchan1,ind_post)
indchanant = intersect(indchan1,ind_ant)

fig = figure('position',[1 1 300 300]);
set(fig,'PaperPosition',[1 1 300 300])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
cmap = colormap('gray');
cmap = cmap(end:-1:1,:)
index = y(5);
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat.time(y(5)) stat.time(y(5))];
cfg.zlim               = [0 5]; % F-values
cfg.colormap           = cmap;
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
cfg.highlight          = {'on','on'};
cfg.highlightchannel   = {stat.label(indchanpost),stat.label(indchanant)};
cfg.highlightsymbol    = {'.','.'};
cfg.highlightsize      = {20,20} ;
cfg.highlightcolor     = {'w','w'};
cfg.comment            = num2str(stat.time(y(5)));
ft_topoplotER(cfg,stat);
colorbar

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/MISC_PLOTS/dummytopo_mags')
%% cluster
[x,y] = findpeaks(times);
timeofinterest1 = y(9);
indchan1 = find(stat.prob(:,timeofinterest1) <0.05);
indchanpost = intersect(indchan1,ind_post)
indchanant = intersect(indchan1,ind_ant)

fig = figure('position',[1 1 300 300]);
set(fig,'PaperPosition',[1 1 300 300])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat.time(y(9)) stat.time(y(9))];
cfg.zlim               = [-10 10]; % F-values
cfg.colormap           = 'jet';
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
cfg.highlightchannel   = stat.label(indchanpost);
cfg.highlightsymbol    = '.';
cfg.highlightsize      = 20;
cfg.comment            = num2str(stat.time(y(9)));
ft_topoplotER(cfg,stat);

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/MISC_PLOTS/mags_topo_occ_clusterreftime')

%% cluster avg post clust
fig = figure('position',[1 1 1300 1000]);
set(fig,'PaperPosition',[1 1 1300 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
subplot(2,1,1)

clust  = find(sum(stat.prob(:,y(9)) <= 0.05) > 0);
% determine figure size base on amplitude on avg cluster activity
valmax = max([max(mean(GDAVG{1}.avg(indchanant,:))) ...
         max(mean(GDAVG{2}.avg(indchanant,:))) ...
         max(mean(GDAVG{3}.avg(indchanant,:)))]);
valmin = min([min(mean(GDAVG{1}.avg(indchanant,:))) ...
         min(mean(GDAVG{2}.avg(indchanant,:))) ...
         min(mean(GDAVG{3}.avg(indchanant,:)))]);
% fmult
fmult = 1e14; % for express in uV

% define axes limit and plot properties
set_axes(-0.7, 5, -5,5)

% stimulus onsets
line([0 0]    ,[-6 6],'linestyle',':','linewidth',3,'color','k'); hold on
line([1.1 1.1],[-6 6],'linestyle',':','linewidth',3,'color','k'); hold on
line([2.2 2.2],[-6 6],'linestyle',':','linewidth',3,'color','k'); hold on
line([3.4 3.4],[-6 6],'linestyle',':','linewidth',3,'color','k'); hold on

% cluster shade
plot_lin_shade(clust,0.05, stat,-5,5,[0.7 0.7 0.7],-5)

% timecourse
plot(GDAVG{1}.time,mean(GDAVG{1}.avg(indchanant,:)*fmult),'linewidth',4,'color',graphcolor(1,:));hold on
plot(GDAVG{1}.time,mean(GDAVG{2}.avg(indchanant,:)*fmult),'linewidth',4,'color',graphcolor(2,:));hold on
plot(GDAVG{1}.time,mean(GDAVG{3}.avg(indchanant,:)*fmult),'linewidth',4,'color',graphcolor(3,:));hold on

%% cluster avg post clust
subplot(2,1,2)

clust  = find(sum(stat.prob(:,y(9)) <= 0.05) > 0);
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
set_axes(-0.7, 5, -5,5)


% stimulus onsets
line([0 0]    ,[-6 6],'linestyle',':','linewidth',3,'color','k'); hold on
line([1.1 1.1],[-6 6],'linestyle',':','linewidth',3,'color','k'); hold on
line([2.2 2.2],[-6 6],'linestyle',':','linewidth',3,'color','k'); hold on
line([3.4 3.4],[-6 6],'linestyle',':','linewidth',3,'color','k'); hold on

% cluster shade
plot_lin_shade(clust,0.05, stat,-5,5,[0.7 0.7 0.7],-5)

% timecourse
plot(GDAVG{1}.time,mean(GDAVG{1}.avg(indchanpost,:)*fmult),'linewidth',4,'color',graphcolor(1,:));hold on
plot(GDAVG{1}.time,mean(GDAVG{2}.avg(indchanpost,:)*fmult),'linewidth',4,'color',graphcolor(2,:));hold on
plot(GDAVG{1}.time,mean(GDAVG{3}.avg(indchanpost,:)*fmult),'linewidth',4,'color',graphcolor(3,:));hold on

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/MISC_PLOTS/mags_timecourse_ref_timeforPANEL')

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
lin_clustshade(clust,alpha, stat, -4,8,[0.9 0.9 0.9],-5)
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
