function [estimates] = OneOverFFit(xdata, ydata,start,MaxFunEvals,MaxIter,TolFun)
% Call fminsearch with a random starting point.

estimates = fminsearch(@oneaverfnoise,start,...
optimset('MaxFunEvals',MaxFunEvals,'MaxIter',MaxIter,'TolFun',TolFun));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% subfunction %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function [sse,FittedPow] = oneaverfnoise(params)
        K           = params(1);
        alpha       = params(2);
        FittedPow   = K./((xdata).^(alpha));
        Error       = FittedPow - ydata;
        sse         = sum(Error.^2);
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end