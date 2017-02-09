addpath('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/PLOTTING_PAPER')

%% TEST INPUT
condnames       = {'QsWest';'QsPar';'QsEast'};
condnames_clust = {'QsWest';'QsPar';'QsEast'};
latency         = [0 1];
graphcolor      = [[0.7 0.7 1];[0 0 0];[0 0 1]];
% stat_test       = 'F';
chansel         = 'EEG';
clustnum        = 1;
clusttype       = 'negclust';
timetag         = '201633012558';
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

% concatenated names
cdn = [];
for i = 1:length(condnames)
    cdn = [cdn condnames{i} '_'];
end
cdn_clust = [];
for i = 1:length(condnames_clust)
    cdn_clust = [cdn_clust condnames_clust{i} '_'];
end

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
%%%%%%%%%%%%%%%%%%%%%% LOAD CLUSTER STAT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear stat
if strcmp(clusttype,'negclust')
    load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/spatial_clust_from_mne/stats_negclust_' ...
       num2str(clustnum) '_' cdn_clust '_' chansel '_Lat' num2str(latency(1)) '-' num2str(latency(2))...
        '_stimlock_' timetag '.mat'],'stat')
else
    load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/spatial_clust_from_mne/stats_posclust_' ...
      num2str(clustnum) '_' cdn_clust '_' chansel '_Lat' num2str(latency(1)) '-' num2str(latency(2))...
         '_stimlock_' timetag '.mat'],'stat')
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
times = sum(stat.prob <= 0.05);
plot(stat.time,times)
[x,y] = findpeaks(times);

fig = figure('position',[1 1 1000 1000]);
set(fig,'PaperPosition',[1 1 1000 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

count = 1;
for index = y

subplot(5,5,count)
    
    cmap                   = colormap('jet');
    cfg                    = [];
    cfg.layout             = lay;
    cfg.xlim               = [stat.time(index) stat.time(index)];
    cfg.zlim               = [-10 10]; % F-values
    cfg.style              = 'straight';
    cfg.colormap           = 'jet';
    cfg.parameter          = 'stat';
    cfg.marker             = 'off';
    cfg.highlight          = 'on';
    indchan = []; indchan = find(stat.prob(:,index) <0.05);
    cfg.highlight          = {'on','on'};
    cfg.highlightchannel   = {stat.label(indchan),stat.label(indchan)};
    cfg.highlightsymbol    = {'.','.'};
    cfg.highlightsize      = {30,30} ;
    cfg.highlightcolor     = {'k','k'};
    cfg.comment            = num2str(stat.time(index));
    ft_topoplotER(cfg,stat);
    count = count + 1;
end

%% PLOT PART2
alpha = 0.05

times = sum(stat.prob <= alpha);
plot(stat.time,times)
[x,y] = findpeaks(times);

fig = figure('position',[1 1 400 400]);
set(fig,'PaperPosition',[1 1 400 400])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
index = y(2);
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat.time(index) stat.time(index)];
cfg.zlim               = [-10 10]; % F-values
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.colormap           = 'jet';
cfg.highlight          = 'on';
indchan = []; indchan = find(stat.prob(:,index) <alpha);
indchanbest = find(stat.stat(:,index) == max(stat.stat(:,index)));
indchan(find(indchan == indchanbest)) = [];
cfg.highlight          = {'on','on'};
cfg.highlightchannel   = {stat.label(indchan),stat.label(indchanbest)};
cfg.highlightsymbol    = {'.','.'};
cfg.highlightsize      = {30,30} ;
cfg.highlightcolor     = {'k','k'};
cfg.comment            = num2str(stat.time(index));
ft_topoplotER(cfg,stat);
print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/MISC_PLOTS/Qt_SPACE_Fmap_EEG_REG_clust1')

%% PLOT PART2
alpha = 0.05

times = sum(stat.prob <= alpha);
plot(stat.time,times)
[x,y] = findpeaks(times);

fig = figure('position',[1 1 400 400]);
set(fig,'PaperPosition',[1 1 400 400])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
index = y(4);
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat.time(index) stat.time(index)];
cfg.zlim               = [-10 10]; % F-values
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.colormap           = 'jet';
cfg.highlight          = 'on';
indchan = []; indchan = find(stat.prob(:,index) <alpha);
indchanbest = find(stat.stat(:,index) == max(stat.stat(:,index)));
indchan(find(indchan == indchanbest)) = [];
cfg.highlight          = {'on','on'};
cfg.highlightchannel   = {stat.label(indchan),stat.label(indchanbest)};
cfg.highlightsymbol    = {'.','.'};
cfg.highlightsize      = {30,30} ;
cfg.highlightcolor     = {'k','k'};
cfg.comment            = num2str(stat.time(index));
ft_topoplotER(cfg,stat);
print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/MISC_PLOTS/Qt_SPACE_Fmap_EEG_REG_clust2')

%% PLOT PART2
alpha = 0.05

times = sum(stat.prob <= alpha);
plot(stat.time,times)
[x,y] = findpeaks(times);

fig = figure('position',[1 1 400 400]);
set(fig,'PaperPosition',[1 1 400 400])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
index = y(9);
cfg                    = [];
cfg.layout             = lay;
cfg.xlim               = [stat.time(index) stat.time(index)];
cfg.zlim               = [-10 10]; % F-values
cfg.style              = 'straight';
cfg.parameter          = 'stat';
cfg.marker             = 'off';
cfg.colormap           = 'jet';
cfg.highlight          = 'on';
indchan = []; indchan = find(stat.prob(:,index) <alpha);
indchanbest = find(stat.stat(:,index) == max(stat.stat(:,index)));
indchan(find(indchan == indchanbest)) = [];
cfg.highlight          = {'on','on'};
cfg.highlightchannel   = {stat.label(indchan),stat.label(indchanbest)};
cfg.highlightsymbol    = {'.','.'};
cfg.highlightsize      = {30,30} ;
cfg.highlightcolor     = {'k','k'};
cfg.comment            = num2str(stat.time(index));
ft_topoplotER(cfg,stat);
print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/MISC_PLOTS/Qt_SPACE_Fmap_EEG_REG_clust3')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PLOT PART2
alpha = 0.05

times = sum(stat.prob <= alpha);
plot(stat.time,times)
[x,y] = findpeaks(times);

fig = figure('position',[1 1 200 200]);
set(fig,'PaperPosition',[1 1 200 200])
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
cfg.highlightsize      = {20,20} ;
cfg.highlightcolor     = {'k','k'};
cfg.comment            = num2str(stat.time(index));
ft_topoplotER(cfg,statdummy);
print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/MISC_PLOTS/dummytopo_grad1_small')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% timecourses cluster
alpha = 0.05;

fig = figure('position',[1 1 1000 600]);
set(fig,'PaperPosition',[1 1 1000 600])
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
fmult = 1e6; % for express in uV
% cluster shade
plot_clustshade(clust,alpha, stat,-2,4,[0.9 0.9 0.9])

% define axes limit and plot properties
set_axes(-0.7, 1.5, -1,3)

% stimulus onsets
line([0 0],[-1.5 3],'linestyle',':','linewidth',3,'color',[0.3 0.3 0.3]); hold on
line([1 1],[-1.5 3],'linestyle',':','linewidth',3,'color',[0.3 0.3 0.3]); hold on

% timecourse
plot(GDAVG{1}.time,mean(GDAVG{1}.avg(indchan,:)*fmult),'linewidth',6,'color',graphcolor(1,:));hold on
plot(GDAVG{1}.time,mean(GDAVG{2}.avg(indchan,:)*fmult),'linewidth',6,'color',graphcolor(2,:));hold on
plot(GDAVG{1}.time,mean(GDAVG{3}.avg(indchan,:)*fmult),'linewidth',6,'color',graphcolor(3,:));hold on

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
fmult = 1e6; % for express in uV
% cluster shade
plot_clustshade(clust,alpha, stat, -2,4,[0.9 0.9 0.9])
% define axes limit and plot properties
set_axes(-0.7, 5, -2,4)

% timecourse
plot(GDAVG{1}.time,GDAVG{1}.avg(indchanbest,:)*fmult,'linewidth',4,'color',graphcolor(1,:));hold on
plot(GDAVG{1}.time,GDAVG{2}.avg(indchanbest,:)*fmult,'linewidth',4,'color',graphcolor(2,:));hold on
plot(GDAVG{1}.time,GDAVG{3}.avg(indchanbest,:)*fmult,'linewidth',4,'color',graphcolor(3,:));hold on

print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/MISC_PLOTS/eeg_counterplot_timecourse')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% avg barplot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 300 400]);
set(fig,'PaperPosition',[1 1 300 400])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

data = barplotval(GDAVGt,alpha,stat,index,graphcolor,[0.3 3.7 -1 1],fmult);
print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/MISC_PLOTS/eeg_counterplot_barplot')

% write for analysis in R
datafolder = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/for_R_data'

DataMat   = [[data(:,1);data(:,2);data(:,3) ]...
            [ones(19,1); ones(19,1)*2; ones(19,1)*3]...
            [1:19 1:19 1:19]'];
CondNames = {'Amplitude','Sref','Subject'}
write_csv_for_anova_R(DataMat, CondNames, [datafolder '/EEG_QSSREF'])

fig = figure('position',[1 1 300 500]);
set(fig,'PaperPosition',[1 1 300 500])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

plot(1, mean(data(:,1)),'color',graphcolor(1,:),'marker','.','markersize',50,'linewidth',4);hold on
plot(2, mean(data(:,2)),'color',graphcolor(2,:),'marker','.','markersize',50,'linewidth',4);hold on
plot(3, mean(data(:,3)),'color',graphcolor(3,:),'marker','.','markersize',50,'linewidth',4);hold on
errorbar(1,mean(data(:,1)),std(data(:,1))./sqrt(19),'linestyle','none','color',graphcolor(1,:),'linewidth',3)
errorbar(2,mean(data(:,2)),std(data(:,2))./sqrt(19),'linestyle','none','color',graphcolor(2,:),'linewidth',3)
errorbar(3,mean(data(:,3)),std(data(:,3))./sqrt(19),'linestyle','none','color',graphcolor(3,:),'linewidth',3)

axis([0 4 -1 1.5])

set(gca, 'box','off','linewidth',2,'fontsize',14,'fontweight','b');
print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/MISC_PLOTS/panel/EEG_cluster_QSSREF')




