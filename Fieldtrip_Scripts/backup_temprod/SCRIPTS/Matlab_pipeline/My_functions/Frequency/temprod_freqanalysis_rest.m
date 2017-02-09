%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function temprod_freqanalysis_rest(index,subject,freqband)

Dir = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject];
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
        load(fullfile(Dir,['/FT_trials/runrest' num2str(index) 'trial' num2str(N,'%03i') '.mat']))    
        clear cfg
        
        cfg.channel            = channeltype;
        cfg.method             = 'mtmfft';
        cfg.output             = 'pow';
        cfg.taper              = 'dpss';
        cfg.foi                = freqband(1):0.1:freqband(2);
%         cfg.t_ftimwin          = ones(1,length(cfg.foi))*2;
        cfg.tapsmofrq          = 2;
%         cfg.toi                = ones(1,2*length(cfg.foi))*1;
        cfg.trials             = 'all';
        cfg.keeptrials         = 'no';
        cfg.pad                = MaxLength/datarestsave.fsample;
        freqrest               = ft_freqanalysis(cfg,datarestsave);
        clear datarestsave 
        
        %% save data %%
        freqrestpath           = [Dir '/FT_spectra/' chantype 'freqrest_' num2str(freqband(1)) '_'...
            num2str(freqband(2)) 'run' num2str(index) 'trial' num2str(N) '.mat'];
        save(freqrestpath,'freqrest','cfg');
        
        clear freq cfg
        
    end
end

