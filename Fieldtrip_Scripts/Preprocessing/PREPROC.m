function PREPROC(runlist,delay,window,trialfun,condname,nip)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% test parameters
% runlist     = {'run1_GD';'run2_GD';'run3_DG';'run4_DG';...
%                'run5_GD'};
% delay       = 0.049;
% window      = [-0.4 2.2];
% nip         = 'sd130343';
% condname    = 'REF1';
% trialfun    = 'trialfun_mtt_REF1';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

root = ['C:\MTT_MEG\data\' nip '\'];

% ECG/EOG PCA projection
projfile_id        = 'PCA_MEG';

% preprocess each run
for i = 1:length(runlist)
    data{i}       = run_preproc(root,runlist{i},delay,window,trialfun);
    datafilt40{i} = run_preproc_filt40(root,runlist{i},delay,window,trialfun);
end

% append all the data relative to one conditions
dataapp                = append_run(data);
dataappfilt40          = append_run(datafilt40);
clear data datafilt40
data                   = dataapp;
datafilt40             = dataappfilt40;

% apply pca matrix for cardiac and blink artifacts
[M,allchan] = computeprojmatrix_mtt(root,[root runlist{1} '_trans_sss.fif'],projfile_id);
for i = 1:length(data.trial)
    data.trial{i} = M(306,306)*data.trial{i};
    datafilt40.trial{i} = M(306,306)*datafilt40.trial{i};    
end;

% define channel types
[Grads1,Grads2,Mags]   = grads_for_layouts('Laptop');

cfg                    = [];
cfg.method             = 'summary';
cfg.keepchannel        = 'yes';
% cfg.channel            = 'all';
% data                   = ft_rejectvisual(cfg,data);
% cfg.channel            = Mags;
% data                   = ft_rejectvisual(cfg,data);
% cfg.channel            = Grads1;
% data                   = ft_rejectvisual(cfg,data);
% cfg.channel            = Grads2;
% data                   = ft_rejectvisual(cfg,data);

% cfg.trials             = 'all';
% cfg.minlength          = 'maxperlen';
% cfg.offset             = -window(1)*data.fsample;
% data                   = ft_redefinetrial(cfg, data);

% cfg                    = [];
% cfg.method             = 'summary';
% cfg.keepchannel        = 'yes';
% cfg.channel            = Mags;
% datafilt40             = ft_rejectvisual(cfg,datafilt40);
% cfg.channel            = Grads1;
% datafilt40             = ft_rejectvisual(cfg,datafilt40);
% cfg.channel            = Grads2;
% datafilt40             = ft_rejectvisual(cfg,datafilt40);

% cfg.trials             = 'all';
% cfg.minlength          = 'maxperlen';
% cfg.offset             = -window(1)*datafilt40.fsample;
% datafilt40             = ft_redefinetrial(cfg, datafilt40);

save(['C:\MTT_MEG\data\' nip '\processed\' condname '_filt40.mat'],'datafilt40')
save(['C:\MTT_MEG\data\' nip '\processed\' condname '_nofilt.mat'],'data')

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function data = run_preproc(root,run,delay,window,trialfun)
        
        % generate epoched fieldtrip dataset
        cfg1                         = [];
        cfg1.continuous              = 'no';
        cfg1.headerformat            = 'neuromag_mne';
        cfg1.dataformat              = 'neuromag_mne';
        cfg1.trialdef.channel        = 'STI101';
        cfg1.trialdef.prestim        =  window(1);
        cfg1.trialdef.poststim       =  window(2);
        cfg1.photodelay              = delay;
        % cfg1.psychinfo               = psychfile;
        
        cfg1.dataset                 = [root run '_trans_sss.fif'];
        cfg1.trialfun                = trialfun;
        
        cfg1.dftfilter               = 'yes';
        % cfg1.lpfilter                = 'yes';
        % cfg1.lpfreq                  = 40;
        
        % define channel types
        [Grads1,Grads2,Mags]   = grads_for_layouts('Laptop');
        cfg1.channel            = [Grads1 Grads2 Mags];
        
        % trial definition and preprocessing
        cfg2                    = ft_definetrial(cfg1);
        data                    = ft_preprocessing(cfg2);
        
        % resample dataset
%         cfg3                    = [];
%         cfg3.channel            = {'all'};
%         cfg3.resamplefs         = 250;
%         cfg3.detrend            = 'no';
%         cfg3.blc                = 'no';
%         cfg3.feedback           = 'no';
%         cfg3.trials             = 'all';
%         data                   = ft_resampledata(cfg3,data);
        
    end

    function data = run_preproc_filt40(root,run,delay,window,trialfun)
        
        % generate epoched fieldtrip dataset
        cfg1                         = [];
        cfg1.continuous              = 'no';
        cfg1.headerformat            = 'neuromag_mne';
        cfg1.dataformat              = 'neuromag_mne';
        cfg1.trialdef.channel        = 'STI101';
        cfg1.trialdef.prestim        =  window(1);
        cfg1.trialdef.poststim       =  window(2);
        cfg1.photodelay              = delay;
        % cfg1.psychinfo               = psychfile;
        
        cfg1.dataset                 = [root run '_trans_sss.fif'];
        cfg1.trialfun                = trialfun;
        
        cfg1.dftfilter               = 'yes';
        cfg1.lpfilter                = 'yes';
        cfg1.lpfreq                  = 40;
        
        % define channel types
        [Grads1,Grads2,Mags]   = grads_for_layouts('Laptop');
        cfg1.channel            = [Grads1 Grads2 Mags];
        
        % trial definition and preprocessing
        cfg2                    = ft_definetrial(cfg1);
        data                    = ft_preprocessing(cfg2);
        
        % resample dataset
%         cfg3                    = [];
%         cfg3.channel            = {'all'};
%         cfg3.resamplefs         = 250;
%         cfg3.detrend            = 'no';
%         cfg3.blc                = 'no';
%         cfg3.feedback           = 'no';
%         cfg3.trials             = 'all';
%         data                   = ft_resampledata(cfg3,data);
        
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







