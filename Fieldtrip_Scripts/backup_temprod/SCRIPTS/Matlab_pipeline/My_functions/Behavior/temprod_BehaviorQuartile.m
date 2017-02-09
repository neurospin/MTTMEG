function  [Qm, Qstd, R, P ] = temprod_BehaviorSummary(subject,RunNum,tag)

% set root
root = SetPath(tag);

DataDir = [root '/DATA/NEW/Trans_sss_' subject];

%% main script
for i               = 1:length(RunNum)
    DATASETS{i}     = [DataDir '/' subject '_run' num2str(RunNum(i)) '_raw_sss.fif'];
    events          = ft_read_event(DATASETS{i} );
    value           = [events(find(strcmp('STI101', {events.type}))).value]';
    sample          = [events(find(strcmp('STI101', {events.type}))).sample]';
    VALUE{i}       = value;
    SAMPLE{i}      = sample;
    clear value sample
end

% for k = 1:length(RunNum)
%     value   = VALUE{k};
%     sample  = SAMPLE{k};
%     Vindex = find(value(1:length(value)) == 16384);
%     for i = 2:length(Vindex)
%         trl(i-1,1) = sample(Vindex(i-1));
%         trl(i-1,2) = sample(Vindex(i));
%         trl(i-1,3) = 0;
%     end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
% test    
for k = 1:length(RunNum)
    value   = VALUE{k};
    sample  = SAMPLE{k};
    Vindex0  = find(value(1:length(value)) == 16384);
    Vindex   = find(value(1:length(value)) == 16395);
    
    if isempty(Vindex) == 1
        Vindex = Vindex0;
    end
    
    for i = 2:length(Vindex)
        trl(i-1,1) = sample(Vindex(i-1));
        trl(i-1,2) = sample(Vindex(i));
        trl(i-1,3) = 0;
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    for i = 1:size(trl, 1)
        durations(i) = trl(i,2) - trl(i,1);
    end
    TRL{k}    = trl;
    DURATIONS{k} = durations;
    
    outlier = []; a = 0;
    q1                  = prctile(durations,25); % first quartile
    q3                  = prctile(durations,75); % third quartile
    myiqr               = iqr(durations);        % interquartile range
    lower_inner_fence   = q1 - 2*myiqr;
    upper_inner_fence   = q3 + 2*myiqr;
    
    index = [];
    if k <= length(RunNum)
        for i = 1:length(durations)
            if durations(i) < lower_inner_fence || durations(i) > upper_inner_fence
                a = a + 1;
                index(a) = i;
            end
        end
        if sum(a) ~= 0
            trl(a,:) = [];
        end
        durations(index) = [];
    end
    INDEX{k} = index;
    TRL_corr{k}    = trl;
    DURATIONS_corr{k} = durations;
    clear durations trl Vindex index
end

%% get quartile avg pour duration mean and std

for k = 1:length(RunNum)
    l = []; q = [];
    l = ceil(length(DURATIONS_corr{k})/4);
    q = {1:l,(l+1):2*l , (2*l+1):3*l, (3*l+1):length(DURATIONS_corr{k})};
    
    for i = 1:4
        Qm{k}(i)   = mean(DURATIONS_corr{k}(q{1,i}));
        Qstd{k}(i) = std(DURATIONS_corr{k}(q{1,i}));        
    end
end

% compute correlation estimates vs real time
for i = 1:length(RunNum)
    PlotRanges{i} = 1:(length(DURATIONS{i}));
    PlotRanges{i}(INDEX{i}) = [];
    for j = 1:length(DURATIONS{i})
        DURATIONS_sum{i}(1,j) = sum(DURATIONS{i}(1:j));
    end
    for k = 1:length(DURATIONS_corr{i})
        DURATIONS_corr_sum{i}(1,k) = sum(DURATIONS_corr{i}(1:k));
    end
    
     [RHO,PVAL] = corr(DURATIONS_corr{i}',DURATIONS_corr_sum{i}');
     R{i} = RHO;
     P{i} = PVAL;
    
end







