function trl = ft_cw_eog_trialfun(cfg)
%% trl = ft_jr_eog_trialfun(cfg)
% function that automatically detect the EOG artifacts, and gives back the fieldtrip trial structure
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
if ~isfield(cfg, 'poststim'),   cfg.poststim    = .550;     end % select time after heart beat
if ~isfield(cfg, 'plot'),       cfg.plot        = 'no';     end % plot heart beats
if ~isfield(cfg, 'threshold'),  cfg.threshold   = 5;        end % in STD
if ~isfield(cfg, 'ecgchan'),    cfg.ecgchan     = 232;      end % ecg channel
cfg.continuous  = 'yes';    % continuous data
cfg.hpfilter    = 'yes';    % remove shifts
cfg.lpfilter    = 'yes';    %
cfg.hpfreq      = 2;        % high pass filter freq
cfg.lpfreq      = 30;       % low pass filter freq
cfg.maxhb       = .150;     % max s between heart beat 
%-- select ecg chan only
cfg_ecg                     = cfg;
cfg_ecg.channel             = cfg.ecgchan;
%-- load data
disp('reads continuous data...');
data_ecg                    = ft_preprocessing(cfg_ecg);
%-- find pulse
disp('finds occualar artifacts...');
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
    legend({'eog', 'threshold', 'threshold', 'artfact'});
end
%-- calculate post stim according to median time across beats
if ~isfield(cfg, 'poststim') || strcmp(cfg.poststim, 'auto')
    cfg.poststim = median(data_ecg.pulse(2:end)-data_ecg.pulse(1:(end-1))) - cfg.prestim * data_ecg.fsample;
end
%-- final triggers
trl = [...
    data_ecg.pulse-(cfg.prestim  * data_ecg.fsample ); ...
    data_ecg.pulse+(cfg.poststim * data_ecg.fsample ); ...
    repmat((cfg.poststim+cfg.prestim) .* data_ecg.fsample,1,length(data_ecg.pulse))]'; % why divide by 10???

trl = trl(2:(min(cfg.hbnb,size(trl,1))- 2),:); % skip first and last heart beats
end
