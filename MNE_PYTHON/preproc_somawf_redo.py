####################################################################
# This script generate jobs.py files and creates a somwf file
# containing the jobs to be send to the cluster with soma_workflow
# you can then launch and follow the processing with soma_workflow interface

####################################################################
# import libraries
from soma_workflow.client import Job, Workflow, Helper
import os
os.chdir('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS/MNE_PYTHON')
import save_object as so

####################################################################
# define parameters
subjects_dir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG"
path_script  = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS/MNE_PYTHON"

modalities = ('MEG',)
megtags    = ('True',)
eegtags    = ('False',)

ListSubj = (
        'tk130502',
        'sl130503') 


listRunPerSubj = (
        ('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
        ('run1_GD','run2_GD','run3_DG','run4_DG'))

EEGbadlist = (
        ['EEG035'],                                                                         
        ['EEG035', 'EEG057'])

DataSource = (
        ('EVT','EVT'),
        ('EVS','EVS'))        

CondComb = (
	('EtDtq1G_QRT2','EtDtq2G_QRT2'),
	('EsDsq1G_QRT2','EsDsq2G_QRT2'))

####################################################################

# init jobs file content and names
Liste_python_files = []
initbody = "import os \n"
initbody = initbody + "os.chdir('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS/MNE_PYTHON')\n"
initbody = initbody + "import EpochAndAverage_MatchedCond as EA_M\n"
initbody = initbody + "import load_object as so\n"

# write job files (basically a python script calling the function of interest with arguments of interest)
python_file = [];
Listfile = []
for subj in range(len(ListSubj)):
    for m in range(len(modalities)):
        for cc in range(len(CondComb)):

            LRpSstr = "("
            for s in range(len(listRunPerSubj[subj])-1):
                LRpSstr = LRpSstr + "'" + listRunPerSubj[subj][s] + "'" + ","
            LRpSstr = LRpSstr + "'" + listRunPerSubj[subj][s+1] + "'" + ")"

            EEGbadstr = "("
            if len(EEGbadlist[subj]) > 1:
                for e in range(len(EEGbadlist[subj])-1):
                    EEGbadstr = EEGbadstr + "'" + EEGbadlist[subj][e] + "'" + ","
                EEGbadstr = EEGbadstr + "'" + EEGbadlist[subj][e+1] + "'" + ")"
            elif len(EEGbadlist[subj]) == 1:
                EEGbadstr = EEGbadstr + "'" + EEGbadlist[subj][0] + "'" + ")"
            else:
                EEGbadstr = EEGbadstr + ")" 
            

            combstr  = "("
            datsstr  = "("
            for c in range(len(CondComb[cc])-1):
                combstr = combstr + "'" + CondComb[cc][c] + "'" + ","
                datsstr = datsstr + "'" + DataSource[cc][c] + "'" + ","
            combstr = combstr + "'" + CondComb[cc][c+1] + "'" + ")"
            datsstr = datsstr + "'" + DataSource[cc][c+1] + "'" + ")"

            body = initbody
            body = body + "EA_M.EpochAndAverage_MatchedCond(" + combstr + ", " + datsstr 
            body = body + ", [('" + ListSubj[subj] + "')], " + "[(" + LRpSstr + ")], "
            body = body + "[(" + EEGbadstr + ")], " + megtags[m] + ", "
            body = body + eegtags[m] + ", " "'" + modalities[m] + "'" + ")" 

            # use a transparent and complete job name referring to arguments of interest
            nametag = ""
            for c in range(len(CondComb[cc])):
                nametag = nametag + "_" + CondComb[cc][c] + "_" + ListSubj[subj] 
            nametag = nametag + "_" + modalities[m] +  "_" 

            # write jobs in a dedicated folder
            name_file = []
            name_file = os.path.join(path_script, ("JOBS_PREPROC/Preproc_STC" + nametag + ".py"))
            Listfile.append(name_file)
            python_file = open(name_file, "w")
            python_file.write(body)
            python_file.close

jobs = []
for file_python in Listfile:
    job_1 = Job(command=["python", file_python], native_specification="-l walltime=12:00:00, -l nodes=1:ppn=8")
    jobs.append(job_1)
    workflow = Workflow(jobs=jobs, dependencies=[])

    # save the workflow into a file
    somaWF_name = os.path.join(path_script, "SOMA_WFs/soma_WF_PREPROC")
    Helper.serialize(somaWF_name, workflow)

#####################################################################
