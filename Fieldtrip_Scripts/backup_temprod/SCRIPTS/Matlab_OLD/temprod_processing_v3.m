function temprod_processing_v3
%% ------------------------------------------------------------------------
% ------------------ ENTER VARIABLES HERE ---------------------------------
% -------------------------------------------------------------------------
%setpath 
study_path      = '/neurospin/tmp/vvw/temprod/';
trial_funfile   = 'temprod_trialfun';
%
%sensors_type    = 'all';
%sensors_type    = 'mag';
sensors_type    = 'grad';
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
% f = 1; % d6
% f = 2; % d6
% f = 3;   % d1
% f = 4; % d5
% f = 5; % d5
% f = 6; % d3
% f = 7; % d2
% f = 8; % d4
% f = 9; % rest
 f = 10; % rndpress

%-----------------
if strfind(fname{f},'d1');        dur = 'd1';
elseif strfind(fname{f},'d2');    dur = 'd2';
elseif strfind(fname{f},'d3');    dur = 'd3';
elseif strfind(fname{f},'d4')%% -----------------------------------------------------------------------
;    dur = 'd4';
elseif strfind(fname{f},'d5');    dur = 'd5';
elseif strfind(fname{f},'d6');    dur = 'd6';
elseif strfind(fname{f},'rest');  dur = 'rest';
elseif strfind(fname{f},'press'); dur = 'rndpress';
end;

% ----------------- start saving
save([sid,'_',dur,'.mat']);

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
cfg.continuous  = 'yes';
cfg.channel     = {'MEG*','EOG*','ECG*'};
cfg.continuous  = 'yes';
cfg.blc         = 'no';
raw_epochs      = preprocessing(cfg);
% ----
% estimated duration
% ----
for j = 1:length(cfg.trl)
    timeprod_data(j) = (cfg.trl(j,2)-cfg.trl(j,1))/cfg.hdr.Fs;
end
raw_epochs.cfg.trlsecs = raw_epochs.cfg.trl/raw_epochs.hdr.Fs;
%% ----
% ---------------- Sensor classification ----------------
% ----
grad_idx        = [];
mag_idx         = [];
eeg_idx         = [];
for n = 1:length(raw_epochs.label)
    if isempty(strmatch('MEG',raw_epochs.label{n})) == 0
        if isempty(find(findstr(raw_epochs.label{n},'1')==7))
            grad_idx = [grad_idx n];
        else
            mag_idx = [mag_idx n];
        end;
    elseif isempty(strmatch('EEG',raw_epochs.label{n})) == 0
        eeg_idx       = [eeg_idx n];
    end
end
info.channel.all     = raw_epochs.label(sort([grad_idx mag_idx eeg_idx]));
info.channel.meg     = raw_epochs.label(sort([grad_idx mag_idx]));
info.channel.magnet  = raw_epochs.label(mag_idx);
info.channel.planar  = raw_epochs.label(grad_idx);
info.channel.eeg     = raw_epochs.label(eeg_idx);
%% ---------------------------------------------------------------------
% MANUAL sensor & trial rejection / inspection
% ---------------------------------------------------------------------
% ----
% reject TRIALS
% ----
cfg                 = [];
cfg.method          = 'summary';
cfg.channel         = {'MEG*', 'EOG*', 'ECG*'};
raw_epochs_mAR      = rejectvisual(cfg,raw_epochs);
% ----
% plot channels
% ----
% planar
for t = 1:length(raw_epochs_mAR.trial); for i = 1:3:306; plot(raw_epochs_mAR.trial{t}(i,:)); hold on ; end; pause; hold off; end;hold off;
for t = 1:length(raw_epochs_mAR.trial); for i = 2:3:306; plot(raw_epochs_mAR.trial{t}(i,:)); hold on ; end; pause; hold off; end;hold off;
% magneto
for t = 1:length(raw_epochs_mAR.trial); for i = 3:3:306; plot(raw_epochs_mAR.trial{t}(i,:)); hold on ; end; pause; hold off; end;hold off;
%
save([sid,'_',dur,'.mat'],'raw_epochs_mAR','-append');

%% ------------------------------------
% ------------------------------------
%normalize grad and magnet sensors - do ICA on both sets of sensors at once?
% ------------------------------------
% ------------------------------------

%% ------------------------------------
% ICA artefact removal
% ------------------------------------
cfg.resamplefs = 256;
cfg.detrend    = 'no';
data           = resampledata(cfg, raw_epochs_mAR);
%
cfg            = [];
if strcmp(sensors_type, 'all')
    cfg.channel    = info.channel.meg;
    comp_all_meg   = componentanalysis(cfg, data);
elseif strcmp(sensors_type, 'grad')    
    cfg.channel    = info.channel.planar;
    comp_grad_meg  = componentanalysis(cfg, data);
elseif strcmp(sensors_type, 'mag')
    cfg.channel    = info.channel.magnet;
    comp_mag_meg   = componentanalysis(cfg, data);
end;
%
save([sid,'_',dur,'.mat'],'data','comp*meg','-append');

% ---------------
% ECG artifacts
% ---------------
% - peak detection ECG [QRS-complex] -
cfg                         = [];
cfg.trl                     = data.cfg.previous.trl;
cfg.dataset                 = data.cfg.previous.previous.dataset;
cfg.continuous              = 'yes';
cfg.artfctdef.ecg.channel   = 'ECG063';
cfg.artfctdef.ecg.pretim    = 0.25;
cfg.artfctdef.ecg.psttim    = 0.50-1/data.fsample;
cfg.artfctdef.ecg.cutoff    = 3;
if strcmp(sensors_type, 'all')
    cfg.channel    = info.channel.meg;
elseif strcmp(sensors_type, 'grad')
    cfg.artfctdef.ecg.inspect    = info.channel.planar;
elseif strcmp(sensors_type, 'mag')
    cfg.artfctdef.ecg.inspect    = info.channel.magnet;
end;
[cfg, artifact]             = artifact_ecg(cfg);

save([sid,'_',dur,'.mat'],'cfg','artifact','-append');
% ---
% - segment MEG data containing ECG artifact -
% ---
cfg             = [];
cfg.dataset     = data.cfg.previous.previous.dataset;
cfg.continuous  = 'yes';
cfg.padding     = 10;
cfg.dftfilter   = 'yes';
cfg.blc         = 'yes';
cfg.trl         = [artifact zeros(size(artifact,1),1)];
if strcmp(sensors_type, 'all')
    cfg.channel     = info.channel.meg;
    data_all_ecg    = preprocessing(cfg);
elseif strcmp(sensors_type, 'grad')
    cfg.channel     = info.channel.planar;
    data_grad_ecg   = preprocessing(cfg);
elseif strcmp(sensors_type, 'mag')
    cfg.channel     = info.channel.magnet;
    data_mag_ecg    = preprocessing(cfg);
end;

save([sid,'_',dur,'.mat'], 'data*ecg','-append');
% ---
% - downsample MEG data to speed up-
% ---
cfg            = [];
cfg.resamplefs = 300;
cfg.detrend    = 'no';

if strcmp(sensors_type, 'all')
    cfg.channel    = info.channel.meg;
    data_all_ecg   = resampledata(cfg, data_all_ecg);
elseif strcmp(sensors_type, 'grad')
    cfg.channel    = info.channel.planar;
    data_grad_ecg  = resampledata(cfg, data_grad_ecg);
elseif strcmp(sensors_type, 'mag')
    cfg.channel    = info.channel.magnet;
    data_mag_ecg   = resampledata(cfg, data_mag_ecg);    
end;
% ---
% - decompose the ECG-locked datasegments into components, using the previously found (un)mixing matrix -
% ---
cfg           = [];
if strcmp(sensors_type, 'all')
    cfg.topo      = comp_all_meg.topo;
    cfg.topolabel = comp_all_meg.topolabel;
    comp_all_ecg  = componentanalysis(cfg, data_all_ecg);
elseif strcmp(sensors_type, 'grad')
    cfg.topo      = comp_grad_meg.topo;
    cfg.topolabel = comp_grad_meg.topolabel;   
    comp_grad_ecg = componentanalysis(cfg, data_grad_ecg);
elseif strcmp(sensors_type, 'mag')
    cfg.topo      = comp_mag_meg.topo;
    cfg.topolabel = comp_mag_meg.topolabel;    
    comp_mag_ecg  = componentanalysis(cfg, data_mag_ecg);    
end;

save([sid,'_',dur,'.mat'], 'comp*ecg','-append');
% ---
% - average the components timelocked to the QRS-complex -
% ---
cfg              = [];
if strcmp(sensors_type, 'all')
    timelock_all_ecg  = timelockanalysis(cfg, comp_all_ecg);
elseif strcmp(sensors_type, 'grad')
    timelock_grad_ecg = timelockanalysis(cfg, comp_grad_ecg);
elseif strcmp(sensors_type, 'mag')
    timelock_mag_ecg  = timelockanalysis(cfg, comp_mag_ecg);    
end;
%
save([sid,'_',dur,'.mat'], 'timelock*ecg','-append');
% ---
% - look at the timelocked/averaged components, compare them with the ECG -
% ---
figure
subplot(2,1,1); plot(timelock_grad_ecg.time, timelock_grad_ecg.avg(1,:))
subplot(2,1,2); plot(timelock_grad_ecg.time, timelock_grad_ecg.avg(2:end,:));
figure
subplot(2,1,1); plot(timelock_grad_ecg.time, timelock_grad_ecg.avg(1,:))
subplot(2,1,2); imagesc(timelock_grad_ecg.avg(2:end,:));
% % -
% % compute a frequency decomposition of all components and the ECG
% % -
% cfg            = [];
% cfg.method     = 'mtmfft';
% cfg.output     = 'fourier';
% cfg.foilim     = [0 100];
% cfg.taper      = 'hanning';
% cfg.pad        = 'maxperlen';
% if strcmp(sensors_type, 'all') 
%     cfg.topo      = comp_all_meg.topo;
%     cfg.topolabel = comp_all_meg.topolabel;
%     freq_all_ecg  = freqanalysis(cfg, comp_all_ecg);
% elseif strcmp(sensors_type, 'grad')
%     cfg.topo      = comp_grad_meg.topo;
%     cfg.topolabel = comp_grad_meg.topolabel;  
%     freq_grad_ecg = freqanalysis(cfg, comp_grad_ecg);
% elseif strcmp(sensors_type, 'mag')
%     cfg.topo      = comp_mag_meg.topo;
%     cfg.topolabel = comp_mag_meg.topolabel; 
%     freq_mag_ecg  = freqanalysis(cfg, comp_mag_ecg);    
% end;
% save([sid,'_',dur,'_ICA.mat'], 'freq*ecg','-append');
% % -
% % compute coherence between all components and the ECG
% % -
% %
% cfg             = [];
% cfg.channelcmb  = {'MEG*' 'ECG063'};
% cfg.jackknife   = 'no';
% if strcmp(sensors_type, 'all') 
%     fdcomp_all          = freqdescriptives(cfg, freq_all_ecg);
% elseif strcmp(sensors_type, 'grad')
%     fdcomp_grad          = freqdescriptives(cfg, freq_grad_ecg);
% elseif strcmp(sensors_type, 'mag')
%     fdcomp_mag          = freqdescriptives(cfg, freq_mag_ecg);
% end;figure
subplot(2,1,1); plot(timelock_grad_ecg.time, abs(timelock_grad_ecg.avg(1,:)))
subplot(2,1,2); imagesc(abs(timelock_grad_ecg.avg(2:end,:)));
% save([sid,'_',dur,'_ICA.mat'], 'fdcomp*','-append');
% % -
% % look at the coherence spectrum between all components and the ECG
% % -
% figure;
% subplot(2,1,1); plot(fdcomp.freq, abs(fdcomp_grad.cohspctrm));
% subplot(2,1,2); imagesc(abs(fdcomp_grad.cohspctrm));
% -
% look at the spatial topography of the components
% -
cfg            = [];
cfg.layout     = 'NM306planar.lay';
%cfg.layout    = 'NM306mag.lay';
%cfg.layout    = 'NM306all.lay';
lay            = prepare_layout(cfg);

% plot first 20 components
x = 0;
for k = 1:4; 
    figure(k)
    for idx = 1:30
        subplot(6,5,idx);
        cfg.interpolation = 'v4';
        topoplot(cfg,comp_grad_ecg.topo(:,x+idx));
        %topoplot(cfg,comp_mag_ecg.topo(:,x+idx));
        %topoplot(cfg,comp_all_ecg.topo(:,x+idx));
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
if strcmp(sensors_type, 'all')
    cfg.topo          = comp_all_ecg.topo;
    cfg.topolabel     = comp_all_ecg.topolabel;
    comp_all_meg_orig = componentanalysis(cfg, raw_epochs_mAR);
elseif strcmp(sensors_type, 'grad')
    cfg.topo          = comp_grad_ecg.topo;
    cfg.topolabel     = comp_grad_ecg.topolabel;
    comp_grad_meg_orig = componentanalysis(cfg, raw_epochs_mAR);
elseif strcmp(sensors_type, 'mag')
    cfg.topo          = comp_mag_ecg.topo;
    cfg.topolabel     = comp_mag_ecg.topolabel;
    comp_mag_meg_orig = componentanalysis(cfg, raw_epochs_mAR);
end;
save([sid,'_',dur,'.mat'], 'comp_*_meg_orig','-append');

%
cfg            = [];
cfg.layout     = 'NM306planar.lay';
%cfg.layout    = 'NM306mag.lay';
%cfg.layout    = 'NM306all.lay';
lay            = prepare_layout(cfg);
cfg =[];
cfg.comp = [1 2 3];
componentbrowser(cfg,comp_grad_meg_orig);
%
% the original data are reconstructed, excluding those components
cfg                   = [];
cfg.component         = [1 2 3 4];         % !!!!!!!!!!
if strcmp(sensors_type, 'all')
    epochs_all_icaECG         = rejectcomponent(cfg, comp_all_meg_orig);
    epochs_all_icaECG.trlsecs = data.cfg.previous.trl/data.cfg.origfs;
elseif strcmp(sensors_type, 'grad')
    epochs_grad_icaECG         = rejectcomponent(cfg, comp_grad_meg_orig);
    epochs_grad_icaECG.trlsecs = data.cfg.previous.trl/data.cfg.origfs;
elseif strcmp(sensors_type, 'mag')
    epochs_mag_icaECG         = rejectcomponent(cfg, comp_mag_meg_orig);
    epochs_mag_icaECG.trlsecs = data.cfg.previous.trl/data.cfg.origfs;
end;
save([sid,'_',dur,'ICA.mat'], 'epochs_*_icaECG','-append');


% -
cfg            = [];
cfg.layout     = 'NM306planar.lay';
%cfg.layout    = 'NM306mag.lay';
%cfg.layout    = 'NM306all.lay';
lay            = prepare_layout(cfg);

% compare before after per sensor
figure;for k = 1:70;for i = 1:204; plot(epochs_grad_icaECG.trial{k}(1,:)); hold on; plot(raw_epochs_mAR.trial{k}(1,:),'r');end;hold off; pause; end

% ------------------------------------
% ------------------------------------

% spectrum trial based
for k = 1:size(epochs_grad_icaECG.trial{1},1);
    for i = 1:70 
        epochs_grad_psd{k,i} = psd(spectrum.welch,epochs_grad_icaECG.trial{i}(1,:),'Fs',2000);
        data_grad_psd(i,:) = epochs_grad_psd{k,i}.Data;
        plot(epochs_grad_psd{k,i});
        hold on;
    end
    hold off;
end

% make correlation variance
for j = 1:length(epochs_icaECG.cfg.previous.previous.trl)
    timeprod_cleandata(j) = (epochs_icaECG.cfg.previous.previous.trl(j,2)-epochs_icaECG.cfg.previous.previous.trl(j,1))/epochs_icaECG.cfg.previous.previous.previous.hdr.Fs;
end

save([sid,'_',dur,'_ICA.mat'], 'epochs_psd','data_psd','timeprod_cleandata','-append');


 
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