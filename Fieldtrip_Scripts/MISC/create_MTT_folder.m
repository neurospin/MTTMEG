% create subject folder

niplist = {'sd130343';'cb130477';'rb130313';'jm100042';'jm100109';'sb120316';...
              'tk130502';'lm130479';'sg120518';'ms130534';'ma100253';'sl130503'};

          
 % create suject folders
cd('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects')         

for i = 1:length(niplist)
    
    mkdir(niplist{i})
    
    cd(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' niplist{i}])
    mkdir('MegData')
    
    cd(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' niplist{i} '/MegData'])
    mkdir('Processed')
    mkdir('ERFPs')
    mkdir('TFs')
    
    cd(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' niplist{i}])
    mkdir('PsychData')
    mkdir('PlotData')
    
    cd(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' niplist{i} '/PlotData'])
    mkdir('ERFPs')
    mkdir('TFs')
    
    cd('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects')     
    
end






























