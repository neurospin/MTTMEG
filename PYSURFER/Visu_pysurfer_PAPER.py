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


########################## TJ - SJ #########################"
brain = Brain("fsaverage", "lh", "pial", config_opts={"cortex":"low_contrast","background":"black"})
sig1 = np.nan_to_num(io.read_scalar_data("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_TJ-SJ_lh.mgz"))
sig2 = np.nan_to_num(io.read_scalar_data('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SJ-TJ_lh.mgz'))

thresh = 1
sig1[sig1 < thresh] = 0
sig2[sig2 < thresh] = 0
conjunct = np.min(np.vstack((sig1, sig2)), axis=0)
brain.add_overlay(sig1, 1, 8, name="sig1")
brain.overlays["sig1"].pos_bar.lut_mode = "Reds"
brain.overlays["sig1"].pos_bar.visible = False
brain.add_overlay(sig2, 1, 8, name="sig2")
brain.overlays["sig2"].pos_bar.lut_mode = "Blues"
brain.overlays["sig2"].pos_bar.visible = False

################### CONJ[TJ-CTRL SJ- CTRL] #####################
################## WHITE #######################################
###################### LH #######################
brain = Brain("fsaverage", "lh", "white", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_CONJTASK_lh_projfrac05.mgz"
brain.add_overlay(overlay_file, min=1, max=10, sign="pos")
mayavi.mlab.view(azimuth=-33, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/MentalTravel_Martin_2014/BAPTISTE_FOLDER/PICTURES/MOD40/GROUPlvl_CONJTASK_lh_projfrac05_face1.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=200, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/MentalTravel_Martin_2014/BAPTISTE_FOLDER/PICTURES/MOD40/GROUPlvl_CONJTASK_lh_projfrac05_face2.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=0, elevation=0, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/MentalTravel_Martin_2014/BAPTISTE_FOLDER/PICTURES/MOD40/GROUPlvl_CONJTASK_lh_projfrac05_face3.png", size=None, figure=None, magnification='auto')
###################### RH #######################
brain = Brain("fsaverage", "rh", "white", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_CONJTASK_rh_projfrac05.mgz"
brain.add_overlay(overlay_file, min=3.11, max=10, sign="pos")
mayavi.mlab.view(azimuth=-33, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/MentalTravel_Martin_2014/BAPTISTE_FOLDER/PICTURES/MOD40/GROUPlvl_CONJTASK_rh_projfrac05_face1.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=200, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/MentalTravel_Martin_2014/BAPTISTE_FOLDER/PICTURES/MOD40/GROUPlvl_CONJTASK_rh_projfrac05_face2.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=0, elevation=0, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/MentalTravel_Martin_2014/BAPTISTE_FOLDER/PICTURES/MOD40/GROUPlvl_CONJTASK_rh_projfrac05_face3.png", size=None, figure=None, magnification='auto')

################### CONJ[TJ-CTRL SJ- CTRL] #####################
################## PIAL #######################################
###################### LH #######################
brain = Brain("fsaverage", "lh", "pial", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_CONJTASK_lh_projfrac05.mgz"
brain.add_overlay(overlay_file, min=3.11, max=10, sign="pos")
mayavi.mlab.view(azimuth=-33, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/MentalTravel_Martin_2014/BAPTISTE_FOLDER/PICTURES/MOD40/GROUPlvl_CONJTASK_lh_projfrac05_face1_pial.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=200, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/MentalTravel_Martin_2014/BAPTISTE_FOLDER/PICTURES/MOD40/GROUPlvl_CONJTASK_lh_projfrac05_face2_pial.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=0, elevation=0, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/MentalTravel_Martin_2014/BAPTISTE_FOLDER/PICTURES/MOD40/GROUPlvl_CONJTASK_lh_projfrac05_face3_pial.png", size=None, figure=None, magnification='auto')
###################### RH #######################
brain = Brain("fsaverage", "rh", "pial", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_CONJTASK_rh_projfrac05.mgz"
brain.add_overlay(overlay_file, min=3.11, max=10, sign="pos")
mayavi.mlab.view(azimuth=-33, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/MentalTravel_Martin_2014/BAPTISTE_FOLDER/PICTURES/MOD40/GROUPlvl_CONJTASK_rh_projfrac05_face1_pial.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=200, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/MentalTravel_Martin_2014/BAPTISTE_FOLDER/PICTURES/MOD40/GROUPlvl_CONJTASK_rh_projfrac05_face2_pial.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=0, elevation=0, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/MentalTravel_Martin_2014/BAPTISTE_FOLDER/PICTURES/MOD40/GROUPlvl_CONJTASK_rh_projfrac05_face3_pial.png", size=None, figure=None, magnification='auto')

################### CONJ[TJ-CTRL SJ- CTRL] #####################
################## INFLATED #######################################
###################### LH #######################
brain = Brain("fsaverage", "lh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_CONJTASK_lh_projfrac05.mgz"
brain.add_overlay(overlay_file, min=3.11, max=10, sign="pos")
mayavi.mlab.view(azimuth=-33, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/MentalTravel_Martin_2014/BAPTISTE_FOLDER/PICTURES/MOD40/GROUPlvl_CONJTASK_lh_projfrac05_face1_inflated.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=200, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/MentalTravel_Martin_2014/BAPTISTE_FOLDER/PICTURES/MOD40/GROUPlvl_CONJTASK_lh_projfrac05_face2_inflated.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=0, elevation=0, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/MentalTravel_Martin_2014/BAPTISTE_FOLDER/PICTURES/MOD40/GROUPlvl_CONJTASK_lh_projfrac05_face3_inflated.png", size=None, figure=None, magnification='auto')
###################### RH #######################
brain = Brain("fsaverage", "rh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_CONJTASK_rh_projfrac05.mgz"
brain.add_overlay(overlay_file, min=3.11, max=10, sign="pos")
mayavi.mlab.view(azimuth=-33, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/MentalTravel_Martin_2014/BAPTISTE_FOLDER/PICTURES/MOD40/GROUPlvl_CONJTASK_rh_projfrac05_face1_inflated.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=200, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/MentalTravel_Martin_2014/BAPTISTE_FOLDER/PICTURES/MOD40/GROUPlvl_CONJTASK_rh_projfrac05_face2_inflated.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=0, elevation=0, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/MentalTravel_Martin_2014/BAPTISTE_FOLDER/PICTURES/MOD40/GROUPlvl_CONJTASK_rh_projfrac05_face3_inflated.png", size=None, figure=None, magnification='auto')

######################################################################
######################################################################
######################################################################
export SUBJECTS_DIR='/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/mri'
export QT_API=pyqt

ipython --pylab
%gui qt

from surfer import Brain
import mayavi
from numpy import array
from matplotlib import pyplot as pl 

import os.path as op
import numpy as np
from surfer import io

########################### RH ###############################################
brain = Brain("fsaverage", "rh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
sig1 = np.nan_to_num(io.read_scalar_data("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/TJ_CTRL_FDRcorr_rh_projfrac05.mgz"))
sig2 = np.nan_to_num(io.read_scalar_data('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/SJ_CTRL_FDRcorr_rh_projfrac05.mgz'))

thresh = 3.11
sig1[sig1 < thresh] = 0
sig2[sig2 < thresh] = 0
conjunct = np.min(np.vstack((sig1, sig2)), axis=0)
brain.add_overlay(sig1, 3.11, 8, name="sig1")
brain.overlays["sig1"].pos_bar.lut_mode = "Reds"
brain.overlays["sig1"].pos_bar.visible = False
brain.add_overlay(sig2, 3.11, 8, name="sig2")
brain.overlays["sig2"].pos_bar.lut_mode = "Blues"
brain.overlays["sig2"].pos_bar.visible = False
brain.add_overlay(conjunct, thresh, 8, name="conjunct")
brain.overlays["conjunct"].pos_bar.lut_mode = "Purples"
brain.overlays["conjunct"].pos_bar.visible = False

mayavi.mlab.view(azimuth=-33, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/MentalTravel_Martin_2014/BAPTISTE_FOLDER/PICTURES/MOD40/GROUPlvl_SJ_CTRL_overlay_TJ_CTRL_rh_projfrac05_inflated_face1.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=200, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/MentalTravel_Martin_2014/BAPTISTE_FOLDER/PICTURES/MOD40/GROUPlvl_SJ_CTRL_overlay_TJ_CTRL_rh_projfrac05_inflated_face2.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=45, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/MentalTravel_Martin_2014/BAPTISTE_FOLDER/PICTURES/MOD40/GROUPlvl_SJ_CTRL_overlay_TJ_CTRL_lh_projfrac05_inflated_face4.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=0, elevation=0, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/MentalTravel_Martin_2014/BAPTISTE_FOLDER/PICTURES/MOD40/GROUPlvl_SJ_CTRL_overlay_TJ_CTRL_rh_projfrac05_inflated_face3.png", size=None, figure=None, magnification='auto')

########################### LH ###############################################
brain = Brain("fsaverage", "lh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
sig1 = np.nan_to_num(io.read_scalar_data("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/TJ_CTRL_FDRcorr_lh_projfrac05.mgz"))
sig2 = np.nan_to_num(io.read_scalar_data('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/SJ_CTRL_FDRcorr_lh_projfrac05.mgz'))

thresh = 3.11
sig1[sig1 < thresh] = 0
sig2[sig2 < thresh] = 0
conjunct = np.min(np.vstack((sig1, sig2)), axis=0)
brain.add_overlay(sig1, 3.11, 8, name="sig1")
brain.overlays["sig1"].pos_bar.lut_mode = "Reds"
brain.overlays["sig1"].pos_bar.visible = False
brain.add_overlay(sig2, 3.11, 8, name="sig2")
brain.overlays["sig2"].pos_bar.lut_mode = "Blues"
brain.overlays["sig2"].pos_bar.visible = False
brain.add_overlay(conjunct, thresh, 11, name="conjunct")
brain.overlays["conjunct"].pos_bar.lut_mode = "Purples"
brain.overlays["conjunct"].pos_bar.visible = False

mayavi.mlab.view(azimuth=-33, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/MentalTravel_Martin_2014/BAPTISTE_FOLDER/PICTURES/MOD40/GROUPlvl_SJ_CTRL_overlay_TJ_CTRL_lh_projfrac05_inflated_face1.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=200, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/MentalTravel_Martin_2014/BAPTISTE_FOLDER/PICTURES/MOD40/GROUPlvl_SJ_CTRL_overlay_TJ_CTRL_lh_projfrac05_inflated_face2.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=45, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/MentalTravel_Martin_2014/BAPTISTE_FOLDER/PICTURES/MOD40/GROUPlvl_SJ_CTRL_overlay_TJ_CTRL_lh_projfrac05_inflated_face4.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=0, elevation=0, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/MentalTravel_Martin_2014/BAPTISTE_FOLDER/PICTURES/MOD40/GROUPlvl_SJ_CTRL_overlay_TJ_CTRL_lh_projfrac05_inflated_face3.png", size=None, figure=None, magnification='auto')

#################################################################################
########################### RH ###############################################
brain = Brain("fsaverage", "rh", "white", config_opts={"cortex":"low_contrast","background":"black"})
sig1 = np.nan_to_num(io.read_scalar_data("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/TJ_CTRL_FDRcorr_rh_projfrac05.mgz"))
sig2 = np.nan_to_num(io.read_scalar_data('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/SJ_CTRL_FDRcorr_rh_projfrac05.mgz'))

thresh = 3.11
sig1[sig1 < thresh] = 0
sig2[sig2 < thresh] = 0
conjunct = np.min(np.vstack((sig1, sig2)), axis=0)
brain.add_overlay(sig1, 3.11, 8, name="sig1")
brain.overlays["sig1"].pos_bar.lut_mode = "Reds"
brain.overlays["sig1"].pos_bar.visible = False
brain.add_overlay(sig2, 3.11, 8, name="sig2")
brain.overlays["sig2"].pos_bar.lut_mode = "Blues"
brain.overlays["sig2"].pos_bar.visible = False
brain.add_overlay(conjunct, thresh, 8, name="conjunct")
brain.overlays["conjunct"].pos_bar.lut_mode = "Purples"
brain.overlays["conjunct"].pos_bar.visible = False

mayavi.mlab.view(azimuth=-33, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/MentalTravel_Martin_2014/BAPTISTE_FOLDER/PICTURES/MOD40/GROUPlvl_SJ_CTRL_overlay_TJ_CTRL_rh_projfrac05_white_face1.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=200, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/MentalTravel_Martin_2014/BAPTISTE_FOLDER/PICTURES/MOD40/GROUPlvl_SJ_CTRL_overlay_TJ_CTRL_rh_projfrac05_white_face2.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=45, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/MentalTravel_Martin_2014/BAPTISTE_FOLDER/PICTURES/MOD40/GROUPlvl_SJ_CTRL_overlay_TJ_CTRL_rh_projfrac05_white_face4.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=0, elevation=0, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/MentalTravel_Martin_2014/BAPTISTE_FOLDER/PICTURES/MOD40/GROUPlvl_SJ_CTRL_overlay_TJ_CTRL_rh_projfrac05_white_face3.png", size=None, figure=None, magnification='auto')

########################### LH ###############################################
brain = Brain("fsaverage", "lh", "white", config_opts={"cortex":"low_contrast","background":"black"})
sig1 = np.nan_to_num(io.read_scalar_data("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/TJ_CTRL_FDRcorr_lh_projfrac05.mgz"))
sig2 = np.nan_to_num(io.read_scalar_data('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/SJ_CTRL_FDRcorr_lh_projfrac05.mgz'))

thresh = 3.11
sig1[sig1 < thresh] = 0
sig2[sig2 < thresh] = 0
conjunct = np.min(np.vstack((sig1, sig2)), axis=0)
brain.add_overlay(sig1, 3.11, 8, name="sig1")
brain.overlays["sig1"].pos_bar.lut_mode = "Reds"
brain.overlays["sig1"].pos_bar.visible = False
brain.add_overlay(sig2, 3.11, 8, name="sig2")
brain.overlays["sig2"].pos_bar.lut_mode = "Blues"
brain.overlays["sig2"].pos_bar.visible = False
brain.add_overlay(conjunct, thresh, 8, name="conjunct")
brain.overlays["conjunct"].pos_bar.lut_mode = "Purples"
brain.overlays["conjunct"].pos_bar.visible = False

mayavi.mlab.view(azimuth=-33, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/MentalTravel_Martin_2014/BAPTISTE_FOLDER/PICTURES/MOD40/GROUPlvl_SJ_CTRL_overlay_TJ_CTRL_lh_projfrac05_white_face1.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=200, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/MentalTravel_Martin_2014/BAPTISTE_FOLDER/PICTURES/MOD40/GROUPlvl_SJ_CTRL_overlay_TJ_CTRL_lh_projfrac05_white_face2.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=45, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/MentalTravel_Martin_2014/BAPTISTE_FOLDER/PICTURES/MOD40/GROUPlvl_SJ_CTRL_overlay_TJ_CTRL_lh_projfrac05_white_face4.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=0, elevation=0, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/MentalTravel_Martin_2014/BAPTISTE_FOLDER/PICTURES/MOD40/GROUPlvl_SJ_CTRL_overlay_TJ_CTRL_lh_projfrac05_white_face3.png", size=None, figure=None, magnification='auto')

#################################################################################
########################### RH ###############################################
brain = Brain("fsaverage", "rh", "pial", config_opts={"cortex":"low_contrast","background":"black"})
sig1 = np.nan_to_num(io.read_scalar_data("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/TJ_CTRL_FDRcorr_rh_projfrac05.mgz"))
sig2 = np.nan_to_num(io.read_scalar_data('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/SJ_CTRL_FDRcorr_rh_projfrac05.mgz'))

thresh = 3.11
sig1[sig1 < thresh] = 0
sig2[sig2 < thresh] = 0
conjunct = np.min(np.vstack((sig1, sig2)), axis=0)
brain.add_overlay(sig1, 3.11, 8, name="sig1")
brain.overlays["sig1"].pos_bar.lut_mode = "Reds"
brain.overlays["sig1"].pos_bar.visible = False
brain.add_overlay(sig2, 3.11, 8, name="sig2")
brain.overlays["sig2"].pos_bar.lut_mode = "Blues"
brain.overlays["sig2"].pos_bar.visible = False
brain.add_overlay(conjunct, thresh, 8, name="conjunct")
brain.overlays["conjunct"].pos_bar.lut_mode = "Purples"
brain.overlays["conjunct"].pos_bar.visible = False

mayavi.mlab.view(azimuth=-33, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/MentalTravel_Martin_2014/BAPTISTE_FOLDER/PICTURES/MOD40/GROUPlvl_SJ_CTRL_overlay_TJ_CTRL_rh_projfrac05_pial_face1.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=215, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/MentalTravel_Martin_2014/BAPTISTE_FOLDER/PICTURES/MOD40/GROUPlvl_SJ_CTRL_overlay_TJ_CTRL_rh_projfrac05_pial_face2.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=45, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/MentalTravel_Martin_2014/BAPTISTE_FOLDER/PICTURES/MOD40/GROUPlvl_SJ_CTRL_overlay_TJ_CTRL_rh_projfrac05_pial_face4.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=0, elevation=0, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/MentalTravel_Martin_2014/BAPTISTE_FOLDER/PICTURES/MOD40/GROUPlvl_SJ_CTRL_overlay_TJ_CTRL_rh_projfrac05_pial_face3.png", size=None, figure=None, magnification='auto')

########################### LH ###############################################
brain = Brain("fsaverage", "lh", "pial", config_opts={"cortex":"low_contrast","background":"black"})
sig1 = np.nan_to_num(io.read_scalar_data("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/TJ_CTRL_FDRcorr_lh_projfrac05.mgz"))
sig2 = np.nan_to_num(io.read_scalar_data('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/SJ_CTRL_FDRcorr_lh_projfrac05.mgz'))

thresh = 3.11
sig1[sig1 < thresh] = 0
sig2[sig2 < thresh] = 0
conjunct = np.min(np.vstack((sig1, sig2)), axis=0)
brain.add_overlay(sig1, 3.11, 8, name="sig1")
brain.overlays["sig1"].pos_bar.lut_mode = "Reds"
brain.overlays["sig1"].pos_bar.visible = False
brain.add_overlay(sig2, 3.11, 8, name="sig2")
brain.overlays["sig2"].pos_bar.lut_mode = "Blues"
brain.overlays["sig2"].pos_bar.visible = False
brain.add_overlay(conjunct, thresh, 8, name="conjunct")
brain.overlays["conjunct"].pos_bar.lut_mode = "Purples"
brain.overlays["conjunct"].pos_bar.visible = False

mayavi.mlab.view(azimuth=-33, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/MentalTravel_Martin_2014/BAPTISTE_FOLDER/PICTURES/MOD40/GROUPlvl_SJ_CTRL_overlay_TJ_CTRL_lh_projfrac05_pial_face1.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=200, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/MentalTravel_Martin_2014/BAPTISTE_FOLDER/PICTURES/MOD40/GROUPlvl_SJ_CTRL_overlay_TJ_CTRL_lh_projfrac05_pial_face2.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=45, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/MentalTravel_Martin_2014/BAPTISTE_FOLDER/PICTURES/MOD40/GROUPlvl_SJ_CTRL_overlay_TJ_CTRL_lh_projfrac05_pial_face4.png", size=None, figure=None, magnification='auto')
mayavi.mlab.view(azimuth=0, elevation=0, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/MentalTravel_Martin_2014/BAPTISTE_FOLDER/PICTURES/MOD40/GROUPlvl_SJ_CTRL_overlay_TJ_CTRL_lh_projfrac05_pial_face3.png", size=None, figure=None, magnification='auto')


















