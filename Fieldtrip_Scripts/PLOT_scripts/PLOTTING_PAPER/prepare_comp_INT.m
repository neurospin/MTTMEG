function [ch, cdn1, cdn2, cdn_clust, stat, GDAVG, GDAVGt] = prepare_comp_INT(niplist,condnames1,condnames2, condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

% condnames    = {'RefPast';'RefPre';'RefFut'};
% condnames_clust   = {'RefPast';'RefPre';'RefFut'};
% latency      = [1.1 2];
% graphcolor   = [[1 0.7 0.7];[0 0 0];[1 0 0]];
% stat_test    = 'F';
% chansel      = 'EEG';
% clustnum     = 0;
% clusttype    = 'posclust';
% timetag      = '201659184413';

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

% concatenated names
cdn1 = [];
for i = 1:length(condnames1)
    cdn1 = [cdn1 condnames1{i} '_'];
end
cdn2 = [];
for i = 1:length(condnames2)
    cdn2 = [cdn2 condnames2{i} '_'];
end


cdn_clust = ['INT_'];
for i = 1:length(condnames_clust)
    cdn_clust = [cdn_clust condnames_clust{i} '_'];
end

% load cell array of conditions
for j = 1:length(niplist)
    datatmp1{j}   = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' ...
                        niplist{j} '/MegData/ERPs_from_mne/' cdn1 chansel],'timelockbase');
end
for j = 1:length(niplist)
    datatmp2{j}   = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' ...
                        niplist{j} '/MegData/ERPs_from_mne/' cdn2 chansel],'timelockbase');
end

close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% COMPUTE ERFS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:length(datatmp1{1,1}.timelockbase)
    
    % for plot
    cfg                             = [];
    cfg.channel                 = ch;
    cfg.trials                     = 'all';
    cfg.keepindividual       = 'no';
    cfg.removemean         = 'yes';
    cfg.covariance             = 'yes';
    
    instr = ['GDAVG{' num2str(i) '} = ft_timelockgrandaverage(cfg,'];
    for j = 1:length(datatmp1)
        instr = [instr 'datatmp1{1,' num2str(j)  '}.timelockbase{1,' num2str(i) '},'];
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
    for j = 1:length(datatmp1)
        instr = [instr 'datatmp1{1,' num2str(j)  '}.timelockbase{1,' num2str(i) '},'];
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
count = length(datatmp1{1,1}.timelockbase)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:length(datatmp2{1,1}.timelockbase)
    
    % for plot
    cfg                             = [];
    cfg.channel                 = ch;
    cfg.trials                     = 'all';
    cfg.keepindividual       = 'no';
    cfg.removemean         = 'yes';
    cfg.covariance             = 'yes';
    
    instr = ['GDAVG{' num2str(i+count) '} = ft_timelockgrandaverage(cfg,'];
    for j = 1:length(datatmp2)
        instr = [instr 'datatmp2{1,' num2str(j)  '}.timelockbase{1,' num2str(i) '},'];
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
    
    instr = ['GDAVGt{' num2str(i+count) '} = ft_timelockgrandaverage(cfg,'];
    for j = 1:length(datatmp2)
        instr = [instr 'datatmp2{1,' num2str(j)  '}.timelockbase{1,' num2str(i) '},'];
    end
    instr(end) = [];
    instr      = [instr ');'];
    
    eval([instr]);
    
    instr = [];
    instr = ['GDAVGt{' num2str(i+count) '} = rmfield(GDAVGt{' num2str(i+count) '},''cfg'''];
    instr      = [instr ');'];
    
    eval([instr]);
    
    instr = [];
    instr = ['GDAVG{' num2str(i+count) '} = rmfield(GDAVG{' num2str(i+count) '},''cfg'''];
    instr      = [instr ');'];
    
    eval([instr]);
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% LOAD CLUSTER STAT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if strcmp(stat_test,'')
    tmp = ''
else
    tmp = [stat_test '_']
end

clear stat
if strcmp(clusttype,'negclust')
    load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/spatial_clust_from_mne/stats_negclust_' ...
      tmp num2str(clustnum) '_' cdn_clust '_' chansel '_Lat' num2str(latency(1)) '-' num2str(latency(2))...
        '_stimlock_' timetag '.mat'],'stat')
else
    load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/spatial_clust_from_mne/stats_posclust_' ...
     tmp num2str(clustnum) '_' cdn_clust '_' chansel '_Lat' num2str(latency(1)) '-' num2str(latency(2))...
         '_stimlock_' timetag '.mat'],'stat')
end
