function RegOrd_SUBJlvl_from_mne_v2(nip,chansel,source,func,segwin,latency)

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
    ch = [Grads1 Grads2]; %temporary
else strcmp(chansel,'EEG')
    ch = EEG;
end

if strcmp(chansel,'EEG')
    % load and select source data
    % get an array of name and corresponding datasets
    for i = 1:size(source,1)
        datasource{i} = ['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/'...
            nip '/MegData/Processed_mne_eeg/' source{i} '_dat_filt40'];
        rejectvisual{i} = ['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/'...
            nip '/MegData/Processed_mne_eeg/' source{i} 'EEG_rejectvisual'];
    end
    [condnames,data] = func(datasource,rejectvisual);
else
    % load and select source data
    % get an array of name and corresponding datasets
    for i = 1:size(source,1)
        datasource{i} = ['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/'...
            nip '/MegData/Processed_mne/' source{i} '_dat_filt40'];
        rejectvisual{i} = ['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/'...
            nip '/MegData/Processed_mne/' source{i} '_rejectvisual'];
    end
    [condnames,data] = func(datasource,rejectvisual);
end

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
    
    % for plot
    cfg                        = [];
    cfg.channel            = ch;
    cfg.trials                = 'all';
    cfg.keeptrials         = 'no';
    cfg.removemean    = 'yes';
    cfg.covariance        = 'yes';
    cfg.vartrllength       = 2;
    datalock{i}              = ft_timelockanalysis(cfg, data{1,i});
    
    % for stats
    cfg                    = [];
    cfg.channel            = ch;
    cfg.keeptrials         = 'yes';
    cfg.removemean         = 'yes';
    cfg.covariance         = 'yes';
    cfg.vartrllength       = 2;
    datalockt{i}             = ft_timelockanalysis(cfg, data{1,i});
    
    % baseline correction
    cfg                        = [];
    cfg.baseline           = [latency(1) 0];
    cfg.channel            = 'all';
    timelockbase{i}       = ft_timelockbaseline(cfg, datalock{i});
    if strcmp(chansel,'GradComb')
        timelockbase{i}       = ft_combineplanar(cfg, datalock{i});
    end
    timelockbaset{i}      = ft_timelockbaseline(cfg, datalockt{i});

end

%% regression with distance bins
tmp   = [];
betas = zeros(size(timelockbaset{1}.trial,2),size(timelockbaset{1}.trial,3));

tic
for c = 1:size(timelockbaset{1}.trial,2)
    for t = 1:size(timelockbaset{1}.trial,3)
        % reordering (High values: close, low values: far
        X          = [];
        Y          = [];
        for i = length(timelockbaset):-1:1
            X = [ones(size(timelockbaset{i}.trial,1),1)*i; X];
        end
        for i = 1:length(timelockbaset)
            Y = [Y ; squeeze(timelockbaset{i}.trial(:,c,t))];
        end
        tmp = corr(Y,X,'type','Kendall');
        betas(c,t) = tmp(1);
    end
end
disp(['elapsed time : ' num2str(toc) ' s'])

timelockbase{1}.avg = betas
CorrKendallPerChanTime = timelockbase{1}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SAVE DATASETS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cdn = ['REG_'];
for i = 1:length(condnames)
    cdn = [cdn condnames{i} '_'];
end

fname = ['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/'...
        nip '/MegData/ERPs_from_mne/' cdn chansel];
    
if length(fname) > 255
    fname = [fname(1:200) '_alias_'];
end   
    
%% check if the file aready exists. if yes, delete it
if exist([fname '.mat']) == 2
    delete([fname '.mat'])
end

save(fname,'CorrKendallPerChanTime')
