function fig = ERFstatT_GroupLvl_v2(condnames,GDAVG,GDAVGt, chansel_, data1,data2,graphcolor)

set(0,'DefaultFigureRenderer','OpenGL')
set(0,'DefaultFigureRendererMode', 'manual')

if strcmp(data1.label{1,1},'MEG0111') == 1
    chantype = 'Mags';
    
    load('/neurospin/meg/meg_tmp/tools_tmp/Pipeline/pipeline/neuromag306mag_neighb.mat')
    
    
elseif strcmp(data1.label{1,1},'MEG0113') == 1 || strcmp(data1.label{1,1},'MEG0112') == 1
    chantype = 'Grads';
    
    load('/neurospin/meg/meg_tmp/tools_tmp/Pipeline/pipeline/neuromag306planar_neighb.mat')
    
elseif strcmp(data1.label{1,1},'EEG001') == 1
    chantype = 'EEG';
    
    cfg = [];
    EEG = EEG_for_layouts('Network');
    cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/eeg_64_NM20884N.lay';
    lay                       = ft_prepare_layout(cfg,GDAVG{1});
    lay.label               = EEG;
    
    cfg                     = [];
    myneighbourdist         = 0.2;
    cfg.method              = 'distance';
    cfg.channel             = EEG;
    cfg.layout              = lay;
    cfg.minnbchan           = 2;
    cfg.neighbourdist       = myneighbourdist;
    cfg.feedback            = 'no';
    neighbours              = ft_prepare_neighbours(cfg, GDAVG{1});
    
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
lay                           = ft_prepare_layout(cfg,data1);
lay.label                     = data1.label;

datasave1 = data1;
datasave2 = data2;

tmp =round(datasave1.time*100)/100;
n = round(length(datasave1.time)/5.5);
point1   = find(tmp == 0.05);
point2   = find(tmp == 0.15);
point3   = find(tmp == 0.25);
point4   = find(tmp == 0.35);
point5   = find(tmp == 0.45);
point6   = find(tmp == 0.55);
point7   = find(tmp == 0.65);
point8   = find(tmp == 0.75);
point9   = find(tmp == 0.85);
point10 = find(tmp == 0.95);
point11 = find(tmp == 1.05);
intv{1}   = [(point1(1)):(point2(1)-1)];
intv{2}   = [(point2(1)):(point3(1)-1)];
intv{3}   = [(point3(1)):(point4(1)-1)];
intv{4}   = [(point4(1)):(point5(1)-1)];
intv{5}   = [(point5(1)):(point6(1)-1)];
intv{6}   = [(point6(1)):(point7(1)-1)];
intv{7}   = [(point7(1)):(point8(1)-1)];
intv{8}   = [(point8(1)):(point9(1)-1)];
intv{9}   = [(point9(1)):(point10(1)-1)];
intv{10} = [(point10(1)):(point11(1)-1)];

for ii =1:10
    data1 = datasave1;
    data2 = datasave2;
    data2.time = data1.time(intv{1});
    data1.time = datasave1.time(intv{1});
    data1.individual = datasave1.individual(:,:,intv{ii});
    %     cfg = [];
%     cfg.toilim = [0 0.2];
%     data1 = ft_redefinetrial(cfg,data1);
    
    % test based on fieldtrip tutorial
    cfg = [];
    cfg.channel               = 'all';
    cfg.latency                = 'all';
    cfg.frequency            = 'all';
    cfg.method               = 'montecarlo';
    cfg.statistic               = 'actvsblT';
    cfg.correctm             = 'cluster';
    cfg.clusteralpha         = 0.005;
    cfg.clusterstatistic       = 'maxsum';
    cfg.minnbchan           = 2;
    cfg.tail                       = 0;
    cfg.clustertail              = 0;
    cfg.alpha                    = 0.0025;
    cfg.numrandomization = 1000;
    cfg.neighbours       = neighbours;
    
    ntrialdim1 = size(data1.individual,1);
    ntrialdim2 = size(data2.individual,1);
    
    design1 = [1:ntrialdim1 1:ntrialdim1];
    
    design2 = zeros(1,ntrialdim1 + ntrialdim2);
    design2(1,1:ntrialdim1) = 1;
    design2(1,(ntrialdim1+1):(ntrialdim1 + ntrialdim2))= 2;
    
    cfg.design           = [design1; design2];
    cfg.uvar  = 1;
    cfg.ivar  = 2;
    
    [stat] = ft_timelockstatistics(cfg,data1,data2);
    
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
    fig = figure;
    
    cdn = [];
    for i = 1:length(condnames)
        cdn = [cdn condnames{i} '_'];
    end
    
    countpos = 0;
    if isfield(stat,'posclusters') == 1
        if isempty(stat.posclusters) == 0
            for k = 1:length(stat.posclusters)
                if stat.posclusters(1,k).prob < 0.005
                    
                    fig = figure('position',[1 1 500 500]);
                    set(fig,'PaperPosition',[1 1 500 500])
                    set(fig,'PaperPositionmode','auto')
                    set(fig,'Visible','on')
                    
                    linmask  = []; linmaskt = [];
                    linmask  = (sum((stat.posclusterslabelmat == k)') ~= 0);
                    x = [];y = []; [x,y] = find(linmask == 1);
                    linmaskt = (sum((stat.posclusterslabelmat == k)) ~= 0);
                    xt = [];yt = []; [xt,yt] = find(linmaskt == 1);
                    
                    min1  = min(mean(mean(data1.individual(:,y,:),1),2));
                    max1 = max(mean(mean(data1.individual(:,y,:),1),2));
                    
                    % ERF
                    subplot(6,6,[4 5 6 10 11 12]);
                    cfg                          = [];
                    cfg.ylim                   = 'maxabs';
                    cfg.linewidth            = 2;
                    cfg.graphcolor         = graphcolor;
                    cfg.channel              = stat.label(linmask);
                    ft_singleplotER(cfg,datasave1);
                    title(['posclust' num2str(countpos)]); xlabel([' p= ' num2str(stat.posclusters(1,k).prob)]);
                    %                 legend(condnames)
                    countpos = countpos + 1;
                    hold on

                    linenim =  datasave1.time(intv{ii});
                    line([linenim(1) linenim(end)],[ min1*1.1 min1*1.1],'linewidth',2,'color','k')
                    
                    % RASTER PLOT Tvalues
                    
                    subplot(6,6,[1 2 3 7 8 9])
                    lim = [-max(max(stat.stat)) max(max(stat.stat))];
                    mask = (stat.posclusterslabelmat == k);
                    imagesc(stat.stat.*(mask),lim)
                    xlabel('Time samples','fontweight','b'); ylabel('channels');
                    
                    titlec = 'Tval, p<0.05: ';
                    for i = 1:length(condnames)
                        titlec = [titlec condnames{i} '-'];
                    end
                    titlec(end) = [];
                    title(titlec)
                    
                    sample = (stat.time(end) - stat.time(1))./length(stat.time);
                    n = round(0.025/sample);
                    nfull = floor(length(stat.time)/n);
                    set(gca,'xtick',1:n:nfull*n,'xticklabel',stat.time(1:n:nfull*n)-ones(1,length(1:n:nfull*n))*0.001)
                    
                    for j = 1:1:(min(nfull+1,18))
                        mysubplot(6,6,j+18)
                        chansel = (stat.posclusterslabelmat(:,1+n*(j-1)) == k);
                        if sum(chansel) == 0
                            cfg                          = [];
                            cfg.layout                 = lay;
                            cfg.xlim                   = [round(stat.time(1+n*(j-1))*100)/100 round(stat.time(1+n*(j-1))*100)/100];
                            cfg.zlim                   = lim;
                            cfg.style                   = 'straight';
                            cfg.parameter          = 'stat';
                            cfg.marker               = 'off';
                            cfg.comment            = [num2str(round(stat.time(1+n*(j-1))*100)/100) ' ms'];
                            ft_topoplotER(cfg,stat);
                        else
                            [x,y] = find(chansel ~= 0);
                            cfg                           = [];
                            cfg.highlight              = 'on';
                            cfg.highlightchannel   = x;
                            cfg.highlightsymbol    = '.';
                            cfg.layout                  = lay;
                            cfg.xlim                     = [round(stat.time(1+n*(j-1))*100)/100 round(stat.time(1+n*(j-1))*100)/100];
                            cfg.zlim                     = lim;
                            cfg.style                     = 'straight';
                            cfg.parameter            = 'stat';
                            cfg.marker                = 'off';
                            cfg.comment              = [num2str(round(stat.time(1+n*(j-1))*100)/100) ' ms'];
                            ft_topoplotER(cfg,stat);
                        end
                    end
                    
                    
                    folder = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/ERFPs/';
                    if exist([folder cdn],'dir') == 0
                        mkdir([folder cdn])
                    end
                    % save plots
                    filename = [folder cdn '/STATS_' chansel_ '_AVBpos' num2str(countpos) '_bin' num2str(ii)];
                    print('-dpng',filename)
                    
                end
            end
        end
    end
    
    
    countneg = 0;
    if isfield(stat,'negclusters') == 1
        if isempty(stat.negclusters) == 0
            for k = 1:length(stat.negclusters)
                if stat.negclusters(1,k).prob < 0.005
                    
                    fig = figure('position',[1 1 500 500]);
                    set(fig,'PaperPosition',[1 1 500 500])
                    set(fig,'PaperPositionmode','auto')
                    set(fig,'Visible','on')
                    
                    linmask  = []; linmaskt = [];
                    linmask  = (sum((stat.negclusterslabelmat == k)') ~= 0);
                    x = [];y = []; [x,y] = find(linmask == 1);
                    linmaskt = (sum((stat.negclusterslabelmat == k)) ~= 0);
                    xt = [];yt = []; [xt,yt] = find(linmaskt == 1);
                    
                     min1  = min(mean(mean(data1.individual(:,y,:),1),2));
                    max1 = max(mean(mean(data1.individual(:,y,:),1),2));
                    
                    % ERF
                    subplot(6,6,[4 5 6 10 11 12]);
                    cfg                          = [];
                    cfg.ylim                   = 'maxabs';
                    cfg.linewidth            = 2;
                    cfg.graphcolor         = graphcolor;
                    cfg.channel              = stat.label(linmask);
                    ft_singleplotER(cfg,datasave1);
                    title(['negclust' num2str(countneg)]); xlabel([' p= ' num2str(stat.negclusters(1,k).prob)]);
                    %                 legend(condnames)
                    countneg = countneg + 1;
                    hold on

                   linenim =  datasave1.time(intv{ii});
                    line([linenim(1) linenim(end)],[ min1*1.1 min1*1.1],'linewidth',2,'color','k')
                    
                    % RASTER PLOT Tvalues
                    
                    subplot(6,6,[1 2 3 7 8 9])
                    lim = [-max(max(stat.stat)) max(max(stat.stat))];
                    mask = (stat.negclusterslabelmat == k);
                    imagesc(stat.stat.*(mask),lim)
                    xlabel('Time samples'); ylabel('channels');
                    
                    titlec = 'Tval, p<0.05: ';
                    for i = 1:length(condnames)
                        titlec = [titlec condnames{i} '-'];
                    end
                    titlec(end) = [];
                    title(titlec)
                    
                    sample = (stat.time(end) - stat.time(1))./length(stat.time);
                    n = round(0.025/sample);
                    nfull = floor(length(stat.time)/n);
                    set(gca,'xtick',1:n:nfull*n,'xticklabel',stat.time(1:n:nfull*n)-ones(1,length(1:n:nfull*n))*0.001)
                    
                    for j = 1:1:(min(nfull+1,18))
                        mysubplot(6,6,j+18)
                        chansel = (stat.negclusterslabelmat(:,1+n*(j-1)) == k);
                        if sum(chansel) == 0
                            cfg                          = [];
                            cfg.layout                 = lay;
                            cfg.xlim                   = [round(stat.time(1+n*(j-1))*100)/100 round(stat.time(1+n*(j-1))*100)/100];
                            cfg.zlim                   = lim;
                            cfg.style                   = 'straight';
                            cfg.parameter          = 'stat';
                            cfg.marker               = 'off';
                            cfg.comment            = [num2str(round(stat.time(1+n*(j-1))*100)/100) ' ms'];
                            ft_topoplotER(cfg,stat);
                        else
                            [x,y] = find(chansel ~= 0);
                            cfg                           = [];
                            cfg.highlight              = 'on';
                            cfg.highlightchannel   = x;
                            cfg.highlightsymbol    = '.';
                            cfg.layout                  = lay;
                            cfg.xlim                     = [round(stat.time(1+n*(j-1))*100)/100 round(stat.time(1+n*(j-1))*100)/100];
                            cfg.zlim                     = lim;
                            cfg.style                     = 'straight';
                            cfg.parameter            = 'stat';
                            cfg.marker                = 'off';
                            cfg.comment              =  [num2str(round(stat.time(1+n*(j-1))*100)/100) ' ms'];
                            ft_topoplotER(cfg,stat);
                        end
                    end
                    
                    folder = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/ERFPs/';
                    if exist([folder cdn],'dir') == 0
                        mkdir([folder cdn])
                    end
                    % save plots
                    filename = [folder cdn '/STATS_' chansel_ '_AVBneg' num2str(countneg) '_bin' num2str(ii)];
                    print('-dpng',filename)
                    
                end
            end
        end
    end
    
    count = [];
    count = countneg + countpos;
    
    
    % GDAVGt_diff{1,1}.individual = GDAVGt{1,1}.individual  - GDAVGt{1,2}.individual;
    %  [FIND,BIND,VIND,LIND,RIND,FCHANS,BCHANS,VCHANS,LCHANS,RCHANS] = clusteranat('Network');
    % cmap                   = colormap('jet');
    % colplot                 = cmap(1:3:17*3,:);
    %
    % if isfield(stat,'posclusters') == 1
    %     if isempty(stat.negclusters) == 0
    %         for k = 1:length(stat.negclusters)
    %             if stat.posclusters(1,k).prob < 0.07
    %                x = find(mean((stat.posclusterslabelmat == k),2) ~= 0);
    %
    %                figure
    %                for i = 1:size(GDAVGt{1,1}.individual,1)
    %                    mysubplot(5,4,i)
    %
    %                    plot(GDAVGt{1,1}.time,squeeze(mean(GDAVGt{1,1}.individual(i,x,:),2)),'linewidth',2,'color','k');
    %                    hold on
    %                    plot(GDAVGt{1,2}.time,squeeze(mean(GDAVGt{1,2}.individual(i,x,:),2)),'linewidth',2,'color','k','linestyle','-.');
    %                    hold on
    %                    plot(GDAVGt{1,1}.time,squeeze(mean(GDAVGt_diff{1,1}.individual(i,x,:),2)),'linewidth',2,'color',colplot(i,:));
    %                    hold on
    %                    line([-0.1 0.9],[0 0 ],'linewidth',3,'color','k')
    %                    axis([-0.1 0.9 -1e-13 1e-13])
    %                end
    %             end
    %         end
    %     end
    % end
    
end







