function [freq,powspctrm] = RemoveOneOverF_V2(freq,powspctrm)

powspctrm_save = powspctrm;
freq = unique(freq);

% input arg
% 2D data: Fullfreq   = freq.freq from fieldtrip freqanalysis
% 3D data: Fullspctrm = freq.powspctrm from fieldtrip freqanalysis

MaxFunEvals = 10^20;
MaxIter = 10^20;
TolFun = 1e-40;

ToRemove = zeros(size(powspctrm,1),size(powspctrm,2),size(powspctrm,3));
for j = 1:size(powspctrm,2)
    % compute k/f^alpha fit
    params(j,:) = OneOverFAndPeaksFit(freq,squeeze(mean(powspctrm(:,j,:)))',[1.e-27 0.5 1 10 2 18],...
                MaxFunEvals,MaxIter,TolFun);
    % remove fit
    FitPow   = params(j,1)*(1./((freq).^(params(j,2))) + ...
    (1/(params(j,3)*sqrt(2*pi)).*exp(-((freq - params(j,4)).^2)/(2*params(j,3)^2))) + ...
    (1/(params(j,5)*sqrt(2*pi)).*exp(-((freq - params(j,6)).^2)/(2*params(j,5)^2))));    
        
    for i = 1:size(powspctrm,1)
        ToRemove(i,j,:) = FitPow;
    end
    powspctrm_save(:,j,:) =  powspctrm_save(:,j,:) - ToRemove(:,j,:);
end

powspctrm = powspctrm_save;

for i = 1:102
    mysubplot(11,10,i)
    semilogx(squeeze(mean(ToRemove(:,i,:))))
end
for i = 1:102
    mysubplot(11,10,i)
    semilogx(squeeze(mean(powspctrm(:,i,:))))
end
