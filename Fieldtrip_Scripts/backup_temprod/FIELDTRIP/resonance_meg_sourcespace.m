function resonance_meg_sourcespace(nip)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Co-registration of the source space to the sensor-based head coordinate system
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% mri_nom = ft_read_mri('C:\RESONANCE_MEG\DATA\pe110338\anat\pe110338\mri\orig\001.mgz');
load(['C:\RESONANCE_MEG\DATA\' nip '\anat\' nip '_mri_nom'])

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
bnd  = ft_read_headshape(['C:\RESONANCE_MEG\DATA\' nip '\anat\' nip '_tuto\bem\' nip '-oct-6-src.fif'], 'format', 'mne_source');
sourcespace = ft_convert_units(bnd, 'cm');
sourcespace = ft_transform_geometry(T, sourcespace);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Volume conduction model
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% mri_nom = ft_read_mri('C:\RESONANCE_MEG\DATA\pe110338\anat\pe110338\mri\orig\001.mgz');
load(['C:\RESONANCE_MEG\DATA\' nip '\anat\' nip '_mri_nom'])

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

%%%%%%%%%%%%%%%%% WARNING : HERE LIES A HUGE PROBLEM - SOLVED %%%%%%%%%%%%%%%%%%%%%%
% % test handmade modif just to finish the test
% sourcespace_bis      = sourcespace;
% sourcespace_bis.pnt(:,1) = sourcespace_bis.pnt(:,1) + ones(length(sourcespace_bis.pnt),1)*3;
% sourcespace = sourcespace_bis;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

view(gca,[180 0]);

save(['C:\RESONANCE_MEG\DATA\' nip '\anat\Sourcespace.mat'],'sourcespace','vol')

print('-dpng',['C:\RESONANCE_MEG\DATA\' nip '\plots\Sourcespace.png']);
