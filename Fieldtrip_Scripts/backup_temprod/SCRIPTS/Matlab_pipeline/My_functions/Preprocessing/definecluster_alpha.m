function definecluster_alpha(index,subject)

datapath = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/run'];

par.ProcDataDir            = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];
chantypefull               = {'Mags';'Gradslong';'Gradslat'};
[label2,label3,label1]     = grads_for_layouts;

for j = 1:3
    load([par.ProcDataDir 'Fullspctrm_alpha' chantypefull{j}  num2str(index) '.mat']);
    M = []; m = [];
    for a = 1:size(Fullspctrm,1)
        M = mean([M max(max(squeeze(Fullspctrm(a,:,:))))]);
        m = mean([m min(min(squeeze(Fullspctrm(a,:,:))))]);
    end
    M = M*0.5;
    m = m*1.5;
    fig                    = figure('position',[1 1 1280 1024]);
    for x = 1:length(Fullfreq)
        mysubplot(6,10,x)
        % load full spectra array
        chantype               = chantypefull{j};
        % select the corresponding power
        freq.powspctrm         = Fullspctrm;
        freq.freq              = Fullfreq;
        trialnumber            = size(Fullspctrm,1);
        % complete dummy fieldtrip structure
        freq.dimord            = 'rpt_chan_freq';
        eval(['freq.label      = label' num2str(j) ';']);
        freq.cumtapcnt         = ones(trialnumber,length(freq.freq));
        
        clear cfg
        cfg.channel           = chantypefull{j};
        cfg.xparam            = 'freq';
        cfg.zparam            = 'powspctrm';
        cfg.xlim              = [Fullfreq(x) Fullfreq(x)];
        cfg.zlim              = [m M];
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
        cfg.comment           = [num2str(Fullfreq(x)) ' ' chantype];
        cfg.layout            = '/neurospin/meg_tmp/ResonanceMeg_Baptiste_2009/SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
        lay                   = ft_prepare_layout(cfg,freq);
        lay.label             = freq.label;
        cfg.layout            = lay;
        
        ft_topoplotER(cfg,freq)
        
    end
    print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
        '/topoalpha_' chantypefull{j} '.png']);
end


