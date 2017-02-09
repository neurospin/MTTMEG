addpath('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/PLOTTING_PAPER')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
times    = sum(stat_magt.prob <= 0.05);
plot(stat_magt.time,times)
[x,y]    = findpeaks(times);
indchan1 = find(stat_magt.prob(:,y(1)) <0.05);
clust1   = find(sum(stat_magt.prob <= 0.05) > 0);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% TEST INPUT
latency      = [0 1];
graphcolor   = [[0.7 0.7 1];[0 0 0];[0 0 1]];
stat_test    = 'F';
chansel      = 'Mags';

% load "space-stats"
stat_space = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/spatial_clust_from_mne_unsig/' ...
    'stats_clust_T_REGfull_distS_Zero__Mags_Lat0-1_stimlock_2016919174236.mat'],'stat')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 1600 1000]);
set(fig,'PaperPosition',[1 1 1600 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

% color of each conditions
col = colormap('hot')
graphcol = []
for i = [15 30 45]
    graphcol = [graphcol;col(i,:)]
end

% fmult
fmult = 1e14; % for express in uV
% define axes limit and plot properties

% stimulus onsets
line([0 0],[-12 7],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on
line([1 1],[-12 7],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on

% cluster shade
cmap = colormap('hot')
cmap_inv = cmap(end:-1:1,:)
plot_lin_shade(clust1, 0.05, stat_magt,'k',-3) % significance window

% binning
val1 = (mean(GDAVG_magt{1}.avg(indchan1,:)*fmult) + mean(GDAVG_magt{2}.avg(indchan1,:)*fmult) +...
    mean(GDAVG_magt{3}.avg(indchan1,:)*fmult) + mean(GDAVG_magt{4}.avg(indchan1,:)*fmult) + ...
    mean(GDAVG_magt{5}.avg(indchan1,:)*fmult) + mean(GDAVG_magt{6}.avg(indchan1,:)*fmult) + ...
    mean(GDAVG_magt{7}.avg(indchan1,:)*fmult) + mean(GDAVG_magt{8}.avg(indchan1,:)*fmult))/8;

val2 = (mean(GDAVG_magt{9}.avg(indchan1,:)*fmult) + mean(GDAVG_magt{10}.avg(indchan1,:)*fmult) +...
    mean(GDAVG_magt{11}.avg(indchan1,:)*fmult) + mean(GDAVG_magt{12}.avg(indchan1,:)*fmult) + ...
    mean(GDAVG_magt{12}.avg(indchan1,:)*fmult) + mean(GDAVG_magt{14}.avg(indchan1,:)*fmult) + ...
    mean(GDAVG_magt{13}.avg(indchan1,:)*fmult) + mean(GDAVG_magt{16}.avg(indchan1,:)*fmult))/8;

val3 = (mean(GDAVG_magt{17}.avg(indchan1,:)*fmult) + mean(GDAVG_magt{18}.avg(indchan1,:)*fmult) +...
    mean(GDAVG_magt{19}.avg(indchan1,:)*fmult) + mean(GDAVG_magt{20}.avg(indchan1,:)*fmult) + ...
    mean(GDAVG_magt{21}.avg(indchan1,:)*fmult) + mean(GDAVG_magt{22}.avg(indchan1,:)*fmult) + ...
    mean(GDAVG_magt{23}.avg(indchan1,:)*fmult) + mean(GDAVG_magt{24}.avg(indchan1,:)*fmult))/8;

% timecourse
plot(GDAVG_magt{1}.time,val1,'linewidth',8,'color',graphcol(1,:));hold on
plot(GDAVG_magt{1}.time,val2,'linewidth',8,'color',graphcol(2,:));hold on
plot(GDAVG_magt{1}.time,val3,'linewidth',8,'color',graphcol(3,:));hold on

set(gca,'box','off','linewidth',4,'fontsize',40,'fontweight','b')
set(gca,'ytick',[-10 -5 0 5],'yticklabel',[-100 -50 0 50])
axis([-0.2 1.2 -10 5])

ax1 = gca; % current axes
ax1_pos = ax1.Position

% f-scores overlay
shift = -8
Y = [shift -mean(stat_magt.stat(indchan1,:)) + ones(1,length(mean(stat_magt.stat(indchan1,:)))).*shift +shift];
X = [0 stat_magt.time stat_magt.time(end)]
fill(X,Y./1,'r','linestyle','none','facealpha',0.5); hold on

Y = [shift -mean(stat_space.stat.stat(indchan1,:)) + ones(1,length(mean(stat_space.stat.stat(indchan1,:)))).*shift +shift];
X = [0 stat_space.stat.time stat_space.stat.time(end)]
fill(X,Y./1,'b','linestyle','none','facealpha',0.5); hold on

ax2 = axes('Position',ax1_pos,'XAxisLocation','top','YAxisLocation','right','Color','none');
set(gca,'box','off','linewidth',4,'fontsize',40,'fontweight','b')

axis([-0.2 1.2 -2 13])

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/Mags_Early_DistT_Time_v2')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
times    = sum(stat_eegs.prob <= 0.05);
plot(stat_eegs.time,times)
[x,y]    = findpeaks(times);
indchan4 = find(stat_eegs.prob(:,y(8)) <0.05);
clust4  = find(sum(stat_eegs.prob <= 0.01) > 0);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% TEST INPUT
latency      = [0 1];
graphcolor   = [[0.7 0.7 1];[0 0 0];[0 0 1]];
stat_test    = 'F';
chansel      = 'Mags';

% load "time-stats"
stat_time = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/spatial_clust_from_mne_unsig/' ...
    'stats_clust_T_REGfull_distT_Zero__EEG_Lat0-1_stimlock_2016919174540.mat'],'stat')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 1600 1000]);
set(fig,'PaperPosition',[1 1 1600 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

% color of each conditions
col = colormap('jet')
graphcol = []
for i = [5 18 22]
    graphcol = [graphcol;col(i,:)]
end

% fmult
fmult = 1e6; % for express in uV
% define axes limit and plot properties

% stimulus onsets
line([0 0],[-12 7],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on
line([1 1],[-12 7],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on

% cluster shade
cmap = colormap('hot')
cmap_inv = cmap(end:-1:1,:)
plot_lin_shade(clust4, 0.05, stat_eegs,'k',0) % significance window

% binning
val1 = (mean(GDAVG_eegs{1}.avg(indchan4,:)*fmult) + mean(GDAVG_eegs{2}.avg(indchan4,:)*fmult) +...
    mean(GDAVG_eegs{3}.avg(indchan4,:)*fmult) + mean(GDAVG_eegs{4}.avg(indchan4,:)*fmult) + ...
    mean(GDAVG_eegs{5}.avg(indchan4,:)*fmult) + mean(GDAVG_eegs{6}.avg(indchan4,:)*fmult) + ...
    mean(GDAVG_eegs{7}.avg(indchan4,:)*fmult) + mean(GDAVG_eegs{8}.avg(indchan4,:)*fmult))/8;

val2 = (mean(GDAVG_eegs{9}.avg(indchan4,:)*fmult) + mean(GDAVG_eegs{10}.avg(indchan4,:)*fmult) +...
    mean(GDAVG_eegs{11}.avg(indchan4,:)*fmult) + mean(GDAVG_eegs{12}.avg(indchan4,:)*fmult) + ...
    mean(GDAVG_eegs{12}.avg(indchan4,:)*fmult) + mean(GDAVG_eegs{14}.avg(indchan4,:)*fmult) + ...
    mean(GDAVG_eegs{13}.avg(indchan4,:)*fmult) + mean(GDAVG_eegs{16}.avg(indchan4,:)*fmult))/8;

val3 = (mean(GDAVG_eegs{17}.avg(indchan4,:)*fmult) + mean(GDAVG_eegs{18}.avg(indchan4,:)*fmult) +...
    mean(GDAVG_eegs{19}.avg(indchan4,:)*fmult) + mean(GDAVG_eegs{20}.avg(indchan4,:)*fmult) + ...
    mean(GDAVG_eegs{21}.avg(indchan4,:)*fmult) + mean(GDAVG_eegs{22}.avg(indchan4,:)*fmult) + ...
    mean(GDAVG_eegs{23}.avg(indchan4,:)*fmult) + mean(GDAVG_eegs{24}.avg(indchan4,:)*fmult))/8;

% timecourse
plot(GDAVG_eegs{1}.time,val1,'linewidth',8,'color',graphcol(1,:));hold on
plot(GDAVG_eegs{1}.time,val2,'linewidth',8,'color',graphcol(2,:));hold on
plot(GDAVG_eegs{1}.time,val3,'linewidth',8,'color',graphcol(3,:));hold on

set(gca,'box','off','linewidth',4,'fontsize',40,'fontweight','b')
axis([-0.2 1.2 -3 3])

ax1 = gca; % current axes
ax1_pos = ax1.Position

% f-scores overlay
shift = -4
Y = [shift -mean(stat_eegs.stat(indchan4,:)) + ones(1,length(mean(stat_eegs.stat(indchan4,:)))).*shift +shift];
X = [0 stat_eegs.time stat_eegs.time(end)]
fill(X,Y./2,'b','linestyle','none','facealpha',0.5); hold on

Y = [shift -mean(stat_time.stat.stat(indchan4,:)) + ones(1,length(mean(stat_time.stat.stat(indchan4,:)))).*shift +shift];
X = [0 stat_time.stat.time stat_time.stat.time(end)]
fill(X,Y./2,'r','linestyle','none','facealpha',0.5); hold on

ax2 = axes('Position',ax1_pos,'XAxisLocation','top','YAxisLocation','right','Color','none');
set(gca,'box','off','linewidth',4,'fontsize',40,'fontweight','b')

axis([-0.2 1.2 -4 20])

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/EEG_Early_DistS_Space_v2')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig = figure('position',[1 1 1600 800]);
set(fig,'PaperPosition',[1 1 1600 800])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

% color of each conditions
col = colormap('hot')
graphcol = []
for i = 1:4
    graphcol = [graphcol;col(11*i,:)]
end

% fmult
fmult = 1e14; % for express in uV
% define axes limit and plot properties
set_axes(-0.7, 2, -7,6)

% stimulus onsets
line([0 0],[-7 6],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on
line([1 1],[-7 6],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on

% cluster shade
cmap = colormap('hot')
cmap_inv = cmap(end:-1:1,:)
plot_lin_shade(clust1, 0.05, stat_magt4,'k',-4) % significance window

% timecourse
plot(GDAVG_magt{1}.time,GDAVG_magt4{1}.avg(indchan1(9),:)*fmult,'linewidth',8,'color',graphcol(1,:));hold on
plot(GDAVG_magt{2}.time,GDAVG_magt4{2}.avg(indchan1(9),:)*fmult,'linewidth',8,'color',graphcol(2,:));hold on
plot(GDAVG_magt{3}.time,GDAVG_magt4{3}.avg(indchan1(9),:)*fmult,'linewidth',8,'color',graphcol(3,:));hold on
plot(GDAVG_magt{4}.time,GDAVG_magt4{4}.avg(indchan1(9),:)*fmult,'linewidth',8,'color',graphcol(4,:));hold on
set(gca,'linewidth',5,'fontsize',50)

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/Mags_Early_DistT_Time')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig = figure('position',[1 1 1600 800]);
set(fig,'PaperPosition',[1 1 1600 800])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

% color of each conditions
col = colormap('hot')
graphcol = []
for i = 1:4
    graphcol = [graphcol;col(11*i,:)]
end

% fmult
fmult = 1e14; % for express in uV
% define axes limit and plot properties
set_axes(-0.7, 2, -7,6)

% stimulus onsets
line([0 0],[-7 6],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on
line([1 1],[-7 6],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on

% cluster shade
cmap = colormap('hot')
cmap_inv = cmap(end:-1:1,:)
plot_lin_shade(clust1, 0.05, stat_magt4,'k',-4) % significance window

% timecourse
plot(GDAVG_magt{1}.time,mean(GDAVG_magt4{1}.avg(indchan1,:)*fmult),'linewidth',8,'color',graphcol(1,:));hold on
plot(GDAVG_magt{2}.time,mean(GDAVG_magt4{2}.avg(indchan1,:)*fmult),'linewidth',8,'color',graphcol(2,:));hold on
plot(GDAVG_magt{3}.time,mean(GDAVG_magt4{3}.avg(indchan1,:)*fmult),'linewidth',8,'color',graphcol(3,:));hold on
plot(GDAVG_magt{4}.time,mean(GDAVG_magt4{4}.avg(indchan1,:)*fmult),'linewidth',8,'color',graphcol(4,:));hold on
set(gca,'linewidth',5,'fontsize',50)

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/Mags_Early_DistT_Time_clust')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 1600 800]);
set(fig,'PaperPosition',[1 1 1600 800])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

% color of each conditions
col = colormap('hot')
graphcol = []
for i = 1:4
    graphcol = [graphcol;col(11*i,:)]
end

% fmult
fmult = 1e6; % for express in uV
% define axes limit and plot properties
set_axes(-0.7, 2, -2,4)

% stimulus onsets
line([0 0],[-7 6],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on
line([1 1],[-7 6],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on

% cluster shade
cmap = colormap('hot')
cmap_inv = cmap(end:-1:1,:)
plot_lin_shade(clust3, 0.05, stat_eegt,'k',-1) % significance window

% timecourse
plot(GDAVG_eeg4{1}.time,GDAVG_eeg4{1}.avg(indchan3(14),:)*fmult,'linewidth',8,'color',graphcol(1,:));hold on
plot(GDAVG_eeg4{2}.time,GDAVG_eeg4{2}.avg(indchan3(14),:)*fmult,'linewidth',8,'color',graphcol(2,:));hold on
plot(GDAVG_eeg4{3}.time,GDAVG_eeg4{3}.avg(indchan3(14),:)*fmult,'linewidth',8,'color',graphcol(3,:));hold on
plot(GDAVG_eeg4{4}.time,GDAVG_eeg4{4}.avg(indchan3(14),:)*fmult,'linewidth',8,'color',graphcol(4,:));hold on
set(gca,'linewidth',5,'fontsize',50)

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/EEG_Early_DistT_Time')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 1600 800]);
set(fig,'PaperPosition',[1 1 1600 800])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

% color of each conditions
col = colormap('jet')
graphcol = []
for j = 1:4
    graphcol = [graphcol;col(7*j,:)];
end

% fmult
fmult = 1e6; % for express in uV
% define axes limit and plot properties
set_axes(-0.7, 2, -3,5)

% stimulus onsets
line([0 0],[-7 6],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on
line([1 1],[-7 6],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on

% cluster shade
cmap = colormap('hot')
cmap_inv = cmap(end:-1:1,:)
plot_lin_shade(clust4, 0.05, stat_eegs,'k',-1) % significance window

% timecourse
plot(GDAVG_eegs4{1}.time,GDAVG_eegs4{1}.avg(indchan4(26),:)*fmult,'linewidth',8,'color',graphcol(1,:));hold on
plot(GDAVG_eegs4{2}.time,GDAVG_eegs4{2}.avg(indchan4(26),:)*fmult,'linewidth',8,'color',graphcol(2,:));hold on
plot(GDAVG_eegs4{3}.time,GDAVG_eegs4{3}.avg(indchan4(26),:)*fmult,'linewidth',8,'color',graphcol(3,:));hold on
plot(GDAVG_eegs4{4}.time,GDAVG_eegs4{4}.avg(indchan4(26),:)*fmult,'linewidth',8,'color',graphcol(4,:));hold on
set(gca,'linewidth',5,'fontsize',50)

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/EEG_Early_DistS_Space')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 1600 800]);
set(fig,'PaperPosition',[1 1 1600 800])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

% color of each conditions
col = colormap('jet')
graphcol = []
for j = 1:4
    graphcol = [graphcol;col(7*j,:)];
end

% fmult
fmult = 1e14; % for express in uV
% define axes limit and plot properties
set_axes(-0.7, 2, -8,10)

% stimulus onsets
line([0 0],[-11 11],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on
line([1 1],[-11 11],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on

% cluster shade
cmap = colormap('hot')
cmap_inv = cmap(end:-1:1,:)
plot_lin_shade(clust2, 0.05, stat_mags,'k',-7) % significance window

% timecourse
plot(GDAVG_mags{1}.time,GDAVG_mags4{1}.avg(indchan2(12),:)*fmult,'linewidth',8,'color',graphcol(1,:));hold on
plot(GDAVG_mags{2}.time,GDAVG_mags4{2}.avg(indchan2(12),:)*fmult,'linewidth',8,'color',graphcol(2,:));hold on
plot(GDAVG_mags{3}.time,GDAVG_mags4{3}.avg(indchan2(12),:)*fmult,'linewidth',8,'color',graphcol(3,:));hold on
plot(GDAVG_mags{4}.time,GDAVG_mags4{4}.avg(indchan2(12),:)*fmult,'linewidth',8,'color',graphcol(4,:));hold on
set(gca,'linewidth',5,'fontsize',50)

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/Mags_Early_DistS_Space')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 400 400]);
set(fig,'PaperPosition',[1 1 400 400])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

times = sum(stat_magt.prob <= 0.02);
plot(stat_magt.time,times)
[x,y] = findpeaks(times);
index = y(1)

cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat_magt.time(index) stat_magt.time(index)];
cfg.zlim               = [-5 5]; % F-values
cmap = colormap('gray')
cfg.colormap           = cmap;
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
cfg.highlight          = {'on','on'};
cfg.highlightchannel   = {stat_magt.label(setdiff(indchan1,indchan1(9))),stat_magt.label(indchan1(9))};
cfg.highlightsymbol    = {'.','d'};
cfg.highlightsize      = {24,10} ;
cfg.highlightcolor     = {'w','w'};
cfg.comment            = num2str(stat_magt.time(index));
ft_topoplotER(cfg,stat_magt);
colorbar

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/Mags_Early_DistT_Time_topo')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 400 400]);
set(fig,'PaperPosition',[1 1 400 400])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

times = sum(stat_eegt.prob <= 0.05);
plot(stat_eegt.time,times)
[x,y] = findpeaks(times);
index = y(3)

cmap = colormap('jet')
cmap = cmap(end:-1:1,:)
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat_eegt.time(index) stat_eegt.time(index)];
cfg.zlim               = [-5 5]; % F-values
cfg.colormap           = cmap;
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
cfg.highlight          = {'on','on'};
cfg.highlightchannel   = {stat_eegt.label(setdiff(indchan3,indchan3(14))),stat_eegt.label(indchan3(14))};
cfg.highlightsymbol    = {'.','d'};
cfg.highlightsize      = {24,10} ;
cfg.highlightcolor     = {'w','w'};
cfg.comment            = num2str(stat_eegt.time(index));
ft_topoplotER(cfg,stat_eegt);
colorbar

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/EEG_Early_DistT_Time_topo')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 400 400]);
set(fig,'PaperPosition',[1 1 400 400])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

index = y(8)

cmap = colormap('jet')
cmap = cmap(end:-1:1,:)
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat_eegs.time(index) stat_eegs.time(index)];
cfg.zlim               = [-5 5]; % F-values
cfg.colormap           = cmap;
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
cfg.highlight          = {'on','on'};
cfg.highlightchannel   = {stat_eegt.label(setdiff(indchan4,indchan4(26))),stat_eegs.label(indchan4(26))};
cfg.highlightsymbol    = {'.','d'};
cfg.highlightsize      = {24,10} ;
cfg.highlightcolor     = {'w','w'};
cfg.comment            = num2str(stat_eegs.time(index));
ft_topoplotER(cfg,stat_eegs);
colorbar

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/EEG_Early_DistS_Space_topo')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 400 400]);
set(fig,'PaperPosition',[1 1 400 400])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

index = y(8)

cmap = colormap('jet')
cmap = cmap(end:-1:1,:)
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat_mags.time(index) stat_mags.time(index)];
cfg.zlim               = [-5 5]; % F-values
cfg.colormap           = cmap;
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
cfg.highlight          = {'on','on'};
cfg.highlightchannel   = {stat_mags.label(setdiff(indchan2,indchan2(12))),stat_magt.label(indchan2(12))};
cfg.highlightsymbol    = {'.','d'};
cfg.highlightsize      = {24,10} ;
cfg.highlightcolor     = {'w','w'};
cfg.comment            = num2str(stat_mags.time(index));
ft_topoplotER(cfg,stat_mags);
colorbar

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/Mags_Early_DistS_Space_topo')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% plot barplots
% time intervals
Tstart(1) = find(abs(GDAVG_magt{3}.time - stat_magt.time(clust1(1))) < 1e-6);
Tend(1)   = find(abs(GDAVG_magt{3}.time - stat_magt.time(clust1(end))) < 1e-6);
interval = [Tstart(1):Tend(1)];

% plots full cluster
fig = figure('position',[1 1 800 800]);
set(fig,'PaperPosition',[1 1 800 800])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

mask = (stat_magt.prob < 0.05);
x = find(mask == 1);

% rephase time of data and test
cfg = []; cfg.toilim = [stat_eegs.time(1) stat_magt.time(end)];
for i = 1:length(GDAVG_magt)
    tmp_gdavg{i} = ft_redefinetrial(cfg,GDAVG_magt{i})
end

% full range
D = [];
for i = 1:length(GDAVG_magt)
    D(i) = mean(tmp_gdavg{i}.avg(x))*1e15;
end
for i = 1:length(GDAVG_magt)
   plot(dist(i),D(i),'color', 'r','marker','.','markersize',60);hold on
end
% four-bins
for i = 1:length(GDAVG_magt4)
    D4(i) = mean(tmp_gdavg{i}.avg(x))*1e15;
end

% b =bar([2 10 17 23],D4([4 3 2 1]),'alpha',0.3,'facecolor','r'); hold on
% b.FaceAlpha = 0.5;

p = [];
p = polyfit(dist,D,1)
yy = polyval(p,[-10 40])
plot([-10 40],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',30); hold on

axis([-2 30 -30 40])

set(gca, 'box','off','linewidth',5,'fontsize',50,'fontweight','b');
print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/Mags_Early_LinearDistT_Time_mean')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plots 1 sensor
fig = figure('position',[1 1 400 500]);
set(fig,'PaperPosition',[1 1 400 500])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

mask = (stat_magt.prob < 0.05);
x = find(mask == 1);

D = [];
p = [];
for i =1:size(GDAVGt_magt{1}.individual,1)
    for d = 1:length(GDAVG_magt)
        cfg = []; cfg.toilim = [stat_eegs.time(1) stat_magt.time(end)];
        tmp_gdavg{d} = ft_redefinetrial(cfg,GDAVGt_magt{d})
        tmp = []; tmp = squeeze(tmp_gdavg{d}.trial(i,:,:));
        D(i,d) = mean(tmp(x))*1e15;
    end
    p(i,:) = polyfit(dist,D(i,:),1)
    yy = polyval(p(i,:),[-10 40])
    if p(i,1) > 0
        plot([-10 40],[yy(1) yy(2)],'linewidth',3,'color',[1 0.5 0.5 0.5]); hold on
    else
        plot([-10 40],[yy(1) yy(2)],'linewidth',3,'color',[0.5 0.5 0.5 0.5]); hold on
    end
end


% rephase time of data and test
cfg = []; cfg.toilim = [stat_eegs.time(1) stat_magt.time(end)];
for i = 1:length(GDAVG_magt)
    tmp_gdavg{i} = ft_redefinetrial(cfg,GDAVG_magt{i})
end

% full range
D = [];
for i = 1:length(GDAVG_magt)
    D(i) = mean(tmp_gdavg{i}.avg(x))*1e15;
end
for i = 1:length(GDAVG_magt)
   plot(dist(i),D(i),'color', 'r','marker','.','markersize',60);hold on
end
% four-bins
for i = 1:length(GDAVG_magt4)
    D4(i) = mean(tmp_gdavg{i}.avg(x))*1e15;
end

p = [];
p = polyfit(dist,D,1)
yy = polyval(p,[-10 40])
plot([-10 40],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on

set(gca, 'box','off','linewidth',3,'fontsize',20,'fontweight','b');

axis([-5 35 -80 100])

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/Mags_Early_LinearDistT_Time_allsubj')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% plot barplots
% time intervals
Tstart(1) = find(abs(GDAVG_eegs{3}.time - stat_eegs.time(clust4(1))) < 1e-6);
Tend(1)   = find(abs(GDAVG_eegs{3}.time - stat_eegs.time(clust4(end))) < 1e-6);
interval = [Tstart(1):Tend(1)];

% plots full cluster
fig = figure('position',[1 1 800 800]);
set(fig,'PaperPosition',[1 1 800 800])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

mask = (stat_eegs.prob < 0.05);
x = find(mask == 1);

% rephase time of data and test
cfg = []; cfg.toilim = [stat_eegs.time(1) stat_eegs.time(end)];
for i = 1:length(GDAVG_eegs)
    tmp_gdavg{i} = ft_redefinetrial(cfg,GDAVG_eegs{i})
end

% full range
D = [];
for i = 1:length(GDAVG_eegs)
    D(i) = mean(tmp_gdavg{i}.avg(x))*1e6;
end
for i = 1:length(GDAVG_eegs)
   plot(dists(i),D(i),'color', 'b','marker','.','markersize',60);hold on
end
% four-bins
for i = 1:length(GDAVG_eegs4)
    D4(i) = mean(tmp_gdavg{i}.avg(x))*1e6;
end

% b =bar([2 10 17 23],D4([4 3 2 1]),'alpha',0.3,'facecolor','r'); hold on
% b.FaceAlpha = 0.5;

p = [];
p = polyfit(dists,D,1)
yy = polyval(p,[-10 150])
plot([-10 150],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',30); hold on

axis([-10 150 0 3])

set(gca, 'box','off','linewidth',5,'fontsize',50,'fontweight','b');
print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/EEG_Early_LinearDistS_Space_mean')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plots 1 sensor
fig = figure('position',[1 1 400 500]);
set(fig,'PaperPosition',[1 1 400 500])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

mask = (stat_eegs.prob < 0.05);
x = find(mask == 1);

D = [];
p = [];
for i =1:size(GDAVGt_eegs{1}.individual,1)
    for d = 1:length(GDAVG_eegs)
        cfg = []; cfg.toilim = [stat_eegs.time(1) stat_eegs.time(end)];
        tmp_gdavg{d} = ft_redefinetrial(cfg,GDAVGt_eegs{d})
        tmp = []; tmp = squeeze(tmp_gdavg{d}.trial(i,:,:));
        D(i,d) = mean(tmp(x))*1e6;
    end
    p(i,:) = polyfit(dists,D(i,:),1)
    yy = polyval(p(i,:),[-10 150])
    if p(i,1) > 0
        plot([-10 150],[yy(1) yy(2)],'linewidth',3,'color',[0.5 0.5 1]); hold on
    else
        plot([-10 150],[yy(1) yy(2)],'linewidth',3,'color',[0.5 0.5 0.5 0.5]); hold on
    end
end


% rephase time of data and test
cfg = []; cfg.toilim = [stat_eegs.time(1) stat_eegs.time(end)];
for i = 1:length(GDAVG_eegs)
    tmp_gdavg{i} = ft_redefinetrial(cfg,GDAVG_eegs{i})
end

% full range
D = [];
for i = 1:length(GDAVG_eegs)
    D(i) = mean(tmp_gdavg{i}.avg(x))*1e6;
end
for i = 1:length(GDAVG_eegs)
   plot(dists(i),D(i),'color', 'b','marker','.','markersize',60);hold on
end
% four-bins
for i = 1:length(GDAVG_eegs4)
    D4(i) = mean(tmp_gdavg{i}.avg(x))*1e6;
end

p = [];
p = polyfit(dists,D,1)
yy = polyval(p,[-10 150])
plot([-10 150],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on

set(gca, 'box','off','linewidth',3,'fontsize',20,'fontweight','b');

axis([-10 150 0 4])

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/Mags_Early_LinearDistS_Space_allsubj')















