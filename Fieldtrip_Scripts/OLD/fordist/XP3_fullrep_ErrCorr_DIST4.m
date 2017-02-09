%%

% SOME HEADER

%%

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
TD_Pre_quartiled(TD_Pre<5.5) = 4;
TD_Pre_quartiled(TD_Pre>=5.5  & TD_Pre <12) = 3;
TD_Pre_quartiled(TD_Pre>=12  & TD_Pre <20.5) = 2;
TD_Pre_quartiled(TD_Pre>=20.5) = 1;

y = []; a = []; a = TD_Fut(3:6,1:6);y = quantile(a(:),3);
TD_Fut_quartiled = a;
TD_Fut_quartiled(TD_Fut(3:6,1:6)<5.5)  = 4;
TD_Fut_quartiled(TD_Fut(3:6,1:6)>=5.5  & TD_Fut(3:6,1:6) <9) = 3;
TD_Fut_quartiled(TD_Fut(3:6,1:6)>=9  & TD_Fut(3:6,1:6) <14) = 2;
TD_Fut_quartiled(TD_Fut(3:6,1:6)>=14) = 1;

y = []; a = []; a = TD_Pas(1:4,1:6);y = quantile(a(:),3);
TD_Pas_quartiled = a;
TD_Pas_quartiled(TD_Pas(1:4,1:6)<3) = 4;
TD_Pas_quartiled(TD_Pas(1:4,1:6)>=3 & TD_Pas(1:4,1:6) <9) = 3;
TD_Pas_quartiled(TD_Pas(1:4,1:6)>=9 & TD_Pas(1:4,1:6) <12) = 2;
TD_Pas_quartiled(TD_Pas(1:4,1:6)>=12) = 1;

y = []; a = []; a = TD_Pre(:,1:4);y = quantile(a(:),3);
TD_W_quartiled = a;
TD_W_quartiled(TD_Pre(:,1:4)<6) = 4;
TD_W_quartiled(TD_Pre(:,1:4)>=6 & TD_Pre(:,1:4) <11.5) = 3;
TD_W_quartiled(TD_Pre(:,1:4)>=11.5 & TD_Pre(:,1:4) <20) = 2;
TD_W_quartiled(TD_Pre(:,1:4)>=20) = 1;

y = []; a = []; a = TD_Pre(:,3:6);y = quantile(a(:),3);
TD_E_quartiled = a;
TD_E_quartiled(TD_Pre(:,3:6)<4.5) = 4;
TD_E_quartiled(TD_Pre(:,3:6)>=4.5 & TD_Pre(:,3:6) <12.5) = 3;
TD_E_quartiled(TD_Pre(:,3:6)>=12.5 & TD_Pre(:,3:6) <20.5) = 2;
TD_E_quartiled(TD_Pre(:,3:6)>=20.5) = 1;

%% "quartilation" of spatial distance
y = []; a = []; a = SD_Par;y = quantile(a(:),3);
SD_Par_quartiled = a;
SD_Par_quartiled(SD_Par<33.5) = 4;
SD_Par_quartiled(SD_Par>=33.5  & SD_Par <76.5) = 3;
SD_Par_quartiled(SD_Par>=76.5  & SD_Par <118) = 2;
SD_Par_quartiled(SD_Par>=118) = 1;

y = []; a = []; a = SD_W(1:6,1:4);y = quantile(a(:),3);
SD_W_quartiled = a;
SD_W_quartiled(SD_W(1:6,1:4)<38) = 4;
SD_W_quartiled(SD_W(1:6,1:4)>=38  & SD_W(1:6,1:4) <54) = 3;
SD_W_quartiled(SD_W(1:6,1:4)>=54  & SD_W(1:6,1:4) <70) = 2;
SD_W_quartiled(SD_W(1:6,1:4)>=70) = 1;

y = []; a = []; a = SD_E(1:6,3:6);y = quantile(a(:),3);
SD_E_quartiled = a;
SD_E_quartiled(SD_E(1:6,3:6)<20.5) = 4;
SD_E_quartiled(SD_E(1:6,3:6)>=20.5  & SD_E(1:6,3:6) <49.5) = 3;
SD_E_quartiled(SD_E(1:6,3:6)>=49.5  & SD_E(1:6,3:6) <65) = 2;
SD_E_quartiled(SD_E(1:6,3:6)>=65) = 1;

y = []; a = []; a = SD_Par(1:4,:);y = quantile(a(:),3);
SD_Pas_quartiled = a;
SD_Pas_quartiled(SD_Par(1:4,:)<38) = 4;
SD_Pas_quartiled(SD_Par(1:4,:)>=38  & SD_Par(1:4,:) <80) = 3;
SD_Pas_quartiled(SD_Par(1:4,:)>=80  & SD_Par(1:4,:) <118.5) = 2;
SD_Pas_quartiled(SD_Par(1:4,:)>=118.5) = 1;

y = []; a = []; a = SD_Par(3:6,:);y = quantile(a(:),3);
SD_Fut_quartiled = a;
SD_Fut_quartiled(SD_Par(3:6,:)<25.5) = 4;
SD_Fut_quartiled(SD_Par(3:6,:)>=25.5  & SD_Par(3:6,:) <78) = 3;
SD_Fut_quartiled(SD_Par(3:6,:)>=78  & SD_Par(3:6,:) <118) = 2;
SD_Fut_quartiled(SD_Par(3:6,:)>=118) = 1;

