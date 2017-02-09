function [ShortFreq,LongFreq] = temprod_freqanalysis_half(run,subject,Pad,freqband)

Dir = ['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject];
datapath               = [Dir '/FT_trials/Short&LongTrials_' num2str(run) '.mat'];
load(datapath,'ShortTrials','LongTrials','Max');
chantypefull  = {'Mags';'Gradslong';'Gradslat'};

for j = 1:3
    chantype = chantypefull{j};
    [GradsLong, GradsLat]  = grads_for_layouts;
    if strcmp(chantype,'Mags')     == 1
        channeltype        =  {'MEG*1'};
    elseif strcmp(chantype,'Gradslong') == 1;
        channeltype        =  GradsLong;
    elseif strcmp(chantype,'Gradslat')
        channeltype        =  GradsLat;
    end
    
    clear cfg
    cfg.channel            = channeltype;
    cfg.method             = 'mtmfft';
    cfg.output             = 'pow';
    cfg.taper              = 'hanning';
    cfg.foi                = freqband(1):0.1:freqband(2);
    cfg.t_ftimwin          = ones(1,length(cfg.foi))*2;
    cfg.tapsmofrq          = 1;
    cfg.toi                = ones(1,2*length(cfg.foi))*1;
    cfg.trials             = 'all';
    cfg.keeptrials         = 'no';
    cfg.pad                = Pad/ShortTrials.fsample;
    ShortFreq{j}           = ft_freqanalysis(cfg,ShortTrials);
    
    clear cfg
    cfg.channel            = channeltype;
    cfg.method             = 'mtmfft';
    cfg.output             = 'pow';
    cfg.taper              = 'hanning';
    cfg.foi                = 1:0.1:120;
    cfg.t_ftimwin          = ones(1,length(cfg.foi))*2;
    cfg.tapsmofrq          = 1;
    cfg.toi                = ones(1,2*length(cfg.foi))*1;
    cfg.trials             = 'all';
    cfg.keeptrials         = 'no';
    cfg.pad                = Pad/ShortTrials.fsample;
    ShortNorm{j}           = ft_freqanalysis(cfg,ShortTrials);
    
    clear cfg
    cfg.channel            = channeltype;
    cfg.method             = 'mtmfft';
    cfg.output             = 'pow';
    cfg.taper              = 'hanning';
    cfg.foi                = freqband(1):0.1:freqband(2);
    cfg.t_ftimwin          = ones(1,length(cfg.foi))*2;
    cfg.tapsmofrq          = 1;
    cfg.toi                = ones(1,2*length(cfg.foi))*1;
    cfg.trials             = 'all';
    cfg.keeptrials         = 'no';
    cfg.pad                = Pad/LongTrials.fsample;
    LongFreq{j}            = ft_freqanalysis(cfg,LongTrials);
    
    clear cfg
    cfg.channel            = channeltype;
    cfg.method             = 'mtmfft';
    cfg.output             = 'pow';
    cfg.taper              = 'hanning';
    cfg.foi                = 1:0.1:120;
    cfg.t_ftimwin          = ones(1,length(cfg.foi))*2;
    cfg.tapsmofrq          = 1;
    cfg.toi                = ones(1,2*length(cfg.foi))*1;
    cfg.trials             = 'all';
    cfg.keeptrials         = 'no';
    cfg.pad                = Pad/ShortTrials.fsample;
    LongNorm{j}            = ft_freqanalysis(cfg,LongTrials);
    
    % normalization to broadband power
    m = mean([mean(ShortNorm{1,1}.powspctrm') mean(LongNorm{1,1}.powspctrm')]);
    LongFreq{j}.powspctrm  = LongFreq{j}.powspctrm/m;
    ShortFreq{j}.powspctrm = ShortFreq{j}.powspctrm/m;
    
end

datapath               = [Dir '/FT_spectra/Short&LongFreq_' ...
    num2str(freqband(1)) '-' num2str(freqband(2)) '_' num2str(run) '.mat'];
save(datapath,'ShortFreq','LongFreq','Max');
