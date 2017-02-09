function temprod_removetrial(indexrun,subject,trialvector)

Dir = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];
chantypefull            = {'Mags';'Gradslong';'Gradslat'};

for j = 1:3
    Fullspctrm          = [];
    Fullfreq            = [];
    chantype            = chantypefull{j};
    Fullspctrm_path     = [Dir 'FullspctrmV2_' chantype num2str(indexrun) '.mat'];
    load(Fullspctrm_path);
    Fullspctrm(trialvector,:,:) = [];
    asc_ord(trialvector,:) = [];
    save(Fullspctrm_path,'Fullspctrm','Fullfreq','asc_ord','trialvector')
end