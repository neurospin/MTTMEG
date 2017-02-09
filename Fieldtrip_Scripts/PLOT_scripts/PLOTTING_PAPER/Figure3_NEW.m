addpath('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/PLOTTING_PAPER')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
condnames_clust= {'EtPastG','EtPreG','EtFutG'};
condnames    = {'EtPastG','EtPreG','EtFutG'};
latency      = [0 1];
graphcolor1   = [[1 0 0];[0.5 0.5 0.5];[1 0 0]];
stat_test    = '';
chansel      = 'EEG';
clustnum     = 0;
clusttype    = 'posclust';
timetag      = '20163313258';

[ch_t, cdn_t, cdn_clust_t, stat_t, GDAVG_t, GDAVGt_t] = prepare_comp(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
condnames_clust = {'EsWest','EsPar','EsEast'};
condnames    = {'EsWest','EsPar','EsEast'};
latency      = [0 1];
graphcolor2   = [[0 0 1];[0.5 0.5 0.5];[0 0 1]];
stat_test    = 'F';
chansel      = 'EEG';
clustnum     = 0;
clusttype    = 'posclust';
timetag      = '201675163329';

[ch_s, cdn_s, cdn_clust_s, stat_s, GDAVG_s, GDAVGt_s] = prepare_comp(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

%%%%%%%%%%%%%%%%%%%%%%%% prepare plotting layout %%%%%%%%%%%%%%%%%%%%%%%%%%
% select sensor datatype
[Grads1,Grads2,Mags]   = grads_for_layouts('Network');

% prepare layout
cfg                           = [];
cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/eeg_64_NM20884N.lay';

layeeg                        = ft_prepare_layout(cfg,GDAVG_t{1});
layeeg.label                = GDAVG_t{1}.label;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EEG
times    = sum(stat_t.prob <= 0.05);
plot(stat_t.time,times)
[x,y]    = findpeaks(times);
indchaneeg = find(stat_t.prob(:,y(7)) <=0.05);
clust   = find(sum(stat_t.prob <= 0.05) > 0);

fig = figure('position',[1 1 400 400]);
set(fig,'PaperPosition',[1 1 400 400])
set(fig,'PaperPositionmode','auto')

cmap = colormap('hot')
cmap = cmap(10:55,:)
index = y(7);
cfg                    = [];
cfg.layout             = layeeg;
cfg.xlim               = [stat_t.time(index) stat_t.time(index)];
cfg.zlim               = [0 6]; % F-values
cfg.colormap           = 'jet';
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.colormap           = cmap ;
cfg.highlight          = 'on';
cfg.highlight          = {'on'};
cfg.highlightchannel   = {stat_t.label(indchaneeg)};
cfg.highlightsymbol    = {'.'};
cfg.highlightsize      = {24} ;
cfg.highlightcolor     = {'k'};
cfg.comment            = num2str(stat_t.time(index));
ft_topoplotER(cfg,stat_t);
colorbar
print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/EEG_EtSPace_topo')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EEG
times    = sum(stat_s.prob <= 0.05);
plot(stat_s.time,times)
[x,y]    = findpeaks(times);
indchaneegs = find(stat_s.prob(:,y(6)) <=0.05);
clust   = find(sum(stat_s.prob <= 0.05) > 0);

fig = figure('position',[1 1 400 400]);
set(fig,'PaperPosition',[1 1 400 400])
set(fig,'PaperPositionmode','auto')

cmap = colormap('hot')
cmap = cmap(10:55,:)
index = y(6);
cfg                    = [];
cfg.layout             = layeeg;
cfg.xlim               = [stat_s.time(index) stat_s.time(index)];
cfg.zlim               = [0 6]; % F-values
cfg.colormap           = 'jet';
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.colormap           = cmap ;
cfg.highlight          = 'on';
cfg.highlight          = {'on'};
cfg.highlightchannel   = {stat_s.label(indchaneegs)};
cfg.highlightsymbol    = {'.'};
cfg.highlightsize      = {24} ;
cfg.highlightcolor     = {'k'};
cfg.comment            = num2str(stat_s.time(index));
ft_topoplotER(cfg,stat_s);
colorbar
print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/EEG_EtSPace_topo')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 1600 1000]);
set(fig,'PaperPosition',[1 1 1600 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

clust  = find(sum(stat_t.prob <= 0.05) > 0);

% fmult
fmult = 1e6; % for express in uV

% stimulus onsets
line([0 0]    ,[-10 10],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on
line([1 1]    ,[-10 10],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on

% cluster shade
fill([0.524 0.524 1000 1.000], [-2 5 5 -2],[0.8 0.8 0.8],'edgecolor',[0.8 0.8 0.8]);hold on

% timecourse
plot(GDAVG_t{1}.time,mean(GDAVG_t{1}.avg(indchaneegs,:)*fmult),'linewidth',8,'color',[1 0.7 0.7]);hold on
plot(GDAVG_t{1}.time,mean(GDAVG_t{2}.avg(indchaneegs,:)*fmult),'linewidth',8,'color',[1 0.35 0.35]);hold on
plot(GDAVG_t{1}.time,mean(GDAVG_t{3}.avg(indchaneegs,:)*fmult),'linewidth',8,'color',[1 0 0]);hold on

set(gca,'box','off','linewidth',4,'fontsize',40,'fontweight','b')
axis([-0.2 1.2 -3 4])

% ax1 = gca; % current axes
% ax1_pos = ax1.Position
% 
% % f-scores overlay
% shift = -12
% Y = [shift mean(stat_t.stat(indchaneeg,:)) + ones(1,length(mean(stat_t.stat(indchaneeg,:)))).*shift +shift];
% X = [0 stat_t.time stat_t.time(end)]
% fill(X,Y./4,'r','linestyle','none','facealpha',0.5); hold on
% 
% Y = [shift mean(stat_s.stat(indchaneeg,:)) + ones(1,length(mean(stat_s.stat(indchaneeg,:)))).*shift +shift];
% X = [0 stat_s.time stat_s.time(end)]
% fill(X,Y./4,'b','linestyle','none','facealpha',0.5); hold on
% 
% ax2 = axes('Position',ax1_pos,'XAxisLocation','top','YAxisLocation','right','Color','none');
% set(gca,'box','off','linewidth',4,'fontsize',40,'fontweight','b')
% 
% axis([-0.2 1.2 0 28])

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/MISC_PLOTS/Figures_PAPER/F_RefTimeET_cluster_eeg')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 1600 1000]);
set(fig,'PaperPosition',[1 1 1600 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

clust  = find(sum(stat_s.prob <= 0.05) > 0);

% fmult
fmult = 1e6; % for express in uV

% stimulus onsets
line([0 0]    ,[-10 10],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on
line([1 1]    ,[-10 10],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on

% cluster shade
fill([0.524 0.524 1000 1.000], [-2 5 5 -2],[0.8 0.8 0.8],'edgecolor',[0.8 0.8 0.8]);hold on

% timecourse
plot(GDAVG_s{1}.time,mean(GDAVG_s{1}.avg(indchaneegs,:)*fmult),'linewidth',8,'color',[0.7 0.7 1]);hold on
plot(GDAVG_s{1}.time,mean(GDAVG_s{2}.avg(indchaneegs,:)*fmult),'linewidth',8,'color',[0.35 0.35 1]);hold on
plot(GDAVG_s{1}.time,mean(GDAVG_s{3}.avg(indchaneegs,:)*fmult),'linewidth',8,'color',[0 0 1]);hold on

set(gca,'box','off','linewidth',4,'fontsize',40,'fontweight','b')
axis([-0.2 1.2 -3 4])

% ax1 = gca; % current axes
% ax1_pos = ax1.Position
% 
% % f-scores overlay
% shift = -12
% Y = [shift mean(stat_t.stat(indchaneegs,:)) + ones(1,length(mean(stat_t.stat(indchaneegs,:)))).*shift +shift];
% X = [0 stat_t.time stat_t.time(end)]
% fill(X,Y./4,'r','linestyle','none','facealpha',0.5); hold on
% 
% Y = [shift mean(stat_s.stat(indchaneegs,:)) + ones(1,length(mean(stat_s.stat(indchaneegs,:)))).*shift +shift];
% X = [0 stat_s.time stat_s.time(end)]
% fill(X,Y./4,'b','linestyle','none','facealpha',0.5); hold on
% 
% ax2 = axes('Position',ax1_pos,'XAxisLocation','top','YAxisLocation','right','Color','none');
% set(gca,'box','off','linewidth',4,'fontsize',40,'fontweight','b')
% 
% axis([-0.2 1.2 0 28])

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/MISC_PLOTS/Figures_PAPER/F_RefSpaceES_cluster_eeg')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% data plots corr
% mean RTs
RT_pre = [0.6373    0.8277    1.0779    0.2698    0.6942    0.6114    0.4533    0.4600    0.5200    0.7548    0.1736    0.8671    0.8147    0.4062    0.5133    0.7438    0.6188    0.7357    0.4826];
RT_pas = [1.2533    0.8555    1.3397    0.5273    0.9783    0.7470    0.4344    0.3910    0.7170    0.9560    0.2053    0.9306    0.7438    0.4467    0.8602    1.1519    0.6295    0.9637    0.5840];
RT_fut = [0.8464    0.9730    1.1650    0.3934    0.8892    0.8328    0.4189    0.4523    0.5681    0.9883    0.2119    1.0586    0.7769    0.5485    0.6699    0.9663    0.6273    0.9109    0.5900];
RT_w = [0.7057    0.8800    1.1760    0.4753    0.8853    0.9285    0.4239    0.4626    0.5527    0.7262    0.1821    0.8422    0.6848    0.4473    0.7148    0.8331    0.5713    1.0006    0.5605];
RT_e = [0.8724    0.9773    1.0937    0.3823    0.8540    0.7532    0.4416    0.5518    0.6146    0.8184    0.1819    0.8908    0.8107    0.4756    0.5960    0.9437    0.5995    1.0112    0.6736];

tmp = find(GDAVGt_t{1}.time <  0.524);
tstart_t = tmp(end) +1;
tmp = find(GDAVGt_t{1}.time <  1);
tend_t = tmp(end) +1;

% eeg data
fmult = 1e6;
dat1 = mean(mean(GDAVGt_t{1}.individual(:,indchaneeg,[tstart_t:tend_t]),2),3)*fmult;
dat2 = mean(mean(GDAVGt_t{2}.individual(:,indchaneeg,[tstart_t:tend_t]),2),3)*fmult;
dat3 = mean(mean(GDAVGt_t{3}.individual(:,indchaneeg,[tstart_t:tend_t]),2),3)*fmult;


plot([RT_pas RT_pre RT_fut],[dat1 ; dat2 ; dat3],'marker','.','markersize',40,'linestyle','none')
plot(RT_pas-RT_pre,dat1-dat2,'marker','.','markersize',40,'linestyle','none')
plot(RT_fut-RT_pre,dat3-dat2,'marker','.','markersize',40,'linestyle','none')
plot([(RT_pas-RT_pre)  (RT_fut-RT_pre)],[(dat3-dat2) ; (dat1-dat2)],'marker','.','markersize',40,'linestyle','none')




