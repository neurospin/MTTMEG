% Summary picture

stat_path = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/spatial_clust_from_mne';
addpath('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/PLOTTING_PAPER')

%% SignDistT
%load stat mags
stat = load([stat_path '/stats_negclust_T_0_REGfull_SignEVTdistT_Zero__Mags_Lat0-1_stimlock_20161024142255.mat'])
[x,y] = find(sum(stat.stat.mask,2) > 0)
chan_sel_stat = x;

DATAMAT = [];
cdn     = 'REGfull_SignEVTdistT';
chansel = 'Mags';
% load cell array of conditions
for j = 1:length(niplist)
    datatmp{j}   = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' ...
        niplist{j} '/MegData/ERPs_from_mne/' cdn chansel],'RegFullPerChanTime','dist','TL');
    DATAMAT(j,:) = mean(datatmp{j}.RegFullPerChanTime.avg(chan_sel_stat,:));
end

%% AbsDistT
%load stat mags
stat2 = load([stat_path '/stats_posclust_T_0_REGfull_EVTdistT_Zero__Mags_Lat0-1_stimlock_201692718828.mat'])
[x,y] = find(sum(stat2.stat.mask,2) > 0)
chan_sel_stat = x;

DATAMAT2 = [];
cdn     = 'REGfull_EVTdistT';
chansel = 'Mags';
% load cell array of conditions
for j = 1:length(niplist)
    datatmp{j}   = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' ...
        niplist{j} '/MegData/ERPs_from_mne/' cdn chansel],'RegFullPerChanTime','dist','TL');
    DATAMAT2(j,:) = mean(datatmp{j}.RegFullPerChanTime.avg(chan_sel_stat,:));
end

time_pts = datatmp{1}.RegFullPerChanTime.time;

%% plot summary
fig = figure('position',[1 1 700 500]);
set(fig,'PaperPosition',[1 1 700 500])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

line([time_pts(1) time_pts(end)],[0 0],'linestyle','-','color','k'); hold on
meanval = -mean(DATAMAT);
meansem = std(DATAMAT)./sqrt(19);
meanval2 = -mean(DATAMAT2);
meansem2 = std(DATAMAT2)./sqrt(19);
patch([time_pts time_pts(end:-1:1)],[[meanval2-meansem2] [meanval2(end:-1:1) + meansem2(end:-1:1)]],[0.7 0.7 0.7],'edgecolor','none','facealpha',0.15)
plot(time_pts,(-mean(DATAMAT2)),'color',[0.7 0.7 0.7],'linewidth',4)
patch([time_pts time_pts(end:-1:1)],[[meanval-meansem] [meanval(end:-1:1) + meansem(end:-1:1)]],[1 0 0],'edgecolor','none','facealpha',0.15)
plot(time_pts,(-mean(DATAMAT)),'red','linewidth',4)

xlabel('time (s)')
ylabel('regression betas (fT/year)')

set(gca,'xtick',[0 0.5 1 1.5 2],'xticklabel',[0 0.5 1 1.5 2])
set(gca,'ytick',[-5 0 5 10 15].*1e-16,'yticklabel',[-0.5 0 0.5 1 1.5])
set(gca,'box','off','linewidth',2)
axis([-0.2 1.5 -7e-16 12e-16])

%% plot zscore summary
fig = figure('position',[1 1 700 500]);
set(fig,'PaperPosition',[1 1 700 500])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

% express as a percentage of peak
DATAMAT_ = -DATAMAT./(min(mean(DATAMAT))).*100
DATAMAT2_ = -DATAMAT2./(min(mean(DATAMAT2))).*100

line([time_pts(1) time_pts(end)],[0 0],'linestyle','-','color','k'); hold on
meanval = -mean(DATAMAT_);
meansem = std(DATAMAT_)./sqrt(19);
meanval2 = -mean(DATAMAT2_);
meansem2 = std(DATAMAT2_)./sqrt(19);
patch([time_pts time_pts(end:-1:1)],[[meanval2-meansem2] [meanval2(end:-1:1) + meansem2(end:-1:1)]],[0.7 0.7 0.7],'edgecolor','none','facealpha',0.15)
plot(time_pts,meanval2,'color',[0.7 0.7 0.7],'linewidth',4)
patch([time_pts time_pts(end:-1:1)],[[meanval-meansem] [meanval(end:-1:1) + meansem(end:-1:1)]],[1 0 0],'edgecolor','none','facealpha',0.15)
plot(time_pts,meanval,'red','linewidth',4)

clust1   = find(sum(stat.stat.prob <= 0.025) > 0);
plot_lin_shade(clust1, 0.025, stat.stat,[1 0 0],135);hold on % significance window
clust2   = find(sum(stat2.stat.prob <= 0.025) > 0);
plot_lin_shade(clust2, 0.025, stat2.stat,[0.7 0.7 0.7],125);hold on % significance window

xlabel('time (s)')
ylabel('regression betas (% peak)')

set(gca,'xtick',[0 0.5 1 1.5 2],'xticklabel',[0 0.5 1 1.5 2])
set(gca,'ytick',[-50 0 50 100 150],'yticklabel',[-50 0 50 100 150])
set(gca,'box','off','linewidth',2)
axis([-0.2 1.5 -50 150])

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/distT_summary')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
stat_path = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/spatial_clust_from_mne';

%% Es Sproj
%load stat mags
stat = load([stat_path '/stats_posclust_F_0_EsWest_EsPar_EsEast__EEG_Lat0-1_stimlock_201675163329.mat'])
[x,y] = find(sum(stat.stat.mask,2) > 0)
chan_sel_stat = x;

DATAMAT = [];
clear datatmp
cdn     = 'EsWest_EsPar_EsEast_';
chansel = 'EEG';
% load cell array of conditions
for j = 1:length(niplist)
    datatmp{j}   = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' ...
        niplist{j} '/MegData/ERPs_from_mne/' cdn chansel],'timelockbase');
    DATAMAT_1(j,:) = mean(datatmp{j}.timelockbase{1}.avg(chan_sel_stat,:));
    DATAMAT_2(j,:) = mean(datatmp{j}.timelockbase{2}.avg(chan_sel_stat,:));
    DATAMAT_3(j,:) = mean(datatmp{j}.timelockbase{3}.avg(chan_sel_stat,:));
end

time_pts = datatmp{j}.timelockbase{1}.time;

%% AbsDistT
%load stat mags
stat2 = load([stat_path '/stats_posclust_0_EtPastG_EtPreG_EtFutG__EEG_Lat0-1_stimlock_20163313258.mat'])
[x,y] = find(sum(stat2.stat.mask,2) > 0)
chan_sel_stat = x;

DATAMAT2 = [];
cdn     = 'EtPastG_EtPreG_EtFutG_';
chansel = 'EEG';
% load cell array of conditions
for j = 1:length(niplist)
    datatmp{j}   = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' ...
         niplist{j} '/MegData/ERPs_from_mne/' cdn chansel],'timelockbase');
    DATAMAT_1b(j,:) = mean(datatmp{j}.timelockbase{1}.avg(chan_sel_stat,:));
    DATAMAT_2b(j,:) = mean(datatmp{j}.timelockbase{2}.avg(chan_sel_stat,:));
    DATAMAT_3b(j,:) = mean(datatmp{j}.timelockbase{3}.avg(chan_sel_stat,:));
end

time_pts2 = datatmp{j}.timelockbase{1}.time;

% %% plot summary
% fig = figure('position',[1 1 700 500]);
% set(fig,'PaperPosition',[1 1 700 500])
% set(fig,'PaperPositionmode','auto')
% set(fig,'Visible','on')
% 
% line([time_pts(1) time_pts(end)],[0 0],'linestyle','-','color','k'); hold on
% meanval = mean((DATAMAT_1 + DATAMAT_3)/2 - DATAMAT_2);
% meansem = std((DATAMAT_1 + DATAMAT_3)/2 - DATAMAT_2)./sqrt(19);
% meanval2 = mean((DATAMAT_1b + DATAMAT_3b)/2 - DATAMAT_2b);
% meansem2 = std((DATAMAT_1b + DATAMAT_3b)/2 - DATAMAT_2b)./sqrt(19);
% patch([time_pts2 time_pts2(end:-1:1)],[[meanval2-meansem2] [meanval2(end:-1:1) + meansem2(end:-1:1)]],[1 0 0],'edgecolor','none','facealpha',0.15)
% plot(time_pts2,(meanval2),'color',[1 0 0],'linewidth',4)
% patch([time_pts time_pts(end:-1:1)],[[meanval-meansem] [meanval(end:-1:1) + meansem(end:-1:1)]],[ 0 0 1],'edgecolor','none','facealpha',0.15)
% plot(time_pts,(meanval),'blue','linewidth',4)
% 
% xlabel('time (s)')
% ylabel('regression betas (fT/year)')
% 
% set(gca,'xtick',[0 0.5 1 1.5 2],'xticklabel',[0 0.5 1 1.5 2])
% set(gca,'ytick',[-5 0 5 10 15].*1e-16,'yticklabel',[-0.5 0 0.5 1 1.5])
% set(gca,'box','off','linewidth',2)
% axis([-0.2 1.5 -7e-16 12e-16])

%% plot zscore summary
fig = figure('position',[1 1 700 500]);
set(fig,'PaperPosition',[1 1 700 500])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

% express as a percentage of peak
line([time_pts(1) time_pts(end)],[0 0],'linestyle','-','color','k'); hold on

DATAMAT  = (DATAMAT_1 + DATAMAT_3)/2 - DATAMAT_2;
DATAMAT2 = (DATAMAT_1b + DATAMAT_3b)/2 - DATAMAT_2b;

DATAMAT_ = DATAMAT./(min(mean(DATAMAT))).*100
DATAMAT2_ = DATAMAT2./(min(mean(DATAMAT2))).*100

meanval = mean(DATAMAT_);
meansem = std(DATAMAT_)./sqrt(19);
meanval2 = mean(DATAMAT2_);
meansem2 = std(DATAMAT2_)./sqrt(19);

hold on
patch([time_pts2 time_pts2(end:-1:1)],[[meanval2-meansem2] [meanval2(end:-1:1) + meansem2(end:-1:1)]],[1 0 0],'edgecolor','none','facealpha',0.15)
plot(time_pts2,meanval2,'color',[1 0 0],'linewidth',2)
patch([time_pts time_pts(end:-1:1)],[[meanval-meansem] [meanval(end:-1:1) + meansem(end:-1:1)]],[0 0 1],'edgecolor','none','facealpha',0.15)
plot(time_pts,meanval,'blue','linewidth',2)

clust1   = find(sum(stat.stat.prob <= 0.025) > 0);
plot_lin_shade_new(clust1, 0.025, stat.stat,[0 0 1],meanval,time_pts);hold on % significance window
clust2   = find(sum(stat2.stat.prob <= 0.025) > 0);
plot_lin_shade_new(clust2, 0.025, stat2.stat,[1 0 0],meanval2,time_pts2);hold on % significance window

xlabel('time (s)')
ylabel('difference (% peak)')

set(gca,'xtick',[0 0.5 1 1.5 2],'xticklabel',[0 0.5 1 1.5 2])
set(gca,'ytick',[-50 0 50 100 150],'yticklabel',[-50 0 50 100 150])
set(gca,'box','off','linewidth',2)
axis([-0.2 1.5 -50 150])

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/Event_Proj_summary')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Self-projection
% Summary picture

stat_path = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/spatial_clust_from_mne';

%% SignDistS
%load stat mags
stat = load([stat_path '/stats_posclust_T_1_REGfull_SignEVSdistS_Zero__Grads2_Lat0-1_stimlock_2016102414316.mat'])
[x,y] = find(sum(stat.stat.mask,2) > 0)
chan_sel_stat = x;

DATAMAT = [];
cdn     = 'REGfull_SignEVSdistS';
chansel = 'Grads2';
% load cell array of conditions
for j = 1:length(niplist)
    datatmp{j}   = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' ...
        niplist{j} '/MegData/ERPs_from_mne/' cdn chansel],'RegFullPerChanTime','dist','TL');
    DATAMAT(j,:) = mean(datatmp{j}.RegFullPerChanTime.avg(chan_sel_stat,:));
end

%% AbsDistS
%load stat mags
stat2 = load([stat_path '/stats_negclust_T_1_REGfull_EVSdistS_Zero__EEG_Lat0-1_stimlock_201684153143.mat'])
[x,y] = find(sum(stat2.stat.mask,2) > 0)
chan_sel_stat = x;

DATAMAT2 = [];
cdn     = 'REGfull_EVSdistS';
chansel = 'Mags';
% load cell array of conditions
for j = 1:length(niplist)
    datatmp{j}   = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' ...
        niplist{j} '/MegData/ERPs_from_mne/' cdn chansel],'RegFullPerChanTime','dist','TL');
    DATAMAT2(j,:) = mean(datatmp{j}.RegFullPerChanTime.avg(chan_sel_stat,:));
end

time_pts = datatmp{1}.RegFullPerChanTime.time;

%% plot zscore summary
fig = figure('position',[1 1 700 500]);
set(fig,'PaperPosition',[1 1 700 500])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

% express as a percentage of peak
DATAMAT_ = -DATAMAT./(min(mean(DATAMAT))).*100
DATAMAT2_ = -DATAMAT2./(min(mean(DATAMAT2))).*100

line([time_pts(1) time_pts(end)],[0 0],'linestyle','-','color','k'); hold on
meanval = -mean(DATAMAT_);
meansem = std(DATAMAT_)./sqrt(19);
meanval2 = -mean(DATAMAT2_);
meansem2 = std(DATAMAT2_)./sqrt(19);
patch([time_pts time_pts(end:-1:1)],[[meanval2-meansem2] [meanval2(end:-1:1) + meansem2(end:-1:1)]],[0.7 0.7 0.7],'edgecolor','none','facealpha',0.15)
plot(time_pts,meanval2,'color',[0.7 0.7 0.7],'linewidth',2)
patch([time_pts time_pts(end:-1:1)],[[meanval-meansem] [meanval(end:-1:1) + meansem(end:-1:1)]],[0 0 1],'edgecolor','none','facealpha',0.15)
plot(time_pts,meanval,'blue','linewidth',2)

clust1   = find(sum(stat.stat.prob <= 0.025) > 0);
plot_lin_shade_new(clust1, 0.025, stat.stat,[0 0 1],meanval,time_pts);hold on % significance window
clust2   = find(sum(stat2.stat.prob <= 0.025) > 0);
plot_lin_shade_new(clust2, 0.025, stat2.stat,[0.7 0.7 0.7],meanval2,time_pts);hold on % significance window

xlabel('time (s)')
ylabel('regression betas (% peak)')

set(gca,'xtick',[0 0.5 1 1.5 2],'xticklabel',[0 0.5 1 1.5 2])
set(gca,'ytick',[-50 0 50 100 150],'yticklabel',[-50 0 50 100 150])
set(gca,'box','off','linewidth',2)
axis([-0.2 1.5 -50 150])

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/distS_summary')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Self-projection ref
% Summary picture
stat_path = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/spatial_clust_from_mne';

%% ref t
%load stat mags
stat = load([stat_path '/stats_posclust_F_1_RefPast_RefPre_RefFut__EEG_Lat1.1-2_stimlock_201659184413.mat'])
[x,y] = find(sum(stat.stat.mask,2) > 0)
chan_sel_stat = x;

DATAMAT = [];
cdn     = 'REG_RefPast_RefPre_RefFut_';
chansel = 'EEG';
% load cell array of conditions
for j = 1:length(niplist)
    datatmp{j}   = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' ...
        niplist{j} '/MegData/ERPs_from_mne/' cdn chansel],'RegPerChanTime');
    DATAMAT(j,:) = mean(datatmp{j}.RegPerChanTime.avg(chan_sel_stat,:));
end

time_pts = datatmp{1}.RegPerChanTime.time;

%% ref s
%load stat mags
stat = load([stat_path '/stats_posclust_F_1_RefPast_RefPre_RefFut__EEG_Lat1.1-2_stimlock_201659184413.mat'])
[x,y] = find(sum(stat.stat.mask,2) > 0)
chan_sel_stat = x;

DATAMAT_2 = [];
cdn     = 'REG_RefW_RefPar_RefE_';
chansel = 'EEG';
% load cell array of conditions
for j = 1:length(niplist)
    datatmp{j}   = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' ...
        niplist{j} '/MegData/ERPs_from_mne/' cdn chansel],'RegPerChanTime');
    DATAMAT2(j,:) = mean(datatmp{j}.RegPerChanTime.avg(chan_sel_stat,:));
end

time_pts2 = datatmp{1}.RegPerChanTime.time;

%% plot zscore summary
fig = figure('position',[1 1 1400 500]);
set(fig,'PaperPosition',[1 1 1400 500])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

% express as a percentage of peak
minabs1 = min(mean(DATAMAT));

DATAMAT_ = (DATAMAT./minabs1).*100
DATAMAT2_ = (DATAMAT2./minabs1).*100

line([time_pts(1) time_pts(end)],[0 0],'linestyle','-','color','k'); hold on
meanval = mean(DATAMAT_);
meansem = std(DATAMAT_)./sqrt(19);
meanval2 = mean(DATAMAT2_);
meansem2 = std(DATAMAT2_)./sqrt(19);

patch([time_pts2 time_pts2(end:-1:1)],[[meanval2-meansem2] [meanval2(end:-1:1) + meansem2(end:-1:1)]],[0.3 0.3 1],'edgecolor','none','facealpha',0.15);hold on
plot(time_pts2,meanval2,'color',[0.6 0.6 1],'linewidth',2)
patch([time_pts time_pts(end:-1:1)],[[meanval-meansem] [meanval(end:-1:1) + meansem(end:-1:1)]],[0.9 0 0],'edgecolor','none','facealpha',0.15);hold on
plot(time_pts,meanval,'color',[0.9 0 0],'linewidth',2)

clust1   = find(sum(stat.stat.prob <= 0.05) > 0);hold on
plot_lin_shade_new(clust1, 0.05, stat.stat,[1 0 0],meanval,time_pts);hold on % significance window


xlabel('time (s)')
ylabel('Regression beta (% peak)')

set(gca,'xtick',[0 0.5 1 1.5 2],'xticklabel',[0 0.5 1 1.5 2])
set(gca,'ytick',[-50 0 50 100 150],'yticklabel',[-50 0 50 100 150])
set(gca,'box','off','linewidth',2)
axis([-0.2 2.2 -75 150])

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/ProjT_summary')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Self-projection ref
% Summary picture
stat_path = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/spatial_clust_from_mne';

%% qt t
%load stat mags
stat = load([stat_path '/stats_posclust_0_QsWest_QsPar_QsEast__EEG_Lat0-1_stimlock_2016330125654.mat'])
[x,y] = find(sum(stat.stat.mask,2) > 0)
chan_sel_stat = x;

DATAMAT = [];
cdn     = 'REG_QtPast_QtPre_QtFut_';
chansel = 'EEG';
% load cell array of conditions
for j = 1:length(niplist)
    datatmp{j}   = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' ...
        niplist{j} '/MegData/ERPs_from_mne/' cdn chansel],'RegPerChanTime');
    DATAMAT(j,:) = mean(datatmp{j}.RegPerChanTime.avg(chan_sel_stat,:));
end

time_pts = datatmp{j}.RegPerChanTime.time;

%% qt s
%load stat mags
stat = load([stat_path '/stats_posclust_0_QsWest_QsPar_QsEast__EEG_Lat0-1_stimlock_2016330125654.mat'])
[x,y] = find(sum(stat.stat.mask,2) > 0)
chan_sel_stat = x;

DATAMAT2 = [];
cdn     = 'REG_QsWest_QsPar_QsEast_';
chansel = 'EEG';
% load cell array of conditions
for j = 1:length(niplist)
    datatmp{j}   = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' ...
        niplist{j} '/MegData/ERPs_from_mne/' cdn chansel],'RegPerChanTime');
    DATAMAT2(j,:) = mean(datatmp{j}.RegPerChanTime.avg(chan_sel_stat,:));
end

time_pts2 = datatmp{j}.RegPerChanTime.time;

%% plot zscore summary
fig = figure('position',[1 1 700 500]);
set(fig,'PaperPosition',[1 1 700 500])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

% express as a percentage of peak
minabs1 = -3.045e-7;

DATAMAT_ = (DATAMAT./minabs1).*100
DATAMAT2_ = (DATAMAT2./minabs1).*100

line([time_pts(1) time_pts(end)],[0 0],'linestyle','-','color','k'); hold on
meanval = mean(DATAMAT_);
meansem = std(DATAMAT_)./sqrt(19);
meanval2 = mean(DATAMAT2_);
meansem2 = std(DATAMAT2_)./sqrt(19);

patch([time_pts time_pts(end:-1:1)],[[meanval-meansem] [meanval(end:-1:1) + meansem(end:-1:1)]],[1 0.3 0.3],'edgecolor','none','facealpha',0.15);hold on
plot(time_pts,meanval,'color',[1 0.6 0.6],'linewidth',2)
patch([time_pts2 time_pts2(end:-1:1)],[[meanval2-meansem2] [meanval2(end:-1:1) + meansem2(end:-1:1)]],[0 0 0.9],'edgecolor','none','facealpha',0.15);hold on
plot(time_pts2,meanval2,'color',[0 0 0.9],'linewidth',2)

clust1   = find(sum(stat.stat.prob <= 0.05) > 0);
plot_lin_shade_new(clust1, 0.025, stat.stat,[0 0 1],meanval2,time_pts2);hold on % significance window

xlabel('time (s)')
ylabel('regression beta (% peak)')

set(gca,'xtick',[0 0.5 1 1.5 2],'xticklabel',[0 0.5 1 1.5 2])
set(gca,'ytick',[-50 0 50 100 150],'yticklabel',[-50 0 50 100 150])
set(gca,'box','off','linewidth',2)
axis([-0.2 1 -75 150])

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/ProjS_summary')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






