function temprod_NEW_runica(subject,index)

datapath = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_'...
            subject '/run' num2str(index) '.mat'];
load(datapath)

%% remove eog label and timecourses
data.label([307;308]) = [];
for i = 1:length(data.trial)
    data.trial{1,i}(307:308,:) = []; 
end

%% rescale data matrix to avoid error in fastica
for i = 1:length(data.trial)
    data.trial{1,i} = data.trial{1,i}*10^11; 
end

%% perform fast ica, get 20 components
[Gradslong, Gradslat] = grads_for_layouts;
channeltype = {'MEG*1';Gradslong;Gradslat};
chan_index  = {'Mags';'Gradslong';'Gradslat'};

for k = 1:3
    cfg.method            = 'fastica';
    cfg.channel           = channeltype{k};
    cfg.trials            = 'all';
    cfg.numcomponent      = 20;
    cfg.blc               = 'yes';
    comp                  = ft_componentanalysis(cfg, data);

    comppath               = [par.ProcDataDir 'comp_' num2str(chan_index{k}) num2str(index) '.mat'];
    save(comppath,'comp','cfg','-v7.3');
    
    %% specifiy layout for plotting topographies
    clear cfg
    cfg.channel           = channeltype{k};
    cfg.xparam            = 'time';
    cfg.zparam            = 'avg';
    cfg.baseline          = 'no';
    cfg.trials            = 'all';
    cfg.colormap          = jet;
    cfg.marker            = 'off';
    cfg.markersymbol      = 'o';
    cfg.markercolor       = [0 0 0];
    cfg.markersize        = 2;
    cfg.markerfontsize    = 8;
    cfg.colorbar          = 'no';
    cfg.interplimits      = 'head';
    cfg.interpolation     = 'v4';
    cfg.style             = 'straight';
    cfg.gridscale         = 67;
    cfg.shading           = 'flat';
    cfg.interactive       = 'yes';
    cfg.layout            = '/neurospin/meg_tmp/ResonanceMeg_Baptiste_2009/SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
    lay                   = ft_prepare_layout(cfg,comp);
    lay.label             = Gradslong;
    cfg.layout            = lay;

    %% plot the 20 first components topographies
    fig = figure('position',[1 1 1280 1024]);
    for i = 1:67
        mysubplot(11,10,i)
        cfg.comment = ['comp ' num2str(i)];
        topoplot(cfg,abs(comp.topo(1:102,i)))
    end
    
    print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
    '/ica20comp' num2str(chan_index{k}) num2str(index) '.png']); 
    
    %% get component timecourses
    clear cfg
    cfg.method        = 'fastica';
    cfg.channel       = channeltype{k};
    cfg.topolabel     = comp.topolabel;
    cfg.top           = comp.topo;
    comp_timecourse   = ft_componentanalysis(cfg, data);

    comp_timecourse_path  = [par.ProcDataDir 'comp_timecourse_' num2str(chan_index{k}) num2str(index) '.mat'];
    save(comp_timecourse_path,'comp_timecourse','cfg','-v7.3');
end
    
%     %% compute fft on components timecourses
%     
%     %% plot mean ica components spectra
%     clear cfg
%     cfg.channel            = 'all';
%     cfg.method             = 'mtmfft';
%     cfg.output             = 'pow';
%     cfg.taper              = 'hanning';
%     cfg.foilim             = [1 50];
%     foi                    = cfg.foilim;
%     cfg.pad                = 'maxperlen';
%     cfg.trials             = 'all';
%     cfg.keeptrials         = 'no';
%     cfg.keeptapers         = 'no';
%     comp_spectra           = ft_freqanalysis(cfg,comp_timecourse);
% 
%     
%     fig = figure('position',[1 1 1280 1024]);
%     for i = 1:size(comp_spectra.powspctrm,1)
%         mysubplot(8,8,i)
%     %     plot(squeeze(comp_spectra.powspctrm(1:size(comp_spectra.powspctrm,1),i,:)));
%         plot(squeeze(comp_spectra.powspctrm(i,:)));
%         axis([0 max(length(comp_spectra.freq))  0 mean(max(max(comp_spectra.powspctrm(:,:))))]);
%     end
%     
%     print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
%     '/ica20compmeanspectra' num2str(chan_index{k}) num2str(index) '.png']); 
%     
%     fig = figure('position',[1 1 1280 1024]);
%     imagesc(log(comp_spectra.powspctrm))
%     
%     print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
%     '/ica20compmeanspectra2' num2str(chan_index{k}) num2str(index) '.png']); 
%     
%     %% plot trial-by-trial ica components spectra
%     clear cfg
%     cfg.channel            = 'all';
%     cfg.method             = 'mtmfft';
%     cfg.output             = 'pow';
%     cfg.taper              = 'hanning';
%     cfg.foilim             = [1 200];
%     foi                    = cfg.foilim;
%     cfg.pad                = 'maxperlen';
%     cfg.trials             = 'all';
%     cfg.keeptrials         = 'yes';
%     cfg.keeptapers         = 'yes';
%     comp_spectra           = ft_freqanalysis(cfg,comp_timecourse);
% 
%     comp_spectra_path  = [par.ProcDataDir 'comp_spectra_' num2str(chan_index{k}) num2str(index) '.mat'];
%     save(comp_spectra_path,'comp_spectra','cfg','-v7.3');
% 
%     fig = figure('position',[1 1 1280 1024]);
%     for i = 1:size(comp_spectra.powspctrm,2)
%         mysubplot(8,8,i)
%         imagesc(log(squeeze(comp_spectra.powspctrm(:,i,:))));
%     end
% 
%     print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
%     '/ica20comptrialbytrialspectra' num2str(chan_index{k}) num2str(index) '.png']); 
%     
% %     fig = figure('position',[1 1 1280 1024]);
% %     for i = 1:size(comp_spectra.powspctrm,2)
% %         mysubplot(8,8,i)
% %     %     plot(squeeze(comp_spectra.powspctrm(1:size(comp_spectra.powspctrm,1),i,:)));
% %         plot(squeeze(mean((comp_spectra.powspctrm(1:size(comp_spectra.powspctrm,1),i,:)))));
% %     %     axis([0 max(length(comp_spectra.freq))  0 mean(max(max(comp_spectra.powspctrm(:,:,:))))]);
% %     end
%     
% end
% 
% 
% 
% 
