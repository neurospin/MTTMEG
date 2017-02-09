% select frequency band

fbegin              = find(freq.freq >= freqband(1));
fend                = find(freq.freq <= freqband(2));
fband               = fbegin(1):fend(end);
freq.powspctrm      = freq.powspctrm(:,:,fband);
freq.freq           = freq.freq(fband);

% Plot average spectrum across channels and trials
plot(squeeze(mean(mean(freq.powspctrm))))