function appendspectra_weighted(indexrun,subject,freqband,nbwin,overlap)

Dir = ['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject];
chantypefull  = {'Mags';'Gradslong';'Gradslat'};

load(fullfile(Dir,['/FT_trials/run' num2str(indexrun) 'trial001.mat']))
ntrials = size(data.sampleinfo,1);

%% sort data by ascending order of trial duration

durations(:,1) = data.sampleinfo(:,2) - data.sampleinfo(:,1);
durations(:,2) = (1:length(durations))';

asc_ord = sortrows(durations);
asc_ord(:,1) = asc_ord(:,1)/250;
chantypefull            = {'Mags';'Gradslong';'Gradslat'};

par.ProcDataDir         = ['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];
%% concatenate data
for j = 1:3
    Fullspctrm          = [];
    Fullfreq            = [];
    for x               = 1:ntrials
        chantype        = chantypefull{j};
        trialdataset{x}    = ['/FT_spectra/' chantype 'freq_ovlp' num2str(overlap) num2str(nbwin) 'win_' num2str(freqband(1)) '_' num2str(freqband(2)) 'run' num2str(indexrun) 'trial' num2str(x) '.mat'];
        freqpath        = [Dir trialdataset{x}];
        load(freqpath)
        F               = freq{1,1}.powspctrm;
        for y           = 2:length(freq)
            F           = F + freq{1,y}.powspctrm;
        end
        F               = F/length(freq);
        Fullspctrm      = cat(1,Fullspctrm,F);
        Fullfreq        = freq{1,y}.freq;
    end
    Fullspctrm      = Fullspctrm(asc_ord(:,2)',:,:);
    disp(['trials concatenated in Fullspctrm_ovlp' num2str(overlap) num2str(nbwin) 'win_' chantype num2str(indexrun)])
    
    Fullspctrm_path     = [par.ProcDataDir 'FT_spectra/Fullspctrm_ovlp' num2str(overlap) num2str(nbwin) 'win_' chantype num2str(indexrun) '.mat'];
    save(Fullspctrm_path,'Fullspctrm','Fullfreq','asc_ord','-v7.3');

    % then delete all intermediate files
    for x = 1:length(durations)
        delete([Dir trialdataset{x}])
    end
    disp(['intermediates datasets deleted'])
    
end







