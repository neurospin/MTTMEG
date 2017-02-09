function Temprod_GLM3( SubjectArray, RunArray, chantype, freqband, condname, tag)

% set root path
root = SetPath(tag);

%% BUILD VARIABLES
% init loop variables
SUBID       = []; % subject regressor
RUNID       = []; % run regressor
sumrun      = 0;  % cumulative sum of runs
OFFSETPOW   = []; % offset vector for power data
OFFSETFREQ  = []; % offset vector for frequency data
OFFSETSLOPE = []; % offset vector for slope data
lgd         = ['''duration'','];  % legend for futher plotting

for i     = 1:length(SubjectArray) % loop for all subjects
    
    yp          = []; % power data
    yf          = []; % frequency data
    ys          = []; % slope data
    DURREG      = []; % regressor of interest
    ACCREG      = []; % regressor of interest
    MEDREG      = []; % regressor of interest
    
    % init loop variables
    ypoff    = [];
    yfoff    = [];
    ysoff    = [];
    lgd      = [lgd '''SUB' num2str(i) ''','];
    % loop for all runs
    for j = 1:length(RunArray{i,1})
        
        % load data
        ProcDataDir = [root '/DATA/NEW/processed_' char(SubjectArray{i,1}) '/'];
        loadpath = [ProcDataDir 'FT_spectra/POW+FREQ_' chantype '_RUN' num2str(RunArray{i,1}(j),'%02i') ...
            '_' num2str(freqband(1)) '_' num2str(freqband(2)) 'Hz.mat'];
        load(loadpath)
        
        % build 1/dur regressor
        tmp      = []; tmp = sortrows(flipdim(DURATIONSORTED,2));
        tmp2      = zeros(size(DURATIONSORTED,1),length(RunArray{i,1}));
        tmp2(:,j) = 1./tmp(:,2);
        DURREG   = [DURREG ; tmp2];
        
        % build acc regressor
        tmp      = []; tmp = sortrows(flipdim(ACCURACY,2));
        tmp2      = zeros(size(ACCURACY,1),length(RunArray{i,1}));
        tmp2(:,j) = tmp(:,2);
        ACCREG   = [ACCREG ; tmp2];
        
        % build acc regressor
        tmp      = []; tmp = sortrows(flipdim(MEDDEVIATION,2));
        tmp2      = zeros(size(MEDDEVIATION,1),length(RunArray{i,1}));
        tmp2(:,j) = tmp(:,2);
        MEDREG   = [MEDREG ; tmp2];
        
        % compute average power across channels for each trial
        pow = [];
        for k = 1:length(POWER)
            pow = [pow ; POWER{k}];
        end
        yp    = [yp (nanmean(pow))];
        
        % compute average frequency across channels for each trial
        freq = [];
        for k = 1:length(FREQUENCY)
            freq = [freq ; FREQUENCY{k}];
        end
        yf    = [yf (nanmean(freq))];
        
        % compute average slope across channels for each trial
        slope = [];
        for k = 1:length(SLOPE)
            slope = [slope ; SLOPE{k}];
        end
        ys    = [ys (nanmean(slope))];
        
    end
    dur{i}   = DURREG;
    acc{i}   = ACCREG;
    med{i}   = MEDREG;
    powdata{i}   = yp;
    freqdata{i}  = yf;
    slopedata{i} = ys;
end
% lgd = [lgd '''location'',''SouthEastOutside'''];
lgd(end) = [];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i     = 1:length(SubjectArray) % loop for all subjects
    
    %% COMPUTE GLMs
    % on frequency data
    [BfreqvsDUR{i},DEVfreqvsDUR{i},STATSfreqvsDUR{i}] = glmfit(dur{i},freqdata{i},'normal','link','identity','constant','on');
    YHATfreqvsDUR{i}                                  = glmval(BfreqvsDUR{i},dur{i},'identity','constant','on');
    BfreqvsDUR{i}(1)          = [];
    STATSfreqvsDUR{1,i}.p(1)  = [];
    
    [BfreqvsACC{i},DEVfreqvsACC{i},STATSfreqvsACC{i}] = glmfit(acc{i},freqdata{i},'normal','link','identity','constant','on');
    YHATfreqvsACC{i}                                  = glmval(BfreqvsACC{i},acc{i},'identity','constant','on');
    BfreqvsACC{i}(1)          = [];
    STATSfreqvsACC{1,i}.p(1)  = [];
    
    [BfreqvsMED{i},DEVfreqvsMED{i},STATSfreqvsMED{i}] = glmfit(med{i},freqdata{i},'normal','link','identity','constant','on');
    YHATfreqvsMED{i}                                  = glmval(BfreqvsMED{i},med{i},'identity','constant','on');
    BfreqvsMED{i}(1)          = [];
    STATSfreqvsMED{1,i}.p(1)  = [];
    
    % on power data
    [BpowvsDUR{i},DEVpowvsDUR{i},STATSpowvsDUR{i}]    = glmfit(dur{i},powdata{i},'normal','link','identity','constant','on');
    YHATpowvsDUR{i}                                   = glmval(BpowvsDUR{i},dur{i},'identity','constant','on');
    BpowvsDUR{i}(1)          = [];
    STATSpowvsDUR{1,i}.p(1)  = [];
    
    [BpowvsACC{i},DEVpowvsACC{i},STATSpowvsACC{i}]    = glmfit(acc{i},powdata{i},'normal','link','identity','constant','on');
    YHATpowvsACC{i}                                   = glmval(BpowvsACC{i},acc{i},'identity','constant','on');
    BpowvsACC{i}(1)          = [];
    STATSpowvsACC{1,i}.p(1)  = [];
    
    [BpowvsMED{i},DEVpowvsMED{i},STATSpowvsMED{i}]    = glmfit(med{i},powdata{i},'normal','link','identity','constant','on');
    YHATpowvsMED{i}                                   = glmval(BpowvsMED{i},med{i},'identity','constant','on');
    BpowvsMED{i}(1)          = [];
    STATSpowvsMED{1,i}.p(1)  = [];
    
    % one slope data
    [BslopevsDUR{i},DEVslopevsDUR{i},STATSslopevsDUR{i}] = glmfit(dur{i},slopedata{i},'normal','link','identity','constant','on');
    YHATslopevsDUR{i}                                    = glmval(BslopevsDUR{i},dur{i},'identity','constant','on');
    BslopevsDUR{i}(1)          = [];
    STATSslopevsDUR{1,i}.p(1)  = [];
    
    [BslopevsACC{i},DEVslopevsACC{i},STATSslopevsACC{i}] = glmfit(acc{i},slopedata{i},'normal','link','identity','constant','on');
    YHATslopevsACC{i}                                    = glmval(BslopevsACC{i},acc{i},'identity','constant','on');
    BslopevsACC{i}(1)          = [];
    STATSslopevsACC{1,i}.p(1)  = [];
    
    [BslopevsMED{i},DEVslopevsMED{i},STATSslopevsMED{i}] = glmfit(med{i},slopedata{i},'normal','link','identity','constant','on');
    YHATslopevsMED{i}                                    = glmval(BslopevsMED{i},med{i},'identity','constant','on');
    BslopevsMED{i}(1)          = [];
    STATSslopevsMED{1,i}.p(1)  = [];
    
end

for i     = 1:length(SubjectArray) % loop for all subjects
    
    %% PLOT RESULTS
    % set figure parameters
    scrsz = get(0,'ScreenSize');
    fig                 = figure('position',scrsz);
    set(fig,'PaperPosition',scrsz)
    set(fig,'PaperPositionMode','auto')
    set(fig,'visible','on')
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FREQ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % plot predicted and observed
    s2 = subplot(3,8,[1 2 3 4 5]);
    plot(freqdata{i},'color','b'); xlabel('trials');ylabel('frequency (Hz)')
    hold on; plot(YHATfreqvsDUR{i} ,'linewidth',2,'color','r','linestyle',':');
    hold on; plot(YHATfreqvsACC{i} ,'linewidth',2,'color','g','linestyle',':');
    hold on; plot(YHATfreqvsMED{i} ,'linewidth',2,'color','k','linestyle',':');
    legend('observed','predicted(1/DUR)','predicted(ACC)','predicted(MED)');
    title([num2str(freqband(1)) '-' num2str(freqband(2))  'Hz :frequency peaks'])
    
    % plot general fit values
    s3 = subplot(3,8,6);
    bar([BfreqvsDUR{i} BfreqvsACC{i}  BfreqvsMED{i} ]'); title('beta');
    set(s3,'Xtick',1:3,'Xticklabel',{'1/DUR';'ACC';'MED'})
    
    % plot log-pvalues for fit
    s4 = subplot(3,8,7);
    bar(-log([STATSfreqvsDUR{1,i}.p STATSfreqvsACC{1,i}.p STATSfreqvsMED{1,i}.p]'))
    hold on; line([0 size(dur{i},2)],[-log(0.001) -log(0.001)]); text((size(dur{i},2)+1),-log(0.001),'0.001');
    hold on; line([0 size(dur{i},2)],[-log(0.05) -log(0.05)]); text((size(dur{i},2)+1),-log(0.05),'0.05');
    title('log p-values'); set(s4,'Xtick',1:3,'Xticklabel',{'1/DUR';'ACC';'MED'})
    
    % plot deviance values
    s5 = subplot(3,8,8);
    bar([DEVfreqvsDUR{i} DEVfreqvsACC{i} DEVfreqvsMED{i}]'); title('deviance score');
    set(s5,'Xtick',1:3,'Xticklabel',{'1/DUR';'ACC';'MED'})
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% POW %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % plot predicted and observed
    s2 = subplot(3,8,[9 10 11 12 13]);
    plot(powdata{i},'color','b'); xlabel('trials');ylabel('power')
    hold on; plot(YHATpowvsDUR{i} ,'linewidth',2,'color','r','linestyle',':');
    hold on; plot(YHATpowvsACC{i} ,'linewidth',2,'color','g','linestyle',':');
    hold on; plot(YHATpowvsMED{i} ,'linewidth',2,'color','k','linestyle',':');
    legend('observed','predicted(1/DUR)','predicted(ACC)','predicted(MED)');
    title([num2str(freqband(1)) '-' num2str(freqband(2))  'Hz :frequency peaks power'])
    
    % plot general fit values: freq
    s3 = subplot(3,8,14);
    bar([BpowvsDUR{i} BpowvsACC{i}  BpowvsMED{i} ]'); title('beta');
    set(s3,'Xtick',1:3,'Xticklabel',{'1/DUR';'ACC';'MED'})
    
    % plot log-pvalues for fit
    s4 = subplot(3,8,15);
    bar(-log([STATSpowvsDUR{1,i}.p STATSpowvsACC{1,i}.p STATSpowvsMED{1,i}.p]'))
    hold on; line([0 size(dur{i},2)],[-log(0.001) -log(0.001)]); text((size(dur{i},2)+1),-log(0.001),'0.001');
    hold on; line([0 size(dur{i},2)],[-log(0.05) -log(0.05)]); text((size(dur{i},2)+1),-log(0.05),'0.05');
    title('log p-values'); set(s4,'Xtick',1:3,'Xticklabel',{'1/DUR';'ACC';'MED'})
    
    % plot deviance values
    s5 = subplot(3,8,16);
    bar([DEVpowvsDUR{i} DEVpowvsACC{i} DEVpowvsMED{i}]'); title('deviance score');
    set(s5,'Xtick',1:3,'Xticklabel',{'1/DUR';'ACC';'MED'})
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SLOPE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % plot predicted and observed
    s2 = subplot(3,8,[17 18 19 20 21]);
    plot(slopedata{i},'color','b'); xlabel('trials');ylabel('power')
    hold on; plot(YHATslopevsDUR{i} ,'linewidth',2,'color','r','linestyle',':');
    hold on; plot(YHATslopevsACC{i} ,'linewidth',2,'color','g','linestyle',':');
    hold on; plot(YHATslopevsMED{i} ,'linewidth',2,'color','k','linestyle',':');
    legend('observed','predicted(1/DUR)','predicted(ACC)','predicted(MED)');
    title([num2str(freqband(1)) '-' num2str(freqband(2))  'Hz : power spectrum slope'])
    
    % plot general fit values: freq
    s3 = subplot(3,8,22);
    bar([BslopevsDUR{i} BslopevsACC{i}  BslopevsMED{i} ]'); title('beta');
    set(s3,'Xtick',1:3,'Xticklabel',{'1/DUR';'ACC';'MED'})
    
    % plot log-pvalues for fit
    s4 = subplot(3,8,23);
    bar(-log([STATSslopevsDUR{1,i}.p STATSslopevsACC{1,i}.p STATSslopevsMED{1,i}.p]'))
    hold on; line([0 size(dur{i},2)],[-log(0.001) -log(0.001)]); text((size(dur{i},2)+1),-log(0.001),'0.001');
    hold on; line([0 size(dur{i},2)],[-log(0.05) -log(0.05)]); text((size(dur{i},2)+1),-log(0.05),'0.05');
    title('log p-values'); set(s4,'Xtick',1:3,'Xticklabel',{'1/DUR';'ACC';'MED'})
    
    % plot deviance values
    s5 = subplot(3,8,24);
    bar([DEVslopevsDUR{i} DEVslopevsACC{i} DEVslopevsMED{i}]'); title('deviance score');
    set(s5,'Xtick',1:3,'Xticklabel',{'1/DUR';'ACC';'MED'})
    
    % save print
    print('-dpng',[root '/DATA/NEW/plots_' SubjectArray{i} '/GLM_FREQ+POW+SLOPE_v2_'...
        chantype '_' num2str(freqband(1)) '-' num2str(freqband(2)) '_' condname 'Hz.png']);
    
end

save([root '\DATA\NEW\across_subjects_data\GLMbetas_'...
    chantype '_' num2str(freqband(1)) '-' num2str(freqband(2)) 'Hz_' condname],...
    'BfreqvsDUR' ,'BfreqvsMED' ,'BfreqvsACC' ,...
    'BpowvsDUR'  ,'BpowvsMED'  ,'BpowvsACC'  ,...
    'BslopevsDUR','BslopevsMED','BslopevsACC',...
    'DEVfreqvsDUR' ,'DEVfreqvsMED' ,'DEVfreqvsACC' ,...
    'DEVpowvsDUR'  ,'DEVpowvsMED'  ,'DEVpowvsACC'  ,...
    'DEVslopevsDUR','DEVslopevsMED','DEVslopevsACC')
