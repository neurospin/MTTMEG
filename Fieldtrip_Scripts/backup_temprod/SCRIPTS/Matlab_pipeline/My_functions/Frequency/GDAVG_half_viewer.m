function GDAVG_half_viewer(subjects,freqband,freqbandselect,tag)

fig                 = figure('position',[1 1 1280 1024]);
set(fig,'PaperPosition',[1 1 1280 1024])
set(fig,'PaperPositionMode','auto')

% set colormap
c = colormap('jet');
C = c(1:round(60/length(subjects)):60,:);

% init legend
leg = [];

for i = 1:length(subjects)
    
    % set paths
    Dir = ['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subjects{i}];
    chantypefull  = {'Mags';'Gradslong';'Gradslat'};
    
    % load data
%     datapath               = [Dir '/FT_spectra/Short&LongFreqGAVG_' tag '_' ...
%         num2str(freqband(1)) '-' num2str(freqband(2)) '.mat'];
%     load(datapath,'ShortFreqGAVG','LongFreqGAVG');
    datapath               = [Dir '/FT_spectra/Short&LongFreqGAVG_' tag '_' ...
    '1-120.mat'];
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
    loglog(ShortFreqGAVG{1,1}.freq,squeeze(mean(ShortFreqGAVG{1,1}.powspctrm)),...
        'color',C(i,:),'linewidth',2)
    grid('on')
    set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
    title('MAGs: Short trials')
    hold on;
    
    axis([freqbandselect(1) freqbandselect(2) MinMags MaxMags])
    
    subplot(3,3,4)
    loglog(LongFreqGAVG{1,1}.freq,squeeze(mean(LongFreqGAVG{1,1}.powspctrm)),...
        'color',C(i,:),'linewidth',2)
    grid('on')
    set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
    title('MAGs: Long trials')
    hold on;
    
    axis([freqbandselect(1) freqbandselect(2) MinMags MaxMags])
    
    % GRADs1
    subplot(3,3,2)
    loglog(ShortFreqGAVG{1,2}.freq,squeeze(mean(ShortFreqGAVG{1,2}.powspctrm)),...
        'color',C(i,:),'linewidth',2)
    grid('on')
    set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
    title('GRADs1: Short trials')
    hold on;
    
    axis([freqbandselect(1) freqbandselect(2) MinGrads MaxGrads])
    
    subplot(3,3,5)
    loglog(LongFreqGAVG{1,2}.freq,squeeze(mean(LongFreqGAVG{1,2}.powspctrm)),...
        'color',C(i,:),'linewidth',2)
    grid('on')
    set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
    title('GRADs1: Long trials')
    hold on;
    
    axis([freqbandselect(1) freqbandselect(2) MinGrads MaxGrads])
    
    % GRADs2
    subplot(3,3,3)
    loglog(ShortFreqGAVG{1,2}.freq,squeeze(mean(ShortFreqGAVG{1,3}.powspctrm)),...
        'color',C(i,:),'linewidth',2)
    grid('on')
    set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
    title('GRADs2: Short trials')
    hold on;
    
    axis([freqbandselect(1) freqbandselect(2) MinGrads MaxGrads])
    
    subplot(3,3,6)
    loglog(LongFreqGAVG{1,2}.freq,squeeze(mean(LongFreqGAVG{1,3}.powspctrm)),...
        'color',C(i,:),'linewidth',2)
    grid('on')
    set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
    title('GRADs2: Long trials')
    hold on;
    
    axis([freqbandselect(1) freqbandselect(2) MinGrads MaxGrads])
    
    % concatenate data
    LFPowAllSub_mags(i,:,:)   =  LongFreqGAVG{1,1}.powspctrm;
    LFPowAllSub_grads1(i,:,:) =  LongFreqGAVG{1,2}.powspctrm;
    LFPowAllSub_grads2(i,:,:) =  LongFreqGAVG{1,3}.powspctrm;
    
    SFPowAllSub_mags(i,:,:)   =  ShortFreqGAVG{1,1}.powspctrm;
    SFPowAllSub_grads1(i,:,:) =  ShortFreqGAVG{1,2}.powspctrm;
    SFPowAllSub_grads2(i,:,:) =  ShortFreqGAVG{1,3}.powspctrm;
    
end

% AVG MAGs
subplot(3,3,7)
loglog(LongFreqGAVG{1,2}.freq,squeeze(mean(mean(SFPowAllSub_mags(:,:,:)))),'color','b','linewidth',2);
hold on
loglog(LongFreqGAVG{1,2}.freq,squeeze(mean(mean(LFPowAllSub_mags(:,:,:)))),'color','r','linewidth',2);
axis([freqbandselect(1) freqbandselect(2) MinMags MaxMags])
set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
grid('on')
Title('MAGs: average across subjects')

% AVG GRADs1
subplot(3,3,8)
loglog(LongFreqGAVG{1,2}.freq,squeeze(mean(mean(SFPowAllSub_grads1(:,:,:)))),'color','b','linewidth',2);
hold on
loglog(LongFreqGAVG{1,2}.freq,squeeze(mean(mean(LFPowAllSub_grads1(:,:,:)))),'color','r','linewidth',2);
axis([freqbandselect(1) freqbandselect(2) MinGrads MaxGrads])
grid('on')
set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
Title('MAGs: average across subjects')

% AVG GRADs2
subplot(3,3,9)
loglog(LongFreqGAVG{1,2}.freq,squeeze(mean(mean(SFPowAllSub_grads2(:,:,:)))),'color','b','linewidth',2);
hold on
loglog(LongFreqGAVG{1,2}.freq,squeeze(mean(mean(LFPowAllSub_grads2(:,:,:)))),'color','r','linewidth',2);
axis([freqbandselect(1) freqbandselect(2) MinGrads MaxGrads])
grid('on')
set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
Title('MAGs: average across subjects')

% save plots
print('-dpng',['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/across_subjects_plots' ...
        '/Spectra_Half_' num2str(freqbandselect(1)) '-' num2str(freqbandselect(2)) '_GAVG.png']);

