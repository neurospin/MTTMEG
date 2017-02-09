function [Minprev,Maxprev] = temprod_getMinMax(arrayindex, arraysubjects, tag)

% set root
root = SetPath(tag);

Minprev = +inf;
Maxprev = -inf;

for i = 1:length(arraysubjects)
    
    Dir = [root '/DATA/NEW/processed_' arraysubjects{i}];
    
    for j = 1:length(arrayindex{i,1});
        
        datapath               = [Dir '/FT_trials/Short&LongTrials_' num2str(arrayindex{i,1}(j)) '.mat'];
        load(datapath,'Min','Max')
        
        Minprev = min(Min,Minprev);
        Maxprev = max(Max,Maxprev);
        
    end 
end










