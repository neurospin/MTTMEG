function TFSL_SUBJlvl_EEGv2(nip,chansel,source,func,segwin,latency)

% nip = the NIP code of the subject
% chansel, can be either 'Mags', 'Grads1','Grads2' or 'EEG'
% condnames = the name of the columns conditions 
% condarray: conditions organized in a x*y cell array
% the rows x define all the subconditions of the y column conditions

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% PREPARE COMPUTATIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% define channel types
[Grads1,Grads2,Mags]   = grads_for_layouts('Network');
EEG  = EEG_for_layouts('Network');

ch = [];
if strcmp(chansel,'Mags')
    ch = Mags;
elseif strcmp(chansel,'Grads1')
    ch = Grads1;
elseif strcmp(chansel,'Grads2')
    ch = Grads2;
elseif strcmp(chansel,'GradComb')
    ch = Grads1; %temporary
else strcmp(chansel,'EEG')
    ch = EEG;
end

% load and select source data
% get an array of name and corresponding datasets
for i = 1:size(source,1)
    datasource{i} = ['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/'...
        nip '/MegData/Processed_mne_eeg/' source{i} '_dat_'];
    rejectvisual{i} = ['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/'...
        nip '/MegData/Processed_mne_eeg/' source{i} 'EEG_rejectvisual'];
end
[condnames,data] = func(datasource,rejectvisual);

% %  test selection
% if size(condarray,2) > 2
%     statstag = 'F';
% else
%     statstag = 'T';
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% COMPUTE ERFS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:length(data)
    
    % temporal realignment
    for j = 1:length(data{1,i}.time)
        data{1,i}.time{1,j} = data{1,i}.time{1,j} - ones(1,length(data{1,i}.time{1,j}))*(segwin(1));
    end
    
%     cut data 
    cfg_red                       = [];
    cfg_red.toilim                = latency;
    data{1,i}                     = ft_redefinetrial(cfg_red,data{1,i});
    
    cfg_freq                      = [];
    cfg_freq.channel              = ch;
    cfg_freq.method               = 'wavelet';
    %     cfg.taper               = 'hanning';
    %     cfg.tapsmofrq           = 1.5;
    cfg_freq.foi                  = 1:40;
    cfg_freq.toi                  =  (latency(1)):0.1:(latency(2));
    cfg_freq.t_ftimwin            = 3./cfg_freq.foi;
    cfg_freq.pad                  = 'maxperlen';
    cfg_freq.width                = 7;
    cfg_freq.gwidth               = 3;
    
    % for induced method 1: substract the ERF/P from each trial in time domain,
    % then compute Time-frequency decomposition
    cfgb                     = [];
    cfgb.baseline            = [-0.5 0];
    tmp                      = [];
    tmp                      = ft_timelockanalysis([], data{1,i});
    tmp                      = ft_timelockbaseline(cfgb,tmp);
    
    data4ind{1,i}            = data{1,i};
    cfg_                     = [];
    cfg_.keeptrials          = 'yes';
    cfg_.baseline            = [-0.5 0];
    data4ind{1,i}            = ft_timelockbaseline(cfg_,data4ind{1,i});
    
    for t = 1:size(data{1,i}.trial,1) 
        data4ind{1,i}.trial(t,:,:) = data4ind{1,i}.trial(t,:,:) - ...
                                   reshape(tmp.avg,[1 size(tmp.avg,1) size(tmp.avg,2)]) ;
    end
    
    % for induced method 2, get the Time-Frequency decomposition of the ERF/P
    dataevk        = data{1,i};     % get dummy structure with 1 trial
    cfg_evk        = [];
    cfg_evk.trials = 1;
    dataevk        = ft_redefinetrial(cfg_evk,dataevk);
    dataevk.trial{1} = tmp.avg;    % replace activity with ERF/P
    datafevk       = ft_freqanalysis(cfg_freq,dataevk);
    
    
    % for stats
%     cfg.keeptrials         = 'yes';
%     cfg.polyremoval        = 1;
%     datalockt{i}           = ft_freqanalysis(cfg_freq, data4ind{1,i});

    % for plot
    cfg.keeptrials         = 'no';
    cfg.polyremoval        = 1;
    datalock{i}            = ft_freqanalysis(cfg_freq, data4ind{1,i});
    
    % to check
%     cfg.keeptrials         = 'no';
%     cfg.polyremoval        = 1;
%     datalockc{i}           = ft_freqanalysis(cfg_freq, data{1,i});
    
    % baseline correction
    cfg                   = [];
    cfg.baseline          = [-0.5 0];
    cfg.baselinetype      = 'absolute';
    cfg.channel           = 'all';
    cfg.param             = 'powspctrm';
    timelockbase{i}       = ft_freqbaseline(cfg, datalock{i});
%     timelockbasec{i}      = ft_freqbaseline(cfg, datalockc{i});
%     timelockbaset{i}      = ft_freqbaseline(cfg, datalockt{i});
    
    % induced method 2
    timelockbase2{i}      = datalock{i};
    timelockbase2{i}.powspctrm = timelockbase2{i}.powspctrm - datafevk.powspctrm; 
    timelockbase2{i}      = ft_freqbaseline(cfg, timelockbase2{i});
    datafevk              = ft_freqbaseline(cfg, datafevk);
    
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PLOT RESULTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% cfg                    = [];
% cfg.axes               = 'no';
% cfg.xlim               = latency;
% cfg.channel            = 'all';
% cfg.baseline           = 'no';
% cfg.baselinetype       = 'absolute';
% cfg.trials             = 'all';
% cfg.showlabels         = 'no';
% cfg.colormap           = jet;
% cfg.marker             = 'off';
% cfg.markersymbol       = 'o';
% cfg.markercolor        = [0 0 0];
% cfg.markersize         = 2;
% cfg.markerfontsize     = 8;
% cfg.linewidth          = 2;
% cfg.axes               = 'yes';
% cfg.colorbar           = 'yes';
% cfg.showoutline        = 'no';
% cfg.interplimits       = 'head';
% cfg.interpolation      = 'v4';
% cfg.style              = 'straight';
% cfg.gridscale          = 67;
% cfg.shading            = 'flat';
% cfg.interactive        = 'yes';
% % cfg.graphcolor         = PlotColors;
% 
% cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/fieldtrip-20130901/template/layout/NM306mag.lay';
% lay                       = ft_prepare_layout(cfg,timelockbase{1});
% lay.label               = ch;
% cfg.layout             = lay;
% 
% %% build plot instructions
% fig1 = figure('position',[1 1 1000 1000]);
% set(fig1,'PaperPosition',[1 1 1000 1000])
% set(fig1,'PaperPositionmode','auto')
% set(fig1,'Visible','off')
% 
% instr_plt = 'ft_multiplotER(cfg';
% for i = 1:size(data,2)
%     instr_plt = [instr_plt ',timelockbase{' num2str(i) '}'];
% end
% instr_plt = [instr_plt ');'];
% evaluate plot intructions
% eval(instr_plt)

% % save plots
% filename = ['TOPO_'];
% for i = 1:size(condarray,2)
%     for j = 1:size(condarray{1,i},1)
%         filename = [filename condarray{1,i}{j,1} '-'];
%     end
%     if i <size(condarray,2)
%         filename = [filename 'VS-'];
%     end
% end
% 
% if length(filename) > 255
%     filename = [filename(1:200) '_alias_'];
% end
% 
% filename = [filename chansel];
% 
% save_plots(nip,'ERFPs',filename,fig1)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SAVE DATASETS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cdn = [];
for i = 1:length(condnames)
    cdn = [cdn condnames{i} '_'];
end

fname = ['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/'...
        nip '/MegData/TFs/Ind' cdn chansel];
fname2 = ['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/'...
        nip '/MegData/TFs/Ind2' cdn chansel];
    
if length(fname) > 255
    fname = [fname(1:200) '_alias_'];
end   
 
if length(fname2) > 255
    fname2 = [fname2(1:200) '_alias_'];
end   

%% check if the file aready exists. if yes, delete it
if exist([fname '.mat']) == 2
    delete([fname '.mat'])
end
if exist([fname2 '.mat']) == 2
    delete([fname2 '.mat'])
end

save(fname,'timelockbase')
save(fname2,'timelockbase2')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% COMPUTE SUBJECT-LEVEL STATISTICS %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% if strcmp(statstag,'F') == 1
%     instr = ['fig2 = ERFstatF_subjectlevel(' '[' num2str(latency(1)) ' ' num2str(latency(2)) '],'];
% else
%     instr = ['fig2 = ERFstatT_subjectlevel(' '[' num2str(latency(1)) ' ' num2str(latency(2)) '],'];
% end
% 
% for i = 1:size(data,2)
%     instr = [instr 'timelockbaset{' num2str(i) '},'];    
% end
% instr(end) = [];
% instr = [instr ');'];  
% eval(instr)
% 
% % save plots
% filename = ['STATS_'];
% for i = 1:size(condarray,2)
%     for j = 1:size(condarray{1,i},1)
%         filename = [filename condarray{1,i}{j,1} '-'];
%     end
%     if i <size(condarray,2)
%         filename = [filename 'VS-'];
%     end
% end
% filename = [filename chansel];
% 
% save_plots(nip,'ERFPs',filename,fig2)

close all

