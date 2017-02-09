addpath('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/PLOTTING_PAPER')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% DIST TIME %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
condnames_clust = {'REGfull_EVTdistT_Zero'};
condnames    = {'REGfull_EVTdistT'};
latency      = [0 1];
graphcolor   = [[1 0.7 0.7];[0 0 0]];
stat_test    = 'T';
chansel      = 'Mags';
clustnum     = 0;
clusttype    = 'negclust';
timetag      = '201684151530';

[ch_magt, cdn_magt, cdn_clust_magt, stat_magt, GDAVG_magt, GDAVGt_magt, dist] = prepare_comp_v2(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
condnames_clust = {'REGfull_EVTdistT_Zero'};
condnames    = {'REGfull_EVTdistT'};
latency      = [0 1];
graphcolor   = [[1 0.7 0.7];[0 0 0]];
stat_test    = 'T';
chansel      = 'EEG';
clustnum     = 0;
clusttype    = 'negclust';
timetag      = '201684153317';

[ch_eegt, cdn_eegt, cdn_clust_eegt, stat_eegt, GDAVG_eegt, GDAVGt_eegt, dist] = prepare_comp_v2(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
condnames_clust = {'REGfull_EVSdistS_Zero'};
condnames    = {'REGfull_EVSdistS'};
latency      = [0 1];
graphcolor   = [[1 0.7 0.7];[0 0 0]];
stat_test    = 'T';
chansel      = 'Mags';
clustnum     = 0;
clusttype    = 'negclust';
timetag      = '201684151338';

[ch_mags, cdn_mags, cdn_clust_mags, stat_mags, GDAVG_mags, GDAVGt_mags, dists] = prepare_comp_v2(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
condnames_clust = {'REGfull_EVSdistS_Zero'};
condnames    = {'REGfull_EVSdistS'};
latency      = [0 1];
graphcolor   = [[1 0.7 0.7];[0 0 0]];
stat_test    = 'T';
chansel      = 'EEG';
clustnum     = 0;
clusttype    = 'negclust';
timetag      = '201684153143';

[ch_eegs, cdn_eegs, cdn_clust_eegs, stat_eegs, GDAVG_eegs, GDAVGt_eegs, dists] = prepare_comp_v2(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
condnames_clust = {'REGfull_EVTdistT_Zero'};
condnames    = {'EtDtq1G','EtDtq2G','EtDtq3G','EtDtq4G'};
latency      = [0 1];
graphcolor   = [[1 0.7 0.7];[0 0 0];[1 0 0];[0 0 0]];
stat_test    = 'T';
chansel      = 'EEG';
clustnum     = 0;
clusttype    = 'negclust';
timetag      = '201684153317';

[ch_eeg4, cdn_eeg4, cdn_clust_eeg4, stat_eeg4, GDAVG_eeg4] = prepare_comp(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
condnames_clust = {'REGfull_EVTdistT_Zero'};
condnames    = {'EtDtq1G','EtDtq2G','EtDtq3G','EtDtq4G'};
latency      = [0 1];
graphcolor   = [[1 0.7 0.7];[0 0 0];[1 0 0];[0 0 0]];
stat_test    = 'T';
chansel      = 'Mags';
clustnum     = 0;
clusttype    = 'negclust';
timetag      = '201684151530';

[ch_magt4, cdn_magt4, cdn_clust_magt4, stat_magt4, GDAVG_magt4] = prepare_comp(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
condnames_clust = {'REGfull_EVSdistS_Zero'};
condnames    = {'EsDsq1G','EsDsq2G','EsDsq3G','EsDsq4G'};
latency      = [0 1];
graphcolor   = [[1 0.7 0.7];[0 0 0];[1 0 0];[0 0 0]];
stat_test    = 'T';
chansel      = 'Mags';
clustnum     = 0;
clusttype    = 'negclust';
timetag      = '201684151338';

[ch_mags4, cdn_mags4, cdn_clust_mags4, stat_mags4, GDAVG_mags4] = prepare_comp(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
condnames_clust = {'REGfull_EVSdistS_Zero'};
condnames    = {'EsDsq1G','EsDsq2G','EsDsq3G','EsDsq4G'};
latency      = [0 1];
graphcolor   = [[1 0.7 0.7];[0 0 0]];
stat_test    = 'T';
chansel      = 'EEG';
clustnum     = 0;
clusttype    = 'negclust';
timetag      = '201684153143';

[ch_eegs4, cdn_eegs4, cdn_clust_eegs4, stat_eegs4, GDAVG_eegs4] = prepare_comp(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

%%%%%%%%%%%%%%%%%%%%%%%% prepare plotting layout %%%%%%%%%%%%%%%%%%%%%%%%%%
% select sensor datatype
[Grads1,Grads2,Mags]   = grads_for_layouts('Network');
% prepare layout
cfg                           = [];
cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/fieldtrip-20130901/template/layout/NM306mag.lay';
lay                        = ft_prepare_layout(cfg,GDAVG_magt4{1});
lay.label                = GDAVG_magt4{1}.label;

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
lay                        = ft_prepare_layout(cfg,GDAVG_eegs{1});
lay.label                = GDAVG_eegs{1}.label;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
times = sum(stat_eegs.prob <= 0.05);
plot(stat_eegs.time,times)
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
    cfg.xlim               = [stat_eegs.time(index) stat_eegs.time(index)];
    cfg.zlim               = [-10 10]; % F-values
    cfg.colormap           = 'jet';
    cfg.style              = 'straight';
    cfg.parameter          = 'stat';
    cfg.marker             = 'off';
    cfg.highlight          = 'on';
    indchan = []; indchan  = find(stat_eegs.prob(:,index) <0.05);
    cfg.highlightchannel   = stat_eegs.label(indchan);
    cfg.highlightsymbol    = '.';
    cfg.highlightsize      = 20;
    cfg.comment            = num2str(stat_eegs.time(index));
    ft_topoplotER(cfg,stat_eegs);
    count = count +1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
times    = sum(stat_magt.prob <= 0.05);
plot(stat_magt.time,times)
[x,y]    = findpeaks(times);
indchan1 = find(stat_magt.prob(:,y(1)) <0.05);
clust1   = find(sum(stat_magt.prob <= 0.05) > 0);

times    = sum(stat_mags.prob <= 0.05);
plot(stat_mags.time,times)
[x,y]    = findpeaks(times);
indchan2 = find((stat_mags.prob(:,y(8)) <0.05).*(stat_mags.stat(:,y(8)) > 0));
clust2   = find((sum((stat_mags.prob <= 0.05).*(stat_mags.stat > 0)) > 0));

times    = sum(stat_eegt.prob <= 0.05);
plot(stat_eegt.time,times)
[x,y]    = findpeaks(times);
indchan3 = find((stat_eegt.prob(:,y(3)) <0.05).*(stat_eegt.stat(:,y(3)) <0));
clust3  = find(sum(stat_eegt.prob <= 0.05) > 0);

times    = sum(stat_eegs.prob <= 0.05);
plot(stat_eegs.time,times)
[x,y]    = findpeaks(times);
indchan4 = find(stat_eegs.prob(:,y(5)) <0.05);
clust4  = find(sum(stat_eegs.prob <= 0.01) > 0);

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

times = sum(stat_magt.prob <= 0.05);
plot(stat_magt.time,times)
[x,y] = findpeaks(times);
index = y(1)

cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat_magt.time(index) stat_magt.time(index)];
cfg.zlim               = [-5 5]; % F-values
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
    D(i) = mean(tmp_gdavg{i}.avg(x))*1e14;
end
for i = 1:length(GDAVG_magt)
   plot(dist(i),D(i),'color', 'r','marker','.','markersize',60);hold on
end
% four-bins
for i = 1:length(GDAVG_magt4)
    D4(i) = mean(tmp_gdavg{i}.avg(x))*1e14;
end

% b =bar([2 10 17 23],D4([4 3 2 1]),'alpha',0.3,'facecolor','r'); hold on
% b.FaceAlpha = 0.5;

p = [];
p = polyfit(dist,D,1)
yy = polyval(p,[-10 40])
plot([-10 40],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',30); hold on

axis([-2 30 -3 4])

set(gca, 'box','off','linewidth',5,'fontsize',50,'fontweight','b');
print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/Mags_Early_LinearDistT_Time_mean')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plots 1 sensor
fig = figure('position',[1 1 400 500]);
set(fig,'PaperPosition',[1 1 400 500])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

D = [];
p = [];
for i =1:size(GDAVGt_magt{1}.individual,1)
    for d = 1:length(GDAVG_magt)
        tmp = []; tmp = squeeze(GDAVGt_magt{d}.individual(i,indchan1(9),clust1));
        D(i,d) = mean(mean(tmp))*1e15;
    end
    p(i,:) = polyfit(dist,D(i,:),1)
    yy = polyval(p(i,:),[-10 40])
    if p(i,1) > 0
        plot([-10 40],[yy(1) yy(2)],'linewidth',3,'color',[1 0.5 0.5 0.5]); hold on
    else
        plot([-10 40],[yy(1) yy(2)],'linewidth',3,'color',[0.5 0.5 0.5 0.5]); hold on
    end
end


D = [];
for i = 1:length(GDAVG_magt)
    D(i) = mean(GDAVG_magt{i}.avg(indchan1(9),clust1))*1e15;
end

for i = 1:length(GDAVG_magt)
   plot(dist(i),D(i),'color', 'k','marker','.','markersize',45);hold on
end

p = [];
p = polyfit(dist,D,1)
yy = polyval(p,[-10 40])
plot([-10 40],[yy(1) yy(2)],'linewidth',4,'color','r'); hold on

axis([0 28 -80 20])
set(gca, 'box','off','linewidth',3,'fontsize',20,'fontweight','b');

%%
print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/Mags_Early_DistT_Time_topo_linear')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Tstart(1) = find(abs(GDAVG_mags{3}.time - stat_mags.time(clust1(1))) < 1e-6);
Tend(1)   = find(abs(GDAVG_mags{3}.time - stat_mags.time(clust1(end))) < 1e-6);
interval = [Tstart(1):Tend(1)];

% plots full cluster
fig = figure('position',[1 1 800 800]);
set(fig,'PaperPosition',[1 1 800 800])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

mask = (stat_mags.prob < 0.01).*(stat_mags.stat < 0);
x = find(mask == 1);

% full range
D = [];
for i = 1:length(GDAVG_mags)
    D(i) = mean(GDAVG_mags{i}.avg(x))*1e14;
end
for i = 1:length(GDAVG_mags)
   plot(dists(i),D(i),'color', 'b','marker','.','markersize',60);hold on
end
% four-bins
for i = 1:length(GDAVG_mags4)
    D4(i) = mean(GDAVG_mags4{i}.avg(x))*1e14;
end

p = [];
p = polyfit(dists,D,1)
yy = polyval(p,[0 150])
plot([0 150],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',30); hold on

axis([0 150 -1 2])

set(gca, 'box','off','linewidth',5,'fontsize',50,'fontweight','b');
print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/Mags_Early_LinearDistS_Space_mean')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% time intervals
Tstart(1) = find(abs(GDAVG_eegs{3}.time - stat_eegs.time(clust4(1))) < 1e-6);
Tend(1)   = find(abs(GDAVG_eegs{3}.time - stat_eegs.time(clust4(end))) < 1e-6);
interval = [Tstart(1):Tend(1)];

% plots full cluster
fig = figure('position',[1 1 800 800]);
set(fig,'PaperPosition',[1 1 800 800])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

mask = (stat_eegs.prob < 0.01)
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
for i = 1:length(GDAVG_eegs)
    D4(i) = mean(tmp_gdavg{i}.avg(x))*1e6;
end

p = [];
p = polyfit(dists,D,1)
yy = polyval(p,[0 135])
plot([0 135],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',30); hold on

axis([0 135 0.5 3])

set(gca, 'box','off','linewidth',5,'fontsize',50,'fontweight','b');
print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/Mags_Early_LinearDistS_Space_mean')

