function REJECTVISUAL_ERF(nip,condarray)

% define channel types
[Grads1,Grads2,Mags]   = grads_for_layouts('Network');

% load cell array of conditions
j = 1;
for i = 1:length(condarray)
    datatmp40{i} = load (['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/'...
        nip '/MegData/Processed_new/' condarray{i} '_filt40.mat'],'datafilt40');
    
    Ntrials40(i)= length(datatmp40{i}.datafilt40.trial);
end
 
% j = 1;
% for i = 1:length(condarray)
%     datatmp{i} = load (['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/'...
%         nip '/MegData/Processed/' condarray{i} '.mat'],'data');
%     
%     Ntrials(i)= length(datatmp{i}.data.trial);
% end

% append datasets belonging to the same condition (defined by cell structure)
% (only if it's a combination of conditions, of course)
instr = ['datapp40 = ft_appenddata([],'];
for i = 1:length(condarray)
    instr = [instr 'datatmp40{1,' num2str(i) '}.datafilt40,'];
end
instr(end) = [];
instr = [instr ');'];
eval(instr)

instr = ['datapp40 = ft_appenddata([],'];
for i = 1:length(condarray)
    instr = [instr 'datatmp40{1,' num2str(i) '}.datafilt40,'];
end
instr(end) = [];
instr = [instr ');'];
eval(instr)

disp([ 'PROCESSING SUBJECT' nip ])

cfg                         = [];
cfg.method             = 'summary';
cfg.keepchannel      = 'yes';
cfg.channel             = Mags;
[datatmp,trsel1]  = ft_rejectvisual(cfg,datapp40);
cfg.channel             = Grads1;
[datatmp,trsel2]  = ft_rejectvisual(cfg,datapp40);
cfg.channel             = Grads2;
[datatmp,trsel3]  = ft_rejectvisual(cfg,datapp40);
trl = (trsel1+trsel2+trsel3) == 3;

NtrialSum = cumsum(Ntrials40);
NtrialSum = [0 NtrialSum];
% i = 1;
% count(i) = 1;
% for j = 1:NtrialSum(i)
%     if trl(j) == 1
%         trlsel{i}(count(i)) = j;
%         count(i) = count(i) + 1;
%     end
% end
% for i = 2:length(condarray) 
%     count(i) = 1;
%     for j = (NtrialSum(i-1)+1):NtrialSum(i)
%         if trl(j) == 1
%             trlsel{i}(count(i)) = j;
%             count(i) = count(i) + 1;
%         end
%     end
% end
% 

for i = 2:length(NtrialSum)
    trlsel = [];
    trlsel = trl((NtrialSum(i-1)+1):(NtrialSum(i)));
    
%     FOLDER = ['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' nip '/MegData/Processed_new/'];
    %     NAMESLIST = get_filenames(FOLDER,'rejectvisual');
    condname = [condarray{i-1} '_rejectvisual.mat'];
    
    %     while match_str(NAMESLIST,condname)
    %         condname = ['bis' condname];
    %         if match_str(NAMESLIST,condname) == 0
    
    save(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/'...
        nip '/MegData/Processed_new/' condname ],'trlsel');
    %         end
    %     end
end


% % save cleaned data
% for i = 1:length(condarray)
%     
%     cfg                 = [];
%     cfg.trials         = trlsel{i};
%     dataclean40     = ft_redefinetrial(cfg, datapp40);
%     dataclean       = ft_redefinetrial(cfg, datapp);
%     
%     save(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/'...
%         nip '/MegData/Processed/' condarray{i} 'filt40_clean.mat'],'dataclean40');
%     
%     save(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/'...
%         nip '/MegData/Processed/' condarray{i} 'clean.mat'],'dataclean');
%     
% end

FOLDER = ['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' nip '/MegData/Processed_new/'];
NAMESLIST = get_filenames(FOLDER,'rejectvisual');


