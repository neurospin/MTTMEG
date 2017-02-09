function REJECTVISUAL_ERF_single(nip,condarray)

% define channel types
[Grads1,Grads2,Mags]   = grads_for_layouts('Network');

% load cell array of conditions
for i = 1:length(condarray)
    datatmp40{i} = load (['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/'...
        nip '/MegData/Processed_mne/' condarray{i} '_dat_filt40.mat'],'datafilt40');
    
    Ntrials40(i)= length(datatmp40{i}.datafilt40.trial);
end

disp([ 'PROCESSING SUBJECT' nip ])

cfg                         = [];
cfg.method             = 'summary';
cfg.keepchannel      = 'yes';
cfg.channel             = Mags;
[datatmp,trsel1]  = ft_rejectvisual(cfg,datatmp40{1,1}.datafilt40);
cfg.channel             = Grads1;
[datatmp,trsel2]  = ft_rejectvisual(cfg,datatmp40{1,1}.datafilt40);
cfg.channel             = Grads2;
[datatmp,trsel3]  = ft_rejectvisual(cfg,datatmp40{1,1}.datafilt40);
trl = (trsel1+trsel2+trsel3) == 3;

NtrialSum = cumsum(Ntrials40);
NtrialSum = [0 NtrialSum];

for i = 2:length(NtrialSum)
    trlsel = [];
    trlsel = trl((NtrialSum(i-1)+1):(NtrialSum(i)));
    
    condname = [condarray{i-1} '_rejectvisual.mat'];
    
    save(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/'...
        nip '/MegData/Processed_mne/' condname ],'trlsel');

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


