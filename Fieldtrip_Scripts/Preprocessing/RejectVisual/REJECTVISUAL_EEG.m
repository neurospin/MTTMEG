function REJECTVISUAL_EEG(nip,condarray)
% 
% nip      = 'jm100042';
% condarray = {'REF1';'REF2';'REF3';'REF4';'REF5'};

% define channel types
[Grads1,Grads2,Mags]   = grads_for_layouts('Network');
[EEG]   = EEG_for_layouts('Network');

% load cell array of conditions
for i = 1:length(condarray)
    datatmp40{i} = load (['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/'...
        nip '/MegData/Processed_eegnew/' condarray{i} 'EEG_filt40.mat'],'datafilt40');
    Ntrials40(i)= length(datatmp40{i}.datafilt40.trial);
end

% % load cell array of conditions
% for i = 1:length(condarray)
%     datatmp{i} = load (['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/'...
%         nip '/MegData/Processed/' condarray{i} 'EEG.mat'],'data');
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

% instr = ['datapp = ft_appenddata([],'];
% for i = 1:length(condarray)
%     instr = [instr 'datatmp{1,' num2str(i) '}.data,'];
% end
% instr(end) = [];
% instr = [instr ');'];
% eval(instr)

cfg                         = [];
cfg.method             = 'summary';
cfg.keepchannel      = 'yes';
cfg.channel             = EEG;
[datafilt40,trsel]      = ft_rejectvisual(cfg,datapp40);

trl = trsel;

NtrialSum = cumsum(Ntrials40);
NtrialSum = [0 NtrialSum];

for i = 2:length(NtrialSum) 
    trlsel = [];
    trlsel = trl((NtrialSum(i-1)+1):(NtrialSum(i)));
    save(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/'...
        nip '/MegData/Processed_eegnew/' condarray{i-1} 'EEG_rejectvisual.mat'],'trlsel');
end

% clear trlsel
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
% % save cleaned data
% for i = 1:length(condarray)
%     
%     cfg                 = [];
%     cfg.trials         = trlsel{i};
%     dataclean40   = ft_redefinetrial(cfg, datapp40);
%     dataclean       = ft_redefinetrial(cfg, datapp);
%     
%     save(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/'...
%         nip '/MegData/Processed/' condarray{i} 'EEG_filt40_clean.mat'],'dataclean40');
%     
%     save (['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/'...
%         nip '/MegData/Processed/' condarray{i} 'EEG_clean.mat'],'dataclean');
%     
% end
% 
% 
% 
