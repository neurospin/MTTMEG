%Time referential based on subject debriefing

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 1600 800]);
set(fig1,'PaperPosition',[1 1 1600 800])
set(fig1,'PaperPositionmode','auto')

SubjectList = {'rg130377';'ad120287';'cv120216';'gd130362';'am090241';'cp130387'};

DATA = [];
for i = 1:length(SubjectList)
    [DATES,TXT] = xlsread(['C:\MTT_MEG\psych\date_'  niplist{i} '_DEBRIEF.xlsx']);
    DATA = cat(3,DATA,DATES);
    subplot(3,4,i); imagesc(DATES,[1950 2050]);xlabel('Space');ylabel('Time');title([SubjectList{i} 'Debrief Time Maps'])
    colorbar;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[REF_DATES,TXT] = xlsread('C:\Users\bgauthie\Desktop\ONGOING_PROJECTS\MENTAL_TIME_TRAVEL\STIM\EVENTS\EVENTS_Psycho\DATE_IMAGING.xlsx');

fig1 = figure('position',[1 1 1600 800]);
set(fig1,'PaperPosition',[1 1 1600 800])
set(fig1,'PaperPositionmode','auto')

DATA = [];
for i = 1:length(SubjectList)
    [DATES,TXT] = xlsread(['C:\MTT_MEG\psych\date_'  niplist{i} '_DEBRIEF.xlsx']);
    DATA = cat(3,DATA,DATES);
    subplot(3,4,i); imagesc(DATES-REF_DATES,[-27 +27]);xlabel('Space');ylabel('Time');title([SubjectList{i} 'Debrief Time Maps'])
    colorbar;
end    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 1600 800]);
set(fig1,'PaperPosition',[1 1 1600 800])
set(fig1,'PaperPositionmode','auto')

DATA = [];
for i = 1:length(SubjectList)
    [DATES,TXT] = xlsread(['C:\MTT_MEG\psych\date_'  niplist{i} '_DEBRIEF.xlsx']);
    DATA = cat(3,DATA,DATES);
    subplot(3,4,i); imagesc(DATES-REF_DATES,[-27 +27]);xlabel('Space');ylabel('Time');title([SubjectList{i} 'Debrief Time Maps'])
    colorbar;
end  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 1600 800]);
set(fig1,'PaperPosition',[1 1 1600 800])
set(fig1,'PaperPositionmode','auto')

ERR = zeros(6,6);
for i = 1:length(SubjectList)
    [DATES,TXT] = xlsread(['C:\MTT_MEG\psych\date_'  niplist{i} '_DEBRIEF.xlsx']);
    ERR = ERR + (DATES == REF_DATES);
end
subplot(3,4,i); imagesc(ERR,[0 12]);xlabel('Space');ylabel('Time');title([SubjectList{i} 'Debrief ERR Maps']);colorbar;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
