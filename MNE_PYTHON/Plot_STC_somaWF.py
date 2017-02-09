# -*- coding: utf-8 -*-
"""
Created on Fri Nov 27 15:09:46 2015

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
#import save_object as so

####################################################################
# define parameters
wdir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG"
path_script  = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS/MNE_PYTHON"

modalities   = ('MEG')
Methods      = ('dSPM',)
parc         = 'aparc'

ListSubj = (
	'sd130343', 'cb130477', 'rb130313','jm100042', 
	'jm100109', 'sb120316', 'tk130502', 
	'lm130479', 'ms130534', 'ma100253',
	'sl130503', 'mb140004', 'mp140019',
	'dm130250', 'hr130504', 'wl130316', 
	'rl130571')

CondComb = (('Qt_all','Qs_all'),
     ('Et_all','Es_all'),

	('EsDsq1G_QRT3','EsDsq3G_QRT3'),
	('EtDtq1G_QRT3','EtDtq3G_QRT3'),

	('QsWest' ,'QsPar' ),
	('QsPar'  ,'QsEast'),
	('QsWest' ,'QsEast'),

	('QtPast' ,'QtPre' ),
	('QtPre'  ,'QtFut' ),
	('QtPast' ,'QtFut' ),

	('EtPast' ,'EtPre' ),
	('EtPre'  ,'EtFut' ),
	('EtPast' ,'EtFut' ),

	('EsWest' ,'EsPar' ),
	('EsWest' ,'EsEast'),
	('EsPar'  ,'EsEast'))

colors = (((1,0,0) ,(0,0,1)),
         ((1,0,0)  ,(0,0,1)),
    	((0,0,1) ,(0.3,0.6,1)),
    	((0,0,1) ,(0.3,0.6,1)),
    	((0,0,1) ,(0.3,0.6,1)),
    	((0,0,1) ,(0.3,0.6,1)),
    	((0,0,1) ,(0.3,0.6,1)),
    	((0,0,1) ,(0.3,0.6,1)),
    	((0,0,1) ,(0.3,0.6,1)),
    	((0,0,1) ,(0.3,0.6,1)),
    	((0,0,1) ,(0.3,0.6,1)),
    	((0,0,1) ,(0.3,0.6,1)),
    	((0,0,1) ,(0.3,0.6,1)),
    	((0,0,1) ,(0.3,0.6,1)),
    	((0,0,1) ,(0.3,0.6,1)),
    	((0,0,1) ,(0.3,0.6,1)))

avg_modes = ('mean','mean_flip')
# write in a file the parameter list to be used by the following jobs
#so.save_object(ListSubj, os.path.join(path_script, ("JOBS_TMP/LISTSUBJforJOBS")))

####################################################################

# init jobs file content and names
python_file, Listfile, ListJobName = [], [], []
initbody = "import os \n"
initbody = initbody + "os.chdir('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS/MNE_PYTHON')\n"
initbody = initbody + "import GetTimeCourseFromSTC_flip as gtc\n"
initbody = initbody + "import load_object as so\n"

# write job files (basically a python script calling the function of interest with arguments of interest)
for modes, avgm in enumerate(avg_modes):
    for m, mod in enumerate(modalities):
        for m2,met in enumerate(Methods):
            for c, cond in enumerate(CondComb):
                body = initbody
                arglist = ["'" + wdir + "'", str(ListSubj) , str(cond), "'" +mod+ "'",
                           "'" +met+ "'", "'" +parc+ "'", str(colors[c]), "'"+str(avgm)+"'"]
                body = (body + 'gtc.GetTimeCourseFromSTC_flip('  + ', '.join(arglist) 
                + ')')
    
                # use a transparent and complete job name referring to arguments of interest
                jobname = ('PlotTSC_' + "_".join([str(con) for con in cond])
                 + '_' + str(mod) + '_' + str(met) + '_' + parc + str(avgm))
                ListJobName.append(jobname)  
            
                # write jobs in a dedicated folder
                name_file = []
                name_file = os.path.join(path_script, ("JOBS_PLOT/PlotStc_" + jobname + ".py"))
                Listfile.append(name_file)
                with open(name_file, 'w') as python_file:
                    python_file.write(body)
                    python_file.close()  

jobs = []
for i in range(len(Listfile)):
    JobVar = Job(command=['python', Listfile[i]], name = ListJobName[i],
                 native_specification = '-l walltime=2:00:00, -l nodes=1:ppn=2')
    jobs.append(JobVar)
    
WfVar = Workflow(jobs=jobs, dependencies=[])
# save the workflow into a file
somaWF_name = os.path.join(path_script, "SOMA_WFs/soma_wf_plot_stc")
Helper.serialize(somaWF_name, WfVar)


#####################################################################
