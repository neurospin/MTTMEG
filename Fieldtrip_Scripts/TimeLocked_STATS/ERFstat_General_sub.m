function stat = ERFstat_General_sub(latency,GDAVG,GDAVGt, chansel_,stat_test,varargin)

if strcmp(varargin{1}.label{1,1},'MEG0111') == 1
    chantype = 'Mags';
    ampunit = 'T';
    
    load('/neurospin/meg/meg_tmp/tools_tmp/Pipeline/pipeline/neuromag306mag_neighb.mat')
    
    
elseif strcmp(varargin{1}.label{1,1},'MEG0113') == 1 || strcmp(varargin{1}.label{1,1},'MEG0112') == 1
    chantype = 'Grads';
    ampunit = 'T';
    
    load('/neurospin/meg/meg_tmp/tools_tmp/Pipeline/pipeline/neuromag306planar_neighb.mat')
    
elseif strcmp(varargin{1}.label{1,1},'EEG001') == 1
    chantype = 'EEG';
    ampunit = 'V';
    
    
    cfg = [];
    EEG = EEG_for_layouts('Network');
    cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/eeg_64_NM20884N.lay';
    lay                       = ft_prepare_layout(cfg,GDAVG{1});
    lay.label               = EEG;
    
    cfg                          = [];
    myneighbourdist      = 0.2;
    cfg.method              = 'distance';
    cfg.channel              = EEG;
    cfg.layout                 = lay;
    cfg.minnbchan          = 2;
    cfg.neighbourdist      = myneighbourdist;
    cfg.feedback            = 'no';
    neighbours            = ft_prepare_neighbours(cfg, GDAVG{1});
    
    % to complete
end

date = clock;
timetag = [num2str(date(1)) num2str(date(2)) num2str(date(3)) ...
    num2str(date(4)) num2str(date(5)) num2str(round(date(6)))];

[Grads1,Grads2,Mags]   = grads_for_layouts('Network');
% varargin{1}.label = Mags';
% data2.label = Mags';

% prepare layout
cfg                           = [];
if strcmp(chantype,'EEG') == 0
    cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/fieldtrip-20130901/template/layout/NM306mag.lay';
else
    cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/eeg_64_NM20884N.lay';
end
lay                        = ft_prepare_layout(cfg,varargin{1});
lay.label                  = varargin{1}.label;

% based on fieldtrip tutorial
rng('default')

cfg = [];
cfg.channel                 = 'all';
cfg.latency                  = latency;
cfg.frequency              = 'all';
cfg.method                 = 'montecarlo';
if strcmp(stat_test, 'Reg') ==1
    cfg.statistic                 = 'depsamplesregrT';
elseif strcmp(stat_test, 'F') ==1
    cfg.statistic                 = 'depsamplesFunivariate';
elseif strcmp(stat_test, 'T') ==1
    cfg.statistic                 = 'depsamplesT';
end
cfg.correctm               = 'cluster';
cfg.clusteralpha           = 0.05;
cfg.clusterstatistic        = 'maxsum';
cfg.minnbchan            = 2;
if  strcmp(stat_test, 'F') ==1
    cfg.tail                        = 1;
    cfg.alpha                    = 0.05;
else
    cfg.tail                        = 0;
    cfg.clustertail             = 0 ;
    cfg.alpha                    = 0.025;
end
cfg.numrandomization = 1000;
cfg.neighbours            = neighbours;

% design definition
design1 = [];
design2 = zeros(1,(size(varargin{1}.individual,1))*length(varargin));
for i =1:length(varargin)
    ntrialdim{i} = size(varargin{1}.individual,1);
    design1 = [design1 1:ntrialdim{i}];
    design2(((i-1)*ntrialdim{i}+1):(i)*ntrialdim{i}) = i;
end

cfg.design = [];
cfg.design           = [design1; design2];
cfg.uvar  = 1;
cfg.ivar  = 2;

% stat instruction
instr = 'stat = ft_timelockstatistics(cfg';
for i =1:length(varargin)
    instr = [instr ',varargin{' num2str(i) '}'];
end
instr = [instr ');'];
eval(instr)

