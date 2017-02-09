function par = ns_par
% function par = ns_par
% Specifies subject information, trigger definition and trial function. 
% 
% Parameters here refer to a specific experiment as an example. 
% May be scripted as subject-dependent (example: par=ns_par(n) where n is
% the subject number) 
%
% 

%% Subject informations %%                                                                                             %% INPUT HERE
% Names 
par.MEGcode         = 'hc_080251';                                                                      % Subject acquisition code
par.Sub_Num         = 'S1';                                                                             % Eprime code
par.RawDir          = '/neurospin/acquisition/neuromag/data/hierarchie/hc_080251/090402/';              % Raw data path
par.DirHead         = '/neurospin/meg/meg_tmp/Hierarchy_Gabriel_2009/AnalysisMarco/HeadPosition/';      % Head position text file directory
par.DataDir         = '/neurospin/meg/meg_tmp/Hierarchy_Gabriel_2009/AnalysisMarco/data/sss/';          % SSS Data directory
par.run             = 1:5;                                                                              % Number of runs
par.PreStim         = 0.5;                                                                              % Prestimulus time window in seconds
par.PostStim        = 0.9;                                                                              % Poststimulus time window in seconds
par.BadChan         = '0531';
par.photodelay = 0.038;                                                                                 % read in Triggers.ave
                                        % for more info see http://www.unicog.org/pmwiki/pmwiki.php/Main/Stimulus-triggerDelay

%% trigger definition: trig{event code, event label} and trialfun to integrate them in FT %%
par.trig=trig_hierarchy;                        % Write your own trigger definition function. See trig_hierarchy as an example.
par.trialfun='trialfun_neurospin_hierarchy';    % Write your own trial definition function. See trialfun_neurospin_hierarchy as an example.

%% MaxFilter parameters
par.DirMaxFil       = '/neurospin/meg/meg_tmp/Hierarchy_Gabriel_2009/AnalysisMarco/scripts/MaxFilterScripts/';
par.NameMaxFil      = ['Maxfilter' par.Sub_Num];

%% ECG/EOG PCA projection 
par.pcaproj = ['run' num2str(1) '_sss.fif'];
par.projfile_id = 'ecg';