function datasel = ns_trlsel_avg(data,trlval)
% function datasel = ns_trlsel_avg(data,trlval)
% Selects trials in data specified in vector trlval and time-lock averages
% with ft_timelockanalysis.
% Input: 
% data = ft dataset, format: output of ft_preprocessing
% trlval = vector of values indicating trial selection. Set trlval=[] if
% you want to average across all trials.
% Example for selecting all trials coded by numbers 1,3,5: trlval=[1 3 5];
% Remember: Trial values are coded in data.cfg.trl(:,4).
%
% Output:
% datasel = ft dataset, format: output of ft_timelockanalysis
% contains only selected trials and their average in the field 'avg'.
%
% NOTE: if data.avg already exists, it will be removed, otherwise
% ft_timelockanalysis will not work.
%
% Marco Buiatti, INSERM U992 Cognitive Neuroimaging Unit (France), 2010.

cfg             = [];
datasel=data;

if isfield(datasel,'avg')
    disp('Warning: a field avg already present in data: removed');
    datasel=rmfield(datasel,'avg');
end

if ~isempty(trlval)
    datasel.trial=data.trial(find(ismember(data.cfg.trl(:,4),trlval))');
end;
datasel.avg     = ft_timelockanalysis(cfg, datasel);
