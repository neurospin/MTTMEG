function trl = ft_jr_ecg_trialfun_sub10(cfg)
%% trl = ft_jr_ecg_trialfun(cfg)
% function that automatically detect the ECG beats, and gives back the fieldtrip trial structure
% - inputs
%   - cfg.
% - output
%   - trl structure (matrix n trials x 3 colums)
% -------------------------------------------------------------------------
% requires 
%   - fieldtrip 2011
%   - (MNE toolbox)
% -------------------------------------------------------------------------
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (c) 2011 Jean-Rémi KING
% jeanremi.king+matlab@gmail.com
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%-- trialfun function used in ft_definetrial to realign the ecg to the
% heart beat
%-- requires cfg.dataset
if ~isfield(cfg, 'dataset'),    error('needs cfg.dataset!');end
if ~isfield(cfg, 'hbnb'),       cfg.hbnb        = 300;      end % number of heart beat kept
if ~isfield(cfg, 'prestim'),    cfg.prestim     = .100;     end % select time before heart beat
%if ~isfield(cfg, 'poststim'),   cfg.poststim    = .550;     end % select time after heart beat
if ~isfield(cfg, 'plot'),       cfg.plot        = 'yes';     end % plot heart beats
if ~isfield(cfg, 'threshold'),  cfg.threshold   = 1.9;        end % in STD
if ~isfield(cfg, 'ecgchan'),    cfg.ecgchan     = 232;      end % ecg channel
if ~isfield(cfg, 'continuous'), cfg.continuous  = 'yes';    end % continuous data
if ~isfield(cfg, 'hpfilter'),   cfg.hpfilter    = 'yes';    end % remove shifts
if ~isfield(cfg, 'hpfreq'),     cfg.hpfreq      = 2;        end % high pass filter freq
if ~isfield(cfg, 'maxhbfreq'),  cfg.maxhb       = .150;     end % max s between heart beat 
%-- select ecg chan only
cfg_ecg                     = cfg;
cfg_ecg.channel             = cfg.ecgchan;
%-- load data
disp('reads continuous data...');
data_ecg                    = ft_preprocessing(cfg_ecg);
%-- find pulse
disp('finds heart beats...');
data_ecg.pulse              = find(abs(data_ecg.trial{1}) > (mean(data_ecg.trial{1})+cfg_ecg.threshold*std(data_ecg.trial{1})));
%-- remove consecutive points: take only points that are further away
%than .150 s (high frequency heart beats)
data_ecg.pulse              = data_ecg.pulse((data_ecg.pulse(2:end)-data_ecg.pulse(1:(end-1))) >  cfg.maxhb*data_ecg.fsample);
%-- plot if necessary
if strcmp(cfg_ecg.plot, 'yes');
    subplot(6,1,1);hold on;
    plot(data_ecg.time{1},data_ecg.trial{1}); % ecg
    plot([data_ecg.time{1}(1) data_ecg.time{1}(end)],repmat(mean(data_ecg.trial{1})+cfg_ecg.threshold*std(data_ecg.trial{1}),1,2),'g'); % threshold
    plot([data_ecg.time{1}(1) data_ecg.time{1}(end)],repmat(mean(data_ecg.trial{1})-cfg_ecg.threshold*std(data_ecg.trial{1}),1,2),'g'); % threshold
    scatter(data_ecg.time{1}(data_ecg.pulse),...
        repmat((mean(data_ecg.trial{1})+cfg_ecg.threshold*std(data_ecg.trial{1})),...
        length(data_ecg.pulse),1),'ro'); %  heart beats
    legend({'ecg', 'threshold', 'threshold', 'beats'});
end
%-- calculate post stim according to median time across beats
if ~isfield(cfg, 'poststim') || strcmp(cfg.poststim, 'auto')
    cfg.poststim = median(data_ecg.pulse(2:end)-data_ecg.pulse(1:(end-1))) - cfg.prestim * data_ecg.fsample;
end
%-- final triggers
trl = [...
    data_ecg.pulse-(cfg.prestim * data_ecg.fsample); ...
    data_ecg.pulse+(cfg.poststim * data_ecg.fsample); ...
    repmat((cfg.poststim+cfg.prestim) .* data_ecg.fsample,1,length(data_ecg.pulse))]'; % why divide by 10???

trl = trl(5:(min(cfg.hbnb,size(trl,1))- 5),:); % skip first and last heart beats
end
