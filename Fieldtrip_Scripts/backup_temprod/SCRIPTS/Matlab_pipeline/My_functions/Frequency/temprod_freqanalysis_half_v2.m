function [ShortFreq,LongFreq] = temprod_freqanalysis_half_v2(run,subject,Pad,freqband,tag)

% set root
root = SetPath(tag); 
Dir = [root '/DATA/NEW/processed_' subject];

datapath               = [Dir '/FT_trials/Short&LongTrials_' num2str(run) '.mat'];
load(datapath,'ShortTrials','LongTrials','Max');
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
    cfg.pad                = Pad/ShortTrials.fsample;
    ShortFreq{j}           = ft_freqanalysis(cfg,ShortTrials);
    
    clear cfg
    cfg.channel            = channeltype;
    cfg.method             = 'mtmfft';
    cfg.output             = 'pow';
    cfg.taper              = 'dpss';
    cfg.foi                = freqband(1):0.1:freqband(2);
    cfg.tapsmofrq          = 1;
    cfg.trials             = 'all';
    cfg.keeptrials         = 'yes';
    cfg.pad                = Pad/LongTrials.fsample;
    LongFreq{j}            = ft_freqanalysis(cfg,LongTrials);
    
    % line noise interpolation
    [ShortFreq{1,j}.freq,ShortFreq{1,j}.powspctrm] = LineNoiseInterp(...
     ShortFreq{1,j}.freq,ShortFreq{1,j}.powspctrm);
    [LongFreq{1,j}.freq,LongFreq{1,j}.powspctrm] = LineNoiseInterp(...
     LongFreq{1,j}.freq,LongFreq{1,j}.powspctrm);
    
    % remove K.f^alpha bias
    ShortToremove = ComputeOneOverF_half(ShortFreq{1,j}.freq,ShortFreq{1,j}.powspctrm); 
    LongToremove  = ComputeOneOverF_half(LongFreq{1,j}.freq,LongFreq{1,j}.powspctrm);  
    ToRemove      = (ShortToremove + LongToremove)/2;
    [ShortFreq{1,j}.freq,ShortFreq{1,j}.powspctrm] = RemoveOneOverF_half(...
     ShortFreq{1,j}.freq,ShortFreq{1,j}.powspctrm,ToRemove);
    [LongFreq{1,j}.freq,LongFreq{1,j}.powspctrm]   = RemoveOneOverF_half(...
     LongFreq{1,j}.freq,LongFreq{1,j}.powspctrm,ToRemove);
end

datapath               = [Dir '/FT_spectra/Short&LongFreq_' ...
    num2str(freqband(1)) '-' num2str(freqband(2)) '_' num2str(run) '_V2.mat'];
save(datapath,'ShortFreq','LongFreq','Max');
