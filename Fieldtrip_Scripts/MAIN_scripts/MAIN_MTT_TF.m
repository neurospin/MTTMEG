% MAIN SCRIPT MTT

close all
clear all

bcktmprd = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/backup_temprod/SCRIPTS';
bcktmprd2 = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/backup_temprod/FIELDTRIP';

%addpath('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/fieldtrip-20130901')
addpath('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/fieldtrip-20151209')
addpath(genpath([bcktmprd '/Matlab_pipeline/Ref_functions']));
addpath([bcktmprd '/Matlab_pipeline/My_functions/Preprocessing']);
addpath(bcktmprd2);
addpath('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts');
addpath('/neurospin/meg/meg_tmp/temprod_Baptiste_2010/SCRIPTS/Matlab_pipeline/My_functions/Misc')

ft_defaults


niplist = {'sd130343' ;'cb130477' ;'rb130313'   ;'jm100042' ;'jm100109';'sb120316';...
    'tk130502'  ;'lm130479' ;'sg120518'   ;'ms130534';'ma100253';'sl130503';...
    'mb140004';'mp140019';'mm130405';'dm130250';'hr130504' ;'wl130316';'rl130571'};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% GROUP analysis %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% chansel   = {'Mags';'Grads2';'Grads1'};
% condnames = {'allEventsavbACT';'allEventsavbBASE'};
% PlotColors = [[0.5 0.5 0.5];[0.2 0.2 0.2]];
% for c = 1:3
%     TFSL_GROUPlvl_actvsblt(niplist,chansel{c},condnames,[0 1.01],PlotColors)
% end

%% Relative Time Distance Effects -EVENTS

chansel         = {'Mags';'Grads2';'Grads1';'EEG'};
condnames1 = {'EtDtq1A';'EtDtq2A'};
condnames2 = {'EtDtq1G';'EtDtq2G'};
condnames3 = {'EtDtq1G_Past';'EtDtq2G_Past'};
condnames4 = {'EtDtq1G_Fut';'EtDtq2G_Fut'};
condnames5 = {'EtDtq1G_Pre';'EtDtq2G_Pre'};
condnames6 = {'EtDtq1A';'EtDtq2A';'EtDtq3A'};
condnames7 = {'EtDtq1G';'EtDtq2G';'EtDtq3G'};
condnames8 = {'EtDtq1A';'EtDtq2A';'EtDtq3A';'EtDtq4A'};
condnames9 = {'EtDtq1G';'EtDtq2G';'EtDtq3G';'EtDtq4G'};

PlotColors1 = [[1 0 0];[1 0.75 0.3]];
PlotColors2 = [[1 0 0];[1 0.75 0.3]];
PlotColors3 = [[1 0 0];[1 0.75 0.3]];
PlotColors4 = [[1 0 0];[1 0.75 0.3]];
PlotColors5 = [[1 0 0];[1 0.75 0.3]];
PlotColors6 = [[1 0 0];[1 0.37 0.15];[1 0.75 0.3]];
PlotColors7 = [[1 0 0];[1 0.37 0.15];[1 0.75 0.3]];
PlotColors8   = [[1 0 0];[1 0.25 0.1];[1 0.5 0.2];[1 0.75 0.3]];
PlotColors9   = [[1 0 0];[1 0.25 0.1];[1 0.5 0.2];[1 0.75 0.3]];

foi= {[4 8];[8 12];[15 24]};

for f = 1:3
    for c =4
        
        TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames1,[0 1.01],PlotColors1,foi{f})
        TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames2,[0 1.01],PlotColors2,foi{f})
        TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames6,[0 1.01],PlotColors6,foi{f})
        TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames7,[0 1.01],PlotColors7,foi{f})
        TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames8,[0 1.01],PlotColors8,foi{f})
        TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames9,[0 1.01],PlotColors9,foi{f})
        
        TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames1,[1 1.801],PlotColors1,foi{f})
        TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames2,[1 1.801],PlotColors2,foi{f})
        TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames6,[1 1.801],PlotColors6,foi{f})
        TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames7,[1 1.801],PlotColors7,foi{f})
        TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames8,[1 1.801],PlotColors8,foi{f})
        TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames9,[1 1.801],PlotColors9,foi{f})
        
    end
end

%% Relative Space Distance Effects -EVENTS

chansel         = {'Mags';'Grads2';'Grads1';'EEG'};
condnames1 = {'EsDsq1A';'EsDsq2A'};
condnames2 = {'EsDsq1G';'EsDsq2G'};
condnames3 = {'EsDsq1G_W';'EsDsq2G_W'};
condnames4 = {'EsDsq1G_E';'EsDsq2G_E'};
condnames5 = {'EsDsq1G_Par';'EsDsq2G_Par'};
condnames6 = {'EsDsq1A';'EsDsq2A';'EsDsq3A'};
condnames7 = {'EsDsq1G';'EsDsq2G';'EsDsq3G'};
condnames8 = {'EsDsq1A';'EsDsq2A';'EsDsq3A';'EsDsq4A'};
condnames9 = {'EsDsq1G';'EsDsq2G';'EsDsq3G';'EsDsq4G'};

PlotColors1 = [[0 0 1];[0.3 0.6 1]];
PlotColors2 = [[0 0 1];[0.3 0.6 1]];
PlotColors3 = [[0 0 1];[0.3 0.6 1]];
PlotColors4 = [[0 0 1];[0.3 0.6 1]];
PlotColors5 = [[0 0 1];[0.3 0.6 1]];
PlotColors6 = [[0 0 1];[0.15 0.3 1 ];[0.3 0.6 1]];
PlotColors7 = [[0 0 1];[0.15 0.3 1 ];[0.3 0.6 1]];
PlotColors8 = [[0 0 1];[0.1 0.2 1];[0.2 0.4 1];[0.3 0.6 1]];
PlotColors9 = [[0 0 1];[0.1 0.2 1];[0.2 0.4 1];[0.3 0.6 1]];

foi= {[4 8];[8 12];[15 24]};

for f = 1:3
    for c =4
        
        TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames1,[0 1.01],PlotColors1,foi{f})
        TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames2,[0 1.01],PlotColors2,foi{f})
        TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames6,[0 1.01],PlotColors6,foi{f})
        TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames7,[0 1.01],PlotColors7,foi{f})
        TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames8,[0 1.01],PlotColors8,foi{f})
        TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames9,[0 1.01],PlotColors9,foi{f})
        
        TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames1,[1 1.801],PlotColors1,foi{f})
        TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames2,[1 1.801],PlotColors2,foi{f})
        TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames6,[1 1.801],PlotColors6,foi{f})
        TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames7,[1 1.801],PlotColors7,foi{f})
        TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames8,[1 1.801],PlotColors8,foi{f})
        TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames9,[1 1.801],PlotColors9,foi{f})
        
    end
end

%% Absolute Time Distance Effects -EVENTS

chansel         = {'Mags';'Grads2';'Grads1';'EEG'};
condnames1 = {'EtPre';'EtFut'};
condnames2 = {'EtPre';'EtPast'};
condnames3 = {'EtPre';'EtnoPre'};
condnames4 = {'EtPast';'EtPre';'EtFut'};
condnames5 = {'EtPastG';'EtPreG';'EtFutG'};

PlotColors1 = [[1 0 0];[1 0.75 0.3]];
PlotColors2 = [[1 0 0];[1 0.75 0.3]];
PlotColors3 = [[1 0 0];[1 0.75 0.3]];
PlotColors4 = [[1 0 0];[1 0.37 0.15];[1 0.75 0.3]];
PlotColors5 = [[1 0 0];[1 0.37 0.15];[1 0.75 0.3]];

foi= {[4 8];[8 12];[15 24]};

for f = 1:3
    for c =4
        
        TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames1,[0 1.01],PlotColors1,foi{f})
        TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames2,[0 1.01],PlotColors2,foi{f})
        TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames3,[0 1.01],PlotColors3,foi{f})
        TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames4,[0 1.01],PlotColors4,foi{f})
        TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames5,[0 1.01],PlotColors5,foi{f})
        
        TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames1,[1 1.801],PlotColors1,foi{f})
        TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames2,[1 1.801],PlotColors2,foi{f})
        TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames3,[1 1.801],PlotColors3,foi{f})
        TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames4,[1 1.801],PlotColors4,foi{f})
        TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames5,[1 1.801],PlotColors5,foi{f})
        
    end
end

%% Absolute Space Distance Effects-EVENTS

chansel       = {'Mags';'Grads2';'Grads1';'EEG'};
condnames1 = {'EsPar';'EsWest'};
condnames2 = {'EsPar';'EsEast'};
condnames3 = {'EsPar';'EsnoPar'};
condnames4 = {'EsWest';'EsPar';'EsEast'};
condnames5 = {'EsWestG';'EsParG';'EsEastG'};


PlotColors1 =  [[0 0 1];[0.3 0.6 1]];
PlotColors2 =  [[0 0 1];[0.3 0.6 1]];
PlotColors3 =  [[0 0 1];[0.3 0.6 1]];
PlotColors4 =  [[0 0 1];[0.15 0.3 1 ];[0.3 0.6 1]];
PlotColors5 =  [[0 0 1];[0.15 0.3 1 ];[0.3 0.6 1]];

foi= {[4 8];[8 12];[15 24]};

for f = 1:3
    for c =4
        
        TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames1,[0 1.01],PlotColors1,foi{f})
        TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames2,[0 1.01],PlotColors2,foi{f})
        TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames3,[0 1.01],PlotColors3,foi{f})
        TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames4,[0 1.01],PlotColors4,foi{f})
        TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames5,[0 1.01],PlotColors5,foi{f})
        
        TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames1,[1 1.801],PlotColors1,foi{f})
        TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames2,[1 1.801],PlotColors2,foi{f})
        TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames3,[1 1.801],PlotColors3,foi{f})
        TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames4,[1 1.801],PlotColors4,foi{f})
        TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames5,[1 1.801],PlotColors5,foi{f})
        
    end
end

%% Absolute Time Distance Effects - QUESTIONS

chansel         = {'Mags';'Grads2';'Grads1';'EEG'};
condnames1 = {'QtPre';'QtFut'};
condnames2 = {'QtPre';'QtPast'};
condnames3 = {'QtPast';'QtPre';'QtFut'};

PlotColors1   =  [[1 0 0];[1 0.75 0.3]];
PlotColors2   =  [[1 0 0];[1 0.75 0.3]];
PlotColors3   =  [[1 0 0];[1 0.37 0.15];[1 0.75 0.3]];

foi= {[4 8];[8 12];[15 24]};

for f = 1:3
    for c =4
        
        TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames1,[0 1.01],PlotColors1,foi{f})
        TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames2,[0 1.01],PlotColors2,foi{f})
        TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames3,[0 1.01],PlotColors3,foi{f})
        
    end
end

%% Absolute Space Distance Effects - QUESTIONS

chansel         = {'Mags';'Grads2';'Grads1';'EEG'};
condnames1 = {'QsPar';'QsEast'};
condnames2 = {'QsPar';'QsWest'};
condnames3 = {'QsWest';'QsPar';'QsEast'};

PlotColors1   =  [[0 0 1];[0.3 0.6 1]];
PlotColors2   =  [[0 0 1];[0.3 0.6 1]];
PlotColors3   =  [[0 0 1];[0.15 0.3 1 ];[0.3 0.6 1]];

foi= {[4 8];[8 12];[15 24]};

for f = 1:3
    for c =4
        
        TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames1,[0 1.01],PlotColors1,foi{f})
        TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames2,[0 1.01],PlotColors2,foi{f})
        TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames3,[0 1.01],PlotColors3,foi{f})
        
    end
end

%% Across time and space

chansel           = {'Mags';'Grads2';'Grads1';'EEG'};
condnames1   = {'Et_all';'Es_all'};
condnames2   = {'Qt_all';'Qs_all'};

PlotColors1   =  [[1 0 0];[0 0 1]];
PlotColors2   =  [[1 0 0];[0 0 1]];

foi= {[8 12]};

for f = 1
    for c =1
        TFSL_GROUPlvl_select(niplist,chansel{1},condnames2,[1 2],[-0.5 1.5],PlotColors2,'T',foi{f},'evk')        
        TFSL_GROUPlvl_select(niplist,chansel{1},condnames1,[1 2],[-0.5 1.5],PlotColors1,'T',foi{f},'evk')
    end
end

%% Reference effects
chansel      = {'Mags';'Grads2';'Grads1';'EEG'};
condnames2   = {'RefW';'RefPar';'RefE'};
condnames3   = {'RefPast';'RefPre';'RefFut'};
condnames4   = {'Sproj';'NoProj';'Tproj'};

%PlotColors1   =  [[0.5 0 0 ];[0 0 0];[1 0 0];[0 0 0.5];[0 0 1]];
PlotColors2   =  [[0 0 0.5];[0.3 0.3 0.3];[0 0 1]];
PlotColors3   = [[0.5 0 0];[0.3 0.3 0.3];[1 0 0]];
PlotColors4   = [[0 0 1];[0.3 0.3 0.3];[1 0 0]];

for c =1:4
    TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames2,[1 2 3],[0 0.3],PlotColors2,'F',[8 12],'ind2')
    TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames2,[1 2 3],[0.3 1.1],PlotColors2,'F',[8 12],'ind2')
    TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames2,[1 2 3],[1.1 2],PlotColors2,'F',[8 12],'ind2')
    TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames2,[1 2 3],[2.2 3.4],PlotColors2,'F',[8 12],'ind2')
    TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames2,[1 2 3],[3.4 4.6],PlotColors2,'F',[8 12],'ind2')
end
for c =1:4
    TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames3,[1 2 3],[0 0.3],PlotColors3,'F',[8 12],'ind2')
    TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames3,[1 2 3],[0.3 1.1],PlotColors3,'F',[8 12],'ind2')
    TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames3,[1 2 3],[1.1 2],PlotColors3,'F',[8 12],'ind2')
    TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames3,[1 2 3],[2.2 3.4],PlotColors3,'F',[8 12],'ind2')
    TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames3,[1 2 3],[3.4 4.6],PlotColors3,'F',[8 12],'ind2')
end
for c =1:4
    TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames4,[1 2 3],[0 0.3],PlotColors4,'F',[8 12],'ind2')
    TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames4,[1 2 3],[0.3 1.1],PlotColors4,'F',[8 12],'ind2')
    TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames4,[1 2 3],[1.1 2],PlotColors4,'F',[8 12],'ind2')
    TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames4,[1 2 3],[2.2 3.4],PlotColors4,'F',[8 12],'ind2')
    TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames4,[1 2 3],[3.4 4.6],PlotColors4,'F',[8 12],'ind2')
end

for c =1:4
    TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames4,[1 2],[0 0.3],PlotColors4,'T',[8 12],'ind2',[0 1])
    TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames4,[1 2],[0.3 1.1],PlotColors4,'T',[8 12],'ind2',[0 1])
    TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames4,[1 2],[1.1 2],PlotColors4,'T',[8 12],'ind2',[0 1])
    TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames4,[1 2],[2.2 3.4],PlotColors4,'T',[8 12],'ind2',[0 1])
    TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames4,[1 2],[3.4 4.6],PlotColors4,'T',[8 12],'ind2',[0 1])
end
for c =1:4
    TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames4,[2 2],[0 0.3],PlotColors4,'T',[8 12],'ind2',[0 1])
    TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames4,[2 2],[0.3 1.1],PlotColors4,'T',[8 12],'ind2',[0 1])
    TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames4,[2 2],[1.1 2],PlotColors4,'T',[8 12],'ind2',[0 1])
    TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames4,[2 2],[2.2 3.4],PlotColors4,'T',[8 12],'ind2',[0 1])
    TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames4,[2 2],[3.4 4.6],PlotColors4,'T',[8 12],'ind2',[0 1])
end
for c =1:4
    TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames4,[3 2],[0 0.3],PlotColors4,'T',[8 12],'ind2',[0 1])
    TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames4,[3 2],[0.3 1.1],PlotColors4,'T',[8 12],'ind2',[0 1])
    TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames4,[3 2],[1.1 2],PlotColors4,'T',[8 12],'ind2',[0 1])
    TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames4,[3 2],[2.2 3.4],PlotColors4,'T',[8 12],'ind2',[0 1])
    TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames4,[3 2],[3.4 4.6],PlotColors4,'T',[8 12],'ind2',[0 1])
end
for c =1:4
    TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames4,[3 1],[0 0.3],PlotColors4,'T',[8 12],'ind2')
    TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames4,[3 1],[0.3 1.1],PlotColors4,'T',[8 12],'ind2')
    TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames4,[3 1],[1.1 2],PlotColors4,'T',[8 12],'ind2')
    TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames4,[3 1],[2.2 3.4],PlotColors4,'T',[8 12],'ind2')
    TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames4,[3 1],[3.4 4.6],PlotColors4,'T',[8 12],'ind2')
end
for c =1:4
    TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames4,[3 2],[0 0.3],PlotColors4,'T',[8 12],'ind2')
    TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames4,[3 2],[0.3 1.1],PlotColors4,'T',[8 12],'ind2')
    TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames4,[3 2],[1.1 2],PlotColors4,'T',[8 12],'ind2')
    TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames4,[3 2],[2.2 3.4],PlotColors4,'T',[8 12],'ind2')
    TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames4,[3 2],[3.4 4.6],PlotColors4,'T',[8 12],'ind2')
end
for c =1:4
    TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames4,[1 2],[0 0.3],PlotColors4,'T',[8 12],'ind2')
    TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames4,[1 2],[0.3 1.1],PlotColors4,'T',[8 12],'ind2')
    TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames4,[1 2],[1.1 2],PlotColors4,'T',[8 12],'ind2')
    TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames4,[1 2],[2.2 3.4],PlotColors4,'T',[8 12],'ind2')
    TFSL_GROUPlvl_GENERAL(niplist,chansel{c},condnames4,[1 2],[3.4 4.6],PlotColors4,'T',[8 12],'ind2')
end

%%

chansel   = {'Mags';'Grads2';'Grads1'};
condnames1 = {'EtDtq1G';'EtDtq2G'};
condnames2 = {'EsDsq1G';'EsDsq2G'};
PlotColors = [[1 0 0];[1 0.75 0.3];[0 0 1];[0.3 0.6 1]];
for c = 1:3
    TFSL_GROUPlvl_INT(niplist,chansel{c},condnames1,condnames2,[0 1.01],PlotColors)
end

chansel   = {'Mags';'Grads2';'Grads1'};
condnames1 = {'EtDtq1G_Past';'EtDtq2G_Past'};
condnames2 = {'EtDtq1G_Pre';'EtDtq2G_Pre'};
condnames3 = {'EtDtq1G_Fut';'EtDtq2G_Fut'};
PlotColors = [[1 0 0];[1 0.75 0.3];[1 0 0];[1 0.75 0.3];[1 0 0];[1 0.75 0.3]];
for c = 1:3
    TFSL_GROUPlvl_REG_INT(niplist,chansel{c},condnames1,condnames2,condnames3,[0 1.01],PlotColors)
end

chansel   = {'Mags';'Grads2';'Grads1'};
condnames1 = {'EsDsq1G_W';'EsDsq2G_W'};
condnames2 = {'EsDsq1G_Par';'EsDsq2G_Par'};
condnames3 = {'EsDsq1G_E';'EsDsq2G_E'};
PlotColors = [[1 0 0];[1 0.75 0.3];[1 0 0];[1 0.75 0.3];[1 0 0];[1 0.75 0.3]];
for c = 1:3
    TFSL_GROUPlvl_REG_INT(niplist,chansel{c},condnames1,condnames2,condnames3,[0 1.01],PlotColors)
end

%%%

chansel   = {'Mags';'Grads2';'Grads1'};
PlotColors = [[1 0 0];[1 0.75 0.3]];
condclust    = {'EtDtq1G';'EtDtq2G'};
condnames = {{'EtDtq1G_Past';'EtDtq2G_Past'};...
    {'EtDtq1G_Pre';'EtDtq2G_Pre'};...
    {'EtDtq1G_Fut';'EtDtq2G_Fut'}};
for c = 1:3
    TFSL_GROUPlvl_PLOT(niplist,chansel{c},condclust,condnames,[0 1.01],PlotColors)
end

chansel   = {'Mags';'Grads2';'Grads1'};
PlotColors = [[1 0 0];[1 0.75 0.3]];
condclust    = {'EsDsq1A';'EsDsq2A'};
condnames = {{'EsDsq1G_W';'EsDsq2G_W'};...
    {'EsDsq1G_Par';'EsDsq2G_Par'};...
    {'EsDsq1G_E';'EsDsq2G_E'}};
for c = 1:3
    TFSL_GROUPlvl_PLOT(niplist,chansel{c},condclust,condnames,[0 1.01],PlotColors)
end

chansel   = {'Mags';'Grads2';'Grads1'};
PlotColors = [[1 0 0];[1 0.37 0.15];[1 0.75 0.3]];
condclust    = {'EtDtq1G';'EtDtq2G'};
condnames = {{'EtPast';'EtPre';'EtFut'}};
for c = 1:3
    TFSL_GROUPlvl_PLOT3(niplist,chansel{c},condclust,condnames,[0 1.01],PlotColors)
end

chansel   = {'Mags';'Grads2';'Grads1'};
PlotColors = [[1 0.7 0.7];[1 0.5 0.5];[1 0.7 0.7]];
condclust    = {'EsDsq1A';'EsDsq2A'};
condnames = {{'EsWest';'EsPar';'EsEast'}};
for c = 1:3
    TFSL_GROUPlvl_PLOT3(niplist,chansel{c},condclust,condnames,[0 1.01],PlotColors)
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:19
    
        TFSL_SUBJlvl_EEGv2(niplist{i},'EEG',{'EVS'},@make_AVG_DIST2_EVS,[1 3],[-0.2 3.5])
        TFSL_SUBJlvl_EEGv2(niplist{i},'EEG',{'EVS'},@make_AVG_DIST2_EVS_True,[1 3],[-0.2 3.5])
        TFSL_SUBJlvl_EEGv2(niplist{i},'EEG',{'EVS'},@make_AVG_DIST3_EVS,[1 3],[-0.2 3.5])
        TFSL_SUBJlvl_EEGv2(niplist{i},'EEG',{'EVS'},@make_AVG_DIST3_EVS_True,[1 3],[-0.2 3.5])
        TFSL_SUBJlvl_EEGv2(niplist{i},'EEG',{'EVS'},@make_AVG_DIST4_EVS,[1 3],[-0.2 3.5])
        TFSL_SUBJlvl_EEGv2(niplist{i},'EEG',{'EVS'},@make_AVG_DIST4_EVS_True,[1 3],[-0.2 3.5])
    
        TFSL_SUBJlvl_EEGv2(niplist{i},'EEG',{'EVT'},@make_AVG_DIST2_EVT,[1 3],[-0.2 3.5])
        TFSL_SUBJlvl_EEGv2(niplist{i},'EEG',{'EVT'},@make_AVG_DIST2_EVT_True,[1 3],[-0.2 3.5])
        TFSL_SUBJlvl_EEGv2(niplist{i},'EEG',{'EVT'},@make_AVG_DIST3_EVT,[1 3],[-0.2 3.5])
        TFSL_SUBJlvl_EEGv2(niplist{i},'EEG',{'EVT'},@make_AVG_DIST3_EVT_True,[1 3],[-0.2 3.5])
        TFSL_SUBJlvl_EEGv2(niplist{i},'EEG',{'EVT'},@make_AVG_DIST4_EVT,[1 3],[-0.2 3.5])
        TFSL_SUBJlvl_EEGv2(niplist{i},'EEG',{'EVT'},@make_AVG_DIST4_EVT_True,[1 3],[-0.2 3.5])
    
        TFSL_SUBJlvl_EEGv2(niplist{i},'EEG',{'QTT'},@make_AVG_QTfutvspre,[1 2],[-0.5 1.5])
        TFSL_SUBJlvl_EEGv2(niplist{i},'EEG',{'QTT'},@make_AVG_QTpastvspre,[1 2],[-0.5 1.5])
        TFSL_SUBJlvl_EEGv2(niplist{i},'EEG',{'QTT'},@make_AVG_QTfutvsprevspast,[1 2],[-0.5 1.5])
    
        TFSL_SUBJlvl_EEGv2(niplist{i},'EEG',{'QTS'},@make_AVG_QTwvspar,[1 2],[-0.5 1.5])
        TFSL_SUBJlvl_EEGv2(niplist{i},'EEG',{'QTS'},@make_AVG_QTevspar,[1 2],[-0.5 1.5])
        TFSL_SUBJlvl_EEGv2(niplist{i},'EEG',{'QTS'},@make_AVG_QTwvsparvse,[1 2],[-0.5 1.5])
    
        TFSL_SUBJlvl_EEGv2(niplist{i},'EEG',{'EVT'},@make_AVG_EVfutvspre,[1 3],[-0.2 3.5])
        TFSL_SUBJlvl_EEGv2(niplist{i},'EEG',{'EVT'},@make_AVG_EVpastvspre,[1 3],[-0.2 3.5])
        TFSL_SUBJlvl_EEGv2(niplist{i},'EEG',{'EVT'},@make_AVG_EVpastvsprevsfut,[1 3],[-0.2 3.5])
    
        TFSL_SUBJlvl_EEGv2(niplist{i},'EEG',{'EVS'},@make_AVG_EVwvspar,[1 3],[-0.2 3.5])
        TFSL_SUBJlvl_EEGv2(niplist{i},'EEG',{'EVS'},@make_AVG_EVevspar,[1 3],[-0.2 3.5])
        TFSL_SUBJlvl_EEGv2(niplist{i},'EEG',{'EVS'},@make_AVG_EVevsparvsw,[1 3],[-0.2 3.5])
    
        TF_SUBJlvl_EEGv2(niplist{i},'EEG',{'EVT';'EVS'},@make_AVG_EVTvsEVS,[1 3],[-0.2 3.5])
        TF_SUBJlvl_EEGv2(niplist{i},'EEG',{'QTT';'QTS'},@make_AVG_QTTvsQTS,[1 2],[-0.5 1.5])
    
        TFSL_SUBJlvl_EEGv2(niplist{i},'EEG',{'EVT'},@make_AVG_DIST2_EVT_True_Past,[1 3],[-0.2 3.5])
        TFSL_SUBJlvl_EEGv2(niplist{i},'EEG',{'EVT'},@make_AVG_DIST2_EVT_True_Pre,[1 3],[-0.2 3.5])
        TFSL_SUBJlvl_EEGv2(niplist{i},'EEG',{'EVT'},@make_AVG_DIST2_EVT_True_Fut,[1 3],[-0.2 3.5])
        TFSL_SUBJlvl_EEGv2(niplist{i},'EEG',{'EVS'},@make_AVG_DIST2_EVS_True_W,[1 3],[-0.2 3.5]);
        TFSL_SUBJlvl_EEGv2(niplist{i},'EEG',{'EVS'},@make_AVG_DIST2_EVS_True_par,[1 3],[-0.2 3.5])
        TFSL_SUBJlvl_EEGv2(niplist{i},'EEG',{'EVS'},@make_AVG_DIST2_EVS_True_E,[1 3],[-0.2 3.5])
    
        TFSL_SUBJlvl_EEGv2(niplist{i},'EEG',{'EVS'},@make_AVG_EVevsparvsw_true,[1 3],[-0.2 3.5])
        TFSL_SUBJlvl_EEGv2(niplist{i},'EEG',{'EVT'},@make_AVG_EVpastvsprevsfut_true,[1 3],[-0.2 3.5])
        TFSL_SUBJlvl_EEGv2(niplist{i},'EEG',{'EVT'},@make_AVG_EVpre_vs_nonpre,[1 3],[-0.2 3.5])
        TFSL_SUBJlvl_EEGv2(niplist{i},'EEG',{'EVS'},@make_AVG_EVparvsnonpar,[1 3],[-0.2 3.5])
end


chansel   = {'Mags';'Grads2';'Grads1'};
for c = 1:3
    for i = 1:19
        
        TFSL_SUBJlvl_v2(niplist{i},chansel{c},{'REF'},@make_AVG_REF_W_Par_E,[0.3 2.2],[-0.2 3.5])
        TFSL_SUBJlvl_v2(niplist{i},chansel{c},{'REF'},@make_AVG_REF_W_Par,[0.3 2.2],[-0.2 3.5])
        TFSL_SUBJlvl_v2(niplist{i},chansel{c},{'REF'},@make_AVG_REF_Pre_Fut,[0.3 2.2],[-0.2 3.5])
        TFSL_SUBJlvl_v2(niplist{i},chansel{c},{'REF'},@make_AVG_REF_Past_Pre_Fut,[0.3 2.2],[-0.2 3.5])
        TFSL_SUBJlvl_v2(niplist{i},chansel{c},{'REF'},@make_AVG_REF_Past_Pre,[0.3 2.2],[-0.2 3.5])
        TFSL_SUBJlvl_v2(niplist{i},chansel{c},{'REF'},@make_AVG_REF_Par_E,[0.3 2.2],[-0.2 3.5])
        
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
chansel   = {'Mags';'Grads2';'Grads1'};
for c = 1:3
    for i = 1:19

        TFSL_SUBJlvl_v2(niplist{i},chansel{c},{'EVS'},@make_AVG_DIST4_EVS_True,[0.5 3.5],[-0.2 3.5])
        TFSL_SUBJlvl_v2(niplist{i},chansel{c},{'EVT'},@make_AVG_DIST4_EVT_True,[0.5 3.5],[-0.2 3.5])
        TFSL_SUBJlvl_v2(niplist{i},chansel{c},{'QTT'},@make_AVG_QTfutvsprevspast,[0.3 1.2],[-0.2 3.5])
        TFSL_SUBJlvl_v2(niplist{i},chansel{c},{'QTS'},@make_AVG_QTwvsparvse,[0.3 1.2],[-0.2 3.5])
        
        TFSL_SUBJlvl_v2(niplist{i},chansel{c},{'EVT'},@make_AVG_EVpastvsprevsfut,[0.5 3.5],[-0.2 3.5])
        TFSL_SUBJlvl_v2(niplist{i},chansel{c},{'EVS'},@make_AVG_EVevsparvsw,[0.5 3.5],[-0.2 3.5])
        
        TFSL_SUBJlvl_v2(niplist{i},chansel{c},{'EVT';'EVS'},@make_AVG_EVTvsEVS,[0.5 3.5],[-0.5 3.5])
        TFSL_SUBJlvl_v2(niplist{i},chansel{c},{'QTT';'QTS'},@make_AVG_QTTvsQTS,[0.5 3.5],[-0.5 3.5])
        
        TFSL_SUBJlvl_v2(niplist{i},chansel{c},{'REF'},@make_AVG_REF_Past_Pre_Fut,[0.3 2.2],[-0.2 3.5])
        TFSL_SUBJlvl_v2(niplist{i},chansel{c},{'REF'},@make_AVG_REF_W_Par_E,[0.3 2.2],[-0.2 3.5])
        
    end
end

chansel   = {'Mags','EEG'};
for c = 1
    for i = 1:19
        FFT_SUBJlvl(niplist{i},chansel{c},{'EVT';'EVS'},@make_AVG_EVTvsEVS,[0.5 3.5],[0 1])
        FFT_SUBJlvl(niplist{i},chansel{c},{'QTT';'QTS'},@make_AVG_QTTvsQTS,[0.5 3.5],[0 1])
    end
end

chansel   = {'Mags','EEG'};
for c = 1
    for i = 1:19
        FFT_SUBJlvl(niplist{i},chansel{c},{'EVT'},@make_AVG_EVpastvsprevsfut_true,[0.5 3.5],[0 1])
        FFT_SUBJlvl(niplist{i},chansel{c},{'EVS'},@make_AVG_EVevsparvsw_true,[0.5 3.5],[0 1])
    end
end

chansel   = {'Mags','EEG'};
for c = 1
    for i = 1:19
        FFT_SUBJlvl(niplist{i},chansel{c},{'REF'},@make_AVG_REF_Past_Pre_Fut,[0.3 2.2],[0 2])
        FFT_SUBJlvl(niplist{i},chansel{c},{'REF'},@make_AVG_REF_W_Par_E,[0.3 2.2],[0 2])
    end
end

chansel           = {'Mags';'Grads2';'Grads1';'EEG'};
condnames1   = {'Et_all';'Es_all'};
condnames2   = {'Qt_all';'Qs_all'};
condnames3   = {'EtPastG';'EtPreG';'EtFutG'}
condnames4   = {'EsWestG';'EsParG';'EsEastG'}
condnames5   = {'RefPast';'RefPre';'RefFut'}
condnames6   = {'RefW';'RefPar';'RefE'}
PlotColors1   =  [[1 0 0];[0 0 1]];
FFT_GROUPlvl_from_mne(niplist,chansel{1},condnames6,[0 2],PlotColors1,'T')

chansel   = {'Mags'};
for c = 1
    for i = 11:19
        TFSL_SUBJlvl_v2(niplist{i},chansel{c},{'EVT';'EVS'},@make_AVG_EVTvsEVS,[0.5 3.5],[-0.4 3.5])
        TFSL_SUBJlvl_v2(niplist{i},chansel{c},{'QTT';'QTS'},@make_AVG_QTTvsQTS,[0.5 3.5],[-0.4 3.5])
    end
end
chansel   = {'Mags'};
for c = 1
    for i = 1:10
        TFSL_SUBJlvl_v2(niplist{i},chansel{c},{'EVT';'EVS'},@make_AVG_EVTvsEVS,[0.5 3.5],[-0.4 3.5])
        TFSL_SUBJlvl_v2(niplist{i},chansel{c},{'QTT';'QTS'},@make_AVG_QTTvsQTS,[0.5 3.5],[-0.4 3.5])
    end
end
chansel   = {'Mags'};
for c = 1
    for i = 11:19
        TFSL_SUBJlvl_v2(niplist{i},chansel{c},{'EVT';'EVS'},@make_AVG_EVTvsEVS,[0.5 3.5],[-0.4 3.5])
        TFSL_SUBJlvl_v2(niplist{i},chansel{c},{'QTT';'QTS'},@make_AVG_QTTvsQTS,[0.5 3.5],[-0.4 3.5])
    end
end

chansel   = {'Mags';'Grads2';'Grads1'};
for c = 1:3
    for i = 1:10
        TFSL_SUBJlvl_v2(niplist{i},chansel{c},{'REF'},@make_AVG_REF_W_Par_E,[3 8],[-3 8])
        TFSL_SUBJlvl_v2(niplist{i},chansel{c},{'REF'},@make_AVG_REF_W_Par,[3 8],[-3 8])
        TFSL_SUBJlvl_v2(niplist{i},chansel{c},{'REF'},@make_AVG_REF_Pre_Fut,[3 8],[-3 8])
        TFSL_SUBJlvl_v2(niplist{i},chansel{c},{'REF'},@make_AVG_REF_Past_Pre_Fut,[3 8],[-3 8])
        TFSL_SUBJlvl_v2(niplist{i},chansel{c},{'REF'},@make_AVG_REF_Past_Pre,[3 8],[-3 8])
        TFSL_SUBJlvl_v2(niplist{i},chansel{c},{'REF'},@make_AVG_REF_Par_E,[3 8],[-3 8]) 
        TFSL_SUBJlvl_v2(niplist{i},chansel{c},{'REF'},@make_SProj_NoProj_TProj,[3 8],[-3 8])
        TFSL_SUBJlvl_v2(niplist{i},chansel{c},{'REF'},@make_SProj_TProj,[3 8],[-3 8])
    end
end

chansel   = {'Mags';'Grads2';'Grads1'};
for c = 1:3
    for i = 6:10
        TFinducedSL_SUBJlvl_v2(niplist{i},chansel{c},{'REF'},@make_AVG_REF_W_Par_E,[3 8],[-3 8])
        TFinducedSL_SUBJlvl_v2(niplist{i},chansel{c},{'REF'},@make_AVG_REF_W_Par,[3 8],[-3 8])
        TFinducedSL_SUBJlvl_v2(niplist{i},chansel{c},{'REF'},@make_AVG_REF_Pre_Fut,[3 8],[-3 8])
        TFinducedSL_SUBJlvl_v2(niplist{i},chansel{c},{'REF'},@make_AVG_REF_Past_Pre_Fut,[3 8],[-3 8])
        TFinducedSL_SUBJlvl_v2(niplist{i},chansel{c},{'REF'},@make_AVG_REF_Past_Pre,[3 8],[-3 8])
        TFinducedSL_SUBJlvl_v2(niplist{i},chansel{c},{'REF'},@make_AVG_REF_Par_E,[3 8],[-3 8])
        TFinducedSL_SUBJlvl_v2(niplist{i},chansel{c},{'REF'},@make_SProj_NoProj_TProj,[3 8],[-3 8])
        TFinducedSL_SUBJlvl_v2(niplist{i},chansel{c},{'REF'},@make_SProj_TProj,[3 8],[-3 8])
    end
end

chansel   = {'EEG'};
for c = 1
    for i =  16:19
        TFinducedSL_SUBJlvl_EEGv2(niplist{i},chansel{c},{'REF'},@make_AVG_REF_W_Par_E,[3 8],[-3 8])
        TFinducedSL_SUBJlvl_EEGv2(niplist{i},chansel{c},{'REF'},@make_AVG_REF_W_Par,[3 8],[-3 8])
        TFinducedSL_SUBJlvl_EEGv2(niplist{i},chansel{c},{'REF'},@make_AVG_REF_Pre_Fut,[3 8],[-3 8])
        TFinducedSL_SUBJlvl_EEGv2(niplist{i},chansel{c},{'REF'},@make_AVG_REF_Past_Pre_Fut,[3 8],[-3 8])
        TFinducedSL_SUBJlvl_EEGv2(niplist{i},chansel{c},{'REF'},@make_AVG_REF_Past_Pre,[3 8],[-3 8])
        TFinducedSL_SUBJlvl_EEGv2(niplist{i},chansel{c},{'REF'},@make_AVG_REF_Par_E,[3 8],[-3 8]) 
        TFinducedSL_SUBJlvl_EEGv2(niplist{i},chansel{c},{'REF'},@make_SProj_NoProj_TProj,[3 8],[-3 8])
        TFinducedSL_SUBJlvl_EEGv2(niplist{i},chansel{c},{'REF'},@make_SProj_TProj,[3 8],[-3 8])
    end
end


