function spectra_correct(indexrun,subject,freqband)

Dir = ['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject];
chantypefull  = {'Mags';'Gradslong';'Gradslat'};

load(fullfile(Dir,['/FT_trials/run' num2str(indexrun) 'trial001.mat']))
ntrials = size(data.sampleinfo,1);

%% sort data by ascending order of trial duration

durations(:,1) = data.sampleinfo(:,2) - data.sampleinfo(:,1);
durations(:,2) = (1:length(durations))';

asc_ord = sortrows(durations);
asc_ord(:,1)./data.fsample;
chantypefull            = {'Mags';'Gradslong';'Gradslat'};

par.ProcDataDir         = ['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];

%% concatenate data
for j = 1:3
    
    Fullspctrm_path     = [par.ProcDataDir 'FT_spectra/FullspctrmV2_' chantype num2str(indexrun) '.mat'];
    

end