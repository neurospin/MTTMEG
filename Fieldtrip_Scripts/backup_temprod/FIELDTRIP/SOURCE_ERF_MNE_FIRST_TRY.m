% FISRT_TRY_SOURCE_FREQ_DICS

clear all
close all

addpath('C:\FIELDTRIP\fieldtrip-20120402');
addpath('C:\RESONANCE_MEG\NEW_SCRIPTS')
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
%% rapid calculation of ERF and covariance matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% compute ERF
face = load('C:\RESONANCE_MEG\DATA\pe110338\processed\localizer_face.mat');

clear cfg
cfg.channel            = 'all';
cfg.trials             = 'all';
cfg.covariance         = 'no';
cfg.keeptrials         = 'no';
cfg.removemean         = 'yes';
cfg.vartrllength       = 2;
ERF_face               = ft_timelockanalysis(cfg,face.data);

cfg.baseline           = [0 0.05];
ERF_face               = ft_timelockbaseline(cfg,ERF_face);

place = load('C:\RESONANCE_MEG\DATA\pe110338\processed\localizer_place.mat');

clear cfg
cfg.channel            = 'all';
cfg.trials             = 'all';
cfg.covariance         = 'no';
cfg.keeptrials         = 'no';
cfg.removemean         = 'yes';
cfg.vartrllength       = 2;
ERF_place               = ft_timelockanalysis(cfg,place.data);

cfg.baseline           = [0 0.05];
ERF_place               = ft_timelockbaseline(cfg,ERF_place);

% compute covariance matrix
[Grads1,Grads2,Mags] = grads_for_layouts('Laptop');

cfg = [];
cfg.channel          = Grads1;
cfg.covariance       = 'yes';
cfg.covariancewindow = [0 0.05];
noisecov_face        = ft_timelockanalysis(cfg, face.data);

cfg = [];
cfg.channel          = Grads1;
cfg.covariance       = 'yes';
cfg.covariancewindow = [0 0.05];
noisecov_place       = ft_timelockanalysis(cfg, place.data);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% compute forward solution
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cfg               = [];
cfg.grad          = face.data.grad;                  % sensor positions
cfg.channel       = Grads1;                     % the used channels
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
invsol_face       = ft_sourceanalysis(cfg,noisecov_face);
invsol_place      = ft_sourceanalysis(cfg,noisecov_place);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% source visualization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

bnd.pnt = sourcespace.pnt;
bnd.tri = sourcespace.tri;

diff = invsol_face;
diff.avg.pow = (invsol_face.avg.pow - invsol_place.avg.pow);
for i = 1:50
    mysubplot(5,10,i)
    m = diff.avg.pow(:,i);
    ft_plot_mesh(bnd, 'vertexcolor', m,'edgecolor', 'none');
    view(gca,[270 0]); title(num2str(diff.time(i)));
end

% diff.tri = sourcespace.tri;
% cfg = [];
% cfg.funparameter  = 'avg.pow';
% % cfg.maskparameter = 'avg.pow';
% ft_sourcemovie(cfg,diff);












