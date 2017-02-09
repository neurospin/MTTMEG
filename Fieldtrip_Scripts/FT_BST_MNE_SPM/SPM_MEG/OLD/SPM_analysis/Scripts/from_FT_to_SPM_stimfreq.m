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
list_run  = {{'run1';'run2'};...
            {'run1';'run2';'run3';'run4'};...
            {'run1';'run2'};...
            {'run1';'run2';'run3';'run4'};...
            {'run1';'run2';'run3';'run4'}};
        
% list_sub  = {'cb100118'};        
% list_run  = {{'run1';'run2'}};        
list_cond = {'50','75','100','150','200','300','400','600'};

for i = 1:length(list_sub)
    for j = 1:length(list_run{i})
        for k = 1:length(list_cond)
            
            % stimfreq
            clear data
            clear D
            
            % go in subject data folder
            cd([Directory '\' list_sub{i} '\TF_data\FT2SPM']);
            
            % load dataset of interest
            filepath = [Directory '\' list_sub{i} '\TF_data\FT2SPM\' char(list_run{i,1}(j)) '_' list_cond{k} '_stimfreq.mat'];
            data = load(filepath);
            
            if isfield(data,'DATA') == 1
                % here you need to provide both the data loaded and the path as spm will update the content of the file
                D = spm_eeg_ft2spm(data.DATA,filepath);
                save([Directory '\' list_sub{i} '\TF_data\FT2SPM\' char(list_run{i,1}(j)) '_' list_cond{k} '_stimfreq_converted.mat'],'D');
            elseif isfield(data,'D') == 1
                clear D
                D = data.D;
                save([Directory '\' list_sub{i} '\TF_data\FT2SPM\' char(list_run{i,1}(j)) '_' list_cond{k} '_stimfreq_converted.mat'],'D');
            end 
            
            % baseline
            clear data
            clear D
            
            % go in subject data folder
            cd([Directory '\' list_sub{i} '\TF_data\FT2SPM']);
            
            % load dataset of interest
            filepath = [Directory '\' list_sub{i} '\TF_data\FT2SPM\' char(list_run{i,1}(j)) '_' list_cond{k} '_baseline.mat'];
            data = load(filepath);
            
            if isfield(data,'DATA') == 1
                % here you need to provide both the data loaded and the path as spm will update the content of the file
                D = spm_eeg_ft2spm(data.DATA,filepath);
                save([Directory '\' list_sub{i} '\TF_data\FT2SPM\' char(list_run{i,1}(j)) '_' list_cond{k} '_baseline_converted.mat'],'D');
            elseif isfield(data,'D') == 1
                clear D
                D = data.D;
                save([Directory '\' list_sub{i} '\TF_data\FT2SPM\' char(list_run{i,1}(j)) '_' list_cond{k} '_baseline_converted.mat'],'D');
            end  
            
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% time-frequency analysis %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% get lists of data paths
Directory = 'C:\RESONANCE_MEG\SPM_analysis\Subjects';
list_sub  = {'cb100118';'cd100449';'nr110115';'ns110383';'pe110338'};
list_run  = {{'run1';'run2'};...
            {'run1';'run2';'run3';'run4'};...
            {'run1';'run2'};...
            {'run1';'run2';'run3';'run4'};...
            {'run1';'run2';'run3';'run4'}};
        
% list_sub  = {'cb100118'};        
% list_run  = {{'run1';'run2'}};        
list_cond = {'50','75','100','150','200','300','400','600'};

for i = 1:length(list_sub)
    for j = 1:length(list_run{i})
        for k = 1:length(list_cond)
            
            clear matlabbatch
            
            % go into directory of interest
            cd([Directory '\' list_sub{i} '\FT2SPM_data']);
            
            % Batch system initialization
            spm_jobman('initcfg')
            
            % Add additional spatial informations on channels lost at the conversion step
            matlabbatch{1}.spm.meeg.preproc.prepare.D = {['C:\RESONANCE_MEG\SPM_analysis\Subjects\' list_sub{i} '\TF_data\FT2SPM\' char(list_run{i,1}(j)) '_' list_cond{k} '_stimfreq_converted.mat']};
            matlabbatch{1}.spm.meeg.preproc.prepare.task{1}.loadmegsens.rawmeg = {'C:\RESONANCE_MEG\FT_analysis\DATA\MEG\cb100118\trans_sss\run1_raw_trans_sss.fif'};
            matlabbatch{1}.spm.meeg.preproc.prepare.task{2}.project3dMEG = 1;
            
            % frequency analysis
            matlabbatch{2}.spm.meeg.tf.tf.D(1) = cfg_dep('Prepare: Prepared Datafile', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','Dfname'));
            matlabbatch{2}.spm.meeg.tf.tf.channels{1}.type = 'MEGMAG';
            matlabbatch{2}.spm.meeg.tf.tf.frequencies = [2:0.5:30];
            matlabbatch{2}.spm.meeg.tf.tf.timewin = [-Inf Inf];
            matlabbatch{2}.spm.meeg.tf.tf.method.mtmconvol.taper = 'hanning';
            matlabbatch{2}.spm.meeg.tf.tf.method.mtmconvol.timeres = 2000;
            matlabbatch{2}.spm.meeg.tf.tf.method.mtmconvol.timestep = 1000;
            matlabbatch{2}.spm.meeg.tf.tf.method.mtmconvol.freqres = 1;
            matlabbatch{2}.spm.meeg.tf.tf.phase = 0;
            matlabbatch{2}.spm.meeg.tf.tf.prefix = 'Stimfreq';

            % write scalp x frequency "scans" 
            matlabbatch{3}.spm.meeg.images.convert2images.D(1) = cfg_dep('Time-frequency analysis: M/EEG time-frequency power dataset', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','Dtfname'));
            matlabbatch{3}.spm.meeg.images.convert2images.mode = 'scalp x frequency';
            matlabbatch{3}.spm.meeg.images.convert2images.conditions = cell(1, 0);
            matlabbatch{3}.spm.meeg.images.convert2images.channels{1}.type = 'MEGMAG';
            matlabbatch{3}.spm.meeg.images.convert2images.timewin = [-Inf Inf];
            matlabbatch{3}.spm.meeg.images.convert2images.freqwin = [-Inf Inf];
            matlabbatch{3}.spm.meeg.images.convert2images.prefix = 'ScXFr_';

            % execute batch
            spm_jobman('run',matlabbatch)
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% get lists of data paths
Directory = 'C:\RESONANCE_MEG\SPM_analysis\Subjects';
list_sub  = {'cb100118';'cd100449';'nr110115';'ns110383';'pe110338'};
list_run  = {{'run1';'run2'};...
            {'run1';'run2';'run3';'run4'};...
            {'run1';'run2'};...
            {'run1';'run2';'run3';'run4'};...
            {'run1';'run2';'run3';'run4'}};
        
% list_sub  = {'cb100118'};        
% list_run  = {{'run1';'run2'}};        
list_cond = {'50','75','100','150','200','300','400','600'};

for i = 1:length(list_sub)
    for j = 1:length(list_run{i})
        for k = 1:length(list_cond)
            
            clear matlabbatch
            
            % go into directory of interest
            cd([Directory '\' list_sub{i} '\FT2SPM_data']);
            
            % Batch system initialization
            spm_jobman('initcfg')
            
            % Add additional spatial informations on channels lost at the conversion step
            matlabbatch{1}.spm.meeg.preproc.prepare.D = {['C:\RESONANCE_MEG\SPM_analysis\Subjects\' list_sub{i} '\TF_data\FT2SPM\' char(list_run{i,1}(j)) '_' list_cond{k} '_baseline_converted.mat']};
            matlabbatch{1}.spm.meeg.preproc.prepare.task{1}.loadmegsens.rawmeg = {'C:\RESONANCE_MEG\FT_analysis\DATA\MEG\cb100118\trans_sss\run1_raw_trans_sss.fif'};
            matlabbatch{1}.spm.meeg.preproc.prepare.task{2}.project3dMEG = 1;
            
            % frequency analysis
            matlabbatch{2}.spm.meeg.tf.tf.D(1) = cfg_dep('Prepare: Prepared Datafile', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','Dfname'));
            matlabbatch{2}.spm.meeg.tf.tf.channels{1}.type = 'MEGMAG';
            matlabbatch{2}.spm.meeg.tf.tf.frequencies = [2:0.5:30];
            matlabbatch{2}.spm.meeg.tf.tf.timewin = [-Inf Inf];
            matlabbatch{2}.spm.meeg.tf.tf.method.mtmconvol.taper = 'hanning';
            matlabbatch{2}.spm.meeg.tf.tf.method.mtmconvol.timeres = 2000;
            matlabbatch{2}.spm.meeg.tf.tf.method.mtmconvol.timestep = 1000;
            matlabbatch{2}.spm.meeg.tf.tf.method.mtmconvol.freqres = 1;
            matlabbatch{2}.spm.meeg.tf.tf.phase = 0;
            matlabbatch{2}.spm.meeg.tf.tf.prefix = 'Stimfreq';

            % write scalp x frequency "scans" 
            matlabbatch{3}.spm.meeg.images.convert2images.D(1) = cfg_dep('Time-frequency analysis: M/EEG time-frequency power dataset', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','Dtfname'));
            matlabbatch{3}.spm.meeg.images.convert2images.mode = 'scalp x frequency';
            matlabbatch{3}.spm.meeg.images.convert2images.conditions = cell(1, 0);
            matlabbatch{3}.spm.meeg.images.convert2images.channels{1}.type = 'MEGMAG';
            matlabbatch{3}.spm.meeg.images.convert2images.timewin = [-Inf Inf];
            matlabbatch{3}.spm.meeg.images.convert2images.freqwin = [-Inf Inf];
            matlabbatch{3}.spm.meeg.images.convert2images.prefix = 'ScXFr_';

            % execute batch
            spm_jobman('run',matlabbatch)
        end
    end
end

