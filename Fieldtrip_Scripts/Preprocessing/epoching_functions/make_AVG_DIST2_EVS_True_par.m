function [condnames,dataset] = make_AVG_DIST2_EVS_True_Par(datasource,rejectvisual)

% corresponding triggercode in the name of individual files

TABLE{16,2}   = repmat([37:46 48 64 67:72]*1000,2,1) + ones(2,18)*70   + repmat([1 ;3],1,18);
TABLE{17,2}   = repmat([37:40 43 45 46 64 67:70]*1000,2,1) + ones(2,12)*90   + repmat([1 ;3],1,12);
TABLE{18,2}   = repmat([39:42 45 46 48 64 69:72]*1000,2,1) + ones(2,12)*110 + repmat([1 ;3],1,12);
TABLE{19,2}   = repmat([37:42 55:60]*1000,2,1) + ones(2,12)*130 + repmat([1 ;3],1,12);
TABLE{20,2}   = repmat([49:54 67:72]*1000,2,1) + ones(2,12)*150 + repmat([1 ;3],1,12);

TABLE{21,2}   = repmat([47 49:60 61 62 63 65 66]*1000,2,1) + ones(2,18)*70   + repmat([1 ;3],1,18);
TABLE{22,2}   = repmat([44 49:52 55:58 61 62 63]*1000,2,1) + ones(2,12)*90   + repmat([1 ;3],1,12);
TABLE{23,2}   = repmat([47 51:54 57:60 63 65 66]*1000,2,1) + ones(2,12)*110 + repmat([1 ;3],1,12);
TABLE{24,2}   = repmat([43:48 49:54]*1000,2,1) + ones(2,12)*130 + repmat([1 ;3],1,12);
TABLE{25,2}   = repmat([55:60 61:66]*1000,2,1) + ones(2,12)*150 + repmat([1 ;3],1,12);

for i = 1:length(datasource)
    datatmp{i} = load(datasource{i});
    rejecttmp{i} = load(rejectvisual{i});
end

%% condames
condnames = {'EsDsq1G_Par';'EsDsq2G_Par'};

%% trial selection
select_event{1} = [TABLE{16,2}(:) ]; 
select_event{2} = [TABLE{21,2}(:) ]; 

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
