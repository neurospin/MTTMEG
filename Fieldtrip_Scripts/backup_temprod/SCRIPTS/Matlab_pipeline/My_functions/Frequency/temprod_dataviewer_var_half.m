function [PKSbis,LOCbis] = temprod_dataviewer_var_half(indexes,subject,freqband,debiasing,loglogdetrend,datatoplot,mode,savetag)

DIR = ['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];
chantypefull            = {'Mags';'Gradslong';'Gradslat'};

fig                 = figure('position',[1 1 1280 1024/3.5]);
% set(fig,'PaperPosition',[1 1 1280 1024])
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
        
        %% short and long trials
        
        S = round(size(Fullspctrm,1)/2);
        L = size(Fullspctrm,1) - S;
        T = size(Fullspctrm,1);
        
        Fullspctrm_S = Fullspctrm(1:S,:,:);
        Fullspctrm_L = Fullspctrm((S+1):T,:,:);
        
        S_Toremove  = ComputeOneOverF_half(Fullfreq,Fullspctrm_S); 
        L_Toremove  = ComputeOneOverF_half(Fullfreq,Fullspctrm_L); 
        ToRemove    = (S_Toremove + L_Toremove)/2;
        [Fullfreq,Fullspctrm_S] = RemoveOneOverF_half(Fullfreq,Fullspctrm_S,ToRemove);
        [Fullfreq,Fullspctrm_L] = RemoveOneOverF_half(Fullfreq,Fullspctrm_L,ToRemove);
        
        
        %% noise removal and channel-by-channel linear interpolation replacemement
        if debiasing == 1
            [Fullfreq,Fullspctrm] = LineNoiseInterp(Fullfreq,Fullspctrm);
        end
        
        %% line noise interpolation
        
        [Fullfreq,Fullspctrm_S] = LineNoiseInterp(Fullfreq,Fullspctrm_S);
        [Fullfreq,Fullspctrm_L] = LineNoiseInterp(Fullfreq,Fullspctrm_L);
                
        % select frequency band
        fbegin              = find(Fullfreq >= freqband(1));
        fend                = find(Fullfreq <= freqband(2));
        fband               = fbegin(1):fend(end);
        bandFullspctrm_S    = Fullspctrm_S(:,:,fband);
        bandFullspctrm_L    = Fullspctrm_L(:,:,fband);
        bandFullfreq        = Fullfreq(fband);
        clear Fullspctrm Fullfreq
        Fullspctrm_S        = bandFullspctrm_S;
        Fullspctrm_L        = bandFullspctrm_L;
        Fullfreq            = bandFullfreq;
        
        subplot(1,3,j)
        % plot spctral variance
        MEANspctrm1 = mean(squeeze(mean(Fullspctrm_S,1)));
        MEANspctrm2 = mean(squeeze(mean(Fullspctrm_L,1)));
        STD1 = std(squeeze(mean(Fullspctrm_S,1)));
        STD2 = std(squeeze(mean(Fullspctrm_L,2)));
        
        if strcmp(datatoplot ,'BOTH')
            if strcmp(mode,'new')
                shadedErrorBar_seb(Fullfreq,MEANspctrm,STD,colors{k})
            elseif strcmp(mode,'old')
                errorbar(Fullfreq,MEANspctrm,STD)
            end
        end
        
        if strcmp(datatoplot,'MEAN')
            plot(Fullfreq,MEANspctrm1,'color','b','linewidth',1);
            hold on
            plot(Fullfreq,MEANspctrm2,'color','r','linewidth',1);
            hold on
            plot(Fullfreq,(MEANspctrm2 - MEANspctrm1),'color',[1 0 1],'linewidth',2);
        end
        
        if strcmp(datatoplot,'STD')
            plot(Fullfreq,STD1,'color','b','linewidth',1);
            hold on
            plot(Fullfreq,STD2,'color','r','linewidth',1);
            hold on
            plot(Fullfreq,(STD2 - STD1),'color',[1 0 1],'linewidth',2);
        end
        
        title([chantypefull{j} ' ' subject ' : intertrial power ' datatoplot ])
        xlabel('frequency (Hz)')
        ylabel('power')
        
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
    'data 2 short trials','data 2 long trials','Long - Short')

 line([freqband(1) freqband(2)],[0 0],'linestyle','--','color','k');

if savetag == 1
    print('-dpng',['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
        '/VAR_spectra_half' datatoplot '_' num2str(indexes) '_' ...
        num2str(freqband(1)) '-' num2str(freqband(2)) '.png']);
end


