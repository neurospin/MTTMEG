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
condnames_clust = {'REGfull_SignEVTdistT_Zero'};
condnames    = {'REGfull_SignEVTdistT'};
latency      = [0 1];
graphcolor   = [[1 0.7 0.7];[0 0 0]];
stat_test    = 'T';
chansel      = 'Grads2';
clustnum     = 0;
clusttype    = 'posclust';
timetag      = '20161024142457';

[ch_grads2, cdn_grads2, cdn_clust_grads2, stat_grads2, GDAVG_grads2, GDAVGt_grads2, dist] = prepare_comp_v3(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
condnames_clust = {'REGfull_SignEVSdistS_Zero'};
condnames    = {'REGfull_SignEVSdistS'};
latency      = [0 1];
graphcolor   = [[1 0.7 0.7];[0 0 0]];
stat_test    = 'T';
chansel      = 'Grads2';
clustnum     = 0;
clusttype    = 'posclust';
timetag      = '2016102414316';

[ch_grads2s, cdn_grads2s, cdn_clust_grads2s, stat_grads2s, GDAVG_grads2s, GDAVGt_grads2s, dists] = prepare_comp_v3(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
condnames_clust = {'REGfull_SignEVSdistS_Zero'};
condnames    = {'REGfull_SignEVSdistS'};
latency      = [0 1];
graphcolor   = [[1 0.7 0.7];[0 0 0]];
stat_test    = 'T';
chansel      = 'Grads1';
clustnum     = 0;
clusttype    = 'posclust';
timetag      = '20161024144010';

[ch_grads2s2, cdn_grads2s2, cdn_clust_grads2s2, stat_grads2s2, GDAVG_grads2s2, GDAVGt_grads2s2, dists2] = prepare_comp_v3(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

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
% prepare layout
cfg                           = [];
cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/fieldtrip-20130901/template/layout/NM306mag.lay';
lay                        = ft_prepare_layout(cfg,GDAVG_grads2s{1});
lay.label                = GDAVG_grads2s{1}.label;

%%%%%%%%%%%%%%%%%%%%%%%% prepare plotting layout %%%%%%%%%%%%%%%%%%%%%%%%%%
% select sensor datatype
[Grads1,Grads2,Mags]   = grads_for_layouts('Network');
% prepare layout
cfg                           = [];
cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/fieldtrip-20130901/template/layout/NM306mag.lay';
lay                        = ft_prepare_layout(cfg,GDAVG_grads2s2{1});
lay.label                = GDAVG_grads2s2{1}.label;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
times = sum(stat_magt.prob <= 0.025);
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
times    = sum(stat_magt.prob <= 0.025);
plot(stat_magt.time,times)
[x,y]    = findpeaks(times);
indchan1 = find(stat_magt.prob(:,y(3)) <0.025);
clust1   = find(sum(stat_magt.prob <= 0.025) > 0);

times    = sum(stat_grads2.prob <= 0.025);
plot(stat_grads2.time,times)
[x,y]    = findpeaks(times);
indchan2 = find(stat_grads2.prob(:,y(1)) <0.025);
clust2   = find(sum(stat_grads2.prob <= 0.025) > 0);

times    = sum(stat_grads2.prob <= 0.025);
plot(stat_grads2.time,times)
[x,y]    = findpeaks(times);
indchan3 = find(stat_grads2.prob(:,y(4)) <0.025);
clust3   = find(sum(stat_grads2.prob <= 0.025) > 0);

times    = sum(stat_grads2s.prob <= 0.025);
plot(stat_grads2s.time,times)
[x,y]    = findpeaks(times);
indchan4 = find(stat_grads2s.prob(:,y(3)) <0.025);
clust4   = find(sum(stat_grads2s.prob <= 0.025) > 0);

times    = sum(stat_grads2s2.prob <= 0.025);
plot(stat_grads2s2.time,times)
[x,y]    = findpeaks(times);
indchan5 = find(stat_grads2s2.prob(:,y(2)) <0.025);
clust5   = find(sum(stat_grads2s2.prob <= 0.025) > 0);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 1600 500]);
set(fig,'PaperPosition',[1 1 1600 500])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

% color of each conditions
graphcolor = [[0.25 0    0   ],
              [0.5  0    0   ],
              [0.75 0.05 0.05],
              [1    0.10 0.10],
              [1    0.25 0.25],
              [1    0.50 0.50],
              [1    0.75 0.75],
              [1    0.95 0.95]]  
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
fill([0.444 0.444 0.520 0.520], [-50 50 50 -50],[0.8 0.8 0.8],'edgecolor',[0.8 0.8 0.8]);hold on

% stimulus onsets
line([0 0],[-120 70],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); 
line([1 1],[-120 70],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); 

% zero-amplitude
line([-0.2 1],[0 0],'linestyle','-','linewidth',2,'color','k');hold on

% timecourse
plot(GDAVG_grads2{1}.time,val1,'linewidth',5,'color',graphcolor(1,:));hold on
plot(GDAVG_grads2{1}.time,val2,'linewidth',5,'color',graphcolor(2,:));
plot(GDAVG_grads2{1}.time,val3,'linewidth',5,'color',graphcolor(3,:));
plot(GDAVG_grads2{1}.time,val4,'linewidth',5,'color',graphcolor(4,:));
plot(GDAVG_grads2{1}.time,val5,'linewidth',5,'color',graphcolor(5,:));
plot(GDAVG_grads2{1}.time,val6,'linewidth',5,'color',graphcolor(6,:));
plot(GDAVG_grads2{1}.time,val7,'linewidth',5,'color',graphcolor(7,:));
plot(GDAVG_grads2{1}.time,val8,'linewidth',5,'color',graphcolor(8,:));

set(gca, 'ytick',[-50 0 50],'yticklabel',[-50 0 50],'linewidth',3,'box','off')
axis([-0.2, 1.2, -50,50])

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/signedDistT_cluster')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 1600 1000]);
set(fig,'PaperPosition',[1 1 1600 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

% fmult
fmult = 1e13; % for express in uV
% define axes limit and plot properties
set_axes(-0.2, 1.2, -30,30);

% stimulus onsets
line([0 0],[-120 70],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on
line([1 1],[-120 70],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on

% cluster shade
plot_lin_shade(clust2, 0.025, stat_grads2,'k',10) % significance window

% binning
val1 = (mean(GDAVG_grads2{1}.avg(indchan2,:)*fmult) + mean(GDAVG_grads2{2}.avg(indchan2,:)*fmult) +...
    mean(GDAVG_grads2{3}.avg(indchan2,:)*fmult)+mean(GDAVG_grads2{4}.avg(indchan2,:)*fmult))/4;
val2 = (mean(GDAVG_grads2{5}.avg(indchan2,:)*fmult) + mean(GDAVG_grads2{6}.avg(indchan2,:)*fmult) +...
    mean(GDAVG_grads2{7}.avg(indchan2,:)*fmult)+mean(GDAVG_grads2{8}.avg(indchan2,:)*fmult))/4;
val3 = (mean(GDAVG_grads2{9}.avg(indchan2,:)*fmult) + mean(GDAVG_grads2{10}.avg(indchan2,:)*fmult) +...
    mean(GDAVG_grads2{11}.avg(indchan2,:)*fmult)+mean(GDAVG_grads2{12}.avg(indchan2,:)*fmult))/4;
val4 = (mean(GDAVG_grads2{13}.avg(indchan2,:)*fmult) + mean(GDAVG_grads2{14}.avg(indchan2,:)*fmult) +...
    mean(GDAVG_grads2{15}.avg(indchan2,:)*fmult)+mean(GDAVG_grads2{16}.avg(indchan2,:)*fmult))/4;
val5 = (mean(GDAVG_grads2{17}.avg(indchan2,:)*fmult) + mean(GDAVG_grads2{18}.avg(indchan2,:)*fmult) +...
    mean(GDAVG_grads2{19}.avg(indchan2,:)*fmult)+mean(GDAVG_grads2{20}.avg(indchan2,:)*fmult))/4;
val6 = (mean(GDAVG_grads2{21}.avg(indchan2,:)*fmult) + mean(GDAVG_grads2{22}.avg(indchan2,:)*fmult) +...
    mean(GDAVG_grads2{23}.avg(indchan2,:)*fmult))/3;

% timecourse
plot(GDAVG_grads2{1}.time,val6,'linewidth',8,'color',[0.5 0   0  ]);hold on
plot(GDAVG_grads2{1}.time,val5,'linewidth',8,'color',[0.75 0.05   0.05  ]);hold on
plot(GDAVG_grads2{1}.time,val4,'linewidth',8,'color',[1 0.10   0.10  ]);hold on
plot(GDAVG_grads2{1}.time,val3,'linewidth',8,'color',[1   0.25 0.25]);hold on
plot(GDAVG_grads2{1}.time,val2,'linewidth',8,'color',[1   0.50 0.50]);hold on
plot(GDAVG_grads2{1}.time,val1,'linewidth',8,'color',[1   0.75 0.75]);hold on

set(gca,'linewidth',5,'fontsize',50)

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/signedDistT_cluster_grads2')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 1600 500]);
set(fig,'PaperPosition',[1 1 1600 500])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

% color of each conditions
graphcolor = [[0 0   0.25];
            [0 0   0.5  ];
            [0.05 0.05   0.75  ];
            [0.10 0.10   1 ];
            [0.25   0.25 1];
            [0.25   0.50 1];
            [0.75   0.75 1];
            [0.95   0.95 1]];  

% fmult
fmult = 1e12; 

% binning
val1 = (mean(GDAVG_grads2s{1}.avg(indchan4,:)*fmult) + mean(GDAVG_grads2s{2}.avg(indchan4,:)*fmult) +...
    mean(GDAVG_grads2s{3}.avg(indchan4,:)*fmult))/3;
val2 = (mean(GDAVG_grads2s{4}.avg(indchan4,:)*fmult) + mean(GDAVG_grads2s{5}.avg(indchan4,:)*fmult) +...
    mean(GDAVG_grads2s{6}.avg(indchan4,:)*fmult))/3;
val3 = (mean(GDAVG_grads2s{7}.avg(indchan4,:)*fmult) + mean(GDAVG_grads2s{8}.avg(indchan4,:)*fmult) +...
    mean(GDAVG_grads2s{9}.avg(indchan4,:)*fmult))/3;
val4 = (mean(GDAVG_grads2s{10}.avg(indchan4,:)*fmult) + mean(GDAVG_grads2s{11}.avg(indchan4,:)*fmult) +...
    mean(GDAVG_grads2s{12}.avg(indchan4,:)*fmult))/3;
val5 = (mean(GDAVG_grads2s{13}.avg(indchan4,:)*fmult) + mean(GDAVG_grads2s{14}.avg(indchan4,:)*fmult) +...
    mean(GDAVG_grads2s{15}.avg(indchan4,:)*fmult))/3;
val6 = (mean(GDAVG_grads2s{16}.avg(indchan4,:)*fmult) + mean(GDAVG_grads2s{17}.avg(indchan4,:)*fmult) +...
    mean(GDAVG_grads2s{18}.avg(indchan4,:)*fmult))/3;
val7 = (mean(GDAVG_grads2s{19}.avg(indchan4,:)*fmult) + mean(GDAVG_grads2s{20}.avg(indchan4,:)*fmult) +...
    mean(GDAVG_grads2s{21}.avg(indchan4,:)*fmult))/3;
val8 = (mean(GDAVG_grads2s{22}.avg(indchan4,:)*fmult) + mean(GDAVG_grads2s{23}.avg(indchan4,:)*fmult) + ...
    mean(GDAVG_grads2s{24}.avg(indchan4,:)*fmult)+ mean(GDAVG_grads2s{25}.avg(indchan4,:)*fmult))/4;
% for express in uV

% cluster shadehelp area
fill([0.640 0.640 0.716 0.716], [-50 50 50 -50],[0.8 0.8 0.8],'edgecolor',[0.8 0.8 0.8]);hold on
fill([0.768 0.768 0.860 0.860], [-50 50 50 -50],[0.8 0.8 0.8],'edgecolor',[0.8 0.8 0.8]);hold on
fill([0.880 0.880 0.988 0.988], [-50 50 50 -50],[0.8 0.8 0.8],'edgecolor',[0.8 0.8 0.8]);hold on

% stimulus onsets
line([0 0],[-3 3],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); 
line([1 1],[-3 3],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); 

% zero-amplitude
line([-0.2 1],[0 0],'linestyle','-','linewidth',2,'color','k');hold on

% timecourse
plot(GDAVG_grads2s{1}.time,val1,'linewidth',5,'color',graphcolor(1,:));hold on
plot(GDAVG_grads2s{1}.time,val2,'linewidth',5,'color',graphcolor(2,:));
plot(GDAVG_grads2s{1}.time,val3,'linewidth',5,'color',graphcolor(3,:));
plot(GDAVG_grads2s{1}.time,val4,'linewidth',5,'color',graphcolor(4,:));
plot(GDAVG_grads2s{1}.time,val5,'linewidth',5,'color',graphcolor(5,:));
plot(GDAVG_grads2s{1}.time,val6,'linewidth',5,'color',graphcolor(6,:));
plot(GDAVG_grads2s{1}.time,val7,'linewidth',5,'color',graphcolor(7,:));
plot(GDAVG_grads2s{1}.time,val8,'linewidth',5,'color',graphcolor(8,:));

set(gca, 'ytick',[-2 0 2],'yticklabel',[-2 0 2],'linewidth',3,'box','off')
axis([-0.2, 1.2, -2 2])

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/signedDistT_cluster_grads2_v2')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 1600 1000]);
set(fig,'PaperPosition',[1 1 1600 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

% color of each conditions
col = colormap('hot')
graphcol = []
for i = [8 16 24 32 40 48]
    graphcol = [graphcol;col(i,:)]
end

% fmult
fmult = 1e13; % for express in uV
% define axes limit and plot properties
set_axes(-0.2, 1.2, -40,40);

% stimulus onsets
line([0 0],[-120 70],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on
line([1 1],[-120 70],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on

% cluster shade
cmap = colormap('hot')
cmap_inv = cmap(end:-1:1,:)
plot_lin_shade(clust2, 0.025, stat_grads2,'k',10) % significance window

% binning
val1 = ((GDAVG_grads2{1}.avg(indchan2(1),:)*fmult) + (GDAVG_grads2{2}.avg(indchan2(1),:)*fmult) +...
    (GDAVG_grads2{3}.avg(indchan2(1),:)*fmult)+(GDAVG_grads2{4}.avg(indchan2(1),:)*fmult))/4;
val2 = ((GDAVG_grads2{5}.avg(indchan2(1),:)*fmult) + (GDAVG_grads2{6}.avg(indchan2(1),:)*fmult) +...
    (GDAVG_grads2{7}.avg(indchan2(1),:)*fmult)+(GDAVG_grads2{8}.avg(indchan2(1),:)*fmult))/4;
val3 = ((GDAVG_grads2{9}.avg(indchan2(1),:)*fmult) + (GDAVG_grads2{10}.avg(indchan2(1),:)*fmult) +...
    (GDAVG_grads2{11}.avg(indchan2(1),:)*fmult)+(GDAVG_grads2{12}.avg(indchan2(1),:)*fmult))/4;
val4 = ((GDAVG_grads2{13}.avg(indchan2(1),:)*fmult) + (GDAVG_grads2{14}.avg(indchan2(1),:)*fmult) +...
    (GDAVG_grads2{15}.avg(indchan2(1),:)*fmult)+(GDAVG_grads2{16}.avg(indchan2(1),:)*fmult))/4;
val5 = ((GDAVG_grads2{17}.avg(indchan2(1),:)*fmult) + (GDAVG_grads2{18}.avg(indchan2(1),:)*fmult) +...
    (GDAVG_grads2{19}.avg(indchan2(1),:)*fmult)+(GDAVG_grads2{20}.avg(indchan2(1),:)*fmult))/4;
val6 = ((GDAVG_grads2{21}.avg(indchan2(1),:)*fmult) + (GDAVG_grads2{22}.avg(indchan2(1),:)*fmult) +...
    (GDAVG_grads2{23}.avg(indchan2(1),:)*fmult))/3;

% timecourse
plot(GDAVG_grads2{1}.time,val6,'linewidth',8,'color',[0.5 0   0  ]);hold on
plot(GDAVG_grads2{1}.time,val5,'linewidth',8,'color',[0.75 0.05   0.05  ]);hold on
plot(GDAVG_grads2{1}.time,val4,'linewidth',8,'color',[1 0.10   0.10  ]);hold on
plot(GDAVG_grads2{1}.time,val3,'linewidth',8,'color',[1   0.25 0.25]);hold on
plot(GDAVG_grads2{1}.time,val2,'linewidth',8,'color',[1   0.50 0.50]);hold on
plot(GDAVG_grads2{1}.time,val1,'linewidth',8,'color',[1   0.75 0.75]);hold on

set(gca,'linewidth',5,'fontsize',50)

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/signedDistT_cluster_grads2_bestchan')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 1600 1000]);
set(fig,'PaperPosition',[1 1 1600 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

% fmult
fmult = 1e13; % for express in uV
% define axes limit and plot properties
set_axes(-0.2, 1.2, -20,20)

% stimulus onsets
line([0 0],[-120 70],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on
line([1 1],[-120 70],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on

% cluster shade
plot_lin_shade(clust4, 0.025, stat_grads2s,'k',10) % significance window

% binning
val1 = (mean(GDAVG_grads2s{1}.avg(indchan4,:)*fmult) + mean(GDAVG_grads2s{2}.avg(indchan4,:)*fmult) +...
    mean(GDAVG_grads2s{3}.avg(indchan4,:)*fmult)+mean(GDAVG_grads2s{4}.avg(indchan4,:)*fmult))/4;
val2 = (mean(GDAVG_grads2s{5}.avg(indchan4,:)*fmult) + mean(GDAVG_grads2s{6}.avg(indchan4,:)*fmult) +...
    mean(GDAVG_grads2s{7}.avg(indchan4,:)*fmult)+mean(GDAVG_grads2s{8}.avg(indchan4,:)*fmult))/4;
val3 = (mean(GDAVG_grads2s{9}.avg(indchan4,:)*fmult) + mean(GDAVG_grads2s{10}.avg(indchan4,:)*fmult) +...
    mean(GDAVG_grads2s{11}.avg(indchan4,:)*fmult)+mean(GDAVG_grads2s{12}.avg(indchan4,:)*fmult))/4;
val4 = (mean(GDAVG_grads2s{13}.avg(indchan4,:)*fmult) + mean(GDAVG_grads2s{14}.avg(indchan4,:)*fmult) +...
    mean(GDAVG_grads2s{15}.avg(indchan4,:)*fmult)+mean(GDAVG_grads2s{16}.avg(indchan4,:)*fmult))/4;
val5 = (mean(GDAVG_grads2s{17}.avg(indchan4,:)*fmult) + mean(GDAVG_grads2s{18}.avg(indchan4,:)*fmult) +...
    mean(GDAVG_grads2s{19}.avg(indchan4,:)*fmult)+mean(GDAVG_grads2s{20}.avg(indchan4,:)*fmult))/4;
val6 = (mean(GDAVG_grads2s{21}.avg(indchan4,:)*fmult) + mean(GDAVG_grads2s{22}.avg(indchan4,:)*fmult) +...
    mean(GDAVG_grads2s{23}.avg(indchan4,:)*fmult))/3;

% timecourse
plot(GDAVG_grads2s{1}.time,val6,'linewidth',8,'color',[0 0 0.5  ]);hold on
plot(GDAVG_grads2s{1}.time,val5,'linewidth',8,'color',[0.05 0.05   0.75  ]);hold on
plot(GDAVG_grads2s{1}.time,val4,'linewidth',8,'color',[0.1 0.10   1  ]);hold on
plot(GDAVG_grads2s{1}.time,val3,'linewidth',8,'color',[0.25   0.25 1]);hold on
plot(GDAVG_grads2s{1}.time,val2,'linewidth',8,'color',[0.5   0.50 1]);hold on
plot(GDAVG_grads2s{1}.time,val1,'linewidth',8,'color',[0.75   0.75 1]);hold on

set(gca,'linewidth',5,'fontsize',50)

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/signedDistS_cluster_grads2_v2')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 1600 1000]);
set(fig,'PaperPosition',[1 1 1600 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

% fmult
fmult = 1e13; % for express in uV
% define axes limit and plot properties
set_axes(-0.2, 1.2, -30,20);

% stimulus onsets
line([0 0],[-120 70],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on
line([1 1],[-120 70],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on

% cluster shade
plot_lin_shade(clust4, 0.025, stat_grads2s,'k',10) % significance window

% binning
val1 = ((GDAVG_grads2s{1}.avg(indchan4(1),:)*fmult) + (GDAVG_grads2s{2}.avg(indchan4(1),:)*fmult) +...
    (GDAVG_grads2s{3}.avg(indchan4(1),:)*fmult)+(GDAVG_grads2s{4}.avg(indchan4(1),:)*fmult))/4;
val2 = ((GDAVG_grads2s{5}.avg(indchan4(1),:)*fmult) + (GDAVG_grads2s{6}.avg(indchan4(1),:)*fmult) +...
    (GDAVG_grads2s{7}.avg(indchan4(1),:)*fmult)+(GDAVG_grads2s{8}.avg(indchan4(1),:)*fmult))/4;
val3 = ((GDAVG_grads2s{9}.avg(indchan4(1),:)*fmult) + (GDAVG_grads2s{10}.avg(indchan4(1),:)*fmult) +...
    (GDAVG_grads2s{11}.avg(indchan4(1),:)*fmult)+(GDAVG_grads2s{12}.avg(indchan4(1),:)*fmult))/4;
val4 = ((GDAVG_grads2s{13}.avg(indchan4(1),:)*fmult) + (GDAVG_grads2s{14}.avg(indchan4(1),:)*fmult) +...
    (GDAVG_grads2s{15}.avg(indchan4(1),:)*fmult)+(GDAVG_grads2s{16}.avg(indchan4(1),:)*fmult))/4;
val5 = ((GDAVG_grads2s{17}.avg(indchan4(1),:)*fmult) + (GDAVG_grads2s{18}.avg(indchan4(1),:)*fmult) +...
    (GDAVG_grads2s{19}.avg(indchan4(1),:)*fmult)+(GDAVG_grads2s{20}.avg(indchan4(1),:)*fmult))/4;
val6 = ((GDAVG_grads2s{21}.avg(indchan4(1),:)*fmult) + (GDAVG_grads2s{22}.avg(indchan4(1),:)*fmult) +...
    (GDAVG_grads2s{23}.avg(indchan4(1),:)*fmult))/3;

% timecourse
plot(GDAVG_grads2s{1}.time,val6,'linewidth',8,'color',[0 0 0.5  ]);hold on
plot(GDAVG_grads2s{1}.time,val5,'linewidth',8,'color',[0.05 0.05   0.75  ]);hold on
plot(GDAVG_grads2s{1}.time,val4,'linewidth',8,'color',[0.1 0.10   1  ]);hold on
plot(GDAVG_grads2s{1}.time,val3,'linewidth',8,'color',[0.25   0.25 1]);hold on
plot(GDAVG_grads2s{1}.time,val2,'linewidth',8,'color',[0.5   0.50 1]);hold on
plot(GDAVG_grads2s{1}.time,val1,'linewidth',8,'color',[0.75   0.75 1]);hold on

set(gca,'linewidth',5,'fontsize',50)

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/signedDistS_bestchan_grads2_v2')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 1600 1000]);
set(fig,'PaperPosition',[1 1 1600 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

% fmult
fmult = 1e13; % for express in uV
% define axes limit and plot properties
set_axes(-0.2, 1.2, -5,5)

% stimulus onsets
line([0 0],[-120 70],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on
line([1 1],[-120 70],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on

% cluster shade
plot_lin_shade(clust5, 0.025, stat_grads2s2,'k',4) % significance window

% binning
val1 = (mean(GDAVG_grads2s2{1}.avg(indchan5,:)*fmult) + mean(GDAVG_grads2s2{2}.avg(indchan5,:)*fmult) +...
    mean(GDAVG_grads2s2{3}.avg(indchan5,:)*fmult)+mean(GDAVG_grads2s2{4}.avg(indchan5,:)*fmult))/4;
val2 = (mean(GDAVG_grads2s2{5}.avg(indchan5,:)*fmult) + mean(GDAVG_grads2s2{6}.avg(indchan5,:)*fmult) +...
    mean(GDAVG_grads2s2{7}.avg(indchan5,:)*fmult)+mean(GDAVG_grads2s2{8}.avg(indchan5,:)*fmult))/4;
val3 = (mean(GDAVG_grads2s2{9}.avg(indchan5,:)*fmult) + mean(GDAVG_grads2s2{10}.avg(indchan5,:)*fmult) +...
    mean(GDAVG_grads2s2{11}.avg(indchan5,:)*fmult)+mean(GDAVG_grads2s2{12}.avg(indchan5,:)*fmult))/4;
val4 = (mean(GDAVG_grads2s2{13}.avg(indchan5,:)*fmult) + mean(GDAVG_grads2s2{14}.avg(indchan5,:)*fmult) +...
    mean(GDAVG_grads2s2{15}.avg(indchan5,:)*fmult)+mean(GDAVG_grads2s2{16}.avg(indchan5,:)*fmult))/4;
val5 = (mean(GDAVG_grads2s2{17}.avg(indchan5,:)*fmult) + mean(GDAVG_grads2s2{18}.avg(indchan5,:)*fmult) +...
    mean(GDAVG_grads2s2{19}.avg(indchan5,:)*fmult)+mean(GDAVG_grads2s2{20}.avg(indchan5,:)*fmult))/4;
val6 = (mean(GDAVG_grads2s2{21}.avg(indchan5,:)*fmult) + mean(GDAVG_grads2s2{22}.avg(indchan5,:)*fmult) +...
    mean(GDAVG_grads2s2{23}.avg(indchan5,:)*fmult))/3;

% timecourse
plot(GDAVG_grads2s{1}.time,val6,'linewidth',8,'color',[0 0 0.5  ]);hold on
plot(GDAVG_grads2s{1}.time,val5,'linewidth',8,'color',[0.05 0.05   0.75  ]);hold on
plot(GDAVG_grads2s{1}.time,val4,'linewidth',8,'color',[0.1 0.10   1  ]);hold on
plot(GDAVG_grads2s{1}.time,val3,'linewidth',8,'color',[0.25   0.25 1]);hold on
plot(GDAVG_grads2s{1}.time,val2,'linewidth',8,'color',[0.5   0.50 1]);hold on
plot(GDAVG_grads2s{1}.time,val1,'linewidth',8,'color',[0.75   0.75 1]);hold on

set(gca,'linewidth',5,'fontsize',50)

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/signedDistS_cluster_grads1_v2')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 400 400]);
set(fig,'PaperPosition',[1 1 400 400])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

[Grads1,Grads2,Mags]   = grads_for_layouts('Network');
% prepare layout
cfg                           = [];
cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/fieldtrip-20130901/template/layout/NM306mag.lay';
lay                        = ft_prepare_layout(cfg,GDAVG_magt{1});
lay.label                = GDAVG_magt{1}.label;

index = y(3)

cmap = colormap('gray')
cmap = cmap(end:-1:1,:)
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat_magt.time(index) stat_magt.time(index)];
cfg.zlim               = [-4 4]; % F-values
cfg.colormap           = cmap;
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
cfg.highlight          = {'on'};
cfg.highlightchannel   = {stat_magt.label(indchan1)};
cfg.highlightsymbol    = {'.'};
cfg.highlightsize      = {24} ;
cfg.highlightcolor     = {'k'};
cfg.comment            = num2str(stat_magt.time(index));
ft_topoplotER(cfg,stat_magt);
colorbar

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/Mags_SignDistT_topo')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 400 400]);
set(fig,'PaperPosition',[1 1 400 400])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

[Grads1,Grads2,Mags]   = grads_for_layouts('Network');
% prepare layout
cfg                           = [];
cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/fieldtrip-20130901/template/layout/NM306mag.lay';
lay                        = ft_prepare_layout(cfg,GDAVG_grads2{1});
lay.label                = GDAVG_grads2{1}.label;

index = y(3)

cmap = colormap('gray')
cmap = cmap(end:-1:1,:)
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat_grads2.time(index) stat_grads2.time(index)];
cfg.zlim               = [-4 4]; % F-values
cfg.colormap           = cmap;
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
cfg.highlight          = {'on'};
cfg.highlightchannel   = {stat_grads2.label(indchan2)};
cfg.highlightsymbol    = {'.'};
cfg.highlightsize      = {24} ;
cfg.highlightcolor     = {'w'};
cfg.comment            = num2str(stat_grads2.time(index));
ft_topoplotER(cfg,stat_grads2);
colorbar

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/Grads2_SignDistT_topo')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 400 400]);
set(fig,'PaperPosition',[1 1 400 400])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

[Grads1,Grads2,Mags]   = grads_for_layouts('Network');
% prepare layout
cfg                           = [];
cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/fieldtrip-20130901/template/layout/NM306mag.lay';
lay                        = ft_prepare_layout(cfg,GDAVG_grads2{1});
lay.label                = GDAVG_grads2{1}.label;

index = y(4)

cmap = colormap('gray')
cmap = cmap(end:-1:1,:)
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat_grads2.time(index) stat_grads2.time(index)];
cfg.zlim               = [-4 4]; % F-values
cfg.colormap           = cmap;
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
cfg.highlight          = {'on'};
cfg.highlightchannel   = {stat_grads2.label(indchan3)};
cfg.highlightsymbol    = {'.'};
cfg.highlightsize      = {24} ;
cfg.highlightcolor     = {'w'};
cfg.comment            = num2str(stat_grads2.time(index));
ft_topoplotER(cfg,stat_grads2);
colorbar

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/Grads2_SignDistT_topo2')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 400 400]);
set(fig,'PaperPosition',[1 1 400 400])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

[Grads1,Grads2,Mags]   = grads_for_layouts('Network');
% prepare layout
cfg                           = [];
cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/fieldtrip-20130901/template/layout/NM306mag.lay';
lay                        = ft_prepare_layout(cfg,GDAVG_grads2s{1});
lay.label                = GDAVG_grads2s{1}.label;

index = y(3)

cmap = colormap('gray')
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat_grads2s.time(index) stat_grads2s.time(index)];
cfg.zlim               = [-4 4]; % F-values
cfg.colormap           = cmap;
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
cfg.highlight          = {'on'};
cfg.highlightchannel   = {stat_grads2s.label(indchan4)};
cfg.highlightsymbol    = {'.'};
cfg.highlightsize      = {24} ;
cfg.highlightcolor     = {'w'};
cfg.comment            = num2str(stat_grads2s.time(index));
ft_topoplotER(cfg,stat_grads2s);
colorbar

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/Grads2_SignDistT_topo')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 400 400]);
set(fig,'PaperPosition',[1 1 400 400])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

[Grads1,Grads2,Mags]   = grads_for_layouts('Network');
% prepare layout
cfg                           = [];
cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/fieldtrip-20130901/template/layout/NM306mag.lay';
lay                        = ft_prepare_layout(cfg,GDAVG_grads2s{1});
lay.label                = GDAVG_grads2s{1}.label;

index = y(4)

cmap = colormap('gray')
cmap = cmap(end:-1:1,:)
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat_grads2s.time(index) stat_grads2s.time(index)];
cfg.zlim               = [-4 4]; % F-values
cfg.colormap           = cmap;
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
cfg.highlight          = {'on'};
cfg.highlightchannel   = {stat_grads2s.label(indchan4)};
cfg.highlightsymbol    = {'.'};
cfg.highlightsize      = {24} ;
cfg.highlightcolor     = {'w'};
cfg.comment            = num2str(stat_grads2s.time(index));
ft_topoplotER(cfg,stat_grads2s);
colorbar

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/Grads2_SignDistS_topo')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plots 1 sensor
mask = (stat_magt.mask.*(repmat((sum(stat_grads2.mask)>0),102,1)));
[x1,y1] = find(sum(mask>0))
[x2,y2] = find(sum(mask>0,2))

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
    D(i) = mean(mean(tmp_gdavg{i}.avg(x2',y1)))*1e15;
end


fig = figure('position',[1 1 800 800]);
set(fig,'PaperPosition',[1 1 800 800])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

line([-30 30],[0 0],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5]);hold on
line([0 0],[-40 40],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5])

for i = 1:length(GDAVG_magt)
   plot(dist(i),D(i),'color', 'r','marker','.','markersize',80);hold on
end

p = [];
p = polyfit(dist,D,1)
yy = polyval(p,[-40 40])

plot([-40 40],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',15); hold on

set(gca, 'box','off','linewidth',3,'fontsize',40,'fontweight','b');
set(gca,'ytick',[-20 0 20 40],'yticklabel',[-20 0 20 40])

axis([-35 35 -30 40])

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/Mags_Early_SignedLinearDistT_Time_allsubj')

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

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/Grads_Early_SignedLinearDistT_Time_allsubj')

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

