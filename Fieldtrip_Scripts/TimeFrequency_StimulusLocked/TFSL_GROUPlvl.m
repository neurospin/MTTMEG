function TFSL_GROUPlvl(niplist,chansel,condnames,latency,graphcolor,stat_test,foi)

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
if length(condnames) > 2
    statstag = 'F';
else
    statstag = 'T';
end

% switch from separated to concatenated names
cdn = [];
for i = 1:length(condnames)
    cdn = [cdn condnames{i} '_'];
end

% load cell array of conditions
 instrmulti = 'ft_multiplotER(cfg,';
 instrsingle = 'ft_singleplotER(cfg,';
for j = 1:length(niplist)
    datatmp{j}   = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' niplist{j} '/MegData/TFs/' cdn chansel],'timelockbase');
    instrmulti     = [instrmulti 'datatmp{1,' num2str(j) '}.timelockbase{1,1},'];
    instrsingle    = [instrsingle 'datatmp{1,' num2str(j) '}.timelockbase{1,1},'];
end
instrmulti(end)  = [];
instrsingle(end) = [];
instrmulti          = [instrmulti ');'];
instrsingle         = [instrsingle ');'];

close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% COMPUTE ERFS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:length(datatmp{1,1}.timelockbase)
 
    % for plot
    cfg = [];
    cfg.keepindividual = 'no';
    cfg.foilim              = 'all';
    cfg.toilim              = 'all';
    cfg.channel           = 'all';
    
    instr = ['GDAVG{' num2str(i) '} = ft_freqgrandaverage(cfg,'];
    for j = 1:length(datatmp)
        instr = [instr 'datatmp{1,' num2str(j)  '}.timelockbase{1,' num2str(i) '},'];
    end
    instr(end) = [];
    instr      = [instr ');'];
    
    eval([instr]);
    
    instr = [];
    instr = ['GDAVG{' num2str(i) '} = rmfield(GDAVG{' num2str(i) '},''cfg'''];
    instr      = [instr ');'];
    
    eval([instr]);
    
    % for stats
    cfg = [];
    cfg.keepindividual = 'yes';
    cfg.foilim              = 'all';
    cfg.toilim              = 'all';
    cfg.channel           = 'all';
    
    instr = ['GDAVGt{' num2str(i) '} = ft_freqgrandaverage(cfg,'];
    for j = 1:length(datatmp)
        instr = [instr 'datatmp{1,' num2str(j)  '}.timelockbase{1,' num2str(i) '},'];
    end
    instr(end) = [];
    instr      = [instr ');'];
    
    eval([instr]);
    
    instr = [];
    instr = ['GDAVGt{' num2str(i) '} = rmfield(GDAVGt{' num2str(i) '},''cfg'''];
    instr      = [instr ');'];
    
    eval([instr]);
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SAVE DATASETS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cdn = [];
for i = 1:length(condnames)
    cdn = [cdn condnames{i} '_'];
end

save(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/MegData/' cdn chansel],'GDAVG')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% COMPUTE SUBJECT-LEVEL STATISTICS %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

instr = 'ERFstat_GeneralTF(condnames, latency, GDAVG, GDAVGt, chansel,graphcolor,stat_test,foi,';

for i = 1:size(GDAVGt,2)
    instr = [instr 'GDAVGt{' num2str(i) '},'];    
end
instr(end) = [];
instr = [instr ');'];  
eval(instr)

% if strcmp(statstag,'F') == 1
%     instr = 'TFstatF_GroupLvl_v3(condnames, GDAVG,';
% else
%     instr = 'TFstatT_GroupLvl_v3(condnames, GDAVG,';
% end
% 
% for i = 1:size(GDAVGt,2)
%    instr = [instr 'GDAVGt{' num2str(i) '},'];    
% end
% instr(end) = [];
% instr = [instr ',[8 12],chansel);'];  
% eval(instr)
% 
% close all
% 
% if strcmp(statstag,'F') == 1
%     instr = 'TFstatF_GroupLvl_v3(condnames, GDAVG,';
% else
%     instr = 'TFstatT_GroupLvl_v3(condnames, GDAVG,';
% end
% 
% for i = 1:size(GDAVGt,2)
%    instr = [instr 'GDAVGt{' num2str(i) '},'];    
% end
% instr(end) = [];
% instr = [instr ',[3 7],chansel);'];  
% eval(instr)
% 
% close all
% 
% if strcmp(statstag,'F') == 1
%     instr = 'TFstatF_GroupLvl_v3(condnames, GDAVG,';
% else
%     instr = 'TFstatT_GroupLvl_v3(condnames, GDAVG,';
% end
% 
% for i = 1:size(GDAVGt,2)
%    instr = [instr 'GDAVGt{' num2str(i) '},'];    
% end
% instr(end) = [];
% instr = [instr ',[15 25],chansel);'];  
% eval(instr)
% 
% close all
% 
