function TFSL_SUBJlvl_cmb(nip,condnames,condarray,segwin,latency)

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

% selection
if size(condarray,2) > 2
    statstag = 'F';
else
    statstag = 'T';
end

% load cell array of conditions
count = zeros(1,size(condarray,2));
if size(condarray,2) >= 2
    for i = 1:size(condarray,2)
        for j = 1:size(condarray{1,i},1)
            datatmp{j,i} = load (['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/'...
                nip '/MegData/Processed/' condarray{1,i}{j,1} 'clean.mat'],'dataclean');
            
            count(i) = count(i) + 1;
        end
    end
end

% append datasets belonging to the same condition (defined by cell structure)
% (only if it's a combination of conditions, of course)
for i = 1:size(datatmp,2)
    if count(i) ~= 1
        instr{i} = ['data{1,' num2str(i) '} = ft_appenddata([],'];
        for j = 1:size(datatmp,1)
            instr{i} = [instr{i} 'datatmp{' num2str(j) ',i}.dataclean,'];
        end
        instr{i}(end) = [];
        instr{i} = [instr{i} ');'];
        eval(instr{i})
    else
        data{1,i} = datatmp{1,i}.dataclean;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% COMPUTE ERFS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:length(data)
      
    % temporal realignment
    for j = 1:length(data{1,i}.time)
        data{1,i}.time{1,j} = data{1,i}.time{1,j} - ones(1,length(data{1,i}.time{1,j}))*(segwin(1));
    end
    
%     cut data 
%     cfg          = [];
%     cfg.toilim = latency;
%     data{1,i}  = ft_redefinetrial(cfg,data{1,i});   
    
    %     cfg                      = [];
    %     cfg.channel          = ch;
    %     cfg.method          = 'wavelet';
    %     cfg.output            = 'pow';
    %     cfg.trials              = 'all';
    %     cfg.keeptrials       = 'no';
    %     cfg.foi                  = 1:0.5:30;
    %     cfg.toi                  = (latency(1)-0.5):0.025:(latency(2)+0.5);
    %     cfg.width              = 4;
    %     cfg.gwidth            = 3;
    
    cfg                          = [];
    cfg.channel              = ch;
    cfg.method              = 'mtmconvol';
    cfg.taper                  = 'hanning';
%     cfg.tapsmofrq           = 1.5;
    cfg.foi                      = 2:1:30;
    cfg.toi                      =  (latency(1)):0.05:(latency(2));
    cfg.t_ftimwin             = ones(1,length(cfg.foi))*0.5;
    
    % for plot
    cfg.keeptrials       = 'no';
    cfg.polyremoval    = 1;
    datalock{i}            = ft_freqanalysis(cfg, data{1,i});
    
    % for stats
    cfg.keeptrials        = 'yes';
    cfg.polyremoval    = 1;
    datalockt{i}           = ft_freqanalysis(cfg, data{1,i});
    
    % baseline correction
    cfg                       = [];
    cfg.baseline           = [latency(1) 0];
    cfg.baselinetype    = 'absolute';
    cfg.channel           = 'all';
    cfg.param             = 'powspctrm';
    timelockbase{i}      = ft_freqbaseline(cfg, datalock{i});
    timelockbaset{i}     = ft_freqbaseline(cfg, datalockt{i});
    
end

timelockbase{1}.powspctrm = timelockbase{1}.powspctrm - timelockbase{2}.powspctrm;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PLOT RESULTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cfg                      = [];
cfg.parameter      = 'powspctrm';
cfg.xlim               = [latency(1) latency(2)];
cfg.ylim               = 'maxmin';
cfg.zlim               = 'maxabs';
cfg.channel          = ch;
cfg.baseline         = 'no';
cfg.trials              = 'all';
cfg.box                = 'yes';
cfg.colorbar         = 'no';
% cfg.colormap        = 'jet';
cfg.showlabels      = 'no';
cfg.showoutline     = 'yes';
cfg.interactive       = 'yes';
cfg.masknans        = 'yes';

cfg1.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/fieldtrip-20130901/template/layout/NM306mag.lay';
lay                       = ft_prepare_layout(cfg1,timelockbase{1,1});
lay.label               = ch;
cfg.layout             = lay;

%% build plot instructions
fig1 = figure('position',[1 1 1000 1000]);
set(fig1,'PaperPosition',[1 1 1000 1000])
set(fig1,'PaperPositionmode','auto')
set(fig1,'Visible','off')

ft_multiplotTFR(cfg,timelockbase{1})

% save plots
filename = ['TOPO_'];
for i = 1:size(condarray,2)
    for j = 1:size(condarray{1,i},1)
        filename = [filename condarray{1,i}{j,1} '-'];
    end
    if i <size(condarray,2)
        filename = [filename 'VS-'];
    end
end

if length(filename) > 255
    filename = [filename(1:200) '_alias_'];
end

filename = [filename '2-30Hz_' chansel];

save_plots(nip,'TFs',filename,fig1)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SAVE DATASETS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cdn = [];
for i = 1:length(condnames)
    cdn = [cdn condnames{i} '_'];
end

fname = ['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/'...
        nip '/MegData/TFs_2-30Hz_' cdn chansel];
    
if length(fname) > 255
    fname = [fname(1:200) '_alias_'];
end   
    
save(fname,'timelockbase')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% COMPUTE SUBJECT-LEVEL STATISTICS %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% if strcmp(statstag,'F') == 1
%     instr = 'fig2 = TFstatF_subjectlevel(';
% else
%     instr = 'fig2 = TFstatT_subjectlevel(';
% end
% 
% fig2 = TFstatT_subjectlevel(timelockbaset{1},timelockbaset{2},foi{1,1});
% % save plots
% 
% filename = ['STATS_'];
% for i = 1:size(condarray,2)
%     for j = 1:size(condarray{1,i},1)
%         filename = [filename condarray{1,i}{j,1} '-'];
%     end
%     if i <size(condarray,2)
%         filename = [filename 'VS-'];
%     end
% end
% filename = [filename '_' num2str(foi{1,1}(1)) '-' num2str(foi{1,1}(2)) 'Hz_' chansel];
% 
% save_plots(nip,'TFs',filename,fig2)
% 

