function temprod_ICA_V3(index,subject,bandpass,bandpasstag,freqband,K,method,numcomponent,show,removenoise)

Dir = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject];

for a = 1:8
    eval(['datapath' num2str(a) '= [''/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_'...
        subject '/run' num2str(a) '.mat'']']);
end

[Gradslong, Gradslat] = grads_for_layouts;
channeltype = {'MEG*1';Gradslong;Gradslat};
chan_index  = {'Mags';'Gradslong';'Gradslat'};

[GradsLong,GradsLat,Mags]     = grads_for_layouts;

if show == 1
    fig = figure('position',[1 1 1280 1024]);
end

durinfopath = [Dir '/FT_trials/run' num2str(index) 'durinfo.mat'];
load(durinfopath)
duration = [(info(:,2) - info(:,1)) (1:length(info))'];
asc_ord = sortrows(duration);

a = 1;
for i = (asc_ord(:,2))'
    load(fullfile(Dir,['/FT_trials/run' num2str(index) 'trial' num2str(i,'%03i') '.mat']))
%     tmptrial               = [data.trial{1} zeros(size(data.trial{1},1),ceil(MaxLength-size(data.trial{1},2)))];
%     tmpresol               = 1/data.fsample;
%     tmptime                = 0:tmpresol:(size(tmptrial,2) - 1)*tmpresol;
%     data.trial{1}          = tmptrial;
%     data.time{1}           = tmptime;
%     clear tmptrial tmpresol tmptime
    datatmp.trial{a}       = data.trial{1};
    datatmp.time{a}        = data.time{1};
    datatmp.label          = data.label;
    datatmp.sampleinfo     = data.sampleinfo;
    datatmp.fsample        = data.fsample;
    a = a+1;
end

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
for i = 1:length(data.trial)
    data.trial{1,i} = data.trial{1,i}*10^14; % *multiply by a scalar don't afefct ICA decomposition
end

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
cfg.pad                = MaxLength/data.fsample;
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

if removenoise == 1
    Nfbegin                = find(freq.freq >= 90);
    Nfend                  = find(freq.freq <= 94);
    Nfband                 = Nfbegin(1):Nfend(end);
    for i = 1:size(freq.powspctrm,1)
        for j = 1:size(freq.powspctrm,2)
            L = linspace(freq.powspctrm(i,j,Nfbegin(1)),... % beginning of the range
                freq.powspctrm(i,j,Nfend(end)),... % end of the range
                Nfend(end) - Nfbegin(1) + 1); % number of frequency bins to replace
            freq.powspctrm(i,j,Nfband) = L;
        end
    end
end

freqcomppath           = [par.ProcDataDir '/FT_ICs/runica-comp' num2str(numcomponent) 'V3_freq' num2str(index) '.mat'];
save(freqcomppath,'freq','comp_topo','bandpass','freqband','cfg');

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
Fullspctrm          = freq.powspctrm;
h =[];
for x               = 1:size(Fullspctrm,2)
    g = [];
    for y           = 1:size(Fullspctrm,3)
        v           = squeeze(Fullspctrm(:,x,y))';
        f           = conv(v,K,'same');
        g(:,y) = f;
        clear f
    end
    h = cat(3,h,g);
end
h = permute(h,[1 3 2]);
Fullspctrm = h;

if show == 1
    for i = 1:numcomponent
        mysubplot(15,10,(i*5-4))
        cfg.comment = [chan_index{1} 'comp' num2str(i)];
        cfg.electrodes = 'off';
        topoplot(cfg,comp_topo.topo(3:3:306,i));
        
        mysubplot(15,10,(i*5-3))
        cfg.comment = [chan_index{2} 'comp' num2str(i)];
        cfg.electrodes = 'off';
        topoplot(cfg,comp_topo.topo(1:3:306,i));
        
        mysubplot(15,10,(i*5-2))
        cfg.comment = [chan_index{3} 'comp' num2str(i)];
        cfg.electrodes = 'off';
        topoplot(cfg,comp_topo.topo(2:3:306,i));
        
        mysubplot(15,10,(i*5-1))
        plot(freq.freq,squeeze(mean(freq.powspctrm,2)));
        
        mysubplot(15,10,(i*5))
        plot(freq.freq,mean(squeeze(mean(freq.powspctrm,2))));
    end
    
    print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
        '/ICAV3_overview_' num2str(freqband(1)) '-' num2str(freqband(2)) '_' num2str(index) '_' num2str(numcomponent) 'comp' '.png']);
    
end
end