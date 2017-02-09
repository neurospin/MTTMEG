function DATARef = error_analysis_generic_mttmegpsycho_MASKED(FOLDER,NIP,varargin)

% load events description to get conditions structure
File_Events = ['C:\Users\bgauthie\Desktop\ONGOING_PROJECTS\MENTAL_TIME_TRAVEL\STIM\EVENTS\EVENTS_Psycho\EVENT_IMAGING.xlsx'];
[NUM,EVENTS] = xlsread(File_Events);

File_Events = ['C:\Users\bgauthie\Desktop\ONGOING_PROJECTS\MENTAL_TIME_TRAVEL\STIM\EVENTS\EVENTS_Psycho\DATE_IMAGING.xlsx'];
[DATE,TXT] = xlsread(File_Events);

File_Events = ['C:\Users\bgauthie\Desktop\ONGOING_PROJECTS\MENTAL_TIME_TRAVEL\STIM\EVENTS\EVENTS_Psycho\LONG_IMAGING.xlsx'];
[LONG,TXT] = xlsread(File_Events);

% get file names for the combination of interest
NAMESLIST = get_filenames(FOLDER,NIP,varargin{:});

% load data for each repetition
for r = 1:length(NAMESLIST)
    REPETITION{r} = load([FOLDER '\' NAMESLIST{r,1}],'RT','EVENTSPACK','REF','RespValStore');
end

% load debrief results
File_Events = ['C:\MTT_MEG\psych\date_' NIP '_DEBRIEF.xlsx'];
[DEB_DATE,TXT] = xlsread(File_Events);
for i = 1:6
    for j = 1:6
        if DEB_DATE(i,j) == DATE(i,j)
            DEB_MASK(i,j) = 1;
        else
            DEB_MASK(i,j) = NaN;
        end
    end
end

%
DATES1ind = [1:2 7:8  13:14 19:20 25:26 31:32];
DATES2ind = [2:3 8:9  14:15 20:21 26:27 32:33];
DATES3ind = [3:4 9:10 15:16 21:22 27:28 33:34];

LONGS1ind = [1 7 2 8 3 9 4 10 5 11 6 12];
LONGS2ind = [7 13 8 14 9 15 10 16 11 17 12 18];
LONGS3ind = [13 19 14 20 15 21 16 22 17 23 18 24];

DATARef1FULL = [];
DATARef2FULL = [];
DATARef3FULL = [];
DATARef4FULL = [];
DATARef5FULL = [];
DATARef6FULL = [];
for r = 1:length(REPETITION)
    DATARef1 = ones(1,36)*NaN;
    DATARef2 = ones(1,36)*NaN;
    DATARef3 = ones(1,36)*NaN;
    DATARef4 = ones(1,36)*NaN;
    DATARef5 = ones(1,36)*NaN;
    DATARef6 = ones(1,36)*NaN;
    for i = 1:36 % mini-block (= ref)
        if REPETITION{1,r}.REF(i) == 1
            for j = 1:4
                count = 1;
                while count <= 36
                    if strcmp(REPETITION{1,r}.EVENTSPACK{1,i}{1,j},EVENTS{count}) == 1
                        if isempty(intersect(count,DATES1ind)) == 0 && REPETITION{1,r}.RespValStore(i,j) == 73
                            DATARef1(count) = 0;
                        elseif isempty(intersect(count,DATES1ind)) == 0 && REPETITION{1,r}.RespValStore(i,j) == 80
                            DATARef1(count) = 1;
                        elseif isempty(intersect(count,DATES1ind)) == 1 && REPETITION{1,r}.RespValStore(i,j) == 73
                            DATARef1(count) = 1;
                        elseif isempty(intersect(count,DATES1ind)) == 1 && REPETITION{1,r}.RespValStore(i,j) == 80
                            DATARef1(count) = 0;
                        end
                    end
                    count = count + 1;
                end
            end
        elseif REPETITION{1,r}.REF(i) == 2
            for j = 1:4
                count = 1;
                while count <= 36
                    if strcmp(REPETITION{1,r}.EVENTSPACK{1,i}{1,j},EVENTS{count}) == 1
                        if isempty(intersect(count,DATES2ind)) == 0 && REPETITION{1,r}.RespValStore(i,j) == 73
                            DATARef2(count) = 0;
                        elseif isempty(intersect(count,DATES2ind)) == 0 && REPETITION{1,r}.RespValStore(i,j) == 80
                            DATARef2(count) = 1;
                        elseif isempty(intersect(count,DATES2ind)) == 1 && REPETITION{1,r}.RespValStore(i,j) == 73
                            DATARef2(count) = 1;
                        elseif isempty(intersect(count,DATES2ind)) == 1 && REPETITION{1,r}.RespValStore(i,j) == 80
                            DATARef2(count) = 0;
                        end
                    end
                    count = count + 1;
                end
            end
        elseif REPETITION{1,r}.REF(i) == 3
            for j = 1:4
                count = 1;
                while count <= 36
                    if strcmp(REPETITION{1,r}.EVENTSPACK{1,i}{1,j},EVENTS{count}) == 1
                        if isempty(intersect(count,DATES3ind)) == 0 && REPETITION{1,r}.RespValStore(i,j) == 73
                            DATARef3(count) = 0;
                        elseif isempty(intersect(count,DATES3ind)) == 0 && REPETITION{1,r}.RespValStore(i,j) == 80
                            DATARef3(count) = 1;
                        elseif isempty(intersect(count,DATES3ind)) == 1 && REPETITION{1,r}.RespValStore(i,j) == 73
                            DATARef3(count) = 1;
                        elseif isempty(intersect(count,DATES3ind)) == 1 && REPETITION{1,r}.RespValStore(i,j) == 80
                            DATARef3(count) = 0;
                        end
                    end
                    count = count + 1;
                end
            end            
        elseif REPETITION{1,r}.REF(i) == 4
            for j = 1:4
                count = 1;
                while count <= 36
                    if strcmp(REPETITION{1,r}.EVENTSPACK{1,i}{1,j},EVENTS{count}) == 1
                        if isempty(intersect(count,LONGS1ind)) == 0 && REPETITION{1,r}.RespValStore(i,j) == 73
                            DATARef4(count) = 0;
                        elseif isempty(intersect(count,LONGS1ind)) == 0 && REPETITION{1,r}.RespValStore(i,j) == 80
                            DATARef4(count) = 1;
                        elseif isempty(intersect(count,LONGS1ind)) == 1 && REPETITION{1,r}.RespValStore(i,j) == 73
                            DATARef4(count) = 1;
                        elseif isempty(intersect(count,LONGS1ind)) == 1 && REPETITION{1,r}.RespValStore(i,j) == 80
                            DATARef4(count) = 0;
                        end
                    end
                    count = count + 1;
                end
            end             
        elseif REPETITION{1,r}.REF(i) == 5
            for j = 1:4
                count = 1;
                while count <= 36
                    if strcmp(REPETITION{1,r}.EVENTSPACK{1,i}{1,j},EVENTS{count}) == 1
                        if isempty(intersect(count,LONGS2ind)) == 0 && REPETITION{1,r}.RespValStore(i,j) == 73
                            DATARef5(count) = 0;
                        elseif isempty(intersect(count,LONGS2ind)) == 0 && REPETITION{1,r}.RespValStore(i,j) == 80
                            DATARef5(count) = 1;
                        elseif isempty(intersect(count,LONGS2ind)) == 1 && REPETITION{1,r}.RespValStore(i,j) == 73
                            DATARef5(count) = 1;
                        elseif isempty(intersect(count,LONGS2ind)) == 1 && REPETITION{1,r}.RespValStore(i,j) == 80
                            DATARef5(count) = 0;
                        end
                    end
                    count = count + 1;
                end
            end             
        elseif REPETITION{1,r}.REF(i) == 6
            for j = 1:4
                count = 1;
                while count <= 36
                    if strcmp(REPETITION{1,r}.EVENTSPACK{1,i}{1,j},EVENTS{count}) == 1
                        if isempty(intersect(count,LONGS3ind)) == 0 && REPETITION{1,r}.RespValStore(i,j) == 73
                            DATARef6(count) = 0;
                        elseif isempty(intersect(count,LONGS3ind)) == 0 && REPETITION{1,r}.RespValStore(i,j) == 80
                            DATARef6(count) = 1;
                        elseif isempty(intersect(count,LONGS3ind)) == 1 && REPETITION{1,r}.RespValStore(i,j) == 73
                            DATARef6(count) = 1;
                        elseif isempty(intersect(count,LONGS3ind)) == 1 && REPETITION{1,r}.RespValStore(i,j) == 80
                            DATARef6(count) = 0;
                        end
                    end
                    count = count + 1;
                end
            end             
        end
    end
    DATARef1FULL = cat(3,DATARef1FULL,DATARef1);
    DATARef2FULL = cat(3,DATARef2FULL,DATARef2);
    DATARef3FULL = cat(3,DATARef3FULL,DATARef3);
    DATARef4FULL = cat(3,DATARef4FULL,DATARef4);
    DATARef5FULL = cat(3,DATARef5FULL,DATARef5);
    DATARef6FULL = cat(3,DATARef6FULL,DATARef6);
end
            
%
DATARef1MEAN = nanmean(nanmean(DATARef1FULL,1),3);
DATARef2MEAN = nanmean(nanmean(DATARef2FULL,1),3);
DATARef3MEAN = nanmean(nanmean(DATARef3FULL,1),3);
DATARef4MEAN = nanmean(nanmean(DATARef4FULL,1),3);
DATARef5MEAN = nanmean(nanmean(DATARef5FULL,1),3);
DATARef6MEAN = nanmean(nanmean(DATARef6FULL,1),3);
DATARef1STD  = nanstd(nanmean(DATARef1FULL,1),0,3);
DATARef2STD  = nanstd(nanmean(DATARef2FULL,1),0,3);
DATARef3STD  = nanstd(nanmean(DATARef3FULL,1),0,3);
DATARef4STD  = nanstd(nanmean(DATARef4FULL,1),0,3);
DATARef5STD  = nanstd(nanmean(DATARef5FULL,1),0,3);
DATARef6STD  = nanstd(nanmean(DATARef6FULL,1),0,3);

DATARef1MEANsq = [(DATARef1MEAN(1:6))' ...
    (DATARef1MEAN(7:12))' ...
    (DATARef1MEAN(13:18))' ...
    (DATARef1MEAN(19:24))' ...
    (DATARef1MEAN(25:30))' ...
    (DATARef1MEAN(31:36))'].*DEB_MASK;
DATARef2MEANsq = [(DATARef2MEAN(1:6))' ...
    (DATARef2MEAN(7:12))' ...
    (DATARef2MEAN(13:18))' ...
    (DATARef2MEAN(19:24))' ...
    (DATARef2MEAN(25:30))' ...
    (DATARef2MEAN(31:36))'].*DEB_MASK;
DATARef3MEANsq = [(DATARef3MEAN(1:6))' ...
    (DATARef3MEAN(7:12))' ...
    (DATARef3MEAN(13:18))' ...
    (DATARef3MEAN(19:24))' ...
    (DATARef3MEAN(25:30))' ...
    (DATARef3MEAN(31:36))'].*DEB_MASK;
DATARef4MEANsq = [(DATARef4MEAN(1:6))' ...
    (DATARef4MEAN(7:12))' ...
    (DATARef4MEAN(13:18))' ...
    (DATARef4MEAN(19:24))' ...
    (DATARef4MEAN(25:30))' ...
    (DATARef4MEAN(31:36))'].*DEB_MASK;
DATARef5MEANsq = [(DATARef5MEAN(1:6))' ...
    (DATARef5MEAN(7:12))' ...
    (DATARef5MEAN(13:18))' ...
    (DATARef5MEAN(19:24))' ...
    (DATARef5MEAN(25:30))' ...
    (DATARef5MEAN(31:36))'].*DEB_MASK;
DATARef6MEANsq = [(DATARef6MEAN(1:6))' ...
    (DATARef6MEAN(7:12))' ...
    (DATARef6MEAN(13:18))' ...
    (DATARef6MEAN(19:24))' ...
    (DATARef6MEAN(25:30))' ...
    (DATARef6MEAN(31:36))'].*DEB_MASK;

fig1 = figure('position',[1 1 800 500]);
set(fig1,'PaperPosition',[1 1 800 500])
set(fig1,'PaperPositionmode','auto')
subplot(2,3,1); imagesc(DATARef1MEANsq,[0 0.3]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');
subplot(2,3,2); imagesc(DATARef2MEANsq,[0 0.3]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');
subplot(2,3,3); imagesc(DATARef3MEANsq,[0 0.3]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');
subplot(2,3,4); imagesc(DATARef4MEANsq,[0 0.3]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');
subplot(2,3,5); imagesc(DATARef5MEANsq,[0 0.3]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');
subplot(2,3,6); imagesc(DATARef6MEANsq,[0 0.3]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');
    
print('-dpng',['C:\MTT_MEG\results\FULL_ER_MT_MEG_PSYCHO_' NIP '_MD'])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 800 500]);
set(fig1,'PaperPosition',[1 1 800 500])
set(fig1,'PaperPositionmode','auto')

subplot(2,3,1)
bar(1:6,nanmean(DATARef1MEANsq'),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(DATARef1MEANsq'),nanstd(DATARef1MEANsq')./sqrt(length(REPETITION)),'linestyle','none','color','k')
axis([0 7 0 0.3])
subplot(2,3,2)
bar(1:6,nanmean(DATARef2MEANsq'),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(DATARef2MEANsq'),nanstd(DATARef2MEANsq')./sqrt(length(REPETITION)),'linestyle','none','color','k')
axis([0 7 0 0.3])
subplot(2,3,3)
bar(1:6,nanmean(DATARef3MEANsq'),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(DATARef3MEANsq'),nanstd(DATARef3MEANsq')./sqrt(length(REPETITION)),'linestyle','none','color','k')
axis([0 7 0 0.3])
subplot(2,3,4)
bar(1:6,nanmean(DATARef4MEANsq),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(DATARef4MEANsq),nanstd(DATARef4MEANsq)./sqrt(length(REPETITION)),'linestyle','none','color','k')
axis([0 7 0 0.3])
subplot(2,3,5)
bar(1:6,nanmean(DATARef5MEANsq),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(DATARef5MEANsq),nanstd(DATARef5MEANsq)./sqrt(length(REPETITION)),'linestyle','none','color','k')
axis([0 7 0 0.3])
subplot(2,3,6)
bar(1:6,nanmean(DATARef6MEANsq),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(DATARef6MEANsq),nanstd(DATARef6MEANsq)./sqrt(length(REPETITION)),'linestyle','none','color','k')
axis([0 7 0 0.3])

print('-dpng',['C:\MTT_MEG\results\MEAN_ER_MT_MEG_PSYCHO_' NIP '_MD'])

DATARef = {DATARef1FULL,DATARef1FULL,DATARef1FULL,DATARef1FULL,DATARef1FULL,DATARef1FULL};

