TIME_MAPS_DEBRIEF_2(niplist)

% MT time maps debrief analysis
clear all
close all

% compute average masked dates
niplist = {'rg130377';'ad120287';'cv120216';'gd130362';'am090241';'cp130387';...
           'el130325';'PB130006';'sb130326';'df130078';'jn120580'};
       
DATA_DB = [];  
DATA_DB_mask = ones(6,6,length(niplist));
indNaN = ones(6,6,length(niplist));
for i = 1:length(niplist)
    File_Events = ['C:\MTT_MEG\psych\date_'  niplist{i} '_DEBRIEF.xlsx'];
    [DEB_DATES,TXT] = xlsread(File_Events);
    DATA_DB = cat(3,DATA_DB,DEB_DATES);
end
    
ind1 = (DATA_DB == 1);
ind2 = (DATA_DB == 0);
ind3 = (DATA_DB == -1);
ind3 = (DATA_DB == -1);
ind4 = (isnan(DATA_DB));
indnan = (ind1 | ind2 | ind3 | ind4);
for i =1:6
    for j =1:6
        for k = 1:length(niplist)
            if indnan(i,j,k) == 1;
                indNaN(i,j,k) = NaN;
            end
        end
    end
end


File_dates = ['C:\Users\bgauthie\Desktop\ONGOING_PROJECTS\MENTAL_TIME_TRAVEL\STIM\EVENTS\EVENTS_Psycho\DATE_IMAGING.xlsx'];
[DATES,TXT] = xlsread(File_dates);  
DATES(2)  = 2004;
DATES(27) = 2013;

DATES_rep  = repmat(DATES,[1 1 length(niplist)]);
DATES_diff = DATES_rep-DATA_DB.*indNaN;
DATES_err  = not(DATES_diff == 0);
sum(DATES_err,3)

fig1 = figure('position',[1 1 1500 1000]);
set(fig1,'PaperPosition',[1 1 1500 1000])
set(fig1,'PaperPositionmode','auto')

subplot(3,3,1); imagesc(DATES,[1980 2040])
title('Real Dates (y)');colorbar    
subplot(3,3,2); imagesc(squeeze(nanmean(DATA_DB.*indNaN,3)),[1980 2040])
title('Dates Report avg (y)');colorbar
subplot(3,3,3); imagesc(squeeze(nanstd(DATA_DB.*indNaN,0,3)),[0 10])
title('Dates Report std (y)');colorbar
subplot(3,3,4); imagesc(DATES - squeeze(nanmean(DATA_DB.*indNaN,3)),[-10 10])
title('Real Dates - Report (y)');colorbar  
subplot(3,3,5); imagesc(sum(DATES_err,3),[0 length(niplist)])
title('Error Count');colorbar 
subplot(3,3,7);tmp = DATES - squeeze(nanmean(DATA_DB.*indNaN,3));
bar(nanmean(tmp)); hold on; errorbar(nanmean(tmp),nanstd(tmp),'linestyle','none');
set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]); axis([0 7 -3 5]);
title('[Real Dates - Report] +-std (y)'); xlabel('temporal distance') 
subplot(3,3,8);tmp = sum(DATES_err,3);
bar(nanmean(tmp)); hold on; errorbar(nanmean(tmp),nanstd(tmp),'linestyle','none');
set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]); axis([0 7 0 length(niplist)]);
title('Error count (nb)'); xlabel('temporal distance') 

print('-dpng','C:\Users\bgauthie\Desktop\ONGOING_PROJECTS\MENTAL_TIME_TRAVEL\Results\DEBRIEF_TIME_MAPS_2')

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
















