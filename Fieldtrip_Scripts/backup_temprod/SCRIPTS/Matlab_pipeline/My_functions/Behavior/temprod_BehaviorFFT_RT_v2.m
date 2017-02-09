function temprod_BehaviorFFT_RT_v2(subject,RunNum,fsample,tag)

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
    D = [D ((DURATIONS{k}/fsample(k)))];
end
subplot(4,3,1); plot(D); Title('successive ET values');ylabel('error (ms)');

% get histogram profile
T = max(D) - min(D);
subplot(4,3,4); hist(D,length(D)); title('ET histogram');
[n1,xout1] = hist(D,length(D));
subplot(4,3,7); plot(xout1,n1); title('histogram profile'); 

% compute and apply high-pass filter
[b,a] = butter(3,0.05,'high');
n1f = filter(b,a,n1);
subplot(4,3,10); plot(xout1,n1f); title('filtered profile'); 

% make a artificial time-course for fft
dim = (max(xout1)-min(xout1))*1000;
data = zeros(1,dim);
data(round(xout1*1000)) = n1f;
% linear interpolation between real data points
index = round(xout1*1000);
datatmp = [];
for i = 1:(length(index)-1)
    tmp{1,i} = linspace(data(index(i)),data(index(i+1)),(index(i+1)-index(i)));
    datatmp = [datatmp tmp{1,i}];
end
    
% compute power spectrum
N = dim; %% number of points
t = [0:N-1]'/N; %% define time
f = datatmp; %% define function
p = abs(fft(f))/(N/2); %% absolute value of the fft
p = p(1:N/2).^2; %% take the positve frequency half, only

Fs = 1000;                    % Sampling frequency
T = 1/Fs;                     % Sample time
L = dim;                      % Length of signal
t = (0:L-1)*T;                % Time vector
NFFT = 2^nextpow2(L);         % Next power of 2 from length of y
Y = fft(datatmp,NFFT)/L;
f = Fs/2*linspace(0,1,NFFT/2+1);
% Plot single-sided amplitude spectrum.
K =  ([1:1:5 4:-1:1])/(sum([1:1:5 4:-1:1]));
P = conv(2*abs(Y(1:NFFT/2+1)),K,'same');

subplot(4,3,[8 9 11 12])
loglog(f,P,'linewidth',2) 
title('Smoothed single-Sided Amplitude Spectrum of y(t)')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')

subplot(4,3,[2 3 5 6])
loglog(f,2*abs(Y(1:NFFT/2+1)),'linewidth',2)
title('Single-Sided Amplitude Spectrum of y(t)')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')


% test with dummy fieldtrip variable
% dummy.time{1,1}  = t;
% dummy.trial{1,1} = datatmp;
% dummy.fsample    = 1000;
% dummy.dimord     = 'raw';
% 
% cfg                    = [];
% cfg.channel            = 'all';
% cfg.method             = 'mtmfft';
% cfg.output             = 'pow';
% cfg.taper              = 'dpss';
% cfg.foi                = [1 100];
% cfg.tapsmofrq          = 1;
% cfg.trials             = 1;
% cfg.keeptrials         = 'yes';
% freq2                  = ft_freqanalysis(cfg,dummy);


