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

ListSubj  = (
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
        'sg120518',
        'mm130405')

CovSource = ('QT',)
             
CondComb  = (('QsEast','QsWest'),)
             
Twin      = ((0.3,0.8),)
####################################################################

# init jobs file content and names
Liste_python_files = []
initbody = "import os \n"
initbody = initbody + "os.chdir('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS/MNE_PYTHON')\n"
initbody = initbody + "import TTest_subjlvl as tt\n"

# write job files (basically a python script calling the function of interest with arguments of interest)
python_file, Listfile, ListJobName = [], [], []
for s,subj in enumerate(ListSubj):
    for c,cond in enumerate(CondComb):

            body = initbody + "tt.TTest_subjlvl('" + str(subj) + "', " + str(CondComb[c])        
            body = body + ", '" + str(CovSource[c]) + "', " + str(Twin[c]) + ",'MEEG'" +")\n"
            body = body + "tt.TTest_subjlvl('" + str(subj) + "', " + str(CondComb[c])        
            body = body + ", '" + str(CovSource[c]) + "', " + str(Twin[c]) + ",'MEG'" +")"
    
            jobname = ''
            jobname = (jobname + 'SubjSourceTStats' + "_" + str(subj) + "_" 
                      + '-'.join([x for x in cond]))   
            ListJobName.append(jobname)
    
            # write jobs in a dedicated folder
            name_file = []
            name_file = os.path.join(path_script, ("JOBS_STATS/stats_T" + jobname + ".py"))
            Listfile.append(name_file)
            with open(name_file, 'w') as python_file:
                python_file.write(body)

jobs = []
for i,list_ in enumerate(Listfile):
    JobVar = Job(command=['python', list_], name = ListJobName[i],
                 native_specification = '-l walltime=0:59:00, -l nodes=1:ppn=2')
    jobs.append(JobVar)
    WfVar = Workflow(jobs=jobs, dependencies=[])

    # save the workflow into a file
    somaWF_name = os.path.join(path_script, "SOMA_WFs/statsT_")
    Helper.serialize(somaWF_name, WfVar)


#####################################################################

