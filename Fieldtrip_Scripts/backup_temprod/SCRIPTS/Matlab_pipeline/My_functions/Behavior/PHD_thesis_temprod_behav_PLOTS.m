clear all
close all

load('C:\TEMPROD\DATA\NEW\across_subjects_data\behavDATA_v2')
load('C:\TEMPROD\DATA\NEW\across_subjects_data\behavDATA_v2_DUR')
load('C:\TEMPROD\DATA\NEW\across_subjects_data\behavDATA_v3_DUR')

Indexes = [3 4 5 6 7 8 10 11 12 13 14];

% length of the full table of results
for i = 1:11
    L(i) = length(TD{1,Indexes(i)});
end

TABLE = []; a = 1;
for i = 1:11
    for j = 1:L(i)
        TABLE(a,1) = Indexes(i);                                           % subject number
        TABLE(a,2) = TD{1,Indexes(i)}(j);                                  % targeted duration
        TABLE(a,3) = fsample{1,Indexes(i)}(j);                             % sampling frequency
        TABLE(a,4) = RunNum{1,Indexes(i)}(j);                              % run number       
        TABLE(a,5) = ER{1,Indexes(i)}(j);                                  % Estimation(1) or replay(0)                
        TABLE(a,6) = means{1,Indexes(i)}(j);                               % duration estimates mean      
        TABLE(a,7) = meds{1,Indexes(i)}(j);                                % duration estimates median 
        TABLE(a,8) = sds{1,Indexes(i)}(j);                                 % duration estimates standard deviation  
        TABLE(a,9) = (sds{1,Indexes(i)}(j))./means{1,Indexes(i)}(j);       % coefficient of variation
        a = a + 1;
    end
end  

TABLEST       = TABLE;
[fx,fy]       = find(TABLEST(:,5) == 0);
TABLEST(fx,:) = [];

% restrict to the 5 subjects with replays
TABLEST_estrep = TABLEST(28:46,:);
TABLEST_OK     = TABLEST(10:46,:);
TABLEST_2      = TABLEST(10:27,:);

TargetValues = unique(TABLE(:,2));

[x,y] = find(TABLEST_OK(:,2) == 6.5);
TABLEST_recode = TABLEST_OK;
TABLEST_recode(x,2) = 5.7;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% write results in a text file
file = ['C:\TEMPROD\DATA\NEW\ForR\TEMPROD_BEHAVDATA_TABLE.txt'];
fileID = fopen(file,'w');

DATAforR1 = []; DATAforR2 = [];
% cell-array
DATAforR1 = TABLEST;
DATAforR2{1,1} = 'Subject';
DATAforR2{1,2} = 'Target';
DATAforR2{1,3} = 'fsample';
DATAforR2{1,4} = 'RunNum';
DATAforR2{1,5} = 'EstRep';
DATAforR2{1,6} = 'Mean';
DATAforR2{1,7} = 'Med';
DATAforR2{1,8} = 'Std';
DATAforR2{1,9} = 'CV';
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
% write results in a text file
file = ['C:\TEMPROD\DATA\NEW\ForR\TEMPROD_BEHAVDATA_TABLE_recode.txt'];
fileID = fopen(file,'w');

DATAforR1 = []; DATAforR2 = [];
% cell-array
DATAforR1 = TABLEST_recode;
DATAforR2{1,1} = 'Subject';
DATAforR2{1,2} = 'Target';
DATAforR2{1,3} = 'fsample';
DATAforR2{1,4} = 'RunNum';
DATAforR2{1,5} = 'EstRep';
DATAforR2{1,6} = 'Mean';
DATAforR2{1,7} = 'Med';
DATAforR2{1,8} = 'Std';
DATAforR2{1,9} = 'CV';
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
% write results in a text file
file = ['C:\TEMPROD\DATA\NEW\ForR\TEMPROD_BEHAVDATA_TABLE_recode_norm.txt'];
fileID = fopen(file,'w');

TABLEST_recode_bis = TABLEST_recode;
TABLEST_recode_bis(:,6) = TABLEST_recode_bis(:,6) - TABLEST_recode_bis(:,2);

DATAforR1 = []; DATAforR2 = [];
% cell-array
DATAforR1 = TABLEST_recode;
DATAforR2{1,1} = 'Subject';
DATAforR2{1,2} = 'Target';
DATAforR2{1,3} = 'fsample';
DATAforR2{1,4} = 'RunNum';
DATAforR2{1,5} = 'EstRep';
DATAforR2{1,6} = 'Mean';
DATAforR2{1,7} = 'Med';
DATAforR2{1,8} = 'Std';
DATAforR2{1,9} = 'CV';
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
% write results in a text file
file = ['C:\TEMPROD\DATA\NEW\ForR\TEMPROD_BEHAVDATA_TABLE_5sub_estrep.txt'];
fileID = fopen(file,'w');

DATAforR1 = []; DATAforR2 = [];
% cell-array
DATAforR1 = TABLEST_estrep;
DATAforR2{1,1} = 'Subject';
DATAforR2{1,2} = 'Target';
DATAforR2{1,3} = 'fsample';
DATAforR2{1,4} = 'RunNum';
DATAforR2{1,5} = 'EstRep';
DATAforR2{1,6} = 'Mean';
DATAforR2{1,7} = 'Med';
DATAforR2{1,8} = 'Std';
DATAforR2{1,9} = 'CV';
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
% write results in a text file
file = ['C:\TEMPROD\DATA\NEW\ForR\TEMPROD_BEHAVDATA_TABLE_9sub.txt'];
fileID = fopen(file,'w');

DATAforR1 = []; DATAforR2 = [];
% cell-array
DATAforR1 = TABLEST_OK;
DATAforR2{1,1} = 'Subject';
DATAforR2{1,2} = 'Target';
DATAforR2{1,3} = 'fsample';
DATAforR2{1,4} = 'RunNum';
DATAforR2{1,5} = 'EstRep';
DATAforR2{1,6} = 'Mean';
DATAforR2{1,7} = 'Med';
DATAforR2{1,8} = 'Std';
DATAforR2{1,9} = 'CV';
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
% write results in a text file
file = ['C:\TEMPROD\DATA\NEW\ForR\TEMPROD_BEHAVDATA_TABLE_2.txt'];
fileID = fopen(file,'w');

DATAforR1 = []; DATAforR2 = [];
% cell-array
DATAforR1 = TABLEST_2;
DATAforR2{1,1} = 'Subject';
DATAforR2{1,2} = 'Target';
DATAforR2{1,3} = 'fsample';
DATAforR2{1,4} = 'RunNum';
DATAforR2{1,5} = 'EstRep';
DATAforR2{1,6} = 'Mean';
DATAforR2{1,7} = 'Med';
DATAforR2{1,8} = 'Std';
DATAforR2{1,9} = 'CV';
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

% subject by subject mean

Xm = []; Xs = [];
for i = [5 6 7]
    for j = [3 4 5 6 7 8 10 11 12 13 14]
        x1 = []; x2 = []; x = [];
        [x1,y1]   = find(TABLEST(:,2) == TargetValues(i));
        [x2,y2]   = find(TABLEST(:,1) == j);
        x = intersect(x1,x2);
        Xm(i,j)  = mean(TABLEST(x,6));
        Xs(i,j)  = mean(sqrt(TABLEST(x,8).^2));
    end
end

% usable plot
fig1 = figure('position',[1 1 1000 1000]);
set(fig1,'PaperPosition',[1 1 1000 1000])
set(fig1,'PaperPositionmode','auto')

bar(Xm([5 7],10:14)); hold on
legend('sujet10','sujet11','sujet12','sujet13','sujet14','fontsize',30)
set(gca,'xtick',1:2,'xticklabel',{'cible: 5.7s','cible: 8.5s'},'fontsize',30);
errorbar([0.7 0.85 1 1.15 1.3],Xm (5,10:14),Xs (5,10:14),'linestyle','none','linewidth',3,'color','k');hold on;
errorbar([1.7 1.85 2 2.15 2.3],Xm (7,10:14),Xs (7,10:14),'linestyle','none','linewidth',3,'color','k');hold on;
ylabel('durées estimée +- ET');set(gca,'box','off','linewidth',3)
axis([0.5 2.5 0 25])

fig1 = figure('position',[1 1 1000 1000]);
set(fig1,'PaperPosition',[1 1 1000 1000])
set(fig1,'PaperPositionmode','auto')

bar(Xm([6 7],5:8)); hold on
legend('sujet05','sujet06','sujet07','sujet08','location','NorthWest')
set(gca,'xtick',1:2,'xticklabel',{'cible: 6.5s','cible: 8.5s'},'fontsize',30);
errorbar([0.725 0.9 1.1 1.275],Xm (6,5:8),Xs (6,5:8),'linestyle','none','linewidth',3,'color','k');hold on;
errorbar([1.725 1.9 2.1 2.275],Xm (7,5:8),Xs (7,5:8),'linestyle','none','linewidth',3,'color','k');hold on;
ylabel('durées estimée +- ET');set(gca,'box','off','linewidth',3)
axis([0.5 2.5 0 25])

% subject-by subject CV

Xcv = []; 
for i = [5 6 7]
    for j = [3 4 5 6 7 8 10 11 12 13 14]
        x1 = []; x2 = []; x = [];
        [x1,y1]   = find(TABLEST(:,2) == TargetValues(i));
        [x2,y2]   = find(TABLEST(:,1) == j);
        x = intersect(x1,x2);
        Xcv(i,j)  = mean(TABLEST(x,9));
    end
end

% usable plot
fig1 = figure('position',[1 1 1000 1000]);
set(fig1,'PaperPosition',[1 1 1000 1000])
set(fig1,'PaperPositionmode','auto')

bar(Xcv([5 7],10:14)); hold on
legend('sujet10','sujet11','sujet12','sujet13','sujet14','fontsize',30)
set(gca,'xtick',1:2,'xticklabel',{'cible: 5.7s','cible: 8.5s'},'fontsize',30);
ylabel('coefficient de variation');set(gca,'box','off','linewidth',3)
axis([0.5 2.5 0 0.7])

% usable plot
fig1 = figure('position',[1 1 1000 1000]);
set(fig1,'PaperPosition',[1 1 1000 1000])
set(fig1,'PaperPositionmode','auto')

bar(Xcv([6 7],5:8)); hold on
legend('sujet05','sujet06','sujet07','sujet08','location','NorthWest')
set(gca,'xtick',1:2,'xticklabel',{'cible: 6.5s','cible: 8.5s'},'fontsize',30);
ylabel('coefficient de variation');set(gca,'box','off','linewidth',3)
axis([0.5 2.5 0 0.7])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% durations histogram

DUR65_1 = [DUR05{1,1}/1000 DUR05{1,3}/1000 ...
         DUR06{1,1}/1000 DUR06{1,3}/1000 ...
         DUR07{1,1}/1000 DUR07{1,3}/1000 DUR07{1,4}/1000 ...
         DUR08{1,1}/1000 DUR08{1,3}/1000 DUR08{1,4}/1000];
         
DUR85_1 = [DUR05{1,2}/1000 ...
         DUR06{1,2}/1000  DUR06{1,4}/1000 ...
         DUR07{1,2}/1000 DUR07{1,5}/1000 DUR07{1,6}/1000 ...
         DUR08{1,2}/1000 DUR08{1,5}/1000];

DUR57_2 = [DUR10{1,1}/1000 DUR10{1,4}/1000  ...
         DUR11{1,1}/1000 DUR11{1,4}/1000 ...
         DUR12{1,1}/1000 DUR12{1,4}/1000  ...
         DUR13{1,2}/1000 DUR13{1,4}/1000  ...
         DUR14{1,2}/1000 DUR14{1,4}/1000];
         
DUR85_2 = [DUR10{1,2}/1000 DUR10{1,5}/1000  ...
         DUR11{1,2}/1000 ...
         DUR12{1,2}/1000 DUR12{1,5}/1000  ...
         DUR13{1,2}/1000 DUR13{1,5}/1000  ...
         DUR14{1,2}/1000 DUR14{1,5}/1000];

fig1 = figure('position',[1 1 1000 1000]);
set(fig1,'PaperPosition',[1 1 1000 1000])
set(fig1,'PaperPositionmode','auto')     

subplot(2,2,1); hist(DUR65_1,200); axis([0 40 0 25]); set(gca,'fontsize',30,'box','off','linewidth',3);
xlabel('Durées estimées (s) - cible: 6.5s','fontsize',30); ylabel('Nombre d''essais','fontsize',30);
subplot(2,2,2); hist(DUR85_1,200); axis([0 40 0 25]); set(gca,'fontsize',30,'box','off','linewidth',3);
xlabel('Durées estimées (s) - cible: 8.5s','fontsize',30); ylabel('Nombre d''essais','fontsize',30);
subplot(2,2,3); hist(DUR57_2,200); axis([0 40 0 25]); set(gca,'fontsize',30,'box','off','linewidth',3);
xlabel('Durées estimées (s) - cible: 5.7s','fontsize',30); ylabel('Nombre d''essais','fontsize',30);
subplot(2,2,4); hist(DUR85_2,200); axis([0 40 0 25]); set(gca,'fontsize',30,'box','off','linewidth',3);
xlabel('Durées estimées (s) - cible: 8.5s','fontsize',30); ylabel('Nombre d''essais','fontsize',30);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%% gamma fit statistic %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DURDUR(1:3) = DUR05  ; DURDUR(4:7) = DUR06  ; DURDUR(8:13) = DUR07 ; DURDUR(14:18) = DUR08;
DURDUR(19:22) = DUR10([1 2 4 5]); DURDUR(23:25) = DUR11([1 2 4]); DURDUR(26:29) = DUR12([1 2 4 5]);
DURDUR(30:33) = DUR13([1 2 4 5]); DURDUR(34:37) = DUR14([1 2 4 5]);

for i                   = 1:size(TABLEST_OK,1)
    [n_in_bins,nb_bins] = hist(DURDUR{i}/TABLEST(i,3),15);
    n_in_bins_norm      = n_in_bins/sum(n_in_bins.*nb_bins); % normalise, so that area in histogram is 1
    xlabel('durations (ms)');
    ylabel('normalised counts');
    
%     axis([3 12 0 0.03]);
    
    fit_all             = gamfit(DURDUR{i}/TABLEST(i,3)); % fit the gamma function to the raw rt data
    fitted_data         = gampdf(nb_bins,fit_all(1),fit_all(2)); % get the fitted gamma pdf, in the range of the x_bins
    [fitted_mean, fitted_variance] = gamstat(fit_all(1),fit_all(2)); % get mean and variance of fit
    fitted_data_norm    = fitted_data/sum(fitted_data.*nb_bins); % normalise, so that area in histogram is 1
    
    hold on; plot(nb_bins,fitted_data_norm,'r','LineWidth',2)
    
    % calculate goodness of fit
    
    SSE1 = n_in_bins_norm - fitted_data_norm;
    SSE1 = SSE1.^2;
    SSE1 = sum(SSE1);
    SST1 = n_in_bins_norm - mean(n_in_bins_norm);
    SST1 = SST1.^2;
    SST1 = sum(SST1);
    RSquare1 = 1- (SSE1/SST1);
    
    % store individual results
    gam_fm(i) = fitted_mean;
    gam_fv(i) = fitted_variance;
    gam_R(i)  = RSquare1;
    
end

DURDUR(1:3) = DUR05  ; DURDUR(4:7) = DUR06  ; DURDUR(8:13) = DUR07 ; DURDUR(14:18) = DUR08;
DURDUR(19:22) = DUR10([1 2 4 5]); DURDUR(23:25) = DUR11([1 2 4]); DURDUR(26:29) = DUR12([1 2 4 5]);
DURDUR(30:33) = DUR13([1 2 4 5]); DURDUR(34:37) = DUR14([1 2 4 5]);

for i                   = 1:size(TABLEST_OK,1)
    [n_in_bins,nb_bins] = hist(DURDUR{i}/TABLEST(i,3),15);
    n_in_bins_norm      = n_in_bins/sum(n_in_bins.*nb_bins); % normalise, so that area in histogram is 1
    xlabel('durations (ms)');
    ylabel('normalised counts');
    
%     axis([3 12 0 0.03]);
    
    fit_all             = lognfit(DURDUR{i}/TABLEST(i,3)); % fit the logn function to the raw rt data
    fitted_data         = lognpdf(nb_bins,fit_all(1),fit_all(2)); % get the fitted logn pdf, in the range of the x_bins
    [fitted_mean, fitted_variance] = lognstat(fit_all(1),fit_all(2)); % get mean and variance of fit
    fitted_data_norm    = fitted_data/sum(fitted_data.*nb_bins); % normalise, so that area in histogram is 1
    
    hold on; plot(nb_bins,fitted_data_norm,'r','LineWidth',2)
    
    % calculate goodness of fit
    
    SSE1 = n_in_bins_norm - fitted_data_norm;
    SSE1 = SSE1.^2;
    SSE1 = sum(SSE1);
    SST1 = n_in_bins_norm - mean(n_in_bins_norm);
    SST1 = SST1.^2;
    SST1 = sum(SST1);
    RSquare1 = 1- (SSE1/SST1);
    
    % store individual results
    logn_fm(i) = fitted_mean;
    logn_fv(i) = fitted_variance;
    logn_R(i)  = RSquare1;
    
end



