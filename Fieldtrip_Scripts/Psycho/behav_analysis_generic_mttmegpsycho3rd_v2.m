function [DATA_s_Ref,DATA_t_Ref] = behav_analysis_generic_mttmegpsycho3rd(FOLDER,NIP,varargin)

% load events description to get conditions structure
File_Events = ['C:\Users\bgauthie\Desktop\ONGOING_PROJECTS\MENTAL_TIME_TRAVEL\STIM\EVENTS\EVENTS_Psycho\EVENT_IMAGING.xlsx'];
[NUM,EVENTS] = xlsread(File_Events);

% get file names for the combination of interest
NAMESLIST = get_filenames(FOLDER,NIP,varargin{:});

File_Events = ['C:\Users\bgauthie\Desktop\ONGOING_PROJECTS\MENTAL_TIME_TRAVEL\STIM\EVENTS\EVENTS_Psycho\DATE_IMAGING.xlsx'];
[DATE,TXT] = xlsread(File_Events);

File_Events = ['C:\Users\bgauthie\Desktop\ONGOING_PROJECTS\MENTAL_TIME_TRAVEL\STIM\EVENTS\EVENTS_Psycho\LONG_IMAGING.xlsx'];
[LONG,TXT] = xlsread(File_Events);

% load data for each repetition
for r = 1:length(NAMESLIST)
    % create dummy variable
    REPETITION{r} = load([FOLDER '\' NAMESLIST{r,1}],'RT','REFPACK','DIM','EVENTS');
end

count = [0 0 0 0 0 0];
for r = 1:length(NAMESLIST)
    for n = REPETITION{r}.REFPACK
        for i = 1:8
            count_t = 1;
            while count_t <= 36
                if (strcmp(char(REPETITION{1,r}.EVENTS{REPETITION{1,r}.REFPACK(n)}(count(n)+i)),EVENTS{count_t}) == 1) && (REPETITION{1,r}.DIM{n}(count(n)+i) == 7)
                    DATA_t{r}(n,count_t) = REPETITION{1,r}.RT(r,count(n)+i);
                end
                count_t = count_t + 1;
            end

            count_s = 1;
            while count_s <= 36
                if (strcmp(char(REPETITION{1,r}.EVENTS{REPETITION{1,r}.REFPACK(n)}(count(n)+i)),EVENTS{count_s}) == 1) && (REPETITION{1,r}.DIM{n}(count(n)+i) == 8)
                    DATA_s{r}(n,count_s) = REPETITION{1,r}.RT(r,count(n)+i);
                end
                count_s = count_s + 1;
            end
        end
        count(n) = count(n) +8;
    end
end

DATARef1_s_FULL = DATA_s{1}(1,:);
DATARef2_s_FULL = DATA_s{1}(2,:);
DATARef3_s_FULL = DATA_s{1}(3,:);
DATARef4_s_FULL = DATA_s{1}(4,:);
DATARef5_s_FULL = DATA_s{1}(5,:);
DATARef6_s_FULL = DATA_s{1}(6,:);

DATARef1_t_FULL = DATA_t{1}(1,:);
DATARef2_t_FULL = DATA_t{1}(2,:);
DATARef3_t_FULL = DATA_t{1}(3,:);
DATARef4_t_FULL = DATA_t{1}(4,:);
DATARef5_t_FULL = DATA_t{1}(5,:);
DATARef6_t_FULL = DATA_t{1}(6,:);

DATARef1_s_FULL(DATARef1_s_FULL < 1.e-2) = NaN;
DATARef2_s_FULL(DATARef2_s_FULL < 1.e-2) = NaN;
DATARef3_s_FULL(DATARef3_s_FULL < 1.e-2) = NaN;
DATARef4_s_FULL(DATARef4_s_FULL < 1.e-2) = NaN;
DATARef5_s_FULL(DATARef5_s_FULL < 1.e-2) = NaN;
DATARef6_s_FULL(DATARef6_s_FULL < 1.e-2) = NaN;
DATARef1_s_FULL(DATARef1_s_FULL > 4.5) = NaN;
DATARef2_s_FULL(DATARef2_s_FULL > 4.5) = NaN;
DATARef3_s_FULL(DATARef3_s_FULL > 4.5) = NaN;
DATARef4_s_FULL(DATARef4_s_FULL > 4.5) = NaN;
DATARef5_s_FULL(DATARef5_s_FULL > 4.5) = NaN;
DATARef6_s_FULL(DATARef6_s_FULL > 4.5) = NaN;
DATARef1_t_FULL(DATARef1_t_FULL < 10.e-2) = NaN;
DATARef2_t_FULL(DATARef2_t_FULL < 10.e-2) = NaN;
DATARef3_t_FULL(DATARef3_t_FULL < 10.e-2) = NaN;
DATARef4_t_FULL(DATARef4_t_FULL < 10.e-2) = NaN;
DATARef5_t_FULL(DATARef5_t_FULL < 10.e-2) = NaN;
DATARef6_t_FULL(DATARef6_t_FULL < 10.e-2) = NaN;
DATARef1_t_FULL(DATARef1_t_FULL > 4.5) = NaN;
DATARef2_t_FULL(DATARef2_t_FULL > 4.5) = NaN;
DATARef3_t_FULL(DATARef3_t_FULL > 4.5) = NaN;
DATARef4_t_FULL(DATARef4_t_FULL > 4.5) = NaN;
DATARef5_t_FULL(DATARef5_t_FULL > 4.5) = NaN;
DATARef6_t_FULL(DATARef6_t_FULL > 4.5) = NaN;

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
subplot(2,3,1); imagesc(DATARef1_s_MEANsq,[0 2]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');
subplot(2,3,2); imagesc(DATARef2_s_MEANsq,[0 2]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');
subplot(2,3,3); imagesc(DATARef3_s_MEANsq,[0 2]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');
subplot(2,3,4); imagesc(DATARef4_s_MEANsq,[0 2]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');
subplot(2,3,5); imagesc(DATARef5_s_MEANsq,[0 2]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');
subplot(2,3,6); imagesc(DATARef6_s_MEANsq,[0 2]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');

print('-dpng',['C:\MTT_MEG\results\FULL_RT_MT_MEG_PSYCHO_SPACE_3rd' NIP])

fig1 = figure('position',[1 1 800 500]);
set(fig1,'PaperPosition',[1 1 800 500])
set(fig1,'PaperPositionmode','auto')
subplot(2,3,1); imagesc(DATARef1_t_MEANsq,[0 2]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');
subplot(2,3,2); imagesc(DATARef2_t_MEANsq,[0 2]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');
subplot(2,3,3); imagesc(DATARef3_t_MEANsq,[0 2]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');
subplot(2,3,4); imagesc(DATARef4_t_MEANsq,[0 2]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');
subplot(2,3,5); imagesc(DATARef5_t_MEANsq,[0 2]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');
subplot(2,3,6); imagesc(DATARef6_t_MEANsq,[0 2]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');

print('-dpng',['C:\MTT_MEG\results\FULL_RT_MT_MEG_PSYCHO_TIME_3rd' NIP])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 800 500]);
set(fig1,'PaperPosition',[1 1 800 500])
set(fig1,'PaperPositionmode','auto')

subplot(2,3,1)
bar(1:6,nanmean(DATARef1_t_MEANsq'),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-2 -1 1 2 3 4]);hold on
errorbar(1:6,nanmean(DATARef1_t_MEANsq'),nanstd(DATARef1_t_MEANsq')./sqrt(6),'linestyle','none','color','k')
subplot(2,3,2)
bar(1:6,nanmean(DATARef2_t_MEANsq'),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(DATARef2_t_MEANsq'),nanstd(DATARef2_t_MEANsq')./sqrt(6),'linestyle','none','color','k')
subplot(2,3,3)
bar(1:6,nanmean(DATARef3_t_MEANsq'),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-4 -3 -2 -1 1 2]);hold on
errorbar(1:6,nanmean(DATARef3_t_MEANsq'),nanstd(DATARef3_t_MEANsq')./sqrt(6),'linestyle','none','color','k')
subplot(2,3,4)
bar(1:6,nanmean(DATARef4_t_MEANsq),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(DATARef4_t_MEANsq),nanstd(DATARef4_t_MEANsq)./sqrt(6),'linestyle','none','color','k')
subplot(2,3,5)
bar(1:6,nanmean(DATARef5_t_MEANsq),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(DATARef5_t_MEANsq),nanstd(DATARef5_t_MEANsq)./sqrt(6),'linestyle','none','color','k')
subplot(2,3,6)
bar(1:6,nanmean(DATARef6_t_MEANsq),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(DATARef6_t_MEANsq),nanstd(DATARef6_t_MEANsq)./sqrt(6),'linestyle','none','color','k')

print('-dpng',['C:\MTT_MEG\results\MEAN_RT_MT_MEG_PSYCHO_TIME_3rd' NIP])

fig1 = figure('position',[1 1 800 500]);
set(fig1,'PaperPosition',[1 1 800 500])
set(fig1,'PaperPositionmode','auto')

subplot(2,3,1)
bar(1:6,nanmean(DATARef1_s_MEANsq'),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(DATARef1_s_MEANsq'),nanstd(DATARef1_s_MEANsq')./sqrt(6),'linestyle','none','color','k')
subplot(2,3,2)
bar(1:6,nanmean(DATARef2_s_MEANsq'),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(DATARef2_s_MEANsq'),nanstd(DATARef2_s_MEANsq')./sqrt(6),'linestyle','none','color','k')
subplot(2,3,3)
bar(1:6,nanmean(DATARef3_s_MEANsq'),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(DATARef3_s_MEANsq'),nanstd(DATARef3_s_MEANsq')./sqrt(6),'linestyle','none','color','k')
subplot(2,3,4)
bar(1:6,nanmean(DATARef4_s_MEANsq),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(DATARef4_s_MEANsq),nanstd(DATARef4_s_MEANsq)./sqrt(6),'linestyle','none','color','k')
subplot(2,3,5)
bar(1:6,nanmean(DATARef5_s_MEANsq),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(DATARef5_s_MEANsq),nanstd(DATARef5_s_MEANsq)./sqrt(6),'linestyle','none','color','k')
subplot(2,3,6)
bar(1:6,nanmean(DATARef6_s_MEANsq),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(DATARef6_s_MEANsq),nanstd(DATARef6_s_MEANsq)./sqrt(6),'linestyle','none','color','k')

print('-dpng',['C:\MTT_MEG\results\MEAN_RT_MT_MEG_PSYCHO_SPACE_3rd' NIP])

%
DATES1 = DATE(1:4,:); DATES1ind = [1:4 7:10 13:16 19:22 25:28 31:34];
DATES2 = DATE(2:5,:); DATES2ind = [2:5 8:11 14:17 20:23 26:29 32:35];
DATES3 = DATE(3:6,:); DATES3ind = [3:6 9:12 15:18 21:24 27:30 33:36];

D1 = sortrows([DATES1(:) DATES1ind(:)]);
D2 = sortrows([DATES2(:) DATES2ind(:)]);
D3 = sortrows([DATES3(:) DATES3ind(:)]);

LONGS1 = LONG(:,1:4); LONGS1ind = [1:6   7:12  13:18 19:24];
LONGS2 = LONG(:,2:5); LONGS2ind = [7:12  13:18 19:24 25:30];
LONGS3 = LONG(:,3:6); LONGS3ind = [13:18 19:24 25:30 31:36];

L1 = sortrows([LONGS1(:) LONGS1ind(:)]);
L2 = sortrows([LONGS2(:) LONGS2ind(:)]);
L3 = sortrows([LONGS3(:) LONGS3ind(:)]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 800 800]);
set(fig1,'PaperPosition',[1 1 800 800])
set(fig1,'PaperPositionmode','auto')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PAST %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (DATE(:)-ones(36,1)*(2004));
AbsXaxis = abs((DATE(:)-ones(36,1)*(2004))); Yaxis = DATARef1_t_MEANsq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis DATARef1_t_STDsq(:)]);
tmpB = tmp(1:12,:) ;tmpstdB = tmpstd(1:12,:);
tmpA = tmp(13:24,:);tmpstdA = tmpstd(13:24,:);
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
P1 = polyfit(tmpB(:,1),tmpB(:,2),1);            Y1 = polyval(P1,-20:0.1:-0.1);
P2 = polyfit(tmpA(:,1),tmpA(:,2),1);            Y2 = polyval(P2,0.1:0.1:20);
P3 = polyfit(NormTmp(:,1),NormTmp(:,2),1);      Y3 = polyval(P3,0.1:0.1:20);
P4 = polyfit(log(NormTmp(:,1)),NormTmp(:,2),1); Y4 = polyval(P4,log(0.1:0.1:20));

subplot(3,3,[1 2])
errorbar(Xaxis', DATARef1_t_MEANsq(:)', DATARef1_t_STDsq(:)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
line([0 0],[0 2],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-20:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:20,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-15,1.8,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-18 18 0 2]); ylabel('Reaction time (s)');xlabel('Temporal distance(y)');

subplot(3,3,3)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:20,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:20,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(5,1.5,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 18 0 2]); ylabel('Reaction time (s)');xlabel('|Temporal distance| (y)');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PRESENT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (DATE(:)-ones(36,1)*(2013));
AbsXaxis = abs((DATE(:)-ones(36,1)*(2013))); Yaxis = DATARef2_t_MEANsq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis DATARef2_t_STDsq(:)]);
tmpB = tmp(7:18,:) ;tmpstdB = tmpstd(7:18,:);
tmpA = tmp(19:30,:);tmpstdA = tmpstd(19:30,:);
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
P1 = polyfit(tmpB(:,1),tmpB(:,2),1);            Y1 = polyval(P1,-20:0.1:-0.1);
P2 = polyfit(tmpA(:,1),tmpA(:,2),1);            Y2 = polyval(P2,0.1:0.1:20);
P3 = polyfit(NormTmp(:,1),NormTmp(:,2),1);      Y3 = polyval(P3,0.1:0.1:20);
P4 = polyfit(log(NormTmp(:,1)),NormTmp(:,2),1); Y4 = polyval(P4,log(0.1:0.1:20));

subplot(3,3,[4 5])
errorbar(Xaxis', DATARef2_t_MEANsq(:)', DATARef2_t_STDsq(:)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
line([0 0],[0 2],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-20:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:20,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-15,1.8,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-18 18 0 2]); ylabel('Reaction time (s)');xlabel('Temporal distance(y)');

subplot(3,3,6)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:20,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:20,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(5,1.5,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 18 0 2]); ylabel('Reaction time (s)');xlabel('|Temporal distance| (y)');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FUTURE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (DATE(:)-ones(36,1)*(2022));
AbsXaxis = abs((DATE(:)-ones(36,1)*(2022))); Yaxis = DATARef3_t_MEANsq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis DATARef3_t_STDsq(:)]);
tmpB = tmp(13:24,:) ;tmpstdB = tmpstd(1:12,:);
tmpA = tmp(25:36,:);tmpstdA = tmpstd(13:24,:);
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
P1 = polyfit(tmpB(:,1),tmpB(:,2),1);            Y1 = polyval(P1,-20:0.1:-0.1);
P2 = polyfit(tmpA(:,1),tmpA(:,2),1);            Y2 = polyval(P2,0.1:0.1:20);
P3 = polyfit(NormTmp(:,1),NormTmp(:,2),1);      Y3 = polyval(P3,0.1:0.1:20);
P4 = polyfit(log(NormTmp(:,1)),NormTmp(:,2),1); Y4 = polyval(P4,log(0.1:0.1:20));

subplot(3,3,[7 8])
errorbar(Xaxis', DATARef3_t_MEANsq(:)', DATARef3_t_STDsq(:)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
line([0 0],[0 2],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-20:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:20,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-17,1.8,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(1,1.8,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-18 18 0 2]); ylabel('Reaction time (s)');xlabel('Temporal distance(y)');

subplot(3,3,9)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:20,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:20,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(1,1.5,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(1,1.8,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 18 0 2]); ylabel('Reaction time (s)');xlabel('|Temporal distance| (y)');

print('-dpng',['C:\MTT_MEG\results\REGRESS_TIME_RT_MT_MEG_PSYCHO_TIME_3rd' NIP])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 800 800]);
set(fig1,'PaperPosition',[1 1 800 800])
set(fig1,'PaperPositionmode','auto')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% WEST %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (DATE(:)-ones(36,1)*(2013));
AbsXaxis = abs((DATE(:)-ones(36,1)*(2013))); Yaxis = DATARef4_t_MEANsq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis DATARef4_t_STDsq(:)]);
tmpB = tmp(7:18,:) ;tmpstdB = tmpstd(7:18,:);
tmpA = tmp(19:30,:);tmpstdA = tmpstd(19:30,:);
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
P1 = polyfit(tmpB(:,1),tmpB(:,2),1);            Y1 = polyval(P1,-20:0.1:-0.1);
P2 = polyfit(tmpA(:,1),tmpA(:,2),1);            Y2 = polyval(P2,0.1:0.1:20);
P3 = polyfit(NormTmp(:,1),NormTmp(:,2),1);      Y3 = polyval(P3,0.1:0.1:20);
P4 = polyfit(log(NormTmp(:,1)),NormTmp(:,2),1); Y4 = polyval(P4,log(0.1:0.1:20));

subplot(3,3,[1 2])
errorbar(Xaxis', DATARef4_t_MEANsq(:)', DATARef4_t_STDsq(:)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
line([0 0],[0 2],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-20:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:20,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-15,1.8,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-18 18 0 2]); ylabel('Reaction time (s)');xlabel('Temporal distance(y)');

subplot(3,3,3)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:20,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:20,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(5,1.5,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 18 0 2]); ylabel('Reaction time (s)');xlabel('|Temporal distance| (y)');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PARIS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (DATE(:)-ones(36,1)*(2013));
AbsXaxis = abs((DATE(:)-ones(36,1)*(2013))); Yaxis = DATARef5_t_MEANsq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis DATARef5_t_STDsq(:)]);
tmpB = tmp(7:18,:) ;tmpstdB = tmpstd(7:18,:);
tmpA = tmp(19:30,:);tmpstdA = tmpstd(19:30,:);
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
P1 = polyfit(tmpB(:,1),tmpB(:,2),1);            Y1 = polyval(P1,-20:0.1:-0.1);
P2 = polyfit(tmpA(:,1),tmpA(:,2),1);            Y2 = polyval(P2,0.1:0.1:20);
P3 = polyfit(NormTmp(:,1),NormTmp(:,2),1);      Y3 = polyval(P3,0.1:0.1:20);
P4 = polyfit(log(NormTmp(:,1)),NormTmp(:,2),1); Y4 = polyval(P4,log(0.1:0.1:20));

subplot(3,3,[4 5])
errorbar(Xaxis', DATARef5_t_MEANsq(:)', DATARef5_t_STDsq(:)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
line([0 0],[0 2],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-20:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:20,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-15,1.8,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-18 18 0 2]); ylabel('Reaction time (s)');xlabel('Temporal distance(y)');

subplot(3,3,6)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:20,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:20,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(5,1.5,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 18 0 2]); ylabel('Reaction time (s)');xlabel('|Temporal distance| (y)');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FUTURE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (DATE(:)-ones(36,1)*(2013));
AbsXaxis = abs((DATE(:)-ones(36,1)*(2013))); Yaxis = DATARef6_t_MEANsq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis DATARef6_t_STDsq(:)]);
tmpB = tmp(7:18,:) ;tmpstdB = tmpstd(7:18,:);
tmpA = tmp(19:30,:);tmpstdA = tmpstd(19:30,:);
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
P1 = polyfit(tmpB(:,1),tmpB(:,2),1);            Y1 = polyval(P1,-20:0.1:-0.1);
P2 = polyfit(tmpA(:,1),tmpA(:,2),1);            Y2 = polyval(P2,0.1:0.1:20);
P3 = polyfit(NormTmp(:,1),NormTmp(:,2),1);      Y3 = polyval(P3,0.1:0.1:20);
P4 = polyfit(log(NormTmp(:,1)),NormTmp(:,2),1); Y4 = polyval(P4,log(0.1:0.1:20));

subplot(3,3,[7 8])
errorbar(Xaxis', DATARef6_t_MEANsq(:)', DATARef6_t_STDsq(:)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
line([0 0],[0 2],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-20:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:20,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-15,1.8,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-18 18 0 2]); ylabel('Reaction time (s)');xlabel('Temporal distance(y)');

subplot(3,3,9)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:20,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:20,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(5,1.5,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 18 0 2]); ylabel('Reaction time (s)');xlabel('|Temporal distance| (y)');

print('-dpng',['C:\MTT_MEG\results\REGRESS_SPACE_RT_MT_MEG_PSYCHO_TIME_3rd_bis' NIP])

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
tmpA = tmp(13:24,:);tmpstdA = tmpstd(13:24,:);
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
line([0 0],[0 2],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-160:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:160,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-155,1.8,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-160 160 0 2]); ylabel('Reaction time (s)');xlabel('Spatial distance (°)');

subplot(3,3,3)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:160,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:160,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(5,1.5,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 160 0 2]); ylabel('Reaction time (s)');xlabel('|Spatial distance| (°)');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PARIS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (LONG(:)-ones(36,1)*(2.3));
AbsXaxis = abs((LONG(:)-ones(36,1)*(2.3))); Yaxis = DATARef2_s_MEANsq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis DATARef2_s_STDsq(:)]);
tmpB = tmp(7:18,:) ;tmpstdB = tmpstd(7:18,:);
tmpA = tmp(19:30,:);tmpstdA = tmpstd(19:30,:);
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
line([0 0],[0 2],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-160:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:160,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-155,1.8,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-160 160 0 2]); ylabel('Reaction time (s)');xlabel('Spatial distance (°)');

subplot(3,3,6)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(length(6)),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:160,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:160,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(5,1.5,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 160 0 2]); ylabel('Reaction time (s)');xlabel('|Spatial distance| (°)');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FUTURE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (LONG(:)-ones(36,1)*(55.3));
AbsXaxis = abs((LONG(:)-ones(36,1)*(55.3))); Yaxis = DATARef3_s_MEANsq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis DATARef3_s_STDsq(:)]);
tmpB = tmp(13:24,:) ;tmpstdB = tmpstd(13:24,:);
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
line([0 0],[0 2],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-160:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:160,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-155,1.8,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(1,1.8,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-160 160 0 2]); ylabel('Reaction time (s)');xlabel('Spatial distance (°)');

subplot(3,3,9)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(length(6)),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:160,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:160,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(1,1.5,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(1,1.8,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 160 0 2]); ylabel('Reaction time (s)');xlabel('|Spatial distance| (°)');

print('-dpng',['C:\MTT_MEG\results\REGRESS_SPACE_RT_MT_MEG_PSYCHO_SPACE_3rd' NIP])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 800 800]);
set(fig1,'PaperPosition',[1 1 800 800])
set(fig1,'PaperPositionmode','auto')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% WEST %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (LONG(:)-ones(36,1)*(-52.3));
AbsXaxis = abs((LONG(:)-ones(36,1)*(-52.3))); Yaxis = DATARef5_s_MEANsq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis DATARef5_s_STDsq(:)]);
tmpB = tmp(7:18,:) ;tmpstdB = tmpstd(7:18,:);
tmpA = tmp(19:30,:);tmpstdA = tmpstd(19:30,:);
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
line([0 0],[0 2],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-160:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:160,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-155,1.8,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-160 160 0 2]); ylabel('Reaction time (s)');xlabel('Spatial distance (°)');

subplot(3,3,3)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:160,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:160,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(5,1.5,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 160 0 2]); ylabel('Reaction time (s)');xlabel('|Spatial distance| (°)');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PARIS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (LONG(:)-ones(36,1)*(2.3));
AbsXaxis = abs((LONG(:)-ones(36,1)*(2.3))); Yaxis = DATARef4_s_MEANsq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis DATARef4_s_STDsq(:)]);
tmpB = tmp(7:18,:) ;tmpstdB = tmpstd(7:18,:);
tmpA = tmp(19:30,:);tmpstdA = tmpstd(19:30,:);
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
errorbar(Xaxis', DATARef4_s_MEANsq(:)', DATARef4_s_STDsq(:)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
line([0 0],[0 2],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-160:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:160,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-155,1.8,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-160 160 0 2]); ylabel('Reaction time (s)');xlabel('Spatial distance (°)');

subplot(3,3,6)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(length(6)),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:160,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:160,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(5,1.5,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 160 0 2]); ylabel('Reaction time (s)');xlabel('|Spatial distance| (°)');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FUTURE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (LONG(:)-ones(36,1)*(55.3));
AbsXaxis = abs((LONG(:)-ones(36,1)*(55.3))); Yaxis = DATARef6_s_MEANsq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis DATARef6_s_STDsq(:)]);
tmpB = tmp(7:18,:) ;tmpstdB = tmpstd(7:18,:);
tmpA = tmp(19:30,:);tmpstdA = tmpstd(7:18,:);
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
errorbar(Xaxis', DATARef6_s_MEANsq(:)', DATARef6_s_STDsq(:)'./sqrt(length(6)),'linestyle','none','marker','.','markersize',20); hold on;
line([0 0],[0 2],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-160:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:160,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-155,1.8,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(1,1.8,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-160 160 0 2]); ylabel('Reaction time (s)');xlabel('Spatial distance (°)');

subplot(3,3,9)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(length(6)),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:160,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:160,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(1,1.5,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(1,1.8,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 160 0 2]); ylabel('Reaction time (s)');xlabel('|Spatial distance| (°)');

print('-dpng',['C:\MTT_MEG\results\REGRESS_SPACE_RT_MT_MEG_PSYCHO_SPACE_3rd_bis' NIP])




