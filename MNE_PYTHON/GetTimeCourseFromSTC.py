def GetTimeCourseFromTSC(wdir,ListSubj,Conditions,modality,method,parcellation,colors):

	import glob
	from subprocess import call
	import mne
	import numpy as np
	import matplotlib.pyplot as pl
	import matplotlib.gridspec as gridspec
 
	source_subject = 'fsaverage'

	subjects_dir = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/mri/'
	
	if method == 'dSPM':
		methodtag = 'dSPMinverse'
	else: 	
		methodtag = method
	
	####################################################################
	## Morph labels in parcellation on subject brain from fsaverage brain label
	labels = mne.read_labels_from_annot('fsaverage', parcellation, hemi='both', subjects_dir = subjects_dir)

	# write subject-wise morphed labels from fsaverage parcellation
	#for subject in ListSubj:
	#	for label in labels:
	#		label.values.fill(1.)
	#		label_target = label.morph(source_subject, subject, subjects_dir = subjects_dir)f, axarr = pl.subplots(7,5)
	#		label_target.save(subjects_dir + '%s/label/%s' % (subject, label.name))

	# get timecourse data from each subject & each label
	init_timepoints = mne.read_source_estimate(wdir + ListSubj[0] + '/mne_python/' + modality + '_' + ListSubj[0] + '_' + Conditions[0] + '_pick_oriNone_' + methodtag + '_ico-5-fwd-fsaverage.fif-rh.stc')
	TC_Label = np.empty([len(Conditions),len(ListSubj),len(labels),len(init_timepoints.times)])
	for i in range(len(ListSubj)):
		for j in range(len(labels)-1):
			for c in range(len(Conditions)):
				stc = mne.read_source_estimate(wdir + ListSubj[i] + '/mne_python/' + modality + '_' + ListSubj[i] + '_' + Conditions[c] + '_pick_oriNone_' + methodtag + '_ico-5-fwd-fsaverage.fif-rh.stc')
				a = stc.in_label(labels[j])
				TC_Label[c,i,j,:] = np.mean(a.data[:,:], axis = 0)
				del stc, a

	# suplot 2 conds per region
	for i in range(len(ListSubj)):

		fig1 = pl.figure(0,figsize=(16,10))
		gs = gridspec.GridSpec(9,4)
		for j in range(0,34):
			ax= pl.subplot(gs[(j/4), (j-(j/4)*4)])
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
				ax.plot(TC_Label[c,i,j,:],colors[c])
				combcondname = combcondname + '_VS_' + Conditions[c]
	
			label = ax.set_xlabel(labels[j].name, fontsize = 10)
			ax.xaxis.set_label_coords(0.5, -0.035)
			pl.savefig("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/PLOTS/" + parcellation + modality + "_" + method + "/" + modality + '_' + combcondname + "_"+ListSubj[i]+'_part1')
	
		fig2 = pl.figure(1,figsize=(16,10))
		for j in range(0,34):
			ax= pl.subplot(gs[(j/4), (j-(j/4)*4)])
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
				ax.plot(TC_Label[c,i,j+34,:],colors[c])
				combcondname = combcondname + '_VS_' + Conditions[c]

			label = ax.set_xlabel(labels[j+34].name, fontsize = 10)
			ax.xaxis.set_label_coords(0.5, -0.035)
			pl.savefig("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/PLOTS/" + parcellation + modality + "_" + method + "/" + modality + '_' + combcondname + "_"+ListSubj[i]+'_part2')
	
	# suplot 2 AVG across subjects
	TC_Label_mean = np.empty([len(Conditions),len(labels),len(init_timepoints.times)])
	
	for j in range(len(labels)-1):
		for c in range(len(Conditions)): 
			TC_Label_mean[c,j,:] = np.mean(TC_Label[c,:,j,:], axis = 0)	

	fig3 = pl.figure(2,figsize=(16,10))
	gs = gridspec.GridSpec(9,4)
	for j in range(0,34):
		ax= pl.subplot(gs[(j/4), (j-(j/4)*4)])
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
			ax.plot(TC_Label_mean[c,j,:],colors[c])
			combcondname = combcondname + Conditions[c]
			if c < len(Conditions): 
				combcondname = combcondname + '_VS_'
	
		label = ax.set_xlabel(labels[j].name, fontsize = 10)
		ax.xaxis.set_label_coords(0.5, -0.035)
		pl.savefig("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/PLOTS/GROUP_" + parcellation + modality + "_" + method + "/" + modality + '_' + combcondname +'_part1')

	fig4 = pl.figure(3,figsize=(16,10))
	for j in range(0,34):
		ax= pl.subplot(gs[(j/4), (j-(j/4)*4)])
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
			ax.plot(TC_Label_mean[c,j+34,:],colors[c])
			combcondname = combcondname + Conditions[c]
			if c < len(Conditions): 
				combcondname = combcondname + '_VS_'

		label = ax.set_xlabel(labels[j+34].name, fontsize = 10)
		ax.xaxis.set_label_coords(0.5, -0.035)
		pl.savefig("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/PLOTS/GROUP_" + parcellation + modality + "_" + method + "/" + modality + '_' + combcondname +'_part2')

	pl.close(fig1)
	pl.close(fig2)
	pl.close(fig3)
	pl.close(fig4)




