function data_raw = cw_PCA_corr(cfg1, cfg, data)
% cfg1 gives the parameters for preprocessing used in the following analysis
% cfg gives the parameters for trial definition
%-- load data
figure;
cfg_ecg                     = ft_definetrial(cfg);
%-- read data using heart beats as trials

%-- get continuous signal
if nargin == 2
    cfg_raw                     = cfg1;
    cfg_raw.continuous          = 'yes';
    cfg_raw.headerformat        = cfg.headerformat;
    cfg_raw.dataformat          = cfg.dataformat;
    cfg_raw.dataset             = cfg.dataset;
    data_raw                    = ft_preprocessing(cfg_raw);
else
    data_raw                    = data;
end
clear data

cfg2 = [];
if isfield(data_raw, 'unpadded'), cfg_ecg.trl = cfg_ecg.trl - data_raw.unpadded;end
cfg2.trl = cfg_ecg.trl;
cfg2.trialdef.prestim = cfg.prestim;
cfg2.trialdef.poststim = cfg.poststim;
disp('epoching trials')
data_ecg                    = cw_epoch_trials(cfg2, data_raw);

% %-- average data
% cfg_ecgpca                  = [];
% avg_tmp                     = data_ecg;
% avg_tmp.time                = {};
% avg_tmp.trial               = {};
%
%
% %----- divide by n trials to reduce memory issue
% for trial = 1:round(length(data_ecg.trial)/cfg.dividetrial):length(data_ecg.trial)
%     if (trial+round(length(data_ecg.trial)/cfg.dividetrial)-1) <= length(data_ecg.trial)
%         cfg_ecgpca.trials   = trial:(trial+round(length(data_ecg.trial)/cfg.dividetrial)-1);
%     else
%         cfg_ecgpca.trials   = trial:length(data_ecg.trial);
%     end
%     data_tmp                = ft_timelockanalysis(cfg_ecgpca,data_ecg);
%     avg_tmp.trial{end+1}    = data_tmp.avg;
%     avg_tmp.time{end+1}     = data_tmp.time;
% end

data_ecgpca                 = ft_timelockanalysis([],data_ecg);
clear avg_tmp;
disp('cleaning data for memory optimization')
[l,c,v] = find(abs(data_raw.trial{1})>10e-26);
if min(c)>1001
    data_raw.trial{1}(:,1:min(c)-1000) = [];
    data_raw.time{1}(1:min(c)-1000) = [];
    data_raw.unpadded = min(c)-1000;
end

disp(['removed ' num2str(min(c)-1000) ' samples'])
clear l c v
if size(data_raw.trial{1},2)>1e6
    div = 2;
    disp('applying analysis to first half of data')
else
    div = 1;
end

%-- apply pca
data_raw.components         = data_raw.trial{1}(:,1:end/div);
data_ecgpca.pca             = {};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data_raw.toremove_comp      = data_raw.components;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%-- apply pca independlty for each sensor
for chantype = 1:length(cfg.chantypes)
    disp(['channel type ' num2str(chantype)]);
    
    disp('computes pca...');
    data_ecgpca.pca{chantype}           = princomp(data_ecgpca.avg(cfg.chantypes{chantype},:)');
    data_raw.components(cfg.chantypes{chantype},:) = data_ecgpca.pca{chantype}'*data_raw.trial{1}(cfg.chantypes{chantype},1:end/div);
    
    %-- check whether the components correlate with heart beat timing
    disp('computes correlation with ecg...');
    data_ecg.r{chantype}                = abs(corr(data_raw.components(cfg.chantypes{chantype},:)', data_raw.trial{1}(cfg_ecg.ecgchan,1:end/div)'));
    data_raw = rmfield(data_raw, 'components');
    %-- will remove the components that correlates the most with the ecg
    switch lower(cfg.mode_reject)
        case 'th'
            data_ecg.rm_components{chantype}    = find(data_ecg.r{chantype} >= cfg.corr_thresh);
            disp(['removing  the' num2str(length(data_ecg.rm_components{chantype})) ' componants above the correlation threshold (' num2str(cfg.corr_thresh) ')']);
        case 'fix_num'
            data_ecg.rm_components{chantype}    = 1:cfg.n_comp  ;
            disp(['removing the first ' num2str(max(data_ecg.rm_components{chantype})) ' componants no matter the correlation value']);
        case 'comp_other'
            data_ecg.rm_components{chantype}    = find(data_ecg.r{chantype}(1:5) >= 1.1 * max(data_ecg.r{chantype}(6:end)));
            disp(['removing  the ' num2str(length(data_ecg.rm_components{chantype})) ' componants amongst the firts five that score above the maximum of the others']);
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %     %BG: added to get components to remove for runs without ecg in a subject
    %     if isfield(data_raw,'toremove') ~= 1
    %         data_raw.toremove_index  = data_ecg.rm_components;
    %     else
    %         data_raw.toremove2_index = data_ecg.rm_components;
    %     end
    data_raw.toremove_comp2     = data_ecgpca;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
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
        plot(data_ecgpca.time,data_ecgpca.avg_comps{chantype}','g');            % corrected artefact
        legend({'avg artifact', 'corrected artefact'});
        %-- correlation in time between ecg and principal components
        subplot(3,length(cfg.chantypes) ,2*length(cfg.chantypes)+chantype);hold on;
        title('correlation PC & ECG')
        scatter(1:length(data_ecg.r{chantype}), data_ecg.r{chantype});
        scatter(1:length(data_ecg.rm_components{chantype}), data_ecg.r{chantype}(data_ecg.rm_components{chantype}), 'filled');
        plot([0 length(data_ecg.r{chantype})], repmat(cfg.corr_thresh,1,2), 'g--');pause(0.05);
    end
end

