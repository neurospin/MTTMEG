addpath('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/PLOTTING_PAPER')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% DIST TIME %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
condnames_clust = {'EsParG';'EsPastG';'EsFutG';'EsWestG';'EsEastG'};
condnames    = {'EsParG';'EsPastG';'EsFutG';'EsWestG';'EsEastG'};
latency      = [0 1];
graphcolor   = [[1 0.7 0.7];[0 0 0];[1 0 0];[0.7 0.7 1];[0 0 1]];
stat_test    = 'F';
chansel      = 'EEG';
clustnum     = 0;
clusttype    = 'posclust';
timetag      = '2016725154557';

[ch_eeg, cdn_eeg, cdn_clust_eeg, stat_eeg, GDAVG_eeg, GDAVGt_eeg] = prepare_comp(niplist,condnames,...
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
lay                        = ft_prepare_layout(cfg,GDAVGt_eeg{1});
lay.label                = GDAVGt_eeg{1}.label;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
times = sum(stat_eeg.prob <= 0.05);
plot(stat_eeg.time,times)
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
    cfg.xlim               = [stat_eeg.time(index) stat_eeg.time(index)];
    cfg.zlim               = [-10 10]; % F-values
    cfg.colormap           = 'jet';
    cfg.style              = 'straight';
    cfg.parameter          = 'stat';
    cfg.marker             = 'off';
    cfg.highlight          = 'on';
    indchan = []; indchan  = find(stat_eeg.prob(:,index) <0.05);
    cfg.highlightchannel   = stat_eeg.label(indchan);
    cfg.highlightsymbol    = '.';
    cfg.highlightsize      = 20;
    cfg.comment            = num2str(stat_eeg.time(index));
    ft_topoplotER(cfg,stat_eeg);
    count = count +1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
times    = sum(stat_eeg.prob <= 0.05);
plot(stat_eeg.time,times)
[x,y]    = findpeaks(times);
indchan1 = find(stat_eeg.prob(:,y(8)) <0.05);
clust1   = find(sum(stat_eeg.prob <= 0.05) > 0);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 750 1000]);
set(fig,'PaperPosition',[1 1 750 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
subplot(2,1,1)

% fmult
fmult = 1e6; % for express in uV
% define axes limit and plot properties
set_axes(-0.7, 2, -1.5,3)

% stimulus onsets
line([0 0]    ,[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on
line([0.9 0.9],[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on

% cluster shade
cmap = colormap('gray')
cmap_inv = cmap(end:-1:1,:)
plot_lin_shade_v2(clust1 ,0.05 , stat_eeg ,-6.5,5,[0.7 0.7 0.7],-1.3,indchan1,cmap,[0 5])
% plot_lin_shade_v2(clust2 ,0.05 , stat_magt ,-6.5,5,[0.7 0.7 0.7],-7,indchan_2,cmap,[-5 5])

% timecourse
plot(GDAVGt_eeg{1}.time,mean(GDAVG_eeg{1}.avg(indchan1,:)*fmult),'linewidth',4,'color',graphcolor(1,:));hold on
plot(GDAVGt_eeg{1}.time,mean(GDAVG_eeg{2}.avg(indchan1,:)*fmult),'linewidth',4,'color',graphcolor(2,:));hold on
plot(GDAVGt_eeg{1}.time,mean(GDAVG_eeg{3}.avg(indchan1,:)*fmult),'linewidth',4,'color',graphcolor(3,:));hold on
plot(GDAVGt_eeg{1}.time,mean(GDAVG_eeg{4}.avg(indchan1,:)*fmult),'linewidth',4,'color',graphcolor(4,:));hold on
plot(GDAVGt_eeg{1}.time,mean(GDAVG_eeg{5}.avg(indchan1,:)*fmult),'linewidth',4,'color',graphcolor(5,:));hold on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 750 1000]);
set(fig,'PaperPosition',[1 1 750 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
subplot(2,1,1)

% fmult
fmult = 1e14; % for express in uV
% define axes limit and plot properties
set_axes(-0.7, 2, -4,4)

% stimulus onsets
line([0 0]    ,[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on
line([0.9 0.9],[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on

% cluster shade
cmap = colormap('gray')
cmap_inv = cmap(end:-1:1,:)
plot_lin_shade_v2(clust2 ,0.05 , stat_mag ,-6.5,5,[0.7 0.7 0.7],-3.7,indchan2,cmap,[0 5])
% plot_lin_shade_v2(clust2 ,0.05 , stat_magt ,-6.5,5,[0.7 0.7 0.7],-7,indchan_2,cmap,[-5 5])

% timecourse
plot(GDAVGt_mag{1}.time,mean(GDAVG_mag{1}.avg(indchan2,:)*fmult),'linewidth',4,'color',graphcolor(1,:));hold on
plot(GDAVGt_mag{1}.time,mean(GDAVG_mag{2}.avg(indchan2,:)*fmult),'linewidth',4,'color',graphcolor(2,:));hold on
plot(GDAVGt_mag{1}.time,mean(GDAVG_mag{3}.avg(indchan2,:)*fmult),'linewidth',4,'color',graphcolor(3,:));hold on
plot(GDAVGt_mag{1}.time,mean(GDAVG_mag{4}.avg(indchan2,:)*fmult),'linewidth',4,'color',graphcolor(4,:));hold on
plot(GDAVGt_mag{1}.time,mean(GDAVG_mag{5}.avg(indchan2,:)*fmult),'linewidth',4,'color',graphcolor(5,:));hold on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 750 1000]);
set(fig,'PaperPosition',[1 1 750 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
subplot(2,1,1)

% fmult
fmult = 1e14; % for express in uV
% define axes limit and plot properties
set_axes(-0.7, 2, -4,4)

% stimulus onsets
line([0 0]    ,[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on
line([0.9 0.9],[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on

% cluster shade
cmap = colormap('gray')
cmap_inv = cmap(end:-1:1,:)
plot_lin_shade_v2(clust3 ,0.05 , stat_mag ,-6.5,5,[0.7 0.7 0.7],-3.7,indchan3,cmap,[0 5])
% plot_lin_shade_v2(clust2 ,0.05 , stat_magt ,-6.5,5,[0.7 0.7 0.7],-7,indchan_2,cmap,[-5 5])

% timecourse
plot(GDAVGt_mag{1}.time,mean(GDAVG_mag{1}.avg(indchan3,:)*fmult),'linewidth',4,'color',graphcolor(1,:));hold on
plot(GDAVGt_mag{1}.time,mean(GDAVG_mag{2}.avg(indchan3,:)*fmult),'linewidth',4,'color',graphcolor(2,:));hold on
plot(GDAVGt_mag{1}.time,mean(GDAVG_mag{3}.avg(indchan3,:)*fmult),'linewidth',4,'color',graphcolor(3,:));hold on
plot(GDAVGt_mag{1}.time,mean(GDAVG_mag{4}.avg(indchan3,:)*fmult),'linewidth',4,'color',graphcolor(4,:));hold on
plot(GDAVGt_mag{1}.time,mean(GDAVG_mag{5}.avg(indchan3,:)*fmult),'linewidth',4,'color',graphcolor(5,:));hold on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 750 1000]);
set(fig,'PaperPosition',[1 1 750 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
subplot(2,1,1)

% fmult
fmult = 1e12; % for express in uV
% define axes limit and plot properties
set_axes(-0.7, 2, -2.5,2.5)

% stimulus onsets
line([0 0]    ,[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on
line([0.9 0.9],[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on

% cluster shade
cmap = colormap('gray')
cmap_inv = cmap(end:-1:1,:)
plot_lin_shade_v2(clust4 ,0.05 , stat_grad22 ,-6.5,5,[0.7 0.7 0.7],-2.4,indchan4,cmap,[0 5])
% plot_lin_shade_v2(clust2 ,0.05 , stat_magt ,-6.5,5,[0.7 0.7 0.7],-7,indchan_2,cmap,[-5 5])

% timecourse
plot(GDAVGt_grad2{1}.time,mean(GDAVG_grad2{1}.avg(indchan4,:)*fmult),'linewidth',4,'color',graphcolor(1,:));hold on
plot(GDAVGt_grad2{1}.time,mean(GDAVG_grad2{2}.avg(indchan4,:)*fmult),'linewidth',4,'color',graphcolor(2,:));hold on
plot(GDAVGt_grad2{1}.time,mean(GDAVG_grad2{3}.avg(indchan4,:)*fmult),'linewidth',4,'color',graphcolor(3,:));hold on
plot(GDAVGt_grad2{1}.time,mean(GDAVG_grad2{4}.avg(indchan4,:)*fmult),'linewidth',4,'color',graphcolor(4,:));hold on
plot(GDAVGt_grad2{1}.time,mean(GDAVG_grad2{5}.avg(indchan4,:)*fmult),'linewidth',4,'color',graphcolor(5,:));hold on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 750 1000]);
set(fig,'PaperPosition',[1 1 750 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
subplot(2,1,1)

% fmult
fmult = 1e12; % for express in uV
% define axes limit and plot properties
set_axes(-0.7, 2, -1,1)

% stimulus onsets
line([0 0]    ,[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on
line([0.9 0.9],[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on

% cluster shade
cmap = colormap('gray')
cmap_inv = cmap(end:-1:1,:)
plot_lin_shade_v2(clust5 ,0.05 , stat_grad2 ,-6.5,5,[0.7 0.7 0.7],-0.9,indchan4,cmap,[0 5])
plot_lin_shade_v2(clust5 ,0.05 , stat_grad22 ,-6.5,5,[0.7 0.7 0.7],-0.9,indchan4,cmap,[0 5])
% plot_lin_shade_v2(clust2 ,0.05 , stat_magt ,-6.5,5,[0.7 0.7 0.7],-7,indchan_2,cmap,[-5 5])

% timecourse
plot(GDAVGt_grad2{1}.time,mean(GDAVG_grad2{1}.avg(indchan5,:)*fmult),'linewidth',4,'color',graphcolor(1,:));hold on
plot(GDAVGt_grad2{1}.time,mean(GDAVG_grad2{2}.avg(indchan5,:)*fmult),'linewidth',4,'color',graphcolor(2,:));hold on
plot(GDAVGt_grad2{1}.time,mean(GDAVG_grad2{3}.avg(indchan5,:)*fmult),'linewidth',4,'color',graphcolor(3,:));hold on
plot(GDAVGt_grad2{1}.time,mean(GDAVG_grad2{4}.avg(indchan5,:)*fmult),'linewidth',4,'color',graphcolor(4,:));hold on
plot(GDAVGt_grad2{1}.time,mean(GDAVG_grad2{5}.avg(indchan5,:)*fmult),'linewidth',4,'color',graphcolor(5,:));hold on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 300 300]);
set(fig,'PaperPosition',[1 1 300 300])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

index = y(1)
cmap  = colormap('gray')
cmap = cmap(end:-1:1,:)
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat_grad2.time(index) stat_grad2.time(index)];
cfg.zlim               = [0 5]; % F-values
cfg.colormap           = cmap;
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
indchan = []; indchan  = find(stat_grad2.prob(:,index) <0.05);
cfg.highlightchannel   = stat_grad2.label(indchan4);
cfg.highlightsymbol    = '.';
cfg.highlightsize      = 20;
cfg.highlightcolor     = 'w';
cfg.comment            = num2str(stat_grad2.time(index));
ft_topoplotER(cfg,stat_grad2);
colorbar

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 300 300]);
set(fig,'PaperPosition',[1 1 300 300])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

index = y(6)
cmap  = colormap('gray')
cmap = cmap(end:-1:1,:)
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat_eeg.time(index) stat_eeg.time(index)];
cfg.zlim               = [0 5]; % F-values
cfg.colormap           = cmap;
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
indchan = []; indchan  = find(stat_eeg.prob(:,index) <0.05);
cfg.highlightchannel   = stat_eeg.label(indchan);
cfg.highlightsymbol    = '.';
cfg.highlightsize      = 20;
cfg.highlightcolor     = 'w';
cfg.comment            = num2str(stat_eeg.time(index));
ft_topoplotER(cfg,stat_eeg);
colorbar
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig = figure('position',[1 1 300 300]);
set(fig,'PaperPosition',[1 1 300 300])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

index = y(8)
cmap  = colormap('gray')
cmap = cmap(end:-1:1,:)
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat_eeg.time(index) stat_eeg.time(index)];
cfg.zlim               = [0 5]; % F-values
cfg.colormap           = cmap;
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
indchan = []; indchan  = find(stat_eeg.prob(:,index) <0.05);
cfg.highlightchannel   = stat_eeg.label(indchan);
cfg.highlightsymbol    = '.';
cfg.highlightsize      = 20;
cfg.highlightcolor     = 'w';
cfg.comment            = num2str(stat_eeg.time(index));
ft_topoplotER(cfg,stat_eeg);
colorbar

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 300 300]);
set(fig,'PaperPosition',[1 1 300 300])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

index = y(11)
cmap  = colormap('gray')
cmap = cmap(end:-1:1,:)
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat_mag.time(index) stat_mag.time(index)];
cfg.zlim               = [0 5]; % F-values
cfg.colormap           = cmap;
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
indchan = []; indchan  = find(stat_mag.prob(:,index) <0.05);
cfg.highlightchannel   = stat_mag.label(indchan);
cfg.highlightsymbol    = '.';
cfg.highlightsize      = 20;
cfg.highlightcolor     = 'w';
cfg.comment            = num2str(stat_mag.time(index));
ft_topoplotER(cfg,stat_mag);
colorbar

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 300 300]);
set(fig,'PaperPosition',[1 1 300 300])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

index = y(22)
cmap  = colormap('gray')
cmap = cmap(end:-1:1,:)
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat_mag.time(index) stat_mag.time(index)];
cfg.zlim               = [0 5]; % F-values
cfg.colormap           = cmap;
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
indchan = []; indchan  = find(stat_mag.prob(:,index) <0.05);
cfg.highlightchannel   = stat_mag.label(indchan);
cfg.highlightsymbol    = '.';
cfg.highlightsize      = 20;
cfg.highlightcolor     = 'w';
cfg.comment            = num2str(stat_mag.time(index));
ft_topoplotER(cfg,stat_mag);
colorbar

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% plot barplots
fig = figure('position',[1 1 300 300]);
set(fig,'PaperPosition',[1 1 300 300])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

% cluster pieces
t = [];
for i = 1:length(clust1)-1
    if abs(clust1(i+1) - clust1(i)) > 1
        t = [t i i+1];
    end
end

interval = [];

if length(t) >2

    Tstart(1) = find(abs(GDAVGt_eeg{3}.time - stat_eeg.time(clust1(1))) < 1e-6);
    Tend(1)   = find(abs(GDAVGt_eeg{3}.time - stat_eeg.time(clust1(t(1)))) < 1e-6);
    interval = [Tstart(1):Tend(1)];
    
    for i = 2:2:length(t)-1 
        Tstart(i/2+1) = find(abs(GDAVGt_eeg{3}.time - stat_eeg.time(clust1(t(i)))) < 1e-6);
        Tend(i/2+1)   = find(abs(GDAVGt_eeg{3}.time - stat_eeg.time(clust1(t(i+1)))) < 1e-6);
        interval = [interval Tstart(i/2+1):Tend(i/2+1)];
    end
    
    Tstart(i/2+2) = find(abs(GDAVGt_eeg{3}.time - stat_eeg.time(clust1(t(i)))) < 1e-6);
    Tend(i/2+2)   = find(abs(GDAVGt_eeg{3}.time - stat_eeg.time(clust1(end))) < 1e-6);   
    interval = [interval Tstart(i/2+2):Tend(i/2+2)];

elseif length(t) == 2
    Tstart(1) = find(abs(GDAVGt_eeg{3}.time - stat_eeg.time(clust1(1))) < 1e-6);
    Tend(1)   = find(abs(GDAVGt_eeg{3}.time - stat_eeg.time(clust1(t(1)))) < 1e-6);
    Tstart(2) = find(abs(GDAVGt_eeg{3}.time - stat_eeg.time(clust1(t(2)))) < 1e-6);
    Tend(2)   = find(abs(GDAVGt_eeg{3}.time - stat_eeg.time(clust1(end))) < 1e-6);  
    interval  = [Tstart(1):Tend(1) Tstart(2):Tend(2)];
else
    Tstart(1) = find(abs(GDAVGt_eeg{3}.time - stat_eeg.time(clust1(1))) < 1e-6);
    Tend(1)   = find(abs(GDAVGt_eeg{3}.time - stat_eeg.time(clust1(end))) < 1e-6);
    interval = [Tstart(1):Tend(1)];
    
end

data1 = mean(mean(GDAVGt_eeg{1}.individual(:,indchan1,Tstart(1):Tend(1)),2),3)*fmult;
data2 = mean(mean(GDAVGt_eeg{2}.individual(:,indchan1,Tstart(1):Tend(1)),2),3)*fmult;
data3 = mean(mean(GDAVGt_eeg{3}.individual(:,indchan1,Tstart(1):Tend(1)),2),3)*fmult;
data4 = mean(mean(GDAVGt_eeg{4}.individual(:,indchan1,Tstart(1):Tend(1)),2),3)*fmult;
data5 = mean(mean(GDAVGt_eeg{5}.individual(:,indchan1,Tstart(1):Tend(1)),2),3)*fmult;

%
fig = figure('position',[1 1 500 500]);
set(fig,'PaperPosition',[1 1 500 500])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

bar([mean(data1) 0 0 0 0],'facecolor',graphcolor(1,:),'edgecolor','k','linewidth',3);hold on
bar([0 mean(data2) 0 0 0],'facecolor',graphcolor(2,:),'edgecolor','k','linewidth',3);hold on
bar([0 0 mean(data3) 0 0],'facecolor',graphcolor(3,:),'edgecolor','k','linewidth',3);hold on
bar([0 0 0 mean(data4) 0],'facecolor',graphcolor(4,:),'edgecolor','k','linewidth',3);hold on
bar([0 0 0 0 mean(data5)],'facecolor',graphcolor(5,:),'edgecolor','k','linewidth',3);hold on

errorbar(1,mean(data1),std(data1)./sqrt(19),'linestyle','none','color','k','linewidth',3)
errorbar(2,mean(data2),std(data2)./sqrt(19),'linestyle','none','color','k','linewidth',3)
errorbar(3,mean(data3),std(data3)./sqrt(19),'linestyle','none','color','k','linewidth',3)
errorbar(4,mean(data4),std(data4)./sqrt(19),'linestyle','none','color','k','linewidth',3)
errorbar(5,mean(data5),std(data5)./sqrt(19),'linestyle','none','color','k','linewidth',3)
axis([0 6 0 4])
set(gca, 'box','off','linewidth',3,'fontsize',20,'fontweight','b');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% write for analysis in R
datafolder = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/for_R_data'

DataMat   = [[data1; data2; data3; data4; data5 ]...
            [ones(19,1); ones(19,1)*2; ones(19,1)*3; ones(19,1)*4; ones(19,1)*5]...
            [1:19 1:19 1:19 1:19 1:19]'];
CondNames = {'Amplitude','REF','Subject'}

write_csv_for_anova_R(DataMat, CondNames, [datafolder '/EEG_Allrefs_EVT'])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% plot barplots
fig = figure('position',[1 1 300 300]);
set(fig,'PaperPosition',[1 1 300 300])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

% cluster pieces
t = [];
for i = 1:length(clust2)-1
    if abs(clust2(i+1) - clust2(i)) > 1
        t = [t i i+1];
    end
end

interval = [];

if length(t) >2

    Tstart(1) = find(abs(GDAVGt_mag{3}.time - stat_mag.time(clust2(1))) < 1e-6);
    Tend(1)   = find(abs(GDAVGt_mag{3}.time - stat_mag.time(clust2(t(1)))) < 1e-6);
    interval = [Tstart(1):Tend(1)];
    
    for i = 2:2:length(t)-1 
        Tstart(i/2+1) = find(abs(GDAVGt_mag{3}.time - stat_mag.time(clust2(t(i)))) < 1e-6);
        Tend(i/2+1)   = find(abs(GDAVGt_mag{3}.time - stat_mag.time(clust2(t(i+1)))) < 1e-6);
        interval = [interval Tstart(i/2+1):Tend(i/2+1)];
    end
    
    Tstart(i/2+2) = find(abs(GDAVGt_mag{3}.time - stat_mag.time(clust2(t(i)))) < 1e-6);
    Tend(i/2+2)   = find(abs(GDAVGt_mag{3}.time - stat_mag.time(clust2(end))) < 1e-6);   
    interval = [interval Tstart(i/2+2):Tend(i/2+2)];

elseif length(t) == 2
    Tstart(1) = find(abs(GDAVGt_mag{3}.time - stat_mag.time(clust2(1))) < 1e-6);
    Tend(1)   = find(abs(GDAVGt_mag{3}.time - stat_mag.time(clust2(t(1)))) < 1e-6);
    Tstart(2) = find(abs(GDAVGt_mag{3}.time - stat_mag.time(clust2(t(2)))) < 1e-6);
    Tend(2)   = find(abs(GDAVGt_mag{3}.time - stat_mag.time(clust2(end))) < 1e-6);  
    interval  = [Tstart(1):Tend(1) Tstart(2):Tend(2)];
else
    Tstart(1) = find(abs(GDAVGt_mag{3}.time - stat_mag.time(clust2(1))) < 1e-6);
    Tend(1)   = find(abs(GDAVGt_mag{3}.time - stat_mag.time(clust2(end))) < 1e-6);
    interval = [Tstart(1):Tend(1)];
    
end

data1 = mean(mean(GDAVGt_mag{1}.individual(:,indchan2,Tstart(1):Tend(1)),2),3)*fmult;
data2 = mean(mean(GDAVGt_mag{2}.individual(:,indchan2,Tstart(1):Tend(1)),2),3)*fmult;
data3 = mean(mean(GDAVGt_mag{3}.individual(:,indchan2,Tstart(1):Tend(1)),2),3)*fmult;
data4 = mean(mean(GDAVGt_mag{4}.individual(:,indchan2,Tstart(1):Tend(1)),2),3)*fmult;
data5 = mean(mean(GDAVGt_mag{5}.individual(:,indchan2,Tstart(1):Tend(1)),2),3)*fmult;

%
fig = figure('position',[1 1 500 500]);
set(fig,'PaperPosition',[1 1 500 500])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

bar([mean(data1) 0 0 0 0],'facecolor',graphcolor(1,:),'edgecolor','k','linewidth',3);hold on
bar([0 mean(data2) 0 0 0],'facecolor',graphcolor(2,:),'edgecolor','k','linewidth',3);hold on
bar([0 0 mean(data3) 0 0],'facecolor',graphcolor(3,:),'edgecolor','k','linewidth',3);hold on
bar([0 0 0 mean(data4) 0],'facecolor',graphcolor(4,:),'edgecolor','k','linewidth',3);hold on
bar([0 0 0 0 mean(data5)],'facecolor',graphcolor(5,:),'edgecolor','k','linewidth',3);hold on

errorbar(1,mean(data1),std(data1)./sqrt(19),'linestyle','none','color','k','linewidth',3)
errorbar(2,mean(data2),std(data2)./sqrt(19),'linestyle','none','color','k','linewidth',3)
errorbar(3,mean(data3),std(data3)./sqrt(19),'linestyle','none','color','k','linewidth',3)
errorbar(4,mean(data4),std(data4)./sqrt(19),'linestyle','none','color','k','linewidth',3)
errorbar(5,mean(data5),std(data5)./sqrt(19),'linestyle','none','color','k','linewidth',3)
axis([0 6 -3 3])
set(gca, 'box','off','linewidth',3,'fontsize',20,'fontweight','b');

%% plot barplots
fig = figure('position',[1 1 300 300]);
set(fig,'PaperPosition',[1 1 300 300])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

% cluster pieces
t = [];
for i = 1:length(clust3)-1
    if abs(clust3(i+1) - clust3(i)) > 1
        t = [t i i+1];
    end
end

interval = [];

if length(t) >2

    Tstart(1) = find(abs(GDAVGt_mag{3}.time - stat_mag.time(clust3(1))) < 1e-6);
    Tend(1)   = find(abs(GDAVGt_mag{3}.time - stat_mag.time(clust3(t(1)))) < 1e-6);
    interval = [Tstart(1):Tend(1)];
    
    for i = 2:2:length(t)-1 
        Tstart(i/2+1) = find(abs(GDAVGt_mag{3}.time - stat_mag.time(clust3(t(i)))) < 1e-6);
        Tend(i/2+1)   = find(abs(GDAVGt_mag{3}.time - stat_mag.time(clust3(t(i+1)))) < 1e-6);
        interval = [interval Tstart(i/2+1):Tend(i/2+1)];
    end
    
    Tstart(i/2+2) = find(abs(GDAVGt_mag{3}.time - stat_mag.time(clust3(t(i)))) < 1e-6);
    Tend(i/2+2)   = find(abs(GDAVGt_mag{3}.time - stat_mag.time(clust3(end))) < 1e-6);   
    interval = [interval Tstart(i/2+2):Tend(i/2+2)];

elseif length(t) == 2
    Tstart(1) = find(abs(GDAVGt_mag{3}.time - stat_mag.time(clust3(1))) < 1e-6);
    Tend(1)   = find(abs(GDAVGt_mag{3}.time - stat_mag.time(clust3(t(1)))) < 1e-6);
    Tstart(2) = find(abs(GDAVGt_mag{3}.time - stat_mag.time(clust3(t(2)))) < 1e-6);
    Tend(2)   = find(abs(GDAVGt_mag{3}.time - stat_mag.time(clust3(end))) < 1e-6);  
    interval  = [Tstart(1):Tend(1) Tstart(2):Tend(2)];
else
    Tstart(1) = find(abs(GDAVGt_mag{3}.time - stat_mag.time(clust3(1))) < 1e-6);
    Tend(1)   = find(abs(GDAVGt_mag{3}.time - stat_mag.time(clust3(end))) < 1e-6);
    interval = [Tstart(1):Tend(1)];
    
end

data1 = mean(mean(GDAVGt_mag{1}.individual(:,indchan3,Tstart(1):Tend(1)),2),3)*fmult;
data2 = mean(mean(GDAVGt_mag{2}.individual(:,indchan3,Tstart(1):Tend(1)),2),3)*fmult;
data3 = mean(mean(GDAVGt_mag{3}.individual(:,indchan3,Tstart(1):Tend(1)),2),3)*fmult;
data4 = mean(mean(GDAVGt_mag{4}.individual(:,indchan3,Tstart(1):Tend(1)),2),3)*fmult;
data5 = mean(mean(GDAVGt_mag{5}.individual(:,indchan3,Tstart(1):Tend(1)),2),3)*fmult;

%
fig = figure('position',[1 1 500 500]);
set(fig,'PaperPosition',[1 1 500 500])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

bar([mean(data1) 0 0 0 0],'facecolor',graphcolor(1,:),'edgecolor','k','linewidth',3);hold on
bar([0 mean(data2) 0 0 0],'facecolor',graphcolor(2,:),'edgecolor','k','linewidth',3);hold on
bar([0 0 mean(data3) 0 0],'facecolor',graphcolor(3,:),'edgecolor','k','linewidth',3);hold on
bar([0 0 0 mean(data4) 0],'facecolor',graphcolor(4,:),'edgecolor','k','linewidth',3);hold on
bar([0 0 0 0 mean(data5)],'facecolor',graphcolor(5,:),'edgecolor','k','linewidth',3);hold on

errorbar(1,mean(data1),std(data1)./sqrt(19),'linestyle','none','color','k','linewidth',3)
errorbar(2,mean(data2),std(data2)./sqrt(19),'linestyle','none','color','k','linewidth',3)
errorbar(3,mean(data3),std(data3)./sqrt(19),'linestyle','none','color','k','linewidth',3)
errorbar(4,mean(data4),std(data4)./sqrt(19),'linestyle','none','color','k','linewidth',3)
errorbar(5,mean(data5),std(data5)./sqrt(19),'linestyle','none','color','k','linewidth',3)
axis([0 6 -3 3])
set(gca, 'box','off','linewidth',3,'fontsize',20,'fontweight','b');

%% plot barplots
fig = figure('position',[1 1 300 300]);
set(fig,'PaperPosition',[1 1 300 300])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

% cluster pieces
t = [];
for i = 1:length(clust4)-1
    if abs(clust4(i+1) - clust4(i)) > 1
        t = [t i i+1];
    end
end

interval = [];

if length(t) >2

    Tstart(1) = find(abs(GDAVGt_grad2{3}.time - stat_grad2.time(clust4(1))) < 1e-6);
    Tend(1)   = find(abs(GDAVGt_grad2{3}.time - stat_grad2.time(clust4(t(1)))) < 1e-6);
    interval = [Tstart(1):Tend(1)];
    
    for i = 2:2:length(t)-1 
        Tstart(i/2+1) = find(abs(GDAVGt_grad2{3}.time - stat_grad2.time(clust4(t(i)))) < 1e-6);
        Tend(i/2+1)   = find(abs(GDAVGt_grad2{3}.time - stat_grad2.time(clust4(t(i+1)))) < 1e-6);
        interval = [interval Tstart(i/2+1):Tend(i/2+1)];
    end
    
    Tstart(i/2+2) = find(abs(GDAVGt_grad2{3}.time - stat_grad2.time(clust4(t(i)))) < 1e-6);
    Tend(i/2+2)   = find(abs(GDAVGt_grad2{3}.time - stat_grad2.time(clust4(end))) < 1e-6);   
    interval = [interval Tstart(i/2+2):Tend(i/2+2)];

elseif length(t) == 2
    Tstart(1) = find(abs(GDAVGt_grad2{3}.time - stat_grad2.time(clust4(1))) < 1e-6);
    Tend(1)   = find(abs(GDAVGt_grad2{3}.time - stat_grad2.time(clust4(t(1)))) < 1e-6);
    Tstart(2) = find(abs(GDAVGt_grad2{3}.time - stat_grad2.time(clust4(t(2)))) < 1e-6);
    Tend(2)   = find(abs(GDAVGt_grad2{3}.time - stat_grad2.time(clust4(end))) < 1e-6);  
    interval  = [Tstart(1):Tend(1) Tstart(2):Tend(2)];
else
    Tstart(1) = find(abs(GDAVGt_grad2{3}.time - stat_grad2.time(clust4(1))) < 1e-6);
    Tend(1)   = find(abs(GDAVGt_grad2{3}.time - stat_grad2.time(clust4(end))) < 1e-6);
    interval = [Tstart(1):Tend(1)];
    
end

data1 = mean(mean(GDAVGt_grad2{1}.individual(:,indchan4,Tstart(1):Tend(1)),2),3)*fmult;
data2 = mean(mean(GDAVGt_grad2{2}.individual(:,indchan4,Tstart(1):Tend(1)),2),3)*fmult;
data3 = mean(mean(GDAVGt_grad2{3}.individual(:,indchan4,Tstart(1):Tend(1)),2),3)*fmult;
data4 = mean(mean(GDAVGt_grad2{4}.individual(:,indchan4,Tstart(1):Tend(1)),2),3)*fmult;
data5 = mean(mean(GDAVGt_grad2{5}.individual(:,indchan4,Tstart(1):Tend(1)),2),3)*fmult;

%
fig = figure('position',[1 1 500 500]);
set(fig,'PaperPosition',[1 1 500 500])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

bar([mean(data1) 0 0 0 0],'facecolor',graphcolor(1,:),'edgecolor','k','linewidth',3);hold on
bar([0 mean(data2) 0 0 0],'facecolor',graphcolor(2,:),'edgecolor','k','linewidth',3);hold on
bar([0 0 mean(data3) 0 0],'facecolor',graphcolor(3,:),'edgecolor','k','linewidth',3);hold on
bar([0 0 0 mean(data4) 0],'facecolor',graphcolor(4,:),'edgecolor','k','linewidth',3);hold on
bar([0 0 0 0 mean(data5)],'facecolor',graphcolor(5,:),'edgecolor','k','linewidth',3);hold on

errorbar(1,mean(data1),std(data1)./sqrt(19),'linestyle','none','color','k','linewidth',3)
errorbar(2,mean(data2),std(data2)./sqrt(19),'linestyle','none','color','k','linewidth',3)
errorbar(3,mean(data3),std(data3)./sqrt(19),'linestyle','none','color','k','linewidth',3)
errorbar(4,mean(data4),std(data4)./sqrt(19),'linestyle','none','color','k','linewidth',3)
errorbar(5,mean(data5),std(data5)./sqrt(19),'linestyle','none','color','k','linewidth',3)
axis([0 6 -2 1])
set(gca, 'box','off','linewidth',3,'fontsize',20,'fontweight','b');

%% plot barplots
fig = figure('position',[1 1 300 300]);
set(fig,'PaperPosition',[1 1 300 300])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

% cluster pieces
t = [];
for i = 1:length(clust5)-1
    if abs(clust5(i+1) - clust5(i)) > 1
        t = [t i i+1];
    end
end

interval = [];

if length(t) >2

    Tstart(1) = find(abs(GDAVGt_grad22{3}.time - stat_grad22.time(clust5(1))) < 1e-6);
    Tend(1)   = find(abs(GDAVGt_grad22{3}.time - stat_grad22.time(clust5(t(1)))) < 1e-6);
    interval = [Tstart(1):Tend(1)];
    
    for i = 2:2:length(t)-1 
        Tstart(i/2+1) = find(abs(GDAVGt_grad22{3}.time - stat_grad22.time(clust5(t(i)))) < 1e-6);
        Tend(i/2+1)   = find(abs(GDAVGt_grad22{3}.time - stat_grad22.time(clust5(t(i+1)))) < 1e-6);
        interval = [interval Tstart(i/2+1):Tend(i/2+1)];
    end
    
    Tstart(i/2+2) = find(abs(GDAVGt_grad22{3}.time - stat_grad22.time(clust5(t(i)))) < 1e-6);
    Tend(i/2+2)   = find(abs(GDAVGt_grad22{3}.time - stat_grad22.time(clust5(end))) < 1e-6);   
    interval = [interval Tstart(i/2+2):Tend(i/2+2)];

elseif length(t) == 2
    Tstart(1) = find(abs(GDAVGt_grad22{3}.time - stat_grad22.time(clust5(1))) < 1e-6);
    Tend(1)   = find(abs(GDAVGt_grad22{3}.time - stat_grad22.time(clust5(t(1)))) < 1e-6);
    Tstart(2) = find(abs(GDAVGt_grad22{3}.time - stat_grad22.time(clust5(t(2)))) < 1e-6);
    Tend(2)   = find(abs(GDAVGt_grad22{3}.time - stat_grad22.time(clust5(end))) < 1e-6);  
    interval  = [Tstart(1):Tend(1) Tstart(2):Tend(2)];
else
    Tstart(1) = find(abs(GDAVGt_grad22{3}.time - stat_grad22.time(clust5(1))) < 1e-6);
    Tend(1)   = find(abs(GDAVGt_grad22{3}.time - stat_grad22.time(clust5(end))) < 1e-6);
    interval = [Tstart(1):Tend(1)];
    
end

data1 = mean(mean(GDAVGt_grad22{1}.individual(:,indchan5,Tstart(1):Tend(1)),2),3)*fmult;
data2 = mean(mean(GDAVGt_grad22{2}.individual(:,indchan5,Tstart(1):Tend(1)),2),3)*fmult;
data3 = mean(mean(GDAVGt_grad22{3}.individual(:,indchan5,Tstart(1):Tend(1)),2),3)*fmult;
data4 = mean(mean(GDAVGt_grad22{4}.individual(:,indchan5,Tstart(1):Tend(1)),2),3)*fmult;
data5 = mean(mean(GDAVGt_grad22{5}.individual(:,indchan5,Tstart(1):Tend(1)),2),3)*fmult;

%
fig = figure('position',[1 1 500 500]);
set(fig,'PaperPosition',[1 1 500 500])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

bar([mean(data1) 0 0 0 0],'facecolor',graphcolor(1,:),'edgecolor','k','linewidth',3);hold on
bar([0 mean(data2) 0 0 0],'facecolor',graphcolor(2,:),'edgecolor','k','linewidth',3);hold on
bar([0 0 mean(data3) 0 0],'facecolor',graphcolor(3,:),'edgecolor','k','linewidth',3);hold on
bar([0 0 0 mean(data4) 0],'facecolor',graphcolor(4,:),'edgecolor','k','linewidth',3);hold on
bar([0 0 0 0 mean(data5)],'facecolor',graphcolor(5,:),'edgecolor','k','linewidth',3);hold on

errorbar(1,mean(data1),std(data1)./sqrt(19),'linestyle','none','color','k','linewidth',3)
errorbar(2,mean(data2),std(data2)./sqrt(19),'linestyle','none','color','k','linewidth',3)
errorbar(3,mean(data3),std(data3)./sqrt(19),'linestyle','none','color','k','linewidth',3)
errorbar(4,mean(data4),std(data4)./sqrt(19),'linestyle','none','color','k','linewidth',3)
errorbar(5,mean(data5),std(data5)./sqrt(19),'linestyle','none','color','k','linewidth',3)
axis([0 6 -0.75 0.75])
set(gca, 'box','off','linewidth',3,'fontsize',20,'fontweight','b');

