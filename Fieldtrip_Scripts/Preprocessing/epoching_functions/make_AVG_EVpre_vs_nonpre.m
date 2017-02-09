function [condnames,dataset] = make_AVG_EVpre_vs_nonpre(datasource,rejectvisual)

% corresponding triggercode in the name of individual files

TABLE{1,2}   = repmat([37:72]*1000,5,1) + ones(5,36)*60   + repmat([0 ;1 ;2 ;3 ;4],1,36);
TABLE{2,2}   = repmat([37:72]*1000,5,1) + ones(5,36)*80   + repmat([0 ;1 ;2 ;3 ;4],1,36);
TABLE{3,2}   = repmat([37:72]*1000,5,1) + ones(5,36)*100   + repmat([0 ;1 ;2 ;3 ;4],1,36);
TABLE{4,2}   = repmat([37:72]*1000,5,1) + ones(5,36)*120   + repmat([0 ;1 ;2 ;3 ;4],1,36);
TABLE{5,2}   = repmat([37:72]*1000,5,1) + ones(5,36)*140   + repmat([0 ;1 ;2 ;3 ;4],1,36);

TABLE{6,2}   = repmat([37:72]*1000,5,1) + ones(5,36)*70   + repmat([0 ;1 ;2 ;3 ;4],1,36);
TABLE{7,2}   = repmat([37:72]*1000,5,1) + ones(5,36)*90   + repmat([0 ;1 ;2 ;3 ;4],1,36);
TABLE{8,2}   = repmat([37:72]*1000,5,1) + ones(5,36)*110   + repmat([0 ;1 ;2 ;3 ;4],1,36);
TABLE{9,2}   = repmat([37:72]*1000,5,1) + ones(5,36)*130   + repmat([0 ;1 ;2 ;3 ;4],1,36);
TABLE{10,2}   = repmat([37:72]*1000,5,1) + ones(5,36)*150   + repmat([0 ;1 ;2 ;3 ;4],1,36);

for i = 1:length(datasource)
    datatmp{i} = load(datasource{i});
    rejecttmp{i} = load(rejectvisual{i});
end

%% condames
condnames = {'EtPre';'EtnoPre'};

%% trial selection
select_event{1} = [TABLE{1,2}(:) ];
select_event{2} = [TABLE{2,2}(:) TABLE{3,2}(:)];

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


