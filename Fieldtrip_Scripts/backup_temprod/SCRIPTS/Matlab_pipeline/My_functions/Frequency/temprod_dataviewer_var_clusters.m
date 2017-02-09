function temprod_dataviewer_var_clusters(indexes,subject,freqband,debiasing,alphapeak,datatoplot,mode,savetag)

DIR = ['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];
chantypefull            = {'Mags';'Gradslong';'Gradslat'};
[Find, Bind, Vind, Lind, Rind] = clusteranat;

fig                 = figure('position',[1 1 1280 1024]);
% set(fig,'PaperPosition',[1 1 1280 1024])
set(fig,'PaperPositionMode','auto')

% set(0,'DefaultFigureRenderer','opengl')

c = colormap('jet');
C = c(1:10:end,:);


colors = {'-k';'-b';'-r';'-g';'-y'};
colors_bis = {C(1,:);C(2,:);C(3,:);C(4,:);C(5,:);C(6,:);C(7,:)};

for j = 1:3
    for clustind = 1:5
        
        if clustind == 1
            indsel = Find; clustname = 'FRONT';
        elseif clustind == 2
            indsel = Bind; clustname = 'BACK';
        elseif clustind == 3
            indsel = Vind; clustname = 'VERTEX';
        elseif clustind == 4
            indsel = Lind; clustname = 'LEFT';
        elseif clustind == 5
            indsel = Rind; clustname = 'RIGHT';
        end
        
        clear DataToRemove
        for k = 1:length(indexes)
            Fullspctrm          = [];
            Fullfreq            = [];
            chantype            = chantypefull{j};
            Fullspctrm_path     = [DIR 'FT_spectra/FullspctrmV2_' chantype num2str(indexes(k)) '.mat'];
            load(Fullspctrm_path);
            tmp = unique(Fullfreq); clear Fullfreq;
            Fullfreq            = tmp;
            
            %% remove 1/f component
            if debiasing == 1
                [Fullfreq,Fullspctrm] = RemoveOneOverF(Fullfreq,Fullspctrm,'mean');
            end
            
            %% noise removal and channel-by-channel linear interpolation replacemement
%             if interpnoise == 1
                [Fullfreq,Fullspctrm] = LineNoiseInterp(Fullfreq,Fullspctrm);
%             end
            
            % select frequency band
            fbegin              = find(Fullfreq >= freqband(1));
            fend                = find(Fullfreq <= freqband(2));
            fband               = fbegin(1):fend(end);
            bandFullspctrm      = Fullspctrm(:,:,fband);
            bandFullfreq        = Fullfreq(fband);
            clear Fullspctrm Fullfreq
            Fullspctrm          = bandFullspctrm;
            Fullfreq            = bandFullfreq;
            
            % get limit values
            Max = squeeze(max(max(mean(Fullspctrm))));
            Min = squeeze(min(min(mean(Fullspctrm))));
            
            % select channels wluster-wise
            Fullspctrm          = Fullspctrm(:,indsel,:);
            
            subplot(3,5,clustind + (j-1)*5)
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
                plot(Fullfreq,MEANspctrm,'color',colors_bis{k},'linewidth',2);
            end
            
            if strcmp(datatoplot,'STD')
                plot(Fullfreq,STD,'color',colors_bis{k},'linewidth',2);
            end
            
            axis([freqband(1) freqband(2) Min Max]);
            
            grid('on')
            
            title([clustname ' ' chantypefull{j} ' ' subject ' : ' datatoplot ])
            xlabel('frequency (Hz)')
            ylabel('power')
            
            grid('on')
            hold on
        end
    end
    legend('data1','data2','data3','data4','data5','data6')
end

if savetag == 1
    print('-dpng',['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
        '/VAR_spectra_clusters_' datatoplot '_' num2str(indexes) '_' ...
        num2str(freqband(1)) '-' num2str(freqband(2)) '.png']);
end


