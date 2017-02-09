function [estimates] = OneOverFAndPeaksFit(xdata, ydata,start,MaxFunEvals,MaxIter,TolFun)
% Call fminsearch with a random starting point.

estimates = fminsearch(@oneaverfnoise,start,...
optimset('MaxFunEvals',MaxFunEvals,'MaxIter',MaxIter,'TolFun',TolFun));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% subfunction %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function [sse,FittedPow] = oneaverfnoise(params)
        K           = params(1);
        alpha       = params(2);
        sigma1       = params(3);
        mu1          = params(4);
        sigma2       = params(5);
        mu2          = params(6);  
        % model power spectrum as a sum of K/f^alpha 
        % + alpha peak (gaussian shape)
        % + beta peak (gaussian shape)
        FittedPow    = K*(1./((xdata).^(alpha)) + ...
                      (1/(sigma1*sqrt(2*pi)).*exp(-((xdata - mu1).^2)/(2*sigma1^2))) + ...
                      (1/(sigma2*sqrt(2*pi)).*exp(-((xdata - mu2).^2)/(2*sigma2^2))));
        Error       = FittedPow - ydata;
        sse         = sum(Error.^2);
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end