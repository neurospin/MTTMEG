function datapath = temprod_preproc_rest(run,isdownsample,runref,subject,runcomp)

% subject information, trigger definition and trial function %%
par.Sub_Num            = subject;
par.RawDir             = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Raw_' subject '/'];
par.DirHead            = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/HeadMvt_' subject '/'];
par.DataDir            = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Trans_sss_' subject '/'];
par.ProcDataDir        = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];
par.run                = run; 

% MaxFilter parameters
par.DirMaxFil          = '/neurospin/meg_tmp/temprod_Baptiste_2010/SCRIPTS/Maxfilter_scripts/';
par.NameMaxFil         = ['Maxfilter_temprod_OLD_' subject];
% ECG/EOG PCA projection
par.pcaproj            = ['_run' num2str(runref) '_raw_sss.fif'];
par.projfile_id        = 'comp';
% correct for Head Movement between runs %%
% made outside of fieldtrip
% perform MaxFilter processing %%
% made outside of fieldtrip

% generate epoched fieldtrip dataset %%

% define parameters from par %%
cfg                         = [];
cfg.continuous              = 'no';
cfg.headerformat            = 'neuromag_mne';
cfg.dataformat              = 'neuromag_mne';
cfg.trialdef.channel        = 'STI101';
cfg.trialdef.prestim        = 0;
cfg.trialdef.poststim       = 0;
cfg.photodelay              = 0.0038; 
cfg.trialfun                = 'trialfun_temprod_OLD_uniquetrial';
cfg.Sub_Num                 = par.Sub_Num;
cfg.lpfreq                  = 'no';
cfg.dftfilter               = 'yes';
    

% trial definition and preprocessing
for i                       = par.run
    disp(['processing run ' num2str(i)]);   
    cfg.dataset             = [par.DataDir par.Sub_Num '_run' num2str(i) '_raw_sss.fif'];
    cfg.DataDir             = par.DataDir;
    cfg.channel             = {'MEG*'};
    cfg.run                 = i;
    cfg_loc                 = ft_definetrial(cfg);
    data                    = ft_preprocessing(cfg_loc);
    cfg                     = [];
end;

% downsampling data
cfg                    = [];
cfg.resamplefs         = 250;
cfg.detrend            = 'no';
cfg.blc                = 'no';
cfg.feedback           = 'no';
cfg.trials             = 'all';
if isdownsample        == 1
    data               = ft_resampledata(cfg,data);
end

% artifact correction by removing PCA components computed with graph %%
data                   = temprod_pca(par,data);

trialbeg = 1;
% segment data for artifact rejection
for j = 1:floor((length(data.time{1,1}))/125)
    datarestnoisy.trial{1,j}      = data.trial{1,1}(1:306,trialbeg:(trialbeg+125));
    datarestnoisy.time{1,j}       = data.time{1,1}(1:125);
    datarestnoisy.sampleinfo(j,:) = [trialbeg (trialbeg+125)];
    trialbeg                      = trialbeg+125;
end
datarestnoisy.fsample        = data.fsample;
datarestnoisy.grad           = data.grad;
datarestnoisy.label          = data.label;

% reject noisy 500 ms data segement
cfg                    =[];
cfg.method             ='summary';
cfg.channel            = {'MEG','EOG'};
cfg.alim               = 4e-11;
cfg.megscale           = 1;
cfg.eogscale           = 5e-7;
cfg.keepchannel        = 'no';
datarestnoisy          = ft_rejectvisual(cfg,datarestnoisy);

init  = datarestnoisy.trial{1,1};
for i = 2:length(datarestnoisy.time)
    init = [init datarestnoisy.trial{1,i}];
end
datarestcleaned.trial{1,1}     = init;
datarestcleaned.time{1,1}      = 0:0.004:(size(datarestcleaned.trial{1,1},2))*0.004;
datarestcleaned.fsample        = data.fsample;
datarestcleaned.grad           = data.grad;
datarestcleaned.label          = data.label;
datarest                       = datarestcleaned;

% load runcomp info
Dir = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];
dataref = load(fullfile(Dir,['/FT_trials/run' num2str(runcomp) 'trial001.mat']),'data','MaxLength');
MaxLength = dataref.MaxLength;

for i = 1:length(dataref.data.sampleinfo)
    nb_of_trial_created = floor(length(datarest.time{1,1})/(length(dataref.data.time{1,1})));
    trialbeg = 1;
    for j = 1:nb_of_trial_created
        datarestsave.trial{1,j} = datarest.trial{1,1}(1:306,trialbeg:(trialbeg +(length(dataref.data.time{1,1}))));
        datarestsave.time{1,j}  = dataref.data.time{1,1};
        datarestsave.sampleinfo = dataref.data.sampleinfo;
        trialbeg                = trialbeg + length(dataref.data.time{1,1});
    end
    datarestsave.fsample        = datarest.fsample;    
    datarestsave.grad           = datarest.grad;  
    datarestsave.label          = datarest.label;  

    datarestpath           = [par.ProcDataDir 'FT_trials/runrest' num2str(runcomp) 'trial' num2str(i,'%03i') '.mat'];
    save(datarestpath,'datarestsave','MaxLength');
    clear datarestsave
end


