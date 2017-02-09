% List of open inputs
% Display Image: Image to Display - cfg_files
nrun = X; % enter the number of runs here
jobfile = {'C:\RESONANCE_MEG\SPM_analysis\Scripts\test_display_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(1, nrun);
for crun = 1:nrun
    inputs{1, crun} = MATLAB_CODE_TO_FILL_INPUT; % Display Image: Image to Display - cfg_files
end
spm('defaults', 'EEG');
spm_jobman('run', jobs, inputs{:});
