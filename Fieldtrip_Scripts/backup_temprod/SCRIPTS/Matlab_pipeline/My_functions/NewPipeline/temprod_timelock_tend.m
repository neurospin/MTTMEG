function temprod_timelock_tend(Indexes,Subject,Targets)

% set paths
root = SetPath('Laptop');
Dir = [root '/DATA/NEW/processed_' Subject];

% for one subject, analyze separately for each condition available
TargetValues = unique(Targets);
for t = 1:length(TargetValues)
    Cond{t} = find(Targets == TargetValues(t));
end

% set channels identity and label list
Chantype = {'Grads1','Grads2','Mags'};
[label1,label2,label3] = grads_for_layouts('Laptop');

% analyze ERFs for terciles of the duration distribution
for i = 1:length(Indexes)
    for j = 1:3
        data = load(fullfile(Dir,['/FT_trials/BLOCKTRIALS_FOR_ERFt0_' Chantype{j} '_RUN0' num2str(Indexes(i)) '.mat']));
        
        cfg.minlength          = 2.5;
        data                   = ft_redefinetrial(cfg, data);
        
        for k = 1:length(data.trial)
            len = [];
            len = length(data.time{1,k});
            data.time{1,k} = -4.5:0.004:+0.5;
            data.trial{i,k} = data.trial{i,k}(:,((len - 5*data.fsample):end));
        end
    
        % separate dataset corresponding to Duration terciles
        Durations{i,j} = (data.sampleinfo(:,2) - data.sampleinfo(:,1))./data.fsample;
        Terciles{i,j} = quantile(Durations{i,j},2);
        T1 = find(Durations{i,j} <= Terciles{i,j}(1));
        T3 = find(Durations{i,j} >= Terciles{i,j}(2));
        T2 = (setxor([T1; T3]',1:length(Durations{i,j})))';
        
        data1.cfg = data.cfg; data1.fsample = data.fsample; data1.hdr = data.hdr; data1.label = data.label; data1.label = data.label;
        data2.cfg = data.cfg; data2.fsample = data.fsample; data2.hdr = data.hdr; data2.label = data.label; data2.label = data.label;
        data3.cfg = data.cfg; data3.fsample = data.fsample; data3.hdr = data.hdr; data3.label = data.label; data3.label = data.label;
        data1.time = data.time(T1); data1.trial = data.trial(T1); data1.sampleinfo = data.sampleinfo(T1);
        data2.time = data.time(T2); data2.trial = data.trial(T2); data2.sampleinfo = data.sampleinfo(T2);
        data3.time = data.time(T3); data3.trial = data.trial(T3); data3.sampleinfo = data.sampleinfo(T3);       
        
%         filter out aplha pulses
        for k = 1:length(data1.trial)
            data1.trial{k} = ft_preproc_bandstopfilter(data1.trial{k}, data1.fsample, [8 12], 4, 'but', 'twopass');
        end
        for k = 1:length(data2.trial)
            data2.trial{k} = ft_preproc_bandstopfilter(data2.trial{k}, data2.fsample, [8 12], 4, 'but', 'twopass');
        end
        for k = 1:length(data3.trial)
            data3.trial{k} = ft_preproc_bandstopfilter(data3.trial{k}, data3.fsample, [8 12], 4, 'but', 'twopass');
        end
        
        eval(['cfg.channel     = label' num2str(j)]);
        cfg                    = [];
        cfg.trials             = 'all';
        cfg.covariance         = 'no';
        cfg.keeptrials         = 'no';
        cfg.removemean         = 'yes';
        cfg.vartrllength       = 2;
        Evoked1                = ft_timelockanalysis(cfg,data1);
        Evoked2                = ft_timelockanalysis(cfg,data2);
        Evoked3                = ft_timelockanalysis(cfg,data3);
        
        cfg                    = [];
        cfg.baseline           = [0 +0.5];
        cfg.channel            = 'all';
        cfg.parameter          = 'avg';
        Evoked1                = ft_timelockbaseline(cfg, Evoked1);
        Evoked2                = ft_timelockbaseline(cfg, Evoked2);
        Evoked3                = ft_timelockbaseline(cfg, Evoked3);
        
        ERFpath                = [Dir '/FT_ERFs/' Chantype{j} 'teLocked_run' num2str(Indexes(i)) '.mat'];
        save(ERFpath,'Evoked1','Evoked2','Evoked3');
        
        cfg                    = [];
        cfg.axes               = 'no';
        cfg.xparam             = 'time';
        cfg.zparam             = 'avg';
        cfg.xlim               = [-4.5 0.5];
        cfg.zlim               = 'maxabs';
        cfg.channel            = 'all';
        cfg.baseline           = 'no';
        cfg.baselinetype       = 'absolute';
        cfg.trials             = 'all';
        cfg.showlabels         = 'no';
        cfg.colormap           = jet;
        cfg.marker             = 'off';
        cfg.markersymbol       = 'o';
        cfg.markercolor        = [0 0 0];
        cfg.markersize         = 2;
        cfg.markerfontsize     = 8;
        cfg.linewidth          = 2;
        cfg.axes               = 'yes';
        cfg.colorbar           = 'yes';
        cfg.showoutline        = 'no';
        cfg.interplimits       = 'head';
        cfg.interpolation      = 'v4';
        cfg.style              = 'straight';
        cfg.gridscale          = 67;
        cfg.shading            = 'flat';
        cfg.interactive        = 'yes';
        
        cfg.layout             = [root '/SCRIPTS/Layouts_fieldtrip/NM306mag.lay'];
        lay                    = ft_prepare_layout(cfg,Evoked1);
        eval(['lay.label       = (label' num2str(j) ')'';']);
        cfg.layout             = lay;
        
        figure
        ft_multiplotER(cfg,Evoked1,Evoked2,Evoked3)
        
        print('-dpng',[root '/DATA/NEW/Plots_' Subject '/MULTIs_ERFtendlocked_' Chantype{j} '_' ...
            num2str(Indexes(i)) '_' num2str(Targets(i)) '.png']);
        
        
    end
end
end

