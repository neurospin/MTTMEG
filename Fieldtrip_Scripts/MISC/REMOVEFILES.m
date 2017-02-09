

niplist = {'sd130343' ;'cb130477' ;'rb130313'   ;'jm100042' ;'jm100109';'sb120316';...
    'tk130502'  ;'lm130479' ;'sg120518'   ;'ms130534';'ma100253';'sl130503';...
    'mb140004';'mp140019';'mm130405';'dm130250';'hr130504' ;'wl130316';'rl130571'};

for i = 1:19
    FOLDER =['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/'...
        niplist{i} '/MegData/Processed/'];
    NAMESLIST{i}= get_filenames(FOLDER,'.mat');
    NAMESLIST_clean{i} = get_filenames(FOLDER,'_clean.mat');
    
    for j = 1:length(NAMESLIST{i})
%         if isempty(match_str(NAMESLIST_clean{i},NAMESLIST{i}{j}))
            delete([FOLDER NAMESLIST{i}{j}])
        end
    end
end






