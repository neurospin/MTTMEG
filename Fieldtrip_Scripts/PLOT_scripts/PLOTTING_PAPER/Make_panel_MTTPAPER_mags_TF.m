function Make_panel_MTTPAPER_mags_TF(condnames,latency, chansel,graphcolor,stat_test)

addpath('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/PLOTTING_PAPER')

%% TEST INPUT
condnames    = {'Sproj';'Tproj'};
latency      = [1.1 2];
frequency    = [2 3];
graphcolor   = [[0 0 1];[1 0 0]];
stat_test    = 'T';
chansel      = 'Mags';
clustnum     = 0;
clusttype    = 'posclust';
timetag      = '2016518155253';
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
elseif strcmp(chansel,'cmb')
    ch = Mags; %temporary
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
instrmulti = 'ft_multiplotER(cfg,';
instrsingle = 'ft_singleplotER(cfg,';
for j = 1:length(niplist)
    datatmp{j}   = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' niplist{j} '/MegData/TFs/' cdn chansel],'timelockbase');
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
    
    instr = ['GDAVG{' num2str(i) '} = ft_freqgrandaverage(cfg,'];
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
    
    instr = ['GDAVGt{' num2str(i) '} = ft_freqgrandaverage(cfg,'];
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
%%%%%%%%%%%%%%%%%%%%%% LOAD CLUSTER STAT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear stat
if strcmp(clusttype,'negclust')
    load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/spatial_clust/TFstats_negclust_' ...
      stat_test '_' num2str(clustnum) '_' cdn '_' chansel '_Lat' num2str(latency(1)) '-' num2str(latency(2))...
         '_stimlock_' num2str(frequency(1)) '-' num2str(frequency(2)) 'Hz_' timetag '.mat'],'stat')
else
    load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/spatial_clust/TFstats_posclust_' ...
      stat_test '_' num2str(clustnum) '_' cdn '_' chansel '_Lat' num2str(latency(1)) '-' num2str(latency(2))...
         '_stimlock_' num2str(frequency(1)) '-' num2str(frequency(2)) 'Hz_' timetag '.mat'],'stat')
end

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
times1 = sum(squeeze(stat.prob(:,1,:))<= 0.05);
times2 = sum(squeeze(stat.prob(:,2,:))<= 0.05);
subplot(1,2,1);plot(stat.time,times1)
subplot(1,2,2);plot(stat.time,times2)
[x,y] = findpeaks(times1);

fig = figure('position',[1 1 1500 1000]);
set(fig,'PaperPosition',[1 1 1500 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
count = 1;
for index = y
    subplot (5,5,count)
    cfg                    = [];
    cfg.layout             = lay;
    cfg.xlim               = [stat.time(index) stat.time(index)];
    cfg.zlim               = [-5 5]; % T-values
    cfg.colormap           = 'jet';
    cfg.style              = 'straight';
    cfg.parameter          = 'stat';
    cfg.marker             = 'off';
    cfg.highlight          = 'on';
    indchan = []; indchan = find(stat.prob(:,1,index) <=0.05);
    cfg.highlightchannel   = stat.label(indchan);
    cfg.highlightsymbol    = '.';
    cfg.highlightsize      = 20;
    cfg.comment            = num2str(stat.time(index));
    ft_topoplotTFR(cfg,stat);
    count = count +1;
end
subplot (3,3,count)
cfg.colorbar = 'east';
ft_topoplotER(cfg,stat);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PLOT PART2
alpha = 0.05

times1 = sum(squeeze(stat.prob(:,1,:))<= 0.05);
times2 = sum(squeeze(stat.prob(:,2,:))<= 0.05);
subplot(1,2,1);plot(stat.time,times1)
subplot(1,2,2);plot(stat.time,times2)
[x,y] = findpeaks(times1);

fig = figure('position',[1 1 300 300]);
set(fig,'PaperPosition',[1 1 300 300])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
% statdummy = stat;
% statdummy.stat = zeros(size(stat.stat));
% cmap = colormap('gray');
index = y(1);
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat.time(index) stat.time(index)];
cfg.zlim               = [-4 4]; % F-values
cfg.colormap           = 'jet';
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.highlight          = 'on';
indchan = []; indchan = find(stat.prob(:,1,index) <alpha);
indchanbest = find(stat.stat(:,1,index) == max(stat.stat(:,1,index)));
indchan(find(indchan == indchanbest)) = [];
cfg.highlight          = {'on','on'};
cfg.highlightchannel   = {stat.label(indchan),stat.label(indchanbest)};
cfg.highlightsymbol    = {'.','.'};
cfg.highlightsize      = {30,60} ;
cfg.highlightcolor     = {'k','w'};
cfg.comment            = num2str(stat.time(index));
ft_topoplotER(cfg,stat);
print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/MISC_PLOTS/TFlowfreq_Sproj-Tproj')

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
fmult = 1e14; % for express in uV
% cluster shade
plot_clustshade(clust,alpha, stat,-2,4,[0.9 0.9 0.9])

% define axes limit and plot properties
set_axes(-0.7, 5, -2,4)

% timecourse
plot(GDAVG{1}.time,mean(GDAVG{1}.avg(indchan,:)*fmult),'linewidth',4,'color',graphcolor(1,:));hold on
plot(GDAVG{1}.time,mean(GDAVG{2}.avg(indchan,:)*fmult),'linewidth',4,'color',graphcolor(2,:));hold on
plot(GDAVG{1}.time,mean(GDAVG{3}.avg(indchan,:)*fmult),'linewidth',4,'color',graphcolor(3,:));hold on

%% cluster best chan
subplot(2,1,2)

% determine figure size base on amplitude on bets channel activity
index = y(9);
% indchanbest = find(stat.stat(:,index) == max(stat.stat(:,index)));
indchanbest = 97
valmax = max([max(GDAVG{1}.avg(indchanbest,:)) ...
         max(GDAVG{2}.avg(indchanbest,:)) ...
         max(GDAVG{3}.avg(indchanbest,:))]);
valmin = min([min(GDAVG{1}.avg(indchanbest,:)) ...
         min(GDAVG{2}.avg(indchanbest,:)) ...
         min(GDAVG{3}.avg(indchanbest,:))]);
% fmult
fmult = 1e14; % for express in uV
% cluster shade
plot_clustshade(clust,alpha, stat, -4,8,[0.9 0.9 0.9])
% define axes limit and plot properties
set_axes(-0.7, 5, -4,8)

% timecourse
plot(GDAVG{1}.time,GDAVG{1}.avg(indchanbest,:)*fmult,'linewidth',4,'color',graphcolor(1,:));hold on
plot(GDAVG{1}.time,GDAVG{2}.avg(indchanbest,:)*fmult,'linewidth',4,'color',graphcolor(2,:));hold on
plot(GDAVG{1}.time,GDAVG{3}.avg(indchanbest,:)*fmult,'linewidth',4,'color',graphcolor(3,:));hold on

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/MISC_PLOTS/mags_counterplot_timecourse')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% avg barplot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data = barplotvalmult(GDAVGt,alpha,stat,index,graphcolor,[0.3 3.7 -2 2],fmult);

fig = figure('position',[1 1 300 300]);
set(fig,'PaperPosition',[1 1 300 300])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

data = barplotval(GDAVGt,alpha,stat,index,graphcolor,[0.3 3.7 -2 2],fmult);
print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/MISC_PLOTS/mag_plot_barplot')

anova1(data)














