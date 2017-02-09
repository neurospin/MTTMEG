function [condnames,dataset] = make_AVG_SignedDistperRefTimeFullRange(datasource,rejectvisual)

% corresponding triggercode in the name of individual files

% past
PAS  = [repmat([37:6:67]*1000,2,1) + ones(2,6)*80   + repmat([1  ;3 ],1,6) ...
         repmat([38:6:68]*1000,2,1) + ones(2,6)*80   + repmat([1  ;3 ],1,6) ...
         repmat([39:6:69]*1000,2,1) + ones(2,6)*80   + repmat([1  ;3 ],1,6) ...
         repmat([40:6:70]*1000,2,1) + ones(2,6)*80   + repmat([1  ;3 ],1,6)];

[TXT,NUM]   = xlsread('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/fordist/DATES_IMAGING_DEBRIEF_FINAL.xlsx');
TD_Pas      = (TXT - ones(6,6)*2004);     
TD_Pas      = TD_Pas(1:4,:); 
IndexPas    = [[1  2  3  4  5  6 ] [7  8  9  10 11 12] ...
               [13 14 15 16 17 18] [19 20 21 22 23 24]];

% fut
FUT  = [repmat([39:6:69]*1000,2,1) + ones(2,6)*100  + repmat([1  ;3 ],1,6) ...
        repmat([40:6:70]*1000,2,1) + ones(2,6)*100  + repmat([1  ;3 ],1,6) ...
        repmat([41:6:71]*1000,2,1) + ones(2,6)*100  + repmat([1  ;3 ],1,6) ...
        repmat([42:6:72]*1000,2,1) + ones(2,6)*100  + repmat([1  ;3 ],1,6)];

TD_Fut    = (TXT - ones(6,6)*2022);   
TD_Fut    = TD_Fut(3:6,:);
IndexFut  = [[1  2  3  4  5  6 ] [7  8  9  10 11 12] ...
             [13 14 15 16 17 18] [19 20 21 22 23 24]];

% pre
PRE  = [repmat([37:6:67]*1000,2,1) + ones(2,6)*60   + repmat([1  ;3 ],1,6) ...
        repmat([38:6:68]*1000,2,1) + ones(2,6)*60   + repmat([1  ;3 ],1,6) ...
        repmat([39:6:69]*1000,2,1) + ones(2,6)*60   + repmat([1  ;3 ],1,6) ...
        repmat([40:6:70]*1000,2,1) + ones(2,6)*60   + repmat([1  ;3 ],1,6) ...
        repmat([41:6:71]*1000,2,1) + ones(2,6)*60   + repmat([1  ;3 ],1,6) ...
        repmat([42:6:72]*1000,2,1) + ones(2,6)*60   + repmat([1  ;3 ],1,6)];

TD_Pre    = (TXT - ones(6,6)*2013);
IndexPre  = [[1  2  3  4  5  6 ] [7  8  9  10 11 12] ...
             [13 14 15 16 17 18] [19 20 21 22 23 24] ...
             [25 26 27 28 29 30] [31 32 33 34 35 36]];

% w
W  = [repmat([37:60]*1000,2,1) + ones(2,24)*120 + repmat([1 ;3],1,24)];
    
TD_W    = (TXT - ones(6,6)*2013);
TD_W    = TD_W(:,1:4);
IndexW  = [[1  2  3  4] [7  8  9  10 ] ...
             [13 14 15 16 ] [19 20 21 22 ] ...
             [25 26 27 28 ] [31 32 33 34 ]];         

% w
E    = [repmat([49:72]*1000,2,1)  + ones(2,24)*140 + repmat([1 ;3],1,24)];
    
TD_E    = (TXT - ones(6,6)*2013);
TD_E    = TD_E(:,3:6);
IndexE  = [[3  4  5  6 ] [9  10 11 12] ...
             [15 16 17 18] [21 22 23 24] ...
             [27 28 29 30] [33 34 35 36]];        
                  
         
for i = 1:length(datasource)
    datatmp{i} = load(datasource{i});
    rejecttmp{i} = load(rejectvisual{i});
end

%% trial selection & condnames
for i = 1:24
    select_event{i}  = PAS(:,i);
    condnames{i} = ['Pas' num2str(IndexPas(i))];
end
for i = 25:48
    select_event{i}  = FUT(:,i-24);
    condnames{i} = ['Fut' num2str(IndexFut(i-24))];
end
for i = 49:84
    select_event{i}  = PRE(:,i-48);
    condnames{i} = ['Pre' num2str(IndexPre(i-48))];
end
for i = 85:108
    select_event{i}  = W(:,i-84);
    condnames{i} = ['W' num2str(IndexW(i-84))];
end
for i = 109:132
    select_event{i}  = E(:,i-108);
    condnames{i} = ['E' num2str(IndexE(i-108))];
end

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


