function temprod_processing

setpath
%% -----------------------------------------------------------------------
% ------------------ START - ENTER YOUR VARIABLES HERE-------------------
% -----------------------------------------------------------------------
study_path      = '/neurospin/tmp/vvw/temprod/';
trial_funfile   = 'temprod_trialfun';
sensors_type    = 'all';
%sensors_type    = 'mag';
%sensors_type    = 'grad';
cd(study_path);
sid             = 's03';                            % subject ID
fpath           = [study_path sid '/'];
d               = [0.75 1.7 2.8 5.2 11.7 17.3];     % durées, d_idx <=> d in fname
%
%fname   = { 's02_b1d1_raw_sss.fif'...
%             's02_b2d4_raw_sss.fif'...
%             's02_b3d3_raw_sss.fif'...
%             's02_b4d6_raw_sss.fif'...
%             's02_b4d6_raw-1_sss.fif'...
%             's02_b5d2_raw_sss.fif'...
%             };
%
% !!!! find out how to combine several files together
fname   = { 's03_b1d6_raw_sss.fif'...              
            's03_b1d6_raw-1_sss.fif'...
            's03_b2d1_raw_sss.fif'...
            's03_b3d5_raw_sss.fif'...
            's03_b3d5_raw-1_sss.fif'...
            's03_b4d3_raw_sss.fif'...
            's03_b5d2_raw-1_sss.fif'...
            's03_b6d4_raw_sss.fif'...
            's03_b7_rest_raw_sss.fif'...
            's03_b8_rndpress_raw_sss.fif'...
            };
% define your triggers of interest by blocktype
TROI            = [5];      %  button press on STI015
TOI             = [0];       % epoch boundaries
%-----------------
% select what to include in your PREPROCESSING
manual_AR   = 'yes';    % manual artifact rejection - select bad sensors and bad trials manually
jump_AR     = 'no';     % jump and muscle artifact rejection / this step is excrutiatingly long
ICA_ECG     = 'yes';    % ecg  ica components removal
ICA_EOG     = 'yes';    % veog ica components removal



%for f = 1:length(fname)
f = 3;
% ----------------- READ file info -----------------
cfg                     = [];
cfg.continuous          = 'yes';
cfg.dataset             = [fpath fname{f}];
cfg.headerformat        = 'neuromag_mne';
cfg.dataformat          = 'neuromag_mne';
cfg.dat                 = read_data([fpath fname{f}]);
cfg.datafile            = [fpath fname{f}];
cfg.hdr                 = read_header([fpath fname{f}]);
cfg.headerfile          = [fpath fname{f}];
% ----------------- DEFINE TRIAL -----------------
cfg.trialdef.channel    = {'STI015'};
cfg.trialdef.eventvalue = TROI;
cfg.trialdef.prestim    = TOI;
cfg.trialfun            = trial_funfile;
cfg                     = definetrial(cfg);
% ---------------- preprocess data -----------------
cfg.continuous      = 'yes';
if strcmp(sensors_type, 'all')
    % all sensors
    cfg.channel         = {'MEG*','EOG*','ECG*'};
    cfg.continuous      = 'yes';
    raw_epochs_all      = preprocessing(cfg);
elseif strcmp(sensors_type, 'grad')
    % only gradiometers
    %cfg.channel         = {'MEG*2', 'MEG*3','EOG*','ECG*'};
    cfg.channel         = {'MEG*2', 'MEG*3'};
    cfg.continuous      = 'yes';
    raw_epochs_grad     = preprocessing(cfg);
elseif strcmp(sensors_type, 'mag')
    % only magnetometers
    cfg.channel         = {'MEG*1','EOG*','ECG*'};
    cfg.continuous      = 'yes';
    raw_epochs_mag     = preprocessing(cfg);
end
% ------------------ layout -----------------
cfg              = [];
if strcmp(sensors_type, 'all')
    cfg.layout  = 'NM306all.lay';
elseif strcmp(sensors_type, 'grad')
    cfg.layout  = 'NM306planar.lay';
elseif strcmp(sensors_type, 'mag')
    cfg.layout  = 'NM306mag.lay';
end

%for i = 1:12
%    subplot(4,3,i);
%    topoplot(cfg,raw_epochs_grad.trial{i}(1:204,120))
%    topoplot(cfg,raw_epochs_all.trial{i}(1:204,120))
%end
% ------------------ time-frequency -----------------
cfg.output       = 'pow';
cfg.method       = 'mtmconvol';
cfg.taper        = 'hanning';
cfg.foi          = 1:3:46;                         % analysis 2 to 46 Hz in steps of 2 Hz
cfg.t_ftimwin    = ones(length(cfg.foi),1).*0.5;   % length of time window = 0.5 sec
cfg.toi          = -0.5:0.05:1.5;                  % time window "slides" from -0.5 to 1.5 sec in steps of 0.05 sec (50 ms)   
if strcmp(sensors_type, 'all')
    % single trials
    cfg.keeptrials   = 'yes';
    TFRhann_tr_all   = freqanalysis(cfg, raw_epochs_all);
    % av trials
    cfg.keeptrials   = 'no';
    TFRhann_av_all   = freqanalysis(cfg, raw_epochs_all);
elseif strcmp(sensors_type, 'grad')
    % single trials
    cfg.keeptrials   = 'yes';
    TFRhann_tr_grad   = freqanalysis(cfg, raw_epochs_grad);
    % av trials
    cfg.keeptrials   = 'no';
    TFRhann_av_grad   = freqanalysis(cfg, raw_epochs_grad);
elseif strcmp(sensors_type, 'mag')
    % single trials
    cfg.keeptrials   = 'yes';
    TFRhann_tr_mag   = freqanalysis(cfg, raw_epochs_mag);
    % av trials
    cfg.keeptrials   = 'no';
    TFRhann_av_mag   = freqanalysis(cfg, raw_epochs_mag);
end
% 
cfg = [];
% if strcmp(sensors_type, 'all')
%     cfg.layout  = 'NM306all.lay';
% elseif strcmp(sensors_type, 'grad')
%     cfg.layout  = 'NM306planar.lay';
% elseif strcmp(sensors_type, 'mag')
%     cfg.layout  = 'NM306mag.lay';
% end
cfg.zlim         = [-3e-27 3e-27];
cfg.showlabels   = 'yes';
figure
multiplotTFR(cfg, TFRhann_av_all);
%multiplotTFR(cfg, TFRhann_av_grad);
%multiplotTFR(cfg, TFRhann_av_mag);


end%for fname