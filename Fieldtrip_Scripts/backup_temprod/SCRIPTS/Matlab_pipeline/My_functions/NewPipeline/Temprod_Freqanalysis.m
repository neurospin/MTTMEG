%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Temprod_Freqanalysis(subject,run,freqband,chantype,Target,Pad,tag)

% subject = 's08'
% run = 5
% freqband = [1 120]
% chantype = 'Mags'
% Target = 8.5
% Pad = 12600
% tag = 'Laptop'

% set root
root = SetPath(tag);
    
% set data path and load data
ProcDataDir                    = [root '/DATA/NEW/processed_' subject '/'];
DataDir                        = [ProcDataDir '/FT_trials/BLOCKTRIALS_' chantype '_RUN' num2str(run,'%02i') '.mat'];
data = load(DataDir);

%% (2) apply a selection filter to the dataset
data                   = Temprod_DataSelect(data,'yes','yes','yes',Target);

% frequency decomposition parameters
cfg                    = [];
cfg.channel            = 'all';
cfg.method             = 'mtmfft';
cfg.output             = 'pow';
cfg.taper              = 'dpss';
cfg.foi                = freqband(1):0.1:freqband(2);
cfg.tapsmofrq          = 1;
cfg.trials             = 'all';
cfg.keeptrials         = 'yes';
cfg.pad                = Pad/data.fsample;
cfg.polyremoval        = 1;
freq                   = ft_freqanalysis(cfg,data);

freq.badchanvisual     = data.badchanvisual;     
freq.badtrialvisual    = data.badtrialvisual;     
freq.durationsorted    = data.durationsorted;    
freq.duration          = data.duration;            
freq.accuracy          = data.accuracy; 
freq.mediandeviation   = data.mediandeviation;
freq.outlier_duration_indexes = data.outlier_duration_indexes;
freq.outlier_accuracy_indexes = data.outlier_duration_indexes;
freq.target            = data.target;

%% save data %%
freqpath               = [ProcDataDir '/FT_spectra/BLOCKFREQ_' chantype '_RUN' num2str(run,'%02i')...
    '_' num2str(freqband(1)) '_' num2str(freqband(2)) 'Hz.mat'];
save(freqpath,'-struct','freq','label','grad','dimord','freq','powspctrm','cumsumcnt','cumtapcnt','cfg','badchanvisual','badtrialvisual',...
    'accuracy','duration','durationsorted','mediandeviation','target','outlier_duration_indexes','outlier_accuracy_indexes','-v7.3');



