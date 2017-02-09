function appendspectra_EEG(indexrun,subject,freqband)

DIR = ['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];

%% sort data by ascending order of trial duration

durinfopath = [DIR 'FT_trials/EEGrun' num2str(indexrun) 'durinfo.mat'];
load(durinfopath)
durations(:,1) = info(:,2) - info(:,1);
durations(:,2) = (1:length(durations))';

asc_ord = sortrows(durations);
clear data

par.ProcDataDir         = ['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];
%% concatenate data
    Fullspctrm          = [];
    Fullfreq            = [];
    for x               = 1:length(durations)

        trialdataset{x}    = ['FT_spectra/EEGfreq_' num2str(freqband(1)) '_' num2str(freqband(2)) 'run' num2str(indexrun) 'trial' num2str(x) '.mat'];
        freqpath        = [DIR trialdataset{x}];
        load(freqpath)
        Fullspctrm      = cat(1,Fullspctrm,freq.powspctrm(:,:,:));
        Fullfreq        = [Fullfreq freq.freq];
    end
    Fullspctrm      = Fullspctrm(asc_ord(:,2)',:,:);
    disp(['trials concatenated in FullspctrmEEG_' num2str(indexrun)])
    
    Fullspctrm_path     = [par.ProcDataDir 'FT_spectra/Fullspctrm_EEG_' num2str(indexrun) '.mat'];
    save(Fullspctrm_path,'Fullspctrm','Fullfreq','asc_ord','-v7.3');

    % then delete all intermediate files
    for x = 1:length(durations)
        delete([DIR trialdataset{x}])
    end
    disp(['intermediates datasets deleted'])
    








