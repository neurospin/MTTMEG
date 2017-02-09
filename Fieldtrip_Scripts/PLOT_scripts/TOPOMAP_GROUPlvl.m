function TOPOMAP_GROUPlvl(niplist,chansel,condnames,latency)

cdn = [];
for i = 1:length(condnames)
    cdn = [cdn condnames{i} '_'];
end

folder = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/Topomaps/';
if exist([folder cdn],'dir') == 0
    mkdir([folder cdn])
end

% niplist            =  {'sd130343' ;'cb130477' ;'rb130313'   ;'jm100042' ;'jm100109';'sb120316';...
%     'tk130502'  ;'lm130479' ;'sg120518'   ;'ms130534';'ma100253';'sl130503';...
%     'mb140004';'mp140019';'mm130405';'dm130250';'hr130504' ;'wl130316';'rl130571'};
% chansel         = 'EEG';
% chantype       = 'EEG';
% condnames   ={'RefPast';'RefPre';'RefFut'};
% latency          = [0 2];

if strmatch(chansel, 'Mags')   ;
    chantype = 'Mags';
    zlim = [-1e-13 1e-13];
    zlimdiff = [-5e-14 5e-14];
    zlimind = [-1e-13 1e-13];
elseif strmatch(chansel, 'EEG')
    chantype = 'EEG';
    zlimind = [-1e-5 1e-5];
    zlim = [-5e-6 5e-6];
    zlimdiff = [-1e-6 1e-6];
end

% concatenante names for data saving
cdn = [];
for i = 1:length(condnames)
    cdn = [cdn condnames{i} '_'];
end

folder = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/Topomaps/';
if exist([folder cdn],'dir') == 0
    mkdir([folder cdn])
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
    datatmp{j}   = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' niplist{j} '/MegData/ERFPs/' cdn chansel],'timelockbase');
    instrmulti     = [instrmulti 'datatmp{1,' num2str(j) '}.timelockbase{1,1},'];
    instrsingle    = [instrsingle 'datatmp{1,' num2str(j) '}.timelockbase{1,1},'];
end
instrmulti(end)  = [];
instrsingle(end) = [];
instrmulti          = [instrmulti ');'];
instrsingle         = [instrsingle ');'];

close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% COMPUTE ERFS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:length(datatmp{1,1}.timelockbase)
    
    % for plot
    cfg                             = [];
    cfg.channel                 = ch;
    cfg.trials                     = 'all';
    cfg.keepindividual       = 'no';
    cfg.removemean         = 'yes';
    cfg.covariance             = 'yes';
    
    instr = ['GDAVG{' num2str(i) '} = ft_timelockgrandaverage(cfg,'];
    for j = 1:length(datatmp)
        instr = [instr 'datatmp{1,' num2str(j)  '}.timelockbase{1,' num2str(i) '},'];
    end
    instr(end) = [];
    instr      = [instr ');'];
    
    eval([instr]);
    
    % for stats
    cfg                             = [];
    cfg.channel                 = ch;
    cfg.trials                     = 'all';
    cfg.keepindividual       = 'yes';
    cfg.removemean         = 'yes';
    cfg.covariance             = 'yes';
    
    instr = ['GDAVGt{' num2str(i) '} = ft_timelockgrandaverage(cfg,'];
    for j = 1:length(datatmp)
        instr = [instr 'datatmp{1,' num2str(j)  '}.timelockbase{1,' num2str(i) '},'];
    end
    instr(end) = [];
    instr      = [instr ');'];
    
    eval([instr]);
    
    instr = [];
    instr = ['GDAVGt{' num2str(i) '} = rmfield(GDAVGt{' num2str(i) '},''cfg'''];
    instr      = [instr ');'];
    
    eval([instr]);
    
    instr = [];
    instr = ['GDAVG{' num2str(i) '} = rmfield(GDAVG{' num2str(i) '},''cfg'''];
    instr      = [instr ');'];
    
    eval([instr]);
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% compute difference
if length(GDAVG) == 2
    GDAVGt_diff{1,1}.individual = GDAVGt{1,1}.individual  - GDAVGt{1,2}.individual;
    GDAVG_diff{1,1}.avg   = GDAVG{1,1}.avg - GDAVG{1,2}.avg;
    GDAVG_diff{1,1}.dimord       = GDAVG{1,1}.dimord;
    GDAVG_diff{1,1}.time           = GDAVG{1,1}.time;
    GDAVG_diff{1,1}.dof        = GDAVG{1,1}.dof;
    GDAVG_diff{1,1}.label        = GDAVG{1,1}.label;
    ndiff = 1;
elseif length(GDAVG) == 3
    GDAVGt_diff{1,1}.individual = GDAVGt{1,1}.individual  - GDAVGt{1,2}.individual;
    GDAVG_diff{1,1}.avg   = GDAVG{1,1}.avg - GDAVG{1,2}.avg;
    GDAVGt_diff{1,2}.individual = GDAVGt{1,3}.individual  - GDAVGt{1,2}.individual;
    GDAVG_diff{1,2}.avg   = GDAVG{1,3}.avg - GDAVG{1,2}.avg;
    GDAVG_diff{1,1}.dimord       = GDAVG{1,1}.dimord;
    GDAVG_diff{1,1}.time           = GDAVG{1,1}.time;
    GDAVG_diff{1,1}.dof          = GDAVG{1,1}.dof;
    GDAVG_diff{1,1}.label        = GDAVG{1,1}.label;
    GDAVG_diff{1,2}.dimord       = GDAVG{1,1}.dimord;
    GDAVG_diff{1,2}.time           = GDAVG{1,1}.time;
    GDAVG_diff{1,2}.dof          = GDAVG{1,1}.dof;
    GDAVG_diff{1,2}.label        = GDAVG{1,1}.label;
    ndiff = 2;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PLOT DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% select sensor datatype
[Grads1,Grads2,Mags]   = grads_for_layouts('Network');

% prepare layout
cfg                           = [];
if strcmp(chantype,'EEG') == 0
    cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/fieldtrip-20130901/template/layout/NM306mag.lay';
else
    cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/eeg_64_NM20884N.lay';
end
lay                        = ft_prepare_layout(cfg,GDAVGt{1});
lay.label                = GDAVGt{1}.label;

fig = figure('position',[1 1 1100 1100]);
set(fig,'PaperPosition',[1 1 1100 1100])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

count = 1;
for c = 1:length(GDAVG)
    for tval = 0:0.1:1
        mysubplot(11,14, count)
        cfg                            = [];
        cfg.xlim                     = [tval tval];
        cfg.zlim                     = zlim;
        cfg.layout                 = lay;
        cfg.colormap            = 'jet';
        cfg.style                   = 'straight';
        cfg.parameter          = 'avg';
        cfg.marker               = 'off';
        cfg.comment            = 'no';
        cfg.interactive           = 'yes';
        cfg.comment            = num2str(tval);
        ft_topoplotER(cfg,GDAVG{c});
        count = count+1;
    end
    count = count +3;
end

count = count+14;
for c = 1:ndiff
    for tval = 0:0.1:1
        mysubplot(11,14, count)
        cfg                            = [];
        cfg.xlim                     = [tval tval];
        cfg.zlim                     = zlimdiff;
        cfg.layout                 = lay;
        cfg.colormap            = 'jet';
        cfg.style                   = 'straight';
        cfg.parameter          = 'avg';
        cfg.marker               = 'off';
        cfg.comment            = 'no';
        cfg.comment            = num2str(tval);
        ft_topoplotER(cfg,GDAVG_diff{c});
        count = count+1;
    end
    count = count +3
end

% compute T-stat
if ndiff >= 1
    test = 'T';
    instr = 'stat = ERFstat_General_sub( latency, GDAVG, GDAVGt, chansel,test,';
    
    for i = [1 2]
        instr = [instr 'GDAVGt{' num2str(i) '},'];
    end
    instr(end) = [];
    instr = [instr ');'];
    eval(instr)
    
    count = count+14;
    for tval = 0:0.1:1
        mysubplot(11,14, count)
        cfg                            = [];
        cfg.xlim                     = [tval tval];
        cfg.zlim                     = [-4 4];
        cfg.layout                 = lay;
        cfg.colormap            = 'jet';
        cfg.style                   = 'straight';
        cfg.parameter          = 'stat';
        cfg.marker               = 'off';
        cfg.comment            = 'no';
        cfg.comment            = num2str(tval);
        ft_topoplotER(cfg,stat);
        count = count+1;
    end
    count = count +3;
end

if ndiff == 2
    test = 'T';
    instr = 'stat = ERFstat_General_sub( latency, GDAVG, GDAVGt, chansel,test,';
    
    for i = [3 2]
        instr = [instr 'GDAVGt{' num2str(i) '},'];
    end
    instr(end) = [];
    instr = [instr ');'];
    eval(instr)
    count = count+14;
    for tval = 0:0.1:1
        mysubplot(11,14, count)
        cfg                            = [];
        cfg.xlim                     = [tval tval];
        cfg.zlim                     = [-4 4];
        cfg.layout                 = lay;
        cfg.colormap            = 'jet';
        cfg.style                   = 'straight';
        cfg.parameter          = 'stat';
        cfg.marker               = 'off';
        cfg.comment            = 'no';
        cfg.comment            = num2str(tval);
        ft_topoplotER(cfg,stat);
        count = count+1;
    end
    count = count +3;
end

% save plots
filename = [folder cdn '/TOPO_' cdn '_' chansel];
print('-dpng',filename)

%%%%%BLAHBLAH

%     % @200-300, et 400ms
%     cfg.channel = {'MEG1611', 'MEG1621', 'MEG1631', 'MEG1641', 'MEG1721', 'MEG1811', 'MEG1821', 'MEG1841', 'MEG1911'}
%     % @600ms
%     cfg.channel = {'MEG0721', 'MEG0731', 'MEG1041', 'MEG1111', 'MEG1121', 'MEG1131', 'MEG1141', 'MEG1611', 'MEG1621', 'MEG1631', 'MEG1641', 'MEG1721', 'MEG1811', 'MEG1821', 'MEG1841', 'MEG1911', 'MEG2211', 'MEG2221', 'MEG2241'}
%
%     cfg.channel = {'MEG0431', 'MEG0441', 'MEG1821'}
%
%     cfg.channel = {'MEG0211', 'MEG0221', 'MEG0411', 'MEG0421'}
%
%     cfg.channel = {'MEG2021', 'MEG2031', 'MEG2311', 'MEG2341'}
%     ft_singleplotER(cfg,GDAVG{1},GDAVG{2},GDAVG{3})
%
%     %%%%%% W H E
%
%     % ref_w_par_e
%     cfg.channel = {'MEG2031', 'MEG2111', 'MEG2311', 'MEG2321', 'MEG2331', 'MEG2341', 'MEG2511'};
%     cfg.channel = {'MEG0931', 'MEG1111', 'MEG1121', 'MEG1211', 'MEG1221', 'MEG1231', 'MEG1241', 'MEG1311'};
%     cfg.channel = {'MEG0411', 'MEG0421', 'MEG0431', 'MEG0441', 'MEG0631', 'MEG0711', 'MEG0741', 'MEG1811', 'MEG1821'};
%     cfg.channel = {'MEG1611', 'MEG1621', 'MEG1631', 'MEG1641'};
%     cfg.channel = {'MEG0211', 'MEG0221', 'MEG0411'};
%     cfg.channel = {'MEG0231', 'MEG0241', 'MEG1511', 'MEG1521', 'MEG1531', 'MEG1611', 'MEG1621', 'MEG1641', 'MEG1721'};
%     cfg.channel = {'MEG1731', 'MEG1741', 'MEG1931', 'MEG2111', 'MEG2121', 'MEG2141'};
%     cfg.channel = {'MEG1511', 'MEG1521', 'MEG1611', 'MEG1621', 'MEG1631'};
%     cfg.channel = {'MEG0431', 'MEG0441', 'MEG1821'};
%
%     cfg               = [];
%     cfg.linewidth = 3;
%     cfg.graphcolor = [[1 0 0];[0 0 0];[1 0.8 0.8]];
%     % ref_past_pre_fut
%     cfg.channel = {'MEG2311', 'MEG2321', 'MEG2441', 'MEG2511', 'MEG2541'};
%     cfg.channel = {'MEG1521', 'MEG1611', 'MEG1621', 'MEG1641', 'MEG1721'};
%     cfg.channel = {'MEG0121', 'MEG0131', 'MEG0211', 'MEG0221', 'MEG0321', 'MEG0331', 'MEG0341', 'MEG0411'};
%     cfg.channel = {'MEG0431', 'MEG0441', 'MEG0711', 'MEG0741', 'MEG1821'};
%     cfg.channel = {'MEG1611', 'MEG1621', 'MEG1631', 'MEG1811'};
%     cfg.channel = {'MEG2011', 'MEG2021', 'MEG2031', 'MEG2041', 'MEG2111', 'MEG2311', 'MEG2341'};
%     cfg.channel = {'MEG0231', 'MEG0241', 'MEG1511', 'MEG1521', 'MEG1541', 'MEG1611', 'MEG1641'};
%     cfg.channel = {'MEG1111', 'MEG1121', 'MEG1231', 'MEG1241', 'MEG1311'};
%     cfg.channel = {'MEG0721', 'MEG0731', 'MEG1041', 'MEG1111', 'MEG1121', 'MEG1131', 'MEG1141', 'MEG2211', 'MEG2221', 'MEG2241'};
%     fig = figure('position',[1 1 1000 500]);
%     set(fig,'PaperPosition',[1 1 1000 500])
%     set(fig,'PaperPositionmode','auto')
%     set(fig,'Visible','on')
%     ft_singleplotER(cfg,GDAVG{1},GDAVG{2},GDAVG{3})
%     legend(condnames)
%     line([-0.2 2],[0 0],'linestyle',':','color','k')
%     set(gca,'linewidth',2)
%     ylabel('Amplitude (T)')
%     xlabel('Time (s)')
%print('-dpng','/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/Topomaps/latepos_evoked_W_Par_E')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% RMS %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure('position',[1 1 1200 600]);
set(fig,'PaperPosition',[1 1 1200 600])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
if strmatch(chansel, 'EEG')
    yl = 1:60;
elseif strmatch(chansel, 'Mags')
    yl = 1:102;
end

for c = 1:length(condnames)
    colormap('jet')
    subplot(2,3,c)
    imagesc(GDAVG{c}.time,yl,GDAVG{c}.avg, zlim); colorbar()
    ylabel('channels');xlabel('time(s)');title(condnames{c})
end

mean_rms = sqrt(mean(GDAVG{1}.avg.*GDAVG{1}.avg,1));
for c = 2:length(condnames)
    mean_rms = mean_rms + sqrt(mean(GDAVG{c}.avg.*GDAVG{c}.avg,1));
end
mean_rms = mean_rms/length(condnames);

subplot(2,3,[4 5])
for c = 1:length(condnames)
    plot(GDAVG{c}.time,sqrt(mean(GDAVG{c}.avg.*GDAVG{c}.avg,1)),'linewidth',2,'linestyle',':');hold on
end
plot(GDAVG{1}.time,mean_rms,'linewidth',3,'color',[0.5 0.5 0.5]);hold on
legend(condnames,'Mean')
ylabel('RMS');xlabel('time(s)')
%     axis([-0.2 2 0 1.7e-5])


% save plots
filename = [folder cdn '/raster+RMS_' cdn '_' chansel];
print('-dpng',filename)

if strmatch(chansel, 'Mags')   ;
    chantype = 'Mags';
    mult_factor = 1e14;
elseif strmatch(chansel, 'EEG')
    chantype = 'EEG';
    mult_factor = 1e6;
end


if ndiff == 1
    
    fig = figure('position',[1 1 1000 1000]);
    set(fig,'PaperPosition',[1 1 1000 1000])
    set(fig,'PaperPositionmode','auto')
    set(fig,'Visible','on')
    
    for i = 1:size(GDAVGt{1}.individual,1)
        subplot(4,5,i)
        plot(GDAVGt{1}.time, sqrt(squeeze(mean(GDAVGt{1}.individual(i,:,:).*GDAVGt{1}.individual(i,:,:),2)))*mult_factor,'color','r','linewidth',2)
        hold on
        plot(GDAVGt{1}.time, sqrt(squeeze(mean(GDAVGt{2}.individual(i,:,:).*GDAVGt{2}.individual(i,:,:),2)))*mult_factor,'color','b','linewidth',2)
        hold on
        grid('on')
        xlabel('Time(ms)'); ylabel('RMS (FT)'); title(niplist{i});
        axis([0 2 0 15])
    end
    legend(condnames)
    
    % save plots
    filename = [folder cdn '/RMS_acros_sub_fig1_' cdn '_' chansel];
    print('-dpng',filename)
    
    fig = figure('position',[1 1 800 1000]);
    set(fig,'PaperPosition',[1 1 800 1000])
    set(fig,'PaperPositionmode','auto')
    set(fig,'Visible','on')
    
    subplot(2,1,1)
    for i = 1:size(GDAVGt{1}.individual,1)
        plot(GDAVGt{1}.time, sqrt(squeeze(mean(GDAVGt{1}.individual(i,:,:).*GDAVGt{1}.individual(i,:,:),2)))*mult_factor,'linewidth',2)
        hold on
    end
    xlabel('Time(ms)'); ylabel('RMS (FT)'); title(['all sub, ' condnames{1}]);
    subplot(2,1,2)
    for i = 1:size(GDAVGt{1}.individual,1)
        plot(GDAVGt{1}.time, sqrt(squeeze(mean(GDAVGt{2}.individual(i,:,:).*GDAVGt{2}.individual(i,:,:),2)))*mult_factor,'linewidth',2)
        hold on
    end
    xlabel('Time(ms)'); ylabel('RMS (FT)'); title(['all sub, ' condnames{2}]);
    
    % save plots
    filename = [folder cdn '/RMS_acros_sub_fig2_' cdn '_' chansel];
    print('-dpng',filename)
    
elseif ndiff == 2
    
    fig = figure('position',[1 1 1000 1000]);
    set(fig,'PaperPosition',[1 1 1000 1000])
    set(fig,'PaperPositionmode','auto')
    set(fig,'Visible','on')
    
    for i = 1:size(GDAVGt{1}.individual,1)
        subplot(4,5,i)
        plot(GDAVGt{1}.time, sqrt(squeeze(mean(GDAVGt{1}.individual(i,:,:).*GDAVGt{1}.individual(i,:,:),2)))*mult_factor,'color','r','linewidth',2)
        hold on
        plot(GDAVGt{1}.time, sqrt(squeeze(mean(GDAVGt{2}.individual(i,:,:).*GDAVGt{2}.individual(i,:,:),2)))*mult_factor,'color','b','linewidth',2)
        hold on
        plot(GDAVGt{1}.time, sqrt(squeeze(mean(GDAVGt{3}.individual(i,:,:).*GDAVGt{3}.individual(i,:,:),2)))*mult_factor,'color','k','linewidth',2)
        hold on
        grid('on')
        xlabel('Time(ms)'); ylabel('RMS (FT)'); title(niplist{i});
        axis([0 2 0 15])
    end
    legend(condnames)
    
    % save plots
    filename = [folder cdn '/RMS_acros_sub_fig1_' cdn '_' chansel];
    print('-dpng',filename)
    
    fig = figure('position',[1 1 800 1000]);
    set(fig,'PaperPosition',[1 1 800 1000])
    set(fig,'PaperPositionmode','auto')
    set(fig,'Visible','on')
    
    subplot(3,1,1)
    for i = 1:size(GDAVGt{1}.individual,1)
        plot(GDAVGt{1}.time, sqrt(squeeze(mean(GDAVGt{1}.individual(i,:,:).*GDAVGt{1}.individual(i,:,:),2)))*mult_factor,'linewidth',2)
        hold on
    end
    xlabel('Time(ms)'); ylabel('RMS (FT)'); title(['all sub, ' condnames{1}]);
    subplot(3,1,2)
    for i = 1:size(GDAVGt{1}.individual,1)
        plot(GDAVGt{1}.time, sqrt(squeeze(mean(GDAVGt{2}.individual(i,:,:).*GDAVGt{2}.individual(i,:,:),2)))*mult_factor,'linewidth',2)
        hold on
    end
    xlabel('Time(ms)'); ylabel('RMS (FT)'); title(['all sub, ' condnames{2}]);
    subplot(3,1,3)
    for i = 1:size(GDAVGt{1}.individual,1)
        plot(GDAVGt{1}.time, sqrt(squeeze(mean(GDAVGt{3}.individual(i,:,:).*GDAVGt{3}.individual(i,:,:),2)))*mult_factor,'linewidth',2)
        hold on
    end
    xlabel('Time(ms)'); ylabel('RMS (FT)'); title(['all sub, ' condnames{3}]);
    
    % save plots
    filename = [folder cdn '/RMS_acros_sub_fig2_' cdn '_' chansel];
    print('-dpng',filename)
    
end

fig = figure('position',[1 1 1500 1100]);
set(fig,'PaperPosition',[1 1 1500 1100])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

count = 1;
for s = 1:length(niplist)
    for tval = 0:0.05:1
        mysubplot(19,21, count)
        cfg                            = [];
        cfg.xlim                     = [tval tval];
        cfg.zlim                     = zlimind;
        cfg.layout                 = lay;
        cfg.colormap            = 'jet';
        cfg.style                   = 'straight';
        cfg.parameter          = 'avg';
        cfg.marker               = 'off';
        cfg.comment            = 'no';
        cfg.interactive           = 'yes';
        cfg.comment            = num2str(tval);
        ft_topoplotER(cfg,datatmp{1,s}.timelockbase{1,c});
        count = count+1;
    end
end

% save plots
filename = [folder cdn '/topo_acros_sub_' cdn '_' chansel];
print('-dpng',filename)

fig = figure('position',[1 1 1500 1100]);
set(fig,'PaperPosition',[1 1 1500 1100])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')

count = 1;
for s = 1:length(niplist)
    
    % compute diff
    datatmp{1,s}.timelockbase{1,1}.avg = datatmp{1,s}.timelockbase{1,1}.avg ...
                                                       - datatmp{1,s}.timelockbase{1,2}.avg;
    for tval = 0:0.05:1
        
        mysubplot(19,21, count)
        cfg                            = [];
        cfg.xlim                     = [tval tval];
        cfg.zlim                     = zlimind;
        cfg.layout                 = lay;
        cfg.colormap            = 'jet';
        cfg.style                   = 'straight';
        cfg.parameter          = 'avg';
        cfg.marker               = 'off';
        cfg.comment            = 'no';
        cfg.interactive           = 'yes';
        cfg.comment            = num2str(tval);
        ft_topoplotER(cfg,datatmp{1,s}.timelockbase{1,1});
        count = count+1;
        
    end
end

% save plots
filename = [folder cdn '/topodiff_acros_sub_' cdn '_' chansel];
print('-dpng',filename)

