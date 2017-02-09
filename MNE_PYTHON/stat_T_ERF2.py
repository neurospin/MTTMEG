##################################################
##DESCRIPTION##
#The script stat_source_stclustering.py calculate the statistical difference between two conditions in ERF, whole brain. The statistics function comes from the example in MNE martinos website (permutation ttest on source data with spatiotemp clustering).
##################################################
# -*- coding: utf-8 -*-
#########################################################################
import os
import mne
import cmath

import numpy as np
from numpy.random import randn

import pylab as pl
import matplotlib.pyplot as plt

import scipy
from scipy import stats as stats
from scipy import io
from scipy import stats as stats

from copy import deepcopy
from math import sqrt, atan2, pi, floor,exp

from mne import spatial_tris_connectivity, compute_morph_matrix, grade_to_tris, SourceEstimate
from mne.epochs import equalize_epoch_counts
from mne.stats import spatio_temporal_cluster_1samp_test
from mne.minimum_norm import apply_inverse, read_inverse_operator
from mne.datasets import sample
from mne.viz import mne_analyze_colormap
from mne.viz import plot_topo
from mne.minimum_norm import apply_inverse, make_inverse_operator,apply_inverse_epochs
from mne.event import merge_events
from mne.stats import permutation_cluster_test

from mne.minimum_norm import apply_inverse, make_inverse_operator, write_inverse_operator, read_inverse_operator
from joblib import Parallel, delayed, Memory

############################################################################################################
####################################################################
# make dataset with all raw difference in source space and morphed to fsaverage
datapath = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/'
ListSubj= ('sd130343', 'cb130477', 'rb130313', 'jm100109', 'tk130502', 'lm130479', 'ms130534', 'ma100253', 'sl130503', 'mp140019', 'dm130250', 'hr130504', 'wl130316', 'rl130571')

Conds = [['Et_all','Es_all'],]

c = 0

data0 = mne.read_source_estimate(datapath + ListSubj[0] + '/mne_python/MEG_' + ListSubj[0] + '_' + Conds[c][0] + '_pick_oriNone_dSPMinverse_ico-5-fwd-fsaverage.fif-lh.stc')
datadiff  = np.empty([data0.shape[0],data0.shape[1],len(ListSubj)])
datamean1 = np.empty([data0.shape[0],data0.shape[1],len(ListSubj)])
datamean2 = np.empty([data0.shape[0],data0.shape[1],len(ListSubj)])

for i in range(len(ListSubj)):
	data1 = mne.read_source_estimate(datapath + ListSubj[i] + '/mne_python/MEG_' + ListSubj[i] + '_' + Conds[c][0] + '_pick_oriNone_dSPMinverse_ico-5-fwd-fsaverage.fif-lh.stc')
	data2 = mne.read_source_estimate(datapath + ListSubj[i] + '/mne_python/MEG_' + ListSubj[i] + '_' + Conds[c][1] + '_pick_oriNone_dSPMinverse_ico-5-fwd-fsaverage.fif-lh.stc')
	data1vs2 = data1.data - data2.data
	datadiff[::,::,i]  = data1vs2
	datamean1[::,::,i] = data1.data
	datamean2[::,::,i] = data2.data
	#datadiff = np.abs(datadiff)

# save difference
tmp = np.mean(datadiff,axis = 2)
fsave_vertices = [np.arange(data0.shape[0]/2), np.arange(data0.shape[0]/2)]
stc_Diff = mne.SourceEstimate(tmp,fsave_vertices,data0.tmin,data0.tstep) 
stc_Diff.save('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/MEG_group_Diff_' + Conds[c][0] + '_' + Conds[c][1] +'_pick_oriNone_dPSMinverse_ico-5-fwd-fsaverage.fif')

# save mean1
tmp = np.mean(datamean1,axis = 2)
fsave_vertices = [np.arange(data0.shape[0]/2), np.arange(data0.shape[0]/2)]
stc_Diff = mne.SourceEstimate(tmp,fsave_vertices,data0.tmin,data0.tstep) 
stc_Diff.save('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/MEG_group_Mean_' + Conds[c][0] + '_pick_oriNone_dPSMinverse_ico-5-fwd-fsaverage.fif')

# save mean2
tmp = np.mean(datamean2,axis = 2)
fsave_vertices = [np.arange(data0.shape[0]/2), np.arange(data0.shape[0]/2)]
stc_Diff = mne.SourceEstimate(tmp,fsave_vertices,data0.tmin,data0.tstep) 
stc_Diff.save('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/MEG_group_Mean_' + Conds[c][1] + '_pick_oriNone_dPSMinverse_ico-5-fwd-fsaverage.fif')

###############################################################################
# Compute statistic
datadiff_stim  = np.empty([data0.shape[0]/2,data0.shape[1],len(ListSubj)])
datadiff_stim = datadiff[::,::,::]

con = mne.spatial_tris_connectivity(grade_to_tris(5))
datadiff_stim = np.transpose(datadiff_stim, [2, 1, 0])
	
p_threshold = 0.05
t_threshold = -stats.distributions.t.ppf(p_threshold / 2, len(ListSubj)-1)
n_permutations = 1024

T_obs, clusters, cluster_p_values, H0 = mne.stats.spatio_temporal_cluster_1samp_test(datadiff_stim, connectivity=con, n_jobs=4,
	                                       threshold=t_threshold, n_permutations=n_permutations, verbose=True)
	                                       
good_cluster_inds = np.where(cluster_p_values < p_threshold)[0]
	
###############################################################################
# Visualize the clusters
#    Now let's build a convenient representation of each cluster, where each
#    cluster becomes a "time point" in the SourceEstimate
fsave_vertices = [np.arange(data0.shape[0]/2), np.arange(data0.shape[0]/2)]
data = np.zeros((data0.shape[0]/2, data0.shape[1]))
data_summary = np.zeros((data0.shape[0]/2, len(good_cluster_inds) + 1))
for ii, cluster_ind in enumerate(good_cluster_inds):
	data.fill(0)
	v_inds = clusters[cluster_ind][1]
	t_inds = clusters[cluster_ind][0]
	data[v_inds, t_inds] = T_obs[t_inds, v_inds]
	# Store a nice visualization of the cluster by summing across time (in ms)
	data = np.sign(data) * np.logical_not(data == 0) * data1.tstep
	data_summary[:, ii + 1] = 0.25e3 * np.sum(data, axis=1)
		
	# save as stc
for i, cluster_ind in enumerate(good_cluster_inds):
	v_inds = clusters[cluster_ind][1]
	t_inds = clusters[cluster_ind][0]
	data[v_inds, t_inds] = T_obs[t_inds, v_inds]
	
stc_cluster_vis = SourceEstimate(data, fsave_vertices, tmin=dataface.tmin, tstep=dataface.tstep)
stc_cluster_vis.save('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/plots/clusters/test_west_par')

########################################################################################"



# Implement gave variable
erfAAgave[s] = np.mean(erfAA_trial,axis=0)
erfAVgave[s] = np.mean(erfAV_trial,axis=0)
erfVAgave[s] = np.mean(erfVA_trial,axis=0)
erfVVgave[s] = np.mean(erfVV_trial,axis=0)

# Compute statistic between subjects
#threshold = 6.0
T_obs_Aon_inter, clusters_Aon_inter, cluster_p_values_Aon_inter, H0_Aon_inter = \
                permutation_cluster_test([erfAAgave, erfAVgave],
                            n_permutations=1000, threshold=None, tail=1,
                            n_jobs=2)
T_obs_Von_inter, clusters_Von_inter, cluster_p_values_Von_inter, H0_Von_inter = \
                permutation_cluster_test([erfVAgave, erfVVgave],
                            n_permutations=1000, threshold=None, tail=1,
                            n_jobs=2)




