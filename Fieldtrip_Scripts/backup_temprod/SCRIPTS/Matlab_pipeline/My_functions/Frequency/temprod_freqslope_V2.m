function P = temprod_freqslope_V2(cplindex,subject,freqband,savetag)

DIR = ['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];
chantypefull            = {'Mags';'Gradslong';'Gradslat'};

b = colormap('jet');
d = colormap('gray');
e = colormap('copper');
c = [b ; d ; e];

for i = 1:length(cplindex)
    for ij = 1:length(cplindex{i})
        for j = 1:3
            
            Fullspctrm          = [];
            Fullfreq            = [];
            chantype            = chantypefull{j};
            Fullspctrm_path     = [DIR 'FT_spectra/FullspctrmV2_' chantype num2str(cplindex{i}(ij)) '.mat'];
            load(Fullspctrm_path);
            tmp = unique(Fullfreq); clear Fullfreq;
            Fullfreq            = tmp;
            
            % select frequency band
            fbegin              = find(Fullfreq >= freqband(1));
            fend                = find(Fullfreq <= freqband(2));
            fband               = fbegin(1):fend(end);
            bandFullspctrm      = Fullspctrm(:,:,fband);
            bandFullfreq        = Fullfreq(fband);
            clear                 Fullspctrm Fullfreq
            Fullspctrm          = bandFullspctrm;
            Fullfreq            = bandFullfreq;
            
            duration{i,ij}      = asc_ord(:,1);
            
            meanspctrm          = [];
            for k = 1:size(Fullspctrm)
                tmp = [];
                meanspctrm(:,k) = squeeze(mean(Fullspctrm(k,:,:)));
                tmp = polyfit(log(bandFullfreq),log(meanspctrm(:,k))',1);
                P{i,ij,j}(k) = tmp(1);
            end
            
        end
    end
end

for i = 1:length(cplindex)
    for ij = 1:length(cplindex{i})
        for  j = 1:3
            [rho{i,ij,j}, pval{i,ij,j}] = corr(duration{i,ij},P{i,ij,j}');
            p1{i,ij,j} = polyfit(duration{i,ij},P{i,ij,j}',1);
        end
    end
end

% mags
fig                 = figure('position',[1 1 1280 1024]);
for i = 1:length(cplindex)
    subplot(2,2,i)
    plot(duration{i,1},P{i,1,1},'marker','o','color','b','linestyle','none'); hold on;
    plot(duration{i,1},polyval(p1{i,1,1},duration{i,1}),'color','b','linewidth',2); hold on;
    plot(duration{i,2},P{i,2,1},'marker','o','color','r','linestyle','none'); hold on;
    plot(duration{i,2},polyval(p1{i,2,1},duration{i,2}),'color','r','linewidth',2); hold on;
    xlabel('duration (ms)')
    ylabel('slope')
    title(['Mags: runest : ' num2str(cplindex{i}(1)) ', runrep : ' num2str(cplindex{i}(2)) ...
           ' freq' num2str(freqband(1)) '-' num2str(freqband(2)) 'Hz'])
end

if savetag == 1
    print('-dpng',['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
        '/Fullspctrm_slope_estimationVSreplay_Mags_' num2str(freqband(1)) '-' num2str(freqband(2)) '.png']);
%     savepath = ['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/FT_spectra/corrslope' num2str(freqband(1)) '-' num2str(freqband(2)) '_' num2str(index) ];
end

% grads1
fig                 = figure('position',[1 1 1280 1024]);
for i = 1:length(cplindex)
    subplot(2,2,i)
    plot(duration{i,1},P{i,1,2},'marker','o','color','b','linestyle','none'); hold on;
    plot(duration{i,1},polyval(p1{i,1,2},duration{i,1}),'color','b','linewidth',2); hold on;
    plot(duration{i,2},P{i,2,2},'marker','o','color','r','linestyle','none'); hold on;
    plot(duration{i,2},polyval(p1{i,2,2},duration{i,2}),'color','r','linewidth',2); hold on;
    xlabel('duration (ms)')
    ylabel('slope')
    title(['Grads1: runest : ' num2str(cplindex{i}(1)) ', runrep : ' num2str(cplindex{i}(2))...
        ' freq' num2str(freqband(1)) '-' num2str(freqband(2)) 'Hz'])
end

if savetag == 1
    print('-dpng',['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
        '/Fullspctrm_slope_estimationVSreplay_Grads1_' num2str(freqband(1)) '-' num2str(freqband(2)) '.png']);
%     savepath = ['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/FT_spectra/corrslope' num2str(freqband(1)) '-' num2str(freqband(2)) '_' num2str(index) ];
end

% grads2
fig                 = figure('position',[1 1 1280 1024]);
for i = 1:length(cplindex)
    subplot(2,2,i)
    plot(duration{i,1},P{i,1,3},'marker','o','color','b','linestyle','none'); hold on;
    plot(duration{i,1},polyval(p1{i,1,3},duration{i,1}),'color','b','linewidth',2); hold on;
    plot(duration{i,2},P{i,2,3},'marker','o','color','r','linestyle','none'); hold on;
    plot(duration{i,2},polyval(p1{i,2,3},duration{i,2}),'color','r','linewidth',2); hold on;
    xlabel('duration (ms)')
    ylabel('slope')
    title(['Grads2: runest : ' num2str(cplindex{i}(1)) ', runrep : ' num2str(cplindex{i}(2))...
        ' freq' num2str(freqband(1)) '-' num2str(freqband(2)) 'Hz'])
end

if savetag == 1
    print('-dpng',['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
        '/Fullspctrm_slope_estimationVSreplay_Grads2_' num2str(freqband(1)) '-' num2str(freqband(2)) '.png']);
%     savepath = ['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/FT_spectra/corrslope' num2str(freqband(1)) '-' num2str(freqband(2)) '_' num2str(index) ];
end

savepath = ['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/FT_spectra/corrslope_V2' num2str(freqband(1)) '-' num2str(freqband(2))];
save(savepath,'P','p1','rho','pval')

