function temprod_ICA_globalview(index,subject,method,threshold)

f = figure;
for i = 2:50
    [rho,pval,observations] = temprod_ICA_statistics(index,subject,i,0,method);
    hold on
    plot(i,rho,'linestyle','none','marker','o')
    f = find(pval <= threshold/i);
    plot(ones(1,length(f))*i,rho(f),'linestyle','none','marker','o','MarkerFaceColor','k')
    for x = 1:length(f)
        text(i+0.4,rho(f(x)),[num2str(i) ',' num2str(f(x))]);
    end
end
line([0 50],[0 0 ]);
xlabel('ICAtotalnumcomp');
ylabel([method ' corr coef']);
% set(f,'PaperPosition','auto')
print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject '/ICA_' method 'corr_bonf' num2str(threshold) '_run' num2str(index) '.png']);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% subfunction %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [rho,pval,observations] = temprod_ICA_statistics(indexrun,subject,numcomponent,show,method)

Dir = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject];

par.ProcDataDir         = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];
load([par.ProcDataDir 'FT_ICs/runica-comp' num2str(numcomponent) '_freq' num2str(indexrun) '.mat']);

% get trial duration order
durinfopath = [Dir '/FT_trials/run' num2str(indexrun) 'durinfo.mat'];
load(durinfopath)
trialduration = [(info(:,2) - info(:,1)) (1:length(info))'];
asc_ord = sortrows(trialduration);

if show == 1
    fig                 = figure('position',[1 1 1280 1024]);
end

% load ICA comps spectra
for i = 1:length(freq.label)
    [MaxPSD(i,:),MaxPSDfreq(i,:)] = max((squeeze(freq.powspctrm(:,i,:)))');
    [R,p] = corr([asc_ord(:,1) freq.freq(MaxPSDfreq(i,:))'],'type',method);
    % linear regression
    observations(i,:) = (freq.freq(MaxPSDfreq(i,:)))';
    regressors = [ones(size(freq.powspctrm,1),1) trialduration(:,1)];
    [RegCoef,confI,Res,ResConfI,Stats] = regress(observations(i,:)',regressors);
    model = RegCoef(1)*(ones(size(freq.powspctrm,1),1))' + (trialduration(:,1)')*RegCoef(2);
    rho(i) = R(1,2);
    pval(i) = p(1,2);
    indexcomp(i) = i;
    Fulldata = sortrows([rho' pval' indexcomp']);
    
    if show == 1
        subplot(5,5,i)
        plot((trialduration(:,1)'),freq.freq(MaxPSDfreq(i,:)),'linestyle','none','marker','.');
        hold on
        plot(asc_ord(:,1),model(asc_ord(:,2)))
        title(['R = ' num2str(R(1,2)) ', pval = ' num2str(p(1,2)) ', comp' num2str(i)])
    end
end
