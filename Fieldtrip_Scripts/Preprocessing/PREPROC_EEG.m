function PREPROC_EEG(runlist,delay,window,trialfun,condname,nip,badEEG)

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
projfile_id        = 'PCA_EEG';

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

% get an .elec if not present
tag = 0;
tmp = fieldnames(data);
for i = 1:length(tmp)
    if strcmp(tmp{i},'elec')
       tag = 1;
    end
end

EEG = EEG_for_layouts('Laptop');

if tag == 0
    count = 1;
    for j = 1:length(data.hdr.orig.chs)
        if isempty(strfind(data.hdr.orig.chs(1,j).ch_name,'EEG')) == 0
            elecbis.chanpos(count,:) = data.hdr.orig.chs(1,j).eeg_loc(:,1)';
            count = count + 1;
        end
    end
    elecbis.label = EEG';
    data.elec = elecbis;
end

% apply pca matrix for cardiac and blink artifacts
M = computeprojmatrix_mtt_eeg(root,[root runlist{1} '_trans_sss.fif'],projfile_id,badEEG);
for i = 1:length(data.trial)
    tmp                              = [];
    tmpfilt40                        = [];
    tmp                              = data.trial{1,i}(badEEG,:);
    tmpfilt40                        = datafilt40.trial{1,i}(badEEG,:);
    data1.trial{1,i}                 = data.trial{1,i};
    data1filt40.trial{1,i}           = datafilt40.trial{1,i};
    data1.trial{1,i}(badEEG,:)       = [];
    data1filt40.trial{1,i}(badEEG,:) = [];
    data1.trial{i}                   = M*data1.trial{i};
    data1filt40.trial{i}             = M*data1filt40.trial{i};
    for l = 1:length(badEEG)
        data1.trial{i}               = [data1.trial{i}(1:badEEG(l),:); ...
            tmp; data1.trial{i}((badEEG(l)+1):end,:)];
        data1filt40.trial{i}               = [data1filt40.trial{i}(1:badEEG(l),:); ...
            tmp; data1filt40.trial{i}((badEEG(l)+1):end,:)];
    end
end

% define channel types
[Grads1,Grads2,Mags]   = grads_for_layouts('Laptop');
EEG                    = EEG_for_layouts('Laptop');

% cfg.trials             = 'all';
% cfg.minlength          = 'maxperlen';
% cfg.offset             = -window(1)*data.fsample;
% data                   = ft_redefinetrial(cfg, data);

% cfg                    = [];
% cfg.method             = 'summary';
% cfg.keepchannel        = 'yes';
% cfg.channel            = EEG;
% chansel                = my_rejectvisual(cfg,datafilt40);

% cfg.trials             = 'all';
% cfg.minlength          = 'maxperlen';
% cfg.offset             = -window(1)*datafilt40.fsample;
% datafilt40             = ft_redefinetrial(cfg, datafilt40);

cfg                    = [];
cfg.layout             = 'C:\MTT_MEG\scripts\NMeeg_Standard.lay';
lay                    = ft_prepare_layout(cfg, data);

lay.pos                = lay.pos*10;
lay.width              = lay.width*10;
lay.height             = lay.height*10;
for l                  = 1:length(lay.outline)
    lay.outline{l}     = lay.outline{l}*10;
end
lay.mask{1}            = lay.mask{1}*10;

cfg                    = [];
tmp = fieldnames(data);
for i = 1:length(tmp)
    if strcmp(tmp{i},'grad')
       data1 = rmfield(data,'grad');
    end
end

cfg                    = [];
myneighbourdist        = 1.5;
cfg.method             = 'distance';
cfg.channel            = EEG;
cfg.layout             = lay;
cfg.minnbchan          = 2;
cfg.neighbourdist      = myneighbourdist;
cfg.feedback           = 'no';
allneighbours          = ft_prepare_neighbours(cfg, data);

% bad channel interpolation
for i = 1:length(badEEG)
    BADEEG{i} = ['EEG0' num2str(badEEG(i))];
end
cfg.badchannel         = BADEEG;
cfg.neighbours         = allneighbours;
cfg.trials             = 'all';
data                   = ft_channelrepair(cfg,data);

save(['C:\MTT_MEG\data\' nip '\processed\' condname 'EEG_filt40.mat'],'datafilt40')
save(['C:\MTT_MEG\data\' nip '\processed\' condname 'EEG_nofilt.mat'],'data')

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
        
        % cfg1.dftfilter               = 'yes';
        % cfg1.lpfilter                = 'yes';
        % cfg1.lpfreq                  = 40;
        
        % define channel types
        [Grads1,Grads2,Mags]   = grads_for_layouts('Laptop');
        EEG                    = EEG_for_layouts('Laptop');
        cfg1.channel            = [EEG];
        
        % trial definition and preprocessing
        cfg2                    = ft_definetrial(cfg1);
        data                    = ft_preprocessing(cfg2);
        
        % resample dataset
%         cfg3                    = [];
%         cfg3.channel            = {'all'};
%         cfg3.resamplefs         = 256;
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
        
        % cfg1.dftfilter               = 'yes';
        cfg1.lpfilter                = 'yes';
        cfg1.lpfreq                  = 40;
        
        % define channel types
        [Grads1,Grads2,Mags]   = grads_for_layouts('Laptop');
        EEG                    = EEG_for_layouts('Laptop');
        cfg1.channel            = [EEG];
        
        % trial definition and preprocessing
        cfg2                    = ft_definetrial(cfg1);
        data                    = ft_preprocessing(cfg2);
        
        % resample dataset
%         cfg3                    = [];
%         cfg3.channel            = {'all'};
%         cfg3.resamplefs         = 256;
%         cfg3.detrend            = 'no';
%         cfg3.blc                = 'no';
%         cfg3.feedback           = 'no';
%         cfg3.trials             = 'all';
%         data                   = ft_resampledata(cfg3,data);
%         
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







