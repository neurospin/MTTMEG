function [condnames,dataset] = make_AVG_DIST3_EVT(datasource,rejectvisual)

% corresponding triggercode in the name of individual files
TABLE{1,2}     = repmat([37 43 49 55 61 67 42 48 54 60 66 72]*1000,5,1) + ones(5,12)*60   + repmat([0 ;1 ;2 ;3 ;4],1,12);
TABLE{2,2}     = repmat([37 43 55 61 46 52 64 70]*1000,5,1) + ones(5,8)*80     + repmat([0 ;1 ;2 ;3 ;4],1,8);
TABLE{3,2}     = repmat([39 45 51 57 42 54 66 72]*1000,5,1) + ones(5,8)*100   + repmat([0 ;1 ;2 ;3 ;4],1,8);
TABLE{4,2}     = repmat([37 43 49 55 42 48 54 60]*1000,5,1) + ones(5,8)*120   + repmat([0 ;1 ;2 ;3 ;4],1,8);
TABLE{5,2}     = repmat([49 55 61 67 54 60 66 72]*1000,5,1) + ones(5,8)*140   + repmat([0 ;1 ;2 ;3 ;4],1,8);

TABLE{6,2}     = repmat([38 44 50 56 62 68 41 47 53 59 65 71]*1000,5,1) + ones(5,12)*60   + repmat([0 ;1 ;2 ;3 ;4],1,12);
TABLE{7,2}     = repmat([49 67 56 68 57 63 69 40 58]*1000,5,1) + ones(5,9)*80 + repmat([0 ;1 ;2 ;3 ;4],1,9);
TABLE{8,2}     = repmat([63 69 40 58 47 71 48 60 ]*1000,5,1) + ones(5,8)*100   + repmat([0 ;1 ;2 ;3 ;4],1,8);
TABLE{9,2}     = repmat([38 44 50 56 41 47 53 59 ]*1000,5,1) + ones(5,8)*120   + repmat([0 ;1 ;2 ;3 ;4],1,8);
TABLE{10,2}   = repmat([50 56 62 68 53 59 65 71 ]*1000,5,1) + ones(5,8)*140   + repmat([0 ;1 ;2 ;3 ;4],1,8);

TABLE{11,2}   = repmat([39 45 51 57 63 69 40 46 52 58 64 70]*1000,5,1) + ones(5,12)*60   + repmat([0 ;1 ;2 ;3 ;4],1,12);
TABLE{12,2}   = repmat([38 44 50 62 39 45 51]*1000,5,1) + ones(5,7)*80   + repmat([0 ;1 ;2 ;3 ;4],1,7);
TABLE{13,2}   = repmat([46 52 64 70 41 53 59 65 ]*1000,5,1) + ones(5,8)*100   + repmat([0 ;1 ;2 ;3 ;4],1,8);
TABLE{14,2}   = repmat([39 54 51 57 40 46 52 58]*1000,5,1) + ones(5,8)*120   + repmat([0 ;1 ;2 ;3 ;4],1,8);
TABLE{15,2}   = repmat([51 57 63 69 52 58 64 70]*1000,5,1) + ones(5,8)*140   + repmat([0 ;1 ;2 ;3 ;4],1,8);

TABLE{16,2}   = repmat([37:42 67:72]*1000,5,1) + ones(5,12)*70   + repmat([0 ;1 ;2 ;3 ;4],1,12);
TABLE{17,2}   = repmat([37:40 67:70]*1000,5,1) + ones(5,8)*90   + repmat([0 ;1 ;2 ;3 ;4],1,8);
TABLE{18,2}   = repmat([39:42 69:72]*1000,5,1) + ones(5,8)*110 + repmat([0 ;1 ;2 ;3 ;4],1,8);
TABLE{19,2}   = repmat([43:48 50 52]*1000,5,1) + ones(5,8)*130 + repmat([0 ;1 ;2 ;3 ;4],1,8);
TABLE{20,2}   = repmat([55 56 59 61 62 63 65 66]*1000,5,1) + ones(5,8)*150 + repmat([0 ;1 ;2 ;3 ;4],1,8);

TABLE{21,2}   = repmat([43:48 61:66]*1000,5,1) + ones(5,12)*70   + repmat([0 ;1 ;2 ;3 ;4],1,12);
TABLE{22,2}   = repmat([43:46 61:64]*1000,5,1) + ones(5,8)*90   + repmat([0 ;1 ;2 ;3 ;4],1,8);
TABLE{23,2}   = repmat([45:48 63:66]*1000,5,1) + ones(5,8)*110 + repmat([0 ;1 ;2 ;3 ;4],1,8);
TABLE{24,2}   = repmat([39 41 49 51 53 54 58 60]*1000,5,1) + ones(5,8)*130 + repmat([0 ;1 ;2 ;3 ;4],1,8);
TABLE{25,2}   = repmat([49 53 54 57 58 60 64 67]*1000,5,1) + ones(5,8)*150 + repmat([0 ;1 ;2 ;3 ;4],1,8);

TABLE{26,2}   = repmat([49:54 55:60]*1000,5,1) + ones(5,12)*70   + repmat([0 ;1 ;2 ;3 ;4],1,12);
TABLE{27,2}   = repmat([49:52 55:58]*1000,5,1) + ones(5,8)*90   + repmat([0 ;1 ;2 ;3 ;4],1,8);
TABLE{28,2}   = repmat([51:54 57:60]*1000,5,1) + ones(5,8)*110 + repmat([0 ;1 ;2 ;3 ;4],1,8);
TABLE{29,2}   = repmat([43:48 50 52]*1000,5,1) + ones(5,8)*130 + repmat([0 ;1 ;2 ;3 ;4],1,8);
TABLE{30,2}   = repmat([55 56 59 61 62 63 65 66]*1000,5,1) + ones(5,8)*150 + repmat([0 ;1 ;2 ;3 ;4],1,8);

for i = 1:length(datasource)
    datatmp{i} = load(datasource{i});
    rejecttmp{i} = load(rejectvisual{i});
end

%% condames
condnames = {'EtDtq1A';'EtDtq2A';'EtDtq3A'};

%% trial selection
select_event{1} = [TABLE{1,2}(:) ;TABLE{2,2}(:)  ;TABLE{3,2}(:)  ;TABLE{4,2}(:)  ;TABLE{5,2}(:) ]; 
select_event{2} = [TABLE{6,2}(:) ;TABLE{7,2}(:)  ;TABLE{8,2}(:)  ;TABLE{9,2}(:)  ;TABLE{10,2}(:) ]; 
select_event{3} = [TABLE{11,2}(:) ;TABLE{12,2}(:)  ;TABLE{13,2}(:)  ;TABLE{14,2}(:)  ;TABLE{15,2}(:) ]; 

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
