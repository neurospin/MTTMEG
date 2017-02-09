% test source reconstruction
clear all
close all

addpath('C:\FIELDTRIP\fieldtrip-20120402');
ft_defaults

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% make the TEMPLATE GRID %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% read anatomical MRI template
template_mri     = ft_read_mri('C:\SPM\SPM8\spm8\templates\T1.nii');

% segment the template brain
cfg              = [];
cfg.output       = {'tpm' 'brain' 'skull' 'skullstrip' 'scalp'};
cfg.spmversion   = 'spm8';
cfg.template     = 'C:\SPM\SPM8\spm8\templates\T1.nii';
cfg.smooth       = 'no';
cfg.downsample   = 1;
cfg.coordsys     = 'spm';
cfg.units        = 'mm';
seg_template_mri = ft_volumesegment(cfg, template_mri);

% build a volume conduction model 
cfg               = [];
cfg.method        = 'singleshell';
template_vol      = ft_prepare_headmodel(cfg, seg_template_mri);
 
% construct the dipole grid in the template brain coordinates
% the source units are in cm
% the negative inwardshift means an outward shift of the brain surface for inside/outside detection
cfg = [];
cfg.grid.xgrid  = 'auto';
cfg.grid.ygrid  = 'auto';
cfg.grid.zgrid  = 'auto';
% cfg.inwardshift = -1.5;
cfg.grid.tight = 'yes';
cfg.grid.resolution = 1;
cfg.grad            = data.grad;
% cfg.sourceunits     = 'cm';
cfg.vol        = template_vol;
template_grid  = ft_prepare_sourcemodel(cfg);
 
% make a figure with the template head model and dipole grid
figure
subplot(1,3,1); ft_plot_vol(template_vol);
subplot(1,3,2); ft_plot_mesh(template_grid);
subplot(1,3,3); ft_plot_mesh(template_grid); hold on; ft_plot_vol(template_vol);

save('C:\RESONANCE_MEG\DATA\pe110338\anat\TEMPLATE_GRID.mat','template_grid','template_vol');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% make the SUBJECT GRID %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
% read the single subject anatomical MRI
subject_mri = ft_read_mri('C:\RESONANCE_MEG\DATA\pe110338\anat\anat_subject2_3T_neurospin.img');

% segment the anatomical MRI
cfg = [];
cfg.output      = {'tpm' 'brain' 'skull' 'skullstrip' 'scalp'};
cfg.spmversion  = 'spm8';
cfg.template    = 'C:\SPM\SPM8\spm8\templates\T1.nii';
cfg.smooth      = 'no';
cfg.downsample  = 1;
cfg.coordsys    = 'spm';
cfg.units       = 'mm';
seg_subject_mri = ft_volumesegment(cfg, subject_mri);
 
% this is a good moment to check whether your segmented volumes are correctly 
% aligned with the anatomical scan (see below) 
 
% construct volume conductor model (i.e. head model) for each subject
% this is optional, you can also use another model, e.g. a single sphere model
cfg = [];
cfg.method = 'singleshell';
cfg.sourceunits = 'mm';
subject_vol = ft_prepare_singleshell(cfg, seg_subject_mri);
 
% create the subject specific grid, using the template grid that has just been created
cfg = [];
cfg.grid.warpmni    = 'yes';
cfg.grid.template   = template_grid;
cfg.grid.nonlinear  = 'yes'; % use non-linear normalization
subject_mri.unit    = 'mm';
cfg.mri             = subject_mri;
cfg.grid.resolution = 10;
cfg.sourceunits     = 'mm';
subject_grid        = ft_prepare_sourcemodel(cfg);

% make a figure of the single subject headmodel, and grid positions
figure;
ft_plot_vol(subject_vol, 'edgecolor', 'none'); alpha 0.4;
ft_plot_mesh(subject_grid.pos(subject_grid.inside,:));

% compute test frequency data
load(['C:\RESONANCE_MEG\DATA\pe110338\processed\run1_100_stimfreq.mat']);

cfg                    = [];
cfg.method             = 'mtmfft';
cfg.channel            = 'MEG*1';
cfg.channelcmb         = {'MEG*1' 'MEG*1'};
cfg.taper              = 'hanning';
cfg.output             = 'powandcsd';
cfg.taper              = 'dpss';
cfg.foi                = 1:1:20;
cfg.tapsmofrq          = 1;
cfg.trials             = 'all';
cfg.keeptrials         = 'no';
cfg.polyremoval        = 0;
FREQ                   = ft_freqanalysis(cfg,DATA);

% sourceanalysis step
cfg              = []; 
cfg.method       = 'dics';
cfg.frequency    = 10;  
cfg.grid         = subject_grid; 
cfg.vol          = subject_vol;
cfg.reducerank   = 2;
cfg.normalize    = 'yes';

source           = ft_sourceanalysis(cfg, FREQ);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% load native mri
mri = ft_read_mri('C:\RESONANCE_MEG\DATA\pe110338\anat\anat_subject2_3T_neurospin.img');

% % realign in 'ctf-like' coordinates
% cfg = [];
% cfg.method = 'interactive';
% mri_realign = ft_volumerealign(cfg, mri);
% realign_segmentedmri  = ft_volumesegment(cfg, mri_realign);

%% segment subject mri
cfg = [];
cfg.output      = {'tpm' 'brain' 'skull' 'skullstrip' 'scalp'};
cfg.spmversion  = 'spm8';
cfg.template    = 'C:\SPM\SPM8\spm8\templates\T1.nii';
cfg.smooth      = 'no';
cfg.downsample  = 1;
cfg.coordsys    = 'spm';
cfg.units       = 'mm';
segmentedmri  = ft_volumesegment(cfg, mri);

%% check segmentation consistency
segmentedmri.transform = mri.transform;
segmentedmri.anatomy   = mri.anatomy;
figure
cfg = [];
ft_sourceplot(cfg,segmentedmri); %only mri
figure
cfg.funparameter = 'gray';
ft_sourceplot(cfg,segmentedmri); %segmented gray matter on top
figure
cfg.funparameter = 'white';
ft_sourceplot(cfg,segmentedmri); %segmented white matter on top
figure
cfg.funparameter = 'csf';
ft_sourceplot(cfg,segmentedmri); %segmented csf matter on top

%% prepare the head model from the segmented brain surface:
cfg = [];
cfg.method = 'singleshell';
vol = ft_prepare_headmodel(cfg, segmentedmri);

%% check heal model consistency
figure;
ft_plot_vol(vol, 'edgecolor', 'k'); alpha 0.4;

%% compute test frequency data
load(['C:\RESONANCE_MEG\DATA\pe110338\processed\run1_100_stimfreq.mat']);

cfg                    = [];
cfg.method             = 'mtmfft';
cfg.channel            = 'MEG*1';
cfg.channelcmb         = {'MEG*1' 'MEG*1'};
cfg.taper              = 'hanning';
cfg.output             = 'powandcsd';
cfg.taper              = 'dpss';
cfg.foi                = 1:1:20;
cfg.tapsmofrq          = 1;
cfg.trials             = 'all';
cfg.keeptrials         = 'no';
cfg.polyremoval        = 0;
FREQ                   = ft_freqanalysis(cfg,DATA);

%% pre-compute leadfield
cfg                 = [];
% cfg.grad            = FREQ.grad;
cfg.vol             = vol;
cfg.reducerank      = 2;
cfg.channel         = {'MEG'};
cfg.grid.resolution = 1;   % use a 3-D grid with a 1 cm resolution
[grid] = ft_prepare_leadfield(cfg,FREQ);
ft_plot_mesh(grid);

%% source power calculation
cfg              = []; 
cfg.method       = 'dics';
cfg.frequency    = 12;  
cfg.grid         = grid; 
cfg.vol          = vol;
cfg.reducerank   = 2;
cfg.normalize    = 'yes';

source           = ft_sourceanalysis(cfg, FREQ);

%% adjust sources with mri anatomy
mri.unit = 'mm';
mri = ft_volumereslice([], mri);

cfg            = [];
cfg.downsample = 2;
cfg.parameter = 'avg.pow';
sourceInterp  = ft_sourceinterpolate(cfg,source,mri);

%% plot result
cfg              = [];
cfg.method       = 'slice';
cfg.funparameter = 'avg.pow';
figure
ft_sourceplot(cfg,sourceInterp);

% here we have the centerd noise bias

load(['C:\RESONANCE_MEG\DATA\pe110338\processed\run1_100_baseline.mat']);

cfg                    = [];
cfg.method             = 'mtmfft';
cfg.channel            = 'MEG*1';
cfg.channelcmb         = {'MEG*1' 'MEG*1'};
cfg.taper              = 'hanning';
cfg.output             = 'powandcsd';
cfg.taper              = 'dpss';
cfg.foi                = 1:1:20;
cfg.tapsmofrq          = 1;
cfg.trials             = 'all';
cfg.keeptrials         = 'no';
cfg.polyremoval        = 0;
FREQb                  = ft_freqanalysis(cfg,DATA);

%% source power calculation
cfg              = []; 
cfg.method       = 'dics';
cfg.frequency    = 12;  
cfg.grid         = grid; 
cfg.vol          = vol;
cfg.reducerank   = 2;
cfg.normalize    = 'yes';

sourceb           = ft_sourceanalysis(cfg, FREQb);

cfg            = [];
cfg.downsample = 2;
cfg.parameter = 'avg.pow';
sourceInterpb  = ft_sourceinterpolate(cfg,sourceb,mri);

sourcediff = source;
sourcediff.avg.pow = (source.avg.pow - sourceb.avg.pow)./ sourceb.avg.pow;

%% plot diff overlay
cfg            = [];
cfg.downsample = 2;
cfg.parameter = 'avg.pow';
sourcediffInterp  = ft_sourceinterpolate(cfg,sourcediff,mri);

cfg              = [];
cfg.method       = 'ortho';
cfg.interactive   = 'yes';
cfg.funparameter = 'avg.pow';
figure
ft_sourceplot(cfg,sourcediffInterp);

%% 3D overlay
cfg = [];
cfg.method         = 'surface';
cfg.funparameter   = 'avg.pow';
cfg.anaparameter   = 'anatomy';
cfg.maskparameter  = cfg.funparameter;
cfg.sourceunits    = 'mm';
cfg.mriunits       = 'mm';
cfg.surffile       = 'C:\FIELDTRIP\fieldtrip-20120402\template\anatomy\single_subj_T1.mat';
%                 cfg.surffile       = '/neurospin/local/fieldtrip/template/surface_l4_both.mat';
cfg.surfdownsample = 1;
cfg.projmethod     = 'nearest';
cfg.distmat        = [];
cfg.camlight       = 'no';
cfg.renderer       = 'opengl';
%                 cfg.funcolorlim    = 'zeromax';
%                 cfg.funcolormap    = 'hot';
%                 cfg.opacitylim     = 'zeromax';
%                 cfg.opacitymap     = 'rampup';
cfg.funcolorlim    = [-0.5 0.5];
cfg.funcolormap    = 'jet';
cfg.opacitylim     = 'maxabs';
cfg.opacitymap     = 'vdown';
cfg.colorbar       = 'no';

figure
ft_sourceplot(cfg,sourcediffInterp);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% try to restrcit sources to gray matter

cfg = [];
cfg.parameter = 'gray';
cfg.smooth = 10; % or some other value
cfg.downsample = 5; % downsample with a factor of 5
seg = ft_volumedownsample(cfg, segmentedmri);

% create a dipole grid
[X,Y,Z] = ndgrid(1:seg.dim(1), 1:seg.dim(2), 1:seg.dim(3));

grid = [];
grid.pos = warp_apply(seg.transform, [X(:) Y(:) Z(:)]); clear X Y Z
grid.dim = seg.dim;
grid.inside = find(seg.gray>0.5); % the threshold value needs to be verified, you can play with the value
grid.outside = find(seg.gray<=0.5);

grid = ft_convert_units(grid, 'cm'); % I assume that the sensors are defined in cm.
ft_plot_mesh(grid);
%% then recompute sources

%% source power calculation
cfg              = []; 
cfg.method       = 'dics';
cfg.frequency    = 12;  
cfg.grid         = grid; 
cfg.vol          = vol;
cfg.reducerank   = 2;
cfg.normalize    = 'yes';

source            = ft_sourceanalysis(cfg, FREQ );
sourceb           = ft_sourceanalysis(cfg, FREQb);

sourcediff = source;
sourcediff.avg.pow = (source.avg.pow - sourceb.avg.pow)./ sourceb.avg.pow;

%% plot diff overlay
cfg            = [];
cfg.downsample = 2;
cfg.parameter = 'avg.pow';
sourcediffInterp  = ft_sourceinterpolate(cfg,sourcediff,mri);

cfg              = [];
cfg.method       = 'ortho';
cfg.interactive   = 'yes';
cfg.funparameter = 'avg.pow';
figure
ft_sourceplot(cfg,sourcediffInterp);

%% 3D

cfg = [];
cfg.method         = 'surface';
cfg.funparameter   = 'avg.pow';
cfg.anaparameter   = 'anatomy';
cfg.maskparameter  = cfg.funparameter;
cfg.sourceunits    = 'mm';
cfg.mriunits       = 'mm';
cfg.surffile       = 'C:\FIELDTRIP\fieldtrip-20120402\template\anatomy\single_subj_T1.mat';
%                 cfg.surffile       = '/neurospin/local/fieldtrip/template/surface_l4_both.mat';
cfg.surfdownsample = 1;
cfg.projmethod     = 'nearest';
cfg.distmat        = [];
cfg.camlight       = 'no';
cfg.renderer       = 'opengl';
%                 cfg.funcolorlim    = 'zeromax';
%                 cfg.funcolormap    = 'hot';
%                 cfg.opacitylim     = 'zeromax';
%                 cfg.opacitymap     = 'rampup';
cfg.funcolorlim    = [-0.5 0.5];
cfg.funcolormap    = 'jet';
cfg.opacitylim     = 'maxabs';
cfg.opacitymap     = 'vdown';
cfg.colorbar       = 'no';

figure
ft_sourceplot(cfg,sourcediffInterp);


