function CombineTrialsQT(nip)

% write list of trigger of interest for each REF cond
tstart = tic;

% name of recombined conditions
TABLE{1,1}   = 'QtT1';
TABLE{2,1}   = 'QtT2';
TABLE{3,1}   = 'QtT3';
TABLE{4,1}   = 'QtT4';
TABLE{5,1}   = 'QtT5';
TABLE{6,1}   = 'QtS1';
TABLE{7,1}   = 'QtS2';
TABLE{8,1}   = 'QtS3';
TABLE{9,1}   = 'QtS4';
TABLE{10,1}  = 'QtS5';

% corresponding triggercode in the name of individual files
TABLE{1,2}   = repmat(37000:1000:72000,5,1) + ones(5,36)*60   + repmat([0 ;1 ;2 ;3 ;4],1,36);
TABLE{2,2}   = repmat(37000:1000:72000,5,1) + ones(5,36)*80   + repmat([0 ;1 ;2 ;3 ;4],1,36);
TABLE{3,2}   = repmat(37000:1000:72000,5,1) + ones(5,36)*100 + repmat([0 ;1 ;2 ;3 ;4],1,36);
TABLE{4,2}   = repmat(37000:1000:72000,5,1) + ones(5,36)*120 + repmat([0 ;1 ;2 ;3 ;4],1,36);
TABLE{5,2}   = repmat(37000:1000:72000,5,1) + ones(5,36)*140 + repmat([0 ;1 ;2 ;3 ;4],1,36);
TABLE{6,2}   = repmat(37000:1000:72000,5,1) + ones(5,36)*70   + repmat([0 ;1 ;2 ;3 ;4],1,36);
TABLE{7,2}   = repmat(37000:1000:72000,5,1) + ones(5,36)*90   + repmat([0 ;1 ;2 ;3 ;4],1,36);
TABLE{8,2}   = repmat(37000:1000:72000,5,1) + ones(5,36)*110 + repmat([0 ;1 ;2 ;3 ;4],1,36);
TABLE{9,2}   = repmat(37000:1000:72000,5,1) + ones(5,36)*130 + repmat([0 ;1 ;2 ;3 ;4],1,36);
TABLE{10,2} = repmat(37000:1000:72000,5,1) + ones(5,36)*150 + repmat([0 ;1 ;2 ;3 ;4],1,36);

NAMESLIST = [];
FOLDER = ['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' nip '/MegData/Processed_new/'];
for i = 1:size(TABLE,1)
    
    j = 1;
    k = 1;
    instr1 = 'datafilt40 = ft_appenddata([],';
    instr2 = 'data = ft_appenddata([],';
    
    while j <= length(TABLE{i,2}(:))
        
        if isempty(get_filenames(FOLDER,'QT',num2str(TABLE{i,2}(j)))) == 0
            NAMESLIST{i}{k} = get_filenames(FOLDER,'QT',num2str(TABLE{i,2}(j)));
            
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
    save(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' nip '/MegData/Processed/' TABLE{i,1}  '.mat'],'data')
    save(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' nip '/MegData/Processed/' TABLE{i,1}  'filt40.mat'],'datafilt40')
end

disp(['elapsed time for get file list ' num2str( toc(tstart))])

