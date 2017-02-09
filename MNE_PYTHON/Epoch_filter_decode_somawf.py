# -*- coding: utf-8 -*-
"""
Created on Wed Oct 14 19:13:26 2015

@author: bgauthie
"""

####################################################################
# This script generate jobs.py files and creates a somwf file
# containing the jobs to be send to the cluster with soma_workflow
# you can then launch and follow the processing with soma_workflow interface

####################################################################
# import libraries
from soma_workflow.client import Job, Workflow, Helper, Group
import os

os.chdir('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS/MNE_PYTHON')

####################################################################
# define parameters
subjects_dir = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG"
path_script  = "/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS/MNE_PYTHON"

ListSubj = (
	  'sd130343',
        'cb130477', 'rb130313', 'jm100042', 'jm100109', 
        'sb120316', 'tk130502','lm130479', 'ms130534', 
        'ma100253', 'sl130503', 'mb140004','mp140019', 
        'dm130250', 'hr130504', 'wl130316', 'rl130571')

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
        ('EVS','EVS','EVS'),
        ('EVT','EVT','EVT'),
        ('EVT','EVT'),
        ('EVS','EVS'),      
        ('QTT','QTT','QTT'),
        ('QTS','QTS','QTS'),
        ('EVT','EVT','EVT'),
        ('EVS','EVS','EVS')) 
CondComb = (
	('Qt_all','Qs_all'),
	('Et_all','Es_all'),
	('EsDsq1G_QRT3','EsDsq2G_QRT3','EsDsq3G_QRT3'),
	('EtDtq1G_QRT3','EtDtq2G_QRT3','EtDtq3G_QRT3'),
	('EtDtq1G_QRT2','EtDtq2G_QRT2'),
     ('EsDsq1G_QRT2','EsDsq2G_QRT2'),
	('QtPast','QtPre','QtFut'),
	('QsWest','QsPar','QsEast'),
	('EtPast','EtPre','EtFut'),
	('EsWest','EsPar','EsEast'))

# on which kind of sensors
decodmod = ('grad')

Filters = range(4,47,4)

####################################################################

# init jobs file content and names
Liste_python_files = []
initbody = "import os \n"
initbody = initbody + "os.chdir('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS/MNE_PYTHON')\n"
initbody = initbody + "import Epoch_filter_return as EFR\n"
initbody = initbody + "import Decode2cond as D2C\n"

initbody2 = "import os \n"
initbody2 = initbody + "os.chdir('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS/MNE_PYTHON')\n"
initbody2 = initbody + "import rm_epochs as RME\n"

# write job files (basically a python script calling the function of interest with arguments of interest)
# for each frequency band, generate a workflow
python_file_full, Listfile_full, ListJobName_full = [], [], []
for f,Filt in enumerate(Filters):

    python_file, Listfile, ListJobName = [], [], []
    for s,subj in enumerate(ListSubj):
        for c,cond in enumerate(CondComb):
            body = initbody + "EFR.Epoch_filter_return(" + str(CondComb[c])        
            body = body + ", " + str(DataSource[c])+ ", '" + str(subj) + "', " + str(listRunPerSubj[s])
            body = body + ", " + str(EEGbadlist[s]) + ", " + str(Filt) + ')\n'
    
            arglist = ["'"+subj+"'", str(cond),"'"+ 'grad'+"'", str(Filt)]      
            body = body + 'D2C.Decode2cond(' + ', '.join(arglist) + ')' 

            jobname = subj + "_".join([str(con) for con in cond]) + '_' + str(Filt) + 'Hz'
            ListJobName.append(jobname)  
            ListJobName_full.append(jobname) 
    
            # write jobs in a dedicated folder
            name_file = []
            name_file = os.path.join(path_script, ("JOBS_DECFILT/epoch&decode2C_" + jobname + ".py"))
            Listfile.append(name_file)
            Listfile_full.append(name_file)
            with open(name_file, 'w') as python_file:
                python_file.write(body)
                python_file.close()
    
        body = initbody2 + "RME.rm_epochs('" + str(subj) + "'," + str(Filt) + ')'
        
        jobname = 'rm_all_'+ subj + '_' + str(Filt) 
        ListJobName.append(jobname) 
        ListJobName_full.append(jobname) 
        
        # write jobs in a dedicated folder
        name_file = []
        name_file = os.path.join(path_script, ("JOBS_DECFILT/rmepochs_" + jobname + ".py"))
        Listfile.append(name_file)
        Listfile_full.append(name_file)
        with open(name_file, 'w') as python_file:
            python_file.write(body)
            python_file.close()               
    
    ###########################################################################
    jobs = []
    for i in range(len(Listfile)):
        JobVar = Job(command=['python', Listfile[i]], name = ListJobName[i],
                     native_specification = '-l walltime=24:00:00, -l nodes=1:ppn=5')
        jobs.append(JobVar)
        
    dependencies =  [(jobs[s*10 + n + s],jobs[s*10 +10+s]) 
                    for n in range(len(CondComb))
                    for s in range(len(ListSubj))]                                            
                  
    WfVar = Workflow(jobs=jobs, dependencies=dependencies)
    # save the workflow into a file
    somaWF_name = os.path.join(path_script, "SOMA_WFs/soma_wf_epoch_filt" + str(Filt) + "Hz_decode")
    Helper.serialize(somaWF_name, WfVar)

###############################################################################
jobs = []
for i in range(len(Listfile_full)):
    JobVar = Job(command=['python', Listfile_full[i]], name = ListJobName_full[i],
                 native_specification = '-l walltime=24:00:00, -l nodes=1:ppn=5')
    jobs.append(JobVar)
    
dependencies =  [(jobs[f*(10*17+17) + s*10 + n + s],jobs[f*(10*17+17) + s*10 +10+s]) 
                for n in range(len(CondComb))
                for s in range(len(ListSubj))
                for f in range(len(Filters))]                                            
              
WfVar = Workflow(jobs=jobs, dependencies=dependencies)
# save the workflow into a file
somaWF_name = os.path.join(path_script, "SOMA_WFs/soma_wf_epoch_filt_allfreq_decode")
Helper.serialize(somaWF_name, WfVar)









