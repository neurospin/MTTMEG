import os

root =  "/media/bgauthie/Seagate Backup Plus Drive/TMP_MEG_SOURCE/MEG/"

ListSubj= ('sd130343', 'cb130477', 'rb130313', 'jm100042',  'jm100109', 'sb120316', 'tk130502', 'lm130479',
'ms130534','ma100253', 'sl130503','mb140004', 'mp140019', 'dm130250', 'hr130504', 'wl130316', 'rl130571')

for s in range(len(ListSubj)):
	Allfile = os.listdir(root + ListSubj[s] + '/mne_python/')
	for i in range(len(Allfile)):
    
		if Allfile[i].find('dPSM') != -1:
			os.rename((root + ListSubj[s] + '/mne_python/' + Allfile[i]), (root + ListSubj[s] + '/mne_python/' + Allfile[i].replace('dPSM','dSPM')))

##############################
import os
import shutil

root  = "/media/bgauthie/Seagate Backup Plus Drive/TMP_MEG_SOURCE/MEG/"
root2 = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/"

ListSubj= ('sd130343', 'cb130477', 'rb130313', 'jm100042',  'jm100109', 'sb120316', 'tk130502', 'lm130479',
'sg120518','ms130534','ma100253', 'sl130503','mb140004', 'mp140019', 'dm130250', 'hr130504', 'wl130316', 'rl130571')

for s in range(len(ListSubj)):
	Allfile = os.listdir(root + ListSubj[s] + '/mne_python/')

	for i in range(len(Allfile)):
		if Allfile[i].find('preproc') != -1:
			shutil.copy((root + ListSubj[s] + '/mne_python/'+ Allfile[i]),(root2 + ListSubj[s] + '/mne_python/'+Allfile[i]))
		elif Allfile[i].find('run3') != -1:
			shutil.copy((root + ListSubj[s] + '/mne_python/'+ Allfile[i]),(root2 + ListSubj[s] + '/mne_python/'+Allfile[i]))
