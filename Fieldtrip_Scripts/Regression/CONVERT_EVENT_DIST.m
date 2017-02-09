% make a correpsondance table reusable in different analyses 
% for conversion of EVENT ID with egocentric/non-egocentric distance
% and present-centered distance
clear all 
close all


[TXT,NUM]   = xlsread('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/fordist/DATES_IMAGING_DEBRIEF_FINAL.xlsx');
[TXT2,NUM2] = xlsread('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/fordist/LONG_IMAGING_DEBRIEF_FINAL.xlsx');

TD_Pre    = abs(TXT - ones(6,6)*2013);
TD_Fut    = abs(TXT - ones(6,6)*2022);
TD_Pas    = abs(TXT - ones(6,6)*2004);

TD_Pas_2  = abs(TXT - ones(6,6)*2013);
TD_Pre_2  = abs(TXT - ones(6,6)*2013);
TD_Fut_2  = abs(TXT - ones(6,6)*2013);

SD_Par    = ceil(abs(TXT2 - ones(6,6)*2.35));
SD_W      = ceil(abs(TXT2 - ones(6,6)*(-52.3)));
SD_E      = ceil(abs(TXT2 - ones(6,6)*(55.3)));

SD_Par_2  = ceil(abs(TXT2 - ones(6,6)*2.35));
SD_W_2    = ceil(abs(TXT2 - ones(6,6)*2.35));
SD_E_2    = ceil(abs(TXT2 - ones(6,6)*2.35));

EVENT_ID  = [[1:6];[7:12];[13:18];[19:24];[25:30];[31:36]]+ones(6,6)*36;

% REFDIM  = [60:10:150];
% SUCCESS = [1 2 3 4 5];
% MATCONV = [];
% MATCONV = repmat(EVENT_ID(:),[(length(REFDIM)*length(SUCCESS)) 1]);
% MATCONV = MATCONV*1000;
% MATCONV = MATCONV + repmat(reshape(repmat(REFDIM,[36 1]),[36*10 1]),[5 1]);
% MATCONV = MATCONV + reshape(repmat(repmat([0 1 2 3 4], [36 1]),[10 1]),[36*10*5 1]);

% egocentric
EGOMATDISTT  = repmat([TD_Pre(:) ;TD_Pas(:); TD_Fut(:);TD_Pre(:); TD_Pre(:)],[10 1]);
EGOMATDISTS  = repmat([SD_Par(:) ;SD_Par(:); SD_Par(:);SD_W(:); SD_E(:)],[10 1]);
% non-egocentric
nEGOMATDISTT = repmat([TD_Pre_2(:) ;TD_Pas_2(:); TD_Fut_2(:);TD_Pre_2(:); TD_Pre_2(:)],[10 1]);
nEGOMATDISTS = repmat([SD_Par_2(:) ;SD_Par_2(:); SD_Par_2(:);SD_W_2(:); SD_E_2(:)],[10 1]);

% event code + ref code
EVENTCODET = [EVENT_ID(:)*1000 + ones(36,1)*60 ; ...
    EVENT_ID(:)*1000 + ones(36,1)*80; ...
    EVENT_ID(:)*1000 + ones(36,1)*100; ...
    EVENT_ID(:)*1000 + ones(36,1)*120; ...
    EVENT_ID(:)*1000 + ones(36,1)*140];
EVENTCODES = [EVENT_ID(:)*1000 + ones(36,1)*70 ; ...
    EVENT_ID(:)*1000 + ones(36,1)*90; ...
    EVENT_ID(:)*1000 + ones(36,1)*110; ...
    EVENT_ID(:)*1000 + ones(36,1)*130; ...
    EVENT_ID(:)*1000 + ones(36,1)*150];

% event code + ref code + sucess code
EVENTCODET = [EVENTCODET + ones(180,1)*0; ...
    EVENTCODET + ones(180,1)*1; ...
    EVENTCODET + ones(180,1)*2; ...
    EVENTCODET + ones(180,1)*3; ...
    EVENTCODET + ones(180,1)*4];
EVENTCODES = [EVENTCODES + ones(180,1)*0; ...
    EVENTCODES + ones(180,1)*1; ...
    EVENTCODES + ones(180,1)*2; ...
    EVENTCODES + ones(180,1)*3; ...
    EVENTCODES + ones(180,1)*4];

% ref code
REFCODE =  repmat([ones(36,1)*1 ; ...
    ones(36,1)*2; ...
    ones(36,1)*3; ...
    ones(36,1)*4; ...
    ones(36,1)*5],[10,1]);

egoCORR_TABLE = [[EVENTCODET ; EVENTCODES] EGOMATDISTT EGOMATDISTS REFCODE ]; 
RAND_TABLE    = rand(length([[EVENTCODET ; EVENTCODES] EGOMATDISTT EGOMATDISTS]),3);
nonego_TABLE  = [[EVENTCODET ; EVENTCODES] nEGOMATDISTT nEGOMATDISTS REFCODE ]; 

save('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/CORR_TABLE_DIST.mat','egoCORR_TABLE' ,'nonego_TABLE')


