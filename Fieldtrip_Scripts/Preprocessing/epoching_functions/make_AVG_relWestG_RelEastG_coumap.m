function [condnames,dataset] = make_AVG_relWestG_RelEastG_coumap(datasource,rejectvisual)

% corresponding triggercode in the name of individual files

% Relative West irrespective of other conditions
TABLE{1,2}   = repmat([37:42 43:48 49:54]*1000,1,1) + ones(1,18)*70   + repmat([3],1,18);
TABLE{2,2}   = repmat([37:40 43:46 49:52]*1000,1,1) + ones(1,12)*90   + repmat([3],1,12);
TABLE{3,2}   = repmat([39:42 45:48 51:54]*1000,1,1) + ones(1,12)*110   + repmat([3],1,12);
TABLE{4,2}   = repmat([37:42 43:48]*1000,1,1) + ones(1,12)*130   + repmat([3],1,12);
TABLE{5,2}   = repmat([49:54 55:60]*1000,1,1) + ones(1,12)*150   + repmat([3],1,12);

% Relative East irrespective of other conditions
TABLE{6,2}   = repmat([55:60 61:66 67:72]*1000,1,1) + ones(1,18)*70   + repmat([1],1,18);
TABLE{7,2}   = repmat([55:58 61:64 67:70]*1000,1,1) + ones(1,12)*90   + repmat([1],1,12);
TABLE{8,2}   = repmat([57:60 63:66 69:72]*1000,1,1) + ones(1,12)*110   + repmat([1],1,12);
TABLE{9,2}   = repmat([49:54 55:60]*1000,1,1) + ones(1,12)*130   + repmat([1],1,12);
TABLE{10,2}   = repmat([61:66 67:72]*1000,1,1) + ones(1,12)*150   + repmat([1],1,12);

for i = 1:length(datasource)
    datatmp{i} = load(datasource{i});
    rejecttmp{i} = load(rejectvisual{i});
end

%% condames
condnames = {'RelWestG_coumap';'RelEastG_coumap'};

%% trial selection
select_event{1} = [TABLE{1,2}(:); TABLE{2,2}(:); TABLE{3,2}(:); TABLE{4,2}(:); TABLE{5,2}(:)];
select_event{2} = [TABLE{6,2}(:); TABLE{7,2}(:); TABLE{8,2}(:); TABLE{9,2}(:); TABLE{10,2}(:)];

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


