function write_cond_def_for_mne

addpath('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts');
Dir = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/event_def_for_mne/';
EVENT_ID  = [[1:6];[7:12];[13:18];[19:24];[25:30];[31:36]]+ones(6,6)*36;

% corresponding triggercode in the name of individual files
TABLE{16,2}   = repmat(EVENT_ID([1 31 2 33 4 34 5 35 36])*1000,2,1) + ones(2,9)*60   + repmat([1 ;3],1,9);
TABLE{17,2}   = repmat(EVENT_ID([1 8 3 27 10])*1000,2,1) + ones(2,5)*80   + repmat([1 ;3],1,5);
TABLE{18,2}   = repmat(EVENT_ID([8 32 21 27 16])*1000,2,1) + ones(2,5)*100 + repmat([1 ;3],1,5);
TABLE{19,2}   = repmat(EVENT_ID([1 31 2 33 4 34])*1000,2,1) + ones(2,6)*120 + repmat([1 ;3],1,6);
TABLE{20,2}   = repmat(EVENT_ID([31 2 32 3 33 34])*1000,2,1) + ones(2,6)*140 + repmat([1 ;3],1,6);

TABLE{21,2}   = repmat(EVENT_ID([8 26 32 3 27 10 29 6 12 30])*1000,2,1) + ones(2,10)*60   + repmat([1 ;3],1,10);
TABLE{22,2}   = repmat(EVENT_ID([19 25 14 32 21 16 34])*1000,2,1)  + ones(2,7)*80   + repmat([1 ;3],1,7);
TABLE{23,2}   = repmat(EVENT_ID([8 32 21 27 16])*1000,2,1) + ones(2,5)*100 + repmat([1 ;3],1,5);
TABLE{24,2}   = repmat(EVENT_ID([8 26 32 3 27 10])*1000,2,1) + ones(2,6)*120 + repmat([1 ;3],1,6);
TABLE{25,2}   = repmat(EVENT_ID([1 8 27 4 10 28])*1000,2,1) + ones(2,6)*140 + repmat([1 ;3],1,6);

TABLE{26,2}   = repmat(EVENT_ID([7 13 25 14 9 15 28 11])*1000,2,1) + ones(2,8)*60   + repmat([1 ;3],1,8);
TABLE{27,2}   = repmat(EVENT_ID([9 15 4 22 28])*1000,2,1) + ones(2,5)*80   + repmat([1 ;3],1,5);
TABLE{28,2}   = repmat(EVENT_ID([7 2 20 9 22 28])*1000,2,1) + ones(2,6)*100 + repmat([1 ;3],1,6);
TABLE{29,2}   = repmat(EVENT_ID([7 25 14 9 28])*1000,2,1) + ones(2,5)*120 + repmat([1 ;3],1,5);
TABLE{30,2}   = repmat(EVENT_ID([7 13 25 14 26 9])*1000,2,1) + ones(2,6)*140 + repmat([1 ;3],1,6);

TABLE{31,2}   = repmat(EVENT_ID([19 20 21 16 22 17 23 24])*1000,2,1) + ones(2,8)*60   + repmat([1 ;3],1,8);
TABLE{32,2}   = repmat(EVENT_ID([7 13 31 2 20 26 33])*1000,2,1) + ones(2,7)*80   + repmat([1 ;3],1,7);
TABLE{33,2}   = repmat(EVENT_ID([13 31 26 15 33 4])*1000,2,1) + ones(2,6)*100 + repmat([1 ;3],1,6);
TABLE{34,2}   = repmat(EVENT_ID([13 19 20 15 21 16 22])*1000,2,1) + ones(2,7)*120 + repmat([1 ;3],1,7);
TABLE{35,2}   = repmat(EVENT_ID([19 20 15 21 16 22])*1000,2,1) + ones(2,6)*140 + repmat([1 ;3],1,6);

%% condames
condnames = {'EtDtq1G_QRT4';'EtDtq2G_QRT4';'EtDtq3G_QRT4';'EtDtq4G_QRT4'};

%% trial selection
cond = [];
cond = [TABLE{16,2}(:) ;TABLE{17,2}(:)  ;TABLE{18,2}(:)  ;TABLE{19,2}(:)  ;TABLE{20,2}(:) ]; 
save([Dir condnames{1} ],'cond')
 
cond = [];
cond = [TABLE{21,2}(:) ;TABLE{22,2}(:)  ;TABLE{23,2}(:)  ;TABLE{24,2}(:)  ;TABLE{25,2}(:) ]; 
save([Dir condnames{2} ],'cond')
 
cond = [];
cond = [TABLE{26,2}(:) ;TABLE{27,2}(:)  ;TABLE{28,2}(:)  ;TABLE{29,2}(:)  ;TABLE{30,2}(:) ]; 
save([Dir condnames{3} ],'cond') 

cond = [];
cond = [TABLE{31,2}(:) ;TABLE{32,2}(:)  ;TABLE{33,2}(:)  ;TABLE{34,2}(:)  ;TABLE{35,2}(:) ]; 
save([Dir condnames{4} ],'cond') 

clear TABLE
clear cond

% corresponding triggercode in the name of individual files
TABLE{16,2}   = repmat(EVENT_ID([1 7 13 19 31 12 18 30 36])*1000,2,1) + ones(2,9)*70   + repmat([1 ;3],1,9);
TABLE{17,2}   = repmat(EVENT_ID([1 7 13 19 22 28])*1000,2,1) + ones(2,6)*90   + repmat([1 ;3],1,6);
TABLE{18,2}   = repmat(EVENT_ID([1 7 19 16 28 34])*1000,2,1) + ones(2,6)*110 + repmat([1 ;3],1,6);
TABLE{19,2}   = repmat(EVENT_ID([19 31 4 10 16 28])*1000,2,1) + ones(2,6)*130 + repmat([1 ;3],1,6);
TABLE{20,2}   = repmat(EVENT_ID([7 19 10 19 28 34])*1000,2,1) + ones(2,6)*150 + repmat([1 ;3],1,6);

TABLE{21,2}   = repmat(EVENT_ID([25 2 8 14 20 32 23 6 24])*1000,2,1) + ones(2,9)*70   + repmat([1 ;3],1,9);
TABLE{22,2}   = repmat(EVENT_ID([25 2 8 10 16 34])*1000,2,1)  + ones(2,6)*90   + repmat([1 ;3],1,6);
TABLE{23,2}   = repmat(EVENT_ID([13 25 31 8 33 22])*1000,2,1) + ones(2,6)*110 + repmat([1 ;3],1,6);
TABLE{24,2}   = repmat(EVENT_ID([1 7 13 33 22 34])*1000,2,1) + ones(2,6)*130 + repmat([1 ;3],1,6);
TABLE{25,2}   = repmat(EVENT_ID([1 13 25 31 4 22])*1000,2,1) + ones(2,6)*150 + repmat([1 ;3],1,6);

TABLE{26,2}   = repmat(EVENT_ID([26 21 4 10 5 11 17 29 32])*1000,2,1) + ones(2,9)*70   + repmat([1 ;3],1,9);
TABLE{27,2}   = repmat(EVENT_ID([31 32 3 27 33 4])*1000,2,1) + ones(2,6)*90   + repmat([1 ;3],1,6);
TABLE{28,2}   = repmat(EVENT_ID([2 20 15 27 4 10])*1000,2,1) + ones(2,6)*110 + repmat([1 ;3],1,6);
TABLE{29,2}   = repmat(EVENT_ID([25 14 3 9 15 27])*1000,2,1) + ones(2,6)*130 + repmat([1 ;3],1,6);
TABLE{30,2}   = repmat(EVENT_ID([14 20 26 32 21 33])*1000,2,1) + ones(2,6)*150 + repmat([1 ;3],1,6);

TABLE{31,2}   = repmat(EVENT_ID([3 9 15 27 33 16 22 28 34])*1000,2,1) + ones(2,9)*70   + repmat([1 ;3],1,9);
TABLE{32,2}   = repmat(EVENT_ID([14 20 26 9 15 21])*1000,2,1) + ones(2,6)*90   + repmat([1 ;3],1,6);
TABLE{33,2}   = repmat(EVENT_ID([14 26 32 3 9 21])*1000,2,1) + ones(2,6)*110 + repmat([1 ;3],1,6);
TABLE{34,2}   = repmat(EVENT_ID([2 8 20 26 32 21])*1000,2,1) + ones(2,6)*130 + repmat([1 ;3],1,6);
TABLE{35,2}   = repmat(EVENT_ID([2 8 3 9 15 27])*1000,2,1) + ones(2,6)*150 + repmat([1 ;3],1,6);

%% condames
condnames = {'EsDsq1G_QRT4';'EsDsq2G_QRT4';'EsDsq3G_QRT4';'EsDsq4G_QRT4'};

%% trial selection
cond = [];
cond = [TABLE{16,2}(:) ;TABLE{17,2}(:)  ;TABLE{18,2}(:)  ;TABLE{19,2}(:)  ;TABLE{20,2}(:) ]; 
save([Dir condnames{1} ],'cond')
 
cond = [];
cond = [TABLE{21,2}(:) ;TABLE{22,2}(:)  ;TABLE{23,2}(:)  ;TABLE{24,2}(:)  ;TABLE{25,2}(:) ]; 
save([Dir condnames{2} ],'cond')
 
cond = [];
cond = [TABLE{26,2}(:) ;TABLE{27,2}(:)  ;TABLE{28,2}(:)  ;TABLE{29,2}(:)  ;TABLE{30,2}(:) ]; 
save([Dir condnames{3} ],'cond') 

cond = [];
cond = [TABLE{31,2}(:) ;TABLE{32,2}(:)  ;TABLE{33,2}(:)  ;TABLE{34,2}(:)  ;TABLE{35,2}(:) ]; 
save([Dir condnames{4} ],'cond') 

clear TABLE
clear cond

% corresponding triggercode in the name of individual files
TABLE{1,2}     = repmat([37 43 49 55 56 61 67 68 42 47 48 54 60 65 66 71 72]*1000,2,1) + ones(2,17)*60   + repmat([1  ;3 ],1,17);
TABLE{2,2}     = repmat([37 43 49 55 61 67 40 46 52 58 64 70]*1000,2,1) + ones(2,12)*80     + repmat([1  ;3 ],1,12);
TABLE{3,2}     = repmat([39 45 51 57 63 69 42 48 54 60 66 72]*1000,2,1) + ones(2,12)*100   + repmat([1  ;3 ],1,12);
TABLE{4,2}     = repmat([37 43 44 49 55 56 42 48 47 53 54 60]*1000,2,1) + ones(2,12)*120   + repmat([1  ;3 ],1,12);
TABLE{5,2}     = repmat([49 55 56 61 67 68 54 60 65 66 71 72]*1000,2,1) + ones(2,12)*140   + repmat([1  ;3 ],1,12);

TABLE{6,2}     = repmat([38 44 50 62 39 45 51 57 63 69 40 41 46 52 53 58 59 64 70]*1000,2,1) + ones(2,19)*60   + repmat([1  ;3 ],1,19);
TABLE{7,2}     = repmat([38 39 44 45 50 51 56 57 62 63 68 69]*1000,2,1) + ones(2,12)*80 + repmat([1  ;3 ],1,12);
TABLE{8,2}     = repmat([40 41 46 47 52 53 58 59 64 65 71 70]*1000,2,1) + ones(2,12)*100   + repmat([1  ;3 ],1,12);
TABLE{9,2}     = repmat([38 39 45 50 51 57 40 41 46 52 58 59]*1000,2,1) + ones(2,12)*120   + repmat([1  ;3 ],1,12);
TABLE{10,2}   = repmat([50 51 57 62 63 69 52 53 58 59 64 70]*1000,2,1) + ones(2,12)*140   + repmat([1  ;3 ],1,12);

%% condames
condnames = {'EtDtq1G_QRT2';'EtDtq2G_QRT2'};

%% trial selection
cond = [];
cond = [TABLE{1,2}(:) ;TABLE{2,2}(:)  ;TABLE{3,2}(:)  ;TABLE{4,2}(:)  ;TABLE{5,2}(:) ]; 
save([Dir condnames{1} ],'cond')
cond = [];
cond = [TABLE{6,2}(:) ;TABLE{7,2}(:)  ;TABLE{8,2}(:)  ;TABLE{9,2}(:)  ;TABLE{10,2}(:)]; 
save([Dir condnames{2}],'cond')
 

clear TABLE
clear cond
% corresponding triggercode in the name of individual files
TABLE{16,2}   = repmat([37:46 48 64 67:72]*1000,2,1) + ones(2,18)*70   + repmat([1 ;3],1,18);
TABLE{17,2}   = repmat([37:40 43 45 46 64 67:70]*1000,2,1) + ones(2,12)*90   + repmat([1 ;3],1,12);
TABLE{18,2}   = repmat([39:42 45 46 48 64 69:72]*1000,2,1) + ones(2,12)*110 + repmat([1 ;3],1,12);
TABLE{19,2}   = repmat([37:42 55:60]*1000,2,1) + ones(2,12)*130 + repmat([1 ;3],1,12);
TABLE{20,2}   = repmat([49:54 67:72]*1000,2,1) + ones(2,12)*150 + repmat([1 ;3],1,12);

TABLE{21,2}   = repmat([47 49:60 61 62 63 65 66]*1000,2,1) + ones(2,18)*70   + repmat([1 ;3],1,18);
TABLE{22,2}   = repmat([44 49:52 55:58 61 62 63]*1000,2,1) + ones(2,12)*90   + repmat([1 ;3],1,12);
TABLE{23,2}   = repmat([47 51:54 57:60 63 65 66]*1000,2,1) + ones(2,12)*110 + repmat([1 ;3],1,12);
TABLE{24,2}   = repmat([43:48 49:54]*1000,2,1) + ones(2,12)*130 + repmat([1 ;3],1,12);
TABLE{25,2}   = repmat([55:60 61:66]*1000,2,1) + ones(2,12)*150 + repmat([1 ;3],1,12);

%% condames
condnames = {'EsDsq1G_QRT2';'EsDsq2G_QRT2'};

%% trial selection
cond = [];
cond = [TABLE{16,2}(:) ;TABLE{17,2}(:)  ;TABLE{18,2}(:)  ;TABLE{19,2}(:)  ;TABLE{20,2}(:) ]; 
save([Dir condnames{1} ],'cond')

cond = [];
cond = [TABLE{21,2}(:) ;TABLE{22,2}(:)  ;TABLE{23,2}(:)  ;TABLE{24,2}(:)  ;TABLE{25,2}(:) ]; 
save([Dir condnames{2} ],'cond')

clear TABLE
clear cond

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

%% condames
condnames = {'EsDsq1G_QRT3';'EsDsq2G_QRT3';'EsDsq3G_QRT3'};

%% trial selection
cond = [];
cond = [TABLE{16,2}(:) ;TABLE{17,2}(:)  ;TABLE{18,2}(:)  ;TABLE{19,2}(:)  ;TABLE{20,2}(:) ]; 
save([Dir condnames{1} ],'cond')
 
cond = [];
cond = [TABLE{21,2}(:) ;TABLE{22,2}(:)  ;TABLE{23,2}(:)  ;TABLE{24,2}(:)  ;TABLE{25,2}(:) ]; 
save([Dir condnames{2} ],'cond')
 
cond = [];
cond = [TABLE{26,2}(:) ;TABLE{27,2}(:)  ;TABLE{28,2}(:)  ;TABLE{29,2}(:)  ;TABLE{30,2}(:) ]; 
save([Dir condnames{3} ],'cond') 

clear TABLE
clear cond

% corresponding triggercode in the name of individual files
TABLE{1,2}     = repmat([37 43 49 55 61 67 42 48 54 60 66 72]*1000,2,1) + ones(2,12)*60   + repmat([1 ;3],1,12);
TABLE{2,2}     = repmat([37 43 55 61 46 52 64 70]*1000,2,1) + ones(2,8)*80     + repmat([1 ;3],1,8);
TABLE{3,2}     = repmat([39 45 51 57 42 54 66 72]*1000,2,1) + ones(2,8)*100   + repmat([1 ;3],1,8);
TABLE{4,2}     = repmat([37 43 49 55 42 48 54 60]*1000,2,1) + ones(2,8)*120   + repmat([1 ;3],1,8);
TABLE{5,2}     = repmat([49 55 61 67 54 60 66 72]*1000,2,1) + ones(2,8)*140   + repmat([1 ;3],1,8);

TABLE{6,2}     = repmat([38 44 50 56 62 68 41 47 53 59 65 71]*1000,2,1) + ones(2,12)*60   + repmat([1 ;3],1,12);
TABLE{7,2}     = repmat([49 67 56 68 57 63 69 40 58]*1000,2,1) + ones(2,9)*80 + repmat([1 ;3],1,9);
TABLE{8,2}     = repmat([63 69 40 58 47 71 48 60 ]*1000,2,1) + ones(2,8)*100   + repmat([1 ;3],1,8);
TABLE{9,2}     = repmat([38 44 50 56 41 47 53 59 ]*1000,2,1) + ones(2,8)*120   + repmat([1 ;3],1,8);
TABLE{10,2}   = repmat([50 56 62 68 53 59 65 71 ]*1000,2,1) + ones(2,8)*140   + repmat([1 ;3],1,8);

TABLE{11,2}   = repmat([39 45 51 57 63 69 40 46 52 58 64 70]*1000,2,1) + ones(2,12)*60   + repmat([1 ;3],1,12);
TABLE{12,2}   = repmat([38 44 50 62 39 45 51]*1000,2,1) + ones(2,7)*80   + repmat([1 ;3],1,7);
TABLE{13,2}   = repmat([46 52 64 70 41 53 59 65 ]*1000,2,1) + ones(2,8)*100   + repmat([1 ;3],1,8);
TABLE{14,2}   = repmat([39 54 51 57 40 46 52 58]*1000,2,1) + ones(2,8)*120   + repmat([1 ;3],1,8);
TABLE{15,2}   = repmat([51 57 63 69 52 58 64 70]*1000,2,1) + ones(2,8)*140   + repmat([1 ;3],1,8);

%% condames
condnames = {'EtDtq1G_QRT3';'EtDtq2G_QRT3';'EtDtq3G_QRT3'};

%% trial selection
cond = [];
cond = [TABLE{1,2}(:) ;TABLE{2,2}(:)  ;TABLE{3,2}(:)  ;TABLE{4,2}(:)  ;TABLE{5,2}(:) ]; 
save([Dir condnames{1} ],'cond')
 
cond = [];
cond = [TABLE{6,2}(:) ;TABLE{7,2}(:)  ;TABLE{8,2}(:)  ;TABLE{9,2}(:)  ;TABLE{10,2}(:) ]; 
save([Dir condnames{2} ],'cond') 

cond = [];
cond = [TABLE{11,2}(:) ;TABLE{12,2}(:)  ;TABLE{13,2}(:)  ;TABLE{14,2}(:)  ;TABLE{15,2}(:) ]; 
save([Dir condnames{3} ],'cond')  

clear TABLE
clear cond

TABLE{1,2}   = repmat([37:72]*1000,2,1) + ones(2,36)*60   + repmat([1 ;3],1,36);
TABLE{2,2}   = repmat([37:72]*1000,2,1) + ones(2,36)*80   + repmat([1 ;3],1,36);
TABLE{3,2}   = repmat([37:72]*1000,2,1) + ones(2,36)*100   + repmat([1 ;3],1,36);
TABLE{4,2}   = repmat([37:72]*1000,2,1) + ones(2,36)*120   + repmat([1 ;3],1,36);
TABLE{5,2}   = repmat([37:72]*1000,2,1) + ones(2,36)*140   + repmat([1 ;3],1,36);

TABLE{6,2}   = repmat([37:72]*1000,2,1) + ones(2,36)*70   + repmat([1 ;3],1,36);
TABLE{7,2}   = repmat([37:72]*1000,2,1) + ones(2,36)*90   + repmat([1 ;3],1,36);
TABLE{8,2}   = repmat([37:72]*1000,2,1) + ones(2,36)*110   + repmat([1 ;3],1,36);
TABLE{9,2}   = repmat([37:72]*1000,2,1) + ones(2,36)*130   + repmat([1 ;3],1,36);
TABLE{10,2}  = repmat([37:72]*1000,2,1) + ones(2,36)*150   + repmat([1 ;3],1,36);

%% condames
condnames = {'EsWestG';'EsParG';'EsEastG'};

%% trial selection
cond = [];
cond = [TABLE{9,2}(:) ]; 
save([Dir condnames{1} ],'cond')
cond = [];
cond = [TABLE{6,2}(:) ]; 
save([Dir condnames{2} ],'cond')
cond = [];
cond = [TABLE{10,2}(:) ]; 
save([Dir condnames{3} ],'cond')

clear TABLE
clear cond

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

%% condames
condnames = {'EtPast';'EtPre';'EtFut'};

%% trial selection
cond = [];
cond = [TABLE{2,2}(:) ]; 
save([Dir condnames{1} ],'cond')
cond = [];
cond = [TABLE{1,2}(:) ]; 
save([Dir condnames{2} ],'cond')
cond = [];
cond = [TABLE{3,2}(:) ]; 
save([Dir condnames{3} ],'cond')

clear TABLE
clear cond

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

%% condames
condnames = {'Et_all';'Es_all'};

%% trial selection
cond = [];
cond = [TABLE{1,2}(:); TABLE{2,2}(:); TABLE{3,2}(:); TABLE{4,2}(:); TABLE{5,2}(:)]; 
save([Dir condnames{1} ],'cond')
cond = [];
cond = [TABLE{6,2}(:); TABLE{7,2}(:); TABLE{8,2}(:); TABLE{9,2}(:); TABLE{10,2}(:)]; 
save([Dir condnames{2} ],'cond')

clear TABLE
clear cond

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

%% condames
condnames = {'EtPre';'EtFut'};

%% trial selection
cond = [];
cond = [TABLE{1,2}(:) ]; 
save([Dir condnames{1} ],'cond')
cond = [];
cond = [TABLE{3,2}(:) ]; 
save([Dir condnames{2} ],'cond')

clear TABLE
clear cond

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

%% condames
condnames = {'EtPre';'EtPast'};

%% trial selection
cond = [];
cond = [TABLE{1,2}(:) ]; 
save([Dir condnames{1} ],'cond')
cond = [];
cond = [TABLE{2,2}(:) ]; 
save([Dir condnames{2} ],'cond')

clear TABLE
clear cond

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

%% condames
condnames = {'EtPre';'EtnoPre'};

%% trial selection
cond = [];
cond = [TABLE{1,2}(:) ]; 
save([Dir condnames{1} ],'cond')
cond = [];
cond = [TABLE{2,2}(:) TABLE{3,2}(:)]; 
save([Dir condnames{2} ],'cond')

clear TABLE
clear cond

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

%% condames
condnames = {'EsPar';'EsEast'};

%% trial selection
cond = [];
cond = [TABLE{6,2}(:) ]; 
save([Dir condnames{1} ],'cond')
cond = [];
cond = [TABLE{10,2}(:) ]; 
save([Dir condnames{2} ],'cond')

clear TABLE
clear cond

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

%% condames
condnames = {'EsPar';'EsWest'};

%% trial selection
cond = [];
cond = [TABLE{6,2}(:) ]; 
save([Dir condnames{1} ],'cond')
cond = [];
cond = [TABLE{9,2}(:) ]; 
save([Dir condnames{2} ],'cond')

clear TABLE
clear cond

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

%% condames
condnames = {'EsPar';'EsnoPar'};

%% trial selection
cond = [];
cond = [TABLE{6,2}(:) ]; 
save([Dir condnames{1} ],'cond')
cond = [];
cond = [ TABLE{9,2}(:)]; 
save([Dir condnames{2} ],'cond')

clear TABLE
clear cond

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

%% condames
condnames = {'Qt_all';'Qs_all'};

%% trial selection
cond = [];
cond = [TABLE{1,2}(:); TABLE{2,2}(:); TABLE{3,2}(:); TABLE{4,2}(:); TABLE{5,2}(:)]; 
save([Dir condnames{1} ],'cond')
cond = [];
cond = [TABLE{6,2}(:); TABLE{7,2}(:); TABLE{8,2}(:); TABLE{9,2}(:); TABLE{10,2}(:)]; 
save([Dir condnames{2} ],'cond')

clear TABLE
clear cond

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

%% condames
condnames = {'QtPast';'QtPre';'QtFut'};

%% trial selection
cond = [];
cond = [TABLE{2,2}(:) ]; 
save([Dir condnames{1} ],'cond')
cond = [];
cond = [TABLE{1,2}(:) ]; 
save([Dir condnames{2} ],'cond')
cond = [];
cond = [TABLE{3,2}(:) ]; 
save([Dir condnames{3} ],'cond')

clear TABLE
clear cond

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

%% condames
condnames = {'QsWest';'QsPar';'QsEast'};

%% trial selection
cond = [];
cond = [TABLE{9,2}(:) ]; 
save([Dir condnames{1} ],'cond')
cond = [];
cond = [TABLE{6,2}(:) ]; 
save([Dir condnames{2} ],'cond')
cond = [];
cond = [TABLE{10,2}(:) ]; 
save([Dir condnames{3} ],'cond')

clear TABLE
clear cond

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

%% condames
condnames = {'QsPar';'QsEast'};

%% trial selection
cond = [];
cond = [TABLE{6,2}(:) ]; 
save([Dir condnames{1} ],'cond')
cond = [TABLE{10,2}(:) ]; 
save([Dir condnames{2} ],'cond')

clear TABLE
clear cond

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

%% condames
condnames = {'QsPar';'QsWest'};

%% trial selection
cond = [];
cond = [TABLE{6,2}(:) ]; 
save([Dir condnames{1} ],'cond')
cond = [];
cond = [TABLE{9,2}(:) ]; 
save([Dir condnames{2} ],'cond')

clear TABLE
clear cond

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

%% condames
condnames = {'QtPre';'QtFut'};

%% trial selection
cond = [];
cond = [TABLE{1,2}(:) ]; 
save([Dir condnames{1} ],'cond')
cond = [];
cond = [TABLE{3,2}(:) ]; 
save([Dir condnames{2} ],'cond')

clear TABLE
clear cond

%% condames
condnames = {'RefPast';'RefPre';'RefFut'};

%% trial selection
cond = [];
cond = [2]; 
save([Dir condnames{1} ],'cond')
cond = [];
cond = [1]; 
save([Dir condnames{2} ],'cond')
cond = [];
cond = [3]; 
save([Dir condnames{3} ],'cond')

clear TABLE
clear cond

%% condames
condnames = {'RefW';'RefPar';'RefE'};

%% trial selection
cond = [];
cond = [4]; 
save([Dir condnames{1} ],'cond')
cond = [];
cond = [1]; 
save([Dir condnames{2} ],'cond')
cond = [];
cond = [5]; 
save([Dir condnames{3} ],'cond')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
TABLE{1,2}   = repmat([37:6:67 38:6:68 39:6:69]*1000,2,1) + ones(2,18)*60   + repmat([1 ;3],1,18);
TABLE{2,2}   = repmat([37:6:67 38:6:68]*1000,2,1) + ones(2,12)*80   + repmat([1 ;3],1,12);
TABLE{3,2}   = repmat([39:6:69 40:6:70]*1000,2,1) + ones(2,12)*100   + repmat([1 ;3],1,12);
TABLE{4,2}   = repmat([37:39 43:45 49:51 55:57]*1000,2,1) + ones(2,12)*120   + repmat([1 ;3],1,12);
TABLE{5,2}   = repmat([49:51 55:57 61:63 67:69]*1000,2,1) + ones(2,12)*140   + repmat([1 ;3],1,12);

% Relative Future irrespective of other conditions
TABLE{6,2}   = repmat([40:6:70 41:6:71 42:6:72]*1000,2,1) + ones(2,18)*60   + repmat([1 ;3],1,18);
TABLE{7,2}   = repmat([39:6:69 40:6:70]*1000,2,1) + ones(2,12)*80   + repmat([1 ;3],1,12);
TABLE{8,2}   = repmat([41:6:71 42:6:72]*1000,2,1) + ones(2,12)*100   + repmat([1 ;3],1,12);
TABLE{9,2}   = repmat([40:42 46:48 52:54 58:60]*1000,2,1) + ones(2,12)*120   + repmat([1 ;3],1,12);
TABLE{10,2}   = repmat([52:54 58:60 64:66 70:72]*1000,2,1) + ones(2,12)*140   + repmat([1 ;3],1,12);

%% condames
condnames = {'RelPastG';'RelFutG'};

%% trial selection
cond = [];
cond = [TABLE{1,2}(:); TABLE{2,2}(:); TABLE{3,2}(:); TABLE{4,2}(:); TABLE{5,2}(:)];
save([Dir condnames{1} ],'cond') 
cond = [];
cond = [TABLE{6,2}(:); TABLE{7,2}(:); TABLE{8,2}(:); TABLE{9,2}(:); TABLE{10,2}(:)];
save([Dir condnames{2} ],'cond') 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
TABLE{1,2}   = repmat([37:42 43:48 49:54]*1000,2,1) + ones(2,18)*70   + repmat([1;3],1,18);
TABLE{2,2}   = repmat([37:40 43:46 49:52]*1000,2,1) + ones(2,12)*90   + repmat([1;3],1,12);
TABLE{3,2}   = repmat([39:42 45:48 51:54]*1000,2,1) + ones(2,12)*110   + repmat([1;3],1,12);
TABLE{4,2}   = repmat([37:42 43:48]*1000,2,1) + ones(2,12)*130   + repmat([1;3],1,12);
TABLE{5,2}   = repmat([49:54 55:60]*1000,2,1) + ones(2,12)*150   + repmat([1;3],1,12);

% Relative East irrespective of other conditions
TABLE{6,2}   = repmat([55:60 61:66 67:72]*1000,2,1) + ones(2,18)*70   + repmat([1;3],1,18);
TABLE{7,2}   = repmat([55:58 61:64 67:70]*1000,2,1) + ones(2,12)*90   + repmat([1;3],1,12);
TABLE{8,2}   = repmat([57:60 63:66 69:72]*1000,2,1) + ones(2,12)*110   + repmat([1;3],1,12);
TABLE{9,2}   = repmat([49:54 55:60]*1000,2,1) + ones(2,12)*130   + repmat([1;3],1,12);
TABLE{10,2}   = repmat([61:66 67:72]*1000,2,1) + ones(2,12)*150   + repmat([1;3],1,12);

%% condames
condnames = {'RelWestG';'RelEastG'};

%% trial selection
cond = [];
cond  = [TABLE{1,2}(:); TABLE{2,2}(:); TABLE{3,2}(:); TABLE{4,2}(:); TABLE{5,2}(:)];
save([Dir condnames{1} ],'cond') 
cond = [];
cond = [TABLE{6,2}(:); TABLE{7,2}(:); TABLE{8,2}(:); TABLE{9,2}(:); TABLE{10,2}(:)];
save([Dir condnames{2} ],'cond') 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
TABLE{1,2}   = repmat([37:6:67 38:6:68 39:6:69]*1000,1,1) + ones(1,18)*60   + repmat([1],1,18);
TABLE{2,2}   = repmat([37:6:67 38:6:68]*1000,1,1) + ones(1,12)*80   + repmat([1],1,12);
TABLE{3,2}   = repmat([39:6:69 40:6:70]*1000,1,1) + ones(1,12)*100   + repmat([1],1,12);
TABLE{4,2}   = repmat([37:39 43:45 49:51 55:57]*1000,1,1) + ones(1,12)*120   + repmat([1],1,12);
TABLE{5,2}   = repmat([49:51 55:57 61:63 67:69]*1000,1,1) + ones(1,12)*140   + repmat([1],1,12);

% Relative Future irrespective of other conditions
TABLE{6,2}   = repmat([40:6:70 41:6:71 42:6:72]*1000,1,1) + ones(1,18)*60   + repmat([3],1,18);
TABLE{7,2}   = repmat([39:6:69 40:6:70]*1000,1,1) + ones(1,12)*80   + repmat([3],1,12);
TABLE{8,2}   = repmat([41:6:71 42:6:72]*1000,1,1) + ones(1,12)*100   + repmat([3],1,12);
TABLE{9,2}   = repmat([40:42 46:48 52:54 58:60]*1000,1,1) + ones(1,12)*120   + repmat([3],1,12);
TABLE{10,2}   = repmat([52:54 58:60 64:66 70:72]*1000,1,1) + ones(1,12)*140   + repmat([3],1,12);

%% condames
condnames = {'RelPastG_intmap';'RelFutG_intmap'};

%% trial selection
cond = [];
cond  = [TABLE{1,2}(:); TABLE{2,2}(:); TABLE{3,2}(:); TABLE{4,2}(:); TABLE{5,2}(:)];
save([Dir condnames{1} ],'cond') 
cond = [];
cond = [TABLE{6,2}(:); TABLE{7,2}(:); TABLE{8,2}(:); TABLE{9,2}(:); TABLE{10,2}(:)];
save([Dir condnames{2} ],'cond') 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
TABLE{1,2}   = repmat([37:6:67 38:6:68 39:6:69]*1000,1,1) + ones(1,18)*60   + repmat([3],1,18);
TABLE{2,2}   = repmat([37:6:67 38:6:68]*1000,1,1) + ones(1,12)*80   + repmat([3],1,12);
TABLE{3,2}   = repmat([39:6:69 40:6:70]*1000,1,1) + ones(1,12)*100   + repmat([3],1,12);
TABLE{4,2}   = repmat([37:39 43:45 49:51 55:57]*1000,1,1) + ones(1,12)*120   + repmat([3],1,12);
TABLE{5,2}   = repmat([49:51 55:57 61:63 67:69]*1000,1,1) + ones(1,12)*140   + repmat([3],1,12);

% Relative Future irrespective of other conditions
TABLE{6,2}   = repmat([40:6:70 41:6:71 42:6:72]*1000,1,1) + ones(1,18)*60   + repmat([1],1,18);
TABLE{7,2}   = repmat([39:6:69 40:6:70]*1000,1,1) + ones(1,12)*80   + repmat([1],1,12);
TABLE{8,2}   = repmat([41:6:71 42:6:72]*1000,1,1) + ones(1,12)*100   + repmat([1],1,12);
TABLE{9,2}   = repmat([40:42 46:48 52:54 58:60]*1000,1,1) + ones(1,12)*120   + repmat([1],1,12);
TABLE{10,2}   = repmat([52:54 58:60 64:66 70:72]*1000,1,1) + ones(1,12)*140   + repmat([1],1,12);

%% condames
condnames = {'RelPastG_coumap';'RelFutG_coumap'};

%% trial selection
cond = [];
cond  = [TABLE{1,2}(:); TABLE{2,2}(:); TABLE{3,2}(:); TABLE{4,2}(:); TABLE{5,2}(:)];
save([Dir condnames{1} ],'cond') 
cond = [];
cond = [TABLE{6,2}(:); TABLE{7,2}(:); TABLE{8,2}(:); TABLE{9,2}(:); TABLE{10,2}(:)];
save([Dir condnames{2} ],'cond') 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
TABLE{1,2}   = repmat([37:42 43:48 49:54]*1000,1,1) + ones(1,18)*70   + repmat([1],1,18);
TABLE{2,2}   = repmat([37:40 43:46 49:52]*1000,1,1) + ones(1,12)*90   + repmat([1],1,12);
TABLE{3,2}   = repmat([39:42 45:48 51:54]*1000,1,1) + ones(1,12)*110   + repmat([1],1,12);
TABLE{4,2}   = repmat([37:42 43:48]*1000,1,1) + ones(1,12)*130   + repmat([1],1,12);
TABLE{5,2}   = repmat([49:54 55:60]*1000,1,1) + ones(1,12)*150   + repmat([1],1,12);

% Relative East irrespective of other conditions
TABLE{6,2}   = repmat([55:60 61:66 67:72]*1000,1,1) + ones(1,18)*70   + repmat([3],1,18);
TABLE{7,2}   = repmat([55:58 61:64 67:70]*1000,1,1) + ones(1,12)*90   + repmat([3],1,12);
TABLE{8,2}   = repmat([57:60 63:66 69:72]*1000,1,1) + ones(1,12)*110   + repmat([3],1,12);
TABLE{9,2}   = repmat([49:54 55:60]*1000,1,1) + ones(1,12)*130   + repmat([3],1,12);
TABLE{10,2}   = repmat([61:66 67:72]*1000,1,1) + ones(1,12)*150   + repmat([3],1,12);

%% condames
condnames = {'RelWestG_intmap';'RelEastG_intmap'};

%% trial selection
cond = [];
cond  = [TABLE{1,2}(:); TABLE{2,2}(:); TABLE{3,2}(:); TABLE{4,2}(:); TABLE{5,2}(:)];
save([Dir condnames{1} ],'cond') 
cond = [];
cond = [TABLE{6,2}(:); TABLE{7,2}(:); TABLE{8,2}(:); TABLE{9,2}(:); TABLE{10,2}(:)];
save([Dir condnames{2} ],'cond') 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Relative West irrespective of other conditions
TABLE{1,2}   = repmat([37:42 43:48 49:54]*1000,1,1) + ones(1,18)*70   + repmat([3],1,18);
TABLE{2,2}   = repmat([37:40 43:46 49:52]*1000,1,1) + ones(1,12)*90   + repmat([3],1,12);
TABLE{3,2}   = repmat([39:42 45:48 51:54]*1000,1,1) + ones(1,12)*110   + repmat([3],1,12);
TABLE{4,2}   = repmat([37:42 43:48]*1000,1,1) + ones(1,12)*130   + repmat([3],1,12);
TABLE{5,2}   = repmat([49:54 55:60]*1000,1,1) + ones(1,12)*150   + repmat([3],1,12);

% Relative East irrespective of other conditions
TABLE{6,2}   = repmat([55:60 61:66 67:72]*1000,1,1) + ones(1,18)*70   + repmat([1],1,18);
TABLE{7,2}   = repmat([55:58 61:64 67:70]*1000,1,1) + ones(1,12)*90   + repmat([1],1,12);
TABLE{8,2}   = repmat([57:60 63:66 69:72]*1000,1,1) + ones(1,12)*110   + repmat([1],1,12);
TABLE{9,2}   = repmat([49:54 55:60]*1000,1,1) + ones(1,12)*130   + repmat([1],1,12);
TABLE{10,2}   = repmat([61:66 67:72]*1000,1,1) + ones(1,12)*150   + repmat([1],1,12);

%% condames
condnames = {'RelWestG_coumap';'RelEastG_coumap'};

%% trial selection
cond = [];
cond  = [TABLE{1,2}(:); TABLE{2,2}(:); TABLE{3,2}(:); TABLE{4,2}(:); TABLE{5,2}(:)];
save([Dir condnames{1} ],'cond') 
cond = [];
cond = [TABLE{6,2}(:); TABLE{7,2}(:); TABLE{8,2}(:); TABLE{9,2}(:); TABLE{10,2}(:)];
save([Dir condnames{2} ],'cond') 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% write list of trigger of interest for each REF cond

[TXT,NUM]   = xlsread('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/fordist/DATES_IMAGING_DEBRIEF_FINAL.xlsx');
[TXT2,NUM2] = xlsread('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/fordist/LONG_IMAGING_DEBRIEF_FINAL.xlsx');

TD_Pre    = abs(TXT - ones(6,6)*2013);
TD_Fut    = abs(TXT - ones(6,6)*2022);
TD_Pas    = abs(TXT - ones(6,6)*2004);
TD_W      = abs(TXT - ones(6,6)*2013);
TD_E      = abs(TXT - ones(6,6)*2013);

SD_Par    = ceil(abs(TXT2 - ones(6,6)*2.35));
SD_Pas    = ceil(abs(TXT2 - ones(6,6)*2.35));
SD_Fut    = ceil(abs(TXT2 - ones(6,6)*2.35));
SD_W      = ceil(abs(TXT2 - ones(6,6)*(-52.3)));
SD_E      = ceil(abs(TXT2 - ones(6,6)*(55.3)));

TD_Pas    = TD_Pas(1:4,:);
SD_Pas    = SD_Pas(1:4,:);
TD_Fut    = TD_Fut(3:6,:);
SD_Fut    = SD_Fut(3:6,:);
TD_W      = TD_W(:,1:4);
SD_W      = SD_W(:,1:4);
TD_E      = TD_E(:,3:6); 
SD_E      = SD_E(:,3:6); 

EVT_Pre  = repmat([37:72]*1000,2,1)                               + ones(2,36)*60  + repmat([1 ;3],1,36);
EVT_Pas  = repmat([37:40 43:46 49:52 55:58 61:64 67:70]*1000,2,1) + ones(2,24)*80  + repmat([1 ;3],1,24);
EVT_Fut  = repmat([39:42 45:48 51:54 57:60 63:66 69:72]*1000,2,1) + ones(2,24)*100 + repmat([1 ;3],1,24);
EVT_W    = repmat([37:60]*1000,2,1)                               + ones(2,24)*120 + repmat([1 ;3],1,24);
EVT_E    = repmat([49:72]*1000,2,1)                               + ones(2,24)*140 + repmat([1 ;3],1,24);

EVS_Pre  = repmat([37:72]*1000,2,1)                               + ones(2,36)*70  + repmat([1 ;3],1,36);
EVS_Pas  = repmat([37:40 43:46 49:52 55:58 61:64 67:70]*1000,2,1) + ones(2,24)*90  + repmat([1 ;3],1,24);
EVS_Fut  = repmat([39:42 45:48 51:54 57:60 63:66 69:72]*1000,2,1) + ones(2,24)*110 + repmat([1 ;3],1,24);
EVS_W    = repmat([37:60]*1000,2,1)                               + ones(2,24)*130 + repmat([1 ;3],1,24);
EVS_E    = repmat([49:72]*1000,2,1)                               + ones(2,24)*150 + repmat([1 ;3],1,24);

tmp1      = [SD_Par(:)';SD_Par(:)']
tmp2      = [SD_Pas(:)';SD_Pas(:)']
tmp3      = [SD_Fut(:)';SD_Fut(:)']
tmp4      = [SD_W(:)'  ;SD_W(:)'  ]
tmp5      = [SD_E(:)'  ;SD_E(:)'  ]

all_distS = [tmp1(:)   ; tmp2(:)   ; tmp3(:)   ; tmp4(:) ; tmp5(:);]
all_EVS   = [EVS_Pre(:); EVS_Pas(:); EVS_Fut(:); EVS_W(:); EVS_E(:)];

tag = 'EVSdistS'

%% get distance percentile to match resolution of temporal distance (25 values)
dist_val = unique(all_distS)
prc =  prctile(dist_val,1/25*100)
distbins = (1:25)*prc 

select_event = []
%% trial selection
x = [];
x = find(all_distS <= distbins(1));
select_event{1} = all_EVS(x)
for i = 2:length(distbins)
    x = [];
    x = find((all_distS <= distbins(i)).*(all_distS > distbins(i-1)));
    select_event{i} = all_EVS(x);
end
x = [];
x = find(all_distS > distbins(25));
select_event{26} = all_EVS(x)

select_event(25) = []
select_event(22) = []

%% condames
condnames = {'dist1s_evs';'dist2s_evs';'dist3s_evs';'dist4s_evs';'dist5s_evs';'dist6s_evs';...
    'dist7s_evs';'dist8s_evs';'dist9s_evs';'dist10s_evs';'dist11s_evs';'dist12s_evs';...
    'dist13s_evs';'dist14s_evs';'dist15s_evs';'dist16s_evs';'dist17s_evs';'dist18s_evs';...
    'dist19s_evs';'dist20s_evs';'dist21s_evs';'dist22s_evs';'dist23s_evs';'dist24s_evs'};

%% trial selection
for i = 1:length(select_event)
    cond = [];
    cond  = select_event{i}
    save([Dir condnames{i} ],'cond')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% write list of trigger of interest for each REF cond
[TXT,NUM]   = xlsread('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/fordist/DATES_IMAGING_DEBRIEF_FINAL.xlsx');
[TXT2,NUM2] = xlsread('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/fordist/LONG_IMAGING_DEBRIEF_FINAL.xlsx');

TD_Pre    = abs(TXT - ones(6,6)*2013);
TD_Fut    = abs(TXT - ones(6,6)*2022);
TD_Pas    = abs(TXT - ones(6,6)*2004);
TD_W      = abs(TXT - ones(6,6)*2013);
TD_E      = abs(TXT - ones(6,6)*2013);

SD_Par    = ceil(abs(TXT2 - ones(6,6)*2.35));
SD_Pas    = ceil(abs(TXT2 - ones(6,6)*2.35));
SD_Fut    = ceil(abs(TXT2 - ones(6,6)*2.35));
SD_W      = ceil(abs(TXT2 - ones(6,6)*(-52.3)));
SD_E      = ceil(abs(TXT2 - ones(6,6)*(55.3)));

TD_Pas    = TD_Pas(1:4,:);
SD_Pas    = SD_Pas(1:4,:);
TD_Fut    = TD_Fut(3:6,:);
SD_Fut    = SD_Fut(3:6,:);
TD_W      = TD_W(:,1:4);
SD_W      = SD_W(:,1:4);
TD_E      = TD_E(:,3:6); 
SD_E      = SD_E(:,3:6); 

EVT_Pre  = repmat([37:72]*1000,2,1)                               + ones(2,36)*60  + repmat([1 ;3],1,36);
EVT_Pas  = repmat([37:40 43:46 49:52 55:58 61:64 67:70]*1000,2,1) + ones(2,24)*80  + repmat([1 ;3],1,24);
EVT_Fut  = repmat([39:42 45:48 51:54 57:60 63:66 69:72]*1000,2,1) + ones(2,24)*100 + repmat([1 ;3],1,24);
EVT_W    = repmat([37:60]*1000,2,1)                               + ones(2,24)*120 + repmat([1 ;3],1,24);
EVT_E    = repmat([49:72]*1000,2,1)                               + ones(2,24)*140 + repmat([1 ;3],1,24);

EVS_Pre  = repmat([37:72]*1000,2,1)                               + ones(2,36)*70  + repmat([1 ;3],1,36);
EVS_Pas  = repmat([37:40 43:46 49:52 55:58 61:64 67:70]*1000,2,1) + ones(2,24)*90  + repmat([1 ;3],1,24);
EVS_Fut  = repmat([39:42 45:48 51:54 57:60 63:66 69:72]*1000,2,1) + ones(2,24)*110 + repmat([1 ;3],1,24);
EVS_W    = repmat([37:60]*1000,2,1)                               + ones(2,24)*130 + repmat([1 ;3],1,24);
EVS_E    = repmat([49:72]*1000,2,1)                               + ones(2,24)*150 + repmat([1 ;3],1,24);

tmp1      = [TD_Pre(:)';TD_Pre(:)']
tmp2      = [TD_Pas(:)';TD_Pas(:)']
tmp3      = [TD_Fut(:)';TD_Fut(:)']
tmp4      = [TD_W(:)'  ;TD_W(:)'  ]
tmp5      = [TD_E(:)'  ;TD_E(:)'  ]

all_distT = [tmp1(:)   ; tmp2(:)   ; tmp3(:)   ; tmp4(:) ; tmp5(:);]
all_EVT   = [EVT_Pre(:); EVT_Pas(:); EVT_Fut(:); EVT_W(:); EVT_E(:)];

tag = 'EVTdistT'

%% trial selection
dist_val = unique(all_distT)
for i = 1:length(dist_val)
    x = [];
    x = find(all_distT == i)
    select_event{i} = all_EVT(x)
end

select_event(9) = []
%% condames
condnames = {'dist1t_evt';'dist2t_evt';'dist3t_evt';'dist4t_evt';'dist5t_evt';'dist6t_evt';...
    'dist7t_evt';'dist8t_evt';'dist9t_evt';'dist10t_evt';'dist11t_evt';'dist12t_evt';...
    'dist13t_evt';'dist14t_evt';'dist15t_evt';'dist16t_evt';'dist17t_evt';'dist18t_evt';...
    'dist19t_evt';'dist20t_evt';'dist21t_evt';'dist22t_evt';'dist23t_evt';'dist24t_evt'};

%% trial selection
for i = 1:length(select_event)
    cond = [];
    cond  = select_event{i}
    save([Dir condnames{i} ],'cond')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tstart = tic;

[TXT,NUM]   = xlsread('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/fordist/DATES_IMAGING_DEBRIEF_FINAL.xlsx');
[TXT2,NUM2] = xlsread('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/fordist/LONG_IMAGING_DEBRIEF_FINAL.xlsx');

TD_Pre    = (TXT - ones(6,6)*2013);
TD_Fut    = (TXT - ones(6,6)*2022);
TD_Pas    = (TXT - ones(6,6)*2004);
TD_W      = (TXT - ones(6,6)*2013);
TD_E      = (TXT - ones(6,6)*2013);

SD_Par    = ceil(abs(TXT2 - ones(6,6)*2.35));
SD_Pas    = ceil(abs(TXT2 - ones(6,6)*2.35));
SD_Fut    = ceil(abs(TXT2 - ones(6,6)*2.35));
SD_W      = ceil(abs(TXT2 - ones(6,6)*(-52.3)));
SD_E      = ceil(abs(TXT2 - ones(6,6)*(55.3)));

TD_Pas    = TD_Pas(1:4,:);
SD_Pas    = SD_Pas(1:4,:);
TD_Fut    = TD_Fut(3:6,:);
SD_Fut    = SD_Fut(3:6,:);
TD_W      = TD_W(:,1:4);
SD_W      = SD_W(:,1:4);
TD_E      = TD_E(:,3:6); 
SD_E      = SD_E(:,3:6); 

EVT_Pre  = repmat([37:72]*1000,2,1)                               + ones(2,36)*60  + repmat([1 ;3],1,36);
EVT_Pas  = repmat([37:40 43:46 49:52 55:58 61:64 67:70]*1000,2,1) + ones(2,24)*80  + repmat([1 ;3],1,24);
EVT_Fut  = repmat([39:42 45:48 51:54 57:60 63:66 69:72]*1000,2,1) + ones(2,24)*100 + repmat([1 ;3],1,24);
EVT_W    = repmat([37:60]*1000,2,1)                               + ones(2,24)*120 + repmat([1 ;3],1,24);
EVT_E    = repmat([49:72]*1000,2,1)                               + ones(2,24)*140 + repmat([1 ;3],1,24);

EVS_Pre  = repmat([37:72]*1000,2,1)                               + ones(2,36)*70  + repmat([1 ;3],1,36);
EVS_Pas  = repmat([37:40 43:46 49:52 55:58 61:64 67:70]*1000,2,1) + ones(2,24)*90  + repmat([1 ;3],1,24);
EVS_Fut  = repmat([39:42 45:48 51:54 57:60 63:66 69:72]*1000,2,1) + ones(2,24)*110 + repmat([1 ;3],1,24);
EVS_W    = repmat([37:60]*1000,2,1)                               + ones(2,24)*130 + repmat([1 ;3],1,24);
EVS_E    = repmat([49:72]*1000,2,1)                               + ones(2,24)*150 + repmat([1 ;3],1,24);

tmp1      = [TD_Pre(:)';TD_Pre(:)']
tmp2      = [TD_Pas(:)';TD_Pas(:)']
tmp3      = [TD_Fut(:)';TD_Fut(:)']
tmp4      = [TD_W(:)'  ;TD_W(:)'  ]
tmp5      = [TD_E(:)'  ;TD_E(:)'  ]

all_distT = [tmp1(:)   ; tmp2(:)   ; tmp3(:)   ; tmp4(:) ; tmp5(:);]
all_EVT   = [EVT_Pre(:); EVT_Pas(:); EVT_Fut(:); EVT_W(:); EVT_E(:)];

tag = 'signEVTdistT'

%% get distance percentile to match resolution of temporal distance (25 values)
dist_val = unique(all_distT)
[n,edges,bin] = histcounts(dist_val,23)

select_event = []
%% trial selection
x = [];
x = find(all_distT <= edges(1));
select_event{1} = all_EVT(x)
for i = 2:length(edges)
    x = [];
    x = find((all_distT <= edges(i)).*(all_distT > edges(i-1)));
    select_event{i} = all_EVT(x);
end

for i = 1:length(select_event)
    condnames{i} = {['signDT' num2str(ceil(edges(i)))]}
end

%% trial selection
for i = 1:length(select_event)
    cond = [];
    cond  = select_event{i}
    save([Dir char(condnames{i}) ],'cond')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tstart = tic;

[TXT,NUM]   = xlsread('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/fordist/DATES_IMAGING_DEBRIEF_FINAL.xlsx');
[TXT2,NUM2] = xlsread('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/fordist/LONG_IMAGING_DEBRIEF_FINAL.xlsx');

TD_Pre    = (TXT - ones(6,6)*2013);
TD_Fut    = (TXT - ones(6,6)*2022);
TD_Pas    = (TXT - ones(6,6)*2004);
TD_W      = (TXT - ones(6,6)*2013);
TD_E      = (TXT - ones(6,6)*2013);

SD_Par    = ceil((TXT2 - ones(6,6)*2.35));
SD_Pas    = ceil((TXT2 - ones(6,6)*2.35));
SD_Fut    = ceil((TXT2 - ones(6,6)*2.35));
SD_W      = ceil((TXT2 - ones(6,6)*(-52.3)));
SD_E      = ceil((TXT2 - ones(6,6)*(55.3)));

TD_Pas    = TD_Pas(1:4,:);
SD_Pas    = SD_Pas(1:4,:);
TD_Fut    = TD_Fut(3:6,:);
SD_Fut    = SD_Fut(3:6,:);
TD_W      = TD_W(:,1:4);
SD_W      = SD_W(:,1:4);
TD_E      = TD_E(:,3:6); 
SD_E      = SD_E(:,3:6); 

EVT_Pre  = repmat([37:72]*1000,2,1)                               + ones(2,36)*60  + repmat([1 ;3],1,36);
EVT_Pas  = repmat([37:40 43:46 49:52 55:58 61:64 67:70]*1000,2,1) + ones(2,24)*80  + repmat([1 ;3],1,24);
EVT_Fut  = repmat([39:42 45:48 51:54 57:60 63:66 69:72]*1000,2,1) + ones(2,24)*100 + repmat([1 ;3],1,24);
EVT_W    = repmat([37:60]*1000,2,1)                               + ones(2,24)*120 + repmat([1 ;3],1,24);
EVT_E    = repmat([49:72]*1000,2,1)                               + ones(2,24)*140 + repmat([1 ;3],1,24);

EVS_Pre  = repmat([37:72]*1000,2,1)                               + ones(2,36)*70  + repmat([1 ;3],1,36);
EVS_Pas  = repmat([37:40 43:46 49:52 55:58 61:64 67:70]*1000,2,1) + ones(2,24)*90  + repmat([1 ;3],1,24);
EVS_Fut  = repmat([39:42 45:48 51:54 57:60 63:66 69:72]*1000,2,1) + ones(2,24)*110 + repmat([1 ;3],1,24);
EVS_W    = repmat([37:60]*1000,2,1)                               + ones(2,24)*130 + repmat([1 ;3],1,24);
EVS_E    = repmat([49:72]*1000,2,1)                               + ones(2,24)*150 + repmat([1 ;3],1,24);

tmp1      = [SD_Par(:)';SD_Par(:)']
tmp2      = [SD_Pas(:)';SD_Pas(:)']
tmp3      = [SD_Fut(:)';SD_Fut(:)']
tmp4      = [SD_W(:)'  ;SD_W(:)'  ]
tmp5      = [SD_E(:)'  ;SD_E(:)'  ]

all_distS = [tmp1(:)   ; tmp2(:)   ; tmp3(:)   ; tmp4(:) ; tmp5(:);]
all_EVS   = [EVS_Pre(:); EVS_Pas(:); EVS_Fut(:); EVS_W(:); EVS_E(:)];

tag = 'SignEVSdistS'

%% get distance percentile to match resolution of temporal distance (25 values)
dist_val = unique(all_distS)
[n,edges,bin] = histcounts(dist_val,28)

select_event = []
%% trial selection
x = [];
x = find(all_distS <= edges(1));
select_event{1} = all_EVS(x)
for i = 2:length(edges)
    x = [];
    x = find((all_distS <= edges(i)).*(all_distS > edges(i-1)));
    select_event{i} = all_EVS(x);
end

select_event(6) = []
edges(6) = []
select_event(4) = []
edges(4) = []
select_event(3) = []
edges(3) = []
select_event(1) = []
edges(1) = []

%% condames
for i = 1:length(select_event)
    condnames{i} = {['signDS' num2str(ceil(edges(i)))]}
end

%% trial selection
for i = 1:length(select_event)
    cond = [];
    cond  = select_event{i}
    save([Dir char(condnames{i}) ],'cond')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tstart = tic;

[TXT,NUM]   = xlsread('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/fordist/DATES_IMAGING_DEBRIEF_FINAL.xlsx');
[TXT2,NUM2] = xlsread('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/fordist/LONG_IMAGING_DEBRIEF_FINAL.xlsx');

SD_Par    = ceil((TXT2 - ones(6,6)*2.35));
SD_Pas    = ceil((TXT2 - ones(6,6)*2.35));
SD_Fut    = ceil((TXT2 - ones(6,6)*2.35));
SD_W      = ceil((TXT2 - ones(6,6)*(-52.3)));
SD_E      = ceil((TXT2 - ones(6,6)*(55.3)));

SD_Pas    = SD_Pas(1:4,:);
SD_Fut    = SD_Fut(3:6,:);
SD_W      = SD_W(:,1:4);
SD_E      = SD_E(:,3:6); 

EVS_Pre  = repmat([37:72]*1000,2,1)                               + ones(2,36)*70  + repmat([1 ;3],1,36);
EVS_Pas  = repmat([37:40 43:46 49:52 55:58 61:64 67:70]*1000,2,1) + ones(2,24)*90  + repmat([1 ;3],1,24);
EVS_Fut  = repmat([39:42 45:48 51:54 57:60 63:66 69:72]*1000,2,1) + ones(2,24)*110 + repmat([1 ;3],1,24);
EVS_W    = repmat([37:60]*1000,2,1)                               + ones(2,24)*130 + repmat([1 ;3],1,24);
EVS_E    = repmat([49:72]*1000,2,1)                               + ones(2,24)*150 + repmat([1 ;3],1,24);

tmp1      = [SD_Par(:)';SD_Par(:)']
tmp2      = [SD_Pas(:)';SD_Pas(:)']
tmp3      = [SD_Fut(:)';SD_Fut(:)']
tmp4      = [SD_W(:)'  ;SD_W(:)'  ]
tmp5      = [SD_E(:)'  ;SD_E(:)'  ]

all_distS = [tmp1(:)   ; tmp2(:)   ; tmp3(:)   ; tmp4(:) ; tmp5(:);]
all_EVS   = [EVS_Pre(:); EVS_Pas(:); EVS_Fut(:); EVS_W(:); EVS_E(:)];

tag = 'SignEVSdistS'

%% get distance percentile to match resolution of temporal distance (25 values)
events_per_bin = length(all_distS)
tmp = (sortrows([all_distS all_EVS]))'
count = 1;
for i = 1:33:events_per_bin
    dist_bin{count} = tmp(2,i:i+32)
    count = count+1
end

select_event = []

%% trial selection
select_event = dist_bin

%% condames
for i = 1:length(select_event)
    condnames{i} = {['signDS8_' num2str(i)]}
end

%% trial selection
for i = 1:length(select_event)
    cond = [];
    cond  = select_event{i}'
    save([Dir char(condnames{i}) ],'cond')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tstart = tic;

[TXT,NUM]   = xlsread('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/fordist/DATES_IMAGING_DEBRIEF_FINAL.xlsx');
[TXT2,NUM2] = xlsread('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/fordist/LONG_IMAGING_DEBRIEF_FINAL.xlsx');

TD_Pre    = (TXT - ones(6,6)*2013);
TD_Fut    = (TXT - ones(6,6)*2022);
TD_Pas    = (TXT - ones(6,6)*2004);
TD_W      = (TXT - ones(6,6)*2013);
TD_E      = (TXT - ones(6,6)*2013);

SD_Par    = ceil(abs(TXT2 - ones(6,6)*2.35));
SD_Pas    = ceil(abs(TXT2 - ones(6,6)*2.35));
SD_Fut    = ceil(abs(TXT2 - ones(6,6)*2.35));
SD_W      = ceil(abs(TXT2 - ones(6,6)*(-52.3)));
SD_E      = ceil(abs(TXT2 - ones(6,6)*(55.3)));

TD_Pas    = TD_Pas(1:4,:);
SD_Pas    = SD_Pas(1:4,:);
TD_Fut    = TD_Fut(3:6,:);
SD_Fut    = SD_Fut(3:6,:);
TD_W      = TD_W(:,1:4);
SD_W      = SD_W(:,1:4);
TD_E      = TD_E(:,3:6); 
SD_E      = SD_E(:,3:6); 

EVT_Pre  = repmat([37:72]*1000,2,1)                               + ones(2,36)*60  + repmat([1 ;3],1,36);
EVT_Pas  = repmat([37:40 43:46 49:52 55:58 61:64 67:70]*1000,2,1) + ones(2,24)*80  + repmat([1 ;3],1,24);
EVT_Fut  = repmat([39:42 45:48 51:54 57:60 63:66 69:72]*1000,2,1) + ones(2,24)*100 + repmat([1 ;3],1,24);
EVT_W    = repmat([37:60]*1000,2,1)                               + ones(2,24)*120 + repmat([1 ;3],1,24);
EVT_E    = repmat([49:72]*1000,2,1)                               + ones(2,24)*140 + repmat([1 ;3],1,24);

EVS_Pre  = repmat([37:72]*1000,2,1)                               + ones(2,36)*70  + repmat([1 ;3],1,36);
EVS_Pas  = repmat([37:40 43:46 49:52 55:58 61:64 67:70]*1000,2,1) + ones(2,24)*90  + repmat([1 ;3],1,24);
EVS_Fut  = repmat([39:42 45:48 51:54 57:60 63:66 69:72]*1000,2,1) + ones(2,24)*110 + repmat([1 ;3],1,24);
EVS_W    = repmat([37:60]*1000,2,1)                               + ones(2,24)*130 + repmat([1 ;3],1,24);
EVS_E    = repmat([49:72]*1000,2,1)                               + ones(2,24)*150 + repmat([1 ;3],1,24);

tmp1      = [TD_Pre(:)';TD_Pre(:)']
tmp2      = [TD_Pas(:)';TD_Pas(:)']
tmp3      = [TD_Fut(:)';TD_Fut(:)']
tmp4      = [TD_W(:)'  ;TD_W(:)'  ]
tmp5      = [TD_E(:)'  ;TD_E(:)'  ]

all_distT = [tmp1(:)   ; tmp2(:)   ; tmp3(:)   ; tmp4(:) ; tmp5(:);]
all_EVT   = [EVT_Pre(:); EVT_Pas(:); EVT_Fut(:); EVT_W(:); EVT_E(:)];

tag = 'signEVTdistT'

%% get distance percentile to match resolution of temporal distance (25 values)
events_per_bin = length(all_distT)
tmp = (sortrows([all_distT all_EVT]))'
count = 1;
for i = 1:33:events_per_bin
    dist_bin{count} = tmp(2,i:i+32)
    count = count+1
end

select_event = []

%% trial selection
select_event = dist_bin

%% condames
for i = 1:length(select_event)
    condnames{i} = {['signDT8_' num2str(i)]}
end
%% trial selection
for i = 1:length(select_event)
    cond = [];
    cond  = select_event{i}'
    save([Dir char(condnames{i}) ],'cond')
end

