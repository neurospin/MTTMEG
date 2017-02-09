function temprod_corr_slope_EEG(arraysubject,arrayindex,freqband)

figure('position',[1281 1 1280 1024]);
chantypefull = {'EEG'};
a = 1;
for i = 1:length(arraysubject)
    tmp  = [];
    tmp2 = [];
    for j = arrayindex{a}
        DIR = ['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' arraysubject{i} '/FT_spectra/'];
        load([DIR 'EEGcorrslope' num2str(freqband(1)) '-' num2str(freqband(2))  '_' num2str(j) '.mat']);
        tmp = [tmp rho1];
        tmp2 = [tmp2 pval1];
    end
    subplot(3,4,a)
    bar(tmp)
    for j = 1:length(arrayindex{a})
        if (tmp2(j) <= 0.05) && (tmp(j) >= 0)
            text(j,0.8,'*','FontSize',15,'color','r')
        elseif (tmp2(j) <= 0.05) && (tmp(j) <= 0)
            text(j,-0.8,'*','FontSize',15,'color','r')
        end
    end
    a = a +1;
    axis([0 length(arrayindex{a-1})+1 -1 1])
    title(arraysubject{a-1})
    xlabel('runs')
    ylabel('slope vs duration corr coef')
end


    