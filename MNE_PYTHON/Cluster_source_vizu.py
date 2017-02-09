# -*- coding: utf-8 -*-
"""
Created on Thu Feb  4 11:37:04 2016

@author: bgauthie
"""
import mne
import os
import numpy as np
from mne.stats import summarize_clusters_stc

def plot_clusters(subject,CondComb):

    ###############################################################################
    def load_object(filename):
        import pickle
        with open(filename, 'rb') as output:
            obj = pickle.load(output)
            
        return obj
        
    ###############################################################################
    T_obs, clusters, cluster_p_values, H0   = load_object('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/'
                                              + subject + '/mne_python/CLUST/'+'-'.join([cond for cond in CondComb])
                                              + '/spatio_temporal_cluster_1samp_test') 
    clu = T_obs, clusters, cluster_p_values, H0 
    stc = mne.read_source_estimate('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/'
                                   + subject + '/mne_python/CLUST/'+'-'.join([cond for cond in CondComb])
                                   + '/spatio_temporal_cluster_1samp_test-forplot-lh.stc')
         
    good_cluster_inds = np.where(cluster_p_values < 0.05)[0]        
    
    if good_cluster_inds.any():    
    
        #    Now let's build a convenient representation of each cluster, where each
        #    cluster becomes a "time point" in the SourceEstimate
        stc_all_cluster_vis = summarize_clusters_stc(clu,p_thresh=0.05, tstep=stc.tstep,
                                                     vertices=stc.vertices,
                                                     subject=subject)
    
        #    Let's actually plot the first "time point" in the SourceEstimate, which
        #    shows all the clusters, weighted by duration
        # blue blobs are for condition A < condition B, red for A > B
        subjects_dir = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/mri'
        for hemi in ['lh','rh']:
            brain = stc_all_cluster_vis.plot(hemi=hemi, subjects_dir=subjects_dir,
                                             time_label='Duration significant (ms)',smoothing_steps=5)
            
            PlotDir = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/'+subject+'/mne_python/BrainMaps/SingleSubjStat/'
                       + '-'.join([cond for cond in CondComb]))
            
            if not os.path.exists(PlotDir):
                os.makedirs(PlotDir)          
            
            brain.set_data_time_index(0)
            brain.show_view('lateral')
            brain.save_image((PlotDir+ '/'+ '-'.join([cond for cond in CondComb]) +
                              '_clusters_' +'lateralview' + hemi + '.png'))
            brain.show_view('medial')
            brain.save_image((PlotDir+ '/'+ '-'.join([cond for cond in CondComb]) +
                              '_clusters_' +'medialview' + hemi + '.png'))
        
###############################################################################
ListSubj = (
	   'sd130343','cb130477', 
        'rb130313', 'jm100042','jm100109', 'sb120316', 'tk130502',
        'lm130479', 'ms130534', 'ma100253', 'sl130503', 'mb140004',
        'mp140019', 'dm130250', 'hr130504', 'wl130316', 'rl130571')
        
CondComb = ('EsWest','EsPar')

for s,subject in enumerate(ListSubj):
    plot_clusters(subject,CondComb)            
            
###############################################################################








     
        