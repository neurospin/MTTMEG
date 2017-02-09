# -*- coding: utf-8 -*-
"""
Created on Thu Oct  8 16:21:52 2015

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
	'sd130343','cb130477', 
        'rb130313', 'jm100109', 'sb120316', 'tk130502',
        'lm130479', 'ms130534', 'ma100253', 'sl130503', 'mb140004',
        'mp140019', 'dm130250', 'hr130504', 'wl130316', 'rl130571')

condcombs = (('Qt_all','Qs_all'),
('Et_all','Es_all'),
('QtPast','QtPre','QtFut'),
('QsWest','QsPar','QsEast'),
('EtPast','EtPre','EtFut'),
('EsWest','EsPar','EsEast'))

modality = ('mag','grad','EEG','combined')
Filt = 0.3

####################################################################

# init jobs file content and names
Liste_python_files = []
initbody = "import os \n"
initbody = initbody + "os.chdir('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS/MNE_PYTHON')\n"
initbody = initbody + "import Decode2cond as dmc\n"

# write job files (basically a python script calling the function of interest with arguments of interest)
python_file, Listfile, ListJobName = [], [], []
for s,subj in enumerate(ListSubj):
    for c,cond in enumerate(condcombs):
        for m, mod in enumerate(modality):
 
            arglist = ["'"+subj+"'", str(cond), "'" +mod+"'"]      
            body = initbody
            body = body + 'dmc.Decode2cond(' + ', '.join(arglist) + ')'  
    
            jobname = subj + "_".join([str(con) for con in cond]) + mod
            ListJobName.append(jobname)  
    
            # write jobs in a dedicated folder
            name_file = []
            name_file = os.path.join(path_script, ("JOBS_DECODING/decodeMC_" + jobname + ".py"))
            Listfile.append(name_file)
            with open(name_file, 'w') as python_file:
                python_file.write(body)

jobs = []
for i in range(len(Listfile)):
    JobVar = Job(command=['python', Listfile[i]], name = ListJobName[i],
                 native_specification = '-l walltime=10:00:00, -l nodes=1:ppn=2')
    jobs.append(JobVar)
    WfVar = Workflow(jobs=jobs, dependencies=[])

    # save the workflow into a file
    somaWF_name = os.path.join(path_script, "SOMA_WFs/soma_WF_DECODEMC_allsub_allcond")
    Helper.serialize(somaWF_name, WfVar)


#####################################################################
