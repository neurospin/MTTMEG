function [trl] = trialfun_mtt_QTT_v2(cfg)

%% test dataset
% cfg.dataset = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/hr130504/raw_sss/run1_GD_trans_sss.fif';

%% get recording trigger value and corresponding samples
events = ft_read_event(cfg.dataset);
hdr    = ft_read_header(cfg.dataset);

value  = [events(find(strcmp('STI101', {events.type}))).value]';
sample = [events(find(strcmp('STI101', {events.type}))).sample]';

%% remove responses trigger values
for i = 1:length(value)
    if (value(i) < 0)
        valuetrig(i) = value(i) + 32768;
    elseif (value(i) >= 0) && (value(i) < 256)
        valuetrig(i) = value(i);
    elseif (value(i) >= 256) && (value(i) < 512)
        valuetrig(i) = value(i) - 256;
    elseif (value(i) >= 512) && (value(i) < 1024)
        valuetrig(i) = value(i) - 512;
    elseif (value(i) > 1024) && (value(i) < 32768)
        valuetrig(i) = value(i) - 1024;
    elseif (value(i) > 32768)
        valuetrig(i) = value(i) - 32768;
    else
        valuetrig(i) = value(i);
    end
end

%% change responses trigger values
for i = 2:length(value)
    if (value(i) == 1024) && (value(i-1) >=16) && (value(i-1) <=35)
        value(i) = value(i-1) + 100;
    elseif (value(i) == 32768) && (value(i-1) >=16) && (value(i-1) <=35)
        value(i) = value(i-1) + 200;
    else
        value(i) = value(i);
    end
end

% Lets's check pour MiniBlock REF triggers
samplelist = [];
for i = 1:length(valuetrig)
    if valuetrig(i) == 1;
        samplelist = [samplelist [sample(i) ;i ; 1]];
    elseif valuetrig(i) == 2;
        samplelist = [samplelist [sample(i) ;i ; 2]];
    elseif valuetrig(i) == 3;
        samplelist = [samplelist [sample(i) ;i ; 3]];
    elseif valuetrig(i) == 4;
        samplelist = [samplelist [sample(i) ;i ; 4]];
    elseif valuetrig(i) == 5;
        samplelist = [samplelist [sample(i) ;i ; 5]];
    end
end
samplelist(:,length(samplelist)+1) = [sample(end); length(sample); 6];

% there should be between 25 to 33 triggers between each miniblock
% if there is an extra miniblock trigger, let's remove it
sampletoremove = [];
for i = 2:length(samplelist)
    if (samplelist(2,i) - samplelist(2,i-1)) < 25
        if valuetrig(samplelist(2,i-1)+1) == (2*samplelist(3,i-1)+4) || valuetrig(samplelist(2,i-1)+1) == (2*samplelist(3,i-1)+5)
            sampletoremove = [sampletoremove samplelist(2,i)];
        else
            sampletoremove = [sampletoremove samplelist(2,i-1)];
        end
    end
end

% correct indices for removed events
for i = 1:length(sampletoremove)
    sample(sampletoremove(i)) = [];
    valuetrig(sampletoremove(i)) = [];
    
    [x,y] = find(samplelist(2,:) == sampletoremove(i));
    samplelist(:,y) = [];
    
    samplelist(2,(y:end)) = samplelist(2,(y:end)) - ...
        ones(1,length(samplelist(2,(y:end))));
end

% Lets's check pour MiniBlock DIM triggers
countMB1 = 1;
countMB2 = 1;
countMB3 = 1;
countMB4 = 1;
countMB5 = 1;
for i = 1:(length(samplelist)-1)
    if samplelist(3,i) == 1;
        MiniBlock.PrePar{1,countMB1} = [sample(samplelist(2,i):(samplelist(2,i+1)-1)) ...
            (valuetrig(samplelist(2,i):(samplelist(2,i+1)-1))') ...
            [sample(samplelist(2,i):(samplelist(2,i+1)-1)) - ...
            [sample((samplelist(2,i)+1):(samplelist(2,i+1)-1));0]]*(-1)];
        countMB1 = countMB1 + 1;
        j = 0;
        while (j < length(MiniBlock.PrePar{1,countMB1-1}))
            j = j + 1;
            if MiniBlock.PrePar{1,countMB1-1}(j,2) == 0
                MiniBlock.PrePar{1,countMB1-1}(j,:) = [];
            end
        end
        j = 0;
        while (j < length(MiniBlock.PrePar{1,countMB1-1}))
            j = j + 1;
            if (MiniBlock.PrePar{1,countMB1-1}(j,3) <= 5) && (MiniBlock.PrePar{1,countMB1-1}(j,3) >0)
                MiniBlock.PrePar{1,countMB1-1}(j,:) = [];
            end
        end
    elseif samplelist(3,i) == 2;
        MiniBlock.PasPar{1,countMB2} = [sample(samplelist(2,i):(samplelist(2,i+1)-1)) ...
            (valuetrig(samplelist(2,i):(samplelist(2,i+1)-1))') ...
            [sample(samplelist(2,i):(samplelist(2,i+1)-1)) - ...
            [sample((samplelist(2,i)+1):(samplelist(2,i+1)-1));0]]*(-1)];
        countMB2 = countMB2 + 1;
        j = 0;
        while (j < length(MiniBlock.PasPar{1,countMB2-1}))
            j = j + 1;
            if MiniBlock.PasPar{1,countMB2-1}(j,2) == 0
                MiniBlock.PasPar{1,countMB2-1}(j,:) = [];
            end
        end
        j = 0;
        while (j < length(MiniBlock.PasPar{1,countMB2-1}))
            j = j + 1;
            if (MiniBlock.PasPar{1,countMB2-1}(j,3) > 0) && (MiniBlock.PasPar{1,countMB2-1}(j,3) <= 5)
                MiniBlock.PasPar{1,countMB2-1}(j,:) = [];
            end
        end
    elseif samplelist(3,i) == 3;
        MiniBlock.FutPar{1,countMB3} = [sample(samplelist(2,i):(samplelist(2,i+1)-1)) ...
            (valuetrig(samplelist(2,i):(samplelist(2,i+1)-1))') ...
            [sample(samplelist(2,i):(samplelist(2,i+1)-1)) - ...
            [sample((samplelist(2,i)+1):(samplelist(2,i+1)-1));0]]*(-1)];
        countMB3 = countMB3 + 1;
        j = 0;
        while (j < length(MiniBlock.FutPar{1,countMB3-1}))
            j = j + 1;
            if MiniBlock.FutPar{1,countMB3-1}(j,2) == 0
                MiniBlock.FutPar{1,countMB3-1}(j,:) = [];
            end
        end
        j = 0;
        while (j < length(MiniBlock.FutPar{1,countMB3-1}))
            j = j + 1;
            if (MiniBlock.FutPar{1,countMB3-1}(j,3) > 0) && (MiniBlock.FutPar{1,countMB3-1}(j,3) <= 5)
                MiniBlock.FutPar{1,countMB3-1}(j,:) = [];
            end
        end
    elseif samplelist(3,i) == 4;
        MiniBlock.PreW{1,countMB4}   = [sample(samplelist(2,i):(samplelist(2,i+1)-1)) ...
            (valuetrig(samplelist(2,i):(samplelist(2,i+1)-1))') ...
            [sample(samplelist(2,i):(samplelist(2,i+1)-1)) - ...
            [sample((samplelist(2,i)+1):(samplelist(2,i+1)-1));0]]*(-1)];
        countMB4 = countMB4 + 1;
        j = 0;
        while (j < length(MiniBlock.PreW{1,countMB4-1}))
            j = j + 1;
            if MiniBlock.PreW{1,countMB4-1}(j,2) == 0
                MiniBlock.PreW{1,countMB4-1}(j,:) = [];
            end
        end
        j = 0;
        while (j < length(MiniBlock.PreW{1,countMB4-1}))
            j = j + 1;
            if (MiniBlock.PreW{1,countMB4-1}(j,3) > 0) && (MiniBlock.PreW{1,countMB4-1}(j,3) <= 5)
                MiniBlock.PreW{1,countMB4-1}(j,:) = [];
            end
        end
    elseif samplelist(3,i) == 5;
        MiniBlock.PreE{1,countMB5}   = [sample(samplelist(2,i):(samplelist(2,i+1)-1)) ...
            (valuetrig(samplelist(2,i):(samplelist(2,i+1)-1))') ...
            [sample(samplelist(2,i):(samplelist(2,i+1)-1)) - ...
            [sample((samplelist(2,i)+1):(samplelist(2,i+1)-1));0]]*(-1)];
        countMB5 = countMB5 + 1;
        j = 0;
        while (j < length(MiniBlock.PreE{1,countMB5-1}))
            j = j + 1;
            if MiniBlock.PreE{1,countMB5-1}(j,2) == 0
                MiniBlock.PreE{1,countMB5-1}(j,:) = [];
            end
        end
        j = 0;
        while (j < length(MiniBlock.PreE{1,countMB5-1}))
            j = j + 1;
            if (MiniBlock.PreE{1,countMB5-1}(j,3) > 0) && (MiniBlock.PreE{1,countMB5-1}(j,3) <= 5)
                MiniBlock.PreE{1,countMB5-1}(j,:) = [];
            end
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% ONLY FOR PILOT SUBJECT (WITH SOME ERRONEOUS TRIGGERS %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isempty(strfind(cfg.dataset(17:24),'sd130343')) == 0 || ...
        isempty(strfind(cfg.dataset(17:24),'cb130477'))
    
    % recode erroneous triggers
    for i = 1:length(MiniBlock.PasPar)
        for j = 3:length(MiniBlock.PasPar{1,i})
            if MiniBlock.PasPar{1,i}(j,2) == 22 && MiniBlock.PasPar{1,i}(j-2,2) == 8
                MiniBlock.PasPar{1,i}(j,2) = 20;
            end
        end
    end
    
    for i = 1:length(MiniBlock.PreE)
        for j = 3:length(MiniBlock.PreE{1,i})
            if MiniBlock.PreE{1,i}(j,2) == 32
                MiniBlock.PreE{1,i}(j,2) = 33;
            elseif MiniBlock.PreE{1,i}(j,2) == 33
                MiniBlock.PreE{1,i}(j,2) = 32;
            end
        end
    end
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% NEW TRIGGER CODE SYSTEM %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% debriefing information
FOLDER_DEBRIEF = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/megdebrief_18subj';
filesdebrief = get_filenames(FOLDER_DEBRIEF,cfg.dataset(45:52));
if isempty(filesdebrief) == 0
    [datatextT,datanumberT] = xlsread([FOLDER_DEBRIEF '/' filesdebrief{1}]);
    [datatextS,datanumberS] = xlsread([FOLDER_DEBRIEF '/' filesdebrief{2}]);
else
    datatextT= nan(6,6);
    datatextS = nan(6*6);
end
 
DATES = datatextT;
LONGS = datatextS;

%% PrePar
EvTimeL    = [];     EvTimeR = [];     EvSpaceL     =[];     EvSpaceR = [];
if isempty(strfind(cfg.dataset,'GD')) == 0
    EvTimeL     = [37:39 43:45 49:51 55:57 61:63 67:69];
    EvTimeR     = [40:42 46:48 52:54 58:60 64:66 70:72];
    EvSpaceL    = [37:54];
    EvSpaceR   = [55:72];
elseif isempty(strfind(cfg.dataset,'DG')) == 0
    EvTimeR    = [37:39 43:45 49:51 55:57 61:63 67:69];
    EvTimeL     = [40:42 46:48 52:54 58:60 64:66 70:72];
    EvSpaceR    = [37:54];
    EvSpaceL     = [55:72];
else
    error('Jesus was a coconut!')
end

for i = 1:length(MiniBlock.PrePar)
    MiniBlock.PrePar{1,i} = mtt_recodetrig(MiniBlock.PrePar{1,i},EvTimeL,EvTimeR,EvSpaceL,EvSpaceR,...
        DATES,LONGS);
end

%% PasPar
EvTimeL    = [];     EvTimeR = [];     EvSpaceL     =[];     EvSpaceR = [];
if isempty(strfind(cfg.dataset,'GD')) == 0
    EvTimeL     = [37:38 43:44 49:50 55:56 61:62 67:68];
    EvTimeR    = [39:40 45:46 51:52 57:58 63:64 69:70];
    EvSpaceL   = [37:40 43:46 49:52];
    EvSpaceR   = [55:58 61:64 67:70];
elseif isempty(strfind(cfg.dataset,'DG')) == 0
    EvTimeR    = [37:38 43:44 49:50 55:56 61:62 67:68];
    EvTimeL     = [39:40 45:46 51:52 57:58 63:64 69:70];
    EvSpaceR   = [37:40 43:46 49:52];
    EvSpaceL    = [55:58 61:64 67:70];
else
    error('Jesus was a coconut!')
end

for i = 1:length(MiniBlock.PasPar)
    MiniBlock.PasPar{1,i} = mtt_recodetrig(MiniBlock.PasPar{1,i},EvTimeL,EvTimeR,EvSpaceL,EvSpaceR,...
        DATES,LONGS);
end

%% FutPar
EvTimeL    = [];     EvTimeR = [];     EvSpaceL     =[];     EvSpaceR = [];
if isempty(strfind(cfg.dataset,'GD')) == 0
    EvTimeL      = [39:40 45:46 51:52 57:58 63:64 69:70];
    EvTimeR    = [41:42 47:48 53:54 59:60 65:66 71:72];
    EvSpaceL    = [39:42 45:48 51:54];
    EvSpaceR   = [57:60 63:66 69:72];
elseif isempty(strfind(cfg.dataset,'DG')) == 0
    EvTimeR    = [39:40 45:46 51:52 57:58 63:64 69:70];
    EvTimeL      = [41:42 47:48 53:54 59:60 65:66 71:72];
    EvSpaceR   = [39:42 45:48 51:54];
    EvSpaceL     = [57:60 63:66 69:72];
else
    error('Jesus was a coconut!')
end

for i = 1:length(MiniBlock.FutPar)
    MiniBlock.FutPar{1,i} = mtt_recodetrig(MiniBlock.FutPar{1,i},EvTimeL,EvTimeR,EvSpaceL,EvSpaceR,...
        DATES,LONGS);
end

%% PreW
EvTimeL    = [];     EvTimeR = [];     EvSpaceL     =[];     EvSpaceR = [];
if isempty(strfind(cfg.dataset,'GD')) == 0
    EvTimeL      = [37:39 43:45 49:51 55:57];
    EvTimeR    = [40:42 46:48 52:54 58:60];
    EvSpaceL     = [37:48];
    EvSpaceR   = [49:60];
elseif isempty(strfind(cfg.dataset,'DG')) == 0
    EvTimeR    = [37:39 43:45 49:51 55:57];
    EvTimeL      = [40:42 46:48 52:54 58:60];
    EvSpaceR   = [37:48];
    EvSpaceL     = [49:60];
else
    error('Jesus was a coconut!')
end

for i = 1:length(MiniBlock.PreW)
    MiniBlock.PreW{1,i} = mtt_recodetrig(MiniBlock.PreW{1,i},EvTimeL,EvTimeR,EvSpaceL,EvSpaceR,...
        DATES,LONGS);
end

%% PreE
EvTimeL    = [];     EvTimeR = [];     EvSpaceL     =[];     EvSpaceR = [];
if isempty(strfind(cfg.dataset,'GD')) == 0
    EvTimeL      = [49:51 55:57 61:63 67:69];
    EvTimeR    = [52:54 58:60 64:66 70:72];
    EvSpaceL     = [49:60];
    EvSpaceR   = [61:72];
elseif isempty(strfind(cfg.dataset,'DG')) == 0
    EvTimeR    = [49:51 55:57 61:63 67:69];
    EvTimeL      = [52:54 58:60 64:66 70:72];
    EvSpaceR   = [49:60];
    EvSpaceL     = [61:72];
else
    error('Jesus was a coconut!')
end

for i = 1:length(MiniBlock.PreE)
    MiniBlock.PreE{1,i} = mtt_recodetrig(MiniBlock.PreE{1,i},EvTimeL,EvTimeR,EvSpaceL,EvSpaceR,...
        DATES,LONGS);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% reassemble value and sample vector
valuetrigcorr = [];
samplecorr  = [];
recodetrig    = [];
recodedates = [];
recodelongs = [];
for i = 1:length(MiniBlock.PrePar)
    valuetrigcorr = [valuetrigcorr; MiniBlock.PrePar{1,i}(:,2)];
    recodetrig    = [recodetrig; MiniBlock.PrePar{1,i}(:,4)];
    recodedates    = [recodedates; MiniBlock.PrePar{1,i}(:,5)];
    recodelongs    = [recodelongs; MiniBlock.PrePar{1,i}(:,6)];
    samplecorr = [samplecorr; MiniBlock.PrePar{1,i}(:,1)];
end
for i = 1:length(MiniBlock.PasPar)
    valuetrigcorr = [valuetrigcorr; MiniBlock.PasPar{1,i}(:,2)];
    recodetrig    = [recodetrig; MiniBlock.PasPar{1,i}(:,4)];
    recodedates    = [recodedates; MiniBlock.PasPar{1,i}(:,5)];
    recodelongs    = [recodelongs; MiniBlock.PasPar{1,i}(:,6)];
    samplecorr = [samplecorr; MiniBlock.PasPar{1,i}(:,1)];
end
for i = 1:length(MiniBlock.FutPar)
    valuetrigcorr = [valuetrigcorr; MiniBlock.FutPar{1,i}(:,2)];
    recodetrig    = [recodetrig; MiniBlock.FutPar{1,i}(:,4)];
    recodedates    = [recodedates; MiniBlock.FutPar{1,i}(:,5)];
    recodelongs    = [recodelongs; MiniBlock.FutPar{1,i}(:,6)];
    samplecorr = [samplecorr; MiniBlock.FutPar{1,i}(:,1)];
end
for i = 1:length(MiniBlock.PreW)
    valuetrigcorr = [valuetrigcorr; MiniBlock.PreW{1,i}(:,2)];
    recodetrig    = [recodetrig; MiniBlock.PreW{1,i}(:,4)];
    recodedates    = [recodedates; MiniBlock.PreW{1,i}(:,5)];
    recodelongs    = [recodelongs; MiniBlock.PreW{1,i}(:,6)];
    samplecorr = [samplecorr; MiniBlock.PreW{1,i}(:,1)];
end
for i = 1:length(MiniBlock.PreE)
    valuetrigcorr = [valuetrigcorr; MiniBlock.PreE{1,i}(:,2)];
    recodetrig    = [recodetrig; MiniBlock.PreE{1,i}(:,4)];
    recodedates    = [recodedates; MiniBlock.PreE{1,i}(:,5)];
    recodelongs    = [recodelongs; MiniBlock.PreE{1,i}(:,6)];
    samplecorr = [samplecorr; MiniBlock.PreE{1,i}(:,1)];
end

%% If the file stop too early
[xlim,ylim] = find(samplecorr >= (hdr.nSamples - max(cfg.trialdef.poststim)*hdr.Fs + min(cfg.photodelay)));

if isempty(xlim) == 0
    samplecorr(xlim) = [];
    valuetrigcorr(xlim) = [];
    recodetrig(xlim) = [];
    recodedates(xlim) = [];
    recodelongs(xlim) = [];
end

%% epoch according to all triggers
triggerlist1 = [6:2:15]; % dist/event original triggers

trl = [];
x = [];y = [];
for t = 1: length(triggerlist1)
    [x{t},y{t}]   = find(valuetrigcorr == triggerlist1(t));
    for t2 = 1:length(recodetrig)
        if isempty(intersect(samplecorr(t2),samplecorr(x{t}))) == 0
            
            trltmp = [];
            count= 1;
            if (samplecorr(t2) - cfg.trialdef.prestim(t)*hdr.Fs + cfg.photodelay(t)*hdr.Fs) >= 0
                trltmp(count,1) = samplecorr(t2) - cfg.trialdef.prestim(t)*hdr.Fs ;
                trltmp(count,2) = samplecorr(t2) + cfg.trialdef.poststim(t)*hdr.Fs ;
                trltmp(count,4) = recodetrig(t2);
                trltmp(count,5) = recodedates(t2);
                trltmp(count,6) = recodelongs(t2);
                trltmp(count,3) = 0;
                trltmp(count,7) = valuetrigcorr(t2);
                count = count+1;
            else
            end
        
        trl = [trl ;trltmp];
        
        end
    end
end



