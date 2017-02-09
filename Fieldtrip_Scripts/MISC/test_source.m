% test pipeline make head model woith fieldtrip

close all
clear all

bcktmprd = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/backup_temprod/SCRIPTS';
bcktmprd2 = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/backup_temprod/FIELDTRIP';

addpath('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/fieldtrip-20130901')
addpath(genpath([bcktmprd '/Matlab_pipeline/Ref_functions']));
addpath([bcktmprd '/Matlab_pipeline/My_functions/Preprocessing']);
addpath(bcktmprd2);
addpath('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts');
ft_defaults

%% test akignement, coordinates, etc...
% read anatomical MRI template
% mri                         = ft_read_mri('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/mri/sd130343/mri/T1.mgz');
mri                         = ft_read_mri('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/ssb1203164113-0002-00001-000160-01.img');

% segment brain volume (gray matter, white matter, csf)
cfg                   = [];
cfg.output         = {'skullstrip' 'brain'};
segmentedmri    = ft_volumesegment(cfg, mri);


% align to the inteded coordinate sytem
% it add a transformation matrix but don't change the data itself
cfg                          =[];
cfg.method              = 'interactive';
mrir                          = ft_volumerealign(cfg, segmentedmri);

% prepare headmodel
cfg = [];
cfg.method='singleshell';
vol = ft_prepare_headmodel(cfg, segmentedmri);

% load meg data
fname = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/raw_sss/run1_GD_trans_sss.fif';
sensors = ft_read_sens(fname);

% overlay anatomical surface volume and sensors positions
% check if it match

vol = ft_convert_units(vol,'cm');
figure
ft_plot_sens(sensors, 'style', '*b');
hold on
ft_plot_vol(vol);


%% load anatomical data

% read anatomical MRI template
% template_mri           = ft_read_mri('/i2bm/local/spm8/canonical/single_subj_T1.nii');
mri                         = ft_read_mri('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/ssb1203164113-0002-00001-000160-01.img');
% mri                         = ft_determine_coordsys(mri);

% align to the inteded coordinate sytem
cfg                          =[];
cfg.method              = 'interactive';
% template_mri            = ft_volumerealign(cfg, template_mri);
mri                          = ft_volumerealign(cfg, mri);

% reslicing
% cfg                           = [];
% cfg.resolution            = 1;
% cfg.dim                     = [256 256 256];
% template_mrirs          = ft_volumereslice(cfg, template_mri);
% mrirs                        = ft_volumereslice(cfg, mri);

% segment the template brain and anatomical one
cfg                   = [];
cfg.output         = {'skullstrip' 'brain'};
% segmented_tpmri = ft_volumesegment(cfg, template_mrirs);
segmentedmri    = ft_volumesegment(cfg, mri);

% % optional
% cfg        = [];
% cfg.method = 'interactive';
% mri_tal    = ft_volumerealign(cfg, segmented_mri );

%% read freesurfer result
mri                         = ft_read_mri('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/mri/sd130343/mri/filled.mgz');
cfg = [];
cfg.interactive = 'yes';
figure;ft_sourceplot(cfg, mri);

%% read headshape
bnd = ft_read_headshape('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/mri/sd130343/bem/sd130343-oct-6-src.fif',...
                                       'format', 'mne_source');
figure
ft_plot_mesh(bnd);

%% coregister mri and sensor space
cfg = [];
cfg.method = 'interactive';
mri             = ft_read_mri('/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/Subjects/sub01/t1mri/acquisition1/anat_sd130243_20131029_02.nii');
mri_nom     = ft_volumerealign(cfg, mri);

mri_nom     = ft_convert_units(mri_nom, 'cm');
T                = mri_nom.transform*inv(mri_nom.transformorig);
sourcespace = ft_convert_units(bnd, 'cm');
sourcespace = ft_transform_geometry(T, sourcespace);

% build a volume conduction model 
mri           = ft_read_mri('/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/Subjects/sub01/t1mri/acquisition1/anat_sd130243_20131029_02.nii');

cfg           = [];
cfg.coordsys  = 'spm'; 
cfg.output    = {'brain'};
seg           = ft_volumesegment(cfg, mri_nom);
seg           = ft_convert_units(seg,'cm');

cfg           = [];
cfg.method    = 'singleshell';
vol             = ft_prepare_headmodel(cfg,seg);
% vol             = ft_determine_coordsys(vol);
vol.bnd       = ft_transform_geometry(T, vol.bnd);

% load vol                                       % volume conduction model
figure;hold on;
ft_plot_vol(vol, 'facecolor', 'none');alpha 0.5;
ft_plot_mesh(sourcespace, 'edgecolor', 'none'); camlight












