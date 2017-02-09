function [yf,ys] = resonance_tuning_multiplot(nip,runarray,tag)

freqvalues = [50 75 100 150 200 300 400 600];
r_freqvalues = [50 83.3 100 150 200 300 400 600];
chantype = {'Mags','Grads1','Grads2'};

% Mags
for c = 1:3
    for r = 1:length(runarray)
        for f = 1:length(freqvalues)
            load(['C:\RESONANCE_MEG\DATA\' nip '\freq\' chantype{c} '_freq_' runarray{r} '_' num2str(freqvalues(f)) '_stimfreq.mat']);
            
            % find SSR fund power valuevalue
            fbegin = []; fend = [];
            fbegin              = find(FREQ.freq >= (1000/r_freqvalues(f)));
            fend                = find(FREQ.freq < (1000/r_freqvalues(f)));
            if abs(1000/r_freqvalues(f) - FREQ.freq(fbegin(1))) <= abs(1000/r_freqvalues(f) - FREQ.freq(fend(end)))
                f_fund_ind      = fbegin(1);
            else
                f_fund_ind      = fend(end);
            end
            
            Powervalue_fund{c,r}(:,f) = FREQ.powspctrm(:,f_fund_ind);
            
            % find SSR fund power valuevalue
            fbegin = []; fend = [];
            fbegin              = find(FREQ.freq >= (500/r_freqvalues(f)));
            fend                = find(FREQ.freq < (500/r_freqvalues(f)));
            if abs(500/r_freqvalues(f) - FREQ.freq(fbegin(1))) <= abs(500/r_freqvalues(f) - FREQ.freq(fend(end)))
                f_sha_ind      = fbegin(1);
            else
                f_sha_ind      = fend(end);
            end
            
            Powervalue_sha{c,r}(:,f) = FREQ.powspctrm(:,f_sha_ind);
            
        end
    end
end

% plot results
tuningcurve_fund = cell(1,3); tuningcurve_sha = cell(1,3);
tuningcurve_fund{1} = zeros(102,8); tuningcurve_sha{1} = zeros(102,8);
tuningcurve_fund{2} = zeros(102,8); tuningcurve_sha{2} = zeros(102,8);
tuningcurve_fund{3} = zeros(102,8); tuningcurve_sha{3} = zeros(102,8);

scrsz = get(0,'ScreenSize');
fig   = figure('position',scrsz);
set(fig,'PaperPosition',scrsz)
set(fig,'PaperPositionMode','auto')

for i = 1:3
    for j = 1:length(runarray)
        tuningcurve_fund{i} = tuningcurve_fund{i} + Powervalue_fund{i,j};
        tuningcurve_sha{i} = tuningcurve_sha{i} + Powervalue_sha{i,j};
    end
    tuningcurve_fund{i}= tuningcurve_fund{i}/length(runarray);
    tuningcurve_sha{i}= tuningcurve_sha{i}/length(runarray);    
end

for i = 1:3
    for chan = 1:102
        [xf(i,chan),yf(i,chan)] = max(tuningcurve_fund{1,i}(chan,:));
        [xs(i,chan),ys(i,chan)] = max(tuningcurve_sha{1,i}(chan,:));
    end
end

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

mysubplot(2,3,1)
topoplot(cfg,log(1000./r_freqvalues(yf(1,:)')')); colorbar('Ytick',log(1000./r_freqvalues),'YTickLabel',ylbl_fund,'fontsize', 15)
mysubplot(2,3,2)
topoplot(cfg,log(1000./r_freqvalues(yf(2,:)')')); colorbar('Ytick',log(1000./r_freqvalues),'YTickLabel',ylbl_fund,'fontsize', 15);
mysubplot(2,3,3)
topoplot(cfg,log(1000./r_freqvalues(yf(3,:)')')); colorbar('Ytick',log(1000./r_freqvalues),'YTickLabel',ylbl_fund,'fontsize', 15);

mysubplot(2,3,4)
topoplot(cfg,log(1000./r_freqvalues(ys(1,:)')')); colorbar('Ytick',log(1000./r_freqvalues),'YTickLabel',ylbl_sha,'fontsize', 15);
mysubplot(2,3,5)
topoplot(cfg,log(1000./r_freqvalues(ys(2,:)')')); colorbar('Ytick',log(1000./r_freqvalues),'YTickLabel',ylbl_sha,'fontsize', 15);
mysubplot(2,3,6)
topoplot(cfg,log(1000./r_freqvalues(ys(3,:)')')); colorbar('Ytick',log(1000./r_freqvalues),'YTickLabel',ylbl_sha,'fontsize', 15);

print('-dpng',['C:\RESONANCE_MEG\DATA\' nip '\plots\topoplot_tuning.png'])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% polynomial fit %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:102
    TFund{i,1} = tuningcurve_fund{1,1}(i,:);
    TFund{i,2} = tuningcurve_fund{1,2}(i,:);
    TFund{i,3} = tuningcurve_fund{1,3}(i,:);
    TSha{i,1}  = tuningcurve_sha{1,1}(i,:);
    TSha{i,2}  = tuningcurve_sha{1,2}(i,:);
    TSha{i,3}  = tuningcurve_sha{1,3}(i,:);    
end
  
for k = 1:102
    
    P = [];xroot = []; yroot = []; Extrema = []; SOAP = [];
    [err,P,xroot,yroot,Extrema] = resonance_polyfit_2009_V5(TFund(k,1:3),1,3,r_freqvalues,'logpolyfit','realaxe');
    
    for i = 1:size(xroot,1)
        for j = 1:size(xroot,2)
            if yroot{i,j}(1) >= yroot{i,j}(2)
                SOAp(i,j) = exp(xroot{i,j}(1));
            else
                SOAp(i,j) = exp(xroot{i,j}(2));
            end
            if imag(SOAp(i,j)) ~= 0
                if polyval(P{i,j},log(50)) > polyval(P{i,j},log(600))
                    SOAp(i,j) = 50;
                else
                    SOAp(i,j) = 600;
                end
            end
            if SOAp(i,j) < 50
                SOAp(i,j) = 50;
            elseif SOAp(i,j) > 600
                SOAp(i,j) = 600;
            end
        end
    end
    
    c1(k) = SOAp(1,:);
    c2(k) = SOAp(2,:);
    c3(k) = SOAp(3,:);
    
end
    
scrsz = get(0,'ScreenSize');
fig   = figure('position',scrsz);
set(fig,'PaperPosition',scrsz)
set(fig,'PaperPositionMode','auto')

mysubplot(2,3,1)
topoplot(cfg,log(1000./c1')); colorbar('Ytick',log(1000./r_freqvalues),'YTickLabel',ylbl_fund,'fontsize', 15)
mysubplot(2,3,2)
topoplot(cfg,log(1000./c2')); colorbar('Ytick',log(1000./r_freqvalues),'YTickLabel',ylbl_fund,'fontsize', 15);
mysubplot(2,3,3)
topoplot(cfg,log(1000./c3')); colorbar('Ytick',log(1000./r_freqvalues),'YTickLabel',ylbl_fund,'fontsize', 15);

for k = 1:102
    
    P = [];xroot = []; yroot = []; Extrema = []; SOAP = [];
    [err,P,xroot,yroot,Extrema] = resonance_polyfit_2009_V5(TSha(k,1:3),1,3,r_freqvalues,'logpolyfit','realaxe');
    
    for i = 1:size(xroot,1)
        for j = 1:size(xroot,2)
            if yroot{i,j}(1) >= yroot{i,j}(2)
                SOAp(i,j) = exp(xroot{i,j}(1));
            else
                SOAp(i,j) = exp(xroot{i,j}(2));
            end
            if imag(SOAp(i,j)) ~= 0
                if polyval(P{i,j},log(50)) > polyval(P{i,j},log(600))
                    SOAp(i,j) = 50;
                else
                    SOAp(i,j) = 600;
                end
            end
            if SOAp(i,j) < 50
                SOAp(i,j) = 50;
            elseif SOAp(i,j) > 600
                SOAp(i,j) = 600;
            end
        end
    end
    
    c1(k) = SOAp(1,:);
    c2(k) = SOAp(2,:);
    c3(k) = SOAp(3,:);
    
end
    
mysubplot(2,3,4)
topoplot(cfg,log(1000./c1')); colorbar('Ytick',log(1000./r_freqvalues),'YTickLabel',ylbl_sha,'fontsize', 15)
mysubplot(2,3,5)
topoplot(cfg,log(1000./c2')); colorbar('Ytick',log(1000./r_freqvalues),'YTickLabel',ylbl_sha,'fontsize', 15);
mysubplot(2,3,6)
topoplot(cfg,log(1000./c3')); colorbar('Ytick',log(1000./r_freqvalues),'YTickLabel',ylbl_sha,'fontsize', 15);

print('-dpng',['C:\RESONANCE_MEG\DATA\' nip '\plots\topoplot_tuning_fit.png'])
    
    
    

