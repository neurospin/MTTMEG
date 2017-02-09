
%% TEST INPUT
condnames    = {'RefPast';'RefPre';'RefFut'};
latency      = [0.3 1.1];
graphcolor   = [[1 0.7 0.7];[0 0 0];[1 0 0]];
stat_test    = 'F';
chansel      = 'Grads1';
clustnum     = 0;
clusttype    = 'posclust';
%timetag      = '201632612299';
timetag      = '201632662253';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% PREPARE COMPUTATIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% define channel types
[Grads1,Grads2,Mags]   = grads_for_layouts('Network');
EEG  = EEG_for_layouts('Network');

ch = [];
if strcmp(chansel,'Mags')
    ch = Mags;
elseif strcmp(chansel,'Grads1')
    ch = Grads1;
elseif strcmp(chansel,'Grads2')
    ch = Grads2;
elseif strcmp(chansel,'GradComb')
    ch = Mags;
else strcmp(chansel,'EEG')
    ch = EEG;
end

% selection
if length(condnames) > 2
    statstag = 'F';
else
    statstag = 'T';
end

% switch from separated to concatenated names
cdn = [];
for i = 1:length(condnames)
    cdn = [cdn condnames{i} '_'];
end

% load cell array of conditions
% for j = 1:length(niplist)
%     datatmp{j}   = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' niplist{j} '/MegData/ERPs_from_mne/' cdn chansel],'timelockbase');
%     for k = 1:length(condnames)
%         datatmp{j}.timelockbase{1,k}.label = Mags ;
%     end
% end

% load cell array of conditions
for j = 1:length(niplist)
    datatmp{j}   = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' ...
                        niplist{j} '/MegData/ERPs_from_mne/' cdn chansel],'timelockbase');
end

close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% COMPUTE ERFS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:length(datatmp{1,1}.timelockbase)
    
    % for plot
    cfg                             = [];
    cfg.channel                 = ch;
    cfg.trials                     = 'all';
    cfg.keepindividual       = 'no';
    cfg.removemean         = 'yes';
    cfg.covariance             = 'yes';
    
    instr = ['GDAVG{' num2str(i) '} = ft_timelockgrandaverage(cfg,'];
    for j = 1:length(datatmp)
        instr = [instr 'datatmp{1,' num2str(j)  '}.timelockbase{1,' num2str(i) '},'];
    end
    instr(end) = [];
    instr      = [instr ');'];
    
    eval([instr]);
    
    % for stats
    cfg                             = [];
    cfg.channel                 = ch;
    cfg.trials                     = 'all';
    cfg.keepindividual       = 'yes';
    cfg.removemean         = 'yes';
    cfg.covariance             = 'yes';
    
    instr = ['GDAVGt{' num2str(i) '} = ft_timelockgrandaverage(cfg,'];
    for j = 1:length(datatmp)
        instr = [instr 'datatmp{1,' num2str(j)  '}.timelockbase{1,' num2str(i) '},'];
    end
    instr(end) = [];
    instr      = [instr ');'];
    
    eval([instr]);
    
    instr = [];
    instr = ['GDAVGt{' num2str(i) '} = rmfield(GDAVGt{' num2str(i) '},''cfg'''];
    instr      = [instr ');'];
    
    eval([instr]);
    
    instr = [];
    instr = ['GDAVG{' num2str(i) '} = rmfield(GDAVG{' num2str(i) '},''cfg'''];
    instr      = [instr ');'];
    
    eval([instr]);
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear stat
if strcmp(clusttype,'negclust')
    load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/spatial_clust_from_mne/stats_negclust_' ...
        num2str(clustnum) '_' cdn '_' chansel '_Lat' num2str(latency(1)) '-' num2str(latency(2))...
        '_stimlock_' timetag '.mat'],'stat')
else
    load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/spatial_clust_from_mne/stats_posclust_' ...
       num2str(clustnum) '_' cdn '_' chansel '_Lat' num2str(latency(1)) '-' num2str(latency(2))...
        '_stimlock_' timetag '.mat'],'stat')
end

stat.label = Grads1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%% EXPLORATION OF THE BEST PLOTTING MODE %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PLOT TOPO SERIES
% parameters
TimeOfInterest1 = [0 0.14 0.22 0.3 0.35 0.5 0.8 1];
TimeOfInterest2 = [1.5 2 2.4 2.8 3.2 3.8 4.2 4.8];

% select sensor datatype
[Grads1,Grads2,Mags]   = grads_for_layouts('Network');

% prepare layout
cfg                           = [];
if strcmp(chansel,'EEG') == 0
    cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/fieldtrip-20130901/template/layout/NM306mag.lay';
else
    cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/eeg_64_NM20884N.lay';
end
lay                        = ft_prepare_layout(cfg,GDAVGt{1});
lay.label                = GDAVGt{1}.label;

fig = figure('position',[1 1 1400 1000]);
set(fig,'PaperPosition',[1 1 1400 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%% THE BEST PLOTTING MODE %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
lay                        = ft_prepare_layout(cfg,GDAVGt{1});
lay.label                = GDAVGt{1}.label;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% EXPLORATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot spatiotemporal structure of the cluster
% and get highest cluster covergae and the corresponding time
times = sum(stat.prob <= 0.05);
plot(stat.time,times)
[x,y] = findpeaks(times);

fig = figure('position',[1 1 1500 1000]);
set(fig,'PaperPosition',[1 1 1500 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
count = 1;
for index = y
    subplot (3,3,count)
    cfg                    = [];
    cfg.layout             = lay;
    cfg.xlim               = [stat.time(index) stat.time(index)];
    cfg.zlim               = [-10 10]; % F-values
    cfg.colormap           = 'jet';
    cfg.style              = 'straight';
    cfg.parameter          = 'stat';
    cfg.marker             = 'off';
    cfg.highlight          = 'on';
    indchan = []; indchan = find(stat.prob(:,index) <0.05);
    cfg.highlightchannel   = stat.label(indchan);
    cfg.highlightsymbol    = '.';
    cfg.highlightsize      = 20;
    cfg.comment            = num2str(stat.time(index));
    ft_topoplotER(cfg,stat);
    count = count +1;
end
subplot (3,3,count)
cfg.colorbar = 'east';
ft_topoplotER(cfg,stat);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 300 300]);
set(fig,'PaperPosition',[1 1 300 300])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

index = y(4)
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat.time(index) stat.time(index)];
cfg.zlim               = [-10 10]; % F-values
cfg.colormap           = 'jet';
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
indchan = []; indchan = find(stat.prob(:,index) <0.05);
cfg.highlightchannel   = stat.label(indchan);
cfg.highlightsymbol    = '.';
cfg.highlightsize      = 20;
cfg.comment            = num2str(stat.time(index));
ft_topoplotER(cfg,stat);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PLOT PART2
alpha = 0.05

times = sum(stat.prob <= alpha);
plot(stat.time,times)
[x,y] = findpeaks(times);

fig = figure('position',[1 1 400 400]);
set(fig,'PaperPosition',[1 1 400 400])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
statdummy = stat;
statdummy.stat = zeros(size(stat.stat));
cmap = colormap('gray');
index = y(4);
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat.time(index) stat.time(index)];
cfg.zlim               = [-10 10]; % F-values
cfg.colormap           = cmap;
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
indchan = []; indchan = find(stat.prob(:,index) <alpha);
indchanbest = find(stat.stat(:,index) == max(stat.stat(:,index)));
indchan(find(indchan == indchanbest)) = [];
cfg.highlight          = {'on','on'};
cfg.highlightchannel   = {stat.label(indchan),stat.label(indchanbest)};
cfg.highlightsymbol    = {'.','.'};
cfg.highlightsize      = {30,60} ;
cfg.highlightcolor     = {'k','w'};
cfg.comment            = num2str(stat.time(index));
ft_topoplotER(cfg,statdummy);
print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/MISC_PLOTS/dummytopo_grad1')
ft_topoplotER(cfg,statdummy);
print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/MISC_PLOTS/dummytopo_grad1')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% timecourses cluster
alpha = 0.05;

fig = figure('position',[1 1 1600 1100]);
set(fig,'PaperPosition',[1 1 1600 1100])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

%% cluster avg
subplot(2,1,1)

% determine figure size base on amplitude on avg cluster activity
clust  = find(sum(stat.prob <= alpha) > 0);
indchan = []; indchan = find(stat.prob(:,index) <alpha);
valmax = max([max(mean(GDAVG{1}.avg(indchan,:))) ...
         max(mean(GDAVG{2}.avg(indchan,:))) ...
         max(mean(GDAVG{3}.avg(indchan,:)))]);
valmin = min([min(mean(GDAVG{1}.avg(indchan,:))) ...
         min(mean(GDAVG{2}.avg(indchan,:))) ...
         min(mean(GDAVG{3}.avg(indchan,:)))]);
% fmult
fmult = 1e12; % for express in uV
% cluster shade
plot_clustshade(clust,alpha, stat,-2,4,[0.9 0.9 0.9])

% define axes limit and plot properties
set_axes(-0.7, 5, -0.5,1)

% timecourse
plot(GDAVG{1}.time,mean(GDAVG{1}.avg(indchan,:)*fmult),'linewidth',4,'color',graphcolor(1,:));hold on
plot(GDAVG{1}.time,mean(GDAVG{2}.avg(indchan,:)*fmult),'linewidth',4,'color',graphcolor(2,:));hold on
plot(GDAVG{1}.time,mean(GDAVG{3}.avg(indchan,:)*fmult),'linewidth',4,'color',graphcolor(3,:));hold on

%% cluster best chan
subplot(2,1,2)

% determine figure size base on amplitude on bets channel activity
index = y(4);
indchanbest = find(stat.stat(:,index) == max(stat.stat(:,index)));
valmax = max([max(GDAVG{1}.avg(indchanbest,:)) ...
         max(GDAVG{2}.avg(indchanbest,:)) ...
         max(GDAVG{3}.avg(indchanbest,:))]);
valmin = min([min(GDAVG{1}.avg(indchanbest,:)) ...
         min(GDAVG{2}.avg(indchanbest,:)) ...
         min(GDAVG{3}.avg(indchanbest,:))]);
% fmult
fmult = 1e14; % for express in uV
% cluster shade
plot_clustshade(clust,alpha, stat, -2,4,[0.9 0.9 0.9])
% define axes limit and plot properties
set_axes(-0.7, 5, -2,4)

% timecourse
plot(GDAVG{1}.time,GDAVG{1}.avg(indchanbest,:)*fmult,'linewidth',4,'color',graphcolor(1,:));hold on
plot(GDAVG{1}.time,GDAVG{2}.avg(indchanbest,:)*fmult,'linewidth',4,'color',graphcolor(2,:));hold on
plot(GDAVG{1}.time,GDAVG{3}.avg(indchanbest,:)*fmult,'linewidth',4,'color',graphcolor(3,:));hold on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
alpha = 0.05;

fig = figure('position',[1 1 1500 600]);
set(fig,'PaperPosition',[1 1 1500 600])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

% determine figure size base on amplitude on avg cluster activity
clust  = find(sum(stat.prob <= alpha) > 0);
indchan = []; indchan = find(stat.prob(:,index) <alpha);
valmax = max([max(mean(GDAVG{1}.avg(indchan,:))) ...
         max(mean(GDAVG{2}.avg(indchan,:))) ...
         max(mean(GDAVG{3}.avg(indchan,:)))]);
valmin = min([min(mean(GDAVG{1}.avg(indchan,:))) ...
         min(mean(GDAVG{2}.avg(indchan,:))) ...
         min(mean(GDAVG{3}.avg(indchan,:)))]);
% fmult
fmult = 1e12; % for express in uV

% stimulus onsets
line([0 0]    ,[-3 6],'linestyle',':','linewidth',3,'color',[0.5 0.5 0.5]); hold on
line([1.1 1.1],[-3 6],'linestyle',':','linewidth',3,'color',[0.5 0.5 0.5]); hold on
line([2.2 2.2],[-3 6],'linestyle',':','linewidth',3,'color',[0.5 0.5 0.5]); hold on
line([3.4 3.4],[-3 6],'linestyle',':','linewidth',3,'color',[0.5 0.5 0.5]); hold on

% cluster shade
[list_start1, list_end1] = plot_clustshade(clust,alpha, stat,-2,4,[0.5 0.5 0.5])

% define axes limit and plot properties
set_axes(-0.7, 5, -0.5,1)

% timecourse
plot(GDAVG{1}.time,mean(GDAVG{1}.avg(indchan,:)*fmult),'linewidth',5,'color',graphcolor(1,:));hold on
plot(GDAVG{1}.time,mean(GDAVG{2}.avg(indchan,:)*fmult),'linewidth',5,'color',graphcolor(2,:));hold on
plot(GDAVG{1}.time,mean(GDAVG{3}.avg(indchan,:)*fmult),'linewidth',5,'color',graphcolor(3,:));hold on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% avg barplot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data = barplotvalmult(GDAVGt,alpha,stat,index,graphcolor,[0.3 3.7 -2 2],fmult);


fig = figure('position',[1 1 300 500]);
set(fig,'PaperPosition',[1 1 300 500])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

dat{1} = data
plot(1, mean(dat{1}(:,1)),'color',graphcolor(1,:),'marker','.','markersize',50,'linewidth',4);hold on
plot(2, mean(dat{1}(:,2)),'color',graphcolor(2,:),'marker','.','markersize',50,'linewidth',4);hold on
plot(3, mean(dat{1}(:,3)),'color',graphcolor(3,:),'marker','.','markersize',50,'linewidth',4);hold on
errorbar(1,mean(dat{1}(:,1)),std(dat{1}(:,1))./sqrt(19),'linestyle','none','color',graphcolor(1,:),'linewidth',3)
errorbar(2,mean(dat{1}(:,2)),std(dat{1}(:,2))./sqrt(19),'linestyle','none','color',graphcolor(2,:),'linewidth',3)
errorbar(3,mean(dat{1}(:,3)),std(dat{1}(:,3))./sqrt(19),'linestyle','none','color',graphcolor(3,:),'linewidth',3)
set(gca, 'box','off','linewidth',2,'fontsize',14,'fontweight','b');
print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/MISC_PLOTS/panel/avg_cluster_grad')

% write for analysis in R
datafolder = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/for_R_data'

DataMat   = [[dat{1}(:,1);dat{1}(:,2);dat{1}(:,3) ]...
            [ones(19,1); ones(19,1)*2; ones(19,1)*3]...
            [1:19 1:19 1:19]'];
CondNames = {'Amplitude','Tref','Subject'}
write_csv_for_anova_R(DataMat, CondNames, [datafolder '/Grads_TREF'])


