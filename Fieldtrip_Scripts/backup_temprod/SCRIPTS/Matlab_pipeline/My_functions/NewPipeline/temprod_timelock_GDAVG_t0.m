function temprod_timelock_GDAVG_t0(Subjects,Indexes,savetag)

% get root directory
root = SetPath('Laptop');

% get subject and run list
Subjects = {'s14';'s13';'s12';'s11';'s08'  ;'s07'  ;'s06';'s05'};
Indexes  = {[2 5];[2 5];[2 5];[2 5];[2 4 5];[1 3 4];[1 3];[1 3]};

% name of the final condition
savetag  = 'Est_5.7';

% Chan type definition
Chantype = {'Grads1';'Grads2';'Mags'};

for k = 1:3
    
    % clear stored variables
    clear GDAVG_t0 GDAVG_te strforeval_t0 strforeval_t0
    
    % configuration of grandaverage
    cfg                             = [];
    cfg.channel                     = 'all';
    cfg.latency                     = [-0.5 5];
    cfg.keepindividual              = 'no';
    cfg.normalizevar                = 'N-1';
    
    % set command to be evaluated for group-level grandaverage
    strforeval_GDAVG_t0_evoked1     = ['GDAVG_t0_evoked1_' Chantype{k} ' = ft_timelockgrandaverage(cfg'];
    strforeval_GDAVG_t0_evoked2     = ['GDAVG_t0_evoked2_' Chantype{k} ' = ft_timelockgrandaverage(cfg'];
    strforeval_GDAVG_t0_evoked3     = ['GDAVG_t0_evoked3_' Chantype{k} ' = ft_timelockgrandaverage(cfg'];
    
    for i = 1:length(Subjects)
        
        % set subject directory
        Dir                         = [root '/DATA/NEW/processed_' Subjects{i}];
        
        % set command to be evaluated for subject-level grandaverage
        strforeval_t0_evoked1       = 'ft_timelockgrandaverage(cfg';
        strforeval_t0_evoked2       = 'ft_timelockgrandaverage(cfg';
        strforeval_t0_evoked3       = 'ft_timelockgrandaverage(cfg';
        
        for j = 1:length([Indexes{i}])
            
            % Load run-level ERF
            datat0locked_evoked1{j} = load([Dir '/FT_ERFs/' Chantype{k} 't0Locked_run' num2str(Indexes{i}(j)) '.mat'],'Evoked1');
            datat0locked_evoked2{j} = load([Dir '/FT_ERFs/' Chantype{k} 't0Locked_run' num2str(Indexes{i}(j)) '.mat'],'Evoked2');
            datat0locked_evoked3{j} = load([Dir '/FT_ERFs/' Chantype{k} 't0Locked_run' num2str(Indexes{i}(j)) '.mat'],'Evoked3');

            % Concatenate subject-level grandaverage command
            strforeval_t0_evoked1   = [strforeval_t0_evoked1 ', datat0locked_evoked1{' num2str(j) '}.Evoked1'];
            strforeval_t0_evoked2   = [strforeval_t0_evoked2 ', datat0locked_evoked2{' num2str(j) '}.Evoked2'];
            strforeval_t0_evoked3   = [strforeval_t0_evoked3 ', datat0locked_evoked3{' num2str(j) '}.Evoked3'];
            
        end
        
        % run subject-level grandaverage
        eval(['sublvlGDAVG' num2str(i) '_t0_evoked1 = ' strforeval_t0_evoked1 ')']);
        eval(['sublvlGDAVG' num2str(i) '_t0_evoked2 = ' strforeval_t0_evoked2 ')']);
        eval(['sublvlGDAVG' num2str(i) '_t0_evoked3 = ' strforeval_t0_evoked3 ')']);
        
        % set command to be evaluated for group-level grandaverage  
        strforeval_GDAVG_t0_evoked1 = [strforeval_GDAVG_t0_evoked1 ',sublvlGDAVG' num2str(i) '_t0_evoked1'];
        strforeval_GDAVG_t0_evoked2 = [strforeval_GDAVG_t0_evoked2 ',sublvlGDAVG' num2str(i) '_t0_evoked2'];
        strforeval_GDAVG_t0_evoked3 = [strforeval_GDAVG_t0_evoked3 ',sublvlGDAVG' num2str(i) '_t0_evoked3'];
        
    end
    
    eval([strforeval_GDAVG_t0_evoked1 ');']);
    eval([strforeval_GDAVG_t0_evoked2 ');']);
    eval([strforeval_GDAVG_t0_evoked3 ');']);
    
end

cfg                    = [];
cfg.axes               = 'no';
cfg.xparam             = 'time';
cfg.zparam             = 'avg';
cfg.xlim               = [-0.5 5];
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
cfg.graphcolor         = 'kbgkbgkbgkbgkbgkbgkbgkbgkbgkbgkbgkbg';

[Grads1,Grads2,Mags]   = grads_for_layouts('Laptop');
cfg.layout             = [root '/SCRIPTS/Layouts_fieldtrip/NM306mag.lay'];
lay                    = ft_prepare_layout(cfg,GDAVG_t0_evoked1_Grads1);
lay.label              = Grads1;
cfg.layout             = lay;
figure
ft_multiplotER(cfg,GDAVG_t0_evoked1_Grads1,GDAVG_t0_evoked2_Grads1,GDAVG_t0_evoked3_Grads1)

lay                    = ft_prepare_layout(cfg,GDAVG_t0_evoked1_Grads2);
lay.label              = Grads2;
cfg.layout             = lay;
figure
ft_multiplotER(cfg,GDAVG_t0_evoked1_Grads2,GDAVG_t0_evoked2_Grads2,GDAVG_t0_evoked3_Grads2)

lay                    = ft_prepare_layout(cfg,GDAVG_t0_evoked1_Mags);
lay.label              = Mags;
cfg.layout             = lay;
figure
ft_multiplotER(cfg,GDAVG_t0_evoked1_Mags,GDAVG_t0_evoked2_Mags,GDAVG_t0_evoked3_Mags)


