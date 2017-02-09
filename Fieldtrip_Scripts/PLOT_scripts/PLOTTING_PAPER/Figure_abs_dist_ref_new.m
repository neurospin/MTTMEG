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
condnames = {'MagsPas1_Pas2_Pas3_Pas4_Pas5_Pas6_Pas7_Pas8_Pas9_Pas10_Pas11_Pas12_Pas13_Pas14_Pas15_Pas16_Pas17_Pas18_Pas19_alias_'};
latency      = [0 1];
chansel = 'Mags'
[chm_pa, cdnm_pa, GDAVGm_pa, GDAVGtm_pa] = prepare_comp_v5(niplist,condnames{1}, latency, chansel)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
condnames = {'EEGW1_W2_W3_W4_W5_W6_W7_W8_W9_W10_W11_W12_W13_W14_W15_W16_W17_W18_W19_W20_W21_W22_W23_W24_E1_E2_E3_E4_E5_E6__alias_'};
latency      = [0 1];
chansel = 'EEG'
[chm_w, cdnm_w, GDAVGm_w, GDAVGtm_w] = prepare_comp_v5(niplist,condnames{1}, latency, chansel)

%%%%%%%%%%%%%%%%%%%%%%%% prepare plotting layout %%%%%%%%%%%%%%%%%%%%%%%%%%
% select sensor datatype
[Grads1,Grads2,Mags]   = grads_for_layouts('Network');
% prepare layout
cfg                           = [];
cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/fieldtrip-20130901/template/layout/NM306mag.lay';
lay                        = ft_prepare_layout(cfg,GDAVG_magt{1});
lay.label                = GDAVG_magt{1}.label;

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
% select two subclusters
mask1 = [zeros(40,251) ; ones(62,251)];
mask2 = [ones(40,251); zeros(62,251)];
times1    = sum((stat_magt.prob <= 0.025).*(mask1));
times2    = sum((stat_magt.prob <= 0.025).*(mask2));
[x1,y1]    = findpeaks(times1);
[x2,y2]    = findpeaks(times2);
indchan1 = find(stat_magt.prob(:,y1(1)) <0.025);
indchan2 = find(stat_magt.prob(:,y2(3)) <0.025);
clust1   = find(sum(stat_magt.prob <= 0.025) > 0);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 1600 1000]);
set(fig,'PaperPosition',[1 1 1600 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

% stimulus onsets
line([0 0],[-12 7],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on
line([1 1],[-12 7],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on

fmult = 1e15

val1 = mean(GDAVGm{1}.avg(indchan2,:)*fmult) 
val2 = mean(GDAVGm{2}.avg(indchan2,:)*fmult) 
val3 = mean(GDAVGm{3}.avg(indchan2,:)*fmult)
val4 = mean(GDAVGm{4}.avg(indchan2,:)*fmult)

plot_lin_shade(clust1, 0.025, stat_magt,'k',40);hold on % significance window

% timecourse
plot(GDAVGm{1}.time,val1,'linewidth',8,'color',[1 0.8 0.8]) ;hold on
plot(GDAVGm{1}.time,val2,'linewidth',8,'color',[1 0.5 0.5]) ;hold on
plot(GDAVGm{1}.time,val3,'linewidth',8,'color',[1 0.3 0.3]) ;hold on
plot(GDAVGm{1}.time,val4,'linewidth',8,'color',[0.9 0 0]) ;hold on

set(gca,'box','off','linewidth',4,'fontsize',40,'fontweight','b')
set(gca,'ytick',[-50  0 50],'yticklabel',[-50 0 50])
axis([-0.2 1.2 -50 50])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mask = (stat_magt.mask);
[x1,y1] = find(sum(mask>0))
[x2,y2] = find(sum(mask>0,2))

% rephase time of data and test
cfg = []; cfg.toilim = [stat_magt.time(1) stat_magt.time(end)];
for i = 1:length(GDAVGm_pa)
    tmp_gdavgm{i} = ft_redefinetrial(cfg,GDAVGm_pa{i})
end

%% PAST
fig = figure('position',[1 1 1400 1000]);
set(fig,'PaperPosition',[1 1 1400 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

subplot(2,3,1)
% full range
D = [];
for i = 1:length(GDAVGm_pa)
    D(i) = mean(mean(tmp_gdavgm{i}.avg(x2',y1)))*1e15;
end

distpa = abs([-13   -12   -10   -14   -15   -11 ...
    -1    -3    -2    -4    -2    -7 ...
     3     1     3     4     8     7 ...
    11    14    12    11    13    12]);

line([0 30],[0 0],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5]);hold on
line([0 0],[-50 50],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5])

plot(distpa,D(1:24),'color', 'r','marker','.','markersize',40,'linestyle','none');hold on

p = [];
p = polyfit(distpa,D(1:24),1)
yy = polyval(p,[0 30])
plot([0 30],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on

[r,p] = corrcoef(distpa,D(1:24))
text(2,-40,['R = ' num2str(r(2))]); 
text(2,-45,['p = ' num2str(p(2))]);

set(gca, 'box','off','linewidth',3,'fontsize',25,'fontweight','b');
axis([0 30 -50 50])

title('PAST')

%% FUTURE
subplot(2,3,3)

% full range
D = [];
for i = 1:length(GDAVGm_pa)
    D(i) = mean(mean(tmp_gdavgm{i}.avg(x2',y1)))*1e15;
end

distfu =  abs([-15   -17   -15   -14   -10   -11 ...
    -7    -4    -6    -7    -5    -6 ...
     2     8     3     2     4     8 ...
    18    10    13    12    14    16]) 

line([0 30],[0 0],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5]);hold on
line([0 0],[-50 50],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5])

plot(distfu,D(25:48),'color', 'r','marker','.','markersize',40,'linestyle','none');hold on

p = [];
p = polyfit(distfu,D(25:48),1)
yy = polyval(p,[0 30])
plot([0 30],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on

[r,p] = corrcoef(distfu,D(25:48))
text(2,-40,['R = ' num2str(r(2))]); 
text(2,-45,['p = ' num2str(p(2))]);

set(gca, 'box','off','linewidth',3,'fontsize',25,'fontweight','b');
axis([0 30 -50 50])

title('FUTURE')

%% PRESENT
subplot(2,3,2)

% full range
D = [];
for i = 1:length(GDAVGm_pa)
    D(i) = mean(mean(tmp_gdavgm{i}.avg(x2',y1)))*1e15;
end

distpre =  abs([   -22   -21   -19   -23   -24   -20 ...
   -10   -12   -11   -13   -11   -16 ...
    -6    -8    -6    -5    -1    -2 ...
     2     5     3     2     4     3 ...
    11    17    12    11    13    17 ...
    27    19    22    21    23    25])

line([0 30],[0 0],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5]);hold on
line([0 0],[-50 50],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5])

plot(distpre,D(49:84),'color', 'r','marker','.','markersize',40,'linestyle','none');hold on

p = [];
p = polyfit(distpre,D(49:84),1)
yy = polyval(p,[0 30])
plot([0 30],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on

[r,p] = corrcoef(distpre,D(49:84))
text(2,-40,['R = ' num2str(r(2))]); 
text(2,-45,['p = ' num2str(p(2))]);

set(gca, 'box','off','linewidth',3,'fontsize',25,'fontweight','b');
axis([0 30 -50 50])

title('PRESENT')

%% West
subplot(2,3,4)

% full range
D = [];
for i = 1:length(GDAVGm_pa)
    D(i) = mean(mean(tmp_gdavgm{i}.avg(x2',y1)))*1e15;
end

distw =  abs([   -22   -10    -6     2    11    27 ...
   -21   -12    -8     5    17    19 ...
   -19   -11    -6     3    12    22 ...
   -23   -13    -5     2    11    21]);

line([0 30],[0 0],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5]);hold on
line([0 0],[-50 50],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5])

plot(distw,D(85:108),'color', 'r','marker','.','markersize',40,'linestyle','none');hold on

p = [];
p = polyfit(distw,D(85:108),1)
yy = polyval(p,[0 30])
plot([0 30],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on

[r,p] = corrcoef(distw,D(85:108))
text(2,-40,['R = ' num2str(r(2))]); 
text(2,-45,['p = ' num2str(p(2))]);

set(gca, 'box','off','linewidth',3,'fontsize',25,'fontweight','b');
axis([0 30 -50 50])

title('CAYENNE')

%% East
subplot(2,3,5)

% full range
D = [];
for i = 1:length(GDAVGm_pa)
    D(i) = mean(mean(tmp_gdavgm{i}.avg(x2',y1)))*1e15;
end

diste =  abs([   -19   -11    -6     3    12    22 ...
   -23   -13    -5     2    11    21 ...
   -24   -11    -1     4    13    23 ...
   -20   -16    -2     3    17    25]);

line([0 30],[0 0],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5]);hold on
line([0 0],[-50 50],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5])

plot(diste,D(109:132),'color', 'r','marker','.','markersize',40,'linestyle','none');hold on

p = [];
p = polyfit(diste,D(109:132),1)
yy = polyval(p,[0 30])
plot([0 30],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on

[r,p] = corrcoef(diste,D(109:132))
text(2,-40,['R = ' num2str(r(2))]); 
text(2,-45,['p = ' num2str(p(2))]);

set(gca, 'box','off','linewidth',3,'fontsize',25,'fontweight','b');
axis([0 30 -50 50])

title('EAST')

%% ALL REFs
subplot(2,3,6)

% full range
D = [];
for i = 1:length(GDAVGm_pa)
    D(i) = mean(mean(tmp_gdavgm{i}.avg(x2',y1)))*1e15;
end

line([0 30],[0 0],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5]);hold on
line([0 0],[-50 50],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5])

plot([distpa distfu distpre distw diste],D,'color', 'r','marker','.','markersize',40,'linestyle','none');hold on

p = [];
p = polyfit([distpa distfu distpre distw diste],D,1)
yy = polyval(p,[0 30])
plot([0 30],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on

[r,p] = corrcoef([distpa distfu distpre distw diste],D)
text(2,-40,['R = ' num2str(r(2))]); 
text(2,-45,['p = ' num2str(p(2))]);

set(gca, 'box','off','linewidth',3,'fontsize',25,'fontweight','b');
axis([0 30 -50 50])

title('ALL REFs')

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/fullrange_absdistT_perRef_mags_fullclust')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mask = (stat_magt.mask);
[x1,y1] = find(sum(mask>0))
[x2,y2] = find(sum(mask>0,2))

% rephase time of data and test
cfg = []; cfg.toilim = [stat_magt.time(1) stat_magt.time(end)];
for i = 1:length(GDAVGm_pa)
    tmp_gdavgm{i} = ft_redefinetrial(cfg,GDAVGm_pa{i})
end

%% PAST
fig = figure('position',[1 1 1400 1000]);
set(fig,'PaperPosition',[1 1 1400 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

subplot(2,3,1)
% full range
D = [];
for i = 1:length(GDAVGm_pa)
    D(i) = mean(mean(tmp_gdavgm{i}.avg(x2',y1)))*1e15;
end

distpa = ([-13   -12   -10   -14   -15   -11 ...
    -1    -3    -2    -4    -2    -7 ...
     3     1     3     4     8     7 ...
    11    14    12    11    13    12]);

line([-30 30],[0 0],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5]);hold on
line([0 0],[-50 50],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5])

plot(distpa,D(1:24),'color', 'r','marker','.','markersize',40,'linestyle','none');hold on

p = [];
p = polyfit(distpa(1:12),D(1:12),1)
yy = [];yy = polyval(p,[-30 0])
plot([-30 0],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on
p = [];
p = polyfit(distpa(13:24),D(13:24),1)
yy = [];yy = polyval(p,[0 30])
plot([0 30],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on

[r,p] = corrcoef(distpa,D(1:24))
text(2,-40,['R = ' num2str(r(2))]); 
text(2,-45,['p = ' num2str(p(2))]);
[r,p] = corrcoef(distpa(1:12),D(1:12))
text(-28,-40,['R = ' num2str(r(2))]); 
text(-28,-45,['p = ' num2str(p(2))]);

set(gca, 'box','off','linewidth',3,'fontsize',25,'fontweight','b');
axis([-30 30 -50 50])

title('PAST')

%% FUTURE
subplot(2,3,3)

% full range
D = [];
for i = 1:length(GDAVGm_pa)
    D(i) = mean(mean(tmp_gdavgm{i}.avg(x2',y1)))*1e15;
end

distfu =  ([-15   -17   -15   -14   -10   -11 ...
    -7    -4    -6    -7    -5    -6 ...
     2     8     3     2     4     8 ...
    18    10    13    12    14    16]) 

line([-30 30],[0 0],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5]);hold on
line([0 0],[-50 50],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5])

plot(distfu,D(25:48),'color', 'r','marker','.','markersize',40,'linestyle','none');hold on

p = [];
p = polyfit(distfu(1:12),D(25:36),1)
yy = [];yy = polyval(p,[-30 0])
plot([-30 0],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on
p = [];
p = polyfit(distfu(13:24),D(37:48),1)
yy = [];yy = polyval(p,[0 30])
plot([0 30],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on

[r,p] = corrcoef(distfu(13:24),D(37:48))
text(2,-40,['R = ' num2str(r(2))]); 
text(2,-45,['p = ' num2str(p(2))]);
[r,p] = corrcoef(distfu(1:12),D(25:36))
text(-28,-40,['R = ' num2str(r(2))]); 
text(-28,-45,['p = ' num2str(p(2))]);

set(gca, 'box','off','linewidth',3,'fontsize',25,'fontweight','b');
axis([-30 30 -50 50])

title('FUTURE')

%% PRESENT
subplot(2,3,2)

% full range
D = [];
for i = 1:length(GDAVGm_pa)
    D(i) = mean(mean(tmp_gdavgm{i}.avg(x2',y1)))*1e15;
end

distpre =  ([   -22   -21   -19   -23   -24   -20 ...
   -10   -12   -11   -13   -11   -16 ...
    -6    -8    -6    -5    -1    -2 ...
     2     5     3     2     4     3 ...
    11    17    12    11    13    17 ...
    27    19    22    21    23    25])

line([-30 30],[0 0],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5]);hold on
line([0 0],[-50 50],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5])

plot(distpre,D(49:84),'color', 'r','marker','.','markersize',40,'linestyle','none');hold on

p = [];
p = polyfit(distpre(1:18),D(49:66),1)
yy = polyval(p,[-30 0])
plot([-30 0],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on
p = [];
p = polyfit(distpre(19:36),D(67:84),1)
yy = polyval(p,[0 30])
plot([0 30],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on

[r,p] = corrcoef(distpre(19:36),D(67:84))
text(2,-40,['R = ' num2str(r(2))]); 
text(2,-45,['p = ' num2str(p(2))]);
[r,p] = corrcoef(distpre(1:18),D(49:66))
text(-28,-40,['R = ' num2str(r(2))]); 
text(-28,-45,['p = ' num2str(p(2))]);

set(gca, 'box','off','linewidth',3,'fontsize',25,'fontweight','b');
axis([-30 30 -50 50])

title('PRESENT')

%% West
subplot(2,3,4)

% full range
D = [];
for i = 1:length(GDAVGm_pa)
    D(i) = mean(mean(tmp_gdavgm{i}.avg(x2',y1)))*1e15;
end

distw =  ([   -22   -10    -6     2    11    27 ...
   -21   -12    -8     5    17    19 ...
   -19   -11    -6     3    12    22 ...
   -23   -13    -5     2    11    21]);

line([-30 30],[0 0],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5]);hold on
line([0 0],[-50 50],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5])

plot(distw,D(85:108),'color', 'r','marker','.','markersize',40,'linestyle','none');hold on

p = [];
p = polyfit(distw([1:3 7:9 13:15 19:21]),D([1:3 7:9 13:15 19:21]+ones(1,12)*84),1)
yy = polyval(p,[-30 0])
plot([-30 0],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on
p = [];
p = polyfit(distw([1:3 7:9 13:15 19:21]+ones(1,12)*3),D([1:3 7:9 13:15 19:21]+ones(1,12)*87),1)
yy = polyval(p,[0 30])
plot([0 30],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on

[r,p] = corrcoef(distw([1:3 7:9 13:15 19:21]),D([1:3 7:9 13:15 19:21]+ones(1,12)*84))
text(2,-40,['R = ' num2str(r(2))]); 
text(2,-45,['p = ' num2str(p(2))]);
[r,p] = corrcoef(distw([1:3 7:9 13:15 19:21]+ones(1,12)*3),D([1:3 7:9 13:15 19:21]+ones(1,12)*87))
text(-28,-40,['R = ' num2str(r(2))]); 
text(-28,-45,['p = ' num2str(p(2))]);

set(gca, 'box','off','linewidth',3,'fontsize',25,'fontweight','b');
axis([-30 30 -50 50])

title('CAYENNE')

%% East
subplot(2,3,5)

% full range
D = [];
for i = 1:length(GDAVGm_pa)
    D(i) = mean(mean(tmp_gdavgm{i}.avg(x2',y1)))*1e15;
end

diste = ([   -19   -11    -6     3    12    22 ...
   -23   -13    -5     2    11    21 ...
   -24   -11    -1     4    13    23 ...
   -20   -16    -2     3    17    25]);

line([-30 30],[0 0],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5]);hold on
line([0 0],[-50 50],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5])

plot(diste,D(109:132),'color', 'r','marker','.','markersize',40,'linestyle','none');hold on

p = [];
p = polyfit(diste([1:3 7:9 13:15 19:21]),D([1:3 7:9 13:15 19:21]+ones(1,12)*108),1)
yy = polyval(p,[-30 0])
plot([-30 0],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on
p = [];
p = polyfit(diste([1:3 7:9 13:15 19:21]+ones(1,12)*3),D([1:3 7:9 13:15 19:21]+ones(1,12)*111),1)
yy = polyval(p,[0 30])
plot([0 30],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on

[r,p] = corrcoef(diste([1:3 7:9 13:15 19:21]),D([1:3 7:9 13:15 19:21]+ones(1,12)*108))
text(2,-40,['R = ' num2str(r(2))]); 
text(2,-45,['p = ' num2str(p(2))]);
[r,p] = corrcoef(diste([1:3 7:9 13:15 19:21]+ones(1,12)*3),D([1:3 7:9 13:15 19:21]+ones(1,12)*111))
text(-28,-40,['R = ' num2str(r(2))]); 
text(-28,-45,['p = ' num2str(p(2))]);

set(gca, 'box','off','linewidth',3,'fontsize',25,'fontweight','b');
axis([-30 30 -50 50])

title('DUBAI')

%% ALL REFs
subplot(2,3,6)

% full range
D = [];
for i = 1:length(GDAVGm_pa)
    D(i) = mean(mean(tmp_gdavgm{i}.avg(x2',y1)))*1e15;
end

line([0 30],[0 0],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5]);hold on
line([0 0],[-50 50],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5])

plot([distpa distfu distpre distw diste],D,'color', 'r','marker','.','markersize',40,'linestyle','none');hold on

p = [];
p = polyfit([distpa(1:12) distfu(1:12) distpre(1:18) ...
    distw([1:3 7:9 13:15 19:21]) diste([1:3 7:9 13:15 19:21])],...
    D([[1:12 25:36 49:66] [[1:3 7:9 13:15 19:21] + ones(1,12)*84] ...
    [[1:3 7:9 13:15 19:21] + ones(1,12)*108]]),1)
yy = polyval(p,[-30 0])
plot([-30 0],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on
p = [];
p = polyfit([distpa(13:24) distfu(13:24) distpre(19:36) ...
    distw([1:3 7:9 13:15 19:21]+ones(1,12)*3) diste([1:3 7:9 13:15 19:21]+ones(1,12)*3)],...
    D([[13:24 37:48 67:84] [[1:3 7:9 13:15 19:21] + ones(1,12)*87] ...
    [[1:3 7:9 13:15 19:21] + ones(1,12)*111]]),1)
yy = polyval(p,[0 30])
plot([0 30],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on

[r,p] = corrcoef([distpa(1:12) distfu(1:12) distpre(1:18) ...
    distw([1:3 7:9 13:15 19:21]) diste([1:3 7:9 13:15 19:21])],...
    D([[1:12 25:36 49:66] [[1:3 7:9 13:15 19:21] + ones(1,12)*84] ...
    [[1:3 7:9 13:15 19:21] + ones(1,12)*108]]))
text(-28,-40,['R = ' num2str(r(2))]); 
text(-28,-45,['p = ' num2str(p(2))]);
[r,p] = corrcoef([distpa(13:24) distfu(13:24) distpre(19:36) ...
    distw([1:3 7:9 13:15 19:21]+ones(1,12)*3) diste([1:3 7:9 13:15 19:21]+ones(1,12)*3)],...
    D([[13:24 37:48 67:84] [[1:3 7:9 13:15 19:21] + ones(1,12)*87] ...
    [[1:3 7:9 13:15 19:21] + ones(1,12)*111]]))
text(2,-40,['R = ' num2str(r(2))]); 
text(2,-45,['p = ' num2str(p(2))]);

set(gca, 'box','off','linewidth',3,'fontsize',25,'fontweight','b');
axis([-30 30 -50 50])

title('ALL REFs')

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/fullrange_splitabsdistT_perRef_mags_fullclust')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mask = (stat_magt.mask.*(repmat((sum(stat_grads2.mask)>0),102,1)));
% mask = (stat_magt.mask);
[x1,y1] = find(sum(mask>0))
[x2,y2] = find(sum(mask>0,2))

% rephase time of data and test
cfg = []; cfg.toilim = [stat_magt.time(1) stat_magt.time(end)];
for i = 1:length(GDAVGm_pa)
    tmp_gdavgm{i} = ft_redefinetrial(cfg,GDAVGm_pa{i})
end

%% PAST
fig = figure('position',[1 1 1400 1000]);
set(fig,'PaperPosition',[1 1 1400 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

subplot(2,3,1)
% full range
D = [];
for i = 1:length(GDAVGm_pa)
    D(i) = mean(mean(tmp_gdavgm{i}.avg(x2',y1)))*1e15;
end

distpa = [-13   -12   -10   -14   -15   -11 ...
    -1    -3    -2    -4    -2    -7 ...
     3     1     3     4     8     7 ...
    11    14    12    11    13    12];

line([0 30],[0 0],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5]);hold on
line([0 0],[-50 50],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5])

plot(distpa,D(1:24),'color', 'r','marker','.','markersize',40,'linestyle','none');hold on

p = [];
p = polyfit(distpa,D(1:24),1)
yy = polyval(p,[0 30])
plot([0 30],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on

[r,p] = corrcoef(distpa,D(1:24))
text(2,-40,['R = ' num2str(r(2))]); 
text(2,-45,['p = ' num2str(p(2))]);

set(gca, 'box','off','linewidth',3,'fontsize',25,'fontweight','b');
axis([0 30 -50 50])

title('PAST')

%% FUTURE
subplot(2,3,3)

% full range
D = [];
for i = 1:length(GDAVGm_pa)
    D(i) = mean(mean(tmp_gdavgm{i}.avg(x2',y1)))*1e15;
end

distfu =  [-15   -17   -15   -14   -10   -11 ...
    -7    -4    -6    -7    -5    -6 ...
     2     8     3     2     4     8 ...
    18    10    13    12    14    16] 

line([0 30],[0 0],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5]);hold on
line([0 0],[-50 50],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5])

plot(distfu,D(25:48),'color', 'r','marker','.','markersize',40,'linestyle','none');hold on

p = [];
p = polyfit(distfu,D(25:48),1)
yy = polyval(p,[0 30])
plot([0 30],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on

[r,p] = corrcoef(distfu,D(25:48))
text(2,-40,['R = ' num2str(r(2))]); 
text(2,-45,['p = ' num2str(p(2))]);

set(gca, 'box','off','linewidth',3,'fontsize',25,'fontweight','b');
axis([0 30 -50 50])

title('FUTURE')

%% PRESENT
subplot(2,3,2)

% full range
D = [];
for i = 1:length(GDAVGm_pa)
    D(i) = mean(mean(tmp_gdavgm{i}.avg(x2',y1)))*1e15;
end

distpre =  [   -22   -21   -19   -23   -24   -20 ...
   -10   -12   -11   -13   -11   -16 ...
    -6    -8    -6    -5    -1    -2 ...
     2     5     3     2     4     3 ...
    11    17    12    11    13    17 ...
    27    19    22    21    23    25]

line([0 30],[0 0],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5]);hold on
line([0 0],[-50 50],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5])

plot(distpre,D(49:84),'color', 'r','marker','.','markersize',40,'linestyle','none');hold on

p = [];
p = polyfit(distpre,D(49:84),1)
yy = polyval(p,[0 30])
plot([0 30],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on

[r,p] = corrcoef(distpre,D(49:84))
text(2,-40,['R = ' num2str(r(2))]); 
text(2,-45,['p = ' num2str(p(2))]);

set(gca, 'box','off','linewidth',3,'fontsize',25,'fontweight','b');
axis([0 30 -50 50])

title('PRESENT')

%% West
subplot(2,3,4)

% full range
D = [];
for i = 1:length(GDAVGm_pa)
    D(i) = mean(mean(tmp_gdavgm{i}.avg(x2',y1)))*1e15;
end

distw =  [   -22   -10    -6     2    11    27 ...
   -21   -12    -8     5    17    19 ...
   -19   -11    -6     3    12    22 ...
   -23   -13    -5     2    11    21];

line([0 30],[0 0],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5]);hold on
line([0 0],[-50 50],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5])

plot(distw,D(85:108),'color', 'r','marker','.','markersize',40,'linestyle','none');hold on

p = [];
p = polyfit(distw,D(85:108),1)
yy = polyval(p,[0 30])
plot([0 30],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on

[r,p] = corrcoef(distw,D(85:108))
text(2,-40,['R = ' num2str(r(2))]); 
text(2,-45,['p = ' num2str(p(2))]);

set(gca, 'box','off','linewidth',3,'fontsize',25,'fontweight','b');
axis([0 30 -50 50])

title('CAYENNE')

%% East
subplot(2,3,5)

% full range
D = [];
for i = 1:length(GDAVGm_pa)
    D(i) = mean(mean(tmp_gdavgm{i}.avg(x2',y1)))*1e15;
end

diste =  [   -19   -11    -6     3    12    22 ...
   -23   -13    -5     2    11    21 ...
   -24   -11    -1     4    13    23 ...
   -20   -16    -2     3    17    25];

line([0 30],[0 0],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5]);hold on
line([0 0],[-50 50],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5])

plot(diste,D(109:132),'color', 'r','marker','.','markersize',40,'linestyle','none');hold on

p = [];
p = polyfit(diste,D(109:132),1)
yy = polyval(p,[0 30])
plot([0 30],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on

[r,p] = corrcoef(diste,D(109:132))
text(2,-40,['R = ' num2str(r(2))]); 
text(2,-45,['p = ' num2str(p(2))]);

set(gca, 'box','off','linewidth',3,'fontsize',25,'fontweight','b');
axis([0 30 -50 50])

title('EAST')

%% ALL REFs
subplot(2,3,6)

% full range
D = [];
for i = 1:length(GDAVGm_pa)
    D(i) = mean(mean(tmp_gdavgm{i}.avg(x2',y1)))*1e15;
end

line([0 30],[0 0],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5]);hold on
line([0 0],[-50 50],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5])

plot([distpa distfu distpre distw diste],D,'color', 'r','marker','.','markersize',40,'linestyle','none');hold on

p = [];
p = polyfit([distpa distfu distpre distw diste],D,1)
yy = polyval(p,[0 30])
plot([0 30],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on

[r,p] = corrcoef([distpa distfu distpre distw diste],D)
text(2,-40,['R = ' num2str(r(2))]); 
text(2,-45,['p = ' num2str(p(2))]);

set(gca, 'box','off','linewidth',3,'fontsize',25,'fontweight','b');
axis([0 30 -50 50])

title('ALL REFs')

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/fullrange_signeddistT_perRef_mags_bestclust')

%% all refs binned (24)
dist_by_ref = [distpa distfu distpre distw diste];
[all_distT,ia,ic] = unique(dist_by_ref) 
[n,edges,bin] = histcounts(all_distT,23)

x = [];
x = find(dist_by_ref <= edges(1));
Dbinned = []
Dbinned(1) = mean(D(x))
for i = 2:length(edges)
    x = [];
    x = find((dist_by_ref <= edges(i)).*(dist_by_ref > edges(i-1)));
    Dbinned(i) = mean(D(x));
end

dist_val_binned = [-24   -21   -19   -17   -14   -12   -10    -7    -5 ...
                    -3     0     2     4     6     9    11    13    16 ...
                    18    20    23    25    27    29];

line([0 30],[0 0],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5]);hold on
line([0 0],[-50 50],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5])                
                
plot(dist_val_binned,Dbinned,'color', 'r','marker','.','markersize',40,'linestyle','none');hold on

p = [];
p = polyfit(dist_val_binned,Dbinned,1)
yy = polyval(p,[0 30])
plot([0 30],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on

[r,p] = corrcoef(dist_val_binned,Dbinned)
text(2,-40,['R = ' num2str(r(2))]); 
text(2,-45,['p = ' num2str(p(2))]);

set(gca, 'box','off','linewidth',3,'fontsize',25,'fontweight','b');
axis([-40 40 -25 40])

title('ALL REFs')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% mask = (stat_magt.mask.*(repmat((sum(stat_grads2.mask)>0),102,1)));
mask = (stat_signDT_Past.stat.mask);
[x1,y1] = find(sum(mask>0))
[x2,y2] = find(sum(mask>0,2))

% rephase time of data and test
cfg = []; cfg.toilim = [stat_magt.time(1) stat_magt.time(end)];
for i = 1:length(GDAVGm_pa)
    tmp_gdavgm{i} = ft_redefinetrial(cfg,GDAVGm_pa{i})
end

%% PAST
fig = figure('position',[1 1 1400 1000]);
set(fig,'PaperPosition',[1 1 1400 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

subplot(2,3,1)
% full range
D = [];
for i = 1:length(GDAVGm_pa)
    D(i) = mean(mean(tmp_gdavgm{i}.avg(x2',y1)))*1e15;
end

distpa = [-13   -12   -10   -14   -15   -11 ...
    -1    -3    -2    -4    -2    -7 ...
     3     1     3     4     8     7 ...
    11    14    12    11    13    12];

line([0 30],[0 0],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5]);hold on
line([0 0],[-50 50],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5])

plot(distpa,D(1:24),'color', 'r','marker','.','markersize',40,'linestyle','none');hold on

p = [];
p = polyfit(distpa,D(1:24),1)
yy = polyval(p,[0 30])
plot([0 30],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on

[r,p] = corrcoef(distpa,D(1:24))
text(2,-40,['R = ' num2str(r(2))]); 
text(2,-45,['p = ' num2str(p(2))]);

set(gca, 'box','off','linewidth',3,'fontsize',25,'fontweight','b');
axis([0 30 -50 50])

title('PAST')

%% FUTURE
subplot(2,3,3)

% full range
D = [];
for i = 1:length(GDAVGm_pa)
    D(i) = mean(mean(tmp_gdavgm{i}.avg(x2',y1)))*1e15;
end

distfu =  [-15   -17   -15   -14   -10   -11 ...
    -7    -4    -6    -7    -5    -6 ...
     2     8     3     2     4     8 ...
    18    10    13    12    14    16] 

line([0 30],[0 0],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5]);hold on
line([0 0],[-50 50],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5])

plot(distfu,D(25:48),'color', 'r','marker','.','markersize',40,'linestyle','none');hold on

p = [];
p = polyfit(distfu,D(25:48),1)
yy = polyval(p,[0 30])
plot([0 30],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on

[r,p] = corrcoef(distfu,D(25:48))
text(2,-40,['R = ' num2str(r(2))]); 
text(2,-45,['p = ' num2str(p(2))]);

set(gca, 'box','off','linewidth',3,'fontsize',25,'fontweight','b');
axis([0 30 -50 50])

title('FUTURE')

%% PRESENT
subplot(2,3,2)

% full range
D = [];
for i = 1:length(GDAVGm_pa)
    D(i) = mean(mean(tmp_gdavgm{i}.avg(x2',y1)))*1e15;
end

distpre =  [   -22   -21   -19   -23   -24   -20 ...
   -10   -12   -11   -13   -11   -16 ...
    -6    -8    -6    -5    -1    -2 ...
     2     5     3     2     4     3 ...
    11    17    12    11    13    17 ...
    27    19    22    21    23    25]

line([0 30],[0 0],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5]);hold on
line([0 0],[-50 50],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5])

plot(distpre,D(49:84),'color', 'r','marker','.','markersize',40,'linestyle','none');hold on

p = [];
p = polyfit(distpre,D(49:84),1)
yy = polyval(p,[0 30])
plot([0 30],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on

[r,p] = corrcoef(distpre,D(49:84))
text(2,-40,['R = ' num2str(r(2))]); 
text(2,-45,['p = ' num2str(p(2))]);

set(gca, 'box','off','linewidth',3,'fontsize',25,'fontweight','b');
axis([0 30 -50 50])

title('PRESENT')

%% West
subplot(2,3,4)

% full range
D = [];
for i = 1:length(GDAVGm_pa)
    D(i) = mean(mean(tmp_gdavgm{i}.avg(x2',y1)))*1e15;
end

distw =  [   -22   -10    -6     2    11    27 ...
   -21   -12    -8     5    17    19 ...
   -19   -11    -6     3    12    22 ...
   -23   -13    -5     2    11    21];

line([0 30],[0 0],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5]);hold on
line([0 0],[-50 50],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5])

plot(distw,D(85:108),'color', 'r','marker','.','markersize',40,'linestyle','none');hold on

p = [];
p = polyfit(distw,D(85:108),1)
yy = polyval(p,[0 30])
plot([0 30],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on

[r,p] = corrcoef(distw,D(85:108))
text(2,-40,['R = ' num2str(r(2))]); 
text(2,-45,['p = ' num2str(p(2))]);

set(gca, 'box','off','linewidth',3,'fontsize',25,'fontweight','b');
axis([0 30 -50 50])

title('CAYENNE')

%% East
subplot(2,3,5)

% full range
D = [];
for i = 1:length(GDAVGm_pa)
    D(i) = mean(mean(tmp_gdavgm{i}.avg(x2',y1)))*1e15;
end

diste =  [   -19   -11    -6     3    12    22 ...
   -23   -13    -5     2    11    21 ...
   -24   -11    -1     4    13    23 ...
   -20   -16    -2     3    17    25];

line([0 30],[0 0],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5]);hold on
line([0 0],[-50 50],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5])

plot(diste,D(109:132),'color', 'r','marker','.','markersize',40,'linestyle','none');hold on

p = [];
p = polyfit(diste,D(109:132),1)
yy = polyval(p,[0 30])
plot([0 30],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on

[r,p] = corrcoef(diste,D(109:132))
text(2,-40,['R = ' num2str(r(2))]); 
text(2,-45,['p = ' num2str(p(2))]);

set(gca, 'box','off','linewidth',3,'fontsize',25,'fontweight','b');
axis([0 30 -50 50])

title('EAST')

%% ALL REFs
subplot(2,3,6)

% full range
D = [];
for i = 1:length(GDAVGm_pa)
    D(i) = mean(mean(tmp_gdavgm{i}.avg(x2',y1)))*1e15;
end

line([0 30],[0 0],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5]);hold on
line([0 0],[-50 50],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5])

plot([distpa distfu distpre distw diste],D,'color', 'r','marker','.','markersize',40,'linestyle','none');hold on

p = [];
p = polyfit([distpa distfu distpre distw diste],D,1)
yy = polyval(p,[0 30])
plot([0 30],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on

[r,p] = corrcoef([distpa distfu distpre distw diste],D)
text(2,-40,['R = ' num2str(r(2))]); 
text(2,-45,['p = ' num2str(p(2))]);

set(gca, 'box','off','linewidth',3,'fontsize',25,'fontweight','b');
axis([0 30 -50 50])

title('ALL REFs')

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/fullrange_signeddistT_perRef_mags_LatePastDetect')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mask = (stat_grads2.mask);

[x1,y1] = find(sum(mask>0))
[x2,y2] = find(sum(mask>0,2))

% rephase time of data and test
cfg.chansel = 'Grads2'; cfg = []; cfg.toilim = [stat_grads2.time(1) stat_grads2.time(end)];
for i = 1:length(GDAVGm_pag)
    tmp_gdavgm{i} = ft_redefinetrial(cfg,GDAVGm_pag{i})
end

%% PAST
fig = figure('position',[1 1 1400 1000]);
set(fig,'PaperPosition',[1 1 1400 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

subplot(2,3,1)
% full range
D = [];
for i = 1:length(GDAVGm_pa)
    D(i) = mean(mean(tmp_gdavgm{i}.avg(x2',y1)))*1e13;
end

distpa = [-13   -12   -10   -14   -15   -11 ...
    -1    -3    -2    -4    -2    -7 ...
     3     1     3     4     8     7 ...
    11    14    12    11    13    12];

line([0 30],[0 0],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5]);hold on
line([0 0],[-50 50],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5])

plot(distpa,D(1:24),'color', 'r','marker','.','markersize',40,'linestyle','none');hold on

p = [];
p = polyfit(distpa,D(1:24),1)
yy = polyval(p,[0 30])
plot([0 30],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on

[r,p] = corrcoef(distpa,D(1:24))
text(2,8,['R = ' num2str(r(2))]); 
text(2,4,['p = ' num2str(p(2))]);

set(gca, 'box','off','linewidth',3,'fontsize',25,'fontweight','b');
axis([0 30 -20 10])

title('PAST')

%% FUTURE
subplot(2,3,3)

% full range
D = [];
for i = 1:length(GDAVGm_pa)
    D(i) = mean(mean(tmp_gdavgm{i}.avg(x2',y1)))*1e13;
end

distfu =  [-15   -17   -15   -14   -10   -11 ...
    -7    -4    -6    -7    -5    -6 ...
     2     8     3     2     4     8 ...
    18    10    13    12    14    16] 

line([0 30],[0 0],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5]);hold on
line([0 0],[-50 50],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5])

plot(distfu,D(25:48),'color', 'r','marker','.','markersize',40,'linestyle','none');hold on

p = [];
p = polyfit(distfu,D(25:48),1)
yy = polyval(p,[0 30])
plot([0 30],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on

[r,p] = corrcoef(distfu,D(25:48))
text(2,8,['R = ' num2str(r(2))]); 
text(2,4,['p = ' num2str(p(2))]);

set(gca, 'box','off','linewidth',3,'fontsize',25,'fontweight','b');
axis([0 30 -20 10])

title('FUTURE')

%% PRESENT
subplot(2,3,2)

% full range
D = [];
for i = 1:length(GDAVGm_pa)
    D(i) = mean(mean(tmp_gdavgm{i}.avg(x2',y1)))*1e13;
end

distpre =  [   -22   -21   -19   -23   -24   -20 ...
   -10   -12   -11   -13   -11   -16 ...
    -6    -8    -6    -5    -1    -2 ...
     2     5     3     2     4     3 ...
    11    17    12    11    13    17 ...
    27    19    22    21    23    25]

line([0 30],[0 0],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5]);hold on
line([0 0],[-50 50],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5])

plot(distpre,D(49:84),'color', 'r','marker','.','markersize',40,'linestyle','none');hold on

p = [];
p = polyfit(distpre,D(49:84),1)
yy = polyval(p,[0 30])
plot([0 30],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on

[r,p] = corrcoef(distpre,D(49:84))
text(2,8,['R = ' num2str(r(2))]); 
text(2,4,['p = ' num2str(p(2))]);

set(gca, 'box','off','linewidth',3,'fontsize',25,'fontweight','b');
axis([0 30 -20 10])

title('PRESENT')

%% West
subplot(2,3,4)

% full range
D = [];
for i = 1:length(GDAVGm_pa)
    D(i) = mean(mean(tmp_gdavgm{i}.avg(x2',y1)))*1e13;
end

distw =  [   -22   -10    -6     2    11    27 ...
   -21   -12    -8     5    17    19 ...
   -19   -11    -6     3    12    22 ...
   -23   -13    -5     2    11    21];

line([0 30],[0 0],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5]);hold on
line([0 0],[-50 50],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5])

plot(distw,D(85:108),'color', 'r','marker','.','markersize',40,'linestyle','none');hold on

p = [];
p = polyfit(distw,D(85:108),1)
yy = polyval(p,[0 30])
plot([0 30],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on

[r,p] = corrcoef(distw,D(85:108))
text(2,8,['R = ' num2str(r(2))]); 
text(2,4,['p = ' num2str(p(2))]);

set(gca, 'box','off','linewidth',3,'fontsize',25,'fontweight','b');
axis([0 30 -20 10])

title('CAYENNE')

%% East
subplot(2,3,5)

% full range
D = [];
for i = 1:length(GDAVGm_pa)
    D(i) = mean(mean(tmp_gdavgm{i}.avg(x2',y1)))*1e13;
end

diste =  [   -19   -11    -6     3    12    22 ...
   -23   -13    -5     2    11    21 ...
   -24   -11    -1     4    13    23 ...
   -20   -16    -2     3    17    25];

line([0 30],[0 0],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5]);hold on
line([0 0],[-50 50],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5])

plot(diste,D(109:132),'color', 'r','marker','.','markersize',40,'linestyle','none');hold on

p = [];
p = polyfit(diste,D(109:132),1)
yy = polyval(p,[0 30])
plot([0 30],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on

[r,p] = corrcoef(diste,D(109:132))
text(2,8,['R = ' num2str(r(2))]); 
text(2,4,['p = ' num2str(p(2))]);

set(gca, 'box','off','linewidth',3,'fontsize',25,'fontweight','b');
axis([0 30 -20 10])

title('EAST')

%% ALL REFs
subplot(2,3,6)

% full range
D = [];
for i = 1:length(GDAVGm_pa)
    D(i) = mean(mean(tmp_gdavgm{i}.avg(x2',y1)))*1e13;
end

line([0 30],[0 0],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5]);hold on
line([0 0],[-50 50],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5])

plot([distpa distfu distpre distw diste],D,'color', 'r','marker','.','markersize',40,'linestyle','none');hold on

p = [];
p = polyfit([distpa distfu distpre distw diste],D,1)
yy = polyval(p,[0 30])
plot([0 30],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on

[r,p] = corrcoef([distpa distfu distpre distw diste],D)
text(2,8,['R = ' num2str(r(2))]); 
text(2,4,['p = ' num2str(p(2))]);

set(gca, 'box','off','linewidth',3,'fontsize',25,'fontweight','b');
axis([0 30 -20 10])

title('ALL REFs')

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/fullrange_signeddistT_perRef_grads')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mask = (stat_magt.mask.*(repmat((sum(stat_grads2.mask)>0),102,1)));
% mask = (stat_magt.mask.*(repmat((sum(stat_grads2.mask)>0),102,1)));
[x1,y1] = find(sum(mask>0))
[x2,y2] = find(sum(mask>0,2))

% rephase time of data and test
cfg = []; cfg.toilim = [stat_grads2.time(1) stat_grads2.time(end)];
for i = 1:length(GDAVGm_pag)
    tmp_gdavgm{i} = ft_redefinetrial(cfg,GDAVGm_pag{i})
end

%% PAST
fig = figure('position',[1 1 1400 1000]);
set(fig,'PaperPosition',[1 1 1400 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

subplot(2,3,1)
% full range
D = [];
for i = 1:length(GDAVGm_pag)
    D(i) = mean(mean(tmp_gdavgm{i}.avg(x2',y1)))*1e15;
end

distpa = [13   -12   -10   -14   -15   -11 ...
    -1    -3    -2    -4    -2    -7 ...
     3     1     3     4     8     7 ...
    11    14    12    11    13    12]

line([0 30],[0 0],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5]);hold on
line([0 0],[-50 50],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5])

plot(distpa,D(1:24),'color', 'r','marker','.','markersize',40,'linestyle','none');hold on

p = [];
p = polyfit(distpa,D(1:24),1)
yy = polyval(p,[0 30])
plot([0 30],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on

[r,p] = corrcoef(distpa,D(1:24))
text(2,-40,['R = ' num2str(r(2))]); 
text(2,-45,['p = ' num2str(p(2))]);

set(gca, 'box','off','linewidth',3,'fontsize',25,'fontweight','b');
axis([0 30 -50 50])

title('PAST')

%% FUTURE
subplot(2,3,3)

% full range
D = [];
for i = 1:length(GDAVGm_pag)
    D(i) = mean(mean(tmp_gdavgm{i}.avg(x2',y1)))*1e15;
end

distfu =  [-15   -17   -15   -14   -10   -11 ...
    -7    -4    -6    -7    -5    -6 ...
     2     8     3     2     4     8 ...
    18    10    13    12    14    16];

line([0 30],[0 0],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5]);hold on
line([0 0],[-50 50],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5])

plot(distfu,D(25:48),'color', 'r','marker','.','markersize',40,'linestyle','none');hold on

p = [];
p = polyfit(distfu,D(25:48),1)
yy = polyval(p,[0 30])
plot([0 30],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on

[r,p] = corrcoef(distfu,D(25:48))
text(2,-40,['R = ' num2str(r(2))]); 
text(2,-45,['p = ' num2str(p(2))]);

set(gca, 'box','off','linewidth',3,'fontsize',25,'fontweight','b');
axis([0 30 -50 50])

title('FUTURE')

%% PRESENT
subplot(2,3,2)

% full range
D = [];
for i = 1:length(GDAVGm_pag)
    D(i) = mean(mean(tmp_gdavgm{i}.avg(x2',y1)))*1e15;
end

distpre =  [ -22   -21   -19   -23   -24   -20 ...
   -10   -12   -11   -13   -11   -16 ...
    -6    -8    -6    -5    -1    -2 ...
     2     5     3     2     4     3 ...
    11    17    12    11    13    17 ...
    27    19    22    21    23    25]

line([0 30],[0 0],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5]);hold on
line([0 0],[-50 50],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5])

plot(distpre,D(49:84),'color', 'r','marker','.','markersize',40,'linestyle','none');hold on

p = [];
p = polyfit(distpre,D(49:84),1)
yy = polyval(p,[0 30])
plot([0 30],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on

[r,p] = corrcoef(distpre,D(49:84))
text(2,-40,['R = ' num2str(r(2))]); 
text(2,-45,['p = ' num2str(p(2))]);

set(gca, 'box','off','linewidth',3,'fontsize',25,'fontweight','b');
axis([0 30 -50 50])

title('PRESENT')

%% West
subplot(2,3,4)

% full range
D = [];
for i = 1:length(GDAVGm_pag)
    D(i) = mean(mean(tmp_gdavgm{i}.avg(x2',y1)))*1e15;
end

distw =  [ -22   -21   -19   -23 ...
   -10   -12   -11   -13 ...
    -6    -8    -6    -5 ...
     2     5     3     2 ...
    11    17    12    11 ...
    27    19    22    21];

line([0 30],[0 0],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5]);hold on
line([0 0],[-50 50],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5])

plot(distw,D(85:108),'color', 'r','marker','.','markersize',40,'linestyle','none');hold on

p = [];
p = polyfit(distw,D(85:108),1)
yy = polyval(p,[0 30])
plot([0 30],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on

[r,p] = corrcoef(distw,D(85:108))
text(2,-40,['R = ' num2str(r(2))]); 
text(2,-45,['p = ' num2str(p(2))]);

set(gca, 'box','off','linewidth',3,'fontsize',25,'fontweight','b');
axis([0 30 -50 50])

title('CAYENNE')

%% East
subplot(2,3,5)

% full range
D = [];
for i = 1:length(GDAVGm_pag)
    D(i) = mean(mean(tmp_gdavgm{i}.avg(x2',y1)))*1e15;
end

diste =  [ -19   -23   -24   -20 ...
   -11   -13   -11   -16 ...
    -6    -5    -1    -2 ...
     3     2     4     3 ...
    12    11    13    17 ...
    22    21    23    25];

line([0 30],[0 0],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5]);hold on
line([0 0],[-50 50],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5])

plot(diste,D(109:132),'color', 'r','marker','.','markersize',40,'linestyle','none');hold on

p = [];
p = polyfit(diste,D(109:132),1)
yy = polyval(p,[0 30])
plot([0 30],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on

[r,p] = corrcoef(diste,D(109:132))
text(2,-40,['R = ' num2str(r(2))]); 
text(2,-45,['p = ' num2str(p(2))]);

set(gca, 'box','off','linewidth',3,'fontsize',25,'fontweight','b');
axis([0 30 -50 50])

title('EAST')

%% ALL REFs
subplot(2,3,6)

% full range
D = [];
for i = 1:length(GDAVGm_pag)
    D(i) = mean(mean(tmp_gdavgm{i}.avg(x2',y1)))*1e15;
end

line([0 30],[0 0],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5]);hold on
line([0 0],[-50 50],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5])

plot([distpa distfu distpre distw diste],D,'color', 'r','marker','.','markersize',40,'linestyle','none');hold on

p = [];
p = polyfit([distpa distfu distpre distw diste],D,1)
yy = polyval(p,[0 30])
plot([0 30],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on

[r,p] = corrcoef([distpa distfu distpre distw diste],D)
text(2,-40,['R = ' num2str(r(2))]); 
text(2,-45,['p = ' num2str(p(2))]);

set(gca, 'box','off','linewidth',3,'fontsize',25,'fontweight','b');
axis([0 30 -50 50])

title('ALL REFs')

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/fullrange_signeddistT_perRef')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%% SPACE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mask = (stat_grads2s.mask);

[x1,y1] = find(sum(mask>0))
[x2,y2] = find(sum(mask>0,2))

% rephase time of data and test
cfg = []; cfg.toilim = [stat_grads2s.time(1) stat_grads2s.time(end)];
for i = 1:length(GDAVGm_w)
    tmp_gdavgm_w{i} = ft_redefinetrial(cfg,GDAVGm_w{i})
end

%% West
fig = figure('position',[1 1 1400 1000]);
set(fig,'PaperPosition',[1 1 1400 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

subplot(2,3,1)
% full range
D = [];
for i = 1:length(GDAVGm_w)
    D(i) = mean(mean(tmp_gdavgm_w{i}.avg(x2',y1)))*1e13;
end

distw = [   -66   -66   -64   -97   -49  -100 ...
   -35   -21   -39   -27   -21   -24 ...
    53    42    45    10    53    55 ...
    97    88    73    62    88    61];

line([-160 160],[0 0],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5]);hold on
line([0 0],[-50 50],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5])

plot(distw,D(1:24),'color', 'b','marker','.','markersize',40,'linestyle','none');hold on

p = [];
p = polyfit(distw,D(1:24),1)
yy = polyval(p,[-160 160])
plot([-160 160],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on

[r,p] = corrcoef(distw,D(1:24))
text(10,-18,['R = ' num2str(r(2))]); 
text(10,-20,['p = ' num2str(p(2))]);

set(gca, 'box','off','linewidth',3,'fontsize',25,'fontweight','b');
axis([-160 160 -25 25])

title('West')

%% Paris
subplot(2,3,3)

% full range
D = [];
for i = 1:length(GDAVGm_w)
    D(i) = mean(mean(tmp_gdavgm_w{i}.avg(x2',y1)))*1e13;
end

distpar =  [-120  -120  -119  -151  -104  -154 ...
   -89   -76   -94   -82   -75   -79 ...
    -2   -13   -10   -45    -2     0 ...
    42    34    18     7    33     6 ...
    64    65    58    94    71    76 ...
   104   134   139   117   119   133]
;

line([-160 160],[0 0],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5]);hold on
line([0 0],[-50 50],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5])

plot(distpar,D(49:84),'color', 'b','marker','.','markersize',40,'linestyle','none');hold on

p = [];
p = polyfit(distpar,D(49:84),1)
yy = polyval(p,[-160 160])
plot([-160 160],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on

[r,p] = corrcoef(distpar,D(49:84))
text(10,-18,['R = ' num2str(r(2))]); 
text(10,-20,['p = ' num2str(p(2))]);

set(gca, 'box','off','linewidth',3,'fontsize',25,'fontweight','b');
axis([-160 160 -25 25])

title('HERE')

%% EAST
subplot(2,3,2)

% full range
D = [];
for i = 1:length(GDAVGm_w)
    D(i) = mean(mean(tmp_gdavgm_w{i}.avg(x2',y1)))*1e13;
end

diste =  [-55   -66   -63   -98   -55   -53 ...
   -11   -19   -35   -46   -20   -47 ...
    11    12     5    41    18    23 ...
    51    81    86    64    66    80];

line([-160 160],[0 0],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5]);hold on
line([0 0],[-50 50],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5])

plot(diste,D(25:48),'color', 'b','marker','.','markersize',40,'linestyle','none');hold on

p = [];
p = polyfit(diste,D(25:48),1)
yy = polyval(p,[-160 160])
plot([-160 160],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on

[r,p] = corrcoef(diste,D(25:48))
text(10,-18,['R = ' num2str(r(2))]); 
text(10,-20,['p = ' num2str(p(2))]);

set(gca, 'box','off','linewidth',3,'fontsize',25,'fontweight','b');
axis([-160 160 -25 25])

title('EAST')

%% Past
subplot(2,3,4)

% full range
D = [];
for i = 1:length(GDAVGm_w)
    D(i) = mean(mean(tmp_gdavgm_w{i}.avg(x2',y1)))*1e13;
end

distpas =  [  -120  -120  -119  -151 ...
   -89   -76   -94   -82 ...
    -2   -13   -10   -45 ...
    42    34    18     7 ...
    64    65    58    94 ...
   104   134   139   117];


line([-160 160],[0 0],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5]);hold on
line([0 0],[-50 50],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5])

plot(distpas,D(85:108),'color', 'b','marker','.','markersize',40,'linestyle','none');hold on

p = [];
p = polyfit(distpas,D(85:108),1)
yy = polyval(p,[-160 160])
plot([-160 160],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on

[r,p] = corrcoef(distpas,D(85:108))
text(10,-18,['R = ' num2str(r(2))]); 
text(10,-20,['p = ' num2str(p(2))]);

set(gca, 'box','off','linewidth',3,'fontsize',25,'fontweight','b');
axis([-160 160 -25 25])

title('PAST')

%% Future
subplot(2,3,5)

% full range
D = [];
for i = 1:length(GDAVGm_w)
    D(i) = mean(mean(tmp_gdavgm_w{i}.avg(x2',y1)))*1e13;
end

distfut =  [[ -119  -151  -104  -154 ...
   -94   -82   -75   -79 ...
   -10   -45    -2     0 ...
    18     7    33     6 ...
    58    94    71    76 ...
   139   117   119   133]]


line([-160 160],[0 0],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5]);hold on
line([0 0],[-50 50],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5])

plot(distfut,D(109:132),'color', 'b','marker','.','markersize',40,'linestyle','none');hold on

p = [];
p = polyfit(distfut,D(109:132),1)
yy = polyval(p,[-160 160])
plot([-160 160],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on

[r,p] = corrcoef(distfut,D(109:132))
text(10,-18,['R = ' num2str(r(2))]); 
text(10,-20,['p = ' num2str(p(2))]);

set(gca, 'box','off','linewidth',3,'fontsize',25,'fontweight','b');
axis([-160 160 -25 25])

title('FUTURE')

%% ALL REFs
subplot(2,3,6)

% full range
D = [];
for i = 1:length(GDAVGm_w)
    D(i) = mean(mean(tmp_gdavgm_w{i}.avg(x2',y1)))*1e13;
end

line([-160 160],[0 0],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5]);hold on
line([0 0],[-50 50],'linewidth',3,'linestyle','--','color',[0.5 0.5 0.5])

plot([distw diste distpar distpas distfut],D,'color', 'b','marker','.','markersize',40,'linestyle','none');hold on

p = [];
p = polyfit([distw diste distpar distpas distfut],D,1)
yy = polyval(p,[-160 160])
plot([-160 160],[yy(1) yy(2)],'linewidth',4,'color','k','markersize',20); hold on

[r,p] = corrcoef([distw diste distpar distpas distfut],D)
text(10,-18,['R = ' num2str(r(2))]); 
text(10,-20,['p = ' num2str(p(2))]);

set(gca, 'box','off','linewidth',3,'fontsize',25,'fontweight','b');
axis([-160 160 -25 25])

title('ALL REFs')

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/fullrange_signeddistS_perRef_clustall')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
times = sum(mask.*mask1);
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
    
    sensorofinterest       = stat_magt.mask.*mask1;
    indchan = []; indchan  = find(sensorofinterest(:,index) > 0);
    cfg.highlightchannel   = stat_magt.label(indchan);
    cfg.highlightsymbol    = '.';
    cfg.highlightsize      = 20;
    cfg.comment            = num2str(stat_magt.time(index));
    ft_topoplotER(cfg,stat_magt);
    count = count +1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% DIST TIME %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
condnames = {                     'RPasDT-2';'RPasDT-1';'RPasDT1';'RPasDT2';...
                                  'RFusDT-2';'RFusDT-1';'RFusDT1';'RFusDT2';...
                       'RPrsDT-3';'RPrsDT-2';'RPrsDT-1';'RPrsDT1';'RPrsDT2';'RPrsDT3'};
latency      = [0 1];
chansel      = 'Grads2';
[ch, cdn, GDAVG, GDAVGt] = prepare_comp_v4(niplist,condnames, latency, chansel)

%%%%%%%%%%%%%%%%%%%%%%%% prepare plotting layout %%%%%%%%%%%%%%%%%%%%%%%%%%
% select sensor datatype
[Grads1,Grads2,Mags]   = grads_for_layouts('Network');
% prepare layout
cfg                           = [];
cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/fieldtrip-20130901/template/layout/NM306mag.lay';
lay                        = ft_prepare_layout(cfg,GDAVG_grads2{1});
lay.label                = GDAVG_grads2{1}.label;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
times    = sum(stat_grads2.prob <= 0.025);
plot(stat_grads2.time,times)
[x,y]    = findpeaks(times);
indchan2 = find(stat_grads2.prob(:,y(1)) <0.025);
clust2   = find(sum(stat_grads2.prob <= 0.025) > 0);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 1600 1000]);
set(fig,'PaperPosition',[1 1 1600 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

% stimulus onsets
line([0 0],[-12 7],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on
line([1 1],[-12 7],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on

fmult = 1e12

val1 = mean(GDAVG{1}.avg(indchan2,:)*fmult) 
val2 = mean(GDAVG{2}.avg(indchan2,:)*fmult) 
val3 = mean(GDAVG{3}.avg(indchan2,:)*fmult)
val4 = mean(GDAVG{4}.avg(indchan2,:)*fmult)

plot_lin_shade(clust1, 0.025, stat_grads2,'k',1);hold on % significance window

% timecourse
plot(GDAVG{1}.time,val1,'linewidth',8,'color',[1 0.8 0.8]) ;hold on
plot(GDAVG{1}.time,val2,'linewidth',8,'color',[1 0.5 0.5]) ;hold on
plot(GDAVG{1}.time,val3,'linewidth',8,'color',[1 0.3 0.3]) ;hold on
plot(GDAVG{1}.time,val4,'linewidth',8,'color',[0.9 0 0]) ;hold on

set(gca,'box','off','linewidth',4,'fontsize',40,'fontweight','b')
set(gca,'ytick',[-2  0 2],'yticklabel',[-2 0 2])
axis([-0.2 1.2 -3 2])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure

mask = (stat_magt.mask);
[x1,y1] = find(sum(mask>0))
[x2,y2] = find(sum(mask>0,2))

% rephase time of data and test
cfg = []; cfg.toilim = [stat_magt.time(1) stat_magt.time(end)];
for i = 1:length(GDAVGtm_pa)
    tmp_gdavgm{i} = ft_redefinetrial(cfg,GDAVGtm_pa{i})
end


D = [];
p = [];
for d = 1:length(GDAVGm_pa)
    for i = 1:size(tmp_gdavgm{d}.trial,1)
        tmp = []; tmp = squeeze(tmp_gdavgm{d}.trial(i,x2',y1));
        D(i,d) = mean(mean(tmp))*1e15;
    end
end

distpa = abs([-13   -12   -10   -14   -15   -11 ...
    -1    -3    -2    -4    -2    -7 ...
     3     1     3     4     8     7 ...
    11    14    12    11    13    12]);

Slopes_pa = [];
for i = 1:size(tmp_gdavgm{d}.trial,1)
    p = [];p = polyfit(distpa,D(i,1:24),1)
    Slopes_pa(i) = p(1);
end

distfu =  abs([-15   -17   -15   -14   -10   -11 ...
    -7    -4    -6    -7    -5    -6 ...
     2     8     3     2     4     8 ...
    18    10    13    12    14    16] )

Slopes_fu = [];
for i = 1:size(tmp_gdavgm{d}.trial,1)
    p = [];p = polyfit(distfu,D(i,25:48),1)
    Slopes_fu(i) = p(1);
end


distpre =  abs([   -22   -21   -19   -23   -24   -20 ...
   -10   -12   -11   -13   -11   -16 ...
    -6    -8    -6    -5    -1    -2 ...
     2     5     3     2     4     3 ...
    11    17    12    11    13    17 ...
    27    19    22    21    23    25])

Slopes_pre = [];
for i = 1:size(tmp_gdavgm{d}.trial,1)
    p = [];p = polyfit(distpre,D(i,49:84),1)
    Slopes_pre(i) = p(1);
end

distw =  abs([   -22   -10    -6     2    11    27 ...
   -21   -12    -8     5    17    19 ...
   -19   -11    -6     3    12    22 ...
   -23   -13    -5     2    11    21]);

Slopes_w = [];
for i = 1:size(tmp_gdavgm{d}.trial,1)
    p = [];p = polyfit(distw,D(i,85:108),1)
    Slopes_w(i) = p(1);
end

diste =  abs([   -19   -11    -6     3    12    22 ...
   -23   -13    -5     2    11    21 ...
   -24   -11    -1     4    13    23 ...
   -20   -16    -2     3    17    25]);

Slopes_e = [];
for i = 1:size(tmp_gdavgm{d}.trial,1)
    p = [];p = polyfit(diste,D(i,109:132),1)
    Slopes_e(i) = p(1);
end

Slopes_all = [];
for i = 1:size(tmp_gdavgm{d}.trial,1)
    p = [];p = polyfit([distpa distfu distpre distw diste],D(i,:),1)
    Slopes_all(i) = p(1);
end

bar([1 2 3 4 5 7],[mean(Slopes_pa) mean(Slopes_fu) mean(Slopes_pre) ...
    mean(Slopes_w) mean(Slopes_e) mean(Slopes_all)],'facecolor',[0.5 0.5 0.5]); hold on
errorbar([1 2 3 4 5 7],[mean(Slopes_pa) mean(Slopes_fu) mean(Slopes_pre) mean(Slopes_w) mean(Slopes_e) mean(Slopes_all)],...
    [std(Slopes_pa) std(Slopes_fu) std(Slopes_pre) std(Slopes_w) std(Slopes_e) std(Slopes_all)]./sqrt(19),'color','k',...
    'linestyle','none')
set(gca,'xtick',[1:5 7], 'xticklabel',{'Past';'Pre';'Fut';'W';'E';'Pooled'})
xlabel('ref conditions')
ylabel('linear fit slope (ft)')

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/fullrange_absdistT_clust_mags_fullclust_slopes')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure

mask = (stat_magt.mask);
[x1,y1] = find(sum(mask>0))
[x2,y2] = find(sum(mask>0,2))

% rephase time of data and test
cfg = []; cfg.toilim = [stat_magt.time(1) stat_magt.time(end)];
for i = 1:length(GDAVGtm_pa)
    tmp_gdavgm{i} = ft_redefinetrial(cfg,GDAVGtm_pa{i})
end


D = [];
p = [];
for d = 1:length(GDAVGm_pa)
    for i = 1:size(tmp_gdavgm{d}.trial,1)
        tmp = []; tmp = squeeze(tmp_gdavgm{d}.trial(i,x2',y1));
        D(i,d) = mean(mean(tmp))*1e15;
    end
end

distpa = ([-13   -12   -10   -14   -15   -11 ...
    -1    -3    -2    -4    -2    -7 ...
     3     1     3     4     8     7 ...
    11    14    12    11    13    12]);
Slopes_pa = [];
for i = 1:size(tmp_gdavgm{d}.trial,1)
    p1 = [];
    p1 = polyfit(distpa(1:12),D(i,1:12),1)
    Slopes_pa1(i) = p1(2)
    p2 = [];
    p2 = polyfit(distpa(13:24),D(i,13:24),1)
    Slopes_pa2(i) = p2(2)
end


distfu =  ([-15   -17   -15   -14   -10   -11 ...
    -7    -4    -6    -7    -5    -6 ...
     2     8     3     2     4     8 ...
    18    10    13    12    14    16]) 
Slopes_fu = [];
for i = 1:size(tmp_gdavgm{d}.trial,1)
    p1 = [];
    p1 = polyfit(distfu(1:12),D(i,25:36),1)
    Slopes_fu1(i) = p1(2)
    p2 = [];
    p2 = polyfit(distfu(13:24),D(i,37:48),1)
    Slopes_fu2(i) = p2(2)
end

distpre =  ([   -22   -21   -19   -23   -24   -20 ...
   -10   -12   -11   -13   -11   -16 ...
    -6    -8    -6    -5    -1    -2 ...
     2     5     3     2     4     3 ...
    11    17    12    11    13    17 ...
    27    19    22    21    23    25])
Slopes_pre = [];
for i = 1:size(tmp_gdavgm{d}.trial,1)
    p1 = [];
    p1 = polyfit(distpre(1:18),D(i,49:66),1)
    Slopes_pre1(i) = p1(2)
    p2 = [];
    p2 = polyfit(distpre(19:36),D(i,67:84),1)
    Slopes_pre2(i) = p2(2)
end

distw =  ([   -22   -10    -6     2    11    27 ...
   -21   -12    -8     5    17    19 ...
   -19   -11    -6     3    12    22 ...
   -23   -13    -5     2    11    21]);
Slopes_w = [];
for i = 1:size(tmp_gdavgm{d}.trial,1)
    p1 = [];
    p1 = polyfit(distw([1:3 7:9 13:15 19:21]),D(i,[1:3 7:9 13:15 19:21]+ones(1,12)*84),1)
    Slopes_w1(i) = p1(2)
    p2 = [];
    p2 = polyfit(distw([1:3 7:9 13:15 19:21]+ones(1,12)*3),D(i,[1:3 7:9 13:15 19:21]+ones(1,12)*87),1)
    Slopes_w2(i) = p2(2)
end

diste = ([   -19   -11    -6     3    12    22 ...
    -23   -13    -5     2    11    21 ...
    -24   -11    -1     4    13    23 ...
    -20   -16    -2     3    17    25]);
Slopes_e = [];
for i = 1:size(tmp_gdavgm{d}.trial,1)
    p1 = [];
    p1 = polyfit(diste([1:3 7:9 13:15 19:21]),D(i,[1:3 7:9 13:15 19:21]+ones(1,12)*108),1)
    Slopes_e1(i) = p1(2)
    p2 = [];
    p2 = polyfit(diste([1:3 7:9 13:15 19:21]+ones(1,12)*3),D(i,[1:3 7:9 13:15 19:21]+ones(1,12)*111),1)
    Slopes_e2(i) = p2(2)
end

Slopes_all = [];
for i = 1:size(tmp_gdavgm{d}.trial,1)
    p1 = [];
    p1 = polyfit([distpa(1:12) distfu(1:12) distpre(1:18) ...
        distw([1:3 7:9 13:15 19:21]) diste([1:3 7:9 13:15 19:21])],...
        D(i,[[1:12 25:36 49:66] [[1:3 7:9 13:15 19:21] + ones(1,12)*84] ...
        [[1:3 7:9 13:15 19:21] + ones(1,12)*108]]),1)
    Slopes_all1(i) = p1(2)
    p2 = [];
    p2 = polyfit([distpa(13:24) distfu(13:24) distpre(19:36) ...
        distw([1:3 7:9 13:15 19:21]+ones(1,12)*3) diste([1:3 7:9 13:15 19:21]+ones(1,12)*3)],...
        D(i,[[13:24 37:48 67:84] [[1:3 7:9 13:15 19:21] + ones(1,12)*87] ...
        [[1:3 7:9 13:15 19:21] + ones(1,12)*111]]),1)
    Slopes_all2(i) = p2(2)
end

subplot(2,1,1)
bar([1 2 3 4 5 7],[mean(Slopes_pa1) mean(Slopes_fu1) mean(Slopes_pre1) ...
    mean(Slopes_w1) mean(Slopes_e1) mean(Slopes_all1)],'facecolor',[0.5 0.5 0.5]); hold on
errorbar([1 2 3 4 5 7],[mean(Slopes_pa1) mean(Slopes_fu1) mean(Slopes_pre1) mean(Slopes_w1) mean(Slopes_e1) mean(Slopes_all1)],...
    [std(Slopes_pa1) std(Slopes_fu1) std(Slopes_pre1) std(Slopes_w1) std(Slopes_e1) std(Slopes_all1)]./sqrt(19),'color','k',...
    'linestyle','none')
set(gca,'xtick',[1:5 7], 'xticklabel',{'Past';'Pre';'Fut';'W';'E';'Pooled'})
xlabel('ref conditions')
ylabel('linear fit slope (ft)')

subplot(2,1,2)
bar([1 2 3 4 5 7],[mean(Slopes_pa2) mean(Slopes_fu2) mean(Slopes_pre2) ...
    mean(Slopes_w2) mean(Slopes_e2) mean(Slopes_all2)],'facecolor',[0.5 0.5 0.5]); hold on
errorbar([1 2 3 4 5 7],[mean(Slopes_pa2) mean(Slopes_fu2) mean(Slopes_pre2) mean(Slopes_w2) mean(Slopes_e2) mean(Slopes_all2)],...
    [std(Slopes_pa2) std(Slopes_fu2) std(Slopes_pre2) std(Slopes_w2) std(Slopes_e2) std(Slopes_all2)]./sqrt(19),'color','k',...
    'linestyle','none')
set(gca,'xtick',[1:5 7], 'xticklabel',{'Past';'Pre';'Fut';'W';'E';'Pooled'})
xlabel('ref conditions')
ylabel('linear fit slope (ft)')

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/fullrange_splitabsdistT_clust_mags_fullclust_slopes')


