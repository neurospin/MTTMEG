% temprod_BehaviorSummary(subject,RunNum,fsample,TD,savetag)
RunNum{1,14}    = [2 3 5 6];
fsample{1,14}   = [1000 1000 1000 1000];
TD{1,14}        = [5.7 8.5 5.7 8.5]; 
subject{1,14}   = 's14';
[Qm14, Qstd14, Rcorr14, Pcorr14] = temprod_BehaviorQuartile(subject{1,14},RunNum{1,14},'Laptop');

RunNum{1,13}    = [2 3 5 6];
fsample{1,13}   = [1000 1000 1000 1000];
TD{1,13}        = [5.7 8.5 5.7 8.5];  
subject{1,13}   = 's13';
[Qm13, Qstd13, Rcorr13, Pcorr13] = temprod_BehaviorQuartile(subject{1,13},RunNum{1,13},'Laptop');

RunNum{1,12}    = [2 3 5 6];
fsample{1,12}   = [1000 1000 1000 1000];
TD{1,12}        = [5.7 8.5 5.7 8.5];  
subject{1,12}   = 's12';
[Qm12, Qstd12, Rcorr12, Pcorr12] = temprod_BehaviorQuartile(subject{1,12},RunNum{1,12},'Laptop');

RunNum{1,11}    = [2 3 5];
fsample{1,11}   = [1000 1000 1000];
TD{1,11}        = [5.7 8.5 5.7];  
subject{1,11}   = 's12';
[Qm11, Qstd11, Rcorr11, Pcorr11] = temprod_BehaviorQuartile(subject{1,11},RunNum{1,11},'Laptop');

RunNum{1,10}    = [2 3 5 6];
fsample{1,10}   = [1000 1000 1000 1000];
TD{1,10}        = [5.7 8.5 5.7 8.5];  
subject{1,10}   = 's10';
[Qm10, Qstd10, Rcorr10, Pcorr10] = temprod_BehaviorQuartile_s10(subject{1,10},RunNum{1,10},'Laptop');

RunNum{1,8}     = 2:6;
fsample{1,8}    = [1 1 1 1 1]*1000; 
TD{1,8}         = [6.5 8.5 6.5 6.5 8.5]; 
subject{1,8}    = 's08';
[Qm8, Qstd8, Rcorr8, Pcorr8] = temprod_BehaviorQuartile(subject{1,8},RunNum{1,8},'Laptop');

RunNum{1,7}     = 1:6;
fsample{1,7}    = [2 2 1 1 1 1]*1000; 
TD{1,7}         = [6.5 8.5 6.5 6.5 8.5 8.5];  
subject{1,7}    = 's07';
[Qm7, Qstd7, Rcorr7, Pcorr7] = temprod_BehaviorQuartile(subject{1,7},RunNum{1,7},'Laptop');

RunNum{1,6}     = 1:4;
fsample{1,6}    = [1 1 1 1]*1000; 
TD{1,6}         = [6.5 8.5 6.5 8.5];  
subject{1,6}    = 's06';
[Qm6, Qstd6, Rcorr6, Pcorr6] = temprod_BehaviorQuartile(subject{1,6},RunNum{1,6},'Laptop');

RunNum{1,5}     = 1:3;
fsample{1,5}    = [1 1 1]*1000; 
TD{1,5}         = [6.5 8.5 6.5]; 
subject{1,5}    = 's05';
[Qm5, Qstd5, Rcorr5, Pcorr5] = temprod_BehaviorQuartile(subject{1,5},RunNum{1,5},'Laptop');

RunNum{1,4}     = 1:3;
fsample{1,4}    = [1 1 1]*1000; 
TD{1,4}         = [5.7 12.8 9.3];  
subject{1,4}    = 's04';
[Qm4, Qstd4, Rcorr4, Pcorr4] = temprod_BehaviorQuartile(subject{1,4},RunNum{1,4},'Laptop');

RunNum{1,3}     = 1:6;
fsample{1,3}    = [1 1 1 1 1 1]*1000; 
TD{1,3}         = [17.3 0.75 11.7 2.8 1.7 5.2];  
subject{1,3}    = 's03';
[Qm3, Qstd3, Rcorr3, Pcorr3] = temprod_BehaviorQuartile(subject{1,3},RunNum{1,3},'Laptop');

%%%%%%%

for i = 1:4
    Q_M8  = [(Qm8{1,1})' (Qm8{1,2})' (Qm8{1,3})' (Qm8{1,4})' (Qm8{1,5})']./repmat((fsample{1,8}),4,1)./repmat((TD{1,8}),4,1);
    Q_M7  = [(Qm7{1,1})' (Qm7{1,2})' (Qm7{1,3})' (Qm7{1,4})' (Qm7{1,5})' (Qm7{1,6})']./repmat((fsample{1,7}),4,1)./repmat((TD{1,7}),4,1);
    Q_M6  = [(Qm6{1,1})' (Qm6{1,2})' (Qm6{1,3})' (Qm6{1,4})']./repmat((fsample{1,6}),4,1)./repmat((TD{1,6}),4,1);
    Q_M5  = [(Qm5{1,1})' (Qm5{1,2})' (Qm5{1,3})']./repmat((fsample{1,5}),4,1)./repmat((TD{1,5}),4,1);
    Q_M14 = [(Qm14{1,1})' (Qm14{1,2})' (Qm14{1,3})' (Qm14{1,4})' ]./repmat((fsample{1,14}),4,1)./repmat((TD{1,14}),4,1);
    Q_M13 = [(Qm13{1,1})' (Qm13{1,2})' (Qm13{1,3})' (Qm13{1,4})' ]./repmat((fsample{1,13}),4,1)./repmat((TD{1,13}),4,1);
    Q_M12 = [(Qm12{1,1})' (Qm12{1,2})' (Qm12{1,3})' (Qm12{1,4})' ]./repmat((fsample{1,12}),4,1)./repmat((TD{1,12}),4,1);
    Q_M11 = [(Qm13{1,1})' (Qm13{1,2})' (Qm13{1,3})']./repmat((fsample{1,11}),4,1)./repmat((TD{1,11}),4,1);
    Q_M10 = [(Qm10{1,1})' (Qm10{1,2})' (Qm10{1,3})' (Qm10{1,4})' ]./repmat((fsample{1,10}),4,1)./repmat((TD{1,10}),4,1);
    
    Q_S8  = [(Qstd8{1,1})' (Qstd8{1,2})' (Qstd8{1,3})' (Qstd8{1,4})' (Qstd8{1,5})']./repmat((fsample{1,8}),4,1)./repmat((TD{1,8}),4,1);
    Q_S7  = [(Qstd7{1,1})' (Qstd7{1,2})' (Qstd7{1,3})' (Qstd7{1,4})' (Qstd7{1,5})' (Qstd7{1,6})']./repmat((fsample{1,7}),4,1)./repmat((TD{1,7}),4,1);
    Q_S6  = [(Qstd6{1,1})' (Qstd6{1,2})' (Qstd6{1,3})' (Qstd6{1,4})']./repmat((fsample{1,6}),4,1)./repmat((TD{1,6}),4,1);
    Q_S5  = [(Qstd5{1,1})' (Qstd5{1,2})' (Qstd5{1,3})']./repmat((fsample{1,5}),4,1)./repmat((TD{1,5}),4,1);
    Q_S14 = [(Qstd14{1,1})' (Qstd14{1,2})' (Qstd14{1,3})' (Qstd14{1,4})' ]./repmat((fsample{1,14}),4,1)./repmat((TD{1,14}),4,1);
    Q_S13 = [(Qstd13{1,1})' (Qstd13{1,2})' (Qstd13{1,3})' (Qstd13{1,4})' ]./repmat((fsample{1,13}),4,1)./repmat((TD{1,13}),4,1);
    Q_S12 = [(Qstd12{1,1})' (Qstd12{1,2})' (Qstd12{1,3})' (Qstd12{1,4})' ]./repmat((fsample{1,12}),4,1)./repmat((TD{1,12}),4,1);
    Q_S11 = [(Qstd13{1,1})' (Qstd13{1,2})' (Qstd13{1,3})']./repmat((fsample{1,11}),4,1)./repmat((TD{1,11}),4,1);
    Q_S10 = [(Qstd10{1,1})' (Qstd10{1,2})' (Qstd10{1,3})' (Qstd10{1,4})' ]./repmat((fsample{1,10}),4,1)./repmat((TD{1,10}),4,1);    
end
    
errorbar(mean([mean(Q_M8'); mean(Q_M7'); mean(Q_M6'); mean(Q_M5'); mean(Q_M14'); mean(Q_M13'); mean(Q_M12'); mean(Q_M11'); mean(Q_M10')]),...
         std([mean(Q_M8'); mean(Q_M7'); mean(Q_M6'); mean(Q_M5'); mean(Q_M14'); mean(Q_M13'); mean(Q_M12'); mean(Q_M11'); mean(Q_M10')]./sqrt(9)));

errorbar(mean([mean(Q_S8'); mean(Q_S7'); mean(Q_S6'); mean(Q_S5'); mean(Q_S14'); mean(Q_S13'); mean(Q_S12'); mean(Q_S11'); mean(Q_S10')]),...
         std([mean(Q_S8'); mean(Q_S7'); mean(Q_S6'); mean(Q_S5'); mean(Q_S14'); mean(Q_S13'); mean(Q_S12'); mean(Q_S11'); mean(Q_S10')]./sqrt(9)));
     
     
QM = [reshape(Q_M8,(size(Q_M8,1)*size(Q_M8,2)),1);...   
    reshape(Q_M7,(size(Q_M7,1)*size(Q_M7,2)),1);...  
    reshape(Q_M6,(size(Q_M6,1)*size(Q_M6,2)),1);...  
    reshape(Q_M5,(size(Q_M5,1)*size(Q_M5,2)),1);...  
    reshape(Q_M14,(size(Q_M14,1)*size(Q_M14,2)),1);...  
    reshape(Q_M13,(size(Q_M13,1)*size(Q_M13,2)),1);...  
    reshape(Q_M12,(size(Q_M12,1)*size(Q_M12,2)),1);...  
    reshape(Q_M11,(size(Q_M11,1)*size(Q_M11,2)),1);...  
    reshape(Q_M10,(size(Q_M10,1)*size(Q_M10,2)),1)];  

QS = [reshape(Q_S8,(size(Q_S8,1)*size(Q_S8,2)),1);...   
    reshape(Q_S7,(size(Q_S7,1)*size(Q_S7,2)),1);...  
    reshape(Q_S6,(size(Q_S6,1)*size(Q_S6,2)),1);...  
    reshape(Q_S5,(size(Q_S5,1)*size(Q_S5,2)),1);...  
    reshape(Q_S14,(size(Q_S14,1)*size(Q_S14,2)),1);...  
    reshape(Q_S13,(size(Q_S13,1)*size(Q_S13,2)),1);...  
    reshape(Q_S12,(size(Q_S12,1)*size(Q_S12,2)),1);...  
    reshape(Q_S11,(size(Q_S11,1)*size(Q_S11,2)),1);...  
    reshape(Q_S10,(size(Q_S10,1)*size(Q_S10,2)),1)];     

QUARTILES = repmat((1:4)',37,1);

SUBJECT = [repmat([8 8 8 8 8]',4,1); repmat([7 7 7 7 7 7]',4,1); repmat([6 6 6 6]',4,1); repmat([5 5 5]',4,1);...
repmat([14 14 14 14]',4,1); repmat([13 13 13 13]',4,1); repmat([12 12 12 12]',4,1); repmat([11 11 11]',4,1); repmat([10 10 10 10]',4,1)];

% write results in a text file
file = ['C:\TEMPROD\DATA\NEW\ForR\QUARTILES.txt'];
fileID = fopen(file,'w');

DATAforR1 = []; DATAforR2 = [];
% cell-array
DATAforR1 = [QM QS QS./QM QUARTILES SUBJECT];

DATAforR2{1,1} = 'QM';
DATAforR2{1,2} = 'QS';
DATAforR2{1,3} = 'CV';
DATAforR2{1,4} = 'QUARTILES';
DATAforR2{1,5} = 'SUBJECT';


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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
loc = {'NorthEast';'NorthEast';'NorthEast';'NorthEast';'NorthEast';'NorthEast';'NorthEast';'NorthEast'};
fig1 = figure('position',[1 1 1000 1000]);
set(fig1,'PaperPosition',[1 1 1000 1000])
set(fig1,'PaperPositionmode','auto')

hold on;
bar(mean([mean(Q_M8'); mean(Q_M7'); mean(Q_M6'); mean(Q_M5'); mean(Q_M14'); mean(Q_M13'); mean(Q_M12'); mean(Q_M11'); mean(Q_M10')]),...
    'facecolor',[0.5 0.5 0.5]);
errorbar(mean([mean(Q_M8'); mean(Q_M7'); mean(Q_M6'); mean(Q_M5'); mean(Q_M14'); mean(Q_M13'); mean(Q_M12'); mean(Q_M11'); mean(Q_M10')]),...
    std([mean(Q_M8'); mean(Q_M7'); mean(Q_M6'); mean(Q_M5'); mean(Q_M14'); mean(Q_M13'); mean(Q_M12'); mean(Q_M11'); mean(Q_M10')]./sqrt(9)),...
    'linestyle','none','linewidth',3,'color','k');
axis([0 5 0 2]); xlabel('Quartiles','FontSize',40);ylabel('Estimation/cible +- SEM','FontSize',40)

set(gca,'FontSize',40)
set(gca,'FontSize',40,'TickLength',[0.03 0.03])
set(gca,'Box','off','TickLength',[0.03 0.03])
set(gca,'box','off','linewidth',3)

print('-dpng',['C:\TEMPROD\DATA\NEW\FIG_THESIS\BEHAV\MEAN_QUARTILES'])  

%%%%

loc = {'NorthEast';'NorthEast';'NorthEast';'NorthEast';'NorthEast';'NorthEast';'NorthEast';'NorthEast'};
fig1 = figure('position',[1 1 1000 1000]);
set(fig1,'PaperPosition',[1 1 1000 1000])
set(fig1,'PaperPositionmode','auto')

hold on;
bar(mean([mean(Q_S8'); mean(Q_S7'); mean(Q_S6'); mean(Q_S5'); mean(Q_S14'); mean(Q_S13'); mean(Q_S12'); mean(Q_S11'); mean(Q_S10')]),...
    'facecolor',[0.5 0.5 0.5]);
errorbar(mean([mean(Q_S8'); mean(Q_S7'); mean(Q_S6'); mean(Q_S5'); mean(Q_S14'); mean(Q_S13'); mean(Q_S12'); mean(Q_S11'); mean(Q_S10')]),...
    std([mean(Q_S8'); mean(Q_S7'); mean(Q_S6'); mean(Q_S5'); mean(Q_S14'); mean(Q_S13'); mean(Q_S12'); mean(Q_S11'); mean(Q_S10')]./sqrt(9)),...
    'linestyle','none','linewidth',3,'color','k');
axis([0 5 0 0.4]); xlabel('Quartiles','FontSize',40);ylabel('Estimation/cible +- SEM','FontSize',40)

set(gca,'FontSize',40)
set(gca,'FontSize',40,'TickLength',[0.03 0.03])
set(gca,'Box','off','TickLength',[0.03 0.03])
set(gca,'box','off','linewidth',3)

print('-dpng',['C:\TEMPROD\DATA\NEW\FIG_THESIS\BEHAV\STD_QUARTILES'])  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
loc = {'NorthEast';'NorthEast';'NorthEast';'NorthEast';'NorthEast';'NorthEast';'NorthEast';'NorthEast'};
fig1 = figure('position',[1 1 1000 1000]);
set(fig1,'PaperPosition',[1 1 1000 1000])
set(fig1,'PaperPositionmode','auto')

hold on;
b = boxplot([mean(Q_M8'); mean(Q_M7'); mean(Q_M6'); mean(Q_M5'); mean(Q_M14'); mean(Q_M13'); mean(Q_M12'); mean(Q_M11'); mean(Q_M10')]);

for ih=1:6
set(b(ih,:),'LineWidth',3);
end

axis([0 5 0.5 2]);
ylabel('durée/cible +- ET','FontSize',40);

set(gca,'xtick',1:4,'xticklabel',{'Q1','Q2','Q3','Q4'})
set(gca,'FontSize',40)
set(gca,'Box','off','TickLength',[0.03 0.03])
set(gca,'box','off','linewidth',3)

print('-dpng',['C:\TEMPROD\DATA\NEW\FIG_THESIS\BEHAV\MEAN_QUARTILES'])  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
b = boxplot([mean(Q_S8')./mean(Q_M8'); mean(Q_S7')./mean(Q_M7'); mean(Q_S6')./mean(Q_M6'); mean(Q_S5')./mean(Q_M5');...
             mean(Q_S14')./mean(Q_M14');  mean(Q_S13')./mean(Q_M13');  mean(Q_S12')./mean(Q_M12');  mean(Q_S11')./mean(Q_M11');  mean(Q_S10')./mean(Q_M10')]);




