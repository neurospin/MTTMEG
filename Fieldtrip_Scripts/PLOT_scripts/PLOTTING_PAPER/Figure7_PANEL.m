addpath('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/PLOTTING_PAPER')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% DIST TIME %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
condnames_clust = {'REGfull_distT_Zero'};
condnames    = {'REGfull_distT'};
latency      = [0 1];
graphcolor   = [[1 0.7 0.7];[0 0 0];[1 0 0]];
stat_test    = 'T';
chansel      = 'EEG';
clustnum     = 0;
clusttype    = 'negclust';
timetag      = '201672794316';

[ch_magt, cdn_magt, cdn_clust_magt, stat_magt, GDAVG_magt, dist] = prepare_comp_v2(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
condnames_clust = {'REGfull_distT_Zero'};
condnames    = {'REGfull_distT'};
latency      = [0 1];
graphcolor   = [[1 0.7 0.7];[0 0 0];[1 0 0]];
stat_test    = 'T';
chansel      = 'Mags';
clustnum     = 0;
clusttype    = 'negclust';
timetag      = '201672794622';

[ch_magt2, cdn_magt2, cdn_clust_magt2, stat_magt2, GDAVG_magt2, dist2] = prepare_comp_v2(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
condnames_clust = {'REGfull_distT_Zero'};
condnames    = {'REGfull_distT'};
latency      = [0 1];
graphcolor   = [[1 0.7 0.7];[0 0 0];[1 0 0]];
stat_test    = 'T';
chansel      = 'Grads2';
clustnum     = 0;
clusttype    = 'negclust';
timetag      = '201672794811';

[ch_gradt, cdn_gradt, cdn_clust_gradt, stat_gradt, GDAVG_gradt, dist3] = prepare_comp_v2(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

%%%%%%%%%%%%%%%%%%%%%%%% prepare plotting layout %%%%%%%%%%%%%%%%%%%%%%%%%%
% select sensor datatype
[Grads1,Grads2,Mags]   = grads_for_layouts('Network');
chansel = 'EEG'
% prepare layout
cfg                           = [];
if strcmp(chansel,'EEG') == 0
    cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/fieldtrip-20130901/template/layout/NM306mag.lay';
else
    cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/eeg_64_NM20884N.lay';
end
lay                        = ft_prepare_layout(cfg,GDAVG_magt{1});
lay.label                = GDAVG_magt{1}.label;

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
lay                        = ft_prepare_layout(cfg,GDAVG_magt2{1});
lay.label                = GDAVG_magt2{1}.label;

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
lay                        = ft_prepare_layout(cfg,GDAVG_gradt{1});
lay.label                = GDAVG_gradt{1}.label;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
times = sum(stat_gradt.prob <= 0.05);
plot(stat_gradt.time,times)
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
    cfg.xlim               = [stat_gradt.time(index) stat_gradt.time(index)];
    cfg.zlim               = [-10 10]; % F-values
    cfg.colormap           = 'jet';
    cfg.style              = 'straight';
    cfg.parameter          = 'stat';
    cfg.marker             = 'off';
    cfg.highlight          = 'on';
    indchan = []; indchan  = find(stat_gradt.prob(:,index) <0.05);
    cfg.highlightchannel   = stat_gradt.label(indchan);
    cfg.highlightsymbol    = '.';
    cfg.highlightsize      = 20;
    cfg.comment            = num2str(stat_gradt.time(index));
    ft_topoplotER(cfg,stat_gradt);
    count = count +1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
times    = sum(stat_magt.prob <= 0.05);
plot(stat_magt.time,times)
[x,y]    = findpeaks(times);
indchan1 = find(stat_magt.prob(:,y(3)) <0.05);
clust1   = find(sum(stat_magt.prob <= 0.05) > 0);

times    = sum(stat_magt2.prob <= 0.05);
plot(stat_magt2.time,times)
[x,y]    = findpeaks(times);
indchan2 = find(stat_magt2.prob(:,y(1)) <0.05);
clust2   = find(sum(stat_magt2.prob <= 0.05) > 0);

times    = sum(stat_gradt.prob <= 0.05);
plot(stat_gradt.time,times)
[x,y]    = findpeaks(times);
indchan3 = find(stat_gradt.prob(:,y(6)) <0.05);
clust3   = find(sum(stat_gradt.prob <= 0.05) > 0);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 1400 1000]);
set(fig,'PaperPosition',[1 1 1400 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

% color of each conditions
col = colormap('hot')
graphcol = []
for i = 1:length(GDAVG_magt)
    graphcol = [graphcol;col(2*i,:)]
end

% fmult
fmult = 1e6; % for express in uV
% define axes limit and plot properties
set_axes(-0.7, 2, -2,3)

% stimulus onsets
line([0 0],[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on
line([1 1],[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on

% cluster shade
cmap = colormap('jet')
cmap_inv = cmap(end:-1:1,:)
plot_lin_shade_v2(clust1 ,0.05 , stat_magt ,-6.5,5,[0.7 0.7 0.7],-1.8,indchan1,cmap,[-5 5])
% plot_lin_shade_v2(clust2 ,0.05 , stat_magt ,-6.5,5,[0.7 0.7 0.7],-7,indchan_2,cmap,[-5 5])

% timecourse
for i = 1:length(GDAVG_magt)
    plot(GDAVG_magt{1}.time,mean(GDAVG_magt{i}.avg(indchan1,:)*fmult),'linewidth',3,'color',graphcol(i,:));hold on
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 1400 1000]);
set(fig,'PaperPosition',[1 1 1400 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

% color of each conditions
col = colormap('hot')
graphcol = []
for i = 1:length(GDAVG_magt2)
    graphcol = [graphcol;col(2*i,:)]
end

% fmult
fmult = 1e14; % for express in uV
% define axes limit and plot properties
set_axes(-0.7, 2, -7, 7)

% stimulus onsets
line([0 0],[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on
line([1 1],[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on

% cluster shade
cmap = colormap('jet')
cmap_inv = cmap(end:-1:1,:)
plot_lin_shade_v2(clust2 ,0.05 , stat_magt2 ,-6.5,5,[0.7 0.7 0.7],-1.8,indchan2,cmap,[-5 5])
% plot_lin_shade_v2(clust2 ,0.05 , stat_magt ,-6.5,5,[0.7 0.7 0.7],-7,indchan_2,cmap,[-5 5])

% timecourse
for i = 1:length(GDAVG_magt2)
    plot(GDAVG_magt2{1}.time,mean(GDAVG_magt2{i}.avg(indchan2,:)*fmult),'linewidth',4,'color',graphcol(i,:));hold on
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 1400 1000]);
set(fig,'PaperPosition',[1 1 1400 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

% color of each conditions
col = colormap('hot')
graphcol = []
for i = 1:length(GDAVG_gradt)
    graphcol = [graphcol;col(2*i,:)]
end

% fmult
fmult = 1e12; % for express in uV
% define axes limit and plot properties
set_axes(-0.7, 2, -2,3)

% stimulus onsets
line([0 0],[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on
line([1 1],[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on

% cluster shade
cmap = colormap('jet')
cmap_inv = cmap(end:-1:1,:)
plot_lin_shade_v2(clust3 ,0.05 , stat_gradt ,-6.5,5,[0.7 0.7 0.7],-1.8,indchan3,cmap,[-5 5])
% plot_lin_shade_v2(clust2 ,0.05 , stat_magt ,-6.5,5,[0.7 0.7 0.7],-7,indchan_2,cmap,[-5 5])

% timecourse
for i = 1:length(GDAVG_magt)
    plot(GDAVG_gradt{1}.time,mean(GDAVG_gradt{i}.avg(indchan3,:)*fmult),'linewidth',3,'color',graphcol(i,:));hold on
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% plot barplots
% cluster pieces
t = [];
for i = 1:length(clust1)-1
    if abs(clust1(i+1) - clust1(i)) > 1
        t = [t i i+1];
    end
end

% time intervals
interval = [];

if length(t) >2

    Tstart(1) = find(abs(GDAVG_magt{3}.time - stat_magt.time(clust1(1))) < 1e-6);
    Tend(1)   = find(abs(GDAVG_magt{3}.time - stat_magt.time(clust1(t(1)))) < 1e-6);
    interval = [Tstart(1):Tend(1)];
    
    for i = 2:2:length(t)-1 
        Tstart(i/2+1) = find(abs(GDAVG_magt{3}.time - stat_magt.time(clust1(t(i)))) < 1e-6);
        Tend(i/2+1)   = find(abs(GDAVG_magt{3}.time - stat_magt.time(clust1(t(i+1)))) < 1e-6);
        interval = [interval Tstart(i/2+1):Tend(i/2+1)];
    end
    
    Tstart(i/2+2) = find(abs(GDAVG_magt{3}.time - stat_magt.time(clust1(t(i)))) < 1e-6);
    Tend(i/2+2)   = find(abs(GDAVG_magt{3}.time - stat_magt.time(clust1(end))) < 1e-6);   
    interval = [interval Tstart(i/2+2):Tend(i/2+2)];

elseif length(t) == 2
    Tstart(1) = find(abs(GDAVG_magt{3}.time - stat_magt.time(clust1(1))) < 1e-6);
    Tend(1)   = find(abs(GDAVG_magt{3}.time - stat_magt.time(clust1(t(1)))) < 1e-6);
    Tstart(2) = find(abs(GDAVG_magt{3}.time - stat_magt.time(clust1(t(2)))) < 1e-6);
    Tend(2)   = find(abs(GDAVG_magt{3}.time - stat_magt.time(clust1(end))) < 1e-6);  
    interval  = [Tstart(1):Tend(1) Tstart(2):Tend(2)];
else
    Tstart(1) = find(abs(GDAVG_magt{3}.time - stat_magt.time(clust1(1))) < 1e-6);
    Tend(1)   = find(abs(GDAVG_magt{3}.time - stat_magt.time(clust1(end))) < 1e-6);
    interval = [Tstart(1):Tend(1)];
    
end

%% barplot
fig = figure('position',[1 1 500 500]);
set(fig,'PaperPosition',[1 1 500 500])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

D = [];
for i = 1:length(GDAVG_magt)
    D(i) = mean(mean(GDAVG_magt{i}.avg(indchan1,Tstart(1):Tend(1))))*fmult;
end

allD = diag(D)
for i = 1:length(GDAVG_magt)
    bar(allD(i,:),'facecolor', graphcol(i,:));hold on
end
% errorbar(1,mean(data1),std(data1)./sqrt(19),'linestyle','none','color','k','linewidth',3)

axis([0 25 1 3.5])
set(gca, 'box','off','linewidth',3,'fontsize',20,'fontweight','b');

%% plots
fig = figure('position',[1 1 500 500]);
set(fig,'PaperPosition',[1 1 500 500])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

D = [];
for i = 1:length(GDAVG_magt)
    D(i) = mean(mean(GDAVG_magt{i}.avg(indchan1,Tstart(1):Tend(1))))*fmult;
end

allD = diag(D)
for i = 1:length(GDAVG_magt)
   plot(dist(i),D(i),'color', 'r','marker','.','markersize',40);hold on
end
% errorbar(1,mean(data1),std(data1)./sqrt(19),'linestyle','none','color','k','linewidth',3)

axis([0 30 1.2 3.8])
set(gca, 'box','off','linewidth',3,'fontsize',20,'fontweight','b');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% plot barplots
% cluster pieces
t = [];
for i = 1:length(clust2)-1
    if abs(clust2(i+1) - clust2(i)) > 1
        t = [t i i+1];
    end
end

% time intervals
interval = [];

if length(t) >2

    Tstart(1) = find(abs(GDAVG_magt2{3}.time - stat_magt2.time(clust2(1))) < 1e-6);
    Tend(1)   = find(abs(GDAVG_magt2{3}.time - stat_magt2.time(clust2(t(1)))) < 1e-6);
    interval = [Tstart(1):Tend(1)];
    
    for i = 2:2:length(t)-1 
        Tstart(i/2+1) = find(abs(GDAVG_magt2{3}.time - stat_magt2.time(clust2(t(i)))) < 1e-6);
        Tend(i/2+1)   = find(abs(GDAVG_magt2{3}.time - stat_magt2.time(clust2(t(i+1)))) < 1e-6);
        interval = [interval Tstart(i/2+1):Tend(i/2+1)];
    end
    
    Tstart(i/2+2) = find(abs(GDAVG_magt2{3}.time - stat_magt2.time(clust2(t(i)))) < 1e-6);
    Tend(i/2+2)   = find(abs(GDAVG_magt2{3}.time - stat_magt2.time(clust2(end))) < 1e-6);   
    interval = [interval Tstart(i/2+2):Tend(i/2+2)];

elseif length(t) == 2
    Tstart(1) = find(abs(GDAVG_magt2{3}.time - stat_magt2.time(clust2(1))) < 1e-6);
    Tend(1)   = find(abs(GDAVG_magt2{3}.time - stat_magt2.time(clust2(t(1)))) < 1e-6);
    Tstart(2) = find(abs(GDAVG_magt2{3}.time - stat_magt2.time(clust2(t(2)))) < 1e-6);
    Tend(2)   = find(abs(GDAVG_magt2{3}.time - stat_magt2.time(clust2(end))) < 1e-6);  
    interval  = [Tstart(1):Tend(1) Tstart(2):Tend(2)];
else
    Tstart(1) = find(abs(GDAVG_magt2{3}.time - stat_magt2.time(clust2(1))) < 1e-6);
    Tend(1)   = find(abs(GDAVG_magt2{3}.time - stat_magt2.time(clust2(end))) < 1e-6);
    interval = [Tstart(1):Tend(1)];
    
end

%% barplot
fig = figure('position',[1 1 500 500]);
set(fig,'PaperPosition',[1 1 500 500])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

D = [];
for i = 1:length(GDAVG_magt2)
    D(i) = mean(mean(GDAVG_magt2{i}.avg(indchan2,Tstart(1):Tend(1))))*fmult;
end

allD = diag(D)
for i = 1:length(GDAVG_magt2)
    bar(allD(i,:),'facecolor', graphcol(i,:));hold on
end
% errorbar(1,mean(data1),std(data1)./sqrt(19),'linestyle','none','color','k','linewidth',3)

axis([0 25 -3 4])
set(gca, 'box','off','linewidth',3,'fontsize',20,'fontweight','b');

%% plots
fig = figure('position',[1 1 500 500]);
set(fig,'PaperPosition',[1 1 500 500])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

D = [];
for i = 1:length(GDAVG_magt2)
    D(i) = mean(mean(GDAVG_magt2{i}.avg(indchan2,Tstart(1):Tend(1))))*fmult;
end

allD = diag(D)
for i = 1:length(GDAVG_magt2)
   plot(dist(i),D(i),'color', 'r','marker','.','markersize',40);hold on
end
% errorbar(1,mean(data1),std(data1)./sqrt(19),'linestyle','none','color','k','linewidth',3)

axis([0 28 -2.5 3.5])
set(gca, 'box','off','linewidth',3,'fontsize',20,'fontweight','b');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% plot barplots
% cluster pieces
t = [];
for i = 1:length(clust3)-1
    if abs(clust3(i+1) - clust3(i)) > 1
        t = [t i i+1];
    end
end

% time intervals
interval = [];

if length(t) >2

    Tstart(1) = find(abs(GDAVG_gradt{3}.time - stat_gradt.time(clust3(1))) < 1e-6);
    Tend(1)   = find(abs(GDAVG_gradt{3}.time - stat_gradt.time(clust3(t(1)))) < 1e-6);
    interval = [Tstart(1):Tend(1)];
    
    for i = 2:2:length(t)-1 
        Tstart(i/2+1) = find(abs(GDAVG_gradt{3}.time - stat_gradt.time(clust3(t(i)))) < 1e-6);
        Tend(i/2+1)   = find(abs(GDAVG_gradt{3}.time - stat_gradt.time(clust3(t(i+1)))) < 1e-6);
        interval = [interval Tstart(i/2+1):Tend(i/2+1)];
    end
    
    Tstart(i/2+2) = find(abs(GDAVG_gradt{3}.time - stat_gradt.time(clust3(t(i)))) < 1e-6);
    Tend(i/2+2)   = find(abs(GDAVG_gradt{3}.time - stat_gradt.time(clust3(end))) < 1e-6);   
    interval = [interval Tstart(i/2+2):Tend(i/2+2)];

elseif length(t) == 2
    Tstart(1) = find(abs(GDAVG_gradt{3}.time - stat_gradt.time(clust3(1))) < 1e-6);
    Tend(1)   = find(abs(GDAVG_gradt{3}.time - stat_gradt.time(clust3(t(1)))) < 1e-6);
    Tstart(2) = find(abs(GDAVG_gradt{3}.time - stat_gradt.time(clust3(t(2)))) < 1e-6);
    Tend(2)   = find(abs(GDAVG_gradt{3}.time - stat_gradt.time(clust3(end))) < 1e-6);  
    interval  = [Tstart(1):Tend(1) Tstart(2):Tend(2)];
else
    Tstart(1) = find(abs(GDAVG_gradt{3}.time - stat_gradt.time(clust3(1))) < 1e-6);
    Tend(1)   = find(abs(GDAVG_gradt{3}.time - stat_gradt.time(clust3(end))) < 1e-6);
    interval = [Tstart(1):Tend(1)];
    
end

%% barplot
fig = figure('position',[1 1 500 500]);
set(fig,'PaperPosition',[1 1 500 500])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

D = [];
for i = 1:length(GDAVG_gradt)
    D(i) = mean(mean(GDAVG_gradt{i}.avg(indchan3,Tstart(1):Tend(1))))*fmult;
end

allD = diag(D)
for i = 1:length(GDAVG_gradt)
    bar(allD(i,:),'facecolor', graphcol(i,:));hold on
end
% errorbar(1,mean(data1),std(data1)./sqrt(19),'linestyle','none','color','k','linewidth',3)

axis([0 25 -2 0])
set(gca, 'box','off','linewidth',3,'fontsize',20,'fontweight','b');

%% plots
fig = figure('position',[1 1 500 500]);
set(fig,'PaperPosition',[1 1 500 500])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

D = [];
for i = 1:length(GDAVG_gradt)
    D(i) = mean(mean(GDAVG_gradt{i}.avg(indchan3,Tstart(1):Tend(1))))*fmult;
end

allD = diag(D)
for i = 1:length(GDAVG_gradt)
   plot(dist(i),D(i),'color', 'r','marker','.','markersize',40);hold on
end
% errorbar(1,mean(data1),std(data1)./sqrt(19),'linestyle','none','color','k','linewidth',3)

axis([0 30 -1.8 0])
set(gca, 'box','off','linewidth',3,'fontsize',20,'fontweight','b');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 300 300]);
set(fig,'PaperPosition',[1 1 300 300])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

index = y(6)
cmap  = colormap('jet')
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat_gradt.time(index) stat_gradt.time(index)];
cfg.zlim               = [-5 5]; % F-values
cfg.colormap           = cmap;
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';


indchan = []; indchan  = find(stat_gradt.prob(:,index) <0.05);
cfg.highlightchannel   = stat_gradt.label(indchan3);
cfg.highlightsymbol    = '.';
cfg.highlightsize      = 20;
cfg.highlightcolor     = 'w';
cfg.comment            = num2str(stat_gradt.time(index));
ft_topoplotER(cfg,stat_gradt);
colorbar

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 300 300]);
set(fig,'PaperPosition',[1 1 300 300])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

index = y(3)
cmap  = colormap('jet')
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat_magt.time(index) stat_magt.time(index)];
cfg.zlim               = [-5 5]; % F-values
cfg.colormap           = cmap;
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';

indchan = []; indchan  = find(stat_magt.prob(:,index) <0.05);
cfg.highlightchannel   = stat_magt.label(indchan1);
cfg.highlightsymbol    = '.';
cfg.highlightsize      = 20;
cfg.highlightcolor     = 'w';
cfg.comment            = num2str(stat_magt.time(index));
ft_topoplotER(cfg,stat_magt);
colorbar

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 300 300]);
set(fig,'PaperPosition',[1 1 300 300])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

index = y(1)
cmap  = colormap('jet')
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat_magt2.time(index) stat_magt2.time(index)];
cfg.zlim               = [-5 5]; % F-values
cfg.colormap           = cmap;
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';

indchan = []; indchan  = find(stat_magt2.prob(:,index) <0.05);
cfg.highlightchannel   = stat_magt2.label(indchan2);
cfg.highlightsymbol    = '.';
cfg.highlightsize      = 20;
cfg.highlightcolor     = 'w';
cfg.comment            = num2str(stat_magt2.time(index));
ft_topoplotER(cfg,stat_magt2);
colorbar
