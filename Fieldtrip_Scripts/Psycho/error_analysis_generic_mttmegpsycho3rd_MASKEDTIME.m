function [DATA_s_Ref,DATA_t_Ref] = error_analysis_generic_mttmegpsycho3rd_MASKEDTIME(FOLDER,NIP,varargin)

% load events description to get conditions structure
File_Events = ['C:\Users\bgauthie\Desktop\ONGOING_PROJECTS\MENTAL_TIME_TRAVEL\STIM\EVENTS\EVENTS_Psycho\EVENT_IMAGING.xlsx'];
[NUM,EVENTS] = xlsread(File_Events);

% get file names for the combination of interest
NAMESLIST = get_filenames(FOLDER,NIP,varargin{:});

File_Events = ['C:\Users\bgauthie\Desktop\ONGOING_PROJECTS\MENTAL_TIME_TRAVEL\STIM\EVENTS\EVENTS_Psycho\DATE_IMAGING.xlsx'];
[DATE,TXT] = xlsread(File_Events);

File_Events = ['C:\Users\bgauthie\Desktop\ONGOING_PROJECTS\MENTAL_TIME_TRAVEL\STIM\EVENTS\EVENTS_Psycho\DATE_IMAGING_DEBRIEF.xlsx'];
[DATE_DEBRIEF,TXT] = xlsread(File_Events);

File_Events = ['C:\Users\bgauthie\Desktop\ONGOING_PROJECTS\MENTAL_TIME_TRAVEL\STIM\EVENTS\EVENTS_Psycho\LONG_IMAGING.xlsx'];
[LONG,TXT] = xlsread(File_Events);

% load time debrief results
try
    File_Events = ['C:\MTT_MEG\psych\date_' NIP '_DEBRIEF.xlsx'];
    [DEB_DATE,TXT] = xlsread(File_Events);
    for i = 1:6
        for j = 1:6
            if DEB_DATE(i,j) == DATE_DEBRIEF(i,j)
                DEB_MASK_TIME(i,j) = 1;
            else
                DEB_MASK_TIME(i,j) = NaN;
            end
        end
    end
catch
    disp('no debrief file for this subject')
    DEB_MASK_TIME = ones(6,6);
end

% load time debrief results
try
    File_Events = ['C:\MTT_MEG\psych\' NIP '_long_DEBRIEF.xlsx'];
    [DEB_LONG,TXT] = xlsread(File_Events);
    [x,y] = find(DEB_LONG == -1);
    DEB_LONG_MASK = ones(6,6);
    for i = 1:length(x)
        DEB_LONG_MASK(x(i),y(i)) = NaN;
    end
catch
    disp('no debrief file for this subject')
        DEB_LONG_MASK = ones(6,6);
end

% load data for each repetition
for r = 1:length(NAMESLIST)
    % create dummy variable
    REPETITION{r} = load([FOLDER '\' NAMESLIST{r,1}],'RT','REF','DIM','EVENTS','RespValStore');
    REFALL(r) = REPETITION{r}.REF;
end

for i = unique(REFALL)
    nref{i} = find(REFALL == i);
end

DATESind{1} = [1:2 7:8  13:14 19:20 25:26 31:32];
DATESind{2} = [1:3 7:9  13:15 19:21 25:27 31:33];
DATESind{3} = [1:4 7:10 13:16 19:22 25:28 31:34];
DATESind{6} = [1:3 7:9  13:15 19:21 25:27 31:33];
DATESind{5} = [1:3 7:9  13:15 19:21 25:27 31:33];
DATESind{4} = [1:3 7:9  13:15 19:21 25:27 31:33];

LONGSind{1} = [1 7 13    2 8 14    3 9 15    4 10 16    5 11 17    6 12 18   ];
LONGSind{2} = [1 7 13    2 8 14    3 9 15    4 10 16    5 11 17    6 12 18   ];
LONGSind{3} = [1 7 13    2 8 14    3 9 15    4 10 16    5 11 17    6 12 18   ];
LONGSind{6} = [1 7 13    2 8 14    3 9 15    4 10 16    5 11 17    6 12 18   ];
LONGSind{5} = [1 7       2 8       3 9       4 10       5 11       6 12      ];
LONGSind{4} = [1 7 13 19 2 8 14 20 3 9 15 21 4 10 16 22 5 11 17 23 6 12 18 24];

for r = 1:length(nref)
    for n = 1:length(nref{r})
        DATA_t{r}(n,:) = ones(1,36)*NaN;
        for i = 1:48
            count_t = 1;
            while count_t <= 36
                if (strcmp(REPETITION{1,nref{r}(n)}.EVENTS{i},EVENTS{count_t}) == 1) && (REPETITION{1,nref{r}(n)}.DIM(i) == 7)
                    
                    if isempty(intersect(count_t,DATESind{r})) == 0 && REPETITION{1,nref{r}(n)}.RespValStore(i) == 73
                        DATA_t{r}(n,count_t) = 0;
                    elseif isempty(intersect(count_t,DATESind{r})) == 0 && REPETITION{1,nref{r}(n)}.RespValStore(i) == 80
                        DATA_t{r}(n,count_t) = 1;
                    elseif isempty(intersect(count_t,DATESind{r})) == 1 && REPETITION{1,nref{r}(n)}.RespValStore(i) == 73
                        DATA_t{r}(n,count_t) = 1;
                    elseif isempty(intersect(count_t,DATESind{r})) == 1 && REPETITION{1,nref{r}(n)}.RespValStore(i) == 80
                        DATA_t{r}(n,count_t) = 0;
                    end
                    
                end
                count_t = count_t + 1;
            end
        end
        DATA_s{r}(n,:) = ones(1,36)*NaN;
        for i = 1:48
            count_s = 1;
            while count_s <= 36
                if (strcmp(REPETITION{1,nref{r}(n)}.EVENTS{i},EVENTS{count_s}) == 1) && (REPETITION{1,nref{r}(n)}.DIM(i) == 8)
                    
                    if isempty(intersect(count_s,LONGSind{r})) == 0 && REPETITION{1,nref{r}(n)}.RespValStore(i) == 73
                        DATA_s{r}(n,count_s) = 0;
                    elseif isempty(intersect(count_s,LONGSind{r})) == 0 && REPETITION{1,nref{r}(n)}.RespValStore(i) == 80
                        DATA_s{r}(n,count_s) = 1;
                    elseif isempty(intersect(count_s,LONGSind{r})) == 1 && REPETITION{1,nref{r}(n)}.RespValStore(i) == 73
                        DATA_s{r}(n,count_s) = 1;
                    elseif isempty(intersect(count_s,LONGSind{r})) == 1 && REPETITION{1,nref{r}(n)}.RespValStore(i) == 80
                        DATA_s{r}(n,count_s) = 0;
                    end
                    
                end
                count_s = count_s + 1;
            end
        end
    end
end
DATARef1_s_FULL = DATA_s{1}.*repmat((DEB_LONG_MASK(:)'),length(nref{r}),1);
DATARef2_s_FULL = DATA_s{2}.*repmat((DEB_LONG_MASK(:)'),length(nref{r}),1);
DATARef3_s_FULL = DATA_s{3}.*repmat((DEB_LONG_MASK(:)'),length(nref{r}),1);
DATARef4_s_FULL = DATA_s{4}.*repmat((DEB_LONG_MASK(:)'),length(nref{r}),1);
DATARef5_s_FULL = DATA_s{5}.*repmat((DEB_LONG_MASK(:)'),length(nref{r}),1);
DATARef6_s_FULL = DATA_s{6}.*repmat((DEB_LONG_MASK(:)'),length(nref{r}),1);

DATARef1_t_FULL = DATA_t{1}.*repmat((DEB_MASK_TIME(:)'),length(nref{r}),1);
DATARef2_t_FULL = DATA_t{2}.*repmat((DEB_MASK_TIME(:)'),length(nref{r}),1);
DATARef3_t_FULL = DATA_t{3}.*repmat((DEB_MASK_TIME(:)'),length(nref{r}),1);
DATARef4_t_FULL = DATA_t{4}.*repmat((DEB_MASK_TIME(:)'),length(nref{r}),1);
DATARef5_t_FULL = DATA_t{5}.*repmat((DEB_MASK_TIME(:)'),length(nref{r}),1);
DATARef6_t_FULL = DATA_t{6}.*repmat((DEB_MASK_TIME(:)'),length(nref{r}),1);

DATARef1_s_MEAN = nanmean(DATARef1_s_FULL,1);
DATARef2_s_MEAN = nanmean(DATARef2_s_FULL,1);
DATARef3_s_MEAN = nanmean(DATARef3_s_FULL,1);
DATARef4_s_MEAN = nanmean(DATARef4_s_FULL,1);
DATARef5_s_MEAN = nanmean(DATARef5_s_FULL,1);
DATARef6_s_MEAN = nanmean(DATARef6_s_FULL,1);
DATARef1_s_STD  = nanstd(DATARef1_s_FULL,1);
DATARef2_s_STD  = nanstd(DATARef2_s_FULL,1);
DATARef3_s_STD  = nanstd(DATARef3_s_FULL,1);
DATARef4_s_STD  = nanstd(DATARef4_s_FULL,1);
DATARef5_s_STD  = nanstd(DATARef5_s_FULL,1);
DATARef6_s_STD  = nanstd(DATARef6_s_FULL,1);

DATARef1_t_MEAN = nanmean(DATARef1_t_FULL,1);
DATARef2_t_MEAN = nanmean(DATARef2_t_FULL,1);
DATARef3_t_MEAN = nanmean(DATARef3_t_FULL,1);
DATARef4_t_MEAN = nanmean(DATARef4_t_FULL,1);
DATARef5_t_MEAN = nanmean(DATARef5_t_FULL,1);
DATARef6_t_MEAN = nanmean(DATARef6_t_FULL,1);
DATARef1_t_STD  = nanstd(DATARef1_t_FULL,1);
DATARef2_t_STD  = nanstd(DATARef2_t_FULL,1);
DATARef3_t_STD  = nanstd(DATARef3_t_FULL,1);
DATARef4_t_STD  = nanstd(DATARef4_t_FULL,1);
DATARef5_t_STD  = nanstd(DATARef5_t_FULL,1);
DATARef6_t_STD  = nanstd(DATARef6_t_FULL,1);

DATARef1_t_MEANsq = [(DATARef1_t_MEAN(1:6))' ...
    (DATARef1_t_MEAN(7:12))' ...
    (DATARef1_t_MEAN(13:18))' ...
    (DATARef1_t_MEAN(19:24))' ...
    (DATARef1_t_MEAN(25:30))' ...
    (DATARef1_t_MEAN(31:36))'];
% DATARef1_t_MEANsq(5:6,:) = ones(2,6)*NaN;
DATARef2_t_MEANsq = [(DATARef2_t_MEAN(1:6))' ...
    (DATARef2_t_MEAN(7:12))' ...
    (DATARef2_t_MEAN(13:18))' ...
    (DATARef2_t_MEAN(19:24))' ...
    (DATARef2_t_MEAN(25:30))' ...
    (DATARef2_t_MEAN(31:36))'];
% DATARef2_t_MEANsq([1 6],:) = ones(2,6)*NaN;
DATARef3_t_MEANsq = [(DATARef3_t_MEAN(1:6))' ...
    (DATARef3_t_MEAN(7:12))' ...
    (DATARef3_t_MEAN(13:18))' ...
    (DATARef3_t_MEAN(19:24))' ...
    (DATARef3_t_MEAN(25:30))' ...
    (DATARef3_t_MEAN(31:36))'];
% DATARef3_t_MEANsq([1 2],:) = ones(2,6)*NaN;
DATARef4_t_MEANsq = [(DATARef4_t_MEAN(1:6))' ...
    (DATARef4_t_MEAN(7:12))' ...
    (DATARef4_t_MEAN(13:18))' ...
    (DATARef4_t_MEAN(19:24))' ...
    (DATARef4_t_MEAN(25:30))' ...
    (DATARef4_t_MEAN(31:36))'];
% DATARef4_t_MEANsq(:,5:6) = ones(6,2)*NaN;
DATARef5_t_MEANsq = [(DATARef5_t_MEAN(1:6))' ...
    (DATARef5_t_MEAN(7:12))' ...
    (DATARef5_t_MEAN(13:18))' ...
    (DATARef5_t_MEAN(19:24))' ...
    (DATARef5_t_MEAN(25:30))' ...
    (DATARef5_t_MEAN(31:36))'];
% DATARef5_t_MEANsq(:,[1 6]) = ones(6,2)*NaN;
DATARef6_t_MEANsq = [(DATARef6_t_MEAN(1:6))' ...
    (DATARef6_t_MEAN(7:12))' ...
    (DATARef6_t_MEAN(13:18))' ...
    (DATARef6_t_MEAN(19:24))' ...
    (DATARef6_t_MEAN(25:30))' ...
    (DATARef6_t_MEAN(31:36))'];
% DATARef6_t_MEANsq(:,[1 2]) = ones(6,2)*NaN;
%
DATARef1_t_STDsq = [(DATARef1_t_STD(1:6))' ...
    (DATARef1_t_STD(7:12))' ...
    (DATARef1_t_STD(13:18))' ...
    (DATARef1_t_STD(19:24))' ...
    (DATARef1_t_STD(25:30))' ...
    (DATARef1_t_STD(31:36))'];
% DATARef1_t_MEANsq(5:6,:) = ones(2,6)*NaN;
DATARef2_t_STDsq = [(DATARef2_t_STD(1:6))' ...
    (DATARef2_t_STD(7:12))' ...
    (DATARef2_t_STD(13:18))' ...
    (DATARef2_t_STD(19:24))' ...
    (DATARef2_t_STD(25:30))' ...
    (DATARef2_t_STD(31:36))'];
% DATARef2_t_MEANsq([1 6],:) = ones(2,6)*NaN;
DATARef3_t_STDsq = [(DATARef3_t_STD(1:6))' ...
    (DATARef3_t_STD(7:12))' ...
    (DATARef3_t_STD(13:18))' ...
    (DATARef3_t_STD(19:24))' ...
    (DATARef3_t_STD(25:30))' ...
    (DATARef3_t_STD(31:36))'];
% DATARef3_t_MEANsq([1 2],:) = ones(2,6)*NaN;
DATARef4_t_STDsq = [(DATARef4_t_STD(1:6))' ...
    (DATARef4_t_STD(7:12))' ...
    (DATARef4_t_STD(13:18))' ...
    (DATARef4_t_STD(19:24))' ...
    (DATARef4_t_STD(25:30))' ...
    (DATARef4_t_STD(31:36))'];
% DATARef4_t_MEANsq(:,5:6) = ones(6,2)*NaN;
DATARef5_t_STDsq = [(DATARef5_t_STD(1:6))' ...
    (DATARef5_t_STD(7:12))' ...
    (DATARef5_t_STD(13:18))' ...
    (DATARef5_t_STD(19:24))' ...
    (DATARef5_t_STD(25:30))' ...
    (DATARef5_t_STD(31:36))'];
% DATARef5_t_MEANsq(:,[1 6]) = ones(6,2)*NaN;
DATARef6_t_STDsq = [(DATARef6_t_STD(1:6))' ...
    (DATARef6_t_STD(7:12))' ...
    (DATARef6_t_STD(13:18))' ...
    (DATARef6_t_STD(19:24))' ...
    (DATARef6_t_STD(25:30))' ...
    (DATARef6_t_STD(31:36))'];
% DATARef6_t_MEANsq(:,[1 2]) = ones(6,2)*NaN;
%
DATA_t_Ref = {DATARef1_t_FULL,DATARef2_t_FULL,DATARef3_t_FULL,DATARef4_t_FULL,DATARef5_t_FULL,DATARef6_t_FULL};
%
DATARef1_s_MEANsq = [(DATARef1_s_MEAN(1:6))' ...
    (DATARef1_s_MEAN(7:12))' ...
    (DATARef1_s_MEAN(13:18))' ...
    (DATARef1_s_MEAN(19:24))' ...
    (DATARef1_s_MEAN(25:30))' ...
    (DATARef1_s_MEAN(31:36))'];
% DATARef1_s_MEANsq(5:6,:) = ones(2,6)*NaN;
DATARef2_s_MEANsq = [(DATARef2_s_MEAN(1:6))' ...
    (DATARef2_s_MEAN(7:12))' ...
    (DATARef2_s_MEAN(13:18))' ...
    (DATARef2_s_MEAN(19:24))' ...
    (DATARef2_s_MEAN(25:30))' ...
    (DATARef2_s_MEAN(31:36))'];
% DATARef2_s_MEANsq([1 6],:) = ones(2,6)*NaN;
DATARef3_s_MEANsq = [(DATARef3_s_MEAN(1:6))' ...
    (DATARef3_s_MEAN(7:12))' ...
    (DATARef3_s_MEAN(13:18))' ...
    (DATARef3_s_MEAN(19:24))' ...
    (DATARef3_s_MEAN(25:30))' ...
    (DATARef3_s_MEAN(31:36))'];
% DATARef3_s_MEANsq([1 2],:) = ones(2,6)*NaN;
DATARef4_s_MEANsq = [(DATARef4_s_MEAN(1:6))' ...
    (DATARef4_s_MEAN(7:12))' ...
    (DATARef4_s_MEAN(13:18))' ...
    (DATARef4_s_MEAN(19:24))' ...
    (DATARef4_s_MEAN(25:30))' ...
    (DATARef4_s_MEAN(31:36))'];
% DATARef4_s_MEANsq(:,5:6) = ones(6,2)*NaN;
DATARef5_s_MEANsq = [(DATARef5_s_MEAN(1:6))' ...
    (DATARef5_s_MEAN(7:12))' ...
    (DATARef5_s_MEAN(13:18))' ...
    (DATARef5_s_MEAN(19:24))' ...
    (DATARef5_s_MEAN(25:30))' ...
    (DATARef5_s_MEAN(31:36))'];
% DATARef5_s_MEANsq(:,[1 6]) = ones(6,2)*NaN;
DATARef6_s_MEANsq = [(DATARef6_s_MEAN(1:6))' ...
    (DATARef6_s_MEAN(7:12))' ...
    (DATARef6_s_MEAN(13:18))' ...
    (DATARef6_s_MEAN(19:24))' ...
    (DATARef6_s_MEAN(25:30))' ...
    (DATARef6_s_MEAN(31:36))'];
% DATARef6_s_MEANsq(:,[1 2]) = ones(6,2)*NaN;
%
DATARef1_s_STDsq = [(DATARef1_s_STD(1:6))' ...
    (DATARef1_s_STD(7:12))' ...
    (DATARef1_s_STD(13:18))' ...
    (DATARef1_s_STD(19:24))' ...
    (DATARef1_s_STD(25:30))' ...
    (DATARef1_s_STD(31:36))'];
% DATARef1_s_MEANsq(5:6,:) = ones(2,6)*NaN;
DATARef2_s_STDsq = [(DATARef2_s_STD(1:6))' ...
    (DATARef2_s_STD(7:12))' ...
    (DATARef2_s_STD(13:18))' ...
    (DATARef2_s_STD(19:24))' ...
    (DATARef2_s_STD(25:30))' ...
    (DATARef2_s_STD(31:36))'];
% DATARef2_s_MEANsq([1 6],:) = ones(2,6)*NaN;
DATARef3_s_STDsq = [(DATARef3_s_STD(1:6))' ...
    (DATARef3_s_STD(7:12))' ...
    (DATARef3_s_STD(13:18))' ...
    (DATARef3_s_STD(19:24))' ...
    (DATARef3_s_STD(25:30))' ...
    (DATARef3_s_STD(31:36))'];
% DATARef3_s_MEANsq([1 2],:) = ones(2,6)*NaN;
DATARef4_s_STDsq = [(DATARef4_s_STD(1:6))' ...
    (DATARef4_s_STD(7:12))' ...
    (DATARef4_s_STD(13:18))' ...
    (DATARef4_s_STD(19:24))' ...
    (DATARef4_s_STD(25:30))' ...
    (DATARef4_s_STD(31:36))'];
% DATARef4_s_MEANsq(:,5:6) = ones(6,2)*NaN;
DATARef5_s_STDsq = [(DATARef5_s_STD(1:6))' ...
    (DATARef5_s_STD(7:12))' ...
    (DATARef5_s_STD(13:18))' ...
    (DATARef5_s_STD(19:24))' ...
    (DATARef5_s_STD(25:30))' ...
    (DATARef5_s_STD(31:36))'];
% DATARef5_s_MEANsq(:,[1 6]) = ones(6,2)*NaN;
DATARef6_s_STDsq = [(DATARef6_s_STD(1:6))' ...
    (DATARef6_s_STD(7:12))' ...
    (DATARef6_s_STD(13:18))' ...
    (DATARef6_s_STD(19:24))' ...
    (DATARef6_s_STD(25:30))' ...
    (DATARef6_s_STD(31:36))'];
% DATARef6_s_MEANsq(:,[1 2]) = ones(6,2)*NaN;
%
DATA_s_Ref = {DATARef1_s_FULL,DATARef2_s_FULL,DATARef3_s_FULL,DATARef4_s_FULL,DATARef5_s_FULL,DATARef6_s_FULL};


fig1 = figure('position',[1 1 800 500]);
set(fig1,'PaperPosition',[1 1 800 500])
set(fig1,'PaperPositionmode','auto')
subplot(2,3,1); imagesc(DATARef1_s_MEANsq,[0 1]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');title('SJ PasPar');
subplot(2,3,2); imagesc(DATARef2_s_MEANsq,[0 1]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');title('SJ PrePar');
subplot(2,3,3); imagesc(DATARef3_s_MEANsq,[0 1]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');title('SJ FutPar');
subplot(2,3,4); imagesc(DATARef5_s_MEANsq,[0 1]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');title('SJ PreW');
subplot(2,3,5); imagesc(DATARef6_s_MEANsq,[0 1]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');title('SJ PrePar');
subplot(2,3,6); imagesc(DATARef4_s_MEANsq,[0 1]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');title('SJ PreE');

print('-dpng',['C:\MTT_MEG\results\FULL_ER_MT_MEG_PSYCHO_SPACE_3rd' NIP])

fig1 = figure('position',[1 1 800 500]);
set(fig1,'PaperPosition',[1 1 800 500])
set(fig1,'PaperPositionmode','auto')

subplot(2,3,1); imagesc(DATARef1_t_MEANsq,[0 1]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');title('TJ PasPar');
subplot(2,3,2); imagesc(DATARef2_t_MEANsq,[0 1]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');title('TJ PrePar');
subplot(2,3,3); imagesc(DATARef3_t_MEANsq,[0 1]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');title('TJ FutPar');
subplot(2,3,4); imagesc(DATARef5_t_MEANsq,[0 1]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');title('TJ PreW');
subplot(2,3,5); imagesc(DATARef6_t_MEANsq,[0 1]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');title('TJ PrePar');
subplot(2,3,6); imagesc(DATARef4_t_MEANsq,[0 1]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');title('TJ PreE');

print('-dpng',['C:\MTT_MEG\results\FULL_ER_MT_MEG_PSYCHO_TIME_3rd' NIP])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 800 500]);
set(fig1,'PaperPosition',[1 1 800 500])
set(fig1,'PaperPositionmode','auto')

subplot(2,3,1)
bar(1:6,nanmean(DATARef1_t_MEANsq'),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(DATARef1_t_MEANsq'),nanstd(DATARef1_t_MEANsq')./sqrt(6),'linestyle','none','color','k');title('TJ PasPar');
subplot(2,3,2)
bar(1:6,nanmean(DATARef2_t_MEANsq'),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(DATARef2_t_MEANsq'),nanstd(DATARef2_t_MEANsq')./sqrt(6),'linestyle','none','color','k');title('TJ PrePar');
subplot(2,3,3)
bar(1:6,nanmean(DATARef3_t_MEANsq'),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(DATARef3_t_MEANsq'),nanstd(DATARef3_t_MEANsq')./sqrt(6),'linestyle','none','color','k');title('TJ FutPar');
subplot(2,3,4)
bar(1:6,nanmean(DATARef5_t_MEANsq'),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(DATARef5_t_MEANsq'),nanstd(DATARef5_t_MEANsq')./sqrt(6),'linestyle','none','color','k');title('TJ PreW');
subplot(2,3,5)
bar(1:6,nanmean(DATARef6_t_MEANsq'),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(DATARef6_t_MEANsq'),nanstd(DATARef6_t_MEANsq')./sqrt(6),'linestyle','none','color','k');title('TJ PrePar');
subplot(2,3,6)
bar(1:6,nanmean(DATARef4_t_MEANsq'),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(DATARef4_t_MEANsq'),nanstd(DATARef4_t_MEANsq')./sqrt(6),'linestyle','none','color','k');title('TJ PreE');

print('-dpng',['C:\MTT_MEG\results\MEAN_ER_MT_MEG_PSYCHO_TIME_3rd' NIP])

fig1 = figure('position',[1 1 800 500]);
set(fig1,'PaperPosition',[1 1 800 500])
set(fig1,'PaperPositionmode','auto')

subplot(2,3,1)
bar(1:6,nanmean(DATARef1_s_MEANsq),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(DATARef1_s_MEANsq),nanstd(DATARef1_s_MEANsq)./sqrt(6),'linestyle','none','color','k');title('SJ PasPar');
subplot(2,3,2)
bar(1:6,nanmean(DATARef2_s_MEANsq),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(DATARef2_s_MEANsq),nanstd(DATARef2_s_MEANsq)./sqrt(6),'linestyle','none','color','k');title('SJ PrePar');
subplot(2,3,3)
bar(1:6,nanmean(DATARef3_s_MEANsq),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(DATARef3_s_MEANsq),nanstd(DATARef3_s_MEANsq)./sqrt(6),'linestyle','none','color','k');title('SJ FutPar');
subplot(2,3,4)
bar(1:6,nanmean(DATARef5_s_MEANsq),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(DATARef5_s_MEANsq),nanstd(DATARef5_s_MEANsq)./sqrt(6),'linestyle','none','color','k');title('SJ PreW');
subplot(2,3,5)
bar(1:6,nanmean(DATARef6_s_MEANsq),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(DATARef6_s_MEANsq),nanstd(DATARef6_s_MEANsq)./sqrt(6),'linestyle','none','color','k');title('SJ PrePar');
subplot(2,3,6)
bar(1:6,nanmean(DATARef4_s_MEANsq),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(DATARef4_s_MEANsq),nanstd(DATARef4_s_MEANsq)./sqrt(6),'linestyle','none','color','k');title('SJ PreE');

print('-dpng',['C:\MTT_MEG\results\MEAN_ER_MT_MEG_PSYCHO_SPACE_3rd' NIP])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 800 800]);
set(fig1,'PaperPosition',[1 1 800 800])
set(fig1,'PaperPositionmode','auto')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PAST %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (DATE(:)-ones(36,1)*(2004));
AbsXaxis = abs((DATE(:)-ones(36,1)*(2004))); Yaxis = DATARef1_t_MEANsq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis DATARef1_t_STDsq(:)]);
tmpB = tmp(1:12,:) ;tmpstdB = tmpstd(1:12,:);
tmpA = tmp(13:36,:);tmpstdA = tmpstd(13:36,:);
indB = find(sum((isnan(tmpB) == 0),2) == 2);
indA = find(sum((isnan(tmpA) == 0),2) == 2);
tmpB = tmpB(indB,:);tmpstdB = tmpstd(indB,:);
tmpA = tmpA(indA,:);tmpstdA = tmpstd(indA,:);
NormTmp = sortrows(abs([tmpB ; tmpA]));
NormTmpStd = sortrows(abs([tmpstdB ; tmpstdA]));

[B1,BINT1,R1,RINT1,STATS1] = REGRESS(tmpB(:,2),[ones(size(tmpB,1),1) tmpB(:,1)]);
[B2,BINT2,R2,RINT2,STATS2] = REGRESS(tmpA(:,2),[ones(size(tmpA,1),1) tmpA(:,1)]);
[B3,BINT3,R3,RINT3,STATS3] = REGRESS(NormTmp(:,2),[ones(size(NormTmp,1),1) NormTmp(:,1)]);
[B4,BINT4,R4,RINT4,STATS4] = REGRESS(log(NormTmp(:,2)),[ones(size(NormTmp,1),1) NormTmp(:,1)]);

STATS = [STATS1;STATS2;STATS3];
P1 = polyfit(tmpB(:,1),tmpB(:,2),1);            Y1 = polyval(P1,-30:0.1:-0.1);
P2 = polyfit(tmpA(:,1),tmpA(:,2),1);            Y2 = polyval(P2,0.1:0.1:30);
P3 = polyfit(NormTmp(:,1),NormTmp(:,2),1);      Y3 = polyval(P3,0.1:0.1:30);
P4 = polyfit(log(NormTmp(:,1)),NormTmp(:,2),1); Y4 = polyval(P4,log(0.1:0.1:30));

subplot(3,3,[1 2])
errorbar(Xaxis', DATARef1_t_MEANsq(:)', DATARef1_t_STDsq(:)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
line([0 0],[0 1],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-30:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:30,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-25,1.8,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-30 30 0 1]); ylabel('Reaction time (s)');xlabel('Temporal distance(y)');title('TJ PasPar');

subplot(3,3,3)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:30,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:30,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(5,1.5,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 30 0 1]); ylabel('Reaction time (s)');xlabel('|Temporal distance| (y)');title('TJ PasPar');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PRESENT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (DATE(:)-ones(36,1)*(2013));
AbsXaxis = abs((DATE(:)-ones(36,1)*(2013))); Yaxis = DATARef2_t_MEANsq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis DATARef2_t_STDsq(:)]);
tmpB = tmp(1:18,:) ;tmpstdB = tmpstd(1:18,:);
tmpA = tmp(19:36,:);tmpstdA = tmpstd(19:36,:);
indB = find(sum((isnan(tmpB) == 0),2) == 2);
indA = find(sum((isnan(tmpA) == 0),2) == 2);
tmpB = tmpB(indB,:);tmpstdB = tmpstd(indB,:);
tmpA = tmpA(indA,:);tmpstdA = tmpstd(indA,:);
NormTmp = sortrows(abs([tmpB ; tmpA]));
NormTmpStd = sortrows(abs([tmpstdB ; tmpstdA]));

[B1,BINT1,R1,RINT1,STATS1] = REGRESS(tmpB(:,2),[ones(size(tmpB,1),1) tmpB(:,1)]);
[B2,BINT2,R2,RINT2,STATS2] = REGRESS(tmpA(:,2),[ones(size(tmpA,1),1) tmpA(:,1)]);
[B3,BINT3,R3,RINT3,STATS3] = REGRESS(NormTmp(:,2),[ones(size(NormTmp,1),1) NormTmp(:,1)]);
[B4,BINT4,R4,RINT4,STATS4] = REGRESS(log(NormTmp(:,2)),[ones(size(NormTmp,1),1) NormTmp(:,1)]);

STATS = [STATS1;STATS2;STATS3];
P1 = polyfit(tmpB(:,1),tmpB(:,2),1);            Y1 = polyval(P1,-30:0.1:-0.1);
P2 = polyfit(tmpA(:,1),tmpA(:,2),1);            Y2 = polyval(P2,0.1:0.1:30);
P3 = polyfit(NormTmp(:,1),NormTmp(:,2),1);      Y3 = polyval(P3,0.1:0.1:30);
P4 = polyfit(log(NormTmp(:,1)),NormTmp(:,2),1); Y4 = polyval(P4,log(0.1:0.1:30));

subplot(3,3,[4 5])
errorbar(Xaxis', DATARef2_t_MEANsq(:)', DATARef2_t_STDsq(:)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
line([0 0],[0 1],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-30:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:30,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-25,1.8,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-30 30 0 1]); ylabel('Reaction time (s)');xlabel('Temporal distance(y)');title('TJ PrePar');

subplot(3,3,6)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:30,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:30,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(5,1.5,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 30 0 1]); ylabel('Reaction time (s)');xlabel('|Temporal distance| (y)');title('TJ PrePar');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FUTURE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (DATE(:)-ones(36,1)*(2022));
AbsXaxis = abs((DATE(:)-ones(36,1)*(2022))); Yaxis = DATARef3_t_MEANsq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis DATARef3_t_STDsq(:)]);
tmpB = tmp(1:24,:) ;tmpstdB = tmpstd(1:24,:);
tmpA = tmp(25:36,:);tmpstdA = tmpstd(25:36,:);
indB = find(sum((isnan(tmpB) == 0),2) == 2);
indA = find(sum((isnan(tmpA) == 0),2) == 2);
tmpB = tmpB(indB,:);tmpstdB = tmpstd(indB,:);
tmpA = tmpA(indA,:);tmpstdA = tmpstd(indA,:);
NormTmp = sortrows(abs([tmpB ; tmpA]));
NormTmpStd = sortrows(abs([tmpstdB ; tmpstdA]));

[B1,BINT1,R1,RINT1,STATS1] = REGRESS(tmpB(:,2),[ones(size(tmpB,1),1) tmpB(:,1)]);
[B2,BINT2,R2,RINT2,STATS2] = REGRESS(tmpA(:,2),[ones(size(tmpA,1),1) tmpA(:,1)]);
[B3,BINT3,R3,RINT3,STATS3] = REGRESS(NormTmp(:,2),[ones(size(NormTmp,1),1) NormTmp(:,1)]);
[B4,BINT4,R4,RINT4,STATS4] = REGRESS(log(NormTmp(:,2)),[ones(size(NormTmp,1),1) NormTmp(:,1)]);

STATS = [STATS1;STATS2;STATS3];
P1 = polyfit(tmpB(:,1),tmpB(:,2),1);            Y1 = polyval(P1,-30:0.1:-0.1);
P2 = polyfit(tmpA(:,1),tmpA(:,2),1);            Y2 = polyval(P2,0.1:0.1:30);
P3 = polyfit(NormTmp(:,1),NormTmp(:,2),1);      Y3 = polyval(P3,0.1:0.1:30);
P4 = polyfit(log(NormTmp(:,1)),NormTmp(:,2),1); Y4 = polyval(P4,log(0.1:0.1:30));

subplot(3,3,[7 8])
errorbar(Xaxis', DATARef3_t_MEANsq(:)', DATARef3_t_STDsq(:)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
line([0 0],[0 1],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-30:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:30,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-25,1.8,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(1,1.8,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-30 30 0 1]); ylabel('Reaction time (s)');xlabel('Temporal distance(y)');title('TJ FutPar');

subplot(3,3,9)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:30,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:30,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(1,1.5,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(1,1.8,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 30 0 1]); ylabel('Reaction time (s)');xlabel('|Temporal distance| (y)');title('TJ FutPar');

print('-dpng',['C:\MTT_MEG\results\REGRESS_TIME_ER_MT_MEG_PSYCHO_TIME_3rd' NIP])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 800 800]);
set(fig1,'PaperPosition',[1 1 800 800])
set(fig1,'PaperPositionmode','auto')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% WEST %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (DATE(:)-ones(36,1)*(2013));
AbsXaxis = abs((DATE(:)-ones(36,1)*(2013))); Yaxis = DATARef5_t_MEANsq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis DATARef5_t_STDsq(:)]);
tmpB = tmp(1:18,:) ;tmpstdB = tmpstd(1:18,:);
tmpA = tmp(19:36,:);tmpstdA = tmpstd(19:36,:);
indB = find(sum((isnan(tmpB) == 0),2) == 2);
indA = find(sum((isnan(tmpA) == 0),2) == 2);
tmpB = tmpB(indB,:);tmpstdB = tmpstd(indB,:);
tmpA = tmpA(indA,:);tmpstdA = tmpstd(indA,:);
NormTmp = sortrows(abs([tmpB ; tmpA]));
NormTmpStd = sortrows(abs([tmpstdB ; tmpstdA]));

[B1,BINT1,R1,RINT1,STATS1] = REGRESS(tmpB(:,2),[ones(size(tmpB,1),1) tmpB(:,1)]);
[B2,BINT2,R2,RINT2,STATS2] = REGRESS(tmpA(:,2),[ones(size(tmpA,1),1) tmpA(:,1)]);
[B3,BINT3,R3,RINT3,STATS3] = REGRESS(NormTmp(:,2),[ones(size(NormTmp,1),1) NormTmp(:,1)]);
[B4,BINT4,R4,RINT4,STATS4] = REGRESS(log(NormTmp(:,2)),[ones(size(NormTmp,1),1) NormTmp(:,1)]);

STATS = [STATS1;STATS2;STATS3];
P1 = polyfit(tmpB(:,1),tmpB(:,2),1);            Y1 = polyval(P1,-30:0.1:-0.1);
P2 = polyfit(tmpA(:,1),tmpA(:,2),1);            Y2 = polyval(P2,0.1:0.1:30);
P3 = polyfit(NormTmp(:,1),NormTmp(:,2),1);      Y3 = polyval(P3,0.1:0.1:30);
P4 = polyfit(log(NormTmp(:,1)),NormTmp(:,2),1); Y4 = polyval(P4,log(0.1:0.1:30));

subplot(3,3,[1 2])
errorbar(Xaxis', DATARef5_t_MEANsq(:)', DATARef5_t_STDsq(:)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
line([0 0],[0 1],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-30:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:30,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-25,1.8,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-30 30 0 1]); ylabel('Reaction time (s)');xlabel('Temporal distance(y)');title('TJ PreW');

subplot(3,3,3)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:30,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:30,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(5,1.5,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 30 0 1]); ylabel('Reaction time (s)');xlabel('|Temporal distance| (y)');title('TJ PreW');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PARIS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (DATE(:)-ones(36,1)*(2013));
AbsXaxis = abs((DATE(:)-ones(36,1)*(2013))); Yaxis = DATARef6_t_MEANsq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis DATARef6_t_STDsq(:)]);
tmpB = tmp(1:18,:) ;tmpstdB = tmpstd(1:18,:);
tmpA = tmp(19:36,:);tmpstdA = tmpstd(19:36,:);
indB = find(sum((isnan(tmpB) == 0),2) == 2);
indA = find(sum((isnan(tmpA) == 0),2) == 2);
tmpB = tmpB(indB,:);tmpstdB = tmpstd(indB,:);
tmpA = tmpA(indA,:);tmpstdA = tmpstd(indA,:);
NormTmp = sortrows(abs([tmpB ; tmpA]));
NormTmpStd = sortrows(abs([tmpstdB ; tmpstdA]));

[B1,BINT1,R1,RINT1,STATS1] = REGRESS(tmpB(:,2),[ones(size(tmpB,1),1) tmpB(:,1)]);
[B2,BINT2,R2,RINT2,STATS2] = REGRESS(tmpA(:,2),[ones(size(tmpA,1),1) tmpA(:,1)]);
[B3,BINT3,R3,RINT3,STATS3] = REGRESS(NormTmp(:,2),[ones(size(NormTmp,1),1) NormTmp(:,1)]);
[B4,BINT4,R4,RINT4,STATS4] = REGRESS(log(NormTmp(:,2)),[ones(size(NormTmp,1),1) NormTmp(:,1)]);

STATS = [STATS1;STATS2;STATS3];
P1 = polyfit(tmpB(:,1),tmpB(:,2),1);            Y1 = polyval(P1,-30:0.1:-0.1);
P2 = polyfit(tmpA(:,1),tmpA(:,2),1);            Y2 = polyval(P2,0.1:0.1:30);
P3 = polyfit(NormTmp(:,1),NormTmp(:,2),1);      Y3 = polyval(P3,0.1:0.1:30);
P4 = polyfit(log(NormTmp(:,1)),NormTmp(:,2),1); Y4 = polyval(P4,log(0.1:0.1:30));

subplot(3,3,[4 5])
errorbar(Xaxis', DATARef6_t_MEANsq(:)', DATARef6_t_STDsq(:)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
line([0 0],[0 1],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-30:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:30,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-15,1.8,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-30 30 0 1]); ylabel('Reaction time (s)');xlabel('Temporal distance(y)');title('TJ PrePar');

subplot(3,3,6)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:30,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:30,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(5,1.5,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 30 0 1]); ylabel('Reaction time (s)');xlabel('|Temporal distance| (y)');title('TJ PrePar');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% East %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (DATE(:)-ones(36,1)*(2013));
AbsXaxis = abs((DATE(:)-ones(36,1)*(2013))); Yaxis = DATARef4_t_MEANsq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis DATARef4_t_STDsq(:)]);
tmpB = tmp(1:18,:) ;tmpstdB = tmpstd(1:18,:);
tmpA = tmp(19:36,:);tmpstdA = tmpstd(19:36,:);
indB = find(sum((isnan(tmpB) == 0),2) == 2);
indA = find(sum((isnan(tmpA) == 0),2) == 2);
tmpB = tmpB(indB,:);tmpstdB = tmpstd(indB,:);
tmpA = tmpA(indA,:);tmpstdA = tmpstd(indA,:);
NormTmp = sortrows(abs([tmpB ; tmpA]));
NormTmpStd = sortrows(abs([tmpstdB ; tmpstdA]));

[B1,BINT1,R1,RINT1,STATS1] = REGRESS(tmpB(:,2),[ones(size(tmpB,1),1) tmpB(:,1)]);
[B2,BINT2,R2,RINT2,STATS2] = REGRESS(tmpA(:,2),[ones(size(tmpA,1),1) tmpA(:,1)]);
[B3,BINT3,R3,RINT3,STATS3] = REGRESS(NormTmp(:,2),[ones(size(NormTmp,1),1) NormTmp(:,1)]);
[B4,BINT4,R4,RINT4,STATS4] = REGRESS(log(NormTmp(:,2)),[ones(size(NormTmp,1),1) NormTmp(:,1)]);

STATS = [STATS1;STATS2;STATS3];
P1 = polyfit(tmpB(:,1),tmpB(:,2),1);            Y1 = polyval(P1,-30:0.1:-0.1);
P2 = polyfit(tmpA(:,1),tmpA(:,2),1);            Y2 = polyval(P2,0.1:0.1:30);
P3 = polyfit(NormTmp(:,1),NormTmp(:,2),1);      Y3 = polyval(P3,0.1:0.1:30);
P4 = polyfit(log(NormTmp(:,1)),NormTmp(:,2),1); Y4 = polyval(P4,log(0.1:0.1:30));

subplot(3,3,[7 8])
errorbar(Xaxis', DATARef4_t_MEANsq(:)', DATARef4_t_STDsq(:)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
line([0 0],[0 1],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-30:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:30,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-25,1.8,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-30 30 0 1]); ylabel('Reaction time (s)');xlabel('Temporal distance(y)');title('TJ PreE');

subplot(3,3,9)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:30,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:30,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(5,1.5,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 30 0 1]); ylabel('Reaction time (s)');xlabel('|Temporal distance| (y)');title('TJ PreE');

print('-dpng',['C:\MTT_MEG\results\REGRESS_SPACE_ER_MT_MEG_PSYCHO_TIME_3rd_bis' NIP])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 800 800]);
set(fig1,'PaperPosition',[1 1 800 800])
set(fig1,'PaperPositionmode','auto')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% WEST %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (LONG(:)-ones(36,1)*(-52.3));
AbsXaxis = abs((LONG(:)-ones(36,1)*(-52.3))); Yaxis = DATARef1_s_MEANsq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis DATARef1_s_STDsq(:)]);
tmpB = tmp(1:12,:) ;tmpstdB = tmpstd(1:12,:);
tmpA = tmp(13:36,:);tmpstdA = tmpstd(13:36,:);
indB = find(sum((isnan(tmpB) == 0),2) == 2);
indA = find(sum((isnan(tmpA) == 0),2) == 2);
tmpB = tmpB(indB,:);tmpstdB = tmpstd(indB,:);
tmpA = tmpA(indA,:);tmpstdA = tmpstd(indA,:);
NormTmp = sortrows(abs([tmpB ; tmpA]));
NormTmpStd = sortrows(abs([tmpstdB ; tmpstdA]));

[B1,BINT1,R1,RINT1,STATS1] = REGRESS(tmpB(:,2),[ones(size(tmpB,1),1) tmpB(:,1)]);
[B2,BINT2,R2,RINT2,STATS2] = REGRESS(tmpA(:,2),[ones(size(tmpA,1),1) tmpA(:,1)]);
[B3,BINT3,R3,RINT3,STATS3] = REGRESS(NormTmp(:,2),[ones(size(NormTmp,1),1) NormTmp(:,1)]);
[B4,BINT4,R4,RINT4,STATS4] = REGRESS(log(NormTmp(:,2)),[ones(size(NormTmp,1),1) NormTmp(:,1)]);

P1 = polyfit(tmpB(:,1),tmpB(:,2),1);            Y1 = polyval(P1,-160:0.1:-0.1);
P2 = polyfit(tmpA(:,1),tmpA(:,2),1);            Y2 = polyval(P2,0.1:0.1:160);
P3 = polyfit(NormTmp(:,1),NormTmp(:,2),1);      Y3 = polyval(P3,0.1:0.1:160);
P4 = polyfit(log(NormTmp(:,1)),NormTmp(:,2),1); Y4 = polyval(P4,log(0.1:0.1:160));

subplot(3,3,[1 2])
errorbar(Xaxis', DATARef1_s_MEANsq(:)', DATARef1_s_STDsq(:)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
line([0 0],[0 1],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-160:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:160,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-155,1.8,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-160 160 0 1]); ylabel('Reaction time (s)');xlabel('Spatial distance (°)');title('SJ PasPar');

subplot(3,3,3)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:160,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:160,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(5,1.5,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 160 0 1]); ylabel('Reaction time (s)');xlabel('|Spatial distance| (°)');title('SJ PasPar');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PARIS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (LONG(:)-ones(36,1)*(2.3));
AbsXaxis = abs((LONG(:)-ones(36,1)*(2.3))); Yaxis = DATARef2_s_MEANsq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis DATARef2_s_STDsq(:)]);
tmpB = tmp(1:18,:) ;tmpstdB = tmpstd(1:18,:);
tmpA = tmp(19:36,:);tmpstdA = tmpstd(19:36,:);
indB = find(sum((isnan(tmpB) == 0),2) == 2);
indA = find(sum((isnan(tmpA) == 0),2) == 2);
tmpB = tmpB(indB,:);tmpstdB = tmpstd(indB,:);
tmpA = tmpA(indA,:);tmpstdA = tmpstd(indA,:);
NormTmp = sortrows(abs([tmpB ; tmpA]));
NormTmpStd = sortrows(abs([tmpstdB ; tmpstdA]));

[B1,BINT1,R1,RINT1,STATS1] = REGRESS(tmpB(:,2),[ones(size(tmpB,1),1) tmpB(:,1)]);
[B2,BINT2,R2,RINT2,STATS2] = REGRESS(tmpA(:,2),[ones(size(tmpA,1),1) tmpA(:,1)]);
[B3,BINT3,R3,RINT3,STATS3] = REGRESS(NormTmp(:,2),[ones(size(NormTmp,1),1) NormTmp(:,1)]);
[B4,BINT4,R4,RINT4,STATS4] = REGRESS(log(NormTmp(:,2)),[ones(size(NormTmp,1),1) NormTmp(:,1)]);

P1 = polyfit(tmpB(:,1),tmpB(:,2),1);            Y1 = polyval(P1,-160:0.1:-0.1);
P2 = polyfit(tmpA(:,1),tmpA(:,2),1);            Y2 = polyval(P2,0.1:0.1:160);
P3 = polyfit(NormTmp(:,1),NormTmp(:,2),1);      Y3 = polyval(P3,0.1:0.1:160);
P4 = polyfit(log(NormTmp(:,1)),NormTmp(:,2),1); Y4 = polyval(P4,log(0.1:0.1:160));

subplot(3,3,[4 5])
errorbar(Xaxis', DATARef2_s_MEANsq(:)', DATARef2_s_STDsq(:)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
line([0 0],[0 1],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-160:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:160,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-155,1.8,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-160 160 0 1]); ylabel('Reaction time (s)');xlabel('Spatial distance (°)');title('SJ PrePar');

subplot(3,3,6)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(length(6)),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:160,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:160,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(5,1.5,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 160 0 1]); ylabel('Reaction time (s)');xlabel('|Spatial distance| (°)');title('SJ PrePar');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FUTURE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (LONG(:)-ones(36,1)*(55.3));
AbsXaxis = abs((LONG(:)-ones(36,1)*(55.3))); Yaxis = DATARef3_s_MEANsq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis DATARef3_s_STDsq(:)]);
tmpB = tmp(1:24,:) ;tmpstdB = tmpstd(1:24,:);
tmpA = tmp(25:36,:);tmpstdA = tmpstd(25:36,:);
indB = find(sum((isnan(tmpB) == 0),2) == 2);
indA = find(sum((isnan(tmpA) == 0),2) == 2);
tmpB = tmpB(indB,:);tmpstdB = tmpstd(indB,:);
tmpA = tmpA(indA,:);tmpstdA = tmpstd(indA,:);
NormTmp = sortrows(abs([tmpB ; tmpA]));
NormTmpStd = sortrows(abs([tmpstdB ; tmpstdA]));

[B1,BINT1,R1,RINT1,STATS1] = REGRESS(tmpB(:,2),[ones(size(tmpB,1),1) tmpB(:,1)]);
[B2,BINT2,R2,RINT2,STATS2] = REGRESS(tmpA(:,2),[ones(size(tmpA,1),1) tmpA(:,1)]);
[B3,BINT3,R3,RINT3,STATS3] = REGRESS(NormTmp(:,2),[ones(size(NormTmp,1),1) NormTmp(:,1)]);
[B4,BINT4,R4,RINT4,STATS4] = REGRESS(log(NormTmp(:,2)),[ones(size(NormTmp,1),1) NormTmp(:,1)]);

STATS = [STATS1;STATS2;STATS3];
P1 = polyfit(tmpB(:,1),tmpB(:,2),1);            Y1 = polyval(P1,-160:0.1:-0.1);
P2 = polyfit(tmpA(:,1),tmpA(:,2),1);            Y2 = polyval(P2,0.1:0.1:160);
P3 = polyfit(NormTmp(:,1),NormTmp(:,2),1);      Y3 = polyval(P3,0.1:0.1:160);
P4 = polyfit(log(NormTmp(:,1)),NormTmp(:,2),1); Y4 = polyval(P4,log(0.1:0.1:160));

subplot(3,3,[7 8])
errorbar(Xaxis', DATARef3_s_MEANsq(:)', DATARef3_s_STDsq(:)'./sqrt(length(6)),'linestyle','none','marker','.','markersize',20); hold on;
line([0 0],[0 1],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-160:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:160,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-155,1.8,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(1,1.8,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-160 160 0 1]); ylabel('Reaction time (s)');xlabel('Spatial distance (°)');title('SJ FutPar');

subplot(3,3,9)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(length(6)),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:160,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:160,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(1,1.5,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(1,1.8,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 160 0 1]); ylabel('Reaction time (s)');xlabel('|Spatial distance| (°)');title('SJ FutPar');

print('-dpng',['C:\MTT_MEG\results\REGRESS_SPACE_ER_MT_MEG_PSYCHO_SPACE_3rd' NIP])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 800 800]);
set(fig1,'PaperPosition',[1 1 800 800])
set(fig1,'PaperPositionmode','auto')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% WEST %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (LONG(:)-ones(36,1)*(-52.3));
AbsXaxis = abs((LONG(:)-ones(36,1)*(-52.3))); Yaxis = DATARef5_s_MEANsq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis DATARef5_s_STDsq(:)]);
tmpB = tmp(1:18,:) ;tmpstdB = tmpstd(1:18,:);
tmpA = tmp(19:36,:);tmpstdA = tmpstd(19:36,:);
indB = find(sum((isnan(tmpB) == 0),2) == 2);
indA = find(sum((isnan(tmpA) == 0),2) == 2);
tmpB = tmpB(indB,:);tmpstdB = tmpstd(indB,:);
tmpA = tmpA(indA,:);tmpstdA = tmpstd(indA,:);
NormTmp = sortrows(abs([tmpB ; tmpA]));
NormTmpStd = sortrows(abs([tmpstdB ; tmpstdA]));

[B1,BINT1,R1,RINT1,STATS1] = REGRESS(tmpB(:,2),[ones(size(tmpB,1),1) tmpB(:,1)]);
[B2,BINT2,R2,RINT2,STATS2] = REGRESS(tmpA(:,2),[ones(size(tmpA,1),1) tmpA(:,1)]);
[B3,BINT3,R3,RINT3,STATS3] = REGRESS(NormTmp(:,2),[ones(size(NormTmp,1),1) NormTmp(:,1)]);
[B4,BINT4,R4,RINT4,STATS4] = REGRESS(log(NormTmp(:,2)),[ones(size(NormTmp,1),1) NormTmp(:,1)]);

P1 = polyfit(tmpB(:,1),tmpB(:,2),1);            Y1 = polyval(P1,-160:0.1:-0.1);
P2 = polyfit(tmpA(:,1),tmpA(:,2),1);            Y2 = polyval(P2,0.1:0.1:160);
P3 = polyfit(NormTmp(:,1),NormTmp(:,2),1);      Y3 = polyval(P3,0.1:0.1:160);
P4 = polyfit(log(NormTmp(:,1)),NormTmp(:,2),1); Y4 = polyval(P4,log(0.1:0.1:160));

subplot(3,3,[1 2])
errorbar(Xaxis', DATARef5_s_MEANsq(:)', DATARef5_s_STDsq(:)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
line([0 0],[0 3],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-160:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:160,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-155,1.8,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-160 160 0 1]); ylabel('Reaction time (s)');xlabel('Spatial distance (°)');title('SJ PreW');

subplot(3,3,3)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:160,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:160,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(5,1.5,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 160 0 1]); ylabel('Reaction time (s)');xlabel('|Spatial distance| (°)');title('SJ PreW');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PARIS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (LONG(:)-ones(36,1)*(2.3));
AbsXaxis = abs((LONG(:)-ones(36,1)*(2.3))); Yaxis = DATARef6_s_MEANsq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis DATARef6_s_STDsq(:)]);
tmpB = tmp(1:18,:) ;tmpstdB = tmpstd(1:18,:);
tmpA = tmp(19:36,:);tmpstdA = tmpstd(19:36,:);
indB = find(sum((isnan(tmpB) == 0),2) == 2);
indA = find(sum((isnan(tmpA) == 0),2) == 2);
tmpB = tmpB(indB,:);tmpstdB = tmpstd(indB,:);
tmpA = tmpA(indA,:);tmpstdA = tmpstd(indA,:);
NormTmp = sortrows(abs([tmpB ; tmpA]));
NormTmpStd = sortrows(abs([tmpstdB ; tmpstdA]));

[B1,BINT1,R1,RINT1,STATS1] = REGRESS(tmpB(:,2),[ones(size(tmpB,1),1) tmpB(:,1)]);
[B2,BINT2,R2,RINT2,STATS2] = REGRESS(tmpA(:,2),[ones(size(tmpA,1),1) tmpA(:,1)]);
[B3,BINT3,R3,RINT3,STATS3] = REGRESS(NormTmp(:,2),[ones(size(NormTmp,1),1) NormTmp(:,1)]);
[B4,BINT4,R4,RINT4,STATS4] = REGRESS(log(NormTmp(:,2)),[ones(size(NormTmp,1),1) NormTmp(:,1)]);

P1 = polyfit(tmpB(:,1),tmpB(:,2),1);            Y1 = polyval(P1,-160:0.1:-0.1);
P2 = polyfit(tmpA(:,1),tmpA(:,2),1);            Y2 = polyval(P2,0.1:0.1:160);
P3 = polyfit(NormTmp(:,1),NormTmp(:,2),1);      Y3 = polyval(P3,0.1:0.1:160);
P4 = polyfit(log(NormTmp(:,1)),NormTmp(:,2),1); Y4 = polyval(P4,log(0.1:0.1:160));

subplot(3,3,[4 5])
errorbar(Xaxis', DATARef6_s_MEANsq(:)', DATARef6_s_STDsq(:)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
line([0 0],[0 1],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-160:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:160,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-155,1.8,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-160 160 0 1]); ylabel('Reaction time (s)');xlabel('Spatial distance (°)');title('SJ PrePar');

subplot(3,3,6)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(length(6)),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:160,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:160,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(5,1.5,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 160 0 1]); ylabel('Reaction time (s)');xlabel('|Spatial distance| (°)');title('SJ PrePar');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EAST %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (LONG(:)-ones(36,1)*(55.3));
AbsXaxis = abs((LONG(:)-ones(36,1)*(55.3))); Yaxis = DATARef4_s_MEANsq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis DATARef4_s_STDsq(:)]);
tmpB = tmp(1:18,:) ;tmpstdB = tmpstd(1:18,:);
tmpA = tmp(19:36,:);tmpstdA = tmpstd(19:36,:);
indB = find(sum((isnan(tmpB) == 0),2) == 2);
indA = find(sum((isnan(tmpA) == 0),2) == 2);
tmpB = tmpB(indB,:);tmpstdB = tmpstd(indB,:);
tmpA = tmpA(indA,:);tmpstdA = tmpstd(indA,:);
NormTmp = sortrows(abs([tmpB ; tmpA]));
NormTmpStd = sortrows(abs([tmpstdB ; tmpstdA]));

[B1,BINT1,R1,RINT1,STATS1] = REGRESS(tmpB(:,2),[ones(size(tmpB,1),1) tmpB(:,1)]);
[B2,BINT2,R2,RINT2,STATS2] = REGRESS(tmpA(:,2),[ones(size(tmpA,1),1) tmpA(:,1)]);
[B3,BINT3,R3,RINT3,STATS3] = REGRESS(NormTmp(:,2),[ones(size(NormTmp,1),1) NormTmp(:,1)]);
[B4,BINT4,R4,RINT4,STATS4] = REGRESS(log(NormTmp(:,2)),[ones(size(NormTmp,1),1) NormTmp(:,1)]);

STATS = [STATS1;STATS2;STATS3];
P1 = polyfit(tmpB(:,1),tmpB(:,2),1);            Y1 = polyval(P1,-160:0.1:-0.1);
P2 = polyfit(tmpA(:,1),tmpA(:,2),1);            Y2 = polyval(P2,0.1:0.1:160);
P3 = polyfit(NormTmp(:,1),NormTmp(:,2),1);      Y3 = polyval(P3,0.1:0.1:160);
P4 = polyfit(log(NormTmp(:,1)),NormTmp(:,2),1); Y4 = polyval(P4,log(0.1:0.1:160));

subplot(3,3,[7 8])
errorbar(Xaxis', DATARef4_s_MEANsq(:)', DATARef4_s_STDsq(:)'./sqrt(length(6)),'linestyle','none','marker','.','markersize',20); hold on;
line([0 0],[0 1],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-160:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:160,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-155,1.8,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(1,1.8,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-160 160 0 1]); ylabel('Reaction time (s)');xlabel('Spatial distance (°)');title('SJ PreE');

subplot(3,3,9)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(length(6)),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:160,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:160,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(1,1.5,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(1,1.8,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 160 0 1]); ylabel('Reaction time (s)');xlabel('|Spatial distance| (°)');title('SJ PreE');

print('-dpng',['C:\MTT_MEG\results\REGRESS_SPACE_ER_MT_MEG_PSYCHO_SPACE_3rd_bis' NIP])


