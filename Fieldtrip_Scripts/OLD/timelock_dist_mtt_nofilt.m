function timelock_dist_mtt_nofilt(nip)

% define channel types
[Grads1,Grads2,Mags]   = grads_for_layouts('Laptop');

clear datafilt40
load(['C:\MTT_MEG\data\' nip '\processed\PastClose_filt40.mat']);

%% T1

% cfg.trials             = 'all';
% cfg.minlength          = 'maxperlen';
% cfg.offset             = 0.4*data.fsample;
% dataraT1               = ft_redefinetrial(cfg, datafilt40);
dataraT1               = datafilt40;

cfg.channel            = Mags;
cfg.trials             = 'all';
cfg.keeptrials         = 'no';
cfg.removemean         = 'yes';
cfg.covariance         = 'yes';
cfg.covariancewindow   = [0 1.5];
datalockmagsT1         = ft_timelockanalysis(cfg, dataraT1);
cfg.channel            = Grads1;
datalockgrads1T1       = ft_timelockanalysis(cfg, dataraT1);
cfg.channel            = Grads2;
datalockgrads2T1       = ft_timelockanalysis(cfg, dataraT1);

cfg                    = [];
cfg.baseline           = [0.2 0.4]; 
cfg.channel            = 'all';
timelockbasemagsPaC     = ft_timelockbaseline(cfg, datalockmagsT1);
timelockbasegrads1PaC   = ft_timelockbaseline(cfg, datalockgrads1T1);
timelockbasegrads2PaC   = ft_timelockbaseline(cfg, datalockgrads2T1);

%% T2
clear datafilt40
load(['C:\MTT_MEG\data\' nip '\processed\PastFar_filt40.mat']);

% cfg.trials             = 'all';
% cfg.minlength          = 'maxperlen';
% cfg.offset             = 0.4*data.fsample;
% dataraT2               = ft_redefinetrial(cfg, datafilt40);
dataraT2               = datafilt40;

cfg.channel            = Mags;
cfg.trials             = 'all';
cfg.keeptrials         = 'no';
cfg.removemean         = 'yes';
cfg.covariance         = 'yes';
cfg.covariancewindow   = [0 1.5];
datalockmagsT2         = ft_timelockanalysis(cfg, dataraT2);
cfg.channel            = Grads1;
datalockgrads1T2       = ft_timelockanalysis(cfg, dataraT2);
cfg.channel            = Grads2;
datalockgrads2T2       = ft_timelockanalysis(cfg, dataraT2);

cfg                    = [];
cfg.baseline           = [0.2 0.4]; 
cfg.channel            = 'all';
timelockbasemagsPaF    = ft_timelockbaseline(cfg, datalockmagsT2);
timelockbasegrads1PaF  = ft_timelockbaseline(cfg, datalockgrads1T2);
timelockbasegrads2PaF  = ft_timelockbaseline(cfg, datalockgrads2T2);

%% T3
clear datafilt40
load(['C:\MTT_MEG\data\' nip '\processed\PresentClose_filt40.mat']);

% cfg.trials             = 'all';
% cfg.minlength          = 'maxperlen';
% cfg.offset             = 0.4*data.fsample;
% dataraT3               = ft_redefinetrial(cfg, datafilt40);
dataraT3               = datafilt40;

cfg.channel            = Mags;
cfg.trials             = 'all';
cfg.keeptrials         = 'no';
cfg.removemean         = 'yes';
cfg.covariance         = 'yes';
cfg.covariancewindow   = [0 1.5];
datalockmagsT3         = ft_timelockanalysis(cfg, dataraT3);
cfg.channel            = Grads1;
datalockgrads1T3       = ft_timelockanalysis(cfg, dataraT3);
cfg.channel            = Grads2;
datalockgrads2T3       = ft_timelockanalysis(cfg, dataraT3);

cfg                    = [];
cfg.baseline           = [0.2 0.4]; 
cfg.channel            = 'all';
timelockbasemagsPrC    = ft_timelockbaseline(cfg, datalockmagsT3);
timelockbasegrads1PrC  = ft_timelockbaseline(cfg, datalockgrads1T3);
timelockbasegrads2PrC  = ft_timelockbaseline(cfg, datalockgrads2T3);

%% S1
clear datafilt40
load(['C:\MTT_MEG\data\' nip '\processed\PresentFar_filt40.mat']);

% cfg.trials             = 'all';
% cfg.minlength          = 'maxperlen';
% cfg.offset             = 0.4*data.fsample;
% dataraS1               = ft_redefinetrial(cfg, datafilt40);
dataraS1               = datafilt40;

cfg.channel            = Mags;
cfg.trials             = 'all';
cfg.keeptrials         = 'no';
cfg.removemean         = 'yes';
cfg.covariance         = 'yes';
cfg.covariancewindow   = [0 1.5];
datalockmagsS1         = ft_timelockanalysis(cfg, dataraS1);
cfg.channel            = Grads1;
datalockgrads1S1       = ft_timelockanalysis(cfg, dataraS1);
cfg.channel            = Grads2;
datalockgrads2S1       = ft_timelockanalysis(cfg, dataraS1);

cfg                    = [];
cfg.baseline           = [0.2 0.4]; 
cfg.channel            = 'all';
timelockbasemagsPrF    = ft_timelockbaseline(cfg, datalockmagsS1);
timelockbasegrads1PrF  = ft_timelockbaseline(cfg, datalockgrads1S1);
timelockbasegrads2PrF  = ft_timelockbaseline(cfg, datalockgrads2S1);

%% S2
clear datafilt40
load(['C:\MTT_MEG\data\' nip '\processed\FutureClose_filt40.mat']);

% cfg.trials             = 'all';
% cfg.minlength          = 'maxperlen';
% cfg.offset             = 0.4*data.fsample;
% dataraS2               = ft_redefinetrial(cfg, datafilt40);
dataraS2               = datafilt40;
  
cfg.channel            = Mags;
cfg.trials             = 'all';
cfg.keeptrials         = 'no';
cfg.removemean         = 'yes';
cfg.covariance         = 'yes';
cfg.covariancewindow   = [0 1.5];
datalockmagsS2         = ft_timelockanalysis(cfg, dataraS2);
cfg.channel            = Grads1;
datalockgrads1S2       = ft_timelockanalysis(cfg, dataraS2);
cfg.channel            = Grads2;
datalockgrads2S2       = ft_timelockanalysis(cfg, dataraS2);

cfg                    = [];
cfg.baseline           = [0.2 0.4]; 
cfg.channel            = 'all';
timelockbasemagsFC     = ft_timelockbaseline(cfg, datalockmagsS2);
timelockbasegrads1FC   = ft_timelockbaseline(cfg, datalockgrads1S2);
timelockbasegrads2FC   = ft_timelockbaseline(cfg, datalockgrads2S2);

%% S3
clear datafilt40
load(['C:\MTT_MEG\data\' nip '\processed\FutureFar_filt40.mat']);

% cfg.trials             = 'all';
% cfg.minlength          = 'maxperlen';
% cfg.offset             = 0.4*data.fsample;
% dataraS3               = ft_redefinetrial(cfg, datafilt40);
dataraS3               = datafilt40;

cfg.channel            = Mags;
cfg.trials             = 'all';
cfg.keeptrials         = 'no';
cfg.removemean         = 'yes';
cfg.covariance         = 'yes';
cfg.covariancewindow   = [0 1.5];
datalockmagsS3         = ft_timelockanalysis(cfg, dataraS3);
cfg.channel            = Grads1;
datalockgrads1S3       = ft_timelockanalysis(cfg, dataraS3);
cfg.channel            = Grads2;
datalockgrads2S3       = ft_timelockanalysis(cfg, dataraS3);

cfg                    = [];
cfg.baseline           = [0.2 0.4]; 
cfg.channel            = 'all';
timelockbasemagsFF     = ft_timelockbaseline(cfg, datalockmagsS3);
timelockbasegrads1FF   = ft_timelockbaseline(cfg, datalockgrads1S3);
timelockbasegrads2FF  = ft_timelockbaseline(cfg, datalockgrads2S3);



save(['C:\MTT_MEG\data\' nip '\processed\Mags_DIST_lock_filt40.mat'], ...
'timelockbasemagsPaC','timelockbasemagsPrC','timelockbasemagsFC',...
'timelockbasemagsPaF','timelockbasemagsPrF','timelockbasemagsFF')

save(['C:\MTT_MEG\data\' nip '\processed\Grads1_DIST_lock_filt40.mat'], ...
'timelockbasegrads1PaC','timelockbasegrads1PrC','timelockbasegrads1FC',...
'timelockbasegrads1PaF','timelockbasegrads1PrF','timelockbasegrads1FF')
  
save(['C:\MTT_MEG\data\' nip '\processed\Grads2_DIST_lock_filt40.mat'], ...
'timelockbasegrads2PaC','timelockbasegrads2PrC','timelockbasegrads2FC',...
'timelockbasegrads2PaF','timelockbasegrads2PrF','timelockbasegrads2FF')
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% define channel types
[Grads1,Grads2,Mags]   = grads_for_layouts('Laptop');

clear datafilt40
load(['C:\MTT_MEG\data\' nip '\processed\PastClose_nofilt.mat']);

%% T1

% cfg.trials             = 'all';
% cfg.minlength          = 'maxperlen';
% cfg.offset             = 0.4*data.fsample;
% dataraT1               = ft_redefinetrial(cfg, datafilt40);
dataraT1               = data;

cfg.channel            = Mags;
cfg.trials             = 'all';
cfg.keeptrials         = 'no';
cfg.removemean         = 'yes';
cfg.covariance         = 'yes';
cfg.covariancewindow   = [0 1.5];
datalockmagsT1         = ft_timelockanalysis(cfg, dataraT1);
cfg.channel            = Grads1;
datalockgrads1T1       = ft_timelockanalysis(cfg, dataraT1);
cfg.channel            = Grads2;
datalockgrads2T1       = ft_timelockanalysis(cfg, dataraT1);

cfg                    = [];
cfg.baseline           = [0.2 0.4]; 
cfg.channel            = 'all';
timelockbasemagsPaC     = ft_timelockbaseline(cfg, datalockmagsT1);
timelockbasegrads1PaC   = ft_timelockbaseline(cfg, datalockgrads1T1);
timelockbasegrads2PaC   = ft_timelockbaseline(cfg, datalockgrads2T1);

%% T2
clear datafilt40
load(['C:\MTT_MEG\data\' nip '\processed\PastFar_nofilt.mat']);

% cfg.trials             = 'all';
% cfg.minlength          = 'maxperlen';
% cfg.offset             = 0.4*data.fsample;
% dataraT2               = ft_redefinetrial(cfg, datafilt40);
dataraT2               = data;

cfg.channel            = Mags;
cfg.trials             = 'all';
cfg.keeptrials         = 'no';
cfg.removemean         = 'yes';
cfg.covariance         = 'yes';
cfg.covariancewindow   = [0 1.5];
datalockmagsT2         = ft_timelockanalysis(cfg, dataraT2);
cfg.channel            = Grads1;
datalockgrads1T2       = ft_timelockanalysis(cfg, dataraT2);
cfg.channel            = Grads2;
datalockgrads2T2       = ft_timelockanalysis(cfg, dataraT2);

cfg                    = [];
cfg.baseline           = [0.2 0.4]; 
cfg.channel            = 'all';
timelockbasemagsPaF    = ft_timelockbaseline(cfg, datalockmagsT2);
timelockbasegrads1PaF  = ft_timelockbaseline(cfg, datalockgrads1T2);
timelockbasegrads2PaF  = ft_timelockbaseline(cfg, datalockgrads2T2);

%% T3
clear datafilt40
load(['C:\MTT_MEG\data\' nip '\processed\PresentClose_nofilt.mat']);

% cfg.trials             = 'all';
% cfg.minlength          = 'maxperlen';
% cfg.offset             = 0.4*data.fsample;
% dataraT3               = ft_redefinetrial(cfg, datafilt40);
dataraT3               = data;

cfg.channel            = Mags;
cfg.trials             = 'all';
cfg.keeptrials         = 'no';
cfg.removemean         = 'yes';
cfg.covariance         = 'yes';
cfg.covariancewindow   = [0 1.5];
datalockmagsT3         = ft_timelockanalysis(cfg, dataraT3);
cfg.channel            = Grads1;
datalockgrads1T3       = ft_timelockanalysis(cfg, dataraT3);
cfg.channel            = Grads2;
datalockgrads2T3       = ft_timelockanalysis(cfg, dataraT3);

cfg                    = [];
cfg.baseline           = [0.2 0.4]; 
cfg.channel            = 'all';
timelockbasemagsPrC    = ft_timelockbaseline(cfg, datalockmagsT3);
timelockbasegrads1PrC  = ft_timelockbaseline(cfg, datalockgrads1T3);
timelockbasegrads2PrC  = ft_timelockbaseline(cfg, datalockgrads2T3);

%% S1
clear datafilt40
load(['C:\MTT_MEG\data\' nip '\processed\PresentFar_nofilt.mat']);

% cfg.trials             = 'all';
% cfg.minlength          = 'maxperlen';
% cfg.offset             = 0.4*data.fsample;
% dataraS1               = ft_redefinetrial(cfg, datafilt40);
dataraS1               = data;

cfg.channel            = Mags;
cfg.trials             = 'all';
cfg.keeptrials         = 'no';
cfg.removemean         = 'yes';
cfg.covariance         = 'yes';
cfg.covariancewindow   = [0 1.5];
datalockmagsS1         = ft_timelockanalysis(cfg, dataraS1);
cfg.channel            = Grads1;
datalockgrads1S1       = ft_timelockanalysis(cfg, dataraS1);
cfg.channel            = Grads2;
datalockgrads2S1       = ft_timelockanalysis(cfg, dataraS1);

cfg                    = [];
cfg.baseline           = [0.2 0.4]; 
cfg.channel            = 'all';
timelockbasemagsPrF    = ft_timelockbaseline(cfg, datalockmagsS1);
timelockbasegrads1PrF  = ft_timelockbaseline(cfg, datalockgrads1S1);
timelockbasegrads2PrF  = ft_timelockbaseline(cfg, datalockgrads2S1);

%% S2
clear datafilt40
load(['C:\MTT_MEG\data\' nip '\processed\FutureClose_nofilt.mat']);

% cfg.trials             = 'all';
% cfg.minlength          = 'maxperlen';
% cfg.offset             = 0.4*data.fsample;
% dataraS2               = ft_redefinetrial(cfg, datafilt40);
dataraS2               = data;
  
cfg.channel            = Mags;
cfg.trials             = 'all';
cfg.keeptrials         = 'no';
cfg.removemean         = 'yes';
cfg.covariance         = 'yes';
cfg.covariancewindow   = [0 1.5];
datalockmagsS2         = ft_timelockanalysis(cfg, dataraS2);
cfg.channel            = Grads1;
datalockgrads1S2       = ft_timelockanalysis(cfg, dataraS2);
cfg.channel            = Grads2;
datalockgrads2S2       = ft_timelockanalysis(cfg, dataraS2);

cfg                    = [];
cfg.baseline           = [0.2 0.4]; 
cfg.channel            = 'all';
timelockbasemagsFC     = ft_timelockbaseline(cfg, datalockmagsS2);
timelockbasegrads1FC   = ft_timelockbaseline(cfg, datalockgrads1S2);
timelockbasegrads2FC   = ft_timelockbaseline(cfg, datalockgrads2S2);

%% S3
clear datafilt40
load(['C:\MTT_MEG\data\' nip '\processed\FutureFar_nofilt.mat']);

% cfg.trials             = 'all';
% cfg.minlength          = 'maxperlen';
% cfg.offset             = 0.4*data.fsample;
% dataraS3               = ft_redefinetrial(cfg, datafilt40);
dataraS3               = data;

cfg.channel            = Mags;
cfg.trials             = 'all';
cfg.keeptrials         = 'no';
cfg.removemean         = 'yes';
cfg.covariance         = 'yes';
cfg.covariancewindow   = [0 1.5];
datalockmagsS3         = ft_timelockanalysis(cfg, dataraS3);
cfg.channel            = Grads1;
datalockgrads1S3       = ft_timelockanalysis(cfg, dataraS3);
cfg.channel            = Grads2;
datalockgrads2S3       = ft_timelockanalysis(cfg, dataraS3);

cfg                    = [];
cfg.baseline           = [0.2 0.4]; 
cfg.channel            = 'all';
timelockbasemagsFF     = ft_timelockbaseline(cfg, datalockmagsS3);
timelockbasegrads1FF   = ft_timelockbaseline(cfg, datalockgrads1S3);
timelockbasegrads2FF  = ft_timelockbaseline(cfg, datalockgrads2S3);



save(['C:\MTT_MEG\data\' nip '\processed\Mags_DIST_lock_nofilt.mat'], ...
'timelockbasemagsPaC','timelockbasemagsPrC','timelockbasemagsFC',...
'timelockbasemagsPaF','timelockbasemagsPrF','timelockbasemagsFF')

save(['C:\MTT_MEG\data\' nip '\processed\Grads1_DIST_lock_nofilt.mat'], ...
'timelockbasegrads1PaC','timelockbasegrads1PrC','timelockbasegrads1FC',...
'timelockbasegrads1PaF','timelockbasegrads1PrF','timelockbasegrads1FF')
  
save(['C:\MTT_MEG\data\' nip '\processed\Grads2_DIST_lock_nofilt.mat'], ...
'timelockbasegrads2PaC','timelockbasegrads2PrC','timelockbasegrads2FC',...
'timelockbasegrads2PaF','timelockbasegrads2PrF','timelockbasegrads2FF')



