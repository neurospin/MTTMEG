
function temprod_singletrial_processing_v1
%% ------------------------------------------------------------------------
% ------------------ ENTER VARIABLES HERE ---------------------------------
% -------------------------------------------------------------------------
addpath('/neurospin/local/mne/MNE-2.7.0-3089-Linux-i686/share/matlab'); 
fieldtrip

%setpath 
study_path      = '/neurospin/meg/meg_tmp/2009_vvw/2009_temprod/';
trial_funfile   = 'temprod_trialfun';
%
sensors_type    = 'all';
%sensors_type    = 'mag';
%sensors_type    = 'grad';
%
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
fname = { 's03_b1d6_raw_sss.fif'...
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
TROI        = [5];      %  button press on STI015
TOI         = [0];      % epoch boundaries
%for f = 1:length(fname)
%-----------------
% f = 1; % d6
% f = 2; % d6
 f = 3;  % d1
% f = 4; % d5
% f = 5; % d5
% f = 6; % d3
% f = 7; % d2
% f = 8; % d4
% f = 9; % rest
% f = 10; % rndpress

%-----------------
if strfind(fname{f},'d1');        dur = 'd1';
elseif strfind(fname{f},'d2');    dur = 'd2';
elseif strfind(fname{f},'d3');    dur = 'd3';
elseif strfind(fname{f},'d4');    dur = 'd4';
elseif strfind(fname{f},'d5');    dur = 'd5';
elseif strfind(fname{f},'d6');    dur = 'd6';
elseif strfind(fname{f},'rest');  dur = 'rest';
elseif strfind(fname{f},'press'); dur = 'rndpress';
end;

% ----------------- start saving
%save([sid,'_',dur,'.mat']);

%% ----
% READ file info
% ----
cfg                     = [];
cfg.continuous          = 'yes';
cfg.dataset             = [fpath fname{f}];
cfg.headerformat        = 'neuromag_mne';
cfg.dataformat          = 'neuromag_mne';
cfg.dat                 = read_data([fpath fname{f}]);
cfg.datafile            = [fpath fname{f}];
cfg.hdr                 = read_header([fpath fname{f}]);
cfg.headerfile          = [fpath fname{f}];
% ----
% DEFINE TRIAL
% ----
cfg.trialdef.channel    = {'STI015'};
cfg.trialdef.eventvalue = TROI;
cfg.trialdef.prestim    = TOI;
cfg.trialfun            = trial_funfile;
cfg                     = definetrial(cfg);
% ----
% preprocess data
% ----
% time epochs
cfg.continuous  = 'yes';
cfg.channel     = {'MEG*','EOG*','ECG*'};
cfg.continuous  = 'yes';
cfg.blc         = 'no';
data            = preprocessing(cfg);

% ----
% POWER of POWER
% ----
% mtmconvol
cfg            = [];
cfg.method     = 'mtmconvol';
cfg.channel    = 'mix';
cfg.output     = 'pow';
cfg.taper      = 'hanning';
cfg.foi        = 2:2:50;
cfg.toi        = data.time{1}; % power calculated at every sample
cfg.t_ftimwin  = 4./cfg.foi;   % timewindow used to calculate power is 4 cycles long and therefore differs over frequencies
cfg.keeptrials = 'yes';

freq1 = freqanalysis(cfg,data);

figure; 
imagesc(freq1.time, freq1.freq, squeeze(freq1.powspctrm));
axis xy²

% mtmfft output power
cfg            = [];
cfg.method     = 'mtmfft';
cfg.output     = 'pow';
cfg.taper      = 'hanning';
cfg.foilim     = [2 50];
cfg.keeptrials = 'no';

freq2 = freqanalysis(cfg,freq1); %FieldTrip automatically converts the freq1 data to raw data. 
                                 %Every frequency in the powerspectrum is converted to a a channel labeled mix@xxHz

freq2.freq2 = [2:2:60];
figure; imagesc(freq2.freq, freq2.freq2, freq2.powspctrm)
axis xy






% ----
% HILBERT
% ----

% bandpass and hilbert
cfg.channel    = 'mix';
cfg.bpfilter   = 'yes';
cfg.bpfreq     = [2 45];
cfg.hilbert    = 'yes';
cfg.keeptrials = 'yes';
data_hilbert = preprocessing(cfg);
%
figure; plot(data.time{1},data.trial{1}(1,:)); 
hold on;
plot(data_hilbert.time{1}(1,:),data_hilbert.trial{1}(1,:),'r', 'linewidth', 2);

% ----
% calculate powerspectrum of hilbert data
% ----
cfg = [];
cfg.method    = 'mtmfft';
cfg.channel   = 'mix';
cfg.output    = 'pow';
cfg.taper     = 'hanning';
cfg.foilim    = [2 45];
fft_hilbert = freqanalysis(cfg,data_hilbert);

% plot powerspectrum
cfg         = []
cfg.xlim    = [1 20];
figure; singleplotER(cfg,fft_hilbert);





