function PREPROC4_emptyroom(nip,trialfun)

tstart = tic;

root = ['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/' nip '/raw_sss/'];
data        = run_preproc(root,'emptyroom',0,[0 0],trialfun);

save(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' nip '/MegData/Processed_new/epochs_emptyroom.mat'],'data')
fieldtrip2fiff(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' nip '/MegData/Processed_new/emptyroom.fif'], data);

telapsed = toc(tstart);
disp(['elapsed time for preprocessing ' num2str(telapsed) ' s.'])
% define channel types
% [Grads1,Grads2,Mags]   = grads_for_layouts('Network');

% save(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' nip '/MegData/Processed/' condname 'filt40.mat'],'datafilt40')
% save(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' nip '/MegData/Processed/' condname 'nofilt.mat'],'data')


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function data = run_preproc(root,run,delays,windows,trialfun)
        
        % generate epoched fieldtrip dataset
        cfg1                              = [];
        cfg1.continuous              = 'no';
        cfg1.headerformat          = 'neuromag_mne';
        cfg1.dataformat              = 'neuromag_mne';
        cfg1.trialdef.channel        = 'STI101';
        cfg1.trialdef.prestim        =  windows(:,1);
        cfg1.trialdef.poststim       =  windows(:,2);
        cfg1.photodelay              = delays;
        
        cfg1.dataset                   = [root run '_trans_sss.fif'];
        cfg1.trialfun                    = trialfun;
        
        cfg1.dftfilter                   = 'yes';
        
        % define channel types
        [Grads1,Grads2,Mags]   = grads_for_layouts('Network');
        cfg1.channel            = [Grads1 Grads2 Mags 'ECG063' 'EOG061' 'EOG062'];
        
        % trial definition and preprocessing
        cfg2                    = ft_definetrial(cfg1);
        cfg2.dftfilter         = 'yes';
        disp(cfg2)
        data                    = ft_preprocessing(cfg2);
        
        % resample dataset
        cfg3                        = [];
        cfg3.channel            = 'all';
        cfg3.resamplefs       = 256;
        cfg3.detrend            = 'yes';
        cfg3.blc                    = 'yes';
        cfg3.feedback          = 'no';
        cfg3.trials                = 'all';
        data                        = ft_resampledata(cfg3,data);
        data.trldef               = cfg2.trl;
        
    end
end