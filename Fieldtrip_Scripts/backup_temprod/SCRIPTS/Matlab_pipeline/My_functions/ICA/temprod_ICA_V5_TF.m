function temprod_ICA_V5_TF(index,subject,numcomponent)

Dir = ['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject];

for a = 1:8
    eval(['datapath' num2str(a) '= [''/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_'...
        subject '/run' num2str(a) '.mat'']']);
end

[Gradslong, Gradslat] = grads_for_layouts;
channeltype = {'MEG*1';Gradslong;Gradslat};
chan_index  = {'Mags';'Gradslong';'Gradslat'};
chan_cmt    = {'M';'G1';'G2'};

[GradsLong,GradsLat,Mags]     = grads_for_layouts;

data  = [];
options = [1e-6 0 0 1 10 10000];
c = colormap(jet(numcomponent));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3D version

for j = 1:3;
    clear FullFTspctrm
    load(fullfile(Dir,['/FT_TFwavelet/' chan_index{j} 'freq_allrun' num2str(index) '.mat']));
    if j == 1
        for a = 1:length(FullFTspctrm)
            data{1,a} = [];
        end
    end
    for a = 1:length(FullFTspctrm)
        s = length(FullFTspctrm{1,a}.time);
        data{j,a} = squeeze(FullFTspctrm{1,a}.powspctrm(:,:,:,100:250));
    end
end
for j = 1:3
    for a = 1:length(data)
        [factors{j,a},it{j,a},err{j,a},concordia{j,a}] = parafac(data{j,a},numcomponent,options);
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3D versioncon - concatenated

for j = 1:3;
    clear FullFTspctrm
    load(fullfile(Dir,['/FT_TFwavelet/' chan_index{j} 'freq_allrun' num2str(index) '.mat']));
    if j == 1
        for a = 1:length(FullFTspctrm)
            data{1,a} = [];
        end
    end
    for a = 1:length(FullFTspctrm)
        s = length(FullFTspctrm{1,a}.time);
        data{j,a} = squeeze(FullFTspctrm{1,a}.powspctrm(:,:,:,100:(s-100)));
    end
end

datacac{1} = [];
datacac{2} = [];
datacac{3} = [];
for i =1:length(FullFTspctrm)
    datacac{j} = cat(3,datacac{j},data{j,a});
end

for j = 1:3
    for a = 1:length(data)
        [factors{j},it{j},err{j},concordia{j}] = parafac(data{j},numcomponent,options);
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4D version
data = [];
for a = 1:length(FullFTspctrm)
    data = cat(1,data,FullFTspctrm{1,a}.powspctrm(:,:,:,100:250));
end
% options = [1e-6 1 2 0 10 10000];
factors = parafac(data,numcomponent);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for j = 1:3
    for f = 1:length(factors)
        % specifiy layout for plotting topographies
        clear cfg
        cfg.channel           = channeltype{1};
        cfg.xparam            = 'comp';
        cfg.zparam            = 'topo';
        cfg.zlim              = 'maxabs';
        cfg.baseline          = 'no';
        cfg.trials            = 'all';
        cfg.colormap          = jet;
        cfg.marker            = 'off';
        cfg.markersymbol      = 'none';
        cfg.markercolor       = [0 0 0];
        cfg.markersize        = 2;
        cfg.markerfontsize    = 8;
        cfg.colorbar          = 'no';
        cfg.interplimits      = 'head';
        cfg.interpolation     = 'v4';
        cfg.style             = 'straight';
        cfg.gridscale         = 67;
        cfg.shading           = 'flat';
        cfg.interactive       = 'no';
        cfg.layout            = '/neurospin/meg/meg_tmp/ResonanceMeg_Baptiste_2009/SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
        lay                   = ft_prepare_layout(cfg,factors{j,f}{1,1});
        tmp                   = chan_index{j};
        eval(['lay.label             = ' tmp]);
        cfg.layout            = lay;
        
        fig                 = figure('position',[1281 1 1280 1024]);
        set(fig,'PaperPosition',[1281 1 1280 1024])
        set(fig,'PaperPositionMode','auto')
        place = [1 2 6 7 11 12 16 17 21 22 26 27];
        
        for i = 1:numcomponent
            cfg.comment       = [chan_index{j} 'comp' num2str(i)];
            cfg.commentpos    = 'lefttop';
            cfg.electrodes    = 'off';
            mysubplot(6,5,place(i));
            topoplot(cfg,factors{j,f}{1,1}(:,i));
        end
        subplot(6,5,[3:5 8:10 13:15]);
        for i = 1:numcomponent
            plot(FullFTspctrm{1,1}.freq,factors{j,f}{1,2}(:,i),'color',c(i,:))
            hold on
            L{i} = ['comp' num2str(i)];
        end
        grid('on')
        legend(L)
        xlabel('frequency (Hz)')
        subplot(6,5,[18:20 23:25 28:30]);
        
        timeaxis = (FullFTspctrm{1,1}.time(100:250) - ones(1,length(FullFTspctrm{1,1}.time(100:250)))*2);
        for i = 1:numcomponent
            plot(timeaxis,factors{j,f}{1,3}(:,i),'color',c(i,:))
            hold on
        end
        grid('on')
        legend(L)
        xlabel('time (s)')
        
        print('-dpng',['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
            '/PLOT_IC_PARAFAC/parafac_TF_' chan_index{j} '_' num2str(f,'%03i') num2str(index) '.png']);
        
    end
end


freqcomppath           = [par.ProcDataDir 'FT_ICs/parafac_TF' num2str(numcomponent) '_' num2str(index) '.mat'];
save(freqcomppath,'factors');
