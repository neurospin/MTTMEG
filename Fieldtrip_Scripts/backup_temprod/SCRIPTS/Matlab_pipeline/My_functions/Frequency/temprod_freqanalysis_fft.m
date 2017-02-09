%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function temprod_freqanalysis_fft(isdetrend,index,subject,freqband)

Dir = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject];
chantypefull  = {'Mags';'Gradslong';'Gradslat'};

LS = ls(Dir);
match = strfind(LS,['run' num2str(index) 'trial']);
for i = 1:length(match)
    num(i) = str2num(LS([match(i)+10 match(i)+11 match(i)+12]));
end

% for i = 1:length(match)
%     num(i) = str2num(LS([match(i)+9 match(i)+10]));
% end

for N = 1:max(num)
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
        load(fullfile(Dir,['forfft_run' num2str(index) 'trial' num2str(N,'%03i') '.mat']))    
        clear cfg
        
        tmptrial               = [data.trial{1} zeros(size(data.trial{1},1),ceil(MaxLength-size(data.trial{1},2)))]; 
        tmpresol               = 1/data.fsample;
        tmptime                = 0:tmpresol:(size(tmptrial,2))*tmpresol;
        data.trial{1}          = tmptrial;
        data.time{1}           = tmptime;
        clear tmptrial tmpresol tmptime
        
        cfg.channel            = channeltype;
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
        freqpath               = [par.ProcDataDir chantype 'fftfreq_' num2str(freqband(1)) '_'...
            num2str(freqband(2)) 'run' num2str(index) 'trial' num2str(N) '.mat'];
        save(freqpath,'freq','cfg');
        
        clear freq cfg
        
        % print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/OLD/Plots_' subject...
        %     '/trialbytrial_spectra_' chantype '-' num2str(freqband(1)) '-' num2str(freqband(2)) '_'...
        %     num2str(index) 'hz.png']);
        
    end
end

