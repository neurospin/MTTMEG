# -*- coding: utf-8 -*-
"""
Created on Tue Jan 31 17:51:52 2017

@author: bgauthie
"""

#export SUBJECTS_DIR='/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/mri'

import os
import mne

subjects_dir = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/mri'
subject      = 'fsaverage'

label_path = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/labels_for_mni'
label_list = (os.listdir(label_path))

testlh = []
testrh = []
for l,labeltag in enumerate(label_list):
    label =   mne.read_label(label_path+'/'+labeltag)
    
    path = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/Plot_STATS/RefPast_vs_RefPre_vs_RefFut';
    stcrh_fname = (path + '/fmapMEEG_RefPast_vs_RefPre_vs_RefFut-rh.stc')
    stcrh = mne.read_source_estimate(stcrh_fname)
    stcrh_label = stcrh.in_label(label) 
    
    stclh_fname = (path + '/fmapMEEG_RefPast_vs_RefPre_vs_RefFut-lh.stc')
    stclh = mne.read_source_estimate(stclh_fname)
    stclh_label = stclh.in_label(label) 
    
    # calculate center of mass and transform to mni coordinates
    vtx, _, tlh = stclh_label.center_of_mass('fsaverage')
    mnilh = mne.vertex_to_mni(vtx, 0, 'fsaverage')[0]
    testlh.append(mnilh)
    
    vtx, _, trh = stcrh_label.center_of_mass('fsaverage')
    mnirh = mne.vertex_to_mni(vtx, 1, 'fsaverage')[0]
    testrh.append(mnirh)

###############################################################################
# save as nifti
src = mne.setup_source_space('fsaverage_tmp', spacing='ico5')

# Export result as a 4D nifti object
path = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/Plot_STATS/RefPast_vs_RefPre_vs_RefFut';
stc_fname = (path + '/fmapMEEG_RefPast_vs_RefPre_vs_RefFut-rh.stc')
stc = mne.read_source_estimate(stc_fname)

fname = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/nifti/Refpast_RefPre_RefFut.nii')
mne.save_stc_as_volume(fname, stc, src, dest='mri', mri_resolution=False)























