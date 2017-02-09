clear all
close all

load('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/dm130250/MegData/Processed_new/EVT_dat_filt40.mat')
load('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/CORR_TABLE_DIST.mat')

DATAMAT = [];

[x1,y1] = find(datafilt40.time{1} < 0.3); % t = 0
[x2,y2] = find(datafilt40.time{1} < 0.1); % t = 0
t0 = y1(end);
tbaseline0 = y2(end);
ntime = size(datafilt40.trial{1},2);
for i = 1:length(datafilt40.trial)
    tmp = [];
    % baselining
    tmp = datafilt40.trial{i}(1:306,:) - ...
        repmat(mean(datafilt40.trial{i}(1:306,tbaseline0:t0),2), ...
        [1 size(datafilt40.trial{i},2)]);
    DATAMAT = cat(3,DATAMAT,tmp);
end

trialcode_egodist_T = [datafilt40.trialinfo(:,1) ones(length(datafilt40.trialinfo(:,1)),1)*NaN ones(length(datafilt40.trialinfo(:,1)),1)*NaN] ;
trialcode_egodist_S = [datafilt40.trialinfo(:,1) ones(length(datafilt40.trialinfo(:,1)),1)*NaN ones(length(datafilt40.trialinfo(:,1)),1)*NaN];

for i = 1:length(datafilt40.trialinfo(:,1))
    for j = 1:length(egoCORR_TABLE)
        if egoCORR_TABLE(j,1) == datafilt40.trialinfo(i,1)
            trialcode_egodist_T(i,2) = egoCORR_TABLE(j,2) ;
            trialcode_egodist_S(i,2) = egoCORR_TABLE(j,3) ;
        end
    end
end
 
count = [];
for i = 1:length(trialcode_egodist_T(:,2))
    if isnan(trialcode_egodist_T(i,2)) || isnan(trialcode_egodist_S(i,2))
        count = [count i];
    end
end
DATAMAT2 = DATAMAT;
trialcode_egodist_T2 = trialcode_egodist_T;
trialcode_egodist_S2 = trialcode_egodist_S;
DATAMAT2(:,:,count) = [];
trialcode_egodist_T2(count,:) = [];        
trialcode_egodist_S2(count,:) = [];   

corrvalt = [];
corrvals = [];
for i = 1:size(DATAMAT2,1)
    for j = 1:size(DATAMAT2,2)
        bt = regress(trialcode_egodist_T2(:,2),squeeze(DATAMAT2(i,j,:)));
        bs = regress(trialcode_egodist_S2(:,2),squeeze(DATAMAT2(i,j,:)));
        corrvalt_evt(i,j) = bt(2);
        corrvals_evt(i,j) = bs(2);
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/dm130250/MegData/Processed_new/EVS_dat_filt40.mat')
load('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/CORR_TABLE_DIST.mat')

DATAMAT = [];

[x1,y1] = find(datafilt40.time{1} < 0.3); % t = 0
[x2,y2] = find(datafilt40.time{1} < 0.1); % t = 0
t0 = y1(end);
tbaseline0 = y2(end);
ntime = size(datafilt40.trial{1},2);
for i = 1:length(datafilt40.trial)
    tmp = [];
    % baselining
    tmp = datafilt40.trial{i}(1:306,:) - ...
        repmat(mean(datafilt40.trial{i}(1:306,tbaseline0:t0),2), ...
        [1 size(datafilt40.trial{i},2)]);
    DATAMAT = cat(3,DATAMAT,tmp);
end

trialcode_egodist_T = [datafilt40.trialinfo(:,1) ones(length(datafilt40.trialinfo(:,1)),1)*NaN ones(length(datafilt40.trialinfo(:,1)),1)*NaN] ;
trialcode_egodist_S = [datafilt40.trialinfo(:,1) ones(length(datafilt40.trialinfo(:,1)),1)*NaN ones(length(datafilt40.trialinfo(:,1)),1)*NaN];

for i = 1:length(datafilt40.trialinfo(:,1))
    for j = 1:length(egoCORR_TABLE)
        if egoCORR_TABLE(j,1) == datafilt40.trialinfo(i,1)
            trialcode_egodist_T(i,2) = egoCORR_TABLE(j,2) ;
            trialcode_egodist_S(i,2) = egoCORR_TABLE(j,3) ;
        end
    end
end
 
count = [];
for i = 1:length(trialcode_egodist_T(:,2))
    if isnan(trialcode_egodist_T(i,2)) || isnan(trialcode_egodist_S(i,2))
        count = [count i];
    end
end
DATAMAT2 = DATAMAT;
trialcode_egodist_T2 = trialcode_egodist_T;
trialcode_egodist_S2 = trialcode_egodist_S;
DATAMAT2(:,:,count) = [];
trialcode_egodist_T2(count,:) = [];        
trialcode_egodist_S2(count,:) = [];   

corrvalt = [];
corrvals = [];
for i = 1:size(DATAMAT2,1)
    for j = 1:size(DATAMAT2,2)
        bt = corrcoef(trialcode_egodist_T2(:,2),squeeze(DATAMAT2(i,j,:)));
        bs = corrcoef(trialcode_egodist_S2(:,2),squeeze(DATAMAT2(i,j,:)));
        corrvalt_evs(i,j) = bt(2);
        corrvals_evs(i,j) = bs(2);
    end
end

subplot(2,2,1); imagesc(corrvalt_evt,[-0.1 0.1]); colorbar
subplot(2,2,2); imagesc(corrvals_evt,[-0.1 0.1]); colorbar
subplot(2,2,3); imagesc(corrvalt_evs,[-0.1 0.1]); colorbar
subplot(2,2,4); imagesc(corrvals_evs,[-0.1 0.1]); colorbar

addpath('/neurospin/meg/meg_tmp/temprod_Baptiste_2010/SCRIPTS/Matlab_pipeline/My_functions/Misc')
[FIND,BIND,VIND,LIND,RIND,FCHANS,BCHANS,VCHANS,LCHANS,RCHANS] = clusteranat('Network');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% import regression result from python to matlab for spatiotemporal cluster analysis in matlab
% "disguise the individual rgressio nscore across time as timelock data 
% compute" grand average
% cross fingers for having the result of your dreams 
% then insult those fucking statisticians
[Grads1,Grads2,Mags]   = grads_for_layouts('Network');
load('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/Python/REG_EVT_egoT_frompy.mat')
% dummy timelock structure
load('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/jm100042/MegData/ERFPs/EsDsq1A_EsDsq2A_EEG.mat')
for sub = 1:size(REG_EVT_egoDIST_py,1)
    
    timelockbase{1,1}.avg     = squeeze(REG_EVT_egoDIST_py(sub,:,:));
    timelockbase{1,1}.time    = time;
    timelockbase{1,1}.dof      = ones(size(REG_EVT_egoDIST_py,2),size(REG_EVT_egoDIST_py,3));
    timelockbase{1,1}.label    = chan';
    timelockbase{1,1}.dimord = 'chan_time';

    timelockbase{1,2}.avg     = zeros(size(REG_EVT_egoDIST_py,2),size(REG_EVT_egoDIST_py,3));
    timelockbase{1,2}.time    = time;
    timelockbase{1,2}.dof      = ones(size(REG_EVT_egoDIST_py,2),size(REG_EVT_egoDIST_py,3));
    timelockbase{1,2}.label    = chan';
    timelockbase{1,2}.dimord = 'chan_time';
    
    save(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' Subjects(sub,:) ...
        '/MegData/ERFPs/REGEVTegoT_ZERO_Mags.mat'],'timelockbase')
    save(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' Subjects(sub,:) ...
        '/MegData/ERFPs/REGEVTegoT_ZERO_Grads2.mat'],'timelockbase')
    save(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' Subjects(sub,:) ...
        '/MegData/ERFPs/REGEVTegoT_ZERO_Grads1.mat'],'timelockbase')   
end














