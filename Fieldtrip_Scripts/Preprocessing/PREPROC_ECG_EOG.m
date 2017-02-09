function PREPROC_ECG_EOG(runlist,delays,windows,trialfun,nip)

tstart = tic;

root = ['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/' nip '/raw_sss/'];

% preprocess each run
for i = 1:length(runlist)
    data{i}        = run_preproc(root,runlist{i},delays,windows,trialfun);
    datafilt40{i} = run_preproc_filt40(root,runlist{i},delays,windows,trialfun);
end

% append all the data relative to one conditions
dataapp                = append_run(data);
dataappfilt40          = append_run(datafilt40);
clear  datafilt40
data                   = dataapp;
datafilt40             = dataappfilt40;

trldef = [];
for i = 1:length(dataappfilt40.cfg.previous)
    trldef = [trldef;dataappfilt40.cfg.previous{1,i}.previous.trl];
end

datafilt40save = datafilt40;
datasave = data;
condtrigs = unique(trldef(:,4));

for i = 1:length(condtrigs)
    cfg     = [];
    cfg.trials   =  (find(trldef(:,4) == condtrigs(i)))';
    datafilt40 = ft_redefinetrial(cfg,datafilt40save);
    save(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' nip '/MegData/Processed/' condname{i} 'filt40.mat'],'datafilt40')
    data = ft_redefinetrial(cfg,datasave);
    save(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' nip '/MegData/Processed/' condname{i} '.mat'],'data')
end
    
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
        
        cfg1.dataset                   = [root run '_trans_sss.fif'];
        cfg1.trialfun                    = trialfun;
        
        cfg1.dftfilter                   = 'yes';
        
        % define channel types
        cfg1.channel            = ['ECG';'EOG61';'EOG62'];
        
        % trial definition and preprocessing
        cfg2                    = ft_definetrial(cfg1);
        data                    = ft_preprocessing(cfg2);
        
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
        
        cfg1.dataset                  = [root run '_trans_sss.fif'];
        cfg1.trialfun                   = trialfun;
        
        cfg1.dftfilter                   = 'yes';
        cfg1.lpfilter                    = 'yes';
        cfg1.lpfreq                     = 40;
        
        % define channel types
        cfg1.channel            = ['ECG';'EOG61';'EOG62'];
        % trial definition and preprocessing
        cfg2                    = ft_definetrial(cfg1);
        data                    = ft_preprocessing(cfg2);
        
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







