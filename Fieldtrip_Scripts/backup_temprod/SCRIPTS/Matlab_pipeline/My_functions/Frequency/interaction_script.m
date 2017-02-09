function temprod_interaction(Sub)

%% Interaction

close all

tag            = 'Laptop';
tagdetrend     = 'nodetrend';
root           = SetPath(tag);
freqbandselect = [2 120];
subjects       = {Sub};

cond           = '2M_Est_5.7';
[xaxis,est_diff_57] = GDAVG_half_viewer_V3(subjects,[2 120],cond,tag);
cond           = '2M_Replay_5.7';
[xaxis,rep_diff_57] = GDAVG_half_viewer_V3(subjects,[2 120],cond,tag);
cond           = '2M_Est_8.5';
[xaxis,est_diff_85] = GDAVG_half_viewer_V3(subjects,[2 120],cond,tag);
cond           = '2M_Replay_8.5';
[xaxis,rep_diff_85] = GDAVG_half_viewer_V3(subjects,[2 120],cond,tag);

Interaction_57 = est_diff_57 - rep_diff_57;
Interaction_85 = est_diff_85 - rep_diff_85;

close all
% 5.7s
% mags
scrsz = get(0,'ScreenSize');
fig = figure('Position',[10 30 scrsz(3)/1.25 scrsz(4)/2.5]);
set(fig,'PaperPosition',[10 30 scrsz(3)/1.25 scrsz(4)/2.5]);
set(fig,'PaperPositionMode','auto');

subplot(1,3,1)
semilogx(xaxis,(Interaction_57(1,:)),'linewidth',2)
axis([min(xaxis) max(xaxis) min(Interaction_57(1,:)) max(Interaction_57(1,:))])
title([subjects{1} ' mags Est57(Long-Short) - Rep57(Long-Short)'])
set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
line([min(xaxis) max(xaxis)],[0 0],'color','k','linewidth',2)
grid('on')
xlabel('Frequency (Hz)'); ylabel('Power (fT)')
% grads1
subplot(1,3,2)
semilogx(xaxis,(Interaction_57(2,:)),'linewidth',2)
axis([min(xaxis) max(xaxis) min(Interaction_57(2,:)) max(Interaction_57(2,:))])
title([subjects{1} ' grads1 Est57(Long-Short) - Rep57(Long-Short)'])
set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
line([min(xaxis) max(xaxis)],[0 0],'color','k','linewidth',2)
grid('on')
% grads2
subplot(1,3,3)
semilogx(xaxis,(Interaction_57(3,:)),'linewidth',2)
axis([min(xaxis) max(xaxis) min(Interaction_57(3,:)) max(Interaction_57(3,:))])
title([subjects{1} ' grads2 Est57(Long-Short) - Rep57(Long-Short)'])
set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
line([min(xaxis) max(xaxis)],[0 0],'color','k','linewidth',2)
grid('on')

print('-dpng',TheSlasher([root '/DATA/NEW/across_subjects_plots' ...
        '/Est57(L-S)-Rep57(L-S)_' char(subjects) '_' num2str(freqbandselect(1)) '-' num2str(freqbandselect(2)) '_GAVG_' tagdetrend '_V3.png'],tag));
% 8.5s
% mags
scrsz = get(0,'ScreenSize');
fig = figure('Position',[10 30 scrsz(3)/1.25 scrsz(4)/2.5]);
set(fig,'PaperPosition',[10 30 scrsz(3)/1.25 scrsz(4)/2.5]);
set(fig,'PaperPositionMode','auto');

subplot(1,3,1)
semilogx(xaxis,(Interaction_85(1,:)),'linewidth',2)
axis([min(xaxis) max(xaxis) min(Interaction_85(1,:)) max(Interaction_85(1,:))])
title([subjects{1} ' mags Est85(Long-Short) - Rep85(Long-Short)'])
set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
line([min(xaxis) max(xaxis)],[0 0],'color','k','linewidth',2)
grid('on')
xlabel('Frequency (Hz)'); ylabel('Power (fT)')
% grads1
subplot(1,3,2)
semilogx(xaxis,(Interaction_85(2,:)),'linewidth',2)
axis([min(xaxis) max(xaxis) min(Interaction_85(2,:)) max(Interaction_85(2,:))])
title([subjects{1} ' grads1 Est85(Long-Short) - Rep85(Long-Short)'])
set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
line([min(xaxis) max(xaxis)],[0 0],'color','k','linewidth',2)
grid('on')
% grads2
subplot(1,3,3)
semilogx(xaxis,(Interaction_85(3,:)),'linewidth',2)
axis([min(xaxis) max(xaxis) min(Interaction_85(3,:)) max(Interaction_85(3,:))])
title([subjects{1} ' grads2 Est85(Long-Short) - Rep85(Long-Short)'])
set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
line([min(xaxis) max(xaxis)],[0 0],'color','k','linewidth',2)
grid('on')

print('-dpng',TheSlasher([root '/DATA/NEW/across_subjects_plots' ...
        '/Est85(L-S)-Rep85(L-S)_' char(subjects) '_' num2str(freqbandselect(1)) '-' num2str(freqbandselect(2)) '_GAVG_' tagdetrend '_V3.png'],tag));
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% quarter-cut data
%% Interaction
close all

tag            = 'Laptop';
tagdetrend     = '';
root           = SetPath(tag);
freqbandselect = [2 120];
subjects       = {Sub};

cond           = '2M_Est_5.7';
[xaxis,est_diff_57_4m1,est_diff_57_3m2] = GDAVG_quarter_viewer_V3(subjects,[2 120],cond,tag);
cond           = '2M_Replay_5.7';
[xaxis,rep_diff_57_4m1,rep_diff_57_3m2] = GDAVG_quarter_viewer_V3(subjects,[2 120],cond,tag);
cond           = '2M_Est_8.5';
[xaxis,est_diff_85_4m1,est_diff_85_3m2] = GDAVG_quarter_viewer_V3(subjects,[2 120],cond,tag);
cond           = '2M_Replay_8.5';
[xaxis,rep_diff_85_4m1,rep_diff_85_3m2] = GDAVG_quarter_viewer_V3(subjects,[2 120],cond,tag);

Interaction_57_4m1 = est_diff_57_4m1 - rep_diff_57_4m1;
Interaction_57_3m2 = est_diff_57_3m2 - rep_diff_57_3m2;
Interaction_85_4m1 = est_diff_85_4m1 - rep_diff_85_4m1;
Interaction_85_3m2 = est_diff_85_3m2 - rep_diff_85_3m2;

close all
% 5.7s
% mags
scrsz = get(0,'ScreenSize');
fig = figure('Position',[10 30 scrsz(3)/1.25 scrsz(4)/2.5]);
set(fig,'PaperPosition',[10 30 scrsz(3)/1.25 scrsz(4)/2.5]);
set(fig,'PaperPositionMode','auto');

subplot(1,3,1)
semilogx(xaxis,(Interaction_57_4m1(1,:)),'linewidth',2,'color','k')
hold on
semilogx(xaxis,(Interaction_57_3m2(1,:)),'linewidth',2,'color','r')
axis([min(xaxis) max(xaxis) min([Interaction_57_4m1(1,:) Interaction_57_3m2(1,:)])...
                            max([Interaction_57_4m1(1,:) Interaction_57_3m2(1,:)])]);
title([subjects{1} ' mags (Est57 - Rep57)'])
set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
line([min(xaxis) max(xaxis)],[0 0],'color','k','linewidth',2)
grid('on')
legend('Q4-Q1','Q3-Q2')
xlabel('Frequency (Hz)'); ylabel('Power (fT)')
% grads1
subplot(1,3,2)
semilogx(xaxis,(Interaction_57_4m1(2,:)),'linewidth',2,'color','k')
hold on
semilogx(xaxis,(Interaction_57_3m2(2,:)),'linewidth',2,'color','r')
axis([min(xaxis) max(xaxis) min([Interaction_57_4m1(2,:) Interaction_57_3m2(2,:)])...
                            max([Interaction_57_4m1(2,:) Interaction_57_3m2(2,:)])]);
title([subjects{1} ' grads1 (Est57 - Rep57)'])
set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
line([min(xaxis) max(xaxis)],[0 0],'color','k','linewidth',2)
grid('on')
legend('Q4-Q1','Q3-Q2')
% grads2
subplot(1,3,3)
semilogx(xaxis,(Interaction_57_4m1(3,:)),'linewidth',2,'color','k')
hold on
semilogx(xaxis,(Interaction_57_3m2(3,:)),'linewidth',2,'color','r')
axis([min(xaxis) max(xaxis) min([Interaction_57_4m1(3,:) Interaction_57_3m2(3,:)])...
                            max([Interaction_57_4m1(3,:) Interaction_57_3m2(3,:)])]);
title([subjects{1} ' grads2 (Est57 - Rep57)'])
set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
line([min(xaxis) max(xaxis)],[0 0],'color','k','linewidth',2)
grid('on')
legend('Q4-Q1','Q3-Q2')

print('-dpng',TheSlasher([root '/DATA/NEW/across_subjects_plots' ...
        '/Quarters(Est57-Rep57)_' char(subjects) '_' num2str(freqbandselect(1)) '-' num2str(freqbandselect(2)) '_GAVG_' tagdetrend '_V3.png'],tag));

close all
% 8.5s
% mags
scrsz = get(0,'ScreenSize');
fig = figure('Position',[10 30 scrsz(3)/1.25 scrsz(4)/2.5]);
set(fig,'PaperPosition',[10 30 scrsz(3)/1.25 scrsz(4)/2.5]);
set(fig,'PaperPositionMode','auto');

subplot(1,3,1)
semilogx(xaxis,(Interaction_85_4m1(1,:)),'linewidth',2,'color','k')
hold on
semilogx(xaxis,(Interaction_85_3m2(1,:)),'linewidth',2,'color','r')
axis([min(xaxis) max(xaxis) min([Interaction_85_4m1(1,:) Interaction_85_3m2(1,:)])...
                            max([Interaction_85_4m1(1,:) Interaction_85_3m2(1,:)])]);
title([subjects{1} ' mags (Est85 - Rep85)'])
set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
line([min(xaxis) max(xaxis)],[0 0],'color','k','linewidth',2)
grid('on')
legend('Q4-Q1','Q3-Q2')
xlabel('Frequency (Hz)'); ylabel('Power (fT)')
% grads1
subplot(1,3,2)
semilogx(xaxis,(Interaction_85_4m1(2,:)),'linewidth',2,'color','k')
hold on
semilogx(xaxis,(Interaction_85_3m2(2,:)),'linewidth',2,'color','r')
axis([min(xaxis) max(xaxis) min([Interaction_85_4m1(2,:) Interaction_85_3m2(2,:)])...
                            max([Interaction_85_4m1(2,:) Interaction_85_3m2(2,:)])]);
title([subjects{1} ' grads1 (Est85 - Rep85)'])
set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
line([min(xaxis) max(xaxis)],[0 0],'color','k','linewidth',2)
grid('on')
legend('Q4-Q1','Q3-Q2')
xlabel('Frequency (Hz)'); ylabel('Power (fT)')
% grads2
subplot(1,3,3)
semilogx(xaxis,(Interaction_85_4m1(3,:)),'linewidth',2,'color','k')
hold on
semilogx(xaxis,(Interaction_85_3m2(3,:)),'linewidth',2,'color','r')
axis([min(xaxis) max(xaxis) min([Interaction_85_4m1(3,:) Interaction_85_3m2(3,:)])...
                            max([Interaction_85_4m1(3,:) Interaction_85_3m2(3,:)])]);
title([subjects{1} ' grads2 (Est85 - Rep85)'])
set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
line([min(xaxis) max(xaxis)],[0 0],'color','k','linewidth',2)
grid('on')
legend('Q4-Q1','Q3-Q2')
xlabel('Frequency (Hz)'); ylabel('Power (fT)')

print('-dpng',TheSlasher([root '/DATA/NEW/across_subjects_plots' ...
        '/Quarters(Est85-Rep85)_' char(subjects) '_' num2str(freqbandselect(1)) '-' num2str(freqbandselect(2)) '_GAVG_' tagdetrend '_V3.png'],tag));
    
close all