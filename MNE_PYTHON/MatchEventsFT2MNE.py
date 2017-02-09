def MatchEventsFT2MNE(eventsMNE,eventFT):

	import mne
	import numpy as np
	import scipy
	import matplotlib
	from scipy import io
	from matplotlib import pyplot as plt
	from matplotlib import image as mpimg
	from mne.minimum_norm import apply_inverse, make_inverse_operator
	import os
	os.chdir('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS/MNE_PYTHON')

	#rolling_window(eventsMNE, 10) == eventsFT[20:30,7]
	#item = np.where(eventsMNE[:,2] == eventsFT[20:30,7])
	#[x for x in xrange(len(eventsMNE[:,2])) if eventsMNE[x:x+len(eventsFT[20:30,7]),2] == eventsFT[20:30,7]]
	#index = as_strided(eventsMNE[:,2],shape=(len(eventsMNE[:,2] -10 +1,10),strides=(may_a.dtype.itemsize,) * 2)
	#for i in range(len(eventsMNE[:,2])-11):
	#	blah = np.where(np.all(eventsMNE[i:(i+9),2] == eventsFT[1:20,7]))
	#	if blah[0][0] == 0:
	#		tag = i
	#
	#return tag	
	
	#for k in range(eventsMNE.shape[0]):
	#	eventsMNE[k,0] = eventsMNE[k,0] - eventsMNE[0,0] 

	#for k in range(eventsFT.shape[0]):
	#	eventsFT[k,0] = eventsFT[k,0] - eventsFT[0,0] 

	newevents = np.zeros([1,3])

	#count = 0;
	for i in range(len(eventFT)):
		for j in range(eventsMNE.shape[0]):
			if eventsMNE[j,0] == eventFT[i,0]:
				#newevents[count,0] = eventsMNE[j,0]
				#newevents[count,1] = eventsMNE[j,1]
				#newevents[count,2] = eventFT[i,4]
				newevents = np.append(newevents,[[eventsMNE[j,0],eventsMNE[j,1],eventFT[i,3]]],axis=0)
				#count = count +1
	
	
	newevents = np.delete(newevents,0,0)
	
	return newevents
