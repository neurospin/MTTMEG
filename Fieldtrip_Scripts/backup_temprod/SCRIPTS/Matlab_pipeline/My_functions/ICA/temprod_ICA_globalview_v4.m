function temprod_ICA_globalview_v4(index,subject,method,threshold,freqband,K,show)

fig                 = figure('position',[1 1 1280 1024]);
set(fig,'PaperPosition',[1 1 1280 1024])
set(fig,'PaperPositionMode','auto')

subplot(6,9,[1 2 3 10 11 12 19 20 21])
for i = 2:30
    clear rho pval observation regressors model
    [rho,pval,observations,regressors,model,freq] = temprod_ICA_statistics(index,subject,i,0,method,freqband);
    hold on
    plot(i,rho,'linestyle','none','marker','o')
    f{i} = find(pval <= threshold/i);
    plot(ones(1,length(f{i}))*i,rho(f{i}),'linestyle','none','marker','o','MarkerFaceColor','k')
    for x = 1:length(f{i})
        text(i+0.4,rho(f{i}(x)),[num2str(i) ',' num2str(f{i}(x))]);
    end
end
line([0 30],[0 0 ]);
xlabel('ICAtotalnumcomp');
ylabel([method ' corr coef']);
axis([0 31 -1 1])
% set(f,'PaperPosition','auto')
title([num2str(subject) ' run' num2str(index) ' ' num2str(freqband(1)) '-' num2str(freqband(2)) ' Hz band']);
grid('on')

% plot component significativelycorrelated with duration
numplots = 1:54;
numplots([1 2 3 10 11 12 19 20 21]) = [];
a = 0;
for i = 2:30
    clear rho pval observation regressors model
    [rho,pval,observations,regressors,model,freq] = temprod_ICA_statistics(index,subject,i,0,method,freqband);
    f{i} = find(pval <= threshold/i);
    
    %% smooting by convolution
    h =[];
    for x               = 1:size(freq.powspctrm,2)
        g = [];
        for y           = 1:size(freq.powspctrm,3)
            v           = squeeze(freq.powspctrm(:,x,y))';
            F           = conv(v,K,'same');
            g(:,y) = F;
            clear F
        end
        h = cat(3,h,g);
    end
    h = permute(h,[1 3 2]);
    freq.powspctrm = h;
    
    for j = 1:length(f{i})
        a = a +1;
        subplot(6,9,numplots(a)) % power
        imagesc(freq.freq,1:size(freq.powspctrm,1),log(squeeze(freq.powspctrm(:,f{i}(j),:))));
        title(['comp' num2str(i) ',' num2str(f{i}(j)) ' : Pow']);
        ylabel('trials');xlabel('frequency');
        a = a +1;
        subplot(6,9,numplots(a)) % power zscore
        imagesc(freq.freq,1:size(freq.powspctrm,1),zscore(log(squeeze(freq.powspctrm(:,f{i}(j),:))),0,2));
        title(['comp' num2str(i) ',' num2str(f{i}(j)) ' : Z-Pow']);
        ylabel('trials');xlabel('frequency');
        a = a +1;
        s = subplot(6,9,numplots(a)); % correlation
        plot((observations(f{i}(j),:))',regressors(:,2)/250,'linestyle','non','marker','.','markersize',12);
        hold on
        plot(model(f{i}(j),:),(regressors(:,2))/250);
        set(s,'ydir','reverse')
        axis([freqband(1)-0.5 freqband(2)+0.5 min(regressors(:,2)/250) max(regressors(:,2)/250)])
        title(['comp' num2str(i) ',' num2str(f{i}(j)) ' : Freq Peak']);
        ylabel('durations(s)');xlabel('frequency');
    end
end

print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject '/ICAV3_'...
    method 'corr_bonf' num2str(threshold) '_' num2str(freqband(1)) '-' num2str(freqband(2)) '_run' num2str(index) '.png']);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% subfunction %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [rho,pval,observations,regressors,model,freq] = temprod_ICA_statistics(indexrun,subject,numcomponent,show,method,freqbandview)

Dir = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject];

par.ProcDataDir         = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];
load([par.ProcDataDir 'FT_ICs/runica-comp' num2str(numcomponent) 'V4_freq' num2str(indexrun) '.mat']);

% get trial duration order
durinfopath = [Dir '/FT_trials/run' num2str(indexrun) 'durinfo.mat'];
load(durinfopath)
trialduration = [(info(:,2) - info(:,1)) (1:length(info))'];
asc_ord = sortrows(trialduration);

if show == 1
    fig                 = figure('position',[1 1 1280 1024]);
end

% select frequency band
fbegin              = find(freq.freq >= freqbandview(1));
fend                = find(freq.freq <= freqbandview(2));
fband               = fbegin(1):fend(end);
bandFullspctrm      = freq.powspctrm(:,:,fband);
bandFullfreq        = freq.freq(fband);
clear freq.powspctrm freq.freq
freq.powspctrm      = bandFullspctrm;
freq.freq           = bandFullfreq;

% load ICA comps spectra
for i = 1:length(freq.label)
    [MaxPSD(i,:),MaxPSDfreq(i,:)] = max((squeeze(freq.powspctrm(:,i,:)))');
    [R,p] = corr([asc_ord(:,1) freq.freq(MaxPSDfreq(i,:))'],'type',method);
    % linear regression
    observations(i,:) = (freq.freq(MaxPSDfreq(i,:)))';
    regressors = [ones(size(freq.powspctrm,1),1) asc_ord(:,1)];
    P = polyfit(regressors(:,2),observations(i,:)',1);
    model(i,:) = P(2)*(ones(size(freq.powspctrm,1),1))' + (asc_ord(:,1)')*P(1);
    rho(i) = R(1,2);
    pval(i) = p(1,2);
%     indexcomp(i) = i;
%     Fulldata = sortrows([rho' pval' indexcomp']);
    
    if show == 1
        subplot(5,5,i)
        plot((asc_ord(:,1)'),freq.freq(MaxPSDfreq(i,:)),'linestyle','none','marker','.');
        hold on
        plot(asc_ord(:,1),model)
        title(['R = ' num2str(R(1,2)) ', pval = ' num2str(p(1,2)) ', comp' num2str(i)])
    end
end
