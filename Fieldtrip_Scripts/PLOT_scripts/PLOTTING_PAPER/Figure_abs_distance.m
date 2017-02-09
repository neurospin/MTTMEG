addpath('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/PLOTTING_PAPER')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% DIST TIME %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
condnames_clust = {'REGfull_SignEVTdistT_Zero'};
condnames    = {'REGfull_SignEVTdistT'};
latency      = [0 1];
graphcolor   = [[1 0.7 0.7];[0 0 0]];
stat_test    = 'T';
chansel      = 'Mags';
clustnum     = 0;
clusttype    = 'negclust';
timetag      = '20161024142255';

[ch_magt, cdn_magt, cdn_clust_magt, stat_magt, GDAVG_magt, GDAVGt_magt, dist] = prepare_comp_v3(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

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

[ch_magta, cdn_magta, cdn_clust_magta, stat_magta, GDAVG_magta, GDAVGt_magta, dista] = prepare_comp_v2(niplist,condnames,...
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
condnames    = {'REGfull_SignEVSdistS'};
latency      = [0 1];
chansel      = 'EEG';
[ch_eegss, cdn_eegss, GDAVG_eegss, GDAVGt_eegss,dist_eegss] = prepare_comp_v4(niplist,condnames{1} , latency, chansel)

%%%%%%%%%%%%%%%%%%%%%%%% prepare plotting layout %%%%%%%%%%%%%%%%%%%%%%%%%%
% select sensor datatype
[Grads1,Grads2,Mags]   = grads_for_layouts('Network');
% prepare layout
cfg                           = [];
cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/fieldtrip-20130901/template/layout/NM306mag.lay';
lay                        = ft_prepare_layout(cfg,GDAVG_magt{1});
lay.label                = GDAVG_magt{1}.label;

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
times = sum(stat_magta.prob <= 0.025);
plot(stat_magta.time,times)
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
    cfg.zlim               = [-5 5]; % F-values
    cfg.colormap           = 'jet';
    cfg.style              = 'straight';
    cfg.parameter          = 'stat';
    cfg.marker             = 'off';
    cfg.highlight          = 'on';
    indchan = []; indchan  = find(stat_magt.prob(:,index) <0.25);
    cfg.highlightchannel   = stat_magt.label(indchan);
    cfg.highlightsymbol    = '.';
    cfg.highlightsize      = 20;
    cfg.comment            = num2str(stat_magt.time(index));
    ft_topoplotER(cfg,stat_magt);
    count = count +1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
times    = sum(stat_magta.prob <= 0.025);
plot(stat_magta.time,times)
[x,y]    = findpeaks(times);
indchan1 = find(stat_magta.prob(:,y(3)) <0.025);
clust1   = find(sum(stat_magta.prob <= 0.025) > 0);

times    = sum(stat_eegs.prob <= 0.025);
plot(stat_eegs.time,times)
[x,y]    = findpeaks(times);
indchan4 = find(stat_eegs.prob(:,y(5)) <0.025);
clust4  = find(sum(stat_eegs.prob <= 0.025) > 0);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 400 400]);
set(fig,'PaperPosition',[1 1 400 400])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

times = sum(stat_magta.prob <= 0.025);
plot(stat_magta.time,times)
[x,y] = findpeaks(times);
index = y(1)

cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat_magta.time(index) stat_magta.time(index)];
cfg.zlim               = [-5 5]; % F-values
cmap = colormap('gray')
cfg.colormap           = cmap;
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
cfg.highlight          = {'on'};
cfg.highlightchannel   = {stat_magta.label(indchan1)};
cfg.highlightsymbol    = {'.'};
cfg.highlightsize      = {24} ;
cfg.highlightcolor     = {'w'};
ft_topoplotER(cfg,stat_magta);
colorbar

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/Mags_Early_DistT_Time_topo')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 1600 500]);
set(fig,'PaperPosition',[1 1 1600 500])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

% color of each conditions
% color of each conditions
graphcolor = [[0 0   0.25];
            [0.05 0.05   0.75  ];
            [0.25   0.25 1];
            [0.75   0.75 1]
            [0.75   0.75 1];
            [0.25   0.25 1];
            [0.05 0.05   0.75  ];
            [0 0   0.25]];

% fmult
fmult = 1e6; % for express in uV

% binning
val1 = (mean(GDAVG_eegss{1}.avg(indchan4,:)*fmult) + mean(GDAVG_eegss{2}.avg(indchan4,:)*fmult) +...
    mean(GDAVG_eegss{3}.avg(indchan4,:)*fmult))/3;
val2 = (mean(GDAVG_eegss{4}.avg(indchan4,:)*fmult) + mean(GDAVG_eegss{5}.avg(indchan4,:)*fmult) +...
    mean(GDAVG_eegss{6}.avg(indchan4,:)*fmult))/3;
val3 = (mean(GDAVG_eegss{7}.avg(indchan4,:)*fmult) + mean(GDAVG_eegss{8}.avg(indchan4,:)*fmult) +...
    mean(GDAVG_eegss{9}.avg(indchan4,:)*fmult))/3;
val4 = (mean(GDAVG_eegss{10}.avg(indchan4,:)*fmult) + mean(GDAVG_eegss{11}.avg(indchan4,:)*fmult) +...
    mean(GDAVG_eegss{12}.avg(indchan4,:)*fmult))/3;
val5 = (mean(GDAVG_eegss{13}.avg(indchan4,:)*fmult) + mean(GDAVG_eegss{14}.avg(indchan4,:)*fmult) +...
    mean(GDAVG_eegss{15}.avg(indchan4,:)*fmult))/3;
val6 = (mean(GDAVG_eegss{16}.avg(indchan4,:)*fmult) + mean(GDAVG_eegss{17}.avg(indchan4,:)*fmult) +...
    mean(GDAVG_eegss{18}.avg(indchan4,:)*fmult))/3;
val7 = (mean(GDAVG_eegss{19}.avg(indchan4,:)*fmult) + mean(GDAVG_eegss{20}.avg(indchan4,:)*fmult) +...
    mean(GDAVG_eegss{21}.avg(indchan4,:)*fmult))/3;
val8 = (mean(GDAVG_eegss{22}.avg(indchan4,:)*fmult) + mean(GDAVG_eegss{23}.avg(indchan4,:)*fmult) +...
    mean(GDAVG_eegss{24}.avg(indchan4,:)*fmult) + mean(GDAVG_eegss{25}.avg(indchan4,:)*fmult))/4;  

% cluster shade
fill([0.653 0.653 0.985 0.985], [-1.5 3 3 -1.5],[0.8 0.8 0.8],'edgecolor',[0.8 0.8 0.8]);hold on

% stimulus onsets
line([0 0],[-1.5 3],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); 
line([1 1],[-1.5 3],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); 

% zero-amplitude
line([-0.2 1],[0 0],'linestyle','-','linewidth',2,'color','k');hold on

% timecourse
plot(GDAVG_eegs{1}.time,val1,'linewidth',5,'color',graphcolor(1,:));hold on
plot(GDAVG_eegs{1}.time,val2,'linewidth',5,'color',graphcolor(2,:));
plot(GDAVG_eegs{1}.time,val3,'linewidth',5,'color',graphcolor(3,:));
plot(GDAVG_eegs{1}.time,val4,'linewidth',5,'color',graphcolor(4,:));
plot(GDAVG_eegs{1}.time,val5,'linewidth',5,'color',graphcolor(5,:));
plot(GDAVG_eegs{1}.time,val6,'linewidth',5,'color',graphcolor(6,:));
plot(GDAVG_eegs{1}.time,val7,'linewidth',5,'color',graphcolor(7,:));
plot(GDAVG_eegs{1}.time,val8,'linewidth',5,'color',graphcolor(8,:));

set(gca, 'ytick',[-1 0 1 2 3],'yticklabel',[-1 0 1 2 3],'linewidth',3,'box','off')
axis([-0.2, 1.2, -1.5,3])

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/absDistT_cluster')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 1600 500]);
set(fig,'PaperPosition',[1 1 1600 500])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

% color of each conditions
graphcolor = [[0.25 0    0   ],
    [0.75 0.05 0.05],
    [1    0.25 0.25],
    [1    0.75 0.75],
    [1    0.75 0.75],
    [1    0.25 0.25],
    [0.75 0.05 0.05],
    [0.25 0    0   ]];
       
% binning
val1 = (mean(GDAVG_magt{1}.avg(indchan1,:)*fmult) + mean(GDAVG_magt{2}.avg(indchan1,:)*fmult) +...
    mean(GDAVG_magt{3}.avg(indchan1,:)*fmult))/3;
val2 = (mean(GDAVG_magt{4}.avg(indchan1,:)*fmult) + mean(GDAVG_magt{5}.avg(indchan1,:)*fmult) +...
    mean(GDAVG_magt{6}.avg(indchan1,:)*fmult))/3;
val3 = (mean(GDAVG_magt{7}.avg(indchan1,:)*fmult) + mean(GDAVG_magt{8}.avg(indchan1,:)*fmult) +...
    mean(GDAVG_magt{9}.avg(indchan1,:)*fmult))/3;
val4 = (mean(GDAVG_magt{10}.avg(indchan1,:)*fmult) + mean(GDAVG_magt{11}.avg(indchan1,:)*fmult) +...
    mean(GDAVG_magt{12}.avg(indchan1,:)*fmult))/3;
val5 = (mean(GDAVG_magt{13}.avg(indchan1,:)*fmult) + mean(GDAVG_magt{14}.avg(indchan1,:)*fmult) +...
    mean(GDAVG_magt{15}.avg(indchan1,:)*fmult))/3;
val6 = (mean(GDAVG_magt{16}.avg(indchan1,:)*fmult) + mean(GDAVG_magt{17}.avg(indchan1,:)*fmult) +...
    mean(GDAVG_magt{18}.avg(indchan1,:)*fmult))/3;
val7 = (mean(GDAVG_magt{19}.avg(indchan1,:)*fmult) + mean(GDAVG_magt{20}.avg(indchan1,:)*fmult) +...
    mean(GDAVG_magt{21}.avg(indchan1,:)*fmult))/3;
val8 = (mean(GDAVG_magt{22}.avg(indchan1,:)*fmult) + mean(GDAVG_magt{23}.avg(indchan1,:)*fmult))/2;
          
% fmult
fmult = 1e15; % for express in uV

% cluster shadehelp area
fill([0.828 0.828 1 1], [-70 50 50 -70],[0.8 0.8 0.8],'edgecolor',[0.8 0.8 0.8]);hold on

% stimulus onsets
line([0 0],[-120 70],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); 
line([1 1],[-120 70],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); 

% zero-amplitude
line([-0.2 1.2],[0 0],'linestyle','-','linewidth',2,'color','k');hold on

% timecourse
plot(GDAVG_magt{1}.time,val1,'linewidth',5,'color',graphcolor(4,:));hold on
plot(GDAVG_magt{1}.time,val2,'linewidth',5,'color',graphcolor(3,:));
plot(GDAVG_magt{1}.time,val3,'linewidth',5,'color',graphcolor(2,:));
plot(GDAVG_magt{1}.time,val4,'linewidth',5,'color',graphcolor(1,:));
plot(GDAVG_magt{1}.time,val5,'linewidth',5,'color',graphcolor(8,:));
plot(GDAVG_magt{1}.time,val6,'linewidth',5,'color',graphcolor(7,:));
plot(GDAVG_magt{1}.time,val7,'linewidth',5,'color',graphcolor(6,:));
plot(GDAVG_magt{1}.time,val8,'linewidth',5,'color',graphcolor(5,:));

set(gca, 'ytick',[-50 0 50],'yticklabel',[-50 0 50],'linewidth',3,'box','off')
axis([-0.2, 1.2, -50,50])

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/absDistT_cluster')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
times    = sum(stat_eegs.prob <= 0.025);
plot(stat_eegs.time,times)
[x,y]    = findpeaks(times);
indchan4 = find(stat_eegs.prob(:,y(5)) <0.025);
clust4  = find(sum(stat_eegs.prob <= 0.025) > 0);

fig = figure('position',[1 1 400 400]);
set(fig,'PaperPosition',[1 1 400 400])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

index = y(5)

cmap = colormap('jet')
cmap = cmap(end:-1:1,:)
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat_eegs.time(index) stat_eegs.time(index)];
cfg.zlim               = [-5 5]; % F-values
cmap = colormap('gray')
cfg.colormap           = cmap;
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
cfg.highlight          = {'on'};
cfg.highlightchannel   = {stat_eegs.label(indchan4)};;
cfg.highlightsymbol    = {'.'};
cfg.highlightsize      = {24} ;
cfg.highlightcolor     = {'w'};
cfg.comment            = num2str(stat_eegs.time(index));
ft_topoplotER(cfg,stat_eegs);
colorbar

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/EEG_Early_DistS_Space_topo')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
times = sum(stat_magt.prob <= 0.025);
plot(stat_magt.time,times)
[x,y] = findpeaks(times);
index = y(3)

fig = figure('position',[1 1 400 400]);
set(fig,'PaperPosition',[1 1 400 400])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

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
cfg.highlight          = {'on'};
cfg.highlightchannel   = {stat_magt.label(indchan1)};
cfg.highlightsymbol    = {'.'};
cfg.highlightsize      = {24} ;
cfg.highlightcolor     = {'w'};
cfg.comment            = num2str(stat_magt.time(index));
ft_topoplotER(cfg,stat_magt);
colorbar

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/Mags_Early_DistT_Time_topo')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plots 1 sensor
x = find(stat_magta.mask==1)

% D = [];
% p = [];
% for i =1:size(GDAVGt_magt{1}.individual,1)
%     for d = 1:length(GDAVG_magt)
%         cfg = []; cfg.toilim = [stat_magt.time(1) stat_magt.time(end)];
%         tmp_gdavg{d} = ft_redefinetrial(cfg,GDAVGt_magt{d})
%         tmp = []; tmp = squeeze(tmp_gdavg{d}.trial(i,:,:));
%         D(i,d) = mean(tmp(x))*1e15;
%     end
%     p(i,:) = polyfit(dist,D(i,:),1)
%     yy = polyval(p(i,:),[-10 40])
%     if p(i,1) > 0
%         plot([-40 40],[yy(1) yy(2)],'linewidth',3,'color',[1 0.5 0.5 0.5]); hold on
%     else
%         plot([-40 40],[yy(1) yy(2)],'linewidth',3,'color',[1 0.5 0.5 0.5]); hold on
%     end
% end


% rephase time of data and test
cfg = []; cfg.toilim = [stat_magt.time(1) stat_magt.time(end)];
for i = 1:length(GDAVG_magt)
    tmp_gdavg{i} = ft_redefinetrial(cfg,GDAVG_magt{i})
end

% full range
D = [];
for i = 1:length(GDAVG_magt)
    D(i) = mean(mean(tmp_gdavg{i}.avg(x)))*1e15;
end


fig = figure('position',[1 1 800 800]);
set(fig,'PaperPosition',[1 1 800 800])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

line([-30 30],[0 0],'linewidth',5,'linestyle','--','color',[0.5 0.5 0.5]);hold on
line([0 0],[-40 40],'linewidth',5,'linestyle','--','color',[0.5 0.5 0.5])


for i = 1:length(GDAVG_magt)
   plot(dist(i),D(i),'color', 'r','marker','.','markersize',80);hold on
end

% fit with neg
p1 = [];
p1 = polyfit(dist(1:11),D(1:11),1)
yy1 = polyval(p1,[-40 0])

% fit with pos
p2 = [];
p2 = polyfit(dist(11:23),D(11:23),1)
yy2 = polyval(p2,[0 40])

plot([-40 0 ],[yy1(1) yy1(2)],'linewidth',5,'color','k','markersize',18); hold on
plot([0   40],[yy2(1) yy2(2)],'linewidth',5,'color','k','markersize',18); hold on

set(gca, 'box','off','linewidth',4,'fontsize',30,'fontweight','b');
set(gca,'ytick',[-20 0 20 40],'yticklabel',{'-20','0','20','40'})
set(gca,'xtick',[-20 0 20 40],'xticklabel',{'-20','REF','20','40'})
axis([-35 35 -20 40])

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/Mags_Early_AbsLinearDistT_Time_allsubj')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plots 1 sensor
fig = figure('position',[1 1 400 500]);
set(fig,'PaperPosition',[1 1 400 500])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

mask = (stat_grads2.prob < 0.025);
x = find(mask == 1);

D = [];
p = [];
for i =1:size(GDAVGt_grads2{1}.individual,1)
    for d = 1:length(GDAVG_grads2)
        cfg = []; cfg.toilim = [stat_grads2.time(1) stat_grads2.time(end)];
        tmp_gdavg{d} = ft_redefinetrial(cfg,GDAVGt_grads2{d})
        tmp = []; tmp = squeeze(tmp_gdavg{d}.trial(i,:,:));
        D(i,d) = mean(tmp(x))*1e13;
    end
    p(i,:) = polyfit(dist,D(i,:),1)
    yy = polyval(p(i,:),[-10 40])
    if p(i,1) > 0
        plot([-40 40],[yy(1) yy(2)],'linewidth',3,'color',[1 0.5 0.5 0.5]); hold on
    else
        plot([-40 40],[yy(1) yy(2)],'linewidth',3,'color',[1 0.5 0.5 0.5]); hold on
    end
end

% rephase time of data and test
cfg = []; cfg.toilim = [stat_grads2.time(1) stat_grads2.time(end)];
for i = 1:length(GDAVG_grads2)
    tmp_gdavg{i} = ft_redefinetrial(cfg,GDAVG_grads2{i})
end

% full range
D = [];
for i = 1:length(GDAVG_grads2)
    D(i) = mean(tmp_gdavg{i}.avg(x))*1e13;
end
for i = 1:length(GDAVG_grads2)
   plot(dist(i),D(i),'color', 'r','marker','.','markersize',80);hold on
end


p = [];
p = polyfit(dist,D,1)
yy = polyval(p,[-40 40])
plot([-40 40],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on

set(gca, 'box','off','linewidth',3,'fontsize',20,'fontweight','b');

axis([-35 35 -20 0])

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/Grads_Early_AbsLinearDistT_Time_allsubj')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plots 1 sensor

x = find((stat_grads2s.mask.*(repmat([zeros(1,160) ones(1,20) zeros(1,71)],102,1))));
x = find((stat_grads2s.mask.*(repmat([zeros(1,192) ones(1,24) zeros(1,35)],102,1))));
x = find((stat_grads2s.mask.*(repmat([zeros(1,220) ones(1,13) zeros(1,18)],102,1))));
x = find(stat_grads2s.mask==1)

% D = [];
% p = [];
% for i =1:size(GDAVGt_grads2s{1}.individual,1)
%     for d = 1:length(GDAVG_grads2s)
%         cfg = []; cfg.toilim = [stat_grads2s.time(1) stat_grads2s.time(end)];
%         tmp_gdavg{d} = ft_redefinetrial(cfg,GDAVGt_grads2s{d})
%         tmp = []; tmp = squeeze(tmp_gdavg{d}.trial(i,:,:));
%         D(i,d) = mean(tmp(x))*1e13;
%     end
%     p(i,:) = polyfit(dist,D(i,:),1)
%     yy = polyval(p(i,:),[-10 40])
%     if p(i,1) > 0
%         plot([-40 40],[yy(1) yy(2)],'linewidth',3,'color',[1 0.5 0.5 0.5]); hold on
%     else
%         plot([-40 40],[yy(1) yy(2)],'linewidth',3,'color',[1 0.5 0.5 0.5]); hold on
%     end
% end

% rephase time of data and test
cfg = []; cfg.toilim = [stat_grads2s.time(1) stat_grads2s.time(end)];
for i = 1:length(GDAVG_grads2s)
    tmp_gdavg{i} = ft_redefinetrial(cfg,GDAVG_grads2s{i})
end

% full range
D = [];
for i = 1:length(GDAVG_grads2s)
    D(i) = mean(tmp_gdavg{i}.avg(x))*1e13;
end

fig = figure('position',[1 1 800 800]);
set(fig,'PaperPosition',[1 1 800 800])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

line([-170 170],[0 0],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5]);hold on
line([0 0],[-15 5],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5])

for i = 1:length(GDAVG_grads2s)
   plot(dists(i),D(i),'color', 'b','marker','.','markersize',100);hold on
end

p = [];
p = polyfit(dists,D,1)
yy = polyval(p,[-170 170])
plot([-170 170],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on

set(gca, 'box','off','linewidth',3,'fontsize',40,'fontweight','b');
% set(gca,'ytick',[-20 0 20 40],'yticklabel',[-20 0 20 40])
axis([-170 170 -15 5])

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/Grads_Early_SignedLinearDistS_Space_allsubj')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plots 1 sensor
x = find(stat_eegs.mask==1)

% D = [];
% p = [];
% for i =1:size(GDAVGt_magt{1}.individual,1)
%     for d = 1:length(GDAVG_magt)
%         cfg = []; cfg.toilim = [stat_magt.time(1) stat_magt.time(end)];
%         tmp_gdavg{d} = ft_redefinetrial(cfg,GDAVGt_magt{d})
%         tmp = []; tmp = squeeze(tmp_gdavg{d}.trial(i,:,:));
%         D(i,d) = mean(tmp(x))*1e15;
%     end
%     p(i,:) = polyfit(dist,D(i,:),1)
%     yy = polyval(p(i,:),[-10 40])
%     if p(i,1) > 0
%         plot([-40 40],[yy(1) yy(2)],'linewidth',3,'color',[1 0.5 0.5 0.5]); hold on
%     else
%         plot([-40 40],[yy(1) yy(2)],'linewidth',3,'color',[1 0.5 0.5 0.5]); hold on
%     end
% end


% rephase time of data and test
cfg = []; cfg.toilim = [stat_eegs.time(1) stat_eegs.time(end)];
for i = 1:length(GDAVG_eegss)
    tmp_gdavg{i} = ft_redefinetrial(cfg,GDAVG_eegss{i})
end

% full range
D = [];
for i = 1:length(GDAVG_eegss)
    D(i) = mean(mean(tmp_gdavg{i}.avg(x)))*1e6;
end


fig = figure('position',[1 1 800 800]);
set(fig,'PaperPosition',[1 1 800 800])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

line([-160 150],[0 0],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5]);hold on
line([0 0],[0 3],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5])

for i = 1:length(GDAVG_magt)
   plot(dists(i),D(i),'color', 'b','marker','.','markersize',80);hold on
end

dists = [-149 -117 -95 -85 -74 -63 -52 -42 -31 -20 -10 1 12 22 33 44 55 65 76 87 97 108 119 129 140]
% fit with neg
p1 = [];
p1 = polyfit(dists(1:12),D(1:12),1)
yy1 = polyval(p1,[-160 0])

% fit with pos
p2 = [];
p2 = polyfit(dists(12:24),D(12:24),1)
yy2 = polyval(p2,[0 150])

plot([-160 0 ],[yy1(1) yy1(2)],'linewidth',4,'color','k','markersize',15); hold on
plot([0   150],[yy2(1) yy2(2)],'linewidth',4,'color','k','markersize',15); hold on

set(gca, 'box','off','linewidth',3,'fontsize',40,'fontweight','b');
set(gca,'ytick',[0 1 2 3],'yticklabel',[0 1 2 3])

axis([-160 150 0 3])

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/EEG_Early_AbsLinearDistS_Space_allsubj')


