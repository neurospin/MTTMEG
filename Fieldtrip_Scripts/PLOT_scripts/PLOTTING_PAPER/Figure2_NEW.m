addpath('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/PLOTTING_PAPER')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
condnames_clust= {'QsWest';'QsPar';'QsEast'};
condnames    = {'QsWest';'QsPar';'QsEast'};
latency      = [0 1];
graphcolor   = [[0 0 1];[0.5 0.5 0.5];[0 0 1]];
stat_test    = '';
chansel      = 'EEG';
clustnum     = 0;
clusttype    = 'posclust';
timetag      = '2016330125654';

[ch_f1, cdn_f1, cdn_clust_f1, stat_f1, GDAVG_f1, GDAVGt_f1] = prepare_comp(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
condnames_clust= {'QsWest';'QsEast'};
condnames    = {'QsWest';'QsEast'};
latency      = [0 1];
graphcolor   = [[0 0 1];[0.5 0.5 0.5];[0 0 1]];
stat_test    = 'T';
chansel      = 'Mags';
clustnum     = 0;
clusttype    = 'negclust';
timetag      = '2016720152333';

[ch_we, cdn_we, cdn_clust_we, stat_we, GDAVG_we, GDAVGt_we] = prepare_comp(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

%% TEST INPUT
latency      = [0 1];
graphcolor   = [[0.7 0.7 1];[0 0 0];[0 0 1]];
stat_test    = 'F';
chansel      = 'EEG';

% load "space-stats"
stat_space = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/spatial_clust_from_mne_unsig/stats_clust_' ...
    stat_test '_' 'QsWest_QsPar_QsEast__' chansel '_Lat' num2str(latency(1)) '-' num2str(latency(2))...
    '_stimlock_20169917958.mat'],'stat')

% load "time-stats"
stat_time = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/spatial_clust_from_mne_unsig/stats_clust_' ...
    stat_test '_' 'QtPast_QtPre_QtFut__' chansel '_Lat' num2str(latency(1)) '-' num2str(latency(2))...
    '_stimlock_20169917636.mat'],'stat')

%% TEST INPUT
latency      = [0 1];
graphcolor   = [[0.7 0.7 1];[0 0 0];[0 0 1]];
stat_test    = 'F';
chansel      = 'Mags';

% load "space-stats"
stat_space_meg = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/spatial_clust_from_mne_unsig/stats_clust_' ...
    stat_test '_' 'QsWest_QsPar_QsEast__' chansel '_Lat' num2str(latency(1)) '-' num2str(latency(2))...
    '_stimlock_201699162350.mat'],'stat')

% load "time-stats"
stat_time_meg = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/spatial_clust_from_mne_unsig/stats_clust_' ...
    stat_test '_' 'QtPast_QtPre_QtFut__' chansel '_Lat' num2str(latency(1)) '-' num2str(latency(2))...
    '_stimlock_201699162342.mat'],'stat')

%%%%%%%%%%%%%%%%%%%%%%%% prepare plotting layout %%%%%%%%%%%%%%%%%%%%%%%%%%
% select sensor datatype
[Grads1,Grads2,Mags]   = grads_for_layouts('Network');

% prepare layout
cfg                           = [];
cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/eeg_64_NM20884N.lay';

layeeg                        = ft_prepare_layout(cfg,GDAVG_f1{1});
layeeg.label                = GDAVG_f1{1}.label;

%%%%%%%%%%%%%%%%%%%%%%%% prepare plotting layout %%%%%%%%%%%%%%%%%%%%%%%%%%
% select sensor datatype
[Grads1,Grads2,Mags]   = grads_for_layouts('Network');

% prepare layout
cfg                           = [];
cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/fieldtrip-20130901/template/layout/NM306mag.lay';

lay                        = ft_prepare_layout(cfg,GDAVG_we{1});
lay.label                = GDAVG_we{1}.label;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EEG
times    = sum(stat_f1.prob <= 0.05);
plot(stat_f1.time,times)
[x,y]    = findpeaks(times);
indchaneeg = find(stat_f1.prob(:,y(2)) <=0.05);
clust   = find(sum(stat_f1.prob <= 0.05) > 0);

fig = figure('position',[1 1 400 400]);
set(fig,'PaperPosition',[1 1 400 400])
set(fig,'PaperPositionmode','auto')

cmap = colormap('hot')
cmap = cmap(10:55,:)
index = y(2);
cfg                    = [];
cfg.layout             = layeeg;
cfg.xlim               = [stat_f1.time(index) stat_f1.time(index)];
cfg.zlim               = [0 6]; % F-values
cfg.colormap           = 'jet';
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.colormap           = cmap ;
cfg.highlight          = 'on';
cfg.highlight          = {'on'};
cfg.highlightchannel   = {stat_f1.label(indchaneeg)};
cfg.highlightsymbol    = {'.'};
cfg.highlightsize      = {24} ;
cfg.highlightcolor     = {'k'};
cfg.comment            = num2str(stat_f1.time(index));
ft_topoplotER(cfg,stat_f1);
colorbar
print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/EEG_QtsSPace_topo')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EEG
times    = sum(stat_we.prob <= 0.05);
plot(stat_we.time,times)
[x,y]    = findpeaks(times);
indchan = find(stat_we.prob(:,y(2)) <=0.05);
clustmeg   = find(sum(stat_we.prob <= 0.05) > 0);

fig = figure('position',[1 1 400 400]);
set(fig,'PaperPosition',[1 1 400 400])
set(fig,'PaperPositionmode','auto')

cmap = colormap('jet')
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat_we.time(index) stat_we.time(index)];
cfg.zlim               = [-6 6]; % T-values
cfg.colormap           = 'jet';
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.colormap           = cmap ;
cfg.highlight          = 'on';
cfg.highlight          = {'on'};
cfg.highlightchannel   = {stat_we.label(indchaneeg)};
cfg.highlightsymbol    = {'.'};
cfg.highlightsize      = {24} ;
cfg.highlightcolor     = {'k'};
cfg.comment            = num2str(stat_we.time(index));
ft_topoplotER(cfg,stat_we);
colorbar
print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/mags_QtsSPace_topo')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 1400 600]);
set(fig,'PaperPosition',[1 1 1400 600])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

clust  = find(sum(stat_f1.prob <= 0.05) > 0);

% fmult
fmult = 1e6; % for express in uV

% stimulus onsets
line([0 0]    ,[-10 10],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on
line([1 1]    ,[-10 10],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on

% cluster shade
fill([0.676 0.676 0.805 0.805], [-2 2 2 -2],[0.8 0.8 0.8],'edgecolor',[0.8 0.8 0.8]);hold on

% timecourse
plot(GDAVG_f1{1}.time,mean(GDAVG_f1{1}.avg(indchaneeg,:)*fmult),'linewidth',8,'color',[0.7 0.7 1]);hold on
plot(GDAVG_f1{1}.time,mean(GDAVG_f1{2}.avg(indchaneeg,:)*fmult),'linewidth',8,'color',[0.35 0.35 1],'linestyle','-');hold on
plot(GDAVG_f1{1}.time,mean(GDAVG_f1{3}.avg(indchaneeg,:)*fmult),'linewidth',8,'color',[0 0 1],'linestyle','-');hold on

set(gca,'box','off','linewidth',4,'fontsize',40,'fontweight','b')
axis([-0.2 1.2 -2 2])

% ax1 = gca; % current axes
% ax1_pos = ax1.Position
% 
% % f-scores overlay
% shift = -8
% Y = [shift mean(stat_time.stat.stat(indchaneeg,:)) + ones(1,length(mean(stat_time.stat.stat(indchaneeg,:)))).*shift +shift];
% X = [0 stat_time.stat.time stat_time.stat.time(end)]
% fill(X,Y./4,'r','linestyle','none','facealpha',0.5); hold on
% 
% Y = [shift mean(stat_space.stat.stat(indchaneeg,:)) + ones(1,length(mean(stat_space.stat.stat(indchaneeg,:)))).*shift +shift];
% X = [0 stat_space.stat.time stat_space.stat.time(end)]
% fill(X,Y./4,'b','linestyle','none','facealpha',0.5); hold on
% 
% ax2 = axes('Position',ax1_pos,'XAxisLocation','top','YAxisLocation','right','Color','none');
% set(gca,'box','off','linewidth',4,'fontsize',40,'fontweight','b')
% 
% axis([-0.2 1.2 0 20])

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/MISC_PLOTS/Figures_PAPER/F_RefSpaceQt_cluster_eeg')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot F-test MEG
fig = figure('position',[1 1 1200 400]);
set(fig,'PaperPosition',[1 1 1200 400])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

plot(stat_time.stat.time,mean(stat_time.stat.stat(indchaneeg,:)),'color','r','linewidth',6); hold on
plot(stat_space.stat.time,mean(stat_space.stat.stat(indchaneeg,:)),'color','b','linewidth',6); hold on

% cluster shade
plot_lin_shade(clust, 0.05, stat_f1,'k',8) % significance window
set(gca,'linewidth',5,'fontsize',50)
set(gca, 'box' ,'off')
axis([0 1.2 0 8])

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/F_traces_Qts')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot F-test EEG
fig = figure('position',[1 1 1200 400]);
set(fig,'PaperPosition',[1 1 1200 400])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

plot(stat_time_meg.stat.time,mean(stat_time_meg.stat.stat(indchan,:)),'color','r','linewidth',6); hold on
plot(stat_space_meg.stat.time,mean(stat_space_meg.stat.stat(indchan,:)),'color','b','linewidth',6); hold on

% cluster shade
plot_lin_shade(clustmeg, 0.05, stat_we,'k',8) % significance window
set(gca,'linewidth',5,'fontsize',50)
set(gca, 'box' ,'off')
axis([0 1.2 0 8])

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/F_traces_Qts_mag')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clusteeg   = find(sum(stat_f1.prob <= 0.05) > 0);
times      = sum(stat_f1.prob <= 0.05);
[x,y]      = findpeaks(times);
indchaneeg = find(stat_f1.prob(:,y(2)) <=0.05);

Tstart(1) = find(abs(GDAVGt_f1{3}.time - stat_f1.time(clusteeg(1))) < 1e-6);
Tend(1)   = find(abs(GDAVGt_f1{3}.time - stat_f1.time(clusteeg(end))) < 1e-6);
interval = [Tstart(1):Tend(1)];

%% Barplots
fmult = 1e6

fig = figure('position',[1 1 800 800]);
set(fig,'PaperPosition',[1 1 800 800])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

dat1eeg = mean(mean(GDAVGt_f1{1}.individual(:,indchaneeg,[Tstart(1):Tend(1) ]),2),3)*fmult;
dat2eeg = mean(mean(GDAVGt_f1{2}.individual(:,indchaneeg,[Tstart(1):Tend(1) ]),2),3)*fmult;
dat3eeg = mean(mean(GDAVGt_f1{3}.individual(:,indchaneeg,[Tstart(1):Tend(1) ]),2),3)*fmult;

bar([mean(dat1eeg) 0 0],'facecolor',graphcolor(1,:),'edgecolor','k','linewidth',5);hold on
bar([0 mean(dat2eeg) 0],'facecolor',graphcolor(2,:),'edgecolor','k','linewidth',5);hold on
bar([0 0 mean(dat3eeg)],'facecolor',graphcolor(3,:),'edgecolor','k','linewidth',5);hold on
errorbar(mean([dat1eeg dat2eeg dat3eeg]),std([dat1eeg dat2eeg dat3eeg])./sqrt(19),'linestyle',...
    'none','color','k','linewidth',5)
set(gca, 'box','off','linewidth',5,'fontsize',50,'fontweight','b');
axis([0 4 -1 1.5])

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/Barplot_EEG_QsSpace')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% write for analysis in R
datafolder = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/for_R_data'

DataMat   = [[dat1eeg ;dat2eeg ;dat3eeg ]....
            [ones(19,1); ones(19,1)*2; ones(19,1)*3]...
            [1:19 1:19 1:19]'];
CondNames = {'Amplitude','Sref','Subject'}
write_csv_for_anova_R(DataMat, CondNames, [datafolder '/Eeg_QSREF'])





