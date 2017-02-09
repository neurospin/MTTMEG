function [condnames,dataset] = make_AVG_DIST2_EVT(datasource,rejectvisual)

% corresponding triggercode in the name of individual files
TABLE{1,2}     = repmat([37 43 49 55 56 61 67 68 42 47 48 54 60 65 66 71 72]*1000,5,1) + ones(5,17)*60   + repmat([0;1;2;3;4],1,17);
TABLE{2,2}     = repmat([37 43 49 55 61 67 40 46 52 58 64 70]*1000,5,1) + ones(5,12)*80     + repmat([0;1;2;3;4],1,12);
TABLE{3,2}     = repmat([39 45 51 57 63 69 42 48 54 60 66 72]*1000,5,1) + ones(5,12)*100   + repmat([0;1;2;3;4],1,12);
TABLE{4,2}     = repmat([37 43 44 49 55 56 42 48 47 53 54 60]*1000,5,1) + ones(5,12)*120   + repmat([0;1;2;3;4],1,12);
TABLE{5,2}     = repmat([49 55 56 61 67 68 54 60 65 66 71 72]*1000,5,1) + ones(5,12)*140   + repmat([0;1;2;3;4],1,12);

TABLE{6,2}     = repmat([38 44 50 62 39 45 51 57 63 69 40 41 46 52 53 58 59 64 70]*1000,5,1) + ones(5,19)*60   + repmat([0;1;2;3;4],1,19);
TABLE{7,2}     = repmat([38 39 44 45 50 51 56 57 62 63 68 69]*1000,5,1) + ones(5,12)*80 + repmat([0;1;2;3;4],1,12);
TABLE{8,2}     = repmat([40 41 46 47 52 53 58 59 64 65 71 70]*1000,5,1) + ones(5,12)*100   + repmat([0;1;2;3;4],1,12);
TABLE{9,2}     = repmat([38 39 45 50 51 57 40 41 46 52 58 59]*1000,5,1) + ones(5,12)*120   + repmat([0;1;2;3;4],1,12);
TABLE{10,2}   = repmat([50 51 57 62 63 69 52 53 58 59 64 70]*1000,5,1) + ones(5,12)*140   + repmat([0;1;2;3;4],1,12);

for i = 1:length(datasource)
    datatmp{i} = load(datasource{i});
    rejecttmp{i} = load(rejectvisual{i});
end

%% condames
condnames = {'EtDtq1A';'EtDtq2A'};

%% trial selection
select_event{1} = [TABLE{1,2}(:) ;TABLE{2,2}(:)  ;TABLE{3,2}(:)  ;TABLE{4,2}(:)  ;TABLE{5,2}(:) ]; 
select_event{2} = [TABLE{6,2}(:) ;TABLE{7,2}(:)  ;TABLE{8,2}(:)  ;TABLE{9,2}(:)  ;TABLE{10,2}(:) ]; 

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
