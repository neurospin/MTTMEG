function  PowSubNorm = temprod_halfdiff(arrayindex,arraysubject,arrayfreqband,Title,spatialfilter)

% set plotting parameters
fig                 = figure('position',[1 1 1280 1024]);
set(fig,'PaperPosition',[1 1 1280 1024])
set(fig,'PaperPositionMode','auto')

chantypefull            = {'Mags';'Gradslong';'Gradslat'};
count = 1;

Pow_mags      = zeros(size(arraysubject,1),2);
Pow_gradslong = zeros(size(arraysubject,1),2);
Pow_gradslat  = zeros(size(arraysubject,1),2);

% load spectra info for each subject
for i = 1:length(arraysubject)
    DIR = ['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' arraysubject{i} '/'];
    freqband = [];
    freqband = arrayfreqband{i};
    
    % for each run
    for j = 1:length(arrayindex{i,1})
        
        % for each channel type
        for k = 1:3
            
            % load subject freq*chan*trial dataset
            Fullspctrm          = [];
            Fullfreq            = [];
            chantype            = chantypefull{k};
            Fullspctrm_path     = [DIR 'FT_spectra/FullspctrmV2_' chantype num2str(arrayindex{i,1}(j)) '.mat'];
            load(Fullspctrm_path);
            tmp                 = unique(Fullfreq); clear Fullfreq;
            Fullfreq            = tmp;
            
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
            
            % get mean poawer across all frequencies for normalization
            if k == 1
                MeanForNorm_1{i}{j} = squeeze(mean(mean(mean(Fullspctrm))));
            elseif k == 2
                MeanForNorm_2{i}{j} = squeeze(mean(mean(mean(Fullspctrm))));
            elseif k == 3
                MeanForNorm_3{i}{j} = squeeze(mean(mean(mean(Fullspctrm))));
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
            
            % spatial filter: zscore of mean topography
%             Sp = zscore(squeeze(mean(squeeze(mean(Fullspctrm,1)),2)));
            
            % divide the dataset into two half based on durations
            MEANspctrm1 = mean(squeeze(mean(Fullspctrm(1:(round(size(Fullspctrm,1)/2)),:,:),2)));
            STD1 = std(squeeze(mean(Fullspctrm(1:(round(size(Fullspctrm,1)/2)),:,:),2)));
            MEANspctrm2 = mean(squeeze(mean(Fullspctrm(round(size(Fullspctrm,1)/2):size(Fullspctrm,1),:,:),2)));
            STD2 = std(squeeze(mean(Fullspctrm(round(size(Fullspctrm,1)/2):size(Fullspctrm,1),:,:),2)));
            M = ([MEANspctrm1; MEANspctrm2]') ;
            
            if k == 1
                PowZ_mags{i}{j}      = M;
            elseif k == 2
                PowZ_gradslong{i}{j} = M;
            elseif k == 3
                PowZ_gradslat{i}{j}  = M;
            end
        end
        
        Pow_mags(i,:)       = Pow_mags(i,:) + mean(PowZ_mags{i}{j})./mean(MeanForNorm_1{i}{j});
        Pow_gradslong(i,:)  = Pow_mags(i,:) + mean(PowZ_gradslong{i}{j})./mean(MeanForNorm_2{i}{j});
        Pow_gradslat(i,:)   = Pow_mags(i,:) + mean(PowZ_gradslat{i}{j})./mean(MeanForNorm_3{i}{j});
    end
    
    Pow_1_short(i,:)      = Pow_mags(i,1)./length(arrayindex{i,1});
    Pow_1_long(i,:)       = Pow_mags(i,2)./length(arrayindex{i,1});
    Pow_2_short(i,:)      = Pow_gradslong(i,1)./length(arrayindex{i,1});
    Pow_2_long(i,:)       = Pow_gradslong(i,2)./length(arrayindex{i,1});
    Pow_3_short(i,:)      = Pow_gradslat(i,1)./length(arrayindex{i,1});
    Pow_3_long(i,:)       = Pow_gradslat(i,2)./length(arrayindex{i,1});
end

PowSubNorm = [Pow_1_short Pow_1_long Pow_2_short Pow_2_long Pow_3_short Pow_3_long];


subplot(3,3,1); hist(Pow_1_short);
h = findobj(gca,'Type','patch');
set(h,'FaceColor','b','EdgeColor','k');
title('Mags: first half trial');
xlabel(['PowerBand/PowerAllfreq'])
subplot(3,3,2); hist(Pow_1_long);
h = findobj(gca,'Type','patch');
set(h,'FaceColor','r','EdgeColor','k');
title('Mags: second half trial');
xlabel(['PowerBand/PowerAllfreq'])
subplot(3,3,3)
bar([mean(Pow_1_short);mean(Pow_1_long)]','facecolor',[0.5 0.5 0.5]); hold on
errorbar(1,mean(Pow_1_short),std(Pow_1_short),'xk'); hold on
errorbar(2,mean(Pow_1_long),std(Pow_1_long),'xk');
set(gca,'xtick',1:2,'xticklabel',{'first half','secondhalf'})
ylabel('PowerBand/PowerAllfreq');
[h,p] = ttest(Pow_1_short,Pow_1_long);
title(['pval : ' num2str(p)]);

subplot(3,3,4); hist(Pow_2_short);
h = findobj(gca,'Type','patch');
set(h,'FaceColor','b','EdgeColor','k');
title('Gradslong: first half trial');
xlabel(['PowerBand/PowerAllfreq'])
subplot(3,3,5); hist(Pow_2_long);
h = findobj(gca,'Type','patch');
set(h,'FaceColor','r','EdgeColor','k');
title('Gradslong: second half trial');
xlabel(['PowerBand/PowerAllfreq'])
subplot(3,3,6)
bar([mean(Pow_2_short);mean(Pow_2_long)]','facecolor',[0.5 0.5 0.5]); hold on
errorbar(1,mean(Pow_2_short),std(Pow_2_short),'xk'); hold on
errorbar(2,mean(Pow_2_long),std(Pow_2_long),'xk');
set(gca,'xtick',1:2,'xticklabel',{'first half','secondhalf'})
ylabel('PowerBand/PowerAllfreq');
[h,p] = ttest(Pow_2_short,Pow_2_long);
title(['pval : ' num2str(p)]);

subplot(3,3,7); hist(Pow_2_short);
h = findobj(gca,'Type','patch');
set(h,'FaceColor','b','EdgeColor','k');
title('Mags: first half trial');
xlabel(['PowerBand/PowerAllfreq'])
subplot(3,3,8); hist(Pow_2_long);
h = findobj(gca,'Type','patch');
set(h,'FaceColor','r','EdgeColor','k');
title('Mags: second half trial');
xlabel(['PowerBand/PowerAllfreq'])
subplot(3,3,9)
bar([mean(Pow_2_short);mean(Pow_2_long)]','facecolor',[0.5 0.5 0.5]); hold on
errorbar(1,mean(Pow_2_short),std(Pow_2_short),'xk'); hold on
errorbar(2,mean(Pow_2_long),std(Pow_2_long),'xk');
set(gca,'xtick',1:2,'xticklabel',{'first half','secondhalf'})
ylabel('PowerBand/PowerAllfreq');
[h,p] = ttest(Pow_2_short,Pow_2_long);
title(['pval : ' num2str(p)]);

print('-dpng',['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/across_subjects_plots/' Title '.png']);


