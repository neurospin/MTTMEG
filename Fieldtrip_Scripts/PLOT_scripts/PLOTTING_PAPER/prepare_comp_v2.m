function [ch, cdn, cdn_clust, stat, GDAVG, GDAVGt, dist] = prepare_comp_v2(niplist,condnames, condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

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
cdn = [];
for i = 1:length(condnames)
    cdn = [cdn condnames{i} '_'];
end
cdn(end) = [];

cdn_clust = [];
for i = 1:length(condnames_clust)
    cdn_clust = [cdn_clust condnames_clust{i} '_'];
end

% load cell array of conditions
for j = 1:length(niplist)
    datatmp{j}   = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' ...
        niplist{j} '/MegData/ERPs_from_mne/' cdn chansel],'RegFullPerChanTime','dist','TL');
end

close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% COMPUTE ERFS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isempty(strfind(cdn,'distT')) == 0
    uniquedist = [1 2 3 4 5 6 7 8 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 27];
elseif isempty(strfind(cdn,'distS')) == 0
    uniquedist = [6 11 16 21 26 31 36 42 47 52 57 62 67 72 78 83 88 93 98 103 108 119 124 129]
end

dist = uniquedist
% get a mean timecourse for each distance
for u = 1:length(uniquedist)
          
    cfg                    = [];
    cfg.channel            = ch;
    cfg.trials             = 'all';
    cfg.keepindividual     = 'no';
    cfg.removemean         = 'yes';
    cfg.covariance         = 'yes';
    
    instr = ['GDAVG{' num2str(u) '} = ft_timelockgrandaverage(cfg,'];
    for j = 1:length(datatmp)
        if size(datatmp{1,j}.TL{u}.trial,1) >= 1
            instr = [instr 'datatmp{1,' num2str(j)  '}.TL{1,' num2str(u) '},'];
        end
    end
    instr(end) = [];
    instr      = [instr ');'];
    
    eval([instr]);

    cfg                    = [];
    cfg.channel            = ch;
    cfg.trials             = 'all';
    cfg.keepindividual     = 'yes';
    cfg.removemean         = 'yes';
    cfg.covariance         = 'yes';
    
    instr = ['GDAVGt{' num2str(u) '} = ft_timelockgrandaverage(cfg,'];
    for j = 1:length(datatmp)
        if size(datatmp{1,j}.TL{u}.trial,1) >= 1
            instr = [instr 'datatmp{1,' num2str(j)  '}.TL{1,' num2str(u) '},'];
        end
    end
    instr(end) = [];
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
