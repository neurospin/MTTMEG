% Plot and write a text file usable by R software
%% low freq band

clear all
close all

SubjArray = {'s14','s13','s12','s11','s10','s08','s07','s06','s05','s04'};
FreqArray = {[2 7],[2 7],[2 7],[2 7],[2 7],[2 7],[2 7],[2 7],[2 7],[2 7]};
RunArray  = {[2 3 5 6],[2 3 5 6],[2 3 5 6],[2 3 5],[2 3 5 6],2:6,2:6,1:4,1:3,1:3};
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
    
    [xtmp4{chan},y4]   = find(global_AVG_corr_R{1,chan}(:,11) == 4); x4{chan} = xtmp4{chan};
    [xtmp5{chan},y5]   = find(global_AVG_corr_R{1,chan}(:,11) == 5); x5{chan} = xtmp5{chan};
    [xtmp6{chan},y6]   = find(global_AVG_corr_R{1,chan}(:,11) == 6); x6{chan} = xtmp6{chan};
    [xtmp7{chan},y7]   = find(global_AVG_corr_R{1,chan}(:,11) == 7); x7{chan} = xtmp7{chan};
    [xtmp8{chan},y8]   = find(global_AVG_corr_R{1,chan}(:,11) == 8); x8{chan} = xtmp8{chan};
    [xtmp10{chan},y10] = find(global_AVG_corr_R{1,chan}(:,11) == 10); x10{chan} = xtmp10{chan};
    [xtmp11{chan},y11] = find(global_AVG_corr_R{1,chan}(:,11) == 11); x11{chan} = xtmp11{chan};
    [xtmp12{chan},y12] = find(global_AVG_corr_R{1,chan}(:,11) == 12); x12{chan} = xtmp12{chan};
    [xtmp13{chan},y13] = find(global_AVG_corr_R{1,chan}(:,11) == 13); x13{chan} = xtmp13{chan};
    [xtmp14{chan},y14] = find(global_AVG_corr_R{1,chan}(:,11) == 14); x14{chan} = xtmp14{chan};
  
    [xtmp4{chan},y4]   = find(GLOBAL_CBC_corr_R{1,chan}(:,11) == 4); x4_{chan} = xtmp4{chan};
    [xtmp5{chan},y5]   = find(GLOBAL_CBC_corr_R{1,chan}(:,11) == 5); x5_{chan} = xtmp5{chan};
    [xtmp6{chan},y6]   = find(GLOBAL_CBC_corr_R{1,chan}(:,11) == 6); x6_{chan} = xtmp6{chan};
    [xtmp7{chan},y7]   = find(GLOBAL_CBC_corr_R{1,chan}(:,11) == 7); x7_{chan} = xtmp7{chan};
    [xtmp8{chan},y8]   = find(GLOBAL_CBC_corr_R{1,chan}(:,11) == 8); x8_{chan} = xtmp8{chan};
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

% plot overall correlations CBC selected
% R: slope vs dur
init{1} = ones(3978,9)*NaN; init{2} = ones(3978,9)*NaN; init{3} = ones(3978,9)*NaN;
INIT{1} = zeros(39,9)     ; INIT{2} = zeros(39,9)     ; INIT{3} = zeros(39,9);

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

rangelol = 1:102:3978;
for i = 1:39
    INIT{1}(i,:) = nanmean(init{1}(rangelol(i):rangelol(i)+101,:));
    INIT{2}(i,:) = nanmean(init{2}(rangelol(i):rangelol(i)+101,:));
    INIT{3}(i,:) = nanmean(init{3}(rangelol(i):rangelol(i)+101,:));
end

for z = 1:3
    for i = 1:39
        for j = 1:9
            if isnan(INIT{z}(i,j))
                INIT{z}(i,j) = 0;
            end
        end
    end
end
            
% plot overall correlations CBC
% R: Freq vs Dur
DATA1 = [INIT{1}(:,3) INIT{2}(:,3) INIT{3}(:,3)]; subplot(2,3,1); imagesc(DATA1,[-0.5 0.5]); colorbar
DATA2 = [INIT{1}(:,6) INIT{2}(:,6) INIT{3}(:,6)]; subplot(2,3,2); imagesc(DATA2,[-0.5 0.5]); colorbar
DATA3 = [INIT{1}(:,9) INIT{2}(:,9) INIT{3}(:,9)]; subplot(2,3,3); imagesc(DATA3,[-0.5 0.5]); colorbar


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%ù
fig1 = figure('position',[1 1 1000 1000]);
set(fig1,'PaperPosition',[1 1 1000 1000])
set(fig1,'PaperPositionmode','auto')

bar([[mean(INIT{1}(:,3)) mean(INIT{2}(:,3)) mean(INIT{3}(:,3))]' [mean(INIT{1}(:,6)) mean(INIT{2}(:,6)) mean(INIT{3}(:,6))]' ...
     [mean(INIT{1}(:,9)) mean(INIT{2}(:,9)) mean(INIT{3}(:,9))]']'); hold on;
errorbar([0.8 1 1.2],[mean(INIT{1}(:,3)) mean(INIT{2}(:,3)) mean(INIT{3}(:,3))],...
    [std(INIT{1}(:,3)) std(INIT{2}(:,3)) std(INIT{3}(:,3))]./sqrt(10),'color','k','linewidth',2,'linestyle','none'); hold on
errorbar([1.8 2 2.2],[mean(INIT{1}(:,6)) mean(INIT{2}(:,6)) mean(INIT{3}(:,6))],...
    [std(INIT{1}(:,6)) std(INIT{2}(:,6)) std(INIT{3}(:,6))]./sqrt(10),'color','k','linewidth',2,'linestyle','none'); hold on
errorbar([2.8 3 3.2],[mean(INIT{1}(:,9)) mean(INIT{2}(:,9)) mean(INIT{3}(:,9))],...
    [std(INIT{1}(:,9)) std(INIT{2}(:,9)) std(INIT{3}(:,9))]./sqrt(10),'color','k','linewidth',2,'linestyle','none'); hold on

legend('Mags','Grads1','Grads2','location','NorthWest');
ylabel('score de corrélation moyen +- ES','fontsize',30);
set(gca,'box','off','xtick',1:3,'xticklabel',{'Dur vs freq';'MedDev vs Pow';'Acc vs Pow'},'fontsize',30,'linewidth',2);
axis([0.5 3.5 -0.1 0.4])

print('-dpng','C:\TEMPROD\DATA\NEW\FIG_THESIS\ALLCORRd_intersubAVG_selectedCBC_lowfreq.png')

