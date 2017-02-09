# -*- coding: utf-8 -*-
"""
Created on Thu Jul  7 14:33:31 2016

@author: bgauthie
"""

import mne
import numpy as np
#from mne import spatial_tris_connectivity, grade_to_tris

###############################################################################
wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"
mridir = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/mri'
group_stats_dir = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/STATS/'

def prob_map(Listsubj, condition, modality):
    # sum the prob of subject-level p <0.05 uncorr
    X = np.zeros((20484,1))
    for s, subject in enumerate(ListSubj):     
        load_path = (wdir+ subject+'/mne_python/STATS')                                                           
        stc = mne.read_source_estimate((load_path + '/' + modality + '_' + 'BinForProb_'
                                        + "_vs_".join(condition) ))  
        X = X + stc.data
        print(stc.data)   
    tmp = X
    tmp = tmp[:,np.newaxis]
    fsave_vertices = [np.arange(10242), np.arange(10242)]
    stc_Ftest = mne.SourceEstimate(tmp,fsave_vertices,0,stc.tstep) 
    #label = mne.stc_to_label(stc_Ftest, src='fsaverage', smooth=True, connected=False, subjects_dir=mridir)
    #con = mne.spatial_tris_connectivity(grade_to_tris(5))
    
    stc_Ftest.save(group_stats_dir + modality + '_ProbMap_' + "_vs_".join(condition))
    
########################################################################################
###############################################################################
ListSubj   = ('sd130343', 'cb130477', 'rb130313', 'jm100042', 
            'jm100109', 'sb120316', 'tk130502', 'lm130479', 
            'ms130534', 'ma100253', 'sl130503', 'mb140004',
            'mp140019', 'dm130250', 'hr130504', 'wl130316',
            'rl130571','sg120518','mm130405')
            
CondComb   = (('QsWest','QsPar' ),
              ('QsEast','QsPar' ),
              ('QsEast','QsWest'),
              ('EsWest','EsPar' ),
              ('EsEast','EsPar' ),
              ('EsEast','EsWest'),
              ('EtPast','EtPre' ),
              ('EtFut' ,'EtPre' ),
              ('EtFut' ,'EtPast'))

CondComb   = (('RefPast','RefPre','RefFut'),)

modality   = ('MEEG','MEG')

for c, cond in enumerate(CondComb):
    for m, mod in enumerate(modality):
        prob_map(ListSubj, cond, mod)
























