function data = barplotvalmult(GDAVGt,alpha,stat,index,graphcolor,limaxis,fmult)

clust  = find(sum(stat.prob <= alpha) > 0);
indchan = []; indchan = find(stat.prob(:,index) <alpha);

% cluster pieces
t = [];
for i = 1:length(clust)-1
    if abs(clust(i+1) - clust(i)) > 1
        t = [t i i+1];
    end
end

interval = [];

if length(t) >2

    Tstart(1) = find(abs(GDAVGt{3}.time - stat.time(clust(1))) < 1e-6);
    Tend(1)   = find(abs(GDAVGt{3}.time - stat.time(clust(t(1)))) < 1e-6);
    interval = [Tstart(1):Tend(1)];
    
    for i = 2:2:length(t)-1 
        Tstart(i/2+1) = find(abs(GDAVGt{3}.time - stat.time(clust(t(i)))) < 1e-6);
        Tend(i/2+1)   = find(abs(GDAVGt{3}.time - stat.time(clust(t(i+1)))) < 1e-6);
        interval = [interval Tstart(i/2+1):Tend(i/2+1)];
    end
    
    Tstart(i/2+2) = find(abs(GDAVGt{3}.time - stat.time(clust(t(i)))) < 1e-6);
    Tend(i/2+2)   = find(abs(GDAVGt{3}.time - stat.time(clust(end))) < 1e-6);   
    interval = [interval Tstart(i/2+2):Tend(i/2+2)];

elseif length(t) == 2
    Tstart(1) = find(abs(GDAVGt{3}.time - stat.time(clust(1))) < 1e-6);
    Tend(1)   = find(abs(GDAVGt{3}.time - stat.time(clust(t(1)))) < 1e-6);
    Tstart(2) = find(abs(GDAVGt{3}.time - stat.time(clust(t(2)))) < 1e-6);
    Tend(2)   = find(abs(GDAVGt{3}.time - stat.time(clust(end))) < 1e-6);  
    interval  = [Tstart(1):Tend(1) Tstart(2):Tend(2)];
end
    
for i = 1:length(Tstart)
    fig = figure('position',[1 1 300 300]);
    set(fig,'PaperPosition',[1 1 300 300])
    set(fig,'PaperPositionmode','auto')
    set(fig,'Visible','on')
    
    dat1 = mean(mean(GDAVGt{1}.individual(:,indchan,[Tstart(i):Tend(i)]),2),3)*fmult;
    dat2 = mean(mean(GDAVGt{2}.individual(:,indchan,[Tstart(i):Tend(i)]),2),3)*fmult;
    dat3 = mean(mean(GDAVGt{3}.individual(:,indchan,[Tstart(i):Tend(i)]),2),3)*fmult;

    bar([mean(dat1) 0 0],'facecolor',graphcolor(1,:),'edgecolor','k','linewidth',2);hold on
    bar([0 mean(dat2) 0],'facecolor',graphcolor(2,:),'edgecolor','k','linewidth',2);hold on
    bar([0 0 mean(dat3)],'facecolor',graphcolor(3,:),'edgecolor','k','linewidth',2);hold on
    errorbar(mean([dat1 dat2,dat3]),std([dat1 dat2,dat3])./sqrt(19),'linestyle',...
            'none','color','k','linewidth',3)
    line([0.5 3.5],[0 0],'color','k','linewidth',2);hold on
    axis(limaxis)
    set(gca, 'box','off','linewidth',2,'fontsize',14,'fontweight','b');
end

data = [dat1 dat2 dat3];












