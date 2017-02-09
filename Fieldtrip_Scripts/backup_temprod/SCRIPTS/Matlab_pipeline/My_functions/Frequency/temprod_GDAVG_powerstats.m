function  [ShortMeanFreq,ShortMeanPow,LongMeanFreq,LongMeanPow] = temprod_GDAVG_powerstats(subjects,freqbandselect,cond,tag)

% set root
root = SetPath(tag); 

% prepare figure
fig                 = figure('position',[1 1 1280 1024]);
set(fig,'PaperPosition',[1 1 1280 1024])
set(fig,'PaperPositionMode','auto')

% init legend
leg = [];
condsub = [];

for i = 1:length(subjects)
    
    condsub = [condsub '_' subjects{i}];
    
    % set paths
    Dir = [root '/DATA/NEW/processed_' subjects{i}];
    chantypefull  = {'Mags';'Gradslong';'Gradslat'};
    
    % load data
    datapath               = TheSlasher([Dir '/FT_spectra/Short&LongFreqGAVG_' cond '_0.5-120_V2.mat'],tag);
    datapath               = TheSlasher(datapath,tag);
    load(datapath,'ShortFreqGAVG','LongFreqGAVG');
    
    % select frequency band
    fbegin                = find(LongFreqGAVG{1,1}.freq >= freqbandselect(1));
    fend                  = find(LongFreqGAVG{1,1}.freq <= freqbandselect(2));
    fband                 = fbegin(1):fend(end);
    
    LongFreqGAVG{1,1}.powspctrm        = LongFreqGAVG{1,1}.powspctrm(:,fband);
    LongFreqGAVG{1,1}.freq             = LongFreqGAVG{1,1}.freq(fband);
    LongFreqGAVG{1,2}.powspctrm        = LongFreqGAVG{1,2}.powspctrm(:,fband);
    LongFreqGAVG{1,2}.freq             = LongFreqGAVG{1,2}.freq(fband);
    LongFreqGAVG{1,3}.powspctrm        = LongFreqGAVG{1,3}.powspctrm(:,fband);
    LongFreqGAVG{1,3}.freq             = LongFreqGAVG{1,3}.freq(fband);
    
    ShortFreqGAVG{1,1}.powspctrm       = ShortFreqGAVG{1,1}.powspctrm(:,fband);
    ShortFreqGAVG{1,1}.freq            = ShortFreqGAVG{1,1}.freq(fband);
    ShortFreqGAVG{1,2}.powspctrm       = ShortFreqGAVG{1,2}.powspctrm(:,fband);
    ShortFreqGAVG{1,2}.freq            = ShortFreqGAVG{1,2}.freq(fband);
    ShortFreqGAVG{1,3}.powspctrm       = ShortFreqGAVG{1,3}.powspctrm(:,fband);
    ShortFreqGAVG{1,3}.freq            = ShortFreqGAVG{1,3}.freq(fband);
    
    % get freq and pow data
    LongMeanPow(i,1)        = mean(mean(LongFreqGAVG{1,1}.powspctrm));
    LongMeanPow(i,2)        = mean(mean(LongFreqGAVG{1,2}.powspctrm));
    LongMeanPow(i,3)        = mean(mean(LongFreqGAVG{1,3}.powspctrm));
    ShortMeanPow(i,1)        = mean(mean(ShortFreqGAVG{1,1}.powspctrm));
    ShortMeanPow(i,2)        = mean(mean(ShortFreqGAVG{1,2}.powspctrm));
    ShortMeanPow(i,3)        = mean(mean(ShortFreqGAVG{1,3}.powspctrm));   
    
    tmp = find(squeeze(mean(LongFreqGAVG{1,1}.powspctrm)) == max(squeeze(mean(LongFreqGAVG{1,1}.powspctrm))));
    LongMeanFreq(i,1) = LongFreqGAVG{1,1}.freq(tmp);
    tmp = find(squeeze(mean(LongFreqGAVG{1,2}.powspctrm)) == max(squeeze(mean(LongFreqGAVG{1,2}.powspctrm))));
    LongMeanFreq(i,1) = LongFreqGAVG{1,2}.freq(tmp);
    tmp = find(squeeze(mean(LongFreqGAVG{1,3}.powspctrm)) == max(squeeze(mean(LongFreqGAVG{1,3}.powspctrm))));
    LongMeanFreq(i,1) = LongFreqGAVG{1,3}.freq(tmp);
    
    tmp = find(squeeze(mean(ShortFreqGAVG{1,1}.powspctrm)) == max(squeeze(mean(ShortFreqGAVG{1,1}.powspctrm))));
    ShortMeanFreq(i,1) = ShortFreqGAVG{1,1}.freq(tmp);
    tmp = find(squeeze(mean(ShortFreqGAVG{1,2}.powspctrm)) == max(squeeze(mean(ShortFreqGAVG{1,2}.powspctrm))));
    ShortMeanFreq(i,1) = ShortFreqGAVG{1,1}.freq(tmp);
    tmp = find(squeeze(mean(ShortFreqGAVG{1,3}.powspctrm)) == max(squeeze(mean(ShortFreqGAVG{1,3}.powspctrm))));
    ShortMeanFreq(i,1) = ShortFreqGAVG{1,1}.freq(tmp);

end
   