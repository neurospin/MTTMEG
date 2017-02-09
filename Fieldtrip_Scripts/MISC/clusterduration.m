%cluster time


plot(stat.time,mean(stat.prob <= 0.05));
tmp = [];
tmp = find(mean(stat.prob <= 0.05)>0);
int = [stat.time(tmp(1)) stat.time(tmp(end))]

