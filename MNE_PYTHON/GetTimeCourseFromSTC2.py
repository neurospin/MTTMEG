def GetTimeCourseFromSTC2(wdir,ListSubj,Conditions,modality,method,parcellation,colors):

	import glob
	from subprocess import call
	import mne
	import numpy as np
	import matplotlib
        matplotlib.use('Agg')
	import matplotlib.pyplot as pl
	import matplotlib.gridspec as gridspec
 
	source_subject = 'fsaverage'

	subjects_dir = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/mri/'
	
	if method == 'dSPM':
		methodtag = 'dSPMinverse'
	else: 	
		methodtag = method
	
	####################################################################
	## use fsaverage brain label with chosen parcellation
	labels = mne.read_labels_from_annot('fsaverage', parcellation, hemi='both', subjects_dir = subjects_dir)


	# get timecourse data from each subject & each label
	init_timepoints = mne.read_source_estimate(wdir + ListSubj[0] + '/mne_python/' + modality + '_' + ListSubj[0] + '_' + Conditions[0] + '_pick_oriNone_' + methodtag + '_ico-5-fwd-fsaverage.fif-rh.stc')
	TC_Label = np.empty([len(Conditions),len(ListSubj),len(labels),len(init_timepoints.times)])
	TCsd_Label = np.empty([len(Conditions),len(ListSubj),len(labels),len(init_timepoints.times)])
	for i in range(len(ListSubj)):
		for j in range(len(labels)-1):
			for c in range(len(Conditions)):
				stc = mne.read_source_estimate(wdir + ListSubj[i] + '/mne_python/' + modality + '_' + ListSubj[i] + '_' + Conditions[c] + '_pick_oriNone_' + methodtag + '_ico-5-fwd-fsaverage.fif-rh.stc')
				a = stc.in_label(labels[j])
				TC_Label[c,i,j,:] = np.mean(a.data[:,:], axis = 0)
	                        TCsd_Label[c,i,j,:] = np.std(a.data[:,:], axis = 0)
				del stc, a

	# suplot 2 conds per region
	for i in range(len(ListSubj)):

		gs = gridspec.GridSpec(8,5)

		fig1 = pl.figure(1,figsize=(16,10))
		for j in range(0,40):
			ax= pl.subplot(gs[(j/5), (j-(j/5)*5)])
			a=ax.get_xticks().tolist()
			for x in range(len(a)):
				a[x]=''
			ax.set_xticklabels(a)
			b=ax.get_yticks().tolist()
			for y in range(len(b)):
				b[y]=''
			ax.set_yticklabels(b)
			
			combcondname = ''
			for c in range(len(Conditions)):
				ax.plot(TC_Label[c,i,j,:],color = colors[c])
				ax.fill_between(range(TC_Label[c,i,j,:].shape[0]),TC_Label[c,i,j,:]-TCsd_Label[c,i,j,:], TC_Label[c,i,j,:]+TCsd_Label[c,i,j,:],
    				alpha=0.1, edgecolor=colors[c], facecolor=colors[c],linewidth=0)
				combcondname = combcondname + '_VS_' + Conditions[c]
	
			label = ax.set_xlabel(labels[j].name, fontsize = 10)
			ax.xaxis.set_label_coords(0.5, -0.035)
			pl.savefig("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/PLOTS/" + parcellation + "/" + modality + "_" + method + "/" + modality + '_' + combcondname + "_"+ListSubj[i]+'_part1')
	
		fig2 = pl.figure(2,figsize=(16,10))
		for j in range(0,40):
			ax= pl.subplot(gs[(j/5), (j-(j/5)*5)])
			a=ax.get_xticks().tolist()
			for x in range(len(a)):
				a[x]=''
			ax.set_xticklabels(a)
			b=ax.get_yticks().tolist()
			for y in range(len(b)):
				b[y]=''
			ax.set_yticklabels(b)

			combcondname = ''
			for c in range(len(Conditions)):
				ax.plot(TC_Label[c,i,j+40,:],color = colors[c])
				ax.fill_between(range(TC_Label[c,i,j+40,:].shape[0]),TC_Label[c,i,j+40,:]-TCsd_Label[c,i,j+40,:], TC_Label[c,i,j+40,:]+TCsd_Label[c,i,j+40,:],
    				alpha=0.1, edgecolor=colors[c], facecolor=colors[c],linewidth=0)
				combcondname = combcondname + '_VS_' + Conditions[c]

			label = ax.set_xlabel(labels[j+40].name, fontsize = 10)
			ax.xaxis.set_label_coords(0.5, -0.035)
			pl.savefig("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/PLOTS/" + parcellation + "/" + modality + "_" + method + "/" + modality + '_' + combcondname + "_"+ListSubj[i]+'_part2')
	
		fig3 = pl.figure(3,figsize=(16,10))
		for j in range(0,40):
			ax= pl.subplot(gs[(j/5), (j-(j/5)*5)])
			a=ax.get_xticks().tolist()
			for x in range(len(a)):
				a[x]=''
			ax.set_xticklabels(a)
			b=ax.get_yticks().tolist()
			for y in range(len(b)):
				b[y]=''
			ax.set_yticklabels(b)

			combcondname = ''
			for c in range(len(Conditions)):
				ax.plot(TC_Label[c,i,j+80,:],color = colors[c])
				ax.fill_between(range(TC_Label[c,i,j+80,:].shape[0]),TC_Label[c,i,j+80,:]-TCsd_Label[c,i,j+80,:], TC_Label[c,i,j+80,:]+TCsd_Label[c,i,j+80,:],
    				alpha=0.1, edgecolor=colors[c], facecolor=colors[c],linewidth=0)
				combcondname = combcondname + '_VS_' + Conditions[c]

			label = ax.set_xlabel(labels[j+80].name, fontsize = 10)
			ax.xaxis.set_label_coords(0.5, -0.035)
			pl.savefig("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/PLOTS/" + parcellation + "/" + modality + "_" + method + "/" + modality + '_' + combcondname + "_"+ListSubj[i]+'_part3')

		fig4 = pl.figure(4,figsize=(16,10))
		for j in range(0,28):
			ax= pl.subplot(gs[(j/5), (j-(j/5)*5)])
			a=ax.get_xticks().tolist()
			for x in range(len(a)):
				a[x]=''
			ax.set_xticklabels(a)
			b=ax.get_yticks().tolist()
			for y in range(len(b)):
				b[y]=''
			ax.set_yticklabels(b)

			combcondname = ''
			for c in range(len(Conditions)):
				ax.plot(TC_Label[c,i,j+120,:],color = colors[c])
				ax.fill_between(range(TC_Label[c,i,j+120,:].shape[0]),TC_Label[c,i,j+120,:]-TCsd_Label[c,i,j+120,:], TC_Label[c,i,j+120,:]+TCsd_Label[c,i,j+120,:],
    				alpha=0.1, edgecolor=colors[c], facecolor=colors[c],linewidth=0)
				combcondname = combcondname + '_VS_' + Conditions[c]

			label = ax.set_xlabel(labels[j+120].name, fontsize = 10)
			ax.xaxis.set_label_coords(0.5, -0.035)
			pl.savefig("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/PLOTS/" + parcellation + "/" + modality + "_" + method + "/" + modality + '_' + combcondname + "_"+ListSubj[i]+'_part4')


	# suplot 2 AVG across subjects
	TC_Label_mean = np.empty([len(Conditions),len(labels),len(init_timepoints.times)])
	TC_Label_std  = np.empty([len(Conditions),len(labels),len(init_timepoints.times)])
	
	for j in range(len(labels)-1):
		for c in range(len(Conditions)): 
			TC_Label_mean[c,j,:] = np.mean(TC_Label[c,:,j,:], axis = 0)
			TC_Label_std[c,j,:]  = (np.std(TC_Label[c,:,j,:], axis = 0))/np.sqrt(np.float32(len(ListSubj)))

	fig5 = pl.figure(5,figsize=(16,10))
	gs = gridspec.GridSpec(8,5)
	for j in range(0,40):
		ax= pl.subplot(gs[(j/5), (j-(j/5)*5)])
		a=ax.get_xticks().tolist()
		for x in range(len(a)):
			a[x]=''
		ax.set_xticklabels(a)
		b=ax.get_yticks().tolist()
		for y in range(len(b)):
			b[y]=''
		ax.set_yticklabels(b)
			
		combcondname = ''
		for c in range(len(Conditions)):
			ax.plot(TC_Label_mean[c,j,:],color = colors[c])
			ax.fill_between(range(TC_Label_mean[c,j,:].shape[0]),TC_Label_mean[c,j,:]-TC_Label_std[c,j,:], TC_Label_mean[c,j,:]+TC_Label_std[c,j,:], alpha=0.1, edgecolor=colors[c], facecolor=colors[c],linewidth=0)
			combcondname = combcondname + Conditions[c]
			if c < len(Conditions): 
				combcondname = combcondname + '_VS_'
	
		label = ax.set_xlabel(labels[j].name, fontsize = 10)
		ax.xaxis.set_label_coords(0.5, -0.035)
		pl.savefig("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/PLOTS/"+ parcellation + "/GROUP_" + modality + "_" + method + "/" + modality + '_' + combcondname +'_part1')

	fig6 = pl.figure(6,figsize=(16,10))
	for j in range(0,40):
		ax= pl.subplot(gs[(j/5), (j-(j/5)*5)])
		a=ax.get_xticks().tolist()
		for x in range(len(a)):
			a[x]=''
		ax.set_xticklabels(a)
		b=ax.get_yticks().tolist()
		for y in range(len(b)):
			b[y]=''
		ax.set_yticklabels(b)

		combcondname = ''
		for c in range(len(Conditions)):
			ax.plot(TC_Label_mean[c,j+40,:],color = colors[c])
			ax.fill_between(range(TC_Label_mean[c,j+40,:].shape[0]),TC_Label_mean[c,j+40,:]-TC_Label_std[c,j+40,:], TC_Label_mean[c,j+40,:]+TC_Label_std[c,j+40,:], alpha=0.1, edgecolor=colors[c], facecolor=colors[c],linewidth=0)
			combcondname = combcondname + Conditions[c]
			if c < len(Conditions): 
				combcondname = combcondname + '_VS_'

		label = ax.set_xlabel(labels[j+40].name, fontsize = 10)
		ax.xaxis.set_label_coords(0.5, -0.035)
		pl.savefig("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/PLOTS/"+ parcellation + "/GROUP_" + modality + "_" + method + "/" + modality + '_' + combcondname +'_part2')

	fig7 = pl.figure(7,figsize=(16,10))
	for j in range(0,40):
		ax= pl.subplot(gs[(j/5), (j-(j/5)*5)])
		a=ax.get_xticks().tolist()
		for x in range(len(a)):
			a[x]=''
		ax.set_xticklabels(a)
		b=ax.get_yticks().tolist()
		for y in range(len(b)):
			b[y]=''
		ax.set_yticklabels(b)
			
		combcondname = ''
		for c in range(len(Conditions)):
			ax.plot(TC_Label_mean[c,j+80,:],color = colors[c])
			ax.fill_between(range(TC_Label_mean[c,j+80,:].shape[0]),TC_Label_mean[c,j+80,:]-TC_Label_std[c,j+80,:], TC_Label_mean[c,j+80,:]+TC_Label_std[c,j+80,:], alpha=0.1, edgecolor=colors[c], facecolor=colors[c],linewidth=0)
			combcondname = combcondname + Conditions[c]
			if c < len(Conditions): 
				combcondname = combcondname + '_VS_'
	
		label = ax.set_xlabel(labels[j+80].name, fontsize = 10)
		ax.xaxis.set_label_coords(0.5, -0.035)
		pl.savefig("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/PLOTS/"+ parcellation + "/GROUP_" + modality + "_" + method + "/" + modality + '_' + combcondname +'_part3')

	fig8 = pl.figure(8,figsize=(16,10))
	for j in range(0,28):
		ax= pl.subplot(gs[(j/5), (j-(j/5)*5)])
		a=ax.get_xticks().tolist()
		for x in range(len(a)):
			a[x]=''
		ax.set_xticklabels(a)
		b=ax.get_yticks().tolist()
		for y in range(len(b)):
			b[y]=''
		ax.set_yticklabels(b)

		combcondname = ''
		for c in range(len(Conditions)):
			ax.plot(TC_Label_mean[c,j+120,:],color = colors[c])
			ax.fill_between(range(TC_Label_mean[c,j+120,:].shape[0]),TC_Label_mean[c,j+120,:]-TC_Label_std[c,j+120,:], TC_Label_mean[c,j+120,:]+TC_Label_std[c,j+120,:], alpha=0.1, edgecolor=colors[c], facecolor=colors[c],linewidth=0)
			combcondname = combcondname + Conditions[c]
			if c < len(Conditions): 
				combcondname = combcondname + '_VS_'

		label = ax.set_xlabel(labels[j+120].name, fontsize = 10)
		ax.xaxis.set_label_coords(0.5, -0.035)
		pl.savefig("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/PLOTS/"+ parcellation + "/GROUP_" + modality + "_" + method + "/" + modality + '_' + combcondname +'_part4')


	pl.close(fig1)
	pl.close(fig2)
	pl.close(fig3)
	pl.close(fig4)
	pl.close(fig5)
	pl.close(fig6)
	pl.close(fig7)
	pl.close(fig8)



