
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

plot(log([50 83.3 100 150 200 300 400 600]),mean(TFF_face_mean{1,2}),'Color','k','linewidth',6,'marker','o','markerfacecolor','w','Markersize',15); hold on; 
plot(log([50 83.3 100 150 200 300 400 600]),mean(TFF_face_mean{1,1}),'Color','k','linewidth',6,'marker','o','markerfacecolor','w','Markersize',15,'linestyle',':'); hold on;
plot(log([50 83.3 100 150 200 300 400 600]),mean(TFF_face_mean{1,3}),'Color','k','linewidth',6,'marker','o','markerfacecolor','w','Markersize',15,'linestyle','--'); hold on;

errorbar(log([50 83.3 100 150 200 300 400 600]),mean(TFF_face_mean{1,1}),std(TFF_face_mean{1,1})/sqrt(5),'k','linestyle','none','linewidth',3); hold on;
errorbar(log([50 83.3 100 150 200 300 400 600]),mean(TFF_face_mean{1,3}),std(TFF_face_mean{1,3})/sqrt(5),'k','linestyle','none','linewidth',3); hold on;
errorbar(log([50 83.3 100 150 200 300 400 600]),mean(TFF_face_mean{1,2}),std(TFF_face_mean{1,2})/sqrt(5),'k','linestyle','none','linewidth',3); hold on;

legend('Mags','Grads1','Grad2')
set(gca,'xtick',log([50 83.3 100 150 200 300 400 600]),'xticklabel',[50 83.3 100 150 200 300 400 600],'LineWidth',3)
set(gca,'FontSize',30); axis([log(40) log(800) -2 2]); xticklabel_rotate([],45,[],'Fontsize',30)
ylabel('power +- SE'); set(gca,'FontSize',30); xlabel('frame length (ms)'); set(gca,'Box','off')
print('-dpng','C:\RESONANCE_MEG\DATA\across_sub\Z-FUND-FACE-TUNING.png')

% sha tuning curve
loc = {'NorthEast';'NorthEast';'NorthEast';'NorthEast';'NorthEast';'NorthEast';'NorthEast';'NorthEast'};
fig1 = figure('position',[1 1 1000 1000]);
set(fig1,'PaperPosition',[1 1 1000 1000])
set(fig1,'PaperPositionmode','auto')

plot(log([50 83.3 100 150 200 300 400 600]),mean(TSF_face_mean{1,2}),'Color','k','linewidth',6,'marker','o','markerfacecolor','w','Markersize',15); hold on; 
plot(log([50 83.3 100 150 200 300 400 600]),mean(TSF_face_mean{1,1}),'Color','k','linewidth',6,'marker','o','markerfacecolor','w','Markersize',15,'linestyle',':'); hold on;
plot(log([50 83.3 100 150 200 300 400 600]),mean(TSF_face_mean{1,3}),'Color','k','linewidth',6,'marker','o','markerfacecolor','w','Markersize',15,'linestyle','--'); hold on;

errorbar(log([50 83.3 100 150 200 300 400 600]),mean(TSF_face_mean{1,1}),std(TSF_face_mean{1,1})/sqrt(5),'k','linestyle','none','linewidth',3); hold on;
errorbar(log([50 83.3 100 150 200 300 400 600]),mean(TSF_face_mean{1,3}),std(TSF_face_mean{1,3})/sqrt(5),'k','linestyle','none','linewidth',3); hold on;
errorbar(log([50 83.3 100 150 200 300 400 600]),mean(TSF_face_mean{1,2}),std(TSF_face_mean{1,2})/sqrt(5),'k','linestyle','none','linewidth',3); hold on;

legend('Mags','Grads1','Grad2')
set(gca,'xtick',log([50 83.3 100 150 200 300 400 600]),'xticklabel',[50 83.3 100 150 200 300 400 600],'LineWidth',3)
set(gca,'FontSize',30); axis([log(40) log(800) -2 2]); xticklabel_rotate([],45,[],'Fontsize',30)
ylabel('power +- SE'); set(gca,'FontSize',30); xlabel('frame length (ms)'); set(gca,'Box','off')
print('-dpng','C:\RESONANCE_MEG\DATA\across_sub\Z-SHA-FACE-TUNING.png')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M_peak_face_fund_mags   = nanmean([cfund_face{1,1}(1) cfund_face{1,2}(1) cfund_face{1,3}(1) cfund_face{1,4}(1) cfund_face{1,5}(1)]);
S_peak_face_fund_mags   = nanstd([cfund_face{1,1}(1) cfund_face{1,2}(1) cfund_face{1,3}(1) cfund_face{1,4}(1) cfund_face{1,5}(1)])./sqrt(5);
M_peak_place_fund_mags  = nanmean([cfund_place{1,1}(1) cfund_place{1,2}(1) cfund_place{1,3}(1) cfund_place{1,4}(1) cfund_place{1,5}(1)]);
S_peak_place_fund_mags  = nanstd([cfund_place{1,1}(1) cfund_place{1,2}(1) cfund_place{1,3}(1) cfund_place{1,4}(1) cfund_place{1,5}(1)])./sqrt(5);
M_peak_object_fund_mags = nanmean([cfund_object{1,1}(1) cfund_object{1,2}(1) cfund_object{1,3}(1) cfund_object{1,4}(1) cfund_object{1,5}(1)]);
S_peak_object_fund_mags = nanstd([cfund_object{1,1}(1) cfund_object{1,2}(1) cfund_object{1,3}(1) cfund_object{1,4}(1) cfund_object{1,5}(1)])./sqrt(5);

M_peak_face_fund_grads1   = nanmean([cfund_face{1,1}(2) cfund_face{1,2}(2) cfund_face{1,3}(2) cfund_face{1,4}(2) cfund_face{1,5}(2)]);
S_peak_face_fund_grads1   = nanstd([cfund_face{1,1}(2) cfund_face{1,2}(2) cfund_face{1,3}(2) cfund_face{1,4}(2) cfund_face{1,5}(2)])./sqrt(5);
M_peak_place_fund_grads1  = nanmean([cfund_place{1,1}(2) cfund_place{1,2}(2) cfund_place{1,3}(2) cfund_place{1,4}(2) cfund_place{1,5}(2)]);
S_peak_place_fund_grads1  = nanstd([cfund_place{1,1}(2) cfund_place{1,2}(2) cfund_place{1,3}(2) cfund_place{1,4}(2) cfund_place{1,5}(2)])./sqrt(5);
M_peak_object_fund_grads1 = nanmean([cfund_object{1,1}(2) cfund_object{1,2}(2) cfund_object{1,3}(2) cfund_object{1,4}(2) cfund_object{1,5}(2)]);
S_peak_object_fund_grads1 = nanstd([cfund_object{1,1}(2) cfund_object{1,2}(2) cfund_object{1,3}(2) cfund_object{1,4}(2) cfund_object{1,5}(2)])./sqrt(5);

M_peak_face_fund_grads2   = nanmean([cfund_face{1,1}(3) cfund_face{1,2}(3) cfund_face{1,3}(3) cfund_face{1,4}(3) cfund_face{1,5}(3)]);
S_peak_face_fund_grads2   = nanstd([cfund_face{1,1}(3) cfund_face{1,2}(3) cfund_face{1,3}(3) cfund_face{1,4}(3) cfund_face{1,5}(3)])./sqrt(5);
M_peak_place_fund_grads2  = nanmean([cfund_place{1,1}(3) cfund_place{1,2}(3) cfund_place{1,3}(3) cfund_place{1,4}(3) cfund_place{1,5}(3)]);
S_peak_place_fund_grads2  = nanstd([cfund_place{1,1}(3) cfund_place{1,2}(3) cfund_place{1,3}(3) cfund_place{1,4}(3) cfund_place{1,5}(3)])./sqrt(5);
M_peak_object_fund_grads2 = nanmean([cfund_object{1,1}(3) cfund_object{1,2}(3) cfund_object{1,3}(3) cfund_object{1,4}(3) cfund_object{1,5}(3)]);
S_peak_object_fund_grads2 = nanstd([cfund_object{1,1}(3) cfund_object{1,2}(3) cfund_object{1,3}(3) cfund_object{1,4}(3) cfund_object{1,5}(3)])./sqrt(5);

% plot fund peak
fig1 = figure('position',[1 1 1000 1000]);
set(fig1,'PaperPosition',[1 1 1000 1000])
set(fig1,'PaperPositionmode','auto')

bar([[M_peak_face_fund_mags   M_peak_place_fund_mags   M_peak_object_fund_mags]' ...
     [M_peak_face_fund_grads1 M_peak_place_fund_grads1 M_peak_object_fund_grads1]' ...
     [M_peak_face_fund_grads2 M_peak_place_fund_grads2 M_peak_object_fund_grads2]']); hold on;
errorbar([0.8 1 1.2 1.8 2 2.2 2.8 3 3.2],[M_peak_face_fund_mags   M_peak_face_fund_grads1   M_peak_face_fund_grads2 ...
     M_peak_place_fund_mags   M_peak_place_fund_grads1   M_peak_place_fund_grads2 ...
     M_peak_object_fund_mags   M_peak_object_fund_grads1   M_peak_object_fund_grads2],...
     [S_peak_face_fund_mags   S_peak_face_fund_grads1   S_peak_face_fund_grads2 ...
     S_peak_place_fund_mags   S_peak_place_fund_grads1   S_peak_place_fund_grads2 ...
     S_peak_object_fund_mags   S_peak_object_fund_grads1   S_peak_object_fund_grads2]./sqrt(5),'linewidth',3,'color','k','linestyle','none')
set(gca,'box','off','linewidth',3) 
ylabel('pic (ms)','fontsize',30) 
set(gca,'xtick',[1 2 3],'xticklabel',{'visages','scènes','objets'},'fontsize',30) 
axis([0.5 3.5 0 300]) 
legend('Mags','Grads1','Grads2')
 
% plot sha peak
M_peak_face_sha_mags   = nanmean([csha_face{1,1}(1) csha_face{1,2}(1) csha_face{1,3}(1) csha_face{1,4}(1) csha_face{1,5}(1)]);
S_peak_face_sha_mags   = nanstd([csha_face{1,1}(1) csha_face{1,2}(1) csha_face{1,3}(1) csha_face{1,4}(1) csha_face{1,5}(1)])./sqrt(5);
M_peak_place_sha_mags  = nanmean([csha_place{1,1}(1) csha_place{1,2}(1) csha_place{1,3}(1) csha_place{1,4}(1) csha_place{1,5}(1)]);
S_peak_place_sha_mags  = nanstd([csha_place{1,1}(1) csha_place{1,2}(1) csha_place{1,3}(1) csha_place{1,4}(1) csha_place{1,5}(1)])./sqrt(5);
M_peak_object_sha_mags = nanmean([csha_object{1,1}(1) csha_object{1,2}(1) csha_object{1,3}(1) csha_object{1,4}(1) csha_object{1,5}(1)]);
S_peak_object_sha_mags = nanstd([csha_object{1,1}(1) csha_object{1,2}(1) csha_object{1,3}(1) csha_object{1,4}(1) csha_object{1,5}(1)])./sqrt(5);

M_peak_face_sha_grads1   = nanmean([csha_face{1,1}(2) csha_face{1,2}(2) csha_face{1,3}(2) csha_face{1,4}(2) csha_face{1,5}(2)]);
S_peak_face_sha_grads1   = nanstd([csha_face{1,1}(2) csha_face{1,2}(2) csha_face{1,3}(2) csha_face{1,4}(2) csha_face{1,5}(2)])./sqrt(5);
M_peak_place_sha_grads1  = nanmean([csha_place{1,1}(2) csha_place{1,2}(2) csha_place{1,3}(2) csha_place{1,4}(2) csha_place{1,5}(2)]);
S_peak_place_sha_grads1  = nanstd([csha_place{1,1}(2) csha_place{1,2}(2) csha_place{1,3}(2) csha_place{1,4}(2) csha_place{1,5}(2)])./sqrt(5);
M_peak_object_sha_grads1 = nanmean([csha_object{1,1}(2) csha_object{1,2}(2) csha_object{1,3}(2) csha_object{1,4}(2) csha_object{1,5}(2)]);
S_peak_object_sha_grads1 = nanstd([csha_object{1,1}(2) csha_object{1,2}(2) csha_object{1,3}(2) csha_object{1,4}(2) csha_object{1,5}(2)])./sqrt(5);

M_peak_face_sha_grads2   = nanmean([csha_face{1,1}(3) csha_face{1,2}(3) csha_face{1,3}(3) csha_face{1,4}(3) csha_face{1,5}(3)]);
S_peak_face_sha_grads2   = nanstd([csha_face{1,1}(3) csha_face{1,2}(3) csha_face{1,3}(3) csha_face{1,4}(3) csha_face{1,5}(3)])./sqrt(5);
M_peak_place_sha_grads2  = nanmean([csha_place{1,1}(3) csha_place{1,2}(3) csha_place{1,3}(3) csha_place{1,4}(3) csha_place{1,5}(3)]);
S_peak_place_sha_grads2  = nanstd([csha_place{1,1}(3) csha_place{1,2}(3) csha_place{1,3}(3) csha_place{1,4}(3) csha_place{1,5}(3)])./sqrt(5);
M_peak_object_sha_grads2 = nanmean([csha_object{1,1}(3) csha_object{1,2}(3) csha_object{1,3}(3) csha_object{1,4}(3) csha_object{1,5}(3)]);
S_peak_object_sha_grads2 = nanstd([csha_object{1,1}(3) csha_object{1,2}(3) csha_object{1,3}(3) csha_object{1,4}(3) csha_object{1,5}(3)])./sqrt(5);


fig1 = figure('position',[1 1 1000 1000]);
set(fig1,'PaperPosition',[1 1 1000 1000])
set(fig1,'PaperPositionmode','auto')

bar([[M_peak_face_sha_mags   M_peak_place_sha_mags   M_peak_object_sha_mags]' ...
     [M_peak_face_sha_grads1 M_peak_place_sha_grads1 M_peak_object_sha_grads1]' ...
     [M_peak_face_sha_grads2 M_peak_place_sha_grads2 M_peak_object_sha_grads2]']); hold on;
errorbar([0.8 1 1.2 1.8 2 2.2 2.8 3 3.2],[M_peak_face_sha_mags   M_peak_face_sha_grads1   M_peak_face_sha_grads2 ...
     M_peak_place_sha_mags   M_peak_place_sha_grads1   M_peak_place_sha_grads2 ...
     M_peak_object_sha_mags   M_peak_object_sha_grads1   M_peak_object_sha_grads2],...
     [S_peak_face_sha_mags   S_peak_face_sha_grads1   S_peak_face_sha_grads2 ...
     S_peak_place_sha_mags   S_peak_place_sha_grads1   S_peak_place_sha_grads2 ...
     S_peak_object_sha_mags   S_peak_object_sha_grads1   S_peak_object_sha_grads2]./sqrt(5),'linewidth',3,'color','k','linestyle','none')
set(gca,'box','off','linewidth',3) 
ylabel('pic (ms)','fontsize',30) 
set(gca,'xtick',[1 2 3],'xticklabel',{'visages','scènes','objets'},'fontsize',30) 
axis([0.5 3.5 0 250]) 
legend('Mags','Grads1','Grads2') 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

PEAKS = [cfund_face{1,1}(1)   cfund_face{1,2}(1)   cfund_face{1,3}(1)   cfund_face{1,4}(1)   cfund_face{1,5}(1) ...
         cfund_place{1,1}(1)  cfund_place{1,2}(1)  cfund_place{1,3}(1)  cfund_place{1,4}(1)  cfund_place{1,5}(1) ...
         cfund_object{1,1}(1) cfund_object{1,2}(1) cfund_object{1,3}(1) cfund_object{1,4}(1) cfund_object{1,5}(1) ...
         cfund_face{1,1}(2)   cfund_face{1,2}(2)   cfund_face{1,3}(2)   cfund_face{1,4}(2)   cfund_face{1,5}(2) ...
         cfund_place{1,1}(2)  cfund_place{1,2}(2)  cfund_place{1,3}(2)  cfund_place{1,4}(2)  cfund_place{1,5}(2) ...
         cfund_object{1,1}(2) cfund_object{1,2}(2) cfund_object{1,3}(2) cfund_object{1,4}(2) cfund_object{1,5}(2) ...
         cfund_face{1,1}(3)   cfund_face{1,2}(3)   cfund_face{1,3}(3)   cfund_face{1,4}(3)   cfund_face{1,5}(3) ...
         cfund_place{1,1}(3)  cfund_place{1,2}(3)  cfund_place{1,3}(3)  cfund_place{1,4}(3)  cfund_place{1,5}(3) ...
         cfund_object{1,1}(3) cfund_object{1,2}(3) cfund_object{1,3}(3) cfund_object{1,4}(3) cfund_object{1,5}(3) ... 
         cfund_face{1,1}(1)   csha_face{1,2}(1)   csha_face{1,3}(1)   csha_face{1,4}(1)   csha_face{1,5}(1) ...
         csha_place{1,1}(1)  csha_place{1,2}(1)  csha_place{1,3}(1)  csha_place{1,4}(1)  csha_place{1,5}(1) ...
         csha_object{1,1}(1) csha_object{1,2}(1) csha_object{1,3}(1) csha_object{1,4}(1) csha_object{1,5}(1) ...
         csha_face{1,1}(2)   csha_face{1,2}(2)   csha_face{1,3}(2)   csha_face{1,4}(2)   csha_face{1,5}(2) ...
         csha_place{1,1}(2)  csha_place{1,2}(2)  csha_place{1,3}(2)  csha_place{1,4}(2)  csha_place{1,5}(2) ...
         csha_object{1,1}(2) csha_object{1,2}(2) csha_object{1,3}(2) csha_object{1,4}(2) csha_object{1,5}(2) ...
         csha_face{1,1}(3)   csha_face{1,2}(3)   csha_face{1,3}(3)   csha_face{1,4}(3)   csha_face{1,5}(3) ...
         csha_place{1,1}(3)  csha_place{1,2}(3)  csha_place{1,3}(3)  csha_place{1,4}(3)  csha_place{1,5}(3) ...
         csha_object{1,1}(3) csha_object{1,2}(3) csha_object{1,3}(3) csha_object{1,4}(3) csha_object{1,5}(3)]';       
SUB      = repmat((1:5)',18,1); 
CHAN     = [ones(1,15) ones(1,15)*2 ones(1,15)*3 ones(1,15) ones(1,15)*2 ones(1,15)*3]';
FS       = [ones(1,45) ones(1,45)*2]';
STIM     = repmat([ones(1,5) ones(1,5)*2 ones(1,5)*3]',6,1);

% write results in a text file
file = ['C:\RESONANCE_MEG\DATA\for_R\peaks_selchan.txt'];
fileID = fopen(file,'w');

DATAforR1 = []; DATAforR2 = [];
% cell-array
DATAforR1 = [PEAKS SUB CHAN FS STIM];
DATAforR2{1,1} = 'PEAKS';
DATAforR2{1,2} = 'SUB';
DATAforR2{1,3} = 'CHAN';
DATAforR2{1,4} = 'FS';
DATAforR2{1,5} = 'STIM';

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
SSRP = [mean(Tfund_face{1,1}{1,1}) mean(Tfund_face{1,2}{1,1}) mean(Tfund_face{1,3}{1,1}) mean(Tfund_face{1,4}{1,1}) mean(Tfund_face{1,5}{1,1}) ...
        mean(Tfund_place{1,1}{1,1}) mean(Tfund_place{1,2}{1,1}) mean(Tfund_place{1,3}{1,1}) mean(Tfund_place{1,4}{1,1}) mean(Tfund_place{1,5}{1,1}) ...
        mean(Tfund_object{1,1}{1,1}) mean(Tfund_object{1,2}{1,1}) mean(Tfund_object{1,3}{1,1}) mean(Tfund_object{1,4}{1,1}) mean(Tfund_object{1,5}{1,1}) ...
        mean(Tfund_face{1,1}{1,2}) mean(Tfund_face{1,2}{1,2}) mean(Tfund_face{1,3}{1,2}) mean(Tfund_face{1,4}{1,2}) mean(Tfund_face{1,5}{1,2}) ...
        mean(Tfund_place{1,1}{1,2}) mean(Tfund_place{1,2}{1,2}) mean(Tfund_place{1,3}{1,2}) mean(Tfund_place{1,4}{1,2}) mean(Tfund_place{1,5}{1,2}) ...
        mean(Tfund_object{1,1}{1,2}) mean(Tfund_object{1,2}{1,2}) mean(Tfund_object{1,3}{1,2}) mean(Tfund_object{1,4}{1,2}) mean(Tfund_object{1,5}{1,2}) ...
        mean(Tfund_face{1,1}{1,3}) mean(Tfund_face{1,2}{1,3}) mean(Tfund_face{1,3}{1,3}) mean(Tfund_face{1,4}{1,3}) mean(Tfund_face{1,5}{1,3}) ...
        mean(Tfund_place{1,1}{1,3}) mean(Tfund_place{1,2}{1,3}) mean(Tfund_place{1,3}{1,3}) mean(Tfund_place{1,4}{1,3}) mean(Tfund_place{1,5}{1,3}) ...
        mean(Tfund_object{1,1}{1,3}) mean(Tfund_object{1,2}{1,3}) mean(Tfund_object{1,3}{1,3}) mean(Tfund_object{1,4}{1,3}) mean(Tfund_object{1,5}{1,3}) ...
        mean(Tsha_face{1,1}{1,1}) mean(Tsha_face{1,2}{1,1}) mean(Tsha_face{1,3}{1,1}) mean(Tsha_face{1,4}{1,1}) mean(Tsha_face{1,5}{1,1}) ...
        mean(Tsha_place{1,1}{1,1}) mean(Tsha_place{1,2}{1,1}) mean(Tsha_place{1,3}{1,1}) mean(Tsha_place{1,4}{1,1}) mean(Tsha_place{1,5}{1,1}) ...
        mean(Tsha_object{1,1}{1,1}) mean(Tsha_object{1,2}{1,1}) mean(Tsha_object{1,3}{1,1}) mean(Tsha_object{1,4}{1,1}) mean(Tsha_object{1,5}{1,1}) ...
        mean(Tsha_face{1,1}{1,2}) mean(Tsha_face{1,2}{1,2}) mean(Tsha_face{1,3}{1,2}) mean(Tsha_face{1,4}{1,2}) mean(Tsha_face{1,5}{1,2}) ...
        mean(Tsha_place{1,1}{1,2}) mean(Tsha_place{1,2}{1,2}) mean(Tsha_place{1,3}{1,2}) mean(Tsha_place{1,4}{1,2}) mean(Tsha_place{1,5}{1,2}) ...
        mean(Tsha_object{1,1}{1,2}) mean(Tsha_object{1,2}{1,2}) mean(Tsha_object{1,3}{1,2}) mean(Tsha_object{1,4}{1,2}) mean(Tsha_object{1,5}{1,2}) ...
        mean(Tsha_face{1,1}{1,3}) mean(Tsha_face{1,2}{1,3}) mean(Tsha_face{1,3}{1,3}) mean(Tsha_face{1,4}{1,3}) mean(Tsha_face{1,5}{1,3}) ...
        mean(Tsha_place{1,1}{1,3}) mean(Tsha_place{1,2}{1,3}) mean(Tsha_place{1,3}{1,3}) mean(Tsha_place{1,4}{1,3}) mean(Tsha_place{1,5}{1,3}) ...
        mean(Tsha_object{1,1}{1,3}) mean(Tsha_object{1,2}{1,3}) mean(Tsha_object{1,3}{1,3}) mean(Tsha_object{1,4}{1,3}) mean(Tsha_object{1,5}{1,3})];
FREQ = repmat((1:8)',90,1);
SUB  = repmat([ones(1,8)*1 ones(1,8)*2 ones(1,8)*3 ones(1,8)*4 ones(1,8)*5]',18,1);
CHAN = [ones(1,120) ones(1,120)*2 ones(1,120)*3 ones(1,120) ones(1,120)*2 ones(1,120)*3]';
FS   = [ones(1,360) ones(1,360)*2]'; 
STIM = repmat([ones(1,40) ones(1,40)*2 ones(1,40)*3]',6,1);

% write results in a text file
file = ['C:\RESONANCE_MEG\DATA\for_R\SSRP_selchan.txt'];
fileID = fopen(file,'w');

DATAforR1 = []; DATAforR2 = [];
% cell-array
DATAforR1 = [SSRP' SUB FREQ CHAN FS STIM];
DATAforR2{1,1} = 'SSRP';
DATAforR2{1,2} = 'SUB';
DATAforR2{1,3} = 'FREQ';
DATAforR2{1,4} = 'CHAN';
DATAforR2{1,5} = 'FS';
DATAforR2{1,6} = 'STIM';

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

