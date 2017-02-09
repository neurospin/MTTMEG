function DATARef = error_analysis_generic_mttmegpsycho_respcode(FOLDER,NIP,varargin)

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
% load data for each repetition
for r = 1:length(NAMESLIST)
    % create dummy variable
    REPETITION{r} = load([FOLDER '\' NAMESLIST{r,1}],'RT','EVENTSPACK','REF','RespValStore','respcode');
    for i = 1:36
        REPETITION{r}.EVENTNUM(i) = length(REPETITION{r}.EVENTSPACK{i});
    end
end

% event matrix
% for r = 1:length(REPETITION)
%     EVENTPACKMAT = cell([ 36 5]);
%     for i = 1:36
%         for j = 1:REPETITION{r}.EVENTNUM(i)
%             EVENTPACKMAT{i,j} = 1:REPETITION{r}.EVENTSPACK{i,j};
%         end
%     end
% end

KeyCode = [80 73 73 80; 73 80 73 80; 80 73 80 73; 73 80 80 73];

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
    
    if strcmp(REPETITION{1,r}.respcode,'BPAIWIEP')
        code(r,:) = KeyCode(1,:);
    elseif strcmp(REPETITION{1,r}.respcode,'BIAPWIEP')
        code(r,:) = KeyCode(2,:);
    elseif strcmp(REPETITION{1,r}.respcode,'BPAIWPEI')
        code(r,:) = KeyCode(3,:);
    elseif strcmp(REPETITION{1,r}.respcode,'BIAPWPEI')
        code(r,:) = KeyCode(4,:);
    end
    
    for i = 1:36 % mini-block (= ref)
        if REPETITION{1,r}.REF(i) == 1
            for j = 1:REPETITION{r}.EVENTNUM(i)
                count = 1;
                while count <= 36
                    if strcmp(REPETITION{1,r}.EVENTSPACK{1,i}{1,j},EVENTS{count}) == 1
                        if isempty(intersect(count,DATES1ind)) == 0 && REPETITION{1,r}.RespValStore(i,j) == code(r,1)
                            DATARef1(count) = 0;
                        elseif isempty(intersect(count,DATES1ind)) == 0 && REPETITION{1,r}.RespValStore(i,j) == code(r,2)
                            DATARef1(count) = 1;
                        elseif isempty(intersect(count,DATES1ind)) == 1 && REPETITION{1,r}.RespValStore(i,j) == code(r,2)
                            DATARef1(count) = 0;
                        elseif isempty(intersect(count,DATES1ind)) == 1 && REPETITION{1,r}.RespValStore(i,j) == code(r,1)
                            DATARef1(count) = 1;
                        end
                    end
                    count = count + 1;
                end
            end
        elseif REPETITION{1,r}.REF(i) == 2
            for j = 1:REPETITION{r}.EVENTNUM(i)
                count = 1;
                while count <= 36
                    if strcmp(REPETITION{1,r}.EVENTSPACK{1,i}{1,j},EVENTS{count}) == 1
                        if isempty(intersect(count,DATES2ind)) == 0 && REPETITION{1,r}.RespValStore(i,j) == code(r,1)
                            DATARef2(count) = 0;
                        elseif isempty(intersect(count,DATES2ind)) == 0 && REPETITION{1,r}.RespValStore(i,j) == code(r,2)
                            DATARef2(count) = 1;
                        elseif isempty(intersect(count,DATES2ind)) == 1 && REPETITION{1,r}.RespValStore(i,j) == code(r,2)
                            DATARef2(count) = 0;
                        elseif isempty(intersect(count,DATES2ind)) == 1 && REPETITION{1,r}.RespValStore(i,j) == code(r,1)
                            DATARef2(count) = 1;
                        end
                    end
                    count = count + 1;
                end
            end
        elseif REPETITION{1,r}.REF(i) == 3
            for j = 1:REPETITION{r}.EVENTNUM(i)
                count = 1;
                while count <= 36
                    if strcmp(REPETITION{1,r}.EVENTSPACK{1,i}{1,j},EVENTS{count}) == 1
                        if isempty(intersect(count,DATES3ind)) == 0 && REPETITION{1,r}.RespValStore(i,j) == code(r,1)
                            DATARef3(count) = 0;
                        elseif isempty(intersect(count,DATES3ind)) == 0 && REPETITION{1,r}.RespValStore(i,j) == code(r,2)
                            DATARef3(count) = 1;
                        elseif isempty(intersect(count,DATES3ind)) == 1 && REPETITION{1,r}.RespValStore(i,j) == code(r,2)
                            DATARef3(count) = 0;
                        elseif isempty(intersect(count,DATES3ind)) == 1 && REPETITION{1,r}.RespValStore(i,j) == code(r,1)
                            DATARef3(count) = 1;
                        end
                    end
                    count = count + 1;
                end
            end            
        elseif REPETITION{1,r}.REF(i) == 4
            for j = 1:REPETITION{r}.EVENTNUM(i)
                count = 1;
                while count <= 36
                    if strcmp(REPETITION{1,r}.EVENTSPACK{1,i}{1,j},EVENTS{count}) == 1
                        if isempty(intersect(count,LONGS1ind)) == 0 && REPETITION{1,r}.RespValStore(i,j) == code(r,3)
                            DATARef4(count) = 0;
                        elseif isempty(intersect(count,LONGS1ind)) == 0 && REPETITION{1,r}.RespValStore(i,j) == code(r,4)
                            DATARef4(count) = 1;
                        elseif isempty(intersect(count,LONGS1ind)) == 1 && REPETITION{1,r}.RespValStore(i,j) == code(r,4)
                            DATARef4(count) = 0;
                        elseif isempty(intersect(count,LONGS1ind)) == 1 && REPETITION{1,r}.RespValStore(i,j) == code(r,3)
                            DATARef4(count) = 1;
                        end
                    end
                    count = count + 1;
                end
            end             
        elseif REPETITION{1,r}.REF(i) == 5
            for j = 1:REPETITION{r}.EVENTNUM(i)
                count = 1;
                while count <= 36
                    if strcmp(REPETITION{1,r}.EVENTSPACK{1,i}{1,j},EVENTS{count}) == 1
                        if isempty(intersect(count,LONGS2ind)) == 0 && REPETITION{1,r}.RespValStore(i,j) == code(r,3)
                            DATARef5(count) = 0;
                        elseif isempty(intersect(count,LONGS2ind)) == 0 && REPETITION{1,r}.RespValStore(i,j) == code(r,4)
                            DATARef5(count) = 1;
                        elseif isempty(intersect(count,LONGS2ind)) == 1 && REPETITION{1,r}.RespValStore(i,j) == code(r,4)
                            DATARef5(count) = 0;
                        elseif isempty(intersect(count,LONGS2ind)) == 1 && REPETITION{1,r}.RespValStore(i,j) == code(r,3)
                            DATARef5(count) = 1;
                        end
                    end
                    count = count + 1;
                end
            end             
        elseif REPETITION{1,r}.REF(i) == 6
            for j = 1:REPETITION{r}.EVENTNUM(i)
                count = 1;
                while count <= 36
                    if strcmp(REPETITION{1,r}.EVENTSPACK{1,i}{1,j},EVENTS{count}) == 1
                        if isempty(intersect(count,LONGS3ind)) == 0 && REPETITION{1,r}.RespValStore(i,j) == code(r,3)
                            DATARef6(count) = 0;
                        elseif isempty(intersect(count,LONGS3ind)) == 0 && REPETITION{1,r}.RespValStore(i,j) == code(r,4)
                            DATARef6(count) = 1;
                        elseif isempty(intersect(count,LONGS3ind)) == 1 && REPETITION{1,r}.RespValStore(i,j) == code(r,4)
                            DATARef6(count) = 0;
                        elseif isempty(intersect(count,LONGS3ind)) == 1 && REPETITION{1,r}.RespValStore(i,j) == code(r,3)
                            DATARef6(count) = 1;
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
    (DATARef1MEAN(31:36))'];
DATARef1MEANsq(5:6,:) = ones(2,6)*NaN;
DATARef2MEANsq = [(DATARef2MEAN(1:6))' ...
    (DATARef2MEAN(7:12))' ...
    (DATARef2MEAN(13:18))' ...
    (DATARef2MEAN(19:24))' ...
    (DATARef2MEAN(25:30))' ...
    (DATARef2MEAN(31:36))'];
DATARef2MEANsq([1 6],:) = ones(2,6)*NaN;
DATARef3MEANsq = [(DATARef3MEAN(1:6))' ...
    (DATARef3MEAN(7:12))' ...
    (DATARef3MEAN(13:18))' ...
    (DATARef3MEAN(19:24))' ...
    (DATARef3MEAN(25:30))' ...
    (DATARef3MEAN(31:36))'];
DATARef3MEANsq([1 2],:) = ones(2,6)*NaN;
DATARef4MEANsq = [(DATARef4MEAN(1:6))' ...
    (DATARef4MEAN(7:12))' ...
    (DATARef4MEAN(13:18))' ...
    (DATARef4MEAN(19:24))' ...
    (DATARef4MEAN(25:30))' ...
    (DATARef4MEAN(31:36))'];
DATARef4MEANsq(:,5:6) = ones(6,2)*NaN;
DATARef5MEANsq = [(DATARef5MEAN(1:6))' ...
    (DATARef5MEAN(7:12))' ...
    (DATARef5MEAN(13:18))' ...
    (DATARef5MEAN(19:24))' ...
    (DATARef5MEAN(25:30))' ...
    (DATARef5MEAN(31:36))'];
DATARef5MEANsq(:,[1 6]) = ones(6,2)*NaN;
DATARef6MEANsq = [(DATARef6MEAN(1:6))' ...
    (DATARef6MEAN(7:12))' ...
    (DATARef6MEAN(13:18))' ...
    (DATARef6MEAN(19:24))' ...
    (DATARef6MEAN(25:30))' ...
    (DATARef6MEAN(31:36))'];
DATARef6MEANsq(:,[1 2]) = ones(6,2)*NaN;

DATARef1STDsq = [(DATARef1STD(1:6))' ...
    (DATARef1STD(7:12))' ...
    (DATARef1STD(13:18))' ...
    (DATARef1STD(19:24))' ...
    (DATARef1STD(25:30))' ...
    (DATARef1STD(31:36))'];
DATARef1STDsq(5:6,:) = ones(2,6)*NaN;
DATARef2STDsq = [(DATARef2STD(1:6))' ...
    (DATARef2STD(7:12))' ...
    (DATARef2STD(13:18))' ...
    (DATARef2STD(19:24))' ...
    (DATARef2STD(25:30))' ...
    (DATARef2STD(31:36))'];
DATARef2STDsq([1 6],:) = ones(2,6)*NaN;
DATARef3STDsq = [(DATARef3STD(1:6))' ...
    (DATARef3STD(7:12))' ...
    (DATARef3STD(13:18))' ...
    (DATARef3STD(19:24))' ...
    (DATARef3STD(25:30))' ...
    (DATARef3STD(31:36))'];
DATARef3STDsq([1 2],:) = ones(2,6)*NaN;
DATARef4STDsq = [(DATARef4STD(1:6))' ...
    (DATARef4STD(7:12))' ...
    (DATARef4STD(13:18))' ...
    (DATARef4STD(19:24))' ...
    (DATARef4STD(25:30))' ...
    (DATARef4STD(31:36))'];
DATARef4STDsq(:,5:6) = ones(6,2)*NaN;
DATARef5STDsq = [(DATARef5STD(1:6))' ...
    (DATARef5STD(7:12))' ...
    (DATARef5STD(13:18))' ...
    (DATARef5STD(19:24))' ...
    (DATARef5STD(25:30))' ...
    (DATARef5STD(31:36))'];
DATARef5STDsq(:,[1 6]) = ones(6,2)*NaN;
DATARef6STDsq = [(DATARef6STD(1:6))' ...
    (DATARef6STD(7:12))' ...
    (DATARef6STD(13:18))' ...
    (DATARef6STD(19:24))' ...
    (DATARef6STD(25:30))' ...
    (DATARef6STD(31:36))'];
DATARef6STDsq(:,[1 2]) = ones(6,2)*NaN;

fig1 = figure('position',[1 1 800 500]);
set(fig1,'PaperPosition',[1 1 800 500])
set(fig1,'PaperPositionmode','auto')
subplot(2,3,1); imagesc(DATARef1MEANsq,[0 1]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');
subplot(2,3,2); imagesc(DATARef2MEANsq,[0 1]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');
subplot(2,3,3); imagesc(DATARef3MEANsq,[0 1]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');
subplot(2,3,4); imagesc(DATARef4MEANsq,[0 1]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');
subplot(2,3,5); imagesc(DATARef5MEANsq,[0 1]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');
subplot(2,3,6); imagesc(DATARef6MEANsq,[0 1]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');
    
print('-dpng',['C:\MTT_MEG\results\FULL_ER_MT_MEG_PSYCHO_' NIP])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 800 500]);
set(fig1,'PaperPosition',[1 1 800 500])
set(fig1,'PaperPositionmode','auto')

subplot(2,3,1)
bar(1:6,nanmean(DATARef1MEANsq'),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(DATARef1MEANsq'),nanstd(DATARef1MEANsq')./sqrt(length(REPETITION)),'linestyle','none','color','k')
axis([0 7 0 0.5])
subplot(2,3,2)
bar(1:6,nanmean(DATARef2MEANsq'),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(DATARef2MEANsq'),nanstd(DATARef2MEANsq')./sqrt(length(REPETITION)),'linestyle','none','color','k')
axis([0 7 0 0.5])
subplot(2,3,3)
bar(1:6,nanmean(DATARef3MEANsq'),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(DATARef3MEANsq'),nanstd(DATARef3MEANsq')./sqrt(length(REPETITION)),'linestyle','none','color','k')
axis([0 7 0 0.5])
subplot(2,3,4)
bar(1:6,nanmean(DATARef4MEANsq),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(DATARef4MEANsq),nanstd(DATARef4MEANsq)./sqrt(length(REPETITION)),'linestyle','none','color','k')
axis([0 7 0 0.5])
subplot(2,3,5)
bar(1:6,nanmean(DATARef5MEANsq),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(DATARef5MEANsq),nanstd(DATARef5MEANsq)./sqrt(length(REPETITION)),'linestyle','none','color','k')
axis([0 7 0 0.5])
subplot(2,3,6)
bar(1:6,nanmean(DATARef6MEANsq),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(DATARef6MEANsq),nanstd(DATARef6MEANsq)./sqrt(length(REPETITION)),'linestyle','none','color','k')
axis([0 7 0 0.5])

print('-dpng',['C:\MTT_MEG\results\MEAN_ER_MT_MEG_PSYCHO_' NIP])

DATARef = {DATARef1FULL,DATARef2FULL,DATARef3FULL,DATARef4FULL,DATARef5FULL,DATARef6FULL};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 800 800]);
set(fig1,'PaperPosition',[1 1 800 800])
set(fig1,'PaperPositionmode','auto')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PAST %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (DATE(:)-ones(36,1)*(2004));
AbsXaxis = abs((DATE(:)-ones(36,1)*(2004))); Yaxis = DATARef1MEANsq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis DATARef1STDsq(:)]);
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
errorbar(Xaxis', DATARef1MEANsq(:)', DATARef1STDsq(:)'./sqrt(length(REPETITION)),'linestyle','none','marker','.','markersize',20); hold on;
line([0 0],[0 1],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-20:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:20,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-15,0.45,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(5,0.45,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-18 18 0 1]); ylabel('Error Rate');xlabel('Temporal distance(y)');

subplot(3,3,3)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(length(REPETITION)),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:20,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:20,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(5,0.42,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(5,0.45,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 18 0 1]); ylabel('Error Rate');xlabel('|Temporal distance| (y)');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PRESENT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (DATE(:)-ones(36,1)*(2013));
AbsXaxis = abs((DATE(:)-ones(36,1)*(2013))); Yaxis = DATARef2MEANsq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis DATARef2STDsq(:)]);
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
errorbar(Xaxis', DATARef2MEANsq(:)', DATARef2STDsq(:)'./sqrt(length(REPETITION)),'linestyle','none','marker','.','markersize',20); hold on;
line([0 0],[0 1],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-20:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:20,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-15,0.45,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(5,0.45,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-18 18 0 1]); ylabel('Error Rate');xlabel('Temporal distance(y)');

subplot(3,3,6)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(length(REPETITION)),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:20,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:20,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(5,0.42,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(5,0.45,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 18 0 1]); ylabel('Error Rate');xlabel('|Temporal distance| (y)');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FUTURE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (DATE(:)-ones(36,1)*(2022));
AbsXaxis = abs((DATE(:)-ones(36,1)*(2022))); Yaxis = DATARef3MEANsq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis DATARef3STDsq(:)]);
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
errorbar(Xaxis', DATARef3MEANsq(:)', DATARef3STDsq(:)'./sqrt(length(REPETITION)),'linestyle','none','marker','.','markersize',20); hold on;
line([0 0],[0 1],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-20:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:20,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-17,0.45,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(1,0.45,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-18 18 0 1]); ylabel('Error Rate');xlabel('Temporal distance(y)');

subplot(3,3,9)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(length(REPETITION)),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:20,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:20,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(1,0.42,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(1,0.45,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 18 0 1]); ylabel('Error Rate');xlabel('|Temporal distance| (y)');

print('-dpng',['C:\MTT_MEG\results\REGRESS_TIME_ER_MT_MEG_PSYCHO_' NIP])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 800 800]);
set(fig1,'PaperPosition',[1 1 800 800])
set(fig1,'PaperPositionmode','auto')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% WEST %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (LONG(:)-ones(36,1)*(-52.3));
AbsXaxis = abs((LONG(:)-ones(36,1)*(-52.3))); Yaxis = DATARef4MEANsq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis DATARef4STDsq(:)]);
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
errorbar(Xaxis', DATARef4MEANsq(:)', DATARef4STDsq(:)'./sqrt(length(REPETITION)),'linestyle','none','marker','.','markersize',20); hold on;
line([0 0],[0 1],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-160:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:160,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-155,0.45,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(5,0.45,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-160 160 0 1]); ylabel('Error Rate');xlabel('Spatial distance(°)');

subplot(3,3,3)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(length(REPETITION)),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:160,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:160,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(5,0.42,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(5,0.45,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 160 0 1]); ylabel('Error Rate');xlabel('|Spatial distance| (°)');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PARIS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (LONG(:)-ones(36,1)*(2.3));
AbsXaxis = abs((LONG(:)-ones(36,1)*(2.3))); Yaxis = DATARef5MEANsq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis DATARef5STDsq(:)]);
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
errorbar(Xaxis', DATARef5MEANsq(:)', DATARef5STDsq(:)'./sqrt(length(REPETITION)),'linestyle','none','marker','.','markersize',20); hold on;
line([0 0],[0 1],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-160:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:160,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-155,4.5,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(5,4.5,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-160 160 0 1]); ylabel('Reaction time (s)');xlabel('Spatial distance| (°)');

subplot(3,3,6)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(length(REPETITION)),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:160,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:160,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(5,0.42,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(5,0.45,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 160 0 1]); ylabel('Error Rate');xlabel('|Spatial distance| (°)');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FUTURE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (LONG(:)-ones(36,1)*(55.3));
AbsXaxis = abs((LONG(:)-ones(36,1)*(55.3))); Yaxis = DATARef6MEANsq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis DATARef6STDsq(:)]);
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
P1 = polyfit(tmpB(:,1),tmpB(:,2),1);            Y1 = polyval(P1,-160:0.1:-0.1);
P2 = polyfit(tmpA(:,1),tmpA(:,2),1);            Y2 = polyval(P2,0.1:0.1:160);
P3 = polyfit(NormTmp(:,1),NormTmp(:,2),1);      Y3 = polyval(P3,0.1:0.1:160);
P4 = polyfit(log(NormTmp(:,1)),NormTmp(:,2),1); Y4 = polyval(P4,log(0.1:0.1:160));

subplot(3,3,[7 8])
errorbar(Xaxis', DATARef6MEANsq(:)', DATARef6STDsq(:)'./sqrt(length(REPETITION)),'linestyle','none','marker','.','markersize',20); hold on;
line([0 0],[0 1],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-160:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:160,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-155,4.5,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(1,4.5,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-160 160 0 1]); ylabel('Error Rate');xlabel('Spatial distance| (°)');

subplot(3,3,9)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(length(REPETITION)),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:160,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:160,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(1,0.42,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(1,0.45,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 160 0 1]); ylabel('Error Rate');xlabel('|Spatial distance| (°)');

print('-dpng',['C:\MTT_MEG\results\REGRESS_SPACE_ER_MT_MEG_PSYCHO_' NIP])





