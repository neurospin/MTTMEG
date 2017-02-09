function [PKSbis,LOCbis] = temprod_dataviewer_var(indexes,subject,freqband,debiasing,loglogdetrend,datatoplot,mode,savetag)

DIR = ['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];
chantypefull            = {'Mags';'Gradslong';'Gradslat'};

fig                 = figure('position',[1 1 1280/1.2 1024/3.5]);
set(fig,'PaperPosition',[1 1 1280 1024])
set(fig,'PaperPositionMode','auto')

% set(0,'DefaultFigureRenderer','opengl')

c = colormap('jet');
C = c(1:10:end,:);  


colors = {'-k';'-b';'-r';'-g';'-y'};
colors_bis = {C(1,:);C(2,:);C(3,:);C(4,:);C(5,:);C(6,:);C(7,:)};

for j = 1:3
    clear DataToRemove
    for k = 1:length(indexes)
        Fullspctrm          = [];
        Fullfreq            = [];
        chantype            = chantypefull{j};
        Fullspctrm_path     = [DIR 'FT_spectra/FullspctrmV2_' chantype num2str(indexes(k)) '.mat'];
        load(Fullspctrm_path);
        
        tmp = unique(Fullfreq); clear Fullfreq;
        Fullfreq            = tmp;
        
        % noise removal and channel-by-channel linear interpolation replacemement
        LNfbegin                = find(Fullfreq >= 47);
        LNfend                  = find(Fullfreq <= 53);
        LNfband                 = LNfbegin(1):LNfend(end);
        for i = 1:size(Fullspctrm,1)
            for x = 1:size(Fullspctrm,2)
                L = linspace(Fullspctrm(i,x,LNfbegin(1)),... % beginning of the range
                    Fullspctrm(i,x,LNfend(end)),... % end of the range
                    LNfend(end) - LNfbegin(1) + 1); % number of frequency bins to replace
                Fullspctrm(i,x,LNfband) = L;
            end
        end
        
        % select frequency band
        fbegin              = find(Fullfreq >= freqband(1));
        fend                = find(Fullfreq <= freqband(2));
        fband               = fbegin(1):fend(end);
        bandFullspctrm      = Fullspctrm(:,:,fband);
        bandFullfreq        = Fullfreq(fband);
        clear Fullspctrm Fullfreq Fullspctrmrest Fullfreqrest
        Fullspctrm          = bandFullspctrm;
        Fullfreq            = bandFullfreq;

        
        subplot(1,3,j)
        % plot spctral variance
        MEANspctrm = mean(squeeze(mean(Fullspctrm,2)));
        STD = std(squeeze(mean(Fullspctrm,2)));
       
        if strcmp(datatoplot ,'BOTH')
            if strcmp(mode,'new')
                shadedErrorBar_seb(Fullfreq,MEANspctrm,STD,colors{k})
            elseif strcmp(mode,'old')
                errorbar(Fullfreq,MEANspctrm,STD)
            end
        end
        
        if strcmp(datatoplot,'MEAN')
            plot(Fullfreq,(log(MEANspctrm)),'color',colors_bis{k},'linewidth',2);
        end
        
        if strcmp(datatoplot,'STD')
            plot(Fullfreq,log(STD),'color',colors_bis{k},'linewidth',2);
        end
        
        title([chantypefull{j} ' ' subject ' : intertrial power ' datatoplot ])
        xlabel('frequency (Hz)')
        ylabel('log-power')
        
        % get alpha peaks
        nbHz = freqband(2) - freqband(1);
        minpeakdist  = round((length(Fullfreq))/nbHz);
        
        [pks{j,k},loc{j,k}] = findpeaks(log(MEANspctrm),'MINPEAKDISTANCE',minpeakdist*2);
        loc{j,k}            = Fullfreq(loc{j,k});
        ind2                = find(loc{j,k} <= 14);
        ind1                = find(loc{j,k} >= 7);
        LOC{j,k}            = loc{j,k}(ind1(1):ind2(end));
        PKS{j,k}            = pks{j,k}(ind1(1):ind2(end));
           
        [maxpeak,ind3]      = max(PKS{j,k});
        LOCbis{j,k}         = LOC{j,k}(ind3);
        PKSbis{j,k}         = PKS{j,k}(ind3);
        
        hold on
        
        % plot peak
        plot(LOCbis{j,k},PKSbis{j,k},'marker','o','color','k','linestyle','none')
        
        hold on
    end
end
legend('data1','data2','data3','data4','data5','data6')

if savetag == 1
    print('-dpng',['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
        '/VAR_spectra_' datatoplot '_' num2str(indexes) '_' ...
        num2str(freqband(1)) '-' num2str(freqband(2)) '.png']);
end


