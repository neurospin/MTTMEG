function TLRL_SUBJlvl(nip,chansel,condnames,condarray,segwin,latency,func)

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
            
            if exist(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/'...
                    nip '/MegData/Processed/' condarray{1,i}{j,1} 'filt40_clean.mat']) == 2
                
                datatmp{j,i} = load (['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/'...
                    nip '/MegData/Processed/' condarray{1,i}{j,1} 'filt40_clean.mat'],'dataclean40');
                
            end
        end
    end
end
 
% append datasets belonging to the same condition (defined by cell structure)
% (only if it's a combination of conditions, of course)
for i = 1:size(datatmp,2)
    if count(i) ~= 1
        instr{i} = ['data{1,' num2str(i) '} = ft_appenddata([],'];
        for j = 1:size(datatmp,1)
            if isempty(datatmp{j,i}) == 0
                instr{i} = [instr{i} 'datatmp{' num2str(j) ',i}.dataclean40,'];
            end
        end
        instr{i}(end) = [];
        instr{i} = [instr{i} ');'];
        eval(instr{i})
    else
        data{1,i} = datatmp{1,i}.dataclean40;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% COMPUTE ERFS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:length(data)
    
    fs = data{1,i}.fsample;
    
    % temporal realignment
    for j = 1:length(data{1,i}.time)
        data{1,i}.time{1,j} = data{1,i}.time{1,j} - ones(1,length(data{1,i}.time{1,j}))*(segwin(1));
    end
    
    % remove too short trials
    cfg                        = [];
    cfg.minlength         = (1+latency(2)+1/fs);
    data{1,i}                = ft_redefinetrial(cfg, data{1,i});
    
    % baseline correction
    cfg                        = [];
    cfg.baseline           = [latency(1) 0];
    cfg.parameter        = 'trial';
    cfg.channel            = ch;
    database{i}            = ft_timelockbaseline(cfg,data{1,i});
    
    % computez trl length
    trlL = [];
    for k =1:length(data{1,i}.time)
        trlL = [trlL length(data{1,i}.time{k})];
    end  
    
    % response alignement "thing" because I just can't manage to do it with ft_redefinetrial!
    datatmp3 = [];
    for k = 1:length(trlL)
        datatmp2= [];
        for l = 1:size(database{1,i}.trial,2)
            x = []; y = [];
            [x,y] = find(isnan(squeeze(database{1,i}.trial(k,l,:))) == 0);
            datatmp2 = cat(2,datatmp2,squeeze(database{1,i}.trial(k,l,(x(end) - (1+latency(2))*fs):x(end))));
        end
        datatmp3 = cat(3,datatmp3,datatmp2);
    end
    time = -1:0.0040:0.5;

    databaseresp{1,i}                 = database{1,i};
    databaseresp{1,i}.trial           = permute(datatmp3,[3,2,1]);
    databaseresp{1,i}.time          = time;
    rmfield(databaseresp{1,i},'sampleinfo');
    rmfield(databaseresp{1,i},'trldef');
    
    %  align data on response
%     cfg                        = [];
%     cfg.begsample       = trlL - ones(1,length(trlL))*(1.5*data{1,i}.fsample);
%     cfg.endsample       = trlL;
%     databaseresp{1,i}  = ft_redefinetrial(cfg,database{i});
% 
%     cfg                        = [];
%     cfg.offset               = trlL' ;
%     databaseresp{1,i}   = ft_redefinetrial(cfg,database{i});
    
    % for plot
    cfg                        = [];
    cfg.channel            = ch;
    cfg.trials                = 'all';
    cfg.keeptrials         = 'no';
    cfg.removemean    = 'yes';
    cfg.covariance        = 'yes';
%     cfg.vartrllength       = 2;
    timelockbase{i}       = ft_timelockanalysis(cfg, databaseresp{1,i});
    
    % for stats
    cfg                        = [];
    cfg.channel            = ch;
    cfg.keeptrials         = 'yes';
    cfg.removemean     = 'yes';
    cfg.covariance        = 'yes';
%     cfg.vartrllength       = 2;
    timelockbaset{i}         = ft_timelockanalysis(cfg, databaseresp{1,i});
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PLOT RESULTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cfg                    = [];
cfg.axes               = 'no';
cfg.xlim               = latency;
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
% cfg.graphcolor         = PlotColors;

cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/fieldtrip-20130901/template/layout/NM306mag.lay';
lay                    = ft_prepare_layout(cfg,timelockbase{1});
lay.label              = ch;
cfg.layout             = lay;

%% build plot instructions
fig1 = figure('position',[1 1 1000 1000]);
set(fig1,'PaperPosition',[1 1 1000 1000])
set(fig1,'PaperPositionmode','auto')
set(fig1,'Visible','off')

instr_plt = 'ft_multiplotER(cfg';
for i = 1:size(data,2)
    instr_plt = [instr_plt ',timelockbase{' num2str(i) '}'];
end
instr_plt = [instr_plt ');'];
% evaluate plot intructions
eval(instr_plt)

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

filename = [filename chansel];

save_plots(nip,'ERFPs',filename,fig1)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SAVE DATASETS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cdn = [];
for i = 1:length(condnames)
    cdn = [cdn condnames{i} '_'];
end

fname = ['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/'...
        nip '/MegData/ERFPs/' cdn chansel];
    
if length(fname) > 255
    fname = [fname(1:200) '_alias_'];
end   
    
save(fname,'timelockbase')

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

