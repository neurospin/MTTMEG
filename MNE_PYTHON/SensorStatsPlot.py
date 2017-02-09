def SensorStatsPlot(condcomb,ListSubj,colors):
    
    #ListSubj = ('sd130343','cb130477' , 'rb130313', 'jm100109', 
    #             'sb120316', 'tk130502','lm130479' , 'ms130534', 'ma100253', 'sl130503', 
    #             'mb140004','mp140019' , 'dm130250', 'hr130504', 'wl130316', 'rl130571')
                 
    #ListSubj = ('sd130343','cb130477' , 'rb130313', 'jm100109', 
    #             'tk130502','lm130479' , 'ms130534', 'ma100253', 'sl130503', 
     #            'mb140004','mp140019' , 'dm130250', 'hr130504', 'rl130571')             
                 
    #condcomb = ('QtPast' ,'QtPre','QtFut' )
    #condcomb = ('QsWest' ,'QsPar','QsEast')
    
    #ipython --pylab
    import mne
    import numpy as np
    import matplotlib.pyplot as plt
    from mpl_toolkits.axes_grid1 import make_axes_locatable
    from mne.viz import plot_topomap
    from mne.stats import spatio_temporal_cluster_test
    from mne.datasets import sample
    from mne.channels import read_ch_connectivity
    from scipy import stats as stats
    from mne.viz import plot_topo
    import os
    os.chdir('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS/MNE_PYTHON')
    os.environ['MNE_ROOT'] = '/neurospin/local/mne'
    wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"	

    # load FieldTrip neighbor definition to setup sensor connectivity
    neighbor_file_mag  = '/neurospin/local/fieldtrip/template/neighbours/neuromag306mag_neighb.mat' # mag
    neighbor_file_grad = '/neurospin/local/fieldtrip/template/neighbours/neuromag306planar_neighb.mat' # grad
    neighbor_file_eeg  = '/neurospin/local/fieldtrip/template/neighbours/easycap64ch-avg_neighb.mat' # eeg
    connectivity, ch_names = mne.channels.read_ch_connectivity(neighbor_file_eeg,picks=range(60))
    connectivity_mag, ch_names_mag   = read_ch_connectivity(neighbor_file_mag)
    connectivity_grad, ch_names_grad = read_ch_connectivity(neighbor_file_grad)
    connectivity_eeg, ch_names_eeg   = read_ch_connectivity(neighbor_file_eeg)
	 
    # evoked 0 to get the size of the matrix
    fname0  = (wdir+ListSubj[0]+"/mne_python/MEEG_"+condcomb[0]+"_"+ListSubj[0]+"-ave.fif")
    evoked0 = mne.read_evokeds(fname0,  condition=0, baseline=(-0.2, 0))
    sensordatamat_meg_mag    = np.empty([len(condcomb), len(ListSubj),102,evoked0.data.shape[1]])
    sensordatamat_meg_grad   = np.empty([len(condcomb), len(ListSubj),204,evoked0.data.shape[1]])
    sensordatamat_meg_eeg    = np.empty([len(condcomb), len(ListSubj),60 ,evoked0.data.shape[1]])
    
    # define statistical threshold
    p_threshold = 0.05
    t_threshold = -stats.distributions.t.ppf(p_threshold / 2., len(ListSubj) - 1)
    
    # compute grand averages
    GDAVGmag, GDAVGgrad, GDAVGeeg = [], [], []
    sensordatamat_meg_mag   = np.empty((len(condcomb),len(ListSubj),102,len(evoked0.times)))
    sensordatamat_meg_grad  = np.empty((len(condcomb),len(ListSubj),204,len(evoked0.times)))
    #sensordatamat_eeg       = np.empty((len(condcomb),len(ListSubj),60 ,len(evoked0.times)))
    
    for c in range(len(condcomb)):
        
        evoked2plotmag, evoked2plotgrad, evoked2ploteeg = [], [], []
        for i in range(len(ListSubj)):
           
            fname_ave_meg   = (wdir+ListSubj[i]+"/mne_python/MEEG_"+condcomb[c]+"_"+ListSubj[i]+"-ave.fif")
            
            tmp_evoked_meg  = mne.read_evokeds(fname_ave_meg,   condition=0, baseline=(-0.2, 0))
            evoked2plotmag.append(tmp_evoked_meg.pick_types('mag'))
            sensordatamat_meg_mag[c,i,::,::]  = tmp_evoked_meg.data
            
            tmp_evoked_meg  = mne.read_evokeds(fname_ave_meg,   condition=0, baseline=(-0.2, 0))
            evoked2plotgrad.append(tmp_evoked_meg.pick_types('grad'))
            sensordatamat_meg_grad[c,i,::,::]  = tmp_evoked_meg.data
            
            #tmp_evoked_meg  = mne.read_evokeds(fname_ave_meg,   condition=0, baseline=(-0.2, 0))
            #evoked2ploteeg.append(tmp_evoked_meg.pick_types('eeg'))
            #sensordatamat_eeg[c,i,::,::]  = tmp_evoked_meg.data
            
        
        GDAVGmag.append(mne.grand_average(evoked2plotmag))
        GDAVGgrad.append(mne.grand_average(evoked2plotgrad))
        #GDAVGeeg.append(mne.grand_average(evoked2ploteeg))
    
    # plot topomaps of grand_averages    
    plot_topo(GDAVGmag,color = colors)
    plt.savefig("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/decoding_context_yousra/"  
        + "_".join([str(cond) for cond in condcomb]) + "_GDAVG_mags")

    plot_topo(GDAVGgrad,color = colors)
    plt.savefig("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/decoding_context_yousra/"  
        + "_".join([str(cond) for cond in condcomb]) + "_GDAVG_grads")
    
    times = np.arange(-0.1, 0.9, 0.05)
    for c in range(len(condcomb)):
    
        GDAVGmag[c].plot_topomap(times, ch_type='mag', vmin = -40, vmax = 40, average=0.05)
        plt.savefig("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/decoding_context_yousra/"  
        + str(condcomb[c]) + "_GDAVG_mags")
        
        GDAVGgrad[c].plot_topomap(times, ch_type='grad',vmin = -10, vmax = 10, average=0.05)
        plt.savefig("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/GROUP/decoding_context_yousra/"  
        + str(condcomb[c]) + "_GDAVG_grads")
  
    allcond_meg_mag   = [np.transpose(x, (0, 2, 1)) for x in sensordatamat_meg_mag]    
    allcond_meg_grad  = [np.transpose(x, (0, 2, 1)) for x in sensordatamat_meg_grad] 

###############################################################################    

    t_threshold = -stats.distributions.t.ppf(0 / 2, len(ListSubj)-1)
    T_obs, clusters, cluster_p_values, HO = spatio_temporal_cluster_test(allcond_meg_mag[0::1], n_permutations=1024,
                                             threshold=t_threshold, tail=0, n_jobs=4,
                                             connectivity=connectivity_mag)
                                             
    t_threshold = -stats.distributions.t.ppf(0 / 2, len(ListSubj)-1)
    T_obs, clusters, cluster_p_values, HO = spatio_temporal_cluster_test(allcond_meg_grad, n_permutations=1024,
                                             threshold=t_threshold, tail=0, n_jobs=4,
                                             connectivity=connectivity_grad)
                                             
    # Select the clusters that are sig. at p < 0.05 (multiple-comparisons corrected value)
    #good_cluster_inds = np.where(cluster_p_values < 0.05)[0]
    #good_cluster_pval = cluster_p_values[good_cluster_inds]                                         
                                             
    #T_obs, clusters, p_values = cluster_stats_mag
    #good_cluster_inds = np.where(p_values < p_accept)[0]










