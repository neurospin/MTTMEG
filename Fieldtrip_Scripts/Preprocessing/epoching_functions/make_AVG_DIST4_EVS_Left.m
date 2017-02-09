function [condnames,dataset] = make_AVG_DIST4_EVS_Left(datasource,rejectvisual)

[TXT,NUM]   = xlsread('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/fordist/DATES_IMAGING_DEBRIEF_FINAL.xlsx');
[TXT2,NUM2] = xlsread('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/fordist/LONG_IMAGING_DEBRIEF_FINAL.xlsx');

TD_Pre    = abs(TXT - ones(6,6)*2013);
TD_Fut    = abs(TXT - ones(6,6)*2022);
TD_Pas    = abs(TXT - ones(6,6)*2004);
SD_Par    = ceil(abs(TXT2 - ones(6,6)*2.35));
SD_W      = ceil(abs(TXT2 - ones(6,6)*(-52.3)));
SD_E      = ceil(abs(TXT2 - ones(6,6)*(55.3)));
EVENT_ID  = [[1:6];[7:12];[13:18];[19:24];[25:30];[31:36]];

%% "quartilation" of temporal distance

y = []; a = []; a = TD_Pre;y = quantile(a(:),3);
TD_Pre_quartiled = a;
TD_Pre_quartiled(TD_Pre<=5.5) = 4;
TD_Pre_quartiled(TD_Pre>5.5  & TD_Pre <12) = 3;
TD_Pre_quartiled(TD_Pre>=12  & TD_Pre <20.5) = 2;
TD_Pre_quartiled(TD_Pre>=20.5) = 1;

y = []; a = []; a = TD_Fut(3:6,1:6);y = quantile(a(:),3);
TD_Fut_quartiled = a;
TD_Fut_quartiled(TD_Fut(3:6,1:6)<=5.5)  = 4;
TD_Fut_quartiled(TD_Fut(3:6,1:6)>5.5  & TD_Fut(3:6,1:6) <9) = 3;
TD_Fut_quartiled(TD_Fut(3:6,1:6)>=9  & TD_Fut(3:6,1:6) <14) = 2;
TD_Fut_quartiled(TD_Fut(3:6,1:6)>=14) = 1;

y = []; a = []; a = TD_Pas(1:4,1:6);y = quantile(a(:),3);
TD_Pas_quartiled = a;
TD_Pas_quartiled(TD_Pas(1:4,1:6)<=3) = 4;
TD_Pas_quartiled(TD_Pas(1:4,1:6)>3 & TD_Pas(1:4,1:6) <9) = 3;
TD_Pas_quartiled(TD_Pas(1:4,1:6)>=9 & TD_Pas(1:4,1:6) <12) = 2;
TD_Pas_quartiled(TD_Pas(1:4,1:6)>=12) = 1;

y = []; a = []; a = TD_Pre(:,1:4);y = quantile(a(:),3);
TD_W_quartiled = a;
TD_W_quartiled(TD_Pre(:,1:4)<=6) = 4;
TD_W_quartiled(TD_Pre(:,1:4)>6 & TD_Pre(:,1:4) <11.5) = 3;
TD_W_quartiled(TD_Pre(:,1:4)>=11.5 & TD_Pre(:,1:4) <20) = 2;
TD_W_quartiled(TD_Pre(:,1:4)>=20) = 1;

y = []; a = []; a = TD_Pre(:,3:6);y = quantile(a(:),3);
TD_E_quartiled = a;
TD_E_quartiled(TD_Pre(:,3:6)<=4.5) = 4;
TD_E_quartiled(TD_Pre(:,3:6)>4.5 & TD_Pre(:,3:6) <12.5) = 3;
TD_E_quartiled(TD_Pre(:,3:6)>=12.5 & TD_Pre(:,3:6) <20.5) = 2;
TD_E_quartiled(TD_Pre(:,3:6)>=20.5) = 1;

%% "quartilation" of spatial distance
y = []; a = []; a = SD_Par;y = quantile(a(:),3);
SD_Par_quartiled = a;
SD_Par_quartiled(SD_Par<=33.5) = 4;
SD_Par_quartiled(SD_Par>33.5  & SD_Par <76.5) = 3;
SD_Par_quartiled(SD_Par>=76.5  & SD_Par <118) = 2;
SD_Par_quartiled(SD_Par>=118) = 1;

y = []; a = []; a = SD_W(1:6,1:4);y = quantile(a(:),3);
SD_W_quartiled = a;
SD_W_quartiled(SD_W(1:6,1:4)<=38) = 4;
SD_W_quartiled(SD_W(1:6,1:4)>38  & SD_W(1:6,1:4) <54) = 3;
SD_W_quartiled(SD_W(1:6,1:4)>=54  & SD_W(1:6,1:4) <70) = 2;
SD_W_quartiled(SD_W(1:6,1:4)>=70) = 1;

y = []; a = []; a = SD_E(1:6,3:6);y = quantile(a(:),3);
SD_E_quartiled = a;
SD_E_quartiled(SD_E(1:6,3:6)<=20.5) = 4;
SD_E_quartiled(SD_E(1:6,3:6)>20.5  & SD_E(1:6,3:6) <49.5) = 3;
SD_E_quartiled(SD_E(1:6,3:6)>=49.5  & SD_E(1:6,3:6) <65) = 2;
SD_E_quartiled(SD_E(1:6,3:6)>=65) = 1;

y = []; a = []; a = SD_Par(1:4,:);y = quantile(a(:),3);
SD_Pas_quartiled = a;
SD_Pas_quartiled(SD_Par(1:4,:)<=38) = 4;
SD_Pas_quartiled(SD_Par(1:4,:)>38  & SD_Par(1:4,:) <80) = 3;
SD_Pas_quartiled(SD_Par(1:4,:)>=80  & SD_Par(1:4,:) <118.5) = 2;
SD_Pas_quartiled(SD_Par(1:4,:)>=118.5) = 1;

y = []; a = []; a = SD_Par(3:6,:);y = quantile(a(:),3);
SD_Fut_quartiled = a;
SD_Fut_quartiled(SD_Par(3:6,:)<=25.5) = 4;
SD_Fut_quartiled(SD_Par(3:6,:)>25.5  & SD_Par(3:6,:) <78) = 3;
SD_Fut_quartiled(SD_Par(3:6,:)>=78  & SD_Par(3:6,:) <118) = 2;
SD_Fut_quartiled(SD_Par(3:6,:)>=118) = 1;

TABLE{21,1}   = 'SDqrt1_1';
TABLE{22,1}   = 'SDqrt1_2';
TABLE{23,1}   = 'SDqrt1_3';
TABLE{24,1}   = 'SDqrt1_4';
TABLE{25,1}   = 'SDqrt1_5';

TABLE{26,1}   = 'SDqrt2_1';
TABLE{27,1}   = 'SDqrt2_2';
TABLE{28,1}   = 'SDqrt2_3';
TABLE{29,1}   = 'SDqrt2_4';
TABLE{30,1}   = 'SDqrt2_5';

TABLE{31,1}   = 'SDqrt3_1';
TABLE{32,1}   = 'SDqrt3_2';
TABLE{33,1}   = 'SDqrt3_3';
TABLE{34,1}   = 'SDqrt3_4';
TABLE{35,1}   = 'SDqrt3_5';

TABLE{36,1}   = 'SDqrt4_1';
TABLE{37,1}   = 'SDqrt4_2';
TABLE{38,1}   = 'SDqrt4_3';
TABLE{39,1}   = 'SDqrt4_4';
TABLE{40,1}   = 'SDqrt4_5';

EVENTSCODE_PrePar = reshape(37:72,6,6);
EVENTSCODE_PasPar = EVENTSCODE_PrePar(1:4,:);
EVENTSCODE_FutPar = EVENTSCODE_PrePar(3:6,:);
EVENTSCODE_PreW    = EVENTSCODE_PrePar(:,1:4);
EVENTSCODE_PreE    = EVENTSCODE_PrePar(:,3:6);

%% get triggercodes from quartiles

% corresponding triggercode in the name of individual files
TABLE{21,2}     = repmat(EVENTSCODE_PrePar(SD_Par_quartiled == 1)*1000,1,1) + repmat(71,size(EVENTSCODE_PrePar(SD_Par_quartiled == 1),1),1);
TABLE{22,2}     = repmat(EVENTSCODE_PasPar(SD_Pas_quartiled == 1)*1000,1,1)+ repmat(91,size(EVENTSCODE_PasPar(SD_Pas_quartiled == 1),1),1);
TABLE{23,2}     = repmat(EVENTSCODE_FutPar(SD_Fut_quartiled == 1)*1000,1,1)+ repmat(111,size(EVENTSCODE_FutPar(SD_Fut_quartiled == 1),1),1);
TABLE{24,2}     = repmat(EVENTSCODE_PreW(SD_W_quartiled == 1)*1000,1,1)+ repmat(131,size(EVENTSCODE_PreW(SD_W_quartiled == 1),1),1);
TABLE{25,2}     = repmat(EVENTSCODE_PreE(SD_E_quartiled == 1)*1000,1,1)+ repmat(151,size(EVENTSCODE_PreE(SD_E_quartiled == 1),1),1);

TABLE{26,2}     = repmat(EVENTSCODE_PrePar(SD_Par_quartiled == 2)*1000,1,1) + repmat(71,size(EVENTSCODE_PrePar(SD_Par_quartiled == 2),1),1);
TABLE{27,2}     = repmat(EVENTSCODE_PasPar(SD_Pas_quartiled == 2)*1000,1,1)+ repmat(91,size(EVENTSCODE_PasPar(SD_Pas_quartiled == 2),1),1);
TABLE{28,2}     = repmat(EVENTSCODE_FutPar(SD_Fut_quartiled == 2)*1000,1,1)+ repmat(111,size(EVENTSCODE_FutPar(SD_Fut_quartiled == 2),1),1);
TABLE{29,2}     = repmat(EVENTSCODE_PreW(SD_W_quartiled == 2)*1000,1,1)+ repmat(131,size(EVENTSCODE_PreW(SD_W_quartiled == 2),1),1);
TABLE{30,2}   = repmat(EVENTSCODE_PreE(SD_E_quartiled == 2)*1000,1,1)+ repmat(151,size(EVENTSCODE_PreE(SD_E_quartiled == 2),1),1);

TABLE{31,2}   = repmat(EVENTSCODE_PrePar(SD_Par_quartiled == 3)*1000,1,1) + repmat(71,size(EVENTSCODE_PrePar(SD_Par_quartiled == 3),1),1);
TABLE{32,2}   = repmat(EVENTSCODE_PasPar(SD_Pas_quartiled == 3)*1000,1,1)+ repmat(91,size(EVENTSCODE_PasPar(SD_Pas_quartiled == 3),1),1);
TABLE{33,2}   = repmat(EVENTSCODE_FutPar(SD_Fut_quartiled == 3)*1000,1,1)+ repmat(111,size(EVENTSCODE_FutPar(SD_Fut_quartiled == 3),1),1);
TABLE{34,2}   = repmat(EVENTSCODE_PreW(SD_W_quartiled == 3)*1000,1,1)+ repmat(131,size(EVENTSCODE_PreW(SD_W_quartiled == 3),1),1);
TABLE{35,2}   = repmat(EVENTSCODE_PreE(SD_E_quartiled == 3)*1000,1,1)+ repmat(151,size(EVENTSCODE_PreE(SD_E_quartiled == 3),1),1);

TABLE{36,2}   = repmat(EVENTSCODE_PrePar(SD_Par_quartiled == 4)*1000,1,1) + repmat(71,size(EVENTSCODE_PrePar(SD_Par_quartiled == 4),1),1);
TABLE{37,2}   = repmat(EVENTSCODE_PasPar(SD_Pas_quartiled == 4)*1000,1,1)+ repmat(91,size(EVENTSCODE_PasPar(SD_Pas_quartiled == 4),1),1);
TABLE{38,2}   = repmat(EVENTSCODE_FutPar(SD_Fut_quartiled == 4)*1000,1,1)+ repmat(111,size(EVENTSCODE_FutPar(SD_Fut_quartiled == 4),1),1);
TABLE{39,2}   = repmat(EVENTSCODE_PreW(SD_W_quartiled == 4)*1000,1,1)+ repmat(131,size(EVENTSCODE_PreW(SD_W_quartiled == 4),1),1);
TABLE{40,2}   = repmat(EVENTSCODE_PreE(SD_E_quartiled == 4)*1000,1,1)+ repmat(151,size(EVENTSCODE_PreE(SD_E_quartiled == 4),1),1);

for i = 1:length(datasource)
    datatmp{i} = load(datasource{i});
    rejecttmp{i} = load(rejectvisual{i});
end

%% condames
condnames = {'EsDsq1G_L';'EsDsq2G_L';'EsDsq3G_L';'EsDsq4G_L'};

%% trial selection
select_event{1} = [TABLE{21,2}(:) ;TABLE{22,2}(:)  ;TABLE{23,2}(:)  ;TABLE{24,2}(:)  ;TABLE{25,2}(:) ]; 
select_event{2} = [TABLE{26,2}(:) ;TABLE{27,2}(:)  ;TABLE{28,2}(:)  ;TABLE{29,2}(:)  ;TABLE{30,2}(:) ]; 
select_event{3} = [TABLE{31,2}(:) ;TABLE{32,2}(:)  ;TABLE{33,2}(:)  ;TABLE{34,2}(:)  ;TABLE{35,2}(:) ]; 
select_event{4} = [TABLE{36,2}(:) ;TABLE{37,2}(:)  ;TABLE{38,2}(:)  ;TABLE{39,2}(:)  ;TABLE{40,2}(:) ]; 

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
