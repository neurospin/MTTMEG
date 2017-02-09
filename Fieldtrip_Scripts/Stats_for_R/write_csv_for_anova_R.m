function write_csv_for_anova_R(DataMat, CondNames, FileName)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% check data/Names consistency
if size(DataMat,2) ~= length(CondNames)
    error('check DataMat & CondNames size consistency')
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% write results in a text file
WriteDataFile = FileName;
fileID = fopen(WriteDataFile,'w');

DATAforR1 = [];
DATAforR2 = [];

% data as columns and labels
DATAforR1 = DataMat;

for a = 1:length(CondNames)
    DATAforR2{1,a}  = CondNames{a};
end

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















