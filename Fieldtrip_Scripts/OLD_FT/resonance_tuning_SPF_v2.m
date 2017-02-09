function [tuningcurve_fund, tuningcurve_sha, cfund, csha] = resonance_tuning_SPF_v2(nip,runarray,SPF,SPFname,tag)

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
            
            Powervalue_fund{c,r}(:,f) = FREQ.powspctrm(:,f_fund_ind).*SPF{1,c};
            
            % find SSR fund power valuevalue
            fbegin = []; fend = [];
            fbegin              = find(FREQ.freq >= (500/r_freqvalues(f)));
            fend                = find(FREQ.freq < (500/r_freqvalues(f)));
            if abs(500/r_freqvalues(f) - FREQ.freq(fbegin(1))) <= abs(500/r_freqvalues(f) - FREQ.freq(fend(end)))
                f_sha_ind      = fbegin(1);
            else
                f_sha_ind      = fend(end);
            end
            
            Powervalue_sha{c,r}(:,f) = FREQ.powspctrm(:,f_sha_ind).*SPF{1,c};
            
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
    
    subplot(2,3,i)
    errorbar(1000./r_freqvalues,mean(tuningcurve_fund{1,i}),std(tuningcurve_fund{1,i}),'linewidth',3); title([chantype{i} ': fund SPF ssr power'])
    errorbarlogx(0.01)
    subplot(2,3,i+3)
    errorbar(500./r_freqvalues,mean(tuningcurve_sha{1,i}),std(tuningcurve_sha{1,i}),'linewidth',3); title([chantype{i} ': sha SPF ssr power'])    
    errorbarlogx(0.01)
end

print('-dpng',['C:\RESONANCE_MEG\DATA\' nip '\plots\' SPFname '_tuning_curve.png'])

save(['C:\RESONANCE_MEG\DATA\' nip '\freq\' SPFname '_tuning_curve.mat'],'tuningcurve_fund','tuningcurve_sha')

% polynomial fitting
% fund

t{1} = mean(tuningcurve_fund{1,1});
t{2} = mean(tuningcurve_fund{1,2});
t{3} = mean(tuningcurve_fund{1,3});
[err,P,xroot,yroot,Extrema] = resonance_polyfit_2009_V5(t,1,3,r_freqvalues,'logpolyfit','realaxe');

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

c1 = SOAp(1,:); 
c2 = SOAp(2,:); 
c3 = SOAp(3,:); 

cfund = [c1 c2 c3];

% polynomial fitting
% sha

t{1} = mean(tuningcurve_sha{1,1});
t{2} = mean(tuningcurve_sha{1,2});
t{3} = mean(tuningcurve_sha{1,3});
[err,P,xroot,yroot,Extrema] = resonance_polyfit_2009_V5(t,1,3,r_freqvalues,'logpolyfit','realaxe');

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

c1 = SOAp(1,:); 
c2 = SOAp(2,:); 
c3 = SOAp(3,:); 

csha = [c1 c2 c3];

