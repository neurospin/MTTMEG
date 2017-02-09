function resonance_topoplot_2(nip,tag)

root = SetPath('Laptop');

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
        FREQSUB.powspctrm = ((FREQSUB.powspctrm - FREQB_allcond.powspctrm)./FREQB_allcond.powspctrm)*100;
        
        % find SSR fund power valuevalue
        fbegin = []; fend = [];
        fbegin              = find(FREQSUB.freq >= (1000/r_freqvalues(i)));
        fend                = find(FREQSUB.freq < (1000/r_freqvalues(i)));
        if abs(1000/r_freqvalues(i) - FREQSUB.freq(fbegin(1))) <= abs(1000/r_freqvalues(i) - FREQSUB.freq(fend(end)))
            f_fund_ind      = fbegin(1);
        else
            f_fund_ind      = fend(end);
        end
        
        % plotting parameters
        cfg                    = [];
        cfg.channel            = 'all';
        cfg.parameter          = 'powspctrm';
        cfg.xlim               = [FREQSUB.freq(f_fund_ind) FREQSUB.freq(f_fund_ind)];
        cfg.ylim               = [-100 100];
        cfg.zlim               = 'maxmin';
        cfg.interplimits       = 'head';
        cfg.interpolation      = 'v4';
        cfg.style              = 'straight';
        cfg.gridscale          = 67;
        cfg.shading            = 'flat';
        cfg.highlight          = 'off';
        cfg.hlmarker           = 'o';
        cfg.hlcolor            = [0 0 0];
        cfg.hlmarkersize       = 1.5;
        cfg.hllinewidth        = 6;
        cfg.fontsize           = 10;
        cfg.colormap           = jet;
        cfg.comment            = [nip ' ' chantype{c} ' : ' num2str(r_freqvalues(i)) 'ms fundamental'];
        cfg.layout             = [root '/SCRIPTS/Layouts_fieldtrip/NM306mag.lay'];
        lay                    = ft_prepare_layout(cfg,FREQSUB);
        lay.label              = FREQSUB.label;
        cfg.layout             = lay;
        cfg.colorbar           = 'yes';
        
        mysubplot(2,4,i)
        ft_topoplotER(cfg,FREQSUB)
    end
    
    print('-dpng',['C:\RESONANCE_MEG\DATA\' nip '\plots\'  chantype{c}  'topoplot_fund_norm'])
    
    
    scrsz = get(0,'ScreenSize');
    fig   = figure('position',scrsz);
    set(fig,'PaperPosition',scrsz)
    set(fig,'PaperPositionMode','auto')
    
    for i = 1:length(freqvalues)
        
        % load data from stimulation and baseline
        load(['C:\RESONANCE_MEG\DATA\' nip '\freq\' chantype{c} '_freqsub_' num2str(freqvalues(i)) '_stimfreq.mat']);
        load(['C:\RESONANCE_MEG\DATA\' nip '\freq\' chantype{c} '_freqsuball_baseline.mat']);
        FREQSUB.powspctrm = ((FREQSUB.powspctrm - FREQB_allcond.powspctrm)./FREQB_allcond.powspctrm)*100;
        
        % find SSR fund sha valuevalue
        fbegin = []; fend = [];
        fbegin              = find(FREQSUB.freq >= (500/r_freqvalues(i)));
        fend                = find(FREQSUB.freq < (500/r_freqvalues(i)));
        if abs(500/r_freqvalues(i) - FREQSUB.freq(fbegin(1))) <= abs(500/r_freqvalues(i) - FREQSUB.freq(fend(end)))
            f_sha_ind      = fbegin(1);
        else
            f_sha_ind      = fend(end);
        end
        
        % plotting parameters
        cfg                    = [];
        cfg.channel            = 'all';
        cfg.parameter          = 'powspctrm';
        cfg.xlim               = [FREQSUB.freq(f_sha_ind) FREQSUB.freq(f_sha_ind)];
        cfg.ylim               = [-100 100];
        cfg.zlim               = 'maxmin';
        cfg.interplimits       = 'head';
        cfg.interpolation      = 'v4';
        cfg.style              = 'straight';
        cfg.gridscale          = 67;
        cfg.shading            = 'flat';
        cfg.highlight          = 'off';
        cfg.hlmarker           = 'o';
        cfg.hlcolor            = [0 0 0];
        cfg.hlmarkersize       = 1.5;
        cfg.hllinewidth        = 6;
        cfg.fontsize           = 10;
        cfg.colormap           = jet;
        cfg.comment            = [nip ' ' chantype{c} ' : ' num2str(r_freqvalues(i)) 'ms subharm'];
        cfg.layout             = [root '/SCRIPTS/Layouts_fieldtrip/NM306mag.lay'];
        lay                    = ft_prepare_layout(cfg,FREQSUB);
        lay.label              = FREQSUB.label;
        cfg.layout             = lay;
        cfg.colorbar           = 'yes';
        
        mysubplot(2,4,i)
        ft_topoplotER(cfg,FREQSUB)
    end
    
    print('-dpng',['C:\RESONANCE_MEG\DATA\' nip '\plots\' chantype{c} '_topoplot_subharm_norm'])
end
