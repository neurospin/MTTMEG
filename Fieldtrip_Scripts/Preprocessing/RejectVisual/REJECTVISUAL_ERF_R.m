function REJECTVISUAL_ERF_R(nip,condarray)

% define channel types
[Grads1,Grads2,Mags]   = grads_for_layouts('Network');

% load cell array of conditions
countcond = 0;
for i = 1:length(condarray)

    if exist(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/'...
            nip '/MegData/Processed/' condarray{i} 'filt40.mat']) == 2 
        
        countcond = countcond+1;
        count( countcond) = 0;
        condarraycorr{countcond} = condarray{i};
        
        datatmp40{countcond} = load (['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/'...
            nip '/MegData/Processed/' condarray{i} 'filt40.mat'],'datafilt40');
        
        Ntrials40(countcond)= length(datatmp40{countcond}.datafilt40.trial);
    end
end

% append datasets belonging to the same condition (defined by cell structure)
% (only if it's a combination of conditions, of course)
instr = ['datapp40 = ft_appenddata([],'];
for i = 1:length(condarraycorr)
    instr = [instr 'datatmp40{1,' num2str(i) '}.datafilt40,'];
end
instr(end) = [];
instr = [instr ');'];
eval(instr)

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

i = 1;
count(i) = 1;
for j = 1:NtrialSum(i)
    if trl(j) == 1
        trlsel{i}(count(i)) = j;
        count(i) = count(i) + 1;
    end
end
for i = 2:length(condarraycorr) 
    count(i) = 1;
    for j = (NtrialSum(i-1)+1):NtrialSum(i)
        if trl(j) == 1
            trlsel{i}(count(i)) = j;
            count(i) = count(i) + 1;
        end
    end
end

% save cleaned data
for i = 1:length(condarraycorr)
    
    cfg                 = [];
    cfg.trials         = trlsel{i};
    dataclean40   = ft_redefinetrial(cfg, datapp40);
    
    save(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/'...
        nip '/MegData/Processed/' condarray{i} 'filt40_clean.mat'],'dataclean40');
    
end



