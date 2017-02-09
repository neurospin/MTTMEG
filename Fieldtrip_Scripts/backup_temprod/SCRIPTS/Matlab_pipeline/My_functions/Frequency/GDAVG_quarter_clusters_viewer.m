function [freqref,data_output_4m1,data_output_3m2] = GDAVG_quarter_clusters_viewer(subjects,freqbandselect,cond,tag)

% set root
root = SetPath(tag);

Qcolors = [0 0 1 ; 0 0.5 0 ; 1 0.5 0; 1 0 0];

for clustind = 1:5
    
    % cluster definition
    [Find, Bind, Vind, Lind, Rind] = clusteranat(tag);
    [GradsLong, GradsLat, Mags]    = grads_for_layouts(tag);
    
    % set colormap
    c = colormap('jet');
    C = c(1:round(60/length(subjects)):60,:);
    
    % init legend
    leg = [];
    condsub = [];
    
    indexplotcluster = [2 8 5 4 6];
    
    if clustind == 1
        indsel = Find; clustname = 'FRONT';
    elseif clustind == 2
        indsel = Bind; clustname = 'BACK';
    elseif clustind == 3
        indsel = Vind; clustname = 'VERTEX';
    elseif clustind == 4
        indsel = Lind; clustname = 'LEFT';
    elseif clustind == 5
        indsel = Rind; clustname = 'RIGHT';
    end
    
    %     clear Q1FPowAllSub_mags   Q2FPowAllSub_mags   Q3FPowAllSub_mags   Q4FPowAllSub_mags
    %     clear Q1FPowAllSub_grads1 Q2FPowAllSub_grads1 Q3FPowAllSub_grads1 Q4FPowAllSub_grads1
    %     clear Q1FPowAllSub_grads2 Q2FPowAllSub_grads2 Q3FPowAllSub_grads2 Q4FPowAllSub_grads2
    
    for i = 1:length(subjects)
        
        condsub = [condsub '_' subjects{i}];
        
        % set paths
        Dir = [root '/DATA/NEW/processed_' subjects{i}];
        chantypefull  = {'Mags';'Gradslong';'Gradslat'};
        
        clear Part1FreqGAVG Part2FreqGAVG Part3FreqGAVG Part4FreqGAVG
        
        % load data
        datapath               = TheSlasher([Dir '/FT_spectra/QuarterCutFreqGAVG_' clustname '_' cond '_1-120_nodetrend.mat'],tag);
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
        
        MaxMags{clustind}  = max([(mean(Part1FreqGAVG{1,1}.powspctrm,1)) ...
            (mean(Part2FreqGAVG{1,1}.powspctrm,1)) ...
            (mean(Part3FreqGAVG{1,1}.powspctrm,1)) ...
            (mean(Part4FreqGAVG{1,1}.powspctrm,1))]) ;
        MinMags{clustind}   = min([(mean(Part1FreqGAVG{1,1}.powspctrm,1)) ...
            (mean(Part2FreqGAVG{1,1}.powspctrm,1)) ...
            (mean(Part3FreqGAVG{1,1}.powspctrm,1)) ...
            (mean(Part4FreqGAVG{1,1}.powspctrm,1))]) ;
        MaxGrads1{clustind}  = max([(mean(Part1FreqGAVG{1,2}.powspctrm,1)) ...
            (mean(Part2FreqGAVG{1,2}.powspctrm,1)) ...
            (mean(Part3FreqGAVG{1,2}.powspctrm,1)) ...
            (mean(Part4FreqGAVG{1,2}.powspctrm,1))]) ;
        MinGrads1{clustind}  = min([(mean(Part1FreqGAVG{1,1}.powspctrm,1)) ...
            (mean(Part2FreqGAVG{1,2}.powspctrm,1)) ...
            (mean(Part3FreqGAVG{1,2}.powspctrm,1)) ...
            (mean(Part4FreqGAVG{1,2}.powspctrm,1))]) ;
        MaxGrads2{clustind}  = max([(mean(Part1FreqGAVG{1,2}.powspctrm,1)) ...
            (mean(Part2FreqGAVG{1,3}.powspctrm,1)) ...
            (mean(Part3FreqGAVG{1,3}.powspctrm,1)) ...
            (mean(Part4FreqGAVG{1,3}.powspctrm,1))]) ;
        MinGrads2{clustind}  = min([(mean(Part1FreqGAVG{1,1}.powspctrm,1)) ...
            (mean(Part2FreqGAVG{1,3}.powspctrm,1)) ...
            (mean(Part3FreqGAVG{1,3}.powspctrm,1)) ...
            (mean(Part4FreqGAVG{1,3}.powspctrm,1))]) ;
        
        % concatenate data
        Q1FPowAllSub_mags{clustind}(i,:,:)   =  Part1FreqGAVG{1,1}.powspctrm;
        Q1FPowAllSub_grads1{clustind}(i,:,:) =  Part1FreqGAVG{1,2}.powspctrm;
        Q1FPowAllSub_grads2{clustind}(i,:,:) =  Part1FreqGAVG{1,3}.powspctrm;
        Q2FPowAllSub_mags{clustind}(i,:,:)   =  Part2FreqGAVG{1,1}.powspctrm;
        Q2FPowAllSub_grads1{clustind}(i,:,:) =  Part2FreqGAVG{1,2}.powspctrm;
        Q2FPowAllSub_grads2{clustind}(i,:,:) =  Part2FreqGAVG{1,3}.powspctrm;
        Q3FPowAllSub_mags{clustind}(i,:,:)   =  Part3FreqGAVG{1,1}.powspctrm;
        Q3FPowAllSub_grads1{clustind}(i,:,:) =  Part3FreqGAVG{1,2}.powspctrm;
        Q3FPowAllSub_grads2{clustind}(i,:,:) =  Part3FreqGAVG{1,3}.powspctrm;
        Q4FPowAllSub_mags{clustind}(i,:,:)   =  Part4FreqGAVG{1,1}.powspctrm;
        Q4FPowAllSub_grads1{clustind}(i,:,:) =  Part4FreqGAVG{1,2}.powspctrm;
        Q4FPowAllSub_grads2{clustind}(i,:,:) =  Part4FreqGAVG{1,3}.powspctrm;
        
    end
end

clustname = {'ANTERIOR';'POSTERIOR';'VERTEX';'LEFT';'RIGHT'};

% get global min and max
GlobalMaxMags  = -inf;
GlobalMaxGrads1 = -inf;
GlobalMaxGrads2 = -inf;
GlobalMinMags  = +inf;
GlobalMinGrads1 = +inf;
GlobalMinGrads2 = +inf;
for clustind = 1:5
    GlobalMaxMags   = max(GlobalMaxMags,MaxMags{clustind});
    GlobalMaxGrads1  = max(GlobalMaxGrads1,MaxGrads1{clustind});
    GlobalMaxGrads2  = max(GlobalMaxGrads2,MaxGrads2{clustind});
    GlobalMinMags   = min(GlobalMinMags,MinMags{clustind});
    GlobalMinGrads1  = min(GlobalMinGrads1,MinGrads1{clustind});
    GlobalMinGrads2  = min(GlobalMinGrads2,MinGrads2{clustind});
end

scrsz = get(0,'ScreenSize');
figmags = figure('position',[scrsz(1) scrsz(2) scrsz(3)*0.5 scrsz(4)*0.75]);
set(figmags,'PaperPosition',[scrsz(1) scrsz(2) scrsz(3)*0.5 scrsz(4)*0.75])
set(figmags,'PaperPositionMode','auto')
for clustind = 1:5
    if size(Q1FPowAllSub_mags{clustind},1) ~= 1
        
        % AVG MAGs
        subplot(3,3,indexplotcluster(clustind))
        semilogx(Part1FreqGAVG{1,2}.freq,squeeze(mean(mean(Q1FPowAllSub_mags{clustind}(:,:,:)))),'color',Qcolors(1,:),'linewidth',2);
        hold on
        semilogx(Part1FreqGAVG{1,2}.freq,squeeze(mean(mean(Q2FPowAllSub_mags{clustind}(:,:,:)))),'color',Qcolors(2,:),'linewidth',2);
        hold on
        semilogx(Part1FreqGAVG{1,2}.freq,squeeze(mean(mean(Q3FPowAllSub_mags{clustind}(:,:,:)))),'color',Qcolors(3,:),'linewidth',2);
        hold on
        semilogx(Part1FreqGAVG{1,2}.freq,squeeze(mean(mean(Q4FPowAllSub_mags{clustind}(:,:,:)))),'color',Qcolors(4,:),'linewidth',2);
        hold on
        
        axis([freqbandselect(1) freqbandselect(2) 0 GlobalMaxMags])
        set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
        grid('on')
        legend('Q1','Q2','Q3','Q4')
        Title([clustname(clustind) ' MAGs: average across subjects'])
        
    elseif size(Q1FPowAllSub_mags{clustind},1) == 1
        
        % AVG MAGs
        subplot(3,3,indexplotcluster(clustind))
        semilogx(Part1FreqGAVG{1,2}.freq,squeeze(mean((Q1FPowAllSub_mags{clustind}(:,:,:)))),'color',Qcolors(1,:),'linewidth',2);
        hold on
        semilogx(Part1FreqGAVG{1,2}.freq,squeeze(mean((Q2FPowAllSub_mags{clustind}(:,:,:)))),'color',Qcolors(2,:),'linewidth',2);
        hold on
        semilogx(Part1FreqGAVG{1,2}.freq,squeeze(mean((Q3FPowAllSub_mags{clustind}(:,:,:)))),'color',Qcolors(3,:),'linewidth',2);
        hold on
        semilogx(Part1FreqGAVG{1,2}.freq,squeeze(mean((Q4FPowAllSub_mags{clustind}(:,:,:)))),'color',Qcolors(4,:),'linewidth',2);
        hold on
        
        axis([freqbandselect(1) freqbandselect(2) 0 GlobalMaxMags])
        set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
        legend('Q1','Q2','Q3','Q4')
        grid('on')
        Title([clustname(clustind) ' MAGs: average across subjects'])
        
    end
end

print('-dpng',[root '\DATA\NEW\across_subjects_plots'...
    '/QuarterCutFreqGAVG_clusters_mags_' cond condsub '_' num2str(freqbandselect(1)) '-' num2str(freqbandselect(2)) '.png']);

scrsz = get(0,'ScreenSize');
figmags = figure('position',[scrsz(1) scrsz(2) scrsz(3)*0.5 scrsz(4)*0.75]);
set(figmags,'PaperPosition',[scrsz(1) scrsz(2) scrsz(3)*0.5 scrsz(4)*0.75])
set(figmags,'PaperPositionMode','auto')
for clustind = 1:5
    if size(Q1FPowAllSub_mags{clustind},1) ~= 1
        
        % AVG MAGs
        subplot(3,3,indexplotcluster(clustind))
        semilogx(Part1FreqGAVG{1,2}.freq,squeeze(mean(mean(Q1FPowAllSub_grads1{clustind}(:,:,:)))),'color',Qcolors(1,:),'linewidth',2);
        hold on
        semilogx(Part1FreqGAVG{1,2}.freq,squeeze(mean(mean(Q2FPowAllSub_grads1{clustind}(:,:,:)))),'color',Qcolors(2,:),'linewidth',2);
        hold on
        semilogx(Part1FreqGAVG{1,2}.freq,squeeze(mean(mean(Q3FPowAllSub_grads1{clustind}(:,:,:)))),'color',Qcolors(3,:),'linewidth',2);
        hold on
        semilogx(Part1FreqGAVG{1,2}.freq,squeeze(mean(mean(Q4FPowAllSub_grads1{clustind}(:,:,:)))),'color',Qcolors(4,:),'linewidth',2);
        hold on
        
        axis([freqbandselect(1) freqbandselect(2) 0 GlobalMaxGrads1])
        set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
        grid('on')
        legend('Q1','Q2','Q3','Q4')
        Title([clustname(clustind) ' GRADS1s: average across subjects'])
        
    elseif size(Q1FPowAllSub_mags{clustind},1) == 1
        
        % AVG MAGs
        subplot(3,3,indexplotcluster(clustind))
        semilogx(Part1FreqGAVG{1,2}.freq,squeeze(mean((Q1FPowAllSub_grads1{clustind}(:,:,:)))),'color',Qcolors(1,:),'linewidth',2);
        hold on
        semilogx(Part1FreqGAVG{1,2}.freq,squeeze(mean((Q2FPowAllSub_grads1{clustind}(:,:,:)))),'color',Qcolors(2,:),'linewidth',2);
        hold on
        semilogx(Part1FreqGAVG{1,2}.freq,squeeze(mean((Q3FPowAllSub_grads1{clustind}(:,:,:)))),'color',Qcolors(3,:),'linewidth',2);
        hold on
        semilogx(Part1FreqGAVG{1,2}.freq,squeeze(mean((Q4FPowAllSub_grads1{clustind}(:,:,:)))),'color',Qcolors(4,:),'linewidth',2);
        hold on
        
        axis([freqbandselect(1) freqbandselect(2) 0 GlobalMaxGrads1])
        set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
        legend('Q1','Q2','Q3','Q4')
        grid('on')
        Title([clustname(clustind) ' GRADS1s: average across subjects'])
        
    end
end
print('-dpng',[root '\DATA\NEW\across_subjects_plots'...
    '/QuarterCutFreqGAVG_clusters_grads1_' cond condsub '_' num2str(freqbandselect(1)) '-' num2str(freqbandselect(2)) '.png']);

scrsz = get(0,'ScreenSize');
figmags = figure('position',[scrsz(1) scrsz(2) scrsz(3)*0.5 scrsz(4)*0.75]);
set(figmags,'PaperPosition',[scrsz(1) scrsz(2) scrsz(3)*0.5 scrsz(4)*0.75])
set(figmags,'PaperPositionMode','auto')
for clustind = 1:5
    if size(Q1FPowAllSub_mags{clustind},1) ~= 1
        
        % AVG MAGs
        subplot(3,3,indexplotcluster(clustind))
        semilogx(Part1FreqGAVG{1,2}.freq,squeeze(mean(mean(Q1FPowAllSub_grads2{clustind}(:,:,:)))),'color',Qcolors(1,:),'linewidth',2);
        hold on
        semilogx(Part1FreqGAVG{1,2}.freq,squeeze(mean(mean(Q2FPowAllSub_grads2{clustind}(:,:,:)))),'color',Qcolors(2,:),'linewidth',2);
        hold on
        semilogx(Part1FreqGAVG{1,2}.freq,squeeze(mean(mean(Q3FPowAllSub_grads2{clustind}(:,:,:)))),'color',Qcolors(3,:),'linewidth',2);
        hold on
        semilogx(Part1FreqGAVG{1,2}.freq,squeeze(mean(mean(Q4FPowAllSub_grads2{clustind}(:,:,:)))),'color',Qcolors(4,:),'linewidth',2);
        hold on
        
        axis([freqbandselect(1) freqbandselect(2) 0 GlobalMaxGrads2])
        set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
        grid('on')
        legend('Q1','Q2','Q3','Q4')
        Title([clustname(clustind) ' GRADS2s: average across subjects'])
        
    elseif size(Q1FPowAllSub_mags{clustind},1) == 1
        
        % AVG MAGs
        subplot(3,3,indexplotcluster(clustind))
        semilogx(Part1FreqGAVG{1,2}.freq,squeeze(mean((Q1FPowAllSub_grads2{clustind}(:,:,:)))),'color',Qcolors(1,:),'linewidth',2);
        hold on
        semilogx(Part1FreqGAVG{1,2}.freq,squeeze(mean((Q2FPowAllSub_grads2{clustind}(:,:,:)))),'color',Qcolors(2,:),'linewidth',2);
        hold on
        semilogx(Part1FreqGAVG{1,2}.freq,squeeze(mean((Q3FPowAllSub_grads2{clustind}(:,:,:)))),'color',Qcolors(3,:),'linewidth',2);
        hold on
        semilogx(Part1FreqGAVG{1,2}.freq,squeeze(mean((Q4FPowAllSub_grads2{clustind}(:,:,:)))),'color',Qcolors(4,:),'linewidth',2);
        hold on
        
        axis([freqbandselect(1) freqbandselect(2) 0 GlobalMaxGrads2])
        set(gca,'xtick',[1 2 5 10 20 30 50 100],'xticklabel',[1 2 5 10 20 30 50 100])
        legend('Q1','Q2','Q3','Q4')
        grid('on')
        Title([clustname(clustind) ' GRADS2s: average across subjects'])
        
    end
end

print('-dpng',[root '\DATA\NEW\across_subjects_plots'...
    '/QuarterCutFreqGAVG_clusters_grads2_' cond condsub '_' num2str(freqbandselect(1)) '-' num2str(freqbandselect(2)) '.png']);

for clustind = 1:5
    if size(Q1FPowAllSub_mags{clustind},1) ~= 1
        
        data_output_4m1{clustind}(1,:) = squeeze(mean(mean((Q4FPowAllSub_mags{clustind}(:,:,:))))) - ...
            squeeze(mean(mean((Q1FPowAllSub_mags{clustind}(:,:,:)))));
        data_output_4m1{clustind}(2,:) = squeeze(mean(mean((Q4FPowAllSub_grads1{clustind}(:,:,:))))) - ...
            squeeze(mean(mean((Q1FPowAllSub_grads1{clustind}(:,:,:)))));
        data_output_4m1{clustind}(3,:) = squeeze(mean(mean((Q4FPowAllSub_grads2{clustind}(:,:,:))))) - ...
            squeeze(mean(mean((Q1FPowAllSub_grads2{clustind}(:,:,:)))));
        
        data_output_3m2{clustind}(1,:) = squeeze(mean(mean((Q3FPowAllSub_mags{clustind}(:,:,:))))) - ...
            squeeze(mean(mean((Q2FPowAllSub_mags{clustind}(:,:,:)))));
        data_output_3m2{clustind}(2,:) = squeeze(mean(mean((Q3FPowAllSub_grads1{clustind}(:,:,:))))) - ...
            squeeze(mean(mean((Q2FPowAllSub_grads1{clustind}(:,:,:)))));
        data_output_3m2{clustind}(3,:) = squeeze(mean(mean((Q3FPowAllSub_grads2{clustind}(:,:,:))))) - ...
            squeeze(mean(mean((Q2FPowAllSub_grads2{clustind}(:,:,:)))));
        
    elseif size(Q1FPowAllSub_mags{clustind},1) == 1
        
        data_output_4m1{clustind}(1,:) = squeeze(mean(((Q4FPowAllSub_mags{clustind}(:,:,:))))) - ...
            squeeze(mean(mean((Q1FPowAllSub_mags{clustind}(:,:,:)))));
        data_output_4m1{clustind}(2,:) = squeeze(mean(((Q4FPowAllSub_grads1{clustind}(:,:,:))))) - ...
            squeeze(mean(mean((Q1FPowAllSub_grads1{clustind}(:,:,:)))));
        data_output_4m1{clustind}(3,:) = squeeze(mean(((Q4FPowAllSub_grads2{clustind}(:,:,:))))) - ...
            squeeze(mean(mean((Q1FPowAllSub_grads2{clustind}(:,:,:)))));
        
        data_output_3m2{clustind}(1,:) = squeeze(mean(((Q3FPowAllSub_mags{clustind}(:,:,:))))) - ...
            squeeze(mean(((Q2FPowAllSub_mags{clustind}(:,:,:)))));
        data_output_3m2{clustind}(2,:) = squeeze(mean(((Q3FPowAllSub_grads1{clustind}(:,:,:))))) - ...
            squeeze(mean(((Q2FPowAllSub_grads1{clustind}(:,:,:)))));
        data_output_3m2{clustind}(3,:) = squeeze(mean(((Q3FPowAllSub_grads2{clustind}(:,:,:))))) - ...
            squeeze(mean(((Q2FPowAllSub_grads2{clustind}(:,:,:)))));
        
    end
end

