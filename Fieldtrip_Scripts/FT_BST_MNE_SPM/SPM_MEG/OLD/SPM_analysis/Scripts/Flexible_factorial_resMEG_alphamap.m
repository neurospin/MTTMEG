%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all

% launch SPM12b manually!!! if not, it won't work (???)
spm('defaults', 'eeg');

clear matlabbatch

% go into directory of interest
cd('C:\RESONANCE_MEG\SPM_analysis\Group\TF_TuningModel1')

% Batch system initialization
spm_jobman('initcfg')

matlabbatch{1}.spm.stats.factorial_design.dir = {'C:\RESONANCE_MEG\SPM_analysis\Group\TF_AlphaModel1'};
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(1).name = 'StimAlpha';
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(1).dept = 1;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(1).variance = 0;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(1).gmsca = 0;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(1).ancova = 0;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(2).name = 'subject';
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(2).dept = 0;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(2).variance = 0;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(2).gmsca = 0;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(2).ancova = 0;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(3).name = 'repl';
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(3).dept = 1;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(3).variance = 0;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(3).gmsca = 0;
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fac(3).ancova = 0;
%%
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fsuball.fsubject(1).scans = {
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cb100118\TF_data\FT2SPM\Scan_StimAlphatf_run1_50_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cb100118\TF_data\FT2SPM\Scan_StimAlphatf_run1_75_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cb100118\TF_data\FT2SPM\Scan_StimAlphatf_run1_100_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cb100118\TF_data\FT2SPM\Scan_StimAlphatf_run1_150_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cb100118\TF_data\FT2SPM\Scan_StimAlphatf_run1_200_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cb100118\TF_data\FT2SPM\Scan_StimAlphatf_run1_300_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cb100118\TF_data\FT2SPM\Scan_StimAlphatf_run1_400_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cb100118\TF_data\FT2SPM\Scan_StimAlphatf_run1_600_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cb100118\TF_data\FT2SPM\Scan_StimAlphatf_run2_50_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cb100118\TF_data\FT2SPM\Scan_StimAlphatf_run2_75_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cb100118\TF_data\FT2SPM\Scan_StimAlphatf_run2_100_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cb100118\TF_data\FT2SPM\Scan_StimAlphatf_run2_150_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cb100118\TF_data\FT2SPM\Scan_StimAlphatf_run2_200_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cb100118\TF_data\FT2SPM\Scan_StimAlphatf_run2_300_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cb100118\TF_data\FT2SPM\Scan_StimAlphatf_run2_400_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cb100118\TF_data\FT2SPM\Scan_StimAlphatf_run2_600_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cb100118\TF_data\FT2SPM\Scan_StimAlphatf_run1_50_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cb100118\TF_data\FT2SPM\Scan_StimAlphatf_run1_75_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cb100118\TF_data\FT2SPM\Scan_StimAlphatf_run1_100_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cb100118\TF_data\FT2SPM\Scan_StimAlphatf_run1_150_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cb100118\TF_data\FT2SPM\Scan_StimAlphatf_run1_200_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cb100118\TF_data\FT2SPM\Scan_StimAlphatf_run1_300_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cb100118\TF_data\FT2SPM\Scan_StimAlphatf_run1_400_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cb100118\TF_data\FT2SPM\Scan_StimAlphatf_run1_600_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cb100118\TF_data\FT2SPM\Scan_StimAlphatf_run2_50_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cb100118\TF_data\FT2SPM\Scan_StimAlphatf_run2_75_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cb100118\TF_data\FT2SPM\Scan_StimAlphatf_run2_100_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cb100118\TF_data\FT2SPM\Scan_StimAlphatf_run2_150_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cb100118\TF_data\FT2SPM\Scan_StimAlphatf_run2_200_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cb100118\TF_data\FT2SPM\Scan_StimAlphatf_run2_300_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cb100118\TF_data\FT2SPM\Scan_StimAlphatf_run2_400_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cb100118\TF_data\FT2SPM\Scan_StimAlphatf_run2_600_baseline_converted\condition_Undefined.nii,1'
                                                                                  };
%%
%%
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fsuball.fsubject(1).conds = [1 1 1
                                                                                  2 1 1
                                                                                  3 1 1
                                                                                  4 1 1
                                                                                  5 1 1
                                                                                  6 1 1
                                                                                  7 1 1
                                                                                  8 1 1
                                                                                  1 1 2
                                                                                  2 1 2
                                                                                  3 1 2
                                                                                  4 1 2
                                                                                  5 1 2
                                                                                  6 1 2
                                                                                  7 1 2
                                                                                  8 1 2
                                                                                  9 1 1
                                                                                  9 1 1
                                                                                  9 1 1
                                                                                  9 1 1
                                                                                  9 1 1
                                                                                  9 1 1
                                                                                  9 1 1
                                                                                  9 1 1
                                                                                  9 1 2
                                                                                  9 1 2
                                                                                  9 1 2
                                                                                  9 1 2
                                                                                  9 1 2
                                                                                  9 1 2
                                                                                  9 1 2
                                                                                  9 1 2];

%%
%%
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fsuball.fsubject(2).scans = {
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run1_50_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run1_75_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run1_100_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run1_150_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run1_200_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run1_300_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run1_400_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run1_600_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run2_50_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run2_75_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run2_100_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run2_150_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run2_200_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run2_300_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run2_400_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run2_600_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run1_50_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run1_75_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run1_100_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run1_150_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run1_200_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run1_300_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run1_400_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run1_600_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run2_50_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run2_75_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run2_100_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run2_150_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run2_200_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run2_300_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run2_400_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run2_600_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run3_50_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run3_75_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run3_100_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run3_150_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run3_200_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run3_300_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run3_400_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run3_600_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run4_50_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run4_75_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run4_100_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run4_150_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run4_200_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run4_300_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run4_400_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run4_600_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run3_50_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run3_75_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run3_100_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run3_150_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run3_200_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run3_300_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run3_400_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run3_600_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run4_50_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run4_75_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run4_100_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run4_150_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run4_200_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run4_300_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run4_400_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\FT2SPM\Scan_StimAlphatf_run4_600_baseline_converted\condition_Undefined.nii,1'
                                                                                  };
%%
%%
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fsuball.fsubject(2).conds = [1 1 1
                                                                                  2 1 1
                                                                                  3 1 1
                                                                                  4 1 1
                                                                                  5 1 1
                                                                                  6 1 1
                                                                                  7 1 1
                                                                                  8 1 1
                                                                                  1 1 2
                                                                                  2 1 2
                                                                                  3 1 2
                                                                                  4 1 2
                                                                                  5 1 2
                                                                                  6 1 2
                                                                                  7 1 2
                                                                                  8 1 2
                                                                                  9 1 1
                                                                                  9 1 1
                                                                                  9 1 1
                                                                                  9 1 1
                                                                                  9 1 1
                                                                                  9 1 1
                                                                                  9 1 1
                                                                                  9 1 1
                                                                                  9 1 2
                                                                                  9 1 2
                                                                                  9 1 2
                                                                                  9 1 2
                                                                                  9 1 2
                                                                                  9 1 2
                                                                                  9 1 2
                                                                                  9 1 2
                                                                                  1 1 3
                                                                                  2 1 3
                                                                                  3 1 3
                                                                                  4 1 3
                                                                                  5 1 3
                                                                                  6 1 3
                                                                                  7 1 3
                                                                                  8 1 3
                                                                                  1 1 4
                                                                                  2 1 4
                                                                                  3 1 4
                                                                                  4 1 4
                                                                                  5 1 4
                                                                                  6 1 4
                                                                                  7 1 4
                                                                                  8 1 4
                                                                                  9 1 3
                                                                                  9 1 3
                                                                                  9 1 3
                                                                                  9 1 3
                                                                                  9 1 3
                                                                                  9 1 3
                                                                                  9 1 3
                                                                                  9 1 3
                                                                                  9 1 4
                                                                                  9 1 4
                                                                                  9 1 4
                                                                                  9 1 4
                                                                                  9 1 4
                                                                                  9 1 4
                                                                                  9 1 4
                                                                                  9 1 4];
%%
%%
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fsuball.fsubject(3).scans = {
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run1_50_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run1_75_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run1_100_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run1_150_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run1_200_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run1_300_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run1_400_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run1_600_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run2_50_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run2_75_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run2_100_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run2_150_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run2_200_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run2_300_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run2_400_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run2_600_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run1_50_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run1_75_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run1_100_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run1_150_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run1_200_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run1_300_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run1_400_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run1_600_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run2_50_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run2_75_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run2_100_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run2_150_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run2_200_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run2_300_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run2_400_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run2_600_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run3_50_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run3_75_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run3_100_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run3_150_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run3_200_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run3_300_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run3_400_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run3_600_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run4_50_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run4_75_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run4_100_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run4_150_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run4_200_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run4_300_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run4_400_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run4_600_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run3_50_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run3_75_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run3_100_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run3_150_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run3_200_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run3_300_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run3_400_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run3_600_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run4_50_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run4_75_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run4_100_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run4_150_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run4_200_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run4_300_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run4_400_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\Scan_StimAlphatf_run4_600_baseline_converted\condition_Undefined.nii,1'
                                                                                  };
%%
%%
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fsuball.fsubject(3).conds = [1 1 1
                                                                                  2 1 1
                                                                                  3 1 1
                                                                                  4 1 1
                                                                                  5 1 1
                                                                                  6 1 1
                                                                                  7 1 1
                                                                                  8 1 1
                                                                                  1 1 2
                                                                                  2 1 2
                                                                                  3 1 2
                                                                                  4 1 2
                                                                                  5 1 2
                                                                                  6 1 2
                                                                                  7 1 2
                                                                                  8 1 2
                                                                                  9 1 1
                                                                                  9 1 1
                                                                                  9 1 1
                                                                                  9 1 1
                                                                                  9 1 1
                                                                                  9 1 1
                                                                                  9 1 1
                                                                                  9 1 1
                                                                                  9 1 2
                                                                                  9 1 2
                                                                                  9 1 2
                                                                                  9 1 2
                                                                                  9 1 2
                                                                                  9 1 2
                                                                                  9 1 2
                                                                                  9 1 2
                                                                                  1 1 3
                                                                                  2 1 3
                                                                                  3 1 3
                                                                                  4 1 3
                                                                                  5 1 3
                                                                                  6 1 3
                                                                                  7 1 3
                                                                                  8 1 3
                                                                                  1 1 4
                                                                                  2 1 4
                                                                                  3 1 4
                                                                                  4 1 4
                                                                                  5 1 4
                                                                                  6 1 4
                                                                                  7 1 4
                                                                                  8 1 4
                                                                                  9 1 3
                                                                                  9 1 3
                                                                                  9 1 3
                                                                                  9 1 3
                                                                                  9 1 3
                                                                                  9 1 3
                                                                                  9 1 3
                                                                                  9 1 3
                                                                                  9 1 4
                                                                                  9 1 4
                                                                                  9 1 4
                                                                                  9 1 4
                                                                                  9 1 4
                                                                                  9 1 4
                                                                                  9 1 4
                                                                                  9 1 4];
%%
%%
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fsuball.fsubject(4).scans = {
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run1_50_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run1_75_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run1_100_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run1_150_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run1_200_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run1_300_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run1_400_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run1_600_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run2_50_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run2_75_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run2_100_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run2_150_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run2_200_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run2_300_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run2_400_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run2_600_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run1_50_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run1_75_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run1_100_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run1_150_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run1_200_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run1_300_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run1_400_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run1_600_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run2_50_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run2_75_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run2_100_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run2_150_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run2_200_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run2_300_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run2_400_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run2_600_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run3_50_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run3_75_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run3_100_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run3_150_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run3_200_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run3_300_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run3_400_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run3_600_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run4_50_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run4_75_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run4_100_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run4_150_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run4_200_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run4_300_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run4_400_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run4_600_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run3_50_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run3_75_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run3_100_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run3_150_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run3_200_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run3_300_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run3_400_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run3_600_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run4_50_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run4_75_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run4_100_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run4_150_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run4_200_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run4_300_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run4_400_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\FT2SPM\Scan_StimAlphatf_run4_600_baseline_converted\condition_Undefined.nii,1'
                                                                                  };
%%
%%
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fsuball.fsubject(4).conds = [1 1 1
                                                                                  2 1 1
                                                                                  3 1 1
                                                                                  4 1 1
                                                                                  5 1 1
                                                                                  6 1 1
                                                                                  7 1 1
                                                                                  8 1 1
                                                                                  1 1 2
                                                                                  2 1 2
                                                                                  3 1 2
                                                                                  4 1 2
                                                                                  5 1 2
                                                                                  6 1 2
                                                                                  7 1 2
                                                                                  8 1 2
                                                                                  9 1 1
                                                                                  9 1 1
                                                                                  9 1 1
                                                                                  9 1 1
                                                                                  9 1 1
                                                                                  9 1 1
                                                                                  9 1 1
                                                                                  9 1 1
                                                                                  9 1 2
                                                                                  9 1 2
                                                                                  9 1 2
                                                                                  9 1 2
                                                                                  9 1 2
                                                                                  9 1 2
                                                                                  9 1 2
                                                                                  9 1 2
                                                                                  1 1 3
                                                                                  2 1 3
                                                                                  3 1 3
                                                                                  4 1 3
                                                                                  5 1 3
                                                                                  6 1 3
                                                                                  7 1 3
                                                                                  8 1 3
                                                                                  1 1 4
                                                                                  2 1 4
                                                                                  3 1 4
                                                                                  4 1 4
                                                                                  5 1 4
                                                                                  6 1 4
                                                                                  7 1 4
                                                                                  8 1 4
                                                                                  9 1 3
                                                                                  9 1 3
                                                                                  9 1 3
                                                                                  9 1 3
                                                                                  9 1 3
                                                                                  9 1 3
                                                                                  9 1 3
                                                                                  9 1 3
                                                                                  9 1 4
                                                                                  9 1 4
                                                                                  9 1 4
                                                                                  9 1 4
                                                                                  9 1 4
                                                                                  9 1 4
                                                                                  9 1 4
                                                                                  9 1 4];
%%
%%
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fsuball.fsubject(5).scans = {
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\nr110115\TF_data\FT2SPM\Scan_StimAlphatf_run1_50_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\nr110115\TF_data\FT2SPM\Scan_StimAlphatf_run1_75_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\nr110115\TF_data\FT2SPM\Scan_StimAlphatf_run1_100_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\nr110115\TF_data\FT2SPM\Scan_StimAlphatf_run1_150_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\nr110115\TF_data\FT2SPM\Scan_StimAlphatf_run1_200_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\nr110115\TF_data\FT2SPM\Scan_StimAlphatf_run1_300_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\nr110115\TF_data\FT2SPM\Scan_StimAlphatf_run1_400_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\nr110115\TF_data\FT2SPM\Scan_StimAlphatf_run1_600_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\nr110115\TF_data\FT2SPM\Scan_StimAlphatf_run2_50_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\nr110115\TF_data\FT2SPM\Scan_StimAlphatf_run2_75_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\nr110115\TF_data\FT2SPM\Scan_StimAlphatf_run2_100_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\nr110115\TF_data\FT2SPM\Scan_StimAlphatf_run2_150_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\nr110115\TF_data\FT2SPM\Scan_StimAlphatf_run2_200_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\nr110115\TF_data\FT2SPM\Scan_StimAlphatf_run2_300_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\nr110115\TF_data\FT2SPM\Scan_StimAlphatf_run2_400_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\nr110115\TF_data\FT2SPM\Scan_StimAlphatf_run2_600_stimfreq_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\nr110115\TF_data\FT2SPM\Scan_StimAlphatf_run1_50_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\nr110115\TF_data\FT2SPM\Scan_StimAlphatf_run1_75_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\nr110115\TF_data\FT2SPM\Scan_StimAlphatf_run1_100_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\nr110115\TF_data\FT2SPM\Scan_StimAlphatf_run1_150_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\nr110115\TF_data\FT2SPM\Scan_StimAlphatf_run1_200_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\nr110115\TF_data\FT2SPM\Scan_StimAlphatf_run1_300_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\nr110115\TF_data\FT2SPM\Scan_StimAlphatf_run1_400_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\nr110115\TF_data\FT2SPM\Scan_StimAlphatf_run1_600_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\nr110115\TF_data\FT2SPM\Scan_StimAlphatf_run2_50_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\nr110115\TF_data\FT2SPM\Scan_StimAlphatf_run2_75_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\nr110115\TF_data\FT2SPM\Scan_StimAlphatf_run2_100_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\nr110115\TF_data\FT2SPM\Scan_StimAlphatf_run2_150_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\nr110115\TF_data\FT2SPM\Scan_StimAlphatf_run2_200_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\nr110115\TF_data\FT2SPM\Scan_StimAlphatf_run2_300_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\nr110115\TF_data\FT2SPM\Scan_StimAlphatf_run2_400_baseline_converted\condition_Undefined.nii,1'
                                                                                  'C:\RESONANCE_MEG\SPM_analysis\Subjects\cb100118\TF_data\FT2SPM\Scan_StimAlphatf_run2_600_baseline_converted\condition_Undefined.nii,1'
                                                                                  };
%%
%%
matlabbatch{1}.spm.stats.factorial_design.des.fblock.fsuball.fsubject(5).conds = [1 1 1
                                                                                  2 1 1
                                                                                  3 1 1
                                                                                  4 1 1
                                                                                  5 1 1
                                                                                  6 1 1
                                                                                  7 1 1
                                                                                  8 1 1
                                                                                  1 1 2
                                                                                  2 1 2
                                                                                  3 1 2
                                                                                  4 1 2
                                                                                  5 1 2
                                                                                  6 1 2
                                                                                  7 1 2
                                                                                  8 1 2
                                                                                  9 1 1
                                                                                  9 1 1
                                                                                  9 1 1
                                                                                  9 1 1
                                                                                  9 1 1
                                                                                  9 1 1
                                                                                  9 1 1
                                                                                  9 1 1
                                                                                  9 1 2
                                                                                  9 1 2
                                                                                  9 1 2
                                                                                  9 1 2
                                                                                  9 1 2
                                                                                  9 1 2
                                                                                  9 1 2
                                                                                  9 1 2];
%%
matlabbatch{1}.spm.stats.factorial_design.des.fblock.maininters{1}.fmain.fnum = 1;
matlabbatch{1}.spm.stats.factorial_design.cov = struct('c', {}, 'cname', {}, 'iCFI', {}, 'iCC', {});
matlabbatch{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;
matlabbatch{1}.spm.stats.factorial_design.masking.im = 1;
matlabbatch{1}.spm.stats.factorial_design.masking.em = {''};
matlabbatch{1}.spm.stats.factorial_design.globalc.g_omit = 1;
matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = 1;
matlabbatch{2}.spm.stats.fmri_est.spmmat(1) = cfg_dep('Factorial design specification: SPM.mat File', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1;

matlabbatch{3}.spm.stats.con.spmmat = {'C:\RESONANCE_MEG\SPM_analysis\Group\TF_AlphaModel1\SPM.mat'};
matlabbatch{3}.spm.stats.con.consess{1}.tcon.name = 'Stimfreq > baseline';
matlabbatch{3}.spm.stats.con.consess{1}.tcon.weights = [1 1 1 1 1 1 1 1 -8];
matlabbatch{3}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{2}.tcon.name = 'stimfreq50 < baseline';
matlabbatch{3}.spm.stats.con.consess{2}.tcon.weights = [-1 0 0 0 0 0 0 0 1];
matlabbatch{3}.spm.stats.con.consess{2}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{3}.tcon.name = 'stimfreq83 < baseline';
matlabbatch{3}.spm.stats.con.consess{3}.tcon.weights = [0 -1 0 0 0 0 0 0 1];
matlabbatch{3}.spm.stats.con.consess{3}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{4}.tcon.name = 'stimfreq100 < baseline';
matlabbatch{3}.spm.stats.con.consess{4}.tcon.weights = [0 0 -1 0 0 0 0 0 1];
matlabbatch{3}.spm.stats.con.consess{4}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{5}.tcon.name = 'stimfreq150 < baseline';
matlabbatch{3}.spm.stats.con.consess{5}.tcon.weights = [0 0 0 -1 0 0 0 0 1];
matlabbatch{3}.spm.stats.con.consess{5}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{6}.tcon.name = 'stimfreq200 < baseline';
matlabbatch{3}.spm.stats.con.consess{6}.tcon.weights = [0 0 0 0 -1 0 0 0 1];
matlabbatch{3}.spm.stats.con.consess{6}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{7}.tcon.name = 'stimfreq300 < baseline';
matlabbatch{3}.spm.stats.con.consess{7}.tcon.weights = [0 0 0 0 0 -1 0 0 1];
matlabbatch{3}.spm.stats.con.consess{7}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{8}.tcon.name = 'stimfreq400 < baseline';
matlabbatch{3}.spm.stats.con.consess{8}.tcon.weights = [0 0 0 0 0 0 -1 0 1];
matlabbatch{3}.spm.stats.con.consess{8}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{9}.tcon.name = 'stimfreq600 < baseline';
matlabbatch{3}.spm.stats.con.consess{9}.tcon.weights = [0 0 0 0 0 0 0 -1 1];
matlabbatch{3}.spm.stats.con.consess{9}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{10}.tcon.name = 'Baseline - Stimfreq';
matlabbatch{3}.spm.stats.con.consess{10}.tcon.weights = [-1 -1 -1 -1 -1 -1 -1 -1 8];
matlabbatch{3}.spm.stats.con.consess{10}.tcon.sessrep = 'none';

tmp1 = [8 8:-1:1]                       ; tmp1(1) = []; tmp1(9) = -sum([tmp1]);
tmp2 = [linspace(1,8,2) linspace(8,1,7)]; tmp2(2) = []; tmp2(9) = -sum([tmp2]);
tmp3 = [linspace(1,8,3) linspace(8,1,6)]; tmp3(3) = []; tmp3(9) = -sum([tmp3]);
tmp4 = [linspace(1,8,4) linspace(8,1,5)]; tmp4(4) = []; tmp4(9) = -sum([tmp4]);
tmp5 = [linspace(1,8,5) linspace(8,1,4)]; tmp5(5) = []; tmp5(9) = -sum([tmp5]);
tmp6 = [linspace(1,8,6) linspace(8,1,3)]; tmp6(6) = []; tmp6(9) = -sum([tmp6]);
tmp7 = [linspace(1,8,7) linspace(8,1,2)]; tmp7(7) = []; tmp7(9) = -sum([tmp7]);
tmp8 = [1:8 8]                          ; tmp8(8) = []; tmp8(9) = -sum([tmp8]);
weights_lin_tuning = -[tmp1;tmp2;tmp3;tmp4;tmp5;tmp6;tmp7;tmp8];

matlabbatch{3}.spm.stats.con.consess{11}.tcon.name = 'Tuning 50ms';
matlabbatch{3}.spm.stats.con.consess{11}.tcon.weights = weights_lin_tuning(1,:);
matlabbatch{3}.spm.stats.con.consess{11}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{12}.tcon.name = 'Tuning 83ms';
matlabbatch{3}.spm.stats.con.consess{12}.tcon.weights = weights_lin_tuning(2,:);
matlabbatch{3}.spm.stats.con.consess{12}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{13}.tcon.name = 'Tuning 100ms';
matlabbatch{3}.spm.stats.con.consess{13}.tcon.weights = weights_lin_tuning(3,:);
matlabbatch{3}.spm.stats.con.consess{13}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{14}.tcon.name = 'Tuning 150ms';
matlabbatch{3}.spm.stats.con.consess{14}.tcon.weights = weights_lin_tuning(4,:);
matlabbatch{3}.spm.stats.con.consess{14}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{15}.tcon.name = 'Tuning 200ms';
matlabbatch{3}.spm.stats.con.consess{15}.tcon.weights = weights_lin_tuning(5,:);
matlabbatch{3}.spm.stats.con.consess{15}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{16}.tcon.name = 'Tuning 300ms';
matlabbatch{3}.spm.stats.con.consess{16}.tcon.weights = weights_lin_tuning(6,:);
matlabbatch{3}.spm.stats.con.consess{16}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{17}.tcon.name = 'Tuning 400ms';
matlabbatch{3}.spm.stats.con.consess{17}.tcon.weights = weights_lin_tuning(7,:);
matlabbatch{3}.spm.stats.con.consess{17}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{18}.tcon.name = 'Tuning 600ms';
matlabbatch{3}.spm.stats.con.consess{18}.tcon.weights = weights_lin_tuning(8,:);
matlabbatch{3}.spm.stats.con.consess{18}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.delete = 1;

% execute batch
spm_jobman('run',matlabbatch)
