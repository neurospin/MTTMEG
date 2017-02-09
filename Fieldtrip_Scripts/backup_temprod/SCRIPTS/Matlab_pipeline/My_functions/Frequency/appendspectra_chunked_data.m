function appendspectra_chunked_data(index,subject,part)

par.ProcDataDir         = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];
range = 1:0.5:46;
for a = 1:length(range)
    freqbandfull{a} = [(range(a)+3) (range(a)+3.5)];
end

%% sort data by ascending order of trial duration
load([par.ProcDataDir 'run' num2str(index) '_' part '.mat']);

eval(['data = data_' part]);
clear data_part1 data_part2 data_part3

for i = 1:size(data.time,2)
    trialduration(1,i) = length(data.time{i});
    trialduration(2,i) = i;
end
asc_ord = sortrows(trialduration');
chantypefull            = {'Mags';'Gradslong';'Gradslat'};

par.ProcDataDir         = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];
%% concatenate data
for j = 1:3
    Fullspctrm          = [];
    Fullfreq            = [];
    for x               = 1:length(freqbandfull)
        freqband        = freqbandfull{x};
        chantype        = chantypefull{j};
        freqpath        = [par.ProcDataDir chantype 'freq_' num2str(freqband(1)) '_' num2str(freqband(2)) '_' num2str(index) '_' part '.mat'];
        load(freqpath)
        Fullspctrm      = cat(3,Fullspctrm,freq.powspctrm(:,:,:));
        Fullfreq        = [Fullfreq freq.freq];
    end
    Fullspctrm      = Fullspctrm(asc_ord(:,2)',:,:);
    %% remove redundant points
    [Fullfreq_u,I,J] = unique(Fullfreq);
    for x               = 1:size(Fullspctrm,1)
        for y           = 1:size(Fullspctrm,2)
            Fullspctrm_u(x,y,:) = Fullspctrm(x,y,I);
        end
    end
    clear Fullspctrm Fullfreq
    Fullspctrm = Fullspctrm_u;
    Fullfreq   = Fullfreq_u;
    
    Fullspctrm_path     = [par.ProcDataDir 'Fullspctrm_' chantype num2str(index) '_' part '.mat'];
    save(Fullspctrm_path,'Fullspctrm','Fullfreq','-v7.3');
    
end

