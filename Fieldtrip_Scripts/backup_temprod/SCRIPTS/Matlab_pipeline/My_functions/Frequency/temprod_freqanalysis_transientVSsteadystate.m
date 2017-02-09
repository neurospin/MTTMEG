%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function temprod_freqanalysis(index,subject,freqband)

Dir = ['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject];
chantypefull  = {'Mags';'Gradslong';'Gradslat'};

load(fullfile(Dir,['/FT_trials/run' num2str(index) 'trial001.mat']))
ntrials = size(data.sampleinfo,1);

%% sort data by ascending order of trial duration

durations(:,1) = data.sampleinfo(:,2) - data.sampleinfo(:,1);
durations(:,2) = (1:length(durations))';

asc_ord = sortrows(durations);

for N = 1:ntrials
    for j = 1:3
        
        chantype = chantypefull{j};
        %% trial-by-trial fourier analysis %%
        [GradsLong, GradsLat]  = grads_for_layouts;
        if strcmp(chantype,'Mags')     == 1
            channeltype        =  {'MEG*1'};
        elseif strcmp(chantype,'Gradslong') == 1;
            channeltype        =  GradsLong;
        elseif strcmp(chantype,'Gradslat')
            channeltype        =  GradsLat;
        end
        load(fullfile(Dir,['/FT_trials/run' num2str(index) 'trial' num2str(N,'%03i') '.mat']))    
        clear cfg
        
        l                      = length(data.time{1,1});
        begdata.time{1,1}      = data.time{1,1}(1:asc_ord(1,1));
        enddata.time{1,1}      = data.time{1,1}((l - asc_ord(1,1) +1):l);
        begdata.trial{1,1}     = data.trial{1,1}(:,1:asc_ord(1,1));
        enddata.trial{1,1}     = data.trial{1,1}(:,(l - asc_ord(1,1) +1):l);
        begdata.hdr            = data.hdr;
        begdata.fsample        = data.fsample;
        begdata.label          = data.label;
        begdata.sampleinfo     = data.sampleinfo;
        begdata.cfg            = data.cfg;
        enddata.hdr            = data.hdr;
        enddata.fsample        = data.fsample;
        enddata.label          = data.label;
        enddata.sampleinfo     = data.sampleinfo;
        enddata.cfg            = data.cfg;
        
        cfg.channel            = channeltype;
        cfg.method             = 'mtmwelch';
        cfg.output             = 'pow';
        cfg.taper              = 'hanning';
        cfg.foi                = freqband(1):0.1:freqband(2);
        cfg.t_ftimwin          = ones(1,length(cfg.foi))*2;
        cfg.tapsmofrq          = 1;
        cfg.toi                = ones(1,2*length(cfg.foi))*1;
        cfg.trials             = 'all';
        cfg.keeptrials         = 'yes';
        cfg.pad                = asc_ord(1,1)/data.fsample;
        begfreq                = ft_freqanalysis(cfg,begdata);
        endfreq                = ft_freqanalysis(cfg,enddata);        
        clear data 

        %% save data %%
        freqpath               = [par.ProcDataDir 'FT_spectra/' chantype 'freqbegend_' num2str(freqband(1)) '_'...
            num2str(freqband(2)) 'run' num2str(index) 'trial' num2str(N) '.mat'];
        save(freqpath,'begfreq','endfreq','cfg');
        
        clear freq cfg
        
        % print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/OLD/Plots_' subject...
        %     '/trialbytrial_spectra_' chantype '-' num2str(freqband(1)) '-' num2str(freqband(2)) '_'...
        %     num2str(index) 'hz.png']);
        
    end
end

