function ERFstat_GeneralTF(condnames,latency,GDAVG,GDAVGt, chansel_,graphcolor,stat_test,foi,isind,varargin)

if strcmp(varargin{1}.label{1,1},'MEG0111') == 1
    chantype = 'Mags';
            ampunit = 'T';
    
    load('/neurospin/meg/meg_tmp/tools_tmp/Pipeline/pipeline/neuromag306mag_neighb.mat')
   
    
elseif strcmp(varargin{1}.label{1,1},'MEG0113') == 1 || strcmp(varargin{1}.label{1,1},'MEG0112') == 1
    chantype = 'Grads';
            ampunit = 'T';
    
    load('/neurospin/meg/meg_tmp/tools_tmp/Pipeline/pipeline/neuromag306planar_neighb.mat')
    
elseif strcmp(varargin{1}.label{1,1},'EEG001') == 1
    chantype = 'EEG';
            ampunit = 'V';
    
    
    cfg = [];
    EEG = EEG_for_layouts('Network');
    cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/eeg_64_NM20884N.lay';
    lay                       = ft_prepare_layout(cfg,GDAVG{1});
    lay.label               = EEG;
    
    cfg                          = [];
    myneighbourdist      = 0.2;
    cfg.method              = 'distance';
    cfg.channel              = EEG;
    cfg.layout                 = lay;
    cfg.minnbchan          = 2;
    cfg.neighbourdist      = myneighbourdist;
    cfg.feedback            = 'no';
    neighbours            = ft_prepare_neighbours(cfg, GDAVG{1});
    
    % to complete
end

date = clock;
timetag = [num2str(date(1)) num2str(date(2)) num2str(date(3)) ...
                  num2str(date(4)) num2str(date(5)) num2str(round(date(6)))];

[Grads1,Grads2,Mags]   = grads_for_layouts('Network');
% varargin{1}.label = Mags';
% data2.label = Mags';

% prepare layout
cfg                           = [];
if strcmp(chantype,'EEG') == 0
    cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/fieldtrip-20130901/template/layout/NM306mag.lay';
else
    cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/eeg_64_NM20884N.lay';
end
lay                        = ft_prepare_layout(cfg,varargin{1});
lay.label                  = varargin{1}.label;

%% select frequency of interest
cfg = [];
cfg.foilim = foi;
cfg.keeptrials    = 'yes';
for i =1:length(varargin)
    seldata{i} = ft_freqdescriptives(cfg,varargin{i});
end

% based on fieldtrip tutorial
rng('default') 

cfg = [];
cfg.channel                 = 'all';
cfg.latency                  = latency;
cfg.frequency              = foi;
cfg.method                 = 'montecarlo';
if strcmp(stat_test, 'Reg') ==1
    cfg.statistic                 = 'depsamplesregrT';
elseif strcmp(stat_test, 'F') ==1
    cfg.statistic                 = 'depsamplesFunivariate';
elseif strcmp(stat_test, 'T') ==1
     cfg.statistic                 = 'depsamplesT';   
end
cfg.correctm               = 'cluster';
cfg.clusteralpha           = 0.05;
cfg.clusterstatistic        = 'maxsum';
cfg.minnbchan            = 2;
if  strcmp(stat_test, 'F') ==1
    cfg.tail                        = 1;
    cfg.alpha                    = 0.05;
else
     cfg.tail                        = 0; 
     cfg.clustertail             = 0 ;
     cfg.alpha                    = 0.025;
end
cfg.numrandomization = 1000;
cfg.neighbours            = neighbours;

% design definition
design1 = [];
design2 = zeros(1,(size(seldata{1}.powspctrm,1))*length(varargin));
for i =1:length(varargin)
    ntrialdim{i} = size(seldata{1}.powspctrm,1);
    design1 = [design1 1:ntrialdim{i}];
    design2(((i-1)*ntrialdim{i}+1):(i)*ntrialdim{i}) = i;   
end

cfg.design = [];
cfg.design           = [design1; design2];
cfg.uvar  = 1;
cfg.ivar  = 2;

% stat instruction
instr = 'stat = ft_freqstatistics(cfg';
for i =1:length(varargin)
    instr = [instr ',seldata{1,' num2str(i) '}'];
end
instr = [instr ');'];
eval(instr)

%% 
% concatenante names for data saving
cdn = [];
for i = 1:length(condnames)
    cdn = [cdn condnames{i} '_'];
end

%% %%%%%%%%%%%%%%%%%%% FIXME %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % change shape of data for further use
% cfg = [];
% cfg.foilim =foi;
% for i = 1:length(varargin)
%     seg{i} = ft_freqdescriptives(cfg,GDAVGt{i});
% end
% % change shape of data for further use
% cfg = [];
% cfg.foilim =foi;
% cfg.keeptrials    = 'yes';
% for i = 1:length(varargin)
%     segt{i} = ft_freqdescriptives(cfg,GDAVGt{i});
% end

% change shape of data for further use
cfg = [];
cfg.foilim =foi;
cfg.latency = [-0.5 5];
for i = 1:length(varargin)
    seg{i} = ft_freqdescriptives(cfg,GDAVGt{i});
end
% change shape of data for further use
cfg = [];
cfg.foilim =foi;
cfg.latency = [-0.5 5];
cfg.keeptrials    = 'yes';
for i = 1:length(varargin)
    segt{i} = ft_freqdescriptives(cfg,GDAVGt{i});
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% look for positive clusters
countpos = 0;
if isfield(stat,'posclusters') == 1
    if isempty(stat.posclusters) == 0
        for k = 1:length(stat.posclusters)
            if stat.posclusters(k).prob <= 0.07 % permissive treshold to look for marginal effects
                
                fig = figure('position',[1 1 1100 1000]);
                set(fig,'PaperPosition',[1 1 1100 1000])
                set(fig,'PaperPositionmode','auto')
                set(fig,'Visible','on')
                
                % get mask of the cluster in each dimension: channel, time, frequency
                linmask  = []; linmaskt = [];
                linmask  = squeeze(nanmean(nanmean(stat.posclusterslabelmat == k,2),3) ~= 0); % spatial mask
                x = [];y = []; [x,y] = find(linmask == 1);
                linmaskt = squeeze(nanmean(nanmean(stat.posclusterslabelmat == k,1),2) ~= 0); % temporal mask
                xt = [];yt = []; [xt,yt] = find(linmaskt == 1);
                linmaskf = squeeze(nanmean(nanmean(stat.posclusterslabelmat == k,1),3) ~= 0); % frequency mask
                xf = [];yf = []; [xf,yf] = find(linmaskf == 1);
                
                offset = find(seg{1}.time == stat.time(1)) - 1;
                
                % ERF cluster
                subplot(12,11,[7:11 18:22 29:33])
                
                % estimate amplitude limit for the cluster 
                for i = 1:length(varargin)
                    min_clust(i) = nanmin(squeeze(nanmean(nanmean(seg{i}.powspctrm(x,yf,:),2),1)));
                    max_clust(i) = nanmax(squeeze(nanmean(nanmean(seg{i}.powspctrm(x,yf,:),2),1)));
                end
                
                % draw significance window
                tstart = seg{1}.time(xt(1)+offset);
                tend   = seg{1}.time(xt(end)+offset);
                rectangle('position',[tstart min(min_clust)*1.5 tend-tstart ...
                    max(max_clust)*1.5 - min(min_clust)*1.5],'FaceColor',[0.85 0.85 0.85],'EdgeColor',[0.85 0.85 0.85]); hold on
                
                                % draw test window
                line([latency(1) latency(1)],[min(min_clust)*1.5 max(max_clust)*1.5],'color','k','linestyle',':','linewidth',3);hold on
                line([latency(2) latency(2)],[min(min_clust)*1.5 max(max_clust)*1.5],'color','k','linestyle',':','linewidth',3);hold on
                
                % plot avg data on cluster 
                nsub = size(segt{1}.powspctrm,1);
                shadedErrorBar(seg{1}.time,squeeze(mean(mean(seg{1}.powspctrm(x,yf,:),1),2)),...
                squeeze(std((mean(mean(segt{1}.powspctrm(:,x,yf,:),2),3))))./sqrt(nsub),{'color',graphcolor(1,:),'linewidth',3},1);hold on
                shadedErrorBar(seg{1}.time,squeeze(mean(mean(seg{2}.powspctrm(x,yf,:),1),2)),...
                squeeze(std((mean(mean(segt{2}.powspctrm(:,x,yf,:),2),3))))./sqrt(nsub),{'color',graphcolor(2,:),'linewidth',3},1);hold on
                if length(condnames) == 3
                    shadedErrorBar(seg{1}.time,squeeze(mean(mean(seg{3}.powspctrm(x,yf,:),1),2)),...
                    squeeze(std((mean(mean(segt{3}.powspctrm(:,x,yf,:),2),3))))./sqrt(nsub),{'color',graphcolor(3,:),'linewidth',3},1);hold on
                end
                
                title(['        posclust' num2str(countpos) [', p= ' num2str(stat.posclusters(1,k).prob)]],'fontsize',14,'fontweight','b'); 
                xlabel('Time (s)','fontsize',14,'fontweight','b'); ylabel(['Amplitude (' ampunit ')'],'fontsize',14,'fontweight','b');
                set(gca, 'box','off','linewidth',2,'fontsize',14,'fontweight','b');
                axis([-0.5 5  min(min_clust)*1.5  max(max_clust)*1.5])
                
                % ERF sensor max
                [indchanx,indchany] =min(mean(mean(stat.stat.*(stat.posclusterslabelmat == k),2),3));
              
                subplot(12,11,[51:55 62:66 73:77])
                
                % estimate amplitude limit for the cluster 
                for i = 1:length(varargin)
                    min_clust(i) = nanmin(squeeze(nanmean(nanmean(seg{i}.powspctrm(indchany,yf,:),2),1)));
                    max_clust(i) = nanmax(squeeze(nanmean(nanmean(seg{i}.powspctrm(indchany,yf,:),2),1)));
                end
                
                % draw significance window
                tstart = seg{1}.time(xt(1)+offset);
                tend   = seg{1}.time(xt(end)+offset);
                rectangle('position',[tstart min(min_clust)*1.5 tend-tstart ...
                    max(max_clust)*1.5 - min(min_clust)*1.5],'FaceColor',[0.85 0.85 0.85],'EdgeColor',[0.85 0.85 0.85]); hold on
                
                                % draw test window
                line([latency(1) latency(1)],[min(min_clust)*1.5 max(max_clust)*1.5],'color','k','linestyle',':','linewidth',3);hold on
                line([latency(2) latency(2)],[min(min_clust)*1.5 max(max_clust)*1.5],'color','k','linestyle',':','linewidth',3);hold on
                
                % plot avg data on best chanel 
                nsub = size(segt{1}.powspctrm,1);
                shadedErrorBar(seg{1}.time,squeeze(mean(mean(seg{1}.powspctrm(indchany,yf,:),1),2)),...
                squeeze(std((mean(mean(segt{1}.powspctrm(:,indchany,yf,:),2),3))))./sqrt(nsub),{'color',graphcolor(1,:),'linewidth',3},1);hold on
                shadedErrorBar(seg{1}.time,squeeze(mean(mean(seg{2}.powspctrm(indchany,yf,:),1),2)),...
                squeeze(std((mean(mean(segt{2}.powspctrm(:,indchany,yf,:),2),3))))./sqrt(nsub),{'color',graphcolor(2,:),'linewidth',3},1);hold on
                if length(condnames) == 3
                    shadedErrorBar(seg{1}.time,squeeze(mean(mean(seg{3}.powspctrm(indchany,yf,:),1),2)),...
                    squeeze(std((mean(mean(segt{3}.powspctrm(:,indchany,yf,:),2),3))))./sqrt(nsub),{'color',graphcolor(3,:),'linewidth',3},1);hold on
                end
                
                xlabel('Time (s)','fontsize',14,'fontweight','b'); ylabel(['Amplitude (' ampunit ')'],'fontsize',14,'fontweight','b');
                set(gca, 'box','off','linewidth',2,'fontsize',14,'fontweight','b');
                axis([-0.5 5  min(min_clust)*1.5  max(max_clust)*1.5])
                
                subplot(12,11,[48 49 59 60])
                cfg                          = [];
                cfg.layout                 = lay;
                cfg.zlim                   = [-1e20 1e20];
                cfg.colormap            = 'jet';
                cfg.style                   = 'straight';
                cfg.parameter          = 'stat';
                cfg.marker               = 'off';
                cfg.highlight              = 'on';
                cfg.highlightchannel   = stat.label(indchany);
                cfg.highlightsymbol    = '.';
                cfg.highlightsize         = 15;
                cfg.comment              = 'no';
                ft_topoplotER(cfg,stat);
                
                subplot(12,11,[4 5 15 16])
                cfg                          = [];
                cfg.layout                 = lay;
                cfg.zlim                   = [-1e20 1e20];
                cfg.colormap            = 'jet';
                cfg.style                   = 'straight';
                cfg.parameter          = 'stat';
                cfg.marker               = 'off';
                cfg.highlight              = 'on';
                cfg.highlightchannel   = stat.label(linmask);
                cfg.highlightsymbol    = '.';
                cfg.highlightsize         = 15;
                cfg.comment              = 'no';
                ft_topoplotER(cfg,stat);
                
                % Cluster RASTER PLOT Tvalues
                subplot(12,11,[1 2 3 12 13 14 23 24 25])
                
                for i = 1:length(varargin)
                    mean_(i)  = squeeze(mean(mean(mean(seg{i}.powspctrm(x,yf,xt+offset),1),2)));
                    sem_(i)   = squeeze(std(mean(mean(mean(segt{i}.powspctrm(:,x,yf,xt+offset),2),3),4)))./sqrt(nsub);
                end
                barm = diag(mean_);
                barsd = diag(sem_);
                
                set(gcf,'Color',[1,1,1])
                for i =1:length(varargin)
                    bar(barm(i,:),'facecolor',graphcolor(i,:),'linewidth',2);
                    hold on
                end
                
                errorbar([mean_],[sem_],'linestyle','none','color','k','linewidth',2);hold on
                ylabel(['Amplitude (' ampunit ')'],'fontsize',14,'fontweight','b');
                axis([ 0 (length(varargin)+1) min([mean_ -sem_])*1.5 max([mean_ +sem_])*1.5]);
                set(gca,'xtick',1:length(varargin),'xticklabel',{''}, 'box','off','linewidth',2,'fontsize',14,'fontweight','b');
                
                % rotate instruction
                instr = 'xticklabel_rotate([1:length(varargin)],45,{';
                for i =1:length(varargin)
                    instr = [instr 'condnames{' num2str(i) '},'];
                end
                instr(end) = [];instr = [instr '},''Fontsize'',12,''fontweight'',''b'');'];
                eval(instr)
                
                % Cluster RASTER PLOT Tvalues
                subplot(12,11,[45 46 47 56 57 58 67 68 69])
                
                for i = 1:length(varargin)
                    mean_(i)  = squeeze(mean(mean(mean(seg{i}.powspctrm(indchany,yf,xt+offset),1),2)));
                    sem_(i)   = squeeze(std(mean(mean(mean(segt{i}.powspctrm(:,indchany,yf,xt+offset),2),3),4)))./sqrt(nsub);
                end
                barm = diag(mean_);
                barsd = diag(sem_);
                
                set(gcf,'Color',[1,1,1])
                for i =1:length(varargin)
                    bar(barm(i,:),'facecolor',graphcolor(i,:),'linewidth',2);
                    hold on
                end
                
                errorbar([mean_],[sem_],'linestyle','none','color','k','linewidth',2);hold on
                ylabel(['Amplitude (' ampunit ')'],'fontsize',14,'fontweight','b');
                axis([ 0 (length(varargin)+1) min([mean_ -sem_])*1.5 max([mean_ +sem_])*1.5]);
                set(gca,'xtick',1:length(varargin),'xticklabel',{''}, 'box','off','linewidth',2,'fontsize',14,'fontweight','b');
                
                % rotate instruction
                instr = 'xticklabel_rotate([1:length(varargin)],45,{';
                for i =1:length(varargin)
                    instr = [instr 'condnames{' num2str(i) '},'];
                end
                instr(end) = [];instr = [instr '},''Fontsize'',12,''fontweight'',''b'');'];
                eval(instr)
                
                lim = [-max(max(stat.stat)) max(max(stat.stat))];
                mask = (stat.posclusterslabelmat == k);
                
                sample = (stat.time(end) - stat.time(1))./length(stat.time);
                n = round(0.1/sample);
                nfull = floor(length(stat.time)/n);

                for  j = 1:1:(min(nfull,88))
                    mysubplot(12,11,j+88)
                    chansel = (stat.posclusterslabelmat(:,:,1+n*(j-1)) == k);
                    if sum(chansel) == 0
                        cfg                          = [];
                        cfg.layout                 = lay;
                        cfg.xlim                   = [round(stat.time(1+n*(j-1))*100)/100 round(stat.time(1+n*(j-1))*100)/100];
                        cfg.zlim                   = lim;
                        cfg.style                   = 'straight';
                        cfg.parameter          = 'stat';
                        cfg.marker               = 'off';
%                         cfg.comment            = [num2str(round(stat.time(1+n*(j-1))*100)/100) ];
                        cfg.comment              = 'no';
                        ft_topoplotER(cfg,stat);
                        set(gca,'fontsize',14,'fontweight','b');
                        text(0.4,0.4,[num2str(round(stat.time(1+n*(j-1))*100)/100) ],'fontsize',14,'fontweight','b');
                    else
                        [x,y] = find(chansel ~= 0);
                        cfg                           = [];
                        cfg.highlight              = 'on';
                        cfg.highlightchannel   = x;
                        cfg.highlightsymbol    = '.';
                        cfg.highlightsize         = 15;
                        cfg.layout                  = lay;
                        cfg.xlim                     = [round(stat.time(1+n*(j-1))*100)/100 round(stat.time(1+n*(j-1))*100)/100];
                        cfg.zlim                     = lim;
                        cfg.style                     = 'straight';
                        cfg.parameter            = 'stat';
                        cfg.marker                = 'off';
%                         cfg.comment              = [num2str(round(stat.time(1+n*(j-1))*100)/100) ];
                        cfg.comment              = 'no';
                        ft_topoplotER(cfg,stat);
                        text(0.4,0.4,[num2str(round(stat.time(1+n*(j-1))*100)/100) ],'fontsize',14,'fontweight','b');
                    end
                end
                
                
                folder = ['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/TFs' isind '_' num2str(foi(1)) '-' num2str(foi(2)) 'Hz/'];
                if exist([folder cdn],'dir') == 0
                    mkdir([folder cdn])
                end
                % save plots
                filename = [folder cdn '/STATS_' isind '_' chansel_ '_posclust' num2str(countpos) '_Lat' num2str(latency(1)) '-' num2str(latency(2)) '_stimlock' num2str(foi(1)) '-' num2str(foi(2)) 'Hz'];
                print('-dpng',filename)
                
                save(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/spatial_clust/TFstats_posclust_' stat_test '_'  num2str(countpos) '_' isind '_'  cdn '_' chansel_ '_Lat' num2str(latency(1)) '-' num2str(latency(2)) '_stimlock_' num2str(foi(1)) '-' num2str(foi(2)) 'Hz' '_' timetag '.mat'],'stat','chansel','condnames')              
                countpos = countpos +1;
            end
        end
    end
end

% look for negative clusters
countneg = 0;
if isfield(stat,'negclusters') == 1
    if isempty(stat.negclusters) == 0
        for k = 1:length(stat.negclusters)
            if stat.negclusters(1,k).prob < 0.07 % permissive treshold to look at marginal effects
                
                fig = figure('position',[1 1 1100 1000]);
                set(fig,'PaperPosition',[1 1 1100 1000])
                set(fig,'PaperPositionmode','auto')
                set(fig,'Visible','on')
                
                % get mask of the cluster in each dimension: channel, time, frequency
                linmask  = []; linmaskt = [];
                linmask  = squeeze(nanmean(nanmean(stat.negclusterslabelmat == k,2),3) ~= 0); % spatial mask
                x = [];y = []; [x,y] = find(linmask == 1);
                linmaskt = squeeze(nanmean(nanmean(stat.negclusterslabelmat == k,1),2) ~= 0); % temporal mask
                xt = [];yt = []; [xt,yt] = find(linmaskt == 1);
                linmaskf = squeeze(nanmean(nanmean(stat.negclusterslabelmat == k,1),3) ~= 0); % frequency mask
                xf = [];yf = []; [xf,yf] = find(linmaskf == 1);
                
                offset = find(seg{1}.time == stat.time(1)) - 1;
                
                % ERF cluster
                subplot(12,11,[7:11 18:22 29:33])
                
                % estimate amplitude limit for the cluster 
                for i = 1:length(varargin)
                    min_clust(i) = nanmin(squeeze(nanmean(nanmean(seg{i}.powspctrm(x,yf,:),2),1)));
                    max_clust(i) = nanmax(squeeze(nanmean(nanmean(seg{i}.powspctrm(x,yf,:),2),1)));
                end
                
                % draw significance window
                tstart = seg{1}.time(xt(1)+offset);
                tend   = seg{1}.time(xt(end)+offset);
                rectangle('position',[tstart min(min_clust)*1.5 tend-tstart ...
                    max(max_clust)*1.5 - min(min_clust)*1.5],'FaceColor',[0.85 0.85 0.85],'EdgeColor',[0.85 0.85 0.85]); hold on
                
                                % draw test window
                line([latency(1) latency(1)],[min(min_clust)*1.5 max(max_clust)*1.5],'color','k','linestyle',':','linewidth',3);hold on
                line([latency(2) latency(2)],[min(min_clust)*1.5 max(max_clust)*1.5],'color','k','linestyle',':','linewidth',3);hold on
                
                % plot avg data on cluster 
                nsub = size(segt{1}.powspctrm,1);
                shadedErrorBar_seb(seg{1}.time,squeeze(mean(mean(seg{1}.powspctrm(x,yf,:),1),2)),...
                squeeze(std((mean(mean(segt{1}.powspctrm(:,x,yf,:),2),3))))./sqrt(nsub),{'color',graphcolor(1,:),'linewidth',3},1);hold on
                shadedErrorBar_seb(seg{1}.time,squeeze(mean(mean(seg{2}.powspctrm(x,yf,:),1),2)),...
                squeeze(std((mean(mean(segt{2}.powspctrm(:,x,yf,:),2),3))))./sqrt(nsub),{'color',graphcolor(2,:),'linewidth',3},1);hold on
                if length(condnames) == 3
                    shadedErrorBar(seg{1}.time,squeeze(mean(mean(seg{3}.powspctrm(x,yf,:),1),2)),...
                    squeeze(std((mean(mean(segt{3}.powspctrm(:,x,yf,:),2),3))))./sqrt(nsub),{'color',graphcolor(3,:),'linewidth',3},1);hold on
                end
                
                title(['        negclust' num2str(countneg) [', p= ' num2str(stat.negclusters(1,k).prob)]],'fontsize',14,'fontweight','b'); 
                xlabel('Time (s)','fontsize',14,'fontweight','b'); ylabel(['Amplitude (' ampunit ')'],'fontsize',14,'fontweight','b');
                set(gca, 'box','off','linewidth',2,'fontsize',14,'fontweight','b');
                axis([-0.5 5  min(min_clust)*1.5  max(max_clust)*1.5])
                
                % ERF sensor max
                [indchanx,indchany] =min(mean(mean(stat.stat.*(stat.negclusterslabelmat == k),2),3));
              
                subplot(12,11,[51:55 62:66 73:77])
                
                % estimate amplitude limit for the cluster 
                for i = 1:length(varargin)
                    min_clust(i) = nanmin(squeeze(nanmean(nanmean(seg{i}.powspctrm(indchany,yf,:),2),1)));
                    max_clust(i) = nanmax(squeeze(nanmean(nanmean(seg{i}.powspctrm(indchany,yf,:),2),1)));
                end
                
                % draw significance window
                tstart = seg{1}.time(xt(1)+offset);
                tend   = seg{1}.time(xt(end)+offset);
                rectangle('position',[tstart min(min_clust)*1.5 tend-tstart ...
                    max(max_clust)*1.5 - min(min_clust)*1.5],'FaceColor',[0.85 0.85 0.85],'EdgeColor',[0.85 0.85 0.85]); hold on
                
                                % draw test window
                line([latency(1) latency(1)],[min(min_clust)*1.5 max(max_clust)*1.5],'color','k','linestyle',':','linewidth',3);hold on
                line([latency(2) latency(2)],[min(min_clust)*1.5 max(max_clust)*1.5],'color','k','linestyle',':','linewidth',3);hold on
                
                 % plot avg data on best chanel 
                nsub = size(segt{1}.powspctrm,1);
                shadedErrorBar(seg{1}.time,squeeze(mean(mean(seg{1}.powspctrm(indchany,yf,:),1),2)),...
                squeeze(std((mean(mean(segt{1}.powspctrm(:,indchany,yf,:),2),3))))./sqrt(nsub),{'color',graphcolor(1,:),'linewidth',3},1);hold on
                shadedErrorBar(seg{1}.time,squeeze(mean(mean(seg{2}.powspctrm(indchany,yf,:),1),2)),...
                squeeze(std((mean(mean(segt{2}.powspctrm(:,indchany,yf,:),2),3))))./sqrt(nsub),{'color',graphcolor(2,:),'linewidth',3},1);hold on
                if length(condnames) == 3
                    shadedErrorBar(seg{1}.time,squeeze(mean(mean(seg{3}.powspctrm(indchany,yf,:),1),2)),...
                    squeeze(std((mean(mean(segt{3}.powspctrm(:,indchany,yf,:),2),3))))./sqrt(nsub),{'color',graphcolor(3,:),'linewidth',3},1);hold on
                end
                
                xlabel('Time (s)','fontsize',14,'fontweight','b'); ylabel(['Amplitude (' ampunit ')'],'fontsize',14,'fontweight','b');
                set(gca, 'box','off','linewidth',2,'fontsize',14,'fontweight','b');
                axis([-0.5 5  min(min_clust)*1.5  max(max_clust)*1.5])
                
                subplot(12,11,[48 49 59 60])
                cfg                          = [];
                cfg.layout                 = lay;
                cfg.zlim                   = [-1e20 1e20];
                cfg.colormap            = 'jet';
                cfg.style                   = 'straight';
                cfg.parameter          = 'stat';
                cfg.marker               = 'off';
                cfg.highlight              = 'on';
                cfg.highlightchannel   = stat.label(indchany);
                cfg.highlightsymbol    = '.';
                cfg.highlightsize         = 15;
                cfg.comment              = 'no';
                ft_topoplotER(cfg,stat);
                
                subplot(12,11,[4 5 15 16])
                cfg                          = [];
                cfg.layout                 = lay;
                cfg.zlim                   = [-1e20 1e20];
                cfg.colormap            = 'jet';
                cfg.style                   = 'straight';
                cfg.parameter          = 'stat';
                cfg.marker               = 'off';
                cfg.highlight              = 'on';
                cfg.highlightchannel   = stat.label(linmask);
                cfg.highlightsymbol    = '.';
                cfg.highlightsize         = 15;
                cfg.comment              = 'no';
                ft_topoplotER(cfg,stat);
                
                % Cluster RASTER PLOT Tvalues
                subplot(12,11,[1 2 3 12 13 14 23 24 25])
                
                for i = 1:length(varargin)
                    mean_(i)  = squeeze(mean(mean(mean(seg{i}.powspctrm(x,yf,xt+offset),1),2)));
                    sem_(i)   = squeeze(std(mean(mean(mean(segt{i}.powspctrm(:,x,yf,xt+offset),2),3),4)))./sqrt(nsub);
                end
                barm = diag(mean_);
                barsd = diag(sem_);
                
                set(gcf,'Color',[1,1,1])
                for i =1:length(varargin)
                    bar(barm(i,:),'facecolor',graphcolor(i,:),'linewidth',2);
                    hold on
                end
                
                errorbar([mean_],[sem_],'linestyle','none','color','k','linewidth',2);hold on
                ylabel(['Amplitude (' ampunit ')'],'fontsize',14,'fontweight','b');
                axis([ 0 (length(varargin)+1) min([mean_ -sem_])*1.5 max([mean_ +sem_])*1.5]);
                set(gca,'xtick',1:length(varargin),'xticklabel',{''}, 'box','off','linewidth',2,'fontsize',14,'fontweight','b');
                
                % rotate instruction
                instr = 'xticklabel_rotate([1:length(varargin)],45,{';
                for i =1:length(varargin)
                    instr = [instr 'condnames{' num2str(i) '},'];
                end
                instr(end) = [];instr = [instr '},''Fontsize'',12,''fontweight'',''b'');'];
                eval(instr)
                
                % Cluster RASTER PLOT Tvalues
                subplot(12,11,[45 46 47 56 57 58 67 68 69])
                
                for i = 1:length(varargin)
                    mean_(i)  = squeeze(mean(mean(mean(seg{i}.powspctrm(indchany,yf,xt+offset),1),2)));
                    sem_(i)   = squeeze(std(mean(mean(mean(segt{i}.powspctrm(:,indchany,yf,xt+offset),2),3),4)))./sqrt(nsub);
                end
                barm = diag(mean_);
                barsd = diag(sem_);
                
                set(gcf,'Color',[1,1,1])
                for i =1:length(varargin)
                    bar(barm(i,:),'facecolor',graphcolor(i,:),'linewidth',2);
                    hold on
                end
                
                errorbar([mean_],[sem_],'linestyle','none','color','k','linewidth',2);hold on
                ylabel(['Amplitude (' ampunit ')'],'fontsize',14,'fontweight','b');
                axis([ 0 (length(varargin)+1) min([mean_ -sem_])*1.5 max([mean_ +sem_])*1.5]);
                set(gca,'xtick',1:length(varargin),'xticklabel',{''}, 'box','off','linewidth',2,'fontsize',14,'fontweight','b');
                
                % rotate instruction
                instr = 'xticklabel_rotate([1:length(varargin)],45,{';
                for i =1:length(varargin)
                    instr = [instr 'condnames{' num2str(i) '},'];
                end
                instr(end) = [];instr = [instr '},''Fontsize'',12,''fontweight'',''b'');'];
                eval(instr)
                
                lim = [-max(max(stat.stat)) max(max(stat.stat))];
                mask = (stat.negclusterslabelmat == k);
                
                sample = (stat.time(end) - stat.time(1))./length(stat.time);
                n = round(0.1/sample);
                nfull = floor(length(stat.time)/n);

                for  j = 1:1:(min(nfull,88))
                    mysubplot(12,11,j+88)
                    chansel = (stat.negclusterslabelmat(:,:,1+n*(j-1)) == k);
                    if sum(chansel) == 0
                        cfg                          = [];
                        cfg.layout                 = lay;
                        cfg.xlim                   = [round(stat.time(1+n*(j-1))*100)/100 round(stat.time(1+n*(j-1))*100)/100];
                        cfg.zlim                   = lim;
                        cfg.style                   = 'straight';
                        cfg.parameter          = 'stat';
                        cfg.marker               = 'off';
%                         cfg.comment            = [num2str(round(stat.time(1+n*(j-1))*100)/100) ];
                        cfg.comment              = 'no';
                        ft_topoplotER(cfg,stat);
                        set(gca,'fontsize',14,'fontweight','b');
                        text(0.4,0.4,[num2str(round(stat.time(1+n*(j-1))*100)/100) ],'fontsize',14,'fontweight','b');
                    else
                        [x,y] = find(chansel ~= 0);
                        cfg                           = [];
                        cfg.highlight              = 'on';
                        cfg.highlightchannel   = x;
                        cfg.highlightsymbol    = '.';
                        cfg.highlightsize         = 15;
                        cfg.layout                  = lay;
                        cfg.xlim                     = [round(stat.time(1+n*(j-1))*100)/100 round(stat.time(1+n*(j-1))*100)/100];
                        cfg.zlim                     = lim;
                        cfg.style                     = 'straight';
                        cfg.parameter            = 'stat';
                        cfg.marker                = 'off';
%                         cfg.comment              = [num2str(round(stat.time(1+n*(j-1))*100)/100) ];
                        cfg.comment              = 'no';
                        ft_topoplotER(cfg,stat);
                        text(0.4,0.4,[num2str(round(stat.time(1+n*(j-1))*100)/100) ],'fontsize',14,'fontweight','b');
                    end
                end
                
                
                folder = ['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/TFs' isind '_' num2str(foi(1)) '-' num2str(foi(2)) 'Hz/'];
                if exist([folder cdn],'dir') == 0
                    mkdir([folder cdn])
                end
                % save plots
                filename = [folder cdn '/STATS_' isind '_' chansel_ '_negclust' num2str(countneg) '_Lat' num2str(latency(1)) '-' num2str(latency(2)) '_stimlock' num2str(foi(1)) '-' num2str(foi(2)) 'Hz'];
                print('-dpng',filename)
                
                save(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/spatial_clust/TFstats_negclust_' stat_test '_'  num2str(countneg) '_' isind '_'  cdn '_' chansel_ '_Lat' num2str(latency(1)) '-' num2str(latency(2)) '_stimlock_' num2str(foi(1)) '-' num2str(foi(2)) 'Hz' '_' timetag '.mat'],'stat','chansel','condnames')
                countneg = countneg +1;
            end
        end
    end
end


