# -*- coding: utf-8 -*-
"""
Created on Mon Nov  9 15:50:26 2015

@author: bgauthie
"""

def GetTimeCourseFromSTC3(wdir,ListSub,Conds,mod,method,parc,colors):
    import mne
    import numpy as np
    import matplotlib
    matplotlib.use('Agg')
    import matplotlib.pyplot as pl
    
    subjects_dir = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/mri/'
        
    ####################################################################
    ## use fsaverage brain label with chosen parcellation
    labels = mne.read_labels_from_annot('fsaverage',
                                        parc, 
                                        hemi = 'both', 
                                        subjects_dir = subjects_dir)
    # init size
    stc0_path = (wdir + '/' + ListSub[0] + '/mne_python/STCS/' + mod + 
               '_' + ListSub[0] + '_' + Conds[0] + '_pick_oriNone_' + 
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
                            '_' + subj + '_' + cond + '_pick_oriNone_' + 
                            method + '_ico-5-fwd-fsaverage.fif-rh.stc')
                stc = mne.read_source_estimate(stc_path)
                a = stc.in_label(labels[l])
                TC_Label[c,s,l,:] = np.mean(a.data[:,:], axis = 0)
                TCsd_Label[c,s,l,:] = np.std(a.data[:,:], axis = 0)
                del stc, a
    
#    # supblot n conds per region
#    for s,subj in enumerate(ListSub):
#
#        pl.figure(figsize=(16,10))
#        for l in range(0,40):
#            ax= pl.subplot(6,7,l+1)
#    
#            combcondname = ''
#            for c in range(len(Conds)):
#                ax.plot(TC_Label[c,s,l,:],color = colors[c])
#                ax.fill_between(range(TC_Label[c,s,l,:].shape[0]),
#                                TC_Label[c,s,l,:] - TCsd_Label[c,s,l,:],
#                                TC_Label[c,s,l,:] + TCsd_Label[c,s,l,:],
#                                alpha=0.1, edgecolor=colors[c], 
#                                facecolor=colors[c],linewidth=0)
#                ax.xaxis.set_visible(False)
#                ax.yaxis.set_visible(False)
#                ax.set_title(labels[l].name, fontsize = 10)
#                combcondname = combcondname + '_VS_' + Conds[c]
#
#                save_path = (wdir + '/PLOTS/' + parc + "/" + mod + "_" + 
#                             method + "/" + mod + '_' + combcondname +
#                             "_"+ subj +'_part1'+'.png')
#                pl.savefig(save_path)
#	
# 
#        pl.figure(figsize=(16,10))
#        for l in range(0,40):
#            ax= pl.subplot(6,7,l+1)
#    
#            combcondname = ''
#            for c in range(len(Conds)):
#                ax.plot(TC_Label[c,s,l+40,:],color = colors[c])
#                ax.fill_between(range(TC_Label[c,s,l+40,:].shape[0]),
#                                TC_Label[c,s,l+40,:] - TCsd_Label[c,s,l+40,:],
#                                TC_Label[c,s,l+40,:] + TCsd_Label[c,s,l+40,:],
#                                alpha=0.1, edgecolor=colors[c], 
#                                facecolor=colors[c],linewidth=0)
#                ax.xaxis.set_visible(False)
#                ax.yaxis.set_visible(False)
#                ax.set_title(labels[l+40].name, fontsize = 10)
#                combcondname = combcondname + '_VS_' + Conds[c]
#
#                save_path = (wdir + '/PLOTS/' + parc + "/" + mod + "_" + 
#                             method + "/" + mod + '_' + combcondname +
#                             "_"+ subj +'_part2'+'.png')
#                pl.savefig(save_path)
#                
#        
#        pl.figure(figsize=(16,10))
#        for l in range(0,40):
#            ax= pl.subplot(6,7,l+1)
#    
#            combcondname = ''
#            for c in range(len(Conds)):
#                ax.plot(TC_Label[c,s,l+80,:],color = colors[c])
#                ax.fill_between(range(TC_Label[c,s,l+80,:].shape[0]),
#                                TC_Label[c,s,l+80,:] - TCsd_Label[c,s,l+80,:],
#                                TC_Label[c,s,l+80,:] + TCsd_Label[c,s,l+80,:],
#                                alpha=0.1, edgecolor=colors[c], 
#                                facecolor=colors[c],linewidth=0)
#                ax.xaxis.set_visible(False)
#                ax.yaxis.set_visible(False)
#                ax.set_title(labels[l+80].name, fontsize = 10)
#                combcondname = combcondname + '_VS_' + Conds[c]
#                
#                save_path = (wdir + '/PLOTS/' + parc + "/" + mod + "_" + 
#                     method + "/" + mod + '_' + combcondname +
#                     "_"+ subj +'_part3'+'.png')
#                pl.savefig(save_path)
#                
#        pl.figure(figsize=(16,10))
#        for l in range(0,29):
#            ax= pl.subplot(6,7,l+1)
#    
#            combcondname = ''
#            for c in range(len(Conds)):
#                ax.plot(TC_Label[c,s,l+120,:],color = colors[c])
#                ax.fill_between(range(TC_Label[c,s,l+120,:].shape[0]),
#                                TC_Label[c,s,l+120,:] - TCsd_Label[c,s,l+120,:],
#                                TC_Label[c,s,l+120,:] + TCsd_Label[c,s,l+120,:],
#                                alpha=0.1, edgecolor=colors[c], 
#                                facecolor=colors[c],linewidth=0)
#                ax.xaxis.set_visible(False)
#                ax.yaxis.set_visible(False)
#                ax.set_title(labels[l+120].name, fontsize = 10)
#                combcondname = combcondname + '_VS_' + Conds[c]
#
#                save_path = (wdir + '/PLOTS/' + parc + "/" + mod + "_" + 
#                             method + "/" + mod + '_' + combcondname +
#                             "_"+ subj +'_part4'+'.png')
#                pl.savefig(save_path)
	


    # suplot 2 AVG across subjects
    TC_Label_mean = np.empty([ncond,nlabel,ntimes])
    TC_Label_std  = np.empty([ncond,nlabel,ntimes])
	
    for l in range(len(labels)-1):
        for c, cond in enumerate(Conds): 
            TC_Label_mean[c,l,:] = np.mean(TC_Label[c,:,l,:], axis = 0)
            TC_Label_std[c,l,:]  = (np.std(TC_Label[c,:,l,:], axis = 0))/np.sqrt(np.float32(nsub))

    fig = pl.figure(figsize=(16,10))
    for l in range(0,40):
        ax= pl.subplot(6,7,l+1)

        combcondname = ''
        for c in range(len(Conds)):
            ax.plot(TC_Label_mean[c,l,:],color = colors[c])
            ax.fill_between(range(TC_Label_mean[c,l,:].shape[0]),
                            TC_Label_mean[c,l,:] - TC_Label_std[c,l,:],
                            TC_Label_mean[c,l,:] + TC_Label_std[c,l,:],
                            alpha=0.1, edgecolor=colors[c], 
                            facecolor=colors[c],linewidth=0)
            ax.xaxis.set_visible(False)
            ax.yaxis.set_visible(False)
            ax.set_title(labels[l].name, fontsize = 10)
            combcondname = combcondname + '_VS_' + Conds[c]

            save_path = (wdir + '/PLOTS/' + parc + "/" + mod + "_" + 
                         method + "/" + mod + '_' + combcondname +
                         '_MEANSUBJ_part1'+'.png')
            pl.savefig(save_path)

    fig = pl.figure(figsize=(16,10))
    for l in range(0,40):
        ax= pl.subplot(6,7,l+1)

        combcondname = ''
        for c in range(len(Conds)):
            ax.plot(TC_Label_mean[c,l+40,:],color = colors[c])
            ax.fill_between(range(TC_Label_mean[c,l,:].shape[0]),
                            TC_Label_mean[c,l+40,:] - TC_Label_std[c,l+40,:],
                            TC_Label_mean[c,l+40,:] + TC_Label_std[c,l+40,:],
                            alpha=0.1, edgecolor=colors[c], 
                            facecolor=colors[c],linewidth=0)
            ax.xaxis.set_visible(False)
            ax.yaxis.set_visible(False)
            ax.set_title(labels[l+40].name, fontsize = 10)
            combcondname = combcondname + '_VS_' + Conds[c]

            save_path = (wdir + '/PLOTS/' + parc + "/" + mod + "_" + 
                         method + "/" + mod + '_' + combcondname +
                         '_MEANSUBJ_part2'+'.png')
            pl.savefig(save_path)
            
    fig = pl.figure(figsize=(16,10))
    for l in range(0,40):
        ax= pl.subplot(6,7,l+1)

        combcondname = ''
        for c in range(len(Conds)):
            ax.plot(TC_Label_mean[c,l+80,:],color = colors[c])
            ax.fill_between(range(TC_Label_mean[c,l,:].shape[0]),
                            TC_Label_mean[c,l+80,:] - TC_Label_std[c,l+80,:],
                            TC_Label_mean[c,l+80,:] + TC_Label_std[c,l+80,:],
                            alpha=0.1, edgecolor=colors[c], 
                            facecolor=colors[c],linewidth=0)
            ax.xaxis.set_visible(False)
            ax.yaxis.set_visible(False)
            ax.set_title(labels[l+80].name, fontsize = 10)
            combcondname = combcondname + '_VS_' + Conds[c]

            save_path = (wdir + '/PLOTS/' + parc + "/" + mod + "_" + 
                         method + "/" + mod + '_' + combcondname +
                         '_MEANSUBJ_part3'+'.png')
            pl.savefig(save_path)
            
    fig = pl.figure(figsize=(16,10))
    for l in range(0,29):
        ax= pl.subplot(6,7,l+1)

        combcondname = ''
        for c in range(len(Conds)):
            ax.plot(TC_Label_mean[c,l+120,:],color = colors[c])
            ax.fill_between(range(TC_Label_mean[c,l,:].shape[0]),
                            TC_Label_mean[c,l+120,:] - TC_Label_std[c,l+120,:],
                            TC_Label_mean[c,l+120,:] + TC_Label_std[c,l+120,:],
                            alpha=0.1, edgecolor=colors[c], 
                            facecolor=colors[c],linewidth=0)
            ax.xaxis.set_visible(False)
            ax.yaxis.set_visible(False)
            ax.set_title(labels[l+120].name, fontsize = 10)
            combcondname = combcondname + '_VS_' + Conds[c]

            save_path = (wdir + '/PLOTS/' + parc + "/" + mod + "_" + 
                         method + "/" + mod + '_' + combcondname +
                         '_MEANSUBJ_part4'+'.png')
            pl.savefig(save_path)
            

	pl.close(fig)


