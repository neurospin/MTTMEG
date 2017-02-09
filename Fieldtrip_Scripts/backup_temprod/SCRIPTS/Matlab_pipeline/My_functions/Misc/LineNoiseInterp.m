function [Fullfreq,Fullspctrm] = LineNoiseInterp(Fullfreq,Fullspctrm)

% input arg
% 2D data: Fullfreq   = freq.freq from fieldtrip freqanalysis
% 3D data: Fullspctrm = freq.powspctrm from fieldtrip freqanalysis

% noise removal and channel-by-channel linear interpolation replacemement

LNfbegin                = find(Fullfreq >= 49);
LNfend                  = find(Fullfreq <= 51);
LNfband                 = LNfbegin(1):LNfend(end);
for i = 1:size(Fullspctrm,1)
    for j = 1:size(Fullspctrm,2)
        L = linspace(Fullspctrm(i,j,LNfbegin(1)),... % beginning of the range
            Fullspctrm(i,j,LNfend(end)),... % end of the range
            LNfend(end) - LNfbegin(1) + 1); % number of frequency bins to replace
        Fullspctrm(i,j,LNfband) = L;
    end
end

% noise removal and channel-by-channel linear interpolation replacemement

LNfbegin                = find(Fullfreq >= 99);
LNfend                  = find(Fullfreq <= 101);
LNfband                 = LNfbegin(1):LNfend(end);
for i = 1:size(Fullspctrm,1)
    for j = 1:size(Fullspctrm,2)
        L = linspace(Fullspctrm(i,j,LNfbegin(1)),... % beginning of the range
            Fullspctrm(i,j,LNfend(end)),... % end of the range
            LNfend(end) - LNfbegin(1) + 1); % number of frequency bins to replace
        Fullspctrm(i,j,LNfband) = L;
    end
end


% specific noise temporary removal + interpolation


% Nfbegin                = find(Fullfreq >= 91);
% Nfend                  = find(Fullfreq <= 93);
% Nfband                 = Nfbegin(1):Nfend(end);
% for i = 1:size(Fullspctrm,1)
%     for j = 1:size(Fullspctrm,2)
%         L = linspace(Fullspctrm(i,j,Nfbegin(1)),... % beginning of the range
%             Fullspctrm(i,j,Nfend(end)),... % end of the range
%             Nfend(end) - Nfbegin(1) + 1); % number of frequency bins to replace
%         Fullspctrm(i,j,Nfband) = L;
%     end
% end


