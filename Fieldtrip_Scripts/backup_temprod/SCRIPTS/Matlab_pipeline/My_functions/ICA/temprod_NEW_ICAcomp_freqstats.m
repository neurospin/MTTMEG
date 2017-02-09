function [rho1,rho2,pval1,pval2] = temprod_NEW_ICAcomp_freqstats(freqband,chantype,index,subject)

par.ProcDataDir         = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/run'];
ncomp = 20;

%% Plot basic correlation between frequency peak, frequency peak power and temporal
%% estimates
load([par.ProcDataDir num2str(index) '.mat'])
load(['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'...
    'Fullspctrm_ICAcomp_' chantype num2str(index) '.mat']);

Sample                 = [];
for i                  = 1:length(data.time)
    Sample             = [Sample ; length(data.time{i})];
end
fsample                = data.fsample;

[label2,label3,label1] = grads_for_layouts;

% load full spectra array
load([par.ProcDataDir 'Fullspctrm_ICAcomp_' chantype num2str(index) '.mat']);
% select frequency band of interest
freqinit               = find(Fullfreq == freqband(1));
freqend                = find(Fullfreq == freqband(2));
freqresolution         = Fullfreq(2) - Fullfreq(1);
freq.freq              = Fullfreq(freqinit:freqend);
clear FullFreq
% select the corresponding power
freq.powspctrm         = Fullspctrm;
freq.powspctrm         = freq.powspctrm(:,1:ncomp,(freqinit:freqend));
trialnumber            = size(Fullspctrm,1);
clear Fullspctrm
% complete dummy fieldtrip structure
freq.dimord            = 'rpt_chan_freq';
if strcmp(chantype,'Gradslong') == 1
    freq.label         = label2;
elseif strcmp(chantype,'Gradslat') == 1
    freq.label         = label3;
else 
    freq.label         = label1;
end
freq.cumtapcnt         = ones(trialnumber,length(freq.freq));

for x = 1:size(freq.powspctrm,2)
    for k                    = 1:length(Sample)
        pmax(x,k)            = max(squeeze(freq.powspctrm(k,x,:)));
        pmin(x,k)            = min(squeeze(freq.powspctrm(k,x,:)));
        Peak(x,k)            = freq.freq(find(freq.powspctrm(k,x,:) == pmax(x,k)));
    end
end

for x = 1:size(freq.powspctrm,2)
    [rho1(x),pval1(x)] = corr((Sample/fsample),Peak(x,:)');
    [rho2(x),pval2(x)] = corr((Sample/fsample),pmax(x,:)');
end

