function TFSL_GROUPlvl_vsZERO(niplist,chansel,condnames,selection,latency,graphcolor,stat_test,foi,isind,zeroing)

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

% tag for induced (method 1, or method 2) or evoked power
if strcmp(isind,'evk')
    datastruct = 'timelockbase'; tag = '';
elseif strcmp(isind,'ind1')
    datastruct = 'timelockbase'; tag = 'Ind';
else
    datastruct = 'timelockbase2'; tag = 'Ind2';
end

% load cell array of conditions
 instrmulti = 'ft_multiplotER(cfg,';
 instrsingle = 'ft_singleplotER(cfg,';
for j = 1:length(niplist)
    datatmp{j}   = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' niplist{j} '/MegData/TFs/' tag cdn chansel],datastruct);
    instrmulti     = [instrmulti 'datatmp{1,' num2str(j) '}.' datastruct '{1,1},'];
    instrsingle    = [instrsingle 'datatmp{1,' num2str(j) '}.' datastruct '{1,1},'];
end
instrmulti(end)  = [];
instrsingle(end) = [];
instrmulti          = [instrmulti ');'];
instrsingle         = [instrsingle ');'];

close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% COMPUTE ERFS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:length(condnames)
 
    % for plot
    cfg = [];
    cfg.keepindividual = 'no';
    cfg.foilim              = 'all';
    cfg.toilim              = 'all';
    cfg.channel           = 'all';
    
    instr = ['GDAVG{' num2str(i) '} = ft_freqgrandaverage(cfg,'];
    for j = 1:length(datatmp)
        instr = [instr 'datatmp{1,' num2str(j)  '}.' datastruct '{1,' num2str(i) '},'];
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
        instr = [instr 'datatmp{1,' num2str(j)  '}.' datastruct '{1,' num2str(i) '},'];
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
% select the condition of interest base on "selection" parameter
TMP = {};
TMPt = {};
cdn = [];
tmpname = {};
tmpcolor = [];

for i = 1:length(selection)
    TMP{i}  = GDAVG{selection(i)};
    TMPt{i} = GDAVGt{selection(i)};
    tmpcolor(i,:) = graphcolor(selection(i),:);
end
 
% then replace the data in the condition of non interest by zero
for i = 1:length(selection)
    if zeroing(i) == 1
        TMP{i}.powspctrm = zeros(size(TMP{i}.powspctrm));
        TMPt{i}.powspctrm = zeros(size(TMPt{i}.powspctrm));
        tmpname{i} = 'ZERO';
    else
        tmpname{i} = condnames{selection(i)};
    end
end
        

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SAVE DATASETS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/MegData/' isind cdn chansel],'GDAVG')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% COMPUTE SUBJECT-LEVEL STATISTICS %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
instr = 'ERFstat_GeneralTF(tmpname, latency, TMP, TMPt, chansel,tmpcolor,stat_test,foi,isind,';

for i = 1:size(TMPt,2)
    instr = [instr 'TMPt{' num2str(i) '},'];    
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
