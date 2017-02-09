function [ch, cdn, GDAVG, GDAVGt,dist] = prepare_comp_v5(niplist,cdn, latency, chansel)

% define channel types
[Grads1,Grads2,Mags]   = grads_for_layouts('Network');
EEG  = EEG_for_layouts('Network');

ch = [];
if strcmp(chansel,'Mags')
    ch = Mags;
elseif strcmp(chansel,'Grads1')
    ch = Grads1;
elseif strcmp(chansel,'Grads2')
    ch = Grads2;
elseif strcmp(chansel,'cmb')
    ch = Mags; %temporary
else strcmp(chansel,'EEG')
    ch = EEG;
end

% load cell array of conditions
for j = 1:length(niplist)
    datatmp{j}   = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' ...
        niplist{j} '/MegData/ERPs_from_mne/' cdn '.mat'],'timelockbase');
end

close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% COMPUTE ERFS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:length(datatmp{1,1}.timelockbase)
    
    
        
        % for plot
        cfg                             = [];
        cfg.channel                 = ch;
        cfg.trials                     = 'all';
        cfg.keepindividual       = 'no';
        cfg.removemean         = 'yes';
        cfg.covariance             = 'yes';
        
        instr = ['GDAVG{' num2str(i) '} = ft_timelockgrandaverage(cfg,'];
        for j = 1:length(datatmp)
            if not(isempty(datatmp{1,j}.timelockbase{1,i}))
                instr = [instr 'datatmp{1,' num2str(j)  '}.timelockbase{1,' num2str(i) '},'];
            end
        end
        instr(end) = [];
        instr      = [instr ');'];
        
        eval([instr]);
        
        % for stats
        cfg                             = [];
        cfg.channel                 = ch;
        cfg.trials                     = 'all';
        cfg.keepindividual       = 'yes';
        cfg.removemean         = 'yes';
        cfg.covariance             = 'yes';
        
        instr = ['GDAVGt{' num2str(i) '} = ft_timelockgrandaverage(cfg,'];
        for j = 1:length(datatmp)
            if not(isempty(datatmp{1,j}.timelockbase{1,i}))
                instr = [instr 'datatmp{1,' num2str(j)  '}.timelockbase{1,' num2str(i) '},'];
            end
        end
        instr(end) = [];
        instr      = [instr ');'];
        
        eval([instr]);
        
        instr = [];
        instr = ['GDAVGt{' num2str(i) '} = rmfield(GDAVGt{' num2str(i) '},''cfg'''];
        instr      = [instr ');'];
        
        eval([instr]);
        
        instr = [];
        instr = ['GDAVG{' num2str(i) '} = rmfield(GDAVG{' num2str(i) '},''cfg'''];
        instr      = [instr ');'];
        
        eval([instr]);

    
end