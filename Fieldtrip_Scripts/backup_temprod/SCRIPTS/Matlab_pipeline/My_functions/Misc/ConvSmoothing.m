function Fullspctrm = ConvSmoothing(Fullspctrm,K)

% 21/02/2012 : add dummy data in function of the length of convolution vector

h =[];
for x               = 1:size(Fullspctrm,2)
    g = []; v = [];
    for y           = 1:size(Fullspctrm,3)
        v           = squeeze(Fullspctrm(:,x,y))';
        % add data "telodata" to avoid convolutions with zero padding 
        v           = [repmat(v(1),1,(length(K)-1)) v repmat(v(end),1,(length(K)-1))];
        f           = conv(v,K,'same');
        % remove dummy data points
        f(1:(length(K)-1)) = [];
        f((end - length(K) +2):end) = [];
        g(:,y) = f;
        clear f
    end
    h = cat(3,h,g);
end
h = permute(h,[1 3 2]);
Fullspctrm = h;
% divide by the sum of the convultion vector
Fullspctrm = Fullspctrm/(sum(K));