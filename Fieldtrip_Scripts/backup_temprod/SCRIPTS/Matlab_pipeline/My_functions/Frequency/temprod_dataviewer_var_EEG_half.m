function [PKSbis,LOCbis] = temprod_dataviewer_var_EEG_half(indexes,subject,freqband,debiasing,loglogdetrend,datatoplot,mode,savetag)

DIR = ['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];
chantypefull            = {'EEG'};

fig                 = figure('position',[1 1 1280/1.2 1024/3.5]);
% set(fig,'PaperPosition',[1 1 1280 1024])
set(fig,'PaperPositionMode','auto')

% set(0,'DefaultFigureRenderer','opengl')

c = colormap('jet');
C = c(1:10:end,:);  


colors = {'-k';'-b';'-r';'-g';'-y'};
colors_bis = {C(1,:);C(2,:);C(3,:);C(4,:);C(5,:);C(6,:);C(7,:)};

for j = 1
    clear DataToRemove
    for k = 1:length(indexes)
        Fullspctrm          = [];
        Fullfreq            = [];
        chantype            = chantypefull{j};
        Fullspctrm_path     = [DIR 'FT_spectra/Fullspctrm_EEG_' num2str(indexes(k)) '.mat'];
        load(Fullspctrm_path);
        tmp = unique(Fullfreq); clear Fullfreq;
        Fullfreq            = tmp;
        
        if loglogdetrend == 1
            %% remove linear trend of log-log representation of the mean (on full freqband)
            % create a matrix with regressor components
            dat                 = log(mean(squeeze(mean(Fullspctrm,2))));
            basis               = log(Fullfreq);
            X                   = zeros(2,length(Fullfreq));
            for i               = 0:1
                X(i+1,:)        = basis.^(i);
            end
            % estimate the polynomial trend using General Linear Modeling, where dat=beta*x+noise
            beta                = dat/X(:,1:end);
            % data to subtract to remove the trend
            DataToRemove{k}   = exp(beta*X);
        end
        
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
        
        % remove line noise stopband artifacts
%         LNfbegin                = find(Fullfreq >= 47);
%         LNfend                  = find(Fullfreq <= 53);
%         LNfband                 = LNfbegin(1):LNfend(end);
%         Fullspctrm(:,:,LNfband) = [];
%         Fullfreq(LNfband)       = [];
%         
%         LNfbegin                = find(Fullfreq >= 97);
%         LNfend                  = find(Fullfreq <= 100);
%         LNfband                 = LNfbegin(1):LNfend(end);
%         Fullspctrm(:,:,LNfband) = [];
%         Fullfreq(LNfband)       = [];
        
        % select frequency band
        fbegin              = find(Fullfreq >= freqband(1));
        fend                = find(Fullfreq <= freqband(2));
        fband               = fbegin(1):fend(end);
        bandFullspctrm      = Fullspctrm(:,:,fband);
        bandFullfreq        = Fullfreq(fband);
        clear Fullspctrm Fullfreq
        Fullspctrm          = bandFullspctrm;
        Fullfreq            = bandFullfreq;
        
        subplot(1,3,j)
        % plot spctral variance
        MEANspctrm1 = mean(squeeze(mean(Fullspctrm(1:(round(size(Fullspctrm,1)/2)),:,:),2)));
        STD1 = std(squeeze(mean(Fullspctrm(1:(round(size(Fullspctrm,1)/2)),:,:),2)));
        MEANspctrm2 = mean(squeeze(mean(Fullspctrm(round(size(Fullspctrm,1)/2):size(Fullspctrm,1),:,:),2)));
        STD2 = std(squeeze(mean(Fullspctrm(round(size(Fullspctrm,1)/2):size(Fullspctrm,1),:,:),2)));
        
        if loglogdetrend == 1
            MEANspctrm = MEANspctrm - DataToRemove{k}(:,fband);
        end
       
        if strcmp(datatoplot ,'BOTH')
            if strcmp(mode,'new')
                shadedErrorBar_seb(Fullfreq,MEANspctrm,STD,colors{k})
            elseif strcmp(mode,'old')
                errorbar(Fullfreq,MEANspctrm,STD)
            end
        end
        
        if strcmp(datatoplot,'MEAN')
            plot(Fullfreq,log(MEANspctrm1),'color','k','linewidth',1);
            hold on
            plot(Fullfreq,log(MEANspctrm2),'color','r','linewidth',1);
        end
        
        if strcmp(datatoplot,'STD')
            plot(Fullfreq,log(STD1),'color','k','linewidth',1);
            hold on
            plot(Fullfreq,log(STD2),'color','r','linewidth',1);
        end
        
        title([chantypefull{j} ' ' subject ' : intertrial power ' datatoplot ])
        xlabel('frequency (Hz)')
        ylabel('log-power')
        
        % get alpha peaks
%         nbHz = freqband(2) - freqband(1);
%         minpeakdist  = round((length(Fullfreq))/nbHz);
%         
%         [pks{j,k},loc{j,k}] = findpeaks(log(MEANspctrm),'MINPEAKDISTANCE',minpeakdist*2);
%         loc{j,k}            = Fullfreq(loc{j,k});
%         ind2                = find(loc{j,k} <= 14);
%         ind1                = find(loc{j,k} >= 7);
%         LOC{j,k}            = loc{j,k}(ind1(1):ind2(end));
%         PKS{j,k}            = pks{j,k}(ind1(1):ind2(end));
%            
%         [maxpeak,ind3]      = max(PKS{j,k});
%         LOCbis{j,k}         = LOC{j,k}(ind3);
%         PKSbis{j,k}         = PKS{j,k}(ind3);
%         
%         hold on
        
        % plot peak
%         plot(LOCbis{j,k},PKSbis{j,k},'marker','o','color','k','linestyle','none')
        
        hold on
    end
end
    legend('data 1 short trials','data 1 long trials',...
           'data 2 short trials','data 2 long trials',...
           'data 3 short trials','data 3 long trials',...
           'data 4 short trials','data 4 long trials',...
           'data 5 short trials','data 5 long trials',...
           'data 6 short trials','data 6 long trials')

if savetag == 1
    print('-dpng',['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
        '/VAR_spectra_EEG_half' datatoplot '_' num2str(indexes) '_' ...
        num2str(freqband(1)) '-' num2str(freqband(2)) '.png']);
end


