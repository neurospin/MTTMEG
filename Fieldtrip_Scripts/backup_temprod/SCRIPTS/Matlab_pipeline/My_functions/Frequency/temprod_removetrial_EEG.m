function temprod_removetrial(indexrun,subject,trialvector)

Dir = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];
chantypefull            = {'Mags';'Gradslong';'Gradslat'};


Fullspctrm          = [];
Fullfreq            = [];
Fullspctrm_path     = [Dir 'FT_spectra/Fullspctrm_EEG_' num2str(indexrun) '.mat'];
load(Fullspctrm_path);

save([Dir 'FT_spectra/Fullspctrm_EEG_backup_' num2str(indexrun) '.mat'],'Fullspctrm','Fullfreq','asc_ord')

disp(['backup spectra file saved in' Dir 'FT_spectra/Fullspctrm_EEG_backup_' num2str(indexrun) '.mat'])

Fullspctrm(trialvector,:,:) = [];
asc_ord(trialvector,:) = [];
save(Fullspctrm_path,'Fullspctrm','Fullfreq','asc_ord','trialvector')
disp(['Fullspctrm_EEG_' num2str(indexrun) '.mat cleaned from noisy trials']);

