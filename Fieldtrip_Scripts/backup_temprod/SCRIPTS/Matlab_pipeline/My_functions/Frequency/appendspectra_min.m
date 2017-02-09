function appendspectra_min(indexrun,subject,freqband)

Dir = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];

%% sort data by ascending order of trial duration

durinfopath = [Dir 'FT_trials/run' num2str(indexrun) 'durinfo.mat'];
load(durinfopath)
durations(:,1) = info(:,2) - info(:,1);
durations(:,2) = (1:length(durations))';

asc_ord = sortrows(durations);
chantypefull            = {'Mags';'Gradslong';'Gradslat'};

par.ProcDataDir         = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];
%% concatenate data
for j = 1:3
    Fullspctrm          = [];
    Fullfreq            = [];
    for x               = 1:length(durations)
        chantype        = chantypefull{j};
        trialdataset{x}    = ['FT_spectra/' chantype 'freqmin_' num2str(freqband(1)) '_' num2str(freqband(2)) 'run' num2str(indexrun) 'trial' num2str(x) '.mat'];
        freqpath        = [Dir trialdataset{x}];
        load(freqpath)
        Fullspctrm      = cat(1,Fullspctrm,freq.powspctrm(:,:,:));
        Fullfreq        = [Fullfreq freq.freq];
    end
    Fullspctrm      = Fullspctrm(asc_ord(:,2)',:,:);
    disp(['trials concatenated in FullspctrmMin_' chantype num2str(indexrun)])
    
    Fullspctrm_path     = [par.ProcDataDir 'FT_spectra/FullspctrmMin_' chantype num2str(indexrun) '.mat'];
    save(Fullspctrm_path,'Fullspctrm','Fullfreq','asc_ord','-v7.3');

    % then delete all intermediate files
    for x = 1:length(durations)
        delete([Dir trialdataset{x}])
    end
    disp(['intermediates datasets deleted'])
    
end







