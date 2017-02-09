function [condnames,dataset] = make_AVG_reltime_congruence(datasource,rejectvisual)

% corresponding triggercode in the name of individual files

% Relative Past irrespective of other conditions
TABLE{1,2}   = repmat([37:6:67 38:6:68 39:6:69]*1000,1,1) + ones(1,18)*60   + repmat([1],1,18);
TABLE{2,2}   = repmat([37:6:67 38:6:68]*1000,1,1) + ones(1,12)*80   + repmat([1],1,12);
TABLE{3,2}   = repmat([39:6:69 40:6:70]*1000,1,1) + ones(1,12)*100   + repmat([1],1,12);
TABLE{4,2}   = repmat([37:39 43:45 49:51 55:57]*1000,1,1) + ones(1,12)*120   + repmat([1],1,12);
TABLE{5,2}   = repmat([49:51 55:57 61:63 67:69]*1000,1,1) + ones(1,12)*140   + repmat([1],1,12);

% Relative Future irrespective of other conditions
TABLE{6,2}   = repmat([40:6:70 41:6:71 42:6:72]*1000,1,1) + ones(1,18)*60   + repmat([3],1,18);
TABLE{7,2}   = repmat([39:6:69 40:6:70]*1000,1,1) + ones(1,12)*80   + repmat([3],1,12);
TABLE{8,2}   = repmat([41:6:71 42:6:72]*1000,1,1) + ones(1,12)*100   + repmat([3],1,12);
TABLE{9,2}   = repmat([40:42 46:48 52:54 58:60]*1000,1,1) + ones(1,12)*120   + repmat([3],1,12);
TABLE{10,2}   = repmat([52:54 58:60 64:66 70:72]*1000,1,1) + ones(1,12)*140   + repmat([3],1,12);

% Relative Past irrespective of other conditions
TABLE{11,2}   = repmat([37:6:67 38:6:68 39:6:69]*1000,1,1) + ones(1,18)*60   + repmat([3],1,18);
TABLE{12,2}   = repmat([37:6:67 38:6:68]*1000,1,1) + ones(1,12)*80   + repmat([3],1,12);
TABLE{13,2}   = repmat([39:6:69 40:6:70]*1000,1,1) + ones(1,12)*100   + repmat([3],1,12);
TABLE{14,2}   = repmat([37:39 43:45 49:51 55:57]*1000,1,1) + ones(1,12)*120   + repmat([3],1,12);
TABLE{15,2}   = repmat([49:51 55:57 61:63 67:69]*1000,1,1) + ones(1,12)*140   + repmat([3],1,12);

% Relative Future irrespective of other conditions
TABLE{16,2}   = repmat([40:6:70 41:6:71 42:6:72]*1000,1,1) + ones(1,18)*60   + repmat([1],1,18);
TABLE{17,2}   = repmat([39:6:69 40:6:70]*1000,1,1) + ones(1,12)*80   + repmat([1],1,12);
TABLE{18,2}   = repmat([41:6:71 42:6:72]*1000,1,1) + ones(1,12)*100   + repmat([1],1,12);
TABLE{19,2}   = repmat([40:42 46:48 52:54 58:60]*1000,1,1) + ones(1,12)*120   + repmat([1],1,12);
TABLE{20,2}   = repmat([52:54 58:60 64:66 70:72]*1000,1,1) + ones(1,12)*140   + repmat([1],1,12);


for i = 1:length(datasource)
    datatmp{i} = load(datasource{i});
    rejecttmp{i} = load(rejectvisual{i});
end

%% condames
condnames = {'Reltime_con';'Reltime_incon'};

%% trial selection
select_event{1} = [TABLE{1,2}(:);  TABLE{2,2}(:);  TABLE{3,2}(:);  TABLE{4,2}(:);  TABLE{5,2}(:) ; TABLE{6,2}(:);  TABLE{7,2}(:);  TABLE{8,2}(:);  TABLE{9,2}(:);  TABLE{10,2}(:)];
select_event{2} = [TABLE{11,2}(:); TABLE{12,2}(:); TABLE{13,2}(:); TABLE{14,2}(:); TABLE{15,2}(:); TABLE{16,2}(:); TABLE{17,2}(:); TABLE{18,2}(:); TABLE{19,2}(:); TABLE{20,2}(:)];

if length(datasource) >= 2
    datatmp{1,1}.datafilt40  = ft_appenddata([],datatmp{1,1}.datafilt40,datatmp{1,2}.datafilt40);
    datatmp{1,1}.trldef        = [datatmp{1,1}.trldef ;datatmp{1,2}.trldef ];
    rejecttmp{1,1}.trlsel       = [rejecttmp{1,1}.trlsel rejecttmp{1,2}.trlsel ];
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


