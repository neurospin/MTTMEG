%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function temprod_OLD_ICAcomp_freqanalysis(isdetrend,index,subject)

par.ProcDataDir        = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/OLD/processed_' subject '/'];

chantypefull  = {'Mags';'Gradslong';'Gradlat'};
for b = 1:3
    for a = 1:6
        eval(['datapath{' num2str(a) ',' num2str(b) '}= [''/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/OLD/processed_'...
            subject '/comp_' chantypefull{b} num2str(index) '.mat'']']);
    end
end

% freqbandfull  = {[4 5];[5 6];[6 7];[7 8];[8 9];[9 10];[10 11];[11 12];[12 13];[13 14];[14 15]...
%     ;[15 16];[16 17];[17 18];[18 19];[19 20];[20 21];[21 22];[22 23];[23 24];[24 25];[25 26];[26 27]...
%     ;[27 28];[28 29];[29 30];[30 31];[31 32];[32 33];[33 34];[34 35];[35 36];[36 37];[37 38];[38 39]...
%     ;[39 40];[40 41];[41 42];[42 43];[43 44];[44 45];[45 46];[46 47];[47 48];[48 49]};
freqbandfull  = {[4 6];[6 8];[8 10];[10 12];[12 14];[14 16];[16 18];[18 20];[20 22];[22 24];[24 26]...
    ;[26 28];[28 30];[30 32];[32 34];[34 36];[36 38];[38 40];[40 42];[42 44];[44 46];[46 48];[48 50]};


for x = 1:length(freqbandfull)
    for j = 1:3
        freqband = freqbandfull{x};
        chantype = chantypefull{j};
        
        %% trial-by-trial fourier analysis %%
        load(datapath{index,j})
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
        cfg.taper              = 'dpss';
        cfg.foi                = freqband(1):0.1:(freqband(2) - 0.2);
        cfg.t_ftimwin          = ones(1,length(cfg.foi))*1;
        cfg.tapsmofrq          = ones(1,length(cfg.foi))*1;
        cfg.toi                = ones(1,2*length(cfg.foi))*0.5;
        cfg.trials             = 'all';
        cfg.keeptrials         = 'yes';
        cfg.keeptapers         = 'no';
        cfg.pad                = 'maxperlen';
        freq                   = ft_freqanalysis(cfg,comp);
        %% linear detrending %%
        if isdetrend == 1
            for i              = 1:size(freq.powspctrm,1)
                freq.powspctrm(i,:,:) = ft_preproc_detrend(squeeze(freq.powspctrm(i,:,:)));
            end
        end
        %% plot trial by trial fourrier spectra %%
        % for i = 1:size(freq.powspctrm,1)
        %     mysubplot(8,8,i)
        %     plot(mean(squeeze(freq.powspctrm(i,1:306,:))));
        % end
        %% find peak power and corresponding frequency %%
        Sample                 = [];
        for i                  = 1:length(comp.time)
            Sample             = [Sample ; length(comp.time{i})];
        end
        Freq                   = freq.freq;
        Fsample                = comp.fsample;
        dur                    = Sample/Fsample;
        % fig = figure('position',[1 1 1280 1024]);
        for k                  = 1:length(Sample)
            hold on
            mysubplot(10,10,k)
            pmax(k)            = max(mean(squeeze(freq.powspctrm(k,:,:))));
            pmin(k)            = min(mean(squeeze(freq.powspctrm(k,:,:))));
            Pmean              = mean(squeeze(freq.powspctrm(k,:,:)));
            plot(freq.freq,Pmean);
            Peak(k)            = find(Pmean == pmax(k));
        end
        FPeak                  = Freq(Peak);
        %% save data %%
        freqpath               = [par.ProcDataDir chantype 'freqICAcomp_' num2str(freqband(1)) '_'...
            num2str(freqband(2)) '_' num2str(index) '.mat'];
        save(freqpath,'freq','cfg','-v7.3');
        
        clear comp
        clear freq
        
        % print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/OLD/Plots_' subject...
        %     '/trialbytrial_spectra_' chantype '-' num2str(freqband(1)) '-' num2str(freqband(2)) '_'...
        %     num2str(index) 'hz.png']);
        
    end
end
