function temprod_dataviewer_var_V2(indexes,subject,freqband,debiasing,datatoplot,mode)

DIR = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];
chantypefull            = {'Mags';'Gradslong';'Gradslat'};

fig                 = figure('position',[1 1 1280 1024]);

colors = {'-k';'-b';'-r';'-g';'-y'};
colors_bis = {'k';'b';'r';'g';'y'};

for j = 1:3
    for x = 1:length(indexes)
        Fullspctrm          = [];
        Fullfreq            = [];
        chantype            = chantypefull{j};
        Fullspctrm_path     = [DIR 'FT_spectra/FullspctrmV2_' chantype num2str(indexes(x)) '.mat'];
        load(Fullspctrm_path);
        tmp = unique(Fullfreq); clear Fullfreq;
        Fullfreq            = tmp;
        
        %% estimate alpha for power law bias 1/f^alpha, by Maximum likelyhood estimation
        if debiasing == 1
            n                   = length(unique(Fullfreq));
            tmp                 = find(Fullfreq <= 50);
            for x = 1:size(Fullspctrm,1)
                for y = 1:size(Fullspctrm,2)
                    cutoff                = Fullspctrm(x,y,tmp(1)); % i.e cutoff value chosed at 50hz
                    AlphaEst(x,y)         = 1 + n*(sum(log(squeeze(Fullspctrm(x,y,:))/cutoff))).^(-1);
                    Fullspctrm_debiased(x,y,:)   = squeeze(Fullspctrm(x,y,:))'./(unique(Fullfreq)).^(-AlphaEst(x,y));
                end
            end
            Fullspctrm = Fullspctrm_debiased; clear Fullspctrm_debiased
        end
        
        % select frequency band
        fbegin              = find(Fullfreq >= freqband(1));
        fend                = find(Fullfreq <= freqband(2));
        fband               = fbegin(1):fend(end);
        bandFullspctrm      = Fullspctrm(:,:,fband);
        bandFullfreq        = Fullfreq(fband);
        clear Fullspctrm Fullfreq
        Fullspctrm          = bandFullspctrm;
        Fullfreq            = bandFullfreq;
        
        subplot(2,2,j)
        % plot spctral variance
        MEANspctrm = mean(squeeze(mean(Fullspctrm,2)));
        STD = std(squeeze(mean(Fullspctrm,2)));
        if strcmp(datatoplot ,'both')
            if strcmp(mode,'new')
                shadedErrorBar_seb(Fullfreq,MEANspctrm,STD,colors{x})
            elseif strcmp(mode,'old')
                errorbar(Fullfreq,MEANspctrm,STD)
            end
        end
        
        if strcmp(datatoplot,'mean')
            loglog(Fullfreq,MEANspctrm,colors_bis{x});
        end
        
        if strcmp(datatoplot,'std')
            loglog(Fullfreq,STD,colors_bis{x});
        end
        
        title(['intertrial power ' datatoplot ' : ' chantypefull{j}])
        xlabel('frequency')
        ylabel('power')
        
        hold on
    end
end

