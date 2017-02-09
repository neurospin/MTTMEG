function temprod_betaERD(run,isdownsample,subject,runref,savetag)

% subject information, trigger definition and trial function %%
par.Sub_Num            = subject;
par.RawDir             = ['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Raw_' subject '/'];
par.DirHead            = ['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/HeadMvt_' subject '/'];
par.DataDir            = ['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Trans_sss_' subject '/'];
par.ProcDataDir        = ['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject '/'];
par.run                = run;

% MaxFilter parameters
par.DirMaxFil          = '/neurospin/meg/meg_tmp/temprod_Baptiste_2010/SCRIPTS/Maxfilter_scripts/';
par.NameMaxFil         = ['Maxfilter_temprod_OLD_' subject];
% ECG/EOG PCA projection
par.pcaproj            = ['_run' num2str(runref) '_raw_sss.fif'];
par.projfile_id        = 'compmeg';
% correct for Head Movement between runs %%
% made outside of fieldtrip
% perform MaxFilter processing %%
% made outside of fieldtrip

% generate epoched fieldtrip dataset %%

% define parameters from par %%
cfg                         = [];
cfg.continuous              = 'no';
cfg.headerformat            = 'neuromag_mne';
cfg.dataformat              = 'neuromag_mne';
cfg.trialdef.channel        = 'STI101';
cfg.trialdef.prestim        = 4;
cfg.trialdef.poststim       = 4;
cfg.photodelay              = 0.0038;
cfg.trialfun                = 'trialfun_temprod_betaERD';
cfg.Sub_Num                 = par.Sub_Num;
cfg.lpfreq                  = 'no';
cfg.dftfilter               = 'yes';


% trial definition and preprocessing
for i                       = par.run
    disp(['processing run ' num2str(i)]);
    cfg.dataset             = [par.DataDir par.Sub_Num '_run' num2str(i) '_raw_sss.fif'];
    cfg.DataDir             = par.DataDir;
    cfg.channel             = {'MEG*'};
    cfg.run                 = i;
    cfg_loc{1,i}            = ft_definetrial(cfg);
    data{1,i}               = ft_preprocessing(cfg_loc{1,i});
    MaxLength{1,i}          = (max(cfg_loc{1,i}.trl(:,2) - cfg_loc{1,i}.trl(:,1)))/data{1,i}.fsample;
    sampleinfo{1,i}         = data{1,i}.sampleinfo;
end;

datatmp.trial              = {};
datatmp.time               = {};
datatmp.sampleinfo         = [];

for i = 1:length(data)
    if isempty(data{1,i}) ~= 1
        datatmp.hdr        = data{1,i}.hdr;
        %         datatmp.grad       = data{1,i}.grad;
        datatmp.fsample    = data{1,i}.fsample;
        datatmp.cfg        = data{1,i}.cfg;
        datatmp.label      = data{1,i}.label;
        datatmp.trial      = [datatmp.trial data{1,i}.trial];
        datatmp.time       = [datatmp.time  data{1,i}.time ];
        datatmp.sampleinfo = [datatmp.sampleinfo ; data{1,i}.sampleinfo];
    end
end

clear data;
data                       = datatmp;
sampleinfo                 = datatmp.sampleinfo;
MaxLength                  = max(max(sampleinfo));

% remove electric line noise
% for i                  = 1:length(data.trial)
%     data.trial{i}      = ft_preproc_bandstopfilter(data.trial{i},data.fsample, [49 51]);
%     data.trial{i}      = ft_preproc_bandstopfilter(data.trial{i},data.fsample, [99 101]);
%     data.trial{i}      = ft_preproc_bandstopfilter(data.trial{i},data.fsample, [149 151]);
% end

% downsampling data
cfg                    = [];
cfg.resamplefs         = 250;
cfg.detrend            = 'no';
cfg.blc                = 'no';
cfg.feedback           = 'no';
cfg.trials             = 'all';
if isdownsample        == 1
    data               = ft_resampledata(cfg,data);
end

% artifact correction by removing PCA components computed with graph %%
data                   = temprod_pca(par,data);

% visual artifact detection %%
% cfg                    =[];
% cfg.method             ='summary';
% cfg.channel            = {'MEG','EOG'};
% cfg.alim               = 4e-11;
% cfg.megscale           = 1;
% cfg.eogscale           = 5e-7;
% cfg.keepchannel        = 'no';
% data                   = ft_rejectvisual(cfg,data);

info                   = sampleinfo;

durinfopath = [par.ProcDataDir 'FT_trials/run' num2str(run) 'durinfo.mat'];
save(durinfopath,'info');

MaxLength = [];
MinLength = [];
for i = 1:size(data.time,2)
    MaxLength = max([MaxLength length(data.time{i})]);
    MinLength = min([MinLength length(data.time{i})]);
end

powscales{1} = [-4e-24 4e-24];
powscales{2} = [-4e-26 4e-26];
powscales{3} = [-4e-26 4e-24];

chantypefull  = {'Mags';'Gradslong';'Gradslat'};
for j = 1:3
    chantype = chantypefull{j};
    [GradsLong, GradsLat]  = grads_for_layouts;
    if strcmp(chantype,'Mags')     == 1
        channeltype        =  {'MEG*1'};
    elseif strcmp(chantype,'Gradslong') == 1;
        channeltype        =  GradsLong;
    elseif strcmp(chantype,'Gradslat')
        channeltype        =  GradsLat;
    end
    clear cfg
    cfg.channel            = channeltype;
    cfg.method             = 'tfr';
    cfg.output             = 'pow';
    cfg.foi                = 1:0.5:30;
    cfg.toi                = 0:0.05:4;
    cfg.trials             = 'all';
    cfg.keeptrials         = 'no';
    cfg.waveletwidth       = 7;
    %     cfg.gwidth             = 3;
    freq{j}                = ft_freqanalysis(cfg,data);
    
    clear cfg
    cfg.parameter        = 'powspctrm';
    cfg.xlim             = 'maxmin';
    cfg.ylim             = 'maxmin';
    cfg.zlim             = 'maxmin';
%     cfg.zlim             = powscales{j};
    cfg.channel          = channeltype;
    cfg.baseline         = [2 4];
    cfg.baselinetype     = 'relative';
    cfg.trials           = 'all';
    cfg.box              = 'yes';
    cfg.colorbar         = 'yes';
    %     cfg.colormap         = 'jet';
    cfg.comment          = 'coin!';
    cfg.showlabels       = 'yes';
    cfg.hotkeys          = 'yes';
    cfg.showoutline      = 'yes';
    cfg.interactive      = 'yes';
    cfg.masknans         = 'yes';
    %   cfg.renderer         = 'painters', 'zbuffer',' opengl' or 'none' (default = [])
    cfg.layout            = '/neurospin/meg/meg_tmp/ResonanceMeg_Baptiste_2009/SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
    lay                   = ft_prepare_layout(cfg,freq);
    lay.label             = freq{j}.label;
    cfg.layout            = lay;
    
    fig                   = figure('position',[1 1 1280 1024]);
    ft_multiplotTFR(cfg, freq{1,j})
    freqtest = freq{1,j};
    ft_multiplotTFR(cfg, freqtest)
    
    fig                   = figure('position',[1 1 1280 1024]);
    cfg.parameter             = 'powspctrm';
    cfg.xlim                  = [4 5];
    cfg.ylim                  = [8 12];
    cfg.zlim                  = 'maxmin';
    cfg.channel               = 'all';
    cfg.baseline              = 'yes';
    cfg.baselinetype          = 'relative';
    cfg.trials                = 'all';
    cfg.colorbar              = 'yes';
    cfg.interactive           = 'yes';
    cfg.layout                = '/neurospin/meg/meg_tmp/ResonanceMeg_Baptiste_2009/SCRIPTS/Layouts_fieldtrip/NM306mag.lay';
    lay                       = ft_prepare_layout(cfg,freq);
    lay.label                 = freqtest.label;
    cfg.layout                = lay;   
    
    ft_topoplotTFR(cfg, freqtest)
    
    if savetag == 1
        print('-dpng',['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Plots_' subject...
            '/TF_1_30_' num2str(run) '.png']);
    end
    
    [FIND,BIND,VIND,LIND,RIND,FCHANS,BCHANS,VCHANS,LCHANS,RCHANS] = clusteranat;
    
end

    
    clear cfg
    cfg.parameter     = 'powspctrm';
    cfg.xlim          = 'maxmin';
    cfg.ylim          = 'maxmin';
    cfg.zlim          = 'maxmin';
    cfg.baseline      = [0 1];
    cfg.baselinetype  = 'absolute';
    cfg.trials        = 'all';
    cfg.channel       = 'all';
    cfg.hotkeys       = 'yes';
%     cfg.colormap      = 'jet';
    cfg.colorbar      = 'yes';
    cfg.interactive   = 'yes';
    
    subplot(3,3,1)
    ft_singleplotTFR(cfg,freq{1,1})
    subplot(3,3,2)
    ft_singleplotTFR(cfg,freq{1,2})
    subplot(3,3,3)
    ft_singleplotTFR(cfg,freq{1,3}) 
    
    cfg.baseline      = [0 2];
    cfg.baselinetype  = 'absolute';
    subplot(3,3,4)
    ft_singleplotTFR(cfg,freq{1,1})
    subplot(3,3,5)
    ft_singleplotTFR(cfg,freq{1,2})
    subplot(3,3,6)
    ft_singleplotTFR(cfg,freq{1,3}) 
    
    cfg.baseline      = [0 4];
    cfg.baselinetype  = 'absolute';
    subplot(3,3,7)
    ft_singleplotTFR(cfg,freq{1,1})
    subplot(3,3,8)
    ft_singleplotTFR(cfg,freq{1,2})
    subplot(3,3,9)
    ft_singleplotTFR(cfg,freq{1,3}) 
    
end

