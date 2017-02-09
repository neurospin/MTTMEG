function datapath = temprod_OLD_preproc(run,isdownsample,subject,runref,rejection,newnumber)

%% subject information, trigger definition and trial function %%
par.MEGcode            = 'vl_0701332';
par.Sub_Num            = subject;
par.RawDir             = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Raw_' subject '/'];
par.DirHead            = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/HeadMvt_' subject '/'];
par.DataDir            = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Trans_sss_' subject '/'];
par.ProcDataDir        = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];
par.run                = run; 
par.PreStim            = 0.5;
par.PostStim           = 0;
par.BadChan            = '';
%% trial definition %%
par.photodelay         = 0.00;
par.trialfun           = 'trialfun_temprod_OLD_cond2';
%% MaxFilter parameters
par.DirMaxFil          = '/neurospin/meg_tmp/temprod_Baptiste_2010/SCRIPTS/Maxfilter_scripts/';
par.NameMaxFil         = ['Maxfilter_temprod_OLD_' subject];
%% ECG/EOG PCA projection
par.pcaproj            = ['_run' num2str(runref) '_raw_sss.fif'];
par.projfile_id        = 'comp';
%% correct for Head Movement between runs %%
% % Generate an SH script that computes head position for each run and save it in a txt file
% ns_getheadmv_temprod_OLD(par);
% % plot head movement rotation/translation coordinates across runs
% dataheadmv = ns_checkheadmv_temprod_OLD(par); % dataheadmv contains all
% info on head movements for each run
% % Based on the rotation/translation plot, choose a run as the ref for head movement (3 in this example) %
% par.RunRef = 4;
%% perform MaxFilter processing %%
% ns_maxfilter(par);
% % for the time being, I've used hand-made script
%% generate epoched fieldtrip dataset %%
cfg                    = [];
cfg.resamplefs         = 500;
cfg.detrend            = 'no';
cfg.blc                = 'no';
cfg.feedback           = 'no';
cfg.trials             = 'all';
data2                  = [];
parsave.run            = run;
if length(par.run)     == 2
    par2               = par;
    par2.run           = par.run(2);
    par.run            = par.run(1);
    data               = ns_fif2ft_temprod_EEG_OLD(par);
    data2              = ns_fif2ft_temprod_EEG_OLD(par2);
    cfg                = [];
    cfg.resamplefs     = 500;
    cfg.detrend        = 'no';
    cfg.blc            = 'no';
    cfg.feedback       = 'no';
    cfg.trials         = 'all';
    if isdownsample    == 1
        data           = ft_resampledata(cfg,data);
        data2          = ft_resampledata(cfg,data2);
    end
elseif length(parsave.run) == 1
    data               = ns_fif2ft_temprod_OLD(par);
    if isdownsample    == 1
        data           = ft_resampledata(cfg,data);
    end
end
%% artifact correction by removing PCA components computed with graph %%
data                   = ns_pca(par,data);
if isempty(data2)      == 0
    data2              = ns_pca(par2,data2);
end
%% baseline correction %%
% for j                  = 1:length(data.trial)
%     data.trial{j}      = ft_preproc_baselinecorrect(data.trial{j});
% end
% if isempty(data2)      == 0
%     for j              = 1:length(data2.trial)
%         data2.trial{j} = ft_preproc_baselinecorrect(data2.trial{j});
%     end
% end
%% apply 50Hz notch filter
% for i                  = 1:length(data.trial)
%     data.trial{i}      = ft_preproc_dftfilter(data.trial{i}, data.fsample,50);
% end
% if isempty(data2)      == 0
%     for i              = 1:length(data2.trial)
%         data2.trial{i} = ft_preproc_dftfilter(data2.trial{i}, data2.fsample,50);
%     end
% end
% %% apply 100Hz notch filter
% for i                  = 1:length(data.trial)
%     data.trial{i}      = ft_preproc_dftfilter(data.trial{i}, data.fsample,100);
% end
% if isempty(data2)      == 0
%     for i              = 1:length(data2.trial)
%         data2.trial{i} = ft_preproc_dftfilter(data2.trial{i}, data2.fsample,100);
%     end
% end
% %% apply 150Hz notch filter
% for i                  = 1:length(data.trial)
%     data.trial{i}      = ft_preproc_dftfilter(data.trial{i}, data.fsample,150);
% end
% if isempty(data2)      == 0
%     for i              = 1:length(data2.trial)
%         data2.trial{i} = ft_preproc_dftfilter(data2.trial{i}, data2.fsample,150);
%     end
% end

%% concatenate data
% load here
if isempty(data2)      == 0
    data.trial         = [data.trial data2.trial];
    data.time          = [data.time data2.time];
end

%% rejection of outliers trials (based on trial duration)

if rejection == 1;
    for i = 1:length(data.trial)
        durations(i) = size(data.trial{1,i},2);
    end
    
    q1                  = prctile(durations,25); % first quartile
    q3                  = prctile(durations,75); % third quartile
    myiqr               = iqr(durations);        % interquartile range
    lower_inner_fence   = q1 - 3*myiqr;
    upper_inner_fence   = q3 + 3*myiqr;
    
    index = [];
    a = 0;
    for i = 1:length(durations)
        if durations(i) < lower_inner_fence || durations(i) > upper_inner_fence
            a = a + 1;
            index(a) = i;
        end
    end
    
    if isempty(index) == 0
        a = 1; b = 1;
        for i = 1:length(data.trial)
            if i ~= index(b)
                tmp.trial{1,a} = data.trial{1,i};
                tmp.time{1,a}  = data.time{1,i};
                a = a + 1;
            elseif i == index(b) && b ~= length(index)
                b = b + 1;
            else i == index(b) && b == length(index)
            end
        end
        data.trial = tmp.trial;
        data.time  = tmp.time;
    end
end
%% visual artifact detection %%
% Load the sensor label file
% load('/neurospin/meg_tmp/tools_tmp/pipeline/SensorClassification.mat')     % contains sensor label sets for plotting
% select channel type and scale
cfg                    =[];
cfg.method             ='summary';
cfg.channel            = {'MEG','EOG'};
cfg.alim               = 4e-11;
cfg.megscale           = 1;
cfg.eogscale           = 5e-7;
cfg.keepchannel        = 'no';
data                   = ft_rejectvisual(cfg,data);
%% save data %%
datapath               = [par.ProcDataDir 'run' num2str(newnumber) '.mat'];
save(datapath,'data','par','-v7.3');

close all
