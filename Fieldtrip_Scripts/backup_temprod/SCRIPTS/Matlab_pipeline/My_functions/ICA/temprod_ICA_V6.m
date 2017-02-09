function temprod_ICA_V6(index,subject,freqband,method,numcomponent,show)

Dir = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject];

for a = 1:8
    eval(['datapath' num2str(a) '= [''/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_'...
        subject '/run' num2str(a) '.mat'']']);
end

[Gradslong, Gradslat] = grads_for_layouts;
channeltype = {'MEG*1';Gradslong;Gradslat};
chan_index  = {'Mags';'Gradslong';'Gradslat'};
chan_cmt    = {'M';'G1';'G2'};

[GradsLong,GradsLat,Mags]     = grads_for_layouts;

durinfopath = [Dir '/FT_trials/runICA' num2str(index) 'durinfo.mat'];
info = load(durinfopath);

a = 1;
datatmp = [];
for i = 1:size(info.info,1)
    load(fullfile(Dir,['/FT_trials/runICA' num2str(index) 'trial' num2str(i,'%03i') '.mat']))
    N                      = length(data.time{1});
    datatmp       = [datatmp data.trial{1,1}];
    a = a + N;
end

sizetrial = floor(size(datatmp,2)/size(info.info,1));
begtrial  = 1;
endtrial  = sizetrial;
for i = 1:size(info.info,1)
    dataepoched{1,i} = datatmp(1:306,begtrial:endtrial);
    begtrial = endtrial + 1;
    endtrial = begtrial + sizetrial - 1;
    datasobi.time{1,i}  = 0:0.004:0.004*(sizetrial-1);
end

datasobi.trial          = dataepoched;
datasobi.label          = data.label;
datasobi.fsample        = data.fsample;

clear data

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
cfg.channel           = 'MEG';
cfg.trials            = 'all';
cfg.numcomponent      = numcomponent;
cfg.blc               = 'no';
comp_topo             = ft_componentanalysis(cfg, datasobi);

%% band-pass filtering
% if bandpasstag == 1
%     for i                  = 1:length(comp_topo.trial)
%         comp_topo.trial{i}      = ft_preproc_bandpassfilter(comp_topo.trial{i},data.fsample,bandpass);
%     end
% end
clear data

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
% cfg.pad                = MaxLength/FSAMPLE;
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

freqcomppath           = [par.ProcDataDir '/FT_ICs/' method '-comp' num2str(numcomponent) 'V5_freq' num2str(index) '.mat'];
save(freqcomppath,'freq','comp_topo','freqband','cfg');
