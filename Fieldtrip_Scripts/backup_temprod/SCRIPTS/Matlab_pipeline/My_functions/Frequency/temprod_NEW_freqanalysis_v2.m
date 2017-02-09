%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function temprod_NEW_freqanalysis_v2(isdetrend,index,subject)

for a = 1:8
    eval(['datapath' num2str(a) '= [''/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_'...
        subject '/run' num2str(a) '.mat'']']);
end

chantypefull  = {'Mags';'Gradslong';'Gradslat'};
par.ProcDataDir        = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];
eval(['load(datapath' num2str(index) ');']);

%% channel by channel welch averaged fourier decompsition
for x = 1:306      
        clear cfg
        cfg.channel            = data.label{x};
        cfg.method             = 'mtmwelch';
        cfg.output             = 'pow';
        cfg.taper              = 'hanning';
        cfg.foi                = 2:0.05:50;
        cfg.t_ftimwin          = ones(1,length(cfg.foi))*1;
%         cfg.tapsmofrq          = ones(1,length(cfg.foi))*1;
%         cfg.toi                = ones(1,2*length(cfg.foi))*0.5;
        cfg.toi                = 0.5:0.5:15;
        cfg.trials             = 'all';
        cfg.keeptrials         = 'yes';
        cfg.keeptapers         = 'no';
        cfg.pad                = 'maxperlen';
        freq                   = ft_freqanalysis(cfg,data);
        %% linear detrending %%
%         if isdetrend == 1
%             for i              = 1:size(freq.powspctrm,1)
%                 freq.powspctrm(i,:,:) = ft_preproc_detrend(squeeze(freq.powspctrm(i,:,:)));
%             end
%         end
        %% save data %%
        freqpath = [par.ProcDataDir 'freq_' data.label{x} '_' num2str(index) '.mat'];
        save(freqpath,'freq','cfg','-v7.3');
        
        clear freq
        
        % print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/OLD/Plots_' subject...
        %     '/trialbytrial_spectra_' chantype '-' num2str(freqband(1)) '-' num2str(freqband(2)) '_'...
        %     num2str(index) 'hz.png']);
        
    end
end
