%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function temprod_freqanalysis_rest_eeg(index,subject,freqband)

Dir = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject];

LS = ls(Dir);
match = strfind(LS,['EEGrun' num2str(index) 'trial']);
for i = 1:length(match)
    num(i) = str2num(LS([match(i)+13 match(i)+14 match(i)+15]));
end

% for i = 1:length(match)
%     num(i) = str2num(LS([match(i)+9 match(i)+10]));
% end

for N = 1:max(num)
    
    %% trial-by-trial fourier analysis %%
    
    load(fullfile(Dir,['EEGrun' num2str(index) 'trial' num2str(N,'%03i') '.mat']))
    clear cfg
    
    tmptrial               = [data.trial{1} zeros(size(data.trial{1},1),ceil(MaxLength-size(data.trial{1},2)))];
    tmpresol               = 1/data.fsample;
    tmptime                = 0:tmpresol:(size(tmptrial,2))*tmpresol;
    data.trial{1}          = tmptrial;
    data.time{1}           = tmptime;
    clear tmptrial tmpresol tmptime
    
    cfg.channel            = 'all';
    cfg.method             = 'mtmfft';
    cfg.output             = 'pow';
    cfg.taper              = 'hanning';
    cfg.foi                = freqband(1):0.1:freqband(2);
    %         cfg.t_ftimwin          = ones(1,length(cfg.foi))*1;
    %         cfg.tapsmofrq          = ones(1,length(cfg.foi))*1;
    %         cfg.toi                = ones(1,2*length(cfg.foi))*0.5;
    cfg.trials             = 'all';
    cfg.keeptrials         = 'yes';
    cfg.keeptapers         = 'no';
    cfg.pad                = 'maxperlen';
    freq                   = ft_freqanalysis(cfg,data);
    clear data
    %% linear detrending %%
    %         if isdetrend == 1
    %             for i              = 1:size(freq.powspctrm,1)
    %                 freq.powspctrm(i,:,:) = ft_preproc_detrend(squeeze(freq.powspctrm(i,:,:)));
    %             end
    %         end
    %% save data %%
    freqpath               = [par.ProcDataDir 'EEGfreq_' num2str(freqband(1)) '_'...
        num2str(freqband(2)) 'run' num2str(index) 'trial' num2str(N) '.mat'];
    save(freqpath,'freq','cfg');
    
    clear freq cfg
    
    % print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/OLD/Plots_' subject...
    %     '/trialbytrial_spectra_' chantype '-' num2str(freqband(1)) '-' num2str(freqband(2)) '_'...
    %     num2str(index) 'hz.png']);
    
end


for N = 1:max(num)
    trialdataset{N} = [Dir 'EEGrun' num2str(index) 'trial' num2str(N,'%03i') '.mat'];
end

% delete trial
for y = 1:max(num)
    delete([trialdataset{y}])
end
disp(['intermediates trial datasets deleted'])

