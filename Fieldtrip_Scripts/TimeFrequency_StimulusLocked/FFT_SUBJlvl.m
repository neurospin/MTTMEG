function FFT_SUBJlvl(nip,chansel,source,func,segwin,latency)

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
elseif strcmp(chansel,'GradComb')
    ch = Grads1; %temporary
else strcmp(chansel,'EEG')
    ch = EEG;
end

% load and select source data
% get an array of name and corresponding datasets
for i = 1:size(source,1)
    datasource{i} = ['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/'...
        nip '/MegData/Processed_mne/' source{i} '_dat_'];
    rejectvisual{i} = ['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/'...
        nip '/MegData/Processed_mne/' source{i} '_rejectvisual'];
end
[condnames,data] = func(datasource,rejectvisual);

% %  test selection
% if size(condarray,2) > 2
%     statstag = 'F';
% else
%     statstag = 'T';
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% COMPUTE ERFS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:length(data)
    
    % temporal realignment
    for j = 1:length(data{1,i}.time)
        data{1,i}.time{1,j} = data{1,i}.time{1,j} - ones(1,length(data{1,i}.time{1,j}))*(segwin(1));
    end
    
%     cut data 
    cfg          = [];
    cfg.toilim = latency;
    data{1,i}  = ft_redefinetrial(cfg,data{1,i});
    
    cfg                = [];
    cfg.channel        = ch;
    cfg.toi            =  latency(1):0.1:(latency(2));
    cfg.method         = 'mtmfft';
    cfg.output         = 'pow';
    cfg.pad            = 'maxperlen';
    cfg.taper          = 'dpss'
    cfg.foilim         = [1 100]
    cfg.tapsmofrq      = 1;
    pow{i}            = ft_freqanalysis(cfg, data{1,i});
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SAVE DATASETS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cdn = [];
for i = 1:length(condnames)
    cdn = [cdn condnames{i} '_'];
end

fname = ['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/'...
        nip '/MegData/TFs/FFT_' cdn chansel];
    
if length(fname) > 255
    fname = [fname(1:200) '_alias_'];
end   
    
%% check if the file aready exists. if yes, delete it
if exist([fname '.mat']) == 2
    delete([fname '.mat'])
end

save(fname,'pow')


