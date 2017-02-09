%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function temprod_NEW_ICAcomp_freqanalysis(isdetrend,index,subject)

par.ProcDataDir        = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];

chantypefull  = {'Mags';'Gradslong';'Gradslat'};
for b = 1:3
    for a = 1:6
        eval(['datapath{' num2str(a) ',' num2str(b) '}= [''/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_'...
            subject '/comp_timecourse_' chantypefull{b} num2str(index) '.mat'']']);
    end
end

range = 1:0.5:46;
for a = 1:length(range)
    freqbandfull{a} = [(range(a)+3) (range(a)+3.4)];
end

for j = 1:3
    load(datapath{index,j})
    for x = 1:length(freqbandfull)
        freqband = freqbandfull{x};
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
        clear cfg
        cfg.channel            = 'all';
        cfg.method             = 'mtmwelch';
        cfg.output             = 'pow';
        cfg.taper              = 'hanning';
        cfg.foi                = freqband(1):0.1:freqband(2);
        cfg.t_ftimwin          = ones(1,length(cfg.foi))*1;
        cfg.tapsmofrq          = ones(1,length(cfg.foi))*1;
        cfg.toi                = ones(1,2*length(cfg.foi))*0.5;
        cfg.trials             = 'all';
        cfg.keeptrials         = 'yes';
        cfg.keeptapers         = 'no';
        cfg.pad                = 'maxperlen';
        freq                   = ft_freqanalysis(cfg,comp_timecourse);

        %% save data %%
        freqpath               = [par.ProcDataDir chantype 'freqICAcomp_' num2str(freqband(1)) '_'...
            num2str(freqband(2)) '_' num2str(index) '.mat'];
        save(freqpath,'freq','cfg','-v7.3');
        
        clear freq
        
        % print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/OLD/Plots_' subject...
        %     '/trialbytrial_spectra_' chantype '-' num2str(freqband(1)) '-' num2str(freqband(2)) '_'...
        %     num2str(index) 'hz.png']);
        
    end
end
