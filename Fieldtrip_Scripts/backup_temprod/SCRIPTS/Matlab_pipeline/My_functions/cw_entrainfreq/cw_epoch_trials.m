function data_epoch = cw_epoch_trials(cfg, data)

if ~isfield(cfg, 'trl'), error('needs trl to epoch data'), end 
ntrl = size(cfg.trl, 1);

if ~isfield(cfg, 'trialdef'), error('needs informations on the delay pre/post stimulus'), end    
if ~isfield(cfg.trialdef, 'prestim'), error('needs informations on the delay pre stimulus'), end 
if ~isfield(cfg.trialdef, 'poststim'), error('needs informations on the delay post stimulus'), end 

if ~isfield(data, 'trial'), error('this function works on raw data already preprocessed in one epoch'), end

data_epoch = data;
time = -cfg.trialdef.prestim :1/data.fsample:cfg.trialdef.poststim;

for i=1:ntrl
      disp(['epoching trial ' num2str(i) ' of ' num2str(ntrl) ' trials'] );
      data_epoch.trial{i} = data.trial{1}(:,cfg.trl(i,1):cfg.trl(i,2));
      data_epoch.time{i} = time;
end     
       
data_epoch.sampleinfo = cfg.trl;

if isfield(data_epoch, 'components'), data_epoch = rmfield(data_epoch, 'components');end

