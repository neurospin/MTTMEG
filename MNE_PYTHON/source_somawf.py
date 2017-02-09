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

#modalities = ('MEG'  , 'MEEG')
Method     = ('dSPM' , 'MNE')

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
 
datasource = ('QT',
              'EV',
              'QT',
              'QT',
              'EV',
              'EV',
              'EV',
              'EV',
              'EV',
              'EV') 

####################################################################

# init jobs file content and names
Liste_python_files = []
initbody = "import os \n"
initbody = initbody + "os.chdir('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS/MNE_PYTHON')\n"
initbody = initbody + "import SourceReconstructionv2 as SR\n"

# write job files (basically a python script calling the function of interest with arguments of interest)
python_file, Listfile, nametag = [], [], []
for subj in range(len(ListSubj)):
    for M in range(len(Method)):
        for cc in range(len(CondComb)):

            combstr  = "("
            for c in range(len(CondComb[cc])-1):
                combstr = combstr + "'" + CondComb[cc][c] + "'" + ","
            combstr = combstr + "'" + CondComb[cc][c+1] + "'" + ")"

            body = initbody
            body = body + "SR.SourceReconstructionv2(" + combstr + ", " 
            body = body + "[('" + ListSubj[subj] + "')],'MEG',"
            body = body + "'" + Method[M] + "','"  + datasource[cc] + "')" 
            body = body + "\n"
            
            #body = initbody
            #body = body + "SR.SourceReconstructionv2(" + combstr + ", " 
            #body = body + "[('" + ListSubj[subj] + "')],'EEG',"
            #body = body + "'" + Method[M] + "','"  + datasource[cc] + "')" 
            #body = body + "\n"

            body = body + "SR.SourceReconstructionv2(" + combstr + ", " 
            body = body + "[('" + ListSubj[subj] + "')],'MEEG',"
            body = body + "'" + Method[M] + "','"  + datasource[cc] + "')" 

            # use a transparent and complete job name referring to arguments of interest
            tmpname = ""
            for c in range(len(CondComb[cc])):
                tmpname = tmpname + "_" + CondComb[cc][c] + "_" + ListSubj[subj] 
            tmpname = tmpname + Method[M] + "_" 
            nametag.append(tmpname)

            # write jobs in a dedicated folder
            name_file = []
            name_file = os.path.join(path_script, ("JOBS_SOURCE/Source_" + tmpname + ".py"))
            Listfile.append(name_file)
            python_file = open(name_file, "w")
            python_file.write(body)
            python_file.close

jobs = []
for i in range(len(Listfile)):
    #job_1 = Job(command=["python", Listfile[i]], name = nametag[i], native_specification="-l walltime=1:00:00, -l nodes=1:ppn=1")
    job_1 = Job(command=["python", Listfile[i]], name = nametag[i])
    jobs.append(job_1)
    workflow = Workflow(jobs=jobs, dependencies=[])

    # save the workflow into a file
    somaWF_name = os.path.join(path_script, "SOMA_WFs/soma_WF_SOURCE")
    Helper.serialize(somaWF_name, workflow)


#####################################################################
