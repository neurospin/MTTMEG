# -*- coding: utf-8 -*-
"""
Created on Wed Jan 20 10:35:46 2016

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

modalities = ('MEEG','MEG'  ,'EEG'  )
megtags    = ('True','True' ,'False')
eegtags    = ('True','False','True')

ListSubj = (
	   'sg120518',
        'mm130405')

#listRunPerSubj = (
#        ('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
#        ('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
#        ('run2_GD','run3_DG','run4_DG'),
#        ('run1_GD','run2_GD','run3_DG','run4_DG'),
#        ('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
#        ('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
#        ('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
#        ('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
#        ('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
#        ('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
#        ('run1_GD','run2_GD','run3_DG','run4_DG'),
#        ('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
#        ('run1_GD','run2_GD','run3_DG','run4_DG'),
#        ('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
#        ('run1_GD','run2_GD','run3_DG','run4_DG'),
#        ('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
#        ('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'))
        
listRunPerSubj = (
        ('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
        ('run2_GD','run3_DG'))

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
        ['EEG017', 'EEG025', 'EEG036', 'EEG026', 'EEG034'])

EEGbadlist = (
        ['EEG002', 'EEG055'],
        ['EEG017','EEG025','EEG035'])

DataSource = ('QT','EV','REF')

####################################################################

# init jobs file content and names
Liste_python_files = []
everybody = ""
initbody = "import os \n"
initbody = initbody + "os.chdir('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS/MNE_PYTHON')\n"
initbody = initbody + "import Write_covmat_icaclean as WC\n"

# write job files (basically a python script calling the function of interest with arguments of interest)
python_file, Listfile, ListJobName = [], [], []
for s,subj in enumerate(ListSubj):
    for m,mod in enumerate(modalities):
        for c,source in enumerate(DataSource):

            body = initbody + "WC.Write_covmat_icaclean("       
            body = body + " '" + str(DataSource[c])+ "', '" + str(subj) + "', " + str(listRunPerSubj[s])
            body = body + ", " + str(EEGbadlist[s]) + ", " + str(megtags[m]) +  ", "  + str(eegtags[m]) + ')'

            everybody = everybody + body + "\n"

            jobname = 'CovCompute_' + str(modalities[m]) + '_' + subj + '_' + str(DataSource[c])
            ListJobName.append(jobname)  

            # write jobs in a dedicated folder
            name_file = []
            name_file = os.path.join(path_script, ("JOBS_PREPROC/CovCompute" + jobname + ".py"))
            Listfile.append(name_file)
            with open(name_file, 'w') as python_file:
                python_file.write(body)

name_file1 = os.path.join(path_script, ("JOBS_PREPROC/CovCompute_ALL.py"))
with open(name_file1, 'w') as python_file:
    python_file.write(everybody)

jobs = []
for i in range(len(Listfile)):
    JobVar = Job(command=['python', Listfile[i]], name = ListJobName[i],
                 native_specification = '-l walltime=10:00:00, -l nodes=1:ppn=4')
    jobs.append(JobVar)
    WfVar = Workflow(jobs=jobs, dependencies=[])

    # save the workflow into a file
    somaWF_name = os.path.join(path_script, "SOMA_WFs/soma_WF_CovCompute_allsub_allcond")
    Helper.serialize(somaWF_name, WfVar)


#####################################################################
