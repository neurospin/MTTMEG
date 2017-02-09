function  TFstatT_GroupLvl_v2(condnames,GDAVG,data1,data2,foi,chansel_)

if strcmp(data1.label{1,1},'MEG0111') == 1
    chantype = 'Mags';
    
    load('/neurospin/meg/meg_tmp/tools_tmp/Pipeline/pipeline/neuromag306mag_neighb.mat')
   
    
elseif strcmp(data1.label{1,1},'MEG0113') == 1 || strcmp(data1.label{1,1},'MEG0112') == 1
    chantype = 'Grads';
    
    load('/neurospin/meg/meg_tmp/tools_tmp/Pipeline/pipeline/neuromag306planar_neighb.mat')
    
elseif strcmp(data1.label{1,1},'EEG001') == 1
    chantype = 'EEG';
    
    cfg = [];
    EEG = EEG_for_layouts('Network');
    cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/eeg_64_NM20884N.lay';
    lay                       = ft_prepare_layout(cfg,GDAVG{1});
    lay.label               = EEG;
    
    cfg                          = [];
    myneighbourdist      = 0.17;
    cfg.method              = 'distance';
    cfg.channel              = EEG;
    cfg.layout                 = lay;
    cfg.minnbchan          = 2;
    cfg.neighbourdist      = myneighbourdist;
    cfg.feedback            = 'no';
    neighbours            = ft_prepare_neighbours(cfg, GDAVG{1});
    
    % to complete
end

[Grads1,Grads2,Mags]   = grads_for_layouts('Network');
% data1.label = Mags';
% data2.label = Mags';

% prepare layout
cfg                      = [];
if strcmp(chantype,'EEG') == 0
    cfg.layout           = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/fieldtrip-20130901/template/layout/NM306mag.lay';
else
    cfg.layout           = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/eeg_64_NM20884N.lay';
end
lay                      = ft_prepare_layout(cfg,data1);
lay.label                = data1.label;

data1save = data1;
data2save = data2;

cfg = [];
cfg.foilim = foi;
cfg.keeptrials    = 'yes';
data1 = ft_freqdescriptives(cfg,data1);
data2 = ft_freqdescriptives(cfg,data2);

% test based on fieldtrip tutorial
cfg                      = [];
cfg.channel              = 'all';
cfg.latency              = 'all';
cfg.frequency            = foi;
% cfg.avgoverfreq          = 'yes'; 
cfg.parameter            = 'powspctrm';
cfg.method               = 'montecarlo';
cfg.statistic            = 'depsamplesT';
cfg.correctm             = 'cluster';
cfg.clusteralpha         = 0.05;
cfg.clusterstatistic     = 'maxsum';
cfg.minnbchan            = 2;
cfg.tail                 = 0;
cfg.clustertail          = 0;
cfg.alpha                = 0.025;
cfg.numrandomization     = 500;
cfg.neighbours           = neighbours;

ntrialdim1 = size(data1.powspctrm,1);
ntrialdim2 = size(data2.powspctrm,1);

design1 = [1:ntrialdim1 1:ntrialdim1];

design2 = zeros(1,ntrialdim1 + ntrialdim2);
design2(1,1:ntrialdim1) = 1;
design2(1,(ntrialdim1+1):(ntrialdim1 + ntrialdim2))= 2;

cfg.design           = [design1; design2];
cfg.uvar  = 1;
cfg.ivar  = 2;

data1.freq = round(data1.freq); % "bug" correction to check further
data2.freq = round(data1.freq); % "bug" correction to check further

[stat] = ft_freqstatistics(cfg,data1,data2);

%% compure 3 significance masks
posmask007 = [];
posmask005 = [];
posmask0005 = [];
if isfield(stat,'posclusterslabelmat') == 1;
    storesigposclust007 = [];
    storesigposclust005 = [];
    storesigposclust0005 = [];
    posmask007 = zeros(size(stat.posclusterslabelmat,1),size(stat.posclusterslabelmat,3));
    posmask005 = zeros(size(stat.posclusterslabelmat,1),size(stat.posclusterslabelmat,3));
    posmask0005 = zeros(size(stat.posclusterslabelmat,1),size(stat.posclusterslabelmat,3));
    for i = 1:length(stat.posclusters)
        if (stat.posclusters(1,i).prob <= 0.07) && (stat.posclusters(1,i).prob > 0.05) 
            storesigposclust = [storesigposclust007 i];
            posmask007          = posmask007 + ((squeeze(sum(stat.posclusterslabelmat == i,2)))>= 1);
        elseif (stat.posclusters(1,i).prob <= 0.05) && (stat.posclusters(1,i).prob > 0.005) 
            storesigposclust = [storesigposclust005 i];
            posmask005          = posmask005 + ((squeeze(sum(stat.posclusterslabelmat == i,2)))>= 1);
        elseif (stat.posclusters(1,i).prob <= 0.005)
            storesigposclust = [storesigposclust0005 i];
            posmask0005          = posmask0005 + ((squeeze(sum(stat.posclusterslabelmat == i,2)))>= 1);
        end
    end
end
negmask007 = [];
negmask005 = [];
negmask0005 = [];
if isfield(stat,'negclusterslabelmat') == 1;
    storesignegclust007 = [];
    storesignegclust005 = [];
    storesignegclust0005 = [];
    negmask007 = zeros(size(stat.negclusterslabelmat,1),size(stat.negclusterslabelmat,3));
    negmask005 = zeros(size(stat.negclusterslabelmat,1),size(stat.negclusterslabelmat,3));
    negmask0005 = zeros(size(stat.negclusterslabelmat,1),size(stat.negclusterslabelmat,3));
    for i = 1:length(stat.negclusters)
        if (stat.negclusters(1,i).prob <= 0.07) && (stat.negclusters(1,i).prob > 0.05) 
            storesignegclust = [storesignegclust007 i];
            negmask007          = negmask007 + ((squeeze(sum(stat.negclusterslabelmat == i,2)))>= 1);
        elseif (stat.negclusters(1,i).prob <= 0.05) && (stat.negclusters(1,i).prob > 0.005) 
            storesignegclust = [storesignegclust005 i];
            negmask005          = negmask005 + ((squeeze(sum(stat.negclusterslabelmat == i,2)))>= 1);
        elseif (stat.negclusters(1,i).prob <= 0.005)
            storesignegclust = [storesignegclust0005 i];
            negmask0005          = negmask0005 + ((squeeze(sum(stat.negclusterslabelmat == i,2)))>=1);
        end
    end
end

if isempty(posmask007) == 0 && isempty(negmask007) == 0
    Mask007 = negmask007 + posmask007;
elseif isempty(posmask007) == 0 && isempty(negmask007) == 1
    Mask007 = posmask007;
elseif isempty(posmask007) == 1 && isempty(negmask007) == 0
    Mask007 = negmask007 ;
elseif isempty(posmask007) == 1 && isempty(negmask007) == 1
    Mask007 = zeros(size(stat.stat,1),size(stat.stat,2));
end

if isempty(posmask0005) == 0 && isempty(negmask0005) == 0
    Mask0005 = negmask0005 + posmask0005;
elseif isempty(posmask0005) == 0 && isempty(negmask0005) == 1
    Mask0005 = posmask0005;
elseif isempty(posmask0005) == 1 && isempty(negmask0005) == 0
    Mask0005 = negmask0005 ;
elseif isempty(posmask0005) == 1 && isempty(negmask0005) == 1
    Mask0005 = zeros(size(stat.stat,1),size(stat.stat,2));
end

if isempty(posmask005) == 0 && isempty(negmask005) == 0
    Mask005 = negmask005 + posmask005;
elseif isempty(posmask005) == 0 && isempty(negmask005) == 1
    Mask005 = posmask005;
elseif isempty(posmask005) == 1 && isempty(negmask005) == 0
    Mask005 = negmask005 ;
elseif isempty(posmask005) == 1 && isempty(negmask005) == 1
    Mask005 = zeros(size(stat.stat,1),size(stat.stat,2));
end

Mask = Mask005+ Mask0005; % only sign masks, marginal mask is for plot

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cdn = [];
for i = 1:length(condnames)
    cdn = [cdn condnames{i} '_'];
end

diff1 = data1save;
diff2 = data2save;
diff = diff1;
diff.powspctrm = diff1.powspctrm - diff2.powspctrm;

cfg = [];
cfg.foilim = foi;
DIFF1 = ft_freqdescriptives(cfg,data1);
DIFF2 = ft_freqdescriptives(cfg,data2);
DIFF = DIFF1;
DIFF.powspctrm = DIFF1.powspctrm - DIFF2.powspctrm;

countpos = 0;
if isfield(stat,'posclusters') == 1
    if isempty(stat.posclusters) == 0
        for k = 1:length(stat.posclusters)
            if stat.posclusters(1,k).prob < 0.05
                
                countpos = countpos + 1;
                
                fig = figure('position',[1 1 700 600]);
                set(fig,'PaperPosition',[1 1 700 600])
                set(fig,'PaperPositionmode','auto')
                set(fig,'Visible','on')
                
                % TF1
                subplot(9,7,[1 2 3  8 9 10])
                linmask = [];
                linmask = ceil(mean((squeeze(mean(stat.posclusterslabelmat(:,:,:)==k,2)))~=0,2));
                find(linmask == 1)
                cfg                          = [];
                cfg. zlim                  = 'maxabs';
                cfg.channel              = (stat.label(find(linmask == 1)))';
                ft_singleplotTFR(cfg,GDAVG{1,1})
                ylabel('Frequency'); xlabel('time')
                titlec = condnames{1};
                title(titlec)

                % TF2
                subplot(9,7,[22 23 24 29 30 31])
                linmask = [];
                linmask = ceil(mean((squeeze(mean(stat.posclusterslabelmat(:,:,:)==k,2)))~=0,2));
                cfg                          = [];
                cfg. zlim                  = 'maxabs';
                cfg.channel              = (stat.label(find(linmask == 1)))';
                ft_singleplotTFR(cfg,GDAVG{1,2})
                ylabel('Frequency'); xlabel('time')
                titlec = condnames{2};
                title(titlec)

                 % DIFF
                subplot(9,7,[5 6 7 12 13 14])
                linmask = [];
                linmask = ceil(mean((squeeze(mean(stat.posclusterslabelmat(:,:,:)==k,2)))~=0,2));
                cfg                          = [];
                cfg. zlim                  = 'maxabs';
                cfg.channel              = (stat.label(find(linmask == 1)))';
                ft_singleplotTFR(cfg,diff)
                ylabel('Frequency'); xlabel('time')
                titlec = 'pow: ';
                for i = 1:length(condnames)
                    titlec = [titlec condnames{i} '-'];
                end
                titlec(end) = [];
                title(titlec)
                
                % RASTER PLOT Tvalues
                
                subplot(9,7,[26 27 28 33 34 35])
                lim = [-max(max(max(stat.stat))) max(max(max(stat.stat)))];
                mask = (squeeze(mean(double(stat.posclusterslabelmat == k),2)) ~= 0);
                imagesc(squeeze(mean(stat.stat,2)).*(mask),lim)
                xlabel('Time samples'); ylabel('channels');
                
                titlec = 'T-values masked for p<0.05: ';
                for i = 1:length(condnames)
                    titlec = [titlec condnames{i} '-'];
                end
                titlec(end) = [];
                title(titlec)
                
                sample = (stat.time(end) - stat.time(1))./length(stat.time);
                n = round(0.2/sample);
                nfull = floor(length(stat.time)/n);
                set(gca,'xtick',1:n:nfull*n,'xticklabel',(stat.time(1:n:nfull*n)))
                colorbar
                
                 n = round(0.1/sample);
                 nfull = floor(length(stat.time)/n);
                 limmax = max(max(mean(DIFF.powspctrm,2)));
                 limmin  = min(min(mean(DIFF.powspctrm,2)));
                 lim = [-max(abs([limmin limmax])) +max(abs([limmin limmax]))];
                
                for j = 2:(min(nfull+1,30)-1)
                    mysubplot(9,7,j+41)
                    chansel = mask(:,1+n*(j-1));
                    if sum(chansel) == 0
                        cfg                            = [];
                        cfg.layout                   = lay;
                        cfg.xlim                      = [DIFF.time(1+n*(j-1)) DIFF.time(1+n*(j))];
                        cfg.zlim                      = lim;
                        cfg.style                     = 'straight';
                        cfg.parameter             = 'powspctrm';
                        cfg.marker                 = 'off';
                        cfg.comment               = [num2str(stat.time(1+n*(j-1))) ' ms'];
                        ft_topoplotTFR(cfg,DIFF);
                    else
                        [x,y] = find(chansel ~= 0);
                        cfg                             = [];
                        cfg.highlight                = 'on';
                        cfg.highlightchannel     = x;
                        cfg.highlightsymbol      = '.';
                        cfg.layout                    = lay;
                        cfg.xlim                      = [stat.time(1+n*(j-1)) stat.time(1+n*(j-1))];
                        cfg.zlim                      = lim;
                        cfg.style                     = 'straight';
                        cfg.parameter             = 'powspctrm';
                        cfg.marker                  = 'off';
                        cfg.comment                = [num2str(stat.time(1+n*(j-1))) ' ms'];
                        ft_topoplotTFR(cfg,DIFF);
                    end
                end
                
                
                folder = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/TFs/';
                if exist([folder cdn],'dir') == 0
                    mkdir([folder cdn])
                end
                % save plots
                filename = [folder cdn '/STATS_' chansel_ '_' num2str(foi(1)) '_' num2str(foi(2)) 'Hz_posclust' num2str(countpos)];
                print('-dpng',filename)
                
            end
        end
    end
end


countneg = 0;
if isfield(stat,'negclusters') == 1
    if isempty(stat.negclusters) == 0
        for k = 1:length(stat.negclusters)
            if stat.negclusters(1,k).prob < 0.05
                
                countneg = countneg + 1;
                
                fig = figure('position',[1 1 700 600]);
                set(fig,'PaperPosition',[1 1 700 600])
                set(fig,'PaperPositionmode','auto')
                set(fig,'Visible','on')
                
                % TF1
                subplot(9,7,[1 2 3  8 9 10])
                linmask = [];
                linmask = ceil(mean((squeeze(mean(stat.negclusterslabelmat(:,:,:)==k,2)))~=0,2));
                find(linmask == 1)
                cfg                          = [];
                cfg. zlim                  = 'maxabs';
                cfg.channel              = (stat.label(find(linmask == 1)))';
                ft_singleplotTFR(cfg,GDAVG{1,1})
                ylabel('Frequency'); xlabel('time')
                titlec = condnames{1};
                title(titlec)

                % TF2
                subplot(9,7,[22 23 24 29 30 31])
                linmask = [];
                linmask = ceil(mean((squeeze(mean(stat.negclusterslabelmat(:,:,:)==k,2)))~=0,2));
                cfg                          = [];
                cfg. zlim                  = 'maxabs';
                cfg.channel              = (stat.label(find(linmask == 1)))';
                ft_singleplotTFR(cfg,GDAVG{1,2})
                ylabel('Frequency'); xlabel('time')
                titlec = condnames{2};
                title(titlec)

                 % DIFF
                subplot(9,7,[5 6 7 12 13 14])
                linmask = [];
                linmask = ceil(mean((squeeze(mean(stat.negclusterslabelmat(:,:,:)==k,2)))~=0,2));
                cfg                          = [];
                cfg. zlim                  = 'maxabs';
                cfg.channel              = (stat.label(find(linmask == 1)))';
                ft_singleplotTFR(cfg,diff)
                ylabel('Frequency'); xlabel('time')
                titlec = 'pow: ';
                for i = 1:length(condnames)
                    titlec = [titlec condnames{i} '-'];
                end
                titlec(end) = [];
                title(titlec)
                
                % RASTER PLOT Tvalues
                
                subplot(9,7,[26 27 28 33 34 35])
                lim = [-max(max(max(stat.stat))) max(max(max(stat.stat)))];
                mask = (squeeze(mean(double(stat.negclusterslabelmat == k),2)) ~= 0);
                imagesc(squeeze(mean(stat.stat,2)).*(mask),lim)
                xlabel('Time samples'); ylabel('channels');
                
                titlec = 'T-values masked for p<0.05: ';
                for i = 1:length(condnames)
                    titlec = [titlec condnames{i} '-'];
                end
                titlec(end) = [];
                title(titlec)
                
                sample = (stat.time(end) - stat.time(1))./length(stat.time);
                n = round(0.2/sample);
                nfull = floor(length(stat.time)/n);
                set(gca,'xtick',1:n:nfull*n,'xticklabel',(stat.time(1:n:nfull*n)))
                colorbar
                
                 n = round(0.1/sample);
                 nfull = floor(length(stat.time)/n);
                 limmax = max(max(mean(DIFF.powspctrm,2)));
                 limmin  = min(min(mean(DIFF.powspctrm,2)));
                 lim = [-max(abs([limmin limmax])) +max(abs([limmin limmax]))];
                
                for j = 2:(min(nfull+1,30)-1)
                    mysubplot(9,7,j+41)
                    chansel = mask(:,1+n*(j-1));
                    if sum(chansel) == 0
                        cfg                            = [];
                        cfg.layout                   = lay;
                        cfg.xlim                      = [DIFF.time(1+n*(j-1)) DIFF.time(1+n*(j))];
                        cfg.zlim                      = lim;
                        cfg.style                     = 'straight';
                        cfg.parameter             = 'powspctrm';
                        cfg.marker                 = 'off';
                        cfg.comment               = [num2str(stat.time(1+n*(j-1))) ' ms'];
                        ft_topoplotTFR(cfg,DIFF);
                    else
                        [x,y] = find(chansel ~= 0);
                        cfg                             = [];
                        cfg.highlight                = 'on';
                        cfg.highlightchannel     = x;
                        cfg.highlightsymbol      = '.';
                        cfg.layout                    = lay;
                        cfg.xlim                      = [stat.time(1+n*(j-1)) stat.time(1+n*(j-1))];
                        cfg.zlim                      = lim;
                        cfg.style                     = 'straight';
                        cfg.parameter             = 'powspctrm';
                        cfg.marker                  = 'off';
                        cfg.comment                = [num2str(stat.time(1+n*(j-1))) ' ms'];
                        ft_topoplotTFR(cfg,DIFF);
                    end
                end
                
                
                folder = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP/TFs/';
                if exist([folder cdn],'dir') == 0
                    mkdir([folder cdn])
                end
                % save plots
                filename = [folder cdn '/STATS_' chansel_ '_' num2str(foi(1)) '_' num2str(foi(2)) 'Hz_negclust' num2str(countneg)];
                print('-dpng',filename)
                
            end
        end
    end
end

