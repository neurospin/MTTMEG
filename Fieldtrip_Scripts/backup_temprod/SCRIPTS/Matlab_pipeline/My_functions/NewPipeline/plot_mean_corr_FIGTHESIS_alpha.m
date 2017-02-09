% Plot and write a text file usable by R software
%% alpha band

clear all
close all

SubjArray = {'s14','s13','s12','s11','s10','s08','s07','s06','s05','s04'};
FreqArray = {[6.5 10.5],[6.5 10.5],[7 11],[5.5 9.5],[8 12],[6 10],[10 14],[8.5 12.5],[8.5 12.5],[9 13]};
RunArray  = {[2 3 5 6],[2 3 5 6],[2 3 5 6],[2 3 5],[2 3 5 6],2:6,2:6,1:4,1:3,1:3};
ChanArray = {'Mags','Grads1','Grads2'};

for chan = 1:3
    tmp_CBC_corr_R = [];
    tmp_CBC_corr_p = [];
    tmp_AVG_corr_R = [];
    tmp_AVG_corr_p = [];
    for i = 1:length(SubjArray)
        for j = 1:length(RunArray{i})
            load(['C:\TEMPROD\DATA\NEW\processed_' SubjArray{i} '\FT_spectra\SUMMARY_corr_' ChanArray{chan} '_' SubjArray{i} ...
                '_run' num2str(RunArray{i}(j)) '_freq'  num2str(FreqArray{i}(1)) '-' num2str(FreqArray{i}(2)) '.mat'])
            
            tmp_CBC_corr_R = [tmp_CBC_corr_R ; CBC_corr_R];
            tmp_CBC_corr_p = [tmp_CBC_corr_p ; CBC_corr_p];
            tmp_AVG_corr_R = [tmp_AVG_corr_R ; AVG_corr_R];
            tmp_AVG_corr_p = [tmp_AVG_corr_p ; AVG_corr_p];
            
        end
    end
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
  
    [xtmp4{chan},y4]   = find(global_CBC_corr_R{1,chan}(:,11) == 4); x4_{chan} = xtmp4{chan};
    [xtmp5{chan},y5]   = find(global_CBC_corr_R{1,chan}(:,11) == 5); x5_{chan} = xtmp5{chan};
    [xtmp6{chan},y6]   = find(global_CBC_corr_R{1,chan}(:,11) == 6); x6_{chan} = xtmp6{chan};
    [xtmp7{chan},y7]   = find(global_CBC_corr_R{1,chan}(:,11) == 7); x7_{chan} = xtmp7{chan};
    [xtmp8{chan},y8]   = find(global_CBC_corr_R{1,chan}(:,11) == 8); x8_{chan} = xtmp8{chan};
    [xtmp10{chan},y10] = find(global_CBC_corr_R{1,chan}(:,11) == 10); x10_{chan} = xtmp10{chan};
    [xtmp11{chan},y11] = find(global_CBC_corr_R{1,chan}(:,11) == 11); x11_{chan} = xtmp11{chan};
    [xtmp12{chan},y12] = find(global_CBC_corr_R{1,chan}(:,11) == 12); x12_{chan} = xtmp12{chan};
    [xtmp13{chan},y13] = find(global_CBC_corr_R{1,chan}(:,11) == 13); x13_{chan} = xtmp13{chan};
    [xtmp14{chan},y14] = find(global_CBC_corr_R{1,chan}(:,11) == 14); x14_{chan} = xtmp14{chan}; 
    
    [xtmp_pcorr{chan},y]   = find(global_CBC_corr_p{1,chan}(:,1) < 0.01); x_pcorr{chan} = xtmp_pcorr{chan};

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot correlation between AVG and behav

for chan = 1:3
    
    fig1 = figure('position',[1 1 1000 1000]);
    set(fig1,'PaperPosition',[1 1 1000 1000])
    set(fig1,'PaperPositionmode','auto')
    % mean AVG corr power with dur
    dAVG_Rm_p(chan,:) = [mean(global_AVG_corr_R{1,chan}(x4{1,chan},1)) mean(global_AVG_corr_R{1,chan}(x5{1,chan},1)) ...
        mean(global_AVG_corr_R{1,chan}(x6{1,chan},1)) mean(global_AVG_corr_R{1,chan}(x7{1,chan},1)) ...
        mean(global_AVG_corr_R{1,chan}(x8{1,chan},1)) mean(global_AVG_corr_R{1,chan}(x10{1,chan},1)) ...
        mean(global_AVG_corr_R{1,chan}(x11{1,chan},1)) mean(global_AVG_corr_R{1,chan}(x12{1,chan},1)) ...
        mean(global_AVG_corr_R{1,chan}(x13{1,chan},1)) mean(global_AVG_corr_R{1,chan}(x14{1,chan},1))];
    dAVG_Rsem_p(chan,:) = [std(global_AVG_corr_R{1,chan}(x4{1,chan},1))./sqrt(length(x4{1,chan})) std(global_AVG_corr_R{1,chan}(x5{1,chan},1))./sqrt(length(x5{1,chan})) ...
        std(global_AVG_corr_R{1,chan}(x6{1,chan},1))./sqrt(length(x6{1,chan})) std(global_AVG_corr_R{1,chan}(x7{1,chan},1))./sqrt(length(x7{1,chan})) ...
        std(global_AVG_corr_R{1,chan}(x8{1,chan},1))./sqrt(length(x8{1,chan})) std(global_AVG_corr_R{1,chan}(x10{1,chan},1))./sqrt(length(x10{1,chan})) ...
        std(global_AVG_corr_R{1,chan}(x11{1,chan},1))./sqrt(length(x11{1,chan})) std(global_AVG_corr_R{1,chan}(x12{1,chan},1))./sqrt(length(x12{1,chan})) ...
        std(global_AVG_corr_R{1,chan}(x13{1,chan},1))./sqrt(length(x13{1,chan})) std(global_AVG_corr_R{1,chan}(x14{1,chan},1))./sqrt(length(x14{1,chan}))];
    bar(dAVG_Rm_p(chan,:),'facecolor',[0.5 0.5 0.5]); hold on
    errorbar(1:10,dAVG_Rm_p(chan,:),dAVG_Rsem_p(chan,:),'linestyle','none','linewidth',3,'color','k')
    axis([0 11 -0.3 0.5]); ylabel('Corr�lation +- SEM : puissance vs Dur�e','fontsize',30)
    set(gca,'box','off','linewidth',3);
    set(gca,'Xtick',1:10,'Xticklabel',{'s04','s05','s06','s07','s08','s10','s11','s12','s13','s14'},'fontsize',30);
    
    print('-dpng',['C:\TEMPROD\DATA\NEW\FIG_THESIS\' ChanArray{chan} 'POW_DUR_CORR_alpha_AVG.png'])
    
    fig1 = figure('position',[1 1 1000 1000]);
    set(fig1,'PaperPosition',[1 1 1000 1000])
    set(fig1,'PaperPositionmode','auto')
    % mean AVG corr frequency with dur
    dAVG_Rm_f(chan,:) = [mean(global_AVG_corr_R{1,chan}(x4{1,chan},2)) mean(global_AVG_corr_R{1,chan}(x5{1,chan},2)) ...
        mean(global_AVG_corr_R{1,chan}(x6{1,chan},2)) mean(global_AVG_corr_R{1,chan}(x7{1,chan},2)) ...
        mean(global_AVG_corr_R{1,chan}(x8{1,chan},2)) mean(global_AVG_corr_R{1,chan}(x10{1,chan},2)) ...
        mean(global_AVG_corr_R{1,chan}(x11{1,chan},2)) mean(global_AVG_corr_R{1,chan}(x12{1,chan},2)) ...
        mean(global_AVG_corr_R{1,chan}(x13{1,chan},2)) mean(global_AVG_corr_R{1,chan}(x14{1,chan},2))];
    dAVG_Rsem_f(chan,:) = [std(global_AVG_corr_R{1,chan}(x4{1,chan},2))./sqrt(length(x4{1,chan})) std(global_AVG_corr_R{1,chan}(x5{1,chan},2))./sqrt(length(x5{1,chan})) ...
        std(global_AVG_corr_R{1,chan}(x6{1,chan},2))./sqrt(length(x6{1,chan})) std(global_AVG_corr_R{1,chan}(x7{1,chan},2))./sqrt(length(x7{1,chan})) ...
        std(global_AVG_corr_R{1,chan}(x8{1,chan},2))./sqrt(length(x8{1,chan})) std(global_AVG_corr_R{1,chan}(x10{1,chan},2))./sqrt(length(x10{1,chan})) ...
        std(global_AVG_corr_R{1,chan}(x11{1,chan},2))./sqrt(length(x11{1,chan})) std(global_AVG_corr_R{1,chan}(x12{1,chan},2))./sqrt(length(x12{1,chan})) ...
        std(global_AVG_corr_R{1,chan}(x13{1,chan},2))./sqrt(length(x13{1,chan})) std(global_AVG_corr_R{1,chan}(x14{1,chan},2))./sqrt(length(x14{1,chan}))];
    bar(dAVG_Rm_f(chan,:),'facecolor',[0.5 0.5 0.5]); hold on
    errorbar(1:10,dAVG_Rm_f(chan,:),dAVG_Rsem_f(chan,:),'linestyle','none','linewidth',3,'color','k')
    axis([0 11 -0.3 0.5]); ylabel('Corr�lation +- SEM : puissance vs Dur�e','fontsize',30)
    set(gca,'box','off','linewidth',3);
    set(gca,'Xtick',1:10,'Xticklabel',{'s04','s05','s06','s07','s08','s10','s11','s12','s13','s14'},'fontsize',30);
    
    print('-dpng',['C:\TEMPROD\DATA\NEW\FIG_THESIS\' ChanArray{chan} 'FREQ_DUR_CORR_alpha_AVG.png'])
 
    fig1 = figure('position',[1 1 1000 1000]);
    set(fig1,'PaperPosition',[1 1 1000 1000])
    set(fig1,'PaperPositionmode','auto')
    % mean AVG corr power with dur
    mAVG_Rm_p(chan,:) = [mean(global_AVG_corr_R{1,chan}(x4{1,chan},4)) mean(global_AVG_corr_R{1,chan}(x5{1,chan},4)) ...
        mean(global_AVG_corr_R{1,chan}(x6{1,chan},4)) mean(global_AVG_corr_R{1,chan}(x7{1,chan},4)) ...
        mean(global_AVG_corr_R{1,chan}(x8{1,chan},4)) mean(global_AVG_corr_R{1,chan}(x10{1,chan},4)) ...
        mean(global_AVG_corr_R{1,chan}(x11{1,chan},4)) mean(global_AVG_corr_R{1,chan}(x12{1,chan},4)) ...
        mean(global_AVG_corr_R{1,chan}(x13{1,chan},4)) mean(global_AVG_corr_R{1,chan}(x14{1,chan},4))];
    mAVG_Rsem_p(chan,:) = [std(global_AVG_corr_R{1,chan}(x4{1,chan},4))./sqrt(length(x4{1,chan})) std(global_AVG_corr_R{1,chan}(x5{1,chan},4))./sqrt(length(x5{1,chan})) ...
        std(global_AVG_corr_R{1,chan}(x6{1,chan},4))./sqrt(length(x6{1,chan})) std(global_AVG_corr_R{1,chan}(x7{1,chan},4))./sqrt(length(x7{1,chan})) ...
        std(global_AVG_corr_R{1,chan}(x8{1,chan},4))./sqrt(length(x8{1,chan})) std(global_AVG_corr_R{1,chan}(x10{1,chan},4))./sqrt(length(x10{1,chan})) ...
        std(global_AVG_corr_R{1,chan}(x11{1,chan},4))./sqrt(length(x11{1,chan})) std(global_AVG_corr_R{1,chan}(x12{1,chan},4))./sqrt(length(x12{1,chan})) ...
        std(global_AVG_corr_R{1,chan}(x13{1,chan},4))./sqrt(length(x13{1,chan})) std(global_AVG_corr_R{1,chan}(x14{1,chan},4))./sqrt(length(x14{1,chan}))];
    bar(mAVG_Rm_p(chan,:),'facecolor',[0.5 0.5 0.5]); hold on
    errorbar(1:10,mAVG_Rm_p(chan,:),mAVG_Rsem_p(chan,:),'linestyle','none','linewidth',3,'color','k')
    axis([0 11 -0.3 0.5]); ylabel('Corr�lation +- SEM : puissance vs MedDev','fontsize',30)
    set(gca,'box','off','linewidth',3);
    set(gca,'Xtick',1:10,'Xticklabel',{'s04','s05','s06','s07','s08','s10','s11','s12','s13','s14'},'fontsize',30);
    
    print('-dpng',['C:\TEMPROD\DATA\NEW\FIG_THESIS\' ChanArray{chan} 'POW_MED_CORR_alpha_AVG.png'])
    
    fig1 = figure('position',[1 1 1000 1000]);
    set(fig1,'PaperPosition',[1 1 1000 1000])
    set(fig1,'PaperPositionmode','auto')
    % mean AVG corr frequency with dur
    mAVG_Rm_f(chan,:) = [mean(global_AVG_corr_R{1,chan}(x4{1,chan},5)) mean(global_AVG_corr_R{1,chan}(x5{1,chan},5)) ...
        mean(global_AVG_corr_R{1,chan}(x6{1,chan},5)) mean(global_AVG_corr_R{1,chan}(x7{1,chan},5)) ...
        mean(global_AVG_corr_R{1,chan}(x8{1,chan},5)) mean(global_AVG_corr_R{1,chan}(x10{1,chan},5)) ...
        mean(global_AVG_corr_R{1,chan}(x11{1,chan},5)) mean(global_AVG_corr_R{1,chan}(x12{1,chan},5)) ...
        mean(global_AVG_corr_R{1,chan}(x13{1,chan},5)) mean(global_AVG_corr_R{1,chan}(x14{1,chan},5))];
    mAVG_Rsem_f(chan,:) = [std(global_AVG_corr_R{1,chan}(x4{1,chan},5))./sqrt(length(x4{1,chan})) std(global_AVG_corr_R{1,chan}(x5{1,chan},5))./sqrt(length(x5{1,chan})) ...
        std(global_AVG_corr_R{1,chan}(x6{1,chan},5))./sqrt(length(x6{1,chan})) std(global_AVG_corr_R{1,chan}(x7{1,chan},5))./sqrt(length(x7{1,chan})) ...
        std(global_AVG_corr_R{1,chan}(x8{1,chan},5))./sqrt(length(x8{1,chan})) std(global_AVG_corr_R{1,chan}(x10{1,chan},5))./sqrt(length(x10{1,chan})) ...
        std(global_AVG_corr_R{1,chan}(x11{1,chan},5))./sqrt(length(x11{1,chan})) std(global_AVG_corr_R{1,chan}(x12{1,chan},5))./sqrt(length(x12{1,chan})) ...
        std(global_AVG_corr_R{1,chan}(x13{1,chan},5))./sqrt(length(x13{1,chan})) std(global_AVG_corr_R{1,chan}(x14{1,chan},5))./sqrt(length(x14{1,chan}))];
    bar(mAVG_Rm_f(chan,:),'facecolor',[0.5 0.5 0.5]); hold on
    errorbar(1:10,mAVG_Rm_f(chan,:),mAVG_Rsem_f(chan,:),'linestyle','none','linewidth',3,'color','k')
    axis([0 11 -0.3 0.5]); ylabel('Corr�lation +- SEM : puissance vs MedDev','fontsize',30)
    set(gca,'box','off','linewidth',3);
    set(gca,'Xtick',1:10,'Xticklabel',{'s04','s05','s06','s07','s08','s10','s11','s12','s13','s14'},'fontsize',30);
    
    print('-dpng',['C:\TEMPROD\DATA\NEW\FIG_THESIS\' ChanArray{chan} 'FREQ_MED_CORR_alpha_AVG.png'])    
 
    fig1 = figure('position',[1 1 1000 1000]);
    set(fig1,'PaperPosition',[1 1 1000 1000])
    set(fig1,'PaperPositionmode','auto')
    % mean AVG corr power with dur
    aAVG_Rm_p(chan,:) = [mean(global_AVG_corr_R{1,chan}(x4{1,chan},7)) mean(global_AVG_corr_R{1,chan}(x5{1,chan},7)) ...
        mean(global_AVG_corr_R{1,chan}(x6{1,chan},7)) mean(global_AVG_corr_R{1,chan}(x7{1,chan},7)) ...
        mean(global_AVG_corr_R{1,chan}(x8{1,chan},7)) mean(global_AVG_corr_R{1,chan}(x10{1,chan},7)) ...
        mean(global_AVG_corr_R{1,chan}(x11{1,chan},7)) mean(global_AVG_corr_R{1,chan}(x12{1,chan},7)) ...
        mean(global_AVG_corr_R{1,chan}(x13{1,chan},7)) mean(global_AVG_corr_R{1,chan}(x14{1,chan},7))];
    aAVG_Rsem_p(chan,:) = [std(global_AVG_corr_R{1,chan}(x4{1,chan},7))./sqrt(length(x4{1,chan})) std(global_AVG_corr_R{1,chan}(x5{1,chan},7))./sqrt(length(x5{1,chan})) ...
        std(global_AVG_corr_R{1,chan}(x6{1,chan},7))./sqrt(length(x6{1,chan})) std(global_AVG_corr_R{1,chan}(x7{1,chan},7))./sqrt(length(x7{1,chan})) ...
        std(global_AVG_corr_R{1,chan}(x8{1,chan},7))./sqrt(length(x8{1,chan})) std(global_AVG_corr_R{1,chan}(x10{1,chan},7))./sqrt(length(x10{1,chan})) ...
        std(global_AVG_corr_R{1,chan}(x11{1,chan},7))./sqrt(length(x11{1,chan})) std(global_AVG_corr_R{1,chan}(x12{1,chan},7))./sqrt(length(x12{1,chan})) ...
        std(global_AVG_corr_R{1,chan}(x13{1,chan},7))./sqrt(length(x13{1,chan})) std(global_AVG_corr_R{1,chan}(x14{1,chan},7))./sqrt(length(x14{1,chan}))];
    bar(aAVG_Rm_p(chan,:),'facecolor',[0.5 0.5 0.5]); hold on
    errorbar(1:10,aAVG_Rm_p(chan,:),aAVG_Rsem_p(chan,:),'linestyle','none','linewidth',3,'color','k')
    axis([0 11 -0.3 0.5]); ylabel('Corr�lation +- SEM : puissance vs Acc','fontsize',30)
    set(gca,'box','off','linewidth',3);
    set(gca,'Xtick',1:10,'Xticklabel',{'s04','s05','s06','s07','s08','s10','s11','s12','s13','s14'},'fontsize',30);
    
    print('-dpng',['C:\TEMPROD\DATA\NEW\FIG_THESIS\' ChanArray{chan} 'POW_ACC_CORR_alpha_AVG.png'])
    
    fig1 = figure('position',[1 1 1000 1000]);
    set(fig1,'PaperPosition',[1 1 1000 1000])
    set(fig1,'PaperPositionmode','auto')
    % mean AVG corr frequency with dur
    aAVG_Rm_f(chan,:) = [mean(global_AVG_corr_R{1,chan}(x4{1,chan},8)) mean(global_AVG_corr_R{1,chan}(x5{1,chan},8)) ...
        mean(global_AVG_corr_R{1,chan}(x6{1,chan},8)) mean(global_AVG_corr_R{1,chan}(x7{1,chan},8)) ...
        mean(global_AVG_corr_R{1,chan}(x8{1,chan},8)) mean(global_AVG_corr_R{1,chan}(x10{1,chan},8)) ...
        mean(global_AVG_corr_R{1,chan}(x11{1,chan},8)) mean(global_AVG_corr_R{1,chan}(x12{1,chan},8)) ...
        mean(global_AVG_corr_R{1,chan}(x13{1,chan},8)) mean(global_AVG_corr_R{1,chan}(x14{1,chan},8))];
    aAVG_Rsem_f(chan,:) = [std(global_AVG_corr_R{1,chan}(x4{1,chan},8))./sqrt(length(x4{1,chan})) std(global_AVG_corr_R{1,chan}(x5{1,chan},8))./sqrt(length(x5{1,chan})) ...
        std(global_AVG_corr_R{1,chan}(x6{1,chan},8))./sqrt(length(x6{1,chan})) std(global_AVG_corr_R{1,chan}(x7{1,chan},8))./sqrt(length(x7{1,chan})) ...
        std(global_AVG_corr_R{1,chan}(x8{1,chan},8))./sqrt(length(x8{1,chan})) std(global_AVG_corr_R{1,chan}(x10{1,chan},8))./sqrt(length(x10{1,chan})) ...
        std(global_AVG_corr_R{1,chan}(x11{1,chan},8))./sqrt(length(x11{1,chan})) std(global_AVG_corr_R{1,chan}(x12{1,chan},8))./sqrt(length(x12{1,chan})) ...
        std(global_AVG_corr_R{1,chan}(x13{1,chan},8))./sqrt(length(x13{1,chan})) std(global_AVG_corr_R{1,chan}(x14{1,chan},8))./sqrt(length(x14{1,chan}))];
    bar(aAVG_Rm_f(chan,:),'facecolor',[0.5 0.5 0.5]); hold on
    errorbar(1:10,aAVG_Rm_f(chan,:),aAVG_Rsem_f(chan,:),'linestyle','none','linewidth',3,'color','k')
    axis([0 11 -0.3 0.5]); ylabel('Corr�lation +- SEM : puissance vs Acc','fontsize',30)
    set(gca,'box','off','linewidth',3);
    set(gca,'Xtick',1:10,'Xticklabel',{'s04','s05','s06','s07','s08','s10','s11','s12','s13','s14'},'fontsize',30);
    
    print('-dpng',['C:\TEMPROD\DATA\NEW\FIG_THESIS\' ChanArray{chan} 'FREQ_ACC_CORR_alpha_AVG.png'])     
    
end

%%%%%%%%%%%%%%%% plot avg across subject %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 1000 1000]);
set(fig1,'PaperPosition',[1 1 1000 1000])
set(fig1,'PaperPositionmode','auto')

bar([mean(dAVG_Rm_f,2) mean(dAVG_Rm_p,2)]'); hold on;
errorbar([[0.8 1 1.2];[1.8 2 2.2]],[mean(dAVG_Rm_f,2) mean(dAVG_Rm_p,2)]',...
        [std(dAVG_Rm_f'); std(dAVG_Rm_p')]./sqrt(10),'color','k','linewidth',2,'linestyle','none'); hold on
legend('Mags','Grads1','Grads2');
ylabel('score de corr�lation moyen +- ES','fontsize',30);
set(gca,'box','off','xtick',1:2,'xticklabel',{'Dur vs freq';'Dur vs Pow'},'fontsize',30,'linewidth',2);
axis([0.5 2.5 -0.1 0.4])

print('-dpng','C:\TEMPROD\DATA\NEW\FIG_THESIS\ALLCORRd_intersubAVG_alpha.png')

%%%%%

fig1 = figure('position',[1 1 1000 1000]);
set(fig1,'PaperPosition',[1 1 1000 1000])
set(fig1,'PaperPositionmode','auto')

bar([mean(mAVG_Rm_f,2) mean(mAVG_Rm_p,2)]'); hold on;
errorbar([[0.8 1 1.2];[1.8 2 2.2]],[mean(mAVG_Rm_f,2) mean(mAVG_Rm_p,2)]',...
        [std(mAVG_Rm_f'); std(mAVG_Rm_p')]./sqrt(10),'color','k','linewidth',2,'linestyle','none'); hold on
legend('Mags','Grads1','Grads2');
ylabel('score de corr�lation moyen +- ES','fontsize',30);
set(gca,'box','off','xtick',1:2,'xticklabel',{'MedDev vs freq';'MedDev vs Pow'},'fontsize',30,'linewidth',2);
axis([0.5 2.5 -0.1 0.4])

print('-dpng','C:\TEMPROD\DATA\NEW\FIG_THESIS\ALLCORRm_intersubAVG_alpha.png')

%%%%%

fig1 = figure('position',[1 1 1000 1000]);
set(fig1,'PaperPosition',[1 1 1000 1000])
set(fig1,'PaperPositionmode','auto')

bar([mean(aAVG_Rm_f,2) mean(aAVG_Rm_p,2)]'); hold on;
errorbar([[0.8 1 1.2];[1.8 2 2.2]],[mean(aAVG_Rm_f,2) mean(aAVG_Rm_p,2)]',...
        [std(aAVG_Rm_f'); std(aAVG_Rm_p')]./sqrt(10),'color','k','linewidth',2,'linestyle','none'); hold on
legend('Mags','Grads1','Grads2');
ylabel('score de corr�lation moyen +- ES','fontsize',30);
set(gca,'box','off','xtick',1:2,'xticklabel',{'Acc vs freq';'Acc vs Pow'},'fontsize',30,'linewidth',2);
axis([0.5 2.5 -0.1 0.4])

print('-dpng','C:\TEMPROD\DATA\NEW\FIG_THESIS\ALLCORRa_intersubAVG_alpha.png')

% [h,p] = ttest(AVG_Rm_f(1,:))
% [h,p] = ttest(AVG_Rm_f(2,:))
% [h,p] = ttest(AVG_Rm_f(3,:))
% 
% [h,p] = ttest(AVG_Rm_p(1,:))
% [h,p] = ttest(AVG_Rm_p(2,:))
% [h,p] = ttest(AVG_Rm_p(3,:))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot correlation between CBC and behav
for chan = 1:3
    
    fig1 = figure('position',[1 1 1000 1000]);
    set(fig1,'PaperPosition',[1 1 1000 1000])
    set(fig1,'PaperPositionmode','auto')
    % mean AVG corr power with dur
    dCBC_RmP(chan,:) = [mean(global_CBC_corr_R{1,chan}(x4_{1,chan},1)) nanmean(global_CBC_corr_R{1,chan}(x5_{1,chan},1)) ...
        nanmean(global_CBC_corr_R{1,chan}(x6_{1,chan},1)) nanmean(global_CBC_corr_R{1,chan}(x7_{1,chan},1)) ...
        nanmean(global_CBC_corr_R{1,chan}(x8_{1,chan},1)) nanmean(global_CBC_corr_R{1,chan}(x10_{1,chan},1)) ...
        nanmean(global_CBC_corr_R{1,chan}(x11_{1,chan},1)) nanmean(global_CBC_corr_R{1,chan}(x12_{1,chan},1)) ...
        nanmean(global_CBC_corr_R{1,chan}(x13_{1,chan},1)) nanmean(global_CBC_corr_R{1,chan}(x14_{1,chan},1))];
    dCBC_RsemP(chan,:) = [nanstd(global_CBC_corr_R{1,chan}(x4_{1,chan},1))./sqrt(length(x4{1,chan})) nanstd(global_CBC_corr_R{1,chan}(x5_{1,chan},1))./sqrt(length(x5{1,chan})) ...
        nanstd(global_CBC_corr_R{1,chan}(x6_{1,chan},1))./sqrt(length(x6{1,chan})) nanstd(global_CBC_corr_R{1,chan}(x7_{1,chan},1))./sqrt(length(x7{1,chan})) ...
        nanstd(global_CBC_corr_R{1,chan}(x8_{1,chan},1))./sqrt(length(x8{1,chan})) nanstd(global_CBC_corr_R{1,chan}(x10_{1,chan},1))./sqrt(length(x10{1,chan})) ...
        nanstd(global_CBC_corr_R{1,chan}(x11_{1,chan},1))./sqrt(length(x11{1,chan})) nanstd(global_CBC_corr_R{1,chan}(x12_{1,chan},1))./sqrt(length(x12{1,chan})) ...
        nanstd(global_CBC_corr_R{1,chan}(x13_{1,chan},1))./sqrt(length(x13{1,chan})) nanstd(global_CBC_corr_R{1,chan}(x14_{1,chan},1))./sqrt(length(x14{1,chan}))];
    bar(dCBC_RmP(chan,:),'facecolor',[0.5 0.5 0.5]); hold on
    errorbar(1:10,dCBC_RmP(chan,:),dCBC_RsemP(chan,:),'linestyle','none','linewidth',3,'color','k')
    axis([0 11 -0.3 0.5]); ylabel('Corr�lation +- SEM : puissance vs Dur�e','fontsize',30)
    set(gca,'box','off','linewidth',3);
    set(gca,'Xtick',1:10,'Xticklabel',{'s04','s05','s06','s07','s08','s10','s11','s12','s13','s14'},'fontsize',30);
    
    print('-dpng',['C:\TEMPROD\DATA\NEW\FIG_THESIS\' ChanArray{chan} 'POW_DUR_CORR_alpha_CBC.png'])
    
    fig1 = figure('position',[1 1 1000 1000]);
    set(fig1,'PaperPosition',[1 1 1000 1000])
    set(fig1,'PaperPositionmode','auto')
    % nanmean CBC corr frequency with dur
    dCBC_RmF(chan,:) = [nanmean(global_CBC_corr_R{1,chan}(x4_{1,chan},2)) nanmean(global_CBC_corr_R{1,chan}(x5_{1,chan},2)) ...
        nanmean(global_CBC_corr_R{1,chan}(x6_{1,chan},2)) nanmean(global_CBC_corr_R{1,chan}(x7_{1,chan},2)) ...
        nanmean(global_CBC_corr_R{1,chan}(x8_{1,chan},2)) nanmean(global_CBC_corr_R{1,chan}(x10_{1,chan},2)) ...
        nanmean(global_CBC_corr_R{1,chan}(x11_{1,chan},2)) nanmean(global_CBC_corr_R{1,chan}(x12_{1,chan},2)) ...
        nanmean(global_CBC_corr_R{1,chan}(x13_{1,chan},2)) nanmean(global_CBC_corr_R{1,chan}(x14_{1,chan},2))];
    dCBC_RsemF(chan,:) = [nanstd(global_CBC_corr_R{1,chan}(x4_{1,chan},2))./sqrt(length(x4{1,chan})) nanstd(global_CBC_corr_R{1,chan}(x5_{1,chan},2))./sqrt(length(x5{1,chan})) ...
        nanstd(global_CBC_corr_R{1,chan}(x6_{1,chan},2))./sqrt(length(x6{1,chan})) nanstd(global_CBC_corr_R{1,chan}(x7_{1,chan},2))./sqrt(length(x7{1,chan})) ...
        nanstd(global_CBC_corr_R{1,chan}(x8_{1,chan},2))./sqrt(length(x8{1,chan})) nanstd(global_CBC_corr_R{1,chan}(x10_{1,chan},2))./sqrt(length(x10{1,chan})) ...
        nanstd(global_CBC_corr_R{1,chan}(x11_{1,chan},2))./sqrt(length(x11{1,chan})) nanstd(global_CBC_corr_R{1,chan}(x12_{1,chan},2))./sqrt(length(x12{1,chan})) ...
        nanstd(global_CBC_corr_R{1,chan}(x13_{1,chan},2))./sqrt(length(x13{1,chan})) nanstd(global_CBC_corr_R{1,chan}(x14_{1,chan},2))./sqrt(length(x14{1,chan}))];
    bar(dCBC_RmF(chan,:),'facecolor',[0.5 0.5 0.5]); hold on
    errorbar(1:10,dCBC_RmF(chan,:),dCBC_RsemF(chan,:),'linestyle','none','linewidth',3,'color','k')
    axis([0 11 -0.3 0.5]); ylabel('Corr�lation +- SEM : puissance vs Dur�e','fontsize',30)
    set(gca,'box','off','linewidth',3);
    set(gca,'Xtick',1:10,'Xticklabel',{'s04','s05','s06','s07','s08','s10','s11','s12','s13','s14'},'fontsize',30);
    
    print('-dpng',['C:\TEMPROD\DATA\NEW\FIG_THESIS\' ChanArray{chan} 'FREQ_DUR_CORR_alpha_CBC.png'])
    
    fig1 = figure('position',[1 1 1000 1000]);
    set(fig1,'PaperPosition',[1 1 1000 1000])
    set(fig1,'PaperPositionmode','auto')
    % mean AVG corr power with dur
    mCBC_RmP(chan,:) = [mean(global_CBC_corr_R{1,chan}(x4_{1,chan},4)) nanmean(global_CBC_corr_R{1,chan}(x5_{1,chan},4)) ...
        nanmean(global_CBC_corr_R{1,chan}(x6_{1,chan},4)) nanmean(global_CBC_corr_R{1,chan}(x7_{1,chan},4)) ...
        nanmean(global_CBC_corr_R{1,chan}(x8_{1,chan},4)) nanmean(global_CBC_corr_R{1,chan}(x10_{1,chan},4)) ...
        nanmean(global_CBC_corr_R{1,chan}(x11_{1,chan},4)) nanmean(global_CBC_corr_R{1,chan}(x12_{1,chan},4)) ...
        nanmean(global_CBC_corr_R{1,chan}(x13_{1,chan},4)) nanmean(global_CBC_corr_R{1,chan}(x14_{1,chan},4))];
    mCBC_RsemP(chan,:) = [nanstd(global_CBC_corr_R{1,chan}(x4_{1,chan},4))./sqrt(length(x4{1,chan})) nanstd(global_CBC_corr_R{1,chan}(x5_{1,chan},4))./sqrt(length(x5{1,chan})) ...
        nanstd(global_CBC_corr_R{1,chan}(x6_{1,chan},4))./sqrt(length(x6{1,chan})) nanstd(global_CBC_corr_R{1,chan}(x7_{1,chan},4))./sqrt(length(x7{1,chan})) ...
        nanstd(global_CBC_corr_R{1,chan}(x8_{1,chan},4))./sqrt(length(x8{1,chan})) nanstd(global_CBC_corr_R{1,chan}(x10_{1,chan},4))./sqrt(length(x10{1,chan})) ...
        nanstd(global_CBC_corr_R{1,chan}(x11_{1,chan},4))./sqrt(length(x11{1,chan})) nanstd(global_CBC_corr_R{1,chan}(x12_{1,chan},4))./sqrt(length(x12{1,chan})) ...
        nanstd(global_CBC_corr_R{1,chan}(x13_{1,chan},4))./sqrt(length(x13{1,chan})) nanstd(global_CBC_corr_R{1,chan}(x14_{1,chan},4))./sqrt(length(x14{1,chan}))];
    bar(mCBC_RmP(chan,:),'facecolor',[0.5 0.5 0.5]); hold on
    errorbar(1:10,mCBC_RmP(chan,:),mCBC_RsemP(chan,:),'linestyle','none','linewidth',3,'color','k')
    axis([0 11 -0.3 0.5]); ylabel('Corr�lation +- SEM : puissance vs Dur�e','fontsize',30)
    set(gca,'box','off','linewidth',3);
    set(gca,'Xtick',1:10,'Xticklabel',{'s04','s05','s06','s07','s08','s10','s11','s12','s13','s14'},'fontsize',30);
    
    print('-dpng',['C:\TEMPROD\DATA\NEW\FIG_THESIS\' ChanArray{chan} 'POW_MED_CORR_alpha_CBC.png'])
    
    fig1 = figure('position',[1 1 1000 1000]);
    set(fig1,'PaperPosition',[1 1 1000 1000])
    set(fig1,'PaperPositionmode','auto')
    % nanmean CBC corr frequency with dur
    mCBC_RmF(chan,:) = [nanmean(global_CBC_corr_R{1,chan}(x4_{1,chan},5)) nanmean(global_CBC_corr_R{1,chan}(x5_{1,chan},5)) ...
        nanmean(global_CBC_corr_R{1,chan}(x6_{1,chan},5)) nanmean(global_CBC_corr_R{1,chan}(x7_{1,chan},5)) ...
        nanmean(global_CBC_corr_R{1,chan}(x8_{1,chan},5)) nanmean(global_CBC_corr_R{1,chan}(x10_{1,chan},5)) ...
        nanmean(global_CBC_corr_R{1,chan}(x11_{1,chan},5)) nanmean(global_CBC_corr_R{1,chan}(x12_{1,chan},5)) ...
        nanmean(global_CBC_corr_R{1,chan}(x13_{1,chan},5)) nanmean(global_CBC_corr_R{1,chan}(x14_{1,chan},5))];
    mCBC_RsemF(chan,:) = [nanstd(global_CBC_corr_R{1,chan}(x4_{1,chan},5))./sqrt(length(x4{1,chan})) nanstd(global_CBC_corr_R{1,chan}(x5_{1,chan},5))./sqrt(length(x5{1,chan})) ...
        nanstd(global_CBC_corr_R{1,chan}(x6_{1,chan},5))./sqrt(length(x6{1,chan})) nanstd(global_CBC_corr_R{1,chan}(x7_{1,chan},5))./sqrt(length(x7{1,chan})) ...
        nanstd(global_CBC_corr_R{1,chan}(x8_{1,chan},5))./sqrt(length(x8{1,chan})) nanstd(global_CBC_corr_R{1,chan}(x10_{1,chan},5))./sqrt(length(x10{1,chan})) ...
        nanstd(global_CBC_corr_R{1,chan}(x11_{1,chan},5))./sqrt(length(x11{1,chan})) nanstd(global_CBC_corr_R{1,chan}(x12_{1,chan},5))./sqrt(length(x12{1,chan})) ...
        nanstd(global_CBC_corr_R{1,chan}(x13_{1,chan},5))./sqrt(length(x13{1,chan})) nanstd(global_CBC_corr_R{1,chan}(x14_{1,chan},5))./sqrt(length(x14{1,chan}))];
    bar(mCBC_RmF(chan,:),'facecolor',[0.5 0.5 0.5]); hold on
    errorbar(1:10,mCBC_RmF(chan,:),mCBC_RsemF(chan,:),'linestyle','none','linewidth',3,'color','k')
    axis([0 11 -0.3 0.5]); ylabel('Corr�lation +- SEM : puissance vs Dur�e','fontsize',30)
    set(gca,'box','off','linewidth',3);
    set(gca,'Xtick',1:10,'Xticklabel',{'s04','s05','s06','s07','s08','s10','s11','s12','s13','s14'},'fontsize',30);
    
    print('-dpng',['C:\TEMPROD\DATA\NEW\FIG_THESIS\' ChanArray{chan} 'FREQ_MED_CORR_alpha_CBC.png'])
   
    fig1 = figure('position',[1 1 1000 1000]);
    set(fig1,'PaperPosition',[1 1 1000 1000])
    set(fig1,'PaperPositionmode','auto')
    % mean AVG corr power with dur
    aCBC_RmP(chan,:) = [mean(global_CBC_corr_R{1,chan}(x4_{1,chan},7)) nanmean(global_CBC_corr_R{1,chan}(x5_{1,chan},7)) ...
        nanmean(global_CBC_corr_R{1,chan}(x6_{1,chan},7)) nanmean(global_CBC_corr_R{1,chan}(x7_{1,chan},7)) ...
        nanmean(global_CBC_corr_R{1,chan}(x8_{1,chan},7)) nanmean(global_CBC_corr_R{1,chan}(x10_{1,chan},7)) ...
        nanmean(global_CBC_corr_R{1,chan}(x11_{1,chan},7)) nanmean(global_CBC_corr_R{1,chan}(x12_{1,chan},7)) ...
        nanmean(global_CBC_corr_R{1,chan}(x13_{1,chan},7)) nanmean(global_CBC_corr_R{1,chan}(x14_{1,chan},7))];
    aCBC_RsemP(chan,:) = [nanstd(global_CBC_corr_R{1,chan}(x4_{1,chan},7))./sqrt(length(x4{1,chan})) nanstd(global_CBC_corr_R{1,chan}(x5_{1,chan},7))./sqrt(length(x5{1,chan})) ...
        nanstd(global_CBC_corr_R{1,chan}(x6_{1,chan},7))./sqrt(length(x6{1,chan})) nanstd(global_CBC_corr_R{1,chan}(x7_{1,chan},7))./sqrt(length(x7{1,chan})) ...
        nanstd(global_CBC_corr_R{1,chan}(x8_{1,chan},7))./sqrt(length(x8{1,chan})) nanstd(global_CBC_corr_R{1,chan}(x10_{1,chan},7))./sqrt(length(x10{1,chan})) ...
        nanstd(global_CBC_corr_R{1,chan}(x11_{1,chan},7))./sqrt(length(x11{1,chan})) nanstd(global_CBC_corr_R{1,chan}(x12_{1,chan},7))./sqrt(length(x12{1,chan})) ...
        nanstd(global_CBC_corr_R{1,chan}(x13_{1,chan},7))./sqrt(length(x13{1,chan})) nanstd(global_CBC_corr_R{1,chan}(x14_{1,chan},7))./sqrt(length(x14{1,chan}))];
    bar(aCBC_RmP(chan,:),'facecolor',[0.5 0.5 0.5]); hold on
    errorbar(1:10,aCBC_RmP(chan,:),aCBC_RsemP(chan,:),'linestyle','none','linewidth',3,'color','k')
    axis([0 11 -0.3 0.5]); ylabel('Corr�lation +- SEM : puissance vs Dur�e','fontsize',30)
    set(gca,'box','off','linewidth',3);
    set(gca,'Xtick',1:10,'Xticklabel',{'s04','s05','s06','s07','s08','s10','s11','s12','s13','s14'},'fontsize',30);
    
    print('-dpng',['C:\TEMPROD\DATA\NEW\FIG_THESIS\' ChanArray{chan} 'POW_ACC_CORR_alpha_CBC.png'])
    
    fig1 = figure('position',[1 1 1000 1000]);
    set(fig1,'PaperPosition',[1 1 1000 1000])
    set(fig1,'PaperPositionmode','auto')
    % nanmean CBC corr frequency with dur
    aCBC_RmF(chan,:) = [nanmean(global_CBC_corr_R{1,chan}(x4_{1,chan},8)) nanmean(global_CBC_corr_R{1,chan}(x5_{1,chan},8)) ...
        nanmean(global_CBC_corr_R{1,chan}(x6_{1,chan},8)) nanmean(global_CBC_corr_R{1,chan}(x7_{1,chan},8)) ...
        nanmean(global_CBC_corr_R{1,chan}(x8_{1,chan},8)) nanmean(global_CBC_corr_R{1,chan}(x10_{1,chan},8)) ...
        nanmean(global_CBC_corr_R{1,chan}(x11_{1,chan},8)) nanmean(global_CBC_corr_R{1,chan}(x12_{1,chan},8)) ...
        nanmean(global_CBC_corr_R{1,chan}(x13_{1,chan},8)) nanmean(global_CBC_corr_R{1,chan}(x14_{1,chan},8))];
    aCBC_RsemF(chan,:) = [nanstd(global_CBC_corr_R{1,chan}(x4_{1,chan},8))./sqrt(length(x4{1,chan})) nanstd(global_CBC_corr_R{1,chan}(x5_{1,chan},8))./sqrt(length(x5{1,chan})) ...
        nanstd(global_CBC_corr_R{1,chan}(x6_{1,chan},8))./sqrt(length(x6{1,chan})) nanstd(global_CBC_corr_R{1,chan}(x7_{1,chan},8))./sqrt(length(x7{1,chan})) ...
        nanstd(global_CBC_corr_R{1,chan}(x8_{1,chan},8))./sqrt(length(x8{1,chan})) nanstd(global_CBC_corr_R{1,chan}(x10_{1,chan},8))./sqrt(length(x10{1,chan})) ...
        nanstd(global_CBC_corr_R{1,chan}(x11_{1,chan},8))./sqrt(length(x11{1,chan})) nanstd(global_CBC_corr_R{1,chan}(x12_{1,chan},8))./sqrt(length(x12{1,chan})) ...
        nanstd(global_CBC_corr_R{1,chan}(x13_{1,chan},8))./sqrt(length(x13{1,chan})) nanstd(global_CBC_corr_R{1,chan}(x14_{1,chan},8))./sqrt(length(x14{1,chan}))];
    bar(aCBC_RmF(chan,:),'facecolor',[0.5 0.5 0.5]); hold on
    errorbar(1:10,aCBC_RmF(chan,:),aCBC_RsemF(chan,:),'linestyle','none','linewidth',3,'color','k')
    axis([0 11 -0.3 0.5]); ylabel('Corr�lation +- SEM : puissance vs Dur�e','fontsize',30)
    set(gca,'box','off','linewidth',3);
    set(gca,'Xtick',1:10,'Xticklabel',{'s04','s05','s06','s07','s08','s10','s11','s12','s13','s14'},'fontsize',30);
    
    print('-dpng',['C:\TEMPROD\DATA\NEW\FIG_THESIS\' ChanArray{chan} 'FREQ_ACC_CORR_alpha_CBC.png'])    
    
end

%%%%%%%%%%%%%%%% plot avg across subject %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 1000 1000]);
set(fig1,'PaperPosition',[1 1 1000 1000])
set(fig1,'PaperPositionmode','auto')

bar([mean(dCBC_RmF,2) mean(dCBC_RmP,2)]'); hold on;
errorbar([[0.8 1 1.2];[1.8 2 2.2]],[mean(dCBC_RmF,2) mean(dCBC_RmP,2)]',...
        [std(dCBC_RmF'); std(dCBC_RmP')]./sqrt(10),'color','k','linewidth',2,'linestyle','none'); hold on
legend('Mags','Grads1','Grads2','location','NorthWest');
ylabel('score de corr�lation moyen +- ES','fontsize',30);
set(gca,'box','off','xtick',1:2,'xticklabel',{'Dur vs freq';'Dur vs Pow'},'fontsize',30,'linewidth',2);
axis([0.5 2.5 -0.1 0.4])

print('-dpng','C:\TEMPROD\DATA\NEW\FIG_THESIS\ALLCORRd_intersubAVGCBC_alpha.png')

%%%
fig1 = figure('position',[1 1 1000 1000]);
set(fig1,'PaperPosition',[1 1 1000 1000])
set(fig1,'PaperPositionmode','auto')

bar([mean(mCBC_RmF,2) mean(mCBC_RmP,2)]'); hold on;
errorbar([[0.8 1 1.2];[1.8 2 2.2]],[mean(mCBC_RmF,2) mean(mCBC_RmP,2)]',...
        [std(mCBC_RmF'); std(mCBC_RmP')]./sqrt(10),'color','k','linewidth',2,'linestyle','none'); hold on
legend('Mags','Grads1','Grads2','location','NorthWest');
ylabel('score de corr�lation moyen +- ES','fontsize',30);
set(gca,'box','off','xtick',1:2,'xticklabel',{'Dur vs freq';'Dur vs Pow'},'fontsize',30,'linewidth',2);
axis([0.5 2.5 -0.1 0.4])

print('-dpng','C:\TEMPROD\DATA\NEW\FIG_THESIS\ALLCORRm_intersubAVGCBC_alpha.png')

%%
fig1 = figure('position',[1 1 1000 1000]);
set(fig1,'PaperPosition',[1 1 1000 1000])
set(fig1,'PaperPositionmode','auto')

bar([mean(aCBC_RmF,2) mean(aCBC_RmP,2)]'); hold on;
errorbar([[0.8 1 1.2];[1.8 2 2.2]],[mean(aCBC_RmF,2) mean(aCBC_RmP,2)]',...
        [std(aCBC_RmF'); std(aCBC_RmP')]./sqrt(10),'color','k','linewidth',2,'linestyle','none'); hold on
legend('Mags','Grads1','Grads2','location','NorthWest');
ylabel('score de corr�lation moyen +- ES','fontsize',30);
set(gca,'box','off','xtick',1:2,'xticklabel',{'Dur vs freq';'Dur vs Pow'},'fontsize',30,'linewidth',2);
axis([0.5 2.5 -0.1 0.4])

print('-dpng','C:\TEMPROD\DATA\NEW\FIG_THESIS\ALLCORRa_intersubAVGCBC_alpha.png')


% [h,p] = ttest(CBC_RmF(1,:))
% [h,p] = ttest(CBC_RmF(2,:))
% [h,p] = ttest(CBC_RmF(3,:))
% 
% [h,p] = ttest(CBC_RmP(1,:))
% [h,p] = ttest(CBC_RmP(2,:))
% [h,p] = ttest(CBC_RmP(3,:))

%%%%%%%%%%%%%%% plot AVG corr of significantly correlated channels %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot correlation between CBC and behav
for chan = 1:3
    
    x4_{chan}  = intersect(x4_{chan},x_pcorr{chan});
    x5_{chan}  = intersect(x5_{chan},x_pcorr{chan});
    x6_{chan}  = intersect(x6_{chan},x_pcorr{chan});
    x7_{chan}  = intersect(x7_{chan},x_pcorr{chan});
    x8_{chan}  = intersect(x8_{chan},x_pcorr{chan});
    x10_{chan} = intersect(x10_{chan},x_pcorr{chan});
    x11_{chan} = intersect(x11_{chan},x_pcorr{chan});
    x12_{chan} = intersect(x12_{chan},x_pcorr{chan});
    x13_{chan} = intersect(x13_{chan},x_pcorr{chan});
    x14_{chan} = intersect(x14_{chan},x_pcorr{chan});
    
    fig1 = figure('position',[1 1 1000 1000]);
    set(fig1,'PaperPosition',[1 1 1000 1000])
    set(fig1,'PaperPositionmode','auto')
    % mean AVG corr power with dur
    CBC_RmP(chan,:) = [mean(global_CBC_corr_R{1,chan}(x4_{1,chan},1)) nanmean(global_CBC_corr_R{1,chan}(x5_{1,chan},1)) ...
        nanmean(global_CBC_corr_R{1,chan}(x6_{1,chan},1)) nanmean(global_CBC_corr_R{1,chan}(x7_{1,chan},1)) ...
        nanmean(global_CBC_corr_R{1,chan}(x8_{1,chan},1)) nanmean(global_CBC_corr_R{1,chan}(x10_{1,chan},1)) ...
        nanmean(global_CBC_corr_R{1,chan}(x11_{1,chan},1)) nanmean(global_CBC_corr_R{1,chan}(x12_{1,chan},1)) ...
        nanmean(global_CBC_corr_R{1,chan}(x13_{1,chan},1)) nanmean(global_CBC_corr_R{1,chan}(x14_{1,chan},1))];
    CBC_RsemP(chan,:) = [nanstd(global_CBC_corr_R{1,chan}(x4_{1,chan},1))./sqrt(length(x4{1,chan})) nanstd(global_CBC_corr_R{1,chan}(x5_{1,chan},1))./sqrt(length(x5{1,chan})) ...
        nanstd(global_CBC_corr_R{1,chan}(x6_{1,chan},1))./sqrt(length(x6{1,chan})) nanstd(global_CBC_corr_R{1,chan}(x7_{1,chan},1))./sqrt(length(x7{1,chan})) ...
        nanstd(global_CBC_corr_R{1,chan}(x8_{1,chan},1))./sqrt(length(x8{1,chan})) nanstd(global_CBC_corr_R{1,chan}(x10_{1,chan},1))./sqrt(length(x10{1,chan})) ...
        nanstd(global_CBC_corr_R{1,chan}(x11_{1,chan},1))./sqrt(length(x11{1,chan})) nanstd(global_CBC_corr_R{1,chan}(x12_{1,chan},1))./sqrt(length(x12{1,chan})) ...
        nanstd(global_CBC_corr_R{1,chan}(x13_{1,chan},1))./sqrt(length(x13{1,chan})) nanstd(global_CBC_corr_R{1,chan}(x14_{1,chan},1))./sqrt(length(x14{1,chan}))];
    bar(CBC_RmP(chan,:),'facecolor',[0.5 0.5 0.5]); hold on
    errorbar(1:10,CBC_RmP(chan,:),CBC_RsemP(chan,:),'linestyle','none','linewidth',3,'color','k')
    axis([0 11 -0.3 0.5]); ylabel('Corr�lation +- SEM : puissance vs Dur�e','fontsize',30)
    set(gca,'box','off','linewidth',3);
    set(gca,'Xtick',1:10,'Xticklabel',{'s04','s05','s06','s07','s08','s10','s11','s12','s13','s14'},'fontsize',30);
    
    print('-dpng',['C:\TEMPROD\DATA\NEW\FIG_THESIS\' ChanArray{chan} 'POW_DUR_CORR_alpha_selectedCBC.png'])
    
    fig1 = figure('position',[1 1 1000 1000]);
    set(fig1,'PaperPosition',[1 1 1000 1000])
    set(fig1,'PaperPositionmode','auto')
    % nanmean CBC corr frequency with dur
    CBC_RmF(chan,:) = [nanmean(global_CBC_corr_R{1,chan}(x4_{1,chan},2)) nanmean(global_CBC_corr_R{1,chan}(x5_{1,chan},2)) ...
        nanmean(global_CBC_corr_R{1,chan}(x6_{1,chan},2)) nanmean(global_CBC_corr_R{1,chan}(x7_{1,chan},2)) ...
        nanmean(global_CBC_corr_R{1,chan}(x8_{1,chan},2)) nanmean(global_CBC_corr_R{1,chan}(x10_{1,chan},2)) ...
        nanmean(global_CBC_corr_R{1,chan}(x11_{1,chan},2)) nanmean(global_CBC_corr_R{1,chan}(x12_{1,chan},2)) ...
        nanmean(global_CBC_corr_R{1,chan}(x13_{1,chan},2)) nanmean(global_CBC_corr_R{1,chan}(x14_{1,chan},2))];
    CBC_RsemF(chan,:) = [nanstd(global_CBC_corr_R{1,chan}(x4_{1,chan},2))./sqrt(length(x4{1,chan})) nanstd(global_CBC_corr_R{1,chan}(x5_{1,chan},2))./sqrt(length(x5{1,chan})) ...
        nanstd(global_CBC_corr_R{1,chan}(x6_{1,chan},2))./sqrt(length(x6{1,chan})) nanstd(global_CBC_corr_R{1,chan}(x7_{1,chan},2))./sqrt(length(x7{1,chan})) ...
        nanstd(global_CBC_corr_R{1,chan}(x8_{1,chan},2))./sqrt(length(x8{1,chan})) nanstd(global_CBC_corr_R{1,chan}(x10_{1,chan},2))./sqrt(length(x10{1,chan})) ...
        nanstd(global_CBC_corr_R{1,chan}(x11_{1,chan},2))./sqrt(length(x11{1,chan})) nanstd(global_CBC_corr_R{1,chan}(x12_{1,chan},2))./sqrt(length(x12{1,chan})) ...
        nanstd(global_CBC_corr_R{1,chan}(x13_{1,chan},2))./sqrt(length(x13{1,chan})) nanstd(global_CBC_corr_R{1,chan}(x14_{1,chan},2))./sqrt(length(x14{1,chan}))];
    bar(CBC_RmF(chan,:),'facecolor',[0.5 0.5 0.5]); hold on
    errorbar(1:10,CBC_RmF(chan,:),CBC_RsemF(chan,:),'linestyle','none','linewidth',3,'color','k')
    axis([0 11 -0.3 0.5]); ylabel('Corr�lation +- SEM : puissance vs Dur�e','fontsize',30)
    set(gca,'box','off','linewidth',3);
    set(gca,'Xtick',1:10,'Xticklabel',{'s04','s05','s06','s07','s08','s10','s11','s12','s13','s14'},'fontsize',30);
    
    print('-dpng',['C:\TEMPROD\DATA\NEW\FIG_THESIS\' ChanArray{chan} 'FREQ_DUR_CORR_alpha_selectedCBC.png'])
    
end

%%%%%%%%%%%%%%%% plot avg across subject %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 1000 1000]);
set(fig1,'PaperPosition',[1 1 1000 1000])
set(fig1,'PaperPositionmode','auto')

bar([mean(CBC_RmF,2) mean(CBC_RmP,2)]'); hold on;
errorbar([[0.8 1 1.2];[1.8 2 2.2]],[mean(CBC_RmF,2) mean(CBC_RmP,2)]',...
        [std(CBC_RmF'); std(CBC_RmP')]./sqrt(10),'color','k','linewidth',2,'linestyle','none'); hold on
legend('Mags','Grads1','Grads2','location','NorthWest');
ylabel('score de corr�lation moyen +- ES','fontsize',30);
set(gca,'box','off','xtick',1:2,'xticklabel',{'Dur vs freq';'Dur vs Pow'},'fontsize',30,'linewidth',2);
axis([0.5 2.5 -0.1 0.4])

print('-dpng','C:\TEMPROD\DATA\NEW\FIG_THESIS\ALLCORR_intersubAVG_selectedCBC_alpha.png')

[h,p] = ttest(CBC_RmF(1,:))
[h,p] = ttest(CBC_RmF(2,:))
[h,p] = ttest(CBC_RmF(3,:))

[H,P,CI,STATS] = ttest(CBC_RmP(1,:));
[h,p] = ttest(CBC_RmP(2,:))
[h,p] = ttest(CBC_RmP(3,:))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all

fig1 = figure('position',[1 1 1000 1000]);
set(fig1,'PaperPosition',[1 1 1000 1000])
set(fig1,'PaperPositionmode','auto')

SubjArray = {'s14','s13','s12','s11','s10','s08','s07','s06','s05','s04'};
FreqArray = {[6.5 10.5],[6.5 10.5],[7 11],[5.5 9.5],[8 12],[6 10],[10 14],[8.5 12.5],[8.5 12.5],[9 13]};
RunArray  = {[2 3 5 6],[2 3 5 6],[2 3 5 6],[2 3 5],[2 3 5 6],2:6,2:6,1:4,1:3,1:3};
ChanArray = {'Mags','Grads1','Grads2'};
for chan = 1:3
    for i = 1:length(SubjArray)
        for j = 1:length(RunArray{i})
            load(['C:\TEMPROD\DATA\NEW\processed_' SubjArray{i} '\FT_spectra\SUMMARY_corr_' ChanArray{chan} '_' SubjArray{i} ...
                '_run' num2str(RunArray{i}(j)) '_freq'  num2str(FreqArray{i}(1)) '-' num2str(FreqArray{i}(2)) '.mat'])
            
            mask{chan}{i,j} = (CBC_corr_p <= 0.01);
        end
    end
end

for chan = 1:3
    for i = 1:length(SubjArray)
        MASK{chan}{i} = zeros(102,11);
        for j = 1:length(RunArray{i})
            MASK{chan}{i} = MASK{chan}{i} + mask{chan}{i,j};
        end
    end
end
        
addpath('C:\RESONANCE_MEG\NEW_SCRIPTS')
addpath(genpath('C:\FIELDTRIP\fieldtrip-20120402'));
% topoplot
cfg                    = [];
cfg.maplimits          = log([1 20]);
cfg.maplimits          = [0 4];
cfg.style              = 'straight';
cfg.electrodes         = 'off';
cfg.layout             = ['C:\FIELDTRIP\fieldtrip-20120402\template\layout/NM306mag.lay'];

% plot probalility of correlation chan-by-chanv: power
for i = 1:10
    mysubplot(3,10,i); topoplot(cfg,MASK{1}{1,i}(:,1));
    mysubplot(3,10,i+10); topoplot(cfg,MASK{2}{1,i}(:,1));
    mysubplot(3,10,i+20); topoplot(cfg,MASK{3}{1,i}(:,1));
end

print('-dpng','C:\TEMPROD\DATA\NEW\FIG_THESIS\individual_probability_topo_power_vs_dur_alpha.png')

fig1 = figure('position',[1 1 1000 1000]);
set(fig1,'PaperPosition',[1 1 1000 1000])
set(fig1,'PaperPositionmode','auto')

for i = 1:10
    mysubplot(3,10,i); topoplot(cfg,MASK{1}{1,i}(:,2));
    mysubplot(3,10,i+10); topoplot(cfg,MASK{2}{1,i}(:,2));
    mysubplot(3,10,i+20); topoplot(cfg,MASK{3}{1,i}(:,2));
end

print('-dpng','C:\TEMPROD\DATA\NEW\FIG_THESIS\individual_probability_topo_frequency_vs_dur_alpha.png')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot and write a text file usable by R software
%% alpha band

clear all
close all

SubjArray = {'s14','s13','s12','s11','s10'};
FreqArray = {[6.5 10.5],[6.5 10.5],[7 11],[5.5 9.5],[8 12]};
RunArray  = {[4 7],[4 7],[4 7],[ 4 ],[4 7]};
ChanArray = {'Mags','Grads1','Grads2'};

for chan = 1:3
    tmp_CBC_corr_R = [];
    tmp_CBC_corr_p = [];
    tmp_AVG_corr_R = [];
    tmp_AVG_corr_p = [];
    for i = 1:length(SubjArray)
        for j = 1:length(RunArray{i})
            load(['C:\TEMPROD\DATA\NEW\processed_' SubjArray{i} '\FT_spectra\SUMMARY_corr_' ChanArray{chan} '_' SubjArray{i} ...
                '_run' num2str(RunArray{i}(j)) '_freq'  num2str(FreqArray{i}(1)) '-' num2str(FreqArray{i}(2)) '.mat'])
            
            tmp_CBC_corr_R = [tmp_CBC_corr_R ; CBC_corr_R];
            tmp_CBC_corr_p = [tmp_CBC_corr_p ; CBC_corr_p];
            tmp_AVG_corr_R = [tmp_AVG_corr_R ; AVG_corr_R];
            tmp_AVG_corr_p = [tmp_AVG_corr_p ; AVG_corr_p];
            
        end
    end
    global_CBC_corr_R{chan} = tmp_CBC_corr_R;
    global_CBC_corr_p{chan} = tmp_CBC_corr_p;
    global_AVG_corr_R{chan} = tmp_AVG_corr_R;
    global_AVG_corr_p{chan} = tmp_AVG_corr_p;
    
    [xtmp10{chan},y10] = find(global_AVG_corr_R{1,chan}(:,11) == 10); x10{chan} = xtmp10{chan};
    [xtmp11{chan},y11] = find(global_AVG_corr_R{1,chan}(:,11) == 11); x11{chan} = xtmp11{chan};
    [xtmp12{chan},y12] = find(global_AVG_corr_R{1,chan}(:,11) == 12); x12{chan} = xtmp12{chan};
    [xtmp13{chan},y13] = find(global_AVG_corr_R{1,chan}(:,11) == 13); x13{chan} = xtmp13{chan};
    [xtmp14{chan},y14] = find(global_AVG_corr_R{1,chan}(:,11) == 14); x14{chan} = xtmp14{chan};

    [xtmp10{chan},y10] = find(global_CBC_corr_R{1,chan}(:,11) == 10); x10_{chan} = xtmp10{chan};
    [xtmp11{chan},y11] = find(global_CBC_corr_R{1,chan}(:,11) == 11); x11_{chan} = xtmp11{chan};
    [xtmp12{chan},y12] = find(global_CBC_corr_R{1,chan}(:,11) == 12); x12_{chan} = xtmp12{chan};
    [xtmp13{chan},y13] = find(global_CBC_corr_R{1,chan}(:,11) == 13); x13_{chan} = xtmp13{chan};
    [xtmp14{chan},y14] = find(global_CBC_corr_R{1,chan}(:,11) == 14); x14_{chan} = xtmp14{chan}; 
    
    [xtmp_pcorr{chan},y4]   = find(global_CBC_corr_p{1,chan}(:,1) < 0.01); x_pcorr{chan} = xtmp_pcorr{chan};

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot correlation between AVG and behav

for chan = 1:3
    
    fig1 = figure('position',[1 1 1000 1000]);
    set(fig1,'PaperPosition',[1 1 1000 1000])
    set(fig1,'PaperPositionmode','auto')
    % mean AVG corr power with dur
    AVG_Rm_p(chan,:) = [mean(global_AVG_corr_R{1,chan}(x10{1,chan},1)) ...
        mean(global_AVG_corr_R{1,chan}(x11{1,chan},1)) mean(global_AVG_corr_R{1,chan}(x12{1,chan},1)) ...
        mean(global_AVG_corr_R{1,chan}(x13{1,chan},1)) mean(global_AVG_corr_R{1,chan}(x14{1,chan},1))];
    AVG_Rsem_p(chan,:) = [std(global_AVG_corr_R{1,chan}(x10{1,chan},1))./sqrt(length(x10{1,chan})) ...
        std(global_AVG_corr_R{1,chan}(x11{1,chan},1))./sqrt(length(x11{1,chan})) std(global_AVG_corr_R{1,chan}(x12{1,chan},1))./sqrt(length(x12{1,chan})) ...
        std(global_AVG_corr_R{1,chan}(x13{1,chan},1))./sqrt(length(x13{1,chan})) std(global_AVG_corr_R{1,chan}(x14{1,chan},1))./sqrt(length(x14{1,chan}))];
    bar(AVG_Rm_p(chan,:),'facecolor',[0.5 0.5 0.5]); hold on
    errorbar(1:5,AVG_Rm_p(chan,:),AVG_Rsem_p(chan,:),'linestyle','none','linewidth',3,'color','k')
    axis([0 6 -0.3 0.5]); ylabel('Corr�lation +- SEM : puissance vs Dur�e','fontsize',30)
    set(gca,'box','off','linewidth',3);
    set(gca,'Xtick',1:10,'Xticklabel',{'s10','s11','s12','s13','s14'},'fontsize',30);
    
    print('-dpng',['C:\TEMPROD\DATA\NEW\FIG_THESIS\' ChanArray{chan} 'POW_DUR_CORR_alpha_AVG_REPLAY.png'])
    
    fig1 = figure('position',[1 1 1000 1000]);
    set(fig1,'PaperPosition',[1 1 1000 1000])
    set(fig1,'PaperPositionmode','auto')
    % mean AVG corr frequency with dur
    AVG_Rm_f(chan,:) = [mean(global_AVG_corr_R{1,chan}(x10{1,chan},2)) ...
        mean(global_AVG_corr_R{1,chan}(x11{1,chan},2)) mean(global_AVG_corr_R{1,chan}(x12{1,chan},2)) ...
        mean(global_AVG_corr_R{1,chan}(x13{1,chan},2)) mean(global_AVG_corr_R{1,chan}(x14{1,chan},2))];
    AVG_Rsem_f(chan,:) = [std(global_AVG_corr_R{1,chan}(x10{1,chan},2))./sqrt(length(x10{1,chan})) ...
        std(global_AVG_corr_R{1,chan}(x11{1,chan},2))./sqrt(length(x11{1,chan})) std(global_AVG_corr_R{1,chan}(x12{1,chan},2))./sqrt(length(x12{1,chan})) ...
        std(global_AVG_corr_R{1,chan}(x13{1,chan},2))./sqrt(length(x13{1,chan})) std(global_AVG_corr_R{1,chan}(x14{1,chan},2))./sqrt(length(x14{1,chan}))];
    bar(AVG_Rm_f(chan,:),'facecolor',[0.5 0.5 0.5]); hold on
    errorbar(1:5,AVG_Rm_f(chan,:),AVG_Rsem_f(chan,:),'linestyle','none','linewidth',3,'color','k')
    axis([0 6 -0.3 0.5]); ylabel('Corr�lation +- SEM : puissance vs Dur�e','fontsize',30)
    set(gca,'box','off','linewidth',3);
    set(gca,'Xtick',1:10,'Xticklabel',{'s10','s11','s12','s13','s14'},'fontsize',30);
    
    print('-dpng',['C:\TEMPROD\DATA\NEW\FIG_THESIS\' ChanArray{chan} 'FREQ_DUR_CORR_alpha_AVG_REPLAY.png'])
    
end

%%%%%%%%%%%%%%%% plot avg across subject %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 1000 1000]);
set(fig1,'PaperPosition',[1 1 1000 1000])
set(fig1,'PaperPositionmode','auto')

bar([mean(AVG_Rm_f,2) mean(AVG_Rm_p,2)]'); hold on;
errorbar([[0.8 1 1.2];[1.8 2 2.2]],[mean(AVG_Rm_f,2) mean(AVG_Rm_p,2)]',...
        [std(AVG_Rm_f'); std(AVG_Rm_p')]./sqrt(10),'color','k','linewidth',2,'linestyle','none'); hold on
legend('Mags','Grads1','Grads2');
ylabel('score de corr�lation moyen +- ES','fontsize',30);
set(gca,'box','off','xtick',1:2,'xticklabel',{'Dur vs freq';'Dur vs Pow'},'fontsize',30,'linewidth',2);
axis([0.5 2.5 -0.1 0.4])

print('-dpng','C:\TEMPROD\DATA\NEW\FIG_THESIS\ALLCORR_intersubAVG_alpha_REPLAY.png')

[h,p] = ttest(AVG_Rm_f(1,:))
[h,p] = ttest(AVG_Rm_f(2,:))
[h,p] = ttest(AVG_Rm_f(3,:))

[h,p] = ttest(AVG_Rm_p(1,:))
[h,p] = ttest(AVG_Rm_p(2,:))
[h,p] = ttest(AVG_Rm_p(3,:))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot correlation between CBC and behav
for chan = 1:3
    
    fig1 = figure('position',[1 1 1000 1000]);
    set(fig1,'PaperPosition',[1 1 1000 1000])
    set(fig1,'PaperPositionmode','auto')
    % mean AVG corr power with dur
    CBC_RmP(chan,:) = [nanmean(global_CBC_corr_R{1,chan}(x10_{1,chan},1)) ...
        nanmean(global_CBC_corr_R{1,chan}(x11_{1,chan},1)) nanmean(global_CBC_corr_R{1,chan}(x12_{1,chan},1)) ...
        nanmean(global_CBC_corr_R{1,chan}(x13_{1,chan},1)) nanmean(global_CBC_corr_R{1,chan}(x14_{1,chan},1))];
    CBC_RsemP(chan,:) = [nanstd(global_CBC_corr_R{1,chan}(x10_{1,chan},1))./sqrt(length(x10{1,chan})) ...
        nanstd(global_CBC_corr_R{1,chan}(x11_{1,chan},1))./sqrt(length(x11{1,chan})) nanstd(global_CBC_corr_R{1,chan}(x12_{1,chan},1))./sqrt(length(x12{1,chan})) ...
        nanstd(global_CBC_corr_R{1,chan}(x13_{1,chan},1))./sqrt(length(x13{1,chan})) nanstd(global_CBC_corr_R{1,chan}(x14_{1,chan},1))./sqrt(length(x14{1,chan}))];
    bar(CBC_RmP(chan,:),'facecolor',[0.5 0.5 0.5]); hold on
    errorbar(1:5,CBC_RmP(chan,:),CBC_RsemP(chan,:),'linestyle','none','linewidth',3,'color','k')
    axis([0 5 -0.3 0.5]); ylabel('Corr�lation +- SEM : puissance vs Dur�e','fontsize',30)
    set(gca,'box','off','linewidth',3);
    set(gca,'Xtick',1:10,'Xticklabel',{'s10','s11','s12','s13','s14'},'fontsize',30);
    
    print('-dpng',['C:\TEMPROD\DATA\NEW\FIG_THESIS\' ChanArray{chan} 'POW_DUR_CORR_alpha_CBC_REPLAY.png'])
    
    fig1 = figure('position',[1 1 1000 1000]);
    set(fig1,'PaperPosition',[1 1 1000 1000])
    set(fig1,'PaperPositionmode','auto')
    % nanmean CBC corr frequency with dur
    CBC_RmF(chan,:) = [nanmean(global_CBC_corr_R{1,chan}(x10_{1,chan},2)) ...
        nanmean(global_CBC_corr_R{1,chan}(x11_{1,chan},2)) nanmean(global_CBC_corr_R{1,chan}(x12_{1,chan},2)) ...
        nanmean(global_CBC_corr_R{1,chan}(x13_{1,chan},2)) nanmean(global_CBC_corr_R{1,chan}(x14_{1,chan},2))];
    CBC_RsemF(chan,:) = [nanstd(global_CBC_corr_R{1,chan}(x10_{1,chan},2))./sqrt(length(x10{1,chan})) ...
        nanstd(global_CBC_corr_R{1,chan}(x11_{1,chan},2))./sqrt(length(x11{1,chan})) nanstd(global_CBC_corr_R{1,chan}(x12_{1,chan},2))./sqrt(length(x12{1,chan})) ...
        nanstd(global_CBC_corr_R{1,chan}(x13_{1,chan},2))./sqrt(length(x13{1,chan})) nanstd(global_CBC_corr_R{1,chan}(x14_{1,chan},2))./sqrt(length(x14{1,chan}))];
    bar(CBC_RmF(chan,:),'facecolor',[0.5 0.5 0.5]); hold on
    errorbar(1:5,CBC_RmF(chan,:),CBC_RsemF(chan,:),'linestyle','none','linewidth',3,'color','k')
    axis([0 6 -0.3 0.5]); ylabel('Corr�lation +- SEM : puissance vs Dur�e','fontsize',30)
    set(gca,'box','off','linewidth',3);
    set(gca,'Xtick',1:10,'Xticklabel',{'s10','s11','s12','s13','s14'},'fontsize',30);
    
    print('-dpng',['C:\TEMPROD\DATA\NEW\FIG_THESIS\' ChanArray{chan} 'FREQ_DUR_CORR_alpha_CBC_REPLAY.png'])
    
end

%%%%%%%%%%%%%%%% plot avg across subject %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 1000 1000]);
set(fig1,'PaperPosition',[1 1 1000 1000])
set(fig1,'PaperPositionmode','auto')

bar([mean(CBC_RmF,2) mean(CBC_RmP,2)]'); hold on;
errorbar([[0.8 1 1.2];[1.8 2 2.2]],[mean(CBC_RmF,2) mean(CBC_RmP,2)]',...
        [std(CBC_RmF'); std(CBC_RmP')]./sqrt(10),'color','k','linewidth',2,'linestyle','none'); hold on
legend('Mags','Grads1','Grads2','location','NorthWest');
ylabel('score de corr�lation moyen +- ES','fontsize',30);
set(gca,'box','off','xtick',1:2,'xticklabel',{'Dur vs freq';'Dur vs Pow'},'fontsize',30,'linewidth',2);
axis([0.5 2.5 -0.1 0.4])

print('-dpng','C:\TEMPROD\DATA\NEW\FIG_THESIS\ALLCORR_intersubAVGCBC_alpha_REPLAY.png')

[h,p] = ttest(CBC_RmF(1,:))
[h,p] = ttest(CBC_RmF(2,:))
[h,p] = ttest(CBC_RmF(3,:))

[h,p] = ttest(CBC_RmP(1,:))
[h,p] = ttest(CBC_RmP(2,:))
[h,p] = ttest(CBC_RmP(3,:))

%%%%%%%%%%%%%%% plot AVG corr of significantly correlated channels %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot correlation between CBC and behav
for chan = 1:3
    
    x10_{chan} = intersect(x10_{chan},x_pcorr{chan});
    x11_{chan} = intersect(x11_{chan},x_pcorr{chan});
    x12_{chan} = intersect(x12_{chan},x_pcorr{chan});
    x13_{chan} = intersect(x13_{chan},x_pcorr{chan});
    x14_{chan} = intersect(x14_{chan},x_pcorr{chan});
    
    fig1 = figure('position',[1 1 1000 1000]);
    set(fig1,'PaperPosition',[1 1 1000 1000])
    set(fig1,'PaperPositionmode','auto')
    % mean AVG corr power with dur
    CBC_RmP(chan,:) = [nanmean(global_CBC_corr_R{1,chan}(x10_{1,chan},1)) ...
        nanmean(global_CBC_corr_R{1,chan}(x11_{1,chan},1)) nanmean(global_CBC_corr_R{1,chan}(x12_{1,chan},1)) ...
        nanmean(global_CBC_corr_R{1,chan}(x13_{1,chan},1)) nanmean(global_CBC_corr_R{1,chan}(x14_{1,chan},1))];
    CBC_RsemP(chan,:) = [nanstd(global_CBC_corr_R{1,chan}(x10_{1,chan},1))./sqrt(length(x10{1,chan})) ...
        nanstd(global_CBC_corr_R{1,chan}(x11_{1,chan},1))./sqrt(length(x11{1,chan})) nanstd(global_CBC_corr_R{1,chan}(x12_{1,chan},1))./sqrt(length(x12{1,chan})) ...
        nanstd(global_CBC_corr_R{1,chan}(x13_{1,chan},1))./sqrt(length(x13{1,chan})) nanstd(global_CBC_corr_R{1,chan}(x14_{1,chan},1))./sqrt(length(x14{1,chan}))];
    bar(CBC_RmP(chan,:),'facecolor',[0.5 0.5 0.5]); hold on
    errorbar(1:5,CBC_RmP(chan,:),CBC_RsemP(chan,:),'linestyle','none','linewidth',3,'color','k')
    axis([0 6 -0.3 0.5]); ylabel('Corr�lation +- SEM : puissance vs Dur�e','fontsize',30)
    set(gca,'box','off','linewidth',3);
    set(gca,'Xtick',1:10,'Xticklabel',{'s10','s11','s12','s13','s14'},'fontsize',30);
    
    print('-dpng',['C:\TEMPROD\DATA\NEW\FIG_THESIS\' ChanArray{chan} 'POW_DUR_CORR_alpha_selectedCBC_REPLAY.png'])
    
    fig1 = figure('position',[1 1 1000 1000]);
    set(fig1,'PaperPosition',[1 1 1000 1000])
    set(fig1,'PaperPositionmode','auto')
    % nanmean CBC corr frequency with dur
    CBC_RmF(chan,:) = [nanmean(global_CBC_corr_R{1,chan}(x10_{1,chan},2)) ...
        nanmean(global_CBC_corr_R{1,chan}(x11_{1,chan},2)) nanmean(global_CBC_corr_R{1,chan}(x12_{1,chan},2)) ...
        nanmean(global_CBC_corr_R{1,chan}(x13_{1,chan},2)) nanmean(global_CBC_corr_R{1,chan}(x14_{1,chan},2))];
    CBC_RsemF(chan,:) = [nanstd(global_CBC_corr_R{1,chan}(x10_{1,chan},2))./sqrt(length(x10{1,chan})) ...
        nanstd(global_CBC_corr_R{1,chan}(x11_{1,chan},2))./sqrt(length(x11{1,chan})) nanstd(global_CBC_corr_R{1,chan}(x12_{1,chan},2))./sqrt(length(x12{1,chan})) ...
        nanstd(global_CBC_corr_R{1,chan}(x13_{1,chan},2))./sqrt(length(x13{1,chan})) nanstd(global_CBC_corr_R{1,chan}(x14_{1,chan},2))./sqrt(length(x14{1,chan}))];
    bar(CBC_RmF(chan,:),'facecolor',[0.5 0.5 0.5]); hold on
    errorbar(1:5,CBC_RmF(chan,:),CBC_RsemF(chan,:),'linestyle','none','linewidth',3,'color','k')
    axis([0 6 -0.3 0.5]); ylabel('Corr�lation +- SEM : puissance vs Dur�e','fontsize',30)
    set(gca,'box','off','linewidth',3);
    set(gca,'Xtick',1:10,'Xticklabel',{'s10','s11','s12','s13','s14'},'fontsize',30);
    
    print('-dpng',['C:\TEMPROD\DATA\NEW\FIG_THESIS\' ChanArray{chan} 'FREQ_DUR_CORR_alpha_selectedCBC_REPLAY.png'])
    
end

%%%%%%%%%%%%%%%% plot avg across subject %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 1000 1000]);
set(fig1,'PaperPosition',[1 1 1000 1000])
set(fig1,'PaperPositionmode','auto')

bar([mean(CBC_RmF,2) mean(CBC_RmP,2)]'); hold on;
errorbar([[0.8 1 1.2];[1.8 2 2.2]],[mean(CBC_RmF,2) mean(CBC_RmP,2)]',...
        [std(CBC_RmF'); std(CBC_RmP')]./sqrt(10),'color','k','linewidth',2,'linestyle','none'); hold on
legend('Mags','Grads1','Grads2','location','NorthWest');
ylabel('score de corr�lation moyen +- ES','fontsize',30);
set(gca,'box','off','xtick',1:2,'xticklabel',{'Dur vs freq';'Dur vs Pow'},'fontsize',30,'linewidth',2);
axis([0.5 2.5 -0.1 0.4])

print('-dpng','C:\TEMPROD\DATA\NEW\FIG_THESIS\ALLCORR_intersubAVG_selectedCBC_alpha_REPLAY.png')

[h,p] = ttest(CBC_RmF(1,:))
[h,p] = ttest(CBC_RmF(2,:))
[h,p] = ttest(CBC_RmF(3,:))

[H,P,CI,STATS] = ttest(CBC_RmP(1,:));
[h,p] = ttest(CBC_RmP(2,:))
[h,p] = ttest(CBC_RmP(3,:))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all

fig1 = figure('position',[1 1 1000 1000]);
set(fig1,'PaperPosition',[1 1 1000 1000])
set(fig1,'PaperPositionmode','auto')

SubjArray = {'s14','s13','s12','s11','s10'};
FreqArray = {[6.5 10.5],[6.5 10.5],[7 11],[5.5 9.5],[8 12]};
RunArray  = {[4 7],[4 7],[4 7],[4 ],[4 7]};
ChanArray = {'Mags','Grads1','Grads2'};
for chan = 1:3
    for i = 1:length(SubjArray)
        for j = 1:length(RunArray{i})
            load(['C:\TEMPROD\DATA\NEW\processed_' SubjArray{i} '\FT_spectra\SUMMARY_corr_' ChanArray{chan} '_' SubjArray{i} ...
                '_run' num2str(RunArray{i}(j)) '_freq'  num2str(FreqArray{i}(1)) '-' num2str(FreqArray{i}(2)) '.mat'])
            
            mask{chan}{i,j} = (CBC_corr_p <= 0.01);
        end
    end
end

for chan = 1:3
    for i = 1:length(SubjArray)
        MASK{chan}{i} = zeros(102,11);
        for j = 1:length(RunArray{i})
            MASK{chan}{i} = MASK{chan}{i} + mask{chan}{i,j};
        end
    end
end
        
addpath('C:\RESONANCE_MEG\NEW_SCRIPTS')
addpath(genpath('C:\FIELDTRIP\fieldtrip-20120402'));
% topoplot
cfg                    = [];
cfg.maplimits          = log([1 20]);
cfg.maplimits          = [0 4];
cfg.style              = 'straight';
cfg.electrodes         = 'off';
cfg.layout             = ['C:\FIELDTRIP\fieldtrip-20120402\template\layout/NM306mag.lay'];

% plot probalility of correlation chan-by-chanv: power
for i = 1:5
    mysubplot(3,10,i); topoplot(cfg,MASK{1}{1,i}(:,1));
    mysubplot(3,10,i+10); topoplot(cfg,MASK{2}{1,i}(:,1));
    mysubplot(3,10,i+20); topoplot(cfg,MASK{3}{1,i}(:,1));
end

print('-dpng','C:\TEMPROD\DATA\NEW\FIG_THESIS\individual_probability_topo_power_vs_dur_alpha_REPLAY.png')

fig1 = figure('position',[1 1 1000 1000]);
set(fig1,'PaperPosition',[1 1 1000 1000])
set(fig1,'PaperPositionmode','auto')

for i = 1:5
    mysubplot(3,10,i); topoplot(cfg,MASK{1}{1,i}(:,2));
    mysubplot(3,10,i+10); topoplot(cfg,MASK{2}{1,i}(:,2));
    mysubplot(3,10,i+20); topoplot(cfg,MASK{3}{1,i}(:,2));
end

print('-dpng','C:\TEMPROD\DATA\NEW\FIG_THESIS\individual_probability_topo_frequency_vs_dur_alpha_REPLAY.png')















