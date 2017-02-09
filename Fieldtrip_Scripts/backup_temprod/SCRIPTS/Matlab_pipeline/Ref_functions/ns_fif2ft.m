function data=ns_fif2ft(par)
% function data=ns_fif2ft(par)
% Generates fieldtrip dataset data from fif dataset with parameters
% specified in par: 
% - Defines trials by ft_definetrial
% - Performs preprocessing by ft_preprocessing
% - Concatenates data from all runs into a single dataset by ft_appenddata
%
% Input:
% par = dataset parameters defined in ns_par and ns_preproc
%
% Output:
% data = fieldtrip dataset, format from ft_preprocessing
%
% Marco Buiatti, INSERM U992 Cognitive Neuroimaging Unit (France), 2010.

%% define parameters from par %%
cfg                     = [];
cfg.continuous          = 'no';
cfg.headerformat        = 'neuromag_mne';
cfg.dataformat          = 'neuromag_mne';
cfg.trialdef.channel='STI101';
cfg.trialdef.eventvalue=par.trig;
cfg.trialdef.prestim=par.PreStim;
cfg.trialdef.poststim=par.PostStim;
cfg.photodelay = par.photodelay; 
cfg.trialfun =par.trialfun;
cfg.Sub_Num = par.Sub_Num;
cfg.lpfreq = 40;
% cfg.blc='yes';
% cfg.blcwindow=[-par.PreStim 0];

%% trial definition and preprocessing
for i=1:length(par.run)
    disp(['processing run ' num2str(i)]);   
    cfg.dataset = [par.DataDir par.Sub_Num 'run' num2str(i) '_sss.fif'];
    cfg.DataDir = par.DataDir;
    cfg.run = i;
    % dataset configuration cfg
    cfg_loc = ft_definetrial(cfg);
    % load data in dataset structure defined by cfg_loc
    data{i}= ft_preprocessing(cfg_loc);
end;

%% concatanate all runs into a single dataset
data=ft_appenddata(cfg,data{:});
