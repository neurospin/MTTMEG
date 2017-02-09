# -*- coding: utf-8 -*-
"""
Created on Fri Feb  5 15:46:41 2016

@author: bgauthie
"""

def GetTimeCourseFromSTC_flip(wdir,ListSub,Conds,mod,method,parc,colors, avg_mode):
    import mne
    import os
    from mne.stats import fdr_correction
    from scipy import stats
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
                     '_MEANSUBJ_notmorph_part'+ str(Panel) +'.png')       
        pl.savefig(save_path)
        pl.close()

    ###############################################################
    #\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
    def plot_panel_stats(Labels, Panel, Conds, stc, TC_label,TC_mean,TC_std, avg_mode):
        
        #######################################################################
        def cluster(data, maxgap):

            data.sort()
            groups = [[data[0]]]
            for x in data[1:]:
                if abs(x - groups[-1][-1]) <= maxgap:
                    groups[-1].append(x)
                else:
                    groups.append([x])
            return groups
        #######################################################################
        
        pl.figure(figsize=(10,14))
        for l,label in enumerate(Labels):
            
            T, pval, threshold_uncorrected, threshold_fdr = [], [], [], []
            reject_fdr, pval_fdr, X  = [], [], []
            
            # difference between conditions            
            X       = TC_Label[0,:,label,:] - TC_Label[1,:,label,:]
            
            T, pval = stats.ttest_1samp(X, 0)
            alpha   = 0.05
            
            n_samples, n_tests    = X.shape
            threshold_uncorrected = stats.t.ppf(1.0 - alpha, n_samples - 1)
            reject_fdr, pval_fdr  = fdr_correction(pval, alpha=alpha, method='indep')
            
            temp_clust_uncorr,temp_clust_fdr = [], [] 
            clust_uncorr, clust_fdr = [], []
            if reject_fdr.any(): 
            
                threshold_fdr     = np.min(np.abs(T)[reject_fdr])
                temp_clust_uncorr = np.where(abs(T) >= threshold_uncorrected)
                temp_clust_fdr    = np.where(abs(T) >= threshold_fdr)
                
                clust_uncorr   = cluster(temp_clust_uncorr[0],1)
                clust_fdr = cluster(temp_clust_fdr[0],1)
            
            ax= pl.subplot(6,3,l+1)
            combcondname = ''
            for c, cond in enumerate(Conds):
                
                # plot conditions and +-SEM
                ax.plot(stc.times, TC_mean[c,label,:],color = colors[c],
                        linewidth=2)
                ax.fill_between(stc.times,
                                TC_mean[c,label,:] - TC_std[c,label,:],
                                TC_mean[c,label,:] + TC_std[c,label,:],
                                alpha=0.1, edgecolor=colors[c], 
                                facecolor=colors[c],linewidth=0)
                #ax.yaxis.set_visible(False)
                ax.set_title(labels[label].name, fontsize = 12)
                combcondname = combcondname + '_VS_' + Conds[c]
                pl.tight_layout()
                
            # plot stats
            if reject_fdr.any():
                for clust in clust_uncorr:
                    ax.axvspan(stc.times[clust[0]], stc.times[clust[-1]- 1],
                                        color='k', alpha=0.1) 
            if reject_fdr.any(): 
                for clust in clust_fdr:
                    ax.axvspan(stc.times[clust[0]], stc.times[clust[-1]- 1],
                                        color='k', alpha=0.2)                             
        
            
        PlotDir = []
        PlotDir = ('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/PLOTS/'+ parc
                   + '/GROUP_' + mod + '_' + method + '/' + avg_mode) 
    
        if not os.path.exists(PlotDir):
            os.makedirs(PlotDir)
        
        save_path = (PlotDir + '/' + mod + '_' + combcondname +
                     '_MEANSUBJ_notmorph_'+ avg_mode +'_stats_part'+ str(Panel) +'.png')       
        pl.savefig(save_path)
        #pl.close()
 
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
                     '_' + ListSub[SubInd] +'_notmorph_part'+ str(Panel) +'.png')       
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
    stc0_path = (wdir + '/' + ListSub[0] + '/mne_python/STCS/IcaCorr_' + mod + 
               '_' + ListSub[0] + '_' + Conds[0] + '_pick_orinormal_' + 
                method + '_ico-5-fwd-fsaverage.fif-rh.stc')
    init_timepoints = mne.read_source_estimate(stc0_path)
    init_timepoints.crop(0,1)
    ncond  = len(Conds)
    nsub   = len(ListSub)
    nlabel = len(labels)
    ntimes = len(init_timepoints.times)
    
    # get timecourse data from each subject & each label
    TC_Label   = np.empty([ncond,nsub,nlabel,ntimes])
    TCsd_Label = np.empty([ncond,nsub,nlabel,ntimes])
    for l in range(nlabel-1):
        for s,subj in enumerate(ListSub):  
            labels = mne.read_labels_from_annot(subj,
                                            parc, 
                                            hemi = 'both', 
                                            subjects_dir = subjects_dir)           
                
            # which modality?
            wdir_ = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"
            if mod == 'MEG':
                fname_fwd  = (wdir_+subj+"/mne_python/run3_ico5_megonly_icacorr_-fwd.fif") 
            elif mod == 'EEG':
                fname_fwd  = (wdir_+subj+"/mne_python/run3_ico5_eegonly_icacorr_-fwd.fif") 
            elif mod == 'MEEG':
                fname_fwd  = (wdir_+subj+"/mne_python/run3_ico5_meeg_icacorr_-fwd.fif")
        
            for c,cond in enumerate(Conds):
                stc_path = (wdir + '/' + subj + '/mne_python/STCS/IcaCorr_' + mod +
                            '_' + subj + '_' + cond + '_pick_orinormal_' + 
                            method + '_ico-5-fwd.fif-rh.stc')
                forward = mne.read_forward_solution(fname_fwd)
                stc = mne.read_source_estimate(stc_path)
                stc.crop(0,1)
                TC_Label[c,s,l,:] = stc.extract_label_time_course(labels[l],forward['src'],mode=avg_mode)
                #TCsd_Label[c,s,l,:] = np.std(a.data[:,:], axis = 0)/np.sqrt(np.float32(a.shape[0]))
                del stc
        
        stc = mne.read_source_estimate(stc_path)
        stc.crop(0,1)                    

    # suplot 2 AVG across subjects
    TC_Label_mean = np.empty([ncond,nlabel,ntimes])
    TC_Label_std  = np.empty([ncond,nlabel,ntimes])
	
    for l in range(len(labels)-1):
        for c, cond in enumerate(Conds): 
            TC_Label_mean[c,l,:] = np.mean(TC_Label[c,:,l,:], axis = 0)
            TC_Label_std[c,l,:]  = (np.std(TC_Label[c,:,l,:], axis = 0))/np.sqrt(np.float32(nsub))
    
    # plot source amplitudes panel per label
    plot_panel_stats(range(0,18) , 1, Conds, stc, TC_Label,TC_Label_mean,TC_Label_std, avg_mode)
    plot_panel_stats(range(18,36), 2, Conds, stc, TC_Label, TC_Label_mean,TC_Label_std, avg_mode)
    plot_panel_stats(range(36,54), 3, Conds, stc, TC_Label, TC_Label_mean,TC_Label_std, avg_mode)
    plot_panel_stats(range(54,67), 4, Conds, stc, TC_Label, TC_Label_mean,TC_Label_std, avg_mode)
    
    # plot source amplitude panel per label per subject
#    for s, subject in enumerate(ListSub):
#        plot_panel_subj(ListSub,s,range(0,18) , 1, Conds, stc, TC_Label,TCsd_Label)
#        plot_panel_subj(ListSub,s,range(18,36), 2, Conds, stc, TC_Label,TCsd_Label)
#        plot_panel_subj(ListSub,s,range(36,54), 3, Conds, stc, TC_Label,TCsd_Label)
#        plot_panel_subj(ListSub,s,range(54,68), 4, Conds, stc, TC_Label,TCsd_Label)
    


