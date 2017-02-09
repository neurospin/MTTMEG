# -*- coding: utf-8 -*-
"""
Created on Thu Feb  4 13:54:50 2016

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
        'rl130571')

CovSource = (
        'QT',
        'EV',
        'EV',
        'EV',
        'EV',
        'EV',      
        'QT',
        'QT',
        'EV',
        'EV') 
CondComb = (
	('Qt_all','Qs_all'),
      ('Et_all','Es_all'),
	('EsDsq1G_QRT3','EsDsq3G_QRT3'),
	('EtDtq1G_QRT3','EtDtq3G_QRT3'),
	('EtDtq1G_QRT2','EtDtq2G_QRT2'),
     ('EsDsq1G_QRT2','EsDsq2G_QRT2'),
	('QtPast','QtPre','QtFut'),
	('QsWest','QsPar','QsEast'),
	('EtPast','EtPre','EtFut'),
	('EsWest','EsPar','EsEast'))
####################################################################

# init jobs file content and names
Liste_python_files = []
initbody = "import os \n"
initbody = initbody + "os.chdir('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS/MNE_PYTHON')\n"
initbody = initbody + "import SingleSourceStats as SSS\n"

# write job files (basically a python script calling the function of interest with arguments of interest)
python_file, Listfile, ListJobName = [], [], []
for s,subj in enumerate(ListSubj):
    for c,cond in enumerate(CondComb):

        body = initbody + "SSS.SingleSourceStats('" + str(subj) + "', " + str(CondComb[c])        
        body = body + ", '" + str(CovSource[c]) + "','dSPM','MEG')"

        jobname = ''
        jobname = (jobname + 'SingleSourcetStats' + "_" + str(subj) + "_" 
                  + '-'.join([c for c in cond]))   
        ListJobName.append(jobname)

        # write jobs in a dedicated folder
        name_file = []
        name_file = os.path.join(path_script, ("JOBS_STATS/stats_source" + jobname + ".py"))
        Listfile.append(name_file)
        with open(name_file, 'w') as python_file:
            python_file.write(body)

jobs = []
for i in range(len(Listfile)):
    JobVar = Job(command=['python', Listfile[i]], name = ListJobName[i],
                 native_specification = '-l walltime=10:00:00, -l nodes=2:ppn=8')
    jobs.append(JobVar)
    WfVar = Workflow(jobs=jobs, dependencies=[])

    # save the workflow into a file
    somaWF_name = os.path.join(path_script, "SOMA_WFs/stats_")
    Helper.serialize(somaWF_name, WfVar)


#####################################################################
