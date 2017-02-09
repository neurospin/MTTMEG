function data_raw = ft_jr_ecgeog(cfg)
%% data_raw = ft_jr_ecgeog(cfg)
% function that automatically removes the ECG artefact using a PCA on the
% average artefact.
% -------------------------------------------------------------------------
% inputs
%   - cfg.dataset           => path of dataset
%   - cfg.plot              => 'yes' or 'no'            (default = 'yes')
%   - cfg.chantypes         => cells of chantypes       (default => all)
%   - cfg.ecgchan           => ecg channel              (default => read from header)
%   - cfg.dataformat        =>                          (default => 'neuromag')
%   - cfg.headerformat      =>                          (default => 'neuromag')
%   - cfg.prestim           => cut before ecg           (default => .2)
%   - cfg.poststim          => cut after ecg            (default => .5)
%   - cfg.dividetrial       => divide computation       (default => by 1)
%   - cfg.corr_thresh       => corr(PC,ecg) threshold   (default => .1)
% output
%   - data                  => structure containing continuous FT data
% -------------------------------------------------------------------------
% requires 
%   - fieldtrip 2011
%   - MNE toolbox
% -------------------------------------------------------------------------
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (c) 2011 Jean-Rémi KING
% jeanremi.king+matlab@gmail.com
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
if ~isfield(cfg,'dataset'),     error('needs cfg.dataset');                 end
if ~isfield(cfg,'plot'),        cfg.plot        = 'yes';                    end
%-- read header
hdr                         = ft_read_header(cfg.dataset);
disp(hdr);
if ~isfield(cfg,'chantypes'),   cfg.chantypes   = {1:hdr.nChans};           end % cells dividing types of sensors (gradiometers, etc)
%-- finds ecg channels
if ~isfield(cfg,'ecgchan'),     cfg.ecgchan     = find(cell2mat(cellfun(@(x) ~isempty(findstr('ECG',x)), hdr.label, 'UniformOutput', false))); end
if ~isfield(cfg,'headerformat'),cfg.headerformat= 'neuromag_mne';           end
if ~isfield(cfg,'dataformat'),  cfg.dataformat  = 'neuromag_mne';           end
if ~isfield(cfg,'prestim'),     cfg.prestim     = .200;                     end
if ~isfield(cfg,'poststim'),    cfg.poststim    = .500;                     end
if ~isfield(cfg,'dividetrial'), cfg.dividetrial = 1;                        end % divide the computation by n trials for memory issue
if ~isfield(cfg,'corr_thresh'), cfg.corr_thresh = .05;                       end % correlation between ECG and PC
cfg.trialfun                = 'ft_jr_ecg_trialfun';                         % get heart beat as triggers
%-- load data
cfg_ecg                     = ft_definetrial(cfg);
%-- read data using heart beats as trials
cfg_ecg.lpfilter = 'yes';
cfg_ecg.lpfreq = 40;
data_ecg                    = ft_preprocessing(cfg_ecg);
%-- average data
cfg_ecgpca                  = [];
avg_tmp                     = data_ecg;
avg_tmp.time                = {};
avg_tmp.trial               = {};
%----- divide by n trials to reduce memory issue
for trial = 1:round(length(data_ecg.trial)/cfg.dividetrial):length(data_ecg.trial)
    if (trial+round(length(data_ecg.trial)/cfg.dividetrial)-1) <= length(data_ecg.trial)
        cfg_ecgpca.trials   = trial:(trial+round(length(data_ecg.trial)/cfg.dividetrial)-1);
    else
        cfg_ecgpca.trials   = trial:length(data_ecg.trial);
    end
    data_tmp                = ft_timelockanalysis(cfg_ecgpca,data_ecg);
    avg_tmp.trial{end+1}    = data_tmp.avg;
    avg_tmp.time{end+1}     = data_tmp.time;
end
data_ecgpca                 = ft_timelockanalysis([],avg_tmp);
clear avg_tmp;

%-- get continuous signal
cfg_raw                     = [];
cfg_raw.continuous          = 'yes';
cfg_raw.headerformat        = cfg.headerformat;
cfg_raw.dataformat          = cfg.dataformat;
cfg_raw.dataset             = cfg.dataset;
data_raw                    = ft_preprocessing(cfg_raw);

%-- apply pca
data_raw.components         = data_raw.trial{1};
data_ecgpca.pca             = {};

%-- apply pca independlty for each sensor
for chantype = 1:length(cfg.chantypes) 
    disp(['channel type ' num2str(chantype)]);
    
    disp('computes pca...');
    data_ecgpca.pca{chantype}           = princomp(data_ecgpca.avg(cfg.chantypes{chantype},:)');
    data_raw.components(cfg.chantypes{chantype},:) = data_ecgpca.pca{chantype}'*data_raw.trial{1}(cfg.chantypes{chantype},:);
    
    %-- check whether the components correlate with heart beat timing
    disp('computes correlation with ecg...');
    data_ecg.r{chantype}                = abs(corr(data_raw.components(cfg.chantypes{chantype},:)', data_raw.trial{1}(cfg_ecg.ecgchan,:)'));
    
    %-- will remove the components that correlates the most with the ecg
    data_ecg.rm_components{chantype}    = find(data_ecg.r{chantype} >= cfg.corr_thresh);
    data_ecg.clear_comp                 = zeros(length(data_ecg.rm_components{chantype}),size(data_ecgpca.pca{chantype},1));
    
    %-- and keep the other
    data_ecg.keep_components{chantype}  = setdiff(1:size(data_ecgpca.pca{chantype},1),data_ecg.rm_components{chantype});
    
    %-- watch effect on average ECG
    data_ecgpca.avg_comps{chantype}     = ...
        data_ecgpca.pca{chantype}*...
        cat(2,data_ecg.clear_comp',data_ecgpca.pca{chantype}(:,data_ecg.keep_components{chantype}))'*...
        data_ecgpca.avg(cfg.chantypes{chantype},:);
    
    %-- transform continuous signal
    data_raw.trial{1}(cfg.chantypes{chantype},:) = ...
        data_ecgpca.pca{chantype}*...
        cat(2,data_ecg.clear_comp',data_ecgpca.pca{chantype}(:,data_ecg.keep_components{chantype}))'*...
        data_raw.trial{1}(cfg.chantypes{chantype},:);
        
    %-- plotting functions
    if strcmp(cfg_ecg.plot,'yes')
        %-- ECG
        subplot(2*length(cfg.chantypes),length(cfg.chantypes),length(cfg.chantypes)+chantype);hold on;
        title('ECG');
        plot(data_ecgpca.time,data_ecgpca.avg(cfg_ecg.ecgchan,:));
        %-- mean artefact
        subplot(3,length(cfg.chantypes),length(cfg.chantypes)+chantype);hold on;
        title(['artifact chans ' num2str(chantype)]);
        plot(data_ecgpca.time,data_ecgpca.avg(cfg.chantypes{chantype},:)','r'); % average artifact
        plot(data_ecgpca.time,data_ecgpca.avg_comps{chantype}','g');                % corrected artefact
        legend({'avg artifact', 'corrected artefact'});
        %-- correlation in time between ecg and principal components
        subplot(3,length(cfg.chantypes) ,2*length(cfg.chantypes)+chantype);hold on;
        title('correlation PC & ECG')
        scatter(1:length(data_ecg.r{chantype}), data_ecg.r{chantype});
        plot([0 length(data_ecg.r{chantype})], repmat(cfg.corr_thresh,1,2), 'g--');
    end
end

return