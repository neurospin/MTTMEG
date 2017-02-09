function [f,P] = temprod_BehaviorFFT_RT_v4(subjectArray,RunNum,fsample,tag)

figure

% set root
root = SetPath(tag);

%% main script
for j = 1:length(subjectArray)
    DataDir             = [root '/DATA/NEW/Trans_sss_' subjectArray{j}];
    for i               = 1:length(RunNum{j})
        DATASETS{i,j}   = [DataDir '/' subjectArray{j} '_run' num2str(RunNum{j}(i)) '_raw_sss.fif'];
        events          = ft_read_event(DATASETS{i,j} );
        value           = [events(find(strcmp('STI101', {events.type}))).value]';
        sample          = [events(find(strcmp('STI101', {events.type}))).sample]';
        VALUE{i,j}      = value;
        SAMPLE{i,j}     = sample;
        clear value sample
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% test
for l = 1:length(subjectArray)
    for k = 1:length(RunNum{l})
        value   = VALUE{k};
        sample  = SAMPLE{k};
        
        if strcmp(subjectArray{l},'s10')
            
            Vindex = find(value(1:length(value)) == 16512);
            
            for i = 2:length(Vindex)
                trl(i-1,1) = sample(Vindex(i-1));
                trl(i-1,2) = sample(Vindex(i));
                trl(i-1,3) = 0;
            end
            
        else
            
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
            
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        for i = 1:size(trl, 1)
            durations(i) = trl(i,2) - trl(i,1);
        end
        TRL{k,l}    = trl;
        DURATIONS{k,l} = durations;
        
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
        INDEX{k,l} = index;
        TRL_corr{k,l}    = trl;
        DURATIONS_corr{k,l} = durations;
        clear durations trl Vindex index
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for l = 1:length(subjectArray)
    for i = 1:length(RunNum{l})
        PlotRanges{i,l} = 1:(length(DURATIONS{i,l}));
        PlotRanges{i,l}(INDEX{i,l}) = [];
        for j = 1:length(DURATIONS{i,l})
            DURATIONS_sum{i,l}(1,j) = sum(DURATIONS{i,l}(1:j));
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% Dehaene' 1993 paper %%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Concatenate data
D = [];
for i = 1:length(subjectArray)
    for k = 1:length(RunNum{i})
        D = [D ((DURATIONS{k,i}/fsample{i}(k)))];
    end
end
subplot(1,4,1); plot(D); Title('successive ET values');ylabel('error (ms)');

% get histogram profile
T = max(D) - min(D);
subplot(1,4,2); hist(D,length(D)); title('ET histogram');
[n1,xout1] = hist(D,length(D));
subplot(1,4,3); plot(xout1,n1); title('histogram profile');

N = length(D);
Fs = N/T;                     % Sampling frequency
T = 1/Fs;                     % Sample time
L = length(D);                % Length of signal
t = (1:N)*(T/N);              % Time vector
NFFT = 2^nextpow2(L);         % Next power of 2 from length of y
Y = fft(xout1,NFFT)/L;
f = Fs/2*linspace(0,1,NFFT/2+1);
% Plot single-sided amplitude spectrum.
K =  ([1:1:5 4:-1:1])/(sum([1:1:5 4:-1:1]));
P = conv(2*abs(Y(1:NFFT/2+1)),K,'same');

subplot(1,4,4)
loglog(f,P,'linewidth',2)
title('Smoothed single-Sided Amplitude Spectrum of y(t)')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')

