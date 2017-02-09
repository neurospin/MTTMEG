function [freqref,data_output_4m1,data_output_3m2] = GDAVG_half_quarter(subjects,freqbandselect,cond,tag)

% set root
root = SetPath(tag);

% prepare figure
scrsz = get(0,'ScreenSize');
fig                 = figure('position',scrsz);
set(fig,'PaperPosition',scrsz)
set(fig,'PaperPositionMode','auto')

% set colormap
c = colormap('jet');
C = c(1:round(60/length(subjects)):60,:);

% init legend
leg = [];
condsub = [];

for i = 1:length(subjects)
    
    condsub = [condsub '_' subjects{i}];
    
    % set paths
    Dir = [root '/DATA/NEW/processed_' subjects{i}];
    chantypefull  = {'Mags';'Gradslong';'Gradslat'};
    
    % load data
    datapath               = TheSlasher([Dir '/FT_spectra/QuarterCutFreqGAVG_' cond '_1-120_nodetrend.mat'],tag);
    datapath               = TheSlasher(datapath,tag);
    load(datapath,'Part1FreqGAVG','Part2FreqGAVG','Part3FreqGAVG','Part4FreqGAVG');
    
    % select frequency band
    fbegin                = find(Part1FreqGAVG{1,1}.freq >= freqbandselect(1));
    fend                  = find(Part1FreqGAVG{1,1}.freq <= freqbandselect(2));
    fband                 = fbegin(1):fend(end);
    
    Part1FreqGAVG{1,1}.powspctrm        = Part1FreqGAVG{1,1}.powspctrm(:,fband);
    Part1FreqGAVG{1,1}.freq             = Part1FreqGAVG{1,1}.freq(fband);
    Part1FreqGAVG{1,2}.powspctrm        = Part1FreqGAVG{1,2}.powspctrm(:,fband);
    Part1FreqGAVG{1,2}.freq             = Part1FreqGAVG{1,2}.freq(fband);
    Part1FreqGAVG{1,3}.powspctrm        = Part1FreqGAVG{1,3}.powspctrm(:,fband);
    Part1FreqGAVG{1,3}.freq             = Part1FreqGAVG{1,3}.freq(fband);
    
    Part2FreqGAVG{1,1}.powspctrm        = Part2FreqGAVG{1,1}.powspctrm(:,fband);
    Part2FreqGAVG{1,1}.freq             = Part2FreqGAVG{1,1}.freq(fband);
    Part2FreqGAVG{1,2}.powspctrm        = Part2FreqGAVG{1,2}.powspctrm(:,fband);
    Part2FreqGAVG{1,2}.freq             = Part2FreqGAVG{1,2}.freq(fband);
    Part2FreqGAVG{1,3}.powspctrm        = Part2FreqGAVG{1,3}.powspctrm(:,fband);
    Part2FreqGAVG{1,3}.freq             = Part2FreqGAVG{1,3}.freq(fband);
    
    Part3FreqGAVG{1,1}.powspctrm        = Part3FreqGAVG{1,1}.powspctrm(:,fband);
    Part3FreqGAVG{1,1}.freq             = Part3FreqGAVG{1,1}.freq(fband);
    Part3FreqGAVG{1,2}.powspctrm        = Part3FreqGAVG{1,2}.powspctrm(:,fband);
    Part3FreqGAVG{1,2}.freq             = Part3FreqGAVG{1,2}.freq(fband);
    Part3FreqGAVG{1,3}.powspctrm        = Part3FreqGAVG{1,3}.powspctrm(:,fband);
    Part3FreqGAVG{1,3}.freq             = Part3FreqGAVG{1,3}.freq(fband);
    
    Part4FreqGAVG{1,1}.powspctrm        = Part4FreqGAVG{1,1}.powspctrm(:,fband);
    Part4FreqGAVG{1,1}.freq             = Part4FreqGAVG{1,1}.freq(fband);
    Part4FreqGAVG{1,2}.powspctrm        = Part4FreqGAVG{1,2}.powspctrm(:,fband);
    Part4FreqGAVG{1,2}.freq             = Part4FreqGAVG{1,2}.freq(fband);
    Part4FreqGAVG{1,3}.powspctrm        = Part4FreqGAVG{1,3}.powspctrm(:,fband);
    Part4FreqGAVG{1,3}.freq             = Part4FreqGAVG{1,3}.freq(fband);    
    
    freqref = Part1FreqGAVG{1,3}.freq;
    
    MaxMags  = max([max(mean((Part1FreqGAVG{1,1}.powspctrm))) ...
                   max(mean((Part2FreqGAVG{1,1}.powspctrm))) ...
                   max(mean((Part3FreqGAVG{1,1}.powspctrm))) ...
                   max(mean((Part4FreqGAVG{1,1}.powspctrm)))]) ;
    MinMags  = min([min(mean((Part1FreqGAVG{1,1}.powspctrm))) ...
                   min(mean((Part2FreqGAVG{1,1}.powspctrm))) ...
                   min(mean((Part3FreqGAVG{1,1}.powspctrm))) ...
                   min(mean((Part4FreqGAVG{1,1}.powspctrm)))]) ;
    MaxGrads = max([max(mean((Part1FreqGAVG{1,2}.powspctrm))) ...
                   max(mean((Part2FreqGAVG{1,2}.powspctrm))) ...
                   max(mean((Part3FreqGAVG{1,2}.powspctrm))) ...
                   max(mean((Part4FreqGAVG{1,2}.powspctrm)))]) ;
    MinGrads = min([min(mean((Part1FreqGAVG{1,2}.powspctrm))) ...
                   min(mean((Part2FreqGAVG{1,2}.powspctrm))) ...
                   min(mean((Part3FreqGAVG{1,2}.powspctrm))) ...
                   min(mean((Part4FreqGAVG{1,2}.powspctrm)))]) ;
    
    % plot data
    
    % MAGs
    subplot(3,5,1)
    semilogx(Part1FreqGAVG{1,1}.freq,squeeze(mean(Part1FreqGAVG{1,1}.powspctrm)),...
        'color',C(i,:),'linewidth',2)
    grid('on')
    set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
    title('MAGs: Q1 trials')
    hold on;
    axis([freqbandselect(1) freqbandselect(2) MinMags*1.5 MaxMags*1.5])
    
    subplot(3,5,2)
    semilogx(Part2FreqGAVG{1,1}.freq,squeeze(mean(Part2FreqGAVG{1,1}.powspctrm)),...
        'color',C(i,:),'linewidth',2)
    grid('on')
    set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
    title('MAGs: Q2 trials')
    hold on;
    axis([freqbandselect(1) freqbandselect(2) MinMags*1.5 MaxMags*1.5])
    
    subplot(3,5,3)
    semilogx(Part3FreqGAVG{1,1}.freq,squeeze(mean(Part3FreqGAVG{1,1}.powspctrm)),...
        'color',C(i,:),'linewidth',2)
    grid('on')
    set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
    title('MAGs: Q3 trials')
    hold on;
    axis([freqbandselect(1) freqbandselect(2) MinMags*1.5 MaxMags*1.5])
    
    subplot(3,5,4)
    semilogx(Part4FreqGAVG{1,1}.freq,squeeze(mean(Part4FreqGAVG{1,1}.powspctrm)),...
        'color',C(i,:),'linewidth',2)
    grid('on')
    set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
    title('MAGs: Q4 trials')
    hold on;
    axis([freqbandselect(1) freqbandselect(2) MinMags*1.5 MaxMags*1.5])    
    
    % GRADs1
    subplot(3,5,6)
    semilogx(Part1FreqGAVG{1,2}.freq,squeeze(mean(Part1FreqGAVG{1,2}.powspctrm)),...
        'color',C(i,:),'linewidth',2)
    grid('on')
    set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
    title('GRADs1: Q1 trials')
    hold on;
    axis([freqbandselect(1) freqbandselect(2) MinGrads*1.5 MaxGrads*1.5])
    
    subplot(3,5,7)
    semilogx(Part2FreqGAVG{1,2}.freq,squeeze(mean(Part2FreqGAVG{1,2}.powspctrm)),...
        'color',C(i,:),'linewidth',2)
    grid('on')
    set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
    title('GRADs1: Q2 trials')
    hold on;
    axis([freqbandselect(1) freqbandselect(2) MinGrads*1.5 MaxGrads*1.5])
    
    subplot(3,5,8)
    semilogx(Part3FreqGAVG{1,2}.freq,squeeze(mean(Part3FreqGAVG{1,2}.powspctrm)),...
        'color',C(i,:),'linewidth',2)
    grid('on')
    set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
    title('GRADs1: Q3 trials')
    hold on;
    axis([freqbandselect(1) freqbandselect(2) MinGrads*1.5 MaxGrads*1.5])
    
    subplot(3,5,9)
    semilogx(Part4FreqGAVG{1,2}.freq,squeeze(mean(Part4FreqGAVG{1,2}.powspctrm)),...
        'color',C(i,:),'linewidth',2)
    grid('on')
    set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
    title('GRADs1: Q4 trials')
    hold on;
    axis([freqbandselect(1) freqbandselect(2) MinGrads*1.5 MaxGrads*1.5])    
    
    
    % GRADs2
    subplot(3,5,11)
    semilogx(Part1FreqGAVG{1,2}.freq,squeeze(mean(Part1FreqGAVG{1,3}.powspctrm)),...
        'color',C(i,:),'linewidth',2)
    grid('on')
    set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
    title('GRADs2: Q1 trials')
    hold on;
    axis([freqbandselect(1) freqbandselect(2) MinGrads*1.5 MaxGrads*1.5])
    
    subplot(3,5,12)
    semilogx(Part2FreqGAVG{1,2}.freq,squeeze(mean(Part2FreqGAVG{1,3}.powspctrm)),...
        'color',C(i,:),'linewidth',2)
    grid('on')
    set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
    title('GRADs2: Q2 trials')
    hold on;
    axis([freqbandselect(1) freqbandselect(2) MinGrads*1.5 MaxGrads*1.5])
    
    subplot(3,5,13)
    semilogx(Part3FreqGAVG{1,2}.freq,squeeze(mean(Part3FreqGAVG{1,3}.powspctrm)),...
        'color',C(i,:),'linewidth',2)
    grid('on')
    set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
    title('GRADs2: Q3 trials')
    hold on;
    axis([freqbandselect(1) freqbandselect(2) MinGrads*1.5 MaxGrads*1.5])
    
    subplot(3,5,14)
    semilogx(Part4FreqGAVG{1,2}.freq,squeeze(mean(Part4FreqGAVG{1,3}.powspctrm)),...
        'color',C(i,:),'linewidth',2)
    grid('on')
    set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
    title('GRADs2: Q4 trials')
    hold on;
    axis([freqbandselect(1) freqbandselect(2) MinGrads*1.5 MaxGrads*1.5])    
    
    % concatenate data
    Q1FPowAllSub_mags(i,:,:)   =  Part1FreqGAVG{1,1}.powspctrm;
    Q1FPowAllSub_grads1(i,:,:) =  Part1FreqGAVG{1,2}.powspctrm;
    Q1FPowAllSub_grads2(i,:,:) =  Part1FreqGAVG{1,3}.powspctrm;
    Q2FPowAllSub_mags(i,:,:)   =  Part2FreqGAVG{1,1}.powspctrm;
    Q2FPowAllSub_grads1(i,:,:) =  Part2FreqGAVG{1,2}.powspctrm;
    Q2FPowAllSub_grads2(i,:,:) =  Part2FreqGAVG{1,3}.powspctrm;
    Q3FPowAllSub_mags(i,:,:)   =  Part3FreqGAVG{1,1}.powspctrm;
    Q3FPowAllSub_grads1(i,:,:) =  Part3FreqGAVG{1,2}.powspctrm;
    Q3FPowAllSub_grads2(i,:,:) =  Part3FreqGAVG{1,3}.powspctrm;
    Q4FPowAllSub_mags(i,:,:)   =  Part4FreqGAVG{1,1}.powspctrm;
    Q4FPowAllSub_grads1(i,:,:) =  Part4FreqGAVG{1,2}.powspctrm;
    Q4FPowAllSub_grads2(i,:,:) =  Part4FreqGAVG{1,3}.powspctrm;    
    
end

if size(Q1FPowAllSub_mags,1) ~= 1
    
    % AVG MAGs
    subplot(3,5,5)
    semilogx(Part1FreqGAVG{1,2}.freq,squeeze(mean(mean(Q1FPowAllSub_mags(:,:,:)))),'color',[0 0 1],'linewidth',2);
    hold on
    semilogx(Part1FreqGAVG{1,2}.freq,squeeze(mean(mean(Q2FPowAllSub_mags(:,:,:)))),'color',[0.33 0 0.66],'linewidth',2);
    hold on
    semilogx(Part1FreqGAVG{1,2}.freq,squeeze(mean(mean(Q3FPowAllSub_mags(:,:,:)))),'color',[0.66 0 0.33],'linewidth',2);
    hold on
    semilogx(Part1FreqGAVG{1,2}.freq,squeeze(mean(mean(Q4FPowAllSub_mags(:,:,:)))),'color',[1 0 0],'linewidth',2);
    hold on    
    
    axis([freqbandselect(1) freqbandselect(2) MinMags MaxMags])
    set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
    grid('on')
    legend('Q1','Q2','Q3','Q4')
    Title('MAGs: average across subjects')
    
    % AVG GRADs1
    subplot(3,5,10)
    semilogx(Part1FreqGAVG{1,2}.freq,squeeze(mean(mean(Q1FPowAllSub_grads1(:,:,:)))),'color',[0 0 1],'linewidth',2);
    hold on
    semilogx(Part2FreqGAVG{1,2}.freq,squeeze(mean(mean(Q2FPowAllSub_grads1(:,:,:)))),'color',[0.33 0 0.66],'linewidth',2);
    hold on
    semilogx(Part3FreqGAVG{1,2}.freq,squeeze(mean(mean(Q3FPowAllSub_grads1(:,:,:)))),'color',[0.66 0 0.33],'linewidth',2);
    hold on
    semilogx(Part4FreqGAVG{1,2}.freq,squeeze(mean(mean(Q4FPowAllSub_grads1(:,:,:)))),'color',[1 0 0],'linewidth',2);
    hold on    
    
    axis([freqbandselect(1) freqbandselect(2) MinGrads MaxGrads])
    grid('on')
    legend('Q1','Q2','Q3','Q4')
    set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
    Title('Grads1: average across subjects')
    
    % AVG GRADs2
    subplot(3,5,15)
    semilogx(Part1FreqGAVG{1,2}.freq,squeeze(mean(mean(Q1FPowAllSub_grads2(:,:,:)))),'color',[0 0 1],'linewidth',2);
    hold on
    semilogx(Part1FreqGAVG{1,2}.freq,squeeze(mean(mean(Q2FPowAllSub_grads2(:,:,:)))),'color',[0.33 0 0.66],'linewidth',2);
    hold on
    semilogx(Part1FreqGAVG{1,2}.freq,squeeze(mean(mean(Q3FPowAllSub_grads2(:,:,:)))),'color',[0.66 0 0.33],'linewidth',2);
    hold on
    semilogx(Part1FreqGAVG{1,2}.freq,squeeze(mean(mean(Q4FPowAllSub_grads2(:,:,:)))),'color',[1 0 0],'linewidth',2);
    hold on
    
    axis([freqbandselect(1) freqbandselect(2) MinGrads MaxGrads])
    grid('on')
    legend('Q1','Q2','Q3','Q4')    
    set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
    Title(['Grads2: average across subjects'])
    
elseif size(Q1FPowAllSub_mags,1) == 1
    
 % AVG MAGs
    subplot(3,5,5)
    semilogx(Part1FreqGAVG{1,2}.freq,squeeze(mean((Q1FPowAllSub_mags(:,:,:)))),'color',[0 0 1],'linewidth',2);
    hold on
    semilogx(Part1FreqGAVG{1,2}.freq,squeeze(mean((Q2FPowAllSub_mags(:,:,:)))),'color',[0.33 0 0.66],'linewidth',2);
    hold on
    semilogx(Part1FreqGAVG{1,2}.freq,squeeze(mean((Q3FPowAllSub_mags(:,:,:)))),'color',[0.66 0 0.33],'linewidth',2);
    hold on
    semilogx(Part1FreqGAVG{1,2}.freq,squeeze(mean((Q4FPowAllSub_mags(:,:,:)))),'color',[1 0 0],'linewidth',2);
    hold on    
    
    axis([freqbandselect(1) freqbandselect(2) MinMags MaxMags])
    set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
    legend('Q1','Q2','Q3','Q4')    
    grid('on')
    Title('MAGs: average across subjects')
    
    % AVG GRADs1
    subplot(3,5,10)
    semilogx(Part1FreqGAVG{1,2}.freq,squeeze(mean((Q1FPowAllSub_grads1(:,:,:)))),'color',[0 0 1],'linewidth',2);
    hold on
    semilogx(Part2FreqGAVG{1,2}.freq,squeeze(mean((Q2FPowAllSub_grads1(:,:,:)))),'color',[0.33 0 0.66],'linewidth',2);
    hold on
    semilogx(Part3FreqGAVG{1,2}.freq,squeeze(mean((Q3FPowAllSub_grads1(:,:,:)))),'color',[0.66 0 0.33],'linewidth',2);
    hold on
    semilogx(Part4FreqGAVG{1,2}.freq,squeeze(mean((Q4FPowAllSub_grads1(:,:,:)))),'color',[1 0 0],'linewidth',2);
    hold on    
    
    axis([freqbandselect(1) freqbandselect(2) MinGrads MaxGrads])
    grid('on')
    legend('Q1','Q2','Q3','Q4')    
    set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
    Title('Grads1: average across subjects')
    
    % AVG GRADs2
    subplot(3,5,15)
    semilogx(Part1FreqGAVG{1,2}.freq,squeeze(mean((Q1FPowAllSub_grads2(:,:,:)))),'color',[0 0 1],'linewidth',2);
    hold on
    semilogx(Part1FreqGAVG{1,2}.freq,squeeze(mean((Q2FPowAllSub_grads2(:,:,:)))),'color',[0.33 0 0.66],'linewidth',2);
    hold on
    semilogx(Part1FreqGAVG{1,2}.freq,squeeze(mean((Q3FPowAllSub_grads2(:,:,:)))),'color',[0.66 0 0.33],'linewidth',2);
    hold on
    semilogx(Part1FreqGAVG{1,2}.freq,squeeze(mean((Q4FPowAllSub_grads2(:,:,:)))),'color',[1 0 0],'linewidth',2);
    hold on
    
    axis([freqbandselect(1) freqbandselect(2) MinGrads MaxGrads])
    grid('on')
    legend('Q1','Q2','Q3','Q4')    
    set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
    Title(['Grads2: average across subjects'])
    
    % save plots
    print('-dpng',TheSlasher([root '/DATA/NEW/across_subjects_plots' ...
        '/Spectra_quarter_' cond '_' num2str(freqbandselect(1)) '-' num2str(freqbandselect(2)) '_GAVG_nodetrend_' condsub '.png'],tag));
    
end

% % AVG MAGs
% fig = figure('position',scrsz/2);
% subplot(1,2,1)
% semilogx(LongFreqGAVG{1,2}.freq,squeeze(mean(mean((SFPowAllSub_mags(:,:,:))))),'color','b','linewidth',2);
% hold on
% semilogx(LongFreqGAVG{1,2}.freq,squeeze(mean(mean((LFPowAllSub_mags(:,:,:))))),'color','r','linewidth',2);
% axis([freqbandselect(1) freqbandselect(2) MinMags MaxMags])
% Title('MAGs: average across subjects')
% subplot(1,2,2)
% semilogx(LongFreqGAVG{1,2}.freq,squeeze(mean(mean((LFPowAllSub_mags(:,:,:))))) - ...
%     squeeze(mean(mean((SFPowAllSub_mags(:,:,:))))),'color',[1 0 1],'linewidth',2);
% set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
% Title('MAGs: Long - Short')
% grid('on')
% axis([freqbandselect(1) freqbandselect(2) -2e-29 2e-29])
% line([min(LongFreqGAVG{1,1}.freq) min(LongFreqGAVG{1,1}.freq)],[0 0]);
% 
% print('-dpng',TheSlasher([root '/DATA/NEW/across_subjects_plots' ...
%     '/Spectra_Half_diff_mags' cond '_' num2str(freqbandselect(1)) '-' num2str(freqbandselect(2)) '_GAVG_nodetrend_V2_' condsub '.png'],tag));
% 
% % AVG GRADs1
% fig = figure('position',scrsz/2);
% subplot(1,2,1)
% semilogx(LongFreqGAVG{1,2}.freq,squeeze(mean(mean((SFPowAllSub_grads1(:,:,:))))),'color','b','linewidth',2);
% hold on
% semilogx(LongFreqGAVG{1,2}.freq,squeeze(mean(mean((LFPowAllSub_grads1(:,:,:))))),'color','r','linewidth',2);
% axis([freqbandselect(1) freqbandselect(2) MinGrads MaxGrads])
% grid('on')
% Title(['Grads1: average across subjects'])
% subplot(1,2,2)
% semilogx(LongFreqGAVG{1,2}.freq,squeeze(mean(mean((LFPowAllSub_grads1(:,:,:))))) - ...
%     squeeze(mean(mean((SFPowAllSub_grads1(:,:,:))))),'color',[1 0 1],'linewidth',2);
% set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
% Title('Grads1: Long - Short')
% grid('on')
% axis([freqbandselect(1) freqbandselect(2) -3e-27 3e-27])
% line([min(LongFreqGAVG{1,1}.freq) min(LongFreqGAVG{1,1}.freq)],[0 0]);
% 
% print('-dpng',TheSlasher([root '/DATA/NEW/across_subjects_plots' ...
%     '/Spectra_Half_diff_grads1' cond '_' num2str(freqbandselect(1)) '-' num2str(freqbandselect(2)) '_GAVG_nodetrend_V2_' condsub '.png'],tag));
% 
% 
% % AVG GRADs2
% fig = figure('position',scrsz/2);
% subplot(1,2,1)
% semilogx(LongFreqGAVG{1,2}.freq,squeeze(mean(mean((SFPowAllSub_grads2(:,:,:))))),'color','b','linewidth',2);
% hold on
% semilogx(LongFreqGAVG{1,2}.freq,squeeze(mean(mean((LFPowAllSub_grads2(:,:,:))))),'color','r','linewidth',2);
% axis([freqbandselect(1) freqbandselect(2) MinGrads MaxGrads])
% grid('on')
% Title(['Grads2: average across subjects'])
% subplot(1,2,2)
% semilogx(LongFreqGAVG{1,2}.freq,squeeze(mean(mean((LFPowAllSub_grads2(:,:,:))))) - ...
%     squeeze(mean(mean((SFPowAllSub_grads2(:,:,:))))),'color',[1 0 1],'linewidth',2);
% set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
% Title('Grads2: Long - Short')
% grid('on')
% axis([freqbandselect(1) freqbandselect(2) -3e-27 3e-27])
% line([min(LongFreqGAVG{1,1}.freq) min(LongFreqGAVG{1,1}.freq)],[0 0]);
% 
% print('-dpng',TheSlasher([root '/DATA/NEW/across_subjects_plots' ...
%     '/Spectra_Half_diff_grads2' cond '_' num2str(freqbandselect(1)) '-' num2str(freqbandselect(2)) '_GAVG_nodetrend_V2_' condsub '.png'],tag));

if size(Q1FPowAllSub_mags,1) ~= 1
    
    data_output_4m1(1,:) = squeeze(mean(mean((Q4FPowAllSub_mags(:,:,:))))) - ...
        squeeze(mean(mean((Q1FPowAllSub_mags(:,:,:)))));
    data_output_4m1(2,:) = squeeze(mean(mean((Q4FPowAllSub_grads1(:,:,:))))) - ...
        squeeze(mean(mean((Q1FPowAllSub_grads1(:,:,:)))));
    data_output_4m1(3,:) = squeeze(mean(mean((Q4FPowAllSub_grads2(:,:,:))))) - ...
        squeeze(mean(mean((Q1FPowAllSub_grads2(:,:,:)))));
    
    data_output_3m2(1,:) = squeeze(mean(mean((Q3FPowAllSub_mags(:,:,:))))) - ...
        squeeze(mean(mean((Q2FPowAllSub_mags(:,:,:)))));
    data_output_3m2(2,:) = squeeze(mean(mean((Q3FPowAllSub_grads1(:,:,:))))) - ...
        squeeze(mean(mean((Q2FPowAllSub_grads1(:,:,:)))));
    data_output_3m2(3,:) = squeeze(mean(mean((Q3FPowAllSub_grads2(:,:,:))))) - ...
        squeeze(mean(mean((Q2FPowAllSub_grads2(:,:,:)))));    
    
elseif size(Q1FPowAllSub_mags,1) == 1
    
    data_output_4m1(1,:) = squeeze(mean(((Q4FPowAllSub_mags(:,:,:))))) - ...
        squeeze(mean(((Q1FPowAllSub_mags(:,:,:)))));
    data_output_4m1(2,:) = squeeze(mean(((Q4FPowAllSub_grads1(:,:,:))))) - ...
        squeeze(mean(((Q1FPowAllSub_grads1(:,:,:)))));
    data_output_4m1(3,:) = squeeze(mean(((Q4FPowAllSub_grads2(:,:,:))))) - ...
        squeeze(mean(((Q1FPowAllSub_grads2(:,:,:)))));
    
    data_output_3m2(1,:) = squeeze(mean(((Q3FPowAllSub_mags(:,:,:))))) - ...
        squeeze(mean(((Q2FPowAllSub_mags(:,:,:)))));
    data_output_3m2(2,:) = squeeze(mean(((Q3FPowAllSub_grads1(:,:,:))))) - ...
        squeeze(mean(((Q2FPowAllSub_grads1(:,:,:)))));
    data_output_3m2(3,:) = squeeze(mean(((Q3FPowAllSub_grads2(:,:,:))))) - ...
        squeeze(mean(((Q2FPowAllSub_grads2(:,:,:)))));
    
end


