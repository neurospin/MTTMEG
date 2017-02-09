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

load('C:\MTT_MEG\results\PSYCH_RT_3rd');

REF1S(1,:)  = nanmean(DATARef_s_karin{1,1},1);
REF1S(2,:)  = nanmean(DATARef_s_benoit{1,1},1);
REF1S(3,:)  = nanmean(DATARef_s_laetitia{1,1},1);
REF1S(4,:)  = nanmean(DATARef_s_sb130354{1,1},1);
REF1S(5,:)  = nanmean(DATARef_s_sd130343{1,1},1);
REF1S(6,:)  = nanmean(DATARef_s_wb120579{1,1},1);
REF1S(7,:)  = nanmean(DATARef_s_hm070076{1,1},1);
REF1Smean   = nanmean(REF1S);
REF1Sstd    = nanstd(REF1S);

REF2S(1,:) = nanmean(DATARef_s_karin{1,2},1);
REF2S(2,:) = nanmean(DATARef_s_benoit{1,2},1);
REF2S(3,:) = nanmean(DATARef_s_laetitia{1,2},1);
REF2S(4,:)  = nanmean(DATARef_s_sb130354{1,2},1);
REF2S(5,:)  = nanmean(DATARef_s_sd130343{1,2},1);
REF2S(6,:)  = nanmean(DATARef_s_wb120579{1,2},1);
REF2S(7,:)  = nanmean(DATARef_s_hm070076{1,2},1);
REF2Smean  = nanmean(REF2S);
REF2Sstd   = nanstd(REF2S);

REF3S(1,:) = nanmean(DATARef_s_karin{1,3},1);
REF3S(2,:) = nanmean(DATARef_s_benoit{1,3},1);
REF3S(3,:) = nanmean(DATARef_s_laetitia{1,3},1);
REF3S(4,:)  = nanmean(DATARef_s_sb130354{1,3},1);
REF3S(5,:)  = nanmean(DATARef_s_sd130343{1,3},1);
REF3S(6,:)  = nanmean(DATARef_s_wb120579{1,3},1);
REF3S(7,:)  = nanmean(DATARef_s_hm070076{1,3},1);
REF3Smean  = nanmean(REF3S);
REF3Sstd   = nanstd(REF3S);

REF4S(1,:) = nanmean(DATARef_s_karin{1,4},1);
REF4S(2,:) = nanmean(DATARef_s_benoit{1,4},1);
REF4S(3,:) = nanmean(DATARef_s_laetitia{1,4},1);
REF4S(4,:)  = nanmean(DATARef_s_sb130354{1,4},1);
REF4S(5,:)  = nanmean(DATARef_s_sd130343{1,4},1);
REF4S(6,:)  = nanmean(DATARef_s_wb120579{1,4},1);
REF4S(7,:)  = nanmean(DATARef_s_hm070076{1,4},1);
REF4Smean  = nanmean(REF4S);
REF4Sstd   = nanstd(REF4S);

REF5S(1,:) = nanmean(DATARef_s_karin{1,5},1);
REF5S(2,:) = nanmean(DATARef_s_benoit{1,5},1);
REF5S(3,:) = nanmean(DATARef_s_laetitia{1,5},1);
REF5S(4,:)  = nanmean(DATARef_s_sb130354{1,5},1);
REF5S(5,:)  = nanmean(DATARef_s_sd130343{1,5},1);
REF5S(6,:)  = nanmean(DATARef_s_wb120579{1,5},1);
REF5S(7,:)  = nanmean(DATARef_s_hm070076{1,5},1);
REF5Smean  = nanmean(REF5S);
REF5Sstd   = nanstd(REF5S);

REF6S(1,:) = nanmean(DATARef_s_karin{1,6},1);
REF6S(2,:) = nanmean(DATARef_s_benoit{1,6},1);
REF6S(3,:) = nanmean(DATARef_s_laetitia{1,6},1);
REF6S(4,:)  = nanmean(DATARef_s_sb130354{1,6},1);
REF6S(5,:)  = nanmean(DATARef_s_sd130343{1,6},1);
REF6S(6,:)  = nanmean(DATARef_s_wb120579{1,6},1);
REF6S(7,:)  = nanmean(DATARef_s_hm070076{1,6},1);
REF6Smean  = nanmean(REF6S);
REF6Sstd   = nanstd(REF6S);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

REF1T(1,:)  = nanmean(DATARef_t_karin{1,1},1);
REF1T(2,:)  = nanmean(DATARef_t_benoit{1,1},1);
REF1T(3,:)  = nanmean(DATARef_t_laetitia{1,1},1);
REF1T(4,:)  = nanmean(DATARef_t_sb130354{1,1},1);
REF1T(5,:)  = nanmean(DATARef_t_sd130343{1,1},1);
REF1T(6,:)  = nanmean(DATARef_t_wb120579{1,1},1);
REF1T(7,:)  = nanmean(DATARef_t_hm070076{1,1},1);
REF1Tmean   = nanmean(REF1T);
REF1Tstd    = nanstd(REF1T);

REF2T(1,:) = nanmean(DATARef_t_karin{1,2},1);
REF2T(2,:) = nanmean(DATARef_t_benoit{1,2},1);
REF2T(3,:) = nanmean(DATARef_t_laetitia{1,2},1);
REF2T(4,:) = nanmean(DATARef_t_sb130354{1,2},1);
REF2T(5,:) = nanmean(DATARef_t_sd130343{1,2},1);
REF2T(6,:) = nanmean(DATARef_t_wb120579{1,2},1);
REF2T(7,:) = nanmean(DATARef_t_hm070076{1,2},1);
REF2Tmean  = nanmean(REF2T);
REF2Tstd   = nanstd(REF2T);

REF3T(1,:) = nanmean(DATARef_t_karin{1,3},1);
REF3T(2,:) = nanmean(DATARef_t_benoit{1,3},1);
REF3T(3,:) = nanmean(DATARef_t_laetitia{1,3},1);
REF3T(4,:) = nanmean(DATARef_t_sb130354{1,3},1);
REF3T(5,:) = nanmean(DATARef_t_sd130343{1,3},1);
REF3T(6,:) = nanmean(DATARef_t_wb120579{1,3},1);
REF3T(7,:) = nanmean(DATARef_t_hm070076{1,3},1);
REF3Tmean  = nanmean(REF3T);
REF3Tstd   = nanstd(REF3T);

REF4T(1,:) = nanmean(DATARef_t_karin{1,4},1);
REF4T(2,:) = nanmean(DATARef_t_benoit{1,4},1);
REF4T(3,:) = nanmean(DATARef_t_laetitia{1,4},1);
REF4T(4,:) = nanmean(DATARef_t_sb130354{1,4},1);
REF4T(5,:) = nanmean(DATARef_t_sd130343{1,4},1);
REF4T(6,:) = nanmean(DATARef_t_wb120579{1,4},1);
REF4T(7,:) = nanmean(DATARef_t_hm070076{1,4},1);
REF4Tmean  = nanmean(REF4T);
REF4Tstd   = nanstd(REF4T);

REF5T(1,:) = nanmean(DATARef_t_karin{1,5},1);
REF5T(2,:) = nanmean(DATARef_t_benoit{1,5},1);
REF5T(3,:) = nanmean(DATARef_t_laetitia{1,5},1);
REF5T(4,:) = nanmean(DATARef_t_sb130354{1,5},1);
REF5T(5,:) = nanmean(DATARef_t_sd130343{1,5},1);
REF5T(6,:) = nanmean(DATARef_t_wb120579{1,5},1);
REF5T(7,:) = nanmean(DATARef_t_hm070076{1,5},1);
REF5Tmean  = nanmean(REF5T);
REF5Tstd   = nanstd(REF5T);

REF6T(1,:) = nanmean(DATARef_t_karin{1,6},1);
REF6T(2,:) = nanmean(DATARef_t_benoit{1,6},1);
REF6T(3,:) = nanmean(DATARef_t_laetitia{1,6},1);
REF6T(4,:) = nanmean(DATARef_t_sb130354{1,6},1);
REF6T(5,:) = nanmean(DATARef_t_sd130343{1,6},1);
REF6T(6,:) = nanmean(DATARef_t_wb120579{1,6},1);
REF6T(7,:) = nanmean(DATARef_t_hm070076{1,6},1);
REF6Tmean  = nanmean(REF6T);
REF6Tstd   = nanstd(REF6T);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

REF1Tmeansq = [(REF1Tmean(1:6))' (REF1Tmean(7:12))' (REF1Tmean(13:18))' ...
    (REF1Tmean(19:24))' (REF1Tmean(25:30))' (REF1Tmean(31:36))'];
REF2Tmeansq = [(REF2Tmean(1:6))' (REF2Tmean(7:12))' (REF2Tmean(13:18))' ...
    (REF2Tmean(19:24))' (REF2Tmean(25:30))' (REF2Tmean(31:36))'];
REF3Tmeansq = [(REF3Tmean(1:6))' (REF3Tmean(7:12))' (REF3Tmean(13:18))' ...
    (REF3Tmean(19:24))' (REF3Tmean(25:30))' (REF3Tmean(31:36))'];
REF4Tmeansq = [(REF4Tmean(1:6))' (REF4Tmean(7:12))' (REF4Tmean(13:18))' ...
    (REF4Tmean(19:24))' (REF4Tmean(25:30))' (REF4Tmean(31:36))'];
REF5Tmeansq = [(REF5Tmean(1:6))' (REF5Tmean(7:12))' (REF5Tmean(13:18))' ...
    (REF5Tmean(19:24))' (REF5Tmean(25:30))' (REF5Tmean(31:36))'];
REF6Tmeansq = [(REF6Tmean(1:6))' (REF6Tmean(7:12))' (REF6Tmean(13:18))' ...
    (REF6Tmean(19:24))' (REF6Tmean(25:30))' (REF6Tmean(31:36))'];

REF1Smeansq = [(REF1Smean(1:6))' (REF1Smean(7:12))' (REF1Smean(13:18))' ...
    (REF1Smean(19:24))' (REF1Smean(25:30))' (REF1Smean(31:36))'];
REF2Smeansq = [(REF2Smean(1:6))' (REF2Smean(7:12))' (REF2Smean(13:18))' ...
    (REF2Smean(19:24))' (REF2Smean(25:30))' (REF2Smean(31:36))'];
REF3Smeansq = [(REF3Smean(1:6))' (REF3Smean(7:12))' (REF3Smean(13:18))' ...
    (REF3Smean(19:24))' (REF3Smean(25:30))' (REF3Smean(31:36))'];
REF4Smeansq = [(REF4Smean(1:6))' (REF4Smean(7:12))' (REF4Smean(13:18))' ...
    (REF4Smean(19:24))' (REF4Smean(25:30))' (REF4Smean(31:36))'];
REF5Smeansq = [(REF5Smean(1:6))' (REF5Smean(7:12))' (REF5Smean(13:18))' ...
    (REF5Smean(19:24))' (REF5Smean(25:30))' (REF5Smean(31:36))'];
REF6Smeansq = [(REF6Smean(1:6))' (REF6Smean(7:12))' (REF6Smean(13:18))' ...
    (REF6Smean(19:24))' (REF6Smean(25:30))' (REF6Smean(31:36))'];

REF1Tstdsq  = [(REF1Tstd(1:6))' (REF1Tstd(7:12))' (REF1Tstd(13:18))' ...
    (REF1Tstd(19:24))' (REF1Tstd(25:30))' (REF1Tstd(31:36))'];
REF2Tstdsq  = [(REF2Tstd(1:6))' (REF2Tstd(7:12))' (REF2Tstd(13:18))' ...
    (REF2Tstd(19:24))' (REF2Tstd(25:30))' (REF2Tstd(31:36))'];
REF3Tstdsq  = [(REF3Tstd(1:6))' (REF3Tstd(7:12))' (REF3Tstd(13:18))' ...
    (REF3Tstd(19:24))' (REF3Tstd(25:30))' (REF3Tstd(31:36))'];
REF4Tstdsq  = [(REF4Tstd(1:6))' (REF4Tstd(7:12))' (REF4Tstd(13:18))' ...
    (REF4Tstd(19:24))' (REF4Tstd(25:30))' (REF4Tstd(31:36))'];
REF5Tstdsq  = [(REF5Tstd(1:6))' (REF5Tstd(7:12))' (REF5Tstd(13:18))' ...
    (REF5Tstd(19:24))' (REF5Tstd(25:30))' (REF5Tstd(31:36))'];
REF6Tstdsq  = [(REF6Tstd(1:6))' (REF6Tstd(7:12))' (REF6Tstd(13:18))' ...
    (REF6Tstd(19:24))' (REF6Tstd(25:30))' (REF6Tstd(31:36))'];

REF1Sstdsq  = [(REF1Sstd(1:6))' (REF1Sstd(7:12))' (REF1Sstd(13:18))' ...
    (REF1Sstd(19:24))' (REF1Sstd(25:30))' (REF1Sstd(31:36))'];
REF2Sstdsq  = [(REF2Sstd(1:6))' (REF2Sstd(7:12))' (REF2Sstd(13:18))' ...
    (REF2Sstd(19:24))' (REF2Sstd(25:30))' (REF2Sstd(31:36))'];
REF3Sstdsq  = [(REF3Sstd(1:6))' (REF3Sstd(7:12))' (REF3Sstd(13:18))' ...
    (REF3Sstd(19:24))' (REF3Sstd(25:30))' (REF3Sstd(31:36))'];
REF4Sstdsq  = [(REF4Sstd(1:6))' (REF4Sstd(7:12))' (REF4Sstd(13:18))' ...
    (REF4Sstd(19:24))' (REF4Sstd(25:30))' (REF4Sstd(31:36))'];
REF5Sstdsq  = [(REF5Sstd(1:6))' (REF5Sstd(7:12))' (REF5Sstd(13:18))' ...
    (REF5Sstd(19:24))' (REF5Sstd(25:30))' (REF5Sstd(31:36))'];
REF6Sstdsq  = [(REF6Sstd(1:6))' (REF6Sstd(7:12))' (REF6Sstd(13:18))' ...
    (REF6Sstd(19:24))' (REF6Sstd(25:30))' (REF6Sstd(31:36))'];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 800 500]);
set(fig1,'PaperPosition',[1 1 800 500])
set(fig1,'PaperPositionmode','auto')

subplot(2,3,1); imagesc(REF1Smeansq,[0 2]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');
subplot(2,3,2); imagesc(REF2Smeansq,[0 2]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');
subplot(2,3,3); imagesc(REF3Smeansq,[0 2]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');
subplot(2,3,4); imagesc(REF4Smeansq,[0 2]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');
subplot(2,3,5); imagesc(REF5Smeansq,[0 2]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');
subplot(2,3,6); imagesc(REF6Smeansq,[0 2]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');

print('-dpng',['C:\MTT_MEG\results\FULL_RT_MT_MEG_PSYCHO_SPACE_3rd_merge'])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 800 500]);
set(fig1,'PaperPosition',[1 1 800 500])
set(fig1,'PaperPositionmode','auto')

subplot(2,3,1); imagesc(REF1Tmeansq,[0 2]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');
subplot(2,3,2); imagesc(REF2Tmeansq,[0 2]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');
subplot(2,3,3); imagesc(REF3Tmeansq,[0 2]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');
subplot(2,3,4); imagesc(REF4Tmeansq,[0 2]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');
subplot(2,3,5); imagesc(REF5Tmeansq,[0 2]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');
subplot(2,3,6); imagesc(REF6Tmeansq,[0 2]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');

print('-dpng',['C:\MTT_MEG\results\FULL_RT_MT_MEG_PSYCHO_TIME_3rd_merge'])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 800 500]);
set(fig1,'PaperPosition',[1 1 800 500])
set(fig1,'PaperPositionmode','auto')

subplot(2,3,1)
bar(1:6,nanmean(REF1Tmeansq'),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-2 -1 1 2 3 4]);hold on
errorbar(1:6,nanmean(REF1Tmeansq'),nanstd(REF1Tmeansq')./sqrt(6),'linestyle','none','color','k')
subplot(2,3,2)
bar(1:6,nanmean(REF2Tmeansq'),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(REF2Tmeansq'),nanstd(REF2Tmeansq')./sqrt(6),'linestyle','none','color','k')
subplot(2,3,3)
bar(1:6,nanmean(REF3Tmeansq'),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-4 -3 -2 -1 1 2]);hold on
errorbar(1:6,nanmean(REF3Tmeansq'),nanstd(REF3Tmeansq')./sqrt(6),'linestyle','none','color','k')
subplot(2,3,4)
bar(1:6,nanmean(REF4Tmeansq'),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(REF4Tmeansq'),nanstd(REF4Tmeansq')./sqrt(6),'linestyle','none','color','k')
subplot(2,3,5)
bar(1:6,nanmean(REF5Tmeansq'),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(REF5Tmeansq'),nanstd(REF5Tmeansq')./sqrt(6),'linestyle','none','color','k')
subplot(2,3,6)
bar(1:6,nanmean(REF6Tmeansq'),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(REF6Tmeansq'),nanmean(REF6Tmeansq')./sqrt(6),'linestyle','none','color','k')

print('-dpng','C:\MTT_MEG\results\MEAN_RT_MT_MEG_PSYCHO_TIME_merge_3rd')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 800 500]);
set(fig1,'PaperPosition',[1 1 800 500])
set(fig1,'PaperPositionmode','auto')

subplot(2,3,1)
bar(1:6,nanmean(REF1Smeansq),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-2 -1 1 2 3 4]);hold on
errorbar(1:6,nanmean(REF1Smeansq),nanstd(REF1Smeansq)./sqrt(6),'linestyle','none','color','k')
subplot(2,3,2)
bar(1:6,nanmean(REF2Smeansq),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(REF2Smeansq),nanstd(REF2Smeansq)./sqrt(6),'linestyle','none','color','k')
subplot(2,3,3)
bar(1:6,nanmean(REF3Smeansq),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-4 -3 -2 -1 1 2]);hold on
errorbar(1:6,nanmean(REF3Smeansq),nanstd(REF3Smeansq)./sqrt(6),'linestyle','none','color','k')
subplot(2,3,4)
bar(1:6,nanmean(REF4Smeansq),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(REF4Smeansq),nanstd(REF4Smeansq)./sqrt(6),'linestyle','none','color','k')
subplot(2,3,5)
bar(1:6,nanmean(REF5Smeansq),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(REF5Smeansq),nanstd(REF5Smeansq)./sqrt(6),'linestyle','none','color','k')
subplot(2,3,6)
bar(1:6,nanmean(REF6Smeansq),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(REF6Smeansq),nanmean(REF6Smeansq)./sqrt(6),'linestyle','none','color','k')

print('-dpng','C:\MTT_MEG\results\MEAN_RT_MT_MEG_PSYCHO_SPACE_merge_3rd')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 800 800]);
set(fig1,'PaperPosition',[1 1 800 800])
set(fig1,'PaperPositionmode','auto')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PAST %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (DATE(:)-ones(36,1)*(2004));
AbsXaxis = abs((DATE(:)-ones(36,1)*(2004))); Yaxis = REF1Tmeansq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis REF1Tstdsq(:)]);
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
errorbar(Xaxis', REF1Tmeansq(:)', REF1Tstdsq(:)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
line([0 0],[0 3],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-30:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:30,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-25,1.8,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-30 30 0 3]); ylabel('Reaction time (s)');xlabel('Temporal distance(y)');title('TJ PasPar');

subplot(3,3,3)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:30,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:30,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(5,1.5,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 30 0 3]); ylabel('Reaction time (s)');xlabel('|Temporal distance| (y)');title('TJ PasPar');

coef3T(1) = P3(1);
coef4T(1) = P4(1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PRESENT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (DATE(:)-ones(36,1)*(2013));
AbsXaxis = abs((DATE(:)-ones(36,1)*(2013))); Yaxis = REF2Tmeansq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis REF2Tstdsq(:)]);
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
errorbar(Xaxis', REF2Tmeansq(:)', REF2Tstdsq(:)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
line([0 0],[0 3],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-30:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:30,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-25,1.8,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-30 30 0 3]); ylabel('Reaction time (s)');xlabel('Temporal distance(y)');title('TJ PrePar');

subplot(3,3,6)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:30,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:30,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(5,1.5,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 30 0 3]); ylabel('Reaction time (s)');xlabel('|Temporal distance| (y)');title('TJ PrePar');

coef3T(2) = P3(1);
coef4T(2) = P4(1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FUTURE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (DATE(:)-ones(36,1)*(2022));
AbsXaxis = abs((DATE(:)-ones(36,1)*(2022))); Yaxis = REF3Tmeansq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis REF3Tstdsq(:)]);
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
errorbar(Xaxis', REF3Tmeansq(:)', REF3Tstdsq(:)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
line([0 0],[0 3],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-30:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:30,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-25,1.8,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(1,1.8,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-30 30 0 3]); ylabel('Reaction time (s)');xlabel('Temporal distance(y)');title('TJ FutPar');

subplot(3,3,9)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:30,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:30,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(1,1.5,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(1,1.8,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 30 0 3]); ylabel('Reaction time (s)');xlabel('|Temporal distance| (y)');title('TJ FutPar');

print('-dpng',['C:\MTT_MEG\results\REGRESS_TIME_RT_MT_MEG_PSYCHO_TIME_3rd_merge'])

coef3T(3) = P3(1);
coef4T(3) = P4(1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 800 800]);
set(fig1,'PaperPosition',[1 1 800 800])
set(fig1,'PaperPositionmode','auto')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% WEST %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (DATE(:)-ones(36,1)*(2013));
AbsXaxis = abs((DATE(:)-ones(36,1)*(2013))); Yaxis = REF5Tmeansq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis REF5Tstdsq(:)]);
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
errorbar(Xaxis', REF5Tmeansq(:)', REF5Tstdsq(:)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
line([0 0],[0 3],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-30:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:30,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-25,1.8,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-30 30 0 3]); ylabel('Reaction time (s)');xlabel('Temporal distance(y)');title('TJ PreW');

subplot(3,3,3)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:30,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:30,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(5,1.5,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 30 0 3]); ylabel('Reaction time (s)');xlabel('|Temporal distance| (y)');title('TJ PreW');

coef3T(4) = P3(1);
coef4T(4) = P4(1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PARIS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (DATE(:)-ones(36,1)*(2013));
AbsXaxis = abs((DATE(:)-ones(36,1)*(2013))); Yaxis = REF6Tmeansq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis REF6Tstdsq(:)]);
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
errorbar(Xaxis', REF6Tmeansq(:)', REF6Tstdsq(:)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
line([0 0],[0 3],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-30:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:30,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-15,1.8,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-30 30 0 3]); ylabel('Reaction time (s)');xlabel('Temporal distance(y)');title('TJ PrePar');

subplot(3,3,6)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:30,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:30,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(5,1.5,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 30 0 3]); ylabel('Reaction time (s)');xlabel('|Temporal distance| (y)');title('TJ PrePar');

coef3T(5) = P3(1);
coef4T(5) = P4(1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% East %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (DATE(:)-ones(36,1)*(2013));
AbsXaxis = abs((DATE(:)-ones(36,1)*(2013))); Yaxis = REF4Tmeansq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis REF4Tstdsq(:)]);
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
errorbar(Xaxis', REF4Tmeansq(:)', REF4Tstdsq(:)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
line([0 0],[0 3],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-30:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:30,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-25,1.8,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-30 30 0 3]); ylabel('Reaction time (s)');xlabel('Temporal distance(y)');title('TJ PreE');

subplot(3,3,9)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:30,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:30,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(5,1.5,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 30 0 3]); ylabel('Reaction time (s)');xlabel('|Temporal distance| (y)');title('TJ PreE');

coef3T(6) = P3(1);
coef4T(6) = P4(1);

print('-dpng',['C:\MTT_MEG\results\REGRESS_SPACE_RT_MT_MEG_PSYCHO_TIME_3rd_merge'])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 800 800]);
set(fig1,'PaperPosition',[1 1 800 800])
set(fig1,'PaperPositionmode','auto')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% WEST %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (LONG(:)-ones(36,1)*(-52.3));
AbsXaxis = abs((LONG(:)-ones(36,1)*(-52.3))); Yaxis = REF1Smeansq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis REF1Sstdsq(:)]);
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
errorbar(Xaxis', REF1Smeansq(:)', REF1Sstdsq(:)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
line([0 0],[0 3],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-160:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:160,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-155,1.8,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-160 160 0 3]); ylabel('Reaction time (s)');xlabel('Spatial distance (°)');title('SJ PasPar');

subplot(3,3,3)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:160,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:160,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(5,1.5,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 160 0 3]); ylabel('Reaction time (s)');xlabel('|Spatial distance| (°)');title('SJ PasPar');

coef3S(1) = P3(1);
coef4S(1) = P4(1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PARIS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (LONG(:)-ones(36,1)*(2.3));
AbsXaxis = abs((LONG(:)-ones(36,1)*(2.3))); Yaxis = REF2Smeansq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis REF2Sstdsq(:)]);
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
errorbar(Xaxis', REF2Smeansq(:)', REF2Sstdsq(:)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
line([0 0],[0 3],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-160:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:160,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-155,1.8,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-160 160 0 3]); ylabel('Reaction time (s)');xlabel('Spatial distance (°)');title('SJ PrePar');

subplot(3,3,6)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(length(6)),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:160,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:160,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(5,1.5,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 160 0 3]); ylabel('Reaction time (s)');xlabel('|Spatial distance| (°)');title('SJ PrePar');

coef3S(2) = P3(1);
coef4S(2) = P4(1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FUTURE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (LONG(:)-ones(36,1)*(55.3));
AbsXaxis = abs((LONG(:)-ones(36,1)*(55.3))); Yaxis = REF3Smeansq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis REF3Sstdsq(:)]);
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
errorbar(Xaxis', REF3Smeansq(:)', REF3Sstdsq(:)'./sqrt(length(6)),'linestyle','none','marker','.','markersize',20); hold on;
line([0 0],[0 3],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-160:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:160,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-155,1.8,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(1,1.8,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-160 160 0 3]); ylabel('Reaction time (s)');xlabel('Spatial distance (°)');title('SJ FutPar');

subplot(3,3,9)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(length(6)),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:160,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:160,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(1,1.5,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(1,1.8,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 160 0 3]); ylabel('Reaction time (s)');xlabel('|Spatial distance| (°)');title('SJ FutPar');

print('-dpng',['C:\MTT_MEG\results\REGRESS_SPACE_RT_MT_MEG_PSYCHO_TIME_3rd_merge'])

coef3S(3) = P3(1);
coef4S(3) = P4(1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 800 800]);
set(fig1,'PaperPosition',[1 1 800 800])
set(fig1,'PaperPositionmode','auto')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% WEST %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (LONG(:)-ones(36,1)*(-52.3));
AbsXaxis = abs((LONG(:)-ones(36,1)*(-52.3))); Yaxis = REF5Smeansq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis REF5Sstdsq(:)]);
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
errorbar(Xaxis', REF5Smeansq(:)', REF5Sstdsq(:)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
line([0 0],[0 3],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-160:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:160,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-155,1.8,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-160 160 0 3]); ylabel('Reaction time (s)');xlabel('Spatial distance (°)');title('SJ PreW');

subplot(3,3,3)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:160,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:160,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(5,1.5,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 160 0 3]); ylabel('Reaction time (s)');xlabel('|Spatial distance| (°)');title('SJ PreW');

coef3S(4) = P3(1);
coef4S(4) = P4(1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PARIS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (LONG(:)-ones(36,1)*(2.3));
AbsXaxis = abs((LONG(:)-ones(36,1)*(2.3))); Yaxis = REF6Smeansq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis REF6Sstdsq(:)]);
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

P1 = polyfit(tmpB(:,1),tmpB(:,2),1);            Y1 = polyval(P1,-160:0.1:-0.1);
P2 = polyfit(tmpA(:,1),tmpA(:,2),1);            Y2 = polyval(P2,0.1:0.1:160);
P3 = polyfit(NormTmp(:,1),NormTmp(:,2),1);      Y3 = polyval(P3,0.1:0.1:160);
P4 = polyfit(log(NormTmp(:,1)),NormTmp(:,2),1); Y4 = polyval(P4,log(0.1:0.1:160));

subplot(3,3,[4 5])
errorbar(Xaxis', REF6Smeansq(:)', REF6Sstdsq(:)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
line([0 0],[0 3],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-160:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:160,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-155,1.8,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-160 160 0 3]); ylabel('Reaction time (s)');xlabel('Spatial distance (°)');title('SJ PrePar');

subplot(3,3,6)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(length(6)),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:160,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:160,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(5,1.5,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(5,1.8,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 160 0 3]); ylabel('Reaction time (s)');xlabel('|Spatial distance| (°)');title('SJ PrePar');

coef3S(5) = P3(1);
coef4S(5) = P4(1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EAST %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (LONG(:)-ones(36,1)*(55.3));
AbsXaxis = abs((LONG(:)-ones(36,1)*(55.3))); Yaxis = REF4Smeansq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis REF4Sstdsq(:)]);
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
errorbar(Xaxis', REF4Smeansq(:)', REF4Sstdsq(:)'./sqrt(length(6)),'linestyle','none','marker','.','markersize',20); hold on;
line([0 0],[0 3],'linestyle','--','linewidth',2,'color','k'); hold on;
plot(-160:0.1:-0.1,Y1,'color',[1 0.4 0.4],'linewidth',2); plot(0.1:0.1:160,Y2,'color',[1 0.4 0.4],'linewidth',2);
text(-155,1.8,['R² = ' num2str(STATS1(1)) ', p = ' num2str(STATS1(3))],'color','r')
text(1,1.8,['R² = ' num2str(STATS2(1)) ', p = ' num2str(STATS2(3))],'color','r')
axis([-160 160 0 3]); ylabel('Reaction time (s)');xlabel('Spatial distance (°)');title('SJ PreE');

subplot(3,3,9)
errorbar(NormTmp(:,1)', NormTmp(:,2)', NormTmpStd(:,2)'./sqrt(length(6)),'linestyle','none','marker','.','markersize',20); hold on;
plot(0.1:0.1:160,Y3,'color',[1 0 0],'linewidth',2); hold on;
plot(0.1:0.1:160,Y4,'color',[0 1 0],'linewidth',2); hold on;
text(1,1.5,['R² = ' num2str(STATS3(1)) ', p = ' num2str(STATS3(3))],'color','r')
text(1,1.8,['R² = ' num2str(STATS4(1)) ', p = ' num2str(STATS4(3))],'color','g')
axis([0 160 0 3]); ylabel('Reaction time (s)');xlabel('|Spatial distance| (°)');title('SJ PreE');

coef3S(6) = P3(1);
coef4S(6) = P4(1);

print('-dpng',['C:\MTT_MEG\results\REGRESS_SPACE_RT_MT_MEG_PSYCHO_SPACE_3rd_merge'])

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

load('C:\MTT_MEG\results\PSYCH_ERR_3rd');

REF1S(1,:)  = nanmean(DATARef_s_karin{1,1},1);
REF1S(2,:)  = nanmean(DATARef_s_benoit{1,1},1);
REF1S(3,:)  = nanmean(DATARef_s_laetitia{1,1},1);
REF1S(4,:)  = nanmean(DATARef_s_sb130354{1,1},1);
REF1S(5,:)  = nanmean(DATARef_s_sd130343{1,1},1);
REF1S(6,:)  = nanmean(DATARef_s_wb120579{1,1},1);
REF1S(7,:)  = nanmean(DATARef_s_hm070076{1,1},1);
REF1Smean   = nanmean(REF1S);
REF1Sstd    = nanstd(REF1S);

REF2S(1,:) = nanmean(DATARef_s_karin{1,2},1);
REF2S(2,:) = nanmean(DATARef_s_benoit{1,2},1);
REF2S(3,:) = nanmean(DATARef_s_laetitia{1,2},1);
REF2S(4,:)  = nanmean(DATARef_s_sb130354{1,2},1);
REF2S(5,:)  = nanmean(DATARef_s_sd130343{1,2},1);
REF2S(6,:)  = nanmean(DATARef_s_wb120579{1,2},1);
REF2S(7,:)  = nanmean(DATARef_s_hm070076{1,2},1);
REF2Smean  = nanmean(REF2S);
REF2Sstd   = nanstd(REF2S);

REF3S(1,:) = nanmean(DATARef_s_karin{1,3},1);
REF3S(2,:) = nanmean(DATARef_s_benoit{1,3},1);
REF3S(3,:) = nanmean(DATARef_s_laetitia{1,3},1);
REF3S(4,:)  = nanmean(DATARef_s_sb130354{1,3},1);
REF3S(5,:)  = nanmean(DATARef_s_sd130343{1,3},1);
REF3S(6,:)  = nanmean(DATARef_s_wb120579{1,3},1);
REF3S(7,:)  = nanmean(DATARef_s_hm070076{1,3},1);
REF3Smean  = nanmean(REF3S);
REF3Sstd   = nanstd(REF3S);

REF4S(1,:) = nanmean(DATARef_s_karin{1,4},1);
REF4S(2,:) = nanmean(DATARef_s_benoit{1,4},1);
REF4S(3,:) = nanmean(DATARef_s_laetitia{1,4},1);
REF4S(4,:)  = nanmean(DATARef_s_sb130354{1,4},1);
REF4S(5,:)  = nanmean(DATARef_s_sd130343{1,4},1);
REF4S(6,:)  = nanmean(DATARef_s_wb120579{1,4},1);
REF4S(7,:)  = nanmean(DATARef_s_hm070076{1,4},1);
REF4Smean  = nanmean(REF4S);
REF4Sstd   = nanstd(REF4S);

REF5S(1,:) = nanmean(DATARef_s_karin{1,5},1);
REF5S(2,:) = nanmean(DATARef_s_benoit{1,5},1);
REF5S(3,:) = nanmean(DATARef_s_laetitia{1,5},1);
REF5S(4,:)  = nanmean(DATARef_s_sb130354{1,5},1);
REF5S(5,:)  = nanmean(DATARef_s_sd130343{1,5},1);
REF5S(6,:)  = nanmean(DATARef_s_wb120579{1,5},1);
REF5S(7,:)  = nanmean(DATARef_s_hm070076{1,5},1);
REF5Smean  = nanmean(REF5S);
REF5Sstd   = nanstd(REF5S);

REF6S(1,:) = nanmean(DATARef_s_karin{1,6},1);
REF6S(2,:) = nanmean(DATARef_s_benoit{1,6},1);
REF6S(3,:) = nanmean(DATARef_s_laetitia{1,6},1);
REF6S(4,:)  = nanmean(DATARef_s_sb130354{1,6},1);
REF6S(5,:)  = nanmean(DATARef_s_sd130343{1,6},1);
REF6S(6,:)  = nanmean(DATARef_s_wb120579{1,6},1);
REF6S(7,:)  = nanmean(DATARef_s_hm070076{1,6},1);
REF6Smean  = nanmean(REF6S);
REF6Sstd   = nanstd(REF6S);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

REF1T(1,:)  = nanmean(DATARef_t_karin{1,1},1);
REF1T(2,:)  = nanmean(DATARef_t_benoit{1,1},1);
REF1T(3,:)  = nanmean(DATARef_t_laetitia{1,1},1);
REF1T(4,:)  = nanmean(DATARef_t_sb130354{1,1},1);
REF1T(5,:)  = nanmean(DATARef_t_sd130343{1,1},1);
REF1T(6,:)  = nanmean(DATARef_t_wb120579{1,1},1);
REF1T(7,:)  = nanmean(DATARef_t_hm070076{1,1},1);
REF1Tmean   = nanmean(REF1T);
REF1Tstd    = nanstd(REF1T);

REF2T(1,:) = nanmean(DATARef_t_karin{1,2},1);
REF2T(2,:) = nanmean(DATARef_t_benoit{1,2},1);
REF2T(3,:) = nanmean(DATARef_t_laetitia{1,2},1);
REF2T(4,:) = nanmean(DATARef_t_sb130354{1,2},1);
REF2T(5,:) = nanmean(DATARef_t_sd130343{1,2},1);
REF2T(6,:) = nanmean(DATARef_t_wb120579{1,2},1);
REF2T(7,:) = nanmean(DATARef_t_hm070076{1,2},1);
REF2Tmean  = nanmean(REF2T);
REF2Tstd   = nanstd(REF2T);

REF3T(1,:) = nanmean(DATARef_t_karin{1,3},1);
REF3T(2,:) = nanmean(DATARef_t_benoit{1,3},1);
REF3T(3,:) = nanmean(DATARef_t_laetitia{1,3},1);
REF3T(4,:) = nanmean(DATARef_t_sb130354{1,3},1);
REF3T(5,:) = nanmean(DATARef_t_sd130343{1,3},1);
REF3T(6,:) = nanmean(DATARef_t_wb120579{1,3},1);
REF3T(7,:) = nanmean(DATARef_t_hm070076{1,3},1);
REF3Tmean  = nanmean(REF3T);
REF3Tstd   = nanstd(REF3T);

REF4T(1,:) = nanmean(DATARef_t_karin{1,4},1);
REF4T(2,:) = nanmean(DATARef_t_benoit{1,4},1);
REF4T(3,:) = nanmean(DATARef_t_laetitia{1,4},1);
REF4T(4,:) = nanmean(DATARef_t_sb130354{1,4},1);
REF4T(5,:) = nanmean(DATARef_t_sd130343{1,4},1);
REF4T(6,:) = nanmean(DATARef_t_wb120579{1,4},1);
REF4T(7,:) = nanmean(DATARef_t_hm070076{1,4},1);
REF4Tmean  = nanmean(REF4T);
REF4Tstd   = nanstd(REF4T);

REF5T(1,:) = nanmean(DATARef_t_karin{1,5},1);
REF5T(2,:) = nanmean(DATARef_t_benoit{1,5},1);
REF5T(3,:) = nanmean(DATARef_t_laetitia{1,5},1);
REF5T(4,:) = nanmean(DATARef_t_sb130354{1,5},1);
REF5T(5,:) = nanmean(DATARef_t_sd130343{1,5},1);
REF5T(6,:) = nanmean(DATARef_t_wb120579{1,5},1);
REF5T(7,:) = nanmean(DATARef_t_hm070076{1,5},1);
REF5Tmean  = nanmean(REF5T);
REF5Tstd   = nanstd(REF5T);

REF6T(1,:) = nanmean(DATARef_t_karin{1,6},1);
REF6T(2,:) = nanmean(DATARef_t_benoit{1,6},1);
REF6T(3,:) = nanmean(DATARef_t_laetitia{1,6},1);
REF6T(4,:) = nanmean(DATARef_t_sb130354{1,6},1);
REF6T(5,:) = nanmean(DATARef_t_sd130343{1,6},1);
REF6T(6,:) = nanmean(DATARef_t_wb120579{1,6},1);
REF6T(7,:) = nanmean(DATARef_t_hm070076{1,6},1);
REF6Tmean  = nanmean(REF6T);
REF6Tstd   = nanstd(REF6T);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

REF1Tmeansq = [(REF1Tmean(1:6))' (REF1Tmean(7:12))' (REF1Tmean(13:18))' ...
    (REF1Tmean(19:24))' (REF1Tmean(25:30))' (REF1Tmean(31:36))'];
REF2Tmeansq = [(REF2Tmean(1:6))' (REF2Tmean(7:12))' (REF2Tmean(13:18))' ...
    (REF2Tmean(19:24))' (REF2Tmean(25:30))' (REF2Tmean(31:36))'];
REF3Tmeansq = [(REF3Tmean(1:6))' (REF3Tmean(7:12))' (REF3Tmean(13:18))' ...
    (REF3Tmean(19:24))' (REF3Tmean(25:30))' (REF3Tmean(31:36))'];
REF4Tmeansq = [(REF4Tmean(1:6))' (REF4Tmean(7:12))' (REF4Tmean(13:18))' ...
    (REF4Tmean(19:24))' (REF4Tmean(25:30))' (REF4Tmean(31:36))'];
REF5Tmeansq = [(REF5Tmean(1:6))' (REF5Tmean(7:12))' (REF5Tmean(13:18))' ...
    (REF5Tmean(19:24))' (REF5Tmean(25:30))' (REF5Tmean(31:36))'];
REF6Tmeansq = [(REF6Tmean(1:6))' (REF6Tmean(7:12))' (REF6Tmean(13:18))' ...
    (REF6Tmean(19:24))' (REF6Tmean(25:30))' (REF6Tmean(31:36))'];

REF1Smeansq = [(REF1Smean(1:6))' (REF1Smean(7:12))' (REF1Smean(13:18))' ...
    (REF1Smean(19:24))' (REF1Smean(25:30))' (REF1Smean(31:36))'];
REF2Smeansq = [(REF2Smean(1:6))' (REF2Smean(7:12))' (REF2Smean(13:18))' ...
    (REF2Smean(19:24))' (REF2Smean(25:30))' (REF2Smean(31:36))'];
REF3Smeansq = [(REF3Smean(1:6))' (REF3Smean(7:12))' (REF3Smean(13:18))' ...
    (REF3Smean(19:24))' (REF3Smean(25:30))' (REF3Smean(31:36))'];
REF4Smeansq = [(REF4Smean(1:6))' (REF4Smean(7:12))' (REF4Smean(13:18))' ...
    (REF4Smean(19:24))' (REF4Smean(25:30))' (REF4Smean(31:36))'];
REF5Smeansq = [(REF5Smean(1:6))' (REF5Smean(7:12))' (REF5Smean(13:18))' ...
    (REF5Smean(19:24))' (REF5Smean(25:30))' (REF5Smean(31:36))'];
REF6Smeansq = [(REF6Smean(1:6))' (REF6Smean(7:12))' (REF6Smean(13:18))' ...
    (REF6Smean(19:24))' (REF6Smean(25:30))' (REF6Smean(31:36))'];

REF1Tstdsq  = [(REF1Tstd(1:6))' (REF1Tstd(7:12))' (REF1Tstd(13:18))' ...
    (REF1Tstd(19:24))' (REF1Tstd(25:30))' (REF1Tstd(31:36))'];
REF2Tstdsq  = [(REF2Tstd(1:6))' (REF2Tstd(7:12))' (REF2Tstd(13:18))' ...
    (REF2Tstd(19:24))' (REF2Tstd(25:30))' (REF2Tstd(31:36))'];
REF3Tstdsq  = [(REF3Tstd(1:6))' (REF3Tstd(7:12))' (REF3Tstd(13:18))' ...
    (REF3Tstd(19:24))' (REF3Tstd(25:30))' (REF3Tstd(31:36))'];
REF4Tstdsq  = [(REF4Tstd(1:6))' (REF4Tstd(7:12))' (REF4Tstd(13:18))' ...
    (REF4Tstd(19:24))' (REF4Tstd(25:30))' (REF4Tstd(31:36))'];
REF5Tstdsq  = [(REF5Tstd(1:6))' (REF5Tstd(7:12))' (REF5Tstd(13:18))' ...
    (REF5Tstd(19:24))' (REF5Tstd(25:30))' (REF5Tstd(31:36))'];
REF6Tstdsq  = [(REF6Tstd(1:6))' (REF6Tstd(7:12))' (REF6Tstd(13:18))' ...
    (REF6Tstd(19:24))' (REF6Tstd(25:30))' (REF6Tstd(31:36))'];

REF1Sstdsq  = [(REF1Sstd(1:6))' (REF1Sstd(7:12))' (REF1Sstd(13:18))' ...
    (REF1Sstd(19:24))' (REF1Sstd(25:30))' (REF1Sstd(31:36))'];
REF2Sstdsq  = [(REF2Sstd(1:6))' (REF2Sstd(7:12))' (REF2Sstd(13:18))' ...
    (REF2Sstd(19:24))' (REF2Sstd(25:30))' (REF2Sstd(31:36))'];
REF3Sstdsq  = [(REF3Sstd(1:6))' (REF3Sstd(7:12))' (REF3Sstd(13:18))' ...
    (REF3Sstd(19:24))' (REF3Sstd(25:30))' (REF3Sstd(31:36))'];
REF4Sstdsq  = [(REF4Sstd(1:6))' (REF4Sstd(7:12))' (REF4Sstd(13:18))' ...
    (REF4Sstd(19:24))' (REF4Sstd(25:30))' (REF4Sstd(31:36))'];
REF5Sstdsq  = [(REF5Sstd(1:6))' (REF5Sstd(7:12))' (REF5Sstd(13:18))' ...
    (REF5Sstd(19:24))' (REF5Sstd(25:30))' (REF5Sstd(31:36))'];
REF6Sstdsq  = [(REF6Sstd(1:6))' (REF6Sstd(7:12))' (REF6Sstd(13:18))' ...
    (REF6Sstd(19:24))' (REF6Sstd(25:30))' (REF6Sstd(31:36))'];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 800 500]);
set(fig1,'PaperPosition',[1 1 800 500])
set(fig1,'PaperPositionmode','auto')

subplot(2,3,1); imagesc(REF1Smeansq,[0 1]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');
subplot(2,3,2); imagesc(REF2Smeansq,[0 1]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');
subplot(2,3,3); imagesc(REF3Smeansq,[0 1]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');
subplot(2,3,4); imagesc(REF4Smeansq,[0 1]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');
subplot(2,3,5); imagesc(REF5Smeansq,[0 1]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');
subplot(2,3,6); imagesc(REF6Smeansq,[0 1]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');

print('-dpng',['C:\MTT_MEG\results\FULL_ER_MT_MEG_PSYCHO_SPACE_3rd_merge'])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 800 500]);
set(fig1,'PaperPosition',[1 1 800 500])
set(fig1,'PaperPositionmode','auto')

subplot(2,3,1); imagesc(REF1Tmeansq,[0 1]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');
subplot(2,3,2); imagesc(REF2Tmeansq,[0 1]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');
subplot(2,3,3); imagesc(REF3Tmeansq,[0 1]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');
subplot(2,3,4); imagesc(REF4Tmeansq,[0 1]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');
subplot(2,3,5); imagesc(REF5Tmeansq,[0 1]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');
subplot(2,3,6); imagesc(REF6Tmeansq,[0 1]);
set(gca,'Ytick',1:6,'Yticklabel',{'-3','-2','-1','1','2','3'});ylabel('Time');
set(gca,'Xtick',1:6,'Xticklabel',{'-3','-2','-1','1','2','3'});xlabel('Space');

print('-dpng',['C:\MTT_MEG\results\FULL_ER_MT_MEG_PSYCHO_TIME_3rd_merge'])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 800 500]);
set(fig1,'PaperPosition',[1 1 800 500])
set(fig1,'PaperPositionmode','auto')

subplot(2,3,1)
bar(1:6,nanmean(REF1Tmeansq'),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-2 -1 1 2 3 4]);hold on
errorbar(1:6,nanmean(REF1Tmeansq'),nanstd(REF1Tmeansq')./sqrt(6),'linestyle','none','color','k')
subplot(2,3,2)
bar(1:6,nanmean(REF2Tmeansq'),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(REF2Tmeansq'),nanstd(REF2Tmeansq')./sqrt(6),'linestyle','none','color','k')
subplot(2,3,3)
bar(1:6,nanmean(REF3Tmeansq'),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-4 -3 -2 -1 1 2]);hold on
errorbar(1:6,nanmean(REF3Tmeansq'),nanstd(REF3Tmeansq')./sqrt(6),'linestyle','none','color','k')
subplot(2,3,4)
bar(1:6,nanmean(REF4Tmeansq'),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(REF4Tmeansq'),nanstd(REF4Tmeansq')./sqrt(6),'linestyle','none','color','k')
subplot(2,3,5)
bar(1:6,nanmean(REF5Tmeansq'),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(REF5Tmeansq'),nanstd(REF5Tmeansq')./sqrt(6),'linestyle','none','color','k')
subplot(2,3,6)
bar(1:6,nanmean(REF6Tmeansq'),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(REF6Tmeansq'),nanmean(REF6Tmeansq')./sqrt(6),'linestyle','none','color','k')

print('-dpng','C:\MTT_MEG\results\MEAN_ER_MT_MEG_PSYCHO_TIME_merge_3rd')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 800 500]);
set(fig1,'PaperPosition',[1 1 800 500])
set(fig1,'PaperPositionmode','auto')

subplot(2,3,1)
bar(1:6,nanmean(REF1Smeansq),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-2 -1 1 2 3 4]);hold on
errorbar(1:6,nanmean(REF1Smeansq),nanstd(REF1Smeansq)./sqrt(6),'linestyle','none','color','k')
subplot(2,3,2)
bar(1:6,nanmean(REF2Smeansq),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(REF2Smeansq),nanstd(REF2Smeansq)./sqrt(6),'linestyle','none','color','k')
subplot(2,3,3)
bar(1:6,nanmean(REF3Smeansq),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-4 -3 -2 -1 1 2]);hold on
errorbar(1:6,nanmean(REF3Smeansq),nanstd(REF3Smeansq)./sqrt(6),'linestyle','none','color','k')
subplot(2,3,4)
bar(1:6,nanmean(REF4Smeansq),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(REF4Smeansq),nanstd(REF4Smeansq)./sqrt(6),'linestyle','none','color','k')
subplot(2,3,5)
bar(1:6,nanmean(REF5Smeansq),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(REF5Smeansq),nanstd(REF5Smeansq)./sqrt(6),'linestyle','none','color','k')
subplot(2,3,6)
bar(1:6,nanmean(REF6Smeansq),'FaceColor',[0.5 0.5 0.5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);hold on
errorbar(1:6,nanmean(REF6Smeansq),nanmean(REF6Smeansq)./sqrt(6),'linestyle','none','color','k')

print('-dpng','C:\MTT_MEG\results\MEAN_ER_MT_MEG_PSYCHO_SPACE_merge_3rd')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 800 800]);
set(fig1,'PaperPosition',[1 1 800 800])
set(fig1,'PaperPositionmode','auto')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PAST %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (DATE(:)-ones(36,1)*(2004));
AbsXaxis = abs((DATE(:)-ones(36,1)*(2004))); Yaxis = REF1Tmeansq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis REF1Tstdsq(:)]);
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
errorbar(Xaxis', REF1Tmeansq(:)', REF1Tstdsq(:)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
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

coef3T(1) = P3(1);
coef4T(1) = P4(1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PRESENT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (DATE(:)-ones(36,1)*(2013));
AbsXaxis = abs((DATE(:)-ones(36,1)*(2013))); Yaxis = REF2Tmeansq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis REF2Tstdsq(:)]);
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
errorbar(Xaxis', REF2Tmeansq(:)', REF2Tstdsq(:)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
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

coef3T(2) = P3(1);
coef4T(2) = P4(1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FUTURE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (DATE(:)-ones(36,1)*(2022));
AbsXaxis = abs((DATE(:)-ones(36,1)*(2022))); Yaxis = REF3Tmeansq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis REF3Tstdsq(:)]);
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
errorbar(Xaxis', REF3Tmeansq(:)', REF3Tstdsq(:)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
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

print('-dpng',['C:\MTT_MEG\results\REGRESS_TIME_ER_MT_MEG_PSYCHO_TIME_3rd_merge'])

coef3T(3) = P3(1);
coef4T(3) = P4(1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 800 800]);
set(fig1,'PaperPosition',[1 1 800 800])
set(fig1,'PaperPositionmode','auto')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% WEST %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (DATE(:)-ones(36,1)*(2013));
AbsXaxis = abs((DATE(:)-ones(36,1)*(2013))); Yaxis = REF5Tmeansq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis REF5Tstdsq(:)]);
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
errorbar(Xaxis', REF5Tmeansq(:)', REF5Tstdsq(:)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
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

coef3T(4) = P3(1);
coef4T(4) = P4(1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PARIS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (DATE(:)-ones(36,1)*(2013));
AbsXaxis = abs((DATE(:)-ones(36,1)*(2013))); Yaxis = REF6Tmeansq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis REF6Tstdsq(:)]);
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
errorbar(Xaxis', REF6Tmeansq(:)', REF6Tstdsq(:)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
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

coef3T(5) = P3(1);
coef4T(5) = P4(1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% East %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (DATE(:)-ones(36,1)*(2013));
AbsXaxis = abs((DATE(:)-ones(36,1)*(2013))); Yaxis = REF4Tmeansq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis REF4Tstdsq(:)]);
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
errorbar(Xaxis', REF4Tmeansq(:)', REF4Tstdsq(:)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
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

coef3T(6) = P3(1);
coef4T(6) = P4(1);

print('-dpng',['C:\MTT_MEG\results\REGRESS_SPACE_ER_MT_MEG_PSYCHO_TIME_3rd_merge'])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 800 800]);
set(fig1,'PaperPosition',[1 1 800 800])
set(fig1,'PaperPositionmode','auto')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% WEST %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (LONG(:)-ones(36,1)*(-52.3));
AbsXaxis = abs((LONG(:)-ones(36,1)*(-52.3))); Yaxis = REF1Smeansq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis REF1Sstdsq(:)]);
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
errorbar(Xaxis', REF1Smeansq(:)', REF1Sstdsq(:)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
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

coef3S(1) = P3(1);
coef4S(1) = P4(1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PARIS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (LONG(:)-ones(36,1)*(2.3));
AbsXaxis = abs((LONG(:)-ones(36,1)*(2.3))); Yaxis = REF2Smeansq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis REF2Sstdsq(:)]);
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
errorbar(Xaxis', REF2Smeansq(:)', REF2Sstdsq(:)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
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

coef3S(2) = P3(1);
coef4S(2) = P4(1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FUTURE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (LONG(:)-ones(36,1)*(55.3));
AbsXaxis = abs((LONG(:)-ones(36,1)*(55.3))); Yaxis = REF3Smeansq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis REF3Sstdsq(:)]);
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
errorbar(Xaxis', REF3Smeansq(:)', REF3Sstdsq(:)'./sqrt(length(6)),'linestyle','none','marker','.','markersize',20); hold on;
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

print('-dpng',['C:\MTT_MEG\results\REGRESS_SPACE_ER_MT_MEG_PSYCHO_TIME_3rd_merge'])

coef3S(3) = P3(1);
coef4S(3) = P4(1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 800 800]);
set(fig1,'PaperPosition',[1 1 800 800])
set(fig1,'PaperPositionmode','auto')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% WEST %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (LONG(:)-ones(36,1)*(-52.3));
AbsXaxis = abs((LONG(:)-ones(36,1)*(-52.3))); Yaxis = REF5Smeansq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis REF5Sstdsq(:)]);
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
errorbar(Xaxis', REF5Smeansq(:)', REF5Sstdsq(:)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
line([0 0],[0 1],'linestyle','--','linewidth',2,'color','k'); hold on;
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

coef3S(4) = P3(1);
coef4S(4) = P4(1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PARIS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (LONG(:)-ones(36,1)*(2.3));
AbsXaxis = abs((LONG(:)-ones(36,1)*(2.3))); Yaxis = REF6Smeansq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis REF6Sstdsq(:)]);
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

P1 = polyfit(tmpB(:,1),tmpB(:,2),1);            Y1 = polyval(P1,-160:0.1:-0.1);
P2 = polyfit(tmpA(:,1),tmpA(:,2),1);            Y2 = polyval(P2,0.1:0.1:160);
P3 = polyfit(NormTmp(:,1),NormTmp(:,2),1);      Y3 = polyval(P3,0.1:0.1:160);
P4 = polyfit(log(NormTmp(:,1)),NormTmp(:,2),1); Y4 = polyval(P4,log(0.1:0.1:160));

subplot(3,3,[4 5])
errorbar(Xaxis', REF6Smeansq(:)', REF6Sstdsq(:)'./sqrt(6),'linestyle','none','marker','.','markersize',20); hold on;
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

coef3S(5) = P3(1);
coef4S(5) = P4(1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EAST %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xaxis = (LONG(:)-ones(36,1)*(55.3));
AbsXaxis = abs((LONG(:)-ones(36,1)*(55.3))); Yaxis = REF4Smeansq(:);
tmp  = sortrows([Xaxis Yaxis]);tmpstd = sortrows([Xaxis REF4Sstdsq(:)]);
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
errorbar(Xaxis', REF4Smeansq(:)', REF4Sstdsq(:)'./sqrt(length(6)),'linestyle','none','marker','.','markersize',20); hold on;
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

coef3S(6) = P3(1);
coef4S(6) = P4(1);

print('-dpng',['C:\MTT_MEG\results\REGRESS_SPACE_ER_MT_MEG_PSYCHO_SPACE_3rd_merge'])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% AVG RT
fig1 = figure('position',[1 1 500 300]);
set(fig1,'PaperPosition',[1 1 500 300])
set(fig1,'PaperPositionmode','auto')

bar([nanmean(nanmean(REF2Tmeansq)) nanmean(nanmean(REF1Tmeansq)) nanmean(nanmean(REF3Tmeansq)) ...
    0 nanmean(nanmean(REF5Tmeansq)) nanmean(nanmean(REF4Tmeansq)) nanmean(nanmean(REF6Tmeansq))],'facecolor',[0.5 0.5 0.5]);
set(gca,'xtick',1:7,'xticklabel',{'PrePar';'PasPar';'FutPar';'';'PrePar';'PreW';'PreE'}); hold on;
errorbar(1:7,[nanmean(nanmean(REF2Tmeansq)) nanmean(nanmean(REF1Tmeansq)) nanmean(nanmean(REF3Tmeansq)) ...
    0 nanmean(nanmean(REF5Tmeansq)) nanmean(nanmean(REF4Tmeansq)) nanmean(nanmean(REF6Tmeansq))],...
    [nanstd(REF2Tmeansq(:)) nanstd(REF1Tmeansq(:)) nanstd(REF3Tmeansq(:)) ...
    0 nanstd(REF5Tmeansq(:)) nanstd(REF4Tmeansq(:)) nanstd(REF6Tmeansq(:))]./sqrt(5),'linestyle','none','color','k');
ylabel('RT')
xticklabel_rotate([],45,[],'Fontsize',10)

fig1 = figure('position',[1 1 500 300]);
set(fig1,'PaperPosition',[1 1 500 300])
set(fig1,'PaperPositionmode','auto')

bar([nanmean(nanmean(REF2Smeansq)) nanmean(nanmean(REF1Smeansq)) nanmean(nanmean(REF3Smeansq)) ...
    0 nanmean(nanmean(REF5Smeansq)) nanmean(nanmean(REF4Smeansq)) nanmean(nanmean(REF6Smeansq))],'facecolor',[0.5 0.5 0.5]);
set(gca,'xtick',1:7,'xticklabel',{'PrePar';'PasPar';'FutPar';'';'PrePar';'PreW';'PreE'}); hold on;
errorbar(1:7,[nanmean(nanmean(REF2Smeansq)) nanmean(nanmean(REF1Smeansq)) nanmean(nanmean(REF3Smeansq)) ...
    0 nanmean(nanmean(REF5Smeansq)) nanmean(nanmean(REF4Smeansq)) nanmean(nanmean(REF6Smeansq))],...
    [nanstd(REF2Smeansq(:)) nanstd(REF1Smeansq(:)) nanstd(REF3Smeansq(:)) ...
    0 nanstd(REF5Smeansq(:)) nanstd(REF4Smeansq(:)) nanstd(REF6Smeansq(:))]./sqrt(5),'linestyle','none','color','k');
ylabel('RT')
xticklabel_rotate([],45,[],'Fontsize',10)

% AVG ER
fig1 = figure('position',[1 1 500 300]);
set(fig1,'PaperPosition',[1 1 500 300])
set(fig1,'PaperPositionmode','auto')

bar([nanmean(nanmean(REF2Tmeansq)) nanmean(nanmean(REF1Tmeansq)) nanmean(nanmean(REF3Tmeansq)) ...
    0 nanmean(nanmean(REF5Tmeansq)) nanmean(nanmean(REF4Tmeansq)) nanmean(nanmean(REF6Tmeansq))],'facecolor',[0.5 0.5 0.5]);
set(gca,'xtick',1:7,'xticklabel',{'PrePar';'PasPar';'FutPar';'';'PrePar';'PreW';'PreE'}); hold on;
errorbar(1:7,[nanmean(nanmean(REF2Tmeansq)) nanmean(nanmean(REF1Tmeansq)) nanmean(nanmean(REF3Tmeansq)) ...
    0 nanmean(nanmean(REF5Tmeansq)) nanmean(nanmean(REF4Tmeansq)) nanmean(nanmean(REF6Tmeansq))],...
    [nanstd(REF2Tmeansq(:)) nanstd(REF1Tmeansq(:)) nanstd(REF3Tmeansq(:)) ...
    0 nanstd(REF5Tmeansq(:)) nanstd(REF4Tmeansq(:)) nanstd(REF6Tmeansq(:))]./sqrt(5),'linestyle','none','color','k');
ylabel('RT')
xticklabel_rotate([],45,[],'Fontsize',10)

fig1 = figure('position',[1 1 500 300]);
set(fig1,'PaperPosition',[1 1 500 300])
set(fig1,'PaperPositionmode','auto')

bar([nanmean(nanmean(REF2Smeansq)) nanmean(nanmean(REF1Smeansq)) nanmean(nanmean(REF3Smeansq)) ...
    0 nanmean(nanmean(REF5Smeansq)) nanmean(nanmean(REF4Smeansq)) nanmean(nanmean(REF6Smeansq))],'facecolor',[0.5 0.5 0.5]);
set(gca,'xtick',1:7,'xticklabel',{'PrePar';'PasPar';'FutPar';'';'PrePar';'PreW';'PreE'}); hold on;
errorbar(1:7,[nanmean(nanmean(REF2Smeansq)) nanmean(nanmean(REF1Smeansq)) nanmean(nanmean(REF3Smeansq)) ...
    0 nanmean(nanmean(REF5Smeansq)) nanmean(nanmean(REF4Smeansq)) nanmean(nanmean(REF6Smeansq))],...
    [nanstd(REF2Smeansq(:)) nanstd(REF1Smeansq(:)) nanstd(REF3Smeansq(:)) ...
    0 nanstd(REF5Smeansq(:)) nanstd(REF4Smeansq(:)) nanstd(REF6Smeansq(:))]./sqrt(5),'linestyle','none','color','k');
ylabel('RT')
xticklabel_rotate([],45,[],'Fontsize',10)

%% AVG RT coeff
fig1 = figure('position',[1 1 1000 600]);
set(fig1,'PaperPosition',[1 1 1000 600])
set(fig1,'PaperPositionmode','auto')

subplot(2,2,1)
bar([coef3T([2 1 3]) 0 coef3T([5 4 6]) ],'facecolor',[0.5 0.5 0.5]); 
set(gca,'xtick',1:7,'xticklabel',{'PrePar';'PasPar';'FutPar';'';'Prepar';'PreW';'PreE'});
ylabel('lin slope')
xticklabel_rotate([],45,[],'Fontsize',10)
subplot(2,2,2)
bar([coef3S([2 1 3]) 0 coef3S([5 4 6]) ],'facecolor',[0.5 0.5 0.5]); 
set(gca,'xtick',1:7,'xticklabel',{'PrePar';'PasPar';'FutPar';'';'Prepar';'PreW';'PreE'}); 
ylabel('lin slope')
xticklabel_rotate([],45,[],'Fontsize',10)

subplot(2,2,3)
bar([coef4T([2 1 3 5 4 6]) ],'facecolor',[0.5 0.5 0.5]); ylabel('log slope')
set(gca,'xtick',1:6,'xticklabel',{'PrePar';'PasPar';'FutPar';'Prepar';'PreW';'PreE'});  
xticklabel_rotate([],45,[],'Fontsize',10)
subplot(2,2,4)
bar([coef4S([2 1 3 5 4 6]) ],'facecolor',[0.5 0.5 0.5]); ylabel('log slope')
set(gca,'xtick',1:6,'xticklabel',{'PrePar';'PasPar';'FutPar';'Prepar';'PreW';'PreE'});  
xticklabel_rotate([],45,[],'Fontsize',10)

%% AVG ER coeff
fig1 = figure('position',[1 1 1000 600]);
set(fig1,'PaperPosition',[1 1 1000 600])
set(fig1,'PaperPositionmode','auto')

subplot(2,2,1)
bar([coef3T([2 1 3]) 0 coef3T([5 4 6]) ],'facecolor',[0.5 0.5 0.5]); 
set(gca,'xtick',1:7,'xticklabel',{'PrePar';'PasPar';'FutPar';'';'Prepar';'PreW';'PreE'});
ylabel('lin slope')
xticklabel_rotate([],45,[],'Fontsize',10)
subplot(2,2,2)
bar([coef3S([2 1 3]) 0 coef3S([5 4 6]) ],'facecolor',[0.5 0.5 0.5]); 
set(gca,'xtick',1:7,'xticklabel',{'PrePar';'PasPar';'FutPar';'';'Prepar';'PreW';'PreE'}); 
ylabel('lin slope')
xticklabel_rotate([],45,[],'Fontsize',10)

subplot(2,2,3)
bar([coef4T([2 1 3 5 4 6]) ],'facecolor',[0.5 0.5 0.5]); ylabel('log slope')
set(gca,'xtick',1:6,'xticklabel',{'PrePar';'PasPar';'FutPar';'Prepar';'PreW';'PreE'});  
xticklabel_rotate([],45,[],'Fontsize',10)
subplot(2,2,4)
bar([coef4S([2 1 3 5 4 6]) ],'facecolor',[0.5 0.5 0.5]); ylabel('log slope')
set(gca,'xtick',1:6,'xticklabel',{'PrePar';'PasPar';'FutPar';'Prepar';'PreW';'PreE'});  
xticklabel_rotate([],45,[],'Fontsize',10)


