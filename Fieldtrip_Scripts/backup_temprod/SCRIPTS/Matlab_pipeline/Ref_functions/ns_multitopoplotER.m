function ns_multitopoplotER(davg,tlim,zmax)
% function multi_topoplotER(data,tlim,zmax) plots topography of the three
% sensor types separately for a selection of time intervals 
% Input:
% davg = averaged data = data.avg if data = fieldtrip dataset, format from
% ft_timelockanalysis, = data if data = grand averaged fieldtrip dataset,
% format from ft_timelockgrandaverage
% tlim = time intervals within which ERFs are averaged. 
% Example: tlim = [tmin; tmax] = [0 0.2; 0.1 0.3] for time intervals [0 100 ms] and [200
% ms 300 ms];
% zmax = z limits (1/10 for Mag)
%
% Marco Buiatti, INSERM U992 Cognitive Neuroimaging Unit (France), 2010.

load SensorClassification.mat
chtype={Grad_1,Grad_2,Mag};
cfg = [];
cfg.layout = 'NM306all.lay';
cfg.comment ='xlim';
figure
dloc=davg;
for j=1:size(tlim,2)
    cfg.xlim=[tlim(1,j) tlim(2,j)];
    for i=1:length(chtype)
        if i==3 cfg.zlim=[-zmax,zmax]/10; else cfg.zlim=[-zmax,zmax]; end; 
        subplot(size(tlim,2),3,i+3*(j-1))
        [sel1, sel2] = match_str(All, chtype{i});
        dloc.label=chtype{i};
        dloc.avg=davg.avg(sel1,:);
        ft_topoplotER(cfg, dloc);
    end;
end;