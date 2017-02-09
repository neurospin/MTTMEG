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
DataDir             = '/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Trans_sss_s04/';
RunNum              = [1 2 3];
fsample             = 1000;

%% main script
for i               = RunNum
    DATASETS{i}     = [DataDir 's04_run' num2str(RunNum(i)) '_raw_sss.fif'];
    events          = ft_read_event(DATASETS{i} );
    value           = [events(find(strcmp('STI101', {events.type}))).value]';
    sample          = [events(find(strcmp('STI101', {events.type}))).sample]';
    VALUE{i}       = value;
    SAMPLE{i}      = sample;
    clear value sample
end

for k = RunNum
    value   = VALUE{k};
    sample  = SAMPLE{k};
    Vindex = find(value(1:length(value)) == 16384);
    for i = 2:length(Vindex)
        trl(i-1,1) = sample(Vindex(i-1));
        trl(i-1,2) = sample(Vindex(i));
        trl(i-1,3) = 0;
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
    lower_inner_fence   = q1 - 3*myiqr;
    upper_inner_fence   = q3 + 3*myiqr;
    
    index = [];
    if k <= 3
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

%% normalization part %%

for k = RunNum
    DURATIONS_norm{k} = (DURATIONS_corr{k} - mean(DURATIONS_corr{k}))/std(DURATIONS_corr{k});
end

FULLDUR = [DURATIONS_norm{1} DURATIONS_norm{2} DURATIONS_norm{3}];

[n1,m1] = hist(DURATIONS_norm{1},length(DURATIONS_norm{1})/3);
[n2,m2] = hist(DURATIONS_norm{2},length(DURATIONS_norm{2})/3);
[n3,m3] = hist(DURATIONS_norm{3},length(DURATIONS_norm{3})/3);

nmin = min([n1,n2,n3]);
mmin = min([m1,m2,m3]);
nmax = max([n1,n2,n3]);

CI = RunNum;                % ascending order of targeted durations
TD = [5.7 12.8 9.3];         % targeted durations

fig                        = figure('position',[1 1 1280 1024]);
%% Temporal estimates distribution
for i =RunNum
    subplot(4,4,i)
    hist(DURATIONS_corr{CI(i)}/1000,length(DURATIONS_norm{CI(i)})/3)
%     axis([3 12 0 12]);
    title(['temporal estimates cond' num2str(i)]); H = get(gca);
    hold on
    med(i) = median(DURATIONS_corr{CI(i)}/1000);
    mednorm(i) = med(i)/TD(i);
    meAn(i) = mean(DURATIONS_corr{CI(i)}/1000);
    SD(i)  = std(DURATIONS_corr{CI(i)}/1000);
    meAnnorm(i) = SD(i)/meAn(i);
    SDnorm(i) = 100 - (TD(i) - SD(i))*100/TD(i);
    SDcorr(i) = SD(i)/med(i);
    Terror(i) = 100 + (med(i) - TD(i))*100/TD(i);
    x(i) = med(i)/TD(i);
    line([med(i) med(i)],[H.YLim(1) H.YLim(2)],'color','g','linewidth',2);
%     if k <= 3
        line([TD(i) TD(i)],[H.YLim(1) H.YLim(2)],'color','r','linewidth',2);
%     end
    xlabel(['Target = ' num2str(TD(i)) 's, median = ' num2str(median(DURATIONS_corr{CI(i)}/1000)) 's'])
end

%% plot normalized histograms and gamma fit
for i                   = RunNum
    subplot(4,4,i+4)
    [n_in_bins,nb_bins] = hist(DURATIONS_corr{CI(i)}/1000,length(DURATIONS_norm{CI(i)})/3);
    n_in_bins_norm      = n_in_bins/sum(n_in_bins.*nb_bins); % normalise, so that area in histogram is 1
    bar(nb_bins,n_in_bins_norm);
    xlabel('RT (ms)');
    ylabel('normalised');
%     axis([3 12 0 0.025]);
    
    fit_all             = gamfit(DURATIONS_corr{CI(i)}/1000); % fit the gamma function to the raw rt data
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

%% Basic stats across conditions
subplot(4,4,13); hist(FULLDUR,length(FULLDUR)); title('All z-scores')
subplot(4,4,14); plot([1 2 3],meAn(RunNum),'marker','o','linestyle','none'); ylabel('mean'); axis([0 4 0 20]);
hold on 
errorbar([1 2 3],meAn(RunNum),SD(RunNum),'linestyle','none')
subplot(4,4,15); plot([1 2 3],meAnnorm(RunNum),'marker','o','linestyle','none'); ylabel('std/mean'); axis([0 4 0 0.4])

%% plot reponse times across acquisition

for i = RunNum
    PlotRanges{i} = 1:(length(DURATIONS{i}));
    PlotRanges{i}(INDEX{i}) = [];
    for j = 1:length(DURATIONS{i})
        DURATIONS_sum{i}(1,j) = sum(DURATIONS{i}(1:j));
    end
    for k = 1:length(DURATIONS_corr{i})
        DURATIONS_corr_sum{i}(1,k) = sum(DURATIONS_corr{i}(1:k));
    end
end

for i = RunNum
    subplot(4,4,i+8)
    plot((DURATIONS_sum{i})/fsample,(DURATIONS{i})/fsample)
    hold on
    plot((DURATIONS_sum{i}(PlotRanges{i}))/fsample,(DURATIONS_corr{i})/fsample,'linewidth',2,'color','r')
%     axis([1 (max([max(DURATIONS_sum{1}) length(DURATIONS_sum{2}) length(DURATIONS_sum{3})]))/fsample...
%     3 12]);
    ylabel('duration')
    xlabel('acquisition time')
end

print('-r0','-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_s04/behavioral.png']);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig                        = figure('position',[1 1 1280 1024]);
for i = RunNum
    subplot(4,4,i+4)
    plot((DURATIONS_sum{i})/fsample,zscore((DURATIONS{i})/fsample),0,2,'linewidth',2,'color','k')
    subplot(4,4,i+8)
    plot((DURATIONS_sum{i}(PlotRanges{i}))/fsample,zscore((DURATIONS_corr{i})/fsample,0,2),'linewidth',2,'color','r')
%     axis([1 (max([max(DURATIONS_sum{1}) length(DURATIONS_sum{2}) length(DURATIONS_sum{3})]))/fsample...
%     3 12]);
    ylabel('duration zscore')
    xlabel('acquisition time')
end


fig                        = figure('position',[1 1 1280 1024]);
for i = RunNum
    plot((DURATIONS_sum{i})/fsample,((DURATIONS{i})/fsample),'linewidth',2,'color','k')
    hold on
    plot((DURATIONS_sum{i}(PlotRanges{i}))/fsample,((DURATIONS_corr{i})/fsample),'linewidth',2,'color','r')
%     axis([1 (max([max(DURATIONS_sum{1}) length(DURATIONS_sum{2}) length(DURATIONS_sum{3})]))/fsample...
%     3 12]);
    ylabel('duration zscore')
    xlabel('acquisition time')
    hold on  
end



