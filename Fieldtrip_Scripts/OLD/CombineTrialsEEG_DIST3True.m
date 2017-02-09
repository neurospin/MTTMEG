function CombineTrialsEEG_DIST3(nip)

% write list of trigger of interest for each REF cond
tstart = tic;

% name of recombined conditions
TABLE{1,1}     = 'td1True_1';
TABLE{2,1}     = 'td1True_2';
TABLE{3,1}     = 'td1True_3';
TABLE{4,1}     = 'td1True_4';
TABLE{5,1}     = 'td1True_5';

TABLE{6,1}     = 'td2True_1';
TABLE{7,1}     = 'td2True_2';
TABLE{8,1}     = 'td2True_3';
TABLE{9,1}     = 'td2True_4';
TABLE{10,1}   = 'td2True_5';

TABLE{11,1}     = 'td3True_1';
TABLE{12,1}     = 'td3True_2';
TABLE{13,1}     = 'td3True_3';
TABLE{14,1}     = 'td3True_4';
TABLE{15,1}     = 'td3True_5';

TABLE{16,1}   = 'sd1True_1';
TABLE{17,1}   = 'sd1True_2';
TABLE{18,1}   = 'sd1True_3';
TABLE{19,1}   = 'sd1True_4';
TABLE{20,1}   = 'sd1True_5';

TABLE{21,1}   = 'sd2True_1';
TABLE{22,1}   = 'sd2True_2';
TABLE{23,1}   = 'sd2True_3';
TABLE{24,1}   = 'sd2True_4';
TABLE{25,1}   = 'sd2True_5';

TABLE{26,1}   = 'sd3True_1';
TABLE{27,1}   = 'sd3True_2';
TABLE{28,1}   = 'sd3True_3';
TABLE{29,1}   = 'sd3True_4';
TABLE{30,1}   = 'sd3True_5';

% corresponding triggercode in the name of individual files
TABLE{1,2}     = repmat([37 43 49 55 61 67 42 48 54 60 66 72]*1000,2,1) + ones(2,12)*60   + repmat([1 ;3],1,12);
TABLE{2,2}     = repmat([37 43 55 61 46 52 64 70]*1000,2,1) + ones(2,8)*80     + repmat([1 ;3],1,8);
TABLE{3,2}     = repmat([39 45 51 57 42 54 66 72]*1000,2,1) + ones(2,8)*100   + repmat([1 ;3],1,8);
TABLE{4,2}     = repmat([37 43 49 55 42 48 54 60]*1000,2,1) + ones(2,8)*120   + repmat([1 ;3],1,8);
TABLE{5,2}     = repmat([49 55 61 67 54 60 66 72]*1000,2,1) + ones(2,8)*140   + repmat([1 ;3],1,8);

TABLE{6,2}     = repmat([38 44 50 56 62 68 41 47 53 59 65 71]*1000,2,1) + ones(2,12)*60   + repmat([1 ;3],1,12);
TABLE{7,2}     = repmat([49 67 56 68 57 63 69 40 58]*1000,2,1) + ones(2,9)*80 + repmat([1 ;3],1,9);
TABLE{8,2}     = repmat([63 69 40 58 47 71 48 60 ]*1000,2,1) + ones(2,8)*100   + repmat([1 ;3],1,8);
TABLE{9,2}     = repmat([38 44 50 56 41 47 53 59 ]*1000,2,1) + ones(2,8)*120   + repmat([1 ;3],1,8);
TABLE{10,2}   = repmat([50 56 62 68 53 59 65 71 ]*1000,2,1) + ones(2,8)*140   + repmat([1 ;3],1,8);

TABLE{11,2}   = repmat([39 45 51 57 63 69 40 46 52 58 64 70]*1000,2,1) + ones(2,12)*60   + repmat([1 ;3],1,12);
TABLE{12,2}   = repmat([38 44 50 62 39 45 51]*1000,2,1) + ones(2,7)*80   + repmat([1 ;3],1,7);
TABLE{13,2}   = repmat([46 52 64 70 41 53 59 65 ]*1000,2,1) + ones(2,8)*100   + repmat([1 ;3],1,8);
TABLE{14,2}   = repmat([39 54 51 57 40 46 52 58]*1000,2,1) + ones(2,8)*120   + repmat([1 ;3],1,8);
TABLE{15,2}   = repmat([51 57 63 69 52 58 64 70]*1000,2,1) + ones(2,8)*140   + repmat([1 ;3],1,8);

TABLE{16,2}   = repmat([37:42 67:72]*1000,2,1) + ones(2,12)*70   + repmat([1 ;3],1,12);
TABLE{17,2}   = repmat([37:40 67:70]*1000,2,1) + ones(2,8)*90   + repmat([1 ;3],1,8);
TABLE{18,2}   = repmat([39:42 69:72]*1000,2,1) + ones(2,8)*110 + repmat([1 ;3],1,8);
TABLE{19,2}   = repmat([43:48 50 52]*1000,2,1) + ones(2,8)*130 + repmat([1 ;3],1,8);
TABLE{20,2}   = repmat([55 56 59 61 62 63 65 66]*1000,2,1) + ones(2,8)*150 + repmat([1 ;3],1,8);

TABLE{21,2}   = repmat([43:48 61:66]*1000,2,1) + ones(2,12)*70   + repmat([1 ;3],1,12);
TABLE{22,2}   = repmat([43:46 61:64]*1000,2,1) + ones(2,8)*90   + repmat([1 ;3],1,8);
TABLE{23,2}   = repmat([45:48 63:66]*1000,2,1) + ones(2,8)*110 + repmat([1 ;3],1,8);
TABLE{24,2}   = repmat([39 41 49 51 53 54 58 60]*1000,2,1) + ones(2,8)*130 + repmat([1 ;3],1,8);
TABLE{25,2}   = repmat([49 53 54 57 58 60 64 67]*1000,2,1) + ones(2,8)*150 + repmat([1 ;3],1,8);

TABLE{26,2}   = repmat([49:54 55:60]*1000,2,1) + ones(2,12)*70   + repmat([1 ;3],1,12);
TABLE{27,2}   = repmat([49:52 55:58]*1000,2,1) + ones(2,8)*90   + repmat([1 ;3],1,8);
TABLE{28,2}   = repmat([51:54 57:60]*1000,2,1) + ones(2,8)*110 + repmat([1 ;3],1,8);
TABLE{29,2}   = repmat([43:48 50 52]*1000,2,1) + ones(2,8)*130 + repmat([1 ;3],1,8);
TABLE{30,2}   = repmat([55 56 59 61 62 63 65 66]*1000,2,1) + ones(2,8)*150 + repmat([1 ;3],1,8);

NAMESLIST = [];
FOLDER = ['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' nip '/MegData/Processed_eegnew/'];
for i = 1:size(TABLE,1)
    
    j = 1;
    k = 1;
    instr1 = 'datafilt40 = ft_appenddata([],';
    instr2 = 'data = ft_appenddata([],';
    
    while j <= length(TABLE{i,2}(:))
        
        if isempty(get_filenames(FOLDER,'EV',num2str(TABLE{i,2}(j)))) == 0
            NAMESLIST{i}{k} = get_filenames(FOLDER,'EV',num2str(TABLE{i,2}(j)),'EEG');
            
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
    save(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' nip '/MegData/Processed/' TABLE{i,1}  'EEG.mat'],'data')
    save(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' nip '/MegData/Processed/' TABLE{i,1}  'EEG_filt40.mat'],'datafilt40')
end

disp(['elapsed time for get file list ' num2str( toc(tstart))])

