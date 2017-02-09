function resonance_process_anat(nip)

addpath('C:\FIELDTRIP\fieldtrip-20120402')
ft_defaults

% load T1 MRI
mri = ft_read_mri('C:\RESONANCE_MEG\DATA\pe110338\anat\ptk_server_task_2\spe1103382797-0006-00001-000160-01.hdr');

% realign in CTF coordinates
cfg=[];
cfg.method = 'interactive';
mri_ctf = ft_volumerealign(cfg, mri);

% reslicing for fressurfer convention
cfg            = [];
cfg.resolution = 1;
cfg.dim        = [256 256 256];
mrirs          = ft_volumereslice(cfg, mri_ctf);

% segment mri
cfg           = [];
cfg.coordsys  = 'ctf';
cfg.output    = {'skullstrip' 'brain'};
seg           = ft_volumesegment(cfg, mrirs);

% realign in talairach convention
cfg        = [];
cfg.method = 'interactive';
mri_tal    = ft_volumerealign(cfg, mrirs);

% ensure that the skull-stripped anatomy is expressed in the same coordinate system as the anatomy
seg.transform = mri_tal.transform;

% save both the original anatomy, and the masked anatomy in a freesurfer compatible format
cfg             = [];
cfg.filename    = ['C:\RESONANCE_MEG\DATA\' nip '\anat\processed_mri'];
cfg.filetype    = 'nifti';
cfg.parameter   = 'anatomy';
ft_volumewrite(cfg, mri_tal);

cfg.filename    = ['C:\RESONANCE_MEG\DATA\' nip '\anat\processed_mri_masked'];
ft_volumewrite(cfg, seg);

