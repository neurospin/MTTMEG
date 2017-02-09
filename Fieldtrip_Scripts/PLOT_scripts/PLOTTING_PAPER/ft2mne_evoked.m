addpath('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/GROUP')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% EEG %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% convert subject-level average in mne python format

condnames    = {'RefPast';'RefPre';'RefFut'};
chansel      = 'EEG';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

% selection
if length(condnames) > 2
    statstag = 'F';
else
    statstag = 'T';
end

% switch from separated to concatenated names
cdn = [];
for i = 1:length(condnames)
    cdn = [cdn condnames{i} '_'];
end

% load cell array of conditions
instrmulti = 'ft_multiplotER(cfg,';
instrsingle = 'ft_singleplotER(cfg,';
for j = 1:length(niplist)
    datatmp{j}   = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' niplist{j} '/MegData/ERPs_from_mne/' cdn chansel],'timelockbase');
end

close all

%% convert in mne python format
filename = ['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' niplist{j} '/MegData/ERPs_from_mne/' cdn chansel '-ave.fif']
fieldtrip2fiff(filename,datatmp{1}.timelockbase{1});

% raw
load('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/hr130504/MegData/Processed_mne_eeg/REF_dat_filt40.mat')
filename = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/hr130504/MegData/Processed_mne_eeg/TESTrawformne.fif'
fieldtrip2fiff(filename,datafilt40);

