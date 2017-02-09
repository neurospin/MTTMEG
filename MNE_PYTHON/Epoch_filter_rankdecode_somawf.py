# -*- coding: utf-8 -*-
"""
Created on Thu Oct 29 18:50:47 2015

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
	  'sd130343',
        'cb130477', 'rb130313', 'jm100109', 
        'sb120316', 'tk130502','lm130479', 'ms130534', 
        'ma100253', 'sl130503', 'mb140004','mp140019', 
        'dm130250', 'hr130504', 'wl130316', 'rl130571')

listRunPerSubj = (
        ('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
        ('run1_GD','run2_GD','run3_DG','run4_DG','run5_GD'),
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
	('EsWest','EsPar','EsEast'))

# on which kind of sensors
decodmod = ('grad')

Filters = [0.5]

Classes = ((1,2,3),
         (1,2,3),
         (1,2,3),
         (1,2,3),
         (1,2,3),
         (1,2,3))

Windows = ((-0.2, 0.),(0., 0.1 ),(0., 0.2),(0., 0.3),(0., 0.4),(0., 0.5 ),
           (0., 0.6),(0., 0.7),(0., 0.8),(0., 0.9),(0., 1.),(0.1, 1.1))
RidgeAlpha = (10000, 1000, 100, 10, 1, 0.1, 0.01, 0.001, 0.0001)

###############################################################################
###############################################################################
def write_job(body,folder, pre_jobname, post_jobname,Listfile, ListJobName):
    ListJobName.append(post_jobname)  

    # write jobs in the dedicated folder
    name_file = []
    name_file = os.path.join(path_script, (folder + "/" + pre_jobname + 
                                           post_jobname + ".py"))
    Listfile.append(name_file)
    with open(name_file, 'w') as python_file:
        python_file.write(body)
        python_file.close()

    return Listfile, ListJobName

###############################################################################
###############################################################################
# init jobs file content and names
Liste_python_files = []
initbody = "import os \n"
initbody = initbody + "os.chdir('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/SCRIPTS/MNE_PYTHON')\n"
initbody = initbody + "import Epoch_filterband_return as EFR\n"
initbody = initbody + "import rank_decode_v3 as RKD\n"

initbody2 = initbody + "import rm_epochs as RME\n"

# write job files (basically a python script calling the function of interest with arguments of interest)
# for each band pass filter, generate a workflow
folder = 'JOBS_RANK'
python_file, Listfile, ListJobName = [], [], []
for f, Filt in enumerate(Filters):
    
    # epochs data with different band-pass filters
    for c,cond in enumerate(CondComb):
        for s,subj in enumerate(ListSubj):
            
            arglist = []
            arglist = [str(CondComb[c]),str(DataSource[c]),("'"+str(subj)+"'"),
                       str(listRunPerSubj[s]),str(EEGbadlist[s]),str(Filt)]   
            body = (initbody + "EFR.Epoch_filterband_return(" +
                    ', '.join(arglist) + ')\n')                             
                                                
            # rank decoding across a range of alpha parameters
            for a,alpha in enumerate(RidgeAlpha):
                for w,window in enumerate(Windows):
                    
                    arglist = []
                    arglist = ["'"+str(subj)+"'",str(cond),str(Classes[c]),"'grad'",
                               str(window),str(alpha),str(Filt)]
                    body = body + 'RKD.rank_decode_v3(' + ', '.join(arglist) + ')\n'  
                    post_jobname = (str(subj)+'_'+"_".join([str(con) for con in cond])
                                    + '_allWindows_allAlphas_' + str(Filt) + '-30Hz' )
                    pre_jobname = 'epochs&rank_'
                    
            Listfile,ListJobName = write_job(body,folder, pre_jobname, 
                                              post_jobname,Listfile,ListJobName)
        
        # remove epochs after having computed and saved the decoding scores   
#        arglist = []  
#        arglist = [(str(ListSubj)),str(Filt),str(cond)]
#        body = initbody2 + "RME.rm_epochs(" + ', '.join(arglist) + ')' 
#        post_jobname = ('rm_all_' + str(Filt) + 
#                       "_".join([str(con) for con in cond]))
#        pre_jobname = 'rmepochs_'
#        Listfile,ListJobName = write_job(body,folder, pre_jobname, 
#                                         post_jobname,Listfile,ListJobName)
#                                 
# append jobs in list
jobs = []
for i in range(len(Listfile)):
    JobVar = Job(command=['python', Listfile[i]], name = ListJobName[i],
                 native_specification = '-l walltime=24:00:00')
    jobs.append(JobVar)

# write dependancies 
#dep1 = []
#count = -1
#
#for f, Filt in enumerate(Filters):
#    for c,cond in enumerate(CondComb):
#        for s,subj in enumerate(ListSubj):             
#            count = count + 1
#            # make epochs cleaning jobs dependent from decoding jobs
#            dep1.append((jobs[count],jobs[(len(ListSubj)+1)*(c+1)*(f+1) -1]))
#        count = count + 1


# write a workflow 
WfVar = Workflow(jobs=jobs, dependencies=[])
# save the workflow into a file
somaWF_name = os.path.join(path_script, "SOMA_WFs/soma_wf_epoch_filt_allband_rank_decode")
Helper.serialize(somaWF_name, WfVar)





