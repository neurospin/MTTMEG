function temprod_OLD_summary(subject)

fig = figure('position',[1 1 1280 1024]);
[GradsLong, GradsLat] = grads_for_layouts;

for a = 1:6
    eval(['datapath' num2str(a) '= [''/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/OLD/processed_'...
    subject '/run' num2str(a) '.mat'']']);
end

freqband = {[4 8];[8 14];[15 30];[51 99];[1 99]};

[GradsLong, GradsLat]  = grads_for_layouts;
for k = 1:6
    eval(['load(datapath' num2str(k) ');']); 
    for l = 1:5
        clear cfg
        cfg.channel            = {'MEG'};
        cfg.method             = 'mtmfft';
        cfg.output             = 'pow';
        cfg.taper              = 'hanning';
        cfg.foilim             = freqband{l};
        foi                    = cfg.foilim;
        cfg.tapsmofrq          = 0.5;
        cfg.pad                = 'maxperlen';
        cfg.trials             = 'all';
        cfg.keeptrials         = 'no';
        cfg.keeptapers         = 'no';
        freq                   = ft_freqanalysis(cfg,data);
        eval(['MeanPowerMags(' num2str(k) ',' num2str(l) ') = mean(mean(freq.powspctrm))']);
        
        cfg.channel            = GradsLat;
        freq                   = ft_freqanalysis(cfg,data);
        eval(['MeanPowerGradsLat(' num2str(k) ',' num2str(l) ') = mean(mean(freq.powspctrm))']);
        
        cfg.channel            = GradsLong;
        freq                   = ft_freqanalysis(cfg,data);
        eval(['MeanPowerGradsLong(' num2str(k) ',' num2str(l) ') = mean(mean(freq.powspctrm))']);
        
    end
end

MeanPowerMagsSave = MeanPowerMags;
MeanPowerGradsLongSave = MeanPowerGradsLong;
MeanPowerGradsLatSave = MeanPowerGradsLat;

MeanPowerMags = log(MeanPowerMagsSave);
MeanPowerGradsLong = log(MeanPowerGradsLongSave);
MeanPowerGradsLat = log(MeanPowerGradsLatSave);

MAX = max([max(MeanPowerMags(:,1:4)), max(MeanPowerGradsLong(:,1:4)), max(MeanPowerGradsLat(:,1:4))]);
subplot(2,3,1);plot(MeanPowerGradsLong(:,1:4)); hold on; title('GradsLong');
xlabel('average  log power by condition');
subplot(2,3,2);plot(MeanPowerGradsLat(:,1:4)) ; hold on;title('GradsLat');
xlabel('average log power by condition');
subplot(2,3,3);plot(MeanPowerMags(:,1:4))     ; hold on;title('Mags');
xlabel('average log power by condition');


for i = 1:6
    MeanPowerGradsLong(i,1:4) = MeanPowerGradsLong(i,1:4)/MeanPowerGradsLong(i,5);
    MeanPowerGradsLat(i,1:4) = MeanPowerGradsLat(i,1:4)/MeanPowerGradsLat(i,5);
    MeanPowerMags(i,1:4) = MeanPowerMags(i,1:4)/MeanPowerMags(i,5);
end
    
subplot(2,3,4);plot(MeanPowerGradsLong(:,1:4)); hold on; title('GradsLong');
xlabel('log power ratio by condition');
subplot(2,3,5);plot(MeanPowerGradsLat(:,1:4)) ; hold on; title('GradsLat');
xlabel('log power ratio by condition');
subplot(2,3,6);plot(MeanPowerMags(:,1:4))     ; hold on; title('Mags');
xlabel('log power ratio by condition');

figure
subplot(3,4,1);plot(MeanPowerGradsLong(1:6,1)); hold on; title('theta (4-8Hz) : GradsLong');xlabel('log power ratio by condition');
subplot(3,4,2);plot(MeanPowerGradsLong(1:6,2)); hold on; title('alpha (8-14Hz) : GradsLong');xlabel('log power ratio by condition');
subplot(3,4,3);plot(MeanPowerGradsLong(1:6,3)); hold on; title('beta (15-30Hz) : GradsLong');xlabel('log power ratio by condition');
subplot(3,4,4);plot(MeanPowerGradsLong(1:6,4)); hold on; title('gamma (51-99Hz) : GradsLong');xlabel('log power ratio by condition');

subplot(3,4,5);plot(MeanPowerGradsLat(1:6,1)); hold on; title('theta (4-8Hz) : GradsLat');xlabel('log power ratio by condition');
subplot(3,4,6);plot(MeanPowerGradsLat(1:6,2)); hold on; title('alpha (8-14Hz) : GradsLat');xlabel('log power ratio by condition');
subplot(3,4,7);plot(MeanPowerGradsLat(1:6,3)); hold on; title('beta (15-30Hz) : GradsLat');xlabel('log power ratio by condition');
subplot(3,4,8);plot(MeanPowerGradsLat(1:6,4)); hold on; title('gamma (51-99Hz) : GradsLat');xlabel('log power ratio by condition');

subplot(3,4,9);plot(MeanPowerMags(1:6,1)); hold on; title('theta (4-8Hz) : Mags');xlabel('log power ratio by condition');
subplot(3,4,10);plot(MeanPowerMags(1:6,2)); hold on; title('alpha (8-14Hz) : Mags');xlabel('log power ratio by condition');
subplot(3,4,11);plot(MeanPowerMags(1:6,3)); hold on; title('beta (15-30Hz) : Mags');xlabel('log power ratio by condition');
subplot(3,4,12);plot(MeanPowerMags(1:6,4)); hold on; title('gamma (51-99Hz) : Mags');xlabel('log power ratio by condition');






    
    