function [Fullfreq,Fullspctrm,Fullspctrm_2,index] = linear_detrend(Fullfreq,Fullspctrm,rangefit)

[rte,index] = min(abs(Fullfreq  - rangefit(2)));
Fullspctrm = Fullspctrm(:,:,[1:index]);
Fullfreq   = Fullfreq([1:index]);

for i = 1:size(Fullspctrm,1)
    for j = 1:size(Fullspctrm,2)   
        P{i,j} = POLYFIT(Fullfreq,(squeeze(Fullspctrm(i,j,:)))',0);
        Fullspctrm_2(i,j,:) = POLYVAL(P{i,j},Fullfreq);
    end
end



















