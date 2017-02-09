function temprod_ICA_V5_sobi(index,subject,freqband,numcomponent)

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

[winv,act] = sobi(datatmp,15, min(100, (size(datatmp,2)/3)));

sizetrial = floor(size(act,2)/size(info.info,1));
begtrial  = 1;
endtrial  = sizetrial;
for i = 1:size(info.info,1)
    dataepoched{1,i} = act(1:306,begtrial:endtrial);
    begtrial = endtrial + 1;
    endtrial = begtrial + sizetrial - 1;
    datasobi.time{1,i}  = 0:0.004:0.004*(sizetrial-1);
end

datasobi.trial          = dataepoched;
datasobi.label          = data.label;
datasobi.fsample        = data.fsample;

FSAMPLE = data.fsample;
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
freq                   = ft_freqanalysis(cfg, datasobi);


freqcomppath           = [par.ProcDataDir '/FT_ICs/sobi-comp' num2str(numcomponent) 'V5_freq' num2str(index) '.mat'];
save(freqcomppath,'freq','datasobi','freqband','cfg');
