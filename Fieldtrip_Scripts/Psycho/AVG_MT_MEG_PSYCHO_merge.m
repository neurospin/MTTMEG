% AVG view logplots

clear all
close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% load events description to get conditions structure
File_Events = ['C:\Users\bgauthie\Desktop\ONGOING_PROJECTS\MENTAL_TIME_TRAVEL\STIM\EVENTS\EVENTS_Psycho\EVENT_IMAGING.xlsx'];
[NUM,EVENTS] = xlsread(File_Events);

File_Events = ['C:\Users\bgauthie\Desktop\ONGOING_PROJECTS\MENTAL_TIME_TRAVEL\STIM\EVENTS\EVENTS_Psycho\DATE_IMAGING.xlsx'];
[DATE,TXT] = xlsread(File_Events);

File_Events = ['C:\Users\bgauthie\Desktop\ONGOING_PROJECTS\MENTAL_TIME_TRAVEL\STIM\EVENTS\EVENTS_Psycho\LONG_IMAGING.xlsx'];
[LONG,TXT] = xlsread(File_Events);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load('C:\MTT_MEG\results\PSYCH_RT.mat')
load('C:\MTT_MEG\results\PSYCH_RT_2.mat')

REF1(1,:)  = nanmean(DATARef_PB130006{1,1},1);
REF1(2,:)  = nanmean(DATARef_df130078{1,1},1);
REF1(3,:)  = nanmean(DATARef_el130325{1,1},1);
REF1(4,:)  = nanmean(DATARef_jn120580{1,1},1);
REF1(5,:)  = nanmean(DATARef_sb130326{1,1},1);
REF1(6,:)  = nanmean(DATARef_ad120287{1,1},1);
REF1(7,:)  = nanmean(DATARef_am090241{1,1},1);
REF1(8,:)  = nanmean(DATARef_cv120216{1,1},1);
REF1(9,:)  = nanmean(DATARef_gd130362{1,1},1);
REF1(10,:) = nanmean(DATARef_rg130377{1,1},1);
REF1mean   = nanmean(REF1);
REF1std    = nanstd(REF1);

REF2(1,:) = nanmean(DATARef_PB130006{1,2},1);
REF2(2,:) = nanmean(DATARef_df130078{1,2},1);
REF2(3,:) = nanmean(DATARef_el130325{1,2},1);
REF2(4,:) = nanmean(DATARef_jn120580{1,2},1);
REF2(5,:) = nanmean(DATARef_sb130326{1,2},1);
REF2(6,:)  = nanmean(DATARef_ad120287{1,2},1);
REF2(7,:)  = nanmean(DATARef_am090241{1,2},1);
REF2(8,:)  = nanmean(DATARef_cv120216{1,2},1);
REF2(9,:)  = nanmean(DATARef_gd130362{1,2},1);
REF2(10,:) = nanmean(DATARef_rg130377{1,2},1);
REF2mean  = nanmean(REF2);
REF2std   = nanstd(REF2);

REF3(1,:) = nanmean(DATARef_PB130006{1,3},1);
REF3(2,:) = nanmean(DATARef_df130078{1,3},1);
REF3(3,:) = nanmean(DATARef_el130325{1,3},1);
REF3(4,:) = nanmean(DATARef_jn120580{1,3},1);
REF3(5,:) = nanmean(DATARef_sb130326{1,3},1);
REF3(6,:)  = nanmean(DATARef_ad120287{1,3},1);
REF3(7,:)  = nanmean(DATARef_am090241{1,3},1);
REF3(8,:)  = nanmean(DATARef_cv120216{1,3},1);
REF3(9,:)  = nanmean(DATARef_gd130362{1,3},1);
REF3(10,:) = nanmean(DATARef_rg130377{1,3},1);
REF3mean  = nanmean(REF3);
REF3std   = nanstd(REF3);

REF4(1,:) = nanmean(DATARef_PB130006{1,4},1);
REF4(2,:) = nanmean(DATARef_df130078{1,4},1);
REF4(3,:) = nanmean(DATARef_el130325{1,4},1);
REF4(4,:) = nanmean(DATARef_jn120580{1,4},1);
REF4(5,:) = nanmean(DATARef_sb130326{1,4},1);
REF4(6,:)  = nanmean(DATARef_ad120287{1,4},1);
REF4(7,:)  = nanmean(DATARef_am090241{1,4},1);
REF4(8,:)  = nanmean(DATARef_cv120216{1,4},1);
REF4(9,:)  = nanmean(DATARef_gd130362{1,4},1);
REF4(10,:) = nanmean(DATARef_rg130377{1,4},1);
REF4mean  = nanmean(REF4);
REF4std   = nanstd(REF4);

REF5(1,:) = nanmean(DATARef_PB130006{1,5},1);
REF5(2,:) = nanmean(DATARef_df130078{1,5},1);
REF5(3,:) = nanmean(DATARef_el130325{1,5},1);
REF5(4,:) = nanmean(DATARef_jn120580{1,5},1);
REF5(5,:) = nanmean(DATARef_sb130326{1,5},1);
REF5(6,:)  = nanmean(DATARef_ad120287{1,5},1);
REF5(7,:)  = nanmean(DATARef_am090241{1,5},1);
REF5(8,:)  = nanmean(DATARef_cv120216{1,5},1);
REF5(9,:)  = nanmean(DATARef_gd130362{1,5},1);
REF5(10,:) = nanmean(DATARef_rg130377{1,5},1);
REF5mean  = nanmean(REF5);
REF5std   = nanstd(REF5);

REF6(1,:) = nanmean(DATARef_PB130006{1,6},1);
REF6(2,:) = nanmean(DATARef_df130078{1,6},1);
REF6(3,:) = nanmean(DATARef_el130325{1,6},1);
REF6(4,:) = nanmean(DATARef_jn120580{1,6},1);
REF6(5,:) = nanmean(DATARef_sb130326{1,6},1);
REF6(6,:)  = nanmean(DATARef_ad120287{1,6},1);
REF6(7,:)  = nanmean(DATARef_am090241{1,6},1);
REF6(8,:)  = nanmean(DATARef_cv120216{1,6},1);
REF6(9,:)  = nanmean(DATARef_gd130362{1,6},1);
REF6(10,:) = nanmean(DATARef_rg130377{1,6},1);
REF6mean  = nanmean(REF6);
REF6std   = nanstd(REF6);

REF1meansq = [(REF1mean(1:6))' (REF1mean(7:12))' (REF1mean(13:18))' ...
              (REF1mean(19:24))' (REF1mean(25:30))' (REF1mean(31:36))'];
REF2meansq = [(REF2mean(1:6))' (REF2mean(7:12))' (REF2mean(13:18))' ...
              (REF2mean(19:24))' (REF2mean(25:30))' (REF2mean(31:36))'];
REF3meansq = [(REF3mean(1:6))' (REF3mean(7:12))' (REF3mean(13:18))' ...
              (REF3mean(19:24))' (REF3mean(25:30))' (REF3mean(31:36))'];
REF4meansq = [(REF4mean(1:6))' (REF4mean(7:12))' (REF4mean(13:18))' ...
              (REF4mean(19:24))' (REF4mean(25:30))' (REF4mean(31:36))'];
REF5meansq = [(REF5mean(1:6))' (REF5mean(7:12))' (REF5mean(13:18))' ...
              (REF5mean(19:24))' (REF5mean(25:30))' (REF5mean(31:36))'];
REF6meansq = [(REF6mean(1:6))' (REF6mean(7:12))' (REF6mean(13:18))' ...
              (REF6mean(19:24))' (REF6mean(25:30))' (REF6mean(31:36))'];
          
REF1stdsq  = [(REF1std(1:6))' (REF1std(7:12))' (REF1std(13:18))' ...
              (REF1std(19:24))' (REF1std(25:30))' (REF1std(31:36))'];
REF2stdsq  = [(REF2std(1:6))' (REF2std(7:12))' (REF2std(13:18))' ...
              (REF2std(19:24))' (REF2std(25:30))' (REF2std(31:36))'];
REF3stdsq  = [(REF3std(1:6))' (REF3std(7:12))' (REF3std(13:18))' ...
              (REF3std(19:24))' (REF3std(25:30))' (REF3std(31:36))'];
REF4stdsq  = [(REF4std(1:6))' (REF4std(7:12))' (REF4std(13:18))' ...
              (REF4std(19:24))' (REF4std(25:30))' (REF4std(31:36))'];
REF5stdsq  = [(REF5std(1:6))' (REF5std(7:12))' (REF5std(13:18))' ...
              (REF5std(19:24))' (REF5std(25:30))' (REF5std(31:36))'];
REF6stdsq  = [(REF6std(1:6))' (REF6std(7:12))' (REF6std(13:18))' ...
              (REF6std(19:24))' (REF6std(25:30))' (REF6std(31:36))'];   

REF1stdsq(5:6,:)   = ones(2,6)*NaN;
REF2stdsq([1 6],:) = ones(2,6)*NaN;
REF3stdsq([1 2],:) = ones(2,6)*NaN;
REF4stdsq(:,5:6)   = ones(6,2)*NaN;
REF5stdsq(:,[1 6]) = ones(6,2)*NaN;
REF6stdsq(:,[1 2]) = ones(6,2)*NaN; 
REF1meansq(5:6,:)   = ones(2,6)*NaN; 
REF2meansq([1 6],:) = ones(2,6)*NaN;
REF3meansq([1 2],:) = ones(2,6)*NaN;
REF4meansq(:,5:6)   = ones(6,2)*NaN;
REF5meansq(:,[1 6]) = ones(6,2)*NaN;
REF6meansq(:,[1 2]) = ones(6,2)*NaN;          
          
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 800 500]);
set(fig1,'PaperPosition',[1 1 800 500])
set(fig1,'PaperPositionmode','auto')

subplot(2,3,1)
bar(1:6,nanmean(REF1meansq'),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(REF1meansq'),nanstd(REF1meansq')./sqrt(size(REF1,1)),'linestyle','none','color','k')
subplot(2,3,2)
bar(1:6,nanmean(REF2meansq'),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(REF2meansq'),nanstd(REF2meansq')./sqrt(size(REF2,1)),'linestyle','none','color','k')
subplot(2,3,3)
bar(1:6,nanmean(REF3meansq'),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(REF3meansq'),nanstd(REF3meansq')./sqrt(size(REF3,1)),'linestyle','none','color','k')
subplot(2,3,4)
bar(1:6,nanmean(REF4meansq),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(REF4meansq),nanstd(REF4meansq)./sqrt(size(REF4,1)),'linestyle','none','color','k')
subplot(2,3,5)
bar(1:6,nanmean(REF5meansq),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(REF5meansq),nanstd(REF5meansq)./sqrt(size(REF5,1)),'linestyle','none','color','k')
subplot(2,3,6)
bar(1:6,nanmean(REF6meansq),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(REF6meansq),nanstd(REF6meansq)./sqrt(size(REF6,1)),'linestyle','none','color','k')

print('-dpng',['C:\MTT_MEG\results\AVG_MEAN_RT_MT_MEG_PSYCHO_merge'])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 800 800]);
set(fig1,'PaperPosition',[1 1 800 800])
set(fig1,'PaperPositionmode','auto')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PAST %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (DATE(:)-ones(36,1)*(2004));
AbsXaxis = abs((DATE(:)-ones(36,1)*(2004))); Yaxis = REF1meansq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis REF1stdsq(:)]);
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
P1 = polyfit(tmpB(:,1),tmpB(:,2),1);            Y1 = polyval(P1,-30:0.1:-0.1);
P2 = polyfit(tmpA(:,1),tmpA(:,2),1);            Y2 = polyval(P2,0.1:0.1:30);
P3 = polyfit(NormTmp(:,1),NormTmp(:,2),1);      Y3 = polyval(P3,0.1:0.1:30);
P4 = polyfit(log(NormTmp(:,1)),NormTmp(:,2),1); Y4 = polyval(P4,log(0.1:0.1:30));

subplot(3,3,[1 2])
errorbar(Xaxis', REF1meansq(:)', REF1stdsq(:)'./sqrt(size(REF1,1)),'linestyle','none','marker','.','markersize',20); hold on;
line([0 0],[0 3],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-30:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:30,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-15,2.8,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(5,2.8,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-30 30 0 3]); ylabel('Reaction time (s)');xlabel('Temporal distance(y)');

subplot(3,3,3)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(size(REF1,1)),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:30,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:30,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(5,2.5,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(5,2.8,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 30 0 3]); ylabel('Reaction time (s)');xlabel('|Temporal distance| (y)');

coef3(1) = P3(1);
coef4(1) = P4(1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PRESENT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (DATE(:)-ones(36,1)*(2013));
AbsXaxis = abs((DATE(:)-ones(36,1)*(2013))); Yaxis = REF2meansq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis REF2stdsq(:)]);
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
P1 = polyfit(tmpB(:,1),tmpB(:,2),1);            Y1 = polyval(P1,-30:0.1:-0.1);
P2 = polyfit(tmpA(:,1),tmpA(:,2),1);            Y2 = polyval(P2,0.1:0.1:30);
P3 = polyfit(NormTmp(:,1),NormTmp(:,2),1);      Y3 = polyval(P3,0.1:0.1:30);
P4 = polyfit(log(NormTmp(:,1)),NormTmp(:,2),1); Y4 = polyval(P4,log(0.1:0.1:30));

subplot(3,3,[4 5])
errorbar(Xaxis', REF2meansq(:)', REF2stdsq(:)'./sqrt(size(REF2,1)),'linestyle','none','marker','.','markersize',20); hold on;
line([0 0],[0 3],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-30:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:30,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-15,2.8,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(5,2.8,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-30 30 0 3]); ylabel('Reaction time (s)');xlabel('Temporal distance(y)');

subplot(3,3,6)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(size(REF2,1)),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:30,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:30,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(5,2.5,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(5,2.8,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 30 0 3]); ylabel('Reaction time (s)');xlabel('|Temporal distance| (y)');

coef3(2) = P3(1);
coef4(2) = P4(1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FUTURE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (DATE(:)-ones(36,1)*(2022));
AbsXaxis = abs((DATE(:)-ones(36,1)*(2022))); Yaxis = REF3meansq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis REF3stdsq(:)]);
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
P1 = polyfit(tmpB(:,1),tmpB(:,2),1);            Y1 = polyval(P1,-30:0.1:-0.1);
P2 = polyfit(tmpA(:,1),tmpA(:,2),1);            Y2 = polyval(P2,0.1:0.1:30);
P3 = polyfit(NormTmp(:,1),NormTmp(:,2),1);      Y3 = polyval(P3,0.1:0.1:30);
P4 = polyfit(log(NormTmp(:,1)),NormTmp(:,2),1); Y4 = polyval(P4,log(0.1:0.1:30));

subplot(3,3,[7 8])
errorbar(Xaxis', REF3meansq(:)', REF3stdsq(:)'./sqrt(size(REF3,1)),'linestyle','none','marker','.','markersize',20); hold on;
line([0 0],[0 3],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-30:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:30,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-17,2.8,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(1,2.8,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-30 30 0 3]); ylabel('Reaction time (s)');xlabel('Temporal distance(y)');

subplot(3,3,9)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(size(REF3,1)),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:30,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:30,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(1,2.5,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(1,2.8,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 30 0 3]); ylabel('Reaction time (s)');xlabel('|Temporal distance| (y)');

print('-dpng','C:\MTT_MEG\results\AVG_REGRESS_TIME_RT_MT_MEG_PSYCHO_merge')

coef3(3) = P3(1);
coef4(3) = P4(1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 800 800]);
set(fig1,'PaperPosition',[1 1 800 800])
set(fig1,'PaperPositionmode','auto')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% WEST %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (LONG(:)-ones(36,1)*(-52.3));
AbsXaxis = abs((LONG(:)-ones(36,1)*(-52.3))); Yaxis = REF4meansq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis REF4stdsq(:)]);
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
errorbar(Xaxis', REF4meansq(:)', REF4stdsq(:)'./sqrt(size(REF4,1)),'linestyle','none','marker','.','markersize',20); hold on;
line([0 0],[0 3],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-160:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:160,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-155,2.8,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(5,2.8,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-160 160 0 3]); ylabel('Reaction time (s)');xlabel('|Spatial distance| (°)');

subplot(3,3,3)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(size(REF4,1)),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:160,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:160,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(5,2.5,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(5,2.8,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 160 0 3]); ylabel('Reaction time (s)');xlabel('|Spatial distance| (°)');

coef3(4) = P3(1);
coef4(4) = P4(1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PARIS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (LONG(:)-ones(36,1)*(2.3));
AbsXaxis = abs((LONG(:)-ones(36,1)*(2.3))); Yaxis = REF5meansq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis REF5stdsq(:)]);
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
errorbar(Xaxis', REF5meansq(:)', REF5stdsq(:)'./sqrt(size(REF5,1)),'linestyle','none','marker','.','markersize',20); hold on;
line([0 0],[0 3],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-160:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:160,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-155,2.8,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(5,2.8,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-160 160 0 3]); ylabel('Reaction time (s)');xlabel('|Spatial distance| (°)');

subplot(3,3,6)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(size(REF5,1)),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:160,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:160,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(5,2.5,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(5,2.8,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 160 0 3]); ylabel('Reaction time (s)');xlabel('|Spatial distance| (°)');

coef3(5) = P3(1);
coef4(5) = P4(1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FUTURE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (LONG(:)-ones(36,1)*(55.3));
AbsXaxis = abs((LONG(:)-ones(36,1)*(55.3))); Yaxis = REF6meansq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis REF6stdsq(:)]);
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
errorbar(Xaxis', REF6meansq(:)', REF6stdsq(:)'./sqrt(size(REF6,1)),'linestyle','none','marker','.','markersize',20); hold on;
line([0 0],[0 3],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-160:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:160,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-155,2.8,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(1,2.8,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-160 160 0 3]); ylabel('Reaction time (s)');xlabel('|Spatial distance| (°)');

subplot(3,3,9)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(size(REF6,1)),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:160,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:160,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(1,2.5,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(1,2.8,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 160 0 3]); ylabel('Reaction time (s)');xlabel('|Spatial distance| (°)');

print('-dpng',['C:\MTT_MEG\results\AVG_REGRESS_SPACE_RT_MT_MEG_PSYCHO_merge'])

coef3(6) = P3(1);
coef4(6) = P4(1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% load events description to get conditions structure
File_Events = ['C:\Users\bgauthie\Desktop\ONGOING_PROJECTS\MENTAL_TIME_TRAVEL\STIM\EVENTS\EVENTS_Psycho\EVENT_IMAGING.xlsx'];
[NUM,EVENTS] = xlsread(File_Events);

File_Events = ['C:\Users\bgauthie\Desktop\ONGOING_PROJECTS\MENTAL_TIME_TRAVEL\STIM\EVENTS\EVENTS_Psycho\DATE_IMAGING.xlsx'];
[DATE,TXT] = xlsread(File_Events);

File_Events = ['C:\Users\bgauthie\Desktop\ONGOING_PROJECTS\MENTAL_TIME_TRAVEL\STIM\EVENTS\EVENTS_Psycho\LONG_IMAGING.xlsx'];
[LONG,TXT] = xlsread(File_Events);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load('C:\MTT_MEG\results\PSYCH_ERR.mat')
load('C:\MTT_MEG\results\PSYCH_ERR_2.mat')

REF1(1,:)  = nanmean(DATARef_PB130006{1,1},3);
REF1(2,:)  = nanmean(DATARef_df130078{1,1},3);
REF1(3,:)  = nanmean(DATARef_el130325{1,1},3);
REF1(4,:)  = nanmean(DATARef_jn120580{1,1},3);
REF1(5,:)  = nanmean(DATARef_sb130326{1,1},3);
REF1(6,:)  = nanmean(DATARef_ad120287{1,1},3);
REF1(7,:)  = nanmean(DATARef_am090241{1,1},3);
REF1(8,:)  = nanmean(DATARef_cv120216{1,1},3);
REF1(9,:)  = nanmean(DATARef_gd130362{1,1},3);
REF1(10,:) = nanmean(DATARef_rg130377{1,1},3);
REF1mean   = nanmean(REF1);
REF1std    = nanstd(REF1);

REF2(1,:) = nanmean(DATARef_PB130006{1,2},3);
REF2(2,:) = nanmean(DATARef_df130078{1,2},3);
REF2(3,:) = nanmean(DATARef_el130325{1,2},3);
REF2(4,:) = nanmean(DATARef_jn120580{1,2},3);
REF2(5,:) = nanmean(DATARef_sb130326{1,2},3);
REF2(6,:)  = nanmean(DATARef_ad120287{1,2},3);
REF2(7,:)  = nanmean(DATARef_am090241{1,2},3);
REF2(8,:)  = nanmean(DATARef_cv120216{1,2},3);
REF2(9,:)  = nanmean(DATARef_gd130362{1,2},3);
REF2(10,:) = nanmean(DATARef_rg130377{1,2},3);
REF2mean  = nanmean(REF2);
REF2std   = nanstd(REF2);

REF3(1,:) = nanmean(DATARef_PB130006{1,3},3);
REF3(2,:) = nanmean(DATARef_df130078{1,3},3);
REF3(3,:) = nanmean(DATARef_el130325{1,3},3);
REF3(4,:) = nanmean(DATARef_jn120580{1,3},3);
REF3(5,:) = nanmean(DATARef_sb130326{1,3},3);
REF3(6,:)  = nanmean(DATARef_ad120287{1,3},3);
REF3(7,:)  = nanmean(DATARef_am090241{1,3},3);
REF3(8,:)  = nanmean(DATARef_cv120216{1,3},3);
REF3(9,:)  = nanmean(DATARef_gd130362{1,3},3);
REF3(10,:) = nanmean(DATARef_rg130377{1,3},3);
REF3mean  = nanmean(REF3);
REF3std   = nanstd(REF3);

REF4(1,:) = nanmean(DATARef_PB130006{1,4},3);
REF4(2,:) = nanmean(DATARef_df130078{1,4},3);
REF4(3,:) = nanmean(DATARef_el130325{1,4},3);
REF4(4,:) = nanmean(DATARef_jn120580{1,4},3);
REF4(5,:) = nanmean(DATARef_sb130326{1,4},3);
REF4(6,:)  = nanmean(DATARef_ad120287{1,4},3);
REF4(7,:)  = nanmean(DATARef_am090241{1,4},3);
REF4(8,:)  = nanmean(DATARef_cv120216{1,4},3);
REF4(9,:)  = nanmean(DATARef_gd130362{1,4},3);
REF4(10,:) = nanmean(DATARef_rg130377{1,4},3);
REF4mean  = nanmean(REF4);
REF4std   = nanstd(REF4);

REF5(1,:) = nanmean(DATARef_PB130006{1,5},3);
REF5(2,:) = nanmean(DATARef_df130078{1,5},3);
REF5(3,:) = nanmean(DATARef_el130325{1,5},3);
REF5(4,:) = nanmean(DATARef_jn120580{1,5},3);
REF5(5,:) = nanmean(DATARef_sb130326{1,5},3);
REF5(6,:)  = nanmean(DATARef_ad120287{1,5},3);
REF5(7,:)  = nanmean(DATARef_am090241{1,5},3);
REF5(8,:)  = nanmean(DATARef_cv120216{1,5},3);
REF5(9,:)  = nanmean(DATARef_gd130362{1,5},3);
REF5(10,:) = nanmean(DATARef_rg130377{1,5},3);
REF5mean  = nanmean(REF5);
REF5std   = nanstd(REF5);

REF6(1,:) = nanmean(DATARef_PB130006{1,6},3);
REF6(2,:) = nanmean(DATARef_df130078{1,6},3);
REF6(3,:) = nanmean(DATARef_el130325{1,6},3);
REF6(4,:) = nanmean(DATARef_jn120580{1,6},3);
REF6(5,:) = nanmean(DATARef_sb130326{1,6},3);
REF6(6,:)  = nanmean(DATARef_ad120287{1,6},3);
REF6(7,:)  = nanmean(DATARef_am090241{1,6},3);
REF6(8,:)  = nanmean(DATARef_cv120216{1,6},3);
REF6(9,:)  = nanmean(DATARef_gd130362{1,6},3);
REF6(10,:) = nanmean(DATARef_rg130377{1,6},3);
REF6mean  = nanmean(REF6);
REF6std   = nanstd(REF6);

REF1meansq = [(REF1mean(1:6))' (REF1mean(7:12))' (REF1mean(13:18))' ...
              (REF1mean(19:24))' (REF1mean(25:30))' (REF1mean(31:36))'];
REF2meansq = [(REF2mean(1:6))' (REF2mean(7:12))' (REF2mean(13:18))' ...
              (REF2mean(19:24))' (REF2mean(25:30))' (REF2mean(31:36))'];
REF3meansq = [(REF3mean(1:6))' (REF3mean(7:12))' (REF3mean(13:18))' ...
              (REF3mean(19:24))' (REF3mean(25:30))' (REF3mean(31:36))'];
REF4meansq = [(REF4mean(1:6))' (REF4mean(7:12))' (REF4mean(13:18))' ...
              (REF4mean(19:24))' (REF4mean(25:30))' (REF4mean(31:36))'];
REF5meansq = [(REF5mean(1:6))' (REF5mean(7:12))' (REF5mean(13:18))' ...
              (REF5mean(19:24))' (REF5mean(25:30))' (REF5mean(31:36))'];
REF6meansq = [(REF6mean(1:6))' (REF6mean(7:12))' (REF6mean(13:18))' ...
              (REF6mean(19:24))' (REF6mean(25:30))' (REF6mean(31:36))'];
          
REF1stdsq  = [(REF1std(1:6))' (REF1std(7:12))' (REF1std(13:18))' ...
              (REF1std(19:24))' (REF1std(25:30))' (REF1std(31:36))'];
REF2stdsq  = [(REF2std(1:6))' (REF2std(7:12))' (REF2std(13:18))' ...
              (REF2std(19:24))' (REF2std(25:30))' (REF2std(31:36))'];
REF3stdsq  = [(REF3std(1:6))' (REF3std(7:12))' (REF3std(13:18))' ...
              (REF3std(19:24))' (REF3std(25:30))' (REF3std(31:36))'];
REF4stdsq  = [(REF4std(1:6))' (REF4std(7:12))' (REF4std(13:18))' ...
              (REF4std(19:24))' (REF4std(25:30))' (REF4std(31:36))'];
REF5stdsq  = [(REF5std(1:6))' (REF5std(7:12))' (REF5std(13:18))' ...
              (REF5std(19:24))' (REF5std(25:30))' (REF5std(31:36))'];
REF6stdsq  = [(REF6std(1:6))' (REF6std(7:12))' (REF6std(13:18))' ...
              (REF6std(19:24))' (REF6std(25:30))' (REF6std(31:36))'];   

REF1stdsq(5:6,:)   = ones(2,6)*NaN;
REF2stdsq([1 6],:) = ones(2,6)*NaN;
REF3stdsq([1 2],:) = ones(2,6)*NaN;
REF4stdsq(:,5:6)   = ones(6,2)*NaN;
REF5stdsq(:,[1 6]) = ones(6,2)*NaN;
REF6stdsq(:,[1 2]) = ones(6,2)*NaN; 
REF1meansq(5:6,:)   = ones(2,6)*NaN; 
REF2meansq([1 6],:) = ones(2,6)*NaN;
REF3meansq([1 2],:) = ones(2,6)*NaN;
REF4meansq(:,5:6)   = ones(6,2)*NaN;
REF5meansq(:,[1 6]) = ones(6,2)*NaN;
REF6meansq(:,[1 2]) = ones(6,2)*NaN;             
          
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 800 500]);
set(fig1,'PaperPosition',[1 1 800 500])
set(fig1,'PaperPositionmode','auto')

subplot(2,3,1)
bar(1:6,nanmean(REF1meansq'),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(REF1meansq'),nanstd(REF1meansq')./sqrt(size(REF1,1)),'linestyle','none','color','k')
subplot(2,3,2)
bar(1:6,nanmean(REF2meansq'),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(REF2meansq'),nanstd(REF2meansq')./sqrt(size(REF2,1)),'linestyle','none','color','k')
subplot(2,3,3)
bar(1:6,nanmean(REF3meansq'),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(REF3meansq'),nanstd(REF3meansq')./sqrt(size(REF3,1)),'linestyle','none','color','k')
subplot(2,3,4)
bar(1:6,nanmean(REF4meansq),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(REF4meansq),nanstd(REF4meansq)./sqrt(size(REF4,1)),'linestyle','none','color','k')
subplot(2,3,5)
bar(1:6,nanmean(REF5meansq),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(REF5meansq),nanstd(REF5meansq)./sqrt(size(REF5,1)),'linestyle','none','color','k')
subplot(2,3,6)
bar(1:6,nanmean(REF6meansq),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(REF6meansq),nanstd(REF6meansq)./sqrt(size(REF6,1)),'linestyle','none','color','k')

print('-dpng',['C:\MTT_MEG\results\AVG_MEAN_ER_MT_MEG_PSYCHO_merge'])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 800 800]);
set(fig1,'PaperPosition',[1 1 800 800])
set(fig1,'PaperPositionmode','auto')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PAST %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (DATE(:)-ones(36,1)*(2004));
AbsXaxis = abs((DATE(:)-ones(36,1)*(2004))); Yaxis = REF1meansq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis REF1stdsq(:)]);
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
errorbar(Xaxis', REF1meansq(:)', REF1stdsq(:)'./sqrt(size(REF1,1)),'linestyle','none','marker','.','markersize',20); hold on;
line([0 0],[0 0.5],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-20:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:20,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-15,0.45,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(5,0.45,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-18 18 0 0.5]); ylabel('Error Rate');xlabel('Temporal distance(y)');

subplot(3,3,3)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(size(REF1,1)),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:20,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:20,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(5,0.42,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(5,0.45,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 18 0 0.5]); ylabel('Error Rate');xlabel('Temporal distance(y)');

coef3(1) = P3(1);
coef4(1) = P4(1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PRESENT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (DATE(:)-ones(36,1)*(2013));
AbsXaxis = abs((DATE(:)-ones(36,1)*(2013))); Yaxis = REF2meansq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis REF2stdsq(:)]);
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
errorbar(Xaxis', REF2meansq(:)', REF2stdsq(:)'./sqrt(size(REF2,1)),'linestyle','none','marker','.','markersize',20); hold on;
line([0 0],[0 3],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-20:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:20,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-15,0.45,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(5,0.45,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-18 18 0 0.5]); ylabel('Error Rate');xlabel('Temporal distance(y)');

subplot(3,3,6)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(size(REF2,1)),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:20,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:20,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(5,0.42,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(5,0.45,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 18 0 0.5]); ylabel('Error Rate');xlabel('Temporal distance(y)');

coef3(2) = P3(1);
coef4(2) = P4(1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FUTURE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (DATE(:)-ones(36,1)*(2022));
AbsXaxis = abs((DATE(:)-ones(36,1)*(2022))); Yaxis = REF3meansq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis REF3stdsq(:)]);
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
errorbar(Xaxis', REF3meansq(:)', REF3stdsq(:)'./sqrt(size(REF3,1)),'linestyle','none','marker','.','markersize',20); hold on;
line([0 0],[0 0.45],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-20:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:20,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-17,0.45,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(1,0.45,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-18 18 0 0.5]); ylabel('Error Rate');xlabel('Temporal distance(y)');

subplot(3,3,9)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(size(REF3,1)),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:20,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:20,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(1,0.42,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(1,0.45,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 18 0 0.5]); ylabel('Error Rate');xlabel('Temporal distance(y)');

print('-dpng','C:\MTT_MEG\results\AVG_REGRESS_TIME_ER_MT_MEG_PSYCHO_merge')

coef3(3) = P3(1);
coef4(3) = P4(1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 800 800]);
set(fig1,'PaperPosition',[1 1 800 800])
set(fig1,'PaperPositionmode','auto')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% WEST %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (LONG(:)-ones(36,1)*(-52.3));
AbsXaxis = abs((LONG(:)-ones(36,1)*(-52.3))); Yaxis = REF4meansq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis REF4stdsq(:)]);
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
errorbar(Xaxis', REF4meansq(:)', REF4stdsq(:)'./sqrt(size(REF4,1)),'linestyle','none','marker','.','markersize',20); hold on;
line([0 0],[0 0.5],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-160:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:160,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-155,0.45,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(5,0.45,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-160 160 0 0.5]); ylabel('Error Rate');xlabel('Spatial distance(°)');

subplot(3,3,3)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(size(REF4,1)),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:160,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:160,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(5,0.42,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(5,0.45,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 160 0 0.5]); ylabel('Error Rate');xlabel('|Spatial distance| (°)');

coef3(4) = P3(1);
coef4(4) = P4(1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PARIS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (LONG(:)-ones(36,1)*(2.3));
AbsXaxis = abs((LONG(:)-ones(36,1)*(2.3))); Yaxis = REF5meansq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis REF5stdsq(:)]);
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
errorbar(Xaxis', REF5meansq(:)', REF5stdsq(:)'./sqrt(size(REF5,1)),'linestyle','none','marker','.','markersize',20); hold on;
line([0 0],[0 0.5],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-160:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:160,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-155,0.45,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(5,0.45,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-160 160 0 0.5]); ylabel('Error Rate');xlabel('Spatial distance(°)');

subplot(3,3,6)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(size(REF5,1)),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:160,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:160,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(5,0.42,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(5,0.45,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 160 0 0.5]); ylabel('Error  Rate');xlabel('|Spatial distance| (°)');

coef3(5) = P3(1);
coef4(5) = P4(1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FUTURE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (LONG(:)-ones(36,1)*(55.3));
AbsXaxis = abs((LONG(:)-ones(36,1)*(55.3))); Yaxis = REF6meansq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis REF6stdsq(:)]);
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
errorbar(Xaxis', REF6meansq(:)', REF6stdsq(:)'./sqrt(size(REF6,1)),'linestyle','none','marker','.','markersize',20); hold on;
line([0 0],[0 0.5],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-160:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:160,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-155,0.45,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(1,0.45,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-160 160 0 0.5]); ylabel('Error Rate');xlabel('Spatial distance(°)');

subplot(3,3,9)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(size(REF6,1)),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:160,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:160,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(1,0.42,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(1,0.45,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 160 0 0.5]); ylabel('Error Rate');xlabel('|Spatial distance| (°)');

print('-dpng',['C:\MTT_MEG\results\AVG_REGRESS_SPACE_ER_MT_MEG_PSYCHO_merge'])

coef3(6) = P3(1);
coef4(6) = P4(1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% AVG RT
fig1 = figure('position',[1 1 500 300]);
set(fig1,'PaperPosition',[1 1 500 300])
set(fig1,'PaperPositionmode','auto')

bar([nanmean(nanmean(REF2meansq)) nanmean(nanmean(REF1meansq)) nanmean(nanmean(REF3meansq)) ...
    0 nanmean(nanmean(REF5meansq)) nanmean(nanmean(REF4meansq)) nanmean(nanmean(REF6meansq))],'facecolor',[0.5 0.5 0.5]);
set(gca,'xtick',1:7,'xticklabel',{'PrePar';'PasPar';'FutPar';'';'PrePar';'PreW';'PreE'}); hold on;
errorbar(1:7,[nanmean(nanmean(REF2meansq)) nanmean(nanmean(REF1meansq)) nanmean(nanmean(REF3meansq)) ...
    0 nanmean(nanmean(REF5meansq)) nanmean(nanmean(REF4meansq)) nanmean(nanmean(REF6meansq))],...
    [nanstd(REF2meansq(:)) nanstd(REF1meansq(:)) nanstd(REF3meansq(:)) ...
    0 nanstd(REF5meansq(:)) nanstd(REF4meansq(:)) nanstd(REF6meansq(:))]./sqrt(5),'linestyle','none','color','k');
ylabel('RT')
xticklabel_rotate([],45,[],'Fontsize',10)

%% AVG RT coeff
fig1 = figure('position',[1 1 1000 600]);
set(fig1,'PaperPosition',[1 1 1000 600])
set(fig1,'PaperPositionmode','auto')

subplot(2,2,1)
bar([coef3([2 1 3]) 0 coef3([5 4 6])],'facecolor',[0.5 0.5 0.5]); ylabel('lin slope')
set(gca,'xtick',1:7,'xticklabel',{'PrePar';'PasPar';'FutPar';'';'PrePar';'PreW';'PreE'})
xticklabel_rotate([],45,[],'Fontsize',10)

fig1 = figure('position',[1 1 800 400]);
set(fig1,'PaperPosition',[1 1 800 400])
set(fig1,'PaperPositionmode','auto')

subplot(2,2,[1 3])
bar([coef3([5 4 6])],'facecolor',[0.5 0.5 0.5]); ylabel('lin slope')
set(gca,'xtick',1:3,'xticklabel',{'PrePar';'PreW';'PreE'})
xticklabel_rotate([],45,[],'Fontsize',10)

subplot(2,2,2)
bar([coef4([2 1 3]) 0 coef4([5 4 6])],'facecolor',[0.5 0.5 0.5]); ylabel('log slope')
set(gca,'xtick',1:7,'xticklabel',{'PrePar';'PasPar';'FutPar';'';'PrePar';'PreW';'PreE'})
xticklabel_rotate([],45,[],'Fontsize',10)

%% AVG ER 
fig1 = figure('position',[1 1 500 300]);
set(fig1,'PaperPosition',[1 1 500 300])
set(fig1,'PaperPositionmode','auto')

bar([nanmean(nanmean(REF2meansq)) nanmean(nanmean(REF1meansq)) nanmean(nanmean(REF3meansq)) ...
    0 nanmean(nanmean(REF5meansq)) nanmean(nanmean(REF4meansq)) nanmean(nanmean(REF6meansq))],'facecolor',[0.5 0.5 0.5]);
set(gca,'xtick',1:7,'xticklabel',{'PrePar';'PasPar';'FutPar';'';'PrePar';'PreW';'PreE'}); hold on;
errorbar(1:7,[nanmean(nanmean(REF2meansq)) nanmean(nanmean(REF1meansq)) nanmean(nanmean(REF3meansq)) ...
    0 nanmean(nanmean(REF5meansq)) nanmean(nanmean(REF4meansq)) nanmean(nanmean(REF6meansq))],...
    [nanstd(REF2meansq(:)) nanstd(REF1meansq(:)) nanstd(REF3meansq(:)) ...
    0 nanstd(REF5meansq(:)) nanstd(REF4meansq(:)) nanstd(REF6meansq(:))]./sqrt(5),'linestyle','none','color','k');
ylabel('RT')
xticklabel_rotate([],45,[],'Fontsize',10)

%% AVG ER coeff
fig1 = figure('position',[1 1 800 400]);
set(fig1,'PaperPosition',[1 1 800 400])
set(fig1,'PaperPositionmode','auto')

subplot(2,2,1)
bar([coef3([2 1 3]) ],'facecolor',[0.5 0.5 0.5]); ylabel('lin slope')
set(gca,'xtick',1:3,'xticklabel',{'PrePar';'PasPar';'FutPar'}); 
xticklabel_rotate([],45,[],'Fontsize',10)
subplot(2,2,2)
bar([coef3([5 4 6]) ],'facecolor',[0.5 0.5 0.5]); ylabel('lin slope')
set(gca,'xtick',1:3,'xticklabel',{'PrePar';'PreW';'PreE'});
xticklabel_rotate([],45,[],'Fontsize',10)
subplot(2,2,3)
bar([coef4([2 1 3]) ],'facecolor',[0.5 0.5 0.5]); ylabel('log slope')
set(gca,'xtick',1:3,'xticklabel',{'PrePar';'PasPar';'FutPar'});
xticklabel_rotate([],45,[],'Fontsize',10)
subplot(2,2,4)
bar([coef4([5 4 6]) ],'facecolor',[0.5 0.5 0.5]); ylabel('log slope')
set(gca,'xtick',1:3,'xticklabel',{'PrePar';'PreW';'PreE'}); 
xticklabel_rotate([],45,[],'Fontsize',10)




