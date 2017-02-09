function temprod_NEW_icaviewer(index,subject,freqband,K,compdisplay,savetag)

par.ProcDataDir         = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];
chantypefull            = {'Mags';'Gradslong';'Gradlat'};

for j = 1:3
    Fullspctrm          = [];
    Fullfreq            = [];
    chantype            = chantypefull{j};
    Fullspctrm_path     = [par.ProcDataDir 'Fullspctrm_ICAcomp_' chantype num2str(index) '.mat'];
    load(Fullspctrm_path);
    fbegin              = find(Fullfreq >= freqband(1));
    fend                = find(Fullfreq <= freqband(2));
    fband               = fbegin(1):fend(end);
    bandFullspctrm      = Fullspctrm(:,:,fband);
    bandFullfreq        = Fullfreq(fband);
    clear Fullspctrm Fullfreq
    Fullspctrm          = bandFullspctrm;
    Fullfreq            = bandFullfreq;
    
    %% smooting by convolution
    h =[];
    for x               = 1:size(Fullspctrm,2)
        g = [];
        for y           = 1:size(Fullspctrm,3)
            v           = squeeze(Fullspctrm(:,x,y))';
            f           = conv(v,K,'same');
            g(:,y) = f;
            clear f
        end
        h = cat(3,h,g);
    end
    h = permute(h,[1 3 2]);
    Fullspctrm = h;
    
    if compdisplay == 1
        %% plot channel-by-channel data
        fig                 = figure('position',[1 1 1280 1024]);
        for k               = 1:size(Fullspctrm,2)
            full            = [];
            for i           = 1:size(Fullspctrm,1)
                Pmean       = squeeze((Fullspctrm(i,k,:)));
                full        = [full Pmean];
            end
            mysubplot(11,10,k)
            imagesc(log(full)')
        end
        
        %% save plot
        if savetag == 1
            print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
                '/Fullspctrm_' chantype '_' num2str(freqband(1)) '-' num2str(freqband(2)) '_' num2str(index) '.png']);
        end
        
        %% plot-channel-by-channel zscores
        fig                 = figure('position',[1 1 1280 1024]);
        for k               = 1:size(Fullspctrm,2)
            full            = [];
            for i           = 1:size(Fullspctrm,1)
                Pmean       = squeeze((Fullspctrm(i,k,:)));
                full        = [full Pmean];
            end
            mysubplot(11,10,k)
            imagesc(zscore(log(full)',0,2));
        end
        %% save plot
        if savetag == 1
            print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
                '/Fullspctrm_zscores_' chantype '_' num2str(freqband(1)) '-' num2str(freqband(2)) '_' num2str(index) '.png']);
        end
    end
    %% rename data for averaging
    eval(['Fullspctrm' chantype '= Fullspctrm;']);
end

% plot results, zscores, averages across channels
fig                 = figure('position',[1 1 1280 1024]);
%% psd data
zscoretag = 0;
%% magnetometers
sub1 = subplot(3,3,1);
if zscoretag == 1
    z = zscore((squeeze(mean(FullspctrmMags,2))),0,2);
    imagesc(z);
else
    imagesc((squeeze(mean(FullspctrmMags,2))));
end
xlabel('frequency');
ylabel('trials');
title('mags power');
colorbar;
set(sub1,'XTick',10:16:length(Fullfreq),'XTickLabel',round(Fullfreq(10:16:end)*10)/10);
%% longitudinal gradiometers
sub2 = subplot(3,3,2);
if zscoretag == 1
    z = zscore((squeeze(mean(FullspctrmGradslong,2))),0,2);
    imagesc(z);
else
    imagesc((squeeze(mean(FullspctrmGradslong,2))));
end
xlabel('frequency');
ylabel('trials');
title('gradslong power');
colorbar;
set(sub2,'XTick',10:16:length(Fullfreq),'XTickLabel',round(Fullfreq(10:16:end)*10)/10);
%% latitudinal gradiometers
sub3 = subplot(3,3,3);
if zscoretag == 1
    z = zscore((squeeze(mean(FullspctrmGradlat,2))),0,2);
    imagesc(z);
else
    imagesc((squeeze(mean(FullspctrmGradlat,2))));
end
xlabel('frequency');
ylabel('trials');
title('gradslat power');
colorbar
set(sub3,'XTick',10:16:length(Fullfreq),'XTickLabel',round(Fullfreq(10:16:end)*10)/10);

%% Z-scores data
zscoretag = 1;
%% magnetometers
sub1 = subplot(3,3,4);
if zscoretag == 1
    z = zscore((squeeze(mean(FullspctrmMags,2))),0,2);
    imagesc(z);
else
    imagesc((squeeze(mean(FullspctrmMags,2))));
end
xlabel('frequency');
ylabel('trials');
title('mags power zscore');
colorbar;
set(sub1,'XTick',10:16:length(Fullfreq),'XTickLabel',round(Fullfreq(10:16:end)*10)/10);
%% longitudinal gradiometers
sub2 = subplot(3,3,5);
if zscoretag == 1
    z = zscore((squeeze(mean(FullspctrmGradslong,2))),0,2);
    imagesc(z);
else
    imagesc((squeeze(mean(FullspctrmGradslong,2))));
end
xlabel('frequency');
ylabel('trials');
title('gradslong power zscore');
colorbar;
set(sub2,'XTick',10:16:length(Fullfreq),'XTickLabel',round(Fullfreq(10:16:end)*10)/10);
%% latitudinal gradiometers
sub3 = subplot(3,3,6);
if zscoretag == 1
    z = zscore((squeeze(mean(FullspctrmGradlat,2))),0,2);
    imagesc(z);
else
    imagesc((squeeze(mean(FullspctrmGradlat,2))));
end
xlabel('frequency');
ylabel('trials');
title('gradslat power zscore');
colorbar
set(sub3,'XTick',10:16:length(Fullfreq),'XTickLabel',round(Fullfreq(10:16:end)*10)/10);


if savetag == 1
    print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
        '/Fullspctrm_overview_' num2str(freqband(1)) '-' num2str(freqband(2)) '_' num2str(index) '.png']);
end


%% specifiy layout for plotting topographies

[Gradslong, Gradslat] = grads_for_layouts;
channeltype = {'MEG*1';Gradslong;Gradslat};
chan_index  = {'Mags';'Gradslong';'Gradslat'};

for k = 1:3
    comp_timecourse_path  = [par.ProcDataDir 'comp_timecourse_' num2str(chan_index{k}) num2str(index) '.mat'];
    load(comp_timecourse_path);
    comp = comp_timecourse;
    clear comp_timecourse
    clear cfg
    cfg.channel           = channeltype{k};
    cfg.xparam            = 'time';
    cfg.zparam            = 'avg';
    cfg.baseline          = 'no';
    cfg.trials            = 'all';
    cfg.colormap          = jet;
    cfg.marker            = 'off';
    cfg.markersymbol      = 'o';
    cfg.markercolor       = [0 0 0];
    cfg.markersize        = 2;
    cfg.markerfontsize    = 8;
    cfg.colorbar          = 'no';
    cfg.interplimits      = 'head';
    cfg.interpolation     = 'v4';
    cfg.style             = 'straight';
    cfg.gridscale         = 67;
    cfg.shading           = 'flat';
    cfg.interactive       = 'yes';
    cfg.layout            = '/neurospin/meg_tmp/ResonanceMeg_Baptiste_2009/SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
    lay                   = ft_prepare_layout(cfg,comp);
    lay.label             = Gradslong;
    cfg.layout            = lay;
    
    %% plot the 20 first components topographies
    fig = figure('position',[1 1 1280 1024]);
    for i = 1:size(Fullspctrm,2)
        mysubplot(8,10,i)
        cfg.comment = ['comp ' num2str(i)];
k = 1
topoplot(cfg,abs(comp.topo(:,i)))
    end
    
    print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
        '/icacomptopos' num2str(chan_index{k}) num2str(index) '.png']);
    
end

if savetag == 1
    print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
        '/Fullspctrm_overview_' num2str(freqband(1)) '-' num2str(freqband(2)) '_' num2str(index) '.png']);
end



