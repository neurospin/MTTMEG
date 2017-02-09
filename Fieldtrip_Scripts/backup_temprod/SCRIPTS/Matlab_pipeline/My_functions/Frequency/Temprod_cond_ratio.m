function Temprod_cond_ratio(subject,RunArray,chantype,Pad,freqband,Target,tag)

% % test set
% subject  = 's14';
% RunArray = [2 4];
% chantype = 'Mags';
% tag      = 'Laptop';
% freqband = [1 120];
% Pad      = 12600;
% Target   = 5.7;

% set root
root = SetPath(tag);

% load data
for i = 1:2
    ProcDataDir                = [root '/DATA/NEW/processed_' subject '/'];
    DataDir                    = [ProcDataDir 'FT_trials/BLOCKTRIALS_' chantype '_RUN' num2str(RunArray(i),'%02i') '.mat'];
    eval(['data' num2str(i) ' = load(DataDir)']);
end

% load matching indexes
ProcDataDir                    = [root '/DATA/NEW/processed_' subject '/'];
DataDir                        = [ProcDataDir 'FT_trials/matchestrep_' chantype '_RUN' num2str(RunArray(i),'%02i') '.mat'];
load(DataDir)

% keep only matching data
[x2,y2] = find((isnan(matchest(:,1)) == 0) == 1);
matchest = matchest(x2,:);
[x1,y1] = find((isnan(matchrep(:,1)) == 0) == 1);
matchrep = matchrep(x1,:);

cfg                    = [];
cfg.channel            = 'all';
cfg.method             = 'mtmfft';
cfg.output             = 'pow';
cfg.taper              = 'dpss';
cfg.foi                = freqband(1):0.1:freqband(2);
cfg.tapsmofrq          = 1;
cfg.trials             = matchest(:,2);
cfg.keeptrials         = 'yes';
cfg.pad                = Pad/data1.fsample;
freq1                  = ft_freqanalysis(cfg,data1);

cfg                    = [];
cfg.channel            = 'all';
cfg.method             = 'mtmfft';
cfg.output             = 'pow';
cfg.taper              = 'dpss';
cfg.foi                = freqband(1):0.1:freqband(2);
cfg.tapsmofrq          = 1;
cfg.trials             = matchrep(:,2);
cfg.keeptrials         = 'yes';
cfg.pad                = Pad/data2.fsample;
freq2                  = ft_freqanalysis(cfg,data2);

freqratio              = freq1;
freqratio.powspctrm    = log10(freq1.powspctrm./freq2.powspctrm);

data1.duration         = (data1.sampleinfo(:,2) - data1.sampleinfo(:,1))/data1.fsample;
data1.duration         = data1.duration(matchest(:,2),:);
data1.duration         = [data1.duration (1:(length(data1.duration)))'];
freqratio.duration     = sortrows(data1.duration);

% sort trial accuracy
freqratio.accuracy     = freqratio.duration;
freqratio.accuracy(:,1) = (abs(freqratio.accuracy(:,1) - ones(size(freqratio.accuracy,1),1)*Target))/Target;
freqratio.accuracy     = sortrows(freqratio.accuracy);

% sort deviation to the median
m                      = median(freqratio.duration(:,1));
for i = 1:size(freqratio.duration,1)
    freqratio.mediandeviation(i,1:2)  = freqratio.duration(i,1:2) - [m 0];
end
freqratio.mediandeviation(:,1) = abs(freqratio.mediandeviation(:,1));
freqratio.mediandeviation = sortrows(freqratio.mediandeviation);

freqratio.target       = Target;

%% save data %%
freqpath               = [ProcDataDir '/FT_spectra/BLOCKFREQ_RATIO_' chantype '_est' num2str(RunArray(1),'%02i') 'rep' num2str(RunArray(2),'%02i')...
    '_' num2str(freqband(1)) '_' num2str(freqband(2)) 'Hz.mat'];
save(freqpath,'-struct','freqratio','label','grad','dimord','freq','powspctrm','cumsumcnt','cumtapcnt','cfg',...
    'accuracy','duration','mediandeviation','target','-v7.3');

