function  [med,meAn,SD,meAnnorm,DURATIONS_corr] = temprod_BehaviorSummary(subject,RunNum,fsample,TD,tag)

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

%% normalization part %%

FULLDUR               = [];
nmin                  = inf;
nmax                  = -inf;
mmin                  = inf;
mmax                  = -inf;
for k = 1:length(RunNum)
    DURATIONS_norm{k} = (DURATIONS_corr{k} - mean(DURATIONS_corr{k}))/std(DURATIONS_corr{k});
    FULLDUR           = [FULLDUR DURATIONS_norm{k}];
    eval(['[n' num2str(k) ',m' num2str(k) '] = hist(DURATIONS_corr{'...
    num2str(k) '}/fsample(' num2str(k) '),length(DURATIONS_norm{' num2str(k) '})/2);']);
    eval(['nmin = min([n' num2str(k) ',nmin]);']);
    eval(['nmax = max([n' num2str(k) ',nmax]);']);
    eval(['mmin = min([m' num2str(k) ',mmin]);']);
    eval(['mmax = max([m' num2str(k) ',mmax]);']);
end

CI = 1:length(RunNum);                % ascending order of targeted durations

fig                 = figure('position',[1 1 1280 1024]);
set(fig,'PaperPosition',[1 1 1280 1024])
set(fig,'PaperPositionMode','auto')
%% Temporal estimates distribution
% set axes
% for i = RunNum
%     Maxes(i) = max(DURATIONS_norm{CI(i)});
%     maxes(i) = min(DURATIONS_norm{CI(i)});
% end

for i = 1:length(RunNum)
    subplot(4,6,i)
    hist(DURATIONS_corr{CI(i)}/fsample(i),length(DURATIONS_norm{CI(i)})/2)
    title(['cond' num2str(i)]); H = get(gca);
    hold on
    med(i) = median(DURATIONS_corr{CI(i)}/fsample(i));
    mednorm(i) = med(i)/TD(i);
    meAn(i) = mean(DURATIONS_corr{CI(i)}/fsample(i));
    SD(i)  = std(DURATIONS_corr{CI(i)}/fsample(i));
    meAnnorm(i) = SD(i)/meAn(i);
    SDnorm(i) = 100 - (TD(i) - SD(i))*100/TD(i);
    SDcorr(i) = SD(i)/med(i);
    Terror(i) = 100 + (med(i) - TD(i))*100/TD(i);
    x(i) = med(i)/TD(i);
    line([med(i) med(i)],[0 nmax],'color','g','linewidth',1);
    line([TD(i) TD(i)],[0 nmax],'color','r','linewidth',1);
    
    axis([mmin mmax nmin nmax])
    
    xlabel('durations (s)')
    ylabel('counts')
end

%% plot normalized histograms and gamma fit
for i                   = 1:length(RunNum)
    subplot(4,6,i+6)
    [n_in_bins,nb_bins] = hist(DURATIONS_corr{CI(i)}/fsample(i),length(DURATIONS_norm{CI(i)})/2);
    n_in_bins_norm      = n_in_bins/sum(n_in_bins.*nb_bins); % normalise, so that area in histogram is 1
    bar(nb_bins,n_in_bins_norm);
    xlabel('durations (ms)');
    ylabel('normalised counts');
    
%     axis([3 12 0 0.03]);
    
    fit_all             = gamfit(DURATIONS_corr{CI(i)}/fsample(i)); % fit the gamma function to the raw rt data
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
    
    title(['gamfit : ' num2str(RSquare1)]);
    
%     axis([mmin mmax nmin nmax])
end

%% Basic stats across conditions
c = colormap(lines(6));

subplot(4,6,19); hist(FULLDUR,length(FULLDUR)); title('All z-scores')

for i = 1:length(RunNum)
    subplot(4,6,20); plot(i,meAn(i),'marker','o','linestyle','none','color',c(i,:)); 
    ylabel('mean');
    axis([0 7 min(meAn - SD)*0.8 max(meAn + SD)*1.2]);
    hold on
    errorbar(i,meAn(i),SD(i),'linestyle','none','color',c(i,:))
end

for i = 1:length(RunNum)
    subplot(4,6,21); plot(i,med(i),'marker','o','linestyle','none','color',c(i,:)); 
    ylabel('median');
    hold on
    axis([0 7 min(med - SD)*0.8 max(med + SD)*1.2]);
    errorbar(i,med(i),SD(i),'linestyle','none','color',c(i,:))
end

subplot(4,6,22)
for i = 1:length(RunNum)
    plot(i,SD(i),'marker','o','linestyle','none','color',c(i,:)); 
    ylabel('std')
    hold on
    axis([0 7 min(SD)*0.8 max(SD)*1.2])
end

subplot(4,6,23)
for i = 1:length(RunNum)
    plot(i,meAnnorm(i),'marker','o','linestyle','none','color',c(i,:))
    hold on
    ylabel('std/mean');
    axis([0 7 min(meAnnorm)*0.8 max(meAnnorm)*1.2])
end


%% plot reponse times across acquisition

for i = 1:length(RunNum)
    PlotRanges{i} = 1:(length(DURATIONS{i}));
    PlotRanges{i}(INDEX{i}) = [];
    for j = 1:length(DURATIONS{i})
        DURATIONS_sum{i}(1,j) = sum(DURATIONS{i}(1:j));
    end
    for k = 1:length(DURATIONS_corr{i})
        DURATIONS_corr_sum{i}(1,k) = sum(DURATIONS_corr{i}(1:k));
    end
end

for i = 1:length(RunNum)
    xmin(i) = min((DURATIONS_sum{i})/fsample(i));
    xmax(i) = max((DURATIONS_sum{i})/fsample(i));
    ymin(i) = min((DURATIONS{i})/fsample(i));
    ymax(i) = max((DURATIONS{i})/fsample(i));
end

for i = 1:length(RunNum)
    subplot(4,6,i+12)
    plot((DURATIONS_sum{i})/fsample(i),(DURATIONS{i})/fsample(i))
    hold on
    plot((DURATIONS_sum{i}(PlotRanges{i}))/fsample(i),(DURATIONS_corr{i})/fsample(i),'linewidth',1,'color','r')
    ylabel('duration (s)')
    xlabel('acquisition time (s)')
    
%     line([(DURATIONS_sum{i}(1))/fsample(i) mean((DURATIONS_corr{i})/fsample(i))],...
%          [(DURATIONS_sum{i}(end))/fsample(i) mean((DURATIONS_corr{i})/fsample(i))],'linewidth',1,'color','k') 
    
    axis([min(xmin) max(xmax) min(ymin) max(ymax)]);
end

print('-r0','-dpng',[root '\DATA\NEW/Plots_' subject '/behavioral.png']);








