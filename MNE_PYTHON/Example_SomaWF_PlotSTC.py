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
subjects_dir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG"
path_script  = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS/MNE_PYTHON"

modalities   = ('MEG','MEEG')
Methods      = ('dSPM',)
parcellation = 'aparc'

ListSubj = (
	'sd130343', 'cb130477', 'rb130313','jm100042', 
	'jm100109', 'sb120316', 'tk130502', 
	'lm130479', 'ms130534', 'ma100253',
	'sl130503', 'mb140004', 'mp140019',
	'dm130250', 'hr130504', 'wl130316', 
	'rl130571')

CondComb = (
	('Qt_all','Qs_all'),
	('Et_all','Es_all'),
	('QtPast','QtPre','QtFut'),
	('QsWest','QsPar','QsEast'),
	('EtPast','EtPre','EtFut'),
	('EsWest','EsPar','EsEast'),
	('EsDsq1G_QRT3','EsDsq2G_QRT3','EsDsq3G_QRT3'),
	('EtDtq1G_QRT3','EtDtq2G_QRT3','EtDtq3G_QRT3'),
	('EtDtq1G_QRT2','EtDtq2G_QRT2'),
	('EsDsq1G_QRT2','EsDsq2G_QRT2'))

colors     = (
	((1,0,0)  ,(0,0,1)),
	((1,0,0)  ,(0,0,1)),
	((0.8,0,0),(1,0,0) ,(1,0.2,0.2)),
	((0,0,0.8),(0,0,1) ,(0.2,0.2,1)),
	((0.8,0,0),(1,0,0) ,(1,0.2,0.2)),
	((0,0,0.8),(0,0,1) ,(0.2,0.2,1)),
	((0,0,1),(0.15,0.3,1) ,(0.3,0.6,1)),
	((1,0,0),(1,0.37,0.15),(1,0.75,0.3)),
	((0,0,1),(0.3,0.6,1)),
	((1,0,0),(1,0.37,0.3),(1,0.75,0.3)))

# write in a file the parameter list to be used by the following jobs
#so.save_object(ListSubj, os.path.join(path_script, ("JOBS_TMP/LISTSUBJforJOBS")))

####################################################################

# init jobs file content and names
Liste_python_files = []
initbody = "import os \n"
initbody = initbody + "os.chdir('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS/MNE_PYTHON')\n"
initbody = initbody + "import GetTimeCourseFromSTC_flip as gtc\n"
initbody = initbody + "import load_object as so\n"
initbody = initbody + "ListSubj = so.load_object('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS/MNE_PYTHON/JOBS_TMP/LISTSUBJforJOBS')\n"

# write job files (basically a python script calling the function of interest with arguments of interest)
python_file = [];
Listfile = []
for m in range(len(modalities)):
    for M in range(len(Methods)):
        for cc in range(len(CondComb)):
            combstr  = "("
            colstr   = "("
            for c in range(len(CondComb[cc])-1):
                combstr = combstr + "'" + CondComb[cc][c] + "'" + ","
                colstr  = colstr  + str(colors[cc][c])  + ","
            combstr = combstr + "'" + CondComb[cc][c+1] + "'" + ")"
            colstr  = colstr  + str(colors[cc][c+1]) + ")"

            body = initbody
            body = body + "gtc.GetTimeCourseFromSTC_flip(" + "'" + subjects_dir + "/'" + ", ListSubj , "
            body = body + combstr + ", " + "'" + modalities[m] + "'" + " , " + "'" + Methods[M] + "'" + ", " 
            body = body + "'" + parcellation + "'" + ", " + colstr + ")"

            # use a transparent and complete job name referring to arguments of interest
            nametag = ""
            for c in range(len(CondComb[cc])):
                nametag = nametag + "_" + CondComb[cc][c] 
            nametag = nametag + "_" + modalities[m] + "_" + Methods[M] + "_" 

            # write jobs in a dedicated folder
            name_file = []
            name_file = os.path.join(path_script, ("JOBS_TMP/Plot_STC" + nametag + ".py"))
            Listfile.append(name_file)
            python_file = open(name_file, "w")
            python_file.write(body)
            python_file.close

jobs = []
for file_python in Listfile:
    job_1 = Job(command=["python", file_python])
    jobs.append(job_1)
    workflow = Workflow(jobs=jobs, dependencies=[])

    # save the workflow into a file
    somaWF_name = os.path.join(path_script, "JOBS_TMP/soma_WF_JOBS")
    Helper.serialize(somaWF_name, workflow)


#####################################################################
