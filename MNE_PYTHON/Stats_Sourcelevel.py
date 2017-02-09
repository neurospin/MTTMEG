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

from scipy import stats as stats
from mne.stats import f_threshold_mway_rm, f_mway_rm
from mne import  grade_to_tris
from mne.stats import summarize_clusters_stc

###############################################################################
def grouplevel_Ttest2(ListSubj,condition,method,mod,twin,clust_p):
    
    wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG"
        
    # load a specific STC morphed on fsaverage to get shape info
    stc0_path = (wdir + '/' + ListSubj[0] + '/mne_python/STCS/IcaCorr_' + mod + 
               '_' + ListSubj[0] + '_' + condition[0] + '_pick_oriNone_' + 
                method + '_ico-5-fwd-fsaverage.fif-rh.stc')
    stc0      = mne.read_source_estimate(stc0_path)
    ncond     = len(condition)
    nsub      = len(ListSubj)
    ntimes    = len(stc0.times)    
    nvertices = stc0.data.shape[0]        
            
    # average individual STCs morphed on fsaverage for each cond
    AVG_STC_cond  = np.empty([nvertices, ntimes,  nsub, ncond])
    for s,subj in enumerate(ListSubj):
#        multfact = 0
#        for c,cond in enumerate(condition):
#            stc_path = (wdir + '/' + subj + '/mne_python/STCS/IcaCorr_' + modality +
#                        '_' + subj + '_' + cond + '_pick_oriNone_' + 
#                        method + '_ico-5-fwd-fsaverage.fif-rh.stc')
#            stc = mne.read_source_estimate(stc_path) 
#            multfact = multfact  + np.mean(np.mean(stc.data))
            
        for c,cond in enumerate(condition):
            stc_path = (wdir + '/' + subj + '/mne_python/STCS/IcaCorr_' + modality +
                        '_' + subj + '_' + cond + '_pick_oriNone_' + 
                        method + '_ico-5-fwd-fsaverage.fif-rh.stc')
            stc = mne.read_source_estimate(stc_path)     
#            AVG_STC_cond[:,:,s,c] = stc.data/(multfact/2)  
            AVG_STC_cond[:,:,s,c] = stc.data
    # Compute statistic
    np.random.seed(42)
    
    # compute subject-by-subject mean difference            
    X = AVG_STC_cond[:,:,:,1] - AVG_STC_cond[:,:,:,0]
    
    # smooth the data (optional)
    #fsave_vertices = [np.arange(10242), np.arange(10242)]
    #morph_mat = compute_morph_matrix('sample', 'fsaverage', sample_vertices,
    #                                 fsave_vertices, 20, subjects_dir)
    #n_vertices_fsave = morph_mat.shape[0]

    # optional: restrict computation to temporal window of interest
    lower_bound = np.where(stc0.times >= twin[0])[0][0]
    upper_bound = np.where(stc0.times >= twin[1])[0][0]
    X = X[:,lower_bound:upper_bound,:]
    
    con = mne.spatial_tris_connectivity(grade_to_tris(5))
    X = np.transpose(X, [2, 1, 0])
    	
    p_threshold = clust_p
    t_threshold = -stats.distributions.t.ppf(p_threshold / 2., nsub -1)
    n_permutations = 1024
    
    T_obs, clusters, cluster_p_values, H0  = mne.stats.spatio_temporal_cluster_1samp_test(X, connectivity=con, n_jobs=40,
    	                                       threshold=t_threshold, n_permutations=n_permutations, verbose=True)                                       
    
    return T_obs, clusters, cluster_p_values, H0,stc0  
    
###############################################################################
def grouplevel_stats(ListSubj,condition,method,mod,twin,clust_p):
    
    wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG"
        
    # load a specific STC morphed on fsaverage to get shape info
    stc0_path = (wdir + '/' + ListSubj[0] + '/mne_python/STCS/IcaCorr_' + mod + 
               '_' + ListSubj[0] + '_' + condition[0] + '_pick_oriNone_' + 
                method + '_ico-5-fwd-fsaverage.fif-rh.stc')
    stc0      = mne.read_source_estimate(stc0_path)
    stc0.crop(-0.2,5)
    ncond     = len(condition)
    nsub      = len(ListSubj)
    ntimes    = len(stc0.times)    
    nvertices = stc0.data.shape[0]        
            
    # average individual STCs morphed on fsaverage for each cond
    AVG_STC_cond  = np.empty([nvertices, ntimes,  nsub, ncond])
    
    for s,subj in enumerate(ListSubj):            
        for c,cond in enumerate(condition):
            stc_path = (wdir + '/' + subj + '/mne_python/STCS/IcaCorr_' + modality +
                        '_' + subj + '_' + cond + '_pick_oriNone_' + 
                        method + '_ico-5-fwd-fsaverage.fif-rh.stc')
            stc = mne.read_source_estimate(stc_path) 
            stc0.crop(-0.2,5)
            AVG_STC_cond[:,:,s,c] = stc.data

    # optional: restrict computation to temporal window of interest
    lower_bound = np.where(stc0.times >= twin[0])[0][0]
    upper_bound = np.where(stc0.times >= twin[1])[0][0]
    
    con = mne.spatial_tris_connectivity(grade_to_tris(5))
    # array of shapes (obs, time, vertices)
    X = []
    for c,cond in enumerate(condition):
        X.append(np.transpose(AVG_STC_cond[:,lower_bound: upper_bound,:,c], [2, 1, 0]))
    	
    effects = 'A'
    factor_levels = [3]
   
    # get f-values only.
    def mystat_fun(*args):
        return f_mway_rm(np.swapaxes(args, 1, 0), factor_levels=factor_levels,
                     effects=effects, return_pvals=False)[0]

    p_threshold = clust_p
    f_threshold = mne.stats.f_threshold_mway_rm(nsub,factor_levels = factor_levels, effects = effects,pvalue= p_threshold)

    T_obs, clu, clu_p_val, H0  = mne.stats.spatio_temporal_cluster_test(X, threshold=f_threshold,stat_fun=mystat_fun,
                                                                        connectivity=con, n_jobs=1,
                                                                        verbose=True, seed = 666)                                       
    
    return T_obs, clu, clu_p_val, H0,stc0      

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
            stc_path = (wdir + '/' + subj + '/mne_python/STCS/IcaCorr_' + modality +
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
    f_threshold = mne.stats.f_threshold_mway_rm(nsub,factor_levels = factor_levels, effects = effects,pvalue= p_threshold)
    
    T_obs, clu, clu_p_val, H0  = mne.stats.permutation_cluster_test(X, threshold=f_threshold,stat_fun=mystat_fun,
                                                                        connectivity=con, n_jobs=8,
                                                                    verbose=True, seed = 666)                                       
    
    return T_obs, clu, clu_p_val, H0,stc0   
    
###############################################################################
def grouplevel_spatial_linreg(ListSubj,condition,method,mod,twin,clust_p):
    
    wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG"
        
    # load a specific STC morphed on fsaverage to get shape info
    stc0_path = (wdir + '/' + ListSubj[0] + '/mne_python/STCS/IcaCorr_' + mod + 
               '_' + ListSubj[0] + '_' + condition[0] + '_pick_oriNone_' + 
                method + '_ico-5-fwd-fsaverage.fif-rh.stc')
    stc0      = mne.read_source_estimate(stc0_path)
    ncond     = len(condition)
    nsub      = len(ListSubj)
    ntimes    = len(stc0.times)    
    nvertices = stc0.data.shape[0]        
            
    # average individual STCs morphed on fsaverage for each cond
    AVG_STC_cond  = np.empty([nvertices, ntimes,  nsub, ncond])
    
    for s,subj in enumerate(ListSubj):            
        for c,cond in enumerate(condition):
            stc_path = (wdir + '/' + subj + '/mne_python/STCS/IcaCorr_' + modality +
                        '_' + subj + '_' + cond + '_pick_oriNone_' + 
                        method + '_ico-5-fwd-fsaverage.fif-rh.stc')
            stc = mne.read_source_estimate(stc_path)     
            AVG_STC_cond[:,:,s,c] = stc.data

    # optional: restrict computation to temporal window of interest
    lower_bound = np.where(stc0.times >= twin[0])[0][0]
    upper_bound = np.where(stc0.times >= twin[1])[0][0]
    
    con = mne.spatial_tris_connectivity(grade_to_tris(5))
    
    # array of shapes (obs, time, vertices)
    X, Xpred = [], []
    for c,cond in enumerate(condition):
        X.append(np.mean(np.transpose(AVG_STC_cond[:,lower_bound: upper_bound,:,c], [2, 1, 0]),1))
        Xpred.append(np.ones((nsub,nvertices))*(c+1))
        
    X     = np.array(X) 
    Xpred = np.array(Xpred) 
    
    Reg = np.zeros((nsub,nvertices))
    # lienar regression per vertex
    for s in range(nsub):
        for v in range(nvertices):
            tmp = stats.linregress(X[:,s,v],Xpred[:,s,v])   
            Reg[s,v] = tmp.slope
     
    if clust_p == None:	
        T_obs, clu, clu_p_val, H0  = mne.stats.permutation_cluster_1samp_test(Reg, None,
                                                                        connectivity=con, n_jobs=8,
                                                                        verbose=True, seed = 666)
    else:
        p_threshold = clust_p
        t_threshold = -stats.distributions.t.ppf(p_threshold / 2., nsub -1)
        T_obs, clu, clu_p_val, H0  = mne.stats.permutation_cluster_1samp_test(Reg, threshold=t_threshold,
                                                                              connectivity=con, n_jobs=8,
                                                                              verbose=True, seed = 666)                                       
     
    return T_obs, clu, clu_p_val, H0,stc0      

###############################################################################    
ListSubj   = ('sd130343', 'cb130477', 'rb130313', 'jm100042', 
            'jm100109', 'sb120316', 'tk130502', 'lm130479', 
            'ms130534', 'ma100253', 'sl130503', 'mb140004',
            'mp140019', 'dm130250', 'hr130504', 'wl130316',
            'rl130571','sg120518','mm130405')
condition  = ('RefPast','RefPre','RefFut')   
modality   = 'MEG'
method     = 'dSPM'
clust_p    = 0.05
twin = (1.606,1.829)

Clu = []
for i,p in enumerate(clust_p):
    T_obs, clu, clu_p_val, H0,stc   = [], [], [], [], []
    T_obs, clu, clu_p_val, H0,stc   = grouplevel_stats(ListSubj,Conditions,
                                                        method, modality, twin, p)
    Clu.append([T_obs, clu, clu_p_val, H0,stc])
                                                        
good_cluster_inds = np.where(Clu[0][-3] < 0.05)
good_cluster_inds = np.where(clu_p_val < 0.05)
################################################################################
ListSubj   = ('sd130343', 'cb130477', 'rb130313', 'jm100042', 
            'jm100109', 'sb120316', 'tk130502', 'lm130479', 
            'ms130534', 'ma100253', 'sl130503', 'mb140004',
            'mp140019', 'dm130250', 'hr130504', 'wl130316',
            'rl130571')
Conditions = ('RefPast','RefPre','RefFut')  
Conditions = ('EsWest','EsPar','EsEast')     
#Conditions = ('QsWest','QsPar','QsEast')    
modality   = 'MEEG'
method     = 'dSPM'
clust_p    = (0.05,)
twin = (4.008,4.138)

Clu = []
for i,p in enumerate(clust_p):
    T_obs, clu, clu_p_val, H0,stc   = [], [], [], [], []
    T_obs, clu, clu_p_val, H0,stc   = grouplevel_spatial_stats(ListSubj,Conditions,
                                                        method, modality, twin, p)
    Clu.append([T_obs, clu, clu_p_val, H0,stc])

#############
Clu = []
for i,p in enumerate(clust_p):
    T_obs, clu, clu_p_val, H0,stc   = [], [], [], [], []
    T_obs, clu, clu_p_val, H0,stc   = grouplevel_spatial_linreg(ListSubj,Conditions,
                                                        method, modality, twin, p)
    Clu.append([T_obs, clu, clu_p_val, H0,stc])

###############
#clu = T_obs, clu, clu_p_val, H0 
good_cluster_inds = np.where(Clu[0].clu_p_val < 0.05)[0]

tmp = Clu[0][0]
tmp = tmp[:,np.newaxis]
fsave_vertices = [np.arange(stc.shape[0]/2), np.arange(stc.shape[0]/2)]
stc_Ftest = mne.SourceEstimate(tmp,fsave_vertices,0,stc.tstep) 
stc_Ftest.save('/home/bgauthie/test_F_Map_ESSPROJ')

###############################################################################
if good_cluster_inds.any():    

    #    Now let's build a convenient representation of each cluster, where each
    #    cluster becomes a "time point" in the SourceEstimate
    stc_all_cluster_vis = summarize_clusters_stc(clu,p_thresh=0.05, tstep=stc.tstep,
                                                 vertices=stc.vertices,
                                                 subject='fsaverage')
    stc_all_cluster_vis.save('/home/bgauthie/test')

    #    Let's actually plot the first "time point" in the SourceEstimate, which
    #    shows all the clusters, weighted by duration
    subjects_dir = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/mri'
    hemi = 'lh'
    brain = stc_all_cluster_vis.plot(hemi=hemi, subjects_dir=subjects_dir,
                                         time_label='Duration significant (ms)',smoothing_steps=5)
        
       

