function REJECTVISUAL_TF(nip,condarray)

% define channel types
[Grads1,Grads2,Mags]   = grads_for_layouts('Network');

% load cell array of conditions
j = 1;
for i = 1:length(condarray)
    count(i) = 0;
    datatmp{i} = load (['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/'...
        nip '/MegData/Processed/' condarray{i} '.mat'],'data');
    
    while (datatmp{1,i}.data.sampleinfo(j,1) < datatmp{1,i}.data.sampleinfo(j+1,1)) && (j < (length(datatmp{1,i}.data.sampleinfo(j,1))-1));
        count(i) = count(i) +1;
        j = j+1;
    end
    count(i) = count(i) +1;
    j = j + 1;
    Ntrials(i)= length(datatmp{i}.data.trial);
end
 
% append datasets belonging to the same condition (defined by cell structure)
% (only if it's a combination of conditions, of course)
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
[datatmp,trsel1]  = ft_rejectvisual(cfg,datapp);
cfg.channel             = Grads1;
[datatmp,trsel2]  = ft_rejectvisual(cfg,datapp);
cfg.channel             = Grads2;
[datatmp,trsel3]  = ft_rejectvisual(cfg,datapp);
trl = (trsel1+trsel2+trsel3) == 3;

NtrialSum = cumsum(Ntrials);

i = 1;
count(i) = 1;
for j = 1:NtrialSum(i)
    if trl(j) == 1
        trlsel{i}(count(i)) = j;
        count(i) = count(i) + 1;
    end
end
for i = 2:length(condarray) 
    count(i) = 1;
    for j = (NtrialSum(i-1)+1):NtrialSum(i)
        if trl(j) == 1
            trlsel{i}(count(i)) = j;
            count(i) = count(i) + 1;
        end
    end
end

% save cleaned data
for i = 1:length(condarray)
    
    cfg                 = [];
    cfg.trials         = trlsel{i};
    dataclean   = ft_redefinetrial(cfg, datapp);
    
    save(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/'...
        nip '/MegData/Processed/' condarray{i} 'clean.mat'],'dataclean');
    
end



