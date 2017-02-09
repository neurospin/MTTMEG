function CombineTrialsDIST3(nip)

% write list of trigger of interest for each REF cond
tstart = tic;

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

% name of recombined conditions
TABLE{1,1}     = 'TDqrt1_1';
TABLE{2,1}     = 'TDqrt1_2';
TABLE{3,1}     = 'TDqrt1_3';
TABLE{4,1}     = 'TDqrt1_4';
TABLE{5,1}     = 'TDqrt1_5';

TABLE{6,1}     = 'TDqrt2_1';
TABLE{7,1}     = 'TDqrt2_2';
TABLE{8,1}     = 'TDqrt2_3';
TABLE{9,1}     = 'TDqrt2_4';
TABLE{10,1}   = 'TDqrt2_5';

TABLE{11,1}     = 'TDqrt3_1';
TABLE{12,1}     = 'TDqrt3_2';
TABLE{13,1}     = 'TDqrt3_3';
TABLE{14,1}     = 'TDqrt3_4';
TABLE{15,1}     = 'TDqrt3_5';

TABLE{16,1}     = 'TDqrt4_1';
TABLE{17,1}     = 'TDqrt4_2';
TABLE{18,1}     = 'TDqrt4_3';
TABLE{19,1}     = 'TDqrt4_4';
TABLE{20,1}     = 'TDqrt4_5';

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
TABLE{1,2}     = repmat(EVENTSCODE_PrePar(TD_Pre_quartiled == 1)*1000,1,5) + repmat(60:64,size(EVENTSCODE_PrePar(TD_Pre_quartiled == 1),1),1);
TABLE{2,2}     = repmat(EVENTSCODE_PasPar(TD_Pas_quartiled == 1)*1000,1,5)+ repmat(80:84,size(EVENTSCODE_PasPar(TD_Pas_quartiled == 1),1),1);
TABLE{3,2}     = repmat(EVENTSCODE_FutPar(TD_Fut_quartiled == 1)*1000,1,5)+ repmat(100:104,size(EVENTSCODE_FutPar(TD_Fut_quartiled == 1),1),1);
TABLE{4,2}     = repmat(EVENTSCODE_PreW(TD_W_quartiled == 1)*1000,1,5)+ repmat(120:124,size(EVENTSCODE_PreW(TD_W_quartiled == 1),1),1);
TABLE{5,2}     = repmat(EVENTSCODE_PreE(TD_E_quartiled == 1)*1000,1,5)+ repmat(140:144,size(EVENTSCODE_PreE(TD_E_quartiled == 1),1),1);

TABLE{6,2}     = repmat(EVENTSCODE_PrePar(TD_Pre_quartiled == 2)*1000,1,5) + repmat(60:64,size(EVENTSCODE_PrePar(TD_Pre_quartiled == 2),1),1);
TABLE{7,2}     = repmat(EVENTSCODE_PasPar(TD_Pas_quartiled == 2)*1000,1,5)+ repmat(80:84,size(EVENTSCODE_PasPar(TD_Pas_quartiled == 2),1),1);
TABLE{8,2}     = repmat(EVENTSCODE_FutPar(TD_Fut_quartiled == 2)*1000,1,5)+ repmat(100:104,size(EVENTSCODE_FutPar(TD_Fut_quartiled == 2),1),1);
TABLE{9,2}     = repmat(EVENTSCODE_PreW(TD_W_quartiled == 2)*1000,1,5)+ repmat(120:124,size(EVENTSCODE_PreW(TD_W_quartiled == 2),1),1);
TABLE{10,2}   = repmat(EVENTSCODE_PreE(TD_E_quartiled == 2)*1000,1,5)+ repmat(140:144,size(EVENTSCODE_PreE(TD_E_quartiled == 2),1),1);

TABLE{11,2}   = repmat(EVENTSCODE_PrePar(TD_Pre_quartiled == 3)*1000,1,5) + repmat(60:64,size(EVENTSCODE_PrePar(TD_Pre_quartiled == 3),1),1);
TABLE{12,2}   = repmat(EVENTSCODE_PasPar(TD_Pas_quartiled == 3)*1000,1,5)+ repmat(80:84,size(EVENTSCODE_PasPar(TD_Pas_quartiled == 3),1),1);
TABLE{13,2}   = repmat(EVENTSCODE_FutPar(TD_Fut_quartiled == 3)*1000,1,5)+ repmat(100:104,size(EVENTSCODE_FutPar(TD_Fut_quartiled == 3),1),1);
TABLE{14,2}   = repmat(EVENTSCODE_PreW(TD_W_quartiled == 3)*1000,1,5)+ repmat(120:124,size(EVENTSCODE_PreW(TD_W_quartiled == 3),1),1);
TABLE{15,2}   = repmat(EVENTSCODE_PreE(TD_E_quartiled == 3)*1000,1,5)+ repmat(140:144,size(EVENTSCODE_PreE(TD_E_quartiled == 3),1),1);

TABLE{16,2}   = repmat(EVENTSCODE_PrePar(TD_Pre_quartiled == 4)*1000,1,5) + repmat(60:64,size(EVENTSCODE_PrePar(TD_Pre_quartiled == 4),1),1);
TABLE{17,2}   = repmat(EVENTSCODE_PasPar(TD_Pas_quartiled == 4)*1000,1,5)+ repmat(80:84,size(EVENTSCODE_PasPar(TD_Pas_quartiled == 4),1),1);
TABLE{18,2}   = repmat(EVENTSCODE_FutPar(TD_Fut_quartiled == 4)*1000,1,5)+ repmat(100:104,size(EVENTSCODE_FutPar(TD_Fut_quartiled == 4),1),1);
TABLE{19,2}   = repmat(EVENTSCODE_PreW(TD_W_quartiled == 4)*1000,1,5)+ repmat(120:124,size(EVENTSCODE_PreW(TD_W_quartiled == 4),1),1);
TABLE{20,2}   = repmat(EVENTSCODE_PreE(TD_E_quartiled == 4)*1000,1,5)+ repmat(140:144,size(EVENTSCODE_PreE(TD_E_quartiled == 4),1),1);

TABLE{21,2}     = repmat(EVENTSCODE_PrePar(SD_Par_quartiled == 1)*1000,1,5) + repmat(70:74,size(EVENTSCODE_PrePar(SD_Par_quartiled == 1),1),1);
TABLE{22,2}     = repmat(EVENTSCODE_PasPar(SD_Pas_quartiled == 1)*1000,1,5)+ repmat(90:94,size(EVENTSCODE_PasPar(SD_Pas_quartiled == 1),1),1);
TABLE{23,2}     = repmat(EVENTSCODE_FutPar(SD_Fut_quartiled == 1)*1000,1,5)+ repmat(110:114,size(EVENTSCODE_FutPar(SD_Fut_quartiled == 1),1),1);
TABLE{24,2}     = repmat(EVENTSCODE_PreW(SD_W_quartiled == 1)*1000,1,5)+ repmat(130:134,size(EVENTSCODE_PreW(SD_W_quartiled == 1),1),1);
TABLE{25,2}     = repmat(EVENTSCODE_PreE(SD_E_quartiled == 1)*1000,1,5)+ repmat(150:154,size(EVENTSCODE_PreE(SD_E_quartiled == 1),1),1);

TABLE{26,2}     = repmat(EVENTSCODE_PrePar(SD_Par_quartiled == 2)*1000,1,5) + repmat(70:74,size(EVENTSCODE_PrePar(SD_Par_quartiled == 2),1),1);
TABLE{27,2}     = repmat(EVENTSCODE_PasPar(SD_Pas_quartiled == 2)*1000,1,5)+ repmat(90:94,size(EVENTSCODE_PasPar(SD_Pas_quartiled == 2),1),1);
TABLE{28,2}     = repmat(EVENTSCODE_FutPar(SD_Fut_quartiled == 2)*1000,1,5)+ repmat(110:114,size(EVENTSCODE_FutPar(SD_Fut_quartiled == 2),1),1);
TABLE{29,2}     = repmat(EVENTSCODE_PreW(SD_W_quartiled == 2)*1000,1,5)+ repmat(130:134,size(EVENTSCODE_PreW(SD_W_quartiled == 2),1),1);
TABLE{30,2}   = repmat(EVENTSCODE_PreE(SD_E_quartiled == 2)*1000,1,5)+ repmat(150:154,size(EVENTSCODE_PreE(SD_E_quartiled == 2),1),1);

TABLE{31,2}   = repmat(EVENTSCODE_PrePar(SD_Par_quartiled == 3)*1000,1,5) + repmat(70:74,size(EVENTSCODE_PrePar(SD_Par_quartiled == 3),1),1);
TABLE{32,2}   = repmat(EVENTSCODE_PasPar(SD_Pas_quartiled == 3)*1000,1,5)+ repmat(90:94,size(EVENTSCODE_PasPar(SD_Pas_quartiled == 3),1),1);
TABLE{33,2}   = repmat(EVENTSCODE_FutPar(SD_Fut_quartiled == 3)*1000,1,5)+ repmat(110:114,size(EVENTSCODE_FutPar(SD_Fut_quartiled == 3),1),1);
TABLE{34,2}   = repmat(EVENTSCODE_PreW(SD_W_quartiled == 3)*1000,1,5)+ repmat(130:134,size(EVENTSCODE_PreW(SD_W_quartiled == 3),1),1);
TABLE{35,2}   = repmat(EVENTSCODE_PreE(SD_E_quartiled == 3)*1000,1,5)+ repmat(150:154,size(EVENTSCODE_PreE(SD_E_quartiled == 3),1),1);

TABLE{36,2}   = repmat(EVENTSCODE_PrePar(SD_Par_quartiled == 4)*1000,1,5) + repmat(70:74,size(EVENTSCODE_PrePar(SD_Par_quartiled == 4),1),1);
TABLE{37,2}   = repmat(EVENTSCODE_PasPar(SD_Pas_quartiled == 4)*1000,1,5)+ repmat(90:94,size(EVENTSCODE_PasPar(SD_Pas_quartiled == 4),1),1);
TABLE{38,2}   = repmat(EVENTSCODE_FutPar(SD_Fut_quartiled == 4)*1000,1,5)+ repmat(110:114,size(EVENTSCODE_FutPar(SD_Fut_quartiled == 4),1),1);
TABLE{39,2}   = repmat(EVENTSCODE_PreW(SD_W_quartiled == 4)*1000,1,5)+ repmat(130:134,size(EVENTSCODE_PreW(SD_W_quartiled == 4),1),1);
TABLE{40,2}   = repmat(EVENTSCODE_PreE(SD_E_quartiled == 4)*1000,1,5)+ repmat(150:154,size(EVENTSCODE_PreE(SD_E_quartiled == 4),1),1);

NAMESLIST = [];
FOLDER = ['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' nip '/MegData/Processed_new/'];
for i = 1:size(TABLE,1)
    
    j = 1;
    k = 1;
    instr1 = 'datafilt40 = ft_appenddata([],';
    instr2 = 'data = ft_appenddata([],';
    
    while j <= length(TABLE{i,2}(:))
        
        if isempty(get_filenames(FOLDER,'QT',num2str(TABLE{i,2}(j)))) == 0
            NAMESLIST{i}{k} = get_filenames(FOLDER,'QT',num2str(TABLE{i,2}(j)));
            
            Blahfilt40{i,k}    = load([FOLDER char(NAMESLIST{i}{k}(2:2:end,:))]);
            Blahfilt40{i,k}.datafilt40.cfg = rmfield(Blahfilt40{i,k}.datafilt40.cfg,'previous');
            instr1               = [instr1 'Blahfilt40{' num2str(i) ',' num2str(k) '}.datafilt40,'];
            
            Blah{i,k}            = load([FOLDER char(NAMESLIST{i}{k}(1:2:end,:))]);
            Blah{i,k}.data.cfg = rmfield(Blah{i,k}.data.cfg,'previous');
            instr2                = [instr2 'Blah{' num2str(i) ',' num2str(k) '}.data,'];
            
            k = k+1;
        end
        j = j+1;
    end
    instr1(end) = []; instr1 = [instr1 ');'];
    instr2(end) = []; instr2 = [instr2 ');'];
    eval(instr1);
    eval(instr2);
    save(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' nip '/MegData/Processed/' TABLE{i,1}  '.mat'],'data')
    save(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' nip '/MegData/Processed/' TABLE{i,1}  'filt40.mat'],'datafilt40')
end

disp(['elapsed time for get file list ' num2str( toc(tstart))])

