function Temprod_Dataviewer_FIGTHESIS(subject,run,freqband,chantype,debiasing,tag)

% set root
root = SetPath(tag);

%% (1) set data path and load data
ProcDataDir                = [root '\DATA\NEW\processed_' subject '\'];
freqpath                   = [ProcDataDir 'FT_spectra\BLOCKFREQ_' chantype '_RUN' num2str(run,'%02i')...
    '_1_120Hz.mat'];
freq                       = load(freqpath);

%% round behav data
% m                         = median(freq.duration(:,1));
% for i = 1:size(freq.duration,1)
%     freq.mediandeviation(i,1:2)  = freq.duration(i,1:2) - [m 0];
% end
% freq.mediandeviation(:,1) = abs(freq.mediandeviation(:,1));
% freq.mediandeviation      = sortrows(freq.mediandeviation);

%store behavioural
freq.accuracysave         = freq.accuracy;
freq.durationsave         = freq.duration;
freq.durationsortedsave   = freq.durationsorted;
freq.mediandeviationsave  = freq.mediandeviation;

freq.accuracy(:,1)        = round((freq.accuracy(:,1))*100)/100;
freq.duration(:,1)        = round((freq.duration(:,1))*100)/100;
freq.durationsorted(:,1)  = round((freq.durationsorted(:,1))*100)/100;
freq.mediandeviation(:,1) = round((freq.mediandeviation(:,1))*100)/100;

% channel type definition
[Grads1,Grads2,Mags]     = grads_for_layouts(tag);
Eeg                      = EEG_for_layouts(tag);

% cluster index definition
[FIND,BIND,VIND,LIND,RIND,FCHANS,BCHANS,VCHANS,LCHANS,RCHANS] = clusteranat(tag);
if strcmp('Mags',chantype)
    clustindex = [LIND(1,:) RIND(1,:) BIND(1,:) VIND(1,:) FIND(1,:)];
elseif strcmp('Grads1',chantype)
    clustindex = [LIND(2,:) RIND(2,:) BIND(2,:) VIND(2,:) FIND(2,:)];
elseif strcmp('Grads2',chantype)
    clustindex = [LIND(3,:) RIND(3,:) BIND(3,:) VIND(3,:) FIND(3,:)];
end

%% (3) line noise removal by channel-by-channel linear interpolation replacemement
[freq.freq,freq.powspctrm] = LineNoiseInterp(freq.freq,freq.powspctrm);

%% (4) remove 1/f component
if strcmp(debiasing,'yes')     == 1
    [freq.freq,freq.powspctrm] = RemoveOneOverF(freq.freq,freq.powspctrm,'mean');
end

%% (5) select frequency band
fbegin              = find(freq.freq >= freqband(1));
fend                = find(freq.freq <= freqband(2));
fband               = fbegin(1):fend(end);
freq.powspctrm      = freq.powspctrm(:,:,fband);
freq.freq           = freq.freq(fband);


%% deviation to the median estimate

% compute freq correlations
[MaxPSD,MaxPSDfreq,slope,Rf_med,pf_med] = trial_by_trial_corr(freq.freq,freq.powspctrm,freq.mediandeviationsave,'freq','max','Pearson');
% compute power correlations
[MaxPSD,MaxPSDfreq,slope,Rp_med,pp_med] = trial_by_trial_corr(freq.freq,freq.powspctrm,freq.mediandeviationsave,'pow','max','Pearson');
% compute slope correlations
[MaxPSD,MaxPSDfreq,slope,Rs_med,ps_med] = trial_by_trial_corr(freq.freq,freq.powspctrm,freq.mediandeviationsave,'slope','max','Pearson');

%% sorted durations

% compute freq correlations
[MaxPSD,MaxPSDfreq,slope,Rf_dur,pf_dur] = trial_by_trial_corr(freq.freq,freq.powspctrm,freq.durationsortedsave,'freq','max','Pearson');
% compute power correlations
[MaxPSD,MaxPSDfreq,slope,Rp_dur,pp_dur] = trial_by_trial_corr(freq.freq,freq.powspctrm,freq.durationsortedsave,'pow','max','Pearson');
% compute slope correlations
[MaxPSD,MaxPSDfreq,slope,Rs_dur,ps_dur] = trial_by_trial_corr(freq.freq,freq.powspctrm,freq.durationsortedsave,'slope','max','Pearson');

%% sorted accuracies

% compute freq correlations
[MaxPSD,MaxPSDfreq,slope,Rf_acc,pf_acc] = trial_by_trial_corr(freq.freq,freq.powspctrm,freq.accuracysave,'freq','max','Pearson');
% compute power correlations
[MaxPSD,MaxPSDfreq,slope,Rp_acc,pp_acc] = trial_by_trial_corr(freq.freq,freq.powspctrm,freq.accuracysave,'pow','max','Pearson');
% compute slope correlations
[MaxPSD,MaxPSDfreq,slope,Rs_acc,ps_acc] = trial_by_trial_corr(freq.freq,freq.powspctrm,freq.accuracysave,'slope','max','Pearson');

%% sum up in a structure
AVG_corr_R(:,1:9) = [Rp_dur(1,2) Rf_dur(1,2) Rs_dur(1,2) Rp_med(1,2) Rf_med(1,2) Rs_med(1,2)  Rp_acc(1,2) Rf_acc(1,2) Rs_acc(1,2)]; 
AVG_corr_R(:,10) = ones(1,1)*run; 
AVG_corr_R(:,11) = ones(1,1)*(str2num(subject(2:3)));

AVG_corr_p(:,1:9) = [pp_dur(1,2) pf_dur(1,2) ps_dur(1,2) pp_med(1,2) pf_med(1,2) ps_med(1,2)  pp_acc(1,2) pf_acc(1,2) ps_acc(1,2)]; 
AVG_corr_p(:,10) = ones(1,1)*run; 
AVG_corr_p(:,11) = ones(1,1)*(str2num(subject(2:3)));

%% Chan-by-chan power corr vs med
for i = 1:size(freq.powspctrm,2)
    [MaxPSD_tosave{i},MaxPSDfreq_tosave{i},Slope_tosave{i},Rp_cbc_med,pp_cbc_med] = trial_by_trial_corr(freq.freq,freq.powspctrm(:,i,:),freq.mediandeviationsave,'pow','max','Pearson');
    pval_pp_med(i) = pp_cbc_med(1,2);
    Rval_pp_med(i) = Rp_cbc_med(1,2);
end

%% Chan-by-chan frequency corr vs med
for i = 1:size(freq.powspctrm,2)
    [MaxPSD_med{i},MaxPSDfreq_med{i},Slope_tosave{i},Rf_cbc_med,pf_cbc_med] = trial_by_trial_corr(freq.freq,freq.powspctrm(:,i,:),freq.mediandeviationsave,'freq','max','Pearson');
    pval_pf_med(i) = pf_cbc_med(1,2);
    Rval_pf_med(i) = Rf_cbc_med(1,2);
end

%% Chan-by-chan power corr vs dur
for i = 1:size(freq.powspctrm,2)
    [MaxPSD_tosave{i},MaxPSDfreq_tosave{i},Slope_tosave{i},Rp_cbc_dur,pp_cbc_dur] = trial_by_trial_corr(freq.freq,freq.powspctrm(:,i,:),freq.durationsortedsave,'pow','max','Pearson');
    powtoplot(:,i) = MaxPSD_tosave{i}';
    pval_pp_dur(i) = pp_cbc_dur(1,2);
    Rval_pp_dur(i) = Rp_cbc_dur(1,2);
end

%% Chan-by-chan frequency corr vs dur
for i = 1:size(freq.powspctrm,2)
    [MaxPSD_SortedD{i},MaxPSDfreq_SortedD{i},Slope_tosave{i},Rf_cbc_dur,pf_cbc_dur] = trial_by_trial_corr(freq.freq,freq.powspctrm(:,i,:),freq.durationsortedsave,'freq','max','Pearson');
    pval_pf_dur(i) = pf_cbc_dur(1,2);
    Rval_pf_dur(i) = Rf_cbc_dur(1,2);
end

%% Chan-by-chan power corr vs acc
for i = 1:size(freq.powspctrm,2)
    [MaxPSD_acc{i},MaxPSDfreq_acc{i},Slope_tosave{i},Rp_cbc_acc,pp_cbc_acc] = trial_by_trial_corr(freq.freq,freq.powspctrm(:,i,:),freq.accuracysave,'pow','max','Pearson');
    pval_pp_acc(i) = pp_cbc_acc(1,2);
    Rval_pp_acc(i) = Rp_cbc_acc(1,2);
end

%% Chan-by-chan frequency corr vs acc
for i = 1:size(freq.powspctrm,2)
    [MaxPSD_acc{i},MaxPSDfreq_acc{i},Slope_tosave{i},Rf_cbc_acc,pf_cbc_acc] = trial_by_trial_corr(freq.freq,freq.powspctrm(:,i,:),freq.accuracysave,'freq','max','Pearson');
    pval_pf_acc(i) = pf_cbc_acc(1,2);
    Rval_pf_acc(i) = Rf_cbc_acc(1,2);
end

%% Chan-by-chan slope corr vs med
for i = 1:size(freq.powspctrm,2)
    [MaxPSD_med{i},MaxPSDfreq_med{i},Slope_tosave{i},Rs_cbc_med,ps_cbc_med] = trial_by_trial_corr(freq.freq,freq.powspctrm(:,i,:),freq.mediandeviationsave,'slope','max','Pearson');
    pval_ps_med(i) = ps_cbc_med(1,2);
    Rval_ps_med(i) = Rs_cbc_med(1,2);
end

%% Chan-by-chan slope corr vs dur
for i = 1:size(freq.powspctrm,2)
    [MaxPSDdur{i},MaxPSDfreq_dur{i},Slope_tosave{i},Rs_cbc_dur,ps_cbc_dur] = trial_by_trial_corr(freq.freq,freq.powspctrm(:,i,:),freq.durationsave,'slope','max','Pearson');
    pval_ps_dur(i) = ps_cbc_dur(1,2);
    Rval_ps_dur(i) = Rs_cbc_dur(1,2);
end

%% Chan-by-chan slope corr vs acc
for i = 1:size(freq.powspctrm,2)
    [MaxPSD_acc{i},MaxPSDfreq_acc{i},Slope_tosave{i},Rs_cbc_acc,ps_cbc_acc] = trial_by_trial_corr(freq.freq,freq.powspctrm(:,i,:),freq.accuracysave,'slope','max','Pearson');
    pval_ps_acc(i) = ps_cbc_acc(1,2);
    Rval_ps_acc(i) = Rs_cbc_acc(1,2);
end

%% concatenate in a data structure
CBC_corr_R(1:102,1:9) = [Rval_pp_dur' Rval_pf_dur' Rval_ps_dur' Rval_pp_med' Rval_pf_med' Rval_ps_med' Rval_pp_acc' Rval_pf_acc' Rval_ps_acc'];
CBC_corr_R(:,10) = ones(size(CBC_corr_R(:,1),1),1)*run;
CBC_corr_R(:,11) = ones(size(CBC_corr_R(:,1),1),1)*(str2num(subject(2:3)));

CBC_corr_p(1:102,1:9) = [pval_pp_dur' pval_pf_dur' pval_ps_dur' pval_pp_med' pval_pf_med' pval_ps_med' pval_pp_acc' pval_pf_acc' pval_ps_acc'];
CBC_corr_p(:,10) = ones(size(CBC_corr_R(:,1),1),1)*run;
CBC_corr_p(:,11) = ones(size(CBC_corr_R(:,1),1),1)*(str2num(subject(2:3)));

save(['C:\TEMPROD\DATA\NEW\processed_' subject '\FT_spectra\SUMMARY_corr_' chantype '_' subject '_run' num2str(run) '_freq' num2str(freqband(1)) '-' num2str(freqband(2)) '.mat'],...
    'CBC_corr_p','CBC_corr_R','AVG_corr_p','AVG_corr_R');

disp(['processing sub ' subject ', run ' num2str(run) ])
