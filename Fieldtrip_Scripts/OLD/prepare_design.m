function [VecPred,IND,timelockbaset] = prepare_design(nip,chansel,source,segwin,latency)

%% load subject datafilt40set
for i = 1:size(source,1)
    datafilt40source= ['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/'...
        nip '/MegData/Processed_new/' source '_dat_filt40'];
    rejectvisual = ['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/'...
        nip '/MegData/Processed_new/' source '_rejectvisual'];
end
load(datafilt40source)
load(rejectvisual)

trig = [6 7 8 9 10 11 12 13 14 15];
ref  = [1 1 2 2 3   3   4   4   5   5  ];
dj   = [1 2 1 2 1   2   1   2   1   2  ];

%% prepare REF predictor and DJ predictor
for i =1:length(trldef)
    tmp = [];tmp = num2str(trldef(i,4));
    for j = 1:10
        if str2num(tmp([3 4])) == trig(j)
            REFpred(i) = ref(j);
            DJpred(i) = dj(j);
        end
    end
end

[TXT,NUM]   = xlsread('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/fordist/DATES_IMAGING_DEBRIEF_FINAL.xlsx');
[TXT2,NUM2] = xlsread('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/fordist/LONG_IMAGING_DEBRIEF_FINAL.xlsx');

TD_Pre    = abs(TXT - ones(6,6)*2013);
TD_Fut    = abs(TXT - ones(6,6)*2022);
TD_Pas    = abs(TXT - ones(6,6)*2004);
SD_Par    = ceil(abs(TXT2 - ones(6,6)*2.35));
SD_W      = ceil(abs(TXT2 - ones(6,6)*(-52.3)));
SD_E      = ceil(abs(TXT2 - ones(6,6)*(55.3)));
EVENT_ID  = [[1:6];[7:12];[13:18];[19:24];[25:30];[31:36]]'+ones(6,6)*36;

T_dist_trig = {{TD_Pre(:)};{TD_Pas(:)};{TD_Fut(:)};{TD_Pre(:)};{TD_Pre(:)}};
S_dist_trig = {{SD_Par(:)};{SD_Par(:)};{SD_Par(:)};{SD_W(:)};{SD_E(:)}};

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% "quartilation" of temporal distance

y = []; a = []; a = TD_Pre;y = quantile(a(:),3);
TD_Pre_quartiled = a;
TD_Pre_quartiled(TD_Pre<=5.5) = 4;
TD_Pre_quartiled(TD_Pre>5.5  & TD_Pre <12) = 3;
TD_Pre_quartiled(TD_Pre>=12  & TD_Pre <20.5) = 2;
TD_Pre_quartiled(TD_Pre>=20.5) = 1;

y = []; a = []; a = TD_Fut(3:6,1:6);y = quantile(a(:),3);
TD_Fut_quartiled = a;
TD_Fut_quartiled(TD_Fut(3:6,1:6)<=5.5)  = 4;
TD_Fut_quartiled(TD_Fut(3:6,1:6)>5.5  & TD_Fut(3:6,1:6) <9) = 3;
TD_Fut_quartiled(TD_Fut(3:6,1:6)>=9  & TD_Fut(3:6,1:6) <14) = 2;
TD_Fut_quartiled(TD_Fut(3:6,1:6)>=14) = 1;

y = []; a = []; a = TD_Pas(1:4,1:6);y = quantile(a(:),3);
TD_Pas_quartiled = a;
TD_Pas_quartiled(TD_Pas(1:4,1:6)<=3) = 4;
TD_Pas_quartiled(TD_Pas(1:4,1:6)>3 & TD_Pas(1:4,1:6) <9) = 3;
TD_Pas_quartiled(TD_Pas(1:4,1:6)>=9 & TD_Pas(1:4,1:6) <12) = 2;
TD_Pas_quartiled(TD_Pas(1:4,1:6)>=12) = 1;

y = []; a = []; a = TD_Pre(:,1:4);y = quantile(a(:),3);
TD_W_quartiled = a;
TD_W_quartiled(TD_Pre(:,1:4)<=6) = 4;
TD_W_quartiled(TD_Pre(:,1:4)>6 & TD_Pre(:,1:4) <11.5) = 3;
TD_W_quartiled(TD_Pre(:,1:4)>=11.5 & TD_Pre(:,1:4) <20) = 2;
TD_W_quartiled(TD_Pre(:,1:4)>=20) = 1;

y = []; a = []; a = TD_Pre(:,3:6);y = quantile(a(:),3);
TD_E_quartiled = a;
TD_E_quartiled(TD_Pre(:,3:6)<=4.5) = 4;
TD_E_quartiled(TD_Pre(:,3:6)>4.5 & TD_Pre(:,3:6) <12.5) = 3;
TD_E_quartiled(TD_Pre(:,3:6)>=12.5 & TD_Pre(:,3:6) <20.5) = 2;
TD_E_quartiled(TD_Pre(:,3:6)>=20.5) = 1;

%% "quartilation" of spatial distance
y = []; a = []; a = SD_Par;y = quantile(a(:),3);
SD_Par_quartiled = a;
SD_Par_quartiled(SD_Par<=33.5) = 4;
SD_Par_quartiled(SD_Par>33.5  & SD_Par <76.5) = 3;
SD_Par_quartiled(SD_Par>=76.5  & SD_Par <118) = 2;
SD_Par_quartiled(SD_Par>=118) = 1;

y = []; a = []; a = SD_W(1:6,1:4);y = quantile(a(:),3);
SD_W_quartiled = a;
SD_W_quartiled(SD_W(1:6,1:4)<=38) = 4;
SD_W_quartiled(SD_W(1:6,1:4)>38  & SD_W(1:6,1:4) <54) = 3;
SD_W_quartiled(SD_W(1:6,1:4)>=54  & SD_W(1:6,1:4) <70) = 2;
SD_W_quartiled(SD_W(1:6,1:4)>=70) = 1;

y = []; a = []; a = SD_E(1:6,3:6);y = quantile(a(:),3);
SD_E_quartiled = a;
SD_E_quartiled(SD_E(1:6,3:6)<=20.5) = 4;
SD_E_quartiled(SD_E(1:6,3:6)>20.5  & SD_E(1:6,3:6) <49.5) = 3;
SD_E_quartiled(SD_E(1:6,3:6)>=49.5  & SD_E(1:6,3:6) <65) = 2;
SD_E_quartiled(SD_E(1:6,3:6)>=65) = 1;

y = []; a = []; a = SD_Par(1:4,:);y = quantile(a(:),3);
SD_Pas_quartiled = a;
SD_Pas_quartiled(SD_Par(1:4,:)<=38) = 4;
SD_Pas_quartiled(SD_Par(1:4,:)>38  & SD_Par(1:4,:) <80) = 3;
SD_Pas_quartiled(SD_Par(1:4,:)>=80  & SD_Par(1:4,:) <118.5) = 2;
SD_Pas_quartiled(SD_Par(1:4,:)>=118.5) = 1;

y = []; a = []; a = SD_Par(3:6,:);y = quantile(a(:),3);
SD_Fut_quartiled = a;
SD_Fut_quartiled(SD_Par(3:6,:)<=25.5) = 4;
SD_Fut_quartiled(SD_Par(3:6,:)>25.5  & SD_Par(3:6,:) <78) = 3;
SD_Fut_quartiled(SD_Par(3:6,:)>=78  & SD_Par(3:6,:) <118) = 2;
SD_Fut_quartiled(SD_Par(3:6,:)>=118) = 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% prepare distance predictors
for i =1:length(trldef)
    tmp = [];tmp = num2str(trldef(i,4));
    for j = 1:36
        if str2num(tmp([1 2])) == EVENT_ID(j)
            if REFpred(i) == 1
                DistTPred(i) = T_dist_trig{1}{1}(j);
                DistSPred(i) = S_dist_trig{1}{1}(j);
            elseif REFpred(i) == 2
                DistTPred(i) = T_dist_trig{2}{1}(j);
                DistSPred(i) = S_dist_trig{2}{1}(j);
            elseif REFpred(i) == 3
                DistTPred(i) = T_dist_trig{3}{1}(j);
                DistSPred(i) = S_dist_trig{3}{1}(j);
            elseif REFpred(i) == 4
                DistTPred(i) = T_dist_trig{4}{1}(j);
                DistSPred(i) = S_dist_trig{4}{1}(j);
            elseif REFpred(i) == 5
                DistTPred(i) = T_dist_trig{5}{1}(j);
                DistSPred(i) = S_dist_trig{5}{1}(j);
            end
        end
    end
end

% VecPred = [REFpred==1;...
%     REFpred==2;...
%     REFpred==3;...
%     REFpred==4;...
%     REFpred==5;...
%     DJpred == 1;...
%     DJpred == 2;...
%     DistTPred;...
%     DistSPred]';

VecPred = [
    DJpred == 1;...
    DJpred == 2;...
    DistTPred;...
    DistSPred]';

% VecPred = [
%     DistTPred;...
%     DistSPred]';

%% get all possible combinations (132 or 133)
[C,IA,IC] = unique(VecPred,'rows');
for i =1:length(VecPred)
    for j =1:length(C)
        if sum(VecPred(i,:) == VecPred(IA(j),:)) == size(VecPred,2)
            IND(i)= j;
        end
    end
end
    
%% baseline and realign temporally the dataset
% define channel types
[Grads1,Grads2,Mags]   = grads_for_layouts('Network');
EEG  = EEG_for_layouts('Network');

ch = [];
if strcmp(chansel,'Mags')
    ch = Mags;
elseif strcmp(chansel,'Grads1')
    ch = Grads1;
elseif strcmp(chansel,'Grads2')
    ch = Grads2;
elseif strcmp(chansel,'GradComb')
    ch = Grads1; %temporary
else strcmp(chansel,'EEG')
    ch = EEG;
end

for i = 1:length(datafilt40)
    
    % temporal realignment
    for j = 1:length(datafilt40.time)
        datafilt40.time{1,j} = datafilt40.time{1,j} - ones(1,length(datafilt40.time{1,j}))*(segwin(1));
    end
    
%     cut datafilt40 
    cfg          = [];
    cfg.toilim = latency;
    datafilt40  = ft_redefinetrial(cfg,datafilt40);   
    
    % for stats
    cfg                        = [];
    cfg.channel            = ch;
    cfg.keeptrials         = 'yes';
    cfg.removemean     = 'yes';
    cfg.covariance        = 'yes';
    cfg.vartrllength       = 2;
    datafilt40lockt{i}             = ft_timelockanalysis(cfg, datafilt40);
    
    % baseline correction
    cfg                        = [];
    cfg.baseline           = [latency(1) 0];
    cfg.channel            = 'all';
    timelockbaset{i}      = ft_timelockbaseline(cfg, datafilt40lockt{i});

end





