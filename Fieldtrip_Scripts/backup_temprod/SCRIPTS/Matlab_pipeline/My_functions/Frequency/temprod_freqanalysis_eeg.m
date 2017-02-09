%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function temprod_freqanalysis_eeg(isdetrend,index,subject,freqband)

Dir = ['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject];
chantypefull  = {'Mags';'Gradslong';'Gradslat'};

durinfopath = [Dir '/FT_trials/EEGrun' num2str(index) 'durinfo.mat'];
load(durinfopath)
duration(:,1) = info(:,2) - info(:,1);
duration(:,2) = (1:length(duration))';

for N = 1:length(duration)

        
        %% trial-by-trial fourier analysis %%

        load(fullfile(Dir,['/FT_trials/EEGrun' num2str(index) 'trial' num2str(N,'%03i') '.mat']))    
        clear cfg
        
%         tmptrial               = [data.trial{1} zeros(size(data.trial{1},1),ceil(MaxLength-size(data.trial{1},2)))]; 
%         tmpresol               = 1/data.fsample;
%         tmptime                = 0:tmpresol:(size(tmptrial,2))*tmpresol;
%         data.trial{1}          = tmptrial;
%         data.time{1}           = tmptime;
%         clear tmptrial tmpresol tmptime
        
%         cfg.baseline           = [data.time{1,1}(1) data.time{1,1}(end)];
%         cfg.channel            = 'all';
%         data                   = ft_timelockbaseline(cfg, data);

        cfg.channel            = 'all';
        cfg.method             = 'mtmfft';
        cfg.output             = 'pow';
        cfg.taper              = 'dpss';
        cfg.foi                = freqband(1):0.1:freqband(2);
%         cfg.t_ftimwin          = ones(1,length(cfg.foi))*2;
        cfg.tapsmofrq          = 1;
%         cfg.toi                = ones(1,2*length(cfg.foi))*1;
        cfg.trials             = 'all';
        cfg.keeptrials         = 'yes';
        cfg.pad                = MaxLength/data.fsample;
%         cfg.polyremoval        = 0;
        freq                   = ft_freqanalysis(cfg,data);
        
%         indexnorm                  = length(data.time{1,1})/MaxLength;
%         
%         freq.powspctrm         = freq.powspctrm*indexnorm ;
        
        clear data 
        %% linear detrending %%
%         if isdetrend == 1
%             for i              = 1:size(freq.powspctrm,1)
%                 freq.powspctrm(i,:,:) = ft_preproc_detrend(squeeze(freq.powspctrm(i,:,:)));
%             end
%         end
        %% save data %%
        freqpath               = [Dir '/FT_spectra/EEGfreq_' num2str(freqband(1)) '_'...
            num2str(freqband(2)) 'run' num2str(index) 'trial' num2str(N) '.mat'];
        save(freqpath,'freq','cfg');
        
        clear freq cfg
        
        % print('-dpng',['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/OLD/Plots_' subject...
        %     '/trialbytrial_spectra_' chantype '-' num2str(freqband(1)) '-' num2str(freqband(2)) '_'...
        %     num2str(index) 'hz.png']);
end

