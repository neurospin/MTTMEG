function [Max,Min] = temprod_preproc_quarter(run,isdownsample,subject,runref,rejection,tag)

% set root
root = SetPath(tag); 
Dir = [root '/DATA/NEW/processed_' subject];

% subject information, trigger definition and trial function %%
par.Sub_Num            = subject;
par.RawDir             = [root '/DATA/NEW/Raw_' subject '/'];
par.DirHead            = [root '/DATA/NEW/HeadMvt_' subject '/'];
par.DataDir            = [root '/DATA/NEW/Trans_sss_' subject '/'];
par.ProcDataDir        = [root '/DATA/NEW/processed_' subject '/'];
par.run                = run; 

% MaxFilter parameters
par.DirMaxFil          = [root '/SCRIPTS/Maxfilter_scripts/'];
par.NameMaxFil         = ['Maxfilter_temprod_OLD_' subject];
% ECG/EOG PCA projection
par.pcaproj            = ['_run' num2str(runref) '_raw_sss.fif'];
par.projfile_id        = 'compmeg';
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
cfg.trialfun                = 'trialfun_temprod_OLD_cond2';
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
    cfg_loc{1,i}            = ft_definetrial(cfg);
    data{1,i}               = ft_preprocessing(cfg_loc{1,i});
    MaxLength{1,i}          = (max(cfg_loc{1,i}.trl(:,2) - cfg_loc{1,i}.trl(:,1)))/data{1,i}.fsample;
    sampleinfo{1,i}         = data{1,i}.sampleinfo;
end

datatmp.trial              = {};
datatmp.time               = {};
datatmp.sampleinfo         = [];

for i = 1:length(data)
    if isempty(data{1,i}) ~= 1
        datatmp.hdr        = data{1,i}.hdr;
%         datatmp.grad       = data{1,i}.grad;
        datatmp.fsample    = data{1,i}.fsample;
        datatmp.cfg        = data{1,i}.cfg;
        datatmp.label      = data{1,i}.label;
        datatmp.trial      = [datatmp.trial data{1,i}.trial];
        datatmp.time       = [datatmp.time  data{1,i}.time ];
        datatmp.sampleinfo = [datatmp.sampleinfo ; data{1,i}.sampleinfo];
    end
end

clear data;
data = datatmp;
sampleinfo = datatmp.sampleinfo;
MaxLength = max(max(sampleinfo)); 

% remove electric line noise 
% for i                  = 1:length(data.trial)
%     data.trial{i}      = ft_preproc_bandstopfilter(data.trial{i},data.fsample, [49 51]);
%     data.trial{i}      = ft_preproc_bandstopfilter(data.trial{i},data.fsample, [99 101]);
%     data.trial{i}      = ft_preproc_bandstopfilter(data.trial{i},data.fsample, [149 151]);
% end

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


% rejection of outliers trials (based on trial duration)
if rejection == 1;
    for i = 1:length(data.trial)
        durations(i) = size(data.trial{1,i},2);
    end
    
    q1                  = prctile(durations,25); % first quartile
    q3                  = prctile(durations,75); % third quartile
    myiqr               = iqr(durations);        % interquartile range
    lower_inner_fence   = q1 - 2*myiqr;
    upper_inner_fence   = q3 + 2*myiqr;
    
    index = [];
    a = 0;
    for i = 1:length(durations)
        if durations(i) < lower_inner_fence || durations(i) > upper_inner_fence
            a = a + 1;
            index(a) = i;
        end
    end
    
    info = [];
    if isempty(index) == 0
        a = 1; b = 1;
        for i = 1:length(data.trial)
            if i ~= index(b)
                tmp.trial{1,a} = data.trial{1,i};
                tmp.time{1,a}  = data.time{1,i};
                info(a,:) = sampleinfo(i,:);
                a = a + 1;
            elseif i == index(b) && b ~= length(index)
                b = b + 1;
            else i == index(b) && b == length(index)
            end
        end
        data.trial = tmp.trial;
        data.time  = tmp.time;
        data.sampleinfo = info;
    end
end

if isempty(info)
    info = sampleinfo;
end

% visual artifact detection %%
cfg                    =[];
cfg.method             ='summary';
cfg.channel            = {'MEG','EOG'};
cfg.alim               = 4e-11;
cfg.megscale           = 1;
cfg.eogscale           = 5e-7;
cfg.keepchannel        = 'no';
dataclean              = ft_rejectvisual(cfg,data);

asc_ord                = dataclean.sampleinfo(:,2) - dataclean.sampleinfo(:,1);
asc_ord(:,2)           = 1:length(asc_ord);
asc_ord                = sortrows(asc_ord);
qlength                = round(length(asc_ord)/4);
qtrials1               = [1:qlength];
qtrials2               = [(qlength+1):qlength*2];
qtrials3               = [(qlength*2+1):qlength*3];
qtrials4               = [(qlength*3+1):length(asc_ord)];

% separate quarters
Part1Trials            = dataclean;
Part1Trials.trial      = Part1Trials.trial(qtrials1 );
Part1Trials.time       = Part1Trials.time(qtrials1 );
Part1Trials.sampleinfo = Part1Trials.sampleinfo(qtrials1 ,:);

Part2Trials            = dataclean;
Part2Trials.trial      = Part2Trials.trial(qtrials2 );
Part2Trials.time       = Part2Trials.time(qtrials2 );
Part2Trials.sampleinfo = Part2Trials.sampleinfo(qtrials2 ,:);

Part3Trials            = dataclean;
Part3Trials.trial      = Part3Trials.trial(qtrials3 );
Part3Trials.time       = Part3Trials.time(qtrials3 );
Part3Trials.sampleinfo = Part3Trials.sampleinfo(qtrials3 ,:);

Part4Trials            = dataclean;
Part4Trials.trial      = Part4Trials.trial(qtrials4 );
Part4Trials.time       = Part4Trials.time(qtrials4 );
Part4Trials.sampleinfo = Part4Trials.sampleinfo(qtrials4 ,:);

MaxLength1 = [];
MinLength1 = [];
for i = 1:size(Part1Trials.time,2)
    MaxLength1 = max([MaxLength1 length(Part1Trials.time{i})]);
    MinLength1 = min([MinLength1 length(Part1Trials.time{i})]);
end
MaxLength2 = [];
MinLength2 = [];
for i = 1:size(Part2Trials.time,2)
    MaxLength2 = max([MaxLength2 length(Part2Trials.time{i})]);
    MinLength2 = min([MinLength2 length(Part2Trials.time{i})]);
end
MaxLength3 = [];
MinLength3 = [];
for i = 1:size(Part3Trials.time,2)
    MaxLength1 = max([MaxLength3 length(Part3Trials.time{i})]);
    MinLength1 = min([MinLength3 length(Part3Trials.time{i})]);
end
MaxLength4 = [];
MinLength4 = [];
for i = 1:size(Part4Trials.time,2)
    MaxLength4 = max([MaxLength4 length(Part4Trials.time{i})]);
    MinLength4 = min([MinLength4 length(Part4Trials.time{i})]);
end
Max = max([MaxLength1 MaxLength2 MaxLength3 MaxLength4]);
Min = min([MinLength1 MinLength2 MinLength3 MinLength4]);

datapath               = [par.ProcDataDir 'FT_trials/QuarterCutTrials_' num2str(run) '.mat'];
save(datapath,'Part1Trials','Part2Trials','Part3Trials','Part4Trials','Max','Min');

