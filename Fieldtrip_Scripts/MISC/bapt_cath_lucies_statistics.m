function cath_lucies_statistics(data1, data2, PngfilesDir)

%% INIT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% % load them
% [ave_grandave,ave_avesoa] = load_categ(plot_categ,MatfilesDir,TL);
% 
% %load data
% data1           = ave_grandave(1).grandave;
% data2           = ave_grandave(2).grandave;
% 
% clear ave_grandave
% clear ave_avesoa

% data1 = LocStd;
% data2 = LocDev;
timewindow = [-.2,1.3];

%load chan list
[EEG,MEGm,MEGg,MEG,ALL] = loadchan_fieldtrip(data1.label);

% figure('Position',figpos) position and size
figpos = get( 0, 'ScreenSize' );
if figpos(3) > 1500
    figpos(1) = 1280;
    figpos(3) = 1280;
end

% % Change the latency to align on the ERN peak
% data1ERN = data1;
% data2ERN = data2;
% data1ERN.time = data1ERN.time([nearest(data1ERN.time,0.050)-10:nearest(data1ERN.time,0.050)+10]);
% data2ERN.time = data1ERN.time;
% data1ERN.individual = [];
% data2ERN.individual = [];
% for s = 1:size(data2.individual,1)
%     [min_v,ind] = min(data2.individual(s,336,60:80)); % min between 30 ms and 108 ms
%     disp(data2.time(60+ind));
%     tERNs(s) = ind + 60;
%     data1ERN.individual(s,:,:) = data1.individual(s,:,tERNs(s)-10:tERNs(s)+10);
%     data2ERN.individual(s,:,:) = data2.individual(s,:,tERNs(s)-10:tERNs(s)+10);
% end




% for EEG or MEG
ct = {'EEG';'Grad1';'Grad2';'Mag'};
ctind = {EEG;MEGg(1:2:end);MEGg(2:2:end);MEGm};
layoutfile = {'/neurospin/meg/meg_tmp/MaskingError_Lucie_2009/DATA/Topo/NMeeg_Standard.lay';...
     '/neurospin/local/fieldtrip/template/NM306mag.lay';...
     '/neurospin/local/fieldtrip/template/NM306mag.lay';...
     '/neurospin/local/fieldtrip/template/NM306mag.lay'};
%lims = {[-3.0e-6 3.0e-6];[-120e-14 120e-14 ];[-120e-14 120e-14 ];[-60e-15 60e-15]};
lims = {[-3.0e-6 3.0e-6];[-700e-14 700e-14 ];[-800e-14 800e-14 ];[-300e-15 300e-15]};
 
conservativity_stat(1).alphasize = 0.05;
conservativity_stat(1).mcc = 'fdr';
conservativity_stat(2).alphasize = 0.01; 
conservativity_stat(2).mcc = 'no';



%% CLASSIC PARAMETRIC AND NONPARAMETRIC STAT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% for itest = 1:length(conservativity_stat) 
%     
%     % ANALYTIC STATS
%     cfg = [];
%     cfg.channel     =  'all';
%     cfg.latency     = timewindow;
%     cfg.avgovertime = 'yes';
%     cfg.parameter   = 'individual';
%     cfg.method      = 'analytic';
%     cfg.statistic   = 'depsamplesT';
%     cfg.alpha       = conservativity_stat(itest).alphasize;
%     cfg.correctm    = conservativity_stat(itest).mcc;%'bonferoni'%'holms'%
%     Nsub = 13;
%     cfg.design(1,1:2*Nsub)  = [ones(1,Nsub) 2*ones(1,Nsub)];
%     cfg.design(2,1:2*Nsub)  = [1:Nsub 1:Nsub];
%     cfg.ivar                = 1; % the 1st row in cfg.design contains the independent variable
%     cfg.uvar                = 2; % the 2nd row in cfg.design contains the subject number
%     stat = ft_timelockstatistics(cfg,data1,data2);
% 
%     % PLOT STAT
%     data_1vs2 = data1;
%     data_1vs2.avg = data2.avg - data1.avg;
%     data_1vs2.individual = data2.individual - data1.individual;
%     for chan_type = 1:length(ct)
%         cfg = [];
%         cfg.layout = layoutfile{chan_type};
%         lay = ft_prepare_layout(cfg, data1);
%         if strcmp(ct,'MEG')
%             for i = 1:length(lay.label)-2 
%                 lay.label{i} = ['MEG' lay.label{i}];
%             end
%         end
%         lay = ft_prepare_layout(cfg, data1);
% %         cfg = [];
% %         cfg.layout = lay;
% %         layoutplot(cfg,data1)
%         cfg = [];
%         %cfg.style     = 'blank';
%         cfg.layout    = lay;
%         cfg.electrodes      = 'on';
%         cfg.highlight = 'labels';
%         if ~isempty(find(stat.mask(ctind{chan_type})))
%             cfg.highlight = find(stat.mask(ctind{chan_type}));
%         end
%         cfg.highlightsymbol    = '*';
%         cfg.highlightcolor    =[1 0 0];
%         cfg.highlightsize = 6;
%         cfg.highlightfontsize  = 14;
%         % cfg.marker  = 'labels';
%         % cfg.markerfontsize     = 6;
%         cfg.zlim = lims{chan_type};
%         cfg.comment   = [ct{chan_type} ' average time ' num2str(TOI(1)) '-' num2str(TOI(2)) ' ms'];
%         figname = ['ANALYTIC_' ct{chan_type} '_' num2str(conservativity_stat(itest).alphasize*100) '_MCC' num2str(conservativity_stat(itest).mcc)];
%         f=figure('Position',figpos);set(f,'Name',figname);
%         topoplot(cfg, mean(data_1vs2.avg(ctind{chan_type},[nearest(data1.time,TOI(1)):nearest(data1.time,TOI(2))]),2));
%         saveas(f,[PngfilesDir '/STAT_parametric/' TL '/' TL '_' 'STAT_' [plot_categ(:).name] '_' figname '.png'],'png');
%         save([PngfilesDir '/STAT_parametric/' TL '/' TL '_' 'STAT_' [plot_categ(:).name] '_' figname '.mat'],'stat');
%     end
% 
% 
% 
%     % MONTECARLO STAT
%     cfg = [];
%     cfg.channel     =  'all';
%     cfg.latency     = TOI;
%     cfg.avgovertime = 'yes';
%     cfg.parameter   = 'individual';
%     cfg.method      = 'montecarlo';
%     cfg.statistic   = 'depsamplesT';
%     cfg.alpha       = conservativity_stat(itest).alphasize;
%     cfg.correctm    = conservativity_stat(itest).mcc;
%     cfg.numrandomization = 1000;
%     Nsub = 13;
%     cfg.design(1,1:2*Nsub)  = [ones(1,Nsub) 2*ones(1,Nsub)];
%     cfg.design(2,1:2*Nsub)  = [1:Nsub 1:Nsub];
%     cfg.ivar                = 1; % the 1st row in cfg.design contains the independent variable
%     cfg.uvar                = 2; % the 2nd row in cfg.design contains the subject number
%     [stat] = ft_timelockstatistics(cfg,data1,data2);
% 
%     % PLOT STAT
%     data_1vs2 = data1;
%     data_1vs2.avg = data2.avg - data1.avg;
%     data_1vs2.individual = data2.individual - data1.individual;
%     for chan_type = 1:length(ct)
%         cfg = [];
%         cfg.layout = layoutfile{chan_type};
%         lay = ft_prepare_layout(cfg, data1);
%         if strcmp(ct,'MEG')
%             for i = 1:length(lay.label)-2 
%                 lay.label{i} = ['MEG' lay.label{i}];
%             end
%         end
%         lay = ft_prepare_layout(cfg, data1);
% %         cfg = [];
% %         cfg.layout = lay;
% %         layoutplot(cfg,data1)
%         cfg = [];
%         %cfg.style     = 'blank';
%         cfg.layout    = lay;
%         cfg.electrodes      = 'on';
%         cfg.highlight = 'labels';
%         if ~isempty(find(stat.mask(ctind{chan_type})))
%             cfg.highlight = find(stat.mask(ctind{chan_type}));
%         end
%         cfg.highlightsymbol    = '*';
%         cfg.highlightcolor    =[1 0 0];
%         cfg.highlightsize = 6;
%         cfg.highlightfontsize  = 14;
%         % cfg.marker  = 'labels';
%         % cfg.markerfontsize     = 6;
%         cfg.zlim = lims{chan_type};
%         cfg.comment   = [ct{chan_type} ' average time ' num2str(TOI(1)) '-' num2str(TOI(2)) ' ms'];
%         figname = ['MONTECARLO_' ct{chan_type} '_' num2str(conservativity_stat(itest).alphasize*100) '_MCC' num2str(conservativity_stat(itest).mcc)];
%         f=figure('Position',figpos);set(f,'Name',figname);
%         topoplot(cfg, mean(data_1vs2.avg(ctind{chan_type},[nearest(data1.time,TOI(1)):nearest(data1.time,TOI(2))]),2));
%         saveas(f,[PngfilesDir '/STAT_parametric/' TL '/' TL '_' 'STAT_' [plot_categ(:).name] '_' figname '.png'],'png');
%         save([PngfilesDir '/STAT_parametric/' TL '/' TL '_' 'STAT_' [plot_categ(:).name] '_' figname '.mat'],'stat');
%     end
%      
%     
% end
% 
% 
% 
% 
% 

%% CLUSTER STATS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


for chan_type = 2:4
    
    % layout preparation
    cfg = [];
    cfg.layout = layoutfile{chan_type};
    lay = ft_prepare_layout(cfg, data1);
    if ~strcmp(ct{chan_type},'EEG')
        for i = 1:length(lay.label)-2 
            lay.label{i} = ['MEG' lay.label{i}];
        end
    end
    lay.pos = lay.pos*10;
    lay.width = lay.width*10;
    lay.height = lay.height*10;
    for l = 1:length(lay.outline)
        lay.outline{l} = lay.outline{l}*10;
    end
    lay.mask{1} = lay.mask{1}*10;
    lay.label(1:end-2) = data1.label(ctind{chan_type});
    
    % Disp neighbour selection
    myneighbourdist = 1.5;
%     cfg = [];
%     cfg.channel = ctind{chan_type};
%     cfg.layout = lay;
%     cfg.minnbchan = 2;
%     cfg.neighbourdist = myneighbourdist;
%     cfg.feedback      = 'yes';
%     neighbours = ft_neighbourselection(cfg, data1);
    
    % Compute stat
    cfg = [];
    cfg.channel = ctind{chan_type};
    cfg.layout = lay;
    cfg.minnbchan = 3;
    cfg.neighbourdist = myneighbourdist;   
    cfg.latency = [0.6 .9];
    cfg.method = 'montecarlo';
    cfg.statistic = 'depsamplesT';
    cfg.correctm = 'cluster';
    cfg.clusteralpha = 0.05;
    cfg.clusterstatistic = 'maxsum';
    cfg.tail = 0;
    cfg.clustertail = 0;
    cfg.alpha = 0.05;
    cfg.numrandomization = 500;
    subj = 10;
    %design = [ones(1,subj), 2*ones(1,subj)];
    design = zeros(2,2*subj);
    for i = 1:subj
      design(1,i) = i;
    end
    for i = 1:subj
      design(1,subj+i) = i;
    end
    design(2,1:subj)        = 1;
    design(2,subj+1:2*subj) = 2;
    cfg.design = design;
    cfg.uvar  = 1;
    cfg.ivar  = 2;
    [stat] = ft_timelockstatistics(cfg,data1,data2);

    % PLOT STAT
    % put the substracted data in a structure
    data_1vs2 = data1;
    data_1vs2.avg = data2.avg - data1.avg;
    data_1vs2.individual = data2.individual - data1.individual; 
    % find if there are significant points
%     if isfield(stat,'posclusters')
%         pos = stat.posclusterslabelmat>=1;
% %         neg = stat.negclusterslabelmat>=1;
%     end
    
 %   plot across time
    window_avg = 5; %fenetre de points de sample sur lequel on avg les poscluster...
    m= 1:window_avg:length(stat.time);
    l = length(stat.time)/window_avg;
    ncol = max(ceil(l/floor(sqrt(l))),floor(sqrt(l))); 
    nraw = min(ceil(l/floor(sqrt(l))),floor(sqrt(l))); 
    f1 = figure('Position',figpos); set(f1,'Name',[ct{chan_type} ' Cluster Across Time']);
    for k = 1:length(stat.time)/window_avg-1;
        figure(f1)
        [x y w h] = mysubplot(nraw,ncol,k);
        subplot('Position',[x y w h]);
        hold on
        cfg = [];
        cfg.layout = lay; 
        
        if isfield(stat,'posclusters') && isfield(stat,'negclusters')
            n = 1;
            maxpos = 0;
            maxneg = 0;
            if isfield(stat.posclusters, 'prob')
                maxpos = length(find([stat.posclusters.prob]<.05));
            end
            if isfield(stat.negclusters, 'prob')
                maxneg = length(find([stat.negclusters.prob]<.05));
            end
            for clust = 1:max(maxpos,maxneg)
                
                pos_int = mean(stat.posclusterslabelmat(:,m(k):m(k+1))== clust,2); 
                neg_int = mean(stat.negclusterslabelmat(:,m(k):m(k+1)) == clust,2);

                if ~isempty(find(pos_int==1))
                     cfg.highlight{n} = find(pos_int==1);
                     if stat.posclusters(clust).prob <= 0.05
                        cfg.hlmarker{n} = '+';
                     else
                        cfg.hlmarker{n} = '.';
                     end
                     cfg.hlcolor{n} = [0 0 0];
                     cfg.hlmarkersize{n} = 6;
                     cfg.hllinewidth{n} = 2;
                     cfg.hlfacecolor{n} = [0 0 0];
                     n = n + 1;
                end
                if ~isempty(find(neg_int==1))
                     cfg.highlight{n} = find(neg_int==1);
                     if stat.negclusters(clust).prob <= 0.05
                        cfg.hlmarker{n} = 'x';
                     else
                        cfg.hlmarker{n} = '.';
                     end
                     cfg.hlcolor{n} = [0 0 0];
                     cfg.hlmarkersize{n} = 6;
                     cfg.hllinewidth{n} = 2;
                     cfg.hlfacecolor{n} = [0 0 0];
                     n = n + 1;
                end
            end
        end
        cfg.comment = [num2str(stat.time(m(k))) ' ms ' ct{chan_type}];   
        cfg.commentpos = 'title'; 
        cfg.zlim = [-6 6]; %  cfg.zlim = lims{chan_type};
        topoplot(cfg, stat.stat(:,m(k)));%  topoplot(cfg, data_1vs2.avg(ctind{chan_type},nearest(data_1vs2.time,stat.time(k))));       
    end

    
    % plot average for the all positive cluster
    if isfield(stat,'posclusters')
        l = length(stat.posclusters);
        ncol = max(ceil(l/floor(sqrt(l))),floor(sqrt(l))); 
        nraw = min(ceil(l/floor(sqrt(l))),floor(sqrt(l))); 
        f2 = figure('Position',figpos); set(f2,'Name',[ct{chan_type} ' Cluster Average']);
        for clust = 1:length(stat.posclusters)
            pos = stat.posclusterslabelmat==clust;
            clust_maxchan = 0;
            clust_signific_time = [];
            for k = 1:length(stat.time)
                if length(ctind{chan_type}(pos(:,k))) > clust_maxchan
                    clust_maxchan = length(ctind{chan_type}(pos(:,k)));
                    clust_maxchan_names = ctind{chan_type}(pos(:,k));
                    clust_maxtimesignif = k;
                end
                if ~isempty(ctind{chan_type}(pos(:,k)))
                    clust_signific_time = [clust_signific_time k];
                end
            end
            if ~isempty(clust_signific_time)
                tmin_signif = stat.time(clust_signific_time(1));
                tmax_signif = stat.time(clust_signific_time(end));
            else
                tmin_signif = 0;
                tmax_signif = 0;
            end
            figure(f2)
            [x y w h] = mysubplot(nraw,ncol,clust);
            subplot('Position',[x y w h]);
            hold on
            plot(data1.time,mean(data1.avg(clust_maxchan_names,:)),'Color',[0 0 1]);
            hold on
            plot(data2.time,mean(data2.avg(clust_maxchan_names,:)) ,'Color',[1 0 0]);%'LineWidth',2);
        %     ylabel('Volt')
            title([ct{chan_type} ' Cluster nb' num2str(clust) ' p-value' num2str(stat.posclusters(clust).prob)])
            xlabel('Time')
            axis([timewindow lims{chan_type}])
            %lh = legend(plot_categ(:).name,'Location','SouthEast');
            %set(lh,'FontSize',6);
            grid
            line([0 0],[-15e-6 15e-6],'Color','k','LineStyle','--');
            line(timewindow,[0 0],'Color','k','LineStyle','--');
            line([tmin_signif tmax_signif],[lims{chan_type}(2)*0.80 lims{chan_type}(2)*0.80] ,'Color','black','LineWidth',2);
        end
    end
    
    if ~exist(PngfilesDir,'dir') 
        mkdir(PngfilesDir)
    end
    
    saveas(f1,[PngfilesDir  ct{chan_type} '_topoacrosstime' '.fig']);
    if isfield(stat,'posclusters')
      saveas(f2,[PngfilesDir  ct{chan_type} '_clusteraverage' '.fig']);
    end
    save([PngfilesDir  ct{chan_type} '_ClusterStat' '.mat'],'stat');
    
    clear stat
    clear pos
    clear pos_int
end




