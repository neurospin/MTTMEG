function CombineTrialsEEGTrue_EV(nip)

% write list of trigger of interest for each REF cond
tstart = tic;

% name of recombined conditions
TABLE{1,1}     = 'TD1True_1';
TABLE{2,1}     = 'TD1True_2';
TABLE{3,1}     = 'TD1True_3';
TABLE{4,1}     = 'TD1True_4';
TABLE{5,1}     = 'TD1True_5';

TABLE{6,1}     = 'TD2True_1';
TABLE{7,1}     = 'TD2True_2';
TABLE{8,1}     = 'TD2True_3';
TABLE{9,1}     = 'TD2True_4';
TABLE{10,1}   = 'TD2True_5';

TABLE{11,1}   = 'SD1True_1';
TABLE{12,1}   = 'SD1True_2';
TABLE{13,1}   = 'SD1True_3';
TABLE{14,1}   = 'SD1True_4';
TABLE{15,1}   = 'SD1True_5';

TABLE{16,1}   = 'SD2True_1';
TABLE{17,1}   = 'SD2True_2';
TABLE{18,1}   = 'SD2True_3';
TABLE{19,1}   = 'SD2True_4';
TABLE{20,1}   = 'SD2True_5';

% corresponding triggercode in the name of individual files
TABLE{1,2}     = repmat([39 40 45 46 51 52 57 58 63 64 69 70]*1000,2,1) + ones(2,12)*60   + repmat([1;3],1,12);
TABLE{2,2}     = repmat([38 39 44 45 50 51 56 57 62 63 68 69]*1000,2,1) + ones(2,12)*80   + repmat([1;3],1,12);
TABLE{3,2}     = repmat([40 41 46 47 52 53 58 59 64 65 70 71 ]*1000,2,1) + ones(2,12)*100   + repmat([1;3],1,12);
TABLE{4,2}     = repmat([39 40 45 46 51 52 57 58]*1000,2,1) + ones(2,8)*120   + repmat([1;3],1,8);
TABLE{5,2}     = repmat([51 52 57 58 63 64 69 70]*1000,2,1) + ones(2,8)*140   + repmat([1;3],1,8);

TABLE{6,2}     = repmat([37 38 41 42 43 44 47 48 49 50 53 54 55 56 59 60 61 62 65 66 67 68 71 72]*1000,2,1) + ones(2,24)*60   + repmat([1;3],1,24);
TABLE{7,2}     = repmat([37 43 49 55 61 67 40 46 52 58 64 70]*1000,2,1) + ones(2,12)*80   + repmat([1;3],1,12);
TABLE{8,2}     = repmat([39 45 51 57 63 69 42 48 54 60 66 72]*1000,2,1) + ones(2,12)*100   + repmat([1;3],1,12);
TABLE{9,2}     = repmat([37 43 49 55 38 44 50 56 41 47 53 59 42 48 54 60]*1000,2,1) + ones(2,16)*120   + repmat([1;3],1,16);
TABLE{10,2}   = repmat([49 50 55 56 61 62 67 68 53 54 59 60 65 66 71 72]*1000,2,1) + ones(2,16)*140   + repmat([1;3],1,16);

TABLE{11,2}   = repmat([49 50 51 52 53 54 55 56 57 58 59 60]*1000,2,1) + ones(2,12)*70   + repmat([1;3],1,12);
TABLE{12,2}   = repmat([49 50 51 52 55 56 57 58]*1000,2,1) + ones(2,8)*90   + repmat([1;3],1,8);
TABLE{13,2}   = repmat([51 52 53 54 57 58 59 60]*1000,2,1) + ones(2,8)*110 + repmat([1;3],1,8);
TABLE{14,2}   = repmat([43 44 45 46 47 48 49 50 51 52 53 54]*1000,2,1) + ones(2,12)*130 + repmat([1;3],1,12);
TABLE{15,2}   = repmat([55 56 57 58 59 60 61 62 63 64 65 66]*1000,2,1) + ones(2,12)*150 + repmat([1;3],1,12);

TABLE{16,2}   = repmat([37:48 61:72]*1000,2,1) + ones(2,24)*70   + repmat([1;3],1,24);
TABLE{17,2}   = repmat([37:40 43:46 61:64 67:70]*1000,2,1) + ones(2,16)*90   + repmat([1;3],1,16);
TABLE{18,2}   = repmat([39:42 45:48 63:66 69:72]*1000,2,1) + ones(2,16)*110 + repmat([1;3],1,16);
TABLE{19,2}   = repmat([37:42 55:60]*1000,2,1) + ones(2,12)*130 + repmat([1;3],1,12);
TABLE{20,2}   = repmat([49:54 67:72]*1000,2,1) + ones(2,12)*150 + repmat([1;3],1,12);

NAMESLIST = [];
FOLDER = ['/neurospin/meg/megTrue_tmp/MTTTrue_MEGTrue_Baptiste/FromTrue_laptop/Subjects/' nip '/MegData/ProcessedTrue_eegnew/'];
for i = 1:size(TABLE,1)
    
    j = 1;
    k = 1;
    instr1 = 'datafilt40 = ftTrue_appenddata([],';
    instr2 = 'data = ftTrue_appenddata([],';
    
    while j <= length(TABLE{i,2}(:))
        
        if isempty(getTrue_filenames(FOLDER,'EV',num2str(TABLE{i,2}(j)))) == 0
            NAMESLIST{i}{k} = getTrue_filenames(FOLDER,'EV',num2str(TABLE{i,2}(j)),'EEG');
            
            Blahfilt40{i,k}    = load([FOLDER char(NAMESLIST{i}{k}(2:2:end,:))]);
            Blahfilt40{i,k}.datafilt40.cfg = rmfield(Blahfilt40{i,k}.datafilt40.cfg,'previous');
            instr1               = [instr1 'Blahfilt40{' num2str(i) ',' num2str(k) '}.datafilt40,'];
            
            Blah{i,k}            = load([FOLDER char(NAMESLIST{i}{k}(1:2:end,:))]);
            Blah{i,k}.data.cfg = rmfield(Blah{i,k}.data.cfg,'previous');
            instr2                = [instr2 'Blah{' num2str(i) ',' num2str(k) '}.data,'];
            
            k = k+1;
        end
        j = j+1;
    end
    instr1(end) = []; instr1 = [instr1 ');'];
    instr2(end) = []; instr2 = [instr2 ');'];
    eval(instr1);
    eval(instr2);
    save(['/neurospin/meg/megTrue_tmp/MTTTrue_MEGTrue_Baptiste/FromTrue_laptop/Subjects/' nip '/MegData/Processed/' TABLE{i,1}  'EEG.mat'],'data')
    save(['/neurospin/meg/megTrue_tmp/MTTTrue_MEGTrue_Baptiste/FromTrue_laptop/Subjects/' nip '/MegData/Processed/' TABLE{i,1}  'EEGTrue_filt40.mat'],'datafilt40')
end

disp(['elapsed time for get file list ' num2str( toc(tstart))])

