function [condnames,dataset,dist_val,tag] = make_AVG_signDIST36_EVT_W_True(datasource,rejectvisual)

% write list of trigger of interest for each REF cond
tstart = tic;

[TXT,NUM]   = xlsread('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/fordist/DATES_IMAGING_DEBRIEF_FINAL.xlsx');
[TXT2,NUM2] = xlsread('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/fordist/LONG_IMAGING_DEBRIEF_FINAL.xlsx');

TD_Pre    = (TXT - ones(6,6)*2013);
TD_Fut    = (TXT - ones(6,6)*2022);
TD_Pas    = (TXT - ones(6,6)*2004);
TD_W      = (TXT - ones(6,6)*2013);
TD_E      = (TXT - ones(6,6)*2013);

SD_Par    = ceil(abs(TXT2 - ones(6,6)*2.35));
SD_Pas    = ceil(abs(TXT2 - ones(6,6)*2.35));
SD_Fut    = ceil(abs(TXT2 - ones(6,6)*2.35));
SD_W      = ceil(abs(TXT2 - ones(6,6)*(-52.3)));
SD_E      = ceil(abs(TXT2 - ones(6,6)*(55.3)));

TD_Pas    = TD_Pas(1:4,:);
SD_Pas    = SD_Pas(1:4,:);
TD_Fut    = TD_Fut(3:6,:);
SD_Fut    = SD_Fut(3:6,:);
TD_W      = TD_W(:,1:4);
SD_W      = SD_W(:,1:4);
TD_E      = TD_E(:,3:6); 
SD_E      = SD_E(:,3:6); 

EVT_Pre  = repmat([37:72]*1000,2,1)                               + ones(2,36)*60  + repmat([1 ;3],1,36);
EVT_Pas  = repmat([37:40 43:46 49:52 55:58 61:64 67:70]*1000,2,1) + ones(2,24)*80  + repmat([1 ;3],1,24);
EVT_Fut  = repmat([39:42 45:48 51:54 57:60 63:66 69:72]*1000,2,1) + ones(2,24)*100 + repmat([1 ;3],1,24);
EVT_W    = repmat([37:60]*1000,2,1)                               + ones(2,24)*120 + repmat([1 ;3],1,24);
EVT_E    = repmat([49:72]*1000,2,1)                               + ones(2,24)*140 + repmat([1 ;3],1,24);

EVS_Pre  = repmat([37:72]*1000,2,1)                               + ones(2,36)*70  + repmat([1 ;3],1,36);
EVS_Pas  = repmat([37:40 43:46 49:52 55:58 61:64 67:70]*1000,2,1) + ones(2,24)*90  + repmat([1 ;3],1,24);
EVS_Fut  = repmat([39:42 45:48 51:54 57:60 63:66 69:72]*1000,2,1) + ones(2,24)*110 + repmat([1 ;3],1,24);
EVS_W    = repmat([37:60]*1000,2,1)                               + ones(2,24)*130 + repmat([1 ;3],1,24);
EVS_E    = repmat([49:72]*1000,2,1)                               + ones(2,24)*150 + repmat([1 ;3],1,24);

tmp1      = [TD_Pre(:)';TD_Pre(:)']
tmp2      = [TD_Pas(:)';TD_Pas(:)']
tmp3      = [TD_Fut(:)';TD_Fut(:)']
tmp4      = [TD_W(:)'  ;TD_W(:)'  ]
tmp5      = [TD_E(:)'  ;TD_E(:)'  ]

all_distT = [ tmp4(:)]
all_EVT   = [EVT_W(:)];

tag = 'SignEVTdistT_W'

%% select events
dist_val = all_distT;

select_event = [];
for i = 1:length(all_distT)/2
    select_event{i} = all_EVT((2*i-1):(2*i));
end

%% condames
for i = 1:length(select_event)
    condnames{i} = {['sDT_W' num2str(dist_val(i))]}
end


for i = 1:length(datasource)
    datatmp{i} = load(datasource{i});
    rejecttmp{i} = load(rejectvisual{i});
end

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
