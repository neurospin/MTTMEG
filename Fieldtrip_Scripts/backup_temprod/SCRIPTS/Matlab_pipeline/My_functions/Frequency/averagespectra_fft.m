%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function averagespectra_fft(indexrun,subject,freqband,numtrial)

Dir = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];
chantypefull  = {'Mags';'Gradslong';'Gradslat'};

%% concatenate data
for j = 1:3
    Fullspctrm          = [];
    Fullfreq            = [];
    for x               = 1:numtrial
        if isempty(Fullspctrm) == 1
            chantype        = chantypefull{j};
            trialdataset{x}    = [chantype 'fftfreq_' num2str(freqband(1)) '_' num2str(freqband(2)) 'run' num2str(indexrun) 'trial' num2str(x) '.mat'];
            freqpath        = [Dir trialdataset{x}];
            load(freqpath)
            S = size(squeeze(freq.powspctrm));
            Fullspctrm = zeros(S(1),S(2));
        end
        chantype        = chantypefull{j};
        trialdataset{x}    = [chantype 'fftfreq_' num2str(freqband(1)) '_' num2str(freqband(2)) 'run' num2str(indexrun) 'trial' num2str(x) '.mat'];
        freqpath        = [Dir trialdataset{x}];
        load(freqpath)
        Fullspctrm = Fullspctrm + squeeze(freq.powspctrm);
    end
    Fullspctrm = Fullspctrm/numtrial;
    Fullfreq = freq.freq;
    Fullspctrm_path     = [Dir 'FullspctrmFFT_' chantype num2str(indexrun) '.mat'];
    save(Fullspctrm_path,'Fullspctrm','Fullfreq');
    
        % then delete all intermediate files
    for x = 1:numtrial
        delete([Dir trialdataset{x}])
    end
    disp('intermediates datasets deleted');
    
end