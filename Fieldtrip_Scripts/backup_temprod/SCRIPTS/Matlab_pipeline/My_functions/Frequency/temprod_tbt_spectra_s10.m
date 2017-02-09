function temprod_tbt_spectra_s10(index,subject,freqband,savetag)

DIR = ['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];
chantypefull            = {'Mags';'Gradslong';'Gradslat'};

for j = 1:3
    figure('position',[1281 1 1280 1024]);
    b = colormap('jet');
    d = colormap('gray');
    e = colormap('copper');
    c = [b ; d ; e];
    
    Fullspctrm          = [];
    Fullfreq            = [];
    chantype            = chantypefull{j};
    Fullspctrm_path     = [DIR 'FT_spectra/FullspctrmS10_' chantype num2str(index) '.mat'];
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

    FullfreqSave        = Fullfreq;
    FullspctrmSave      = Fullspctrm; 
    
    for i = 1:size(Fullspctrm)
        meanspctrm(:,i)          =  squeeze(mean(Fullspctrm(i,:,:)));
        loglog(unique(Fullfreq),meanspctrm(:,i),'color',c(i,:),'linewidth',2)
        axis([freqband(1) freqband(2) min(min(meanspctrm)) max(max(meanspctrm))])
        grid('on')
        hold on
    end
    
    title([subject ' run' num2str(index) ' ' chantype ' trial-by-trial mean spectrum'])
    xlabel('frequency (Hz)')
    ylabel('Power (Ft)')
    
end

if savetag == 1
    print('-dpng',['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
        '/Fullspctrms10_tbt_' num2str(freqband(1)) '-' num2str(freqband(2)) '_' num2str(index) '.png']);
end

