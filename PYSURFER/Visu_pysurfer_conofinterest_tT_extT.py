export SUBJECTS_DIR='/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/mri'
export QT_API=pyqt

ipython

#%gui qt
%gui wx
from surfer import Brain
import mayavi
from numpy import array

import os.path as op
import numpy as np
from surfer import io

################### TJ-CTRL #####################
###################### LH #######################
brain = Brain("fsaverage", "lh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_TJ_CTRL_tT_extT_lh_projfrac05.mgz"
brain.add_overlay(overlay_file, min=3.11, max=10, sign="pos")
mayavi.mlab.view(azimuth=315, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_TJ_CTRL_tT_extT_lh_projfrac05_face1.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=135, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_TJ_CTRL_tT_extT_lh_projfrac05_face2.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=225, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_TJ_CTRL_tT_extT_lh_projfrac05_face3.png", size=None, figure=None, magnification='auto')
###################### RH #######################
brain = Brain("fsaverage", "rh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_TJ_CTRL_tT_extT_rh_projfrac05.mgz"
brain.add_overlay(overlay_file, min=3.11, max=10, sign="pos")
mayavi.mlab.view(azimuth=225, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_TJ_CTRL_tT_extT_lh_projfrac05_face1.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=45, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_TJ_CTRL_tT_extT_rh_projfrac05_face2.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=315, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_TJ_CTRL_tT_extT_rh_projfrac05_face3.png", size=None, figure=None, magnification='auto')
################### SJ-CTRL #####################
###################### LH #######################
brain = Brain("fsaverage", "lh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SJ_CTRL_tT_extT_lh_projfrac05.mgz"
brain.add_overlay(overlay_file, min=3.11, max=10, sign="pos")
sig1 = io.read_scalar_data(overlay_file)
brain.add_overlay(sig1, 3.11, 10, name="sig1")
brain.overlays['sig1'].pos_bar.lut_mode = "Blues"
mayavi.mlab.view(azimuth=315, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SJ_CTRL_tT_extT_lh_projfrac05_face1.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=135, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SJ_CTRL_tT_extT_lh_projfrac05_face2.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=225, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SJ_CTRL_tT_extT_lh_projfrac05_face3.png", size=None, figure=None, magnification='auto')
###################### RH #######################
brain = Brain("fsaverage", "rh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SJ_CTRL_tT_extT_rh_projfrac05.mgz"
brain.add_overlay(overlay_file, min=3.11, max=10, sign="pos")
sig1 = io.read_scalar_data(overlay_file)
brain.add_overlay(sig1, 3.11, 10, name="sig1")
brain.overlays['sig1'].pos_bar.lut_mode = "Blues"
mayavi.mlab.view(azimuth=225, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SJ_CTRL_tT_extT_lh_projfrac05_face1.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=45, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SJ_CTRL_tT_extT_rh_projfrac05_face2.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=315, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SJ_CTRL_tT_extT_rh_projfrac05_face3.png", size=None, figure=None, magnification='auto')

################### SJ-CTRL overlay TJ-CTRL ##########################
############################### RH ###################################
brain = Brain("fsaverage", "rh", "orig", config_opts={"cortex":"low_contrast","background":"black"})
sig1 = io.read_scalar_data('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SJ_CTRL_tT_extT_rh_projfrac05.mgz')
sig2 = io.read_scalar_data('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_TJ_CTRL_tT_extT_rh_projfrac05.mgz')

thresh = 3.11
sig1[sig1 < thresh] = 0
sig2[sig2 < thresh] = 0
conjunct = np.min(np.vstack((sig1, sig2)), axis=0)
brain.add_overlay(sig1, thresh, 10, name="sig1")
brain.overlays["sig1"].pos_bar.lut_mode = "Blues"
brain.overlays["sig1"].pos_bar.visible = False
brain.add_overlay(sig2, thresh, 10, name="sig2")
brain.overlays["sig2"].pos_bar.lut_mode = "Reds"
brain.overlays["sig2"].pos_bar.visible = False
brain.add_overlay(conjunct, thresh, 10, name="conjunct")
brain.overlays["conjunct"].pos_bar.lut_mode = "Purples"
brain.overlays["conjunct"].pos_bar.visible = False

mayavi.mlab.view(azimuth=215, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SJ_CTRL_overlay_TJ_CTRL_tT_extT_rh_projfrac05_face1.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=55, elevation=85, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SJ_CTRL_overlay_TJ_CTRL_tT_extT_rh_projfrac05_face2.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=315, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SJ_CTRL_overlay_TJ_CTRL_tT_extT_rh_projfrac05_face3.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=0, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SJ_CTRL_overlay_TJ_CTRL_tT_extT_rh_projfrac05_face4.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=180, elevation=85, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SJ_CTRL_overlay_TJ_CTRL_tT_extT_rh_projfrac05_face5.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=0, elevation=20, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SJ_CTRL_overlay_TJ_CTRL_tT_extT_rh_projfrac05_face6.png", size=None, figure=None, magnification='auto')

############################### LH ######################################
brain = Brain("fsaverage", "lh", "orig", config_opts={"cortex":"low_contrast","background":"black"})
sig1 = io.read_scalar_data('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SJ_CTRL_tT_extT_lh_projfrac05.mgz')
sig2 = io.read_scalar_data('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_TJ_CTRL_tT_extT_lh_projfrac05.mgz')

thresh = 3.11
sig1[sig1 < thresh] = 0
sig2[sig2 < thresh] = 0
conjunct = np.min(np.vstack((sig1, sig2)), axis=0)
brain.add_overlay(sig1, thresh, 10, name="sig1")
brain.overlays["sig1"].pos_bar.lut_mode = "Blues"
brain.overlays["sig1"].pos_bar.visible = False
brain.add_overlay(sig2, thresh, 10, name="sig2")
brain.overlays["sig2"].pos_bar.lut_mode = "Reds"
brain.overlays["sig2"].pos_bar.visible = False
brain.add_overlay(conjunct, thresh, 10, name="conjunct")
brain.overlays["conjunct"].pos_bar.lut_mode = "Purples"
brain.overlays["conjunct"].pos_bar.visible = False

mayavi.mlab.view(azimuth=225, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SJ_CTRL_overlay_TJ_CTRL_tT_extT_lh_projfrac05_face1.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=120, elevation=85, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SJ_CTRL_overlay_TJ_CTRL_tT_extT_lh_projfrac05_face2.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=325, elevation=100, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SJ_CTRL_overlay_TJ_CTRL_tT_extT_lh_projfrac05_face3.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=0, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SJ_CTRL_overlay_TJ_CTRL_tT_extT_lh_projfrac05_face4.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=180, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SJ_CTRL_overlay_TJ_CTRL_tT_extT_lh_projfrac05_face5.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=0, elevation=-20, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SJ_CTRL_overlay_TJ_CTRL_tT_extT_lh_projfrac05_face6.png", size=None, figure=None, magnification='auto')



#########################################################################################
#########################################################################################
################### SPROJ-CTRL overlay TPROJ-CTRL ##########################
############################### RH ###################################
brain = Brain("fsaverage", "rh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
sig1 = io.read_scalar_data('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SPROJ_tT_extT_rh_projfrac05.mgz')
sig2 = io.read_scalar_data('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_TPROJ_tT_extT_rh_projfrac05.mgz')

thresh = 3.11
sig1[sig1 < thresh] = 0
sig2[sig2 < thresh] = 0
conjunct = np.min(np.vstack((sig1, sig2)), axis=0)
brain.add_overlay(sig1, thresh, 10, name="sig1")
brain.overlays["sig1"].pos_bar.lut_mode = "Blues"
brain.overlays["sig1"].pos_bar.visible = False
brain.add_overlay(sig2, thresh, 10, name="sig2")
brain.overlays["sig2"].pos_bar.lut_mode = "Reds"
brain.overlays["sig2"].pos_bar.visible = False
brain.add_overlay(conjunct, thresh, 10, name="conjunct")
brain.overlays["conjunct"].pos_bar.lut_mode = "Purples"
brain.overlays["conjunct"].pos_bar.visible = False

mayavi.mlab.view(azimuth=45, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJ_overlay_TPROJ_tT_extT_rh_projfrac05_face1.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=315, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJ_overlay_TPROJ_tT_extT_rh_projfrac05_face2.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=225, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJ_overlay_TPROJ_tT_extT_rh_projfrac05_face3.png", size=None, figure=None, magnification='auto')

############################### LH ######################################
brain = Brain("fsaverage", "lh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
sig1 = io.read_scalar_data('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SPROJ_tT_extT_lh_projfrac05.mgz')
sig2 = io.read_scalar_data('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_TPROJ_tT_extT_lh_projfrac05.mgz')

thresh = 3.11
sig1[sig1 < thresh] = 0
sig2[sig2 < thresh] = 0
conjunct = np.min(np.vstack((sig1, sig2)), axis=0)
brain.add_overlay(sig1, thresh, 10, name="sig1")
brain.overlays["sig1"].pos_bar.lut_mode = "Blues"
brain.overlays["sig1"].pos_bar.visible = False
brain.add_overlay(sig2, thresh, 10, name="sig2")
brain.overlays["sig2"].pos_bar.lut_mode = "Reds"
brain.overlays["sig2"].pos_bar.visible = False
brain.add_overlay(conjunct, thresh, 10, name="conjunct")
brain.overlays["conjunct"].pos_bar.lut_mode = "Purples"
brain.overlays["conjunct"].pos_bar.visible = False

mayavi.mlab.view(azimuth=225, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJ_overlay_TPROJ_CTRL_tT_extT_lh_projfrac05_face1.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=135, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJ_overlay_TPROJ_CTRL_tT_extT_lh_projfrac05_face2.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=315, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJ_overlay_TPROJ_CTRL_tT_extT_lh_projfrac05_face3.png", size=None, figure=None, magnification='auto')

#########################################################################################
#########################################################################################
######################################## TEST ###########################################
brain = Brain("fsaverage", "lh", "orig", curv=None,config_opts={"cortex": "bone","background": "black"})
sig1 = io.read_scalar_data('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SJ_TJ_conjunction_lh_projfrac05.mgz')

brain.add_overlay(sig1, min=3.12, max=7.7, sign="pos")
mayavi.mlab.view(azimuth=225, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_TJplusSJvsCTRL_lh_projfrac05_face1.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=120, elevation=85, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_TJplusSJvsCTRL_lh_projfrac05_face2.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=325, elevation=100, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_TJplusSJvsCTRL_lh_projfrac05_face3.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "rh", "orig", curv=None,config_opts={"cortex": "bone","background": "black"})
sig1 = io.read_scalar_data('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SJ_TJ_conjunction_rh_projfrac05.mgz')

brain.add_overlay(sig1, min=3.12, max=7.7, sign="pos")
mayavi.mlab.view(azimuth=215, elevation=100, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_TJplusSJvsCTRL_rh_projfrac05_face1.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=55, elevation=85, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_TJplusSJvsCTRL_rh_projfrac05_face2.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=315, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_TJplusSJvsCTRL_rh_projfrac05_face3.png", size=None, figure=None, magnification='auto')


######################################## TEST ###########################################
brain = Brain("fsaverage", "lh", "orig", curv=None,config_opts={"cortex": "bone","background": "black"})
sig1 = io.read_scalar_data('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SPROJSJ+TPROJTJ_lh_projfrac05.mgz')

brain.add_overlay(sig1, min=3.12, max=6.4, sign="pos")
mayavi.mlab.view(azimuth=225, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJSJ+TPROJTJ_lh_projfrac05_face1.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=120, elevation=85, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJSJ+TPROJTJ_lh_projfrac05_face2.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=325, elevation=100, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJSJ+TPROJTJ_lh_projfrac05_face3.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=0, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJSJ+TPROJTJ_lh_projfrac05_face4.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=180, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJSJ+TPROJTJ_lh_projfrac05_face5.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=0, elevation=-20, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJSJ+TPROJTJ_lh_projfrac05_face6.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "rh", "orig", curv=None,config_opts={"cortex": "bone","background": "black"})
sig1 = io.read_scalar_data('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SPROJSJ+TPROJTJ_lh_projfrac05.mgz')

brain.add_overlay(sig1, min=3.12, max=6.4, sign="pos")
mayavi.mlab.view(azimuth=215, elevation=100, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJSJ+TPROJTJ_rh_projfrac05_face1.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=55, elevation=85, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJSJ+TPROJTJ_rh_projfrac05_face2.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=315, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJSJ+TPROJTJ_rh_projfrac05_face3.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=0, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJSJ+TPROJTJ_rh_projfrac05_face4.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=180, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJSJ+TPROJTJ_rh_projfrac05_face5.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=0, elevation=20, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJSJ+TPROJTJ_rh_projfrac05_face6.png", size=None, figure=None, magnification='auto')

#########################################################################################
#########################################################################################
################### SPROJ-CTRL overlay TPROJ-CTRL ##########################
############################### RH ###################################
brain = Brain("fsaverage", "rh", "orig", config_opts={"cortex": "low_contrast","background": "black"})
sig1 = io.read_scalar_data('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SJ_TJ_tT_extT_rh_projfrac05.mgz')
sig2 = io.read_scalar_data('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_TJ_SJ_tT_extT_rh_projfrac05.mgz')

thresh = 3.116
sig1[sig1 < thresh] = 0
sig2[sig2 < thresh] = 0
conjunct = np.min(np.vstack((sig1, sig2)), axis=0)
brain.add_overlay(sig1, thresh, 10, name="sig1")
brain.overlays["sig1"].pos_bar.lut_mode = "Blues"
brain.add_overlay(sig2, thresh, 10, name="sig2")
brain.overlays["sig2"].pos_bar.lut_mode = "Reds"

mayavi.mlab.view(azimuth=215, elevation=100, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_STvsTJ_rh_projfrac05_face1.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=55, elevation=85, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_STvsTJ_rh_projfrac05_face2.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=315, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_STvsTJ_rh_projfrac05_face3.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=0, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_STvsTJ_rh_projfrac05_face4.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=180, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_STvsTJ_rh_projfrac05_face5.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=0, elevation=20, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_STvsTJ_rh_projfrac05_face6.png", size=None, figure=None, magnification='auto')

######################################################################################
brain = Brain("fsaverage", "lh", "orig", config_opts={"cortex":"low_contrast","background":"black"})
sig1 = io.read_scalar_data('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SJ_TJ_tT_extT_lh_projfrac05.mgz')
sig2 = io.read_scalar_data('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_TJ_SJ_tT_extT_lh_projfrac05.mgz')

thresh = 3.116
sig1[sig1 < thresh] = 0
sig2[sig2 < thresh] = 0
conjunct = np.min(np.vstack((sig1, sig2)), axis=0)
brain.add_overlay(sig1, thresh, 10, name="sig1")
brain.overlays["sig1"].pos_bar.lut_mode = "Blues"
brain.add_overlay(sig2, thresh, 10, name="sig2")
brain.overlays["sig2"].pos_bar.lut_mode = "Reds"

mayavi.mlab.view(azimuth=225, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_STvsTJ_lh_projfrac05_face1.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=120, elevation=85, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_STvsTJ_lh_projfrac05_face2.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=325, elevation=100, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_STvsTJ_lh_projfrac05_face3.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=0, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_STvsTJ_lh_projfrac05_face4.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=180, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_STvsTJ_lh_projfrac05_face5.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=0, elevation=-20, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_STvsTJ_lh_projfrac05_face6.png", size=None, figure=None, magnification='auto')

######################################################################################
######################################################################################
brain = Brain("fsaverage", "lh", "orig", config_opts={"cortex":"low_contrast","background":"black"})
sig1 = io.read_scalar_data('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SPROJ_tT_extT_lh_projfrac05.mgz')
sig2 = io.read_scalar_data('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_TPROJ_tT_extT_lh_projfrac05.mgz')

thresh = 3.11
sig1[sig1 < thresh] = 0
sig2[sig2 < thresh] = 0
conjunct = np.min(np.vstack((sig1, sig2)), axis=0)
brain.add_overlay(sig1, thresh, 10, name="sig1")
brain.overlays["sig1"].pos_bar.lut_mode = "Blues"
brain.overlays["sig1"].pos_bar.visible = False
brain.add_overlay(sig2, thresh, 10, name="sig2")
brain.overlays["sig2"].pos_bar.lut_mode = "Reds"
brain.overlays["sig2"].pos_bar.visible = False
brain.add_overlay(conjunct, thresh, 10, name="conjunct")
brain.overlays["conjunct"].pos_bar.lut_mode = "Purples"
brain.overlays["conjunct"].pos_bar.visible = False

mayavi.mlab.view(azimuth=225, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJSJ+TPROJTJ_lh_projfrac05_face1.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=120, elevation=85, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJSJ+TPROJTJ_lh_projfrac05_face2.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=325, elevation=100, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJSJ+TPROJTJ_lh_projfrac05_face3.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=0, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJSJ+TPROJTJ_lh_projfrac05_face4.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=180, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJSJ+TPROJTJ_lh_projfrac05_face5.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=0, elevation=-20, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJSJ+TPROJTJ_lh_projfrac05_face6.png", size=None, figure=None, magnification='auto')

##################################################################################
brain = Brain("fsaverage", "rh", "orig", config_opts={"cortex": "low_contrast","background": "black"})
sig1 = io.read_scalar_data('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SPROJ_tT_extT_rh_projfrac05.mgz')
sig2 = io.read_scalar_data('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_TPROJ_tT_extT_rh_projfrac05.mgz')

thresh = 3.116
sig1[sig1 < thresh] = 0
sig2[sig2 < thresh] = 0
conjunct = np.min(np.vstack((sig1, sig2)), axis=0)
brain.add_overlay(sig1, thresh, 10, name="sig1")
brain.overlays["sig1"].pos_bar.lut_mode = "Blues"
brain.add_overlay(sig2, thresh, 10, name="sig2")
brain.overlays["sig2"].pos_bar.lut_mode = "Reds"
brain.add_overlay(conjunct, thresh, 10, name="conjunct")
brain.overlays["conjunct"].pos_bar.lut_mode = "Purples"
brain.overlays["conjunct"].pos_bar.visible = False

mayavi.mlab.view(azimuth=215, elevation=100, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJSJ+TPROJTJ_rh_projfrac05_face1.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=55, elevation=85, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJSJ+TPROJTJ_rh_projfrac05_face2.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=315, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJSJ+TPROJTJ_rh_projfrac05_face3.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=0, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJSJ+TPROJTJ_rh_projfrac05_face4.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=180, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJSJ+TPROJTJ_rh_projfrac05_face5.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=0, elevation=20, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJSJ+TPROJTJ_rh_projfrac05_face6.png", size=None, figure=None, magnification='auto')



