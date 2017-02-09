function [condnames,dataset] = make_AVG_DIST3_EVS_True(datasource,rejectvisual)

% corresponding triggercode in the name of individual files

TABLE{16,2}   = repmat([37:42 67:72]*1000,2,1) + ones(2,12)*70   + repmat([1 ;3],1,12);
TABLE{17,2}   = repmat([37:40 67:70]*1000,2,1) + ones(2,8)*90   + repmat([1 ;3],1,8);
TABLE{18,2}   = repmat([39:42 69:72]*1000,2,1) + ones(2,8)*110 + repmat([1 ;3],1,8);
TABLE{19,2}   = repmat([43:48 50 52]*1000,2,1) + ones(2,8)*130 + repmat([1 ;3],1,8);
TABLE{20,2}   = repmat([55 56 59 61 62 63 65 66]*1000,2,1) + ones(2,8)*150 + repmat([1 ;3],1,8);

TABLE{21,2}   = repmat([43:48 61:66]*1000,2,1) + ones(2,12)*70   + repmat([1 ;3],1,12);
TABLE{22,2}   = repmat([43:46 61:64]*1000,2,1) + ones(2,8)*90   + repmat([1 ;3],1,8);
TABLE{23,2}   = repmat([45:48 63:66]*1000,2,1) + ones(2,8)*110 + repmat([1 ;3],1,8);
TABLE{24,2}   = repmat([39 41 49 51 53 54 58 60]*1000,2,1) + ones(2,8)*130 + repmat([1 ;3],1,8);
TABLE{25,2}   = repmat([49 53 54 57 58 60 64 67]*1000,2,1) + ones(2,8)*150 + repmat([1 ;3],1,8);

TABLE{26,2}   = repmat([49:54 55:60]*1000,2,1) + ones(2,12)*70   + repmat([1 ;3],1,12);
TABLE{27,2}   = repmat([49:52 55:58]*1000,2,1) + ones(2,8)*90   + repmat([1 ;3],1,8);
TABLE{28,2}   = repmat([51:54 57:60]*1000,2,1) + ones(2,8)*110 + repmat([1 ;3],1,8);
TABLE{29,2}   = repmat([43:48 50 52]*1000,2,1) + ones(2,8)*130 + repmat([1 ;3],1,8);
TABLE{30,2}   = repmat([55 56 59 61 62 63 65 66]*1000,2,1) + ones(2,8)*150 + repmat([1 ;3],1,8);

for i = 1:length(datasource)
    datatmp{i} = load(datasource{i});
    rejecttmp{i} = load(rejectvisual{i});
end

%% condames
condnames = {'EsDsq1G';'EsDsq2G';'EsDsq3G'};

%% trial selection
select_event{1} = [TABLE{16,2}(:) ;TABLE{17,2}(:)  ;TABLE{18,2}(:)  ;TABLE{19,2}(:)  ;TABLE{20,2}(:) ]; 
select_event{2} = [TABLE{21,2}(:) ;TABLE{22,2}(:)  ;TABLE{23,2}(:)  ;TABLE{24,2}(:)  ;TABLE{25,2}(:) ]; 
select_event{3} = [TABLE{26,2}(:) ;TABLE{27,2}(:)  ;TABLE{28,2}(:)  ;TABLE{29,2}(:)  ;TABLE{30,2}(:) ]; 

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
