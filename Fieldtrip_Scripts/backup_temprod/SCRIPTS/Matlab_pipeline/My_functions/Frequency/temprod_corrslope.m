function temprod_corrslope(arraysubject,arrayindex,freqband)

figure
chantypefull = {'Mags';'Gradslong';'Gradslat'};
a = 1;
for i = 1:length(arraysubject)
    tmp  = []; 
    tmp2 = [];
    for j = arrayindex{a}
        DIR = ['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' arraysubject{i} '/FT_spectra/'];
        load([DIR 'corrslope' num2str(freqband(1)) '-' num2str(freqband(2))  '_' num2str(j) '.mat']);
        tmp  = [tmp rho1];
        tmp2 = [tmp2 pval2];
    end
    subplot(3,4,a)
    bar(tmp)
    for j = arrayindex{a}
    end
    a = a +1; 

    indexes = [];
    indexes = 1:length(arrayindex{a-1});
    for j = indexes
        if (tmp2(j) <= 0.05) && (tmp(j) >= 0)
            text(j,0.5,'*','FontSize',15,'color','r')
        elseif (tmp2(j) <= 0.01) && (tmp(j) >= 0)
            text(j,0.5,'**','FontSize',15,'color','r')
        elseif (tmp2(j) <= 0.05) && (tmp(j) <= 0)
            text(j,0.5,'*','FontSize',15,'color','r')
        elseif (tmp2(j) <= 0.01) && (tmp(j) <= 0)
            text(j,0.5,'**','FontSize',15,'color','r')
        end
    end
    
    axis([0 (length(arrayindex{a-1})+1) -0.5 0.5])
end    
    