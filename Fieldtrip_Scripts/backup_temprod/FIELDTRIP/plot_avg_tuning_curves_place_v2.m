%% get average tuning curve
TFF_face_mean = cell(1,3);TFF_place_mean = cell(1,3);TFF_object_mean = cell(1,3);
TSF_face_mean = cell(1,3);TSF_place_mean = cell(1,3);TSF_object_mean = cell(1,3);
for i = 1:3
    for j = 1:5
        TFF_face_mean{i}(j,:)  = mean(Tfund_face{j}{1,i});
        TFF_place_mean{i}(j,:) = mean(Tfund_place{j}{1,i});
        TFF_object_mean{i}(j,:) = mean(Tfund_object{j}{1,i});
        TSF_face_mean{i}(j,:)  = mean(Tsha_face{j}{1,i});
        TSF_place_mean{i}(j,:) = mean(Tsha_place{j}{1,i});
        TSF_object_mean{i}(j,:) = mean(Tsha_object{j}{1,i});
    end
end

% mags fund tuning curve
loc = {'NorthEast';'NorthEast';'NorthEast';'NorthEast';'NorthEast';'NorthEast';'NorthEast';'NorthEast'};
fig1 = figure('position',[1 1 1000 1000]);
set(fig1,'PaperPosition',[1 1 1000 1000])
set(fig1,'PaperPositionmode','auto')
errorbar(log([50 83.3 100 150 200 300 400 600]),mean(TFF_place_mean{1,1}),std(TFF_place_mean{1,1})/sqrt(5),'k','linestyle','none','linewidth',3); hold on;
plot(log([50 83.3 100 150 200 300 400 600]),mean(TFF_place_mean{1,1}),'Color','k','linewidth',6,'marker','o','markerfacecolor','w','Markersize',15);
hold on; title('MAGS','FontSize',30);
set(gca,'xtick',log([50 83.3 100 150 200 300 400 600]),'xticklabel',[50 83.3 100 150 200 300 400 600],'LineWidth',3)
set(gca,'FontSize',30); axis([log(40) log(800) 0 3e-28]); xticklabel_rotate([],45,[],'Fontsize',30)
ylabel('power +- SE'); set(gca,'FontSize',30); xlabel('frame length (ms)'); set(gca,'Box','off')
print('-dpng','C:\RESONANCE_MEG\DATA\across_sub\place_fund_tuning_curve_mags_v2.png')

% grads1 fund tuning curve
loc = {'NorthEast';'NorthEast';'NorthEast';'NorthEast';'NorthEast';'NorthEast';'NorthEast';'NorthEast'};
fig1 = figure('position',[1 1 1000 1000]);
set(fig1,'PaperPosition',[1 1 1000 1000])
set(fig1,'PaperPositionmode','auto')
errorbar(log([50 83.3 100 150 200 300 400 600]),mean(TFF_place_mean{1,2}),std(TFF_place_mean{1,2})/sqrt(5),'k','linestyle','none','linewidth',3); hold on;
plot(log([50 83.3 100 150 200 300 400 600]),mean(TFF_place_mean{1,2}),'Color','k','linewidth',6,'marker','o','markerfacecolor','w','Markersize',15);
hold on; title('GRADS1','FontSize',30);
set(gca,'xtick',log([50 83.3 100 150 200 300 400 600]),'xticklabel',[50 83.3 100 150 200 300 400 600],'LineWidth',3)
set(gca,'FontSize',30); axis([log(40) log(800) 0 2.e-25]); xticklabel_rotate([],45,[],'Fontsize',30)
ylabel('power +- SE'); set(gca,'FontSize',30); xlabel('frame length (ms)'); set(gca,'Box','off')
print('-dpng','C:\RESONANCE_MEG\DATA\across_sub\place_fund_tuning_curve_grads1_v2.png')

% grads2 fund tuning curve
loc = {'NorthEast';'NorthEast';'NorthEast';'NorthEast';'NorthEast';'NorthEast';'NorthEast';'NorthEast'};
fig1 = figure('position',[1 1 1000 1000]);
set(fig1,'PaperPosition',[1 1 1000 1000])
set(fig1,'PaperPositionmode','auto')
errorbar(log([50 83.3 100 150 200 300 400 600]),mean(TFF_place_mean{1,3}),std(TFF_place_mean{1,3})/sqrt(5),'k','linestyle','none','linewidth',3); hold on;
plot(log([50 83.3 100 150 200 300 400 600]),mean(TFF_place_mean{1,3}),'Color','k','linewidth',6,'marker','o','markerfacecolor','w','Markersize',15);
hold on; title('GRADS2','FontSize',30);
set(gca,'xtick',log([50 83.3 100 150 200 300 400 600]),'xticklabel',[50 83.3 100 150 200 300 400 600],'LineWidth',3)
set(gca,'FontSize',30); axis([log(40) log(800) 0 2.e-25]); xticklabel_rotate([],45,[],'Fontsize',30)
ylabel('power +- SE'); set(gca,'FontSize',30); xlabel('frame length (ms)'); set(gca,'Box','off')
print('-dpng','C:\RESONANCE_MEG\DATA\across_sub\place_fund_tuning_curve_grads2_v2.png')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% mags sha tuning curve
loc = {'NorthEast';'NorthEast';'NorthEast';'NorthEast';'NorthEast';'NorthEast';'NorthEast';'NorthEast'};
fig1 = figure('position',[1 1 1000 1000]);
set(fig1,'PaperPosition',[1 1 1000 1000])
set(fig1,'PaperPositionmode','auto')
errorbar(log([50 83.3 100 150 200 300 400 600]),mean(TSF_place_mean{1,1}),std(TSF_place_mean{1,1})/sqrt(5),'k','linestyle','none','linewidth',3); hold on;
plot(log([50 83.3 100 150 200 300 400 600]),mean(TSF_place_mean{1,1}),'Color','k','linewidth',6,'marker','o','markerfacecolor','w','Markersize',15);
hold on; title('MAGS','FontSize',30);
set(gca,'xtick',log([50 83.3 100 150 200 300 400 600]),'xticklabel',[50 83.3 100 150 200 300 400 600],'LineWidth',3)
set(gca,'FontSize',30); axis([log(40) log(800) 0 8.e-28]); xticklabel_rotate([],45,[],'Fontsize',30)
ylabel('power +- SE'); set(gca,'FontSize',30); xlabel('frame length (ms)'); set(gca,'Box','off')
print('-dpng','C:\RESONANCE_MEG\DATA\across_sub\place_sha_tuning_curve_mags_v2.png')

% grads1 sha tuning curve
loc = {'NorthEast';'NorthEast';'NorthEast';'NorthEast';'NorthEast';'NorthEast';'NorthEast';'NorthEast'};
fig1 = figure('position',[1 1 1000 1000]);
set(fig1,'PaperPosition',[1 1 1000 1000])
set(fig1,'PaperPositionmode','auto')
errorbar(log([50 83.3 100 150 200 300 400 600]),mean(TSF_place_mean{1,2}),std(TSF_place_mean{1,2})/sqrt(5),'k','linestyle','none','linewidth',3); hold on;
plot(log([50 83.3 100 150 200 300 400 600]),mean(TSF_place_mean{1,2}),'Color','k','linewidth',6,'marker','o','markerfacecolor','w','Markersize',15);
hold on; title('GRADS1','FontSize',30);
set(gca,'xtick',log([50 83.3 100 150 200 300 400 600]),'xticklabel',[50 83.3 100 150 200 300 400 600],'LineWidth',3)
set(gca,'FontSize',30); axis([log(40) log(800) 0 4.e-25]); xticklabel_rotate([],45,[],'Fontsize',30)
ylabel('power +- SE'); set(gca,'FontSize',30); xlabel('frame length (ms)'); set(gca,'Box','off')
print('-dpng','C:\RESONANCE_MEG\DATA\across_sub\place_sha_tuning_curve_grads1_v2.png')

% grads2 sha tuning curve
loc = {'NorthEast';'NorthEast';'NorthEast';'NorthEast';'NorthEast';'NorthEast';'NorthEast';'NorthEast'};
fig1 = figure('position',[1 1 1000 1000]);
set(fig1,'PaperPosition',[1 1 1000 1000])
set(fig1,'PaperPositionmode','auto')
errorbar(log([50 83.3 100 150 200 300 400 600]),mean(TSF_place_mean{1,3}),std(TSF_place_mean{1,3})/sqrt(5),'k','linestyle','none','linewidth',3); hold on;
plot(log([50 83.3 100 150 200 300 400 600]),mean(TSF_place_mean{1,3}),'Color','k','linewidth',6,'marker','o','markerfacecolor','w','Markersize',15);
hold on; title('GRADS2','FontSize',30);
set(gca,'xtick',log([50 83.3 100 150 200 300 400 600]),'xticklabel',[50 83.3 100 150 200 300 400 600],'LineWidth',3)
set(gca,'FontSize',30); axis([log(40) log(800) 0 4.e-25]); xticklabel_rotate([],45,[],'Fontsize',30)
ylabel('power +- SE'); set(gca,'FontSize',30); xlabel('frame length (ms)'); set(gca,'Box','off')
print('-dpng','C:\RESONANCE_MEG\DATA\across_sub\place_sha_tuning_curve_grads2_v2.png')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Zscores
%% get average tuning curve
TFF_face_mean = cell(1,3);TFF_place_mean = cell(1,3);TFF_object_mean = cell(1,3);
TSF_face_mean = cell(1,3);TSF_place_mean = cell(1,3);TSF_object_mean = cell(1,3);
for i = 1:3
    for j = 1:5
        TFF_face_mean{i}(j,:)  = zscore(mean(Tfund_face{j}{1,i}));
        TFF_place_mean{i}(j,:) = zscore(mean(Tfund_place{j}{1,i}));
        TFF_object_mean{i}(j,:) = zscore(mean(Tfund_object{j}{1,i}));
        TSF_face_mean{i}(j,:)  = zscore(mean(Tsha_face{j}{1,i}));
        TSF_place_mean{i}(j,:) = zscore(mean(Tsha_place{j}{1,i}));
        TSF_object_mean{i}(j,:) = zscore(mean(Tsha_object{j}{1,i}));
    end
end

% fund tuning curve
loc = {'NorthEast';'NorthEast';'NorthEast';'NorthEast';'NorthEast';'NorthEast';'NorthEast';'NorthEast'};
fig1 = figure('position',[1 1 1000 1000]);
set(fig1,'PaperPosition',[1 1 1000 1000])
set(fig1,'PaperPositionmode','auto')

plot(log([50 83.3 100 150 200 300 400 600]),mean(TFF_place_mean{1,2}),'Color','r','linewidth',6,'marker','o','markerfacecolor','w','Markersize',15); hold on; 
plot(log([50 83.3 100 150 200 300 400 600]),mean(TFF_place_mean{1,1}),'Color','r','linewidth',6,'marker','o','markerfacecolor','w','Markersize',15,'linestyle',':'); hold on;
plot(log([50 83.3 100 150 200 300 400 600]),mean(TFF_place_mean{1,3}),'Color','r','linewidth',6,'marker','o','markerfacecolor','w','Markersize',15,'linestyle','--'); hold on;

errorbar(log([50 83.3 100 150 200 300 400 600]),mean(TFF_place_mean{1,1}),std(TFF_place_mean{1,1})/sqrt(5),'r','linestyle','none','linewidth',3); hold on;
errorbar(log([50 83.3 100 150 200 300 400 600]),mean(TFF_place_mean{1,3}),std(TFF_place_mean{1,3})/sqrt(5),'r','linestyle','none','linewidth',3); hold on;
errorbar(log([50 83.3 100 150 200 300 400 600]),mean(TFF_place_mean{1,2}),std(TFF_place_mean{1,2})/sqrt(5),'r','linestyle','none','linewidth',3); hold on;

legend('Mags','Grads1','Grad2')
set(gca,'xtick',log([50 83.3 100 150 200 300 400 600]),'xticklabel',[50 83.3 100 150 200 300 400 600],'LineWidth',3)
set(gca,'FontSize',30); axis([log(40) log(800) -2 2]); xticklabel_rotate([],45,[],'Fontsize',30)
ylabel('power +- SE'); set(gca,'FontSize',30); xlabel('frame length (ms)'); set(gca,'Box','off')
print('-dpng','C:\RESONANCE_MEG\DATA\across_sub\Z-FUND-PLACE-TUNING.png')

% sha tuning curve
loc = {'NorthEast';'NorthEast';'NorthEast';'NorthEast';'NorthEast';'NorthEast';'NorthEast';'NorthEast'};
fig1 = figure('position',[1 1 1000 1000]);
set(fig1,'PaperPosition',[1 1 1000 1000])
set(fig1,'PaperPositionmode','auto')

plot(log([50 83.3 100 150 200 300 400 600]),mean(TSF_place_mean{1,2}),'Color','r','linewidth',6,'marker','o','markerfacecolor','w','Markersize',15); hold on; 
plot(log([50 83.3 100 150 200 300 400 600]),mean(TSF_place_mean{1,1}),'Color','r','linewidth',6,'marker','o','markerfacecolor','w','Markersize',15,'linestyle',':'); hold on;
plot(log([50 83.3 100 150 200 300 400 600]),mean(TSF_place_mean{1,3}),'Color','r','linewidth',6,'marker','o','markerfacecolor','w','Markersize',15,'linestyle','--'); hold on;

errorbar(log([50 83.3 100 150 200 300 400 600]),mean(TSF_place_mean{1,1}),std(TSF_place_mean{1,1})/sqrt(5),'r','linestyle','none','linewidth',3); hold on;
errorbar(log([50 83.3 100 150 200 300 400 600]),mean(TSF_place_mean{1,3}),std(TSF_place_mean{1,3})/sqrt(5),'r','linestyle','none','linewidth',3); hold on;
errorbar(log([50 83.3 100 150 200 300 400 600]),mean(TSF_place_mean{1,2}),std(TSF_place_mean{1,2})/sqrt(5),'r','linestyle','none','linewidth',3); hold on;

legend('Mags','Grads1','Grad2')
set(gca,'xtick',log([50 83.3 100 150 200 300 400 600]),'xticklabel',[50 83.3 100 150 200 300 400 600],'LineWidth',3)
set(gca,'FontSize',30); axis([log(40) log(800) -2 2]); xticklabel_rotate([],45,[],'Fontsize',30)
ylabel('power +- SE'); set(gca,'FontSize',30); xlabel('frame length (ms)'); set(gca,'Box','off')
print('-dpng','C:\RESONANCE_MEG\DATA\across_sub\Z-SHA-PLACE-TUNING.png')

