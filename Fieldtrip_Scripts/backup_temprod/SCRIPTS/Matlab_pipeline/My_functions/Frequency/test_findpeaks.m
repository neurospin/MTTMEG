%% test finpeaks

P = [];
for i = 1:74
    F = findpeaks(squeeze(freq.powspctrm(i,1,:)));
    F1 = cell(1,length(F));;
    for k = 1:length(F)
        F1{k} = find(squeeze(freq.powspctrm(i,1,:)) == F(k));
        P = [P F1{k}'];
    end
end

hist(P, length(P));
    
    
    