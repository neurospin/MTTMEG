function P = temprod_freqslope(index,subject,freqband,savetag,tag)

% set root
root = SetPath(tag); 
DIR = [root '/DATA/NEW/processed_' subject '/'];

chantypefull            = {'Mags';'Gradslong';'Gradslat'};

b = colormap('jet');
d = colormap('gray');
e = colormap('copper');
c = [b ; d ; e];

for j = 1:3
    
    Fullspctrm          = [];
    Fullfreq            = [];
    chantype            = chantypefull{j};
    Fullspctrm_path     = [DIR 'FT_spectra/FullspctrmV2_' chantype num2str(index) '.mat'];
    load(Fullspctrm_path);
    tmp = unique(Fullfreq); clear Fullfreq;
    Fullfreq            = tmp;
    
    % remove line noise artifacts
    [Fullfreq,Fullspctrm] = LineNoiseInterp(Fullfreq,Fullspctrm);
    
    % select frequency band
    fbegin              = find(Fullfreq >= freqband(1));
    fend                = find(Fullfreq <= freqband(2));
    fband               = fbegin(1):fend(end);
    bandFullspctrm      = Fullspctrm(:,:,fband);
    bandFullfreq        = Fullfreq(fband);
    clear                 Fullspctrm Fullfreq
    Fullspctrm          = bandFullspctrm;
    Fullfreq            = bandFullfreq;
    
    for i = 1:size(Fullspctrm)
        meanspctrm(:,i) =  squeeze(mean(Fullspctrm(i,:,:)));
        P{j}(i,:)       = polyfit(log(bandFullfreq),log(meanspctrm(:,i))',1);
    end
end

scrsz = get(0,'ScreenSize');
figure('position',scrsz);
for  j = 1:3
    subplot(2,3,j)
    [rho1, pval1] = corr(asc_ord(:,1),P{j}(:,1));
    p = polyfit(asc_ord(:,1), P{j}(:,1),1);
    plot(asc_ord(:,1), P{j}(:,1),'linestyle','none','marker','o','linewidth',2)
    hold on
    plot(asc_ord(:,1),polyval(p,asc_ord(:,1)),'color','r','linewidth',2)
    xlabel('duration (ms)')
    ylabel(['P1 rho : ' num2str(rho1) ', pval : ' num2str(pval1)])
    title([subject ' run' num2str(index) ' ' chantypefull{j} ' : Amplitude'])  
end
for  j = 1:3
    subplot(2,3,3+j)
    [rho2, pval2] = corr(asc_ord(:,1),P{j}(:,2));
    p = polyfit(asc_ord(:,1), P{j}(:,2),1);
    plot(asc_ord(:,1), P{j}(:,2),'linestyle','none','marker','o','linewidth',2,'color','k')
    hold on
    plot(asc_ord(:,1),polyval(p,asc_ord(:,1)),'color','r','linewidth',2)
    xlabel('duration (ms)')
    ylabel(['P0 rho : ' num2str(rho2) ', pval : ' num2str(pval2)])
    title([subject ' run' num2str(index) ' ' chantypefull{j} ' : Slope']) 
end    
 

if savetag == 1
    print('-dpng',[root '/DATA/NEW/Plots_' subject...
        '/Fullspctrm_slope_' num2str(freqband(1)) '-' num2str(freqband(2)) '_' num2str(index) '.png']);
    savepath = [root '/DATA/NEW/processed_' subject '/FT_spectra/corrslope' num2str(freqband(1)) '-' num2str(freqband(2)) '_' num2str(index) ];
    save(savepath ,'P','rho1','rho2','pval1','pval2');
end

