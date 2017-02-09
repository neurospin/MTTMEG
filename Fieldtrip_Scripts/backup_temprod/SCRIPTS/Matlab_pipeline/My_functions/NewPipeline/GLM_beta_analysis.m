% test beta analysis
SubjectArray       = [10 9 8 7 6];
RunArray           = {[2 3 5 6];[2 3 5 6] ;[2 3 5 6];[2 3 5];[2 3 5 6];2:6   ;[1 2 4 5] ;1:4  ;1:3  ;1:3};
Chan_type          = {'Mags';'Grads1';'Grads2'};
FreqbandArray      = {[2 5];[7 14];[15 30]};
CondnameArray      = {'AllEstimation'};

% set root
root = SetPath(tag);

Chan_type = {'Mags';'Grads1';'Grads2'};
BETAS = zeros(1,13);

for j = 1:length(FreqbandArray)
    for k = 1:length(Chan_type)
        for l = 1:length(CondnameArray)
            load(['C:\TEMPROD\DATA\NEW\across_subjects_data\GLMbetas_' Chan_type{k} '_'...
            num2str(FreqbandArray{j}(1)) '-' num2str(FreqbandArray{j}(2)) 'Hz_' CondnameArray{l}])
            for i = 1:length(BfreqvsDUR)
                
                BETAS = [BETAS ;[BfreqvsDUR{i}  BfreqvsMED{i}  BfreqvsACC{i}  ...
                                 BpowvsDUR{i}   BpowvsMED{i}   BpowvsACC{i}    ...
                                 BslopevsDUR{i} BslopevsMED{i} BslopevsACC{i}  ...
                                 ones(length(BfreqvsDUR{i}),1)*SubjectArray(i) ...
                                 ones(length(BfreqvsDUR{i}),1)*l               ...
                                 ones(length(BfreqvsDUR{i}),1)*k               ...
                                 ones(length(BfreqvsDUR{i}),1)*j               ]];               
            end
        end
    end
end

SubjectArray  = [10 9 8 7 6];
Chan_type     = {'Mags';'Grads1';'Grads2'};
FreqbandArray = {[2 5];[7 14];[15 30]};
CondnameArray      = {'AllReplay'};
for j = 1:length(FreqbandArray)
    for k = 1:length(Chan_type)
        for l = 1:length(CondnameArray)
            load(['C:\TEMPROD\DATA\NEW\across_subjects_data\GLMbetas_' Chan_type{k} '_'...
            num2str(FreqbandArray{j}(1)) '-' num2str(FreqbandArray{j}(2)) 'Hz_' CondnameArray{l}])
            for i = 1:length(BfreqvsDUR)
                
                BETAS = [BETAS ; [BfreqvsDUR{i}  BfreqvsMED{i}  BfreqvsACC{i}  ...
                                 BpowvsDUR{i}   BpowvsMED{i}   BpowvsACC{i}    ...
                                 BslopevsDUR{i} BslopevsMED{i} BslopevsACC{i}  ...
                                 ones(length(BfreqvsDUR{i}),1)*SubjectArray(i) ...
                                 ones(length(BfreqvsDUR{i}),1)*2               ...
                                 ones(length(BfreqvsDUR{i}),1)*k               ...
                                 ones(length(BfreqvsDUR{i}),1)*j               ]];               
            end
        end
    end
end

BETAS(1,:) = [];

% write results in a text file
WriteDataFile = ['C:\TEMPROD\DATA\NEW\ForR\all_GLM_data.txt'];
fileID = fopen(WriteDataFile,'w');

DATAforR1 = []; 
DATAforR2 = [];

% data as columns and labels
DATAforR1       = BETAS;
DATAforR2{1,1}  = 'BfreqvsDUR';
DATAforR2{1,2}  = 'BfreqvsMED';
DATAforR2{1,3}  = 'BfreqvsACC';
DATAforR2{1,4}  = 'BpowvsDUR';
DATAforR2{1,5}  = 'BpowvsMED';
DATAforR2{1,6}  = 'BpowvsACC';
DATAforR2{1,7}  = 'BslopevsDUR';
DATAforR2{1,8}  = 'BslopevsMED';
DATAforR2{1,9}  = 'BslopevsACC';
DATAforR2{1,10} = 'SUB';
DATAforR2{1,11} = 'COND';
DATAforR2{1,12} = 'CHAN';
DATAforR2{1,13} = 'FREQBAND';

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








