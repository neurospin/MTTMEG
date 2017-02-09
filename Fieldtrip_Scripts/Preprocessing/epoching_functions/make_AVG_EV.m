function [condnames,dataset] = make_AVG_EV(datasource,rejectvisual)

% corresponding triggercode in the name of individual files

TABLE{1,2}  = repmat([37:72]*1000,50,1) + repmat([60:64 70:74 80:84 90:94 100:104 ...
                     110:114 120:124 130:134 140:144 150:154]',1,36);
TABLE{2,2}  = repmat([37:6:67 38:6:68 39:6:69 40:6:70]*1000,50,1)+ repmat([60:64 70:74 80:84 90:94 100:104 ...
                     110:114 120:124 130:134 140:144 150:154]',1,24);
TABLE{3,2}  = repmat([39:6:69 40:6:70 41:6:71 42:6:72]*1000,50,1)+ repmat([60:64 70:74 80:84 90:94 100:104 ...
                     110:114 120:124 130:134 140:144 150:154]',1,24);
TABLE{4,2}  = repmat([37:60]*1000,50,1)+ repmat([60:64 70:74 80:84 90:94 100:104 ...
                     110:114 120:124 130:134 140:144 150:154]',1,24);
TABLE{5,2}  = repmat([49:72]*1000,50,1)+ repmat([60:64 70:74 80:84 90:94 100:104 ...
                     110:114 120:124 130:134 140:144 150:154]',1,24);

for i = 1:length(datasource)
    datatmp{i} = load(datasource{i});
    rejecttmp{i} = load(rejectvisual{i});
end

instr = []; cfg = [];rej = [];trldef = [];
if length(datasource) >= 2
    instr = 'data = ft_appenddata(cfg,';
    for i = 1:length(datasource)
        if isfield(datatmp{1,1},'datafilt40') == 1
            instr = [instr 'datatmp{1,' num2str(i) '}.datafilt40,'];
            tag = 1;
        else
            instr = [instr 'datatmp{1,' num2str(i) '}.data,'];
            tag = 0;
        end
        trldef = [trldef ;datatmp{1,i}.trldef];
        rej = [rej rejecttmp{1,i}.trlsel];
    end
end
instr(end) = []; instr = [instr ');'];
eval(instr)
clear datatmp
clear rejectmtp
if tag == 1
    datatmp{1,1}.datafilt40 = data;
else
    datatmp{1,1}.data = data;
end
datatmp{1,1}.trldef = trldef;
rejectmp{1,1}.trlsel = rej;

%% condames
condnames = {'allEvents'};

%% trial selection
select_event{1} = [TABLE{1,2}(:) ;TABLE{2,2}(:)  ;TABLE{3,2}(:)  ;TABLE{4,2}(:)  ;TABLE{5,2}(:) ]; 

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
    if isfield(datatmp{1,i},'datafilt40') == 1
        dataset{1,i} = ft_redefinetrial(cfg,datatmp{1,1}.datafilt40);
    else
        dataset{1,i} = ft_redefinetrial(cfg,datatmp{1,1}.data);
    end
end


