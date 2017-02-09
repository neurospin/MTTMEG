function [Part1Freq,Part2Freq] = temprod_freqanalysis_quarter(run,subject,Pad,freqband,tag)

% set root
root = SetPath(tag);
Dir = [root '/DATA/NEW/processed_' subject];

datapath               = [Dir '/FT_trials/QuarterCutTrials_' num2str(run) '.mat'];
load(datapath,'Part1Trials','Part2Trials','Part3Trials','Part4Trials','Max');
chantypefull  = {'Mags';'Gradslong';'Gradslat'};

for j = 1:3
    chantype = chantypefull{j};
    [GradsLong, GradsLat]  = grads_for_layouts(tag);
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
    cfg.taper              = 'dpss';
    cfg.foi                = freqband(1):0.1:freqband(2);
    cfg.tapsmofrq          = 1;
    cfg.trials             = 'all';
    cfg.keeptrials         = 'yes';
    cfg.pad                = Pad/Part1Trials.fsample;
    Part1Freq{j}           = ft_freqanalysis(cfg,Part1Trials);
    
    clear cfg
    cfg.channel            = channeltype;
    cfg.method             = 'mtmfft';
    cfg.output             = 'pow';
    cfg.taper              = 'dpss';
    cfg.foi                = freqband(1):0.1:freqband(2);
    cfg.tapsmofrq          = 1;
    cfg.trials             = 'all';
    cfg.keeptrials         = 'yes';
    cfg.pad                = Pad/Part2Trials.fsample;
    Part2Freq{j}            = ft_freqanalysis(cfg,Part2Trials);
    
    clear cfg
    cfg.channel            = channeltype;
    cfg.method             = 'mtmfft';
    cfg.output             = 'pow';
    cfg.taper              = 'dpss';
    cfg.foi                = freqband(1):0.1:freqband(2);
    cfg.tapsmofrq          = 1;
    cfg.trials             = 'all';
    cfg.keeptrials         = 'yes';
    cfg.pad                = Pad/Part1Trials.fsample;
    Part3Freq{j}           = ft_freqanalysis(cfg,Part3Trials);
    
    clear cfg
    cfg.channel            = channeltype;
    cfg.method             = 'mtmfft';
    cfg.output             = 'pow';
    cfg.taper              = 'dpss';
    cfg.foi                = freqband(1):0.1:freqband(2);
    cfg.tapsmofrq          = 1;
    cfg.trials             = 'all';
    cfg.keeptrials         = 'yes';
    cfg.pad                = Pad/Part2Trials.fsample;
    Part4Freq{j}            = ft_freqanalysis(cfg,Part4Trials);
    
    % line noise interpolation
    [Part1Freq{1,j}.freq,Part1Freq{1,j}.powspctrm] = LineNoiseInterp(...
        Part1Freq{1,j}.freq,Part1Freq{1,j}.powspctrm);
    [Part2Freq{1,j}.freq,Part2Freq{1,j}.powspctrm] = LineNoiseInterp(...
        Part2Freq{1,j}.freq,Part2Freq{1,j}.powspctrm);
    [Part3Freq{1,j}.freq,Part3Freq{1,j}.powspctrm] = LineNoiseInterp(...
        Part3Freq{1,j}.freq,Part3Freq{1,j}.powspctrm);
    [Part4Freq{1,j}.freq,Part4Freq{1,j}.powspctrm] = LineNoiseInterp(...
        Part4Freq{1,j}.freq,Part4Freq{1,j}.powspctrm);    
    
    
    remove K.f^alpha bias
    Part1Toremove = ComputeOneOverF_half(Part1Freq{1,j}.freq,Part1Freq{1,j}.powspctrm);
    Part2Toremove  = ComputeOneOverF_half(Part2Freq{1,j}.freq,Part2Freq{1,j}.powspctrm);
    Part3Toremove = ComputeOneOverF_half(Part3Freq{1,j}.freq,Part3Freq{1,j}.powspctrm);
    Part4Toremove  = ComputeOneOverF_half(Part4Freq{1,j}.freq,Part4Freq{1,j}.powspctrm);    
    
    ToRemove      = (Part1Toremove + Part2Toremove + Part3Toremove + Part4Toremove)/4;
    [Part1Freq{1,j}.freq,Part1Freq{1,j}.powspctrm] = RemoveOneOverF_half(...
        Part1Freq{1,j}.freq,Part1Freq{1,j}.powspctrm,ToRemove);
    [Part2Freq{1,j}.freq,Part2Freq{1,j}.powspctrm]   = RemoveOneOverF_half(...
        Part2Freq{1,j}.freq,Part2Freq{1,j}.powspctrm,ToRemove);
    [Part3Freq{1,j}.freq,Part3Freq{1,j}.powspctrm] = RemoveOneOverF_half(...
        Part3Freq{1,j}.freq,Part3Freq{1,j}.powspctrm,ToRemove);
    [Part4Freq{1,j}.freq,Part4Freq{1,j}.powspctrm]   = RemoveOneOverF_half(...
        Part4Freq{1,j}.freq,Part4Freq{1,j}.powspctrm,ToRemove);    
end

datapath               = [Dir '/FT_spectra/QuarterCutFreq_' ...
    num2str(freqband(1)) '-' num2str(freqband(2)) '_' num2str(run) '_V2.mat'];
save(datapath,'Part1Freq','Part2Freq','Part3Freq','Part4Freq','Max');
