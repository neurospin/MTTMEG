%% temprod behavioural analysis
clear all
close all

%% set path %%
addpath '/neurospin/local/mne/i686/share/matlab/'                               % MNE path
addpath '/neurospin/meg_tmp/tools_tmp/pipeline/'                                % path to reference processing scripts
addpath '/neurospin/meg_tmp/temprod_Baptiste_2010/SCRIPTS/Temprod_ft_pipeline/my_pipeline'
fieldtrip
fieldtripdefs                                                                   % fieldtrip path

%% set parameters %%
DataDir             = '/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Trans_sss_s03/';    
RunNum              = [1 11 2 3 31 4 5 6];

%% main script
for i               = 1:length(RunNum)
    DATASETS{i}     = [DataDir 's03_run' num2str(RunNum(i)) '_raw_sss.fif'];
    events          = ft_read_event(DATASETS{i} );
    value           = [events(find(strcmp('STI101', {events.type}))).value]';
    sample          = [events(find(strcmp('STI101', {events.type}))).sample]';
    VALUES{i}       = value;
    SAMPLES{i}      = sample;
end

SAMPLES{1} = [SAMPLES{1} ; SAMPLES{2}];
SAMPLES{4} = [SAMPLES{4} ; SAMPLES{5}];
VALUES{1}  = [VALUES{1} ; VALUES{2}];
VALUES{4}  = [VALUES{4} ; VALUES{5}];

SAMPLE{1}  = SAMPLES{1}; SAMPLE{2} = SAMPLES{3}; SAMPLE{3} = SAMPLES{4};
SAMPLE{4}  = SAMPLES{6}; SAMPLE{5} = SAMPLES{7}; SAMPLE{6} = SAMPLES{8};
VALUE{1}   = VALUES{1};  VALUE{2}  = VALUES{3};  VALUE{3}  = VALUES{4};
VALUE{4}   = VALUES{6};  VALUE{5}  = VALUES{7};  VALUE{6}  = VALUES{8};

SAMPLE{1,1}(120:235) = SAMPLE{1,1}(120:235) + ones(116,1)*SAMPLE{1,1}(119);
SAMPLE{1,3}(196:246) = SAMPLE{1,3}(196:246) + ones(51,1)*SAMPLE{1,3}(195);

clear SAMPLES VALUES sample value

for k = 1:6
    value   = VALUE{k};
    sample  = SAMPLE{k};
    a = 0;
    for i = 1:2
        if (value(i) == 1) || (value(i) == 2) || (value(i) == 3) || (value(i) == 4) || (value(i) == 5) || (value(i) == 6) 
            trl(1,1) = sample(i) ;
            trl(1,2) = sample(i+2);
            trl(1,3) = 0; 
            a = 1;
        end
    end

    for i = 2:(size(value,1)-3)
        if (value(i) == 16395) || (value(i) == 16396) || (value(i) == 16397) || (value(i) == 16398) || (value(i) == 16399) || (value(i) == 16400)    
            a = a + 1;
            trl(a,1) = sample(i) ;
            trl(a,2) = sample(i+3);
            trl(a,3) = 0;  
            if trl(a,2) - trl(a,1) < 2000
                trl(a,1) = sample(i) ;
                trl(a,2) = sample(i+5);
                trl(a,3) = 0;
            end
        end
    end

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
    
    TRL_corr{k}    = trl;
    DURATIONS_corr{k} = durations;
end
    
%% normalization part %%

for k = 1:6
    DURATIONS_norm{k} = (DURATIONS_corr{k} - mean(DURATIONS_corr{k}))/std(DURATIONS_corr{k});
end

FULLDUR = [DURATIONS_norm{1} DURATIONS_norm{2} DURATIONS_norm{3} ...
      DURATIONS_norm{4} DURATIONS_norm{5} DURATIONS_norm{6}];

[n2,m2] = hist(DURATIONS_norm{2},length(DURATIONS_norm{2})/3);
[n5,m5] = hist(DURATIONS_norm{5},length(DURATIONS_norm{5})/3);
[n4,m4] = hist(DURATIONS_norm{4},length(DURATIONS_norm{4})/3);
[n6,m6] = hist(DURATIONS_norm{6},length(DURATIONS_norm{6})/3);
[n3,m3] = hist(DURATIONS_norm{3},length(DURATIONS_norm{3})/3);
[n1,m1] = hist(DURATIONS_norm{1},length(DURATIONS_norm{1})/3);
nmin = min([n1,n2,n3,n4,n5,m6]);
mmin = min([m1,m2,m3,m4,m5,m6]);
nmax = max([n1,n2,n3,n4,n5,m6]);
mmax = max([m1,m2,m3,m4,m5,m6]);

CI = [2 5 4 6 3 1];                % ascending order of targeted durations
TD = [0.75 1.7 2.8 5.2 11.7 17.3]; % targeted durations

figure
%% Temporal estimates distribution
for i = 1:6
    subplot(4,6,i)
    hist(DURATIONS_corr{CI(i)}/2000,length(DURATIONS_norm{CI(i)})/3)
    % axis([-max([abs(mmin) mmax]) max([abs(mmin) mmax]) 0 nmax]);
    title(['temporal estimate cond' num2str(i)]); H = get(gca);
    hold on
    med(i) = median(DURATIONS_corr{CI(i)}/2000);
    mednorm(i) = med(i)/TD(i);
    SD(i)  = std(DURATIONS_corr{CI(i)}/2000);
    SDnorm(i) = 100 - (TD(i) - SD(i))*100/TD(i);
    SDcorr(i) = SD(i)/med(i);
    Terror(i) = 100 + (med(i) - TD(i))*100/TD(i);
    x(i) = med(i)/TD(i);
    line([med(i) med(i)],[H.YLim(1) H.YLim(2)],'color','g','linewidth',2);
    line([TD(i) TD(i)],[H.YLim(1) H.YLim(2)],'color','r','linewidth',2);
    xlabel(['Target = ' num2str(TD(i)) 's, median = ' num2str(median(DURATIONS_corr{CI(i)}/2000)) 's'])
end

%% Z-score distribution
for i = 1:6
    subplot(4,6,6+i)
    hist(DURATIONS_norm{CI(i)},length(DURATIONS_norm{CI(i)})/3)
    axis([-max([abs(mmin) mmax]) max([abs(mmin) mmax]) 0 nmax]);
    title(['z-scores cond' num2str(i)]);
end

%% Basic stats across conditions
subplot(4,6,13); hist(FULLDUR,length(FULLDUR)); title('All z-scores')
subplot(4,6,14); plot(TD,med,'marker','o'); title('median')
subplot(4,6,15); plot(TD,SD,'marker','o'); title('std')
subplot(4,6,16); plot(TD,Terror,'marker','o'); title('median as % of Target')
subplot(4,6,17); plot(TD,SDnorm,'marker','o'); title('std as % of target')

%% plot normalized histograms and gamma fit
fig                     = figure('position',[1 1 1280 1024]);
for i                   = 1:6
    subplot(2,3,i)
    [n_in_bins,nb_bins] = hist(DURATIONS_corr{CI(i)}/2000,length(DURATIONS_norm{CI(i)})/3);
    n_in_bins_norm      = n_in_bins/sum(n_in_bins.*nb_bins); % normalise, so that area in histogram is 1
    bar(nb_bins,n_in_bins_norm);
    xlabel('RT (ms)');
    ylabel('normalised');
    
    fit_all             = gamfit(DURATIONS_corr{CI(i)}/2000); % fit the gamma function to the raw rt data
    fitted_data         = gampdf(nb_bins,fit_all(1),fit_all(2)); % get the fitted gamma pdf, in the range of the x_bins
    [fitted_mean, fitted_variance] = gamstat(fit_all(1),fit_all(2)); % get mean and variance of fit
    fitted_data_norm    = fitted_data/sum(fitted_data.*nb_bins); % normalise, so that area in histogram is 1
    
    hold on; plot(nb_bins,fitted_data_norm,'r','LineWidth',2)
    
    % calculate goodness of fit
    
    SSE1 = n_in_bins_norm - fitted_data_norm;
    SSE1 = SSE1.^2;
    SSE1 = sum(SSE1);
    SST1 = n_in_bins_norm - mean(n_in_bins_norm);
    SST1 = SST1.^2;
    SST1 = sum(SST1);
    RSquare1 = 1- (SSE1/SST1);
    
    legend(sprintf('a: %2.2f, b: %2.2f, R: %2.4f',fit_all(1),fit_all(2),RSquare1));
end
