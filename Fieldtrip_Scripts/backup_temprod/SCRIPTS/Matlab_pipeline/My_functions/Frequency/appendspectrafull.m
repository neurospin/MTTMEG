function appendspectrafull(index,subject)

par.ProcDataDir         = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];
range = 1:0.5:46;
for a = 1:length(range)
    freqbandfull{a} = [(range(a)+3) (range(a)+3.4)];
end

load([par.ProcDataDir 'run' num2str(index) '.mat']);
for i = 1:size(data.time,2)
    trialduration(1,i) = length(data.time{i});
    trialduration(2,i) = i;
end
asc_ord = sortrows(trialduration');
chantypefull            = {'Mags';'Gradslong';'Gradslat'};

for j = 1:3
    Fullspctrm          = [];
    Fullfreq            = [];
    for x               = 1:length(freqbandfull)
        freqband        = freqbandfull{x};
        chantype        = chantypefull{j};
        freqpath        = [par.ProcDataDir chantype 'freq_' num2str(freqband(1)) '_' num2str(freqband(2)) '_' num2str(index) '.mat'];
        load(freqpath)
        Fullspctrm      = cat(3,Fullspctrm,freq.powspctrm(:,:,:));
        Fullfreq        = [Fullfreq freq.freq];
    end
    Fullspctrm      = Fullspctrm(asc_ord(:,2)',:,:);
    Fullspctrm_path     = [par.ProcDataDir 'Fullspctrm_' chantype num2str(index) '.mat'];
    save(Fullspctrm_path,'Fullspctrm','Fullfreq','-v7.3');
    Pmean(j,:)           = zscore(mean(squeeze(mean(Fullspctrm(:,:,:)))));

    
    eval(['Fullspctrm' chantype '= Fullspctrm;']);

end
fig                 = figure('position',[1 1 1280 1024]);
plot(Fullfreq,Pmean);

%% Get visuals for the result
fig                 = figure('position',[1 1 1280 1024]);
sub1 = subplot(1,3,1);
imagesc(log(squeeze(mean(FullspctrmMags,2))));
xlabel('frequency');
ylabel('trials');
title('log power');
colorbar;
set(sub1,'XTick',11:50:length(Fullfreq),'XTickLabel',Fullfreq(11:50:end));
sub2 = subplot(1,3,2);
imagesc(log(squeeze(mean(FullspctrmGradslong,2))));
xlabel('frequency');
ylabel('trials');
title('log power');
colorbar;
set(sub2,'XTick',11:50:length(Fullfreq),'XTickLabel',Fullfreq(11:50:end));
sub3 = subplot(1,3,3);
imagesc(log(squeeze(mean(FullspctrmGradslat,2))));
xlabel('frequency');
ylabel('trials');
title('log power');
colorbar
set(sub3,'XTick',11:50:length(Fullfreq),'XTickLabel',Fullfreq(11:50:end));

print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
    '/Fullspctrm_image_' num2str(index) '.png']);
