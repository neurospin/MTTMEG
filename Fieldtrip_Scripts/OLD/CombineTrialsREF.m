function CombineTrialsREF(nip)

% write list of trigger of interest for each REF cond

TABLE = cell(5,2);

% name of recombined conditions
TABLE{1,1} = 'REF1';
TABLE{2,1} = 'REF2';
TABLE{3,1} = 'REF3'; 
TABLE{4,1} = 'REF4';  
TABLE{5,1} = 'REF5'; 

% corresponding triggercode in the name of individual files
TABLE{1,2} = '00001';
TABLE{2,2} = '00002';
TABLE{3,2} = '00003'; 
TABLE{4,2} = '00004';  
TABLE{5,2} = '00005'; 


NAMESLIST = [];
FOLDER = ['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' nip '/MegData/Processed_new/'];
for i = 1:size(TABLE,1)
    
    if isempty(get_filenames(FOLDER,'REF',num2str(TABLE{i,2}))) == 0
        NAMESLIST{i} = get_filenames(FOLDER,'REF',num2str(TABLE{i,2}));
        
        data = [];
        load([FOLDER char(NAMESLIST{i}(1,:))]);
        save(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' nip '/MegData/Processed/' TABLE{i,1}  '.mat'],'data')
        
        datafilt40 = [];
        load([FOLDER char(NAMESLIST{i}(2,:))]);
        save(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' nip '/MegData/Processed/' TABLE{i,1}  'filt40.mat'],'datafilt40')
        
    end
end

















