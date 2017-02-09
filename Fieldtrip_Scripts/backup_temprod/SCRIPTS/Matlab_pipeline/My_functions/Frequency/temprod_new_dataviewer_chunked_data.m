function temprod_new_dataviewer_chunked_data(index,subject,freqband,K,durationsize,chandisplay,savetag,part)

for a = 1:8
    eval(['datapath' num2str(a) '= [''/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_'...
        subject '/run' num2str(a) '_' part '.mat'']']);
end

par.ProcDataDir         = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];
chantypefull            = {'Mags';'Gradslong';'Gradslat'};

eval(['load(datapath' num2str(index) ');']);

eval(['data = data_' part]);
clear data_part1 data_part2 data_part3

for i = 1:size(data.time,2)
    trialduration(1,i) = length(data.time{i});
    trialduration(2,i) = i;
end
asc_ord = sortrows(trialduration');
X = asc_ord(:,1)';
% W = round((X/X(1))*10);
W = ceil(abs(zscore(X))*10);

for j = 1:3
    Fullspctrm          = [];
    Fullfreq            = [];
    chantype            = chantypefull{j};
    Fullspctrm_path     = [par.ProcDataDir 'Fullspctrm_' chantype num2str(index) '_' part '.mat'];
    load(Fullspctrm_path);
    fbegin              = find(Fullfreq >= freqband(1));
    fend                = find(Fullfreq <= freqband(2));
    fband               = fbegin(1):fend(end);
    bandFullspctrm      = Fullspctrm(:,:,fband);
    bandFullfreq        = Fullfreq(fband);
    clear Fullspctrm Fullfreq
    Fullspctrm          = bandFullspctrm;
    Fullfreq            = bandFullfreq;
    %% resize data with respect to duration
    if durationsize == 1
        Fullspctrm2 = [];
        for i = 1:size(Fullspctrm,1)
            F(1:W(i),:,:) = repmat(Fullspctrm(i,:,:),[W(i) 1 1]);
            Fullspctrm2 = cat(1,Fullspctrm2,F);
            clear F
        end
        Fullspctrm = Fullspctrm2; clear Fullspctrm2
    else
    end
    
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
    
    if chandisplay == 1
        %% plot channel-by-channel data
        fig                 = figure('position',[1 1 1280 1024]);
        for k               = 1:102
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
                '/Fullspctrm_' chantype '_' num2str(freqband(1)) '-' num2str(freqband(2)) '_' num2str(index) '_' part '.png']);
        end
        
        %% plot-channel-by-channel zscores
        fig                 = figure('position',[1 1 1280 1024]);
        for k               = 1:102
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
                '/Fullspctrm_zscores_' chantype '_' num2str(freqband(1)) '-' num2str(freqband(2)) '_' num2str(index) '_' part '.png']);
        end
    end
    %% rename data for averaging
    eval(['Fullspctrm' chantype '= Fullspctrm;']);
end

%% plot results, zscores, averages across channels
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
    z = zscore((squeeze(mean(FullspctrmGradslat,2))),0,2);
    imagesc(z);
else
    imagesc((squeeze(mean(FullspctrmGradslat,2))));
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
    z = zscore((squeeze(mean(FullspctrmGradslat,2))),0,2);
    imagesc(z);
else
    imagesc((squeeze(mean(FullspctrmGradslat,2))));
end
xlabel('frequency');
ylabel('trials');
title('gradslat power zscore');
colorbar
set(sub3,'XTick',10:16:length(Fullfreq),'XTickLabel',round(Fullfreq(10:16:end)*10)/10);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% plot mean topographies
[label2,label3,label1]     = grads_for_layouts;
chantypefull               = {'Mags';'Gradslong';'Gradslat'};
for x = 1:3
    chantypefull{x};   
    % load full spectra array
    chantype               = chantypefull{x};
    % select the corresponding power
    eval(['freq.powspctrm         = Fullspctrm' chantype]);
    freq.freq              = Fullfreq;
    trialnumber            = size(Fullspctrm,1);
    % complete dummy fieldtrip structure
    freq.dimord            = 'rpt_chan_freq';
    eval(['freq.label      = label' num2str(x) ';']);
    freq.cumtapcnt         = ones(trialnumber,length(freq.freq));
    
    clear cfg
    cfg.channel           = 'all';
    cfg.xparam            = 'freq';
    cfg.zparam            = 'powspctrm';
    cfg.xlim              = [Fullfreq(1) Fullfreq(end)];
    %     cfg.zlim              = [m M];
    cfg.baseline          = 'no';
    cfg.trials            = 'all';
    cfg.colormap          = jet;
    cfg.marker            = 'off';
    cfg.markersymbol      = 'o';
    cfg.markercolor       = [0 0 0];
    cfg.markersize        = 2;
    cfg.markerfontsize    = 8;
    cfg.colorbar          = 'yes';
    cfg.interplimits      = 'head';
    cfg.interpolation     = 'v4';
    cfg.style             = 'straight';
    cfg.gridscale         = 67;
    cfg.shading           = 'flat';
    cfg.interactive       = 'yes';
    cfg.comment           = ['average power' chantype];
    cfg.layout            = '/neurospin/meg_tmp/ResonanceMeg_Baptiste_2009/SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
    lay                   = ft_prepare_layout(cfg,freq);
    lay.label             = freq.label;
    cfg.layout            = lay;
    
    subplot(3,3,6+x)
    ft_topoplotER(cfg,freq)
end

if savetag == 1
    print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
        '/Fullspctrm_overview_' num2str(freqband(1)) '-' num2str(freqband(2)) '_' num2str(index) '_' part '.png']);
end



