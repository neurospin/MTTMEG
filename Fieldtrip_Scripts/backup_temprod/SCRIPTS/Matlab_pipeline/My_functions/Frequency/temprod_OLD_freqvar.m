function temprod_OLD_freqvar(freqband,chantype,index,subject)

datapath = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/OLD/processed_' subject '/run'];

%% Plot basic correlation between frequency peak, frequency peak power and temporal
%% estimates

load(['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/OLD/processed_' subject '/'...
chantype 'freq_' num2str(freqband(1)) '_' num2str(freqband(2)) '_' num2str(index) '.mat']);

[GradsLong, GradsLat]  = grads_for_layouts;
if strcmp(chantype,'Mags')     == 1
    channeltype        =  {'MEG*1'};
elseif strcmp(chantype,'Gradslong') == 1;
    channeltype        =  GradsLong;
elseif strcmp(chantype,'Gradslat')
    channeltype        =  GradsLat;
end

for a                  = 1:size(freq.powspctrm,2)
    for b              = 1:size(freq.powspctrm,3)
        Pstd(a,b)      = std(freq.powspctrm(:,a,b));
    end
end

cfg.channel            = 'all'; 
cfg.xparam             = 'freq';
cfg.zparam             = 'powspctrm';
cfg.xlim               = [1 1];
cfg.zlim               = 'maxmin';
cfg.baseline           = 'no';
cfg.trials             = 'all';
cfg.colormap           = jet;
cfg.marker             = 'on';
cfg.markersymbol       = 'o';
cfg.markercolor        = [0 0 0];
cfg.markersize         = 2;
cfg.markerfontsize     = 8;
cfg.colorbar           = 'no';
cfg.interplimits       = 'head';
cfg.interpolation      = 'v4';
cfg.style              = 'both';
cfg.gridscale          = 67;
cfg.shading            = 'flat';
cfg.interactive        = 'no';
cfg.comment            = [chantype '-' num2str(freqband(1)) '-' num2str(freqband(2)) 'hz'];
cfg.layout             = '/neurospin/meg_tmp/ResonanceMeg_Baptiste_2009/SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
lay                    = ft_prepare_layout(cfg,freq);
if strcmp(chantype,'GradsLong')     == 1
    for i          = 1:102
        lay.label{i,1} = GradsLong{1,i};
    end
elseif strcmp(chantype,'GradsLat')     == 1
        for i          = 1:102
        lay.label{i,1} = GradsLat{1,i};
        end
elseif strcmp(chantype,'Mags')     == 1
    for i          = 1:102
        lay.label{i,1} = ['MEG' lay.label{i,1}];
    end
end
cfg.layout             = lay;

topoplot(cfg,mean(Pstd')')




