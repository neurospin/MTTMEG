function PREPROC_from_MNE(runlist,delays,windowsERF,windowsTF,trialfun,condtag,nip)

%% %%%%%%%%%%%%%% delete previous results %%%%%%%%%%%%%%%%%%%%%
fold = ['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' nip '/MegData/Processed_new/'];
NAMESLIST = get_filenames(fold,'_dat_');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tstart = tic;

root = ['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/' nip '/'];

% preprocess each run
for i = 1:length(runlist)
    data{i}        = run_preproc(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/' nip '/'],runlist{i},delays,windowsTF,trialfun);
%     datafilt40{i} = run_preproc_filt40(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/' nip '/'],runlist{i},delays,windowsERF,trialfun);
end

% append all the data relative to one conditions
dataapp               = append_run(data);
% dataappfilt40        = append_run(datafilt40);
clear  datafilt40
data                     = dataapp;
% datafilt40             = dataappfilt40;

% trldef40 = [];
% for i = 1:length(dataappfilt40.cfg.previous)
%     trldef40 = [trldef40;[dataappfilt40.cfg.previous{1,i}.previous.previous.trl ...
%         ones(size(dataappfilt40.cfg.previous{1,i}.previous.previous.trl,1),1)*i]];
% end

trldef = [];
for i = 1:length(dataapp.cfg.previous)
    trldef = [trldef;[dataapp.cfg.previous{1,i}.previous.previous.trl ...
        ones(size(dataapp.cfg.previous{1,i}.previous.previous.trl,1),1)*i]];
end

% datafilt40save = datafilt40;
datasave = data;
% condtrigs40 = unique(trldef40(:,4));
condtrigs = unique(trldef(:,4));

trldefsave = trldef;
% trldef = trldef40;

folder = ['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' nip '/MegData/Processed_mne'];
if exist(folder,'dir') == 0
    mkdir(folder)
end

% save([folder '/' condtag '_dat_filt40.mat'],'datafilt40','trldef')
trldef = trldefsave;
save([folder '/' condtag '_dat_.mat'],'data','trldef')

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
        
        cfg1.dataset                   =  [root run 'ICAcorr_trans_sss.fif'];
        cfg1.trialfun                    = trialfun;
        
        cfg1.dftfilter                   = 'yes';
        
        % define channel types
        [Grads1,Grads2,Mags]   = grads_for_layouts('Network');
        cfg1.channel            = [Grads1 Grads2 Mags 'ECG063' 'EOG061' 'EOG062'];
        
        % trial definition and preprocessing
        cfg2                    = ft_definetrial(cfg1);
        data                    = ft_preprocessing(cfg2);
        cfg3.dftfilter         = 'yes';
        data                    = ft_preprocessing(cfg3,data);
        
        % resample dataset
        cfg3                        = [];
        cfg3.channel            = 'all';
        cfg3.resamplefs       = 250;
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
        
        % define channel types
        [Grads1,Grads2,Mags]   = grads_for_layouts('Network');
        cfg1.channel            = [Grads1 Grads2 Mags 'ECG063' 'EOG061' 'EOG062'];
        
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
        cfg3.resamplefs         = 250;
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







