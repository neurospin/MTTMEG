import glob
from subprocess import call
import mne
import numpy as np
import matplotlib.pyplot as pl
import matplotlib.gridspec as gridspec
 
#ListSubj= ('sd130343', 'cb130477', 'rb130313', 'jm100042',  'jm100109', 'sb120316', 'tk130502', 'lm130479',
#'sg120518','ms130534','ma100253', 'sl130503','mb140004', 'mp140019', 'dm130250', 'hr130504', 'wl130316', 'rl130571')
    
ListSubj= ['sd130343', 'cb130477', 'rb130313', 'jm100042',  'jm100109', 'sb120316', 'tk130502', 'lm130479',
'ms130534','ma100253', 'sl130503','mb140004', 'mp140019', 'dm130250', 'hr130504', 'wl130316', 'rl130571']

source_subject = 'fsaverage'

#wdir = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/'
#subjects_dir = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/mri/'

wdir = "/media/bgauthie/Seagate Backup Plus Drive/TMP_MEG_SOURCE/MEG/"
subjects_dir = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/mri/'

####################################################################
## Morph labels in parcellation on subject brain from fsaverage brain label

labels = mne.read_labels_from_annot('fsaverage', 'aparc', hemi='both', subjects_dir = subjects_dir)

# write subject-wise morphed labels from fsaverage parcellation
#for subject in ListSubj:
#	for label in labels:
#		label.values.fill(1.)
#		label_target = label.morph(source_subject, subject, subjects_dir = subjects_dir)f, axarr = pl.subplots(7,5)
#		label_target.save(subjects_dir + '%s/label/%s' % (subject, label.name))

# get timecourse data from each subject & each label
init_timepoints = mne.read_source_estimate(wdir + ListSubj[0] + '/mne_python/MEG_' + ListSubj[0] + '_Qt_all_pick_oriNone_dSPMinverse_ico-5-fwd.fif-rh.stc')
TC_Label_Qt_all = np.empty([len(ListSubj),len(labels),len(init_timepoints.times)])
TC_Label_Qs_all = np.empty([len(ListSubj),len(labels),len(init_timepoints.times)])
for i in range(len(ListSubj)):
	labels = mne.read_labels_from_annot(ListSubj[i], 'aparc', hemi='both', subjects_dir = subjects_dir)
	for j in range(len(labels)-1):
		stc_Qt_all = mne.read_source_estimate(wdir + ListSubj[i] + '/mne_python/MEG_' + ListSubj[i] + '_Qt_all_pick_oriNone_dSPMinverse_ico-5-fwd.fif-rh.stc')
		stc_Qs_all = mne.read_source_estimate(wdir + ListSubj[i] + '/mne_python/MEG_' + ListSubj[i] + '_Qs_all_pick_oriNone_dSPMinverse_ico-5-fwd.fif-rh.stc')
		a = stc_Qt_all.in_label(labels[j])
		b = stc_Qs_all.in_label(labels[j])
		TC_Label_Qt_all[i,j,:] = np.mean(a.data[:,:], axis = 0)
		TC_Label_Qs_all[i,j,:] = np.mean(b.data[:,:], axis = 0)
		del stc_Qt_all, stc_Qs_all

# suplot 2 conds per region
for i in range(len(ListSubj)):

	fig1 = pl.figure(0)
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
		ax.plot(TC_Label_Qt_all[i,j,:],'r')
		ax.plot(TC_Label_Qs_all[i,j,:],'b')
		label = ax.set_xlabel(labels[j].name, fontsize = 10)
		ax.xaxis.set_label_coords(0.5, -0.035)
		plt.savefig("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/PLOTS/Qt_all_vs_Qs_all_"+ListSubj[i]+'_part1')

	fig2 = pl.figure(1)
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
		ax.plot(TC_Label_Qt_all[i,j+34,:],'r')
		ax.plot(TC_Label_Qs_all[i,j+34,:],'b')
		label = ax.set_xlabel(labels[j].name, fontsize = 10)
		ax.xaxis.set_label_coords(0.5, -0.035)
		plt.savefig("/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/PLOTS/Qt_all_vs_Qs_all_"+ListSubj[i]+'_part2')














