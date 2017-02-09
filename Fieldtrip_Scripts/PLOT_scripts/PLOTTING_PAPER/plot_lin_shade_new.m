
function [list_start,list_end] = plot_lin_shade_new(clust, alpha, stat, color,data, datatime)

    list_start = [];
    list_end   = [];

    % cluster shade
    t = [];
    for i = 1:length(clust)-1
        if abs(clust(i+1) - clust(i)) > 1
            t = [t i i+1];
        end
    end

    if isempty(t)
        tstart = stat.time(clust(1));
        tend   = stat.time(clust(end));
        
        [xs,ys] = find(datatime == tstart)
        [xe,ye] = find(datatime == tend)
        plot(stat.time(clust(1):clust(end)),data(ys:ye),'color',color,'linewidth',6)
        
        list_start = [list_start tstart]
        list_end   = [list_end     tend]

    elseif length(t) > 2

        tstart = stat.time(clust(1));
        tend   = stat.time(clust(t(1)));
            [xs,ys] = find(datatime == tstart)
            [xe,ye] = find(datatime == tend)
            plot(stat.time(clust(1):clust((1))),data(ys:ye),'color',color,'linewidth',6)
        list_start = [list_start tstart]
        list_end   = [list_end     tend]
        for i = 2:2:length(t)-1
            tstart = stat.time(clust(t(i)));
            tend   = stat.time(clust(t(i+1)));
            
            [xs,ys] = find(datatime == tstart)
            [xe,ye] = find(datatime == tend)
            plot(stat.time(clust(t(i)):clust((t+1))),data(ys:ye),'color',color,'linewidth',6)
            
            list_start = [list_start tstart]
            list_end   = [list_end     tend]
        end
        tstart = stat.time(clust(t(i+2)));
        tend   = stat.time(clust(end));

        [xs,ys] = find(datatime == tstart)
        [xe,ye] = find(datatime == tend)
        plot(stat.time(clust(t(i+2)):clust(end)),data(ys:ye),'color',color,'linewidth',6)
        
        list_start = [list_start tstart]
        list_end   = [list_end     tend]

    elseif length(t) == 2

        tstart = stat.time(clust(1));
        tend   = stat.time(clust(t(1)));
        
        [xs,ys] = find(datatime == tstart)
        [xe,ye] = find(datatime == tend)
        plot(stat.time(clust(1):clust(t(1))),data(ys:ye),'color',color,'linewidth',6)
        
%         line([tstart tend],[whereY whereY],'color',color,'linewidth',4)
        list_start = [list_start tstart]
        list_end   = [list_end     tend]
        
        tstart = stat.time(clust(t(2)));
        tend   = stat.time(clust(end));
        
        [xs,ys] = find(datatime == tstart)
        [xe,ye] = find(datatime == tend)
        plot(stat.time(clust(t(2)):clust(end)),data(ys:ye),'color',color,'linewidth',6)
%         line([tstart tend],[whereY whereY],'color',color,'linewidth',4)
        
        list_start = [list_start tstart]
        list_end   = [list_end     tend]

    end
end










