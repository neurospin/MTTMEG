% MTT_MEG_ANALYSIS

load('C:\MTT_MEG\psych\test\test5run_1_left_MentalTravelMeg.mat')

% load events description to get conditions structure
File_Events = ['C:\Users\bgauthie\Desktop\ONGOING_PROJECTS\MENTAL_TIME_TRAVEL\STIM\EVENTS\EVENTS_Psycho\EVENTS_PSYCHO_FINAL.xlsx'];
[NUM,EVENTS] = xlsread(File_Events);
EVENTSind = [(1:6)' (7:12)' (13:18)' (19:24)' (25:30)' (31:36)'];

[DATES,TXT] = xlsread('C:\Users\bgauthie\Desktop\ONGOING_PROJECTS\MENTAL_TIME_TRAVEL\STIM\EVENTS\EVENTS_Psycho\EVENTS_DATES_v3.xlsx');
[LONGS,TXT]  = xlsread('C:\Users\bgauthie\Desktop\ONGOING_PROJECTS\MENTAL_TIME_TRAVEL\STIM\EVENTS\EVENTS_Psycho\EVENTS_LONG_v2.xlsx');

DATES1 = DATES(1:4,:); DATES1ind = [1:4;7:10;13:16;19:22;25:28;31:34];
DATES2 = DATES(2:5,:); DATES2ind = [2:5;8:11;14:17;20:23;26:29;32:35];
DATES3 = DATES(3:6,:); DATES3ind = [3:6;9:12;15:18;21:24;27:30;33:36];

D1 = sortrows([DATES1(:) DATES1ind(:)]);
D2 = sortrows([DATES2(:) DATES2ind(:)]);
D3 = sortrows([DATES3(:) DATES3ind(:)]);

LONGS1 = LONGS(:,1:4); LONGS1ind = [1:6;7:12;13:18;19:24];
LONGS2 = LONGS(:,2:5); LONGS2ind = [7:12;13:18;19:24;25:30];
LONGS3 = LONGS(:,3:6); LONGS3ind = [13:18;19:24;25:30;31:36];

L1 = sortrows([LONGS1(:) LONGS1ind(:)]);
L2 = sortrows([LONGS2(:) LONGS2ind(:)]);
L3 = sortrows([LONGS3(:) LONGS3ind(:)]);

%%
for i = 1:6
    x = []; y = [];
    [x,y] = find(REF == i);
    for j = y
        for k = 1:4
            count = 1;
            for l = 1:36
                if strcmp(EVENTSPACK{j}(k),EVENTS(l))
                    DATART(i,l) = RT(j,k);
                end
            end
        end
    end
end

subplot(2,3,1);bar([1990 2000 2010 2020],[mean(DATART(1,D1(1:6,2))) mean(DATART(1,D1(7:12,2))) ...
mean(DATART(1,D1(13:18,2))) mean(DATART(1,D1(19:24,2)))],'facecolor',[0.8 0.8 0.8])
hold on; plot(D1(:,1),DATART(1,D1(:,2)),'linestyle','none','marker','o','linewidth',2);title('Past-Paris');
axis([1985 2025 0 4.5]);hold on; line([2004 2004],[0 4.5],'linestyle','--','linewidth',2);xlabel('TD');ylabel('RT');

subplot(2,3,2);bar([1999 2009 2019 2029],[mean(DATART(2,D2(1:6,2))) mean(DATART(2,D2(7:12,2))) ...
mean(DATART(2,D2(13:18,2))) mean(DATART(2,D2(19:24,2)))],'facecolor',[0.8 0.8 0.8])
hold on; plot(D2(:,1),DATART(2,D2(:,2)),'linestyle','none','marker','o','linewidth',2);title('Present-Paris');
axis([1994 2035 0 4.5]);hold on; line([2013 2013],[0 4.5],'linestyle','--','linewidth',2);xlabel('TD');ylabel('RT');

subplot(2,3,3);bar([2008 2018 2028 2038],[mean(DATART(3,D3(1:6,2))) mean(DATART(3,D3(7:12,2))) ...
mean(DATART(3,D3(13:18,2))) mean(DATART(3,D3(19:24,2)))],'facecolor',[0.8 0.8 0.8])
hold on; plot(D3(:,1),DATART(3,D3(:,2)),'linestyle','none','marker','o','linewidth',2);title('Future-Paris');
axis([2005 2045 0 4.5]);hold on; line([2022 2022],[0 4.5],'linestyle','--','linewidth',2);xlabel('TD');ylabel('RT');

subplot(2,3,4);bar([-125 -75 -25 25],[mean(DATART(4,L1(1:6,2))) mean(DATART(4,L1(7:12,2))) ...
mean(DATART(4,L1(13:18,2))) mean(DATART(4,L1(19:24,2)))],'facecolor',[0.8 0.8 0.8])
hold on; plot(L1(:,1),DATART(4,L1(:,2)),'linestyle','none','marker','o','linewidth',2);title('Present-Cayenne');
axis([-160 55 0 4.5]);hold on; line([-55 -55],[0 4.5],'linestyle','--','linewidth',2);xlabel('SD');ylabel('RT');

subplot(2,3,5);bar([-80 -30 20 70],[mean(DATART(5,L2(1:6,2))) mean(DATART(5,L2(7:12,2))) ...
mean(DATART(5,L2(13:18,2))) mean(DATART(5,L2(19:24,2)))],'facecolor',[0.8 0.8 0.8])
hold on; plot(L2(:,1),DATART(5,L2(:,2)),'linestyle','none','marker','o','linewidth',2);title('Present-Paris');
axis([-105 105 0 4.5]);hold on; line([2.3 2.3],[0 4.5],'linestyle','--','linewidth',2);xlabel('SD');ylabel('RT');

subplot(2,3,6);bar([-30 20 70 120],[mean(DATART(6,L3(1:6,2))) mean(DATART(6,L3(7:12,2))) ...
mean(DATART(6,L3(13:18,2))) mean(DATART(6,L3(19:24,2)))],'facecolor',[0.8 0.8 0.8])
hold on; plot(L3(:,1),DATART(6,L3(:,2)),'linestyle','none','marker','o','linewidth',2);title('Present-Dubaï');
axis([-50 160 0 4.5]);hold on; line([55 55],[0 4.5],'linestyle','--','linewidth',2);xlabel('SD');ylabel('RT');
