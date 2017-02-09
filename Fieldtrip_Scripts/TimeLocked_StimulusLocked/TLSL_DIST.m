function TLSL_DIST(nip,chansel,varargin)

% define channel types
[Grads1,Grads2,Mags]   = grads_for_layouts('Laptop');
EEG  = EEG_for_layouts('Laptop');

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

if length(varargin) > 2
    statstag = 'F';
else
    statstag = 'T';
end

% load cell array of conditions tag
if size(varargin,2) >= 2
    for i = 1:size(varargin,2)
        for j = 1:size(varargin{1,i},1)
            datatmp{i,j} = load(['C:\MTT_MEG\data\' nip '\processed\' varargin{1,i}{j,1} '_filt40.mat']);
        end
    end
end
 
% append datasets belonging to the same condition (defined by cell structure)
for i = 1:size(datatmp,1)
    instr{i} = ['data{1,' num2str(i) '} = ft_appenddata([],'];
    for j = 1:size(datatmp,2)
        instr{i} = [instr{i} 'datatmp{i,' num2str(j) '}.datafilt40,'];
    end
    instr{i}(end) = [];
    instr{i} = [instr{i} ');'];
    eval(instr{i})
end

%% COMPUTE ERFS
for i = 1:length(data)
    
    % temporal realignment
    for j = 1:length(data{1,i}.time)
        data{1,i}.time{1,j} = data{1,i}.time{1,j} - ones(1,length(data{1,i}.time{1,j}))*(0.35);
    end
    
    cfg                    = [];
    cfg.channel            = ch;
    cfg.trials             = 'all';
    
    % for plot
    cfg.keeptrials         = 'no';
    cfg.removemean         = 'yes';
    cfg.covariance         = 'yes';
    datalock {i}           = ft_timelockanalysis(cfg, data{1,i});
    
    % for stats
    cfg.keeptrials         = 'yes';
    cfg.removemean         = 'yes';
    cfg.covariance         = 'yes';
    datalockt{i}           = ft_timelockanalysis(cfg, data{1,i});
    
    % baseline correction
    cfg                    = [];
    cfg.baseline           = [-0.25 0];
    cfg.channel            = 'all';
    timelockbase{i}        = ft_timelockbaseline(cfg, datalock{i});
    timelockbaset{i}       = ft_timelockbaseline(cfg, datalockt{i});

end

%% PLOT
cfg                    = [];
cfg.axes               = 'no';
cfg.zlim               = 'xlim';
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
cfg.graphcolor         = [[0 0 0];[0 0 0.7];[0.5 0.5 1];[0.7 0 0];[1 0.5 0.5]];
cfg.graphcolor         = cfg.graphcolor(1:length(varargin),:);

cfg.layout             = 'C:\FIELDTRIP\fieldtrip-20120402\template\layout/NM306mag.lay';
lay                    = ft_prepare_layout(cfg,timelockbase{1});
lay.label              = ch;
cfg.layout             = lay;

%% build plot instructions
fig = figure('position',[1 1 1000 1000]);
set(fig,'PaperPosition',[1 1 1000 1000])
set(fig,'PaperPositionmode','auto')

instr_plt = 'ft_multiplotER(cfg';
for i = 1:size(data,2)
    instr_plt = [instr_plt ',timelockbase{' num2str(i) '}'];
end
instr_plt = [instr_plt ');'];
% evaluate plot intructions
eval(instr_plt)

% save plots
filename = ['C:\MTT_MEG\results\' nip '\TOPO_'];
for i = 1:size(varargin,1)
    for j = 1:size(varargin{i,1},1)
        filename = [filename varargin{i,1}{j,1} '-'];
    end
    if i <size(varargin,1)
        filename = [filename 'VS-'];
    end
end
filename = [filename chansel];

print('-dpng',filename)
%% compute REFs stats

if strcmp(statstag,'F') == 1
    instr = 'ERFstatF_subjectlevel(';
else
    instr = 'ERFstatT_subjectlevel(';
end

for i = 1:size(data,2)
    instr = [instr 'timelockbaset{' num2str(i) '},'];    
end
instr(end) = [];
instr = [instr ');'];  
eval(instr)

% save plots
filename = ['C:\MTT_MEG\results\' nip '\STATS_'];
for i = 1:size(varargin,1)
    for j = 1:size(varargin{i,1},1)
        filename = [filename varargin{i,1}{j,1} '-'];
    end
    if i <size(varargin,1)
        filename = [filename 'VS-'];
    end
end
filename = [filename chansel];

print('-dpng',filename)




    
