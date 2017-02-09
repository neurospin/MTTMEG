# -*- coding: utf-8 -*-
"""
Created on Mon Nov  9 10:41:07 2015

@author: bgauthie
"""

from matplotlib import pyplot as plt
from matplotlib.font_manager import FontProperties
import numpy as np
import os

####################################################################
# define parameters
subjects_dir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG"
path_script  = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS/MNE_PYTHON"

ListSubj = (
	  'sd130343','cb130477', 'rb130313', 'jm100109', 
        'sb120316', 'tk130502','lm130479', 'ms130534', 
        'ma100253', 'sl130503', 'mb140004','mp140019', 
        'dm130250', 'hr130504', 'wl130316', 'rl130571')

DataSource = (
        ('QTT','QTS'),
        ('EVT','EVS'),
        ('EVS','EVS','EVS'),
        ('EVT','EVT','EVT'),
        ('EVT','EVT'),
        ('EVS','EVS'),      
        ('QTT','QTT','QTT'),
        ('QTS','QTS','QTS'),
        ('EVT','EVT','EVT'),
        ('EVS','EVS','EVS')) 
CondCombs = (
	('EsDsq1G_QRT3','EsDsq2G_QRT3','EsDsq3G_QRT3'),
	('EtDtq1G_QRT3','EtDtq2G_QRT3','EtDtq3G_QRT3'),
	('QtPast','QtPre','QtFut'),
	('QsWest','QsPar','QsEast'),
	('EtPast','EtPre','EtFut'),
	('EsWest','EsPar','EsEast'))

decodmod = ('grad')

Classes = ((1,2,3),
          (1,2,3),
          (1,2,3),
          (1,2,3),
          (1,2,3),
          (1,2,3))

Windows = ((-0.2, 0.),(0., 0.1 ),(0., 0.2),(0., 0.3),(0., 0.4),(0., 0.5 ),
           (0., 0.6),(0., 0.7),(0., 0.8),(0., 0.9),(0., 1.),(0.1, 1.1))
RidgeAlpha = (10000, 1000, 100, 10, 1, 0.1, 0.01, 0.001, 0.0001)

Filt = 0.3
###############################################################################

savedir = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/' +
          'decoding_context_yousra/MVPA_time/ranking')  
for c,condcomb in enumerate(CondCombs): 
    
    CMATALPHA = []
    for a,alpha in enumerate(RidgeAlpha):

        fig1 = plt.figure(1,figsize=(6,12))  
        CMAT2 = []
        for s,subject in enumerate (ListSubj): 
            
            CMAT = []
            for w,window in enumerate(Windows):
                path = (savedir + '/SCORES/source_dSPM_MEG'+ subject + 
                        "_vs_".join([str(cond) for cond in condcomb])
                        + str(alpha) + str(window) + str(Filt) + '.npy')
                
                if os.path.exists(path)     :            
                    CMAT.append(np.load(path))               
                    plt.subplot(len(ListSubj)+2,12,s*len(Windows) + w+1)
                    imgplot = plt.imshow(CMAT[w],interpolation = 'none',cmap = 'Reds')
                    imgplot.set_clim(0.5, 0.65)
                    plt.xticks(range(len(condcomb)),['','',''])
                    plt.yticks(range(len(condcomb)),['','',''])
                    
                else:
                    CMAT.append(np.ones((3,3))*0.5)
                    plt.subplot(len(ListSubj)+2,12,s*len(Windows) + w+1)
                    imgplot = plt.imshow(CMAT[w],interpolation = 'none',cmap = 'Reds')
                   
            CMAT2.append(CMAT)
        CMATALPHA.append(CMAT2)    
        
        for w,window in enumerate(Windows):
            plt.subplot(len(ListSubj)+2,12,(s+2)*len(Windows) + w+1)
            imgplot = plt.imshow(np.mean(CMAT2, axis = 0)[w],interpolation = 'none',cmap = 'Reds')
            imgplot.set_clim(0.5, 0.65)
            plt.xticks(range(len(condcomb)),['','',''])
            plt.yticks(range(len(condcomb)),['','',''])
          
        plt.savefig(savedir + '/PLOTS/source_MEG_dSPM' + "_vs_".join([str(cond) for cond in condcomb]) 
        + str(alpha) + str(Filt) + '.png')
        plt.close()

        
        ##############################################################################
    
    fig1 = plt.figure(1,figsize=(16,12))     
    CMATALPHA2 = np.array(CMATALPHA)    
    CMATALPHA2 = np.mean(CMATALPHA2,axis = 1)
    for a,alpha in enumerate(RidgeAlpha):
        for w,window in enumerate(Windows):
            plt.subplot(len(RidgeAlpha),12,w + 1 + a*12)
            imgplot = plt.imshow(CMATALPHA2[a][w],interpolation = 'none',
                                 cmap = 'Reds')
            imgplot.set_clim(0.5,0.65)
            plt.xticks(range(len(condcomb)),['','',''])
            plt.yticks(range(len(condcomb)),['','',''])
            for i in range(3):
                for j in range(3):
                    if i != j:
                        tmp = []
                        tmp = np.floor((CMATALPHA2[a][w][i][j])*1000)/10
                        font0 = FontProperties()
                        font1 = font0.copy()
                        font1.set_weight('bold')
                        font1.set_size('x-small')
                        plt.text(i,j,tmp,horizontalalignment='center',
                                 verticalalignment='center',
                                 fontproperties=font1)
            #plt.tight_layout()                     
                        

    plt.savefig(savedir + '/PLOTS/Source_MEG_dSPM' + "_vs_".join([str(cond) for cond in condcomb]) +
                'Mean_across_alpha' + str(Filt) + '-30Hz.png')
    plt.close()

    ####################################################################
    fig2 = plt.figure(2,figsize=(4,4)) 
    tmp = []
    tmp = np.floor((CMATALPHA2[a][w])*1000)/10
    imgplot = plt.imshow(tmp,interpolation = 'none',cmap = 'Reds')
    imgplot.set_clim(50, 65)
    plt.title('MEAN')
    plt.xticks(range(len(condcomb)),condcomb)
    plt.xticks(rotation=45)
    plt.yticks(range(len(condcomb)),condcomb)
    plt.yticks(rotation=45)
    plt.colorbar() 
    plt.tight_layout()
    for i in range(3):
        for j in range(3):
            plt.text(i,j,tmp[i][j],horizontalalignment='center',
                     verticalalignment='center')
    
    plt.savefig(savedir + '/' + "_vs_".join([str(cond) for cond in condcomb]) + 'template.png')
    plt.close()


