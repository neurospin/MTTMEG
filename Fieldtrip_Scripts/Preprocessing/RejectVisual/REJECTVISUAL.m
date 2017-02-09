function REJECTVISUAL(nip,condarray)

% define channel types
[Grads1,Grads2,Mags]   = grads_for_layouts('Network');

% load cell array of conditions
for i = 1:length(condarray)
    datatmp40{i} = load (['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/'...
        nip '/MegData/Processed/' condarray{i} 'filt40.mat'],'datafilt40');
    Ntrials40(i)= length(datatmp40{i}.datafilt40.trial);
end

% load cell array of conditions
for i = 1:length(condarray)
    datatmp{i} = load (['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/'...
        nip '/MegData/Processed/' condarray{i} '.mat'],'data');
    Ntrials(i)= length(datatmp{i}.data.trial);
end

 
% append datasets belonging to the same condition (defined by cell structure)
% (only if it's a combination of conditions, of course)
instr = ['datapp40 = ft_appenddata([],'];
for i = 1:length(condarray)
    instr = [instr 'datatmp40{1,' num2str(i) '}.datafilt40,'];
end
instr(end) = [];
instr = [instr ');'];
eval(instr)

instr = ['datapp = ft_appenddata([],'];
for i = 1:length(condarray)
    instr = [instr 'datatmp{1,' num2str(i) '}.data,'];
end
instr(end) = [];
instr = [instr ');'];
eval(instr)

cfg                         = [];
cfg.method             = 'summary';
cfg.keepchannel      = 'yes';
cfg.channel             = Mags;
datafilt40               = ft_rejectvisual(cfg,datapp40);
cfg.channel             = Grads1;
datafilt40               = ft_rejectvisual(cfg,datafilt40);
cfg.channel             = Grads2;
datafilt40               = ft_rejectvisual(cfg,datafilt40);

% get new trial definition for each condition
j = 1;
for i = 1:length(condarray)
    count(i) = 0;
    while (datafilt40.sampleinfo(j,1) < datafilt40.sampleinfo(j+1,1)) && (j < (length(datafilt40.sampleinfo)-1));
        count(i) = count(i) +1;
        j = j+1;
    end
    count(i) = count(i) +1;
    j = j + 1;
end
trialref  = cumsum(count);
trialref2 = cumsum(Ntrials40);

init   = 0;
init2 = 0;
add = 1;
for i = 1:length(condarray)
   [a, b, c] = intersect(datafilt40.sampleinfo((init+1):trialref(i),1),datapp40.sampleinfo((init2+1):trialref2(i),1));
   trlsel{i} = c + ones(length(c),1)*init2;
init  = trialref(i);
init2 = trialref2(i);   
end

% save cleaned data
for i = 1:length(condarray)
    
    cfg                 = [];
    cfg.trials         = trlsel{i};
    dataclean40   = ft_redefinetrial(cfg, datapp40);
    dataclean       = ft_redefinetrial(cfg, datapp);
    
    save(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/'...
        nip '/MegData/Processed/' condarray{i} 'filt40_clean.mat'],'dataclean40');
    
    save (['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/'...
        nip '/MegData/Processed/' condarray{i} 'nofilt_clean.mat'],'dataclean');
    
end



