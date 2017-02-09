# -*- coding: utf-8 -*-
"""
Created on Tue Oct 20 14:02:29 2015

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
        'dm130250', 'hr130504', 'wl130316', 'rl130571',
        'mm130405', 'sg120518')

DataSource = (
        ('EVS','EVS','EVS'),
        ('EVT','EVT','EVT'),    
        ('QTT','QTT','QTT'),
        ('QTS','QTS','QTS'),
        ('EVT','EVT','EVT'),
        ('EVS','EVS','EVS')) 
CondComb = (
	('EsDsq1G_QRT3','EsDsq2G_QRT3','EsDsq3G_QRT3'),
	('EtDtq1G_QRT3','EtDtq2G_QRT3','EtDtq3G_QRT3'),
	('QtPast','QtPre','QtFut'),
	('QsWest','QsPar','QsEast'),
	('EtPast','EtPre','EtFut'),
	('EsWest','EsPar','EsEast'),
      ('RefW','RefPar','RefE'),
      ('RefPast','RefPre','RefFut'))

decodmod = ('combined')

Classes = ((3,2,1),
         (3,2,1),
         (-1,0,1),
         (-1,0,1),
         (-1,0,1),
         (-1,0,1))

#Windows = ((-0.2, 0.),(0., 0.2 ),(0.2, 0.4),(0.4, 0.6),(0.6, 0.8),(0.8,1))
Windows = ((-0.2, 0.),(0., 0.1 ),(0., 0.2),(0., 0.3),(0., 0.4),(0., 0.5 ),
           (0., 0.6),(0., 0.7),(0., 0.8),(0., 0.9),(0., 1.),(0.1, 1.1))
RidgeAlpha = (10000, 1000, 100, 10, 1, 0.1, 0.01, 0.001, 0.0001)

####################################################################

# init jobs file content and names
Liste_python_files = []
initbody = "import os \n"
initbody = initbody + "os.chdir('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS/MNE_PYTHON')\n"
initbody = initbody + "import rank_decode as RKD\n"

# write job files (basically a python script calling the function of interest with arguments of interest)
# for each frequency band, generate a workflow
# python_file_full, Listfile_full, ListJobName_full = [], [], []

python_file, Listfile, ListJobName = [], [], []
for a,alpha in enumerate(RidgeAlpha):
    for w,window in enumerate(Windows):
        for c,cond in enumerate(CondComb):
            
            arglist = [str(ListSubj),str(cond),str(Classes[c]),"'combined'",str(window),str(alpha)]
            body = initbody + 'RKD.rank_decode('  + ', '.join(arglist) + ')'  
    
            jobname = ('rank' + "_".join([str(con) for con in cond])
            + "_win" + "_".join([str(w) for w in window]) + '_alpha' + str(alpha))
            ListJobName.append(jobname)  
    
            # write jobs in a dedicated folder
            name_file = []
            name_file = os.path.join(path_script, ("JOBS_RANK/decode_" + jobname + ".py"))
            Listfile.append(name_file)
            with open(name_file, 'w') as python_file:
                python_file.write(body)
                python_file.close()  
    
###########################################################################
jobs = []
for i in range(len(Listfile)):
    JobVar = Job(command=['python', Listfile[i]], name = ListJobName[i],
                 native_specification = '-l walltime=1:00:00, -l nodes=1:ppn=1')
    jobs.append(JobVar)
    
WfVar = Workflow(jobs=jobs, dependencies=[])
# save the workflow into a file
somaWF_name = os.path.join(path_script, "SOMA_WFs/soma_wf_rank_decode")
Helper.serialize(somaWF_name, WfVar)
    
