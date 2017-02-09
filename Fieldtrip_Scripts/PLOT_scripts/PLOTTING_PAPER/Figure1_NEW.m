addpath('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/PLOTTING_PAPER')

%% TEST INPUT 1 mags occipital
condnames_clust = {'RefPast';'RefPre';'RefFut'};
condnames    = {'RefPast';'RefPre';'RefFut'};
latency      = [0.3 1.1];
graphcolor   = [[1 0.7 0.7];[0.5 0.5 0.5];[1 0 0]];
stat_test    = 'F';
chansel      = 'Mags';
clustnum     = 0;
clusttype    = 'posclust';
timetag      = '2016510191545';

[ch_prepas, cdn_prepas, cdn_clust_prepas, stat_prepas, GDAVG_prepas, GDAVGt_prepas] = prepare_comp(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

% load "space-stats"
stat_counter2 = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/spatial_clust_from_mne_unsig/stats_clust_' ...
    stat_test '_' 'RefW_RefPar_RefE__' chansel '_Lat' num2str(latency(1)) '-' num2str(latency(2))...
    '_stimlock_201699103348.mat'],'stat')
latency       = [0 0.3];
stat_counter1 = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/spatial_clust_from_mne_unsig/stats_clust_' ...
    stat_test '_' 'RefW_RefPar_RefE__' chansel '_Lat' num2str(latency(1)) '-' num2str(latency(2))...
    '_stimlock_20169995829.mat'],'stat')
latency      = [1.1 2.2];
stat_counter3 = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/spatial_clust_from_mne_unsig/stats_clust_' ...
    stat_test '_' 'RefW_RefPar_RefE__' chansel '_Lat' num2str(latency(1)) '-' num2str(latency(2))...
    '_stimlock_20169912417.mat'],'stat')

% load "time-stats"
latency       = [0 0.3];
stat_time1 = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/spatial_clust_from_mne_unsig/stats_clust_' ...
    stat_test '_' 'RefPast_RefPre_RefFut__' chansel '_Lat' num2str(latency(1)) '-' num2str(latency(2))...
    '_stimlock_2016999582.mat'],'stat')
latency       = [0.3 1.1];
stat_time2 = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/spatial_clust_from_mne_unsig/stats_clust_' ...
    stat_test '_' 'RefPast_RefPre_RefFut__' chansel '_Lat' num2str(latency(1)) '-' num2str(latency(2))...
    '_stimlock_201699101247.mat'],'stat')
latency      = [1.1 2.2];
stat_time3 = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/spatial_clust_from_mne_unsig/stats_clust_' ...
    stat_test '_' 'RefPast_RefPre_RefFut__' chansel '_Lat' num2str(latency(1)) '-' num2str(latency(2))...
    '_stimlock_201699105051.mat'],'stat')

%% TEST INPUT 1 mags occipital
condnames_clust = {'RefPast';'RefPre';'RefFut'};
condnames    = {'RefPast';'RefPre';'RefFut'};
latency      = [1.1 2];
graphcolor   = [[1 0.7 0.7];[0.5 0.5 0.5];[1 0 0]];
stat_test    = 'F';
chansel      = 'EEG';
clustnum     = 0;
clusttype    = 'posclust';
timetag      = '201659184413';

[ch_eeg, cdn_eeg, cdn_clust_eeg, stat_eeg, GDAVG_eeg, GDAVGt_eeg] = prepare_comp(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

% load "time-stats"
latency       = [0 0.3];
stateeg_time1 = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/spatial_clust_from_mne_unsig/stats_clust_' ...
    stat_test '_RefPast_RefPre_RefFut__' chansel '_Lat' num2str(latency(1)) '-' num2str(latency(2))...
    '_stimlock_20169995738.mat'],'stat')
latency       = [0.3 1.1];
stateeg_time2 = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/spatial_clust_from_mne_unsig/stats_clust_' ...
    stat_test '_RefPast_RefPre_RefFut__' chansel '_Lat' num2str(latency(1)) '-' num2str(latency(2))...
    '_stimlock_2016991096.mat'],'stat')
latency      = [1.1 2.2];
stateeg_time3 = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/spatial_clust_from_mne_unsig/stats_clust_' ...
    stat_test '_RefPast_RefPre_RefFut__' chansel '_Lat' num2str(latency(1)) '-' num2str(latency(2))...
    '_stimlock_201699103711.mat'],'stat')

% load "space-stats"
latency       = [0 0.3];
stateeg_space1 = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/spatial_clust_from_mne_unsig/stats_clust_' ...
    stat_test '_RefW_RefPar_RefE__' chansel '_Lat' num2str(latency(1)) '-' num2str(latency(2))...
    '_stimlock_20169995814.mat'],'stat')
latency       = [0.3 1.1];
stateeg_space2 = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/spatial_clust_from_mne_unsig/stats_clust_' ...
    stat_test '_RefW_RefPar_RefE__' chansel '_Lat' num2str(latency(1)) '-' num2str(latency(2))...
    '_stimlock_201699102345.mat'],'stat')
latency      = [1.1 2.2];
stateeg_space3 = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/spatial_clust_from_mne_unsig/stats_clust_' ...
    stat_test '_RefW_RefPar_RefE__' chansel '_Lat' num2str(latency(1)) '-' num2str(latency(2))...
    '_stimlock_201699112910.mat'],'stat')

%%%%%%%%%%%%%%%%%%%%%%%% prepare plotting layout %%%%%%%%%%%%%%%%%%%%%%%%%%
% select sensor datatype
[Grads1,Grads2,Mags]   = grads_for_layouts('Network');

% prepare layout
cfg                           = [];
cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/eeg_64_NM20884N.lay';

layeeg                        = ft_prepare_layout(cfg,GDAVG_eeg{1});
layeeg.label                = GDAVG_eeg{1}.label;

%%%%%%%%%%%%%%%%%%%%%%%% prepare plotting layout %%%%%%%%%%%%%%%%%%%%%%%%%%
% select sensor datatype
[Grads1,Grads2,Mags]   = grads_for_layouts('Network');

% prepare layout
cfg                           = [];
cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/fieldtrip-20130901/template/layout/NM306mag.lay';

lay                        = ft_prepare_layout(cfg,GDAVG_prepas{1});
lay.label                = GDAVG_prepas{1}.label;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EEG
times    = sum(stat_eeg.prob <= 0.05);
plot(stat_eeg.time,times)
[x,y]    = findpeaks(times);
indchaneeg = find(stat_eeg.prob(:,y(4)) <=0.05);
clust   = find(sum(stat_eeg.prob <= 0.05) > 0);

fig = figure('position',[1 1 400 400]);
set(fig,'PaperPosition',[1 1 400 400])
set(fig,'PaperPositionmode','auto')

cmap = colormap('hot')
cmap = cmap(10:55,:)
index = y(4);
cfg                    = [];
cfg.layout             = layeeg;
cfg.xlim               = [stat_eeg.time(index) stat_eeg.time(index)];
cfg.zlim               = [0 6]; % F-values
cfg.colormap           = 'jet';
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.colormap           = cmap ;
cfg.highlight          = 'on';
cfg.highlight          = {'on'};
cfg.highlightchannel   = {stat_eeg.label(indchaneeg)};
cfg.highlightsymbol    = {'.'};
cfg.highlightsize      = {24} ;
cfg.highlightcolor     = {'k'};
cfg.comment            = num2str(stat_eeg.time(index));
ft_topoplotER(cfg,stat_eeg);
colorbar
print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/EEG_REFTime_topo')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MEG
times    = sum(stat_prepas.prob <= 0.05);
plot(stat_prepas.time,times)
[x,y]    = findpeaks(times);
indchan = find(stat_prepas.prob(:,y(5)) <=0.05);
clust   = find(sum(stat_prepas.prob <= 0.05) > 0);

fig = figure('position',[1 1 400 400]);
set(fig,'PaperPosition',[1 1 400 400])
set(fig,'PaperPositionmode','auto')

cmap = colormap('hot')
cmap = cmap(10:55,:)
index = y(5);
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat_prepas.time(index) stat_prepas.time(index)];
cfg.zlim               = [0 6]; % F-values
cfg.colormap           = 'jet';
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.colormap           = cmap ;
cfg.highlight          = 'on';
cfg.highlight          = {'on'};
cfg.highlightchannel   = {stat_prepas.label(indchan2plot)};
cfg.highlightsymbol    = {'.'};
cfg.highlightsize      = {24} ;
cfg.highlightcolor     = {'k'};
cfg.comment            = num2str(stat_prepas.time(index));
ft_topoplotER(cfg,stat_prepas);
colorbar
print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/MEG_REFTime_topo')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% cluster frontal
times = sum(stat_prepas.prob <= 0.05);
plot(stat_prepas.time,times)
[x,y] = findpeaks(times);

chan_front = {'MEG0121', 'MEG0211', 'MEG0221', 'MEG0311', 'MEG0321', 'MEG0331',...
              'MEG0341', 'MEG0411', 'MEG0421', 'MEG0511', 'MEG0521', 'MEG0531',...
              'MEG0541', 'MEG0611', 'MEG0621', 'MEG0631', 'MEG0641', 'MEG0811',...
              'MEG0821', 'MEG0911', 'MEG0921', 'MEG0931', 'MEG0941', 'MEG1011',...
              'MEG1021', 'MEG1031', 'MEG1041', 'MEG1111', 'MEG1121', 'MEG1211',...
              'MEG1231', 'MEG1241', 'MEG1311'}
indchan = []; indchan = find(stat_prepas.prob(:,y(5)) <0.05);  

% get the indexes of frontal sensor
ind_front = []
count = 1;
for i = 1:length(stat_prepas.label)
    for j = 1:length(chan_front)
        if strcmp(stat_prepas.label{i},chan_front{j})
            ind_front(count) = i;
            count = count +1;
        end
    end
end

indchan2plot = intersect(ind_front,indchan)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot F-test MEG
fig = figure('position',[1 1 1600 400]);
set(fig,'PaperPosition',[1 1 1600 400])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

set_axes(-0.2, 2.5, 0,10);

plot(stat_time1.stat.time,mean(stat_time1.stat.stat(indchan2plot,:)),'color','r','linewidth',6); hold on
plot(stat_time2.stat.time,mean(stat_time2.stat.stat(indchan2plot,:)),'color','r','linewidth',6); hold on
plot(stat_time3.stat.time,mean(stat_time3.stat.stat(indchan2plot,:)),'color','r','linewidth',6); hold on

plot(stat_counter1.stat.time,mean(stat_counter1.stat.stat(indchan2plot,:)),'color','b','linewidth',6); hold on
plot(stat_counter2.stat.time,mean(stat_counter2.stat.stat(indchan2plot,:)),'color','b','linewidth',6); hold on
plot(stat_counter3.stat.time,mean(stat_counter3.stat.stat(indchan2plot,:)),'color','b','linewidth',6); hold on
set(gca,'linewidth',5,'fontsize',50)

% cluster shade
plot_lin_shade(clust, 0.05, stat_prepas,'k',10) % significance window

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/F_traces_Ref')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot F-test EEG
fig = figure('position',[1 1 1600 400]);
set(fig,'PaperPosition',[1 1 1600 400])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

set_axes(-0.2, 2.5, 0,10);

% cluster shade
plot_lin_shade(clust, 0.05, stat_eeg,'k',11) % significance window

indchan2plot = intersect(ind_front,indchan)
plot(stateeg_time1.stat.time,mean(stateeg_time1.stat.stat(indchaneeg,:)),'color','r','linewidth',6); hold on
plot(stateeg_time2.stat.time,mean(stateeg_time2.stat.stat(indchaneeg,:)),'color','r','linewidth',6); hold on
plot(stateeg_time3.stat.time,mean(stateeg_time3.stat.stat(indchaneeg,:)),'color','r','linewidth',6); hold on

plot(stateeg_space1.stat.time,mean(stateeg_space1.stat.stat(indchaneeg,:)),'color','b','linewidth',6); hold on
plot(stateeg_space2.stat.time,mean(stateeg_space2.stat.stat(indchaneeg,:)),'color','b','linewidth',6); hold on
plot(stateeg_space3.stat.time,mean(stateeg_space3.stat.stat(indchaneeg,:)),'color','b','linewidth',6); hold on
set(gca,'linewidth',5,'fontsize',50)

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/F_traces_RefEEG')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 1600 800]);
set(fig,'PaperPosition',[1 1 1600 800])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

clust  = find(sum(stat_prepas.prob <= 0.05) > 0);

% fmult
fmult = 1e14; % for express in uV
set_axes(0.9, 2, -8,6);

% stimulus onsets
line([0 0]    ,[-5 5],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on
line([1.1 1.1],[-5 5],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on
line([2 2 ],[-5 5],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on

% cluster shade
plot_lin_shade(clust, 0.05, stat_prepas,'k',-5) % significance window

% timecourse
plot(GDAVG_prepas{1}.time,GDAVG_prepas{1}.avg(indchan2plot(8),:)*fmult,'linewidth',8,'color',graphcolor(1,:));hold on
plot(GDAVG_prepas{1}.time,GDAVG_prepas{2}.avg(indchan2plot(8),:)*fmult,'linewidth',8,'color',graphcolor(2,:));hold on
plot(GDAVG_prepas{1}.time,GDAVG_prepas{3}.avg(indchan2plot(8),:)*fmult,'linewidth',8,'color',graphcolor(3,:));hold on
set(gca,'linewidth',5,'fontsize',50)

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/MISC_PLOTS/Figures_PAPER/F_RefTime_bestchan')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 1600 600]);
set(fig,'PaperPosition',[1 1 1600 600])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

clust  = find(sum(stat_prepas.prob <= 0.05) > 0);

% fmult
fmult = 1e14; % for express in uV

% stimulus onsets
line([0 0]    ,[-7 8],'linestyle',':','linewidth',4,'color','k'); hold on
line([0.3 0.3],[-7 8],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on
line([1.1 1.1],[-7 8],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on
line([2 2],[-7 8],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on

% cluster shade
fill([0.364 0.364 0.684 0.684], [-4 5 5 -4],[0.8 0.8 0.8],'edgecolor',[0.8 0.8 0.8]);hold on
fill([0.76 0.760 1.048 1.048], [-4 5 5 -4],[0.8 0.8 0.8],'edgecolor',[0.8 0.8 0.8]);hold on

% timecourse
plot(GDAVG_prepas{1}.time,mean(GDAVG_prepas{1}.avg(indchan2plot,:)*fmult),'linewidth',8,'color',[1 0.7 0.7]);hold on
plot(GDAVG_prepas{1}.time,mean(GDAVG_prepas{2}.avg(indchan2plot,:)*fmult),'linewidth',8,'color',[1 0.35 0.35]);hold on
plot(GDAVG_prepas{1}.time,mean(GDAVG_prepas{3}.avg(indchan2plot,:)*fmult),'linewidth',8,'color',[1 0 0]);hold on

set(gca,'box','off','linewidth',4,'fontsize',40,'fontweight','b')
set(gca,'ytick',[-4 0 4],'yticklabel',[-40 0 40])
axis([-0.2 2.2 -4 5])

% ax1 = gca; % current axes
% ax1_pos = ax1.Position
% 
% % f-scores overlay
% shift = -12
% Y = [shift mean(stat_time1.stat.stat(indchan2plot,:)) + ones(1,length(mean(stat_time1.stat.stat(indchan2plot,:)))).*shift ...
%     mean(stat_time2.stat.stat(indchan2plot,:)) + ones(1,length(mean(stat_time2.stat.stat(indchan2plot,:)))).*shift ...
%     mean(stat_time3.stat.stat(indchan2plot,:)) + ones(1,length(mean(stat_time3.stat.stat(indchan2plot,:)))).*shift +shift];
% X = [0 stat_time1.stat.time stat_time2.stat.time stat_time3.stat.time stat_time3.stat.time(end)]
% fill(X,Y./2,'r','linestyle','none','facealpha',0.5); hold on
% 
% Y = [shift mean(stat_counter1.stat.stat(indchan2plot,:)) + ones(1,length(mean(stat_counter1.stat.stat(indchan2plot,:)))).*shift ...
%     mean(stat_counter2.stat.stat(indchan2plot,:)) + ones(1,length(mean(stat_counter2.stat.stat(indchan2plot,:)))).*shift ...
%     mean(stat_counter3.stat.stat(indchan2plot,:)) + ones(1,length(mean(stat_counter3.stat.stat(indchan2plot,:)))).*shift +shift];
% X = [0 stat_counter1.stat.time stat_counter2.stat.time stat_counter3.stat.time stat_counter3.stat.time(end)]
% fill(X,Y./2,'b','linestyle','none','facealpha',0.5)
% 
% ax2 = axes('Position',ax1_pos,'XAxisLocation','top','YAxisLocation','right','Color','none');
% set(gca,'box','off','linewidth',4,'fontsize',40,'fontweight','b')
% 
% axis([-0.2 2.2 0 28])

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/MISC_PLOTS/Figures_PAPER/F_RefTime_cluster')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 1600 600]);
set(fig,'PaperPosition',[1 1 1600 600])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

clust  = find(sum(stat_eeg.prob <= 0.05) > 0);

% fmult
fmult = 1e6; % for express in uV

% stimulus onsets
line([0 0]    ,[-7 8],'linestyle',':','linewidth',4,'color','k'); hold on
line([0.3 0.3],[-7 8],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on
line([1.1 1.1],[-7 8],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on
line([2 2 ],[-7 8],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on

% cluster shade
fill([1.606 1.606 1.829 1.829], [-2 5 5 -2],[0.8 0.8 0.8],'edgecolor',[0.8 0.8 0.8]);hold on

% timecourse
plot(GDAVG_eeg{1}.time,mean(GDAVG_eeg{1}.avg(indchaneeg,:)*fmult),'linewidth',8,'color',[1 0.7 0.7]);hold on
plot(GDAVG_eeg{1}.time,mean(GDAVG_eeg{2}.avg(indchaneeg,:)*fmult),'linewidth',8,'color',[1 0.35 0.35]);hold on
plot(GDAVG_eeg{1}.time,mean(GDAVG_eeg{3}.avg(indchaneeg,:)*fmult),'linewidth',8,'color',[1 0 0]);hold on

set(gca,'box','off','linewidth',4,'fontsize',40,'fontweight','b')
set(gca,'ytick',[-4 -2 0 2 4],'yticklabel',[-4 -2 0 2 4])
axis([-0.2 2.2 -2 5])

% ax1 = gca; % current axes
% ax1_pos = ax1.Position
% 
% % f-scores overlay
% shift = -10
% Y = [shift mean(stateeg_time1.stat.stat(indchaneeg,:)) + ones(1,length(mean(stateeg_time1.stat.stat(indchaneeg,:)))).*shift ...
%     mean(stateeg_time2.stat.stat(indchaneeg,:)) + ones(1,length(mean(stateeg_time2.stat.stat(indchaneeg,:)))).*shift ...
%     mean(stateeg_time3.stat.stat(indchaneeg,:)) + ones(1,length(mean(stateeg_time3.stat.stat(indchaneeg,:)))).*shift +shift];
% X = [0 stateeg_time1.stat.time stateeg_time2.stat.time stateeg_time3.stat.time stateeg_time3.stat.time(end)]
% fill(X,Y./2,'r','linestyle','none','facealpha',0.5); hold on
% 
% Y = [shift mean(stateeg_space1.stat.stat(indchaneeg,:)) + ones(1,length(mean(stateeg_space1.stat.stat(indchaneeg,:)))).*shift ...
%     mean(stateeg_space2.stat.stat(indchaneeg,:)) + ones(1,length(mean(stateeg_space2.stat.stat(indchaneeg,:)))).*shift ...
%     mean(stateeg_space3.stat.stat(indchaneeg,:)) + ones(1,length(mean(stateeg_space3.stat.stat(indchaneeg,:)))).*shift +shift];
% X = [0 stateeg_space1.stat.time stateeg_space2.stat.time stateeg_space3.stat.time stateeg_space3.stat.time(end)]
% fill(X,Y./2,'b','linestyle','none','facealpha',0.5)
% 
% ax2 = axes('Position',ax1_pos,'XAxisLocation','top','YAxisLocation','right','Color','none');
% set(gca,'box','off','linewidth',4,'fontsize',40,'fontweight','b')
% 
% axis([-0.2 2.2 0 30])

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/MISC_PLOTS/Figures_PAPER/F_RefTime_cluster_eeg')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% avg barplot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clust  = find(sum(stat_prepas.prob <= 0.05) > 0);
indchan = []; indchan = find(stat_prepas.prob(indchan2plot,index) <0.05);

% cluster pieces
t = [];
for i = 1:length(clust)-1
    if abs(clust(i+1) - clust(i)) > 1
        t = [t i i+1];
    end
end

interval = [];

if length(t) >2

    Tstart(1) = find(abs(GDAVGt_prepas{3}.time - stat_prepas.time(clust(1))) < 1e-6);
    Tend(1)   = find(abs(GDAVGt_prepas{3}.time - stat_prepas.time(clust(t(1)))) < 1e-6);
    interval = [Tstart(1):Tend(1)];
    
    for i = 2:2:length(t)-1 
        Tstart(i/2+1) = find(abs(GDAVGt_prepas{3}.time - stat_prepas.time(clust(t(i)))) < 1e-6);
        Tend(i/2+1)   = find(abs(GDAVGt_prepas{3}.time - stat_prepas.time(clust(t(i+1)))) < 1e-6);
        interval = [interval Tstart(i/2+1):Tend(i/2+1)];
    end
    
    Tstart(i/2+2) = find(abs(GDAVGt_prepas{3}.time - stat_prepas.time(clust(t(i)))) < 1e-6);
    Tend(i/2+2)   = find(abs(GDAVGt_prepas{3}.time - stat_prepas.time(clust(end))) < 1e-6);   
    interval = [interval Tstart(i/2+2):Tend(i/2+2)];

elseif length(t) == 2
    Tstart(1) = find(abs(GDAVGt_prepas{3}.time - stat_prepas.time(clust(1))) < 1e-6);
    Tend(1)   = find(abs(GDAVGt_prepas{3}.time - stat_prepas.time(clust(t(1)))) < 1e-6);
    Tstart(2) = find(abs(GDAVGt_prepas{3}.time - stat_prepas.time(clust(t(2)))) < 1e-6);
    Tend(2)   = find(abs(GDAVGt_prepas{3}.time - stat_prepas.time(clust(end))) < 1e-6);  
    interval  = [Tstart(1):Tend(1) Tstart(2):Tend(2)];
else
    Tstart(1) = find(abs(GDAVGt_prepas{3}.time - stat_prepas.time(clust(1))) < 1e-6);
    Tend(1)   = find(abs(GDAVGt_prepas{3}.time - stat_prepas.time(clust(end))) < 1e-6);
    interval = [Tstart(1):Tend(1)];
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Barplots
fig = figure('position',[1 1 800 800]);
set(fig,'PaperPosition',[1 1 800 800])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
fmult = 1e14

dat1 = mean(mean(GDAVGt_prepas{1}.individual(:,indchan2plot,[Tstart(1):Tend(1) Tstart(2):Tend(2)]),2),3)*fmult;
dat2 = mean(mean(GDAVGt_prepas{2}.individual(:,indchan2plot,[Tstart(1):Tend(1) Tstart(2):Tend(2)]),2),3)*fmult;
dat3 = mean(mean(GDAVGt_prepas{3}.individual(:,indchan2plot,[Tstart(1):Tend(1) Tstart(2):Tend(2)]),2),3)*fmult;

bar([mean(dat1) 0 0],'facecolor',graphcolor(1,:),'edgecolor','k','linewidth',5);hold on
bar([0 mean(dat2) 0],'facecolor',graphcolor(2,:),'edgecolor','k','linewidth',5);hold on
bar([0 0 mean(dat3)],'facecolor',graphcolor(3,:),'edgecolor','k','linewidth',5);hold on
errorbar(mean([dat1 dat2,dat3]),std([dat1 dat2,dat3])./sqrt(19),'linestyle',...
    'none','color','k','linewidth',5)
set(gca, 'box','off','linewidth',5,'fontsize',50,'fontweight','b');
axis([0 4 -1.2 5])

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/Barplot_MAGS_RefTime_1clust')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Barplots
fig = figure('position',[1 1 800 800]);
set(fig,'PaperPosition',[1 1 800 800])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

dat1 = mean(mean(GDAVGt_prepas{1}.individual(:,indchan2plot,[Tstart(1):Tend(1)]),2),3)*fmult;
dat2 = mean(mean(GDAVGt_prepas{2}.individual(:,indchan2plot,[Tstart(1):Tend(1)]),2),3)*fmult;
dat3 = mean(mean(GDAVGt_prepas{3}.individual(:,indchan2plot,[Tstart(1):Tend(1)]),2),3)*fmult;
dat4 = mean(mean(GDAVGt_prepas{1}.individual(:,indchan2plot,[Tstart(2):Tend(2)]),2),3)*fmult;
dat5 = mean(mean(GDAVGt_prepas{2}.individual(:,indchan2plot,[Tstart(2):Tend(2)]),2),3)*fmult;
dat6 = mean(mean(GDAVGt_prepas{3}.individual(:,indchan2plot,[Tstart(2):Tend(2)]),2),3)*fmult;

bar([mean(dat1) 0 0 0 0 0],'facecolor',graphcolor(1,:),'edgecolor','k','linewidth',4);hold on
bar([0 mean(dat4) 0 0 0 0],'facecolor',graphcolor(1,:),'edgecolor','k','linewidth',4);hold on
bar([0 0 mean(dat2) 0 0 0],'facecolor',graphcolor(2,:),'edgecolor','k','linewidth',4);hold on
bar([0 0 0 mean(dat5) 0 0],'facecolor',graphcolor(2,:),'edgecolor','k','linewidth',4);hold on
bar([0 0 0 0 mean(dat3) 0],'facecolor',graphcolor(3,:),'edgecolor','k','linewidth',4);hold on
bar([0 0 0 0 0 mean(dat6)],'facecolor',graphcolor(3,:),'edgecolor','k','linewidth',4);hold on
errorbar(mean([dat1 dat4 dat2 dat5 dat3 dat6]),std([dat1 dat4 dat2 dat5 dat3 dat6])./sqrt(19),'linestyle',...
    'none','color','k','linewidth',4)
set(gca, 'box','off','linewidth',4,'fontsize',50,'fontweight','b');
axis([0 7 -1.2 5])

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/Barplot_MAGS_RefTime_2clust')

%% avg barplot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clusteeg   = find(sum(stat_eeg.prob <= 0.05) > 0);
times      = sum(stat_eeg.prob <= 0.05);
[x,y]      = findpeaks(times);
indchaneeg = find(stat_eeg.prob(:,y(4)) <=0.05);

Tstart(1) = find(abs(GDAVGt_eeg{3}.time - stat_eeg.time(clusteeg(1))) < 1e-6);
Tend(1)   = find(abs(GDAVGt_eeg{3}.time - stat_eeg.time(clusteeg(end))) < 1e-6);
interval = [Tstart(1):Tend(1)];

%% Barplots
fmult = 1e6

fig = figure('position',[1 1 800 800]);
set(fig,'PaperPosition',[1 1 800 800])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

dat1eeg = mean(mean(GDAVGt_eeg{1}.individual(:,indchaneeg,[Tstart(1):Tend(1) ]),2),3)*fmult;
dat2eeg = mean(mean(GDAVGt_eeg{2}.individual(:,indchaneeg,[Tstart(1):Tend(1) ]),2),3)*fmult;
dat3eeg = mean(mean(GDAVGt_eeg{3}.individual(:,indchaneeg,[Tstart(1):Tend(1) ]),2),3)*fmult;

bar([mean(dat1eeg) 0 0],'facecolor',graphcolor(1,:),'edgecolor','k','linewidth',5);hold on
bar([0 mean(dat2eeg) 0],'facecolor',graphcolor(2,:),'edgecolor','k','linewidth',5);hold on
bar([0 0 mean(dat3eeg)],'facecolor',graphcolor(3,:),'edgecolor','k','linewidth',5);hold on
errorbar(mean([dat1eeg dat2eeg dat3eeg]),std([dat1 dat2 dat3])./sqrt(19),'linestyle',...
    'none','color','k','linewidth',5)
set(gca, 'box','off','linewidth',5,'fontsize',50,'fontweight','b');
axis([0 4 -2 2])

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/Barplot_EEG_RefTime_1clust')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% write for analysis in R
datafolder = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/for_R_data'

DataMat   = [[dat1 ;dat2 ;dat3 ]...
            [ones(19,1); ones(19,1)*2; ones(19,1)*3]...
            [1:19 1:19 1:19]'];
CondNames = {'Amplitude','Tref','Subject'}
write_csv_for_anova_R(DataMat, CondNames, [datafolder '/Mags1_TREF'])

DataMat   = [[dat1eeg ;dat2eeg ;dat3eeg ]....
            [ones(19,1); ones(19,1)*2; ones(19,1)*3]...
            [1:19 1:19 1:19]'];
CondNames = {'Amplitude','Tref','Subject'}
write_csv_for_anova_R(DataMat, CondNames, [datafolder '/Eeg_TREF'])




