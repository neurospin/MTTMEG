function cfg = PREPROC4_for_mne_v2(runlist,nip)

root = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/';

dataname0 = load([root nip '/MegData/Processed_mne/REF_dat_filt40.mat'],'trldef');
dataname1 = load([root nip '/MegData/Processed_mne/EVT_dat_filt40.mat'],'trldef');
dataname2 = load([root nip '/MegData/Processed_mne/EVS_dat_filt40.mat'],'trldef');
dataname3 = load([root nip '/MegData/Processed_mne/QTT_dat_filt40.mat'],'trldef');
dataname4 = load([root nip '/MegData/Processed_mne/QTS_dat_filt40.mat'],'trldef');
trialdeftmp = [dataname0.trldef; dataname1.trldef; dataname2.trldef; dataname3.trldef; dataname4.trldef];

rejname0 = load([root nip '/MegData/Processed_mne/REF_rejectvisual.mat']);
rejname1 = load([root nip '/MegData/Processed_mne/EVT_rejectvisual.mat']);
rejname2 = load([root nip '/MegData/Processed_mne/EVS_rejectvisual.mat']);
rejname3 = load([root nip '/MegData/Processed_mne/QTT_rejectvisual.mat']);
rejname4 = load([root nip '/MegData/Processed_mne/QTS_rejectvisual.mat']);
tmp = [rejname0.trlsel rejname1.trlsel rejname2.trlsel rejname3.trlsel rejname4.trlsel];

rejname0eeg = load([root nip '/MegData/Processed_mne_eeg/REFEEG_rejectvisual.mat']);
rejname1eeg = load([root nip '/MegData/Processed_mne_eeg/EVTEEG_rejectvisual.mat']);
rejname2eeg = load([root nip '/MegData/Processed_mne_eeg/EVSEEG_rejectvisual.mat']);
rejname3eeg = load([root nip '/MegData/Processed_mne_eeg/QTTEEG_rejectvisual.mat']);
rejname4eeg = load([root nip '/MegData/Processed_mne_eeg/QTSEEG_rejectvisual.mat']);
tmpeeg = [rejname0eeg.trlsel rejname1eeg.trlsel rejname2eeg.trlsel rejname3eeg.trlsel rejname4eeg.trlsel];

fullsubj = [trialdeftmp double(tmp') double(tmpeeg')];

for i =1:length(runlist)
    save(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' nip '/PsychData/events_ICAcorr_run' num2str(i) '_v2.mat'],'fullsubj');
end
