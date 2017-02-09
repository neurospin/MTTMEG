%% TEST FASTICA

clear all
close all

%% SET PATHS %%
addpath '/neurospin/meg_tmp/fieldtrip-20110201/'
fieldtrip
ft_defaults
addpath '/neurospin/local/mne/i686/share/matlab/'
addpath '/neurospin/meg_tmp/tools_tmp/pipeline/'  
addpath '/neurospin/meg_tmp/temprod_Baptiste_2010/SCRIPTS/Temprod_ft_pipeline/ref_pipeline'
addpath '/neurospin/meg_tmp/temprod_Baptiste_2010/SCRIPTS/Temprod_ft_pipeline/my_pipeline'
addpath '/neurospin/meg_tmp/temprod_Baptiste_2010/SCRIPTS/Temprod_ft_pipeline/my_pipeline/FastICA_25'

%% 
load('/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_s04/run1.mat');

Label          = data.label;
Nsamples       = [];
Ntrials        = length(data.time);

for i          = 1:Ntrials
    Nsamples(i)= size(data.time{1,i},2);
end

dat            = zeros(306,sum(Nsamples));
for trial      = 1:Ntrials
    begsample  = sum(Nsamples(1:(trial-1))) + 1;
    endsample  = sum(Nsamples(1:trial));
    dat(:,begsample:endsample) = data.trial{trial}(1:306,:);
end

clear data
rescfactor     = 1/abs(min(min(dat))); % scaling factor : minimum value = 1;
dat            = dat*rescfactor;

[icasig, A, W] = FASTICA (dat,'numOfIC',10); 
% icasig : components, A : mixing matrix, W : separating matrix

[Gradslong, Gradslat] = grads_for_layouts;
channeltype = {'MEG*1';Gradslong;Gradslat};
chan_index  = {'Mags';'Gradslong';'Gradslat'};

clear cfg
cfg.channel           = channeltype{2};
cfg.xparam            = 'time';
cfg.zparam            = 'avg';
cfg.baseline          = 'no';
cfg.trials            = 'all';
cfg.colormap          = jet;
cfg.marker            = 'off';
cfg.markersymbol      = 'o';
cfg.markercolor       = [0 0 0];
cfg.markersize        = 2;
cfg.markerfontsize    = 8;
cfg.colorbar          = 'no';
cfg.interplimits      = 'head';
cfg.interpolation     = 'v4';
cfg.style             = 'both';
cfg.gridscale         = 67;
cfg.shading           = 'flat';
cfg.interactive       = 'no';
cfg.layout            = '/neurospin/meg_tmp/ResonanceMeg_Baptiste_2009/SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
lay                   = ft_prepare_layout(cfg,W');
lay.label             = Gradslong;
cfg.layout            = lay;
topoplot(cfg,W(1,1:102)')



