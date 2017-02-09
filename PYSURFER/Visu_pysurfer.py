export SUBJECTS_DIR='/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/mri'
export QT_API=pyqt

ipython

from surfer import Brain
%gui qt

brain = Brain("fsaverage", "lh", "inflated")
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SPROJ_SJ_lh.mgz"
brain.add_overlay(overlay_file, min=3.10, max=5.80, sign="pos")

brain = Brain("fsaverage", "rh", "inflated")
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SPROJ_SJ_rh.mgz"
brain.add_overlay(overlay_file, min=3.10, max=5.80, sign="pos")

brain = Brain("fsaverage", "rh", "inflated")
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SPROJ_SJ_rh.mgz"
brain.add_overlay(overlay_file, min=2.34, max=5.50, sign="pos")
