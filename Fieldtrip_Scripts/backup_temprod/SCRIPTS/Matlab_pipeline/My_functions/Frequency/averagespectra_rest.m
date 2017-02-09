%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function temprod_freqanalysis_rest_meg(indexrun,subject,freqband,numtrial)

Dir = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];
chantypefull               = {'Mags';'Gradslong';'Gradslat'};

%% concatenate data

Fullspctrm          = [];
Fullfreq            = [];
for i = 1:3
    chantype = chantypefull{i};
    for x               = 1:numtrial
        if isempty(Fullspctrm) == 1
            trialdataset{x}    = [chantype 'MEGfreq_' num2str(freqband(1)) '_' num2str(freqband(2)) 'run' num2str(indexrun) 'trial' num2str(x) '.mat'];
            freqpath        = [Dir trialdataset{x}];
            load(freqpath)
            S = size(squeeze(freq.powspctrm));
            Fullspctrm = zeros(S(1),S(2));
        end
        trialdataset{x}    = [chantype 'MEGfreq_' num2str(freqband(1)) '_' num2str(freqband(2)) 'run' num2str(indexrun) 'trial' num2str(x) '.mat'];
        freqpath        = [Dir trialdataset{x}];
        load(freqpath)
        Fullspctrm = Fullspctrm + squeeze(freq.powspctrm);
        Fullfreq = freq.freq;
    end
    Fullspctrm_path     = [Dir 'FullspctrmMEGRest_' chantype num2str(indexrun) '.mat'];
    save(Fullspctrm_path,'Fullspctrm','Fullfreq');
end


for y = 1:numtrial
    delete([Dir trialdataset{y}])
end
disp(['intermediates datasets deleted'])