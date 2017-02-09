function temprod_freqstats(subject,index,freqband,savetag)

% compute cluster analysis for power differencies
% between short and long trials in a run

DIR = ['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];
chantypefull            = {'Mags';'Gradslong';'Gradslat'};

fig                     = figure('position',[1 1 1280 1024]);
set(fig,'PaperPositionMode','auto')

[label2,label3,label1]  = grads_for_layouts;

for j = 1:3
    chantype            = chantypefull{j};
    Fullspctrm_path     = [DIR 'FT_spectra/FullspctrmV2_' chantype num2str(index) '.mat'];
    load(Fullspctrm_path);
    tmp = unique(Fullfreq); clear Fullfreq;
    Fullfreq            = tmp;
 
    % separate the dataset into 2 datasets: short and long trials
    ls                  = round(size(Fullspctrm,1)/2);
    ll                  = size(Fullspctrm,1);
    freq1.powspctrm     = squeeze(mean(Fullspctrm(1:ls,:,:)));
    freq2.powspctrm     = squeeze(mean(Fullspctrm((ls+1):ll,:,:)));
    freq1.freq          = Fullfreq;
    freq2.freq          = Fullfreq;
    freq1.trialnumber   = length(1:ls);
    freq2.trialnumber   = length((ls+1):ll);
    freq1.dimord        = 'chan_freq';
    freq2.dimord        = 'chan_freq';
    freq1.cumtapcnt     = ones(1,length(freq1.freq));
    freq2.cumtapcnt     = ones(1,length(freq2.freq));
    eval(['freq1.label      = label' num2str(j) ''' ;']);
    eval(['freq1.label      = label' num2str(j) ''';']);    
    
    % compute statistics
    cfg.channel         = 'all';
    cfg.latency         = 'all';
    cfg.frequency       = [freqband(1) freqband(2)];
    cfg.avgoverchan     = 'no';
    cfg.avgovertime     = 'yes';
    cfg.avgoverfreq     = 'no';
    cfg.parameter       = 'powspctrm';
    cfg.method          = 'montecarlo';
    cfg.design          = ones(1,102);
    cfg.ivar            = 1;
    
    stat = ft_freqstatistics(cfg, freq1, freq2);
    
    
    