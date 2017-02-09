%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function temprod_NEW_ICAcomp_fullcorr(index,ptreshold,subject)

datapath = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/run'];
load([datapath num2str(index) '.mat'])

par.ProcDataDir            = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];
chantypefull               = {'Mags';'Gradslong';'Gradlat'};

Sample                     = [];
for i                      = 1:length(data.time)
    Sample                 = [Sample ; length(data.time{i})];
end
fsample                    = data.fsample;

fig                        = figure('position',[1 1 1280 1024]);
for j = 1:3
    chantype               = chantypefull{j};
    load([par.ProcDataDir 'Fullspctrm_ICAcomp_' chantype num2str(index) '.mat']); 
    freq.powspctrm         = Fullspctrm;
    freq.freq              = Fullfreq;
    
    tmp                    = 1;
    select = []; selectmat = [];
    for a                  = 1:size(freq.powspctrm,3)
        for b                  = 1:size(freq.powspctrm,2)
            [rho(b,a),pval(b,a)]   = corr((Sample/fsample),freq.powspctrm(:,b,a));
            if pval(b,a) <= ptreshold
                select(tmp)    = b;
                tmp = tmp + 1;
                selectmat(b,a) = rho(b,a);
            else
                selectmat(b,a) = 0;
            end
        end
    end
    
    sub = subplot(2,3,j)
    imagesc(rho,[-0.5 0.5])
    ylabel('ICA components'); xlabel('frequency'); title([chantype ': linear regression coefficient'])
    set(sub,'XTick',11:50:length(Fullfreq),'XTickLabel',Fullfreq(11:50:end));
    colorbar
    sub = subplot(2,3,j+3)
    imagesc(selectmat,[-0.5 0.5])
    colorbar
    grid on
    
    ylabel('ICA components'); xlabel('frequency'); title([chantype ': T-test at ' num2str(ptreshold)]);
    set(sub,'XTick',11:50:length(Fullfreq),'XTickLabel',Fullfreq(11:50:end));
end

print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
    '/ICAcomp_chan-by-chan_fbin-by-fbin_corr' num2str(index) '.png']); 
