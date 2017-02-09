%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%% BASIC INTEGRATION BATCH FT TO SPM12 %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all

% launch SPM12b manually!!! if not, it won't work (???)
spm('defaults', 'eeg');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%% PREPROCESSED AND EPOCHED FT DATA CONVERSION %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% get lists of data paths
Directory = 'C:\RESONANCE_MEG\SPM_analysis\Subjects';
list_sub  = {'cb100118';'cd100449';'nr110115';'ns110383';'pe110338'};
list_cond = {'face';'place';'object'};

for i = 1:length(list_sub)
    for j = 1:length(list_cond)
        
        % go in subject data folder
        cd([Directory '\' list_sub{i} '\FT2SPM_data']);
        
        % load dataset of interest
        filepath = [Directory '\' list_sub{i} '\FT2SPM_data\localizer_' list_cond{j} '.mat'];
        data = load(filepath);
        
        if isfield(data,'data') == 1
            % here you need to provide both the data loaded and the path as spm will update the content of the file
            D = spm_eeg_ft2spm(data.data,filepath);
            save([Directory '\' list_sub{i} '\FT2SPM_data\localizer_' list_cond{j} '_converted.mat'],'D');
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%% BASELINE CORRECTION AND AVERAGING %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Directory = 'C:\RESONANCE_MEG\SPM_analysis\Subjects';
list_sub  = {'cb100118';'cd100449';'nr110115';'ns110383';'pe110338'};
list_cond = {'face';'place';'object'};

for i = 1:length(list_sub)
    for j = 1:length(list_cond)
        
        clear matlabbatch
        
        % go into directory of interest
        cd([Directory '\' list_sub{i} '\FT2SPM_data']);
        
        % Batch system initialization
        spm_jobman('initcfg')
        
        % Add additional spatial informations on channels lost at the conversion step
        matlabbatch{1}.spm.meeg.preproc.prepare.D = {[Directory '\' list_sub{i} '\FT2SPM_data\localizer_' list_cond{j} '_converted.mat']};
        matlabbatch{1}.spm.meeg.preproc.prepare.task{1}.project3dMEG = 1;
        matlabbatch{1}.spm.meeg.preproc.prepare.task{2}.loadmegsens.rawmeg = {'C:\RESONANCE_MEG\FT_analysis\DATA\MEG\cb100118\trans_sss\localizer_raw_trans_sss.fif'};  % any raw .fif file will be ok!
        
        % baseline correction
        matlabbatch{2}.spm.meeg.preproc.bc.D = {[Directory '\' list_sub{i} '\FT2SPM_data\localizer_' list_cond{j} '_converted.mat']};
        matlabbatch{2}.spm.meeg.preproc.bc.timewin = [0 230];
        matlabbatch{2}.spm.meeg.preproc.bc.prefix = 'b';
        
        % write scalp x time "scans" for subject level stats
        matlabbatch{3}.spm.meeg.images.convert2images.D = {[Directory '\' list_sub{i} '\FT2SPM_data\blocalizer_' list_cond{j} '_converted.mat']};
        matlabbatch{3}.spm.meeg.images.convert2images.mode = 'scalp x time';
        matlabbatch{3}.spm.meeg.images.convert2images.conditions = {list_cond(j)};
        matlabbatch{3}.spm.meeg.images.convert2images.channels{1}.type = 'MEGMAG';
        matlabbatch{3}.spm.meeg.images.convert2images.timewin = [-Inf Inf];
        matlabbatch{3}.spm.meeg.images.convert2images.freqwin = [-Inf Inf];
        matlabbatch{3}.spm.meeg.images.convert2images.prefix = '';

        % trial robust averaging
        matlabbatch{4}.spm.meeg.averaging.average.D = {[Directory '\' list_sub{i} '\FT2SPM_data\blocalizer_' list_cond{j} '_converted.mat']};
        matlabbatch{4}.spm.meeg.averaging.average.userobust.robust.ks = 3;
        matlabbatch{4}.spm.meeg.averaging.average.userobust.robust.bycondition = false;
        matlabbatch{4}.spm.meeg.averaging.average.userobust.robust.savew = false;
        matlabbatch{4}.spm.meeg.averaging.average.plv = false;
        matlabbatch{4}.spm.meeg.averaging.average.prefix = 'm';

        % display results in GUI (optionnal)
        matlabbatch{5}.spm.meeg.other.review.D(1) = cfg_dep('Averaging: Averaged Datafile', substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','Dfname'));
       
        % delete intermediate files (optional)
        matlabbatch{6}.spm.meeg.other.delete.D(1) = cfg_dep('Baseline correction: Baseline corrected M/EEG datafile', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','Dfname'));
        
        % execute batch
        spm_jobman('run',matlabbatch)
        
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%% SUBJECT-LEVEL SENSOR SPACE STATS %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% currently juste in batch mode due to the large number of scans

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%% MRI COREGISTRATION, FORWARD MODELLING %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% get lists of data paths
Directory = 'C:\RESONANCE_MEG\SPM_analysis\Subjects';
list_sub  = {'cb100118';'cd100449';'nr110115';'ns110383';'pe110338'};
list_cond = {'face';'place';'object'};
list_mri  = {'scb1001182664-0002-00001-000160-01.img';...
    'scd1004492988-0002-00001-000160-01.img';...
    'snr1101152600-0002-00001-000160-01.img';...
    'sns1103832976-0002-00001-000160-01.img';...
    'spe1103382797-0006-00001-000160-01.img'};
fidnas_list = {[-8.2 107.5 -17.4];...
    [-7.2 121.1 -30.2];...
    [4.1  125.8 -7.5 ];...
    [-4.1 116.6 -14.9];...
    [ 0.7 116.9 -10.0]};
fidlpa_list = {[-66.2 12.7 -33.2];...
    [-72.0 16.5 -43.5];...
    [-71.0 23.3 -28.1];...
    [-74.1 13.0 -25.2];...
    [-73.4 16.4 -32.6]};
fidrpa_list = {[63.3 16.6 -29.9];...
    [64.8 21.6 -45.6];...
    [77.1 22.2 -21.9];...
    [69.9 21.2 -27.3];...
    [66.5 19.5 -33.7]};

% compute a model for each subject
for i = 1:length(list_sub)
    
    clear matlabbatch
    
    % go into directory of interest
    cd([Directory '\' list_sub{i} '\FT2SPM_data']);
    
    % Batch system initialization
    spm_jobman('initcfg')
    
    % MEG dataset specification (to get spatial information only)
    matlabbatch{1}.spm.meeg.source.headmodel.D = {
            ['C:\RESONANCE_MEG\SPM_analysis\Subjects\' list_sub{i} '\FT2SPM_data\mblocalizer_place_converted.mat']
            ['C:\RESONANCE_MEG\SPM_analysis\Subjects\' list_sub{i} '\FT2SPM_data\mblocalizer_object_converted.mat']
            ['C:\RESONANCE_MEG\SPM_analysis\Subjects\' list_sub{i} '\FT2SPM_data\mblocalizer_face_converted.mat']
            };
    matlabbatch{1}.spm.meeg.source.headmodel.val = 1;
    matlabbatch{1}.spm.meeg.source.headmodel.comment = '';
    
    % structural MRI specification
    matlabbatch{1}.spm.meeg.source.headmodel.meshing.meshes.mri = {['C:\RESONANCE_MEG\FT_analysis\DATA\MRI\' list_sub{i} '_analyze\' list_mri{i} ',1']};
    matlabbatch{1}.spm.meeg.source.headmodel.meshing.meshres = 3;
    
    % fiducial points specification (coordinate exploration aloowed by "display" interplace with the GUI)
    matlabbatch{1}.spm.meeg.source.headmodel.coregistration.coregspecify.fiducial(1).fidname = 'Nasion';
    matlabbatch{1}.spm.meeg.source.headmodel.coregistration.coregspecify.fiducial(1).specification.type = fidnas_list{i};
    matlabbatch{1}.spm.meeg.source.headmodel.coregistration.coregspecify.fiducial(2).fidname = 'LPA';
    matlabbatch{1}.spm.meeg.source.headmodel.coregistration.coregspecify.fiducial(2).specification.type = fidlpa_list{i};
    matlabbatch{1}.spm.meeg.source.headmodel.coregistration.coregspecify.fiducial(3).fidname = 'RPA';
    matlabbatch{1}.spm.meeg.source.headmodel.coregistration.coregspecify.fiducial(3).specification.type = fidrpa_list{i};
    matlabbatch{1}.spm.meeg.source.headmodel.coregistration.coregspecify.useheadshape = 1;
    
    % specify forward model
    matlabbatch{1}.spm.meeg.source.headmodel.forward.eeg = 'EEG BEM';
    matlabbatch{1}.spm.meeg.source.headmodel.forward.meg = 'Single Shell';
    
    % execute batch
    spm_jobman('run',matlabbatch)
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%% INVERSE MODELLING, IMAGES WRITING %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% get lists of data paths
Directory = 'C:\RESONANCE_MEG\SPM_analysis\Subjects';
list_sub  = {'cb100118';'cd100449';'nr110115';'ns110383';'pe110338'};
list_cond = {'face';'place';'object'};

for i = 1:length(list_sub)
    for j = 1:length(list_cond)
        
        clear matlabbatch
        
        % Batch system initialization
        spm_jobman('initcfg')
        
        % go into directory of interest
        cd([Directory '\' list_sub{i} '\FT2SPM_data']);
        
        % inverse model
        matlabbatch{1}.spm.meeg.source.invert.D = {
            ['C:\RESONANCE_MEG\SPM_analysis\Subjects\' list_sub{i} '\FT2SPM_data\mblocalizer_place_converted.mat']
            ['C:\RESONANCE_MEG\SPM_analysis\Subjects\' list_sub{i} '\FT2SPM_data\mblocalizer_object_converted.mat']
            ['C:\RESONANCE_MEG\SPM_analysis\Subjects\' list_sub{i} '\FT2SPM_data\mblocalizer_face_converted.mat']
            };
        matlabbatch{1}.spm.meeg.source.invert.val = 1;
        matlabbatch{1}.spm.meeg.source.invert.whatconditions.all = 1;
        matlabbatch{1}.spm.meeg.source.invert.isstandard.standard = 1;
        matlabbatch{1}.spm.meeg.source.invert.modality = {
            'MEG'
            'MEGPLANAR'
            }';
        
        % write image of evoked field in source space for subjects & conditions of interest
        % (useful for 2nd-level statistical anlysis)
        % exemple here: M100 ERF
        matlabbatch{2}.spm.meeg.source.results.D(1) = cfg_dep('Source inversion: M/EEG dataset(s) after imaging source reconstruction', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','D'));
        matlabbatch{2}.spm.meeg.source.results.val = 1;
        matlabbatch{2}.spm.meeg.source.results.woi = [310 350];
        matlabbatch{2}.spm.meeg.source.results.foi = [1 40];
        matlabbatch{2}.spm.meeg.source.results.ctype = 'evoked';
        matlabbatch{2}.spm.meeg.source.results.space = 1;
        matlabbatch{2}.spm.meeg.source.results.format = 'image';
        matlabbatch{2}.spm.meeg.source.results.smoothing = 8;
        
        % exemple here: M170 ERF
        matlabbatch{3}.spm.meeg.source.results.D(1) = cfg_dep('Source inversion: M/EEG dataset(s) after imaging source reconstruction', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','D'));
        matlabbatch{3}.spm.meeg.source.results.val = 1;
        matlabbatch{3}.spm.meeg.source.results.woi = [390 410];
        matlabbatch{3}.spm.meeg.source.results.foi = [1 40];
        matlabbatch{3}.spm.meeg.source.results.ctype = 'evoked';
        matlabbatch{3}.spm.meeg.source.results.space = 1;
        matlabbatch{3}.spm.meeg.source.results.format = 'image';
        matlabbatch{3}.spm.meeg.source.results.smoothing = 8;
        
        % execute batch
        spm_jobman('run',matlabbatch)
        
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% 2nd-LEVEL INFERENCE (ANOVA BETWEEN SUBJECTS) %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear matlabbatch

% Batch system initialization
spm_jobman('initcfg')

% go into directory of interest
cd('C:\RESONANCE_MEG\SPM_analysis\Group');

matlabbatch{1}.spm.stats.factorial_design.dir = {'C:\RESONANCE_MEG\SPM_analysis\Group'};
matlabbatch{1}.spm.stats.factorial_design.des.anova.icell(1).scans = {
                                                                      'C:\RESONANCE_MEG\SPM_analysis\Subjects\cb100118\FT2SPM_data\mblocalizer_face_converted_1_t310_350_f1_40_1.nii,1'
                                                                      'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\FT2SPM_data\mblocalizer_face_converted_1_t310_350_f1_40_1.nii,1'
                                                                      'C:\RESONANCE_MEG\SPM_analysis\Subjects\nr110115\FT2SPM_data\mblocalizer_face_converted_1_t310_350_f1_40_1.nii,1'
                                                                      'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\FT2SPM_data\mblocalizer_face_converted_1_t310_350_f1_40_1.nii,1'
                                                                      'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\FT2SPM_data\mblocalizer_face_converted_1_t310_350_f1_40_1.nii,1'
                                                                      };
matlabbatch{1}.spm.stats.factorial_design.des.anova.icell(2).scans = {
                                                                      'C:\RESONANCE_MEG\SPM_analysis\Subjects\cb100118\FT2SPM_data\mblocalizer_place_converted_1_t310_350_f1_40_1.nii,1'
                                                                      'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\FT2SPM_data\mblocalizer_place_converted_1_t310_350_f1_40_1.nii,1'
                                                                      'C:\RESONANCE_MEG\SPM_analysis\Subjects\nr110115\FT2SPM_data\mblocalizer_place_converted_1_t310_350_f1_40_1.nii,1'
                                                                      'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\FT2SPM_data\mblocalizer_place_converted_1_t310_350_f1_40_1.nii,1'
                                                                      'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\FT2SPM_data\mblocalizer_place_converted_1_t310_350_f1_40_1.nii,1'
                                                                      };
matlabbatch{1}.spm.stats.factorial_design.des.anova.dept = 0;
matlabbatch{1}.spm.stats.factorial_design.des.anova.variance = 1;
matlabbatch{1}.spm.stats.factorial_design.des.anova.gmsca = 0;
matlabbatch{1}.spm.stats.factorial_design.des.anova.ancova = 0;
matlabbatch{1}.spm.stats.factorial_design.cov = struct('c', {}, 'cname', {}, 'iCFI', {}, 'iCC', {});
matlabbatch{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;
matlabbatch{1}.spm.stats.factorial_design.masking.im = 1;
matlabbatch{1}.spm.stats.factorial_design.masking.em = {''};
matlabbatch{1}.spm.stats.factorial_design.globalc.g_omit = 1;
matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = 1;

matlabbatch{2}.spm.stats.fmri_est.spmmat(1) = cfg_dep('Factorial design specification: SPM.mat File', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1;

matlabbatch{3}.spm.stats.con.spmmat(1) = cfg_dep('Model estimation: SPM.mat File', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{3}.spm.stats.con.consess{1}.tcon.name = 'FACE - PLACE';
matlabbatch{3}.spm.stats.con.consess{1}.tcon.weights = [-1 1];
matlabbatch{3}.spm.stats.con.consess{2}.tcon.name = 'PLACE - FACE';
matlabbatch{3}.spm.stats.con.consess{2}.tcon.weights = [1 -1];
matlabbatch{3}.spm.stats.con.consess{2}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.delete = 0;







