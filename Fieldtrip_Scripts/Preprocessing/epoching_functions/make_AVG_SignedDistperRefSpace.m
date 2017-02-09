function [condnames,dataset] = make_AVG_SignedDistperRefSpace(datasource,rejectvisual)

% corresponding triggercode in the name of individual files

% west
TABLE{1}   = repmat([37:42]*1000,2,1) + ones(2,6)*130   + repmat([1  ;3 ],1,6);
TABLE{2}   = repmat([43:48]*1000,2,1) + ones(2,6)*130   + repmat([1  ;3 ],1,6);
TABLE{3}   = repmat([49:54]*1000,2,1) + ones(2,6)*130   + repmat([1  ;3 ],1,6);
TABLE{4}   = repmat([55:60]*1000,2,1) + ones(2,6)*130   + repmat([1  ;3 ],1,6);

% east
TABLE{5}   = repmat([49:54]*1000,2,1) + ones(2,6)*150   + repmat([1  ;3 ],1,6);
TABLE{6}   = repmat([55:60]*1000,2,1) + ones(2,6)*150   + repmat([1  ;3 ],1,6);
TABLE{7}   = repmat([61:66]*1000,2,1) + ones(2,6)*150   + repmat([1  ;3 ],1,6);
TABLE{8}   = repmat([67:72]*1000,2,1) + ones(2,6)*150   + repmat([1  ;3 ],1,6);

% paris
TABLE{9}   = repmat([37:42]*1000,2,1) + ones(2,6)*70   + repmat([1  ;3 ],1,6);
TABLE{10}  = repmat([43:48]*1000,2,1) + ones(2,6)*70   + repmat([1  ;3 ],1,6);
TABLE{11}  = repmat([49:54]*1000,2,1) + ones(2,6)*70   + repmat([1  ;3 ],1,6);
TABLE{12}  = repmat([55:60]*1000,2,1) + ones(2,6)*70   + repmat([1  ;3 ],1,6);
TABLE{13}  = repmat([61:66]*1000,2,1) + ones(2,6)*70   + repmat([1  ;3 ],1,6);
TABLE{14}  = repmat([67:72]*1000,2,1) + ones(2,6)*70   + repmat([1  ;3 ],1,6);

% % past
% TABLE{15}  = repmat([37:6:67]*1000,2,1) + ones(2,6)*80   + repmat([1  ;3 ],1,6);
% TABLE{16}  = repmat([38:6:68]*1000,2,1) + ones(2,6)*80   + repmat([1  ;3 ],1,6);
% TABLE{17}  = repmat([39:6:69]*1000,2,1) + ones(2,6)*80   + repmat([1  ;3 ],1,6);
% TABLE{18}  = repmat([40:6:70]*1000,2,1) + ones(2,6)*80   + repmat([1  ;3 ],1,6);
% 
% % fut
% TABLE{19}  = repmat([39:6:69]*1000,2,1) + ones(2,6)*100   + repmat([1  ;3 ],1,6);
% TABLE{20}  = repmat([40:6:70]*1000,2,1) + ones(2,6)*100   + repmat([1  ;3 ],1,6);
% TABLE{21}  = repmat([41:6:71]*1000,2,1) + ones(2,6)*100   + repmat([1  ;3 ],1,6);
% TABLE{22}  = repmat([42:6:72]*1000,2,1) + ones(2,6)*100   + repmat([1  ;3 ],1,6);
% 
% % pre
% TABLE{23}  = repmat([37:6:67]*1000,2,1) + ones(2,6)*60   + repmat([1  ;3 ],1,6);
% TABLE{24}  = repmat([38:6:68]*1000,2,1) + ones(2,6)*60   + repmat([1  ;3 ],1,6);
% TABLE{25}  = repmat([39:6:69]*1000,2,1) + ones(2,6)*60   + repmat([1  ;3 ],1,6);
% TABLE{26}  = repmat([40:6:70]*1000,2,1) + ones(2,6)*60   + repmat([1  ;3 ],1,6);
% TABLE{27}  = repmat([41:6:71]*1000,2,1) + ones(2,6)*60   + repmat([1  ;3 ],1,6);
% TABLE{28}  = repmat([42:6:72]*1000,2,1) + ones(2,6)*60   + repmat([1  ;3 ],1,6);

for i = 1:length(datasource)
    datatmp{i} = load(datasource{i});
    rejecttmp{i} = load(rejectvisual{i});
end

%% condames
condnames = {                     'RWsDS-2';'RWsDS-1';'RWsDS1';'RWsDS2';...
                                  'REsDS-2';'REsDS-1';'REsDS1';'REsDS2';...
                       'RHsDS-3';'RHsDS-2';'RHsDS-1';'RHsDS1';'RHsDS2';'RHsDS3'};

%% trial selection
select_event{1}  = [TABLE{1}(:) ]
select_event{2}  = [TABLE{2}(:) ]
select_event{3}  = [TABLE{3}(:) ]
select_event{4}  = [TABLE{4}(:) ]

select_event{5}  = [TABLE{5}(:) ]
select_event{6}  = [TABLE{6}(:) ]
select_event{7}  = [TABLE{7}(:) ]
select_event{8}  = [TABLE{8}(:) ]

select_event{9}  = [TABLE{9}(:) ]
select_event{10} = [TABLE{10}(:)]
select_event{11} = [TABLE{11}(:)]
select_event{12} = [TABLE{12}(:)]
select_event{13} = [TABLE{13}(:)]
select_event{14} = [TABLE{14}(:)]

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


