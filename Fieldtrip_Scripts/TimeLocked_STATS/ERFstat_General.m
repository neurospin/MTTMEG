function ERFstat_General(condnames,latency,GDAVG,GDAVGt, chansel_,graphcolor,varargin)

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

% based on fieldtrip tutorial
cfg = [];
cfg.channel                 = 'all';
cfg.latency                  = latency;
cfg.frequency              = 'all';
cfg.method                 = 'montecarlo';
if length(varargin) >2
    cfg.statistic                 = 'depsamplesregrT';
else
    cfg.statistic                 = 'depsamplesT';
end
cfg.correctm               = 'cluster';
cfg.clusteralpha           = 0.05;
cfg.clusterstatistic        = 'maxsum';
cfg.minnbchan            = 2;
cfg.tail                        = 0;
cfg.clustertail              = 0;
cfg.alpha                    = 0.025;
cfg.numrandomization = 2000;
cfg.neighbours            = neighbours;

% design definition
design1 = [];
design2 = zeros(1,(size(varargin{1}.individual,1))*length(varargin));
for i =1:length(varargin)
    ntrialdim{i} = size(varargin{1}.individual,1);
    design1 = [design1 1:ntrialdim{i}];
    design2(((i-1)*ntrialdim{i}+1):(i)*ntrialdim{i}) = i;   
end

cfg.design = [];
cfg.design           = [design1; design2];
cfg.uvar  = 1;
cfg.ivar  = 2;

% stat instruction
instr = 'stat = ft_timelockstatistics(cfg';
for i =1:length(varargin)
    instr = [instr ',varargin{' num2str(i) '}'];
end
instr = [instr ');'];
eval(instr)

%% 
% concatenante names for data saving
cdn = [];
for i = 1:length(condnames)
    cdn = [cdn condnames{i} '_'];
end

% change shape of data for further use
cfg.minlength = 'maxperlen';
for i = 1:length(varargin)
    seg{i} = ft_redefinetrial(cfg,GDAVGt{i});
end

% look for positive clusters
countpos = 0;
if isfield(stat,'posclusters') == 1
    if isempty(stat.posclusters) == 0
        for k = 1:length(stat.posclusters)
            if stat.posclusters(1,k).prob < 0.07 % permissive treshold to look for marginal effects
                
                fig = figure('position',[1 1 1100 1000]);
                set(fig,'PaperPosition',[1 1 1100 1000])
                set(fig,'PaperPositionmode','auto')
                set(fig,'Visible','on')
                
                linmask  = []; linmaskt = [];
                linmask  = (sum((stat.posclusterslabelmat == k)') ~= 0); % spatial mask
                x = [];y = []; [x,y] = find(linmask == 1);
                linmaskt = (sum((stat.posclusterslabelmat == k)) ~= 0); % temporal mask
                xt = [];yt = []; [xt,yt] = find(linmaskt == 1);
                
                offset = find(seg{i}.time == stat.time(1)); % time delay between data.time and stat.time (aka baseline, usually)
                
                % ERF cluster
                subplot(12,11,[7:11 18:22 29:33])
                
                for i = 1:length(varargin)
                    min_clust(i) = min(mean(mean(seg{i}.trial(:,y,:),1),2));
                    max_clust(i) = max(mean(mean(seg{i}.trial(:,y,:),1),2));
                end
                
                cfg                          = [];
                cfg.ylim                   = [min([min_clust])*1.2 max([max_clust])*1.2];
                cfg.graphcolor         = graphcolor;
                cfg.linewidth            = 3;
                cfg.channel              = stat.label(linmask);
                
                % plot instruction
                instr = 'ft_singleplotER(cfg';
                for i =1:length(varargin)
                    instr = [instr ',GDAVG{' num2str(i) '}'];
                end
                instr = [instr ');'];
                eval(instr)
                
                linenim = stat.time(linmaskt);
                line([linenim(1) linenim(end)],[ min([min_clust])*1.1 min([min_clust])*1.1],'linewidth',2,'color','k')
                title(['        posclust' num2str(countpos) [', p= ' num2str(stat.posclusters(1,k).prob)]],'fontsize',14,'fontweight','b'); 
                xlabel('Time (s)','fontsize',14,'fontweight','b'); ylabel(['Amplitude (' ampunit ')'],'fontsize',14,'fontweight','b');
                set(gca, 'box','off','linewidth',2,'fontsize',14,'fontweight','b');

                % ERF sensor max
                [indchanx,indchany] = find(stat.stat == max(max(stat.stat.*(stat.posclusterslabelmat == k))));
                
                subplot(12,11,[51:55 62:66 73:77])
                
                for i = 1:length(varargin)
                    min_bestch(i)  = min(mean(mean(seg{i}.trial(:,indchanx,:),1),2));
                    max_bestch(i) = max(mean(mean(seg{i}.trial(:,indchanx,:),1),2));
                end
                
                cfg                          = [];
                cfg.ylim                   = [min([min_bestch])*1.2 max([max_bestch])*1.2];
                cfg.graphcolor         = graphcolor;
                cfg.linewidth            = 3;
                cfg.channel              = stat.label(indchanx);
                
                % plot instruction
                instr = 'ft_singleplotER(cfg';
                for i =1:length(varargin)
                    instr = [instr ',GDAVG{' num2str(i) '}'];
                end
                instr = [instr ');'];
                eval(instr)
                
                linenim = stat.time(linmaskt);
                line([linenim(1) linenim(end)],[ min([min_bestch])*1.1 min([min_bestch])*1.1],'linewidth',2,'color','k')
                title(['best channel'],'fontsize',14,'fontweight','b');
                xlabel('Time (s)','fontsize',14,'fontweight','b'); ylabel(['Amplitude (' ampunit ')'],'fontsize',14,'fontweight','b');
                set(gca, 'box','off','linewidth',2,'fontsize',14,'fontweight','b');
                
                subplot(12,11,[48 49 59 60])
                cfg                          = [];
                cfg.layout                 = lay;
                cfg.zlim                   = [-1e20 1e20];
                cfg.colormap            = 'jet';
                cfg.style                   = 'straight';
                cfg.parameter          = 'stat';
                cfg.marker               = 'off';
                cfg.highlight              = 'on';
                cfg.highlightchannel   = stat.label(indchanx);
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
                    mean_(i)  = mean(mean(mean(seg{i}.trial(:,y,yt+offset))));
                    sem_(i)   = std(mean(mean(seg{1}.trial(:,y,yt+offset),2),3),0,1)/sqrt(size(seg{1}.trial,1));
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
                axis([ 0 (length(varargin)+1) min([mean_ -sem_])*1.2 max([mean_ +sem_])*1.5]);
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
                    mean_(i)  = mean(mean(mean(seg{i}.trial(:,indchanx,yt+offset))));
                    sem_(i)   = std(mean(mean(seg{1}.trial(:,indchanx,yt+offset),2),3),0,1)/sqrt(size(seg{1}.trial,1));
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
                axis([ 0 (length(varargin)+1) min([mean_ -sem_])*1.2 max([mean_ +sem_])*1.5]);
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

                for  j = 1:1:(min(nfull+1,88))
                    mysubplot(12,11,j+88)
                    chansel = (stat.posclusterslabelmat(:,1+n*(j-1)) == k);
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
                
                
                folder = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/ERFPs/';
                if exist([folder cdn],'dir') == 0
                    mkdir([folder cdn])
                end
                % save plots
                filename = [folder cdn '/STATS_' chansel_ '_posclust' num2str(countpos) '_Lat' num2str(latency(1)) '-' num2str(latency(2)) '_stimlock'];
                print('-dpng',filename)
                
                save(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/spatial_clust/stats_posclust_' num2str(countpos) '_' cdn '_' chansel_ '_Lat' num2str(latency(1)) '-' num2str(latency(2)) '_stimlock.mat'],'stat','chansel','condnames')
              
                countpos = countpos +1;
            end
        end
    end
end

% look for positive clusters
countneg = 0;
if isfield(stat,'negclusters') == 1
    if isempty(stat.negclusters) == 0
        for k = 1:length(stat.negclusters)
            if stat.negclusters(1,k).prob < 0.07 % permissive treshold to look for marginal effects
                
                fig = figure('position',[1 1 1100 1000]);
                set(fig,'PaperPosition',[1 1 1100 1000])
                set(fig,'PaperPositionmode','auto')
                set(fig,'Visible','on')
                
                linmask  = []; linmaskt = [];
                linmask  = (sum((stat.negclusterslabelmat == k)') ~= 0); % spatial mask
                x = [];y = []; [x,y] = find(linmask == 1);
                linmaskt = (sum((stat.negclusterslabelmat == k)) ~= 0); % temporal mask
                xt = [];yt = []; [xt,yt] = find(linmaskt == 1);
                
                offset = find(seg{i}.time == stat.time(1)); % time delay between data.time and stat.time (aka baseline, usually)
                
                % ERF cluster
                subplot(12,11,[7:11 18:22 29:33])
                
                for i = 1:length(varargin)
                    min_clust(i) = min(mean(mean(seg{i}.trial(:,y,:),1),2));
                    max_clust(i) = max(mean(mean(seg{i}.trial(:,y,:),1),2));
                end
                
                cfg                          = [];
                cfg.ylim                   = [min([min_clust])*1.2 max([max_clust])*1.2];
                cfg.graphcolor         = graphcolor;
                cfg.linewidth            = 3;
                cfg.channel              = stat.label(linmask);
                
                % plot instruction
                instr = 'ft_singleplotER(cfg';
                for i =1:length(varargin)
                    instr = [instr ',GDAVG{' num2str(i) '}'];
                end
                instr = [instr ');'];
                eval(instr)
                
                linenim = stat.time(linmaskt);
                line([linenim(1) linenim(end)],[ min([min_clust])*1.1 min([min_clust])*1.1],'linewidth',2,'color','k')
                title(['        negclust' num2str(countneg) [', p= ' num2str(stat.negclusters(1,k).prob)]],'fontsize',14,'fontweight','b'); 
                xlabel('Time (s)','fontsize',14,'fontweight','b'); ylabel(['Amplitude (' ampunit ')'],'fontsize',14,'fontweight','b');
                set(gca, 'box','off','linewidth',2,'fontsize',14,'fontweight','b');

                % ERF sensor max
                [indchanx,indchany] = find(stat.stat == min(min(stat.stat.*(stat.negclusterslabelmat == k))));
                
                subplot(12,11,[51:55 62:66 73:77])
                
                for i = 1:length(varargin)
                    min_bestch(i)  = min(mean(mean(seg{i}.trial(:,indchanx,:),1),2));
                    max_bestch(i) = max(mean(mean(seg{i}.trial(:,indchanx,:),1),2));
                end
                
                cfg                          = [];
                cfg.ylim                   = [min([min_bestch])*1.2 max([max_bestch])*1.2];
                cfg.graphcolor         = graphcolor;
                cfg.linewidth            = 3;
                cfg.channel              = stat.label(indchanx);
                
                % plot instruction
                instr = 'ft_singleplotER(cfg';
                for i =1:length(varargin)
                    instr = [instr ',GDAVG{' num2str(i) '}'];
                end
                instr = [instr ');'];
                eval(instr)
                
                linenim = stat.time(linmaskt);
                line([linenim(1) linenim(end)],[ min([min_bestch])*1.1 min([min_bestch])*1.1],'linewidth',2,'color','k')
                title(['best channel'],'fontsize',14,'fontweight','b');
                xlabel('Time (s)','fontsize',14,'fontweight','b'); ylabel(['Amplitude (' ampunit ')'],'fontsize',14,'fontweight','b');
                set(gca, 'box','off','linewidth',2,'fontsize',14,'fontweight','b');
                
                subplot(12,11,[48 49 59 60])
                cfg                          = [];
                cfg.layout                 = lay;
                cfg.zlim                   = [-1e20 1e20];
                cfg.colormap            = 'jet';
                cfg.style                   = 'straight';
                cfg.parameter          = 'stat';
                cfg.marker               = 'off';
                cfg.highlight              = 'on';
                cfg.highlightchannel   = stat.label(indchanx);
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
                    mean_(i)  = mean(mean(mean(seg{i}.trial(:,y,yt+offset))));
                    sem_(i)   = std(mean(mean(seg{1}.trial(:,y,yt+offset),2),3),0,1)/sqrt(size(seg{1}.trial,1));
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
                axis([ 0 (length(varargin)+1) min([mean_ -sem_])*1.2 max([mean_ +sem_])*1.5]);
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
                    mean_(i)  = mean(mean(mean(seg{i}.trial(:,indchanx,yt+offset))));
                    sem_(i)   = std(mean(mean(seg{1}.trial(:,indchanx,yt+offset),2),3),0,1)/sqrt(size(seg{1}.trial,1));
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
                axis([ 0 (length(varargin)+1) min([mean_ -sem_])*1.2 max([mean_ +sem_])*1.5]);
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

                for  j = 1:1:(min(nfull+1,88))
                    mysubplot(12,11,j+88)
                    chansel = (stat.negclusterslabelmat(:,1+n*(j-1)) == k);
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
                
                
                folder = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/ERFPs/';
                if exist([folder cdn],'dir') == 0
                    mkdir([folder cdn])
                end
                % save plots
                filename = [folder cdn '/STATS_' chansel_ '_negclust' num2str(countneg) '_Lat' num2str(latency(1)) '-' num2str(latency(2)) '_stimlock'];
                print('-dpng',filename)
                
                save(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/spatial_clust/stats_negclust_'  num2str(countneg) '_' cdn '_' chansel_ '_Lat' num2str(latency(1)) '-' num2str(latency(2)) '_stimlock.mat'],'stat','chansel','condnames')
              
                countneg = countneg +1;
            end
        end
    end
end

