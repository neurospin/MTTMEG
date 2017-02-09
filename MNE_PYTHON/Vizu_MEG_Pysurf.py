# -*- coding: utf-8 -*-
"""
Created on Fri Jan 22 14:25:17 2016

@author: bgauthie
"""
# do not forget to set envrionement variable
# export SUBJECTS_DIR='/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/mri'
# export QT_API=pyqt

import os
import numpy as np
import mne

#from matplotlib import pyplot as pl
from surfer import Brain
from surfer.io import read_stc

###############################################################################
def plot_overlays_singlesubj(subject,condition,method,modality,hemi,indextime):

    subject_id, surface = 'fsaverage', 'inflated'
    hemi = hemi
    brain = Brain(subject_id, hemi, surface, size=(600, 600))
    stc_fname = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/' 
                 + subject +'/mne_python/STCS/IcaCorr_' + modality + '_' + subject 
                 + '_' + condition + '_pick_oriNone_' + method + '_ico-5-fwd-fsaverage.fif-'+hemi+'.stc')
    stc = read_stc(stc_fname)
    data = stc['data']
    vertices = stc['vertices']
    time = np.linspace(stc['tmin'], stc['tmin'] + data.shape[1] * stc['tstep'],
                       data.shape[1])
    
    colormap = 'hot'
    time_label = lambda t: 'time=%0.2f ms' % (t * 1e3)
    brain.add_data(data, colormap=colormap, vertices=vertices,
                   smoothing_steps=4, time=time, time_label=time_label,
                   hemi=hemi)
    brain.set_data_time_index(indextime)
    brain.scale_data_colormap(fmin=6, fmid=12, fmax=18, transparent=True)
    #brain.show_view(dict(elevation=None, distance=None))
    #    mayavi.mlab.view(azimuth=0, elevation=None, distance=None, focalpoint=None,
    #         roll=None, reset_roll=True, figure=None)

    realtime = stc['tmin'] + stc['tstep']*indextime  
    
    PlotDir = []
    PlotDir = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/' + subject + '/mne_python/BrainMaps/' 
               + condition ) 
    
    if not os.path.exists(PlotDir):
        os.makedirs(PlotDir)

    brain.save_image(PlotDir + '/IcaCorr_' + modality + '_' + method + '_' + subject 
                        + '_' + condition + '_' + str(realtime) +  hemi + '_ico-5-fwd-fsaverage-'
                        +'.png')                      
###############################################################################
###############################################################################
def plot_overlays_diff_singlesubj(subject,condition,method,modality,hemi,indextime, azimuth):

    subject_id, surface = 'fsaverage', 'inflated'
    hemi = hemi
    brain = Brain(subject_id, hemi, surface, size=(600, 600))
    stc_fname = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/' + subject + '/mne_python/STCS_diff/IcaCorr_' 
               + condition[0] + '-' + condition[1] 
               + '/' + modality + '_' + method + '_' + subject 
                        + '_' + condition[0] + '-' + condition[1] 
                        + '_' + '_ico-5-fwd-fsaverage-.stc-'+hemi+'.stc')
    stc = read_stc(stc_fname)
    data = stc['data']
    vertices = stc['vertices']
    time = np.linspace(stc['tmin'], stc['tmin'] + data.shape[1] * stc['tstep'],
                       data.shape[1])
    
    colormap = 'hot'
    time_label = lambda t: 'time=%0.2f ms' % (t * 1e3)
    brain.add_data(data, colormap=colormap, vertices=vertices,
                   smoothing_steps=4, time=time, time_label=time_label,
                   hemi=hemi)
    brain.set_data_time_index(indextime)
    brain.scale_data_colormap(fmin=0, fmid=2.5, fmax=5, transparent=True)
    brain.show_view(dict(azimuth=azimuth,elevation=None, distance=None))
    #    mayavi.mlab.view(azimuth=0, elevation=None, distance=None, focalpoint=None,
    #         roll=None, reset_roll=True, figure=None)

    realtime = stc['tmin'] + stc['tstep']*indextime  
    
    PlotDir = []
    PlotDir = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/' + subject + '/mne_python/BrainMaps/IcaCorr_' +  
               + condition[0] + '-' + condition[1]) 
    
    if not os.path.exists(PlotDir):
        os.makedirs(PlotDir)

    brain.save_image(PlotDir + '/IcaCorr_' + modality + '_' + method + '_' + subject 
                        + '_' + condition[0] + '-' + condition[1] + '_' + str(realtime) +  hemi 
                        + '_'+ str(azimuth)+ '_ico-5-fwd-fsaverage-'
                        +'.png')        
                        
###############################################################################
###############################################################################
def plot_overlays_diff_group(condition,method,modality,hemi,indextime,azimuth):

    hemi = hemi
    brain = Brain(subject_id='fsaverage', hemi=hemi, surface='pial', size=(600, 600))
    stc_fname = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_' 
                 + modality + '_' + condition[0] + '-' + condition[1] + '_pick_oriNone_' + method 
                 + '_ico-5-fwd-fsaverage.stc-'+ hemi +'.stc')
    stc = read_stc(stc_fname)
    data = stc['data']
    vertices = stc['vertices']
    time = np.linspace(stc['tmin'], stc['tmin'] + data.shape[1] * stc['tstep'],
                       data.shape[1])
    
    # colormap = 'seismic'
    colormap = mne.viz.mne_analyze_colormap(limits=[-3,-1.81,-1.80, 1.80,1.81, 3], format='mayavi')
    time_label = lambda t: 'time=%0.2f ms' % (t * 1e3)
    brain.add_data(data, colormap=colormap, vertices=vertices,
                   smoothing_steps=20, time=time, time_label=time_label,
                   hemi=hemi)
    brain.set_data_time_index(indextime)
    brain.scale_data_colormap(fmin=-1.82, fmid=0, fmax= 1.82, transparent=False)
    brain.show_view(dict(azimuth=azimuth,elevation=None, distance=None))
    #    mayavi.mlab.view(azimuth=0, elevation=None, distance=None, focalpoint=None,
    #         roll=None, reset_roll=True, figure=None)

    realtime = stc['tmin'] + stc['tstep']*indextime  
    
    PlotDir = []
    PlotDir = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/Plots/IcaCorr_'  
               + condition[0] + '-' + condition[1] ) 
    
    if not os.path.exists(PlotDir):
        os.makedirs(PlotDir)

    brain.save_image(PlotDir + '/IcaCorr_' + modality + '_' + method + '_'
                        + '_' + condition[0] + '-' + condition[1] + '_' + str(realtime)
                        +  hemi + '_'+ str(azimuth)+ '_ico-5-fwd-fsaverage-'+'.png')                      
 
###############################################################################
###############################################################################
def plot_overlays_diff_group2(condition,method,modality,hemi,indextime,azimuth):

    subject_id, surface = 'fsaverage', 'inflated'
    hemi = hemi
    brain = Brain(subject_id, hemi, surface, size=(600, 600))
    stc_fname = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_Normalized'
                 + modality + '_' + condition[0] + '-' + condition[1] + '_pick_oriNone_' + method 
                 + '_ico-5-fwd-fsaverage.stc-'+ hemi +'.stc')
    stc = read_stc(stc_fname)
    data = stc['data']
    vertices = stc['vertices']
    time = np.linspace(stc['tmin'], stc['tmin'] + data.shape[1] * stc['tstep'],
                       data.shape[1])
    
    colormap = mne.viz.mne_analyze_colormap(limits=[-0.5, -0.325, -0.32, 0.32, 0.325, 0.5], format='mayavi')
    #colormap = 'hot'
    time_label = lambda t: 'time=%0.2f ms' % (t * 1e3)
    brain.add_data(data, colormap=colormap, vertices=vertices,
                   smoothing_steps=15, time=time, time_label=time_label,
                   hemi=hemi)
    brain.set_data_time_index(indextime)
    brain.scale_data_colormap(fmin=-0.34, fmid=0, fmax=0.34, transparent=False)
    brain.show_view(dict(azimuth=azimuth,elevation=None, distance=None))
    #    mayavi.mlab.view(azimuth=0, elevation=None, distance=None, focalpoint=None,
    #         roll=None, reset_roll=True, figure=None)

    realtime = stc['tmin'] + stc['tstep']*indextime  
    
    PlotDir = []
    PlotDir = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/Plots/IcaCorr_'  
               + condition[0] + '-' + condition[1] ) 
    
    if not os.path.exists(PlotDir):
        os.makedirs(PlotDir)

    brain.save_image(PlotDir + '/IcaCorr_' + modality + '_' + method + '_'
                        + '_Normalized' + condition[0] + '-' + condition[1] + '_' + str(realtime)
                        +  hemi + '_'+ str(azimuth)+ '_ico-5-fwd-fsaverage-'+'.png')    
   
###############################################################################
def plot_overlays_diff_group_window(condition,method,modality,hemi,window,azimuth,elevation):

    subject_id, surface = 'fsaverage', 'inflated'
    hemi = hemi
    brain = Brain(subject_id, hemi, surface, size=(600, 600))
    stc_fname = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_Normalized'
                 + modality + '_' + condition[0] + '-' + condition[1] + '_pick_oriNone_' + method 
                 + '_ico-5-fwd-fsaverage.stc-'+ hemi +'.stc')
                 
    stcl_fname = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_Normalized'
                 + modality + '_' + condition[0] + '-' + condition[1] + '_pick_oriNone_' + method 
                 + '_ico-5-fwd-fsaverage.stc-lh.stc')
    stcr_fname = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/BrainMaps/IcaCorr_Normalized'
                 + modality + '_' + condition[0] + '-' + condition[1] + '_pick_oriNone_' + method 
                 + '_ico-5-fwd-fsaverage.stc-rh.stc')    
                 
    stcl  = read_stc(stcl_fname)
    stcr  = read_stc(stcr_fname)
    datal = stcl['data']  
    datar = stcr['data']            
                 
    stc = read_stc(stc_fname)
    data = stc['data']
    vertices = stc['vertices']
    time = np.linspace(stc['tmin'], stc['tmin'] + data.shape[1] * stc['tstep'],
                       data.shape[1])
    winstart = np.where(time < window[0])[0][-1]
    winend   = np.where(time >= window[1])[0][0]
    
    meanval = np.mean(data[:,winstart:winend],1)   
    meanvalr = np.mean(datar[:,winstart:winend],1)   
    meanvall = np.mean(datal[:,winstart:winend],1)  
    maxval = np.max([np.max(meanvalr),np.max(meanvall)])
    minval = np.min([np.min(meanvalr),np.min(meanvall)])
    fmin = -np.max(np.abs([maxval,minval]))*0.8
    fmax = np.max(np.abs([maxval,minval]))*0.8
    
    colormap = mne.viz.mne_analyze_colormap(limits=[fmin, fmin/3, fmin/3.1, fmax/3.1, fmax/3, fmax], format='mayavi')
    #colormap = 'jet'
    
    time_label = lambda t: 'time=%0.2f ms' % (0)
    brain.add_data(meanval, colormap=colormap, vertices=vertices,
                   smoothing_steps=15, time=time, time_label=time_label,
                   hemi=hemi)
    brain.scale_data_colormap(fmin=fmin, fmid=0, fmax=fmax, transparent=False)
    brain.show_view(dict(azimuth=azimuth,elevation=elevation, distance=None))
    #    mayavi.mlab.view(azimuth=0, elevation=None, distance=None, focalpoint=None,
    #         roll=None, reset_roll=True, figure=None)
    
    PlotDir = []
    PlotDir = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/Plots/IcaCorr_Window_'  
               + condition[0] + '-' + condition[1]  + str(window[0]) + '-' + str(window[1])) 
    
    if not os.path.exists(PlotDir):
        os.makedirs(PlotDir)

    brain.save_image(PlotDir + '/IcaCorr_' + modality + '_' + method + '_'
                        + '_Normalized' + condition[0] + '-' + condition[1] + '_'
                        + str(window[0]) + '-' + str(window[1])
                        +  hemi + '_'+ str(azimuth)+ '_ico-5-fwd-fsaverage-'+'.png')       
 
###############################################################################
def combview(condition,window,mod,isnorm):
    
    import Image
    
    cond = (condition[0] + '-' + condition[1])
    ima_dir = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/Plots/IcaCorr_' 
    + 'Window_' + cond +str(window[0])+'-'+str(window[1]))
    # create new template image
    new_im = Image.new('RGB', (1200,820))
    #Iterate through a 4 by 20 grid with 0 spacing, to place my image
        
    # external face
    im = Image.open((ima_dir+'/IcaCorr_' +mod+'_dSPM__'+isnorm+cond+'_'
    +str(window[0])+'-'+str(window[1])+'lh_180_ico-5-fwd-fsaverage-.png'))  
    im = im.crop((0,100,600,550))     
    new_im.paste(im, (0,0))
    im = Image.open((ima_dir+'/IcaCorr_' +mod+'_dSPM__'+isnorm+cond+'_'
    +str(window[0])+'-'+str(window[1])+'rh_0_ico-5-fwd-fsaverage-.png')) 
    im = im.crop((0,100,600,550))         
    new_im.paste(im, (600,0))
    
    # internal face
    im = Image.open((ima_dir+'/IcaCorr_' +mod+'_dSPM__'+isnorm+cond+'_'
    +str(window[0])+'-'+str(window[1])+'lh_0_ico-5-fwd-fsaverage-.png'))    
    im = im.crop((0,100,600,550))      
    new_im.paste(im, (0,420))
    im = Image.open((ima_dir+'/IcaCorr_' +mod+'_dSPM__'+isnorm+cond+'_'
    +str(window[0])+'-'+str(window[1])+'rh_180_ico-5-fwd-fsaverage-.png')) 
    im = im.crop((0,100,600,550))         
    new_im.paste(im, (600,420))
    
    new_im.show()
    new_im.save((ima_dir+'/'+mod+isnorm+'_dSPM__'+cond+'.tiff'))
  
###############################################################################
ListSubj = ('sd130343', 'cb130477', 'rb130313','jm100042', 
	      'jm100109', 'sb120316', 'tk130502', 
	      'lm130479', 'ms130534', 'ma100253',
	      'sl130503', 'mb140004', 'mp140019',
	      'dm130250', 'hr130504', 'wl130316', 
	      'rl130571')
condition = ('Qt_all','Qs_all')
method = 'dSPM'
modality = ('MEEG','MEG')
hemispheres = ('lh','rh')

for mod in modality:
    for subject in ListSubj:
        for hemi in hemispheres:
            for azimuth in (0,180):
                for time in [20,30,40,50,60,70,80,90,100,110,120,130,140,150,160,170,180,190,200,210,220]:
                    plot_overlays_diff_singlesubj(subject,condition,method,mod,hemi,time, azimuth)



CondComb = (
	('Qt_all','Qs_all'),)
#	('Et_all','Es_all'),
#	('EsDsq1G_QRT3','EsDsq3G_QRT3'),
#	('EtDtq1G_QRT3','EtDtq3G_QRT3'),
#	('EtDtq1G_QRT2','EtDtq2G_QRT2'),
#	('EsDsq1G_QRT2','EsDsq2G_QRT2'))
 
CondComb = (('RefFut','RefPre'),)

method = 'dSPM'
modality = ('MEEG','MEG')
hemispheres = ('lh','rh')

for condition in CondComb:
    for mod in modality:
        for hemi in hemispheres:
            for azimuth in (0,180):
                for time in [20,40,60,80,100,120,140,160,180,200,220]:
                    #plot_overlays_diff_group2(condition,method,mod,hemi,time,azimuth)
                    plot_overlays_diff_group(condition,method,mod,hemi,time,azimuth)


for azimuth in (0,180):
    for hemi in ('lh','rh'):
        #plot_overlays_diff_group_window(('EtFut','EtPre'),'dSPM','MEEG',hemi,[1.252, 1.444],azimuth,None)
        #plot_overlays_diff_group_window(('EtPast','EtPre'),'dSPM','MEEG',hemi,[1.252, 1.444],azimuth,None)
        #plot_overlays_diff_group_window(('EtPast','EtPre'),'dSPM','MEEG',hemi,[1.595,1.750],azimuth,None)
        #plot_overlays_diff_group_window(('EtFut','EtPre'),'dSPM','MEEG',hemi,[1.595,1.750],azimuth,None)
        #plot_overlays_diff_group_window(('EtFut','EtPre'),'dSPM','MEEG',hemi,[0.255,0.451],azimuth,None)
        #plot_overlays_diff_group_window(('EtPast','EtPre'),'dSPM','MEEG',hemi,[0.255,0.451],azimuth,None)
        #plot_overlays_diff_group_window(('EtPast','EtPre'),'dSPM','MEEG',hemi,[0.512,0.688],azimuth,None)
        #plot_overlays_diff_group_window(('QsEast','QsPar'),'dSPM','MEEG',hemi,[0.260,0.476],azimuth,None)
        #plot_overlays_diff_group_window(('QsWest','QsPar'),'dSPM','MEEG',hemi,[0.260,0.476],azimuth,None)
        #plot_overlays_diff_group_window(('EsEast','EsPar'),'dSPM','MEEG',hemi,[1, 1.232],azimuth,None)
        #plot_overlays_diff_group_window(('EsWest','EsPar'),'dSPM','MEEG',hemi,[1, 1.232],azimuth,None)
        #plot_overlays_diff_group_window(('EsEast','EsPar'),'dSPM','MEEG',hemi,[1.244, 1.500],azimuth,None)
        #plot_overlays_diff_group_window(('EsWest','EsPar'),'dSPM','MEEG',hemi,[1.244, 1.500],azimuth,None)
        #plot_overlays_diff_group_window(('Qt_all','Qs_all'),'dSPM','MEEG',hemi,[0.404, 0.460],azimuth,None)
        #plot_overlays_diff_group_window(('Qt_all','Qs_all'),'dSPM','MEEG',hemi,[0.650, 0.700],azimuth,None)       
        #plot_overlays_diff_group_window(('Qt_all','Qs_all'),'dSPM','MEEG',hemi,[0.144, 0.270],azimuth,None)
        #plot_overlays_diff_group_window(('Qt_all','Qs_all'),'dSPM','MEEG',hemi,[0.445, 0.632],azimuth,None)
        #plot_overlays_diff_group_window(('Et_all','Es_all'),'dSPM','MEEG',hemi,[0.415, 0.821],azimuth,None)
        #plot_overlays_diff_group_window(('Et_all','Es_all'),'dSPM','MEEG',hemi,[0.308, 0.972],azimuth,None)
        #plot_overlays_diff_group_window(('EtDtq1G_QRT2','EtDtq2G_QRT2'),'dSPM','MEEG',hemi,[0.750, 0.950],azimuth,None)
        #plot_overlays_diff_group_window(('EtDtq1G_QRT2','EtDtq2G_QRT2'),'dSPM','MEEG',hemi,[0.740,0.848 ],azimuth,None)
        #plot_overlays_diff_group_window(('EsDsq1G_QRT2','EsDsq2G_QRT2'),'dSPM','MEEG',hemi,[0.164, 0.260],azimuth,None)
        #plot_overlays_diff_group_window(('EtDtq1G_QRT3','EtDtq3G_QRT3'),'dSPM','MEEG',hemi,[1.050, 1.150],azimuth,None)
        #plot_overlays_diff_group_window(('EtDtq1G_QRT3','EtDtq3G_QRT3'),'dSPM','MEEG',hemi,[1.350, 1.400],azimuth,None)
        #plot_overlays_diff_group_window(('EsDsq1G_QRT3','EsDsq3G_QRT3'),'dSPM','MEEG',hemi,[1.356, 1.400],azimuth,None)
        #plot_overlays_diff_group_window(('EsDsq1G_QRT3','EsDsq3G_QRT3'),'dSPM','MEEG',hemi,[0.456, 0.608],azimuth,None) 
        #plot_overlays_diff_group_window(('QsEast','QsPar'),'dSPM','MEEG',hemi,[0.677, 0.806],azimuth,None)
        #plot_overlays_diff_group_window(('QsEast','QsPar'),'dSPM','MEEG',hemi,[0.334, 0.476],azimuth,None)
        #plot_overlays_diff_group_window(('QsEast','QsPar'),'dSPM','MEEG',hemi,[0.473, 0.821],azimuth,None)
        #plot_overlays_diff_group_window(('QsEast','QsPar'),'dSPM','MEEG',hemi,[0.288, 0.328],azimuth,None)
        plot_overlays_diff_group_window(('RefFut','RefPre'),'dSPM','MEEG',hemi,[0.301,0.359],azimuth,None)
        plot_overlays_diff_group_window(('RefFut','RefPre'),'dSPM','MEEG',hemi,[1.606,1.829],azimuth,None)
        plot_overlays_diff_group_window(('RefFut','RefPre'),'dSPM','MEEG',hemi,[0.564,0.808],azimuth,None)
        plot_overlays_diff_group_window(('RefFut','RefPre'),'dSPM','MEEG',hemi,[0.880,1.084],azimuth,None)
        plot_overlays_diff_group_window(('RefPast','RefPre'),'dSPM','MEEG',hemi,[0.301,0.359],azimuth,None)
        plot_overlays_diff_group_window(('RefPast','RefPre'),'dSPM','MEEG',hemi,[1.606,1.829],azimuth,None)
        plot_overlays_diff_group_window(('RefPast','RefPre'),'dSPM','MEEG',hemi,[0.564,0.808],azimuth,None)
        plot_overlays_diff_group_window(('RefPast','RefPre'),'dSPM','MEEG',hemi,[0.880,1.084],azimuth,None)
         
CondComb = ( 
      ('RefW','RefPar'),
      ('RefPast','RefPre'),
      ('RefE','RefPar'),
      ('RefFut','RefPre'))

 
 
combview(('RefFut','RefPre'),[0.301,0.359],'MEEG','Normalized')
combview(('RefFut','RefPre'),[1.606,1.829],'MEEG','Normalized')
combview(('RefFut','RefPre'),[0.564,0.808],'MEEG','Normalized')
combview(('RefFut','RefPre'),[0.880,1.084],'MEEG','Normalized')
combview(('RefPast','RefPre'),[0.301,0.359],'MEEG','Normalized')
combview(('RefPast','RefPre'),[1.606,1.829],'MEEG','Normalized')
combview(('RefPast','RefPre'),[0.564,0.808],'MEEG','Normalized')
combview(('RefPast','RefPre'),[0.880,1.084],'MEEG','Normalized')
 
combview(('EtFut','EtPre'),[0.509, 0.989],'MEEG','Normalized')
combview(('EtPast','EtPre'),[0.509, 0.989],'MEEG','Normalized')
combview(('EtPast','EtPre'),[0.106,0.223],'MEEG','Normalized')
combview(('EtFut','EtPre'),[0.106,0.233],'MEEG','Normalized')
combview(('EtFut','EtPre'),[0.255,0.451],'MEEG','Normalized')
combview(('EtPast','EtPre'),[0.255,0.451],'MEEG','Normalized')
combview(('EtPast','EtPre'),[0.512,0.688],'MEEG','Normalized')
combview(('EtFut','EtPre'),[0.512,0.688],'MEEG','Normalized')
     
combview(('EtFut','EtPre'),[1.252, 1.444],'MEEG','Normalized')
combview(('EtPast','EtPre'),[1.252, 1.444],'MEEG','Normalized')
combview(('EtPast','EtPre'),[1.595,1.750],'MEEG','Normalized')
combview(('EtFut','EtPre'),[1.595,1.750],'MEEG','Normalized')

combview(('QsWest','QsPar'),[0.260,0.476],'MEEG','Normalized')
combview(('QsEast','QsPar'),[0.260,0.476],'MEEG','Normalized')

combview(('EsWest','EsPar'),[1.050, 1.150],'MEEG','Normalized')
combview(('EsEast','EsPar'),[1.350, 1.400],'MEEG','Normalized')
combview(('EsWest','EsPar'),[1.244, 1.500],'MEEG','Normalized')
combview(('EsEast','EsPar'),[1.244, 1.500],'MEEG','Normalized')
combview(('EsWest','EsPar'),[0.400, 0.600],'MEEG','Normalized')
combview(('EsEast','EsPar'),[0.400, 0.600],'MEEG','Normalized')

combview(('Qt_all','Qs_all'),[0.404, 0.460],'MEEG','Normalized')
combview(('Qt_all','Qs_all'),[0.650, 0.700],'MEEG','Normalized')
combview(('Qt_all','Qs_all'),[0.144, 0.270],'MEEG','Normalized')
combview(('Qt_all','Qs_all'),[0.445, 0.632],'MEEG','Normalized')

combview(('Et_all','Es_all'),[0.415, 0.821],'MEEG','Normalized')
combview(('Et_all','Es_all'),[0.308, 0.972],'MEEG','Normalized')

combview(('EtDtq1G_QRT2','EtDtq2G_QRT2'),[0.750, 0.950],'MEEG','Normalized')
combview(('EtDtq1G_QRT2','EtDtq2G_QRT2'),[0.740,0.848 ],'MEEG','Normalized')
combview(('EsDsq1G_QRT2','EsDsq2G_QRT2'),[0.164, 0.260],'MEEG','Normalized')
combview(('EtDtq1G_QRT3','EtDtq3G_QRT3'),[0.450, 0.500],'MEEG','Normalized')
combview(('EtDtq1G_QRT3','EtDtq3G_QRT3'),[0.888, 0.932],'MEEG','Normalized')
combview(('EsDsq1G_QRT3','EsDsq3G_QRT3'),[0.848, 0.876],'MEEG','Normalized')
combview(('EsDsq1G_QRT3','EsDsq3G_QRT3'),[0.456, 0.608],'MEEG','Normalized')

combview(('QsWest','QsPar'),[0.677, 0.806],'MEEG','Normalized')
combview(('QsWest','QsPar'),[0.334, 0.476],'MEEG','Normalized')
combview(('QsWest','QsPar'),[0.473, 0.821],'MEEG','Normalized')
combview(('QsWest','QsPar'),[0.288, 0.328],'MEEG','Normalized')
combview(('QsEast','QsPar'),[0.677, 0.806],'MEEG','Normalized')
combview(('QsEast','QsPar'),[0.334, 0.476],'MEEG','Normalized')
combview(('QsEast','QsPar'),[0.473, 0.821],'MEEG','Normalized')
combview(('QsEast','QsPar'),[0.288, 0.328],'MEEG','Normalized')
###############################################################################
###############################################################################
# combines group-level images in a panel
cond = 'EsWest-EsPar'
mod = 'MEEG'
isnorm = 'Normalized'

import Image

time = (-0.1,0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9)
ima_dir = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/Plots/IcaCorr_' + cond)
# create new template image
new_im = Image.new('RGB', (2400,4500))
#Iterate through a 4 by 20 grid with 0 spacing, to place my image
count = 1

for i in range(10):
        
    # external face
    im = Image.open((ima_dir+'/IcaCorr_' +mod+'_dSPM__'+isnorm+cond+'_'+str(time[count])+'lh_180_ico-5-fwd-fsaverage-.png'))  
    im = im.crop((0,100,600,550))     
    new_im.paste(im, (0,i*450))

    im = Image.open((ima_dir+'/IcaCorr_' +mod+'_dSPM__'+isnorm+cond+'_'+str(time[count])+'rh_0_ico-5-fwd-fsaverage-.png')) 
    im = im.crop((0,100,600,550))         
    new_im.paste(im, (600,i*450))

    # internal face
    im = Image.open((ima_dir+'/IcaCorr_' +mod+'_dSPM__'+isnorm+cond+'_'+str(time[count])+'lh_0_ico-5-fwd-fsaverage-.png'))    
    im = im.crop((0,100,600,550))      
    new_im.paste(im, (2*600,i*450))


    im = Image.open((ima_dir+'/IcaCorr_' +mod+'_dSPM__'+isnorm+cond+'_'+str(time[count])+'rh_180_ico-5-fwd-fsaverage-.png')) 
    im = im.crop((0,100,600,550))         
    new_im.paste(im, (3*600,i*450))

    
    count = count + 1

new_im.show()
new_im.save((ima_dir+mod+isnorm+'_dSPM__'+cond+'.tiff'))

###############################################################################
###############################################################################
# combines group-level images in a panel
CondComb = (('Qt_all','Qs_all'),) 
#	('EsDsq1G_QRT3','EsDsq3G_QRT3'),
#	('EtDtq1G_QRT3','EtDtq3G_QRT3'),
#	('EtDtq1G_QRT2','EtDtq2G_QRT2'),
#	('EsDsq1G_QRT2','EsDsq2G_QRT2'))
#	('QtPast','QtPre'),
#	('QtFut' ,'QtPre'),
#	('EtPast','EtPre'),
#	('EtFut' ,'EtPre'),
#	('QsWest','QsPar'),
#	('QsEast','QsPar'),
#	('EsWest','EsPar'),
#	('EsEast','EsPar')) 

import Image

for condi in CondComb:
    
    cond = (condi[0] + '-' + condi[1])
    mod = 'MEEG'
    isnorm = ''

    
    time = (-0.1,0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9)
    ima_dir = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/Plots/IcaCorr_' + cond)
    # create new template image
    new_im = Image.new('RGB', (6000,2400))
    #Iterate through a 4 by 20 grid with 0 spacing, to place my image
    count = 1
    
    for i in range(10):
            
        # external face
        im = Image.open((ima_dir+'/IcaCorr_' +mod+'_dSPM__'+isnorm+cond+'_'+str(time[count])+'lh_180_ico-5-fwd-fsaverage-.png'))  
        im = im.crop((0,100,600,550))     
        new_im.paste(im, (i*600,0))
    
        im = Image.open((ima_dir+'/IcaCorr_' +mod+'_dSPM__'+isnorm+cond+'_'+str(time[count])+'rh_0_ico-5-fwd-fsaverage-.png')) 
        im = im.crop((0,100,600,550))         
        new_im.paste(im, (i*600,400))
    
        # internal face
        im = Image.open((ima_dir+'/IcaCorr_' +mod+'_dSPM__'+isnorm+cond+'_'+str(time[count])+'lh_0_ico-5-fwd-fsaverage-.png'))    
        im = im.crop((0,100,600,550))      
        new_im.paste(im, (i*600,2*400))
    
    
        im = Image.open((ima_dir+'/IcaCorr_' +mod+'_dSPM__'+isnorm+cond+'_'+str(time[count])+'rh_180_ico-5-fwd-fsaverage-.png')) 
        im = im.crop((0,100,600,550))         
        new_im.paste(im, (i*600,3*400))
        
        count = count + 1
    
    new_im.show()
    new_im.save((ima_dir+mod+isnorm+'_dSPM__'+cond+'_H.tiff'))


###############################################################################
# combines subject-level images in a panel
import Image
    
ListSubj = ('sd130343', 'cb130477', 'rb130313','jm100042', 
	      'jm100109', 'sb120316', 'tk130502', 
	      'lm130479', 'ms130534', 'ma100253',
	      'sl130503', 'mb140004', 'mp140019',
	      'dm130250', 'hr130504', 'wl130316', 
	      'rl130571')    
for subject in ListSubj:    
    
    #time = (-0.1,-0.05,0.0,0.05,0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45,0.5,0.55,0.6,0.65,0.7,0.75,0.8,0.85,0.9)
    time = (-0.1,0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9)
    ima_dir = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/'+subject+'/mne_python/BrainMaps'
    # create new template image
    new_im = Image.new('RGB', (2400,4500))
    #Iterate through a 4 by 20 grid with 0 spacing, to place my image
    count = 1
    
    for i in range(10):
            
        # external face
        im = Image.open((ima_dir+'/Qt_all-Qs_all/MEEG_dSPM_'+subject+'_Qt_all-Qs_all_'+str(time[count])+'lh_180_ico-5-fwd-fsaverage-.png'))  
        im = im.crop((0,100,600,550))     
        new_im.paste(im, (0,i*450))
    
        im = Image.open((ima_dir+'/Qt_all-Qs_all/MEEG_dSPM_'+subject+'_Qt_all-Qs_all_'+str(time[count])+'rh_0_ico-5-fwd-fsaverage-.png')) 
        im = im.crop((0,100,600,550))         
        new_im.paste(im, (600,i*450))
    
        # internal face
        im = Image.open((ima_dir+'/Qt_all-Qs_all/MEEG_dSPM_'+subject+'_Qt_all-Qs_all_'+str(time[count])+'lh_0_ico-5-fwd-fsaverage-.png'))    
        im = im.crop((0,100,600,550))      
        new_im.paste(im, (2*600,i*450))
    
    
        im = Image.open((ima_dir+'/Qt_all-Qs_all/MEEG_dSPM_'+subject+'_Qt_all-Qs_all_'+str(time[count])+'rh_180_ico-5-fwd-fsaverage-.png')) 
        im = im.crop((0,100,600,550))         
        new_im.paste(im, (3*600,i*450))
    
        
        count = count + 1
    
    new_im.show()
    new_im.save((ima_dir + '/Qt_all-Qs_all_' + subject + '.tiff'))
    
    
    
    
    
    

























