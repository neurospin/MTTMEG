addpath('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/PLOTTING_PAPER')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% DIST TIME %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
condnames_clust = {'Reltime_con','Reltime_incon'};
condnames    = {'Reltime_con','Reltime_incon'};
latency      = [0 1];
graphcolor   = [[1 0.6 0.6];[1 0 0]];
stat_test    = 'T';
chansel      = 'Mags';
clustnum     = 0;
clusttype    = 'posclust';
timetag      = '20161021151740';

[ch_magt, cdn_magt, cdn_clust_magt, stat_magt, GDAVG_magt, GDAVGt_magt] = prepare_comp(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
condnames_clust = {'Relspace_con','Relspace_incon'};
condnames    = {'Relspace_con','Relspace_incon'};
latency      = [0 1];
graphcolor   = [[1 0.6 0.6];[1 0 0]];
stat_test    = 'T';
chansel      = 'Mags';
clustnum     = 0;
clusttype    = 'negclust';
timetag      = '20161021152716';

[ch_mags, cdn_mags, cdn_clust_mags, stat_mags, GDAVG_mags, GDAVGt_mags] = prepare_comp(niplist,condnames,...
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
lay                        = ft_prepare_layout(cfg,GDAVGt_magt{1});
lay.label                = GDAVGt_magt{1}.label;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
times = sum(stat_mags.prob <= 0.05);
plot(stat_mags.time,times)
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
    cfg.xlim               = [stat_mags.time(index) stat_mags.time(index)];
    cfg.zlim               = [-10 10]; % F-values
    cfg.colormap           = 'jet';
    cfg.style              = 'straight';
    cfg.parameter          = 'stat';
    cfg.marker             = 'off';
    cfg.highlight          = 'on';
    indchan = []; indchan  = find(stat_mags.prob(:,index) <0.05);
    cfg.highlightchannel   = stat_mags.label(indchan);
    cfg.highlightsymbol    = '.';
    cfg.highlightsize      = 20;
    cfg.comment            = num2str(stat_mags.time(index));
    ft_topoplotER(cfg,stat_mags);
    count = count +1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
times    = sum(stat_magt.prob <= 0.05);
plot(stat_magt.time,times)
[x,y]    = findpeaks(times);
indchan1 = find(stat_magt.prob(:,y(4)) <0.05);
clust1   = find(sum(stat_magt.prob <= 0.05) > 0);

times    = sum(stat_mags.prob <= 0.05);
plot(stat_mags.time,times)
[x,y]    = findpeaks(times);
indchan2 = find(stat_mags.prob(:,y(5)) <0.05);
clust2   = find(sum(stat_mags.prob <= 0.05) > 0);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig = figure('position',[1 1 1600 1000]);
set(fig,'PaperPosition',[1 1 1600 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

fmult = 1e15; % conversion
set_axes(-0.7, 1.2, -70,70); % define axes limit and plot properties

line([0 0],[-100 100],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on % stimulus onsets
line([1 1],[-100 100],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on % stimulus offsets

plot_lin_shade(clust1, 0.05, stat_magt,'k',10) % significance window

plot(GDAVGt_magt{1}.time,mean(GDAVG_magt{1}.avg(indchan1,:)*fmult),'linewidth',8,'color',graphcolor(1,:));hold on % timecourse
plot(GDAVGt_magt{1}.time,mean(GDAVG_magt{2}.avg(indchan1,:)*fmult),'linewidth',8,'color',graphcolor(2,:));hold on % timecourse

set(gca,'box','off','linewidth',4,'fontsize',40,'fontweight','b')
set(gca,'ytick',[-100 -50 0 50],'yticklabel',[ -100 -50 -50 0 50])
axis([-0.2 1.2 -110 50])

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/congruency_Time_cluster')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:length(indchan1)

% fig = figure('position',[1 1 1600 1000]);
% set(fig,'PaperPosition',[1 1 1600 1000])
% set(fig,'PaperPositionmode','auto')
% set(fig,'Visible','on')
fig = figure('position',[1 1 800 500]);
set(fig,'PaperPosition',[1 1 800 500])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')


fmult = 1e15; % conversion
set_axes(-0.7, 1.2, -70,70); % define axes limit and plot properties

line([0 0],[-100 100],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on % stimulus onsets
line([1 1],[-100 100],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on % stimulus offsets

plot_lin_shade(clust1, 0.05, stat_magt,'k',10) % significance window

plot(GDAVGt_magt{1}.time,GDAVG_magt{1}.avg(indchan1(i),:)*fmult,'linewidth',8,'color',graphcolor(1,:));hold on % timecourse
plot(GDAVGt_magt{1}.time,GDAVG_magt{2}.avg(indchan1(i),:)*fmult,'linewidth',8,'color',graphcolor(2,:));hold on % timecourse

set(gca,'box','off','linewidth',4,'fontsize',40,'fontweight','b')
set(gca,'ytick',[-50 0 50],'yticklabel',[-50 0 50])
axis([-0.2 1.2 -50 50])

end

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/congruency_Time')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% load "space-stats"
stat_space = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/spatial_clust_from_mne_unsig/' ...
    'stats_clust_INT_T_INT_RelWestG_intmap_RelEastG_intmap_RelWestG_coumap_RelEastG_coumap__Mags_Lat0-1_stimlock_2016927134231.mat'],'stat')

% load "space-stats"
fig = figure('position',[1 1 1600 1000]);
set(fig,'PaperPosition',[1 1 1600 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

fmult = 1e14; % conversion
set_axes(-0.7, 1.2, -7,7); % define axes limit and plot properties

line([0 0],[-10 10],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on % stimulus onsets
line([1 1],[-10 10],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on % stimulus offsets

plot_lin_shade(clust5, 0.05, stat_magii,'k',3) % significance window

plot(GDAVGt_magii{1}.time,mean(GDAVG_magii{1}.avg(indchan5,:)*fmult),'linewidth',8,'color',graphcolor(1,:));hold on % timecourse
plot(GDAVGt_magii{1}.time,mean(GDAVG_magii{2}.avg(indchan5,:)*fmult),'linewidth',8,'color',graphcolor(2,:));hold on % timecourse
plot(GDAVGt_magii{1}.time,mean(GDAVG_magii{3}.avg(indchan5,:)*fmult),'linewidth',8,'color',graphcolor(1,:),'linestyle','-.');hold on % timecourse
plot(GDAVGt_magii{1}.time,mean(GDAVG_magii{4}.avg(indchan5,:)*fmult),'linewidth',8,'color',graphcolor(2,:),'linestyle','-.');hold on % timecourse

set(gca,'box','off','linewidth',4,'fontsize',40,'fontweight','b')
set(gca,'ytick',[-5 0 5],'yticklabel',[-50 0 50])
axis([-0.2 1.2 -5 5])

ax1 = gca; % current axes
ax1_pos = ax1.Position

% f-scores overlay
shift = -9
Y = [shift mean(stat_magii.stat(indchan5,:)) + ones(1,length(mean(stat_magii.stat(indchan5,:)))).*shift +shift];
X = [0 stat_magii.time stat_magii.time(end)]
fill(X,Y./2,'r','linestyle','none','facealpha',0.5); hold on

Y = [shift mean(stat_space.stat.stat(indchan5,:)) + ones(1,length(mean(stat_space.stat.stat(indchan5,:)))).*shift +shift];
X = [0 stat_space.stat.time stat_space.stat.time(end)]
fill(X,Y./2,'b','linestyle','none','facealpha',0.5); hold on

ax2 = axes('Position',ax1_pos,'XAxisLocation','top','YAxisLocation','right','Color','none');
set(gca,'box','off','linewidth',4,'fontsize',40,'fontweight','b')

axis([-0.2 1.2 -1 19])

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/Mags_Early_Ord_Time_map_INT')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 1600 800]);
set(fig,'PaperPosition',[1 1 1600 800])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

fmult = 1e15; % conversion
set_axes(0.9, 2, -8,5); % define axes limit and plot properties

line([1 1],[-10 10],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on % stimulus onsets
line([1.8 1.8],[-10 10],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on % stimulus offsets

plot_lin_shade(clust2, 0.05, stat_magt2,'k',-2) % significance window

plot(GDAVGt_magt2{1}.time,GDAVG_magt2{1}.avg(indchan2(12),:)*fmult,'linewidth',8,'color',graphcolor(1,:));hold on % timecourse
plot(GDAVGt_magt2{1}.time,GDAVG_magt2{2}.avg(indchan2(12),:)*fmult,'linewidth',8,'color',graphcolor(2,:));hold on % timecourse
set(gca,'linewidth',5,'fontsize',50)

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/Mags_Early_Ord_Time2')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% load "space-stats"
stat_space = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/spatial_clust_from_mne_unsig/' ...
    'stats_clust_INT_T_INT_RelWestG_intmap_RelEastG_intmap_RelWestG_coumap_RelEastG_coumap__Mags_Lat1-1.8_stimlock_2016927161414.mat'],'stat')

fig = figure('position',[1 1 1600 600]);
set(fig,'PaperPosition',[1 1 1600 600])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

fmult = 1e14; % conversion
set_axes(-0.7, 2.2, -3,3); % define axes limit and plot properties

line([0 0],[-10 10],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on % stimulus onsets
line([1.8 1.8],[-10 10],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on % stimulus offsets

plot_lin_shade(clust6, 0.05, stat_magii2,'k',1.5) % significance window

plot(GDAVGt_magii2{1}.time,mean(GDAVG_magii2{1}.avg(indchan6,:)*fmult),'linewidth',8,'color',graphcolor(1,:));hold on % timecourse
plot(GDAVGt_magii2{1}.time,mean(GDAVG_magii2{2}.avg(indchan6,:)*fmult),'linewidth',8,'color',graphcolor(2,:));hold on % timecourse
plot(GDAVGt_magii2{1}.time,mean(GDAVG_magii2{3}.avg(indchan6,:)*fmult),'linewidth',8,'color',graphcolor(1,:),'linestyle','-.');hold on % timecourse
plot(GDAVGt_magii2{1}.time,mean(GDAVG_magii2{4}.avg(indchan6,:)*fmult),'linewidth',8,'color',graphcolor(2,:),'linestyle','-.');hold on % timecourse

set(gca,'box','off','linewidth',4,'fontsize',40,'fontweight','b')
set(gca,'ytick',[-3 0 3],'yticklabel',[-30 0 30])
% axis([-0.2 2.2 -5 5])

% ax1 = gca; % current axes
% ax1_pos = ax1.Position
% 
% % f-scores overlay
% shift = -8
% Y = [shift mean(stat_magii2.stat(indchan6,:)) + ones(1,length(mean(stat_magii2.stat(indchan6,:)))).*shift +shift];
% X = [1 stat_magii2.time stat_magii2.time(end)]
% fill(X,Y./2,'r','linestyle','none','facealpha',0.5); hold on
% 
% Y = [shift mean(stat_space.stat.stat(indchan6,:)) + ones(1,length(mean(stat_space.stat.stat(indchan6,:)))).*shift +shift];
% X = [1 stat_space.stat.time stat_space.stat.time(end)]
% fill(X,Y./2,'b','linestyle','none','facealpha',0.5); hold on
% 
% ax2 = axes('Position',ax1_pos,'XAxisLocation','top','YAxisLocation','right','Color','none');
% set(gca,'box','off','linewidth',4,'fontsize',40,'fontweight','b')

% axis([-0.2 1.2 -1 19])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 1600 600]);
set(fig,'PaperPosition',[1 1 1600 600])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

graphcolor   = [[0.6 0.6 1];[0 0 1]]
fmult = 1e14; % conversion
set_axes(-0.7, 2.2, -3,3); % define axes limit and plot properties

line([0 0],[-10 10],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on % stimulus onsets
line([1.8 1.8],[-10 10],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on % stimulus offsets

plot_lin_shade(clust7, 0.05, stat_magiii2,'k',1.5) % significance window

plot(GDAVGt_magiii2{1}.time,mean(GDAVG_magiii2{1}.avg(indchan6,:)*fmult),'linewidth',8,'color',graphcolor(1,:));hold on % timecourse
plot(GDAVGt_magiii2{1}.time,mean(GDAVG_magiii2{2}.avg(indchan6,:)*fmult),'linewidth',8,'color',graphcolor(2,:));hold on % timecourse
plot(GDAVGt_magiii2{1}.time,mean(GDAVG_magiii2{3}.avg(indchan6,:)*fmult),'linewidth',8,'color',graphcolor(1,:),'linestyle','-.');hold on % timecourse
plot(GDAVGt_magiii2{1}.time,mean(GDAVG_magiii2{4}.avg(indchan6,:)*fmult),'linewidth',8,'color',graphcolor(2,:),'linestyle','-.');hold on % timecourse

set(gca,'box','off','linewidth',4,'fontsize',40,'fontweight','b')
set(gca,'ytick',[-3 0 3],'yticklabel',[-30 0 30])

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/Mags_Early_Ord_Space_map_INT2')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 1600 600]);
set(fig,'PaperPosition',[1 1 1600 600])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

graphcolor   = [[1 0.6 0.6];[1 0 0]]

fmult = 1e14; % conversion
set_axes(-0.7, 2.2, -10,5); % define axes limit and plot properties

line([0 0],[-10 10],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on % stimulus onsets
line([1.8 1.8],[-10 10],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on % stimulus offsets

plot_lin_shade(clust6, 0.05, stat_magii2,'k',1.5) % significance window

plot(GDAVGt_magii2{1}.time,GDAVG_magii2{1}.avg(indchan2(12),:)*fmult,'linewidth',8,'color',graphcolor(1,:));hold on % timecourse
plot(GDAVGt_magii2{1}.time,GDAVG_magii2{2}.avg(indchan2(12),:)*fmult,'linewidth',8,'color',graphcolor(2,:));hold on % timecourse
plot(GDAVGt_magii2{1}.time,GDAVG_magii2{3}.avg(indchan2(12),:)*fmult,'linewidth',8,'color',graphcolor(1,:),'linestyle','-.');hold on % timecourse
plot(GDAVGt_magii2{1}.time,GDAVG_magii2{4}.avg(indchan2(12),:)*fmult,'linewidth',8,'color',graphcolor(2,:),'linestyle','-.');hold on % timecourse

set(gca,'box','off','linewidth',4,'fontsize',40,'fontweight','b')
set(gca,'ytick',[-10 0 5],'yticklabel',[-100 0 50])

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/Mags_Early_Ord_Time_map_INT2_singlechan')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 1600 600]);
set(fig,'PaperPosition',[1 1 1600 600])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

graphcolor   = [[0.6 0.6 1];[0 0 1]]
fmult = 1e14; % conversion
set_axes(-0.7, 2.2, -10,5); % define axes limit and plot properties

line([0 0],[-10 10],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on % stimulus onsets
line([1.8 1.8],[-10 10],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on % stimulus offsets

plot_lin_shade(clust7, 0.05, stat_magiii2,'k',1.5) % significance window

plot(GDAVGt_magiii2{1}.time,GDAVG_magiii2{1}.avg(indchan2(12),:)*fmult,'linewidth',8,'color',graphcolor(1,:));hold on % timecourse
plot(GDAVGt_magiii2{1}.time,GDAVG_magiii2{2}.avg(indchan2(12),:)*fmult,'linewidth',8,'color',graphcolor(2,:));hold on % timecourse
plot(GDAVGt_magiii2{1}.time,GDAVG_magiii2{3}.avg(indchan2(12),:)*fmult,'linewidth',8,'color',graphcolor(1,:),'linestyle','-.');hold on % timecourse
plot(GDAVGt_magiii2{1}.time,GDAVG_magiii2{4}.avg(indchan2(12),:)*fmult,'linewidth',8,'color',graphcolor(2,:),'linestyle','-.');hold on % timecourse

set(gca,'box','off','linewidth',4,'fontsize',40,'fontweight','b')
set(gca,'ytick',[-10 0 5],'yticklabel',[-100 0 50])

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/Mags_Early_Ord_Space_map_INT2_singlechan')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PLOT PART2
fig = figure('position',[1 1 400 400]);
set(fig,'PaperPosition',[1 1 400 400])
set(fig,'PaperPositionmode','auto')

index = y(5);
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat_magt.time(index) stat_magt.time(index)];
cfg.zlim               = [-5 5]; % F-values
cfg.colormap           = 'jet';
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
cfg.highlight          = {'on','on'};
cfg.highlightchannel   = {stat_magt.label(setdiff(indchan1,indchanbest)),stat_magt.label(indchanbest)};
cfg.highlightsymbol    = {'.','d'};
cfg.highlightsize      = {24,10} ;
cfg.highlightcolor     = {'w','w'};
cfg.comment            = num2str(stat_magt.time(index));
ft_topoplotER(cfg,stat_magt);
colorbar
print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/Mags_Early_Ord_Time_topo')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PLOT PART2
fig = figure('position',[1 1 400 400]);
set(fig,'PaperPosition',[1 1 400 400])
set(fig,'PaperPositionmode','auto')

index = y(5);
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat_magii.time(index) stat_magii.time(index)];
cfg.zlim               = [-5 5]; % F-values
cfg.colormap           = 'jet';
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
cfg.highlight          = {'on'};
cfg.highlightchannel   = {stat_magii.label(indchan5)};
cfg.highlightsymbol    = {'.'};
cfg.highlightsize      = {24} ;
cfg.highlightcolor     = {'w'};
cfg.comment            = num2str(stat_magii.time(index));
ft_topoplotER(cfg,stat_magii);
colorbar
print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/Mags_Early_Ord_Time_topo_map_int')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PLOT PART2
fig = figure('position',[1 1 400 400]);
set(fig,'PaperPosition',[1 1 400 400])
set(fig,'PaperPositionmode','auto')

index = y(8);
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat_magt2.time(index) stat_magt2.time(index)];
cfg.zlim               = [-5 5]; % F-values
cfg.colormap           = 'jet';
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
cfg.highlight          = {'on','on'};
cfg.highlightchannel   = {stat_magt2.label(setdiff(indchan2,indchan2(12))),stat_magt2.label(indchan2(12))};
cfg.highlightsymbol    = {'.','d'};
cfg.highlightsize      = {24,10} ;
cfg.highlightcolor     = {'w','w'};
cfg.comment            = num2str(stat_magt2.time(index));
ft_topoplotER(cfg,stat_magt2);
colorbar
print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/Mags_Early_Ord_Time2_topo')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PLOT PART2
fig = figure('position',[1 1 400 400]);
set(fig,'PaperPosition',[1 1 400 400])
set(fig,'PaperPositionmode','auto')

index = y(8);
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat_mags.time(index) stat_mags.time(index)];
cfg.zlim               = [-5 5]; % F-values
cfg.colormap           = 'jet';
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
cfg.highlight          = {'on','on'};
cfg.highlightchannel   = {stat_mags.label(setdiff(indchan3,indchan3(10))),stat_mags.label(indchan3(10))};
cfg.highlightsymbol    = {'.','d'};
cfg.highlightsize      = {24,10} ;
cfg.highlightcolor     = {'w','w'};
cfg.comment            = num2str(stat_mags.time(index));
ft_topoplotER(cfg,stat_mags);
colorbar
print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/Mags_Early_Ord_Space_topo')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% plot barplots

% cluster pieces
t = [];
for i = 1:length(clust4)-1
    if abs(clust4(i+1) - clust4(i)) > 1
        t = [t i i+1];
    end
end

interval = [];

if length(t) >2

    Tstart(1) = find(abs( GDAVGt_magi{1}.time - stat_magi.time(clust4(1))) < 1e-6);
    Tend(1)   = find(abs( GDAVGt_magi{1}.time - stat_magi.time(clust4(t(1)))) < 1e-6);
    interval = [Tstart(1):Tend(1)];
    
    for i = 2:2:length(t)-1 
        Tstart(i/2+1) = find(abs( GDAVGt_magi{1}.time - stat_magi.time(clust4(t(i)))) < 1e-6);
        Tend(i/2+1)   = find(abs( GDAVGt_magi{1}.time - stat_magi.time(clust4(t(i+1)))) < 1e-6);
        interval = [interval Tstart(i/2+1):Tend(i/2+1)];
    end
    
    Tstart(i/2+2) = find(abs( GDAVGt_magi{1}.time - stat_magi.time(clust4(t(i)))) < 1e-6);
    Tend(i/2+2)   = find(abs( GDAVGt_magi{1}.time - stat_magi.time(clust4(end))) < 1e-6);   
    interval = [interval Tstart(i/2+2):Tend(i/2+2)];

elseif length(t) == 2
    Tstart(1) = find(abs( GDAVGt_magi{1}.time - stat_magi.time(clust4(1))) < 1e-6);
    Tend(1)   = find(abs( GDAVGt_magi{1}.time - stat_magi.time(clust4(t(1)))) < 1e-6);
    Tstart(2) = find(abs( GDAVGt_magi{1}.time - stat_magi.time(clust4(t(2)))) < 1e-6);
    Tend(2)   = find(abs( GDAVGt_magi{1}.time - stat_magi.time(clust4(end))) < 1e-6);  
    interval  = [Tstart(1):Tend(1) Tstart(2):Tend(2)];
else
    Tstart(1) = find(abs( GDAVGt_magi{1}.time - stat_magi.time(clust4(1))) < 1e-6);
    Tend(1)   = find(abs( GDAVGt_magi{1}.time - stat_magi.time(clust4(end))) < 1e-6);
    interval = [Tstart(1):Tend(1)];
    
end

data1 = mean(mean( GDAVGt_magi{1}.individual(:,indchan4,Tstart(1):Tend(1)),2),3)*fmult;
data2 = mean(mean( GDAVGt_magi{2}.individual(:,indchan4,Tstart(1):Tend(1)),2),3)*fmult;
data3 = mean(mean( GDAVGt_magi{3}.individual(:,indchan4,Tstart(1):Tend(1)),2),3)*fmult;
data4 = mean(mean( GDAVGt_magi{4}.individual(:,indchan4,Tstart(1):Tend(1)),2),3)*fmult;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 800 800]);
set(fig,'PaperPosition',[1 1 800 800])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

graphcolor   = [[1 0.6 0.6];[1 0 0];[0.6 0.6 1];[0 0 1]];

bar(1,[mean(data1)],'facecolor',graphcolor(1,:),'edgecolor','k');hold on
bar(2,[mean(data2)],'facecolor',graphcolor(2,:),'edgecolor','k');hold on
bar(3,[mean(data3)],'facecolor',graphcolor(3,:),'edgecolor','k');hold on
bar(4,[mean(data4)],'facecolor',graphcolor(4,:),'edgecolor','k');hold on
errorbar(1,mean(data1),std(data1)./sqrt(19),'linestyle','none','color','k','linewidth',3)
errorbar(2,mean(data2),std(data2)./sqrt(19),'linestyle','none','color','k','linewidth',3)
errorbar(3,mean(data3),std(data3)./sqrt(19),'linestyle','none','color','k','linewidth',3)
errorbar(4,mean(data4),std(data4)./sqrt(19),'linestyle','none','color','k','linewidth',3)

axis([0 5 -5.5 0])
set(gca,'ytick',[-5 0],'yticklabel',[-50 0])
set(gca,'linewidth',5,'fontsize',50,'box','off')

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/Mags_INT_Ord_TIME_SPACE')




















