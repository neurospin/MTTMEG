function temprod_powercorr(index,subject,freqband,fsample,savetag)

DIR = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];
chantypefull            = {'Mags';'Gradslong';'Gradslat'};

fig                     = figure;
set(fig,'PaperPositionMode','auto')

for j = 1:3
    clear RHO PVAL model POW DUR
    Fullspctrm          = [];
    Fullfreq            = [];
    chantype            = chantypefull{j};
    Fullspctrm_path     = [DIR 'FT_spectra/FullspctrmV2_' chantype num2str(index) '.mat'];
    load(Fullspctrm_path);
    tmp = unique(Fullfreq); clear Fullfreq;
    Fullfreq            = tmp;
         
    % select frequency band
    fbegin              = find(Fullfreq >= freqband(1));
    fend                = find(Fullfreq <= freqband(2));
    fband               = fbegin(1):fend(end);
    bandFullspctrm      = Fullspctrm(:,:,fband);
    bandFullfreq        = Fullfreq(fband);
    clear Fullspctrm Fullfreq
    Fullspctrm          = bandFullspctrm;
    Fullfreq            = bandFullfreq;
    
    POW                 = mean(squeeze(mean(Fullspctrm,2)),2);
    DUR                 = asc_ord(:,1)/(fsample);
    [RHO, PVAL]         = corr([POW DUR]);
    
    P = polyfit(DUR, POW, 1);
    model(j,:) = P(1)*DUR' + P(2)*(ones(1,length(DUR)));
    
    subplot(2,2,j)
    plot(DUR, POW,'linestyle','non','marker','o')
    hold on
    plot(DUR, model(j,:));
    
    title(['Pearson corrcoef : ' num2str(RHO(2,1)) ', pval : ' num2str(PVAL(2,1))]);
    xlabel('Durations');
    ylabel(['mean ' num2str(freqband(1)) '-' num2str(freqband(2)) 'Hz Power']);
end
 
if savetag == 1
    print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
        '/PowCorr_' num2str(freqband(1)) '-' num2str(freqband(2)) '_' num2str(index) '.png']);
end