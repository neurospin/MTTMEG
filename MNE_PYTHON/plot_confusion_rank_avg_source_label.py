# -*- coding: utf-8 -*-
"""
Created on Fri Nov 20 18:23:55 2015

@author: bgauthie
"""

from matplotlib import pyplot as plt
import numpy as np
import os
import mne

####################################################################
# define parameters
subjects_dir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG"
path_script  = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS/MNE_PYTHON"

ListSubj = (
	  'sd130343','cb130477', 'rb130313', 'jm100109', 
        'sb120316', 'tk130502','lm130479', 'ms130534', 
        'ma100253', 'sl130503', 'mb140004','mp140019', 
        'dm130250', 'hr130504', 'wl130316', 'rl130571')

CondCombs = (
	('EsDsq1G_QRT3','EsDsq2G_QRT3','EsDsq3G_QRT3'),
	('EtDtq1G_QRT3','EtDtq2G_QRT3','EtDtq3G_QRT3'))

Windows = ((-0.2, 0.),(0., 0.1 ),(0., 0.2),(0., 0.3),(0., 0.4),(0., 0.5 ),
           (0., 0.6),(0., 0.7),(0., 0.8),(0., 0.9),(0., 1.),(0., 1.1))
RidgeAlpha = (0.001,)
modality = 'MEG'

Filt = 0.3
###############################################################################
# plot accuracy across time function
def plot_accuracy(CMATLABEL3,CMATLABEL3std,label_ind,condcomb,PanelInd):

    plt.figure(figsize=(12,12))  
    for l in range(len(label_ind)):
        
        ax = plt.subplot(4,4,l+1)
        ax.set_xlim([0, 11])
        ax.set_ylim([0.45, 0.65])
        
        plt.axhline(0.5,linestyle = '--',color = (0,0,0),linewidth=2) 
        
        plt.plot(range(12), CMATLABEL3[label_ind[l],:,1,0],linewidth = 2, color = (1,0,0))
        plt.fill_between(range(12), CMATLABEL3[label_ind[l],:,1,0] - 1.96*CMATLABEL3std[label_ind[l],:,1,0], 
                            CMATLABEL3[label_ind[l],:,1,0] + 1.96*CMATLABEL3std[label_ind[l],:,1,0],
                              alpha=0.2, edgecolor=(1,0,0), facecolor=(1,0,0),linewidth=0)
                              
        plt.plot(range(12), CMATLABEL3[label_ind[l],:,2,0],linewidth = 2, color = (0.4,0,0))
        plt.fill_between(range(12), CMATLABEL3[label_ind[l],:,2,0] - 1.96*CMATLABEL3std[label_ind[l],:,2,0], 
                            CMATLABEL3[label_ind[l],:,2,0] + 1.96*CMATLABEL3std[label_ind[l],:,2,0],
                              alpha=0.3, edgecolor=(0.4,0,0), facecolor=(0.4,0,0),linewidth=0)
                              
        plt.plot(range(12), CMATLABEL3[label_ind[l],:,2,1],linewidth = 2, color = (1,0.4,0.4))
        plt.fill_between(range(12), CMATLABEL3[label_ind[l],:,2,1] - 1.96*CMATLABEL3std[label_ind[l],:,2,1], 
                            CMATLABEL3[label_ind[l],:,2,1] + 1.96*CMATLABEL3std[label_ind[l],:,2,1],
                              alpha=0.2, edgecolor=(1,0.4,0.4), facecolor=(1,0.4,0.4),linewidth=0)
                              
        plt.text(0.5,0.63,labels[label_ind[l]].name, fontsize=10,fontweight='bold')
        plt.text(0.5,0.61,'Close vs Far' , fontsize=9,color=(0.4,0,0))  
        plt.text(0.5,0.60,'Close vs Med' , fontsize=9,color=(1,0,0))
        plt.text(0.5,0.59,'Medium vs far', fontsize=9,color=(1,0.4,0.4))  
        plt.ylabel('accuracy +- CI95%',fontsize=9, fontweight='bold') 
        plt.xlabel('0-locked cumulative time',fontsize=9, fontweight='bold')
        
        ax.set_xticks([0,2,4,6,8,10])
        ax.set_xticklabels([-0.2, 0.2, 0.4 ,0.6 ,0.8, 1],fontsize=9) 
        ax.set_yticks([0.50, 0.55, 0.60])
        ax.set_yticklabels([0.50, 0.55, 0.60],fontsize=9)
        #plt.xticks(rotation=50)
        plt.tight_layout()
        
                
    PlotDir = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/decoding_context_yousra/MVPA_time/ranking/' 
    + '_vs_'.join([str(cond) for cond in condcomb]) + '/')  
            
    if not os.path.exists(PlotDir):
        os.makedirs(PlotDir)
        
    plt.savefig(PlotDir + 'Panel' + str(PanelInd) + '_'+  modality)
    plt.close()
        
###############################################################################

subjects_dir = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/mri/'
labels = mne.read_labels_from_annot('sd130343',
                                parc = 'aparc', 
                                hemi = 'both', 
                                subjects_dir = subjects_dir)

savedir = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/' +
          'decoding_context_yousra/MVPA_time/ranking')  
          
for c,condcomb in enumerate(CondCombs): 
    
    CMATLABEL= []
    for l in range(0,68):

        #fig1 = plt.figure(1,figsize=(6,12))  
        CMAT2 = []
        for s,subject in enumerate (ListSubj): 
            
            CMAT = []
            for w,window in enumerate(Windows):
                path = (savedir + '/SCORES/source_dSPM_MEG'+ subject + 
                        "_vs_".join([str(cond) for cond in condcomb])
                        + str(0.001) + str(window) + str(Filt) + str(l) + '.npy')
                
                if os.path.exists(path)     :            
                    CMAT.append(np.load(path))               
                    #plt.subplot(len(ListSubj)+2,12,s*len(Windows) + w+1)
                    #imgplot = plt.imshow(CMAT[w],interpolation = 'none',cmap = 'Reds')
                    #imgplot.set_clim(0.5, 0.65)
                    #plt.xticks(range(len(condcomb)),['','',''])
                    #plt.yticks(range(len(condcomb)),['','',''])
                    
                else:
                    print 'missing data'
                    print path
                    #CMAT.append(np.ones((3,3))*0.5)
                    #plt.subplot(len(ListSubj)+2,12,s*len(Windows) + w+1)
                    #imgplot = plt.imshow(CMAT[w],interpolation = 'none',cmap = 'Reds')
                   
            CMAT2.append(CMAT)
        CMATLABEL.append(CMAT2)    
        
        ##############################################################################
    
    fig1 = plt.figure(1,figsize=(5,12))     
    CMATLABEL2 = np.array(CMATLABEL)    
    CMATLABEL2 = np.mean(CMATLABEL2,axis = 1)
    count = 1
    for l in range(0,20):
        for w,window in enumerate(Windows):
            ax = plt.subplot(20,12, count)
            if w == 0:
                plt.title(labels[l].name,fontsize = 10)
            CMATLABEL2[l][w][0][1] = np.nan
            CMATLABEL2[l][w][0][2] = np.nan
            CMATLABEL2[l][w][1][2] = np.nan
            imgplot = plt.imshow(CMATLABEL2[l][w],interpolation = 'none',
                                 cmap = 'Reds')
            imgplot.set_clim(0.5,0.65)
            ax.xaxis.set_visible(False)
            ax.yaxis.set_visible(False)
            ax.axis('off')
            count = count + 1  
            
    plt.savefig(savedir + '/PLOTS/Source_MEG_dSPM' + "_vs_".join([str(cond) for cond in condcomb]) +
                'Mean_across_labels_part1_acc' + str(Filt) + '-30Hz.png')
    plt.close()              
                        
    fig2 = plt.figure(2,figsize=(5,12))     
    CMATLABEL2 = np.array(CMATLABEL)    
    CMATLABEL2 = np.mean(CMATLABEL2,axis = 1)
    count = 1
    for l in range(0,20):
        for w,window in enumerate(Windows):
            ax = plt.subplot(20,12, count)
            if w == 0:
                plt.title(labels[l+20].name,fontsize = 10)
            CMATLABEL2[l+20][w][0][1] = np.nan
            CMATLABEL2[l+20][w][0][2] = np.nan
            CMATLABEL2[l+20][w][1][2] = np.nan
            imgplot = plt.imshow(CMATLABEL2[l+20][w],interpolation = 'none',
                                 cmap = 'Reds')
            imgplot.set_clim(0.5,0.65)
            ax.xaxis.set_visible(False)
            ax.yaxis.set_visible(False)
            ax.axis('off')
            count = count + 1  
            
    plt.savefig(savedir + '/PLOTS/Source_MEG_dSPM' + "_vs_".join([str(cond) for cond in condcomb]) +
                'Mean_across_labels_part2_acc' + str(Filt) + '-30Hz.png')
    plt.close()               

    fig3 = plt.figure(3,figsize=(5,12))     
    CMATLABEL2 = np.array(CMATLABEL)    
    CMATLABEL2 = np.mean(CMATLABEL2,axis = 1)
    count = 1
    for l in range(0,20):
        for w,window in enumerate(Windows):
            ax = plt.subplot(20,12, count)
            if w == 0:
                plt.title(labels[l+40].name,fontsize = 10)
            CMATLABEL2[l+40][w][0][1] = np.nan
            CMATLABEL2[l+40][w][0][2] = np.nan
            CMATLABEL2[l+40][w][1][2] = np.nan
            imgplot = plt.imshow(CMATLABEL2[l+40][w],interpolation = 'none',
                                 cmap = 'Reds')
            imgplot.set_clim(0.5,0.65)
            ax.xaxis.set_visible(False)
            ax.yaxis.set_visible(False)
            ax.axis('off')
            count = count + 1    
    
    plt.savefig(savedir + '/PLOTS/Source_MEG_dSPM' + "_vs_".join([str(cond) for cond in condcomb]) +
                'Mean_across_labels_part3_acc' + str(Filt) + '-30Hz.png')
    plt.close()           

    fig4 = plt.figure(4,figsize=(5,12))     
    CMATLABEL2 = np.array(CMATLABEL)    
    CMATLABEL2 = np.mean(CMATLABEL2,axis = 1)
    count = 1
    for l in range(0,8):
        for w,window in enumerate(Windows):
            ax = plt.subplot(20,12, count)
            if w == 0:
                plt.title(labels[l+60].name,fontsize = 10)
            CMATLABEL2[l+60][w][0][1] = np.nan
            CMATLABEL2[l+60][w][0][2] = np.nan
            CMATLABEL2[l+60][w][1][2] = np.nan
            imgplot = plt.imshow(CMATLABEL2[l+60][w],interpolation = 'none',
                                 cmap = 'Reds')
            imgplot.set_clim(0.5,0.65)
            ax.xaxis.set_visible(False)
            ax.yaxis.set_visible(False)
            ax.axis('off')
            count = count + 1   
    plt.savefig(savedir + '/PLOTS/Source_MEG_dSPM' + "_vs_".join([str(cond) for cond in condcomb]) +
                'Mean_across_labels_part4_acc' + str(Filt) + '-30Hz.png')
    plt.close()   

    ###########################################################################
   
    CMATLABEL2 = np.array(CMATLABEL)    
    CMATLABEL3 = np.mean(CMATLABEL2,axis = 1)
    CMATLABEL3std = np.std(CMATLABEL2,axis = 1)/np.sqrt(len(ListSubj))
    plot_accuracy(CMATLABEL3,CMATLABEL3std,range(0,16),condcomb,1)
    plot_accuracy(CMATLABEL3,CMATLABEL3std,range(16,32),condcomb,2)
    plot_accuracy(CMATLABEL3,CMATLABEL3std,range(32,48),condcomb,3)
    plot_accuracy(CMATLABEL3,CMATLABEL3std,range(48,64),condcomb,4)
    plot_accuracy(CMATLABEL3,CMATLABEL3std,range(64,68),condcomb,5)

