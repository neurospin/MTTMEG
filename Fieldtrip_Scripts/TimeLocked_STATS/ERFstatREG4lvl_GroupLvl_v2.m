function count = ERFstatREG4lvl_GroupLvl_v2(condnames,GDAVG,GDAVGt, chansel_, data1,data2,data3,data4,graphcolor)

if strcmp(data1.label{1,1},'MEG0111') == 1
    chantype = 'Mags';
            ampunit = 'T';
    
    load('/neurospin/meg/meg_tmp/tools_tmp/Pipeline/pipeline/neuromag306mag_neighb.mat')
   
    
elseif strcmp(data1.label{1,1},'MEG0113') == 1 || strcmp(data1.label{1,1},'MEG0112') == 1
    chantype = 'Grads';
            ampunit = 'T';
    
    load('/neurospin/meg/meg_tmp/tools_tmp/Pipeline/pipeline/neuromag306planar_neighb.mat')
    
elseif strcmp(data1.label{1,1},'EEG001') == 1
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
% data1.label = Mags';
% data2.label = Mags';

% prepare layout
cfg                           = [];
if strcmp(chantype,'EEG') == 0
    cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/fieldtrip-20130901/template/layout/NM306mag.lay';
else
    cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/eeg_64_NM20884N.lay';
end
lay                        = ft_prepare_layout(cfg,data1);
lay.label                  = data1.label;

% test based on fieldtrip tutorial
cfg = [];
cfg.channel                = 'all';
cfg.latency                 = [0 1];
cfg.frequency              = 'all';
cfg.method                 = 'montecarlo';
cfg.statistic              = 'depsamplesregrT';
cfg.correctm               = 'cluster';
cfg.clusteralpha           = 0.05;
cfg.clusterstatistic       = 'maxsum';
cfg.minnbchan              = 2;
cfg.tail                   = 0;
cfg.clustertail            = 0;
cfg.alpha                  = 0.025;
cfg.numrandomization       = 5000;
cfg.neighbours             = neighbours;

ntrialdim1 = size(data1.individual,1);
ntrialdim2 = size(data2.individual,1);
ntrialdim3 = size(data3.individual,1);
ntrialdim4 = size(data4.individual,1);

design1 = [1:ntrialdim1 1:ntrialdim2 1:ntrialdim3 1:ntrialdim4];

design2 = zeros(1,ntrialdim1 + ntrialdim2 + ntrialdim3 + ntrialdim4);
design2(1,1:ntrialdim1) = 1;
design2(1,(ntrialdim1+1):(ntrialdim1 + ntrialdim2))= 2;
design2(1,(ntrialdim1+ntrialdim2+1 ):(ntrialdim1+ntrialdim2 + ntrialdim3))= 3;
design2(1,(ntrialdim1+ntrialdim2+ntrialdim3+1):(ntrialdim1+ntrialdim2+ntrialdim3+ntrialdim4))= 4;

cfg.design = [];
cfg.design           = [design1; design2];
cfg.uvar  = 1;
cfg.ivar  = 2;

[stat] = ft_timelockstatistics(cfg,data1,data2,data3,data4);

%% compure 3 significance masks
posmask007 = [];
posmask005 = [];
posmask0005 = [];
if isfield(stat,'posclusterslabelmat') == 1;
    storesigposclust007 = [];
    storesigposclust005 = [];
    storesigposclust0005 = [];
    posmask007 = zeros(size(stat.posclusterslabelmat,1),size(stat.posclusterslabelmat,2));
    posmask005 = zeros(size(stat.posclusterslabelmat,1),size(stat.posclusterslabelmat,2));
    posmask0005 = zeros(size(stat.posclusterslabelmat,1),size(stat.posclusterslabelmat,2));
    for i = 1:length(stat.posclusters)
        if (stat.posclusters(1,i).prob <= 0.07) && (stat.posclusters(1,i).prob > 0.05) 
            storesigposclust = [storesigposclust007 i];
            posmask007          = posmask007 + (stat.posclusterslabelmat == i);
        elseif (stat.posclusters(1,i).prob <= 0.05) && (stat.posclusters(1,i).prob > 0.005) 
            storesigposclust = [storesigposclust005 i];
            posmask005          = posmask005 + (stat.posclusterslabelmat == i);
        elseif (stat.posclusters(1,i).prob <= 0.005)
            storesigposclust = [storesigposclust0005 i];
            posmask0005          = posmask0005 + (stat.posclusterslabelmat == i);
        end
    end
end
negmask007 = [];
negmask005 = [];
negmask0005 = [];
if isfield(stat,'negclusterslabelmat') == 1;
    storesignegclust007 = [];
    storesignegclust005 = [];
    storesignegclust0005 = [];
    negmask007 = zeros(size(stat.negclusterslabelmat,1),size(stat.negclusterslabelmat,2));
    negmask005 = zeros(size(stat.negclusterslabelmat,1),size(stat.negclusterslabelmat,2));
    negmask0005 = zeros(size(stat.negclusterslabelmat,1),size(stat.negclusterslabelmat,2));
    for i = 1:length(stat.negclusters)
        if (stat.negclusters(1,i).prob <= 0.07) && (stat.negclusters(1,i).prob > 0.05) 
            storesignegclust = [storesignegclust007 i];
            negmask007          = negmask007 + (stat.negclusterslabelmat == i);
        elseif (stat.negclusters(1,i).prob <= 0.05) && (stat.negclusters(1,i).prob > 0.005) 
            storesignegclust = [storesignegclust005 i];
            negmask005          = negmask005 + (stat.negclusterslabelmat == i);
        elseif (stat.negclusters(1,i).prob <= 0.005)
            storesignegclust = [storesignegclust0005 i];
            negmask0005          = negmask0005 + (stat.negclusterslabelmat == i);
        end
    end
end

if isempty(posmask007) == 0 && isempty(negmask007) == 0
    Mask007 = negmask007 + posmask007;
elseif isempty(posmask007) == 0 && isempty(negmask007) == 1
    Mask007 = posmask007;
elseif isempty(posmask007) == 1 && isempty(negmask007) == 0
    Mask007 = negmask007 ;
elseif isempty(posmask007) == 1 && isempty(negmask007) == 1
    Mask007 = zeros(size(stat.stat,1),size(stat.stat,2));
end

if isempty(posmask0005) == 0 && isempty(negmask0005) == 0
    Mask0005 = negmask0005 + posmask0005;
elseif isempty(posmask0005) == 0 && isempty(negmask0005) == 1
    Mask0005 = posmask0005;
elseif isempty(posmask0005) == 1 && isempty(negmask0005) == 0
    Mask0005 = negmask0005 ;
elseif isempty(posmask0005) == 1 && isempty(negmask0005) == 1
    Mask0005 = zeros(size(stat.stat,1),size(stat.stat,2));
end

if isempty(posmask005) == 0 && isempty(negmask005) == 0
    Mask005 = negmask005 + posmask005;
elseif isempty(posmask005) == 0 && isempty(negmask005) == 1
    Mask005 = posmask005;
elseif isempty(posmask005) == 1 && isempty(negmask005) == 0
    Mask005 = negmask005 ;
elseif isempty(posmask005) == 1 && isempty(negmask005) == 1
    Mask005 = zeros(size(stat.stat,1),size(stat.stat,2));
end

Mask = Mask005+ Mask0005; % only sign masks, marginal mask is for plot

%%

cdn = [];
for i = 1:length(condnames)
    cdn = [cdn condnames{i} '_'];
end

cfg.toilim = [0 1];
seg1 = ft_redefinetrial(cfg,GDAVGt{1});
seg2 = ft_redefinetrial(cfg,GDAVGt{2});
seg3 = ft_redefinetrial(cfg,GDAVGt{3});
seg4 = ft_redefinetrial(cfg,GDAVGt{4});

countpos = 0;
if isfield(stat,'posclusters') == 1
    if isempty(stat.posclusters) == 0
        for k = 1:length(stat.posclusters)
            if stat.posclusters(1,k).prob < 0.07
                
                 fig = figure('position',[1 1 700 700]);
                set(fig,'PaperPosition',[1 1 700 700])
                set(fig,'PaperPositionmode','auto')
                set(fig,'Visible','off')
                
                linmask  = []; linmaskt = [];
                linmask  = (sum((stat.posclusterslabelmat == k)') ~= 0);
                x = [];y = []; [x,y] = find(linmask == 1);
                linmaskt = (sum((stat.posclusterslabelmat == k)) ~= 0);
                xt = [];yt = []; [xt,yt] = find(linmaskt == 1);
                
                min1 = min(mean(mean(seg1.trial(:,y,:),1),2));
                min2 =min(mean(mean(seg2.trial(:,y,:),1),2));
                min3 = min(mean(mean(seg3.trial(:,y,:),1),2));
                min4 = min(mean(mean(seg4.trial(:,y,:),1),2));
                max1 = max(mean(mean(seg1.trial(:,y,:),1),2));
                max2 =max(mean(mean(seg2.trial(:,y,:),1),2));
                max3 =max(mean(mean(seg3.trial(:,y,:),1),2));
                max4 =max(mean(mean(seg4.trial(:,y,:),1),2));
                
                % ERF
                subplot(7,6,[4 5 6 10 11 12 16 17 18])

                cfg                          = [];
                cfg.ylim                   = [min([min1 min2 min3 min4])*1.2 max([max1 max2 max3 max4])*1.2];
                cfg.graphcolor         = graphcolor;
                cfg.linewidth            = 3;
                cfg.channel              = stat.label(linmask);
                ft_singleplotER(cfg,GDAVG{1},GDAVG{2},GDAVG{3},GDAVG{4});
                linenim = stat.time(linmaskt);
                line([linenim(1) linenim(end)],[ min([min1 min2 min3 min4])*1.1 min([min1 min2 min3 min4])*1.1],'linewidth',2,'color','k')
                title(['        posclust' num2str(countpos) [', p= ' num2str(stat.posclusters(1,k).prob)]],'fontsize',14,'fontweight','b'); 
                xlabel('Time (s)','fontsize',14,'fontweight','b'); ylabel(['Amplitude (' ampunit ')'],'fontsize',14,'fontweight','b');
                set(gca, 'box','off','linewidth',2,'fontsize',14,'fontweight','b');
                %                 legend(condnames,'location','EastOutside')

                countpos = countpos + 1;
                
               % RASTER PLOT Tvalues
                subplot(7,6,[1 2 3 7 8 9 13 14 15])
                mean1 = mean(mean(mean(seg1.trial(:,y,yt))));
                mean2 =mean(mean(mean(seg2.trial(:,y,yt))));
                mean3 =mean(mean(mean(seg3.trial(:,y,yt))));
                mean4 =mean(mean(mean(seg4.trial(:,y,yt))));
                sem1   = std(mean(mean(seg1.trial(:,y,yt),2),3),0,1)/sqrt(size(seg1.trial,1));
                sem2   = std(mean(mean(seg2.trial(:,y,yt),2),3),0,1)/sqrt(size(seg1.trial,1));
                sem3   = std(mean(mean(seg3.trial(:,y,yt),2),3),0,1)/sqrt(size(seg1.trial,1));
                sem4   = std(mean(mean(seg4.trial(:,y,yt),2),3),0,1)/sqrt(size(seg1.trial,1));
                
                set(gcf,'Color',[1,1,1])
                bar([mean1 0 0 0],'facecolor',graphcolor(1,:),'linewidth',2);
                hold on
                bar([0 mean2 0 0],'facecolor',graphcolor(2,:),'linewidth',2);
                hold on
                bar([0 0 mean3 0],'facecolor',graphcolor(3,:),'linewidth',2);
                hold on
                bar([0 0 0 mean4],'facecolor',graphcolor(4,:),'linewidth',2);
                hold on
                legend(condnames{1},condnames{2},condnames{3},condnames{4},'Location','NorthWest')
                errorbar([mean1 mean2 mean3 mean4],[sem1 sem2 sem3 sem4],'linestyle','none','color','k','linewidth',2);hold on
                ylabel(['Amplitude (' ampunit ')'],'fontsize',14,'fontweight','b');
                axis([ 0 5 min([mean1-sem1 mean2-sem2 mean3-sem3 mean4-sem4])*1.2 ...
                    max([mean1+sem1 mean2+sem2 mean3+sem3 mean4+sem4])*1.5]);
                set(gca,'xtick',1:3,'xticklabel',{''}, 'box','off','linewidth',2,'fontsize',14,'fontweight','b');
                
                lim = [-max(max(stat.stat)) max(max(stat.stat))];
                mask = (stat.posclusterslabelmat == k);
                
                sample = (stat.time(end) - stat.time(1))./length(stat.time);
                n = round(0.1/sample);
                nfull = floor(length(stat.time)/n);

                for j = 1:1:(min(nfull+1,42))
                    mysubplot(7,6,j+24)
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
                filename = [folder cdn '/STATS_' chansel_ '_posclust' num2str(countpos)];
                print('-dpng',filename)
                
                save(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/spatial_clust/stats_posclust_ '  cdn '_' chansel_],'stat','chansel','condnames')
                
            end
        end
    end
end

countneg = 0;
if isfield(stat,'negclusters') == 1
    if isempty(stat.negclusters) == 0
        for k = 1:length(stat.negclusters)
            if stat.negclusters(1,k).prob < 0.07
                
                 fig = figure('position',[1 1 700 700]);
                set(fig,'PaperPosition',[1 1 700 700])
                set(fig,'PaperPositionmode','auto')
                set(fig,'Visible','off')
                
                linmask  = []; linmaskt = [];
                linmask  = (sum((stat.negclusterslabelmat == k)') ~= 0);
                x = [];y = []; [x,y] = find(linmask == 1);
                linmaskt = (sum((stat.negclusterslabelmat == k)) ~= 0);
                xt = [];yt = []; [xt,yt] = find(linmaskt == 1);
                
                min1 = min(mean(mean(seg1.trial(:,y,:),1),2));
                min2 =min(mean(mean(seg2.trial(:,y,:),1),2));
                min3 = min(mean(mean(seg3.trial(:,y,:),1),2));
                min4 = min(mean(mean(seg4.trial(:,y,:),1),2));
                max1 = max(mean(mean(seg1.trial(:,y,:),1),2));
                max2 =max(mean(mean(seg2.trial(:,y,:),1),2));
                max3 =max(mean(mean(seg3.trial(:,y,:),1),2));
                max4 =max(mean(mean(seg4.trial(:,y,:),1),2));
                
                % ERF
                subplot(7,6,[4 5 6 10 11 12 16 17 18])

                cfg                          = [];
                cfg.ylim                   = [min([min1 min2 min3 min4])*1.2 max([max1 max2 max3 max4])*1.2];
                cfg.graphcolor         = graphcolor;
                cfg.linewidth            = 3;
                cfg.channel              = stat.label(linmask);
                ft_singleplotER(cfg,GDAVG{1},GDAVG{2},GDAVG{3},GDAVG{4});
                linenim = stat.time(linmaskt);
                line([linenim(1) linenim(end)],[ min([min1 min2 min3 min4])*1.1 min([min1 min2 min3 min4])*1.1],'linewidth',2,'color','k')
                title(['        negclust' num2str(countneg) [', p= ' num2str(stat.negclusters(1,k).prob)]],'fontsize',14,'fontweight','b'); 
                xlabel('Time (s)','fontsize',14,'fontweight','b'); ylabel(['Amplitude (' ampunit ')'],'fontsize',14,'fontweight','b');
                set(gca, 'box','off','linewidth',2,'fontsize',14,'fontweight','b');
                %                 legend(condnames,'location','EastOutside')

                countneg = countneg + 1;
                
               % RASTER PLOT Tvalues
                subplot(7,6,[1 2 3 7 8 9 13 14 15])
                mean1 = mean(mean(mean(seg1.trial(:,y,yt))));
                mean2 =mean(mean(mean(seg2.trial(:,y,yt))));
                mean3 =mean(mean(mean(seg3.trial(:,y,yt))));
                mean4 =mean(mean(mean(seg4.trial(:,y,yt))));
                sem1   = std(mean(mean(seg1.trial(:,y,yt),2),3),0,1)/sqrt(size(seg1.trial,1));
                sem2   = std(mean(mean(seg2.trial(:,y,yt),2),3),0,1)/sqrt(size(seg1.trial,1));
                sem3   = std(mean(mean(seg3.trial(:,y,yt),2),3),0,1)/sqrt(size(seg1.trial,1));
                sem4   = std(mean(mean(seg4.trial(:,y,yt),2),3),0,1)/sqrt(size(seg1.trial,1));
                
                set(gcf,'Color',[1,1,1])
                bar([mean1 0 0 0],'facecolor',graphcolor(1,:),'linewidth',2);
                hold on
                bar([0 mean2 0 0],'facecolor',graphcolor(2,:),'linewidth',2);
                hold on
                bar([0 0 mean3 0],'facecolor',graphcolor(3,:),'linewidth',2);
                hold on
                bar([0 0 0 mean4],'facecolor',graphcolor(4,:),'linewidth',2);
                hold on
                legend(condnames{1},condnames{2},condnames{3},condnames{4},'Location','NorthWest')
                errorbar([mean1 mean2 mean3 mean4],[sem1 sem2 sem3 sem4],'linestyle','none','color','k','linewidth',2);hold on
                ylabel(['Amplitude (' ampunit ')'],'fontsize',14,'fontweight','b');
                axis([ 0 5 min([mean1-sem1 mean2-sem2 mean3-sem3 mean4-sem4])*1.2 ...
                    max([mean1+sem1 mean2+sem2 mean3+sem3 mean4+sem4])*1.5]);
                set(gca,'xtick',1:3,'xticklabel',{''}, 'box','off','linewidth',2,'fontsize',14,'fontweight','b');
                
                lim = [-max(max(stat.stat)) max(max(stat.stat))];
                mask = (stat.negclusterslabelmat == k);
                
                sample = (stat.time(end) - stat.time(1))./length(stat.time);
                n = round(0.1/sample);
                nfull = floor(length(stat.time)/n);

                for j = 1:1:(min(nfull+1,42))
                    mysubplot(7,6,j+24)
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
                filename = [folder cdn '/STATS_' chansel_ '_negclust' num2str(countneg)];
                print('-dpng',filename)
                
                
                  save(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/spatial_clust/stats_negclust_ '  cdn '_' chansel_],'stat','chansel','condnames')
            end
        end
    end
end

count = [];
count = countneg + countpos;


