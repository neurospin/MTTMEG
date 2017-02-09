%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all

% launch SPM12b manually!!! if not, it won't work (???)
spm('defaults', 'eeg');

clear matlabbatch

% go into directory of interest
cd('C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\TF_TuningModel1')

% Batch system initialization
spm_jobman('initcfg')

matlabbatch{1}.spm.stats.factorial_design.dir = {'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\TF_TuningModel1'};
%%
matlabbatch{1}.spm.stats.factorial_design.des.anovaw.fsubject.scans = {'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_50_stimfreq_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_50_stimfreq_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_50_stimfreq_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_50_stimfreq_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_75_stimfreq_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_75_stimfreq_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_75_stimfreq_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_75_stimfreq_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_100_stimfreq_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_100_stimfreq_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_100_stimfreq_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_100_stimfreq_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_150_stimfreq_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_150_stimfreq_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_150_stimfreq_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_150_stimfreq_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_200_stimfreq_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_200_stimfreq_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_200_stimfreq_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_200_stimfreq_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_300_stimfreq_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_300_stimfreq_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_300_stimfreq_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_300_stimfreq_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_400_stimfreq_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_400_stimfreq_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_400_stimfreq_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_400_stimfreq_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_600_stimfreq_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_600_stimfreq_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_600_stimfreq_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_600_stimfreq_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_50_stimfreq_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_50_stimfreq_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_50_stimfreq_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_50_stimfreq_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_75_stimfreq_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_75_stimfreq_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_75_stimfreq_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_75_stimfreq_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_100_stimfreq_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_100_stimfreq_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_100_stimfreq_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_100_stimfreq_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_150_stimfreq_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_150_stimfreq_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_150_stimfreq_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_150_stimfreq_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_200_stimfreq_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_200_stimfreq_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_200_stimfreq_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_200_stimfreq_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_300_stimfreq_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_300_stimfreq_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_300_stimfreq_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_300_stimfreq_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_400_stimfreq_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_400_stimfreq_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_400_stimfreq_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_400_stimfreq_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_600_stimfreq_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_600_stimfreq_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_600_stimfreq_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_600_stimfreq_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_50_stimfreq_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_50_stimfreq_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_50_stimfreq_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_50_stimfreq_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_75_stimfreq_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_75_stimfreq_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_75_stimfreq_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_75_stimfreq_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_100_stimfreq_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_100_stimfreq_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_100_stimfreq_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_100_stimfreq_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_150_stimfreq_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_150_stimfreq_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_150_stimfreq_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_150_stimfreq_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_200_stimfreq_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_200_stimfreq_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_200_stimfreq_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_300_stimfreq_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_300_stimfreq_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_300_stimfreq_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_300_stimfreq_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_400_stimfreq_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_400_stimfreq_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_400_stimfreq_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_400_stimfreq_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_600_stimfreq_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_600_stimfreq_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_600_stimfreq_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_600_stimfreq_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_50_stimfreq_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_50_stimfreq_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_50_stimfreq_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_50_stimfreq_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_75_stimfreq_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_75_stimfreq_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_75_stimfreq_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_75_stimfreq_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_100_stimfreq_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_100_stimfreq_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_100_stimfreq_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_100_stimfreq_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_150_stimfreq_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_150_stimfreq_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_150_stimfreq_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_150_stimfreq_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_200_stimfreq_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_200_stimfreq_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_200_stimfreq_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_200_stimfreq_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_300_stimfreq_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_300_stimfreq_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_300_stimfreq_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_300_stimfreq_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_400_stimfreq_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_400_stimfreq_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_400_stimfreq_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_400_stimfreq_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_600_stimfreq_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_600_stimfreq_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_600_stimfreq_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_600_stimfreq_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_50_baseline_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_50_baseline_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_50_baseline_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_50_baseline_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_75_baseline_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_75_baseline_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_75_baseline_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_100_baseline_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_100_baseline_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_100_baseline_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_100_baseline_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_150_baseline_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_150_baseline_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_150_baseline_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_150_baseline_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_200_baseline_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_200_baseline_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_200_baseline_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_200_baseline_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_300_baseline_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_300_baseline_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_300_baseline_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_300_baseline_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_400_baseline_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_400_baseline_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_400_baseline_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_400_baseline_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_600_baseline_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_600_baseline_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_600_baseline_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run1_600_baseline_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_50_baseline_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_50_baseline_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_50_baseline_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_50_baseline_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_75_baseline_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_75_baseline_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_75_baseline_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_75_baseline_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_100_baseline_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_100_baseline_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_100_baseline_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_100_baseline_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_150_baseline_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_150_baseline_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_150_baseline_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_150_baseline_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_200_baseline_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_200_baseline_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_200_baseline_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_200_baseline_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_300_baseline_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_300_baseline_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_300_baseline_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_300_baseline_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_400_baseline_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_400_baseline_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_400_baseline_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_400_baseline_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_600_baseline_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_600_baseline_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_600_baseline_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run2_600_baseline_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_50_baseline_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_50_baseline_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_50_baseline_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_50_baseline_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_75_baseline_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_75_baseline_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_75_baseline_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_100_baseline_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_100_baseline_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_100_baseline_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_100_baseline_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_150_baseline_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_150_baseline_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_150_baseline_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_150_baseline_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_200_baseline_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_200_baseline_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_200_baseline_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_200_baseline_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_300_baseline_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_300_baseline_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_300_baseline_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_400_baseline_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_400_baseline_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_400_baseline_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_600_baseline_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_600_baseline_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_600_baseline_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run3_600_baseline_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_50_baseline_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_50_baseline_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_50_baseline_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_50_baseline_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_75_baseline_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_75_baseline_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_75_baseline_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_75_baseline_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_100_baseline_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_100_baseline_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_100_baseline_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_100_baseline_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_150_baseline_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_150_baseline_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_150_baseline_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_150_baseline_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_200_baseline_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_200_baseline_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_200_baseline_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_200_baseline_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_300_baseline_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_300_baseline_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_300_baseline_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_300_baseline_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_400_baseline_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_400_baseline_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_400_baseline_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_400_baseline_converted\condition_Undefined.nii,4'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_600_baseline_converted\condition_Undefined.nii,1'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_600_baseline_converted\condition_Undefined.nii,2'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_600_baseline_converted\condition_Undefined.nii,3'
                                                                       'C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\FT2SPM\ScXFr_Stimfundtf_run4_600_baseline_converted\condition_Undefined.nii,4'
                                                                        };
                                                                    
%%
matlabbatch{1}.spm.stats.factorial_design.des.anovaw.fsubject.conds = [1 1 1 1 2 2 2 2 3 3 3 3 4 4 4 4 5 5 5 5 6 6 6 6 7 7 7 7 8 8 8 8 ...
                                                                       1 1 1 1 2 2 2 2 3 3 3 3 4 4 4 4 5 5 5 5 6 6 6 6 7 7 7 7 8 8 8 8 ...
                                                                       1 1 1 1 2 2 2 2 3 3 3 3 4 4 4 4 5 5 5 6 6 6 6 7 7 7 7 8 8 8 8 ...
                                                                       1 1 1 1 2 2 2 2 3 3 3 3 4 4 4 4 5 5 5 5 6 6 6 6 7 7 7 7 8 8 8 8 ones(1,124)*9]';
                                                                       
%%
matlabbatch{1}.spm.stats.factorial_design.des.anovaw.dept = 1;
matlabbatch{1}.spm.stats.factorial_design.des.anovaw.variance = 0;
matlabbatch{1}.spm.stats.factorial_design.des.anovaw.gmsca = 0;
matlabbatch{1}.spm.stats.factorial_design.des.anovaw.ancova = 0;
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
matlabbatch{3}.spm.stats.con.consess{1}.tcon.name = 'StimFreqAll > Baseline';
matlabbatch{3}.spm.stats.con.consess{1}.tcon.weights = [1 1 1 1 1 1 1 1 -8 0];
matlabbatch{3}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{2}.tcon.name = 'StimFreq50 > Baseline';
matlabbatch{3}.spm.stats.con.consess{2}.tcon.weights = [1 0 0 0 0 0 0 0 -1 0];
matlabbatch{3}.spm.stats.con.consess{2}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{3}.tcon.name = 'StimFreq83 > Baseline';
matlabbatch{3}.spm.stats.con.consess{3}.tcon.weights = [0 1 0 0 0 0 0 0 -1 0];
matlabbatch{3}.spm.stats.con.consess{3}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{4}.tcon.name = 'StimFreq100 > baseline';
matlabbatch{3}.spm.stats.con.consess{4}.tcon.weights = [0 0 1 0 0 0 0 0 -1 0];
matlabbatch{3}.spm.stats.con.consess{4}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{5}.tcon.name = 'StimFreq150 > Baseline';
matlabbatch{3}.spm.stats.con.consess{5}.tcon.weights = [0 0 0 1 0 0 0 0 -1 0];
matlabbatch{3}.spm.stats.con.consess{5}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{6}.tcon.name = 'StimFreq200 > Baseline';
matlabbatch{3}.spm.stats.con.consess{6}.tcon.weights = [0 0 0 0 1 0 0 0 -1 0];
matlabbatch{3}.spm.stats.con.consess{6}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{7}.tcon.name = 'StimFreq300 > Baseline';
matlabbatch{3}.spm.stats.con.consess{7}.tcon.weights = [0 0 0 0 0 1 0 0 -1 0];
matlabbatch{3}.spm.stats.con.consess{7}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{8}.tcon.name = 'StimFreq400 > Baseline';
matlabbatch{3}.spm.stats.con.consess{8}.tcon.weights = [0 0 0 0 0 0 1 0 -1 0];
matlabbatch{3}.spm.stats.con.consess{8}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{9}.tcon.name = 'StimFreq600 > Baseline';
matlabbatch{3}.spm.stats.con.consess{9}.tcon.weights = [0 0 0 0 0 0 0 1 -1 0];
matlabbatch{3}.spm.stats.con.consess{9}.tcon.sessrep = 'none';
matlabbatch{3}.spm.stats.con.consess{10}.tcon.name = 'Baseline > StimFreqAll';
matlabbatch{3}.spm.stats.con.consess{10}.tcon.weights = [-1 -1 -1 -1 -1 -1 -1 -1 8 0];
matlabbatch{3}.spm.stats.con.consess{10}.tcon.sessrep = 'none';

matlabbatch{3}.spm.stats.con.delete = 1;

% execute batch
spm_jobman('run',matlabbatch)


                                                                    
                                                                    
                                                                    
