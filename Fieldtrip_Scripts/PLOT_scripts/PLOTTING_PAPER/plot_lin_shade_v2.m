
function [list_start,list_end] = plot_lin_shade(clust, alpha, stat, ymin, ymax,color,whereY, indchan,cmap_,heatmap_lim)

    list_start = [];
    list_end   = [];

    % cluster shade
    clust  = find(sum(stat.prob <= alpha) > 0);
    
    % get mean T or F values along time dimension
    meanval = mean(stat.stat(indchan, :))  
    
    % resample colormap
    cmap_orig = colormap(cmap_)
    cmap_new = []
    cmap_new(:,1) = interp1(1:length(cmap_orig),cmap_orig(:,1),linspace(1,64,192))
    cmap_new(:,2) = interp1(1:length(cmap_orig),cmap_orig(:,2),linspace(1,64,192))
    cmap_new(:,3) = interp1(1:length(cmap_orig),cmap_orig(:,3),linspace(1,64,192))
    
    heatmap_ind = linspace(heatmap_lim(1),heatmap_lim(end),192)
    
    % for each timepoint in the cluster, plot a colored point
    for i = clust
        tmp = [];
        tmp = meanval(i)
%         [x,y] = find(heatmap_ind <= tmp)
        [x index] = min(abs(heatmap_ind-tmp))
        plot(stat.time(i),whereY            ,'markerfacecolor',cmap_new(index,:),'markeredgecolor',cmap_new(index,:),'marker','s','markersize',1); hold on
        plot(stat.time(i),whereY+whereY*0.01,'markerfacecolor',cmap_new(index,:),'markeredgecolor',cmap_new(index,:),'marker','s','markersize',1); hold on
        plot(stat.time(i),whereY+whereY*0.02,'markerfacecolor',cmap_new(index,:),'markeredgecolor',cmap_new(index,:),'marker','s','markersize',1); hold on
        plot(stat.time(i),whereY+whereY*0.03,'markerfacecolor',cmap_new(index,:),'markeredgecolor',cmap_new(index,:),'marker','s','markersize',1); hold on
        plot(stat.time(i),whereY+whereY*0.04,'markerfacecolor',cmap_new(index,:),'markeredgecolor',cmap_new(index,:),'marker','s','markersize',1); hold on
        plot(stat.time(i),whereY+whereY*0.05,'markerfacecolor',cmap_new(index,:),'markeredgecolor',cmap_new(index,:),'marker','s','markersize',1); hold on
        plot(stat.time(i),whereY+whereY*0.06,'markerfacecolor',cmap_new(index,:),'markeredgecolor',cmap_new(index,:),'marker','s','markersize',1); hold on
        plot(stat.time(i),whereY+whereY*0.07,'markerfacecolor',cmap_new(index,:),'markeredgecolor',cmap_new(index,:),'marker','s','markersize',1); hold on
        plot(stat.time(i),whereY+whereY*0.08,'markerfacecolor',cmap_new(index,:),'markeredgecolor',cmap_new(index,:),'marker','s','markersize',1); hold on
        plot(stat.time(i),whereY+whereY*0.09,'markerfacecolor',cmap_new(index,:),'markeredgecolor',cmap_new(index,:),'marker','s','markersize',1); hold on
        plot(stat.time(i),whereY+whereY*0.10,'markerfacecolor',cmap_new(index,:),'markeredgecolor',cmap_new(index,:),'marker','s','markersize',1); hold on
    end
    
    t = [];
    for i = 1:length(clust)-1
        if abs(clust(i+1) - clust(i)) > 1
            t = [t i i+1];
        end
    end

    if isempty(t)
        tstart = stat.time(clust(1));
        tend   = stat.time(clust(end));
        list_start = [list_start tstart]
        list_end   = [list_end     tend]

    elseif length(t) > 2

        tstart = stat.time(clust(1));
        tend   = stat.time(clust(t(1)));
        list_start = [list_start tstart]
        list_end   = [list_end     tend]
        for i = 2:2:length(t)-1
            tstart = stat.time(clust(t(i)));
            tend   = stat.time(clust(t(i+1)));
            list_start = [list_start tstart]
            list_end   = [list_end     tend]
        end
        tstart = stat.time(clust(t(i+2)));
        tend   = stat.time(clust(end));
        list_start = [list_start tstart]
        list_end   = [list_end     tend]

    elseif length(t) == 2

        tstart = stat.time(clust(1));
        tend   = stat.time(clust(t(1)));
        list_start = [list_start tstart]
        list_end   = [list_end     tend]
        tstart = stat.time(clust(t(2)));
        tend   = stat.time(clust(end));
        list_start = [list_start tstart]
        list_end   = [list_end     tend]

    end
end

