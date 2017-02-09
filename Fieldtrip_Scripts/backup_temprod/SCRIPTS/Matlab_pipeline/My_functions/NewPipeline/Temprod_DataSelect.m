function data = Temprod_DataSelect(data,CleanChan,CleanTrial,CleanOutlier,Target)

stored.badchanvisual  = data.badchanvisual;
stored.badtrialvisual = data.badtrialvisual;

%% (1) remaining bad channel interpolation
if strcmp(CleanChan,'yes')
    data.CleanChan        = 'yes';
    if isempty(data.badchanvisual) ~= 1
%         
%         % define neighbour channels on a template basis
%         cfg               = [];
%         cfg.method        = 'template';
%         cfg.layout        = 'C:\FIELDTRIP\fieldtrip-20111020\template\layout\NM306mag.lay';
%         lay               = ft_prepare_layout(cfg,data);
%         cfg.layout        = lay;
%         neighbours        = ft_prepare_neighbours(cfg,data);
%         
%         % bad channel interpolation
%         cfg               = [];
%         cfg.layout        = lay;        
%         cfg.badchannel    = data.badchanvisual;
%         cfg.neighbours    = neighbours;
%         cfg.trials        = 'all';
%         data              = ft_channelrepair(cfg,data);
    end
else
    data.CleanChan        = 'no';
end

data.badchanvisual  = stored.badchanvisual;
data.badtrialvisual = stored.badtrialvisual;

%% (2) noisy trials rejection
if strcmp(CleanTrial,'yes')
    data.CleanTrial                 = 'yes';
    if isempty(data.badtrialvisual) ~= 1
        trlnum                      = 1:length(data.trial);
        trlnum(data.badtrialvisual) = [];
        tmp                         = {};
        for i                       = 1:length(trlnum)
            tmp.trial{1,i}          = data.trial{1,trlnum(i)};
            tmp.time{1,i}           = data.time{1,trlnum(i)};
            tmp.sampleinfo(i,:)     = data.sampleinfo(trlnum(i),:);
        end
        data.trial                  = tmp.trial;
        data.time                   = tmp.time;
        data.sampleinfo             = tmp.sampleinfo;
    end
else
    data.CleanTrial       = 'no';
end

%% (3) compute trial duration

% store trial durations
data.duration        = (data.sampleinfo(:,2) - data.sampleinfo(:,1))/data.fsample;
data.duration        = [data.duration (1:(length(data.duration)))'];

data.oldduration     = data.duration;

%% (4) outlier rejection for duration
behav_variable = data.duration(:,1);

% take the log-distribution to symmetrize the distribution and remove low-values outliers
% behav_variable      = log(behav_variable);

% outlier definition
q1                  = prctile(behav_variable,25); % first quartile
q3                  = prctile(behav_variable,75); % third quartile
myiqr               = iqr(behav_variable);        % interquartile range
lower_inner_fence   = q1 - myiqr;                 % inferior threshold
upper_inner_fence   = q3 + myiqr;                 % superior threshold

% outliers indexation
outlier_duration_indexes               = [];
a                   = 0;
for i = 1:length(behav_variable)
    if (behav_variable(i) < lower_inner_fence) || ...
            (behav_variable(i) > upper_inner_fence)
        a           = a + 1;
        outlier_duration_indexes(a)    = i;
    end
end

% compute behavioural variables
data.outlier_duration_indexes             = outlier_duration_indexes;

if strcmp(CleanOutlier,'yes')
    data.CleanOutliers           = 'yes';
    data.duration(outlier_duration_indexes,:) = [];
end
data.duration(:,2)                        = 1:(size(data.duration,1));

% sort trial durations
data.durationsorted  = sortrows(data.duration);

% sort trial accuracy
data.accuracy        = data.duration;
data.accuracy(:,1)   = (abs(data.accuracy(:,1) - ones(size(data.accuracy,1),1)*Target))/Target;
data.accuracy        = sortrows(data.accuracy);

% sort deviation to the median
m                         = median(data.duration(:,1));
for i = 1:size(data.duration,1)
    data.mediandeviation(i,1:2)  = data.duration(i,1:2) - [m 0];
end
data.mediandeviation(:,1) = abs(data.mediandeviation(:,1));
% data.mediandeviation      = sortrows(data.mediandeviation);

% remove trial outliers for behavioural data
if strcmp(CleanOutlier,'yes')
    trialtoremove = [];
    tmp           = {};
    trialtoremove = unique([data.outlier_duration_indexes]);
    if isempty(trialtoremove) ~= 1
        a             = 1;
        b             = 1;
        for i         = 1:length(data.trial)
            if (i ~= trialtoremove(a)) && (a <= length(trialtoremove));
                tmp.trial{1,b}          = data.trial{1,i};
                tmp.time{1,b}           = data.time{1,i};
                tmp.sampleinfo(b,:)     = data.sampleinfo(i,:);
                b = b +1;
            elseif (i == trialtoremove(a)) && (a < length(trialtoremove));
                a     = a+1;
            else
            end
        end
        data.trial          = tmp.trial;
        data.time           = tmp.time;
        data.sampleinfo     = tmp.sampleinfo;
    end
end


data.target = Target;
