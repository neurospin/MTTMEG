fig   = figure('position',[1 1 1000 1000]);
set(fig,'PaperPosition',[1 1 1000 1000])
set(fig,'PaperPositionMode','auto')

freqvalues = [50 75 100 150 200 300 400 600];
r_freqvalues = [50 83.3 100 150 200 300 400 600];
chantype = {'Mags','Grads1','Grads2'};

for i = 1:length(yf)
    for c = 1:3
        
        cfg                    = [];
        cfg.maplimits          = log([1 20]);
        cfg.style              = 'straight';
        cfg.electrodes         = 'off';
        cfg.layout             = ['C:\FIELDTRIP\fieldtrip-20120402\template\layout/NM306mag.lay'];
        % lay                    = ft_prepare_layout(cfg,FREQ);
        % lay.label              = FREQ.label(1:102);
        % cfg.layout             = lay;
        
        ylbl_fund                  = round(10*1000./r_freqvalues)/10;
        ylbl_sha                   = round(10*500./r_freqvalues)/10;
        
        mysubplot(5,6,1 + (i-1)*6 + c -1)
        topoplot(cfg,log(1000./r_freqvalues(yf{i}(c,:)')')); %colorbar('Ytick',log(1000./r_freqvalues),'YTickLabel',ylbl_fund,'fontsize', 15)
        mysubplot(5,6,1 + (i-1)*6 + c +2)
        topoplot(cfg,log(1000./r_freqvalues(ys{i}(c,:)')')); %colorbar('Ytick',log(1000./r_freqvalues),'YTickLabel',ylbl_fund,'fontsize', 15)            
    end
end

figure
topoplot(cfg,log(1000./r_freqvalues(yf{i}(c,:)')'));colorbar('Ytick',log(1000./r_freqvalues),'YTickLabel',ylbl_fund,'fontsize', 15)
figure
topoplot(cfg,log(1000./r_freqvalues(ys{i}(c,:)')')); colorbar('Ytick',log(1000./r_freqvalues),'YTickLabel',ylbl_sha,'fontsize', 15)  

for i = 1:length(yf)
    Yf_mags(i,:)   = yf{i}(1,:);
    Yf_grads1(i,:) = yf{i}(2,:);
    Yf_grads2(i,:) = yf{i}(3,:);
    Ys_mags(i,:)   = ys{i}(1,:);
    Ys_grads1(i,:) = ys{i}(2,:);
    Ys_grads2(i,:) = ys{i}(3,:);    
end

fig1 = figure('position',[1 1 1000 1000]);
set(fig1,'PaperPosition',[1 1 1000 1000])
set(fig1,'PaperPositionmode','auto')

mysubplot(5,6,1)
topoplot(cfg,mean(log(1000./r_freqvalues(Yf_mags)')')');
mysubplot(5,6,2)
topoplot(cfg,mean(log(1000./r_freqvalues(Yf_grads1)')')');
mysubplot(5,6,3)
topoplot(cfg,mean(log(1000./r_freqvalues(Yf_grads2)')')');

fig1 = figure('position',[1 1 1000 1000]);
set(fig1,'PaperPosition',[1 1 1000 1000])
set(fig1,'PaperPositionmode','auto')

mysubplot(5,6,1)
topoplot(cfg,mean(log(1000./r_freqvalues(Ys_mags)')')');
mysubplot(5,6,2)
topoplot(cfg,mean(log(1000./r_freqvalues(Ys_grads1)')')');
mysubplot(5,6,3)
topoplot(cfg,mean(log(1000./r_freqvalues(Ys_grads2)')')');
         


