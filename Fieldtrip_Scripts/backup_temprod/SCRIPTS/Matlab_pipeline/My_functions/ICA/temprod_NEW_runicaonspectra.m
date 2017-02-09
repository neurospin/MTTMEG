function temprod_NEW_runicaonspectra(index,subject,freqband,K,method)

par.ProcDataDir         = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];
[label2,label3,label1]     = grads_for_layouts;
chan_index  = {'Mags';'Gradslong';'Gradslat'};

F                       = [];
for k = 1:3
    Fullspctrm          = [];
    Fullfreq            = [];
    chantype            = chan_index{k};
    Fullspctrm_path     = [par.ProcDataDir 'Fullspctrm_' chantype num2str(index) '.mat'];
    load(Fullspctrm_path);
    fbegin              = find(Fullfreq >= freqband(1));
    fend                = find(Fullfreq <= freqband(2));
    fband               = fbegin(1):fend(end);
    F = cat(2,Fullspctrm,F);
end
    Fullspctrm = F;  

    % inform fieldtrip structure as if it was timeseries
    freq.dimord            = 'rpt_chan_time';
%     eval(['data.label      = label' num2str(k) ''';']);
%     eval(['data.cfg.channel = label' num2str(k) ''';']);
    data.label             = [label1 label2 label3]';
    data.cfg.channel       = [label1 label2 label3]';
    for i = 1:size(Fullspctrm,1)
        data.time{1,i}     = Fullfreq;
        data.trial{1,i}    = squeeze(Fullspctrm(i,:,:))*10^30;
    end
    data.hdr.nTrial        = size(Fullspctrm,1);
    % compute ICA on spectra
    cfg.method            = method;
    cfg.channel           = 'all';
    cfg.trials            = 'all';
    cfg.numcomponent      = 20;
    cfg.demean            = 'yes';
    cfg.blc               = 'yes';
    comp                  = ft_componentanalysis(cfg,data);
    
    %     comppath              = [par.ProcDataDir 'compspec_' num2str(chan_index{k}) num2str(index) '.mat'];
    %     save(comppath,'comp','cfg','-v7.3');
    
    %% specifiy layout for plotting topographies
    clear cfg
    cfg.channel           = data.label;
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
    lay.label             = data.label;
    cfg.layout            = lay;
    
    %% plot the 20 first components topographies
    fig = figure('position',[1 1 1280 1024]);
    for i = 1:20
        mysubplot(7,9,(i*3)-2)
        cfg.comment = ['comp ' num2str(i)];
        topoplot(cfg,abs(comp.topo(1:102,i)))
    end
    
    %     print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
    %     '/icacompspec' num2str(chan_index{k}) num2str(index) '.png']);
    
    %% get component timecourses
    clear cfg
    cfg.method        = method;
    cfg.numcomponent  = 20;
    cfg.channel       = data.label;
    cfg.topolabel     = comp.topolabel;
    cfg.top           = comp.topo;
    comp_timecourse   = ft_componentanalysis(cfg, data);
    
    M = [];
    for a = 1:20
        for i = 1:length(comp_timecourse.trial)
            M(i,:) = comp_timecourse.trial{1,i}(a,fband);
%             M(i,:) = comp_timecourse.trial{1,i}(a,:);
        end
        [blah1, blah2, blah3, blah4, s] = mysubplot(7,9,(a*3));
        for x = 1:size(M,2)
            M(:,x) = conv(M(:,x),K,'same');
        end
        imagesc(zscore(M,0,2));
%         set(s,'XTick',1:round(size(M,2)/3):size(M,2),'XTickLabel',Fullfreq(fband(1)):round(length(fband)/3):Fullfreq(fband(end)));
    end
    
    M = [];
    for a = 1:20
        for i = 1:length(comp_timecourse.trial)
            M(i,:) = comp_timecourse.trial{1,i}(a,fband);
%             M(i,:) = comp_timecourse.trial{1,i}(a,:);
        end
        [blah1, blah2, blah3, blah4, s] = mysubplot(7,9,(a*3)-1)
        for x = 1:size(M,2)
            M(:,x) = conv(M(:,x),K,'same');
        end
        imagesc(M)
%         set(s,'XTick',1:round(size(M,2)/3):size(M,2),'XTickLabel',Fullfreq(fband(1)):round(length(fband)/3):Fullfreq(fband(end)));
    end
    
    %     comp_timecourse_path  = [par.ProcDataDir 'comp_timecourse_' num2str(chan_index{k}) num2str(index) '.mat'];
    %     save(comp_timecourse_path,'compspec_freqcourse','cfg','-v7.3');
end

