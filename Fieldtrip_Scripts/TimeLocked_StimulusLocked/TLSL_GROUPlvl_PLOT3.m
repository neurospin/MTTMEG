function TLSL_GROUPlvl_PLOT(niplist,chansel_,condclust,condnames,latency,PlotColors)

% nip = the NIP code of the subject
% chansel, can be either 'Mags', 'Grads1','Grads2' or 'EEG'
% condnames = the name of the columns conditions
% condarray: conditions organized in a x*y cell array
% the rows x define all the subconditions of the y column conditions

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% PREPARE COMPUTATIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% %%%%%%%% for  testing %%%%%%%%%%%%%%
%
% chansel   = 'Mags';
% chansel_ = 'Mags';
%
% PlotColors = [[1 0 0];[1 0.75 0.3]];
%
% condclust    = {'EtDtq1G';'EtDtq2G'};
%
% condnames = {{'EtDtq1G_Past';'EtDtq2G_Past'};...
%     {'EtDtq1G_Pre';'EtDtq2G_Pre'};...
%     {'EtDtq1G_Fut';'EtDtq2G_Fut'}};
condnamesave = condnames;

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% define channel types
[Grads1,Grads2,Mags]   = grads_for_layouts('Network');
EEG  = EEG_for_layouts('Network');

ch = [];
if strcmp(chansel_,'Mags')
    ch = Mags;
elseif strcmp(chansel_,'Grads1')
    ch = Grads1;
elseif strcmp(chansel_,'Grads2')
    ch = Grads2;
elseif strcmp(chansel_,'cmb')
    ch = Mags; %temporary
else strcmp(chansel_,'EEG')
    ch = EEG;
end

for condarray = 1:size(condnames,1)
    % switch from separated to concatenated names
    cdn{condarray} = [];
    for i = 1:length(condnames{condarray})
        cdn{condarray} = [cdn{condarray} condnames{condarray}{i} '_'];
    end
    
    % load cell array of conditions
    instrmulti{condarray} = 'ft_multiplotER(cfg,';
    instrsingle{condarray}  = 'ft_singleplotER(cfg,';
    for j = 1:length(niplist)
        datatmp{condarray}{j}   = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' niplist{j} '/MegData/ERFPs/' cdn{condarray} chansel_],'timelockbase');
        instrmulti{condarray}     = [instrmulti{condarray} 'datatmp{1,' num2str(j) '}.timelockbase{1,1},'];
        instrsingle{condarray}    = [instrsingle{condarray} 'datatmp{1,' num2str(j) '}.timelockbase{1,1},'];
    end
    instrmulti{condarray}(end)  = [];
    instrsingle{condarray}(end) = [];
    instrmulti{condarray}          = [instrmulti{condarray} ');'];
    instrsingle{condarray}         = [instrsingle{condarray} ');'];
    
end

close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if strcmp(chansel_,'Mags');
    ampunit = 'fT';
    fmult = 1.e-14;
    
elseif strcmp(chansel_,'Grads1') || strcmp(chansel_,'Grads2');
    ampunit = 'fT/cm';
    fmult = 1.e-14;
    
elseif strcmp(chansel_,'EEG');
    ampunit = 'uV';
    fmult = 1.e-6;
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% COMPUTE ERFS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for condarray = 1:size(condnames,1)
    for i = 1:length(datatmp{condarray}{1,1}.timelockbase)
        
        % for plot
        cfg                             = [];
        cfg.channel                 = ch;
        cfg.trials                     = 'all';
        cfg.keepindividual       = 'no';
        cfg.removemean         = 'yes';
        cfg.covariance             = 'yes';
        
        instr = ['GDAVG{' num2str(condarray) '}{' num2str(i) '} = ft_timelockgrandaverage(cfg,'];
        for j = 1:length(datatmp{condarray})
            instr = [instr 'datatmp{' num2str(condarray) '}{1,' num2str(j)  '}.timelockbase{1,' num2str(i) '},'];
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
        
        instr = ['GDAVGt{' num2str(condarray) '}{' num2str(i) '} = ft_timelockgrandaverage(cfg,'];
        for j = 1:length(datatmp{condarray})
            instr = [instr 'datatmp{' num2str(condarray) '}{1,' num2str(j)  '}.timelockbase{1,' num2str(i) '},'];
        end
        instr(end) = [];
        instr      = [instr ');'];
        
        eval([instr]);
        
        instr = [];
        instr = ['GDAVGt{' num2str(condarray) '}{' num2str(i) '} = rmfield(GDAVGt{' num2str(condarray) '}{' num2str(i) '},''cfg'''];
        instr      = [instr ');'];
        
        eval([instr]);
        
        instr = [];
        instr = ['GDAVG{' num2str(condarray) '}{' num2str(i) '} = rmfield(GDAVG{' num2str(condarray) '}{' num2str(i) '},''cfg'''];
        instr      = [instr ');'];
        
        eval([instr]);
        
        instr = [];
        instr = ['GDAVG{' num2str(condarray) '}{' num2str(i) '}.avg = GDAVG{' num2str(condarray) '}{' num2str(i) '}.avg./fmult;'];
        eval([instr]);
        
        instr = [];
        instr = ['GDAVGt{' num2str(condarray) '}{' num2str(i) '}.individual = GDAVGt{' num2str(condarray) '}{' num2str(i) '}.individual./fmult;'];
        eval([instr]);
        
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%% load cluster from previous stats %%%%%%%%%%%%%%%%%
%% %%% plot another condition set timecourse on this spatiotemporal cluster
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% load cluster stats from condclust definition
folder_clust ='/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/spatial_clust/';

cdn_clust = [];
for i = 1:length(condclust)
    cdn_clust= [cdn_clust condclust{i} '_'];
end

cfg          = [];
cfg.toilim = [0 1];
for  condarray = 1:size(condnames,1)
    seg1{condarray} = ft_redefinetrial(cfg,GDAVGt{condarray}{1});
    seg2{condarray} = ft_redefinetrial(cfg,GDAVGt{condarray}{2});
    seg3{condarray} = ft_redefinetrial(cfg,GDAVGt{condarray}{3});
end

if exist([folder_clust 'stats_posclust_ ' cdn_clust '__' chansel_  '_Lat' num2str(latency(1)) '-' num2str(latency(2)) '_stimlock' '.mat']) == 2
    
    load([folder_clust 'stats_posclust_ ' cdn_clust '__' chansel_  '_Lat' num2str(latency(1)) '-' num2str(latency(2)) '_stimlock' '.mat'] );
    
    condnames = condnamesave;
    countpos = 0;
    if isfield(stat,'posclusters') == 1
        if isempty(stat.posclusters) == 0
            for k = 1:length(stat.posclusters)
                if stat.posclusters(1,k).prob < 0.07
                    
                    fig = figure('position',[1 1 1000 700]);
                    set(fig,'PaperPosition',[1 1 1000 700])
                    set(fig,'PaperPositionmode','auto')
                    set(fig,'Visible','on')
                    
                    linmask  = []; linmaskt = [];
                    linmask  = (sum((stat.posclusterslabelmat == k)') ~= 0);
                    x = [];y = []; [x,y] = find(linmask == 1);
                    linmaskt = (sum((stat.posclusterslabelmat == k)) ~= 0);
                    xt = [];yt = []; [xt,yt] = find(linmaskt == 1);
                    
                    loc = {[12 3 10 11 12 19 20 21];[4 5 6 13 14 15 22 23 24];...
                        [7 8 9 16 17 18 25 26 27];[43 44 45 52 53 54 61 62 63]};
                    
                    for  condarray = 1:size(condnames,1)
                        min1(condarray)  = min(mean(mean(seg1{condarray}.trial(:,y,:),1),2));
                        min2(condarray)  =min(mean(mean(seg2{condarray}.trial(:,y,:),1),2));
                        min3(condarray)  =min(mean(mean(seg3{condarray}.trial(:,y,:),1),2));
                        max1(condarray) = max(mean(mean(seg1{condarray}.trial(:,y,:),1),2));
                        max2(condarray) =max(mean(mean(seg2{condarray}.trial(:,y,:),1),2));
                        max3(condarray) =max(mean(mean(seg3{condarray}.trial(:,y,:),1),2));
                    end
                    

                    for  condarray = 1:size(condnames,1)

                        % ERF
                        subplot(7,9,loc{condarray})
                        
                        cfg                          = [];
                        cfg.ylim                   = [min([min1 min2 min3 ])*1.5 max([max1 max2 max3])*1.2];
                        cfg.graphcolor         = PlotColors;
                        cfg.linewidth            = 3;
                        cfg.channel              = stat.label(linmask);
                        cfg.cm_linestyle        = {'-','-','-'};
                        ft_singleplotER(cfg,GDAVG{condarray}{1},GDAVG{condarray}{2},GDAVG{condarray}{3});
                        %                     hold on;line([GDAVG1{1}.time(1) GDAVG1{1}.time(end)],[0 0],'color','k')
                        linenim = stat.time(linmaskt);
                        line([linenim(1) linenim(end)],[ min([min1 min2 ])*1.1 min([min1 min2  ])*1.1],'linewidth',2,'color','k')
                        title([texlabel(cdn{condarray},'literal')],'fontsize',14,'fontweight','b');
                        xlabel('Time (s)','fontsize',14,'fontweight','b');
                        set(gca, 'box','off','linewidth',2,'fontsize',14,'fontweight','b');
                        %                 legend(condnames,'location','EastOutside')
                        
                        if condarray == 1
                            ylabel(['Amplitude (' ampunit ')'],'fontsize',14,'fontweight','b');
                        end
                        
                    end
%                     
%                     cfg                          = [];
%                     cfg.ylim                   = [min([min1 min2 min3])*1.5 max([max1 max2 max3])*1.2];
%                     cfg.linewidth            = 3;
%                     cfg.channel              = stat.label(linmask);
%                     subplot(7,9,loc{4})
%                     instr(end) = []; instr = [instr ');']; eval(instr);
%                     linenim = stat.time(linmaskt);
%                     line([linenim(1) linenim(end)],[ min([min1 min2 min3])*1.1 min([min1 min2 min3 ])*1.1],'linewidth',2,'color','k')
%                     line([GDAVG{condarray}{1}.time(1) GDAVG{condarray}{1}.time(end)],[0 0],'linewidth',2,'color','k')
%                     title([cdn{condarray}],'fontsize',14,'fontweight','b');
%                     xlabel('Time (s)','fontsize',14,'fontweight','b');
%                     set(gca, 'box','off','linewidth',2,'fontsize',14,'fontweight','b');
%                     
%                     if size(condnames,1)==1
%                         legend(texlabel(cdn{1},'literal'),'Location','WestOutside')
%                     elseif size(condnames,1)==2
%                         legend(texlabel(cdn{1},'literal'),texlabel(cdn{2},'literal'),'Location','WestOutside')
%                     elseif size(condnames,1)==3
%                         legend(texlabel(cdn{1},'literal'),texlabel(cdn{2},'literal'),texlabel(cdn{3},'literal'),'Location','WestOutside')
%                     end
                    
                    % RASTER PLOT Tvalues
                    initplot = zeros(size(condnames,1)*length(condnames{1}),size(condnames,1)*length(condnames{1}));
                    initplot_sd = zeros(size(condnames,1)*length(condnames{1}),size(condnames,1)*length(condnames{1}));
                    set(gcf,'Color',[1,1,1])
                    
                    for  condarray = 1:size(condnames,1)
                        
                        subplot(7,9,[37 38 39 46 47 48 55 56 57])
                        mean1{condarray} = mean(mean(mean(seg1{condarray}.trial(:,y,yt))));
                        mean2{condarray} =mean(mean(mean(seg2{condarray}.trial(:,y,yt))));
                        mean3{condarray} =mean(mean(mean(seg3{condarray}.trial(:,y,yt))));
                        sem1{condarray}   = std(mean(mean(seg1{condarray}.trial(:,y,yt),2),3),0,1)/sqrt(size(seg1{condarray}.trial,1));
                        sem2{condarray}   = std(mean(mean(seg2{condarray}.trial(:,y,yt),2),3),0,1)/sqrt(size(seg1{condarray}.trial,1));
                        sem3{condarray}   = std(mean(mean(seg3{condarray}.trial(:,y,yt),2),3),0,1)/sqrt(size(seg1{condarray}.trial,1));
                        
                        initplot((condarray-1)*3+1,(condarray-1)*3+1) = mean1{condarray};
                        initplot((condarray-1)*3+2,(condarray-1)*3+2) = mean2{condarray};
                        initplot((condarray-1)*3+3,(condarray-1)*3+3) = mean3{condarray};
                        
                        initplot_sd((condarray-1)*3+1,(condarray-1)*3+1) = sem1{condarray};
                        initplot_sd((condarray-1)*3+2,(condarray-1)*3+2) = sem2{condarray};
                        initplot_sd((condarray-1)*3+3,(condarray-1)*3+3) = sem3{condarray};
                        
                        limmintoplot((condarray-1)*3+1,(condarray-1)*3+1) = initplot((condarray-1)*3+1,(condarray-1)*3+1) ...
                            -  initplot_sd((condarray-1)*3+1,(condarray-1)*3+1);
                        limmintoplot((condarray-1)*3+2,(condarray-1)*3+2) = initplot((condarray-1)*3+2,(condarray-1)*3+2) ...
                            -  initplot_sd((condarray-1)*3+2,(condarray-1)*3+2);
                        limmintoplot((condarray-1)*3+3,(condarray-1)*3+3) = initplot((condarray-1)*3+3,(condarray-1)*3+3) ...
                            -  initplot_sd((condarray-1)*3+3,(condarray-1)*3+3);
                        limmaxtoplot((condarray-1)*3+1,(condarray-1)*3+1) = initplot((condarray-1)*3+1,(condarray-1)*3+1) ...
                            +  initplot_sd((condarray-1)*3+1,(condarray-1)*3+1);
                        limmaxtoplot((condarray-1)*3+2,(condarray-1)*3+2) = initplot((condarray-1)*3+2,(condarray-1)*3+2) ...
                            +  initplot_sd((condarray-1)*3+2,(condarray-1)*3+2);
                        limmaxtoplot((condarray-1)*3+3,(condarray-1)*3+3) = initplot((condarray-1)*3+3,(condarray-1)*3+3) ...
                            +  initplot_sd((condarray-1)*3+3,(condarray-1)*3+3);
                        
                        bar(initplot((condarray-1)*3+1,:),'facecolor',PlotColors(1,:),'linewidth',2);
                        hold on
                        bar(initplot((condarray-1)*3+2,:),'facecolor',PlotColors(2,:),'linewidth',2);
                        hold on
                        bar(initplot((condarray-1)*3+3,:),'facecolor',PlotColors(3,:),'linewidth',2);
                        hold on
                        
                    end
                    
                    errorbar([sum(initplot)],[sum(initplot_sd)],'linestyle','none','color','k','linewidth',2);hold on
                    ylabel(['Amplitude (' ampunit ')'],'fontsize',14,'fontweight','b');
                    axis([ 0 length(initplot)+1  min(sum(limmintoplot))*1.2 max(sum(limmaxtoplot))*1.2]);
                    set(gca,'xtick',1:2,'xticklabel',{''}, 'box','off','linewidth',2,'fontsize',14,'fontweight','b');
                    
                    % save plots
                    folder = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/ERFPs/';
                    if size(condnames,1)==1
                        filename = [folder cdn_clust '/PlotposClust_' chansel_ '_posclust' num2str(countpos) '_VS_' cdn{1} ];
                    elseif size(condnames,1)==2
                        filename = [folder cdn_clust '/PlotposClust_' chansel_ '_posclust' num2str(countpos) '_VS_' cdn{1} cdn{2} ];
                    elseif size(condnames,1)==3
                        filename = [folder cdn_clust '/PlotposClust_' chansel_ '_posclust' num2str(countpos) '_VS_' cdn{1} cdn{2} cdn{3}];
                    end
                    print('-dpng',filename)
                    
                end
            end
        end
    end
    countpos = countpos +1;
    
elseif exist([folder_clust 'stats_negclust_ ' cdn_clust '__' chansel_  '_Lat' num2str(latency(1)) '-' num2str(latency(2)) '_stimlock' '.mat']) == 2
    
    load([folder_clust 'stats_negclust_ ' cdn_clust '__' chansel_  '_Lat' num2str(latency(1)) '-' num2str(latency(2)) '_stimlock' '.mat'] );
    
    condnames = condnamesave;
    countneg = 0;
    if isfield(stat,'negclusters') == 1
        if isempty(stat.negclusters) == 0
            for k = 1:length(stat.negclusters)
                if stat.negclusters(1,k).prob < 0.07
                    
                    fig = figure('position',[1 1 1000 700]);
                    set(fig,'PaperPosition',[1 1 1000 700])
                    set(fig,'PaperPositionmode','auto')
                    set(fig,'Visible','on')
                    
                    linmask  = []; linmaskt = [];
                    linmask  = (sum((stat.negclusterslabelmat == k)') ~= 0);
                    x = [];y = []; [x,y] = find(linmask == 1);
                    linmaskt = (sum((stat.negclusterslabelmat == k)) ~= 0);
                    xt = [];yt = []; [xt,yt] = find(linmaskt == 1);
                    
                    loc = {[12 3 10 11 12 19 20 21];[4 5 6 13 14 15 22 23 24];...
                        [7 8 9 16 17 18 25 26 27];[43 44 45 52 53 54 61 62 63]};
                    
                    for  condarray = 1:size(condnames,1)
                        min1(condarray)  = min(mean(mean(seg1{condarray}.trial(:,y,:),1),2));
                        min2(condarray)  =min(mean(mean(seg2{condarray}.trial(:,y,:),1),2));
                        min3(condarray)  =min(mean(mean(seg3{condarray}.trial(:,y,:),1),2));
                        max1(condarray) = max(mean(mean(seg1{condarray}.trial(:,y,:),1),2));
                        max2(condarray) =max(mean(mean(seg2{condarray}.trial(:,y,:),1),2));
                        max3(condarray) =max(mean(mean(seg3{condarray}.trial(:,y,:),1),2));
                    end
                    

                    for  condarray = 1:size(condnames,1)

                        % ERF
                        subplot(7,9,loc{condarray})
                        
                        cfg                          = [];
                        cfg.ylim                   = [min([min1 min2 min3 ])*1.5 max([max1 max2 max3])*1.2];
                        cfg.graphcolor         = PlotColors;
                        cfg.linewidth            = 3;
                        cfg.channel              = stat.label(linmask);
                        cfg.cm_linestyle        = {'-','-','-'};
                        ft_singleplotER(cfg,GDAVG{condarray}{1},GDAVG{condarray}{2},GDAVG{condarray}{3});
                        %                     hold on;line([GDAVG1{1}.time(1) GDAVG1{1}.time(end)],[0 0],'color','k')
                        linenim = stat.time(linmaskt);
                        line([linenim(1) linenim(end)],[ min([min1 min2 ])*1.1 min([min1 min2  ])*1.1],'linewidth',2,'color','k')
                        title([texlabel(cdn{condarray},'literal')],'fontsize',14,'fontweight','b');
                        xlabel('Time (s)','fontsize',14,'fontweight','b');
                        set(gca, 'box','off','linewidth',2,'fontsize',14,'fontweight','b');
                        %                 legend(condnames,'location','EastOutside')
                        
                        if condarray == 1
                            ylabel(['Amplitude (' ampunit ')'],'fontsize',14,'fontweight','b');
                        end
                        
                    end
%                     
%                     cfg                          = [];
%                     cfg.ylim                   = [min([min1 min2 min3])*1.5 max([max1 max2 max3])*1.2];
%                     cfg.linewidth            = 3;
%                     cfg.channel              = stat.label(linmask);
%                     subplot(7,9,loc{4})
%                     instr(end) = []; instr = [instr ');']; eval(instr);
%                     linenim = stat.time(linmaskt);
%                     line([linenim(1) linenim(end)],[ min([min1 min2 min3])*1.1 min([min1 min2 min3 ])*1.1],'linewidth',2,'color','k')
%                     line([GDAVG{condarray}{1}.time(1) GDAVG{condarray}{1}.time(end)],[0 0],'linewidth',2,'color','k')
%                     title([cdn{condarray}],'fontsize',14,'fontweight','b');
%                     xlabel('Time (s)','fontsize',14,'fontweight','b');
%                     set(gca, 'box','off','linewidth',2,'fontsize',14,'fontweight','b');
%                     
%                     if size(condnames,1)==1
%                         legend(texlabel(cdn{1},'literal'),'Location','WestOutside')
%                     elseif size(condnames,1)==2
%                         legend(texlabel(cdn{1},'literal'),texlabel(cdn{2},'literal'),'Location','WestOutside')
%                     elseif size(condnames,1)==3
%                         legend(texlabel(cdn{1},'literal'),texlabel(cdn{2},'literal'),texlabel(cdn{3},'literal'),'Location','WestOutside')
%                     end
                    
                    % RASTER PLOT Tvalues
                    initplot = zeros(size(condnames,1)*length(condnames{1}),size(condnames,1)*length(condnames{1}));
                    initplot_sd = zeros(size(condnames,1)*length(condnames{1}),size(condnames,1)*length(condnames{1}));
                    set(gcf,'Color',[1,1,1])
                    
                    for  condarray = 1:size(condnames,1)
                        
                        subplot(7,9,[37 38 39 46 47 48 55 56 57])
                        mean1{condarray} = mean(mean(mean(seg1{condarray}.trial(:,y,yt))));
                        mean2{condarray} =mean(mean(mean(seg2{condarray}.trial(:,y,yt))));
                        mean3{condarray} =mean(mean(mean(seg3{condarray}.trial(:,y,yt))));
                        sem1{condarray}   = std(mean(mean(seg1{condarray}.trial(:,y,yt),2),3),0,1)/sqrt(size(seg1{condarray}.trial,1));
                        sem2{condarray}   = std(mean(mean(seg2{condarray}.trial(:,y,yt),2),3),0,1)/sqrt(size(seg1{condarray}.trial,1));
                        sem3{condarray}   = std(mean(mean(seg3{condarray}.trial(:,y,yt),2),3),0,1)/sqrt(size(seg1{condarray}.trial,1));
                        
                        initplot((condarray-1)*3+1,(condarray-1)*3+1) = mean1{condarray};
                        initplot((condarray-1)*3+2,(condarray-1)*3+2) = mean2{condarray};
                        initplot((condarray-1)*3+3,(condarray-1)*3+3) = mean3{condarray};
                        
                        initplot_sd((condarray-1)*3+1,(condarray-1)*3+1) = sem1{condarray};
                        initplot_sd((condarray-1)*3+2,(condarray-1)*3+2) = sem2{condarray};
                        initplot_sd((condarray-1)*3+3,(condarray-1)*3+3) = sem3{condarray};
                        
                        limmintoplot((condarray-1)*3+1,(condarray-1)*3+1) = initplot((condarray-1)*3+1,(condarray-1)*3+1) ...
                            -  initplot_sd((condarray-1)*3+1,(condarray-1)*3+1);
                        limmintoplot((condarray-1)*3+2,(condarray-1)*3+2) = initplot((condarray-1)*3+2,(condarray-1)*3+2) ...
                            -  initplot_sd((condarray-1)*3+2,(condarray-1)*3+2);
                        limmintoplot((condarray-1)*3+3,(condarray-1)*3+3) = initplot((condarray-1)*3+3,(condarray-1)*3+3) ...
                            -  initplot_sd((condarray-1)*3+3,(condarray-1)*3+3);
                        limmaxtoplot((condarray-1)*3+1,(condarray-1)*3+1) = initplot((condarray-1)*3+1,(condarray-1)*3+1) ...
                            +  initplot_sd((condarray-1)*3+1,(condarray-1)*3+1);
                        limmaxtoplot((condarray-1)*3+2,(condarray-1)*3+2) = initplot((condarray-1)*3+2,(condarray-1)*3+2) ...
                            +  initplot_sd((condarray-1)*3+2,(condarray-1)*3+2);
                        limmaxtoplot((condarray-1)*3+3,(condarray-1)*3+3) = initplot((condarray-1)*3+3,(condarray-1)*3+3) ...
                            +  initplot_sd((condarray-1)*3+3,(condarray-1)*3+3);
                        
                        bar(initplot((condarray-1)*3+1,:),'facecolor',PlotColors(1,:),'linewidth',2);
                        hold on
                        bar(initplot((condarray-1)*3+2,:),'facecolor',PlotColors(2,:),'linewidth',2);
                        hold on
                        bar(initplot((condarray-1)*3+3,:),'facecolor',PlotColors(3,:),'linewidth',2);
                        hold on
                        
                    end
                    
                    errorbar([sum(initplot)],[sum(initplot_sd)],'linestyle','none','color','k','linewidth',2);hold on
                    ylabel(['Amplitude (' ampunit ')'],'fontsize',14,'fontweight','b');
                    axis([ 0 length(initplot)+1  min(sum(limmintoplot))*1.2 max(sum(limmaxtoplot))*1.2]);
                    set(gca,'xtick',1:2,'xticklabel',{''}, 'box','off','linewidth',2,'fontsize',14,'fontweight','b');
                    
                    % save plots
                    folder = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/ERFPs/';
                    if size(condnames,1)==1
                        filename = [folder cdn_clust '/PlotNegClust_' chansel_ '_negclust' num2str(countneg) '_VS_' cdn{1} ];
                    elseif size(condnames,1)==2
                        filename = [folder cdn_clust '/PlotNegClust_' chansel_ '_negclust' num2str(countneg) '_VS_' cdn{1} cdn{2} ];
                    elseif size(condnames,1)==3
                        filename = [folder cdn_clust '/PlotNegClust_' chansel_ '_negclust' num2str(countneg) '_VS_' cdn{1} cdn{2} cdn{3}];
                    end
                    print('-dpng',filename)
                    
                end
            end
        end
    end
    countneg = countneg +1;
    
end










