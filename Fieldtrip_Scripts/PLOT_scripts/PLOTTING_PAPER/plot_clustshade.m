
function [list_start,list_end] = plot_clustshade(clust, alpha, stat, ymin, ymax,color)
    
    list_start = [];
    list_end   = [];
    
    % cluster shade
    clust  = find(sum(stat.prob <= alpha) > 0);
    t = [];
    for i = 1:length(clust)-1
        if abs(clust(i+1) - clust(i)) > 1
            t = [t i i+1];
        end
    end
    
    if isempty(t)
        tstart = stat.time(clust(1));
        tend   = stat.time(clust(end));
        rectangle('position',[tstart ymin tend-tstart ymax-ymin],'FaceColor',color,'EdgeColor',color)
        list_start = [list_start tstart]
        list_end   = [list_end     tend]
        
    elseif length(t) > 2
        
        tstart = stat.time(clust(1));
        tend   = stat.time(clust(t(1)));
        rectangle('position',[tstart ymin tend-tstart ymax-ymin],'FaceColor',color,'EdgeColor',color)
        list_start = [list_start tstart]
        list_end   = [list_end     tend]
        for i = 2:2:length(t)-1
            tstart = stat.time(clust(t(i)));
            tend   = stat.time(clust(t(i+1)));
            rectangle('position',[tstart ymin tend-tstart ymax-ymin],'FaceColor',color,'EdgeColor',color)
            list_start = [list_start tstart]
            list_end   = [list_end     tend]
        end
        tstart = stat.time(clust(t(i+2)));
        tend   = stat.time(clust(end));
        rectangle('position',[tstart ymin tend-tstart ymax-ymin],'FaceColor',color,'EdgeColor',color)
        list_start = [list_start tstart]
        list_end   = [list_end     tend]
        
    elseif length(t) == 2
        
        tstart = stat.time(clust(1));
        tend   = stat.time(clust(t(1)));
        rectangle('position',[tstart ymin tend-tstart ymax-ymin],'FaceColor',color,'EdgeColor',color)
        list_start = [list_start tstart]
        list_end   = [list_end     tend]
        tstart = stat.time(clust(t(2)));
        tend   = stat.time(clust(end));
        rectangle('position',[tstart ymin tend-tstart ymax-ymin],'FaceColor',color,'EdgeColor',color)
        list_start = [list_start tstart]
        list_end   = [list_end     tend]
        
    end
end

