##################################################
##DESCRIPTION##
#The script stat_source_stclustering.py calculate the statistical difference between two conditions (Afirst, Vfirst) in ERF, whole brain. The statistics function comes from the example in MNE martinos website (permutation ttest on source data with spatiotemp clustering).
##################################################

# -*- coding: utf-8 -*-

############################ compute inv - evtFARq1 &  evtFARq1 ###############################################
import os
import mne
import cmath
import scipy

import numpy as np
import pylab as pl
import matplotlib.pyplot as plt

from numpy.random import randn
from scipy import stats as stats
from scipy import io
from mne.minimum_norm import apply_inverse, make_inverse_operator,apply_inverse_epochs
from mne.event import merge_events
from mne.viz import plot_topo
from copy import deepcopy
from math import sqrt, atan2, pi, floor,exp
from mne.stats import permutation_cluster_test
from numpy.random import randn
from scipy import stats as stats
	
import mne
from mne import spatial_tris_connectivity, compute_morph_matrix, grade_to_tris, SourceEstimate
from mne.epochs import equalize_epoch_counts
from mne.stats import spatio_temporal_cluster_1samp_test
from mne.minimum_norm import apply_inverse, read_inverse_operator
from mne.datasets import sample
from mne.viz import mne_analyze_colormap
	
from mne.minimum_norm import apply_inverse, make_inverse_operator, write_inverse_operator, read_inverse_operator
from joblib import Parallel, delayed, Memory

############################################################################################################
####################################################################
# make dataset with all raw difference in source space and morphed to fsaverage
datapath = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/'
ListSubj= ('sd130343', 'cb130477', 'rb130313', 'jm100042',  'jm100109', 'sb120316', 'tk130502', 'lm130479','sg120518', 'ms130534',       'ma100253', 'sl130503','mb140004', 'mp140019', 'mm130405', 'dm130250', 'hr130504', 'wl130316', 'rl130571')

datadiff  = np.empty([20484,1301,len(ListSubj)])
datamean1 = np.empty([20484,1301,len(ListSubj)])
datamean2 = np.empty([20484,1301,len(ListSubj)])
for i in range(len(ListSubj)):
	data1 = mne.read_source_estimate(datapath + ListSubj[i] + '/mne_python/'+ ListSubj[i] + '_EtDtq1G_QRT2_dPSMinverse_ico-5-fwd-fsaverage.fif-lh.stc')
	data2 = mne.read_source_estimate(datapath + ListSubj[i] + '/mne_python/'+ ListSubj[i] + '_EtDtq2G_QRT2_dPSMinverse_ico-5-fwd-fsaverage.fif-lh.stc')
	data1vs2 = data1.data - data2.data
	datadiff[::,::,i]  = data1vs2
	datamean1[::,::,i] = data1.data
	datamean2[::,::,i] = data2.data
	#datadiff = np.abs(datadiff)

# save difference
tmp = np.mean(datadiff,axis = 2)
fsave_vertices = [np.arange(10242), np.arange(10242)]
stc_Diff = mne.SourceEstimate(tmp,fsave_vertices, -0.2,0.001) 
stc_Diff.save("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/group_Diff_EtDtq1G_QRT2_EtDtq2G_QRT2_dPSMinverse_ico-5-fwd-fsaverage.fif")

# save mean1
tmp = np.mean(datamean1,axis = 2)
fsave_vertices = [np.arange(10242), np.arange(10242)]
stc_Diff = mne.SourceEstimate(tmp,fsave_vertices, -0.2,0.001) 
stc_Diff.save("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/group_Mean_EtDtq1G_QRT2_dPSMinverse_ico-5-fwd-fsaverage.fif")

# save mean2
tmp = np.mean(datamean2,axis = 2)
fsave_vertices = [np.arange(10242), np.arange(10242)]
stc_Diff = mne.SourceEstimate(tmp,fsave_vertices, -0.2,0.001) 
stc_Diff.save("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/group_Mean_EtDtq2G_QRT2_dPSMinverse_ico-5-fwd-fsaverage.fif")

###############################################################################
# Compute statistic
datadiff_stim  = np.empty([20484,901,len(ListSubj)])
datadiff_stim = datadiff[::,201:1101,:]

con = mne.spatial_tris_connectivity(grade_to_tris(5))
datadiff_stim = np.transpose(datadiff_stim, [2, 1, 0])
	
p_threshold = 0.05
t_threshold = -stats.distributions.t.ppf(p_threshold / 2, len(ListSubj)-1)
n_permutations = 1024

T_obs, clusters, cluster_p_values, H0 = mne.stats.spatio_temporal_cluster_1samp_test(datadiff_stim, connectivity=con, n_jobs=8,
	                                       threshold=t_threshold, n_permutations=n_permutations, verbose=True)
	                                       
good_cluster_inds = np.where(cluster_p_values < p_threshold)[0]
	
###############################################################################
# Visualize the clusters
#    Now let's build a convenient representation of each cluster, where each
#    cluster becomes a "time point" in the SourceEstimate
fsave_vertices = [np.arange(10242), np.arange(10242)]
data = np.zeros((20484, 701))
data_summary = np.zeros((20484, len(good_cluster_inds) + 1))
for ii, cluster_ind in enumerate(good_cluster_inds):
	data.fill(0)
	v_inds = clusters[cluster_ind][1]
	t_inds = clusters[cluster_ind][0]
	data[v_inds, t_inds] = T_obs[t_inds, v_inds]
	# Store a nice visualization of the cluster by summing across time (in ms)
	data = np.sign(data) * np.logical_not(data == 0) * dataface.tstep
	data_summary[:, ii + 1] = 1e3 * np.sum(data, axis=1)
		
	# save as stc
for i, cluster_ind in enumerate(good_cluster_inds):
	v_inds = clusters[cluster_ind][1]
	t_inds = clusters[cluster_ind][0]
	data[v_inds, t_inds] = T_obs[t_inds, v_inds]
	
stc_cluster_vis = SourceEstimate(data, fsave_vertices, tmin=dataface.tmin, tstep=dataface.tstep)
stc_cluster_vis.save('/neurospin/meg/meg_tmp/ResonanceMeg_Baptiste_2009/MEG/inter_subject/processed/STC_face_vs_house_clust')

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




