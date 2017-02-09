function temprod_dataviewer_TF(index,subject,freqband,scaling)

DIR = ['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];
chantypefull            = {'Mags';'Gradslong';'Gradslat'};


% clims = {[5e-26 5e-25];[5e-23 5e-22];[5e-23 5e-22]};


for j = 1:3
    chantype            = chantypefull{j};
    Fullspctrm_path     = [DIR '/FT_TFwavelet/' chantype 'freq_allrun' num2str(index) '.mat'];
    load(Fullspctrm_path);
    
    for Ns = 1:size(FullFTspctrm,2)   
        dur_as_samples(Ns) = size(FullFTspctrm{1,Ns}.time,2);
        % select frequency band
        fbegin              = find(FullFTspctrm{1,Ns}.freq >= freqband(1));
        fend                = find(FullFTspctrm{1,Ns}.freq <= freqband(2));
        fband               = fbegin(1):fend(end);
        FullFTspctrm{1,Ns}.powspctrm   = FullFTspctrm{1,Ns}.powspctrm(:,:,fband,:);
        FullFTspctrm{1,Ns}.freq        = FullFTspctrm{1,Ns}.freq(fband);
        Maxpow(Ns) = max(max(max(mean(squeeze(FullFTspctrm{1,Ns}.powspctrm)))));
        Minpow(Ns) = min(min(min(mean(squeeze(FullFTspctrm{1,Ns}.powspctrm)))));
    end
    
    clims{j} = [mean(Minpow)*scaling(1) max(Maxpow)*scaling(2)];
    
    if (Ns >40) && (Ns <79)
        indexes_fig1 = repmat([1:5:40 2:5:40 3:5:40 4:5:40 5:5:40],1,2) ;
        
        fig2                 = figure('position',[1281 1 1280 1024]);
        set(fig2,'PaperPosition',[1281 1 1280 1024])
        set(fig2,'PaperPositionMode','auto')
        for N = 41:size(FullFTspctrm,2)
            
            mysubplot(8,5,indexes_fig1(N))
            imagesc([squeeze(mean(squeeze(FullFTspctrm{1,N}.powspctrm)))  ...
                ones(size(FullFTspctrm{1,N}.powspctrm,3),(max(dur_as_samples) - dur_as_samples(N)))...
                *mean(clims{j})],clims{j});
            set(gca,'YDir','normal');
            set(gca,'Xtick',0:100:(length(FullFTspctrm{1,N}.time)),...
                'Xticklabel',-2:2:FullFTspctrm{1,N}.time(end));
            set(gca,'Ytick',40:50:(length(FullFTspctrm{1,N}.freq)),...
                'Yticklabel',10:10:FullFTspctrm{1,N}.freq(end));
        end
        
%         subplot(8,5,40)
%         imagesc(ones(size(bandFullspctrm,3)),(max(dur_as_samples))*mean(clims{j}),clims{j});
%         ylabel('frequency (hz)');
%         xlabel('time from push onset')
        
        print('-dpng',['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
            '/TFpart2_' num2str(freqband(1)) '-' num2str(freqband(2)) '_' num2str(index) '.png']);
        
        fig1                 = figure('position',[1 1 1280 1024]);
        set(fig1,'PaperPosition',[1 1 1280 1024])
        set(fig1,'PaperPositionMode','auto')
        for N = 1:40
            
            mysubplot(8,5,indexes_fig1(N))
            imagesc([squeeze(mean(squeeze(FullFTspctrm{1,N}.powspctrm)))  ...
                ones(size(FullFTspctrm{1,N}.powspctrm,3),(max(dur_as_samples) - dur_as_samples(N)))...
                *mean(clims{j})],clims{j});
            set(gca,'YDir','normal');
            set(gca,'Xtick',0:100:(length(FullFTspctrm{1,N}.time)),...
                'Xticklabel',-2:2:FullFTspctrm{1,N}.time(end));
            set(gca,'Ytick',40:50:(length(FullFTspctrm{1,N}.freq)),...
                'Yticklabel',10:10:FullFTspctrm{1,N}.freq(end));

        end
        
         print('-dpng',['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
        '/TFpart1_' num2str(freqband(1)) '-' num2str(freqband(2)) '_' num2str(index) '.png']);
        
    else

    end
end
