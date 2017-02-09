function PREPROC4_EEG_from_MNE(runlist,delays,windowsERF,windowsTF,trialfun,condtag,nip,badEEG)

tstart = tic;

root = ['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/' nip '/'];

% ECG/EOG PCA projection
projfile_id        = 'PCA_EEG';

% preprocess each run
for i = 1:length(runlist)
    data{i}        = run_preproc(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/' nip '/'],runlist{i},delays,windowsTF,trialfun);
%     datafilt40{i} = run_preproc_filt40(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/' nip '/'],runlist{i},delays,windowsERF,trialfun);
end

% append all the data relative to one conditions
dataapp                = append_run(data);
% dataappfilt40          = append_run(datafilt40);
clear  datafilt40
data                   = dataapp;
% datafilt40             = dataappfilt40;

% get an .elec if not present
tag = 0;
tmp = fieldnames(data);
for i = 1:length(tmp)
    if strcmp(tmp{i},'elec')
       tag = 1;
    end
end

EEG = EEG_for_layouts('Network');

if tag == 0
    count = 1;
    for j = 1:length(data.hdr.orig.chs)
        if isempty(strfind(data.hdr.orig.chs(1,j).ch_name,'EEG')) == 0 && strcmp(data.hdr.orig.chs(1,j).ch_name,'EEG064') == 0 
            elecbis.elecpos(count,:) = data.hdr.orig.chs(1,j).eeg_loc(:,1)';
            count = count + 1;
        end
    end
    elecbis.label = EEG';
    elecbis.chpos = elecbis.elecpos;
    elecbis.unit     = 'cm';
    data.elec     = elecbis;
%     datafilt40.elec   = elecbis;
end

% apply pca matrix for cardiac and blink artifacts
M = computeprojmatrix_mtt_eeg(root,[root runlist{1} '_trans_sss.fif'],projfile_id,badEEG);
for i = 1:length(data.trial)
    tmp                                      = [];
%     tmpfilt40                               = [];
    tmp                                      = data.trial{1,i}(badEEG,:);
%     tmpfilt40                               = datafilt40.trial{1,i}(badEEG,:);
    data1.trial{1,i}                       = data.trial{1,i};
%     data1filt40.trial{1,i}                = datafilt40.trial{1,i};
    data1.trial{1,i}(badEEG,:)        = [];
%     data1filt40.trial{1,i}(badEEG,:) = [];
    data1.trial{i}                           = M*data1.trial{i};
%     data1filt40.trial{i}                    = M*data1filt40.trial{i};
    for l = 1:length(badEEG)
        data1.trial{i}                       = [data1.trial{i}(1:badEEG(l),:); ...
            tmp(l,:); data1.trial{i}((badEEG(l)+1):end,:)];
%         data1filt40.trial{i}               = [data1filt40.trial{i}(1:badEEG(l),:); ...
%             tmpfilt40(l,:); data1filt40.trial{i}((badEEG(l)+1):end,:)];
    end
end
data.trial = data1.trial;

% trldef40 = [];
% for i = 1:length(dataappfilt40.cfg.previous)
%     trldef40 = [trldef40;dataappfilt40.cfg.previous{1,i}.previous.previous.trl];
% end

trldef = [];
for i = 1:length(dataapp.cfg.previous)
    trldef = [trldef;dataapp.cfg.previous{1,i}.previous.previous.trl];
end

% datafilt40save = datafilt40;
datasave = data;
% condtrigs40 = unique(trldef40(:,4));
condtrigs = unique(trldef(:,4));

%%
aen = load('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/allneighboursEEG.mat');

%% if not, this function "think" this is MEG data
if isfield(datasave,'grad')
    datasave = rmfield(datasave,'grad');
end
% if isfield(datafilt40save,'grad')
%     datafilt40save = rmfield(datafilt40save,'grad');
% end

% bad channel interpolation
if isempty(badEEG)  
    
%     datafilt40_ = datafilt40save;
    data_         = datasave;
    
else
    
    for i = 1:length(badEEG)
        if badEEG(i) < 10
            BADEEG{i} = ['EEG00' num2str(badEEG(i))];
        else
            BADEEG{i} = ['EEG0' num2str(badEEG(i))];
        end
    end
    cfg                         = [];
    cfg.method             = 'nearest';
    cfg.badchannel       = BADEEG;
    cfg.neighbours        = aen.allneighbours;
    cfg.trials                 = 'all';
    data_                       = ft_channelrepair(cfg,datasave);
%     datafilt40_               = ft_channelrepair(cfg,datafilt40save);
    
end

data = data_;
% datafilt40 = datafilt40_;

%%

folder = ['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' nip '/MegData/Processed_mne_eeg/'];
if exist(folder,'dir') == 0
    mkdir(folder)
end

trldefsave = trldef;
% trldef = trldef40;
% save([folder condtag '_dat_filt40.mat'],'datafilt40','trldef')
trldef = trldefsave;
save([folder condtag '_dat_.mat'],'data','trldef')

telapsed = toc(tstart);
disp(['elapsed time for preprocessing ' num2str(telapsed) ' s.'])
% define channel types
% [Grads1,Grads2,Mags]   = grads_for_layouts('Network');

% save(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' nip '/MegData/Processed/' condname 'filt40.mat'],'datafilt40')
% save(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' nip '/MegData/Processed/' condname 'nofilt.mat'],'data')


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function data = run_preproc(root,run,delays,windows,trialfun)
        
        % generate epoched fieldtrip dataset
        cfg1                              = [];
        cfg1.continuous              = 'no';
        cfg1.headerformat          = 'neuromag_mne';
        cfg1.dataformat              = 'neuromag_mne';
        cfg1.trialdef.channel        = 'STI101';
        cfg1.trialdef.prestim        =  windows(:,1);
        cfg1.trialdef.poststim       =  windows(:,2);
        cfg1.photodelay              = delays;
        
        cfg1.dataset                   = [root run 'ICAcorr_trans_sss.fif'];
        cfg1.trialfun                    = trialfun;
        
        cfg1.dftfilter                   = 'yes';
        
        % define channel types
        EEG                    = EEG_for_layouts('Network');
        cfg1.channel            = [EEG];
        
        % trial definition and preprocessing
        cfg2                    = ft_definetrial(cfg1);
        data                    = ft_preprocessing(cfg2);
        cfg3.dftfilter         = 'yes';
        data                    = ft_preprocessing(cfg3,data);
        
        % resample dataset
        cfg3                        = [];
        cfg3.channel            = 'all';
        cfg3.resamplefs       = 256;
        cfg3.detrend            = 'yes';
        cfg3.blc                    = 'yes';
        cfg3.feedback          = 'no';
        cfg3.trials                = 'all';
        data                        = ft_resampledata(cfg3,data);
        data.trldef               = cfg2.trl;
        
    end

    function data = run_preproc_filt40(root,run,delay,window,trialfun)
        
        % generate epoched fieldtrip dataset
        cfg1                               = [];
        cfg1.continuous               = 'no';
        cfg1.headerformat           = 'neuromag_mne';
        cfg1.dataformat              = 'neuromag_mne';
        cfg1.trialdef.channel        = 'STI101';
        cfg1.trialdef.prestim        =  window(:,1);
        cfg1.trialdef.poststim       =  window(:,2);
        cfg1.photodelay              = delay;
        % cfg1.psychinfo              = psychfile;
        
        cfg1.dataset                  = [root run 'ICAcorr_trans_sss.fif'];
        cfg1.trialfun                   = trialfun;
        
        cfg1.dftfilter                   = 'yes';
        cfg1.lpfilter                    = 'yes';
        cfg1.lpfreq                     = 35;
        
        % define channel types
        EEG                    = EEG_for_layouts('Network');
        cfg1.channel            = [EEG];
        
        % trial definition and preprocessing
        cfg2                    = ft_definetrial(cfg1);
        data                    = ft_preprocessing(cfg2);
        cfg3.dftfilter         = 'yes';
        cfg3.lpfilter          = 'yes';
        cfg3.lpfreq           = 30;
        data                    = ft_preprocessing(cfg3,data);
        
        % resample dataset
        cfg3                        = [];
        cfg3.channel            = 'all';
        cfg3.resamplefs         = 256;
        cfg3.detrend            = 'no';
        cfg3.blc                  = 'yes';
        cfg3.feedback           = 'no';
        cfg3.trials                = 'all';
        data                       = ft_resampledata(cfg3,data);
        data.trldef               = cfg2.trl;
        
    end

    function dataapp = append_run(data)
        
        instr      = 'dataapp = ft_appenddata([]';
        for j      = 1:length(data)
            instr  = [instr ',data{' num2str(j) '}'];
        end
        
        instr      = [instr ');'];
        eval(instr);
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end

