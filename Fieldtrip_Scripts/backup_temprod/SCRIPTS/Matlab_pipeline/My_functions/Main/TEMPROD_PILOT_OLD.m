%% TEMPROD PILOT ANALYSIS
clear all
close all
%% SET PATHS %%
addpath '/neurospin/local/mne/i686/share/matlab/'                               
addpath '/neurospin/meg_tmp/tools_tmp/pipeline/'                               
addpath '/neurospin/meg_tmp/temprod_Baptiste_2010/SCRIPTS/Temprod_ft_pipeline/my_pipeline'
addpath '/neurospin/meg_tmp/temprod_Baptiste_2010/SCRIPTS/Temprod_ft_pipeline/my_pipeline/FastICA_25'
fieldtrip
fieldtripdefs 

%% PROCESSING %%
% temprod_OLD_preproc(index,isdownsample,subject,runref,trialrejection,newindex)
temprod_OLD_preproc(1,1,'s04',2,1,1);
temprod_OLD_preproc(2,1,'s04',2,1,2);
temprod_OLD_preproc(3,1,'s04',2,1,3);
temprod_OLD_preproc(4,1,'s04',2,0,4);
temprod_OLD_preproc(5,1,'s04',2,0,5);
temprod_OLD_preproc_uniquetrial(6,1,'s04',6,0,6); % redo function for pca correction
temprod_OLD_preproc_uniquetrial(7,1,'s04',7,0,7); % redo function for pca correction

%% FREQUENCY ANALYSIS %%
% temprod_NEW_freqanalysis(isdetrend,index,subject)
%% s03
temprod_NEW_freqanalysis(0,1,'s03'); 
temprod_NEW_freqanalysis(0,2,'s03'); 
temprod_NEW_freqanalysis(0,3,'s03'); 
temprod_NEW_freqanalysis(0,4,'s03'); 
temprod_NEW_freqanalysis(0,5,'s03'); 
temprod_NEW_freqanalysis(0,6,'s03'); 
temprod_NEW_freqanalysis(0,7,'s03'); 
temprod_NEW_freqanalysis(0,8,'s03'); 
%% s04
temprod_NEW_freqanalysis(0,1,'s04'); % duration 5.7
temprod_NEW_freqanalysis(0,2,'s04'); % duration 9.3
temprod_NEW_freqanalysis(0,3,'s04'); % duration 12.8
temprod_NEW_freqanalysis(0,4,'s04'); % motor control 1
temprod_NEW_freqanalysis(0,5,'s04'); % motor control 2
temprod_NEW_freqanalysis(0,6,'s04'); % emprty room
temprod_NEW_freqanalysis(0,7,'s04'); % rest

%% PSD DATA CONCATENATION %%
% appendspectra(index,subject,zscoretag,filter)
appendspectra(1,'s04');
appendspectra(2,'s04');
appendspectra(3,'s04');
appendspectra(4,'s04');

%% DATA OVERVIEW %%
% temprod_new_dataviewer(index,subject,freqband,K,chandisplay,save)
temprod_new_dataviewer(1,'s04',[8 14],[1:30 31:-1:1],1,1);

%% RUN ICA %%
% temprod_NEW_runica(subject,index)
temprod_NEW_runica('s04',1);
temprod_NEW_runica('s04',2);
temprod_NEW_runica('s04',3);
temprod_NEW_runica('s04',4);

%% FREQUENCY ANALYSIS ON ICA COMPONENTS %%
% temprod_NEW_ICAcomp_freqanalysis(isdetrend,index,subject)
temprod_NEW_ICAcomp_freqanalysis(0,1,'s04');
temprod_NEW_ICAcomp_freqanalysis(0,2,'s04');
temprod_NEW_ICAcomp_freqanalysis(0,3,'s04');
temprod_NEW_ICAcomp_freqanalysis(0,4,'s04');

%% PSD OF ICA COMPONENTS CONCATENATION %%
% appendspectra_ICAcomp(index,subject)
appendspectra_ICAcomp(1,'s04');
appendspectra_ICAcomp(2,'s04');
appendspectra_ICAcomp(3,'s04');
appendspectra_ICAcomp(4,'s04');

%% ICA OVERVIEW %%
% temprod_NEW_icaviewer(index,subject,freqband,K,compdisplay,save)
temprod_new_icaviewer(1,'s04',[4 50],[1 2 3 2 1],0,1);
temprod_new_icaviewer(2,'s04',[4 50],[1 2 3 2 1],0,1);
temprod_new_icaviewer(3,'s04',[4 50],[1 2 3 2 1],0,1);
temprod_new_icaviewer(4,'s04',[4 50],[1 2 3 2 1],0,1);

%% plot single trial and averaged band topographies %%
% old version
chantype  = {'Mags';'Gradslong';'Gradslat'};
freqband  = {[4 8];[8 14];[15 30];[30 50]};
for k = 1:length(freqband)
    for i = 1:6
        for j = 1:3
            eval(['temprod_OLD_freqplot(datapath' num2str(i) ...
            ',freqband{' num2str(k) '},' num2str(i) ',chantype{' num2str(j) '},' ...
            'subject);']);
        end
    end
end
% new version
freqband  = {[4 8];[8 14];[15 30];[30 50]};
for k = 1:length(freqband)
    for i = 1;
        eval(['temprod_NEW_freqplot(freqband{' num2str(k) '},' num2str(i) ',''s04'');']);
    end
end

%% plot topographies averaged across trials %%
chantype  = {'Mags';'Gradslong';'Gradslat'};
freqband  = {[4 8];[8 14];[15 30];[51 99]};
for k = 1:length(freqband)
    eval(['temprod_OLD_freqgdaverage(freqband{' num2str(k) '}'...
    ',subject);']);
end
chantype  = {'Mags';'Gradslong';'Gradslat'};
freqband  = {[101 149];[151 199]};
for k = 1:length(freqband)
    eval(['temprod_OLD_freqgdaverage(freqband{' num2str(k) '}'...
    ',subject);']);
end
%%

freqband  = {[4 8];[8 14];[15 30];[30 48]};
temprod_NEW_freqgdaverage(freqband,'s04',1);
temprod_NEW_freqgdaverage(freqband,'s04',2);
temprod_NEW_freqgdaverage(freqband,'s04',3);
temprod_NEW_freqgdaverage(freqband,'s04',4);

%% some global correlations %%
chantype  = {'Mags';'Gradslong';'Gradslat'};
freqband  = {[4 8];[8 14];[15 30];[30 48]};
for k = 1:length(freqband)
    for i = 1:6
        for j = 1:3
            eval(['[rho1(' num2str(k) ',' num2str(i) ',' num2str(j) '),'...
                'rho2(' num2str(k) ',' num2str(i) ',' num2str(j) '),'...
                'pval1(' num2str(k) ',' num2str(i) ',' num2str(j) '),'...
                'pval2(' num2str(k) ',' num2str(i) ',' num2str(j) ')]'...
                '= temprod_OLD_freqstats(datapath' num2str(i) ',freqband{' num2str(k) '},'...
                'chantype{' num2str(j) '},' num2str(i) ',subject);']);
        end
    end
end

treshold = 0.001;
fig = figure('position',[1 1 1280 1024]);
for i = 1:4
    subplot(3,4,i); bar(rho1(i,:,1),'grouped');axis([0 7 -0.7 0.7]);title(['RHO dur,freqpeak :' num2str(freqband{i,1}) 'Hz']);xlabel('duration cond');
    for j = 1:6
        if pval1(i,j,1) <= treshold
            text(j,0.5,'*','color','r','fontsize',20);
        end
    end
    subplot(3,4,4+i); bar(rho1(i,:,2),'grouped');axis([0 7 -0.7 0.7]);title(['RHO dur,freqpeak :' num2str(freqband{i,1}) 'Hz']);xlabel('duration cond');
    for j = 1:6
        if pval1(i,j,2) <= treshold
            text(j,0.5,'*','color','r','fontsize',20);
        end
    end
    subplot(3,4,8+i); bar(rho1(i,:,3),'grouped');axis([0 7 -0.7 0.7]);title(['RHO dur,freqpeak :' num2str(freqband{i,1}) 'Hz']);xlabel('duration cond');
    for j = 1:6
        if pval1(i,j,3) <= treshold
            text(j,0.5,'*','color','r','fontsize',20);
        end
    end
end
fig = figure('position',[1 1 1280 1024]);
for i = 1:4
    subplot(3,4,i); bar(rho2(i,:,1),'grouped');axis([0 7 -0.7 0.7]);title(['RHO dur,freqpeakpow :' num2str(freqband{i,1}) 'Hz']);xlabel('duration cond');
    for j = 1:6
        if pval2(i,j,1) <= treshold
            text(j,0.5,'*','color','r','fontsize',20);
        end
    end
    subplot(3,4,4+i); bar(rho2(i,:,2),'grouped');axis([0 7 -0.7 0.7]);title(['RHO dur,freqpeakpow :' num2str(freqband{i,1}) 'Hz']);xlabel('duration cond');
    for j = 1:6
        if pval2(i,j,2) <= treshold
            text(j,0.5,'*','color','r','fontsize',20);
        end
    end
    subplot(3,4,8+i); bar(rho2(i,:,3),'grouped');axis([0 7 -0.7 0.7]);title(['RHO dur,freqpeakpow :' num2str(freqband{i,1}) 'Hz']);xlabel('duration cond');
    for j = 1:6
        if pval2(i,j,3) <= treshold
            text(j,0.5,'*','color','r','fontsize',20);
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% some global correlations (NEW s04) %%
chantype  = {'Mags';'Gradslong';'Gradslat'};
freqband  = {[4 8];[8 14];[15 30];[30 48]};
for k = 1:length(freqband)
    for i = 1:4
        for j = 1:3
            eval(['[rho1(' num2str(k) ',' num2str(i) ',' num2str(j) '),'...
                'rho2(' num2str(k) ',' num2str(i) ',' num2str(j) '),'...
                'pval1(' num2str(k) ',' num2str(i) ',' num2str(j) '),'...
                'pval2(' num2str(k) ',' num2str(i) ',' num2str(j) ')]'...
                '= temprod_NEW_freqstats(freqband{' num2str(k) '},'...
                'chantype{' num2str(j) '},' num2str(i) ',''s04'');']);
        end
    end
end

treshold = 0.001;
fig = figure('position',[1 1 1280 1024]);
for i = 1:4
    subplot(3,4,i); bar(rho1(i,:,1),'grouped');axis([0 7 -0.7 0.7]);title(['RHO dur,freqpeak :' num2str(freqband{i,1}) 'Hz']);xlabel('duration cond');
    for j = 1:3
        if pval1(i,j,1) <= treshold
            text(j,0.5,'*','color','r','fontsize',20);
        end
    end
    subplot(3,4,4+i); bar(rho1(i,:,2),'grouped');axis([0 7 -0.7 0.7]);title(['RHO dur,freqpeak :' num2str(freqband{i,1}) 'Hz']);xlabel('duration cond');
    for j = 1:3
        if pval1(i,j,2) <= treshold
            text(j,0.5,'*','color','r','fontsize',20);
        end
    end
    subplot(3,4,8+i); bar(rho1(i,:,3),'grouped');axis([0 7 -0.7 0.7]);title(['RHO dur,freqpeak :' num2str(freqband{i,1}) 'Hz']);xlabel('duration cond');
    for j = 1:3
        if pval1(i,j,3) <= treshold
            text(j,0.5,'*','color','r','fontsize',20);
        end
    end
end
fig = figure('position',[1 1 1280 1024]);
for i = 1:4
    subplot(3,4,i); bar(rho2(i,:,1),'grouped');axis([0 7 -0.7 0.7]);title(['RHO dur,freqpeakpow :' num2str(freqband{i,1}) 'Hz']);xlabel('duration cond');
    for j = 1:3
        if pval2(i,j,1) <= treshold
            text(j,0.5,'*','color','r','fontsize',20);
        end
    end
    subplot(3,4,4+i); bar(rho2(i,:,2),'grouped');axis([0 7 -0.7 0.7]);title(['RHO dur,freqpeakpow :' num2str(freqband{i,1}) 'Hz']);xlabel('duration cond');
    for j = 1:3
        if pval2(i,j,2) <= treshold
            text(j,0.5,'*','color','r','fontsize',20);
        end
    end
    subplot(3,4,8+i); bar(rho2(i,:,3),'grouped');axis([0 7 -0.7 0.7]);title(['RHO dur,freqpeakpow :' num2str(freqband{i,1}) 'Hz']);xlabel('duration cond');
    for j = 1:3
        if pval2(i,j,3) <= treshold
            text(j,0.5,'*','color','r','fontsize',20);
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% some global correlations on ICA components %%
chantype  = {'Mags';'Gradslong';'Gradlat'};
freqband  = {[4 8];[8 12];[15 30];[31 48]};
RHO1f = []; RHO2f = []; PVAL1f = []; PVAL2f = [];
for k = 1:length(freqband)
    RHO1c = []; RHO2c = []; PVAL1c = []; PVAL2c = [];
    for i = 1:6
        RHO1 = []; RHO2 = []; PVAL1 = []; PVAL2 = [];
        for j = 1:3
            eval(['[rho1,rho2,pval1,pval2]'...
                '= temprod_OLD_ICAcomp_freqstats(datapath' num2str(i) ',freqband{' num2str(k) '},'...
                'chantype{' num2str(j) '},' num2str(i) ',subject);']);
            RHO1 = [RHO1 rho1'];
            RHO2 = [RHO2 rho2'];
            PVAL1 = [PVAL1 pval1'];
            PVAL2 = [PVAL2 pval2'];
        end
        RHO1c = cat(3,RHO1c,RHO1);
        RHO2c = cat(3,RHO2c,RHO2);
        PVAL1c = cat(3,PVAL1c,PVAL1);
        PVAL2c = cat(3,PVAL2c,PVAL2);
    end
    RHO1f = cat(4,RHO1f,RHO1c);
    RHO2f = cat(4,RHO2f,RHO2c);
    PVAL1f = cat(4,PVAL1f,PVAL1c);
    PVAL2f = cat(4,PVAL2f,PVAL2c);
end

treshold = 0.001;
fig = figure('position',[1 1 1280 1024]);
for i = 1:4
    mysubplot(3,4,i); 
    bar3(squeeze(RHO1f(:,1,:,i)));
    axis([1 6 0 25 -0.5 0.5 ]);
    title(['RHO dur,freqpeak :' num2str(freqband{i,1}) 'Hz']);
    xlabel('duration cond');
%     for j = 1:6
%         if pval1(i,j,1) <= treshold
%             text(j,0.5,'*','color','r','fontsize',20);
%         end
%     end
    mysubplot(3,4,4+i);
    bar3(squeeze(RHO1f(:,2,:,i)));
    axis([1 6 0 25 -0.5 0.5 ]);
    title(['RHO dur,freqpeak :' num2str(freqband{i,1}) 'Hz']);
    xlabel('duration cond');
%     for j = 1:6
%         if pval1(i,j,2) <= treshold
%             text(j,0.5,'*','color','r','fontsize',20);
%         end
%     end
    mysubplot(3,4,8+i);
    bar3(squeeze(RHO1f(:,3,:,i)));
    axis([1 6 0 25 -0.5 0.5 ]);
    title(['RHO dur,freqpeak :' num2str(freqband{i,1}) 'Hz']);
    xlabel('duration cond');
%     for j = 1:6
%         if pval1(i,j,3) <= treshold
%             text(j,0.5,'*','color','r','fontsize',20);
%         end
%     end
end

treshold = 0.001;
fig = figure('position',[1 1 1280 1024]);
for i = 1:4
    mysubplot(3,4,i); 
    bar3(squeeze(RHO2f(:,1,:,i)));
    axis([1 6 0 25 -0.5 0.5 ]);
    title(['RHO dur,powpeak :' num2str(freqband{i,1}) 'Hz']);
    xlabel('duration cond');
%     for j = 1:6
%         if pval1(i,j,1) <= treshold
%             text(j,0.5,'*','color','r','fontsize',20);
%         end
%     end
    mysubplot(3,4,4+i);
    bar3(squeeze(RHO2f(:,2,:,i)));
    axis([1 6 0 25 -0.5 0.5 ]);
    title(['RHO dur,powpeak :' num2str(freqband{i,1}) 'Hz']);
    xlabel('duration cond');
%     for j = 1:6
%         if pval1(i,j,2) <= treshold
%             text(j,0.5,'*','color','r','fontsize',20);
%         end
%     end
    mysubplot(3,4,8+i);
    bar3(squeeze(RHO2f(:,3,:,i)));
    axis([1 6 0 25 -0.5 0.5 ]);
    title(['RHO dur,powpeak :' num2str(freqband{i,1}) 'Hz']);
    xlabel('duration cond');
%     for j = 1:6
%         if pval1(i,j,3) <= treshold
%             text(j,0.5,'*','color','r','fontsize',20);
%         end
%     end
end

%% correlations channel-by-channel in a frequency bands %%
freqband  = {[4 8];[8 14];[15 30];[30 49]};
ptreshold     = 0.01;
for k = 1:length(freqband)
    for i = 5
        eval(['temprod_OLD_freqchanstats(freqband{' num2str(k) '},'...
        num2str(i) ',' num2str(ptreshold) ',subject);']);
    end
end
%
subject = 's04';
freqband  = {[4 8];[8 14];[15 30];[30 48]};
ptreshold     = 0.001;
for k = 1:length(freqband)
    for i = 1
        eval(['temprod_NEW_freqchanstats(freqband{' num2str(k) '},'...
        num2str(i) ',' num2str(ptreshold) ',subject);']);
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% some global correlations on ICA components (new S04) %%
chantype  = {'Mags';'Gradslong';'Gradlat'};
freqband  = {[4 8];[8 14];[15 30];[31 48]};
RHO1f = []; RHO2f = []; PVAL1f = []; PVAL2f = [];
for k = 1:length(freqband)
    RHO1c = []; RHO2c = []; PVAL1c = []; PVAL2c = [];
    for i = 1:4
        RHO1 = []; RHO2 = []; PVAL1 = []; PVAL2 = [];
        for j = 1:3
            eval(['[rho1,rho2,pval1,pval2]'...
                '= temprod_NEW_ICAcomp_freqstats(freqband{' num2str(k) '},'...
                'chantype{' num2str(j) '},' num2str(i) ',''s04'');']);
            RHO1 = [RHO1 rho1'];
            RHO2 = [RHO2 rho2'];
            PVAL1 = [PVAL1 pval1'];
            PVAL2 = [PVAL2 pval2'];
        end
        RHO1c = cat(3,RHO1c,RHO1);
        RHO2c = cat(3,RHO2c,RHO2);
        PVAL1c = cat(3,PVAL1c,PVAL1);
        PVAL2c = cat(3,PVAL2c,PVAL2);
    end
    RHO1f = cat(4,RHO1f,RHO1c);
    RHO2f = cat(4,RHO2f,RHO2c);
    PVAL1f = cat(4,PVAL1f,PVAL1c);
    PVAL2f = cat(4,PVAL2f,PVAL2c);
end

treshold = 0.001;
fig = figure('position',[1 1 1280 1024]);
for i = 1:4
    mysubplot(3,4,i); 
    bar3(squeeze(RHO1f(:,1,:,i)));
    axis([1 3 0 25 -0.5 0.5 ]);
    title(['RHO dur,freqpeak :' num2str(freqband{i,1}) 'Hz']);
    xlabel('duration cond');
%     for j = 1:6
%         if pval1(i,j,1) <= treshold
%             text(j,0.5,'*','color','r','fontsize',20);
%         end
%     end
    mysubplot(3,4,4+i);
    bar3(squeeze(RHO1f(:,2,:,i)));
    axis([1 3 0 25 -0.5 0.5 ]);
    title(['RHO dur,freqpeak :' num2str(freqband{i,1}) 'Hz']);
    xlabel('duration cond');
%     for j = 1:6
%         if pval1(i,j,2) <= treshold
%             text(j,0.5,'*','color','r','fontsize',20);
%         end
%     end
    mysubplot(3,4,8+i);
    bar3(squeeze(RHO1f(:,3,:,i)));
    axis([1 3 0 25 -0.5 0.5 ]);
    title(['RHO dur,freqpeak :' num2str(freqband{i,1}) 'Hz']);
    xlabel('duration cond');
%     for j = 1:6
%         if pval1(i,j,3) <= treshold
%             text(j,0.5,'*','color','r','fontsize',20);
%         end
%     end
end

treshold = 0.001;
fig = figure('position',[1 1 1280 1024]);
for i = 1:4
    mysubplot(3,4,i); 
    bar3(squeeze(RHO2f(:,1,:,i)));
    axis([1 3 0 25 -0.5 0.5 ]);
    title(['RHO dur,powpeak :' num2str(freqband{i,1}) 'Hz']);
    xlabel('duration cond');
%     for j = 1:6
%         if pval1(i,j,1) <= treshold
%             text(j,0.5,'*','color','r','fontsize',20);
%         end
%     end
    mysubplot(3,4,4+i);
    bar3(squeeze(RHO2f(:,2,:,i)));
    axis([1 3 0 25 -0.5 0.5 ]);
    title(['RHO dur,powpeak :' num2str(freqband{i,1}) 'Hz']);
    xlabel('duration cond');
%     for j = 1:6
%         if pval1(i,j,2) <= treshold
%             text(j,0.5,'*','color','r','fontsize',20);
%         end
%     end
    mysubplot(3,4,8+i);
    bar3(squeeze(RHO2f(:,3,:,i)));
    axis([1 3 0 25 -0.5 0.5 ]);
    title(['RHO dur,powpeak :' num2str(freqband{i,1}) 'Hz']);
    xlabel('duration cond');
%     for j = 1:6
%         if pval1(i,j,3) <= treshold
%             text(j,0.5,'*','color','r','fontsize',20);
%         end
%     end
end

%% correlations channel-by-channel in a frequency bands %%
freqband  = {[4 8];[8 14];[15 30];[30 49]};
ptreshold     = 0.01;
for k = 1:length(freqband)
    for i = 5
        eval(['temprod_OLD_freqchanstats(freqband{' num2str(k) '},'...
        num2str(i) ',' num2str(ptreshold) ',subject);']);
    end
end
%
subject = 's04';
freqband  = {[4 8];[8 14];[15 30];[30 49]};
% freqband  = {[8 14]};
ptreshold     = 0.001;
for k = 1:length(freqband)
    for i = 1
        eval(['temprod_NEW_freqchanstats(freqband{' num2str(k) '},'...
        num2str(i) ',' num2str(ptreshold) ',''s04'');']);
    end
end

%% correlations channel-by-channel and frequency bin-by-frequency bin

temprod_NEW_fullcorr(1,0.001,'s04')
temprod_NEW_fullcorr(2,0.001,'s04')
temprod_NEW_fullcorr(3,0.001,'s04')
temprod_NEW_fullcorr(4,0.001,'s04')

temprod_OLD_ICAcomp_fullcorr(1,0.01,subject)
temprod_OLD_ICAcomp_fullcorr(2,0.01,subject)
temprod_OLD_ICAcomp_fullcorr(3,0.01,subject)
temprod_OLD_ICAcomp_fullcorr(4,0.01,subject)
temprod_OLD_ICAcomp_fullcorr(5,0.01,subject)
temprod_OLD_ICAcomp_fullcorr(6,0.01,subject)

temprod_NEW_ICAcomp_fullcorr(1,0.001,'s04')
temprod_NEW_ICAcomp_fullcorr(2,0.001,'s04')
temprod_NEW_ICAcomp_fullcorr(3,0.001,'s04')
temprod_NEW_ICAcomp_fullcorr(4,0.001,'s04')

%% tests
temprod_OLD_GFP_overview(datapath1,0,subject,[0 100],0.001)
temprod_OLD_summary(subject)
temprod_OLD_GFP_overview2(subject,[0 50])
temprod_OLD_freqvar([4 8],chantype{1},1,subject)
temprod_OLD_var_overview(subject,[0 50]);


%% plot mean variance for frequency band %%
chantype  = {'Mags';'Gradslong';'Gradslat'};
freqband  = {[4 8];[8 14];[15 30];[30 50];[51 99]};
for k = 1:length(freqband)
    fig = figure('position',[1 1 1280 1024]);
    for j = 1:3
        for i = 1:6
            mysubplot(3,6,(j-1)*6 + i)
            eval(['temprod_OLD_freqvar(freqband{' num2str(k) '},'...
            'chantype{' num2str(j) '},' num2str(i) ',subject);']);
        end
    end
 print('-dpng',['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/OLD/Plots_' subject...
    '/topovarchan_FreqPeak' chantype{j} '-' num2str(freqband{k}(1)) '-' num2str(freqband{k}(2)) 'hz.png']); 
end

%% compute the 20 first ica components and associed frequency content
temprod_OLD_runica(subject,2)
temprod_OLD_runica(subject,3)
temprod_OLD_runica(subject,4)
temprod_OLD_runica(subject,5)
temprod_OLD_runica(subject,6)

%% search cluster in alpha band
definecluster_alpha(1,'s04')

%% search frequency of power peaks distribution in alpha band

temprod_New_peakdistrib([8 14],1,'s04');
temprod_New_peakdistrib([8 14],2,'s04');
temprod_New_peakdistrib([8 14],3,'s04');
temprod_New_peakdistrib([8 14],4,'s04');

temprod_NEW_ICApipeline(4,'s04')









