function [freq,powspctrm] = RemoveOneOverF_half(freq,powspctrm,ToRemove)

for i = 1:size(powspctrm,1)
    for j = 1:size(powspctrm,2)
        powspctrm(i,j,:) =  powspctrm(i,j,:) - ToRemove(1,j,:);
    end
end

