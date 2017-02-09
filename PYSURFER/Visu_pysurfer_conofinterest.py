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

#from mayavi.api import Engine
#engine = Engine()
#engine.start()

#if len(engine.scenes) == 0:
#    engine.new_scene()

################### internal face #####################

#scene = engine.scenes[0]
brain = Brain("fsaverage", "lh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
#camera_light = engine.scenes[0].scene.light_manager.lights[0]
#camera_light.activate = False
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_TJ_CTRL_lh_projfrac05.mgz"
brain.add_overlay(overlay_file, min=3.11, max=8, sign="pos")
mayavi.mlab.view(azimuth=180, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_TJ_CTRL_lh_projfrac05_internalface.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "rh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_TJ_CTRL_rh_projfrac05.mgz"
brain.add_overlay(overlay_file, min=3.11, max=11, sign="pos")
mayavi.mlab.view(azimuth=180, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_TJ_CTRL_rh_projfrac05_internalface.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "lh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SJ_CTRL_lh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
brain.add_overlay(sig1, 3.11, 11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Blues"
mayavi.mlab.view(azimuth=180, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SJ_CTRL_lh_projfrac05_internalface.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "rh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SJ_CTRL_rh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
brain.add_overlay(sig1, 3.11, 11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Blues"
mayavi.mlab.view(azimuth=180, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SJ_CTRL_rh_projfrac05_internalface.png", size=None, figure=None, magnification='auto')

################### frontal pole #####################
brain = Brain("fsaverage", "lh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_TJ_CTRL_lh_projfrac05.mgz"
brain.add_overlay(overlay_file, min=3.11, max=11, sign="pos")
mayavi.mlab.view(azimuth=90, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_TJ_CTRL_lh_projfrac05_frontalpole.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "rh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_TJ_CTRL_rh_projfrac05.mgz"
brain.add_overlay(overlay_file, min=3.11, max=11, sign="pos")
mayavi.mlab.view(azimuth=90, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_TJ_CTRL_rh_projfrac05_frontalpole.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "lh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SJ_CTRL_lh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
brain.add_overlay(sig1, min=3.11, min=11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Blues"
mayavi.mlab.view(azimuth=90, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SJ_CTRL_lh_projfrac05_frontalpole.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "rh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SJ_CTRL_rh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
brain.add_overlay(sig1, min=3.11, min=11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Blues"
mayavi.mlab.view(azimuth=90, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SJ_CTRL_rh_projfrac05_frontalpole.png", size=None, figure=None, magnification='auto')

################### external face #####################
brain = Brain("fsaverage", "lh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_TJ_CTRL_lh_projfrac05.mgz"
brain.add_overlay(overlay_file, min=3.11, max=11, sign="pos")
mayavi.mlab.view(azimuth=0, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_TJ_CTRL_lh_projfrac05_externalface.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "rh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_TJ_CTRL_rh_projfrac05.mgz"
brain.add_overlay(overlay_file, min=3.11, max=11, sign="pos")
mayavi.mlab.view(azimuth=0, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_TJ_CTRL_rh_projfrac05_externalface.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "lh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SJ_CTRL_lh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
brain.add_overlay(sig1, min=3.11, min=11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Blues"
mayavi.mlab.view(azimuth=90, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SJ_CTRL_lh_projfrac05_externalface.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "rh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SJ_CTRL_rh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
brain.add_overlay(sig1, min=3.11, min=11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Blues"
mayavi.mlab.view(azimuth=90, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SJ_CTRL_rh_projfrac05_externalface.png", size=None, figure=None, magnification='auto')

################### occipital pole #####################
brain = Brain("fsaverage", "lh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_TJ_CTRL_lh_projfrac05.mgz"
brain.add_overlay(overlay_file, min=3.11, max=11, sign="pos")
mayavi.mlab.view(azimuth=270, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_TJ_CTRL_lh_projfrac05_occipitalpole.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "rh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_TJ_CTRL_rh_projfrac05.mgz"
brain.add_overlay(overlay_file, min=3.11, max=11, sign="pos")
mayavi.mlab.view(azimuth=270, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_TJ_CTRL_rh_projfrac05_occipitalpole.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "lh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SJ_CTRL_lh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
brain.add_overlay(sig1, 3.11, 11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Blues"
mayavi.mlab.view(azimuth=270, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SJ_CTRL_lh_projfrac05_occipitalpole.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "rh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SJ_CTRL_rh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
brain.add_overlay(sig1, 3.11, 11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Blues"
mayavi.mlab.view(azimuth=270, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SJ_CTRL_rh_projfrac05_occipitalpole.png", size=None, figure=None, magnification='auto')

################### internal face - conjunction #####################
import os.path as op
import numpy as np
from surfer import io
from surfer import Brain

brain = Brain("fsaverage", "rh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
sig1 = io.read_scalar_data('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SJ_CTRL_rh_projfrac05.mgz')
sig2 = io.read_scalar_data('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_TJ_CTRL_rh_projfrac05.mgz')

thresh = 3.11
sig1[sig1 < thresh] = 0
sig2[sig2 < thresh] = 0
conjunct = np.min(np.vstack((sig1, sig2)), axis=0)
brain.add_overlay(sig1, thresh, 11, name="sig1")
brain.overlays["sig1"].pos_bar.lut_mode = "Reds"
brain.overlays["sig1"].pos_bar.visible = False
brain.add_overlay(sig2, thresh, 11, name="sig2")
brain.overlays["sig2"].pos_bar.lut_mode = "Blues"
brain.overlays["sig2"].pos_bar.visible = False
brain.add_overlay(conjunct, thresh, 11, name="conjunct")
brain.overlays["conjunct"].pos_bar.lut_mode = "Purples"
brain.overlays["conjunct"].pos_bar.visible = False

mayavi.mlab.view(azimuth=45, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SJ_CTRL_overlay_TJ_CTRL_rh_projfrac05_externalface1.png", size=None, figure=None, magnification='auto')

mayavi.mlab.view(azimuth=315, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SJ_CTRL_overlay_TJ_CTRL_rh_projfrac05_externalface2.png", size=None, figure=None, magnification='auto')

mayavi.mlab.view(azimuth=225, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SJ_CTRL_overlay_TJ_CTRL_rh_projfrac05_internalface1.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "lh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
sig1 = io.read_scalar_data('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SJ_CTRL_lh_projfrac05.mgz')
sig2 = io.read_scalar_data('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_TJ_CTRL_lh_projfrac05.mgz')

thresh = 3.11
sig1[sig1 < thresh] = 0
sig2[sig2 < thresh] = 0
conjunct = np.min(np.vstack((sig1, sig2)), axis=0)
brain.add_overlay(sig1, thresh, 11, name="sig1")
brain.overlays["sig1"].pos_bar.lut_mode = "Blues"
brain.overlays["sig1"].pos_bar.visible = False
brain.add_overlay(sig2, thresh, 11, name="sig2")
brain.overlays["sig2"].pos_bar.lut_mode = "Reds"
brain.overlays["sig2"].pos_bar.visible = False
brain.add_overlay(conjunct, thresh, 11, name="conjunct")
brain.overlays["conjunct"].pos_bar.lut_mode = "Purples"
brain.overlays["conjunct"].pos_bar.visible = False

mayavi.mlab.view(azimuth=45, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SJ_CTRL_overlay_TJ_CTRL_lh_projfrac05_externalface1.png", size=None, figure=None, magnification='auto')

mayavi.mlab.view(azimuth=225, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SJ_CTRL_overlay_TJ_CTRL_lh_projfrac05_internalface1.png", size=None, figure=None, magnification='auto')

mayavi.mlab.view(azimuth=315, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SJ_CTRL_overlay_TJ_CTRL_lh_projfrac05_externalface2.png", size=None, figure=None, magnification='auto')


mayavi.mlab.view(azimuth=135, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SJ_CTRL_overlay_TJ_CTRL_lh_projfrac05_occipitalpole.png", size=None, figure=None, magnification='auto')

################################################################################
################################################################################
################### internal face #####################
brain = Brain("fsaverage", "lh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_TJ_SJ_lh_projfrac05.mgz"
brain.add_overlay(overlay_file, min=3.11, max=11, sign="pos")
mayavi.mlab.view(azimuth=45, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_TJ_SJ_lh_projfrac05_45.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "rh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_TJ_SJ_rh_projfrac05.mgz"
brain.add_overlay(overlay_file, min=3.11, max=11, sign="pos")
mayavi.mlab.view(azimuth=45, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_TJ_SJ_rh_projfrac05_45.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "lh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SJ_TJ_lh_projfrac05.mgz"
sig1 = io.read_scalar_data(overlay_file)
sig1[sig1 < 3.11] = 0
brain.add_overlay(sig1, 3.11, 11, name="sig1")
brain.overlays['sig1'].pos_bar.lut_mode = "Blues"
mayavi.mlab.view(azimuth=45, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SJ_TJ_lh_projfrac05_45.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "rh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SJ_TJ_rh_projfrac05.mgz"
sig2 = io.read_scalar_data(overlay_file)
sig2[sig2 < 3.11] = 0
brain.add_overlay(sig2, 3.11, 11, name="sig2")
brain.overlays['sig2'].pos_bar.lut_mode = "Blues"
mayavi.mlab.view(azimuth=45, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SJ_TJ_rh_projfrac05_45.png", size=None, figure=None, magnification='auto')

################### internal face #####################
brain = Brain("fsaverage", "lh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_TJ_SJ_lh_projfrac05.mgz"
brain.add_overlay(overlay_file, min=3.11, max=11, sign="pos")
mayavi.mlab.view(azimuth=135, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_TJ_SJ_lh_projfrac05_135.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "rh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_TJ_SJ_rh_projfrac05.mgz"
brain.add_overlay(overlay_file, min=3.11, max=11, sign="pos")
mayavi.mlab.view(azimuth=135, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_TJ_SJ_rh_projfrac05_135.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "lh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SJ_TJ_lh_projfrac05.mgz"
sig3 = io.read_scalar_data(overlay_file)
sig3[sig3 < 3.11] = 0
brain.add_overlay(sig3, 3.11, 11, name="sig3")
brain.overlays['sig3'].pos_bar.lut_mode = "Blues"
mayavi.mlab.view(azimuth=135, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SJ_TJ_lh_projfrac05_135.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "rh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SJ_TJ_rh_projfrac05.mgz"
sig4 = io.read_scalar_data(overlay_file)
sig4[sig4 < 3.11] = 0
brain.add_overlay(sig4, 3.11, 11, name="sig4")
brain.overlays['sig4'].pos_bar.lut_mode = "Blues"
mayavi.mlab.view(azimuth=135, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SJ_TJ_rh_projfrac05_135.png", size=None, figure=None, magnification='auto')

################### frontal pole #####################
brain = Brain("fsaverage", "lh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_TJ_SJ_lh_projfrac05.mgz"
brain.add_overlay(overlay_file, min=3.11, max=11, sign="pos")
mayavi.mlab.view(azimuth=225, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_TJ_SJ_lh_projfrac05_225.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "rh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_TJ_SJ_rh_projfrac05.mgz"
brain.add_overlay(overlay_file, min=3.11, max=11, sign="pos")
mayavi.mlab.view(azimuth=225, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_TJ_SJ_rh_projfrac05_225.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "lh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SJ_TJ_lh_projfrac05.mgz"
sig5 = io.read_scalar_data(overlay_file)
sig5[sig5 < 3.11] = 0
brain.add_overlay(sig5, 3.11, 11, name="sig5")
brain.overlays['sig5'].pos_bar.lut_mode = "Blues"
mayavi.mlab.view(azimuth=225, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SJ_TJ_lh_projfrac05_225.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "rh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SJ_TJ_rh_projfrac05.mgz"
sig6 = io.read_scalar_data(overlay_file)
sig6[sig6 < 3.11] = 0
brain.add_overlay(sig6, 3.11, 11, name="sig6")
brain.overlays['sig6'].pos_bar.lut_mode = "Blues"
mayavi.mlab.view(azimuth=225, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SJ_TJ_rh_projfrac05_225.png", size=None, figure=None, magnification='auto')

################### occipital pole #####################
brain = Brain("fsaverage", "lh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_TJ_SJ_lh_projfrac05.mgz"
brain.add_overlay(overlay_file, min=3.11, max=11, sign="pos")
mayavi.mlab.view(azimuth=315, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_TJ_SJ_lh_projfrac05_315.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "rh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_TJ_SJ_rh_projfrac05.mgz"
brain.add_overlay(overlay_file, min=3.11, max=11, sign="pos")
mayavi.mlab.view(azimuth=315, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_TJ_SJ_rh_projfrac05_315.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "lh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SJ_TJ_lh_projfrac05.mgz"
sig7 = io.read_scalar_data(overlay_file)
sig7[sig7 < 3.11] = 0
brain.add_overlay(sig7, 3.11, 11, name="sig7")
brain.overlays['sig7'].pos_bar.lut_mode = "Blues"
mayavi.mlab.view(azimuth=315, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SJ_TJ_lh_projfrac05_315.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "rh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SJ_TJ_rh_projfrac05.mgz"
sig8 = io.read_scalar_data(overlay_file)
sig8[sig8 < 3.11] = 0
brain.add_overlay(sig8, 3.11, 11, name="sig8")
brain.overlays['sig8'].pos_bar.lut_mode = "Blues"
mayavi.mlab.view(azimuth=315, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SJ_TJ_rh_projfrac05_315.png", size=None, figure=None, magnification='auto')

################################################################################
################################################################################
################### internal face #####################
brain = Brain("fsaverage", "lh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_TPROJ_lh_projfrac05.mgz"
brain.add_overlay(overlay_file, min=3.11, max=11, sign="pos")
mayavi.mlab.view(azimuth=180, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_TPROJ_lh_projfrac05_internalface.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "rh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_TPROJ_rh_projfrac05.mgz"
brain.add_overlay(overlay_file, min=3.11, max=11, sign="pos")
mayavi.mlab.view(azimuth=180, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_TPROJ_rh_projfrac05_internalface.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "lh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SPROJ_lh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
brain.add_overlay(sig1, 3.11, 11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Blues"
mayavi.mlab.view(azimuth=180, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJ_lh_projfrac05_internalface.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "rh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SPROJ_rh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
brain.add_overlay(sig1, 3.11, 11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Blues"
mayavi.mlab.view(azimuth=180, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJ_rh_projfrac05_internalface.png", size=None, figure=None, magnification='auto')

################### external face #####################
brain = Brain("fsaverage", "lh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_TPROJ_lh_projfrac05.mgz"
brain.add_overlay(overlay_file, min=3.11, max=11, sign="pos")
mayavi.mlab.view(azimuth=0, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_TPROJ_lh_projfrac05_externalface.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "rh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_TPROJ_rh_projfrac05.mgz"
brain.add_overlay(overlay_file, min=3.11, max=11, sign="pos")
mayavi.mlab.view(azimuth=0, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_TPROJ_rh_projfrac05_externalface.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "lh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SPROJ_lh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
brain.add_overlay(sig1, 3.11, 11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Blues"
mayavi.mlab.view(azimuth=0, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJ_lh_projfrac05_externalface.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "rh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SPROJ_rh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
brain.add_overlay(sig1, 3.11, 11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Blues"
mayavi.mlab.view(azimuth=0, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJ_rh_projfrac05_externalface.png", size=None, figure=None, magnification='auto')

################### frontal pole #####################
brain = Brain("fsaverage", "lh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_TPROJ_lh_projfrac05.mgz"
brain.add_overlay(overlay_file, min=3.11, max=11, sign="pos")
mayavi.mlab.view(azimuth=90, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_TPROJ_lh_projfrac05_frontalpole.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "rh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_TPROJ_rh_projfrac05.mgz"
brain.add_overlay(overlay_file, min=3.11, max=11, sign="pos")
mayavi.mlab.view(azimuth=90, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_TPROJ_rh_projfrac05_frontalpole.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "lh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SPROJ_lh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
brain.add_overlay(sig1, 3.11, 11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Blues"
mayavi.mlab.view(azimuth=90, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJ_lh_projfrac05_frontalpole.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "rh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SPROJ_rh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
brain.add_overlay(sig1, 3.11, 11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Blues"
mayavi.mlab.view(azimuth=90, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJ_rh_projfrac05_frontalpole.png", size=None, figure=None, magnification='auto')

################### occipital pole #####################
brain = Brain("fsaverage", "lh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_TPROJ_lh_projfrac05.mgz"
brain.add_overlay(overlay_file, min=3.11, max=11, sign="pos")
mayavi.mlab.view(azimuth=270, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_TPROJ_lh_projfrac05_occipitalpole.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "rh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_TPROJ_rh_projfrac05.mgz"
brain.add_overlay(overlay_file, min=3.11, max=11, sign="pos")
mayavi.mlab.view(azimuth=270, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_TPROJ_rh_projfrac05_occipitalpole.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "lh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SPROJ_lh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
brain.add_overlay(sig1, 3.11, 11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Blues"
mayavi.mlab.view(azimuth=270, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJ_lh_projfrac05_occipitalpole.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "rh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SPROJ_rh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
brain.add_overlay(sig1, 3.11, 11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Blues"
mayavi.mlab.view(azimuth=270, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJ_rh_projfrac05_occipitalpole.png", size=None, figure=None, magnification='auto')

################### internal face - conjunction #####################
import os.path as op
import numpy as np
from surfer import io
from surfer import Brain

brain = Brain("fsaverage", "rh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
sig1 = io.read_scalar_data('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SPROJ_rh_projfrac05.mgz')
sig2 = io.read_scalar_data('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_TPROJ_rh_projfrac05.mgz')

thresh = 3.11
sig1[sig1 < thresh] = 0
sig2[sig2 < thresh] = 0
conjunct = np.min(np.vstack((sig1, sig2)), axis=0)
brain.add_overlay(sig1, thresh, 11, name="sig1")
brain.overlays["sig1"].pos_bar.lut_mode = "Blues"
brain.overlays["sig1"].pos_bar.visible = False
brain.add_overlay(sig2, thresh, 11, name="sig2")
brain.overlays["sig2"].pos_bar.lut_mode = "Reds"
brain.overlays["sig2"].pos_bar.visible = False
brain.add_overlay(conjunct, thresh, 11, name="conjunct")
brain.overlays["conjunct"].pos_bar.lut_mode = "Purples"
brain.overlays["conjunct"].pos_bar.visible = False

mayavi.mlab.view(azimuth=45, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJ_overlay_TPROJ_rh_projfrac05_externalface.png", size=None, figure=None, magnification='auto')

mayavi.mlab.view(azimuth=315, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJ_overlay_TPROJ_rh_projfrac05_internalface.png", size=None, figure=None, magnification='auto')

mayavi.mlab.view(azimuth=225, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJ_overlay_TPROJ_rh_projfrac05_frontalpole.png", size=None, figure=None, magnification='auto')


brain = Brain("fsaverage", "lh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
sig1 = io.read_scalar_data('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SPROJ_lh_projfrac05.mgz')
sig2 = io.read_scalar_data('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_TPROJ_lh_projfrac05.mgz')

thresh = 3.11
sig1[sig1 < thresh] = 0
sig2[sig2 < thresh] = 0
conjunct = np.min(np.vstack((sig1, sig2)), axis=0)
brain.add_overlay(sig1, thresh, 11, name="sig1")
brain.overlays["sig1"].pos_bar.lut_mode = "Blues"
brain.overlays["sig1"].pos_bar.visible = False
brain.add_overlay(sig2, thresh, 11, name="sig2")
brain.overlays["sig2"].pos_bar.lut_mode = "Reds"
brain.overlays["sig2"].pos_bar.visible = False
brain.add_overlay(conjunct, thresh, 11, name="conjunct")
brain.overlays["conjunct"].pos_bar.lut_mode = "Purples"
brain.overlays["conjunct"].pos_bar.visible = False

mayavi.mlab.view(azimuth=45, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJ_overlay_TPROJ_lh_projfrac05_externalface.png", size=None, figure=None, magnification='auto')

mayavi.mlab.view(azimuth=225, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJ_overlay_TPROJ_lh_projfrac05_frontalpole.png", size=None, figure=None, magnification='auto')

mayavi.mlab.view(azimuth=315, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJ_overlay_TPROJ_lh_projfrac05_internalface.png", size=None, figure=None, magnification='auto')

mayavi.mlab.view(azimuth=135, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJ_overlay_TPROJ_lh_projfrac05_internalface.png", size=None, figure=None, magnification='auto')

#######################################################################
#######################################################################
brain = Brain("fsaverage", "rh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_CTRL-SJTJ_rh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
sig[sig < 3.11] = 0
brain.add_overlay(sig, 3.11, 11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Greens"
mayavi.mlab.view(azimuth=45, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_CTRL-SJTJ_rh_projfrac05_45.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "lh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_CTRL-SJTJ_lh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
sig[sig < 3.11] = 0
brain.add_overlay(sig, 3.11, 11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Greens"
mayavi.mlab.view(azimuth=45, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_CTRL-SJTJ_lh_projfrac05_45.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "rh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_CTRL-SJTJ_rh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
sig[sig < 3.11] = 0
brain.add_overlay(sig, 3.11, 11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Greens"
mayavi.mlab.view(azimuth=135, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_CTRL-SJTJ_rh_projfrac05_135.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "lh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_CTRL-SJTJ_lh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
sig[sig < 3.11] = 0
brain.add_overlay(sig, 3.11, 11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Greens"
mayavi.mlab.view(azimuth=135, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_CTRL-SJTJ_lh_projfrac05_135.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "rh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_CTRL-SJTJ_rh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
sig[sig < 3.11] = 0
brain.add_overlay(sig, 3.11, 11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Greens"
mayavi.mlab.view(azimuth=225, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_CTRL-SJTJ_rh_projfrac05_225.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "lh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_CTRL-SJTJ_lh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
sig[sig < 3.11] = 0
brain.add_overlay(sig, 3.11, 11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Greens"
mayavi.mlab.view(azimuth=225, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_CTRL-SJTJ_lh_projfrac05_225.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "rh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_CTRL-SJTJ_rh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
sig[sig < 3.11] = 0
brain.add_overlay(sig, 3.11, 11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Greens"
mayavi.mlab.view(azimuth=315, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_CTRL-SJTJ_rh_projfrac05_315.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "lh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_CTRL-SJTJ_lh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
sig[sig < 3.11] = 0
brain.add_overlay(sig, 3.11, 11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Greens"
mayavi.mlab.view(azimuth=315, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_CTRL-SJTJ_lh_projfrac05_315.png", size=None, figure=None, magnification='auto')

#######################################################################
#######################################################################
brain = Brain("fsaverage", "rh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SPROJspec_rh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
sig[sig < 3.11] = 0
brain.add_overlay(sig, 3.11, 11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Blues"
mayavi.mlab.view(azimuth=45, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJspec_rh_projfrac05_45.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "lh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SPROJspec_lh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
sig[sig < 3.11] = 0
brain.add_overlay(sig, 3.11, 11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Blues"
mayavi.mlab.view(azimuth=45, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJspec_lh_projfrac05_45.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "rh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SPROJspec_rh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
sig[sig < 3.11] = 0
brain.add_overlay(sig, 3.11, 11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Blues"
mayavi.mlab.view(azimuth=135, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJspec_rh_projfrac05_135.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "lh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SPROJspec_lh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
sig[sig < 3.11] = 0
brain.add_overlay(sig, 3.11, 11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Blues"
mayavi.mlab.view(azimuth=135, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJspec_lh_projfrac05_135.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "rh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SPROJspec_rh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
sig[sig < 3.11] = 0
brain.add_overlay(sig, 3.11, 11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Blues"
mayavi.mlab.view(azimuth=225, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJspec_rh_projfrac05_225.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "lh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SPROJspec_lh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
sig[sig < 3.11] = 0
brain.add_overlay(sig, 3.11, 11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Blues"
mayavi.mlab.view(azimuth=225, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJspec_lh_projfrac05_225.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "rh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SPROJspec_rh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
sig[sig < 3.11] = 0
brain.add_overlay(sig, 3.11, 11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Blues"
mayavi.mlab.view(azimuth=315, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJspec_rh_projfrac05_315.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "lh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SPROJspec_lh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
sig[sig < 3.11] = 0
brain.add_overlay(sig, 3.11, 11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Blues"
mayavi.mlab.view(azimuth=315, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SPROJspec_lh_projfrac05_315.png", size=None, figure=None, magnification='auto')

#######################################################################
#######################################################################
brain = Brain("fsaverage", "rh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_TJ-REST_rh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
sig[sig < 3.96] = 0
brain.add_overlay(sig, 3.96, 11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Reds"
mayavi.mlab.view(azimuth=45, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_TJ-REST_rh_projfrac05_45.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "lh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_TJ-REST_lh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
sig[sig < 3.96] = 0
brain.add_overlay(sig, 3.96, 11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Reds"
mayavi.mlab.view(azimuth=45, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_TJ-REST_lh_projfrac05_45.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "rh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_TJ-REST_rh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
sig[sig < 3.96] = 0
brain.add_overlay(sig, 3.96, 11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Reds"
mayavi.mlab.view(azimuth=135, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_TJ-REST_rh_projfrac05_135.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "lh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_TJ-REST_lh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
sig[sig < 3.96] = 0
brain.add_overlay(sig, 3.96, 11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Reds"
mayavi.mlab.view(azimuth=135, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_TJ-REST_lh_projfrac05_135.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "rh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_STJ-REST_rh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
sig[sig < 3.96] = 0
brain.add_overlay(sig, 3.96, 11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Reds"
mayavi.mlab.view(azimuth=225, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_TJ-REST_rh_projfrac05_225.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "lh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_TJ-REST_lh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
sig[sig < 3.96] = 0
brain.add_overlay(sig, 3.96, 11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Reds"
mayavi.mlab.view(azimuth=225, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_TJ-REST_lh_projfrac05_225.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "rh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_TJ-REST_rh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
sig[sig < 3.96] = 0
brain.add_overlay(sig, 3.96, 11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Reds"
mayavi.mlab.view(azimuth=315, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_TJ-REST_rh_projfrac05_315.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "lh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_TJ-REST_lh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
sig[sig < 3.96] = 0
brain.add_overlay(sig, 3.96, 11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Reds"
mayavi.mlab.view(azimuth=315, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_TJ-REST_lh_projfrac05_315.png", size=None, figure=None, magnification='auto')

#######################################################################
#######################################################################
brain = Brain("fsaverage", "rh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SJ-REST_rh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
sig[sig < 3.96] = 0
brain.add_overlay(sig, 3.96, 11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Blues"
mayavi.mlab.view(azimuth=45, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SJ-REST_rh_projfrac05_45.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "lh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SJ-REST_lh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
sig[sig < 3.96] = 0
brain.add_overlay(sig, 3.96, 11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Blues"
mayavi.mlab.view(azimuth=45, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SJ-REST_lh_projfrac05_45.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "rh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SJ-REST_rh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
sig[sig < 3.96] = 0
brain.add_overlay(sig, 3.96, 11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Blues"
mayavi.mlab.view(azimuth=135, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SJ-REST_rh_projfrac05_135.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "lh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SJ-REST_lh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
sig[sig < 3.96] = 0
brain.add_overlay(sig, 3.96, 11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode =  "Blues"
mayavi.mlab.view(azimuth=135, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SJ-REST_lh_projfrac05_135.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "rh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SJ-REST_rh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
sig[sig < 3.96] = 0
brain.add_overlay(sig, 3.96, 11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Blues"
mayavi.mlab.view(azimuth=225, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SJ-REST_rh_projfrac05_225.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "lh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SJ-REST_lh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
sig[sig < 3.96] = 0
brain.add_overlay(sig, 3.96, 11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Blues"
mayavi.mlab.view(azimuth=225, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SJ-REST_lh_projfrac05_225.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "rh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SJ-REST_rh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
sig[sig < 3.96] = 0
brain.add_overlay(sig, 3.96, 11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Blues"
mayavi.mlab.view(azimuth=315, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SJ-REST_rh_projfrac05_315.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "lh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_SJ-REST_lh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
sig[sig < 3.96] = 0
brain.add_overlay(sig, 3.96, 11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Blues"
mayavi.mlab.view(azimuth=315, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_SJ-REST_lh_projfrac05_315.png", size=None, figure=None, magnification='auto')

#######################################################################
#######################################################################
brain = Brain("fsaverage", "rh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_CTRL-REST_rh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
sig[sig < 3.96] = 0
brain.add_overlay(sig, 3.96, 11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Greens"
mayavi.mlab.view(azimuth=45, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_CTRL-REST_rh_projfrac05_45.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "lh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_CTRL-REST_lh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
sig[sig < 3.96] = 0
brain.add_overlay(sig, 3.96, 11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Greens"
mayavi.mlab.view(azimuth=45, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_CTRL-REST_lh_projfrac05_45.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "rh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_CTRL-REST_rh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
sig[sig < 3.96] = 0
brain.add_overlay(sig, 3.96, 11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Greens"
mayavi.mlab.view(azimuth=135, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_CTRL-REST_rh_projfrac05_135.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "lh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_CTRL-REST_lh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
sig[sig < 3.96] = 0
brain.add_overlay(sig, 3.96, 11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode =  "Greens"
mayavi.mlab.view(azimuth=135, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_CTRL-REST_lh_projfrac05_135.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "rh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_STJ-REST_rh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
sig[sig < 3.96] = 0
brain.add_overlay(sig, 3.96, 11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Greens"
mayavi.mlab.view(azimuth=225, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_CTRL-REST_rh_projfrac05_225.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "lh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_CTRL-REST_lh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
sig[sig < 3.96] = 0
brain.add_overlay(sig, 3.96, 11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Greens"
mayavi.mlab.view(azimuth=225, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_CTRL-REST_lh_projfrac05_225.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "rh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_CTRL-REST_rh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
sig[sig < 3.96] = 0
brain.add_overlay(sig, 3.96, 11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Greens"
mayavi.mlab.view(azimuth=315, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_CTRL-REST_rh_projfrac05_315.png", size=None, figure=None, magnification='auto')

brain = Brain("fsaverage", "lh", "inflated", config_opts={"cortex":"low_contrast","background":"black"})
overlay_file = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/fMRI/GROUPlvl_CTRL-REST_lh_projfrac05.mgz"
sig = io.read_scalar_data(overlay_file)
sig[sig < 3.96] = 0
brain.add_overlay(sig, 3.96, 11, name="sig")
brain.overlays['sig'].pos_bar.lut_mode = "Greens"
mayavi.mlab.view(azimuth=315, elevation=None, distance=None, focalpoint=None,
     roll=None, reset_roll=True, figure=None)
mayavi.mlab.savefig("/neurospin/unicog/protocols/IRMf/BENOIT_MT/BAPTISTE_FOLDER/PICTURES/MOD30-2/GROUPlvl_CTRL-REST_lh_projfrac05_315.png", size=None, figure=None, magnification='auto')






