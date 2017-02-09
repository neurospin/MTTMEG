%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function temprod_TF_freqanalysis(index,subject,freqband)

Dir = ['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject];
chantypefull  = {'Mags';'Gradslong';'Gradslat'};

load(fullfile(Dir,['/FT_trials/runforTF' num2str(index) 'trial001.mat']))
ntrials = size(data.sampleinfo,1);

dur = data.sampleinfo(:,2) - data.sampleinfo(:,1);
asc_ord = sortrows([dur (1:length(data.sampleinfo))']);

for j = 1:3
    chantype = chantypefull{j};
    tmp = 1;
    for N = (asc_ord(:,2))'
        
        
        %% trial-by-trial fourier analysis %%
        [GradsLong, GradsLat]  = grads_for_layouts;
        if strcmp(chantype,'Mags')     == 1
            channeltype        =  {'MEG*1'};
        elseif strcmp(chantype,'Gradslong') == 1;
            channeltype        =  GradsLong;
        elseif strcmp(chantype,'Gradslat')
            channeltype        =  GradsLat;
        end
        load(fullfile(Dir,['/FT_trials/runforTF' num2str(index) 'trial' num2str(N,'%03i') '.mat']));
        
        clear cfg
        cfg.channel            = channeltype;
        cfg.method             = 'wavelet';
        cfg.output             = 'pow';
        cfg.foi                = freqband(1):0.2:freqband(2);
        cfg.toi                = 0:0.02:(data.time{1,1}(end));
        cfg.trials             = 'all';
        cfg.keeptrials         = 'yes';
        cfg.width              = 7;
        cfg.gwidth             = 3;
        freq                   = ft_freqanalysis(cfg,data);
        
        FullFTspctrm{1,tmp}      = freq;
        tmp = tmp + 1;
        clear freq cfg
    end
    
    %% save data %%
    freqpath               = [Dir '/FT_TFwavelet/' chantype 'freq_allrun' num2str(index) '.mat'];
    save('-v7.3',freqpath,'FullFTspctrm')
end

