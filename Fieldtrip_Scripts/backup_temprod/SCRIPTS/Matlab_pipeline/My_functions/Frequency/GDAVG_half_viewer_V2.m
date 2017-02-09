function [freqref,data_output] = GDAVG_half_viewer_V2(subjects,freqbandselect,cond,tag)

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
    datapath               = TheSlasher([Dir '/FT_spectra/Short&LongFreqGAVG_' cond '_1-120_V2.mat'],tag);
    datapath               = TheSlasher(datapath,tag);
    load(datapath,'ShortFreqGAVG','LongFreqGAVG');
    
    % select frequency band
    fbegin                = find(LongFreqGAVG{1,1}.freq >= freqbandselect(1));
    fend                  = find(LongFreqGAVG{1,1}.freq <= freqbandselect(2));
    fband                 = fbegin(1):fend(end);
    
    LongFreqGAVG{1,1}.powspctrm        = LongFreqGAVG{1,1}.powspctrm(:,fband);
    LongFreqGAVG{1,1}.freq             = LongFreqGAVG{1,1}.freq(fband);
    LongFreqGAVG{1,2}.powspctrm        = LongFreqGAVG{1,2}.powspctrm(:,fband);
    LongFreqGAVG{1,2}.freq             = LongFreqGAVG{1,2}.freq(fband);
    LongFreqGAVG{1,3}.powspctrm        = LongFreqGAVG{1,3}.powspctrm(:,fband);
    LongFreqGAVG{1,3}.freq             = LongFreqGAVG{1,3}.freq(fband);
    
    ShortFreqGAVG{1,1}.powspctrm       = ShortFreqGAVG{1,1}.powspctrm(:,fband);
    ShortFreqGAVG{1,1}.freq            = ShortFreqGAVG{1,1}.freq(fband);
    ShortFreqGAVG{1,2}.powspctrm       = ShortFreqGAVG{1,2}.powspctrm(:,fband);
    ShortFreqGAVG{1,2}.freq            = ShortFreqGAVG{1,2}.freq(fband);
    ShortFreqGAVG{1,3}.powspctrm       = ShortFreqGAVG{1,3}.powspctrm(:,fband);
    ShortFreqGAVG{1,3}.freq            = ShortFreqGAVG{1,3}.freq(fband);
    
    freqref = ShortFreqGAVG{1,3}.freq;
    
    MaxMags = max([max(mean((ShortFreqGAVG{1,1}.powspctrm))) ...
        max(mean((LongFreqGAVG{1,1}.powspctrm)))]) ;
    MinMags = min([min(mean((ShortFreqGAVG{1,1}.powspctrm))) ...
        min(mean((LongFreqGAVG{1,1}.powspctrm)))]) ;
    MaxGrads = max([max(mean((ShortFreqGAVG{1,2}.powspctrm))) ...
        max(mean((LongFreqGAVG{1,2}.powspctrm)))]) ;
    MinGrads = min([min(mean((ShortFreqGAVG{1,2}.powspctrm))) ...
        min(mean((LongFreqGAVG{1,2}.powspctrm)))]) ;
    
    % plot data
    
    % MAGs
    subplot(3,3,1)
    semilogx(ShortFreqGAVG{1,1}.freq,squeeze(mean(ShortFreqGAVG{1,1}.powspctrm)),...
        'color',C(i,:),'linewidth',2)
    grid('on')
    set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
    title('MAGs: Short trials')
    hold on;
    
    axis([freqbandselect(1) freqbandselect(2) MinMags*1.5 MaxMags*1.5])
    
    subplot(3,3,4)
    semilogx(LongFreqGAVG{1,1}.freq,squeeze(mean(LongFreqGAVG{1,1}.powspctrm)),...
        'color',C(i,:),'linewidth',2)
    grid('on')
    set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
    title('MAGs: Long trials')
    hold on;
    
    axis([freqbandselect(1) freqbandselect(2) MinMags*1.5 MaxMags*1.5])
    
    % GRADs1
    subplot(3,3,2)
    semilogx(ShortFreqGAVG{1,2}.freq,squeeze(mean(ShortFreqGAVG{1,2}.powspctrm)),...
        'color',C(i,:),'linewidth',2)
    grid('on')
    set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
    title('GRADs1: Short trials')
    hold on;
    
    axis([freqbandselect(1) freqbandselect(2) MinGrads*1.5 MaxGrads*1.5])
    
    subplot(3,3,5)
    semilogx(LongFreqGAVG{1,2}.freq,squeeze(mean(LongFreqGAVG{1,2}.powspctrm)),...
        'color',C(i,:),'linewidth',2)
    grid('on')
    set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
    title('GRADs1: Long trials')
    hold on;
    
    axis([freqbandselect(1) freqbandselect(2) MinGrads*1.5 MaxGrads*1.5])
    
    % GRADs2
    subplot(3,3,3)
    semilogx(ShortFreqGAVG{1,2}.freq,squeeze(mean(ShortFreqGAVG{1,3}.powspctrm)),...
        'color',C(i,:),'linewidth',2)
    grid('on')
    set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
    title('GRADs2: Short trials')
    hold on;
    
    axis([freqbandselect(1) freqbandselect(2) MinGrads*1.5 MaxGrads*1.5])
    
    subplot(3,3,6)
    semilogx(LongFreqGAVG{1,2}.freq,squeeze(mean(LongFreqGAVG{1,3}.powspctrm)),...
        'color',C(i,:),'linewidth',2)
    grid('on')
    set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
    title('GRADs2: Long trials')
    hold on;
    
    axis([freqbandselect(1) freqbandselect(2) MinGrads*1.5 MaxGrads*1.5])
    
    % concatenate data
    LFPowAllSub_mags(i,:,:)   =  LongFreqGAVG{1,1}.powspctrm;
    LFPowAllSub_grads1(i,:,:) =  LongFreqGAVG{1,2}.powspctrm;
    LFPowAllSub_grads2(i,:,:) =  LongFreqGAVG{1,3}.powspctrm;
    
    SFPowAllSub_mags(i,:,:)   =  ShortFreqGAVG{1,1}.powspctrm;
    SFPowAllSub_grads1(i,:,:) =  ShortFreqGAVG{1,2}.powspctrm;
    SFPowAllSub_grads2(i,:,:) =  ShortFreqGAVG{1,3}.powspctrm;
    
end

if size(SFPowAllSub_mags,1) ~= 1
    
    % AVG MAGs
    subplot(3,3,7)
    semilogx(LongFreqGAVG{1,2}.freq,squeeze(mean(mean(SFPowAllSub_mags(:,:,:)))),'color','b','linewidth',2);
    hold on
    semilogx(LongFreqGAVG{1,2}.freq,squeeze(mean(mean(LFPowAllSub_mags(:,:,:)))),'color','r','linewidth',2);
    axis([freqbandselect(1) freqbandselect(2) MinMags MaxMags])
    set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
    grid('on')
    Title('MAGs: average across subjects')
    
    % AVG GRADs1
    subplot(3,3,8)
    semilogx(LongFreqGAVG{1,2}.freq,squeeze(mean(mean(SFPowAllSub_grads1(:,:,:)))),'color','b','linewidth',2);
    hold on
    semilogx(LongFreqGAVG{1,2}.freq,squeeze(mean(mean(LFPowAllSub_grads1(:,:,:)))),'color','r','linewidth',2);
    axis([freqbandselect(1) freqbandselect(2) MinGrads MaxGrads])
    grid('on')
    set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
    Title('Grads1: average across subjects')
    
    % AVG GRADs2
    subplot(3,3,9)
    semilogx(LongFreqGAVG{1,2}.freq,squeeze(mean(mean(SFPowAllSub_grads2(:,:,:)))),'color','b','linewidth',2);
    hold on
    semilogx(LongFreqGAVG{1,2}.freq,squeeze(mean(mean(LFPowAllSub_grads2(:,:,:)))),'color','r','linewidth',2);
    axis([freqbandselect(1) freqbandselect(2) MinGrads MaxGrads])
    grid('on')
    set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
    Title(['Grads2: average across subjects'])
    
elseif size(SFPowAllSub_mags,1) == 1
    
    % AVG MAGs
    subplot(3,3,7)
    semilogx(LongFreqGAVG{1,2}.freq,squeeze(mean((SFPowAllSub_mags(:,:,:)))),'color','b','linewidth',2);
    hold on
    semilogx(LongFreqGAVG{1,2}.freq,squeeze(mean((LFPowAllSub_mags(:,:,:)))),'color','r','linewidth',2);
    axis([freqbandselect(1) freqbandselect(2) MinMags MaxMags])
    set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
    grid('on')
    Title('MAGs: average across subjects')
    
    % AVG GRADs1
    subplot(3,3,8)
    semilogx(LongFreqGAVG{1,2}.freq,squeeze(mean((SFPowAllSub_grads1(:,:,:)))),'color','b','linewidth',2);
    hold on
    semilogx(LongFreqGAVG{1,2}.freq,squeeze(mean((LFPowAllSub_grads1(:,:,:)))),'color','r','linewidth',2);
    axis([freqbandselect(1) freqbandselect(2) MinGrads MaxGrads])
    grid('on')
    set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
    Title('Grads1: average across subjects')
    
    % AVG GRADs2
    subplot(3,3,9)
    semilogx(LongFreqGAVG{1,2}.freq,squeeze(mean((SFPowAllSub_grads2(:,:,:)))),'color','b','linewidth',2);
    hold on
    semilogx(LongFreqGAVG{1,2}.freq,squeeze(mean((LFPowAllSub_grads2(:,:,:)))),'color','r','linewidth',2);
    axis([freqbandselect(1) freqbandselect(2) MinGrads MaxGrads])
    grid('on')
    set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
    Title(['Grads2: average across subjects'])
    
    % save plots
    print('-dpng',TheSlasher([root '/DATA/NEW/across_subjects_plots' ...
        '/Spectra_Half_' cond '_' num2str(freqbandselect(1)) '-' num2str(freqbandselect(2)) '_GAVG_V2_' condsub '.png'],tag));
    
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
% axis([freqbandselect(1) freqbandselect(2) -3e-29 3e-29])
% line([min(LongFreqGAVG{1,1}.freq) min(LongFreqGAVG{1,1}.freq)],[0 0]);
% 
% print('-dpng',TheSlasher([root '/DATA/NEW/across_subjects_plots' ...
%         '/Spectra_Half_diff_mags' cond '_' num2str(freqbandselect(1)) '-' num2str(freqbandselect(2)) '_GAVG_withdetrend_V2_' condsub '.png'],tag));
% 
% % AVG GRADs1
% fig = figure('position',scrsz/2);
% subplot(1,2,1)
% semilogx(LongFreqGAVG{1,2}.freq,squeeze(mean(mean((SFPowAllSub_grads1(:,:,:))))),'color','b','linewidth',2);
% hold on
% semilogx(LongFreqGAVG{1,2}.freq,squeeze(mean(mean((LFPowAllSub_grads1(:,:,:))))),'color','r','linewidth',2);
% axis([freqbandselect(1) freqbandselect(2) MinGrads MaxGrads])
% grid('on')
% Title(['Grads2: average across subjects'])
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
%         '/Spectra_Half_diff_grads1' cond '_' num2str(freqbandselect(1)) '-' num2str(freqbandselect(2)) '_GAVG_withdetrend_V2_' condsub '.png'],tag));
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
% Title('Grads1: Long - Short')
% grid('on')
% axis([freqbandselect(1) freqbandselect(2) -3e-27 3e-27])
% line([min(LongFreqGAVG{1,1}.freq) min(LongFreqGAVG{1,1}.freq)],[0 0]);
% 
% print('-dpng',TheSlasher([root '/DATA/NEW/across_subjects_plots' ...
%         '/Spectra_Half_diff_grads2' cond '_' num2str(freqbandselect(1)) '-' num2str(freqbandselect(2)) '_GAVG_withdetrend_V2_' condsub '.png'],tag));
% 

if size(SFPowAllSub_mags,1) ~= 1
    
    data_output(1,:) = squeeze(mean(mean((LFPowAllSub_mags(:,:,:))))) - ...
        squeeze(mean(mean((SFPowAllSub_mags(:,:,:)))));
    data_output(2,:) = squeeze(mean(mean((LFPowAllSub_grads1(:,:,:))))) - ...
        squeeze(mean(mean((SFPowAllSub_grads1(:,:,:)))));
    data_output(3,:) = squeeze(mean(mean((LFPowAllSub_grads2(:,:,:))))) - ...
        squeeze(mean(mean((SFPowAllSub_grads2(:,:,:)))));
    
elseif size(SFPowAllSub_mags,1) == 1
    
    data_output(1,:) = squeeze(mean(((LFPowAllSub_mags(:,:,:))))) - ...
        squeeze(mean(((SFPowAllSub_mags(:,:,:)))));
    data_output(2,:) = squeeze(mean(((LFPowAllSub_grads1(:,:,:))))) - ...
        squeeze(mean(((SFPowAllSub_grads1(:,:,:)))));
    data_output(3,:) = squeeze(mean(((LFPowAllSub_grads2(:,:,:))))) - ...
        squeeze(mean(((SFPowAllSub_grads2(:,:,:)))));
    
end
