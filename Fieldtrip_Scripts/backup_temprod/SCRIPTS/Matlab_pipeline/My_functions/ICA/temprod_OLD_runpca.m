function temprod_OLD_runpca(subject,index)

subject = 's03';
index   = 4;

datapath = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/OLD/processed_'...
            subject '/run' num2str(index) '.mat'];
load(datapath)

% remove eog label and timecourses
data.label([307;308]) = [];
for i = 1:length(data.trial)
    data.trial{1,i}(307:308,:) = []; 
end

% perform pca on each trial, get 20 components
for a = 1:length(data.trial)
    cfg.method            = 'pca';
    cfg.channel           = {'MEG*1'};
    cfg.trials            = a;
    cfg.numcomponent      = 20;
    cfg.blc               = 'yes';
    eval(['comp' num2str(a) '= ft_componentanalysis(cfg, data)'])
end

% specifiy layout for plotting topographies
[Gradslong, Gradslat] = grads_for_layouts;
chantype              = {'Mags';'Gradslong';'Gradslat'};
clear cfg
cfg.channel           = {'MEG*1'};
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
lay                   = ft_prepare_layout(cfg,comp1);
    for i             = 1:102
        lay.label{i,1} = ['MEG' lay.label{i,1}];
    end
cfg.layout            = lay;

% plot the 20 first components topographies
for i = 1:20
    fig = figure('position',[1 1 1280 1024]);
    for j = 1:length(data.trial)
        mysubplot(8,10,j)
        cfg.comment = ['comp ' num2str(i)];
        cfg.marker  = 'off';
        eval(['topoplot(cfg,comp' num2str(j) '.topo(1:102,i));']);
    end
    print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/OLD/Plots_' subject...
    '/topopca_run' num2str(index) '_comp' num2str(i) '.png']); 
end

% concatenate PCA components
W = [];
for i = 1:length(data.trial)
    eval(['W = [W ; comp' num2str(i) '.topo''];']);
end

% perform pca on all trials, get 20 components
cfg.method            = 'pca';
cfg.channel           = {'MEG*1'};
cfg.trials            = 'all';
cfg.numcomponent      = 20;
cfg.blc               = 'yes';
comp = ft_componentanalysis(cfg, data);

% get components timecourses
cfg.method            = 'pca';
cfg.trial             = 'all';
cfg.channel           = {'MEG*1'};
cfg.numcomponent      = 20;
cfg.topo              = comp.topo;
cfg.topolabel         = comp.topolabel;
comptimecourse        = ft_componentanalysis(cfg, data);

Wtimecourse = [];
for i = 1:length(data.trial)
    Wtimecourse = [Wtimecourse ; comptimecourse.trial{1,i}];
end













