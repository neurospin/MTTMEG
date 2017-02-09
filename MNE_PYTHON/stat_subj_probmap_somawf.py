# -*- coding: utf-8 -*-
"""
Created on Thu Jul  7 13:56:56 2016

@author: bgauthie
"""

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

#CovSource = ('EV','EV','QT')
#'REF','REF','REF','REF','REF') 
CovSource = ('REF',)
             
#CondComb  = (('EtPast','EtPre','EtFut'),
#             ('EsWest','EsPar','EsEast'),
#             ('QsWest','QsPar','QsEast'))
#             ('RefPast','RefPre','RefFut'),
#             ('RefPast','RefPre','RefFut'),
#             ('RefPast','RefPre','RefFut'),
#             ('RefPast','RefPre','RefFut'),
#             ('RefPast','RefPre','RefFut'))
CondComb  = (('EtPast','EtPre','EtFut'),)

#Twin      = ((0.517,0.954),
#             (0.520,1    ),
#             (0.340,0.480))
#             (0.760,1048),
#             (1.606,1.829),
#             (2.446,2.634),
#             (3.091,3.325),
#             (4.008,4.138))
Twin      = ((1.606,1.829),)
####################################################################

# init jobs file content and names
Liste_python_files = []
initbody = "import os \n"
initbody = initbody + "os.chdir('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS/MNE_PYTHON')\n"
initbody = initbody + "import ANOVA_subjlvl as subaov\n"

# write job files (basically a python script calling the function of interest with arguments of interest)
python_file, Listfile, ListJobName = [], [], []
for s,subj in enumerate(ListSubj):
    for c,cond in enumerate(CondComb):

            body = initbody + "subaov.ANOVA_subjlvl('" + str(subj) + "', " + str(cond)        
            body = body + ", '" + str(CovSource[c]) + "', " + str(Twin[c]) + ",'MEEG'" +")\n"
            body = body + "subaov.ANOVA_subjlvl('" + str(subj) + "', " + str(cond)   
            body = body + ", '" + str(CovSource[c]) + "', " + str(Twin[c]) + ",'MEG'" +")\n"
            
            jobname = ''
            jobname = (jobname + 'SubjSourceFStats' + "_" + str(subj) + "_" 
                      + '-'.join([x for x in cond]))   
            ListJobName.append(jobname)
    
            # write jobs in a dedicated folder
            name_file = []
            name_file = os.path.join(path_script, ("JOBS_STATS/stats_F" + jobname + ".py"))
            Listfile.append(name_file)
            with open(name_file, 'w') as python_file:
                python_file.write(body)

jobs = []
for i,list_ in enumerate(Listfile):
    JobVar = Job(command=['python', list_], name = ListJobName[i],
                 native_specification = '-l walltime=0:59:00, -l nodes=1:ppn=4')
    jobs.append(JobVar)
    WfVar = Workflow(jobs=jobs, dependencies=[])

    # save the workflow into a file
    somaWF_name = os.path.join(path_script, "SOMA_WFs/stats_F")
    Helper.serialize(somaWF_name, WfVar)


#####################################################################
