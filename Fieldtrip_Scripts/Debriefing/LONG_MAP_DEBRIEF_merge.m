LONG_MAPS_DEBRIEF_merge(niplist)

% MT time maps debrief analysis
clear all
close all

% compute average masked dates
niplist = {'rg130377';'ad120287';'cv120216';'gd130362';'am090241';'cp130387';...
           'el130325';'PB130006';'sb130326';'df130078';'jn120580';'nipbenoit';'niplaetitia';...
           'sd130343';'wb120579';'sb130354';'fd130308';'hm070076'};
       
LONG_DB = [];  
LONG_DB_mask = ones(6,6,length(niplist));
indNaN = ones(6,6,length(niplist));
for i = 1:length(niplist)
    File_Events = ['C:\MTT_MEG\psych\' niplist{i} '_long_DEBRIEF.xlsx'];
    [DEB_LONG,TXT] = xlsread(File_Events);
    LONG_DB = cat(3,LONG_DB,DEB_LONG);
end

File_dates = ['C:\Users\bgauthie\Desktop\ONGOING_PROJECTS\MENTAL_TIME_TRAVEL\STIM\EVENTS\EVENTS_Psycho\LONG_IMAGING.xlsx'];
[LONG,TXT] = xlsread(File_dates);  

LONG_rep  = repmat(LONG,[1 1 length(niplist)]);
LONG_diff = LONG_rep-LONG_DB.*indNaN;
LONG_err  = not(LONG_diff == 0);
sum(LONG_err,3)

fig1 = figure('position',[1 1 1500 1000]);
set(fig1,'PaperPosition',[1 1 1500 1000])
set(fig1,'PaperPositionmode','auto')

subplot(3,3,1); imagesc(LONG,[-160 160])
title('Real Long (y)');colorbar    
subplot(3,3,2); imagesc(squeeze(nanmean(LONG_DB,3)),[-1 1])
title('avg long Report Accuracy Index (a.u.)');colorbar
subplot(3,3,3); bar(mean(mean(LONG_DB,3))); hold on;
errorbar(mean(mean(LONG_DB,3)),std(mean(LONG_DB,3)));

subplot(3,3,4); bar(mean(sum(LONG_DB == -1),3)); hold on;
errorbar(mean(sum(LONG_DB == -1),3),std(sum(LONG_DB == -1,3)),'linestyle','none');title('forgotten or misplaced')
set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);xlabel('spatial distance');
subplot(3,3,5); bar(mean(sum(LONG_DB == 0),3)); hold on;
errorbar(mean(sum(LONG_DB == 0),3),std(sum(LONG_DB == 0,3)),'linestyle','none');title('approximately placed')
set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);xlabel('spatial distance');
subplot(3,3,6); bar(mean(sum(LONG_DB == 1),3)); hold on;
errorbar(mean(sum(LONG_DB == 1),3),std(sum(LONG_DB == 1,3)),'linestyle','none');title('well placed')
set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);xlabel('spatial distance');

print('-dpng','C:\Users\bgauthie\Desktop\ONGOING_PROJECTS\MENTAL_TIME_TRAVEL\Results\DEBRIEF_LONG_MAPS_merge')

%% for R
TD    = repmat([-3;-2;-1;1;2;3],[1 6 11]);
TIME  = repmat([1 ;2 ;3 ;4;5;6],[1 6 11]);
SD    = repmat([-3 -2 -1 1 2 3],[6 1 11]);
SPACE = repmat([1  2  3  4 5 6],[6 1 11]);
BA    = repmat([-1;-1;-1;1;1;1],[1 6 11]);
WE    = repmat([-1 -1 -1 1 1 1],[6 1 11]);
SUBJ  = [];
for i = 1:length(niplist)
    SUBJ = cat(3,SUBJ,ones(6,6)*i);
end

% write results in a text file
WriteDataFile = 'C:\Users\bgauthie\Desktop\ONGOING_PROJECTS\MENTAL_TIME_TRAVEL\forR\DEBRIEF_STATS_2.txt';
fileID = fopen(WriteDataFile,'w');

DATAforR1 = []; 
DATAforR2 = [];

% data as columns and labels
DATAforR1 = [DATES_err(:) DATES_diff(:) TD(:) TIME(:) SD(:) SPACE(:) BA(:) WE(:) SUBJ(:)];

DATAforR2{1,1}  = 'Err';
DATAforR2{1,2}  = 'Diff';
DATAforR2{1,3}  = 'TD';
DATAforR2{1,4}  = 'TIME';
DATAforR2{1,5}  = 'SD';
DATAforR2{1,6}  = 'SPACE';
DATAforR2{1,7}  = 'BA';
DATAforR2{1,8}  = 'WE';
DATAforR2{1,9}  = 'SUBJ';

for i = 1:size(DATAforR1,1)
    for j = 1:size(DATAforR1,2)
        DATAforR2{i+1,j} = DATAforR1(i,j);
    end
end

% write data in a text file readable by R
for i = 1:size(DATAforR2,1)
    for j = 1:size(DATAforR2,2)
        if j == 1
            fprintf(fileID, '%s', [' ' num2str(DATAforR2{i,j})]);
        elseif j < size(DATAforR2,2)
            fprintf(fileID, '%s', [' ' num2str(DATAforR2{i,j})]);
        elseif j == size(DATAforR2,2)
            fprintf(fileID, '%s\n', [' ' num2str(DATAforR2{i,j})]);
        end
    end
end
close all
















