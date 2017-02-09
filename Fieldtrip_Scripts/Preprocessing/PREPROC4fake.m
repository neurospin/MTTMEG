function cfg = PREPROC4fake(runlist,delays,windowsERF,trialfun,nip)

tstart = tic;

root = ['/media/bgauthie/Seagate Backup Plus Drive/TMP_MEG_SOURCE/MEG/' nip '/raw_sss/'];
% root = ['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/' nip '/raw_sss/'];

% preprocess each run
cfg{1} = run_preproc(root,runlist{1},delays,windowsERF,trialfun);
fullsubj = [];
fullsubj   = [fullsubj  cfg{1}.trl ones(size(cfg{1}.trl,1),1)*1 ];
for i = 2:length(runlist)
        cfg{i} = run_preproc(root,runlist{i},delays,windowsERF,trialfun);
        fullsubj   = [fullsubj ; [cfg{i}.trl ones(size(cfg{i}.trl,1),1)*i]];
end

fname = ['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' nip '/PsychData/events.txt'];
rejname1 = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' nip '/MegData/Processed_new/EVT_rejectvisual.mat']);
rejname2 = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' nip '/MegData/Processed_new/EVS_rejectvisual.mat']);
rejname3 = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' nip '/MegData/Processed_new/QTT_rejectvisual.mat']);
rejname4 = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' nip '/MegData/Processed_new/QTS_rejectvisual.mat']);
tmp = [rejname1.trlsel rejname2.trlsel rejname3.trlsel rejname4.trlsel];

fname = ['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' nip '/PsychData/events.txt'];
rejname1eeg = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' nip '/MegData/Processed_eegnew/EVTEEG_rejectvisual.mat']);
rejname2eeg = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' nip '/MegData/Processed_eegnew/EVSEEG_rejectvisual.mat']);
rejname3eeg = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' nip '/MegData/Processed_eegnew/QTTEEG_rejectvisual.mat']);
rejname4eeg = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' nip '/MegData/Processed_eegnew/QTSEEG_rejectvisual.mat']);
tmpeeg = [rejname1eeg.trlsel rejname2eeg.trlsel rejname3eeg.trlsel rejname4eeg.trlsel];

fullsubj = [fullsubj double(tmp') double(tmpeeg')];

for i =1:length(runlist)
    [x{i},y{i}] = find(fullsubj(:,7) == i);
    fullsubj(x{i},:) = sortrows(fullsubj(x{i},:),1);
%     write_csv_for_anova_R(fullsubj(x{i},:),{'s0','s0','dealy','recodetrig','date','place','origtrig','run','badt'},fname)
    save(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' nip '/PsychData/events' num2str(i) '.mat'],'fullsubj');
end

    function cfg2 = run_preproc(root,run,delays,windows,trialfun)
        
        % generate epoched fieldtrip dataset
        cfg1                              = [];
        cfg1.continuous              = 'no';
        cfg1.headerformat          = 'neuromag_mne';
        cfg1.dataformat              = 'neuromag_mne';
        cfg1.trialdef.channel        = 'STI101';
        cfg1.trialdef.prestim        =  windows(:,1);
        cfg1.trialdef.poststim       =  windows(:,2);
        cfg1.photodelay              = delays;
        
        cfg1.dataset                   = [root char(run) '_trans_sss.fif'];
        cfg1.trialfun                    = trialfun;
        
        cfg1.dftfilter                   = 'yes';
        
        % define channel types
        [Grads1,Grads2,Mags]   = grads_for_layouts('Network');
        cfg1.channel            = [Grads1 Grads2 Mags 'ECG063' 'EOG061' 'EOG062'];
        
        % trial definition and preprocessing
        cfg2                    = ft_definetrial(cfg1);
    end

end







