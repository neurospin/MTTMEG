function temprod_ICA_V5_EEG(index,subject,freqband,method,numcomponent,highpass)

Dir = ['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject];

for a = 1:8
    eval(['datapath' num2str(a) '= [''/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_'...
        subject '/run' num2str(a) '.mat'']']);
end

durinfopath = [Dir '/FT_trials/runICA_EEG'  num2str(index) 'trial001.mat'];
load(durinfopath)

a = 1;
for i = 1:size(data.sampleinfo,1)
    load(fullfile(Dir,['/FT_trials/runICA_EEG' num2str(index) 'trial' num2str(i,'%03i') '.mat']))
    datatmp.trial{a}       = data.trial{1};
    datatmp.time{a}        = data.time{1};
    datatmp.label          = data.label;
    datatmp.fsample        = data.fsample;
    a = a+1;
end

FSAMPLE = data.fsample;
clear data
data = datatmp;

%% test with random data with same size
% for i = 1:length(data.trial)
%     data.trial{1,i} = rand(size(data.trial{1,i},1),size(data.trial{1,i},2));
% end

%% rescale data matrix to avoid error in fastica
% if strcmp('fastica',method) == 1;
%     for i = 1:length(data.trial)
%         data.trial{1,i} = data.trial{1,i}*10^14; % *multiply by a scalar don't affect ICA decomposition
%     end
% end

%% compute pca, get 10 components
clear cfg
cfg.method            = method;
cfg.fastica           = struct('numofIC',numcomponent);
cfg.runica            = struct('pca',numcomponent);
cfg.binica            = struct('ncomps',numcomponent);
cfg.channel           = 'EEG*';
cfg.trials            = 'all';
cfg.numcomponent      = numcomponent;
cfg.blc               = 'no';
comp_topo             = ft_componentanalysis(cfg, data);

%% high-pass filtering
if highpass > 0
    for i                  = 1:length(comp_topo.trial)
        comp_topo.trial{i} = ft_preproc_highpassfilter(comp_topo.trial{i},data.fsample,highpass);
    end
end
clear data
clear data.sampleinfo

%% compute power spectra density on pca components
clear cfg
cfg.channel            = 'all';
cfg.method             = 'mtmfft';
cfg.output             = 'pow';
cfg.taper              = 'dpss';
cfg.tapsmofrq          = 1;
cfg.foi                = freqband(1):0.1:freqband(2);
cfg.trials             = 'all';
cfg.keeptrials         = 'yes';
cfg.keeptapers         = 'no';
freq                   = ft_freqanalysis(cfg, comp_topo);

% if removenoise == 1
%     Nfbegin                = find(freq.freq >= 90);
%     Nfend                  = find(freq.freq <= 94);
%     Nfband                 = Nfbegin(1):Nfend(end);
%     for i = 1:size(freq.powspctrm,1)
%         for j = 1:size(freq.powspctrm,2)
%             L = linspace(freq.powspctrm(i,j,Nfbegin(1)),... % beginning of the range
%                 freq.powspctrm(i,j,Nfend(end)),... % end of the range
%                 Nfend(end) - Nfbegin(1) + 1); % number of frequency bins to replace
%             freq.powspctrm(i,j,Nfband) = L;
%         end
%     end
% end

freqcomppath           = [par.ProcDataDir '/FT_ICs/' method 'EEG-comp' num2str(numcomponent) 'V5_freq' num2str(index) '.mat'];
save(freqcomppath,'freq','comp_topo','freqband','cfg');
