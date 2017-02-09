# -*- coding: utf-8 -*-
"""
Created on Fri Nov  6 13:29:10 2015

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
	  'sd130343','cb130477', 'rb130313', 'jm100109', 
        'sb120316', 'tk130502','lm130479', 'ms130534', 
        'ma100253', 'sl130503', 'mb140004','mp140019', 
        'dm130250', 'hr130504', 'wl130316', 'rl130571')

CondComb = (
	('EsDsq1G_QRT3','EsDsq2G_QRT3','EsDsq3G_QRT3'),
	('EtDtq1G_QRT3','EtDtq2G_QRT3','EtDtq3G_QRT3'))

decodmod = ('grad')

Classes = ((3,2,1),
         (3,2,1))

#Windows = ((-0.2, 0.),(0., 0.2 ),(0.2, 0.4),(0.4, 0.6),(0.6, 0.8),(0.8,1))
Windows = ((0., 1.1),)
RidgeAlpha = (0.001)

Filters = [0.3]

indexes = range(0,68) # aparc labels
####################################################################

# init jobs file content and names
Liste_python_files = []
initbody = "import os \n"
initbody = initbody + "os.chdir('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS/MNE_PYTHON')\n"
initbody = initbody + "import rank_decode_source_label as RKD\n"

# write job files (basically a python script calling the function of interest with arguments of interest)
# for each frequency band, generate a workflow
# python_file_full, Listfile_full, ListJobName_full = [], [], []

python_file, Listfile, ListJobName = [], [], []
for c,cond in enumerate(CondComb):
    for s, subj in enumerate(ListSubj):
        body = initbody
        for w,window in enumerate(Windows):
            for i,index in enumerate(indexes):
        
                arglist = ["'"+str(subj)+"'",str(cond),str(Classes[c]),"'MEG'",
                           str(window),str(0.001),str(0.3),str(index)]
                body = body + 'RKD.rank_decode_source_label('  + ', '.join(arglist) + ')\n'  

        jobname = ('rank_' + str(subj) + "_".join([str(con) for con in cond])
         + '_alpha_' + str(0.001) + '_' + str(0.3) +'_allwin_allabels')
        ListJobName.append(jobname)  

        # write jobs in a dedicated folder
        name_file = []
        name_file = os.path.join(path_script, ("JOBS_RANK/decode_source_label_" + jobname + ".py"))
        Listfile.append(name_file)
        with open(name_file, 'w') as python_file:
            python_file.write(body)
            python_file.close()  

###########################################################################
jobs = []
for i in range(len(Listfile)):
    JobVar = Job(command=['python', Listfile[i]], name = ListJobName[i],
                 native_specification = '-l walltime=48:00:00, -l nodes=1:ppn=2')
    jobs.append(JobVar)
    
WfVar = Workflow(jobs=jobs, dependencies=[])
# save the workflow into a file
somaWF_name = os.path.join(path_script, "SOMA_WFs/soma_wf_rank_source_decode")
Helper.serialize(somaWF_name, WfVar)
    
