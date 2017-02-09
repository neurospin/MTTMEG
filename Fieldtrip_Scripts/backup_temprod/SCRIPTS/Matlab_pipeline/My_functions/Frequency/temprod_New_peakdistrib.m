function temprod_New_peakdistrib(freqband,index,subject)

datapath = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/run'];
load([datapath num2str(index) '.mat'])

par.ProcDataDir            = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];
chantypefull               = {'Mags';'Gradslong';'Gradslat'};

Sample                     = [];
for i                      = 1:length(data.time)
    Sample                 = [Sample ; length(data.time{i})];
end
fsample                    = data.fsample;

fig                        = figure('position',[1 1 1280 1024]);
for l = 1:3
    chantype               = chantypefull{l};
    load([par.ProcDataDir 'Fullspctrm_' chantype num2str(index) '.mat']);
    
    Fbegin = find(Fullfreq >= freqband(1));
    Fend   = find(Fullfreq >= freqband(2));
    
    freq.powspctrm         = Fullspctrm(:,:,Fbegin:Fend);
    freq.freq              = Fullfreq(Fbegin:Fend);
    
    P = [];
    for i = 1:size(Fullspctrm,1)
        for j = 1:size(Fullspctrm,2)
            F = findpeaks(squeeze(freq.powspctrm(i,j,:)));
            F1 = cell(1,length(F));
            for k = 1:length(F)
                F1{k} = find(squeeze(freq.powspctrm(i,j,:)) == F(k));
                P = [P F1{k}'];
            end
        end
    end
    eval(['P' num2str(l) ' = P;']);
    
    subplot(3,3,l)
    hist(freq.freq(P), length(unique(P)));
    [n,x] = hist(freq.freq(P), 100);
    %     [n,x] = hist(freq.freq(P), length(unique(P)));
    %     n_norm = n/sum(n.*x);
    %     bar(x,n_norm)
    sub = subplot(3,3,3+l)
    [f,xi] = ksdensity(P);
    %     f_norm = f/sum(f.*xi);
    fp = findpeaks(f)
    for h = 1:length(fp)
        FP(h) = find(f == fp(h));
        X(h) = x(FP(h));
        text(1,1,num2str(X(h)));
    end
    plot(f)
    hold on
    plot(FP,f(FP),'linestyle','non','marker','o');
    hold on
    for i = 1:length(FP)
        text(FP(i),f(FP(i)),[num2str(round(x(FP(i))*10)/10) 'hz']);
    end
    set(sub,'XTick',1:10:100,'XTickLabel',round(x(1:10:100)*10)/10)
    
end

print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
    '/peak_alpha_ditribution_' num2str(index) '.png']);
end




