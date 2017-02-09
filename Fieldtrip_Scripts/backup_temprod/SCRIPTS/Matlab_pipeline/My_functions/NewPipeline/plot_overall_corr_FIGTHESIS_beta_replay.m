% Plot and write a text file usable by R software
%% beta band

clear all
close all

SubjArray = {'s14','s13','s12','s11','s10'};
FreqArray = {[15 25],[15 25],[15 25],[15 25],[20 30]};
RunArray  = {[4 7],[4 7],[4 7],[ 4 ],[4 7]};
ChanArray = {'Mags','Grads1','Grads2'};

for chan = 1:3
    TMP_CBC_corr_R = [];
    TMP_CBC_corr_p = [];
    tmp_CBC_corr_R = [];
    tmp_CBC_corr_p = [];
    tmp_AVG_corr_R = [];
    tmp_AVG_corr_p = [];
    for i = 1:length(SubjArray)
        for j = 1:length(RunArray{i})
            load(['C:\TEMPROD\DATA\NEW\processed_' SubjArray{i} '\FT_spectra\SUMMARY_corr_' ChanArray{chan} '_' SubjArray{i} ...
                '_run' num2str(RunArray{i}(j)) '_freq'  num2str(FreqArray{i}(1)) '-' num2str(FreqArray{i}(2)) '.mat'])
            
            tmp_CBC_corr_R = [tmp_CBC_corr_R ; nanmean(CBC_corr_R)];
            tmp_CBC_corr_p = [tmp_CBC_corr_p ; nanmean(CBC_corr_p)];
            TMP_CBC_corr_R = [TMP_CBC_corr_R ; CBC_corr_R];
            TMP_CBC_corr_p = [TMP_CBC_corr_p ; CBC_corr_p];            
            tmp_AVG_corr_R = [tmp_AVG_corr_R ; AVG_corr_R];
            tmp_AVG_corr_p = [tmp_AVG_corr_p ; AVG_corr_p];
            
        end
    end
    GLOBAL_CBC_corr_R{chan} = TMP_CBC_corr_R;
    GLOBAL_CBC_corr_p{chan} = TMP_CBC_corr_p;    
    global_CBC_corr_R{chan} = tmp_CBC_corr_R;
    global_CBC_corr_p{chan} = tmp_CBC_corr_p;
    global_AVG_corr_R{chan} = tmp_AVG_corr_R;
    global_AVG_corr_p{chan} = tmp_AVG_corr_p;
    
    [xtmp10{chan},y10] = find(global_AVG_corr_R{1,chan}(:,11) == 10); x10{chan} = xtmp10{chan};
    [xtmp11{chan},y11] = find(global_AVG_corr_R{1,chan}(:,11) == 11); x11{chan} = xtmp11{chan};
    [xtmp12{chan},y12] = find(global_AVG_corr_R{1,chan}(:,11) == 12); x12{chan} = xtmp12{chan};
    [xtmp13{chan},y13] = find(global_AVG_corr_R{1,chan}(:,11) == 13); x13{chan} = xtmp13{chan};
    [xtmp14{chan},y14] = find(global_AVG_corr_R{1,chan}(:,11) == 14); x14{chan} = xtmp14{chan};
  
    [xtmp10{chan},y10] = find(GLOBAL_CBC_corr_R{1,chan}(:,11) == 10); x10_{chan} = xtmp10{chan};
    [xtmp11{chan},y11] = find(GLOBAL_CBC_corr_R{1,chan}(:,11) == 11); x11_{chan} = xtmp11{chan};
    [xtmp12{chan},y12] = find(GLOBAL_CBC_corr_R{1,chan}(:,11) == 12); x12_{chan} = xtmp12{chan};
    [xtmp13{chan},y13] = find(GLOBAL_CBC_corr_R{1,chan}(:,11) == 13); x13_{chan} = xtmp13{chan};
    [xtmp14{chan},y14] = find(GLOBAL_CBC_corr_R{1,chan}(:,11) == 14); x14_{chan} = xtmp14{chan}; 
    
    [xtmp_pcorr{chan},y]   = find(GLOBAL_CBC_corr_p{1,chan}(:,1) <= 0.05); x_pcorr1{chan} = xtmp_pcorr{chan};
    [xtmp_pcorr{chan},y]   = find(GLOBAL_CBC_corr_p{1,chan}(:,2) <= 0.05); x_pcorr2{chan} = xtmp_pcorr{chan};
    [xtmp_pcorr{chan},y]   = find(GLOBAL_CBC_corr_p{1,chan}(:,3) <= 0.05); x_pcorr3{chan} = xtmp_pcorr{chan};
    [xtmp_pcorr{chan},y]   = find(GLOBAL_CBC_corr_p{1,chan}(:,4) <= 0.05); x_pcorr4{chan} = xtmp_pcorr{chan};
    [xtmp_pcorr{chan},y]   = find(GLOBAL_CBC_corr_p{1,chan}(:,5) <= 0.05); x_pcorr5{chan} = xtmp_pcorr{chan};
    [xtmp_pcorr{chan},y]   = find(GLOBAL_CBC_corr_p{1,chan}(:,6) <= 0.05); x_pcorr6{chan} = xtmp_pcorr{chan};
    [xtmp_pcorr{chan},y]   = find(GLOBAL_CBC_corr_p{1,chan}(:,7) <= 0.05); x_pcorr7{chan} = xtmp_pcorr{chan};
    [xtmp_pcorr{chan},y]   = find(GLOBAL_CBC_corr_p{1,chan}(:,8) <= 0.05); x_pcorr8{chan} = xtmp_pcorr{chan};
    [xtmp_pcorr{chan},y]   = find(GLOBAL_CBC_corr_p{1,chan}(:,9) <= 0.05); x_pcorr9{chan} = xtmp_pcorr{chan};    

end

% plot overall correlations AVG
% R: Freq vs Dur
DATA1 = [global_AVG_corr_R{1}(:,2) global_AVG_corr_R{2}(:,2) global_AVG_corr_R{3}(:,2)]; subplot(2,3,1); imagesc(DATA1,[-0.5 0.5]); colorbar
DATA2 = [global_AVG_corr_R{1}(:,5) global_AVG_corr_R{2}(:,5) global_AVG_corr_R{3}(:,5)]; subplot(2,3,2); imagesc(DATA2,[-0.5 0.5]); colorbar
DATA3 = [global_AVG_corr_R{1}(:,8) global_AVG_corr_R{2}(:,8) global_AVG_corr_R{3}(:,8)]; subplot(2,3,3); imagesc(DATA3,[-0.5 0.5]); colorbar

DATA4 = [global_AVG_corr_R{1}(:,1) global_AVG_corr_R{2}(:,1) global_AVG_corr_R{3}(:,1)]; subplot(2,3,4); imagesc(DATA4,[-0.5 0.5]); colorbar
DATA5 = [global_AVG_corr_R{1}(:,4) global_AVG_corr_R{2}(:,4) global_AVG_corr_R{3}(:,4)]; subplot(2,3,5); imagesc(DATA5,[-0.5 0.5]); colorbar
DATA6 = [global_AVG_corr_R{1}(:,7) global_AVG_corr_R{2}(:,7) global_AVG_corr_R{3}(:,7)]; subplot(2,3,6); imagesc(DATA6,[-0.5 0.5]); colorbar

% p: Freq vs Dur
DATA1 = [global_AVG_corr_p{1}(:,2) global_AVG_corr_p{2}(:,2) global_AVG_corr_p{3}(:,2)]; subplot(2,3,1); DATA1mask = (DATA1 <= 0.05);imagesc(DATA1mask,[0 1]); colorbar
DATA2 = [global_AVG_corr_p{1}(:,5) global_AVG_corr_p{2}(:,5) global_AVG_corr_p{3}(:,5)]; subplot(2,3,2); DATA2mask = (DATA2 <= 0.05);imagesc(DATA2mask,[0 1]); colorbar
DATA3 = [global_AVG_corr_p{1}(:,8) global_AVG_corr_p{2}(:,8) global_AVG_corr_p{3}(:,8)]; subplot(2,3,3); DATA3mask = (DATA3 <= 0.05);imagesc(DATA3mask,[0 1]); colorbar

DATA4 = [global_AVG_corr_p{1}(:,1) global_AVG_corr_p{2}(:,1) global_AVG_corr_p{3}(:,1)]; subplot(2,3,4); DATA4mask = (DATA4 <= 0.05);imagesc(DATA4mask,[0 1]); colorbar
DATA5 = [global_AVG_corr_p{1}(:,4) global_AVG_corr_p{2}(:,4) global_AVG_corr_p{3}(:,4)]; subplot(2,3,5); DATA5mask = (DATA5 <= 0.05);imagesc(DATA5mask,[0 1]); colorbar
DATA6 = [global_AVG_corr_p{1}(:,7) global_AVG_corr_p{2}(:,7) global_AVG_corr_p{3}(:,7)]; subplot(2,3,6); DATA6mask = (DATA6 <= 0.05);imagesc(DATA6mask,[0 1]); colorbar

colormap('gray')

% plot overall correlations CBC
% R: Freq vs Dur
DATA1 = [global_CBC_corr_R{1}(:,2) global_CBC_corr_R{2}(:,2) global_CBC_corr_R{3}(:,2)]; subplot(2,3,1); imagesc(DATA1,[-0.5 0.5]); colorbar
DATA2 = [global_CBC_corr_R{1}(:,5) global_CBC_corr_R{2}(:,5) global_CBC_corr_R{3}(:,5)]; subplot(2,3,2); imagesc(DATA2,[-0.5 0.5]); colorbar
DATA3 = [global_CBC_corr_R{1}(:,8) global_CBC_corr_R{2}(:,8) global_CBC_corr_R{3}(:,8)]; subplot(2,3,3); imagesc(DATA3,[-0.5 0.5]); colorbar

DATA4 = [global_CBC_corr_R{1}(:,1) global_CBC_corr_R{2}(:,1) global_CBC_corr_R{3}(:,1)]; subplot(2,3,4); imagesc(DATA4,[-0.5 0.5]); colorbar
DATA5 = [global_CBC_corr_R{1}(:,4) global_CBC_corr_R{2}(:,4) global_CBC_corr_R{3}(:,4)]; subplot(2,3,5); imagesc(DATA5,[-0.5 0.5]); colorbar
DATA6 = [global_CBC_corr_R{1}(:,7) global_CBC_corr_R{2}(:,7) global_CBC_corr_R{3}(:,7)]; subplot(2,3,6); imagesc(DATA6,[-0.5 0.5]); colorbar

% p: Freq vs Dur
DATA1 = [global_CBC_corr_p{1}(:,2) global_CBC_corr_p{2}(:,2) global_CBC_corr_p{3}(:,2)]; subplot(2,3,1); DATA1mask = (DATA1 <= 0.05);imagesc(DATA1mask,[0 1]); colorbar
DATA2 = [global_CBC_corr_p{1}(:,5) global_CBC_corr_p{2}(:,5) global_CBC_corr_p{3}(:,5)]; subplot(2,3,2); DATA2mask = (DATA2 <= 0.05);imagesc(DATA2mask,[0 1]); colorbar
DATA3 = [global_CBC_corr_p{1}(:,8) global_CBC_corr_p{2}(:,8) global_CBC_corr_p{3}(:,8)]; subplot(2,3,3); DATA3mask = (DATA3 <= 0.05);imagesc(DATA3mask,[0 1]); colorbar

DATA4 = [global_CBC_corr_p{1}(:,1) global_CBC_corr_p{2}(:,1) global_CBC_corr_p{3}(:,1)]; subplot(2,3,4); DATA4mask = (DATA4 <= 0.05);imagesc(DATA4mask,[0 1]); colorbar
DATA5 = [global_CBC_corr_p{1}(:,4) global_CBC_corr_p{2}(:,4) global_CBC_corr_p{3}(:,4)]; subplot(2,3,5); DATA5mask = (DATA5 <= 0.05);imagesc(DATA5mask,[0 1]); colorbar
DATA6 = [global_CBC_corr_p{1}(:,7) global_CBC_corr_p{2}(:,7) global_CBC_corr_p{3}(:,7)]; subplot(2,3,6); DATA6mask = (DATA6 <= 0.05);imagesc(DATA6mask,[0 1]); colorbar

colormap('gray')

% plot overall correlations CBC selected
% R: Freq vs Dur
init{1} = ones(918,9)*NaN; init{2} = ones(918,9)*NaN; init{3} = ones(918,9)*NaN;
INIT{1} = zeros(9,9)     ;INIT{2} = zeros(9,9)      ; INIT{3} = zeros(9,9);

for chan = 1:3
    init{chan}(x_pcorr1{chan},1) = GLOBAL_CBC_corr_R{chan}(x_pcorr1{chan});
    init{chan}(x_pcorr2{chan},2) = GLOBAL_CBC_corr_R{chan}(x_pcorr2{chan});
    init{chan}(x_pcorr3{chan},3) = GLOBAL_CBC_corr_R{chan}(x_pcorr3{chan});
    init{chan}(x_pcorr4{chan},4) = GLOBAL_CBC_corr_R{chan}(x_pcorr4{chan});
    init{chan}(x_pcorr5{chan},5) = GLOBAL_CBC_corr_R{chan}(x_pcorr5{chan});
    init{chan}(x_pcorr6{chan},6) = GLOBAL_CBC_corr_R{chan}(x_pcorr6{chan});
    init{chan}(x_pcorr7{chan},7) = GLOBAL_CBC_corr_R{chan}(x_pcorr7{chan});
    init{chan}(x_pcorr8{chan},8) = GLOBAL_CBC_corr_R{chan}(x_pcorr8{chan});
    init{chan}(x_pcorr9{chan},9) = GLOBAL_CBC_corr_R{chan}(x_pcorr9{chan});
end

rangelol = 1:102:918;
for i = 1:9
    INIT{1}(i,:) = nanmean(init{1}(rangelol(i):rangelol(i)+101,:));
    INIT{2}(i,:) = nanmean(init{2}(rangelol(i):rangelol(i)+101,:));
    INIT{3}(i,:) = nanmean(init{3}(rangelol(i):rangelol(i)+101,:));
end

for z = 1:3
    for i = 1:9
        for j = 1:9
            if isnan(INIT{z}(i,j))
                INIT{z}(i,j) = 0;
            end
        end
    end
end
            
% plot overall correlations CBC
% R: Freq vs Dur
DATA1 = [INIT{1}(:,2) INIT{2}(:,2) INIT{3}(:,2)]; subplot(2,3,1); imagesc(DATA1,[-0.5 0.5]); colorbar
DATA2 = [INIT{1}(:,5) INIT{2}(:,5) INIT{3}(:,5)]; subplot(2,3,2); imagesc(DATA2,[-0.5 0.5]); colorbar
DATA3 = [INIT{1}(:,8) INIT{2}(:,8) INIT{3}(:,8)]; subplot(2,3,3); imagesc(DATA3,[-0.5 0.5]); colorbar

DATA4 = [INIT{1}(:,1) INIT{2}(:,1) INIT{3}(:,1)]; subplot(2,3,4); imagesc(DATA4,[-0.5 0.5]); colorbar
DATA5 = [INIT{1}(:,4) INIT{2}(:,4) INIT{3}(:,4)]; subplot(2,3,5); imagesc(DATA5,[-0.5 0.5]); colorbar
DATA6 = [INIT{1}(:,7) INIT{2}(:,7) INIT{3}(:,7)]; subplot(2,3,6); imagesc(DATA6,[-0.5 0.5]); colorbar

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%ù
fig1 = figure('position',[1 1 1000 1000]);
set(fig1,'PaperPosition',[1 1 1000 1000])
set(fig1,'PaperPositionmode','auto')

bar([[mean(INIT{1}(:,2)) mean(INIT{2}(:,2)) mean(INIT{3}(:,2))]' [mean(INIT{1}(:,1)) mean(INIT{2}(:,1)) mean(INIT{3}(:,1))]']'); hold on;
errorbar([0.8 1 1.2],[mean(INIT{1}(:,2)) mean(INIT{2}(:,2)) mean(INIT{3}(:,2))],...
    [std(INIT{1}(:,2)) std(INIT{2}(:,2)) std(INIT{3}(:,2))]./sqrt(10),'color','k','linewidth',2,'linestyle','none'); hold on
errorbar([1.8 2 2.2],[mean(INIT{1}(:,1)) mean(INIT{2}(:,1)) mean(INIT{3}(:,1))],...
    [std(INIT{1}(:,1)) std(INIT{2}(:,1)) std(INIT{3}(:,1))]./sqrt(10),'color','k','linewidth',2,'linestyle','none'); hold on
legend('Mags','Grads1','Grads2','location','NorthWest');
ylabel('score de corrélation moyen +- ES','fontsize',30);
set(gca,'box','off','xtick',1:2,'xticklabel',{'Dur vs freq';'Dur vs Pow'},'fontsize',30,'linewidth',2);
axis([0.5 2.5 -0.1 0.4])

print('-dpng','C:\TEMPROD\DATA\NEW\FIG_THESIS\ALLCORRd_intersubAVG_selectedCBC_beta_replay.png')

fig1 = figure('position',[1 1 1000 1000]);
set(fig1,'PaperPosition',[1 1 1000 1000])
set(fig1,'PaperPositionmode','auto')

bar([[mean(INIT{1}(:,5)) mean(INIT{2}(:,5)) mean(INIT{3}(:,5))]' [mean(INIT{1}(:,4)) mean(INIT{2}(:,4)) mean(INIT{3}(:,4))]']'); hold on;
errorbar([0.8 1 1.2],[mean(INIT{1}(:,5)) mean(INIT{2}(:,5)) mean(INIT{3}(:,5))],...
    [std(INIT{1}(:,4)) std(INIT{2}(:,5)) std(INIT{3}(:,5))]./sqrt(10),'color','k','linewidth',2,'linestyle','none'); hold on
errorbar([1.8 2 2.2],[mean(INIT{1}(:,4)) mean(INIT{2}(:,4)) mean(INIT{3}(:,4))],...
    [std(INIT{1}(:,4)) std(INIT{2}(:,4)) std(INIT{3}(:,4))]./sqrt(10),'color','k','linewidth',2,'linestyle','none'); hold on
legend('Mags','Grads1','Grads2','location','NorthWest');
ylabel('score de corrélation moyen +- ES','fontsize',30);
set(gca,'box','off','xtick',1:2,'xticklabel',{'Med vs freq';'Med vs Pow'},'fontsize',30,'linewidth',2);
axis([0.5 2.5 -0.1 0.4])

print('-dpng','C:\TEMPROD\DATA\NEW\FIG_THESIS\ALLCORRm_intersubAVG_selectedCBC_beta_replay.png')

fig1 = figure('position',[1 1 1000 1000]);
set(fig1,'PaperPosition',[1 1 1000 1000])
set(fig1,'PaperPositionmode','auto')

bar([[mean(INIT{1}(:,8)) mean(INIT{2}(:,8)) mean(INIT{3}(:,8))]' [mean(INIT{1}(:,7)) mean(INIT{2}(:,7)) mean(INIT{3}(:,7))]']'); hold on;
errorbar([0.8 1 1.2],[mean(INIT{1}(:,8)) mean(INIT{2}(:,8)) mean(INIT{3}(:,8))],...
    [std(INIT{1}(:,8)) std(INIT{2}(:,8)) std(INIT{3}(:,8))]./sqrt(10),'color','k','linewidth',2,'linestyle','none'); hold on
errorbar([1.8 2 2.2],[mean(INIT{1}(:,7)) mean(INIT{2}(:,7)) mean(INIT{3}(:,7))],...
    [std(INIT{1}(:,7)) std(INIT{2}(:,7)) std(INIT{3}(:,7))]./sqrt(10),'color','k','linewidth',2,'linestyle','none'); hold on
legend('Mags','Grads1','Grads2','location','NorthWest');
ylabel('score de corrélation moyen +- ES','fontsize',30);
set(gca,'box','off','xtick',1:2,'xticklabel',{'Acc vs freq';'Acc vs Pow'},'fontsize',30,'linewidth',2);
axis([0.5 2.5 -0.1 0.4])

print('-dpng','C:\TEMPROD\DATA\NEW\FIG_THESIS\ALLCORRa_intersubAVG_selectedCBC_beta_replay.png')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Plot and write a text file usable by R software
%% beta band

clear all
close all

SubjArray = {'s14','s13','s12','s11','s10'};
FreqArray = {[15 25],[15 25],[15 25],[15 25],[20 30]};
RunArray  = {[2 5],[2 5],[2 5],[2],[2 5]};
ChanArray = {'Mags','Grads1','Grads2'};

for chan = 1:3
    TMP_CBC_corr_R = [];
    TMP_CBC_corr_p = [];
    tmp_CBC_corr_R = [];
    tmp_CBC_corr_p = [];
    tmp_AVG_corr_R = [];
    tmp_AVG_corr_p = [];
    for i = 1:length(SubjArray)
        for j = 1:length(RunArray{i})
            load(['C:\TEMPROD\DATA\NEW\processed_' SubjArray{i} '\FT_spectra\SUMMARY_corr_' ChanArray{chan} '_' SubjArray{i} ...
                '_run' num2str(RunArray{i}(j)) '_freq'  num2str(FreqArray{i}(1)) '-' num2str(FreqArray{i}(2)) '.mat'])
            
            tmp_CBC_corr_R = [tmp_CBC_corr_R ; nanmean(CBC_corr_R)];
            tmp_CBC_corr_p = [tmp_CBC_corr_p ; nanmean(CBC_corr_p)];
            TMP_CBC_corr_R = [TMP_CBC_corr_R ; CBC_corr_R];
            TMP_CBC_corr_p = [TMP_CBC_corr_p ; CBC_corr_p];            
            tmp_AVG_corr_R = [tmp_AVG_corr_R ; AVG_corr_R];
            tmp_AVG_corr_p = [tmp_AVG_corr_p ; AVG_corr_p];
            
        end
    end
    GLOBAL_CBC_corr_R{chan} = TMP_CBC_corr_R;
    GLOBAL_CBC_corr_p{chan} = TMP_CBC_corr_p;    
    global_CBC_corr_R{chan} = tmp_CBC_corr_R;
    global_CBC_corr_p{chan} = tmp_CBC_corr_p;
    global_AVG_corr_R{chan} = tmp_AVG_corr_R;
    global_AVG_corr_p{chan} = tmp_AVG_corr_p;
    
    [xtmp10{chan},y10] = find(global_AVG_corr_R{1,chan}(:,11) == 10); x10{chan} = xtmp10{chan};
    [xtmp11{chan},y11] = find(global_AVG_corr_R{1,chan}(:,11) == 11); x11{chan} = xtmp11{chan};
    [xtmp12{chan},y12] = find(global_AVG_corr_R{1,chan}(:,11) == 12); x12{chan} = xtmp12{chan};
    [xtmp13{chan},y13] = find(global_AVG_corr_R{1,chan}(:,11) == 13); x13{chan} = xtmp13{chan};
    [xtmp14{chan},y14] = find(global_AVG_corr_R{1,chan}(:,11) == 14); x14{chan} = xtmp14{chan};
  
    [xtmp10{chan},y10] = find(GLOBAL_CBC_corr_R{1,chan}(:,11) == 10); x10_{chan} = xtmp10{chan};
    [xtmp11{chan},y11] = find(GLOBAL_CBC_corr_R{1,chan}(:,11) == 11); x11_{chan} = xtmp11{chan};
    [xtmp12{chan},y12] = find(GLOBAL_CBC_corr_R{1,chan}(:,11) == 12); x12_{chan} = xtmp12{chan};
    [xtmp13{chan},y13] = find(GLOBAL_CBC_corr_R{1,chan}(:,11) == 13); x13_{chan} = xtmp13{chan};
    [xtmp14{chan},y14] = find(GLOBAL_CBC_corr_R{1,chan}(:,11) == 14); x14_{chan} = xtmp14{chan}; 
    
    [xtmp_pcorr{chan},y]   = find(GLOBAL_CBC_corr_p{1,chan}(:,1) <= 0.05); x_pcorr1{chan} = xtmp_pcorr{chan};
    [xtmp_pcorr{chan},y]   = find(GLOBAL_CBC_corr_p{1,chan}(:,2) <= 0.05); x_pcorr2{chan} = xtmp_pcorr{chan};
    [xtmp_pcorr{chan},y]   = find(GLOBAL_CBC_corr_p{1,chan}(:,3) <= 0.05); x_pcorr3{chan} = xtmp_pcorr{chan};
    [xtmp_pcorr{chan},y]   = find(GLOBAL_CBC_corr_p{1,chan}(:,4) <= 0.05); x_pcorr4{chan} = xtmp_pcorr{chan};
    [xtmp_pcorr{chan},y]   = find(GLOBAL_CBC_corr_p{1,chan}(:,5) <= 0.05); x_pcorr5{chan} = xtmp_pcorr{chan};
    [xtmp_pcorr{chan},y]   = find(GLOBAL_CBC_corr_p{1,chan}(:,6) <= 0.05); x_pcorr6{chan} = xtmp_pcorr{chan};
    [xtmp_pcorr{chan},y]   = find(GLOBAL_CBC_corr_p{1,chan}(:,7) <= 0.05); x_pcorr7{chan} = xtmp_pcorr{chan};
    [xtmp_pcorr{chan},y]   = find(GLOBAL_CBC_corr_p{1,chan}(:,8) <= 0.05); x_pcorr8{chan} = xtmp_pcorr{chan};
    [xtmp_pcorr{chan},y]   = find(GLOBAL_CBC_corr_p{1,chan}(:,9) <= 0.05); x_pcorr9{chan} = xtmp_pcorr{chan};    

end

% plot overall correlations AVG
% R: Freq vs Dur
DATA1 = [global_AVG_corr_R{1}(:,2) global_AVG_corr_R{2}(:,2) global_AVG_corr_R{3}(:,2)]; subplot(2,3,1); imagesc(DATA1,[-0.5 0.5]); colorbar
DATA2 = [global_AVG_corr_R{1}(:,5) global_AVG_corr_R{2}(:,5) global_AVG_corr_R{3}(:,5)]; subplot(2,3,2); imagesc(DATA2,[-0.5 0.5]); colorbar
DATA3 = [global_AVG_corr_R{1}(:,8) global_AVG_corr_R{2}(:,8) global_AVG_corr_R{3}(:,8)]; subplot(2,3,3); imagesc(DATA3,[-0.5 0.5]); colorbar

DATA4 = [global_AVG_corr_R{1}(:,1) global_AVG_corr_R{2}(:,1) global_AVG_corr_R{3}(:,1)]; subplot(2,3,4); imagesc(DATA4,[-0.5 0.5]); colorbar
DATA5 = [global_AVG_corr_R{1}(:,4) global_AVG_corr_R{2}(:,4) global_AVG_corr_R{3}(:,4)]; subplot(2,3,5); imagesc(DATA5,[-0.5 0.5]); colorbar
DATA6 = [global_AVG_corr_R{1}(:,7) global_AVG_corr_R{2}(:,7) global_AVG_corr_R{3}(:,7)]; subplot(2,3,6); imagesc(DATA6,[-0.5 0.5]); colorbar

% p: Freq vs Dur
DATA1 = [global_AVG_corr_p{1}(:,2) global_AVG_corr_p{2}(:,2) global_AVG_corr_p{3}(:,2)]; subplot(2,3,1); DATA1mask = (DATA1 <= 0.05);imagesc(DATA1mask,[0 1]); colorbar
DATA2 = [global_AVG_corr_p{1}(:,5) global_AVG_corr_p{2}(:,5) global_AVG_corr_p{3}(:,5)]; subplot(2,3,2); DATA2mask = (DATA2 <= 0.05);imagesc(DATA2mask,[0 1]); colorbar
DATA3 = [global_AVG_corr_p{1}(:,8) global_AVG_corr_p{2}(:,8) global_AVG_corr_p{3}(:,8)]; subplot(2,3,3); DATA3mask = (DATA3 <= 0.05);imagesc(DATA3mask,[0 1]); colorbar

DATA4 = [global_AVG_corr_p{1}(:,1) global_AVG_corr_p{2}(:,1) global_AVG_corr_p{3}(:,1)]; subplot(2,3,4); DATA4mask = (DATA4 <= 0.05);imagesc(DATA4mask,[0 1]); colorbar
DATA5 = [global_AVG_corr_p{1}(:,4) global_AVG_corr_p{2}(:,4) global_AVG_corr_p{3}(:,4)]; subplot(2,3,5); DATA5mask = (DATA5 <= 0.05);imagesc(DATA5mask,[0 1]); colorbar
DATA6 = [global_AVG_corr_p{1}(:,7) global_AVG_corr_p{2}(:,7) global_AVG_corr_p{3}(:,7)]; subplot(2,3,6); DATA6mask = (DATA6 <= 0.05);imagesc(DATA6mask,[0 1]); colorbar

colormap('gray')

% plot overall correlations CBC
% R: Freq vs Dur
DATA1 = [global_CBC_corr_R{1}(:,2) global_CBC_corr_R{2}(:,2) global_CBC_corr_R{3}(:,2)]; subplot(2,3,1); imagesc(DATA1,[-0.5 0.5]); colorbar
DATA2 = [global_CBC_corr_R{1}(:,5) global_CBC_corr_R{2}(:,5) global_CBC_corr_R{3}(:,5)]; subplot(2,3,2); imagesc(DATA2,[-0.5 0.5]); colorbar
DATA3 = [global_CBC_corr_R{1}(:,8) global_CBC_corr_R{2}(:,8) global_CBC_corr_R{3}(:,8)]; subplot(2,3,3); imagesc(DATA3,[-0.5 0.5]); colorbar

DATA4 = [global_CBC_corr_R{1}(:,1) global_CBC_corr_R{2}(:,1) global_CBC_corr_R{3}(:,1)]; subplot(2,3,4); imagesc(DATA4,[-0.5 0.5]); colorbar
DATA5 = [global_CBC_corr_R{1}(:,4) global_CBC_corr_R{2}(:,4) global_CBC_corr_R{3}(:,4)]; subplot(2,3,5); imagesc(DATA5,[-0.5 0.5]); colorbar
DATA6 = [global_CBC_corr_R{1}(:,7) global_CBC_corr_R{2}(:,7) global_CBC_corr_R{3}(:,7)]; subplot(2,3,6); imagesc(DATA6,[-0.5 0.5]); colorbar

% p: Freq vs Dur
DATA1 = [global_CBC_corr_p{1}(:,2) global_CBC_corr_p{2}(:,2) global_CBC_corr_p{3}(:,2)]; subplot(2,3,1); DATA1mask = (DATA1 <= 0.05);imagesc(DATA1mask,[0 1]); colorbar
DATA2 = [global_CBC_corr_p{1}(:,5) global_CBC_corr_p{2}(:,5) global_CBC_corr_p{3}(:,5)]; subplot(2,3,2); DATA2mask = (DATA2 <= 0.05);imagesc(DATA2mask,[0 1]); colorbar
DATA3 = [global_CBC_corr_p{1}(:,8) global_CBC_corr_p{2}(:,8) global_CBC_corr_p{3}(:,8)]; subplot(2,3,3); DATA3mask = (DATA3 <= 0.05);imagesc(DATA3mask,[0 1]); colorbar

DATA4 = [global_CBC_corr_p{1}(:,1) global_CBC_corr_p{2}(:,1) global_CBC_corr_p{3}(:,1)]; subplot(2,3,4); DATA4mask = (DATA4 <= 0.05);imagesc(DATA4mask,[0 1]); colorbar
DATA5 = [global_CBC_corr_p{1}(:,4) global_CBC_corr_p{2}(:,4) global_CBC_corr_p{3}(:,4)]; subplot(2,3,5); DATA5mask = (DATA5 <= 0.05);imagesc(DATA5mask,[0 1]); colorbar
DATA6 = [global_CBC_corr_p{1}(:,7) global_CBC_corr_p{2}(:,7) global_CBC_corr_p{3}(:,7)]; subplot(2,3,6); DATA6mask = (DATA6 <= 0.05);imagesc(DATA6mask,[0 1]); colorbar

colormap('gray')

% plot overall correlations CBC selected
% R: Freq vs Dur
init{1} = ones(918,9)*NaN; init{2} = ones(918,9)*NaN; init{3} = ones(918,9)*NaN;
INIT{1} = zeros(9,9)     ;INIT{2} = zeros(9,9)      ; INIT{3} = zeros(9,9);

for chan = 1:3
    init{chan}(x_pcorr1{chan},1) = GLOBAL_CBC_corr_R{chan}(x_pcorr1{chan});
    init{chan}(x_pcorr2{chan},2) = GLOBAL_CBC_corr_R{chan}(x_pcorr2{chan});
    init{chan}(x_pcorr3{chan},3) = GLOBAL_CBC_corr_R{chan}(x_pcorr3{chan});
    init{chan}(x_pcorr4{chan},4) = GLOBAL_CBC_corr_R{chan}(x_pcorr4{chan});
    init{chan}(x_pcorr5{chan},5) = GLOBAL_CBC_corr_R{chan}(x_pcorr5{chan});
    init{chan}(x_pcorr6{chan},6) = GLOBAL_CBC_corr_R{chan}(x_pcorr6{chan});
    init{chan}(x_pcorr7{chan},7) = GLOBAL_CBC_corr_R{chan}(x_pcorr7{chan});
    init{chan}(x_pcorr8{chan},8) = GLOBAL_CBC_corr_R{chan}(x_pcorr8{chan});
    init{chan}(x_pcorr9{chan},9) = GLOBAL_CBC_corr_R{chan}(x_pcorr9{chan});
end

rangelol = 1:102:918;
for i = 1:9
    INIT{1}(i,:) = nanmean(init{1}(rangelol(i):rangelol(i)+101,:));
    INIT{2}(i,:) = nanmean(init{2}(rangelol(i):rangelol(i)+101,:));
    INIT{3}(i,:) = nanmean(init{3}(rangelol(i):rangelol(i)+101,:));
end

for z = 1:3
    for i = 1:9
        for j = 1:9
            if isnan(INIT{z}(i,j))
                INIT{z}(i,j) = 0;
            end
        end
    end
end
            
% plot overall correlations CBC
% R: Freq vs Dur
DATA1 = [INIT{1}(:,2) INIT{2}(:,2) INIT{3}(:,2)]; subplot(2,3,1); imagesc(DATA1,[-0.5 0.5]); colorbar
DATA2 = [INIT{1}(:,5) INIT{2}(:,5) INIT{3}(:,5)]; subplot(2,3,2); imagesc(DATA2,[-0.5 0.5]); colorbar
DATA3 = [INIT{1}(:,8) INIT{2}(:,8) INIT{3}(:,8)]; subplot(2,3,3); imagesc(DATA3,[-0.5 0.5]); colorbar

DATA4 = [INIT{1}(:,1) INIT{2}(:,1) INIT{3}(:,1)]; subplot(2,3,4); imagesc(DATA4,[-0.5 0.5]); colorbar
DATA5 = [INIT{1}(:,4) INIT{2}(:,4) INIT{3}(:,4)]; subplot(2,3,5); imagesc(DATA5,[-0.5 0.5]); colorbar
DATA6 = [INIT{1}(:,7) INIT{2}(:,7) INIT{3}(:,7)]; subplot(2,3,6); imagesc(DATA6,[-0.5 0.5]); colorbar

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%ù
fig1 = figure('position',[1 1 1000 1000]);
set(fig1,'PaperPosition',[1 1 1000 1000])
set(fig1,'PaperPositionmode','auto')

bar([[mean(INIT{1}(:,2)) mean(INIT{2}(:,2)) mean(INIT{3}(:,2))]' [mean(INIT{1}(:,1)) mean(INIT{2}(:,1)) mean(INIT{3}(:,1))]']'); hold on;
errorbar([0.8 1 1.2],[mean(INIT{1}(:,2)) mean(INIT{2}(:,2)) mean(INIT{3}(:,2))],...
    [std(INIT{1}(:,2)) std(INIT{2}(:,2)) std(INIT{3}(:,2))]./sqrt(10),'color','k','linewidth',2,'linestyle','none'); hold on
errorbar([1.8 2 2.2],[mean(INIT{1}(:,1)) mean(INIT{2}(:,1)) mean(INIT{3}(:,1))],...
    [std(INIT{1}(:,1)) std(INIT{2}(:,1)) std(INIT{3}(:,1))]./sqrt(10),'color','k','linewidth',2,'linestyle','none'); hold on
legend('Mags','Grads1','Grads2','location','NorthWest');
ylabel('score de corrélation moyen +- ES','fontsize',30);
set(gca,'box','off','xtick',1:2,'xticklabel',{'Dur vs freq';'Dur vs Pow'},'fontsize',30,'linewidth',2);
axis([0.5 2.5 -0.1 0.4])

print('-dpng','C:\TEMPROD\DATA\NEW\FIG_THESIS\ALLCORRd_intersubAVG_selectedCBC_beta_replaysubest.png')

fig1 = figure('position',[1 1 1000 1000]);
set(fig1,'PaperPosition',[1 1 1000 1000])
set(fig1,'PaperPositionmode','auto')

bar([[mean(INIT{1}(:,5)) mean(INIT{2}(:,5)) mean(INIT{3}(:,5))]' [mean(INIT{1}(:,4)) mean(INIT{2}(:,4)) mean(INIT{3}(:,4))]']'); hold on;
errorbar([0.8 1 1.2],[mean(INIT{1}(:,5)) mean(INIT{2}(:,5)) mean(INIT{3}(:,5))],...
    [std(INIT{1}(:,4)) std(INIT{2}(:,5)) std(INIT{3}(:,5))]./sqrt(10),'color','k','linewidth',2,'linestyle','none'); hold on
errorbar([1.8 2 2.2],[mean(INIT{1}(:,4)) mean(INIT{2}(:,4)) mean(INIT{3}(:,4))],...
    [std(INIT{1}(:,4)) std(INIT{2}(:,4)) std(INIT{3}(:,4))]./sqrt(10),'color','k','linewidth',2,'linestyle','none'); hold on
legend('Mags','Grads1','Grads2','location','NorthWest');
ylabel('score de corrélation moyen +- ES','fontsize',30);
set(gca,'box','off','xtick',1:2,'xticklabel',{'Med vs freq';'Med vs Pow'},'fontsize',30,'linewidth',2);
axis([0.5 2.5 -0.1 0.4])

print('-dpng','C:\TEMPROD\DATA\NEW\FIG_THESIS\ALLCORRm_intersubAVG_selectedCBC_beta_replaysubest.png')

fig1 = figure('position',[1 1 1000 1000]);
set(fig1,'PaperPosition',[1 1 1000 1000])
set(fig1,'PaperPositionmode','auto')

bar([[mean(INIT{1}(:,8)) mean(INIT{2}(:,8)) mean(INIT{3}(:,8))]' [mean(INIT{1}(:,7)) mean(INIT{2}(:,7)) mean(INIT{3}(:,7))]']'); hold on;
errorbar([0.8 1 1.2],[mean(INIT{1}(:,8)) mean(INIT{2}(:,8)) mean(INIT{3}(:,8))],...
    [std(INIT{1}(:,8)) std(INIT{2}(:,8)) std(INIT{3}(:,8))]./sqrt(10),'color','k','linewidth',2,'linestyle','none'); hold on
errorbar([1.8 2 2.2],[mean(INIT{1}(:,7)) mean(INIT{2}(:,7)) mean(INIT{3}(:,7))],...
    [std(INIT{1}(:,7)) std(INIT{2}(:,7)) std(INIT{3}(:,7))]./sqrt(10),'color','k','linewidth',2,'linestyle','none'); hold on
legend('Mags','Grads1','Grads2','location','NorthWest');
ylabel('score de corrélation moyen +- ES','fontsize',30);
set(gca,'box','off','xtick',1:2,'xticklabel',{'Acc vs freq';'Acc vs Pow'},'fontsize',30,'linewidth',2);
axis([0.5 2.5 -0.1 0.4])

print('-dpng','C:\TEMPROD\DATA\NEW\FIG_THESIS\ALLCORRa_intersubAVG_selectedCBC_beta_replaysubest.png')
