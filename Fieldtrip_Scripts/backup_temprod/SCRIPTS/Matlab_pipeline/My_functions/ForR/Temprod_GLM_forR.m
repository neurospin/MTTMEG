function Temprod_GLM_forR(SubjectArray, RunArray, chantype, freqband, condname, tag)

% set root path
root = SetPath(tag);

%% BUILD VARIABLES
% init loop variables
SUB         = []; % subject regressor
yp          = []; % power data
yf          = []; % frequency data
ys          = []; % slope data
DURREG      = []; % regressor of interest
ACCREG      = []; % regressor of interest
MEDREG      = []; % regressor of interest
DUROFF      = []; % offset
ACCOFF      = []; % offset
MEDOFF      = []; % offset

for i     = 1:length(SubjectArray) % loop for all subjects
        
    % loop for all runs
    for j = 1:length(RunArray{i,1})
        
        % load data
        ProcDataDir = [root '/DATA/NEW/processed_' char(SubjectArray{i,1}) '/'];
        loadpath = [ProcDataDir 'FT_spectra/POW+FREQ_' chantype '_RUN' num2str(RunArray{i,1}(j),'%02i') ...
            '_' num2str(freqband(1)) '_' num2str(freqband(2)) 'Hz.mat'];
        load(loadpath)
        
        % build subject regressor
        SUB     = [SUB ; ones(size(ACCURACY,1),1)*i];
        
        % build 1/dur regressor
        tmp      = []; tmp = sortrows(flipdim(DURATIONSORTED,2));
        DURREG   = [DURREG ; tmp(:,2)];
        DUROFF   = [DUROFF ; ones(size(tmp,1),1)*mean(tmp(:,2))];
        
        % build acc regressor
        tmp      = []; tmp = sortrows(flipdim(ACCURACY,2));
        ACCREG   = [ACCREG ; tmp(:,2)];
        ACCOFF   = [ACCOFF ; ones(size(tmp,1),1)*mean(tmp(:,2))];        
        
        % build acc regressor
        tmp      = []; tmp = sortrows(flipdim(MEDDEVIATION,2));
        MEDREG   = [MEDREG ; tmp(:,2)];
        MEDOFF   = [MEDOFF ; ones(size(tmp,1),1)*mean(tmp(:,2))];              
        
        % compute average power across channels for each trial
        pow = [];
        for k = 1:length(POWER)
            pow = [pow ; POWER{k}];
        end
        yp    = [yp (nanmean(pow))];
        
        % compute average frequency across channels for each trial
        freq = [];
        for k = 1:length(FREQUENCY)
            freq = [freq ; FREQUENCY{k}];
        end
        yf    = [yf (nanmean(freq))];
        
        % compute average slope across channels for each trial
        slope = [];
        for k = 1:length(SLOPE)
            slope = [slope ; SLOPE{k}];
        end
        ys    = [ys (nanmean(slope))];
        
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% write results in a text file
WriteDataFile = ['C:\TEMPROD\DATA\NEW\ForR\' chantype '_' num2str(freqband(1)) '-' num2str(freqband(2)) '_' condname '.txt'];
fileID = fopen(WriteDataFile,'w');

DATAforR1 = []; 
DATAforR2 = [];

% data as columns and labels
DATAforR1 = [yf' yp' ys' 1./DURREG ACCREG MEDREG SUB ACCOFF 1./DUROFF MEDOFF];
DATAforR2{1,1}  = 'FreqPeaks';
DATAforR2{1,2}  = 'PowPeaks';
DATAforR2{1,3}  = 'SlopeCoeff';
DATAforR2{1,4}  = 'InvDur';
DATAforR2{1,5}  = 'RealAcc';
DATAforR2{1,6}  = 'MedDev';
DATAforR2{1,7}  = 'Subject';
DATAforR2{1,8}  = 'AccOff';
DATAforR2{1,9}  = 'DurOff';
DATAforR2{1,10} = 'MedDevOff';

for i = 1:size(DATAforR1,1)
    for j = 1:size(DATAforR1,2)
        DATAforR2{i+1,j} = DATAforR1(i,j);
    end
end

% write data in a text file readable by R
for i = 1:size(DATAforR2,1)
    for j = 1:size(DATAforR2,2)
        if j == 1
            fprintf(fileID, '%s', [' ' num2str(DATAforR2{i,j})]);
        elseif j < size(DATAforR2,2)
            fprintf(fileID, '%s', [' ' num2str(DATAforR2{i,j})]);
        elseif j == size(DATAforR2,2)
            fprintf(fileID, '%s\n', [' ' num2str(DATAforR2{i,j})]);
        end
    end
end
close all


