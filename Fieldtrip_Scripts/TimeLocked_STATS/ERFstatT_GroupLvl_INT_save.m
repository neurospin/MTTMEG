function fig = ERFstatT_GroupLvl_INT_save(condnames1,condnames2,GDAVG1,GDAVG1t,GDAVG2,GDAVG2t,chansel_,latency,graphcolor,stat_test)

if strcmp(GDAVG1{1}.label{1,1},'MEG0111') == 1
    chantype = 'Mags';
    ampunit = 'T';
    
    load('/neurospin/meg/meg_tmp/tools_tmp/Pipeline/pipeline/neuromag306mag_neighb.mat')
    
    
elseif strcmp(GDAVG1{1}.label{1,1},'MEG0113') == 1 || strcmp(GDAVG1{1}.label{1,1},'MEG0112') == 1
    chantype = 'Grads';
    ampunit = 'T';
    
    load('/neurospin/meg/meg_tmp/tools_tmp/Pipeline/pipeline/neuromag306planar_neighb.mat')
    
elseif strcmp(GDAVG1{1}.label{1,1},'EEG001') == 1
    chantype = 'EEG';
    ampunit = 'V';
    
    
    cfg = [];
    EEG = EEG_for_layouts('Network');
    cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/eeg_64_NM20884N.lay';
    lay                       = ft_prepare_layout(cfg,GDAVG1{1});
    lay.label               = EEG;
    
    cfg                          = [];
    myneighbourdist      = 0.2;
    cfg.method              = 'distance';
    cfg.channel              = EEG;
    cfg.layout                 = lay;
    cfg.minnbchan          = 2;
    cfg.neighbourdist      = myneighbourdist;
    cfg.feedback            = 'no';
    neighbours            = ft_prepare_neighbours(cfg, GDAVG1{1});
    
    % to complete
end

date = clock;
timetag = [num2str(date(1)) num2str(date(2)) num2str(date(3)) ...
    num2str(date(4)) num2str(date(5)) num2str(round(date(6)))];

[Grads1,Grads2,Mags]   = grads_for_layouts('Network');
% seg{1}.label = Mags';
% data2.label = Mags';

% prepare layout
cfg                           = [];
if strcmp(chantype,'EEG') == 0
    cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/fieldtrip-20130901/template/layout/NM306mag.lay';
else
    cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/eeg_64_NM20884N.lay';
end
lay                        = ft_prepare_layout(cfg,GDAVG1{1});
lay.label                  = GDAVG1{1}.label;

% based on fieldtrip tutorial
rng('default')

% compute difference intra-condition set for interaction stats
GDAVG1tsave= GDAVG1t;
GDAVG2tsave= GDAVG2t;

GDAVG1t{1,1}.individual = GDAVG1t{1,1}.individual - GDAVG1t{1,2}.individual;
GDAVG2t{1,1}.individual= GDAVG2t{1,1}.individual - GDAVG2t{1,2}.individual;

GDAVG1save= GDAVG1;
GDAVG2save= GDAVG2;

GDAVG1{1,1}.avg = GDAVG1{1,1}.avg - GDAVG1{1,2}.avg;
GDAVG2{1,1}.avg = GDAVG2{1,1}.avg - GDAVG2{1,2}.avg;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cfg = [];
cfg.channel                 = 'all';
cfg.latency                  = latency;
cfg.frequency              = 'all';
cfg.method                 = 'montecarlo';
if strcmp(stat_test, 'Reg') ==1
    cfg.statistic                 = 'ft_statfun_depsamplesregrT';
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

ntrialdim1 = size(GDAVG1t{1}.individual,1);
ntrialdim2 = size(GDAVG1t{1}.individual,1);

design1 = [1:ntrialdim1 1:ntrialdim1];

design2 = zeros(1,ntrialdim1 + ntrialdim2);
design2(1,1:ntrialdim1) = 1;
design2(1,(ntrialdim1+1):(ntrialdim1 + ntrialdim2))= 2;

cfg.design           = [design1; design2];
cfg.uvar  = 1;
cfg.ivar  = 2;

[stat] = ft_timelockstatistics(cfg,GDAVG1t{1},GDAVG2t{1});

%%
% concatenante names for data saving
condnames{1} = condnames1{1}
condnames{2} = condnames1{2}
condnames{3} = condnames2{1}
condnames{4} = condnames2{2}

cdn = ['INT_'];
for i = 1:length(condnames)
    cdn = [cdn condnames{i} '_'];
end

cfg = []
cfg.minlength = 'maxperlen';
seg{1} = ft_redefinetrial(cfg,GDAVG1tsave{1});
seg{2} = ft_redefinetrial(cfg,GDAVG1tsave{2});
seg{3} = ft_redefinetrial(cfg,GDAVG2tsave{1});
seg{4} = ft_redefinetrial(cfg,GDAVG2tsave{2});

GDAVG{1} = GDAVG1save{1}
GDAVG{2} = GDAVG1save{2}
GDAVG{3} = GDAVG2save{1}
GDAVG{4} = GDAVG2save{2}

save(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/spatial_clust_from_mne_unsig/stats_clust_INT_' stat_test '_' cdn '_' chansel_ '_Lat' num2str(latency(1)) '-' num2str(latency(2)) '_stimlock_' timetag '.mat'],'stat','chansel_','condnames')
