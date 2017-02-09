# -*- coding: utf-8 -*-
"""
Created on Thu Jul  7 19:26:32 2016

@author: bgauthie
"""

# -*- coding: utf-8 -*-
"""
Created on Fri Jan 22 14:25:17 2016

@author: bgauthie
"""
# do not forget to set environement variable
# export SUBJECTS_DIR='/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/mri'
# export QT_API=pyqt

import os

#from matplotlib import pyplot as pl
from surfer import Brain
from surfer.io import read_stc

###############################################################################
def plot_overlays_diff_group(condition,modality,hemi,azimuth):

    brain = Brain(subject_id='fsaverage', hemi=hemi,surf='pial',cortex = 'low_contrast', size=(600, 600))
    stc_fname = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/STATS/'+
                 modality+'_ProbMap_'+ "_vs_".join(condition) +'-' + hemi+'.stc')
    stc = read_stc(stc_fname)
    data = stc['data']
    vertices = stc['vertices']

    brain.add_data(data, thresh = 2,colormap='jet',alpha=1, vertices=vertices,
                   smoothing_steps=4,hemi=hemi)
    brain.set_data_time_index(0)
    brain.scale_data_colormap(fmin=2, fmid=6, fmax= 10, transparent=False)
    brain.show_view(dict(azimuth=azimuth,elevation=None, distance=None))
    #    mayavi.mlab.view(azimuth=0, elevation=None, distance=None, focalpoint=None,
    #         roll=None, reset_roll=True, figure=None)
    
    PlotDir = []
    PlotDir = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/Plot_STATS/'  
               + "_vs_".join(condition)) 
    
    if not os.path.exists(PlotDir):
        os.makedirs(PlotDir)

    brain.save_image(PlotDir + '/IcaCorr_' + modality + '_' + 'dSPM' + '_'
                        + '_' + "_vs_".join(condition) + '_'
                        +  hemi + '_'+ str(azimuth)+ '_ico-5-fwd-fsaverage-'+'.png')    
                        
###############################################################################
def plot_overlays_Fgroup(condition,modality,hemi,azimuth):

    brain = Brain(subject_id='fsaverage', hemi=hemi,surf='pial',cortex = 'low_contrast', size=(600, 600))
    stc_fname = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/Plot_STATS/'
                 +"_vs_".join(condition) +'/fmap'+ modality+ '_'
                 +"_vs_".join(condition)+ '-' + hemi+'.stc')
    stc = read_stc(stc_fname)
    data = stc['data']
    vertices = stc['vertices']

    brain.add_data(data, thresh = 3.259,colormap='hot',alpha=1, vertices=vertices,
                   smoothing_steps=3,hemi=hemi)
    brain.set_data_time_index(0)
    brain.scale_data_colormap(fmin=3.26, fmid=5.84, fmax= 8.42, transparent=False)
    brain.show_view(dict(azimuth=azimuth,elevation=None, distance=None))
    #    mayavi.mlab.view(azimuth=0, elevation=None, distance=None, focalpoint=None,
    #         roll=None, reset_roll=True, figure=None)
    
    PlotDir = []
    PlotDir = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/Plot_STATS/'  
               + "_vs_".join(condition)) 
    
    if not os.path.exists(PlotDir):
        os.makedirs(PlotDir)

    brain.save_image(PlotDir + '/Fmap_IcaCorr_' + modality + '_' + 'dSPM' + '_'
                        + '_' + "_vs_".join(condition) + '_'
                        +  hemi + '_'+ str(azimuth)+ '_ico-5-fwd-fsaverage-'+'.png')                      


###############################################################################
def combview_4view(condition,mod):
    
    import Image
    
    ima_dir = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/Plot_STATS/' 
    + "_vs_".join(condition) + '/')
    # create new template image
    new_im = Image.new('RGB', (1250,870))
    #Iterate through a 4 by 20 grid with 0 spacing, to place my image
        
    # external face
    im = Image.open((ima_dir+'/IcaCorr_' +mod+'_dSPM__'+"_vs_".join(condition)+'_'
   +'lh_180_ico-5-fwd-fsaverage-.png'))  
    im = im.crop((0,100,600,520))     
    new_im.paste(im, (0,0))
    
    im = Image.open((ima_dir+'/IcaCorr_' +mod+'_dSPM__'+"_vs_".join(condition)+'_'
    +'rh_0_ico-5-fwd-fsaverage-.png'))  
    im = im.crop((0,100,600,520))         
    new_im.paste(im, (620,0))
    
    # internal face
    im = Image.open((ima_dir+'/IcaCorr_' +mod+'_dSPM__'+"_vs_".join(condition)+'_'
    +'lh_0_ico-5-fwd-fsaverage-.png'))  
    im = im.crop((0,50,650,550))      
    new_im.paste(im, (0,400))
    
    im = Image.open((ima_dir+'/IcaCorr_' +mod+'_dSPM__'+"_vs_".join(condition)+'_'
    +'rh_180_ico-5-fwd-fsaverage-.png'))  
    im = im.crop((0,50,650,550))         
    new_im.paste(im, (620,400))
    
    new_im.show()
    new_im.save((ima_dir+'/PANEL_'+mod+'_dSPM_'+"_vs_".join(condition)+'.tiff'))

###############################################################################
def combview_4view_fmap(condition,mod):
    
    import Image
    
    ima_dir = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/mne_python/Plot_STATS/' 
    + "_vs_".join(condition) + '/')
    # create new template image
    new_im = Image.new('RGB', (1250,870))
    #Iterate through a 4 by 20 grid with 0 spacing, to place my image
        
    # external face
    im = Image.open((ima_dir+'/Fmap_IcaCorr_' +mod+'_dSPM__'+"_vs_".join(condition)+'_'
   +'lh_180_ico-5-fwd-fsaverage-.png'))  
    im = im.crop((0,100,600,520))     
    new_im.paste(im, (0,0))
    
    im = Image.open((ima_dir+'/Fmap_IcaCorr_' +mod+'_dSPM__'+"_vs_".join(condition)+'_'
    +'rh_0_ico-5-fwd-fsaverage-.png'))  
    im = im.crop((0,100,600,520))         
    new_im.paste(im, (620,0))
    
    # internal face
    im = Image.open((ima_dir+'/Fmap_IcaCorr_' +mod+'_dSPM__'+"_vs_".join(condition)+'_'
    +'lh_0_ico-5-fwd-fsaverage-.png'))  
    im = im.crop((0,50,650,550))      
    new_im.paste(im, (0,400))
    
    im = Image.open((ima_dir+'/Fmap_IcaCorr_' +mod+'_dSPM__'+"_vs_".join(condition)+'_'
    +'rh_180_ico-5-fwd-fsaverage-.png'))  
    im = im.crop((0,50,650,550))         
    new_im.paste(im, (620,400))
    
    new_im.show()
    new_im.save((ima_dir+'/PANEL_Fmap_'+mod+'_dSPM_'+"_vs_".join(condition)+'.tiff'))
    
###############################################################################

CondComb = (('RefPast','RefPre','RefFut'),)


method = 'dSPM'
modality = ('MEEG','MEG')
hemispheres = ('lh','rh')

for condition in CondComb:
    for mod in modality:
        for hemi in hemispheres:
            for azimuth in (0,180):
                plot_overlays_diff_group(condition,mod,hemi,azimuth)

for condition in CondComb:
    for mod in modality:
        for hemi in hemispheres:
            for azimuth in (0,180):
                plot_overlays_Fgroup(condition,mod,hemi,azimuth)

for condition in CondComb:
        for mod in modality:
            combview_4view(condition,mod) 
 
for condition in CondComb:
        for mod in modality:
            combview_4view_fmap(condition,mod) 










