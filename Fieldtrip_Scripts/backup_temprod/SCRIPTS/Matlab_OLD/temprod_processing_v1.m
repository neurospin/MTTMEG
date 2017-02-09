function temprod_processing_v1

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
TROI            = [5];      %  button press on STI015
TOI             = [0];       % epoch boundaries
%-----------------
% select what to include in your PREPROCESSING
manual_AR   = 'yes';    % manual artifact rejection - select bad sensors and bad trials manually
jump_AR     = 'no';     % jump and muscle artifact rejection / this step is excrutiatingly long
ICA_ECG     = 'yes';    % ecg  ica components removal
ICA_EOG     = 'yes';    % veog ica components removal

%for f = 1:length(fname)
%-----------------sid             = 's03';                     
f = 3;
%-----------------
if strfind(fname{f},'d1')
    dur = 'd1';
elseif strfind(fname{f},'d2')
    dur = 'd2';
elseif strfind(fname{f},'d3')
    dur = 'd3';
elseif strfind(fname{f},'d4')
    dur = 'd4';
elseif strfind(fname{f},'d5')
    dur = 'd5';
elseif strfind(fname{f},'d6')
    dur = 'd6';
elseif strfind(fname{f},'rest')
    dur = 'rest';
elseif strfind(fname{f},'press')
    dur = 'press';
end;
save([sid,'_',dur,'_ICA_ecg.mat']);
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
cfg.continuous  = 'yes';
cfg.channel     = {'MEG*','EOG*','ECG*'};
cfg.continuous  = 'yes';
cfg.blc         = 'no';
raw_epochs      = preprocessing(cfg);
% ---------------- estimated duration -----------------
for j = 1:length(cfg.trl)
    timeprod_data(j) = (cfg.trl(j,2)-cfg.trl(j,1))/cfg.hdr.Fs;
end
raw_epochs.cfg.trlsecs = raw_epochs.cfg.trl/raw_epochs.hdr.Fs;
% ---------------- Sensor classification ----------------
nsens           = length(raw_epochs.label);
grad_idx        = [];
mag_idx         = [];
eeg_idx         = [];
for n = 1:nsens;
    if isempty(strmatch('MEG',raw_epochs.label{n})) == 0
        if isempty(find(findstr(raw_epochs.label{n},'1')==7))
            grad_idx = [grad_idx n];
        else
            mag_idx = [mag_idx n];
        end
    elseif isempty(strmatch('EEG',raw_epochs.label{n})) == 0
        eeg_idx = [eeg_idx n];
    endcfg            = [];
%cfg.channel    = info.channel.planar;
cfg.channel    = info.channel.magnet;
comp_meg       = componentanalysis(cfg, data);
end
info.channel.all     = raw_epochs.label(sort([grad_idx mag_idx eeg_idx]));
info.channel.meg     = raw_epochs.label(sort([grad_idx mag_idx]));
info.channel.magnet  = raw_epochs.label(mag_idx);
info.channel.planar  = raw_epochs.label(grad_idx);
info.channel.eeg     = raw_epochs.label(eeg_idx);
% ------------------ layout -----------------
cfg              = [];
if strcmp(sensors_type, 'all')
    cfg.layout  = 'NM306all.lay';
elseif strcmp(sensors_type, 'grad')
    cfg.layout  = 'NM306planar.lay';
elseif strcmp(sensors_type, 'mag')
    cfg.layout  = 'NM306mag.lay';
end;
% for i = 1:12
%    subplot(4,3,i);
%    topoplot(cfg,raw_epochs.trial{i}(1:204,120))
%end
%% ---------------------------------------------------------------------
% MANUAL sensor & trial rejection / inspection
% ---------------------------------------------------------------------
% ----
% reject TRIALS
% ----
cfg                 = [];
cfg.method          = 'summary';
cfg.channel         = {'MEG*', 'EOG*', 'ECG*'};
%cfg.channel         = {'MEG*1'};
%cfg.channel         = {'MEG*2'};
%cfg.channel         = {'MEG*3'};
raw_epochs_mAR      = rejectvisual(cfg,raw_epochs);
% plot channels
% planar
for t = 1:length(raw_epochs_mAR.trial); for i = 1:3:306; plot(raw_epochs_mAR.trial{t}(i,:)); hold on ; end; pause; hold off; end;
hold off;
for t = 1:length(raw_epochs_mAR.trial); for i = 2:3:306; plot(raw_epochs_mAR.trial{t}(i,:)); hold on ; end; pause; hold off; end;
hold off;
% magneto
for t = 1:length(raw_epochs_mAR.trial); for i = 3:3:306; plot(raw_epochs_mAR.trial{t}(i,:)); hold on ; end; pause; hold off; end;
hold off;
% EOG61
for t = 1:length(raw_epochs_mAR.trial); plot(raw_epochs_mAR.trial{t}(307,:)); hold on ; pause; hold off;end;
hold off;
% EOG62
for t = 1:length(raw_epochs_mAR.trial); plot(raw_epochs_mAR.trial{t}(308,:)); hold on ; pause; hold off;end;
hold off;
% ECG
for t = 1:length(raw_epochs_mAR.trial); plot(raw_epochs_mAR.trial{t}(309,:)); hold on ; pause; hold off;end;
hold off;

%% ------------------------------------
% ICA artefact removal
% ------------------------------------
cfg.resamplefs = 256;
cfg.detrend    = 'no';
data           = resampledata(cfg, raw_epochs_mAR);
%
cfg            = [];
%cfg.channel    = info.channel.planar;
cfg.channel    = info.channel.magnet;
comp_meg       = componentanalysis(cfg, data);
%
%save([sid,'_',dur,'_ICA_ecg.mat'],'data','comp_meg','-append');
save([sid,'_',dur,'_mag_ICA_ecg.mat'],'data','comp_meg','-append');
% ---------------
% ECG artifacts
% ---------------
% - peak detection ECG [QRS-complex] -
cfg                         = [];
cfg.trl                     = data.cfg.previous.trl;
cfg.dataset                 = data.cfg.previous.previous.dataset;
cfg.continuous              = 'yes';
%cfg.artfctdef.ecg.inspect   = info.channel.planar;
cfg.artfctdef.ecg.inspect   = info.channel.magnet;
cfg.artfctdef.ecg.channel   = 'ECG063';
cfg.artfctdef.ecg.pretim    = 0.25;
cfg.artfctdef.ecg.psttim    = 0.50-1/data.fsample;
cfg.artfctdef.ecg.cutoff    = 3;
[cfg, artifact]             = artifact_ecg(cfg);
%
%save([sid,'_',dur,'_ICA_ecg.mat'],'cfg','artifact','-append');
save([sid,'_',dur,'_mag_ICA_ecg.mat'],'cfg','artifact','-append');
%
% - segment MEG data containing ECG artifact -
cfg             = [];
cfg.dataset     = data.cfg.previous.previous.dataset;
cfg.continuous  = 'yes';
cfg.padding     = 10;
cfg.dftfilter   = 'yes';
cfg.blc         = 'yes';
cfg.trl         = [artifact zeros(size(artifact,1),1)];
%cfg.channel     = info.channel.planar;
cfg.channel   = info.channel.magnet;

% ---------------
% ECG artifacts
data_ecg        = preprocessing(cfg);
%
%save([sid,'_',dur,'_ICA_ecg.mat'], 'data_ecg','-append');
save([sid,'_',dur,'_mag_ICA_ecg.mat'], 'data_ecg','-append');
% - resample MEG data to speed up the decomposition and frequency analysis -
cfg            = [];
cfg.resamplefs = 300;
cfg.detrend    = 'no';
%cfg.channel    = info.channel.planar;
cfg.channel   = info.channel.magnet;
data_ecg       = resampledata(cfg, data_ecg);
%
% - decompose the ECG-locked datasegments into components, using the previously found (un)mixing matrix -
cfg           = [];
cfg.topo      = comp_meg.topo;
cfg.topolabel = comp_meg.topolabel;
comp_ecg      = componentanalysis(cfg, data_ecg);
%
%save([sid,'_',dur,'_ICA_ecg.mat'], 'comp_ecg','-append');
save([sid,'_',dur,'_mag_ICA_ecg.mat'], 'comp_ecg','-append');
%
% - average the components timelocked to the QRS-complex -
cfg              = [];
timelock_ecg     = timelockanalysis(cfg, comp_ecg);
%
%save([sid,'_',dur,'_ICA_ecg.mat'], 'timelock_ecg','-append');
save([sid,'_',dur,'_mag_ICA_ecg.mat'], 'timelock_ecg','-append');

%
% - look at the timelocked/averaged components and compare them with
% the ECG -
figure
subplot(2,1,1); plot(timelock_ecg.time, timelock_ecg.avg(1,:))
subplot(2,1,2); plot(timelock_ecg.time, timelock_ecg.avg(2:end,:));
figure
subplot(2,1,1); plot(timelock_ecg.time, abs(timelock_ecg.avg(1,:)))
subplot(2,1,2); imagesc(abs(timelock_ecg.avg(2:end,:)));
% -
% compute a frequency decomposition of all components and the ECG
% -
cfg            = [];
cfg.method     = 'mtmfft';
cfg.output     = 'fourier';
cfg.foilim     = [0 100];
cfg.taper      = 'hanning';
cfg.pad        = 'maxperlen';
freq_ecg       = freqanalysis(cfg, comp_ecg);
%save([sid,'_',dur,'_ICA_ecg.mat'], 'freq_ecg','-append');
save([sid,'_',dur,'_mag_ICA_ecg.mat'], 'freq_ecg','-append');
% -
% compute coherence between all components and the ECG
% -
%
cfg             = [];
cfg.channelcmb  = {'MEG*' 'ECG063'};
cfg.cohmethod   = 'coh';
cfg.jackknife   = 'no';
fdcomp          = freqdescriptives(cfg, freq_ecg);
save([sid,'_',dur,'_ICA_ecg.mat'], 'fdcomp','-append');
%%% somehow does not compute coherence spectra?!
% -
% look at the coherence spectrum between all components and the ECG
% -
figure;
subplot(2,1,1); plot(fdcomp.freq, abs(fdcomp.cohspctrm));
subplot(2,1,2); imagesc(abs(fdcomp.cohspctrm));
% -
% look at the spatial topography of the components
% -
cfg            = [];
%cfg.layout     = 'NM306planar.lay';
cfg.layout     = 'NM306mag.lay';
lay            = prepare_layout(cfg);

% plot first 20 components
x = 0;
for k = 1:4; 
    figure(k)
    for idx = 1:30
        subplot(6,5,idx);
        topoplot(cfg,comp_ecg.topo(:,x+idx));
    end
    x = k*30;
end

% check in time
figure(100)
subplot(2,1,1);
for i = 1:102
    plot(data_ecg.trial{1}(i,:));
    hold on;
end
subplot(2,1,2);
topoplot(cfg,data_ecg.trial{1}(:,50));

%% ------------------------------
% select components TO REMOVE
% decompose the original data as it was prior to downsampling
cfg             = [];
cfg.topo        = comp_ecg.topo;
cfg.topolabel   = comp_ecg.topolabel;
comp_meg_orig   = componentanalysis(cfg, raw_epochs_mAR);
save([sid,'_',dur,'_ICA_ecg.mat'], 'comp_meg_orig','-append');

% the original data can now be reconstructed, excluding those components
cfg             = [];
cfg.component   = [];         % !!!!!!!!!!
epochs_icaECG = rejectcomponent(cfg, comp_meg_orig);
epochs_icaECG.trlsecs = data.cfg.previous.trl/data.cfg.origfs;

save([sid,'_',dur,'_ICA_ecg.mat'], 'epochs_icaECG','-append');

% ------------------------------------
% ------------------------------------

% spectrum trial based
for i = 1:70 
    %epochs_psd{i} = psd(spectrum.welch,epochs_icaECG.trial{i}(100,:),'Fs',2000);
    data_psd(i,:) = epochs_psd{i}.Data;
    %plot(epochs_psd{i});
    %hold on
end

% make correlation variance
for j = 1:length(epochs_icaECG.cfg.previous.previous.trl)
    timeprod_cleandata(j) = (epochs_icaECG.cfg.previous.previous.trl(j,2)-epochs_icaECG.cfg.previous.previous.trl(j,1))/epochs_icaECG.cfg.previous.previous.previous.hdr.Fs;
end

save([sid,'_',dur,'_ICA_ecg.mat'], 'epochs_psd','data_psd','timeprod_cleandata','-append');


 
% % ------------------ time-frequency -----------------
% cfg.output       = 'pow';
% cfg.method       = 'mtmconvol';
% cfg.taper        = 'hanning';
% cfg.foi          = 1:3:46;                            % analysis 2 to 46 Hz in steps of 2 Hz
% cfg.t_ftimwin    = ones(length(cfg.foi),1).*0.5;      % length of time window = 0.5 sec
% cfg.toi          = 0:0.05:epochs_icaECG.trlsecs(:,2);% time window "slides" from -0.5 to 1.5 sec in steps of 0.05 sec (50 ms)
% 
% % single trials
% cfg.keeptrials   = 'yes';
% TFRhann_tr       = freqanalysis(cfg, epochs_icaECG);
% % av trials
% cfg.keeptrials   = 'no';
% TFRhann_av       = freqanalysis(cfg, epochs_icaECG);
% 
% save([sid,'_',dur,'_TFR.mat'],'epochs_icaECG','TFRhann_tr','TFRhann_av');
% 
% cfg = [];
% % if strcmp(sensors_type, 'all')
% %     cfg.layout  = 'NM306all.lay';
% % elseif strcmp(sensors_type, 'grad')
%      cfg.layout  = 'NM306planar.lay';
% % elseif strcmp(sensors_type, 'mag')
% %     cfg.layout  = 'NM306mag.lay';
% % end
% cfg.zlim         = [-3e-27 3e-27];
% cfg.showlabels   = 'yes';
% figure
% multiplotTFR(cfg, TFRhann_av);
% 
% end%for fname