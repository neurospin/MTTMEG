function [condnames,dataset] = make_AVG_DIST2_EVT_True_Fut(datasource,rejectvisual)

% write list of trigger of interest for each REF cond
tstart = tic;

[TXT,NUM]   = xlsread('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/fordist/DATES_IMAGING_DEBRIEF_FINAL.xlsx');
[TXT2,NUM2] = xlsread('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/fordist/LONG_IMAGING_DEBRIEF_FINAL.xlsx');

TD_Pre    = abs(TXT - ones(6,6)*2013);
TD_Fut    = abs(TXT - ones(6,6)*2022);
TD_Pas    = abs(TXT - ones(6,6)*2004);
SD_Par    = ceil(abs(TXT2 - ones(6,6)*2.35));
SD_W      = ceil(abs(TXT2 - ones(6,6)*(-52.3)));
SD_E      = ceil(abs(TXT2 - ones(6,6)*(55.3)));
EVENT_ID  = [[1:6];[7:12];[13:18];[19:24];[25:30];[31:36]];

%% "quartilation" of temporal distance

y = []; a = []; a = TD_Pre;y = median(a(:));
TD_Pre_quartiled = a;
TD_Pre_quartiled(TD_Pre<=y) = 2;
TD_Pre_quartiled(TD_Pre>y) = 1;

y = []; a = []; a = TD_Fut(3:6,1:6);y = median(a(:));
TD_Fut_quartiled = a;
TD_Fut_quartiled(TD_Fut(3:6,1:6)<=y)  = 2;
TD_Fut_quartiled(TD_Fut(3:6,1:6)>y) = 1;

y = []; a = []; a = TD_Pas(1:4,1:6);y = median(a(:));
TD_Pas_quartiled = a;
TD_Pas_quartiled(TD_Pas(1:4,1:6)<=y) = 2;
TD_Pas_quartiled(TD_Pas(1:4,1:6)>y ) = 1;

y = []; a = []; a = TD_Pre(:,1:4);y = median(a(:));
TD_W_quartiled = a;
TD_W_quartiled(TD_Pre(:,1:4)<=y) = 2;
TD_W_quartiled(TD_Pre(:,1:4)>y ) = 1;

y = []; a = []; a = TD_Pre(:,3:6);y = median(a(:));
TD_E_quartiled = a;
TD_E_quartiled(TD_Pre(:,3:6)<=y) = 2;
TD_E_quartiled(TD_Pre(:,3:6)>y) = 1;

%% "quartilation" of spatial distance
y = []; a = []; a = SD_Par;y = median(a(:));
SD_Par_quartiled = a;
SD_Par_quartiled(SD_Par<=y) = 2;
SD_Par_quartiled(SD_Par>y) = 1;

y = []; a = []; a = SD_Par(1:4,:);y = median(a(:));
SD_Pas_quartiled = a;
SD_Pas_quartiled(SD_Par(1:4,:)<=y)  = 2;
SD_Pas_quartiled(SD_Par(1:4,:)>y) = 1;

y = []; a = []; a = SD_Par(3:6,:);y = median(a(:));
SD_Fut_quartiled = a;
SD_Fut_quartiled(SD_Par(3:6,:)<=y) = 2;
SD_Fut_quartiled(SD_Par(3:6,:)>y ) = 1;

y = []; a = []; a = SD_Par(:,1:4);y = median(a(:));
SD_W_quartiled = a;
SD_W_quartiled(SD_W(:,1:4)<=y) = 2;
SD_W_quartiled(SD_W(:,1:4)>y ) = 1;

y = []; a = []; a = SD_Par(:,3:6);y = median(a(:));
SD_E_quartiled = a;
SD_E_quartiled(SD_E(:,3:6)<=y) = 2;
SD_E_quartiled(SD_E(:,3:6)>y) = 1;


% corresponding triggercode in the name of individual files
TABLE{1,2}     = repmat([37 43 49 55 56 61 67 68 42 47 48 54 60 65 66 71 72]*1000,2,1) + ones(2,17)*60   + repmat([1  ;3 ],1,17);
TABLE{2,2}     = repmat([37 43 49 55 61 67 40 46 52 58 64 70]*1000,2,1) + ones(2,12)*80     + repmat([1  ;3 ],1,12);
TABLE{3,2}     = repmat([39 45 51 57 63 69 42 48 54 60 66 72]*1000,2,1) + ones(2,12)*100   + repmat([1  ;3 ],1,12);
TABLE{4,2}     = repmat([37 43 44 49 55 56 42 48 47 53 54 60]*1000,2,1) + ones(2,12)*120   + repmat([1  ;3 ],1,12);
TABLE{5,2}     = repmat([49 55 56 61 67 68 54 60 65 66 71 72]*1000,2,1) + ones(2,12)*140   + repmat([1  ;3 ],1,12);

TABLE{6,2}     = repmat([38 44 50 62 39 45 51 57 63 69 40 41 46 52 53 58 59 64 70]*1000,2,1) + ones(2,19)*60   + repmat([1  ;3 ],1,19);
TABLE{7,2}     = repmat([38 39 44 45 50 51 56 57 62 63 68 69]*1000,2,1) + ones(2,12)*80 + repmat([1  ;3 ],1,12);
TABLE{8,2}     = repmat([40 41 46 47 52 53 58 59 64 65 71 70]*1000,2,1) + ones(2,12)*100   + repmat([1  ;3 ],1,12);
TABLE{9,2}     = repmat([38 39 45 50 51 57 40 41 46 52 58 59]*1000,2,1) + ones(2,12)*120   + repmat([1  ;3 ],1,12);
TABLE{10,2}   = repmat([50 51 57 62 63 69 52 53 58 59 64 70]*1000,2,1) + ones(2,12)*140   + repmat([1  ;3 ],1,12);

for i = 1:length(datasource)
    datatmp{i} = load(datasource{i});
    rejecttmp{i} = load(rejectvisual{i});
end

%% condames
condnames = {'EtDtq1G_Fut';'EtDtq2G_Fut'};

%% trial selection
select_event{1} = [TABLE{3,2}(:) ]; 
select_event{2} = [TABLE{8,2}(:) ]; 

for i = 1:length(select_event)
    X{i} = [];
    for j =1:length(select_event{i});
        x = []; y= [];
         [x,y] = find(datatmp{1,1}.trldef(:,4) == select_event{i}(j));
         X{i} = [X{i}; x];
    end
    x = []; y= [];T{i} = [];
    [x,y] = find(rejecttmp{1,1}.trlsel == 1);
    T{i} = intersect(X{i},y);
end

for i =1:length(condnames)
    cfg.trials = T{i};
    if isfield(datatmp{1,1},'datafilt40') == 1
        dataset{1,i} = ft_redefinetrial(cfg,datatmp{1,1}.datafilt40);
    else
        dataset{1,i} = ft_redefinetrial(cfg,datatmp{1,1}.data);
    end
end

