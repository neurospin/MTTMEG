function temprod_corrslope_V2(arraysubject,freqband,tag)

% set root
root = SetPath(tag); 

scrsz = get(0,'ScreenSize');
fig = figure('position',scrsz);
set(fig,'PaperPosition',scrsz)
set(fig,'PaperPositionMode','auto')
for i = 1:length(arraysubject)
    
    DIR = [root '/DATA/NEW/processed_' arraysubject{i} '/FT_spectra/'];
    load([DIR 'corrslope_V2' num2str(freqband(1)) '-' num2str(freqband(2))  '.mat']);
    
    if size(p1,1) == 4
        % estimation runs
        tmp  = [];
        tmp2 = [];
        for k = 1:2
            tmp  = [tmp ; [rho{k,1,1} rho{k,1,2} rho{k,1,3}]];
            tmp2 = [tmp2 ; [pval{k,1,1} pval{k,1,2} pval{k,1,3}]];
        end
        % first replay run
        tmp  = [tmp  ; [rho{k,2,1}  rho{k,2,2}  rho{k,2,3}]];
        tmp2 = [tmp2 ; [pval{k,2,1} pval{k,2,2} pval{k,2,3}]];
        % estimation runs
        for k = 3:4
            tmp  = [tmp  ; [rho{k,1,1}  rho{k,1,2}  rho{k,1,3}]];
            tmp2 = [tmp2 ; [pval{k,1,1} pval{k,1,2} pval{k,1,3}]];
        end
        % first replay run
        tmp  = [tmp  ; [rho{k,2,1}  rho{k,2,2}  rho{k,2,3}]];
        tmp2 = [tmp2 ; [pval{k,2,1} pval{k,2,2} pval{k,2,3}]];
        
        subplot(2,4,i)
        bar(tmp)
        set(gca,'xtick',1:6,'xticklabel',{'est1';'est2';'rep1';'est3';'est4';'rep2'})
        legend('mags','grads1','grads2','Location','SouthEast')
        ylabel('correlation slope vs duration')
        title([arraysubject{i} ' at frequency : ' num2str(freqband(1)) '-' num2str(freqband(2)) ' Hz'])
        axis([0.5 6.5 -0.5 0.5])
        
        hold on
        % lines
        line([2.5 2.5],[-0.5 +0.5],'linewidth',2,'linestyle','--','color','r');hold on
        line([3.5 3.5],[-0.5 +0.5],'linewidth',2,'linestyle','--','color','r');hold on
        
        line([5.5 5.5],[-0.5 +0.5],'linewidth',2,'linestyle','--','color','r');hold on
        line([6.5 6.5],[-0.5 +0.5],'linewidth',2,'linestyle','--','color','r');hold on
        
        
    elseif size(p1,1) == 2
        % estimation runs
        tmp  = [];
        tmp2 = [];
        for k = 1:2
            tmp  = [tmp  ; [rho{k,1,1}  rho{k,1,2}  rho{k,1,3}]];
            tmp2 = [tmp2 ; [pval{k,1,1} pval{k,1,2} pval{k,1,3}]];
        end
        % first replay run
        tmp  = [tmp  ; [rho{k,2,1}  rho{k,2,2}  rho{k,2,3}]];
        tmp2 = [tmp2 ; [pval{k,2,1} pval{k,2,2} pval{k,2,3}]];
        
        subplot(2,4,i)
        bar(tmp)
        
        set(gca,'xtick',1:3,'xticklabel',{'est1';'est2';'rep1'})
        legend('mags','grads1','grads2','Location','SouthEast')
        ylabel('correlation slope vs duration')
        title([arraysubject{i} ' at frequency : ' num2str(freqband(1)) '-' num2str(freqband(2)) ' Hz'])
        axis([0.5 3.5 -0.5 0.5])
        
        hold on
        % lines
        line([2.5 2.5],[-0.5 +0.5],'linewidth',2,'linestyle','--','color','r');hold on
        line([3.5 3.5],[-0.5 +0.5],'linewidth',2,'linestyle','--','color','r');hold on
    end
    
    for a = 1:size(tmp2,1)
        for b = 1:3
            if (tmp2(a,b) <= 0.05) && (b == 1)
                text(a-0.3,0.4,'*','color','r','linewidth',5)
            elseif (tmp2(a,b) <= 0.05) && (b == 2)
                text(a,0.4,'*','color','r','linewidth',5)
            elseif (tmp2(a,b) <= 0.05) && (b == 3)
                text(a+0.3,0.4,'*','color','r','linewidth',5)
            end
        end
    end
end

print('-dpng',[root '/DATA/NEW/across_subjects_plots/corrslope_allsub_'...
    num2str(freqband(1)) '-' num2str(freqband(2)) '.png']);

