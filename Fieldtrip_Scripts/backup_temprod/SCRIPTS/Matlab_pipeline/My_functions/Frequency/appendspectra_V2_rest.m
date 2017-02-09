function appendspectra_V2_rest(indexrun,subject,freqband)

Dir = ['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject];
chantypefull  = {'Mags';'Gradslong';'Gradslat'};

load(fullfile(Dir,['/FT_trials/run' num2str(indexrun) 'trial001.mat']))
ntrials = size(data.sampleinfo,1);

%% sort data by ascending order of trial duration

durations(:,1) = data.sampleinfo(:,2) - data.sampleinfo(:,1);
durations(:,2) = (1:length(durations))';

asc_ord = sortrows(durations);
chantypefull            = {'Mags';'Gradslong';'Gradslat'};

par.ProcDataDir         = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];
%% concatenate data
for j = 1:3
    Fullspctrm          = [];
    Fullfreq            = [];
    for x               = 1:ntrials
        chantype        = chantypefull{j};
        trialdataset{x}    = ['/FT_spectra/' chantype 'freqrest_' num2str(freqband(1)) '_' num2str(freqband(2)) 'run' num2str(indexrun) 'trial' num2str(x) '.mat'];
        freqpath        = [Dir trialdataset{x}];
        load(freqpath)
        Fullspctrm      = cat(3,Fullspctrm,freqrest.powspctrm(:,:,:));
        Fullfreq        = freqrest.freq;
    end
    Fullspctrm = permute(Fullspctrm,[3 1 2 ]);
    Fullspctrm      = Fullspctrm(asc_ord(:,2)',:,:);
    disp(['trials concatenated in FullspctrmV2rest_' chantype num2str(indexrun)])
    
    Fullspctrm_path     = [par.ProcDataDir 'FT_spectra/FullspctrmV2rest_' chantype num2str(indexrun) '.mat'];
    save(Fullspctrm_path,'Fullspctrm','Fullfreq','asc_ord','-v7.3');

    % then delete all intermediate files
    for x = 1:length(durations)
        delete([Dir trialdataset{x}])
    end
    disp(['intermediates datasets deleted'])
    
end







