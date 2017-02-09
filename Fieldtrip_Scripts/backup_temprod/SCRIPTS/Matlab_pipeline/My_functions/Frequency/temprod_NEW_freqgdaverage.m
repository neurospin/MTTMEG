function temprod_NEW_freqgdaverage(freqbandfull,subject,index)

S = size(freqbandfull);

datapath = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/run'];

load([datapath num2str(index) '.mat'])
par.ProcDataDir            = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];
chantypefull               = {'Mags';'Gradslong';'Gradslat'};
[label2,label3,label1]     = grads_for_layouts;

fig                        = figure('position',[1 1 1280 1024]);
for x = 1:S(1)
    freqband = freqbandfull{x};
    for j = 1:3
        hold on
        subplot(S(1),3,(x-1)*3 + j)
        
        % load full spectra array
        chantype               = chantypefull{j};
        load([par.ProcDataDir 'Fullspctrm_' chantype num2str(index) '.mat']);
        % select frequency band of interest
        freqinit               = find(Fullfreq == freqband(1));
        freqend                = find(Fullfreq == freqband(2));
        freqresolution         = Fullfreq(2) - Fullfreq(1);
        freq.freq              = Fullfreq(freqinit:freqend);
        clear FullFreq
        % select the corresponding power
        freq.powspctrm         = Fullspctrm;
        freq.powspctrm         = freq.powspctrm(:,:,(freqinit:freqend));
        trialnumber            = size(Fullspctrm,1);
        clear Fullspctrm
        % complete dummy fieldtrip structure
        freq.dimord            = 'rpt_chan_freq';
        eval(['freq.label      = label' num2str(j) ';']);
        freq.cumtapcnt         = ones(trialnumber,length(freq.freq));
        
        clear cfg
        cfg.channel           = chantype;
        cfg.xparam            = 'freq';
        cfg.zparam            = 'powspctrm';
        cfg.xlim              = freqband;
%         cfg.zlim              = [1e-25 5.e-25];
        cfg.baseline          = 'no';
        cfg.trials            = 'all';
        cfg.colormap          = jet;
        cfg.marker            = 'off';
        cfg.markersymbol      = 'o';
        cfg.markercolor       = [0 0 0];
        cfg.markersize        = 2;
        cfg.markerfontsize    = 8;
        cfg.colorbar          = 'yes';
        cfg.interplimits      = 'head';
        cfg.interpolation     = 'v4';
        cfg.style             = 'both';
        cfg.gridscale         = 67;
        cfg.shading           = 'flat';
        cfg.interactive       = 'no';
        cfg.comment           = [num2str(freqband(1)) '-' num2str(freqband(2)) 'Hz cond ' num2str(index) chantype];
        cfg.layout            = '/neurospin/meg_tmp/ResonanceMeg_Baptiste_2009/SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
        lay                   = ft_prepare_layout(cfg,freq);
        lay.label             = freq.label;
        cfg.layout            = lay;
        
        ft_topoplotER(cfg,freq)
    end
end

% Vup                        = max(Vmax);
% Vdown                      = min(Vmin);

% for k = 1:6
%     subplot(2,3,k)
%     %     par.ProcDataDir        = '/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/OLD/processed/';
%     eval(['load(datapath' num2str(k) ');']);
%     %% fourier analysis %%
% [GradsLong, GradsLat]  = grads_for_layouts;
% if strcmp(chantype,'Mags')     == 1
%     channeltype        =  {'MEG*1'};
% elseif strcmp(chantype,'Gradslong') == 1;
%     channeltype        =  GradsLong;
% elseif strcmp(chantype,'Gradslat')
%     channeltype        =  GradsLat;
% end
%
%     clear cfg
%     cfg.channel            = channeltype;
%     cfg.method             = 'mtmfft';
%     cfg.output             = 'pow';
%     cfg.taper              = 'hanning';
%     cfg.foilim             = freqband;
%     foi                    = cfg.foilim;
%     cfg.tapsmofrq          = 0.5;
%     cfg.pad                = 'maxperlen';
%     cfg.trials             = 'all';
%     cfg.keeptrials         = 'no';
%     cfg.keeptapers         = 'no';
%     freq                   = ft_freqanalysis(cfg,data);

print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
    '/topomean-' num2str(freqband(1)) '-' num2str(freqband(2)) 'hz_' num2str(index) '.png']);





