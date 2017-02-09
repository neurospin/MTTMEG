# -*- coding: utf-8 -*-
"""
Created on Fri Jul  8 15:28:05 2016

@author: bgauthie
"""

# -*- coding: utf-8 -*-
"""
Created on Mon Jan 25 15:19:17 2016

@author: bgauthie
"""

###############################################################################
###############################################################################
# stats subfunctions
###############################################################################
import mne
import numpy as np
import os
from scipy import stats

from mne.stats import f_threshold_mway_rm, f_mway_rm
from mne import  grade_to_tris
#from mne.stats import summarize_clusters_stc

###############################################################################   
def grouplevel_spatial_stats(ListSubj,condition,method,mod,twin,clust_p):
    
    wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG"
        
    # load a specific STC morphed on fsaverage to get shape info
    stc0_path = (wdir + '/' + ListSubj[0] + '/mne_python/STCS/IcaCorr_' + mod + 
               '_' + ListSubj[0] + '_' + condition[0] + '_pick_oriNone_' + 
                method + '_ico-5-fwd-fsaverage.fif-rh.stc')
    stc0      = mne.read_source_estimate(stc0_path)
    stc0.crop(-0.2,2.5)
    ncond     = len(condition)
    nsub      = len(ListSubj)
    ntimes    = len(stc0.times)    
    nvertices = stc0.data.shape[0]        
            
    # average individual STCs morphed on fsaverage for each cond
    AVG_STC_cond  = np.empty([nvertices, ntimes,  nsub, ncond])
    
    for s,subj in enumerate(ListSubj):            
        for c,cond in enumerate(condition):
            stc_path = (wdir + '/' + subj + '/mne_python/STCS/IcaCorr_' + mod +
                        '_' + subj + '_' + cond + '_pick_oriNone_' + 
                        method + '_ico-5-fwd-fsaverage.fif-rh.stc')
            stc = mne.read_source_estimate(stc_path) 
            stc.crop(-0.2,2.5)
            AVG_STC_cond[:,:,s,c] = stc.data

    # optional: restrict computation to temporal window of interest
    lower_bound = np.where(stc0.times >= twin[0])[0][0]
    upper_bound = np.where(stc0.times >= twin[1])[0][0]
    
    con = mne.spatial_tris_connectivity(grade_to_tris(5))
    # array of shapes (obs, time, vertices)
    X = []
    for c,cond in enumerate(condition):
        X.append(np.mean(np.transpose(AVG_STC_cond[:,lower_bound: upper_bound,:,c], [2, 1, 0]),1))
 
    effects = 'A'
    factor_levels = [3]
   
    # get f-values only.
    def mystat_fun(*args):
        return f_mway_rm(np.swapaxes(args, 1, 0), factor_levels=factor_levels,
                     effects=effects, return_pvals=False)[0]

    p_threshold = clust_p
    f_threshold = f_threshold_mway_rm(nsub,factor_levels = factor_levels, effects = effects,pvalue= p_threshold)
    
    F_obs, clu, clu_p_val, H0  = mne.stats.permutation_cluster_test(X, threshold=f_threshold,stat_fun=mystat_fun,
                                                                        connectivity=con, n_jobs=1,
                                                                    verbose=True, seed = 666)                                       
    
    wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"
    save_path = (wdir+'GROUP/mne_python/Plot_STATS/' + "_vs_".join(condition))  
    
    if not os.path.exists(save_path):
        os.makedirs(save_path)  
    
    # save cluster stats
    spatial_clust_F = np.array((F_obs, clu, clu_p_val, H0))
    np.save((save_path+'/' + mod + '_' +'cluster_stats_f_'+ "_vs_".join(condition)),
            spatial_clust_F)        
    
    # save F-Map                                                
    tmp = F_obs
    tmp = tmp[:,np.newaxis]
    fsave_vertices = [np.arange(10242), np.arange(10242)]
    stc_Ftest = mne.SourceEstimate(tmp,fsave_vertices,0,stc.tstep) 
    stc_Ftest.save((save_path + '/fmap'  + mod + '_' + "_vs_".join(condition)))
    
    return F_obs, clu, clu_p_val, H0,stc0   
    
###############################################################################    
def grouplevel_spatial_stats_ttest2(ListSubj,condition,method,mod,twin,clust_p):
    
    wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG"
        
    # load a specific STC morphed on fsaverage to get shape info
    stc0_path = (wdir + '/' + ListSubj[0] + '/mne_python/STCS/IcaCorr_' + mod + 
               '_' + ListSubj[0] + '_' + condition[0] + '_pick_oriNone_' + 
                method + '_ico-5-fwd-fsaverage.fif-rh.stc')
    stc0      = mne.read_source_estimate(stc0_path)
    stc0.crop(-0.2,2.5)
    ncond     = len(condition)
    nsub      = len(ListSubj)
    ntimes    = len(stc0.times)    
    nvertices = stc0.data.shape[0]        
            
    # average individual STCs morphed on fsaverage for each cond
    AVG_STC_cond  = np.empty([nvertices, ntimes,  nsub, ncond])
    
    for s,subj in enumerate(ListSubj):            
        for c,cond in enumerate(condition):
            stc_path = (wdir + '/' + subj + '/mne_python/STCS/IcaCorr_' + mod +
                        '_' + subj + '_' + cond + '_pick_oriNone_' + 
                        method + '_ico-5-fwd-fsaverage.fif-rh.stc')
            stc = mne.read_source_estimate(stc_path) 
            stc.crop(-0.2,2.5)
            AVG_STC_cond[:,:,s,c] = stc.data

    # optional: restrict computation to temporal window of interest
    lower_bound = np.where(stc0.times >= twin[0])[0][0]
    upper_bound = np.where(stc0.times >= twin[1])[0][0]
    
    con = mne.spatial_tris_connectivity(grade_to_tris(5))
    # array of shapes (obs, time, vertices)
    X = []
    for c,cond in enumerate(condition):
        X.append(np.mean(np.transpose(AVG_STC_cond[:,lower_bound: upper_bound,:,c], [2, 1, 0]),1))
 
    p_threshold = clust_p
    t_threshold = stats.distributions.t.ppf(1-p_threshold/2,nsub-1)
    
    T_obs, clu, clu_p_val, H0  = mne.stats.permutation_cluster_test(X, threshold=t_threshold,
                                                                        connectivity=con, n_jobs=1,
                                                                        verbose=True, seed = 666)                                      
    
    wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"
    save_path = (wdir+'GROUP/mne_python/Plot_STATS/' + "_vs_".join(condition))  
    
    if not os.path.exists(save_path):
        os.makedirs(save_path)  
    
    # save cluster stats
    spatial_clust_F = np.array((T_obs, clu, clu_p_val, H0))
    np.save((save_path+'/' + mod + '_' +'cluster_stats_t_'+ "_vs_".join(condition)),
            spatial_clust_F)        
    
    # save T-Map                                                
    tmp = T_obs
    tmp = tmp[:,np.newaxis]
    fsave_vertices = [np.arange(10242), np.arange(10242)]
    stc_Ftest = mne.SourceEstimate(tmp,fsave_vertices,0,stc.tstep) 
    stc_Ftest.save((save_path + '/fmap'  + mod + '_' + "_vs_".join(condition)))
    
    return T_obs, clu, clu_p_val, H0,stc0   
        
###############################################################################    
ListSubj   = ('sd130343', 'cb130477', 'rb130313', 'jm100042', 
            'jm100109', 'sb120316', 'tk130502', 'lm130479', 
            'ms130534', 'ma100253', 'sl130503', 'mb140004',
            'mp140019', 'dm130250', 'hr130504', 'wl130316',
            'rl130571','sg120518','mm130405')       

CondComb  = (('EsWest','EsPar','EsEast'),)
modality   = ('MEEG',)
method     = 'dSPM'
clust_p    = 0.05

twin       = ((0.504, 0.993),)

alldata = []
#for p in (0.1,0.025,0.5,0.75,0.01,0.025,0.05,0.075,0.001,0.0025,0.005,0.0075):
for c,cond in enumerate(CondComb):
    for m,mod in enumerate(modality):
        T_obs, clu, clu_p_val, H0,stc   =  grouplevel_spatial_stats(ListSubj,cond,
                                                            method, mod, twin[c], clust_p)
            alldata.append((T_obs, clu, clu_p_val, H0,stc) )                                                
###############################################################################
#if good_cluster_inds.any():    
#
#    #    Now let's build a convenient representation of each cluster, where each
#    #    cluster becomes a "time point" in the SourceEstimate
#    stc_all_cluster_vis = summarize_clusters_stc(clu,p_thresh=0.05, tstep=stc.tstep,
#                                                 vertices=stc.vertices,
#                                                 subject='fsaverage')
#    stc_all_cluster_vis.save('/home/bgauthie/test')
#
#    #    Let's actually plot the first "time point" in the SourceEstimate, which
#    #    shows all the clusters, weighted by duration
#    subjects_dir = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/mri'
#    hemi = 'lh'
#    brain = stc_all_cluster_vis.plot(hemi=hemi, subjects_dir=subjects_dir,
#                                         time_label='Duration significant (ms)',smoothing_steps=5)
#        
#       
#
