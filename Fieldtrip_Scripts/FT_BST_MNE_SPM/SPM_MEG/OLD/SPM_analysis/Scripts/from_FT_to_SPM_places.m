%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CONVERT MEG PREPROCESSED & EPOCHED FIELTRIP DATA INTO SPM FORMAT %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% launch SPM12b
spm('defaults', 'eeg'); 

% load dataset of interest
filepath = 'C:\Users\bgauthie\Desktop\CLEAN_SPM\from_fieldtrip\FT2SPM_data\localizer_place.mat';
load(filepath)

% here you need to provide both the data loaded and the path as spm will update the content of the file
D = spm_eeg_ft2spm(data,filepath);
save('C:\Users\bgauthie\Desktop\CLEAN_SPM\from_fieldtrip\FT2SPM_data\localizer_place_converted.mat','D');

%% ERF computation (code generated from SPM interplace)
% Add additional spatial informations on channels lost at the conversion step
matlabbatch{1}.spm.meeg.preproc.prepare.D = {'C:\Users\bgauthie\Desktop\CLEAN_SPM\from_fieldtrip\FT2SPM_data\localizer_place_converted.mat'};
matlabbatch{1}.spm.meeg.preproc.prepare.task{1}.project3dMEG = 1;
matlabbatch{1}.spm.meeg.preproc.prepare.task{2}.loadmegsens.rawmeg = {'C:\Users\bgauthie\Desktop\CLEAN_SPM\subject1\localizer_raw_trans_sss.fif'};

% baseline correction
matlabbatch{2}.spm.meeg.preproc.bc.D(1) = cfg_dep('Prepare: Prepared Datafile', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','Dfname'));
matlabbatch{2}.spm.meeg.preproc.bc.timewin = [0 250];
matlabbatch{2}.spm.meeg.preproc.bc.prefix = 'b';

% trial robust averaging
matlabbatch{3}.spm.meeg.averaging.average.D(1) = cfg_dep('Baseline correction: Baseline corrected M/EEG datafile', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','Dfname'));
matlabbatch{3}.spm.meeg.averaging.average.userobust.robust.ks = 3;
matlabbatch{3}.spm.meeg.averaging.average.userobust.robust.bycondition = false;
matlabbatch{3}.spm.meeg.averaging.average.userobust.robust.savew = false;
matlabbatch{3}.spm.meeg.averaging.average.plv = false;
matlabbatch{3}.spm.meeg.averaging.average.prefix = 'm';

% display results in GUI (optionnal)
matlabbatch{4}.spm.meeg.other.review.D(1) = cfg_dep('Averaging: Averaged Datafile', substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','Dfname'));
matlabbatch{5}.spm.meeg.other.delete.D(1) = cfg_dep('Baseline correction: Baseline corrected M/EEG datafile', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','Dfname'));

%% Source reconstruction part
% MEG dataset specification
matlabbatch{6}.spm.meeg.source.headmodel.D = {'C:\Users\bgauthie\Desktop\CLEAN_SPM\from_fieldtrip\FT2SPM_data\mblocalizer_place_converted.mat'};
matlabbatch{6}.spm.meeg.source.headmodel.val = 1;
matlabbatch{6}.spm.meeg.source.headmodel.comment = '';

% structural MRI specification
matlabbatch{6}.spm.meeg.source.headmodel.meshing.meshes.mri = {'C:\RESONANCE_MEG\DATA\MRI\cb100118_analyze\scb1001182664-0002-00001-000160-01.img,1'};
matlabbatch{6}.spm.meeg.source.headmodel.meshing.meshres = 3;

% fiducial points specification (coordinate exploration by "display" interplace with the GUI
matlabbatch{6}.spm.meeg.source.headmodel.coregistration.coregspecify.fiducial(1).fidname = 'Nasion';
matlabbatch{6}.spm.meeg.source.headmodel.coregistration.coregspecify.fiducial(1).specification.type = [-8.2 107.5 -17.4];
matlabbatch{6}.spm.meeg.source.headmodel.coregistration.coregspecify.fiducial(2).fidname = 'LPA';
matlabbatch{6}.spm.meeg.source.headmodel.coregistration.coregspecify.fiducial(2).specification.type = [-66.2 12.7 -33.2];
matlabbatch{6}.spm.meeg.source.headmodel.coregistration.coregspecify.fiducial(3).fidname = 'RPA';
matlabbatch{6}.spm.meeg.source.headmodel.coregistration.coregspecify.fiducial(3).specification.type = [63.3 16.6 -29.9];
matlabbatch{6}.spm.meeg.source.headmodel.coregistration.coregspecify.useheadshape = 1;

% specify forward model
matlabbatch{6}.spm.meeg.source.headmodel.forward.eeg = 'EEG BEM';
matlabbatch{6}.spm.meeg.source.headmodel.forward.meg = 'Single Shell';

% inverse model
matlabbatch{7}.spm.meeg.source.invert.D = {'C:\Users\bgauthie\Desktop\CLEAN_SPM\from_fieldtrip\FT2SPM_data\mblocalizer_place_converted.mat'};
matlabbatch{7}.spm.meeg.source.invert.val = 1;
matlabbatch{7}.spm.meeg.source.invert.whatconditions.all = 1;
matlabbatch{7}.spm.meeg.source.invert.isstandard.standard = 1;
matlabbatch{7}.spm.meeg.source.invert.modality = {
                                                  'MEG'
                                                  'MEGPLANAR'
                                                  }';


%% execute batch
spm_jobman('run',matlabbatch)
