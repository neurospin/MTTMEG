function resonance_topoplot(nip,tag)

root                   = SetPath('Laptop');

freqvalues = [50 75 100 150 200 300 400 600];
r_freqvalues = [50 83.3 100 150 200 300 400 600];

scrsz = get(0,'ScreenSize');
fig   = figure('position',scrsz);
set(fig,'PaperPosition',scrsz)
set(fig,'PaperPositionMode','auto')

chantype = {'Mags';'Grads1';'Grads2'};

for c = 1:3
    for i = 1:length(freqvalues)
        
        % load data from stimulation and baseline
        load(['C:\RESONANCE_MEG\DATA\' nip '\freq\' chantype{c} '_freqsub_' num2str(freqvalues(i)) '_stimfreq.mat']);
        load(['C:\RESONANCE_MEG\DATA\' nip '\freq\' chantype{c} '_freqsuball_baseline.mat']);
        FREQSUB.powspctrm = FREQSUB.powspctrm - FREQB_allcond.powspctrm;
        
        % plotting parameters
        cfg                    = [];
        cfg.channel            = 'all';
        cfg.parameter          = 'powspctrm';
        cfg.xlim               = [1/r_freqvalues(i) 1/r_freqvalues(i)]*1000 + [-0.1 +0.1];
        cfg.ylim               = 'maxmin';
        cfg.zlim               = 'maxmin';
        cfg.interplimits       = 'head';
        cfg.interpolation      = 'v4';
        cfg.style              = 'straight';
        cfg.gridscale          = 67;
        cfg.shading            = 'flat';
        cfg.hlmarker           = 'o';
        cfg.hlcolor            = [0 0 0];
        cfg.hlmarkersize       = 1.5;
        cfg.hllinewidth        = 6;
        cfg.fontsize           = 10;
        cfg.colormap           = hot;
        cfg.comment            = [nip ' ' chantype{c} ' : ' num2str(r_freqvalues(i)) 'ms fundamental'];
        cfg.layout             = [root '/SCRIPTS/Layouts_fieldtrip/NM306mag.lay'];
        lay                    = ft_prepare_layout(cfg,FREQSUB);
        lay.label              = FREQSUB.label;
        cfg.layout             = lay;
        cfg.colorbar           = 'yes';
        
        mysubplot(2,4,i)
        ft_topoplotER(cfg,FREQSUB)
    end
    
    print('-dpng',['C:\RESONANCE_MEG\DATA\' nip '\plots\'  chantype{c}  'topoplot_fund'])
    
    
    scrsz = get(0,'ScreenSize');
    fig   = figure('position',scrsz);
    set(fig,'PaperPosition',scrsz)
    set(fig,'PaperPositionMode','auto')
    
    for i = 1:length(freqvalues)
        
        % load data from stimulation and baseline
        load(['C:\RESONANCE_MEG\DATA\' nip '\freq\' chantype{c} '_freqsub_' num2str(freqvalues(i)) '_stimfreq.mat']);
        load(['C:\RESONANCE_MEG\DATA\' nip '\freq\' chantype{c} '_freqsuball_baseline.mat']);
        FREQSUB.powspctrm = FREQSUB.powspctrm - FREQB_allcond.powspctrm;
        
        % plotting parameters
        cfg                    = [];
        cfg.channel            = 'all';
        cfg.parameter          = 'powspctrm';
        cfg.xlim               = [1/r_freqvalues(i) 1/r_freqvalues(i)]*500 + [-0.1 +0.1];
        cfg.ylim               = 'maxmin';
        cfg.zlim               = 'maxmin';
        cfg.interplimits       = 'head';
        cfg.interpolation      = 'v4';
        cfg.style              = 'straight';
        cfg.gridscale          = 67;
        cfg.shading            = 'flat';
        cfg.hlmarker           = 'o';
        cfg.hlcolor            = [0 0 0];
        cfg.hlmarkersize       = 1.5;
        cfg.hllinewidth        = 6;
        cfg.fontsize           = 10;
        cfg.colormap           = hot;
        cfg.comment            = [nip ' ' chantype{c} ' : ' num2str(r_freqvalues(i)) 'ms subharm'];
        cfg.layout             = [root '/SCRIPTS/Layouts_fieldtrip/NM306mag.lay'];
        lay                    = ft_prepare_layout(cfg,FREQSUB);
        lay.label              = FREQSUB.label;
        cfg.layout             = lay;
        cfg.colorbar           = 'yes';
        
        mysubplot(2,4,i)
        ft_topoplotER(cfg,FREQSUB)
    end
    
    print('-dpng',['C:\RESONANCE_MEG\DATA\' nip '\plots\' chantype{c} '_topoplot_subharm'])
end


