function temprod_ICA_V5_parafac(index,subject,freqband,numcomponent)

Dir = ['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject];

for a = 1:8
    eval(['datapath' num2str(a) '= [''/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_'...
        subject '/run' num2str(a) '.mat'']']);
end

[Gradslong, Gradslat] = grads_for_layouts;
channeltype = {'MEG*1';Gradslong;Gradslat};
chan_index  = {'Mags';'Gradslong';'Gradslat'};
chan_cmt    = {'M';'G1';'G2'};

[GradsLong,GradsLat,Mags]     = grads_for_layouts;

durinfopath = [Dir '/FT_trials/runICA' num2str(index) 'durinfo.mat'];
info = load(durinfopath);

options = [1e-6 0 0 1 10 10000];
c = colormap(jet(numcomponent));

a        = 1;
datatmp  = [];
begtendt = [];
for i = 1:size(info.info,1)
    load(fullfile(Dir,['/FT_trials/runICA' num2str(index) 'trial' num2str(i,'%03i') '.mat']))
    N(i)                     = length(data.time{1});
    datatmp       = [datatmp data.trial{1,1}];
    begtendt(i,:) = [a a+N(i)];
    a = a + N(i) - 1;
end

factors = parafac(datatmp,numcomponent,options);

for i = 1:length(N)
    dataepoched{1,i}   = (factors{1,2}((begtendt(i,1)):(begtendt(i,2)),:))';
    datatime{1,i} = 0:0.004:(N(i))*0.004;
end

dataparafac.trial  = dataepoched;
dataparafac.time   = datatime;
dataparafac.dimord = 'rpt_chan_time';
data.label         = {'comp1';'comp2';'comp3';'comp4';'comp5';...
                      'comp6';'comp7';'comp8';'comp9';'comp10'};
dataparafac.fsample   = data.fsample;

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
freq                   = ft_freqanalysis(cfg, dataparafac);


freqcomppath           = [par.ProcDataDir '/FT_ICs/sobi-comp' num2str(numcomponent) 'V5_freq' num2str(index) '.mat'];
save(freqcomppath,'freq','datasobi','freqband','cfg');
