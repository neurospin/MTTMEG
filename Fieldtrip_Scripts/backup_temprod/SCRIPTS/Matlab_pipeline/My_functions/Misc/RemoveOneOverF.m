function [freq,powspctrm] = RemoveOneOverF(freq,powspctrm,tag)

powspctrm_save = powspctrm;
freq = unique(freq);

% input arg
% 2D data: Fullfreq   = freq.freq from fieldtrip freqanalysis
% 3D data: Fullspctrm = freq.powspctrm from fieldtrip freqanalysis

MaxFunEvals = 10^10;
MaxIter = 10^7;
TolFun = 1e-20;

%% mean
if strcmp(tag,'mean') == 1
    
    ToRemove = zeros(size(powspctrm,1),size(powspctrm,2),size(powspctrm,3));
    for j = 1:size(powspctrm,2)
        % compute k/f^alpha fit
        params(j,:) = OneOverFFit(freq,squeeze(mean(powspctrm(:,j,:)))',[0 0.5],...
            MaxFunEvals,MaxIter,TolFun);
        % remove fit
        FitPow   = params(j,1)./((freq).^(params(j,2)));
        for i = 1:size(powspctrm,1)
            ToRemove(i,j,:) = FitPow;
            powspctrm_save(i,j,:) =  powspctrm_save(i,j,:) - mean(ToRemove(:,j,:),1);
        end
    end
    powspctrm = powspctrm_save;
end

%% trial-by-trial
if strcmp(tag,'trial-by-trial') == 1
    
    ToRemove = zeros(size(powspctrm,1),size(powspctrm,2),size(powspctrm,3));
    for j = 1:size(powspctrm,2)
        % compute k/f^alpha fit
        params(j,:) = OneOverFFit(freq,squeeze(mean(powspctrm(:,j,:)))',[0 0.5],...
            MaxFunEvals,MaxIter,TolFun);
        % remove fit
        FitPow   = params(j,1)./((freq).^(params(j,2)));
        for i = 1:size(powspctrm,1)
            ToRemove(i,j,:) = FitPow;
        end
        powspctrm_save(:,j,:) =  powspctrm_save(:,j,:) - ToRemove(:,j,:);
    end
    powspctrm = powspctrm_save;
end
end

