# -*- coding: utf-8 -*-
"""
Created on Thu Nov 26 14:38:34 2015

@author: bgauthie
"""

# -*- coding: utf-8 -*-
"""
Created on Mon Nov  9 15:50:26 2015

@author: bgauthie
"""

def GetTimeCourseFromSTC4(wdir,ListSub,Conds,mod,method,parc,colors):
    import mne
    import numpy as np
    import matplotlib
    matplotlib.use('Agg')
    import matplotlib.pyplot as pl
    
    ###############################################################
    #\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
    def plot_panel_mean(Labels, Panel, Conds, stc, TC_mean,TC_std):
        
        pl.figure(figsize=(10,14))
        for l,label in enumerate(Labels):
            
            ax= pl.subplot(6,3,l+1)
            combcondname = ''
            for c, cond in enumerate(Conds):
                
                ax.plot(stc.times, TC_mean[c,label,:],color = colors[c],
                        linewidth=2)
                ax.fill_between(stc.times,
                                TC_mean[c,label,:] - TC_std[c,label,:],
                                TC_mean[c,label,:] + TC_std[c,label,:],
                                alpha=0.2, edgecolor=colors[c], 
                                facecolor=colors[c],linewidth=0)
                ax.yaxis.set_visible(False)
                ax.set_title(labels[label].name, fontsize = 12)
                combcondname = combcondname + '_VS_' + Conds[c]
                pl.tight_layout()
    
        save_path = (wdir + '/PLOTS/' + parc + "/GROUP_" + mod + "_" + 
                     method + "/" + mod + '_' + combcondname +
                     '_MEANSUBJ_part'+ str(Panel) +'.png')       
        pl.savefig(save_path)
        pl.close()
 
    #################################################################
    #\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ 
    def plot_panel_subj(ListSub,SubInd, Labels, Panel, Conds, stc, TC,TCsd):
        
        pl.figure(figsize=(10,14))
        for l,label in enumerate(Labels):
            
            ax= pl.subplot(6,3,l+1)
            combcondname = ''
            for c, cond in enumerate(Conds):
                
                ax.plot(stc.times, TC[c,SubInd,label,:],color = colors[c],
                        linewidth=2)
                ax.fill_between(stc.times,
                                TC[c,SubInd,label,:] - TCsd[c,SubInd,label,:],
                                TC[c,SubInd,label,:] + TCsd[c,SubInd,label,:],
                                alpha=0.2, edgecolor=colors[c], 
                                facecolor=colors[c],linewidth=0)
                ax.yaxis.set_visible(False)
                ax.set_title(labels[label].name, fontsize = 12)
                combcondname = combcondname + '_VS_' + Conds[c]
                pl.tight_layout()
    
        save_path = (wdir + '/PLOTS/' + parc + "/" + mod + "_" + 
                     method + "/" + mod + '_' + combcondname +
                     '_' + ListSub[SubInd] +'_part'+ str(Panel) +'.png')       
        pl.savefig(save_path)
        pl.close() 
 
    ####################################################################
    #\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
    ## use fsaverage brain label with a chosen parcellation
   
    subjects_dir = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/mri/'
        
    labels = mne.read_labels_from_annot('fsaverage',
                                        parc, 
                                        hemi = 'both', 
                                        subjects_dir = subjects_dir)
    # init size
    stc0_path = (wdir + '/' + ListSub[0] + '/mne_python/STCS/' + mod + 
               '_' + ListSub[0] + '_' + Conds[0] + '_pick_orinormal_' + 
                method + '_ico-5-fwd-fsaverage.fif-rh.stc')
    init_timepoints = mne.read_source_estimate(stc0_path)
    ncond  = len(Conds)
    nsub   = len(ListSub)
    nlabel = len(labels)
    ntimes = len(init_timepoints.times)
    
    # get timecourse data from each subject & each label
    TC_Label   = np.empty([ncond,nsub,nlabel,ntimes])
    TCsd_Label = np.empty([ncond,nsub,nlabel,ntimes])
    for s,subj in enumerate(ListSub):
        for l in range(nlabel-1):
            for c,cond in enumerate(Conds):
                stc_path = (wdir + '/' + subj + '/mne_python/STCS/' + mod +
                            '_' + subj + '_' + cond + '_pick_orinormal_' + 
                            method + '_ico-5-fwd-fsaverage.fif-rh.stc')
                stc = mne.read_source_estimate(stc_path)
                a = stc.in_label(labels[l])
                TC_Label[c,s,l,:] = np.mean(a.data[:,:], axis = 0)
                TCsd_Label[c,s,l,:] = np.std(a.data[:,:], axis = 0)/np.sqrt(np.float32(a.shape[0]))
                del stc, a
                
    stc = mne.read_source_estimate(stc_path)

    # suplot 2 AVG across subjects
    TC_Label_mean = np.empty([ncond,nlabel,ntimes])
    TC_Label_std  = np.empty([ncond,nlabel,ntimes])
	
    for l in range(len(labels)-1):
        for c, cond in enumerate(Conds): 
            TC_Label_mean[c,l,:] = np.mean(TC_Label[c,:,l,:], axis = 0)
            TC_Label_std[c,l,:]  = (np.std(TC_Label[c,:,l,:], axis = 0))/np.sqrt(np.float32(nsub))
    
    # plot source amplitudes panel per label
    plot_panel_mean(range(0,18) , 1, Conds, stc, TC_Label_mean,TC_Label_std)
    plot_panel_mean(range(18,36), 2, Conds, stc, TC_Label_mean,TC_Label_std)
    plot_panel_mean(range(36,54), 3, Conds, stc, TC_Label_mean,TC_Label_std)
    plot_panel_mean(range(54,68), 4, Conds, stc, TC_Label_mean,TC_Label_std)
    
    # plot source amplitude panel per label per subject
    for s, subject in enumerate(ListSub):
        plot_panel_subj(ListSub,s,range(0,18) , 1, Conds, stc, TC_Label,TCsd_Label)
        plot_panel_subj(ListSub,s,range(18,36), 2, Conds, stc, TC_Label,TCsd_Label)
        plot_panel_subj(ListSub,s,range(36,54), 3, Conds, stc, TC_Label,TCsd_Label)
        plot_panel_subj(ListSub,s,range(54,68), 4, Conds, stc, TC_Label,TCsd_Label)
    


