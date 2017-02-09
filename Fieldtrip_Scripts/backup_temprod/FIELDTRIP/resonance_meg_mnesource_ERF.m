function resonance_meg_mnesource_ERF(nip,cond,chantype)

% FISRT_TRY_SOURCE_FREQ_DICS

addpath('C:\FIELDTRIP\fieldtrip-20120402');
addpath('C:\RESONANCE_MEG\NEW_SCRIPTS')
ft_defaults

% compute covariance matrix
[Grads1,Grads2,Mags] = grads_for_layouts('Laptop');

load(['C:\RESONANCE_MEG\DATA\' nip '\anat\sourcespace.mat']);

%%%%%%%%%%%%%%%%%%%%%% test : reflip orientations %%%%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% rapid calculation of ERF and covariance matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% compute ERF
cond1 = load(['C:\RESONANCE_MEG\DATA\' nip '\processed\localizer_' cond '.mat']);

clear cfg
eval(['cfg.channel     = ' chantype ';']);
cfg.trials             = 'all';
cfg.covariance         = 'no';
cfg.keeptrials         = 'no';
cfg.removemean         = 'yes';
cfg.vartrllength       = 2;
ERF_cond               = ft_timelockanalysis(cfg,cond1.data);

cfg.baseline           = [0 0.05];
ERF_cond               = ft_timelockbaseline(cfg,ERF_cond);

cfg = [];
eval(['cfg.channel   = ' chantype ';']);
cfg.covariance       = 'yes';
cfg.covariancewindow = [0 0.05];
noisecov_cond        = ft_timelockanalysis(cfg, cond1.data);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% compute forward solution
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cfg               = [];
cfg.grad          = cond1.data.grad;            % sensor positions
eval(['cfg.channel     = ' chantype ';']);      % the used channels
cfg.grid.pos      = sourcespace.pnt;            % source points
cfg.grid.inside   = 1:size(sourcespace.pnt,1);  % all source points are inside of the brain
cfg.vol           = vol;                        % volume conduction model
leadfield         = ft_prepare_leadfield(cfg);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% compute inverse solution
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cfg               = [];
cfg.method        = 'mne';
cfg.grid          = leadfield;
cfg.vol           = vol;
cfg.mne.lambda    = 1e8;
source_cond       = ft_sourceanalysis(cfg,noisecov_cond);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% source visualization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

bnd.pnt = sourcespace.pnt;
bnd.tri = sourcespace.tri;

fig1 = figure('position',[1 1 1920 1080]);
set(fig1,'PaperPosition',[1 1 1920 1080])
set(fig1,'PaperPositionmode','auto')

for i = 1:25
    mysubplot(5,5,i)
    m = source_cond.avg.pow(:,i*2);
    ft_plot_mesh(bnd, 'vertexcolor', m,'edgecolor','none','facecolor','brain','faceindex','false','vertexindex','false');
    view(gca,[180 0]); title([num2str(source_cond.time(i*2)*1000) ' ms']);
    set(gca,'Clim',[0 3e-21])
end

save(['C:\RESONANCE_MEG\DATA\' nip '\source\Source_ERF_MNE_' cond '_' chantype '.mat'],'source_cond')

print('-dpng',['C:\RESONANCE_MEG\DATA\' nip '\plots\Source_ERF_MNE_' cond '_' chantype '.png'])








