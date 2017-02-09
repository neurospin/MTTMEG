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

modalities = ('MEG'  , 'EEG' , 'MEEG')
megtags    = ('True' ,'False','True' )
eegtags    = ('False','True' ,'True' )

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

listRunPerSubj = (
        ('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
        ('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
        ('run2_GD','run3_DG','run4_DG'),
        ('run2_GD','run3_DG','run4_DG'),
        ('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
        ('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
        ('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
        ('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
        ('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
        ('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
        ('run1_GD','run2_GD','run3_DG','run4_DG'),
        ('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
        ('run1_GD','run2_GD','run3_DG','run4_DG'),
        ('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
        ('run1_GD','run2_GD','run3_DG','run4_DG'),
        ('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
        ('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'))

EEGbadlist = (
        ['EEG025', 'EEG036'], 
        ['EEG035', 'EEG036'],
        ['EEG025', 'EEG035',  'EEG036'],
        ['EEG035'],                                                                 
        ['EEG017', 'EEG025'],
        ['EEG026', 'EEG036'],
        ['EEG035'],                                                                         
        ['EEG025', 'EEG035', 'EEG036'  'EEG037'],
        ['EEG025',  'EEG035'],
        ['EEG009', 'EEG022',  'EEG045',   'EEG046',  'EEG053', 'EEG054',  'EEG059'],
        ['EEG035', 'EEG057'],
        ['EEG043'],
        ['EEG035'],                                                                 
        ['EEG025', 'EEG035'],
        ['EEG025', 'EEG035'],
        ['EEG025',   'EEG035',  'EEG036', 'EEG017'],
        ['EEG0017', 'EEG0025', 'EEG0036', 'EEG0026', 'EEG0034'])

DataSource = (
        ('QTT','QTS'),
        ('EVT','EVS'),
        ('QTT','QTT','QTT'),
        ('QTS','QTS','QTS'),
        ('EVT','EVT','EVT'),
        ('EVS','EVS','EVS'),
        ('EVS','EVS','EVS'),
        ('EVT','EVT','EVT'),
        ('EVT','EVT'),
        ('EVS','EVS'))        

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

            EEGbadstr = "["
            if len(EEGbadlist[subj]) > 1:
                for e in range(len(EEGbadlist[subj])-1):
                    EEGbadstr = EEGbadstr + "'" + EEGbadlist[subj][e] + "'" + ","
                EEGbadstr = EEGbadstr + "'" + EEGbadlist[subj][e+1] + "'" + "]"
            elif len(EEGbadlist[subj]) == 1:
                EEGbadstr = EEGbadstr + "'" + EEGbadlist[subj][0] + "'" + "]"
            else:
                EEGbadstr = EEGbadstr + "]" 
            

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
            body = body + EEGbadstr + ", " + megtags[m] + ", "
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
for i in range(10):
    job_1 = Job(command=["python", Listfile[i]], native_specification="-l walltime=24:00:00, -l nodes=1:ppn=2")
    jobs.append(job_1)
    workflow = Workflow(jobs=jobs, dependencies=[])

    # save the workflow into a file
    somaWF_name = os.path.join(path_script, "SOMA_WFs/soma_WF_PREPROC")
    Helper.serialize(somaWF_name, workflow)


#####################################################################
