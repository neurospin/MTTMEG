function temprod_BehaviorFFT_RT(subject,RunNum,fsample,TD,tag)

figure

% set root
root = SetPath(tag);

DataDir             = [root '/DATA/NEW/Trans_sss_' subject];

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i = 1:length(RunNum)
    PlotRanges{i} = 1:(length(DURATIONS{i}));
    PlotRanges{i}(INDEX{i}) = [];
    for j = 1:length(DURATIONS{i})
        DURATIONS_sum{i}(1,j) = sum(DURATIONS{i}(1:j));
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% Dehaene' 1993 paper %%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Concatenate data
D = [];
for k = 1:length(RunNum)
    D = [D ((DURATIONS{k}/fsample(k) - ones(1,length(DURATIONS{k}))*TD(k)))*1000];
end
subplot(4,3,1); plot(D); Title('successive estimation errors values');ylabel('error (ms)');

% get histogram profile
T = max(D) - min(D);
subplot(4,3,4); hist(D,length(D)/2); title('estimation errors histogram');
[n1,xout1] = hist(D,length(D)/2);
subplot(4,3,7); plot(n1); title('histogram profile'); 

% compute and apply high-pass filter
[b,a] = butter(3,0.05,'high');
n1f = filter(b,a,n1);
subplot(4,3,10); plot(n1f); title('filtered profile'); 

% compute power spectrum
N = length(D); %% number of points
t = [0:N-1]'/N; %% define time
f = n1; %% define function
p = abs(fft(f))/(N/2); %% absolute value of the fft
p = p(1:N/2).^2; %% take the positve frequency half, only

subplot(4,3,8); semilogy(p); grid('on') ;title('power spectrum');
% compute power spectrum
N = length(D); %% number of points
t = [0:N-1]'/N; %% define time
f = n1f; %% define function
pf = abs(fft(f))/(N/2); %% absolute value of the fft
pf = p(1:N/2).^2; %% take the positve frequency half, only
subplot(4,3,11); semilogy(pf); grid('on'); title('power spectrum');



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Gilden's paper %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






