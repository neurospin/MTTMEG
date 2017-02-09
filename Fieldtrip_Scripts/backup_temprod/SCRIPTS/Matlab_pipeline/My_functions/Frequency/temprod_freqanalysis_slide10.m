%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function temprod_freqanalysis(index,subject,freqband)

Dir = ['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject];
chantypefull  = {'Mags';'Gradslong';'Gradslat'};

load(fullfile(Dir,['/FT_trials/run' num2str(index) 'trial001.mat']))
ntrials = size(data.sampleinfo,1);

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
        datasave                   = data;
        timwin                     = []; 
        toi                        = [];
        timwin                     = ((length(data.time{1,1})/data.fsample)/5);
        toi                        = [0.1:0.1:0.9]*(length(data.time{1,1})/data.fsample);
        
        for i = 1:9
            data                   = datasave;
            data.time{1,1}         = data.time{1,1}(round((toi(i)-timwin/2)*data.fsample + 1):round((toi(i)+timwin/2)*data.fsample));
            data.trial{1,1}        = data.trial{1,1}(:,round((toi(i)-timwin/2)*data.fsample + 1):round((toi(i)+timwin/2)*data.fsample));
            cfg.channel            = channeltype;
            cfg.method             = 'mtmfft';
            cfg.output             = 'pow';
            cfg.taper              = 'hanning';
            cfg.foi                = freqband(1):0.1:freqband(2);
            cfg.tapsmofrq          = 1;
            cfg.trials             = 'all';
            cfg.keeptrials         = 'yes';
            cfg.pad                = MaxLength/data.fsample;
            freq{i}                = ft_freqanalysis(cfg,data);
            clear data
        end

        %% save data %%
        freqpath               = [par.ProcDataDir '/FT_spectra/' chantype 'freq_s10_' num2str(freqband(1)) '_'...
        num2str(freqband(2)) 'run' num2str(index) 'trial' num2str(N) '.mat'];
        save(freqpath,'freq','cfg');
        
        clear freq cfg
        
        % print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/OLD/Plots_' subject...
        %     '/trialbytrial_spectra_' chantype '-' num2str(freqband(1)) '-' num2str(freqband(2)) '_'...
        %     num2str(index) 'hz.png']);
        
    end
end

