function trl = trialfun_neurospin_hierarchy(cfg)

% TRIALFUN_NEUROSPIN  determines trials/segments in the data that are
% interesting for analysis, using the general event structure returned
% by read_event. This function is made for Neuromag data from Neurospin
% For more info about triggers in Neuromag system see
% http://www.unicog.org/pmwiki/pmwiki.php/Main/TriggerDefinition
%
% Marco Buiatti, 2010

% read the header and event information
hdr = ft_read_header(cfg.dataset); 

% read the stimulus channel and take the derivative to get the triggers 
B=[0 diff(ft_read_data(cfg.dataset, 'chanindx', strmatch(cfg.trialdef.channel,hdr.label,'exact')))];
B(B<0) = 0;
% NOTE: length(B)=length(channel)

% if two triggers are separated by less than 3 samples, the second trigger
% is considered an error thus it is suppressed. If this occurs, check why you have
% such errors in your trigger channel.
[a,x]=find(B>0);
for i=1:length(x)-1
    if x(i+1)-x(i)<3
        disp(['Warning!!! Delay between triggers is < 3 samples! t = ' num2str(x(i))])
        B(x(i+1))=0;
    end;
end;

% check the triggers by counting the number of trials by condition
A=cell(length(cfg.trialdef.eventvalue),1);
for i=1:length(A)
    A{i} = find(B == cfg.trialdef.eventvalue{i}{1});
    disp(['Number of trials for trigger ' cfg.trialdef.eventvalue{i}{2} ' (code ' num2str(cfg.trialdef.eventvalue{i}{1}) '): ' num2str(length(A{i}))]);
end

% re-order triggers chronologically
TrigSmp=sort([A{:}],'ascend');

% determine the number of samples before and after the trigger
pretrig  = -cfg.trialdef.prestim  * hdr.Fs;
posttrig =  cfg.trialdef.poststim * hdr.Fs;

% add precomputed delay between trigger and stimulus presentation
if isfield(cfg, 'photodelay')
    delay = cfg.photodelay * hdr.Fs;
else
    delay = 0;
end

% put the information in a trl structure
trl=[TrigSmp+delay+pretrig; TrigSmp+delay+posttrig; pretrig*ones(1,length(TrigSmp)); B(TrigSmp)]';
