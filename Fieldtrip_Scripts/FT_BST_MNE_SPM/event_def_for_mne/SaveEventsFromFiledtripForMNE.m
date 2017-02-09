function blah(niplist,runlist)
% write event definition for preprocessing in mne

for i =1:lenght(niplist)
    
    
    cfg{i} = PREPROC4fake(runlist,delays,windowsERF,windowsTF,trialfun,condtag,nip);
    
end

        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        function cfg2 = run_preproc_filt40(root,run,delay,window,trialfun)
        
        % generate epoched fieldtrip dataset
        cfg1                               = [];
        cfg1.continuous               = 'no';
        cfg1.headerformat           = 'neuromag_mne';
        cfg1.dataformat              = 'neuromag_mne';
        cfg1.trialdef.channel        = 'STI101';
        cfg1.trialdef.prestim        =  window(:,1);
        cfg1.trialdef.poststim       =  window(:,2);
        cfg1.photodelay              = delay;
        cfg1.dataset                  = [root run '_trans_sss.fif'];
        cfg1.trialfun                   = trialfun;
        cfg1.channel                  = 'all';
        
        % trial definition and preprocessing
        cfg2                    = ft_definetrial(cfg1);
        
        end
    end
