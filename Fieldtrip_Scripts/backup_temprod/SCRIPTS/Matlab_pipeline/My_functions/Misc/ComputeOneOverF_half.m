function [ToRemove] = ComputeOneOverF_half(freq,powspctrm)

powspctrm_save = powspctrm;
freq = unique(freq);

% input arg
% 2D data: Fullfreq   = freq.freq from fieldtrip freqanalysis
% 3D data: Fullspctrm = freq.powspctrm from fieldtrip freqanalysis

MaxFunEvals = 10^10;
MaxIter = 10^7;
TolFun = 1e-20;

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
end

ToRemove = mean(ToRemove);