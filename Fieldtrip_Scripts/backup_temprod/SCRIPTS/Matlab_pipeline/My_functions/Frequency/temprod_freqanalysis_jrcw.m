%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function temprod_freqanalysis_jrcw(index,subject,freqband,tag)

% set root
root = SetPath(tag); 
Dir = [root '/DATA/NEW/processed_' subject];

Dir = [root '/DATA/NEW/processed_' subject];
chantypefull  = {'Mags';'Gradslong';'Gradslat'};

load(fullfile(Dir,['/FT_trials/run_jrcw_' num2str(index) 'trial001.mat']))
ntrials = size(data.sampleinfo,1);

for N = 1:ntrials
    for j = 1:3
        chantype = chantypefull{j};
        
        %% trial-by-trial fourier analysis %%
        [GradsLong, GradsLat]  = grads_for_layouts(tag);
        if strcmp(chantype,'Mags')     == 1
            channeltype        =  {'MEG*1'};
        elseif strcmp(chantype,'Gradslong') == 1;
            channeltype        =  GradsLong;
        elseif strcmp(chantype,'Gradslat')
            channeltype        =  GradsLat;
        end
        load(fullfile(Dir,['/FT_trials/run_jrcw_' num2str(index) 'trial' num2str(N,'%03i') '.mat']))    
        clear cfg
        
        cfg.channel            = channeltype;
        cfg.method             = 'mtmfft';
        cfg.output             = 'pow';
        cfg.taper              = 'hanning';
        cfg.foi                = freqband(1):0.1:freqband(2);
        cfg.t_ftimwin          = ones(1,length(cfg.foi))*2;
        cfg.tapsmofrq          = 0.5;
        cfg.toi                = ones(1,2*length(cfg.foi))*1;
        cfg.trials             = 'all';
        cfg.keeptrials         = 'yes';
        cfg.pad                = MaxLength/data.fsample;
        freq                   = ft_freqanalysis(cfg,data);
        clear data 

        %% save data %%
        freqpath               = [Dir '/FT_spectra/' chantype 'freq_jrcw_' num2str(freqband(1)) '_'...
            num2str(freqband(2)) 'run' num2str(index) 'trial' num2str(N) '.mat'];
        save(freqpath,'freq','cfg');
        
        clear freq cfg
        
        % line noise interpolation
        [freq.freq,freq.powspctrm] = LineNoiseInterp(freq.freq,freq.powspctrm);;
        
        % print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/OLD/Plots_' subject...
        %     '/trialbytrial_spectra_' chantype '-' num2str(freqband(1)) '-' num2str(freqband(2)) '_'...
        %     num2str(index) 'hz.png']);
        
    end
end

