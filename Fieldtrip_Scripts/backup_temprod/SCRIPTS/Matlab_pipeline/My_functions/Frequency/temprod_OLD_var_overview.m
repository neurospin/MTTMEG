function temprod_OLD_var_overview(subject,freqband)

fig = figure('position',[1 1 1280 1024]);

for a = 1:6
    eval(['datapath' num2str(a) '= [''/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/OLD/processed_'...
        subject '/run' num2str(a) '.mat'']']);
end

for k = 1:6
    eval(['load(datapath' num2str(k) ');']);
    
    %% average fourier analysis %%
    clear cfg
    cfg.channel            = {'MEG'};
    cfg.method             = 'mtmfft';
    cfg.output             = 'pow';
    cfg.taper              = 'hanning';
    cfg.foilim             = freqband;
    foi                    = cfg.foilim;
    cfg.tapsmofrq          = 0.5;
    cfg.pad                = 'maxperlen';
    cfg.trials             = 'all';
    cfg.keeptrials         = 'yes';
    cfg.keeptapers         = 'yes';
    freq                   = ft_freqanalysis(cfg,data);
    
    %% plot log-GFP power on all channels average on all trials

    for a                  = 1:size(freq.powspctrm,2)
        for b              = 1:size(freq.powspctrm,3)
            Pstd(a,b)      = std(freq.powspctrm(:,a,b));
        end
    end
    
    l = [1:(length(freq.freq))/5:length(freq.freq) length(freq.freq)] ; l = round(l);
    
    subplot(3,6,k);
    imagesc(log(Pstd(1:3:306,:)));
%     set(sub1, 'XTick',l,'XTickLabel',freq.freq(l))
%     colorbar
    subplot(3,6,k+6);
    imagesc(log(Pstd(2:3:306,:)));
%     set(sub2, 'XTick',l,'XTickLabel',freq.freq(l))
%     colorbar
    subplot(3,6,k+12);
    imagesc(log(Pstd(3:3:306,:)));
%     set(sub3, 'XTick',l,'XTickLabel',freq.freq(l))
%     colorbar
end