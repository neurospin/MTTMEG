function [rho1,rho2,pval1,pval2] = temprod_OLD_ICAcomp_freqstats(datapath,freqband,chantype,index,subject)

ncomp = 20;

% datapath = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/OLD/processed_' subject '/run'];

%% Plot basic correlation between frequency peak, frequency peak power and temporal
%% estimates
load(datapath)
load(['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/OLD/processed_' subject '/'...
'Fullspctrm_ICAcomp_' chantype num2str(index) '.mat']);
% load(['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/OLD/processed_' subject '/freqdataplot_'...
%     num2str(freqband(1)) '_' num2str(freqband(2)) '_' chantype '.mat']);

Sample                 = [];
for i                  = 1:length(data.time)
    Sample             = [Sample ; length(data.time{i})];
end
fsample                = data.fsample;

freq.powspctrm         = Fullspctrm;
clear Fullspctrm;
freq.powspctrm         = freq.powspctrm(:,1:ncomp,(length(4:0.2:freqband(1)):(length(4:0.2:freqband(2)))));
freq.freq = Fullfreq((length(4:0.2:freqband(1)):(length(4:0.2:freqband(2)))));
clear FullFreq

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

