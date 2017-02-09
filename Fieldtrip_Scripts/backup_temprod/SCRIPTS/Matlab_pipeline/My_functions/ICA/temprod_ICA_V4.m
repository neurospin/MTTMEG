function temprod_ICA_V4(index,subject,freqband,method,numcomponent,show)

Dir = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject];

for a = 1:8
    eval(['datapath' num2str(a) '= [''/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_'...
        subject '/run' num2str(a) '.mat'']']);
end

[Gradslong, Gradslat] = grads_for_layouts;
channeltype = {'MEG*1';Gradslong;Gradslat};
chan_index  = {'Mags';'Gradslong';'Gradslat'};
chan_cmt    = {'M';'G1';'G2'};

[GradsLong,GradsLat,Mags]     = grads_for_layouts;

if show == 1
    fig                 = figure('position',[1 1 1280/1.5 1024/1.5]);
    set(fig,'PaperPosition',[1 1 1280 1024])
    set(fig,'PaperPositionMode','auto')
end

durinfopath = [Dir '/FT_trials/run' num2str(index) 'durinfo.mat'];
load(durinfopath)
duration = [(info(:,2) - info(:,1)) (1:length(info))'];
asc_ord = sortrows(duration);

a = 1;
for i = (asc_ord(:,2))'
    load(fullfile(Dir,['/FT_trials/run' num2str(index) 'trial' num2str(i,'%03i') '.mat']))
    datatmp.trial{a}       = data.trial{1};
    datatmp.time{a}        = data.time{1};
    datatmp.label          = data.label;
    datatmp.sampleinfo     = data.sampleinfo;
    datatmp.fsample        = data.fsample;
    a = a+1;
end

FSAMPLE = data.fsample;
clear data
data = datatmp;

%% remove eog label and timecourses
if length(data.label) > 306
    data.label([307;308]) = [];
    for i = 1:length(data.trial)
        data.trial{1,i}(307:308,:) = [];
    end
end

%% test with random data with same size
% for i = 1:length(data.trial)
%     data.trial{1,i} = rand(size(data.trial{1,i},1),size(data.trial{1,i},2));
% end

%% rescale data matrix to avoid error in fastica
% for i = 1:length(data.trial)
%     data.trial{1,i} = data.trial{1,i}*10^14; % *multiply by a scalar don't affect ICA decomposition
% end

%% compute pca, get 10 components
clear cfg
cfg.method            = method;
cfg.fastica           = struct('numofIC',numcomponent);
cfg.runica            = struct('pca',numcomponent);
cfg.binica            = struct('ncomps',numcomponent);
cfg.channel           = 'MEG';
cfg.trials            = 'all';
cfg.numcomponent      = numcomponent;
cfg.blc               = 'no';
comp_topo             = ft_componentanalysis(cfg, data);

%% band-pass filtering
% if bandpasstag == 1
%     for i                  = 1:length(comp_topo.trial)
%         comp_topo.trial{i}      = ft_preproc_bandpassfilter(comp_topo.trial{i},data.fsample,bandpass);
%     end
% end

clear data

%% compute power spectra density on pca components
clear cfg
cfg.channel            = 'all';
cfg.method             = 'mtmfft';
cfg.output             = 'pow';
cfg.taper              = 'dpss';
cfg.tapsmofrq          = 1;
cfg.foi                = freqband(1):0.1:freqband(2);
cfg.trials             = 'all';
cfg.keeptrials         = 'yes';
cfg.keeptapers         = 'no';
cfg.pad                = MaxLength/FSAMPLE;
freq                   = ft_freqanalysis(cfg, comp_topo);

% interpolate data across 50hz line noise
LNfbegin                = find(freq.freq >= 47);
LNfend                  = find(freq.freq <= 53);
LNfband                 = LNfbegin(1):LNfend(end);
for i = 1:size(freq.powspctrm,1)
    for j = 1:size(freq.powspctrm,2)
        L = linspace(freq.powspctrm(i,j,LNfbegin(1)),... % beginning of the range
            freq.powspctrm(i,j,LNfend(end)),... % end of the range
            LNfend(end) - LNfbegin(1) + 1); % number of frequency bins to replace
        freq.powspctrm(i,j,LNfband) = L;
    end
end

% if removenoise == 1
%     Nfbegin                = find(freq.freq >= 90);
%     Nfend                  = find(freq.freq <= 94);
%     Nfband                 = Nfbegin(1):Nfend(end);
%     for i = 1:size(freq.powspctrm,1)
%         for j = 1:size(freq.powspctrm,2)
%             L = linspace(freq.powspctrm(i,j,Nfbegin(1)),... % beginning of the range
%                 freq.powspctrm(i,j,Nfend(end)),... % end of the range
%                 Nfend(end) - Nfbegin(1) + 1); % number of frequency bins to replace
%             freq.powspctrm(i,j,Nfband) = L;
%         end
%     end
% end

freqcomppath           = [par.ProcDataDir '/FT_ICs/runica-comp' num2str(numcomponent) 'V4_freq' num2str(index) '.mat'];
save(freqcomppath,'freq','comp_topo','freqband','cfg');

%% specifiy layout for plotting topographies
clear cfg
cfg.channel           = channeltype{1};
cfg.xparam            = 'comp';
cfg.zparam            = 'topo';
cfg.zlim              = 'maxabs';
cfg.baseline          = 'no';
cfg.trials            = 'all';
cfg.colormap          = jet;
cfg.marker            = 'off';
cfg.markersymbol      = 'none';
cfg.markercolor       = [0 0 0];
cfg.markersize        = 2;
cfg.markerfontsize    = 8;
cfg.colorbar          = 'no';
cfg.interplimits      = 'head';
cfg.interpolation     = 'v4';
cfg.style             = 'straight';
cfg.gridscale         = 67;
cfg.shading           = 'flat';
cfg.interactive       = 'no';
cfg.layout            = '/neurospin/meg_tmp/ResonanceMeg_Baptiste_2009/SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
lay                   = ft_prepare_layout(cfg,comp_topo);
tmp                   = chan_index{1};
eval(['lay.label             = ' tmp]);
cfg.layout            = lay;

%% plot the 10 first components topographies

if show == 1
    for i = 1:numcomponent
        
        hold on
        
        mysubplot(8,8, i*4 - 1)
        cfg.comment = [chan_cmt{1} 'comp' num2str(i)];
        cfg.commentpos = 'lefttop';
        cfg.electrodes = 'off';
        topoplot(cfg,comp_topo.topo(3:3:306,i));
        
        hold on
        
        mysubplot(8,8,i*4 - 2)
        cfg.comment = [chan_cmt{2} 'comp' num2str(i)];
        cfg.commentpos = 'lefttop';
        cfg.electrodes = 'off';
        topoplot(cfg,comp_topo.topo(1:3:306,i));
        
        hold on
        
        mysubplot(8,8,i*4 - 3)
        cfg.comment = [subject ' r' num2str(index) ' ' chan_cmt{3} 'comp' num2str(i)];
        cfg.commentpos = 'lefttop';
        cfg.electrodes = 'off';
        topoplot(cfg,comp_topo.topo(2:3:306,i));
        
    end
end

print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
        '/ICAV4_topo_overview_' num2str(freqband(1)) '-' num2str(freqband(2)) '_' num2str(index) '_' num2str(numcomponent) 'comp.png']);

if show == 1
    fig                 = figure('position',[1 1 1280/1.5 1024/1.5]);
    set(fig,'PaperPosition',[1 1 1280 1024])
    set(fig,'PaperPositionMode','auto')
    
    C = colormap(jet(30));

    L = [];
    for j = 1:numcomponent
        plot(freq.freq,log(squeeze(mean(freq.powspctrm(:,j,:),1))),'linewidth',2,'color',C(j,:));
        hold on
        L = [L '''comp' num2str(j) ''','];
    end

    Lfinal = ['legend(' L  '''Location'',''BestOutside'');'];
    eval(Lfinal);
    ylabel('log Power')
    xlabel('frequency (Hz)')
    title([subject ' run : ' num2str(index) 'Components Mean power Spectrm averaged across trials'])
    %         axis([1 80 min(min(log(squeeze(freq.powspctrm(:,1,:)))))...
    %                    max(max(log(squeeze(mean(freq.powspctrm(:,1,:)))))) ])
    
    %         mysubplot(12,15,(i*5))
    %         plot(freq.freq,log(mean(squeeze(freq.powspctrm(:,i,:)),1)));
    %         axis([1 80 min(log(mean(squeeze(freq.powspctrm(:,i,:)),1))) max(log(mean(squeeze(freq.powspctrm(:,i,:)),1))) ]);
    
end

    print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
        '/ICAV4_overview_' num2str(freqband(1)) '-' num2str(freqband(2)) '_' num2str(index) '_' num2str(numcomponent) 'comp.png']);
    
end