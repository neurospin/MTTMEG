# -*- coding: utf-8 -*-
"""
Created on Wed Aug  3 18:46:27 2016

@author: bgauthie
"""

# -*- coding: utf-8 -*-
"""
Created on Thu Apr 14 16:32:56 2016

@author: bgauthie
"""

####################################################################
# This script generate jobs.py files and creates a somwf file
# containing the jobs to be send to the cluster with soma_workflow
# you can then launch and follow the processing with soma_workflow interface

####################################################################
# import libraries
from soma_workflow.client import Job, Workflow, Helper
import os
os.chdir('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS/MNE_PYTHON')

####################################################################
# define parameters
subjects_dir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG"
path_script  = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS/MNE_PYTHON"

modalities = ('MEEG',)
megtags    = ('True',)
eegtags    = ('True',)

ListSubj = (
	   'sd130343',
        'cb130477', 
        'rb130313', 
        'jm100042',
        'jm100109', 
        'sb120316', 
        'tk130502',
        'lm130479', 
        'ms130534', 
        'ma100253', 
        'sl130503', 
        'mb140004',
        'mp140019', 
        'dm130250', 
        'hr130504', 
        'wl130316', 
        'rl130571',
 	   'sg120518')          

listRunPerSubj = (
        ('run1_GD','run2_GD'),
        ('run1_GD','run2_GD'),
        ('run2_GD',),
        ('run1_GD','run2_GD'),
        ('run1_GD','run2_GD'),
        ('run1_GD','run2_GD'),
        ('run1_GD','run2_GD'),
        ('run1_GD','run2_GD'),
        ('run1_GD','run2_GD'),
        ('run1_GD','run2_GD'),
        ('run1_GD','run2_GD'),
        ('run1_GD','run2_GD'),
        ('run1_GD','run2_GD'),
        ('run1_GD','run2_GD'),
        ('run1_GD','run2_GD'),
        ('run1_GD','run2_GD'),
        ('run1_GD','run2_GD'),       
        ('run1_GD','run2_GD'))

#listRunPerSubj = (
#        ('run1_GD','run2_GD','run3_DG','run4_DG'),
#        ('run1_GD','run2_GD','run3_DG','run4_DG'),
#        ('run2_GD','run3_DG'),
#        ('run1_GD','run2_GD','run3_DG','run4_DG'),
#        ('run1_GD','run2_GD','run3_DG','run4_DG'),
#        ('run1_GD','run2_GD','run3_DG','run4_DG'),
#        ('run1_GD','run2_GD','run3_DG','run4_DG'),
#        ('run1_GD','run2_GD','run3_DG','run4_DG'),
#        ('run1_GD','run2_GD','run3_DG','run4_DG'),
#        ('run1_GD','run2_GD','run3_DG','run4_DG'),
#        ('run1_GD','run2_GD','run3_DG','run4_DG'),
#        ('run1_GD','run2_GD','run3_DG','run4_DG'),
#        ('run1_GD','run2_GD','run3_DG','run4_DG'),
#        ('run1_GD','run2_GD','run3_DG','run4_DG'),
#        ('run1_GD','run2_GD','run3_DG','run4_DG'),
#        ('run1_GD','run2_GD','run3_DG','run4_DG'),
#        ('run1_GD','run2_GD','run3_DG','run4_DG'),     
#        ('run1_GD','run2_GD','run3_DG','run4_DG'),)

#listRunPerSubj = (
#        ('run3_DG','run4_DG'),
#        ('run3_DG','run4_DG'),
#        ('run3_DG',),
#        ('run3_DG','run4_DG'),
#        ('run3_DG','run4_DG'),
#        ('run3_DG','run4_DG'),
#        ('run3_DG','run4_DG'),
#        ('run3_DG','run4_DG'),
#        ('run3_DG','run4_DG'),
#        ('run3_DG','run4_DG'),
#        ('run3_DG','run4_DG'),
#        ('run3_DG','run4_DG'),
#        ('run3_DG','run4_DG'),
#        ('run3_DG','run4_DG'),
#        ('run3_DG','run4_DG'),
#        ('run3_DG','run4_DG'),
#        ('run3_DG','run4_DG'),
#        ('run3_DG','run4_DG'))

#indexes = ((2,3),(2,3),(1,),(2,3),(2,3),(2,3),(2,3),(2,3),
#           (2,3),(2,3),(2,3),(2,3),(2,3),(2,3),(2,3),(2,3),(2,3),(2,3))

indexes = ((0,1),(0,1),(0,),(0,1),(0,1),(0,1),(0,1),(0,1),
           (0,1),(0,1),(0,1),(0,1),(0,1),(0,1),(0,1),(0,1),(0,1),(0,1))
  
#indexes = ((0,1,2,3),(0,1,2,3),(0,1,2,3),(0,1,2,3),(0,1,2,3),(0,1,2,3),(0,1,2,3),(0,1,2,3),
#           (0,1,2,3),(0,1,2,3),(0,1,2,3),(0,1,2,3),(0,1,2,3),(0,1,2,3),(0,1,2,3),(0,1,2,3),(0,1,2,3),(0,1,2,3))
      
EEGbadlist = (
        ['EEG025', 'EEG036'], 
        ['EEG035', 'EEG036'],
        ['EEG025', 'EEG035',  'EEG036'],
        ['EEG035'] ,                                                               
        ['EEG017', 'EEG025'],
        ['EEG026', 'EEG036'],
        ['EEG035'],                                                                         
        ['EEG025', 'EEG035', 'EEG036' ,'EEG037'],
        ['EEG025', 'EEG035'],
        ['EEG009', 'EEG022',  'EEG045',   'EEG046',  'EEG053', 'EEG054',  'EEG059'],
        ['EEG035', 'EEG057'],
        ['EEG043'],
        ['EEG035'],                                                                 
        ['EEG025', 'EEG035'],
        ['EEG025', 'EEG035'],
        ['EEG025', 'EEG035',  'EEG036', 'EEG017'],
        ['EEG017', 'EEG025', 'EEG036', 'EEG026', 'EEG034'],
        ['EEG002','EEG055'])

DataSource = (
#        ('EVT','EVT'),
        ('EVS','EVS'),
      )

CondComb = (
#        ('RelPatG','RelFutG'),
#        ('RelWestG','RelEastG'))
#	('RelPastG_scoumap','RelFutG_coumap'),
#      ('RelWestG_coumap','RelEastG_coumap'))
#	 ('RelPastG_intmap','RelFutG_intmap'),
      ('RelWestG_intmap','RelEastG_intmap'),)

####################################################################

# init jobs file content and names
Liste_python_files = []
everybody = ""
initbody = "import os \n"
initbody = initbody + "os.chdir('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS/MNE_PYTHON')\n"
initbody = initbody + "import Epoch_icaClean_v4 as Eic\n"

# write job files (basically a python script calling the function of interest with arguments of interest)
python_file, Listfile, ListJobName = [], [], []
for s,subj in enumerate(ListSubj):
    for m,mod in enumerate(modalities):
        for c,cond in enumerate(CondComb):

            body = initbody + "Eic.Epoch_icaClean_v4(" + str(CondComb[c])        
            body = body + ", " + str(DataSource[c])+ ", '" + str(subj) + "', " + str(listRunPerSubj[s])
            body = body + ", " + str(indexes[s]) + ", " + str(EEGbadlist[s]) + ')'

            everybody = everybody + body +"\n"

            jobname = subj
            for c in cond:
                jobname = jobname + '_' + str(c)  
            ListJobName.append(jobname)  

            # write jobs in a dedicated folder
            name_file = []
            name_file = os.path.join(path_script, ("JOBS_PREPROC/Preproc_ica_motmap" + jobname + ".py"))
            Listfile.append(name_file)
            with open(name_file, 'w') as python_file:
                python_file.write(body)

name_file1 = os.path.join(path_script, ("JOBS_PREPROC/Preproc_ica_ALL_motmap.py"))
with open(name_file1, 'w') as python_file:
    python_file.write(everybody)

jobs = []
for i in range(len(Listfile)):
    JobVar = Job(command=['python', Listfile[i]], name = ListJobName[i],
                 native_specification = '-l walltime=8:00:00 -l nodes=1:ppn=8')
    jobs.append(JobVar)
    WfVar = Workflow(jobs=jobs, dependencies=[])

    # save the workflow into a file
    somaWF_name = os.path.join(path_script, "SOMA_WFs/soma_WF_PREPROCica_allsub_allcond_motmap")
    Helper.serialize(somaWF_name, WfVar)


#####################################################################