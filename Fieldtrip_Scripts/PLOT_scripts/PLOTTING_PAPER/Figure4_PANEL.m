addpath('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/PLOTTING_PAPER')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% DIST TIME %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
condnames_clust = {'RegEVTDistT','Zero'};
condnames    = {'EtDtq1G','EtDtq2G','EtDtq3G','EtDtq4G'};
latency      = [0 1];
graphcolor   = [[1 0.7 0.7];[0 0 0];[1 0 0]];
stat_test    = 'T';
chansel      = 'Mags';
clustnum     = 0;
clusttype    = 'posclust';
timetag      = '2016721184638';

[ch_magt, cdn_magt, cdn_clust_magt, stat_magt, GDAVG_magt, GDAVGt_magt] = prepare_comp(niplist,condnames,...
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
times = sum(stat_magt.prob <= 0.05);
plot(stat_magt.time,times)
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
    cfg.xlim               = [stat_magt.time(index) stat_magt.time(index)];
    cfg.zlim               = [-10 10]; % F-values
    cfg.colormap           = 'jet';
    cfg.style              = 'straight';
    cfg.parameter          = 'stat';
    cfg.marker             = 'off';
    cfg.highlight          = 'on';
    indchan = []; indchan  = find(stat_magt.prob(:,index) <0.05);
    cfg.highlightchannel   = stat_magt.label(indchan);
    cfg.highlightsymbol    = '.';
    cfg.highlightsize      = 20;
    cfg.comment            = num2str(stat_magt.time(index));
    ft_topoplotER(cfg,stat_magt);
    count = count +1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
times    = sum(stat_magt.prob <= 0.05);
plot(stat_magt.time,times)
[x,y]    = findpeaks(times);
indchan1 = find(stat_magt.prob(:,y(2)) <0.05);
clust1   = find(sum(stat_magt.prob <= 0.05) > 0);

times    = sum(stat_magt.prob <= 0.05);
plot(stat_magt.time,times)
[x,y]    = findpeaks(times);
indchan2 = find(stat_magt.prob(:,y(3)) <0.05);
clust2   = find(sum(stat_magt.prob <= 0.05) > 0);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 500 1000]);
set(fig,'PaperPosition',[1 1 500 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
subplot(2,1,1)

% color of each conditions
col = colormap('hot')
graphcolor = [col(10,:);col(20,:);col(30,:);col(40,:)]

% fmult
fmult = 1e14; % for express in uV
% define axes limit and plot properties
set_axes(-0.7, 1.2, -8,6)

% stimulus onsets
line([0 0]    ,[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on
line([1.1 1.1],[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on
line([2.2 2.2],[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on
line([3.4 3.4],[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on
line([4.6 4.6],[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on

% cluster shade
cmap = colormap('jet')
cmap_inv = cmap(end:-1:1,:)
plot_lin_shade_v2(clust1 ,0.05 , stat_magt ,-6.5,5,[0.7 0.7 0.7],-6,indchan1,cmap,[-5 5])
% plot_lin_shade_v2(clust2 ,0.05 , stat_magt ,-6.5,5,[0.7 0.7 0.7],-7,indchan_2,cmap,[-5 5])

% timecourse
plot(GDAVGt_magt{1}.time,mean(GDAVG_magt{1}.avg(indchan1,:)*fmult),'linewidth',4,'color',graphcolor(1,:));hold on
plot(GDAVGt_magt{1}.time,mean(GDAVG_magt{2}.avg(indchan1,:)*fmult),'linewidth',4,'color',graphcolor(2,:));hold on
plot(GDAVGt_magt{1}.time,mean(GDAVG_magt{3}.avg(indchan1,:)*fmult),'linewidth',4,'color',graphcolor(3,:));hold on
plot(GDAVGt_magt{1}.time,mean(GDAVG_magt{4}.avg(indchan1,:)*fmult),'linewidth',4,'color',graphcolor(4,:));hold on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(2,1,2)

% color of each conditions
col = colormap('hot')
graphcolor = [col(10,:);col(20,:);col(30,:);col(40,:)]

% fmult
fmult = 1e14; % for express in uV
% define axes limit and plot properties
set_axes(-0.7, 1.2, -8,6)

% stimulus onsets
line([0 0]    ,[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on
line([1.1 1.1],[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on
line([2.2 2.2],[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on
line([3.4 3.4],[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on
line([4.6 4.6],[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on

% cluster shade
cmap = colormap('jet')
cmap_inv = cmap(end:-1:1,:)
plot_lin_shade_v2(clust2 ,0.05 , stat_magt ,-6.5,5,[0.7 0.7 0.7],-6.5,indchan2,cmap,[-5 5])
% plot_lin_shade_v2(clust2 ,0.05 , stat_magt ,-6.5,5,[0.7 0.7 0.7],-7,indchan_2,cmap,[-5 5])

% timecourse
plot(GDAVGt_magt{1}.time,mean(GDAVG_magt{1}.avg(indchan2,:)*fmult),'linewidth',4,'color',graphcolor(1,:));hold on
plot(GDAVGt_magt{1}.time,mean(GDAVG_magt{2}.avg(indchan2,:)*fmult),'linewidth',4,'color',graphcolor(2,:));hold on
plot(GDAVGt_magt{1}.time,mean(GDAVG_magt{3}.avg(indchan2,:)*fmult),'linewidth',4,'color',graphcolor(3,:));hold on
plot(GDAVGt_magt{1}.time,mean(GDAVG_magt{4}.avg(indchan2,:)*fmult),'linewidth',4,'color',graphcolor(4,:));hold on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 300 300]);
set(fig,'PaperPosition',[1 1 300 300])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

index = y(2)
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
cfg.highlightchannel   = stat_magt.label(indchan);
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
cfg.highlightchannel   = stat_magt.label(indchan);
cfg.highlightsymbol    = '.';
cfg.highlightsize      = 20;
cfg.highlightcolor     = 'w';
cfg.comment            = num2str(stat_magt.time(index));
ft_topoplotER(cfg,stat_magt);
colorbar

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% DIST SPACE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
condnames_clust = {'RegEVSDistS','Zero'};
condnames    = {'EsDsq1G','EsDsq2G','EsDsq3G','EsDsq4G'};
latency      = [0 1];
graphcolor   = [[0.7 0.7 0.7];[0 0 0];[1 0 0]];
stat_test    = 'T';
chansel      = 'Mags';
clustnum     = 0;
clusttype    = 'negclust';
timetag      = '201672118530';

[ch_mags, cdn_mags, cdn_clust_mags, stat_mags, GDAVG_mags, GDAVGt_mags] = prepare_comp(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
condnames_clust = {'RegEVSDistS','Zero'};
condnames    = {'EsDsq1G','EsDsq2G','EsDsq3G','EsDsq4G'};
latency      = [0 1];
graphcolor   = [[0.7 0.7 0.7];[0 0 0];[1 0 0]];
stat_test    = 'T';
chansel      = 'EEG';
clustnum     = 0;
clusttype    = 'negclust';
timetag      = '201672119111';

[ch_eeg2, cdn_eeg2, cdn_clust_eeg2, stat_eeg2, GDAVG_eeg2, GDAVGt_eeg2] = prepare_comp(niplist,condnames,...
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
lay                        = ft_prepare_layout(cfg,GDAVGt_eeg2{1});
lay.label                = GDAVGt_eeg2{1}.label;

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
lay                        = ft_prepare_layout(cfg,GDAVGt_mags{1});
lay.label                = GDAVGt_mags{1}.label;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
times = sum(stat_eeg2.prob <= 0.05);
plot(stat_eeg2.time,times)
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
    cfg.xlim               = [stat_eeg2.time(index) stat_eeg2.time(index)];
    cfg.zlim               = [-10 10]; % F-values
    cfg.colormap           = 'jet';
    cfg.style              = 'straight';
    cfg.parameter          = 'stat';
    cfg.marker             = 'off';
    cfg.highlight          = 'on';
    indchan = []; indchan  = find(stat_eeg2.prob(:,index) <0.05);
    cfg.highlightchannel   = stat_eeg2.label(indchan);
    cfg.highlightsymbol    = '.';
    cfg.highlightsize      = 20;
    cfg.comment            = num2str(stat_eeg2.time(index));
    ft_topoplotER(cfg,stat_eeg2);
    count = count +1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
right.channel = {'MEG0721', 'MEG0731', 'MEG0931', 'MEG1021', 'MEG1031', 'MEG1041',...
               'MEG1111', 'MEG1121', 'MEG1131', 'MEG1141', 'MEG1211', 'MEG1221',...
               'MEG1231', 'MEG1241', 'MEG1311', 'MEG1321', 'MEG1331', 'MEG1341',...
               'MEG1411', 'MEG1421', 'MEG1441', 'MEG2211', 'MEG2221', 'MEG2231',...
               'MEG2241', 'MEG2411', 'MEG2421', 'MEG2611', 'MEG2641'}

indchan = []; indchan = find(stat_mags.prob(:,y(4)) <0.05);  

% get the channel list exclusing forntal sensors     
ant_chan = intersect(stat_mags.label ,right.channel)

% get the indexes of posterior sensor
ind_ant = []
count = 1;
for i = 1:length(stat_mags.label)
    for j = 1:length(ant_chan)
        if strcmp(stat_mags.label{i},ant_chan{j})
            ind_ant(count) = i;
            count = count +1;
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
times    = sum(stat_mags.prob <= 0.05);
plot(stat_mags.time,times)
[x,y]    = findpeaks(times);
indchan1 = find(stat_mags.prob(:,y(4)) <0.05);
clust1   = find(sum(stat_mags.prob <= 0.05) > 0);
inchan_g = intersect(ind_ant,indchan1)

times    = sum(stat_eeg2.prob <= 0.05);
plot(stat_eeg2.time,times)
[x,y]    = findpeaks(times);
indchan_eeg2 = find(stat_eeg2.prob(:,y(6)) <0.05);
clust_eeg2   = find(sum(stat_eeg2.prob <= 0.05) > 0);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 500 1000]);
set(fig,'PaperPosition',[1 1 500 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
subplot(2,1,1)

% color of each conditions
col = colormap('jet')
graphcolor = [col(1,:);col(8,:);col(16,:);col(24,:)]

% fmult
fmult = 1e14; % for express in uV
% define axes limit and plot properties
set_axes(-0.7, 1.2, -4,4)

% stimulus onsets
line([0 0]    ,[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on
line([1.1 1.1],[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on
line([2.2 2.2],[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on
line([3.4 3.4],[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on
line([4.6 4.6],[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on

% cluster shade
cmap = colormap('jet')
plot_lin_shade_v2(clust1 ,0.05 , stat_mags ,-4,4,[0.7 0.7 0.7],-3.5,inchan_g,cmap,[-5 5])
% plot_lin_shade_v2(clust2 ,0.05 , stat_magt ,-6.5,5,[0.7 0.7 0.7],-7,indchan_2,cmap,[-5 5])

% timecourse
plot(GDAVG_mags{1}.time,mean(GDAVG_mags{1}.avg(inchan_g,:)*fmult) ,'linewidth',4,'color',graphcolor(1,:));hold on
plot(GDAVG_mags{1}.time,mean(GDAVG_mags{2}.avg(inchan_g,:)*fmult) ,'linewidth',4,'color',graphcolor(2,:));hold on
plot(GDAVG_mags{1}.time,mean(GDAVG_mags{3}.avg(inchan_g,:)*fmult) ,'linewidth',4,'color',graphcolor(3,:));hold on
plot(GDAVG_mags{1}.time,mean(GDAVG_mags{4}.avg(inchan_g,:)*fmult) ,'linewidth',4,'color',graphcolor(4,:));hold on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 500 1000]);
set(fig,'PaperPosition',[1 1 500 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
subplot(2,1,1)

% color of each conditions
col = colormap('jet')
graphcolor = [col(1,:);col(8,:);col(16,:);col(24,:)]

% fmult
fmult = 1e6; % for express in uV
% define axes limit and plot properties
set_axes(-0.7, 1.2, -1.5,2.5)

% stimulus onsets
line([0 0]    ,[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on
line([1.1 1.1],[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on
line([2.2 2.2],[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on
line([3.4 3.4],[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on
line([4.6 4.6],[-5 5],'linestyle',':','linewidth',2,'color',[0.5 0.5 0.5]); hold on

% cluster shade
cmap = colormap('jet')
plot_lin_shade_v2(clust_eeg2 ,0.05 , stat_eeg2 ,-6.5,5,[0.7 0.7 0.7],-1.2,indchan_eeg2,cmap,[-5 5])
% plot_lin_shade_v2(clust2 ,0.05 , stat_magt ,-6.5,5,[0.7 0.7 0.7],-7,indchan_2,cmap,[-5 5])

% timecourse
plot(GDAVG_eeg2{1}.time,mean(GDAVG_eeg2{1}.avg(indchan_eeg2,:)*fmult) ,'linewidth',4,'color',graphcolor(1,:));hold on
plot(GDAVG_eeg2{1}.time,mean(GDAVG_eeg2{2}.avg(indchan_eeg2,:)*fmult) ,'linewidth',4,'color',graphcolor(2,:));hold on
plot(GDAVG_eeg2{1}.time,mean(GDAVG_eeg2{3}.avg(indchan_eeg2,:)*fmult) ,'linewidth',4,'color',graphcolor(3,:));hold on
plot(GDAVG_eeg2{1}.time,mean(GDAVG_eeg2{4}.avg(indchan_eeg2,:)*fmult) ,'linewidth',4,'color',graphcolor(4,:));hold on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 300 300]);
set(fig,'PaperPosition',[1 1 300 300])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

index = y(6)
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
cfg.highlightchannel   = stat_magt.label(indchan);
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

index = y(4)
cmap  = colormap('jet')
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat_mags.time(index) stat_mags.time(index)];
cfg.zlim               = [-5 5]; % F-values
cfg.colormap           = cmap;
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
cfg.highlightchannel   = stat_mags.label(inchan_g);
cfg.highlightsymbol    = '.';
cfg.highlightsize      = 20;
cfg.highlightcolor     = 'w';
cfg.comment            = num2str(stat_mags.time(index));
ft_topoplotER(cfg,stat_mags);
colorbar

