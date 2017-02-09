addpath('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/PLOTTING_PAPER')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
condnames_clust = {'RelPastG_intmap','RelFutG_intmap','RelPastG_coumap','RelFutG_coumap'};
condnames1    = {'RelPastG_intmap','RelFutG_intmap'};
condnames2    = {'RelPastG_coumap','RelFutG_coumap'};
latency      = [0 1];
graphcolor   = [[1 0.6 0.6];[1 0 0];[0.7 0.6 0.6];[0.4 0 0]];
stat_test    = 'T';
chansel      = 'Mags';
clustnum     = 0;
clusttype    = 'posclust';
timetag      = '201681165932';

[ch_magi, cdn1_magi, cdn2_magi, cdn_clust_magi, stat_magi, GDAVG_magi, GDAVGt_magi] = prepare_comp_INT(niplist,condnames1,...
    condnames2,condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
condnames_clust = {'RelPastG_intmap','RelFutG_intmap','RelPastG_coumap','RelFutG_coumap'};
condnames1    = {'RelPastG_intmap','RelFutG_intmap'};
condnames2    = {'RelPastG_coumap','RelFutG_coumap'};
latency      = [1 1.8];
graphcolor   = [[1 0.6 0.6];[1 0 0];[0.7 0.6 0.6];[0.4 0 0]];
stat_test    = 'T';
chansel      = 'Mags';
clustnum     = 0;
clusttype    = 'posclust';
timetag      = '20168117177';

[ch_magi2, cdn1_magi2, cdn2_magi2, cdn_clust_magi2, stat_magi2, GDAVG_magi2, GDAVGt_magi2] = prepare_comp_INT(niplist,condnames1,...
    condnames2,condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
condnames_clust = {'RelWestG_intmap','RelEastG_intmap','RelWestG_coumap','RelEastG_coumap'};
condnames1    = {'RelWestG_intmap','RelEastG_intmap'};
condnames2    = {'RelWestG_coumap','RelEastG_coumap'};
latency      = [1 1.8];
graphcolor   = [[0.6 0.6 1];[0 0 1];[0.6 0.6 0.7];[0 0 0.4]];
stat_test    = 'T';
chansel      = 'Mags';
clustnum     = 0;
clusttype    = 'posclust';
timetag      = '201681171950';

[ch_magi3, cdn1_magi3, cdn2_magi3, cdn_clust_magi3, stat_magi3, GDAVG_magi3, GDAVGt_magi3] = prepare_comp_INT(niplist,condnames1,...
    condnames2,condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

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
lay                        = ft_prepare_layout(cfg,GDAVGt_magi{1});
lay.label                = GDAVGt_magi{1}.label;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
times = sum(stat_magi.prob <= 0.05);
plot(stat_magi.time,times)
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
    cfg.xlim               = [stat_magi.time(index) stat_magi.time(index)];
    cfg.zlim               = [-10 10]; % F-values
    cfg.colormap           = 'jet';
    cfg.style              = 'straight';
    cfg.parameter          = 'stat';
    cfg.marker             = 'off';
    cfg.highlight          = 'on';
    indchan = []; indchan  = find(stat_magi.prob(:,index) <0.05);
    cfg.highlightchannel   = stat_magi.label(indchan);
    cfg.highlightsymbol    = '.';
    cfg.highlightsize      = 20;
    cfg.comment            = num2str(stat_magi.time(index));
    ft_topoplotER(cfg,stat_magi);
    count = count +1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
times    = sum(stat_magi.prob <= 0.05);
plot(stat_magi.time,times)
[x,y]    = findpeaks(times);
indchan4 = find(stat_magi.prob(:,y(5)) <0.05);
indchanbest4 = find(abs(stat_magi.stat(:,y(5))) == max(abs(stat_magi.stat(:,y(5)))))
clust4   = find(sum(stat_magi.prob <= 0.05) > 0);

times    = sum(stat_magi2.prob <= 0.012);
plot(stat_magi2.time,times)
[x,y]    = findpeaks(times);
indchan5 = find((stat_magi2.prob(:,y(15)) <0.012).*(stat_magi2.stat(:,y(15)) >0));
indchanbest5 = find(abs(stat_magi2.stat(:,y(15))) == max(abs(stat_magi2.stat(:,y(15)))))
clust5   = find(sum(stat_magi2.prob <= 0.012) > 0);

times    = sum(stat_magi3.prob <= 0.05);
plot(stat_magi3.time,times)
[x,y]    = findpeaks(times);
indchan6 = find((stat_magi3.prob(:,y(11)) <0.05).*(stat_magi3.stat(:,y(15)) >0));
indchanbest6 = find(abs(stat_magi3.stat(:,y(11))) == max(abs(stat_magi3.stat(:,y(11)))))
clust6   = find(sum(stat_magi3.prob <= 0.05) > 0);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 1600 800]);
set(fig,'PaperPosition',[1 1 1600 800])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

fmult = 1e14; % conversion
set_axes(0.9, 2, -5,8); % define axes limit and plot properties

line([1 1],[-10 10],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on % stimulus onsets
line([1.8 1.8],[-10 10],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on % stimulus offsets

plot_lin_shade(clust4, 0.05, stat_magi,'k',4) % significance window

plot(GDAVGt_magi{1}.time,GDAVG_magi{1}.avg(indchan4(13),:)*fmult,'linewidth',8,'color',graphcolor(1,:));hold on % timecourse
plot(GDAVGt_magi{1}.time,GDAVG_magi{2}.avg(indchan4(13),:)*fmult,'linewidth',8,'color',graphcolor(2,:));hold on % timecourse
plot(GDAVGt_magi{1}.time,GDAVG_magi{3}.avg(indchan4(13),:)*fmult,'linewidth',8,'color',graphcolor(3,:));hold on % timecourse
plot(GDAVGt_magi{1}.time,GDAVG_magi{4}.avg(indchan4(13),:)*fmult,'linewidth',8,'color',graphcolor(4,:));hold on % timecourse
set(gca,'linewidth',5,'fontsize',50)
print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/Mags_Early_Map_Time')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 1600 800]);
set(fig,'PaperPosition',[1 1 1600 800])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
    
fmult = 1e14; % conversion
set_axes(0.9, 2, -8,8); % define axes limit and plot properties

line([1 1],[-10 10],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on % stimulus onsets
line([1.8 1.8],[-10 10],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on % stimulus offsets

plot_lin_shade(clust5, 0.012, stat_magi2,'k',6) % significance window

plot(GDAVGt_magi2{1}.time,GDAVG_magi2{1}.avg(indchan5(9),:)*fmult,'linewidth',8,'color',graphcolor(1,:));hold on % timecourse
plot(GDAVGt_magi2{1}.time,GDAVG_magi2{2}.avg(indchan5(9),:)*fmult,'linewidth',8,'color',graphcolor(2,:));hold on % timecourse
plot(GDAVGt_magi2{1}.time,GDAVG_magi2{3}.avg(indchan5(9),:)*fmult,'linewidth',8,'color',graphcolor(3,:));hold on % timecourse
plot(GDAVGt_magi2{1}.time,GDAVG_magi2{4}.avg(indchan5(9),:)*fmult,'linewidth',8,'color',graphcolor(4,:));hold on % timecourse
set(gca,'linewidth',5,'fontsize',50)
print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/Mags_Late_Map_Time')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 1600 800]);
set(fig,'PaperPosition',[1 1 1600 800])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
    
fmult = 1e14; % conversion
set_axes(0.9, 2, -8,8); % define axes limit and plot properties

line([1 1],[-10 10],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on % stimulus onsets
line([1.8 1.8],[-10 10],'linestyle',':','linewidth',4,'color',[0.5 0.5 0.5]); hold on % stimulus offsets

plot_lin_shade(clust6, 0.05, stat_magi3,'k',6) % significance window

plot(GDAVGt_magi3{1}.time,GDAVG_magi3{1}.avg(indchan6(14),:)*fmult,'linewidth',8,'color',graphcolor(1,:));hold on % timecourse
plot(GDAVGt_magi3{1}.time,GDAVG_magi3{2}.avg(indchan6(14),:)*fmult,'linewidth',8,'color',graphcolor(2,:));hold on % timecourse
plot(GDAVGt_magi3{1}.time,GDAVG_magi3{3}.avg(indchan6(14),:)*fmult,'linewidth',8,'color',graphcolor(3,:));hold on % timecourse
plot(GDAVGt_magi3{1}.time,GDAVG_magi3{4}.avg(indchan6(14),:)*fmult,'linewidth',8,'color',graphcolor(4,:));hold on % timecourse
set(gca,'linewidth',5,'fontsize',50)
print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/Mags_Late_Map_Space')

%% PLOT PART2
times    = sum(stat_magi.prob <= 0.05);
[x,y]    = findpeaks(times);

fig = figure('position',[1 1 400 400]);
set(fig,'PaperPosition',[1 1 400 400])
set(fig,'PaperPositionmode','auto')

index = y(5);
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat_magi.time(index) stat_magi.time(index)];
cfg.zlim               = [-5 5]; % F-values
cfg.colormap           = 'jet';
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
cfg.highlight          = {'on','on'};
cfg.highlightchannel   = {stat_magi.label(setdiff(indchan4,indchan4(13))),stat_magi.label(indchan4(13))};
cfg.highlightsymbol    = {'.','d'};
cfg.highlightsize      = {24,10} ;
cfg.highlightcolor     = {'w','w'};
cfg.comment            = num2str(stat_magi.time(index));
ft_topoplotER(cfg,stat_magi);
colorbar
print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/Mags_Early_Map_Time_topo')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PLOT PART2
times    = sum(stat_magi2.prob <= 0.05);
[x,y]    = findpeaks(times);

fig = figure('position',[1 1 400 400]);
set(fig,'PaperPosition',[1 1 400 400])
set(fig,'PaperPositionmode','auto')

index = y(15);
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat_magi2.time(index) stat_magi2.time(index)];
cfg.zlim               = [-5 5]; % F-values
cfg.colormap           = 'jet';
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
cfg.highlight          = {'on','on'};
cfg.highlightchannel   = {stat_magi2.label(setdiff(indchan5,indchan5(9))),stat_magi2.label(indchan5(9))};
cfg.highlightsymbol    = {'.','d'};
cfg.highlightsize      = {24,10} ;
cfg.highlightcolor     = {'w','w'};
cfg.comment            = num2str(stat_magi2.time(index));
ft_topoplotER(cfg,stat_magi2);
colorbar
print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/Mags_Early_Map_Time2_topo')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PLOT PART2
times    = sum(stat_magi3.prob <= 0.05);
[x,y]    = findpeaks(times);

fig = figure('position',[1 1 400 400]);
set(fig,'PaperPosition',[1 1 400 400])
set(fig,'PaperPositionmode','auto')

index = y(11);
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat_magi3.time(index) stat_magi3.time(index)];
cfg.zlim               = [-5 5]; % F-values
cfg.colormap           = 'jet';
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
cfg.highlight          = {'on','on'};
cfg.highlightchannel   = {stat_magi3.label(setdiff(indchan6,indchan6(14))),stat_magi3.label(indchan6(14))};
cfg.highlightsymbol    = {'.','d'};
cfg.highlightsize      = {24,10} ;
cfg.highlightcolor     = {'w','w'};
cfg.comment            = num2str(stat_magi3.time(index));
ft_topoplotER(cfg,stat_magi3);
colorbar
print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/Mags_Early_Map_Space_topo')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% plot barplots

% cluster pieces
t = [];
for i = 1:length(clust4)-1
    if abs(clust4(i+1) - clust4(i)) > 1
        t = [t i i+1];
    end
end

interval = [];

if length(t) >2

    Tstart(1) = find(abs( GDAVGt_magi{1}.time - stat_magi.time(clust4(1))) < 1e-6);
    Tend(1)   = find(abs( GDAVGt_magi{1}.time - stat_magi.time(clust4(t(1)))) < 1e-6);
    interval = [Tstart(1):Tend(1)];
    
    for i = 2:2:length(t)-1 
        Tstart(i/2+1) = find(abs( GDAVGt_magi{1}.time - stat_magi.time(clust4(t(i)))) < 1e-6);
        Tend(i/2+1)   = find(abs( GDAVGt_magi{1}.time - stat_magi.time(clust4(t(i+1)))) < 1e-6);
        interval = [interval Tstart(i/2+1):Tend(i/2+1)];
    end
    
    Tstart(i/2+2) = find(abs( GDAVGt_magi{1}.time - stat_magi.time(clust4(t(i)))) < 1e-6);
    Tend(i/2+2)   = find(abs( GDAVGt_magi{1}.time - stat_magi.time(clust4(end))) < 1e-6);   
    interval = [interval Tstart(i/2+2):Tend(i/2+2)];

elseif length(t) == 2
    Tstart(1) = find(abs( GDAVGt_magi{1}.time - stat_magi.time(clust4(1))) < 1e-6);
    Tend(1)   = find(abs( GDAVGt_magi{1}.time - stat_magi.time(clust4(t(1)))) < 1e-6);
    Tstart(2) = find(abs( GDAVGt_magi{1}.time - stat_magi.time(clust4(t(2)))) < 1e-6);
    Tend(2)   = find(abs( GDAVGt_magi{1}.time - stat_magi.time(clust4(end))) < 1e-6);  
    interval  = [Tstart(1):Tend(1) Tstart(2):Tend(2)];
else
    Tstart(1) = find(abs( GDAVGt_magi{1}.time - stat_magi.time(clust4(1))) < 1e-6);
    Tend(1)   = find(abs( GDAVGt_magi{1}.time - stat_magi.time(clust4(end))) < 1e-6);
    interval = [Tstart(1):Tend(1)];
    
end

data1 = mean(mean( GDAVGt_magi{1}.individual(:,indchan4,Tstart(1):Tend(1)),2),3)*fmult;
data2 = mean(mean( GDAVGt_magi{2}.individual(:,indchan4,Tstart(1):Tend(1)),2),3)*fmult;
data3 = mean(mean( GDAVGt_magi{3}.individual(:,indchan4,Tstart(1):Tend(1)),2),3)*fmult;
data4 = mean(mean( GDAVGt_magi{4}.individual(:,indchan4,Tstart(1):Tend(1)),2),3)*fmult;

%
fig = figure('position',[1 1 500 400]);
set(fig,'PaperPosition',[1 1 500 400])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

plot([0.8 1.8],[mean(data1) mean(data2)],'color','r','linestyle',':','linewidth',6);hold on
plot([1.2 2.2],[mean(data3) mean(data4)],'color',graphcolor(4,:),'linestyle',':','linewidth',6);hold on
plot(0.8,[mean(data1)],'color',graphcolor(1,:),'marker','.','markersize',100,'linestyle','none');hold on
plot(1.8,[mean(data2)],'color',graphcolor(2,:),'marker','.','markersize',100,'linestyle','none');hold on
plot(1.21,[mean(data3)],'color',graphcolor(3,:),'marker','.','markersize',100,'linestyle','none');hold on
plot(2.2,[mean(data4)],'color',graphcolor(4,:),'marker','.','markersize',100,'linestyle','none');hold on
errorbar(0.8,mean(data1),std(data1)./sqrt(19),'linestyle','none','color',graphcolor(1,:),'linewidth',3)
errorbar(1.8,mean(data2),std(data2)./sqrt(19),'linestyle','none','color',graphcolor(2,:),'linewidth',3)
errorbar(1.2,mean(data3),std(data3)./sqrt(19),'linestyle','none','color',graphcolor(3,:),'linewidth',3)
errorbar(2.2,mean(data4),std(data4)./sqrt(19),'linestyle','none','color',graphcolor(4,:),'linewidth',3)

axis([0.5 2.5 -4 2])
set(gca,'linewidth',5,'fontsize',50,'box','off')

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/PAPER_PLOTS/Mags_INT_Map_TIME_SPACE')





