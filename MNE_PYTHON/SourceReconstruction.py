def SourceReconstruction(condnames,ListSubj):

    #ipython --pylab
    import mne
    from mne.minimum_norm import apply_inverse, make_inverse_operator
    from mne.beamformer import lcmv
    import os
    os.chdir('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS/MNE_PYTHON')
    
    os.environ['SUBJECTS_DIR'] = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/mri'
    os.environ['MNE_ROOT'] = '/neurospin/local/mne'
    
    wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"
    #wdir = "/media/bgauthie/Seagate Backup Plus Drive/TMP_MEG_SOURCE/MEG/"

    for i in range(len(ListSubj)):

    	# open a text logfile
    	logfile = open(wdir+ListSubj[i]+"/mne_python/logfile_preproc.txt", "w")

    	# load covariance matrices
    	fname_fwd_eeg  =(wdir+ListSubj[i]+"/mne_python/run3_ico-5_eegonly_-fwd.fif") 
	fname_fwd_meg  =(wdir+ListSubj[i]+"/mne_python/run3_ico-5_megonly_-fwd.fif") 
	fname_fwd_meeg =(wdir+ListSubj[i]+"/mne_python/run3_ico-5_meeg_-fwd.fif") 
     
	fname_noisecov1 =(wdir+ListSubj[i]+"/mne_python/MEGnoisecov_"+condnames+"_"+ListSubj[i]+"-cov.fif")
	fname_noisecov2 =(wdir+ListSubj[i]+"/mne_python/EEGnoisecov_"+condnames+"_"+ListSubj[i]+"-cov.fif")
	fname_noisecov3 =(wdir+ListSubj[i]+"/mne_python/MEEGnoisecov_"+condnames+"_"+ListSubj[i]+"-cov.fif")   

	fname_datacov1 =(wdir+ListSubj[i]+"/mne_python/MEGdatacov_"+condnames+"_"+ListSubj[i]+"-cov.fif")
	fname_datacov2 =(wdir+ListSubj[i]+"/mne_python/EEGdatacov_"+condnames+"_"+ListSubj[i]+"-cov.fif")
	fname_datacov3 =(wdir+ListSubj[i]+"/mne_python/MEEGdatacov_"+condnames+"_"+ListSubj[i]+"-cov.fif")
 	
	forward_meg = mne.read_forward_solution(fname_fwd_meg ,surf_ori=True)
	forward_eeg  = mne.read_forward_solution(fname_fwd_eeg ,surf_ori=True)
	forward_meeg = mne.read_forward_solution(fname_fwd_meeg,surf_ori=True)
	
	fname_ave_meg   =(wdir+ListSubj[i]+"/mne_python/MEG_"+condnames+"_"+ListSubj[i]+"-ave.fif")
	fname_ave_eeg   =(wdir+ListSubj[i]+"/mne_python/EEG_"+condnames+"_"+ListSubj[i]+"-ave.fif")
	fname_ave_meeg  =(wdir+ListSubj[i]+"/mne_python/MEEG_"+condnames+"_"+ListSubj[i]+"-ave.fif") 

	NOISE_COV1_meg  = mne.read_cov(fname_noisecov1)
	NOISE_COV1_eeg  = mne.read_cov(fname_noisecov2)
	NOISE_COV1_meeg = mne.read_cov(fname_noisecov3)

	DATA_COV1_meg  = mne.read_cov(fname_datacov1)
	DATA_COV1_eeg  = mne.read_cov(fname_datacov2)
	DATA_COV1_meeg = mne.read_cov(fname_datacov3)

	# load evoked
	evokedcond1_meg  = mne.read_evokeds(fname_ave_meg,  condition=0, baseline=(-0.2, 0))
	evokedcond1_eeg  = mne.read_evokeds(fname_ave_eeg,  condition=0, baseline=(-0.2, 0))
	evokedcond1_meeg = mne.read_evokeds(fname_ave_meeg, condition=0, baseline=(-0.2, 0))

    	inverse_operator1_meg  = make_inverse_operator(evokedcond1_meg.info,  forward_meg, NOISE_COV1_meg,  loose=0.2, depth=0.8)
	inverse_operator1_eeg  = make_inverse_operator(evokedcond1_eeg.info,  forward_eeg, NOISE_COV1_eeg,  loose=0.2, depth=0.8)
	inverse_operator1_meeg = make_inverse_operator(evokedcond1_meeg.info, forward_meeg, NOISE_COV1_meeg, loose=0.2, depth=0.8)
	
#################################################################################################################################
	# dSPM solution #
#################################################################################################################################
    	snr = 3.0
    	lambda2 = 1.0 / snr **2
    	
	# MEG source reconstruction
    	stccond1_meg     = apply_inverse(evokedcond1_meg, inverse_operator1_meg, lambda2,method ='dSPM', pick_ori= None)
    	stccond1_meg.save(wdir+ListSubj[i]+"/mne_python/MEG_"+ListSubj[i]+"_"+condnames+"_pick_oriNone_dSPMinverse_ico-5-fwd.fif")
    	stccond1norm_meg = apply_inverse(evokedcond1_meg, inverse_operator1_meg, lambda2,method ='dSPM', pick_ori= "normal")
    	stccond1norm_meg.save(wdir+ListSubj[i]+"/mne_python/MEG_"+ListSubj[i]+"_"+condnames+"_pick_orinormal_dSPMinverse_ico-5-fwd.fif")

    	stc_fsaverage_cond1_meg = mne.morph_data(ListSubj[i], 'fsaverage', stccond1_meg)
    	stc_fsaverage_cond1_meg.save(wdir+ListSubj[i]+"/mne_python/MEG_"+ListSubj[i]+"_"+condnames+"_pick_oriNone_dSPMinverse_ico-5-fwd-fsaverage.fif")
    	stc_fsaverage_cond1norm_meg = mne.morph_data(ListSubj[i], 'fsaverage', stccond1norm_meg)
    	stc_fsaverage_cond1norm_meg.save(wdir+ListSubj[i]+"/mne_python/MEG_"+ListSubj[i]+"_"+condnames+"_pick_orinormal_dSPMinverse_ico-5-fwd-fsaverage.fif")
    
    	logfile.write("" "\n") 
    	logfile.write("processing subject " +ListSubj[i]+"\n")
    	logfile.write("MEG dSPM source reconstruction: orinone & orinormal "+"\n")  
    	logfile.write("Morphing on fsaverage "+"\n")  
    	logfile.write("" "\n")           

	# EEG source reconstruction
    	stccond1_eeg = apply_inverse(evokedcond1_eeg, inverse_operator1_eeg, lambda2,method ='dSPM', pick_ori= None)
    	stccond1_eeg.save(wdir+ListSubj[i]+"/mne_python/EEG_"+ListSubj[i]+"_"+condnames+"_pick_oriNone_dSPMinverse_ico-5-fwd.fif")
    	stccond1norm_eeg = apply_inverse(evokedcond1_eeg, inverse_operator1_eeg, lambda2,method ='dSPM', pick_ori= "normal")
    	stccond1norm_eeg.save(wdir+ListSubj[i]+"/mne_python/EEG_"+ListSubj[i]+"_"+condnames+"_pick_orinormal_dSPMinverse_ico-5-fwd.fif")
    
    	stc_fsaverage_cond1_eeg = mne.morph_data(ListSubj[i], 'fsaverage', stccond1_eeg)
    	stc_fsaverage_cond1_eeg.save(wdir+ListSubj[i]+"/mne_python/EEG_"+ListSubj[i]+"_"+condnames+"_pick_oriNone_dSPMinverse_ico-5-fwd-fsaverage.fif")
    	stc_fsaverage_cond1bis_eeg = mne.morph_data(ListSubj[i], 'fsaverage', stccond1norm_eeg)
    	stc_fsaverage_cond1bis_eeg.save(wdir+ListSubj[i]+"/mne_python/EEG_"+ListSubj[i]+"_"+condnames+"_pick_orinormal_dSPMinverse_ico-5-fwd-fsaverage.fif")
    
    	logfile.write("" "\n") 
    	logfile.write("processing subject " +ListSubj[i]+"\n")
    	logfile.write("EEG dSPM source reconstruction: orinone & orinormal "+"\n")  
    	logfile.write("Morphing on fsaverage "+"\n")  
    	logfile.write("" "\n")    
    
	# MEEG source reconstruction
    	stccond1_meeg = apply_inverse(evokedcond1_meeg, inverse_operator1_meeg, lambda2,method ='dSPM', pick_ori= None)
    	stccond1_meeg.save(wdir+ListSubj[i]+"/mne_python/MEEG_"+ListSubj[i]+"_"+condnames+"_pick_oriNone_dSPMinverse_ico-5-fwd.fif")
    	stccond1norm_meeg = apply_inverse(evokedcond1_meeg, inverse_operator1_meeg, lambda2,method ='dSPM', pick_ori= "normal")
    	stccond1norm_meeg.save(wdir+ListSubj[i]+"/mne_python/MEEG_"+ListSubj[i]+"_"+condnames+"_pick_orinormal_dSPMinverse_ico-5-fwd.fif")
    
    	stc_fsaverage_cond1_meeg = mne.morph_data(ListSubj[i], 'fsaverage', stccond1_meeg)
    	stc_fsaverage_cond1_meeg.save(wdir+ListSubj[i]+"/mne_python/MEEG_"+ListSubj[i]+"_"+condnames+"_pick_oriNone_dSPMinverse_ico-5-fwd-fsaverage.fif")
    	stc_fsaverage_cond1bis_meeg = mne.morph_data(ListSubj[i], 'fsaverage', stccond1norm_meeg)
    	stc_fsaverage_cond1bis_meeg.save(wdir+ListSubj[i]+"/mne_python/MEEG_"+ListSubj[i]+"_"+condnames+"_pick_orinormal_dSPMinverse_ico-5-fwd-fsaverage.fif")

    	logfile.write("" "\n") 
    	logfile.write("processing subject " +ListSubj[i]+"\n")
    	logfile.write("MEEG dSPM source reconstruction: orinone & orinormal "+"\n")  
    	logfile.write("Morphing on fsaverage "+"\n")  
    	logfile.write("" "\n")   

#################################################################################################################################
	# LCMV Beamformer #
#################################################################################################################################
    	# MEG source reconstruction    
    	stccond1_meg = lcmv(evokedcond1_meg, forward_meg, NOISE_COV1_meg,DATA_COV1_meg, reg=0.01,pick_ori= None)
    	stccond1_meg.save(wdir+ListSubj[i]+"/mne_python/MEG_"+ListSubj[i]+"_"+condnames+"_pick_oriNone_LCMV_ico-5-fwd.fif")
    	stccond1norm_meg = lcmv(evokedcond1_meg, forward_meg, NOISE_COV1_meg,DATA_COV1_meg, reg=0.01,pick_ori= "normal")
    	stccond1norm_meg.save(wdir+ListSubj[i]+"/mne_python/MEG_"+ListSubj[i]+"_"+condnames+"_pick_orinormal_LCMV_ico-5-fwd.fif")
    
    	stc_fsaverage_cond1_meg = mne.morph_data(ListSubj[i], 'fsaverage', stccond1_meg)
    	stc_fsaverage_cond1_meg.save(wdir+ListSubj[i]+"/mne_python/MEG_"+ListSubj[i]+"_"+condnames+"_pick_oriNone_LCMV_ico-5-fwd-fsaverage.fif")
    	stc_fsaverage_cond1norm_meg = mne.morph_data(ListSubj[i], 'fsaverage', stccond1norm_meg)
    	stc_fsaverage_cond1norm_meg.save(wdir+ListSubj[i]+"/mne_python/MEG_"+ListSubj[i]+"_"+condnames+"_pick_orinormal_LCMV_ico-5-fwd-fsaverage.fif")   
    
   	logfile.write("" "\n") 
    	logfile.write("processing subject " +ListSubj[i]+"\n")
    	logfile.write("MEG LCMV source reconstruction: orinone & orinormal "+"\n")  
    	logfile.write("Morphing on fsaverage "+"\n")  
    	logfile.write("" "\n")    
    
     	# EEG source reconstruction    
    	stccond1_eeg = lcmv(evokedcond1_eeg, forward_eeg, NOISE_COV1_eeg,DATA_COV1_eeg, reg=0.01,pick_ori= None)
    	stccond1_eeg.save(wdir+ListSubj[i]+"/mne_python/EEG_"+ListSubj[i]+"_"+condnames+"_pick_oriNone_LCMV_ico-5-fwd.fif")
    	stccond1norm_eeg = lcmv(evokedcond1_eeg, forward_eeg, NOISE_COV1_eeg,DATA_COV1_eeg, reg=0.01,pick_ori= "normal")
    	stccond1norm_eeg.save(wdir+ListSubj[i]+"/mne_python/EEG_"+ListSubj[i]+"_"+condnames+"_pick_orinormal_LCMV_ico-5-fwd.fif")
    
    	stc_fsaverage_cond1_eeg = mne.morph_data(ListSubj[i], 'fsaverage', stccond1_eeg)
    	stc_fsaverage_cond1_eeg.save(wdir+ListSubj[i]+"/mne_python/EEG_"+ListSubj[i]+"_"+condnames+"_pick_oriNone_LCMV_ico-5-fwd-fsaverage.fif")
    	stc_fsaverage_cond1norm_eeg = mne.morph_data(ListSubj[i], 'fsaverage', stccond1norm_eeg)
    	stc_fsaverage_cond1norm_eeg.save(wdir+ListSubj[i]+"/mne_python/EEG_"+ListSubj[i]+"_"+condnames+"_pick_orinormal_LCMV_ico-5-fwd-fsaverage.fif")   
    
    	logfile.write("" "\n") 
    	logfile.write("processing subject " +ListSubj[i]+"\n")
    	logfile.write("EEG dSPM source reconstruction: orinone & orinormal "+"\n")  
    	logfile.write("Morphing on fsaverage "+"\n")  
    	logfile.write("" "\n")          
       
        # MEEG source reconstruction    
   	stccond1_meeg = lcmv(evokedcond1_meeg, forward_meeg, NOISE_COV1_meeg,DATA_COV1_meeg, reg=0.01,pick_ori= None)
    	stccond1_meeg.save(wdir+ListSubj[i]+"/mne_python/MEEG_"+ListSubj[i]+"_"+condnames+"_pick_oriNone_LCMV_ico-5-fwd.fif")
    	stccond1norm_meeg = lcmv(evokedcond1_meeg, forward_meeg, NOISE_COV1_meeg,DATA_COV1_meeg, reg=0.01,pick_ori= "normal")
    	stccond1norm_meeg.save(wdir+ListSubj[i]+"/mne_python/MEEG_"+ListSubj[i]+"_"+condnames+"_pick_orinormal_LCMV_ico-5-fwd.fif")
    
    	stc_fsaverage_cond1_meeg = mne.morph_data(ListSubj[i], 'fsaverage', stccond1_meeg)
    	stc_fsaverage_cond1_meeg.save(wdir+ListSubj[i]+"/mne_python/MEEG_"+ListSubj[i]+"_"+condnames+"_pick_oriNone_LCMV_ico-5-fwd-fsaverage.fif")
    	stc_fsaverage_cond1norm_meeg = mne.morph_data(ListSubj[i], 'fsaverage', stccond1norm_meeg)
    	stc_fsaverage_cond1norm_meeg.save(wdir+ListSubj[i]+"/mne_python/MEEG_"+ListSubj[i]+"_"+condnames+"_pick_orinormal_LCMV_ico-5-fwd-fsaverage.fif")   
      
    	logfile.write("" "\n") 
    	logfile.write("processing subject " +ListSubj[i]+"\n")
    	logfile.write("MEEG dSPM source reconstruction: orinone & orinormal "+"\n")  
    	logfile.write("Morphing on fsaverage "+"\n")  
    	logfile.write("" "\n")  

	logfile.close()     


