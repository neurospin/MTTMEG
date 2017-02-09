function TLSL_GROUPlvl_INT_from_mne_save(niplist,chansel,condnames1,condnames2,latency,graphcolor,stat_test)

% nip = the NIP code of the subject
% chansel, can be either 'Mags', 'Grads1','Grads2' or 'EEG'
% condnames = the name of the columns conditions 
% condarray: conditions organized in a x*y cell array
% the rows x define all the subconditions of the y column conditions

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% PREPARE COMPUTATIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% define channel types
[Grads1,Grads2,Mags]   = grads_for_layouts('Network');
EEG  = EEG_for_layouts('Network');

ch = [];
if strcmp(chansel,'Mags')
    ch = Mags;
elseif strcmp(chansel,'Grads1')
    ch = Grads1;
elseif strcmp(chansel,'Grads2')
    ch = Grads2;
elseif strcmp(chansel,'cmb')
    ch = Mags; %temporary
else strcmp(chansel,'EEG')
    ch = EEG;
end

% selection
if length(condnames1) > 2
    statstag = 'F';
else
    statstag = 'T';
end

% switch from separated to concatenated names
cdn1 = [];
for i = 1:length(condnames1)
    cdn1 = [cdn1 condnames1{i} '_'];
end

cdn2 = [];
for i = 1:length(condnames2)
    cdn2 = [cdn2 condnames2{i} '_'];
end

% load cell array of conditions1
for j = 1:length(niplist)
    datatmp1{j}   = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' niplist{j} '/MegData/ERPs_from_mne/' cdn1 chansel],'timelockbase');
end

% load cell array of conditions1
for j = 1:length(niplist)
    datatmp2{j}   = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' niplist{j} '/MegData/ERPs_from_mne/' cdn2 chansel],'timelockbase');
end

close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% COMPUTE ERFS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:length(datatmp1{1,1}.timelockbase)
 
    % for plot pack 
    cfg                             = [];
    cfg.channel                 = ch;
    cfg.trials                     = 'all';
    cfg.keepindividual       = 'no';
    cfg.removemean         = 'yes';
    cfg.covariance             = 'yes';
    
    instr1 = ['GDAVG1{' num2str(i) '} = ft_timelockgrandaverage(cfg,'];
    for j = 1:length(datatmp1)
        instr1 = [instr1 'datatmp1{1,' num2str(j)  '}.timelockbase{1,' num2str(i) '},'];
    end
    instr1(end) = [];
    instr1      = [instr1 ');'];
    eval([instr1]);
    
    instr2 = ['GDAVG2{' num2str(i) '} = ft_timelockgrandaverage(cfg,'];
    for j = 1:length(datatmp2)
        instr2 = [instr2 'datatmp2{1,' num2str(j)  '}.timelockbase{1,' num2str(i) '},'];
    end
    instr2(end) = [];
    instr2      = [instr2 ');'];
    eval([instr2]);    
    
    % for stats
    cfg                             = [];
    cfg.channel                 = ch;
    cfg.trials                     = 'all';
    cfg.keepindividual       = 'yes';
    cfg.removemean         = 'yes';
    cfg.covariance             = 'yes';
    
    instr1 = ['GDAVG1t{' num2str(i) '} = ft_timelockgrandaverage(cfg,'];
    for j = 1:length(datatmp1)
        instr1 = [instr1 'datatmp1{1,' num2str(j)  '}.timelockbase{1,' num2str(i) '},'];
    end
    instr1(end) = [];
    instr1      = [instr1 ');'];
    eval([instr1]);
    
    instr2 = ['GDAVG2t{' num2str(i) '} = ft_timelockgrandaverage(cfg,'];
    for j = 1:length(datatmp2)
        instr2 = [instr2 'datatmp2{1,' num2str(j)  '}.timelockbase{1,' num2str(i) '},'];
    end
    instr2(end) = [];
    instr2      = [instr2 ');'];
    eval([instr2]);    

    instr = [];
    instr = ['GDAVG1t{' num2str(i) '} = rmfield(GDAVG1t{' num2str(i) '},''cfg'''];
    instr      = [instr ');'];
    eval([instr]);
    
    instr = [];
    instr = ['GDAVG2t{' num2str(i) '} = rmfield(GDAVG2t{' num2str(i) '},''cfg'''];
    instr      = [instr ');'];
    eval([instr]);
    
    instr = [];
    instr = ['GDAVG1{' num2str(i) '} = rmfield(GDAVG1{' num2str(i) '},''cfg'''];
    instr      = [instr ');'];
    eval([instr]);
    
    instr = [];
    instr = ['GDAVG2{' num2str(i) '} = rmfield(GDAVG2{' num2str(i) '},''cfg'''];
    instr      = [instr ');'];
    eval([instr]);
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% COMPUTE SUBJECT-LEVEL STATISTICS %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

instr = [];
if strcmp(statstag,'T') == 1
    instr = 'ERFstatT_GroupLvl_INT_save(condnames1, condnames2,GDAVG1, GDAVG1t, GDAVG2, GDAVG2t,chansel,latency,graphcolor,stat_test';
end
instr = [instr ');'];  
eval(instr)
