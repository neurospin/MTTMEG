%% import fieldtrip ERF in bst
clear all
close all

Folder = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/sd130343';
load([Folder '/evt12bst.mat']);

dat1 =timelockbaset{1,1};
dat2 =timelockbaset{1,2};

recent_fieldtrip2fiff([Folder '/EVT1.fif'], dat1);
recent_fieldtrip2fiff([Folder '/EVT2.fif'], dat2);












