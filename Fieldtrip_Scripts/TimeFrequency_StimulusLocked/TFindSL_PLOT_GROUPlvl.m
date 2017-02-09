function TFindSL_PLOT_GROUPlvl(niplist,chansel,condnames,latency)

% nip = the NIP code of the subject
% chansel, can be either 'Mags', 'Grads1','Grads2' or 'EEG'
% condnames = the name of the columns conditions
% condarray: conditions organized in a x*y cell array
% the rows x define all the subconditions of the y column conditions

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% PREPARE COMPUTATIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cdn = [];
for i = 1:length(condnames)
    cdn = [cdn condnames{i} '_'];
end

folder = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/Topomaps/';
if exist([folder cdn],'dir') == 0
    mkdir([folder cdn])
end

if strmatch(chansel, 'Mags')   ;
    chantype = 'Mags';
    zlim =[-2 2].*1e-25;
    zlimdiff = [-10 10].*1e-26;
    zlimind = [-5e-14 5e-13];
elseif strmatch(chansel, 'EEG')
    chantype = 'EEG';
    zlimind = [-2e-5 2e-5];
    zlim = [-2e-10 2e-10];
    zlimdiff = [-1e-10 1e-10];
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% concatenante names for data saving
cdn = [];
for i = 1:length(condnames)
    cdn = [cdn condnames{i} '_'];
end

folder = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/TFplots_ind2/';
if exist([folder cdn],'dir') == 0
    mkdir([folder cdn])
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
elseif strcmp(chansel,'cmb')
    ch = Mags; %temporary
else strcmp(chansel,'EEG')
    ch = EEG;
end

% selection
if length(condnames) > 2
    statstag = 'F';
else
    statstag = 'T';
end

% switch from separated to concatenated names
cdn = [];
for i = 1:length(condnames)
    cdn = [cdn condnames{i} '_'];
end

% load cell array of conditions
instrmulti = 'ft_multiplotER(cfg,';
instrsingle = 'ft_singleplotER(cfg,';
for j = 1:length(niplist)
    datatmp{j}   = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' niplist{j} '/MegData/TFs/Ind2' cdn chansel],'timelockbase2');
    instrmulti     = [instrmulti 'datatmp{1,' num2str(j) '}.timelockbase2{1,1},'];
    instrsingle    = [instrsingle 'datatmp{1,' num2str(j) '}.timelockbase2{1,1},'];
end
instrmulti(end)  = [];
instrsingle(end) = [];
instrmulti          = [instrmulti ');'];
instrsingle         = [instrsingle ');'];

close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% COMPUTE ERFS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:length(datatmp{1,1}.timelockbase2)
    
    % for plot
    cfg = [];
    cfg.keepindividual = 'no';
    cfg.foilim              = 'all';
    cfg.toilim              = 'all';
    cfg.channel           = 'all';
    
    instr = ['GDAVG{' num2str(i) '} = ft_freqgrandaverage(cfg,'];
    for j = 1:length(datatmp)
        instr = [instr 'datatmp{1,' num2str(j)  '}.timelockbase2{1,' num2str(i) '},'];
    end
    instr(end) = [];
    instr      = [instr ');'];
    
    eval([instr]);
    
    instr = [];
    instr = ['GDAVG{' num2str(i) '} = rmfield(GDAVG{' num2str(i) '},''cfg'''];
    instr      = [instr ');'];
    
    eval([instr]);
    
    % for stats
    cfg = [];
    cfg.keepindividual = 'yes';
    cfg.foilim              = 'all';
    cfg.toilim              = 'all';
    cfg.channel           = 'all';
    
    instr = ['GDAVGt{' num2str(i) '} = ft_freqgrandaverage(cfg,'];
    for j = 1:length(datatmp)
        instr = [instr 'datatmp{1,' num2str(j)  '}.timelockbase2{1,' num2str(i) '},'];
    end
    instr(end) = [];
    instr      = [instr ');'];
    
    eval([instr]);
    
    instr = [];
    instr = ['GDAVGt{' num2str(i) '} = rmfield(GDAVGt{' num2str(i) '},''cfg'''];
    instr      = [instr ');'];
    
    eval([instr]);
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PLOT DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% select sensor datatype
[Grads1,Grads2,Mags]   = grads_for_layouts('Network');

% prepare layout
cfg                           = [];
if strcmp(chansel,'EEG') == 0
    cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/fieldtrip-20130901/template/layout/NM306mag.lay';
else
    cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/eeg_64_NM20884N.lay';
end
lay                        = ft_prepare_layout(cfg,GDAVGt{1});
lay.label                = GDAVGt{1}.label;

for c = 1:length(condnames)
    
    fig = figure('position',[1 1 1100 1100]);
    set(fig,'PaperPosition',[1 1 1100 1100])
    set(fig,'PaperPositionmode','auto')
    set(fig,'Visible','on')
    
    cfg                    = [];
    cfg.layout         = lay;
    cfg.xlim             = latency ;
    cfg.ylim             = 'maxmin' ;
    cfg.zlim             = zlim;
    cfg.box              = 'yes';
    cfg.interactive      = 'yes';
    ft_multiplotTFR(cfg,GDAVG{1,c})
    
    % save plots
    filename = [folder cdn '/TFind2_lowfreq_mean_' condnames{c} '_' chansel];
    print('-dpng',filename)
    
end

if length(condnames) == 2

    fig = figure('position',[1 1 1100 1100]);
    set(fig,'PaperPosition',[1 1 1100 1100])
    set(fig,'PaperPositionmode','auto')
    set(fig,'Visible','on')

    diff = GDAVG{1,1};
    diff.powspctrm = GDAVG{1,1}.powspctrm - GDAVG{1,2}.powspctrm;

    cfg                    = [];
    cfg.layout         = lay;
    cfg.xlim             = latency ;
    cfg.ylim             = 'maxmin' ;
    cfg.zlim             =  zlimdiff;
    cfg.interactive  = 'yes';
    ft_multiplotTFR(cfg,diff)
    
    % save plots
    filename = [folder cdn '/TFind2_lowfreq_mean_' condnames{1} '-' condnames{2} '_' chansel];
    print('-dpng',filename)
    
elseif length(condnames) == 3

    fig = figure('position',[1 1 1100 1100]);
    set(fig,'PaperPosition',[1 1 1100 1100])
    set(fig,'PaperPositionmode','auto')
    set(fig,'Visible','on')

    diff = GDAVG{1,1};
    diff.powspctrm = GDAVG{1,1}.powspctrm - GDAVG{1,2}.powspctrm;

    cfg                    = [];
    cfg.layout         = lay;
    cfg.xlim             = latency ;
    cfg.ylim             = 'maxmin' ;
    cfg.zlim             =  zlimdiff;
    cfg.interactive  = 'yes';
    ft_multiplotTFR(cfg,diff)
    
    % save plots
    filename = [folder cdn '/TFind2_lowfreq_mean_' condnames{1} '-' condnames{2} '_' chansel];
    print('-dpng',filename)
    

    fig = figure('position',[1 1 1100 1100]);
    set(fig,'PaperPosition',[1 1 1100 1100])
    set(fig,'PaperPositionmode','auto')
    set(fig,'Visible','on')

    diff = GDAVG{1,1};
    diff.powspctrm = GDAVG{1,3}.powspctrm - GDAVG{1,2}.powspctrm;

    cfg                    = [];
    cfg.layout         = lay;
    cfg.xlim             = latency ;
    cfg.ylim             = 'maxmin' ;
    cfg.zlim             =  zlimdiff;
    cfg.interactive  = 'yes';
    ft_multiplotTFR(cfg,diff)
    
    % save plots
    filename = [folder cdn '/TFind2_lowfreq_mean_' condnames{3} '-' condnames{2} '_' chansel];
    print('-dpng',filename)

    fig = figure('position',[1 1 1100 1100]);
    set(fig,'PaperPosition',[1 1 1100 1100])
    set(fig,'PaperPositionmode','auto')
    set(fig,'Visible','on')

    diff = GDAVG{1,1};
    diff.powspctrm = GDAVG{1,3}.powspctrm - GDAVG{1,1}.powspctrm;

    cfg                    = [];
    cfg.layout         = lay;
    cfg.xlim             = latency ;
    cfg.ylim             = 'maxmin' ;
    cfg.zlim             =  zlimdiff;
    cfg.interactive  = 'yes';
    ft_multiplotTFR(cfg,diff)
    
    % save plots
    filename = [folder cdn '/TFind2_lowfreq_mean_' condnames{3} '-' condnames{1} '_' chansel];
    print('-dpng',filename)
    
end