function [condnames,dataset] = make_AVG_SignedDistperRefSpaceFullRange(datasource,rejectvisual)

% corresponding triggercode in the name of individual files

% west
W  = [repmat([37:42]*1000,2,1) + ones(2,6)*130   + repmat([1  ;3 ],1,6) ...
      repmat([43:48]*1000,2,1) + ones(2,6)*130   + repmat([1  ;3 ],1,6) ...
      repmat([49:54]*1000,2,1) + ones(2,6)*130   + repmat([1  ;3 ],1,6) ...
      repmat([55:60]*1000,2,1) + ones(2,6)*130   + repmat([1  ;3 ],1,6)];

[TXT2,NUM2] = xlsread('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/fordist/LONG_IMAGING_DEBRIEF_FINAL.xlsx');
SD_W      = ceil((TXT2 - ones(6,6)*(-52.3)));
SD_W      = SD_W(:,1:4);
IndexW    = [[1  2  3  4  5  6 ] [7  8  9  10 11 12] ...
               [13 14 15 16 17 18] [19 20 21 22 23 24]];
  
% east
E   = [repmat([49:54]*1000,2,1) + ones(2,6)*150   + repmat([1  ;3 ],1,6) ...
       repmat([55:60]*1000,2,1) + ones(2,6)*150   + repmat([1  ;3 ],1,6) ...
       repmat([61:66]*1000,2,1) + ones(2,6)*150   + repmat([1  ;3 ],1,6) ...
       repmat([67:72]*1000,2,1) + ones(2,6)*150   + repmat([1  ;3 ],1,6)];

SD_E      = ceil((TXT2 - ones(6,6)*(55.3)));
SD_E      = SD_E(:,3:6); 
IndexE    = [[1  2  3  4  5  6 ] [7  8  9  10 11 12] ...
               [13 14 15 16 17 18] [19 20 21 22 23 24]];
   
% paris
P   = [repmat([37:42]*1000,2,1) + ones(2,6)*70   + repmat([1  ;3 ],1,6) ...
       repmat([43:48]*1000,2,1) + ones(2,6)*70   + repmat([1  ;3 ],1,6) ...
       repmat([49:54]*1000,2,1) + ones(2,6)*70   + repmat([1  ;3 ],1,6) ...
	   repmat([55:60]*1000,2,1) + ones(2,6)*70   + repmat([1  ;3 ],1,6) ...
       repmat([61:66]*1000,2,1) + ones(2,6)*70   + repmat([1  ;3 ],1,6) ...
       repmat([67:72]*1000,2,1) + ones(2,6)*70   + repmat([1  ;3 ],1,6)];

SD_Par    = ceil((TXT2 - ones(6,6)*2.35));
IndexPar  = [[1  2  3  4  5  6 ] [7  8  9  10 11 12] ...
             [13 14 15 16 17 18] [19 20 21 22 23 24] ...
             [25 26 27 28 29 30] [31 32 33 34 35 36]];   

% past
Pas   = [ repmat([37:40 43:46 49:52 55:58 61:64 67:70]*1000,2,1) + ones(2,24)*90  + repmat([1 ;3],1,24)];

SD_Pas    = ceil((TXT2 - ones(6,6)*2.35));
SD_Pas    = SD_Pas(1:4,:);
IndexPas  = [[1  2  3  4  5  6 ] [7  8  9  10 11 12] ...
             [13 14 15 16 17 18] [19 20 21 22 23 24]]; 
         
% future
Fut   = [repmat([39:42 45:48 51:54 57:60 63:66 69:72]*1000,2,1) + ones(2,24)*110 + repmat([1 ;3],1,24)];

SD_Fut    = ceil((TXT2 - ones(6,6)*2.35));
SD_Fut    = SD_Fut(3:6,:);
IndexFut  = [[13 14 15 16 17 18] [19 20 21 22 23 24] ...
             [25 26 27 28 29 30] [31 32 33 34 35 36]];          
         
         
for i = 1:length(datasource)
    datatmp{i} = load(datasource{i});
    rejecttmp{i} = load(rejectvisual{i});
end

%% trial selection & condnames
for i = 1:24
    select_event{i}  = W(:,i);
    condnames{i} = ['W' num2str(IndexW(i))];
end
for i = 25:48
    select_event{i}  = E(:,i-24);
    condnames{i} = ['E' num2str(IndexE(i-24))];
end
for i = 49:84
    select_event{i}  = P(:,i-48);
    condnames{i} = ['Par' num2str(IndexPar(i-48))];
end
for i = 85:108
    select_event{i}  = Pas(:,i-84);
    condnames{i} = ['Pas' num2str(IndexPas(i-84))];
end
for i = 109:132
    select_event{i}  = Fut(:,i-108);
    condnames{i} = ['Fut' num2str(IndexFut(i-108))];
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


