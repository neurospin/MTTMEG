function data_corr = cw_correct_ecgeog_noecg(cfg,corrtag)

% function that automatically removes the ECG artefact using a PCA on the
% average artefact.
% -------------------------------------------------------------------------
% inputs
%   - cfg.dataset           => path of dataset
%   - cfg.plot              => 'yes' or 'no'            (default = 'yes')
%   - cfg.chantypes         => cells of chantypes       (default => all)
%   - cfg.dataformat        =>                          (default => 'neuromag')
%   - cfg.headerformat      =>                          (default => 'neuromag')
%   - cfg.dividetrial       => divide computation       (default => by 1)
%   - cfg.prestim, cfg.poststim, ... any other option for preprocessing cf ft_preprocessing
%
%   - cfg.ecgchan           => ecg channel              (default => read from header)
%   - cfg.prestim_ecg           => cut before ecg           (default => .2)
%   - cfg.poststim_ecg          => cut after ecg            (default => .5)
%   - cfg.threshold_ecg         => threshold for artifact detection (in sd)
%   - cfg.mode_reject_ecg       => mandatory, can be 'th' for a rejection
%   based on threshold on the correlation between ecg and componant or
%   'fix_num' for rejection of a fixed number of componants
%   - cfg.corr_thresh_ecg       => corr(PC,ecg) threshold   (default =>
%   .1), used only in 'th' mode
%   - cfg.n_comp_ecg            => number of componants to reject in the
%   'fix_num' mode
%
%
%   - cfg.eogchan           => eog channel              (default => read   EOG061 du header)
%   - cfg.prestim_eog           => cut before eog           (default => .2)
%   - cfg.poststim_eog          => cut after eog            (default => .5)
%   - cfg.threshold_eog         => threshold for artifact detection (in sd)
%   - cfg.mode_reject_eog       => mandatory, can be 'th' for a rejection
%   based on threshold on the correlation between eog and componant or
%   'fix_num' for rejection of a fixed number of componants
%   - cfg.corr_thresh_eog       => corr(PC,eog) threshold   (default =>
%   .1), unsed only in 'th' mode
%   - cfg.n_comp_eog            => number of componants to reject in the
%   'fix_num' mode
% output
%   - data                  => structure containing continuous FT data
% -------------------------------------------------------------------------
% requires
%   - fieldtrip 2011
%   - MNE toolbox
% -------------------------------------------------------------------------
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (c) 2011 Catherine WACONGNE adapted from Jean-Rémi KING
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
switch corrtag
    case 'ecg_only'
        
        %% Apply correction for ECG
        cfg_ecg                         = [];
        if ~isfield(cfg,'dataset'),     error('needs cfg.dataset');  else  cfg_ecg.dataset = cfg.dataset;    end
        if ~isfield(cfg,'plot'),        cfg_ecg.plot        = 'yes'; else  cfg_ecg.plot = cfg.plot;         end
        hdr                         = ft_read_header(cfg.dataset);
        disp(hdr);
        if ~isfield(cfg,'chantypes'),     error('needs cfg.chantypes'); else cfg_ecg.chantypes = cfg.chantypes; end
        if ~isfield(cfg,'ecgchan'),       cfg_ecg.ecgchan     = find(cell2mat(cellfun(@(x) ~isempty(findstr('MEG1713',x)), hdr.label, 'UniformOutput', false))); end
        cfg_ecg.headerformat= 'neuromag_mne';
        cfg_ecg.dataformat  = 'neuromag_mne';
        if ~isfield(cfg,'prestim_ecg'),     cfg_ecg.prestim     = .200;                         end
        if ~isfield(cfg,'poststim_ecg'),    cfg_ecg.poststim    = .300;                         end
        if ~isfield(cfg,'dividetrial'),     cfg_ecg.dividetrial = 1;                            end % divide the computation by n trials for memory issue
        if ~isfield(cfg,'mode_reject_ecg'), error('needs cfg.mode_reject_ecg'); else cfg_ecg.mode_reject = cfg.mode_reject_ecg;   end %mode can be 'th' pour seuil or 'fix_num' for a fixed number of componants
        if ~isfield(cfg,'corr_thresh_ecg'),  cfg_ecg.corr_thresh = .05;  else cfg_ecg.corr_thresh =  cfg.corr_thresh_ecg;         end
        if ~isfield(cfg,'n_comp_ecg'),       cfg_ecg.n_comp      =  2;  else cfg_ecg.n_comp      =  cfg.n_comp_ecg;              end
        cfg_ecg.trialfun                = 'ft_jr_ecg_trialfun';
        data_corr = cw_PCA_corr(cfg, cfg_ecg);pause(0.05);
        
    case 'eog_only'
        
        %% Apply correction for EOG
        cfg_eog                         = [];
        if ~isfield(cfg,'dataset'),     error('needs cfg.dataset');      else  cfg_eog.dataset = cfg.dataset;    end
        if ~isfield(cfg,'plot'),        cfg_eog.plot        = 'yes';     else  cfg_eog.plot = cfg.plot;         end
        hdr                             = ft_read_header(cfg.dataset);
        disp(hdr);
        if ~isfield(cfg,'chantypes'),     error('needs cfg.chantypes');  else cfg_eog.chantypes = cfg.chantypes; end
        if ~isfield(cfg,'eogchan'),       cfg_eog.ecgchan     = find(cell2mat(cellfun(@(x) ~isempty(findstr('EEG061',x)), hdr.label, 'UniformOutput', false))); end
        cfg_eog.headerformat= 'neuromag_mne';
        cfg_eog.dataformat  = 'neuromag_mne';
        if ~isfield(cfg,'prestim_eog'),         cfg_eog.prestim     = .200;                       end
        if ~isfield(cfg,'poststim_eog'),        cfg_eog.poststim    = .300;                       end
        if ~isfield(cfg,'dividetrial'),         cfg_eog.dividetrial = 1;                          end % divide the computation by n trials for memory issue
        if ~isfield(cfg,'mode_reject_eog'), error('needs cfg.mode_reject_eog'); else cfg_eog.mode_reject = cfg.mode_reject_eog;   end %mode can be 'th' pour seuil or 'fix_num' for a fixed number of componants
        if ~isfield(cfg,'corr_thresh_eog'),  cfg_eog.corr_thresh = .1;  else cfg_eog.corr_thresh =  cfg.corr_thresh_eog;         end
        if ~isfield(cfg,'n_comp_eog'),       cfg_eog.n_comp      =  1;  else cfg_eog.n_comp      =  cfg.n_comp_eog;              end
        cfg_eog.trialfun                = 'ft_cw_eog_trialfun';
        data_corr = cw_PCA_corr(cfg, cfg_eog, data_corr);
        
    case 'ecg&eog'
        
%% Apply correction for ECG
        cfg_ecg                         = [];
        if ~isfield(cfg,'dataset'),     error('needs cfg.dataset');  else  cfg_ecg.dataset = cfg.dataset;    end
        if ~isfield(cfg,'plot'),        cfg_ecg.plot        = 'yes'; else  cfg_ecg.plot = cfg.plot;         end
        hdr                         = ft_read_header(cfg.dataset);
        disp(hdr);
        if ~isfield(cfg,'chantypes'),     error('needs cfg.chantypes'); else cfg_ecg.chantypes = cfg.chantypes; end
        if ~isfield(cfg,'ecgchan'),       cfg_ecg.ecgchan     = find(cell2mat(cellfun(@(x) ~isempty(findstr('EEG063',x)), hdr.label, 'UniformOutput', false))); end
        cfg_ecg.headerformat= 'neuromag_mne';
        cfg_ecg.dataformat  = 'neuromag_mne';
        if ~isfield(cfg,'prestim_ecg'),     cfg_ecg.prestim     = .200;                         end
        if ~isfield(cfg,'poststim_ecg'),    cfg_ecg.poststim    = .300;                         end
        if ~isfield(cfg,'dividetrial'),     cfg_ecg.dividetrial = 1;                            end % divide the computation by n trials for memory issue
        if ~isfield(cfg,'mode_reject_ecg'), error('needs cfg.mode_reject_ecg'); else cfg_ecg.mode_reject = cfg.mode_reject_ecg;   end %mode can be 'th' pour seuil or 'fix_num' for a fixed number of componants
        if ~isfield(cfg,'corr_thresh_ecg'),  cfg_ecg.corr_thresh = .1;  else cfg_ecg.corr_thresh =  cfg.corr_thresh_ecg;         end
        if ~isfield(cfg,'n_comp_ecg'),       cfg_ecg.n_comp      =  2;  else cfg_ecg.n_comp      =  cfg.n_comp_ecg;              end
        cfg_ecg.trialfun                = 'ft_jr_ecg_trialfun';
        data_corr = cw_PCA_corr(cfg, cfg_ecg);pause(0.05);
        
 %% Apply correction for EOG
        cfg_eog                         = [];
        if ~isfield(cfg,'dataset'),     error('needs cfg.dataset');      else  cfg_eog.dataset = cfg.dataset;    end
        if ~isfield(cfg,'plot'),        cfg_eog.plot        = 'yes';     else  cfg_eog.plot = cfg.plot;         end
        hdr                             = ft_read_header(cfg.dataset);
        disp(hdr);
        if ~isfield(cfg,'chantypes'),     error('needs cfg.chantypes');  else cfg_eog.chantypes = cfg.chantypes; end
        if ~isfield(cfg,'eogchan'),       cfg_eog.ecgchan     = find(cell2mat(cellfun(@(x) ~isempty(findstr('EEG061',x)), hdr.label, 'UniformOutput', false))); end
        cfg_eog.headerformat= 'neuromag_mne';
        cfg_eog.dataformat  = 'neuromag_mne';
        if ~isfield(cfg,'prestim_eog'),         cfg_eog.prestim     = .200;                       end
        if ~isfield(cfg,'poststim_eog'),        cfg_eog.poststim    = .300;                       end
        if ~isfield(cfg,'dividetrial'),         cfg_eog.dividetrial = 1;                          end % divide the computation by n trials for memory issue
        if ~isfield(cfg,'mode_reject_eog'), error('needs cfg.mode_reject_eog'); else cfg_eog.mode_reject = cfg.mode_reject_eog;   end %mode can be 'th' pour seuil or 'fix_num' for a fixed number of componants
        if ~isfield(cfg,'corr_thresh_eog'),  cfg_eog.corr_thresh = .1;  else cfg_eog.corr_thresh =  cfg.corr_thresh_eog;         end
        if ~isfield(cfg,'n_comp_eog'),       cfg_eog.n_comp      =  1;  else cfg_eog.n_comp      =  cfg.n_comp_eog;              end
        cfg_eog.trialfun                = 'ft_cw_eog_trialfun';
        data_corr = cw_PCA_corr(cfg, cfg_eog, data_corr);        
end
