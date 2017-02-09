% FISRT_TRY_SOURCE_FREQ_DICS

clear all
close all

addpath('C:\FIELDTRIP\fieldtrip-20120402');
addpath('C:\RESONANCE_MEG\NEW_SCRIPTS');
ft_defaults

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Co-registration of the source space to the sensor-based head coordinate system
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% mri_nom = ft_read_mri('C:\RESONANCE_MEG\DATA\pe110338\anat\pe110338\mri\orig\001.mgz');
load('C:\RESONANCE_MEG\DATA\pe110338\anat\mri_nom')

% Next, we will coregister the anatomical MRI to the sensor's coordinate system.
% Using ft_volumerealign we now have to specify the location of the fiducials: 'n' (nasion), 'l' (left preauricular point), and 'r' (right preauricular point).

cfg = [];
cfg.method = 'interactive';
mri_nom_ctf = ft_volumerealign(cfg, mri_nom);

% The output mri contains two transformation matrices:
% mri_nom_ctf.transform, which specifies the transformation from voxel space to sensor-based head coordinate system
% mri_nom_ctf.transformorig, which specifies the transformation from voxel space to Talairach space

% To obtain the transformation matrix that goes from Talairach space to sensor-based head coordinate system,
% we need to combine the two matrices. After the matrices have been combined, we will apply this transformation to the source positions.
% In addition, we want the positions of the sources to be expressed in the same units as the MEG-sensors. 
% For our data this needs to be in 'cm'. Therefore, we have to adjust the units of the geometrical objects accordingly.

mri_nom_ctf = ft_convert_units(mri_nom_ctf, 'cm'); % here I modified the function because of a bug of ft_senstype
T   = mri_nom_ctf.transform*inv(mri_nom_ctf.transformorig);

% go to the Subject/bem directory
bnd  = ft_read_headshape('C:\RESONANCE_MEG\DATA\pe110338\anat\pe110338\bem\pe110338-oct-6-src.fif', 'format', 'mne_source');
sourcespace = ft_convert_units(bnd, 'cm');
sourcespace = ft_transform_geometry(T, sourcespace);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Volume conduction model
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% mri_nom = ft_read_mri('C:\RESONANCE_MEG\DATA\pe110338\anat\pe110338\mri\orig\001.mgz');
load('C:\RESONANCE_MEG\DATA\pe110338\anat\mri_nom')

cfg           = [];
cfg.coordsys  = 'spm'; 
cfg.output    = {'brain'};
seg           = ft_volumesegment(cfg, mri_nom);

cfg           = [];
vol           = ft_prepare_singleshell(cfg,seg);
vol.bnd       = ft_transform_geometry(T, vol.bnd);

figure; hold on;
ft_plot_vol(vol, 'facecolor', 'none');alpha 0.5; 
ft_plot_mesh(sourcespace, 'edgecolor', 'none'); camlight

% test handmade modif just to finish the test
sourcespace_bis      = sourcespace;
sourcespace_bis.pnt(:,1) = sourcespace_bis.pnt(:,1) + ones(length(sourcespace_bis.pnt),1)*3;

figure; hold on;
ft_plot_vol(vol, 'facecolor', 'none');alpha 0.5; 
ft_plot_mesh(sourcespace_bis, 'edgecolor', 'none'); camlight

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% compute forward solution
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load('C:\RESONANCE_MEG\DATA\pe110338\processed\run1_100_stimfreq.mat')
[Grads1,Grads2,Mags]   = grads_for_layouts('Laptop');

cfg                    = [];
cfg.method             = 'mtmfft';
cfg.channel            = Grads1;
cfg.channelcmb         = {Grads1 Grads1};
cfg.taper              = 'hanning';
cfg.output             = 'powandcsd';
cfg.taper              = 'dpss';
cfg.foi                = 1:0.5:95;
cfg.tapsmofrq          = 1;
cfg.trials             = 'all';
cfg.keeptrials         = 'no';
cfg.polyremoval        = 0;
FREQ                   = ft_freqanalysis(cfg,DATA);

load('C:\RESONANCE_MEG\DATA\pe110338\processed\run1_100_baseline.mat')

cfg                    = [];
cfg.method             = 'mtmfft';
cfg.channel            = Grads1;
cfg.channelcmb         = {Grads1 Grads1};
cfg.taper              = 'hanning';
cfg.output             = 'powandcsd';
cfg.taper              = 'dpss';
cfg.foi                = 1:0.5:95;
cfg.tapsmofrq          = 1;
cfg.trials             = 'all';
cfg.keeptrials         = 'no';
cfg.polyremoval        = 0;
FREQb                  = ft_freqanalysis(cfg,DATA);

cfg                    = [];
cfg.grad               = FREQ.grad;                  % sensor positions
cfg.channel            = Grads1;                     % the used channels
cfg.grid.pos           = sourcespace.pnt;            % source points
cfg.grid.inside        = 1:size(sourcespace.pnt,1);  % all source points are inside of the brain
cfg.vol                = vol;                        % volume conduction model
leadfield              = ft_prepare_leadfield(cfg);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% compute inverse solution
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cfg              = []; 
cfg.method       = 'pcc';
cfg.frequency    = 5;  
cfg.grid         = leadfield; 
cfg.vol          = vol;
cfg.reducerank   = 2;
cfg.normalize    = 'yes';

source           = ft_sourceanalysis(cfg, FREQ);
source           = ft_sourcedescriptives([],source);
sourceb          = ft_sourceanalysis(cfg, FREQb);
sourceb          = ft_sourcedescriptives([],sourceb);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% source visualization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

bnd.pnt = sourcespace.pnt;
bnd.tri = sourcespace.tri;

sourcediff = source;
sourcediff.avg.pow = (source.avg.pow - sourceb.avg.pow)./ sourceb.avg.pow;

mysubplot(2,2,1)
m = sourcediff.avg.pow;
ft_plot_mesh(bnd, 'vertexcolor', m,'edgecolor', 'none','facealpha',1);
view(gca,[180 0]);
mysubplot(2,2,2)
m = sourcediff.avg.pow;
ft_plot_mesh(bnd, 'vertexcolor', m,'edgecolor', 'none','facealpha',1);
view(gca,[0 0]);
mysubplot(2,2,3)
m = sourcediff.avg.pow;
ft_plot_mesh(bnd, 'vertexcolor', m,'edgecolor', 'none','facealpha',1);
view(gca,[90 0]);
mysubplot(2,2,4)
m = sourcediff.avg.pow;
ft_plot_mesh(bnd, 'vertexcolor', m,'edgecolor', 'none','facealpha',1);
view(gca,[270 0]);








