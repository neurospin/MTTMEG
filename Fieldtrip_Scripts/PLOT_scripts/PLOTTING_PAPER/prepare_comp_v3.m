function [ch, cdn, cdn_clust, stat, GDAVG, GDAVGt, dist] = prepare_comp_v3(niplist,condnames, condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

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
if isempty(strfind(cdn,'REGfull_SignEVTdistT')) == 0
    uniquedist = [-24 -21 -19 -17 -14 -12 -10 -7 -5 -3 0 4 6 9 11 13 16 18 20 23 25 27 29];
elseif isempty(strfind(cdn,'REGfull_SignEVSdistS')) == 0
    uniquedist = [-149 -117 -95 -85 -74 -63 -52 -42 -31 -20 -10 1 12 22 33 44 55 65 76 87 97 108 119 129 140]
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
