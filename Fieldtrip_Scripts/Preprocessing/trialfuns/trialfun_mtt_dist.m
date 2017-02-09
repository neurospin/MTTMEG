function [trl] = trialfun_mtt_cue_time_v2(cfg)

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

% recode PrePar

for i = 1:length(MiniBlock.PrePar)
    for j = 1:length(MiniBlock.PrePar{1,i}(:,:))
        MiniBlock.PrePar{1,i}(1:j,4) = 0;
    end
end

if isempty(strfind(cfg.dataset,'GD')) == 0
    EvcodeTimeLeft      = [37:39 43:45 49:51 55:57 61:63 67:69];
    EvcodeTimeRight    = [40:42 46:48 52:54 58:60 64:66 70:72];
    EvcodeSpaceLeft     = [37:54];
    EvcodeSpaceRight   = [55:72];
elseif isempty(strfind(cfg.dataset,'DG')) == 0
    EvcodeTimeRight    = [37:39 43:45 49:51 55:57 61:63 67:69];
    EvcodeTimeLeft      = [40:42 46:48 52:54 58:60 64:66 70:72];
    EvcodeSpaceRight   = [37:54];
    EvcodeSpaceLeft     = [55:72];
else
    error('Jesus was a coconut!')
end

respcode = [1024 32768];

for k = [1:5 6:15 37:72 1024 32768]
    if isempty(intersect(k,1:5)) == 0
        for i = 1:length(MiniBlock.PrePar)
            [x,y] = find(MiniBlock.PrePar{1,i}(:,2) == k);
            MiniBlock.PrePar{1,i}(x,4) = k;
        end
    elseif  isempty(intersect(k,6:15)) == 0
        for i = 1:length(MiniBlock.PrePar)
            [x,y] = find(MiniBlock.PrePar{1,i}(:,2) == k);
            for xi = 1:length(x)
                MiniBlock.PrePar{1,i}(x(xi),4) = MiniBlock.PrePar{1,i}(x(xi),4) +  k*10;
                if (x(xi)+1) <= length(MiniBlock.PrePar{1,i}) && isempty(intersect(MiniBlock.PrePar{1,i}(x(xi)+1,2),37:72)) == 0;
                    MiniBlock.PrePar{1,i}(x(xi)+1,4) = MiniBlock.PrePar{1,i}(x(xi)+1,4) +  k*10;
                end
                if (x(xi)+2) <= length(MiniBlock.PrePar{1,i}) && isempty(intersect(MiniBlock.PrePar{1,i}(x(xi)+2,2),16:35)) == 0;
                    MiniBlock.PrePar{1,i}(x(xi)+2,4) = MiniBlock.PrePar{1,i}(x(xi)+2,4) +  k*10;
                end
                if (x(xi)+3) <= length(MiniBlock.PrePar{1,i}) && isempty(intersect(MiniBlock.PrePar{1,i}(x(xi)+3,2),respcode)) == 0;
                    MiniBlock.PrePar{1,i}(x(xi)+3,4) = MiniBlock.PrePar{1,i}(x(xi)+3,4) +  k*10;
                end
            end
        end
    elseif  isempty(intersect(k,37:72)) == 0
        for i = 1:length(MiniBlock.PrePar)
            [x,y] = find(MiniBlock.PrePar{1,i}(:,2) == k);
            for xi = 1:length(x)
                MiniBlock.PrePar{1,i}(x(xi),4) = MiniBlock.PrePar{1,i}(x(xi),4) +  k*1000;
                if (x(xi)-1) >0 && isempty(intersect(MiniBlock.PrePar{1,i}(x(xi)-1,2),6:15)) == 0;
                    MiniBlock.PrePar{1,i}(x(xi)-1,4) = MiniBlock.PrePar{1,i}(x(xi)-1,4) +  k*1000;
                end
                if (x(xi)+1) <= length(MiniBlock.PrePar{1,i}) && isempty(intersect(MiniBlock.PrePar{1,i}(x(xi)+1,2),16:35)) == 0;
                    MiniBlock.PrePar{1,i}(x(xi)+1,4) = MiniBlock.PrePar{1,i}(x(xi)+1,4) +  k*1000;
                end
                if (x(xi)+2) <= length(MiniBlock.PrePar{1,i}) && isempty(intersect(MiniBlock.PrePar{1,i}(x(xi)+2,2),respcode)) == 0;
                    MiniBlock.PrePar{1,i}(x(xi)+2,4) = MiniBlock.PrePar{1,i}(x(xi)+2,4) +  k*1000;
                end
            end
        end
    elseif  isempty(intersect(k,[1024 32768])) == 0
        for i = 1:length(MiniBlock.PrePar)
            [x,y] = find(MiniBlock.PrePar{1,i}(:,2) == k);
            for xi = 1:length(x)
                if (x(xi)-3) > 0 && isempty(intersect(MiniBlock.PrePar{1,i}(x(xi)-3,2),6)) == 0; % timequestion
                    if isempty(intersect(MiniBlock.PrePar{1,i}(x(xi),2),1024)) == 0; % leftbutton
                        if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PrePar{1,i}(x(xi)-2,2),EvcodeTimeLeft )) == 0;
                            MiniBlock.PrePar{1,i}(x(xi),4) = MiniBlock.PrePar{1,i}(x(xi),4) +  1; % TimeLeftTrue
                            if (x(xi)-1) > 0 && isempty(intersect(MiniBlock.PrePar{1,i}(x(xi)-1,2),16:35)) == 0;
                                MiniBlock.PrePar{1,i}(x(xi)-1,4) = MiniBlock.PrePar{1,i}(x(xi)-1,4) +  1;
                            end
                            if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PrePar{1,i}(x(xi)-2,2),37:72)) == 0;
                                MiniBlock.PrePar{1,i}(x(xi)-2,4) = MiniBlock.PrePar{1,i}(x(xi)-2,4) +  1;
                            end
                            if (x(xi)-3) > 0 && isempty(intersect(MiniBlock.PrePar{1,i}(x(xi)-3,2),6)) == 0;
                                MiniBlock.PrePar{1,i}(x(xi)-3,4) = MiniBlock.PrePar{1,i}(x(xi)-3,4) +  1;
                            end
                        elseif (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PrePar{1,i}(x(xi)-2,2),EvcodeTimeRight )) == 0;
                            MiniBlock.PrePar{1,i}(x(xi),4) = MiniBlock.PrePar{1,i}(x(xi),4) +  2; % TimeLeftFalse
                            if (x(xi)-1) > 0 && isempty(intersect(MiniBlock.PrePar{1,i}(x(xi)-1,2),16:35)) == 0;
                                MiniBlock.PrePar{1,i}(x(xi)-1,4) = MiniBlock.PrePar{1,i}(x(xi)-1,4) +  2;
                            end
                            if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PrePar{1,i}(x(xi)-2,2),37:72)) == 0;
                                MiniBlock.PrePar{1,i}(x(xi)-2,4) = MiniBlock.PrePar{1,i}(x(xi)-2,4) + 2;
                            end
                            if (x(xi)-3) > 0 && isempty(intersect(MiniBlock.PrePar{1,i}(x(xi)-3,2),6)) == 0;
                                MiniBlock.PrePar{1,i}(x(xi)-3,4) = MiniBlock.PrePar{1,i}(x(xi)-3,4) + 2;
                            end
                        end
                    elseif isempty(intersect(MiniBlock.PrePar{1,i}(x(xi),2),32768)) == 0; % rightbutton
                        if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PrePar{1,i}(x(xi)-2,2),EvcodeTimeRight )) == 0;
                            MiniBlock.PrePar{1,i}(x(xi),4) = MiniBlock.PrePar{1,i}(x(xi),4) +  3; % TimeRightTrue
                            if (x(xi)-1) > 0 && isempty(intersect(MiniBlock.PrePar{1,i}(x(xi)-1,2),16:35)) == 0;
                                MiniBlock.PrePar{1,i}(x(xi)-1,4) = MiniBlock.PrePar{1,i}(x(xi)-1,4) +  3;
                            end
                            if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PrePar{1,i}(x(xi)-2,2),37:72)) == 0;
                                MiniBlock.PrePar{1,i}(x(xi)-2,4) = MiniBlock.PrePar{1,i}(x(xi)-2,4) +  3;
                            end
                            if (x(xi)-3) > 0 && isempty(intersect(MiniBlock.PrePar{1,i}(x(xi)-3,2),6)) == 0;
                                MiniBlock.PrePar{1,i}(x(xi)-3,4) = MiniBlock.PrePar{1,i}(x(xi)-3,4) +  3;
                            end
                        elseif (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PrePar{1,i}(x(xi)-2,2),EvcodeTimeLeft )) == 0;
                            MiniBlock.PrePar{1,i}(x(xi),4) = MiniBlock.PrePar{1,i}(x(xi),4) +  4; % TimeRightFalse
                            if (x(xi)-1) > 0 && isempty(intersect(MiniBlock.PrePar{1,i}(x(xi)-1,2),16:35)) == 0;
                                MiniBlock.PrePar{1,i}(x(xi)-1,4) = MiniBlock.PrePar{1,i}(x(xi)-1,4) +  4;
                            end
                            if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PrePar{1,i}(x(xi)-2,2),37:72)) == 0;
                                MiniBlock.PrePar{1,i}(x(xi)-2,4) = MiniBlock.PrePar{1,i}(x(xi)-2,4) +  4;
                            end
                            if (x(xi)-3) > 0 && isempty(intersect(MiniBlock.PrePar{1,i}(x(xi)-3,2),6)) == 0;
                                MiniBlock.PrePar{1,i}(x(xi)-3,4) = MiniBlock.PrePar{1,i}(x(xi)-3,4) + 4;
                            end
                        end
                    end
                elseif (x(xi)-3) > 0 && isempty(intersect(MiniBlock.PrePar{1,i}(x(xi)-3,2),7)) == 0; % spacequestion
                    if isempty(intersect(MiniBlock.PrePar{1,i}(x(xi),2),1024)) == 0; % leftbutton
                        if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PrePar{1,i}(x(xi)-2,2),EvcodeTimeLeft )) == 0;
                            MiniBlock.PrePar{1,i}(x(xi),4) = MiniBlock.PrePar{1,i}(x(xi),4) +  1; % SpaceLeftTrue
                            if (x(xi)-1) > 0 && isempty(intersect(MiniBlock.PrePar{1,i}(x(xi)-1,2),16:35)) == 0;
                                MiniBlock.PrePar{1,i}(x(xi)-1,4) = MiniBlock.PrePar{1,i}(x(xi)-1,4) +  1;
                            end
                            if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PrePar{1,i}(x(xi)-2,2),37:72)) == 0;
                                MiniBlock.PrePar{1,i}(x(xi)-2,4) = MiniBlock.PrePar{1,i}(x(xi)-2,4) +  1;
                            end
                            if (x(xi)-3) > 0 && isempty(intersect(MiniBlock.PrePar{1,i}(x(xi)-3,2),6)) == 0;
                                MiniBlock.PrePar{1,i}(x(xi)-3,4) = MiniBlock.PrePar{1,i}(x(xi)-3,4) +  1;
                            end
                        elseif (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PrePar{1,i}(x(xi)-2,2),EvcodeTimeRight )) == 0;
                            MiniBlock.PrePar{1,i}(x(xi),4) = MiniBlock.PrePar{1,i}(x(xi),4) +  2; % SpaceLeftFalse
                            if (x(xi)-1) > 0 && isempty(intersect(MiniBlock.PrePar{1,i}(x(xi)-1,2),16:35)) == 0;
                                MiniBlock.PrePar{1,i}(x(xi)-1,4) = MiniBlock.PrePar{1,i}(x(xi)-1,4) +  2;
                            end
                            if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PrePar{1,i}(x(xi)-2,2),37:72)) == 0;
                                MiniBlock.PrePar{1,i}(x(xi)-2,4) = MiniBlock.PrePar{1,i}(x(xi)-2,4) + 2;
                            end
                            if (x(xi)-3) > 0 && isempty(intersect(MiniBlock.PrePar{1,i}(x(xi)-3,2),7)) == 0;
                                MiniBlock.PrePar{1,i}(x(xi)-3,4) = MiniBlock.PrePar{1,i}(x(xi)-3,4) + 2;
                            end
                        end
                    elseif isempty(intersect(MiniBlock.PrePar{1,i}(x(xi),2),32768)) == 0; % rightbutton
                        if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PrePar{1,i}(x(xi)-2,2),EvcodeTimeRight )) == 0;
                            MiniBlock.PrePar{1,i}(x(xi),4) = MiniBlock.PrePar{1,i}(x(xi),4) +  3; % SpaceRightTrue
                            if (x(xi)-1) > 0 &&  isempty(intersect(MiniBlock.PrePar{1,i}(x(xi)-1,2),16:35)) == 0;
                                MiniBlock.PrePar{1,i}(x(xi)-1,4) = MiniBlock.PrePar{1,i}(x(xi)-1,4) +  3;
                            end
                            if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PrePar{1,i}(x(xi)-2,2),37:72)) == 0;
                                MiniBlock.PrePar{1,i}(x(xi)-2,4) = MiniBlock.PrePar{1,i}(x(xi)-2,4) +  3;
                            end
                            if (x(xi)-3) > 0 && isempty(intersect(MiniBlock.PrePar{1,i}(x(xi)-3,2),7)) == 0;
                                MiniBlock.PrePar{1,i}(x(xi)-3,4) = MiniBlock.PrePar{1,i}(x(xi)-3,4) +  3;
                            end
                        elseif (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PrePar{1,i}(x(xi)-2,2),EvcodeTimeLeft )) == 0;
                            MiniBlock.PrePar{1,i}(x(xi),4) = MiniBlock.PrePar{1,i}(x(xi),4) +  4; % SpaceRightFalse
                            if (x(xi)-1) > 0 && isempty(intersect(MiniBlock.PrePar{1,i}(x(xi)-1,2),16:35)) == 0;
                                MiniBlock.PrePar{1,i}(x(xi)-1,4) = MiniBlock.PrePar{1,i}(x(xi)-1,4) +  4;
                            end
                            if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PrePar{1,i}(x(xi)-2,2),37:72)) == 0;
                                MiniBlock.PrePar{1,i}(x(xi)-2,4) = MiniBlock.PrePar{1,i}(x(xi)-2,4) +  4;
                            end
                            if (x(xi)-3) > 0 && isempty(intersect(MiniBlock.PrePar{1,i}(x(xi)-3,2),7)) == 0;
                                MiniBlock.PrePar{1,i}(x(xi)-3,4) = MiniBlock.PrePar{1,i}(x(xi)-3,4) +  4;
                            end
                        end
                    end
                end
            end
        end
    end
end


% recode PasPar

for i = 1:length(MiniBlock.PasPar)
    for j = 1:length(MiniBlock.PasPar{1,i}(:,:))
        MiniBlock.PasPar{1,i}(1:j,4) = 0;
    end
end

if isempty(strfind(cfg.dataset,'GD')) == 0
    EvcodeTimeLeft      = [37:38 43:44 49:50 55:56 61:62 67:68];
    EvcodeTimeRight    = [39:40 45:46 51:52 57:58 63:64 69:70];
    EvcodeSpaceLeft     = [37:40 43:46 49:52];
    EvcodeSpaceRight   = [55:58 61:64 67:70];
elseif isempty(strfind(cfg.dataset,'DG')) == 0
    EvcodeTimeRight    = [37:38 43:44 49:50 55:56 61:62 67:68];
    EvcodeTimeLeft      = [39:40 45:46 51:52 57:58 63:64 69:70];
    EvcodeSpaceRight   = [37:40 43:46 49:52];
    EvcodeSpaceLeft     = [55:58 61:64 67:70];
else
    error('Jesus was a coconut!')
end

respcode = [1024 32768];

for k = [1:5 6:15 37:72 1024 32768]
    if isempty(intersect(k,1:5)) == 0
        for i = 1:length(MiniBlock.PasPar)
            [x,y] = find(MiniBlock.PasPar{1,i}(:,2) == k);
            MiniBlock.PasPar{1,i}(x,4) = k;
        end
    elseif  isempty(intersect(k,6:15)) == 0
        for i = 1:length(MiniBlock.PasPar)
            [x,y] = find(MiniBlock.PasPar{1,i}(:,2) == k);
            for xi = 1:length(x)
                MiniBlock.PasPar{1,i}(x(xi),4) = MiniBlock.PasPar{1,i}(x(xi),4) +  k*10;
                if (x(xi)+1) <= length(MiniBlock.PasPar{1,i}) && isempty(intersect(MiniBlock.PasPar{1,i}(x(xi)+1,2),37:72)) == 0;
                    MiniBlock.PasPar{1,i}(x(xi)+1,4) = MiniBlock.PasPar{1,i}(x(xi)+1,4) +  k*10;
                end
                if (x(xi)+2) <= length(MiniBlock.PasPar{1,i}) && isempty(intersect(MiniBlock.PasPar{1,i}(x(xi)+2,2),16:35)) == 0;
                    MiniBlock.PasPar{1,i}(x(xi)+2,4) = MiniBlock.PasPar{1,i}(x(xi)+2,4) +  k*10;
                end
                if (x(xi)+3) <= length(MiniBlock.PasPar{1,i}) && isempty(intersect(MiniBlock.PasPar{1,i}(x(xi)+3,2),respcode)) == 0;
                    MiniBlock.PasPar{1,i}(x(xi)+3,4) = MiniBlock.PasPar{1,i}(x(xi)+3,4) +  k*10;
                end
            end
        end
    elseif  isempty(intersect(k,37:72)) == 0
        for i = 1:length(MiniBlock.PasPar)
            [x,y] = find(MiniBlock.PasPar{1,i}(:,2) == k);
            for xi = 1:length(x)
                MiniBlock.PasPar{1,i}(x(xi),4) = MiniBlock.PasPar{1,i}(x(xi),4) +  k*1000;
                if (x(xi)-1) >0 && isempty(intersect(MiniBlock.PasPar{1,i}(x(xi)-1,2),6:15)) == 0;
                    MiniBlock.PasPar{1,i}(x(xi)-1,4) = MiniBlock.PasPar{1,i}(x(xi)-1,4) +  k*1000;
                end
                if (x(xi)+1) <= length(MiniBlock.PasPar{1,i}) && isempty(intersect(MiniBlock.PasPar{1,i}(x(xi)+1,2),16:35)) == 0;
                    MiniBlock.PasPar{1,i}(x(xi)+1,4) = MiniBlock.PasPar{1,i}(x(xi)+1,4) +  k*1000;
                end
                if (x(xi)+2) <= length(MiniBlock.PasPar{1,i}) && isempty(intersect(MiniBlock.PasPar{1,i}(x(xi)+2,2),respcode)) == 0;
                    MiniBlock.PasPar{1,i}(x(xi)+2,4) = MiniBlock.PasPar{1,i}(x(xi)+2,4) +  k*1000;
                end
            end
        end
    elseif  isempty(intersect(k,[1024 32768])) == 0
        for i = 1:length(MiniBlock.PasPar)
            [x,y] = find(MiniBlock.PasPar{1,i}(:,2) == k);
            for xi = 1:length(x)
                if (x(xi)-3) > 0 && isempty(intersect(MiniBlock.PasPar{1,i}(x(xi)-3,2),8)) == 0; % timequestion
                    if isempty(intersect(MiniBlock.PasPar{1,i}(x(xi),2),1024)) == 0; % leftbutton
                        if isempty(intersect(MiniBlock.PasPar{1,i}(x(xi)-2,2),EvcodeTimeLeft )) == 0;
                            MiniBlock.PasPar{1,i}(x(xi),4) = MiniBlock.PasPar{1,i}(x(xi),4) +  1; % TimeLeftTrue
                            if (x(xi)-1) > 0 && isempty(intersect(MiniBlock.PasPar{1,i}(x(xi)-1,2),16:35)) == 0;
                                MiniBlock.PasPar{1,i}(x(xi)-1,4) = MiniBlock.PasPar{1,i}(x(xi)-1,4) +  1;
                            end
                            if(x(xi)-2) > 0 &&  isempty(intersect(MiniBlock.PasPar{1,i}(x(xi)-2,2),37:72)) == 0;
                                MiniBlock.PasPar{1,i}(x(xi)-2,4) = MiniBlock.PasPar{1,i}(x(xi)-2,4) +  1;
                            end
                            if (x(xi)-3) > 0 && isempty(intersect(MiniBlock.PasPar{1,i}(x(xi)-3,2),8)) == 0;
                                MiniBlock.PasPar{1,i}(x(xi)-3,4) = MiniBlock.PasPar{1,i}(x(xi)-3,4) +  1;
                            end
                        elseif (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PasPar{1,i}(x(xi)-2,2),EvcodeTimeRight )) == 0;
                            MiniBlock.PasPar{1,i}(x(xi),4) = MiniBlock.PasPar{1,i}(x(xi),4) +  2; % TimeLeftFalse
                            if (x(xi)-1) > 0 && isempty(intersect(MiniBlock.PasPar{1,i}(x(xi)-1,2),16:35)) == 0;
                                MiniBlock.PasPar{1,i}(x(xi)-1,4) = MiniBlock.PasPar{1,i}(x(xi)-1,4) +  2;
                            end
                            if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PasPar{1,i}(x(xi)-2,2),37:72)) == 0;
                                MiniBlock.PasPar{1,i}(x(xi)-2,4) = MiniBlock.PasPar{1,i}(x(xi)-2,4) + 2;
                            end
                            if (x(xi)-3) > 0 && isempty(intersect(MiniBlock.PasPar{1,i}(x(xi)-3,2),8)) == 0;
                                MiniBlock.PasPar{1,i}(x(xi)-3,4) = MiniBlock.PasPar{1,i}(x(xi)-3,4) + 2;
                            end
                        end
                    elseif isempty(intersect(MiniBlock.PasPar{1,i}(x(xi),2),32768)) == 0; % rightbutton
                        if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PasPar{1,i}(x(xi)-2,2),EvcodeTimeRight )) == 0;
                            MiniBlock.PasPar{1,i}(x(xi),4) = MiniBlock.PasPar{1,i}(x(xi),4) +  3; % TimeRightTrue
                            if (x(xi)-1) > 0 && isempty(intersect(MiniBlock.PasPar{1,i}(x(xi)-1,2),16:35)) == 0;
                                MiniBlock.PasPar{1,i}(x(xi)-1,4) = MiniBlock.PasPar{1,i}(x(xi)-1,4) +  3;
                            end
                            if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PasPar{1,i}(x(xi)-2,2),37:72)) == 0;
                                MiniBlock.PasPar{1,i}(x(xi)-2,4) = MiniBlock.PasPar{1,i}(x(xi)-2,4) +  3;
                            end
                            if (x(xi)-3) > 0 && isempty(intersect(MiniBlock.PasPar{1,i}(x(xi)-3,2),8)) == 0;
                                MiniBlock.PasPar{1,i}(x(xi)-3,4) = MiniBlock.PasPar{1,i}(x(xi)-3,4) +  3;
                            end
                        elseif (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PasPar{1,i}(x(xi)-2,2),EvcodeTimeLeft )) == 0;
                            MiniBlock.PasPar{1,i}(x(xi),4) = MiniBlock.PasPar{1,i}(x(xi),4) +  4; % TimeRightFalse
                            if (x(xi)-1) > 0 && isempty(intersect(MiniBlock.PasPar{1,i}(x(xi)-1,2),16:35)) == 0;
                                MiniBlock.PasPar{1,i}(x(xi)-1,4) = MiniBlock.PasPar{1,i}(x(xi)-1,4) +  4;
                            end
                            if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PasPar{1,i}(x(xi)-2,2),37:72)) == 0;
                                MiniBlock.PasPar{1,i}(x(xi)-2,4) = MiniBlock.PasPar{1,i}(x(xi)-2,4) +  4;
                            end
                            if (x(xi)-3) > 0 && isempty(intersect(MiniBlock.PasPar{1,i}(x(xi)-3,2),8)) == 0;
                                MiniBlock.PasPar{1,i}(x(xi)-3,4) = MiniBlock.PasPar{1,i}(x(xi)-3,4) + 4;
                            end
                        end
                    end
                elseif isempty(intersect(MiniBlock.PasPar{1,i}(x(xi)-3,2),9)) == 0; % spacequestion
                    if isempty(intersect(MiniBlock.PasPar{1,i}(x(xi),2),1024)) == 0; % leftbutton
                        if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PasPar{1,i}(x(xi)-2,2),EvcodeTimeLeft )) == 0;
                            MiniBlock.PasPar{1,i}(x(xi),4) = MiniBlock.PasPar{1,i}(x(xi),4) +  1; % SpaceLeftTrue
                            if (x(xi)-1) > 0 && isempty(intersect(MiniBlock.PasPar{1,i}(x(xi)-1,2),16:35)) == 0;
                                MiniBlock.PasPar{1,i}(x(xi)-1,4) = MiniBlock.PasPar{1,i}(x(xi)-1,4) +  1;
                            end
                            if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PasPar{1,i}(x(xi)-2,2),37:72)) == 0;
                                MiniBlock.PasPar{1,i}(x(xi)-2,4) = MiniBlock.PasPar{1,i}(x(xi)-2,4) +  1;
                            end
                            if (x(xi)-3) > 0 && isempty(intersect(MiniBlock.PasPar{1,i}(x(xi)-3,2),9)) == 0;
                                MiniBlock.PasPar{1,i}(x(xi)-3,4) = MiniBlock.PasPar{1,i}(x(xi)-3,4) +  1;
                            end
                        elseif (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PasPar{1,i}(x(xi)-2,2),EvcodeTimeRight )) == 0;
                            MiniBlock.PasPar{1,i}(x(xi),4) = MiniBlock.PasPar{1,i}(x(xi),4) +  2; % SpaceLeftFalse
                            if (x(xi)-1) > 0 && isempty(intersect(MiniBlock.PasPar{1,i}(x(xi)-1,2),16:35)) == 0;
                                MiniBlock.PasPar{1,i}(x(xi)-1,4) = MiniBlock.PasPar{1,i}(x(xi)-1,4) +  2;
                            end
                            if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PasPar{1,i}(x(xi)-2,2),37:72)) == 0;
                                MiniBlock.PasPar{1,i}(x(xi)-2,4) = MiniBlock.PasPar{1,i}(x(xi)-2,4) + 2;
                            end
                            if (x(xi)-3) > 0 && isempty(intersect(MiniBlock.PasPar{1,i}(x(xi)-3,2),9)) == 0;
                                MiniBlock.PasPar{1,i}(x(xi)-3,4) = MiniBlock.PasPar{1,i}(x(xi)-3,4) + 2;
                            end
                        end
                    elseif isempty(intersect(MiniBlock.PasPar{1,i}(x(xi),2),32768)) == 0; % rightbutton
                        if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PasPar{1,i}(x(xi)-2,2),EvcodeTimeRight )) == 0;
                            MiniBlock.PasPar{1,i}(x(xi),4) = MiniBlock.PasPar{1,i}(x(xi),4) +  3; % SpaceRightTrue
                            if (x(xi)-1) > 0 && isempty(intersect(MiniBlock.PasPar{1,i}(x(xi)-1,2),16:35)) == 0;
                                MiniBlock.PasPar{1,i}(x(xi)-1,4) = MiniBlock.PasPar{1,i}(x(xi)-1,4) +  3;
                            end
                            if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PasPar{1,i}(x(xi)-2,2),37:72)) == 0;
                                MiniBlock.PasPar{1,i}(x(xi)-2,4) = MiniBlock.PasPar{1,i}(x(xi)-2,4) +  3;
                            end
                            if (x(xi)-3) > 0 && isempty(intersect(MiniBlock.PasPar{1,i}(x(xi)-3,2),9)) == 0;
                                MiniBlock.PasPar{1,i}(x(xi)-3,4) = MiniBlock.PasPar{1,i}(x(xi)-3,4) +  3;
                            end
                        elseif (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PasPar{1,i}(x(xi)-2,2),EvcodeTimeLeft )) == 0;
                            MiniBlock.PasPar{1,i}(x(xi),4) = MiniBlock.PasPar{1,i}(x(xi),4) +  4; % SpaceRightFalse
                            if (x(xi)-1) > 0 && isempty(intersect(MiniBlock.PasPar{1,i}(x(xi)-1,2),16:35)) == 0;
                                MiniBlock.PasPar{1,i}(x(xi)-1,4) = MiniBlock.PasPar{1,i}(x(xi)-1,4) +  4;
                            end
                            if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PasPar{1,i}(x(xi)-2,2),37:72)) == 0;
                                MiniBlock.PasPar{1,i}(x(xi)-2,4) = MiniBlock.PasPar{1,i}(x(xi)-2,4) +  4;
                            end
                            if (x(xi)-3) > 0 && isempty(intersect(MiniBlock.PasPar{1,i}(x(xi)-3,2),9)) == 0;
                                MiniBlock.PasPar{1,i}(x(xi)-3,4) = MiniBlock.PasPar{1,i}(x(xi)-3,4) +  4;
                            end
                        end
                    end
                end
            end
        end
    end
end

% recode FutPar

for i = 1:length(MiniBlock.FutPar)
    for j = 1:length(MiniBlock.FutPar{1,i}(:,:))
        MiniBlock.FutPar{1,i}(1:j,4) = 0;
    end
end

if isempty(strfind(cfg.dataset,'GD')) == 0
    EvcodeTimeLeft      = [39:40 45:46 51:52 57:58 63:64 69:70];
    EvcodeTimeRight    = [41:42 47:48 53:54 59:60 65:66 71:72];
    EvcodeSpaceLeft     = [39:42 45:48 51:54];
    EvcodeSpaceRight   = [57:60 63:66 69:72];
elseif isempty(strfind(cfg.dataset,'DG')) == 0
    EvcodeTimeRight    = [39:40 45:46 51:52 57:58 63:64 69:70];
    EvcodeTimeLeft      = [41:42 47:48 53:54 59:60 65:66 71:72];
    EvcodeSpaceRight   = [39:42 45:48 51:54];
    EvcodeSpaceLeft     = [57:60 63:66 69:72];
else
    error('Jesus was a coconut!')
end

respcode = [1024 32768];

for k = [1:5 6:15 37:72 1024 32768]
    if isempty(intersect(k,1:5)) == 0
        for i = 1:length(MiniBlock.FutPar)
            [x,y] = find(MiniBlock.FutPar{1,i}(:,2) == k);
            MiniBlock.FutPar{1,i}(x,4) = k;
        end
    elseif  isempty(intersect(k,6:15)) == 0
        for i = 1:length(MiniBlock.FutPar)
            [x,y] = find(MiniBlock.FutPar{1,i}(:,2) == k);
            for xi = 1:length(x)
                MiniBlock.FutPar{1,i}(x(xi),4) = MiniBlock.FutPar{1,i}(x(xi),4) +  k*10;
                if (x(xi)+1) <= length(MiniBlock.FutPar{1,i}) && isempty(intersect(MiniBlock.FutPar{1,i}(x(xi)+1,2),37:72)) == 0;
                    MiniBlock.FutPar{1,i}(x(xi)+1,4) = MiniBlock.FutPar{1,i}(x(xi)+1,4) +  k*10;
                end
                if (x(xi)+2) <= length(MiniBlock.FutPar{1,i}) && isempty(intersect(MiniBlock.FutPar{1,i}(x(xi)+2,2),16:35)) == 0;
                    MiniBlock.FutPar{1,i}(x(xi)+2,4) = MiniBlock.FutPar{1,i}(x(xi)+2,4) +  k*10;
                end
                if (x(xi)+3) <= length(MiniBlock.FutPar{1,i}) && isempty(intersect(MiniBlock.FutPar{1,i}(x(xi)+3,2),respcode)) == 0;
                    MiniBlock.FutPar{1,i}(x(xi)+3,4) = MiniBlock.FutPar{1,i}(x(xi)+3,4) +  k*10;
                end
            end
        end
    elseif  isempty(intersect(k,37:72)) == 0
        for i = 1:length(MiniBlock.FutPar)
            [x,y] = find(MiniBlock.FutPar{1,i}(:,2) == k);
            for xi = 1:length(x)
                MiniBlock.FutPar{1,i}(x(xi),4) = MiniBlock.FutPar{1,i}(x(xi),4) +  k*1000;
                if (x(xi)-1) >0 && isempty(intersect(MiniBlock.FutPar{1,i}(x(xi)-1,2),6:15)) == 0;
                    MiniBlock.FutPar{1,i}(x(xi)-1,4) = MiniBlock.FutPar{1,i}(x(xi)-1,4) +  k*1000;
                end
                if (x(xi)+1) <= length(MiniBlock.FutPar{1,i}) && isempty(intersect(MiniBlock.FutPar{1,i}(x(xi)+1,2),16:35)) == 0;
                    MiniBlock.FutPar{1,i}(x(xi)+1,4) = MiniBlock.FutPar{1,i}(x(xi)+1,4) +  k*1000;
                end
                if (x(xi)+2) <= length(MiniBlock.FutPar{1,i}) && isempty(intersect(MiniBlock.FutPar{1,i}(x(xi)+2,2),respcode)) == 0;
                    MiniBlock.FutPar{1,i}(x(xi)+2,4) = MiniBlock.FutPar{1,i}(x(xi)+2,4) +  k*1000;
                end
            end
        end
    elseif  isempty(intersect(k,[1024 32768])) == 0
        for i = 1:length(MiniBlock.FutPar)
            [x,y] = find(MiniBlock.FutPar{1,i}(:,2) == k);
            for xi = 1:length(x)
                if (x(xi)-3) > 0 && isempty(intersect(MiniBlock.FutPar{1,i}(x(xi)-3,2),10)) == 0; % timequestion
                    if isempty(intersect(MiniBlock.FutPar{1,i}(x(xi),2),1024)) == 0; % leftbutton
                        if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.FutPar{1,i}(x(xi)-2,2),EvcodeTimeLeft )) == 0;
                            MiniBlock.FutPar{1,i}(x(xi),4) = MiniBlock.FutPar{1,i}(x(xi),4) +  1; % TimeLeftTrue
                            if (x(xi)-1) > 0 && isempty(intersect(MiniBlock.FutPar{1,i}(x(xi)-1,2),16:35)) == 0;
                                MiniBlock.FutPar{1,i}(x(xi)-1,4) = MiniBlock.FutPar{1,i}(x(xi)-1,4) +  1;
                            end
                            if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.FutPar{1,i}(x(xi)-2,2),37:72)) == 0;
                                MiniBlock.FutPar{1,i}(x(xi)-2,4) = MiniBlock.FutPar{1,i}(x(xi)-2,4) +  1;
                            end
                            if (x(xi)-3) > 0 && isempty(intersect(MiniBlock.FutPar{1,i}(x(xi)-3,2),10)) == 0;
                                MiniBlock.FutPar{1,i}(x(xi)-3,4) = MiniBlock.FutPar{1,i}(x(xi)-3,4) +  1;
                            end
                        elseif (x(xi)-2) > 0 && isempty(intersect(MiniBlock.FutPar{1,i}(x(xi)-2,2),EvcodeTimeRight )) == 0;
                            MiniBlock.FutPar{1,i}(x(xi),4) = MiniBlock.FutPar{1,i}(x(xi),4) +  2; % TimeLeftFalse
                            if (x(xi)-1) > 0 && isempty(intersect(MiniBlock.FutPar{1,i}(x(xi)-1,2),16:35)) == 0;
                                MiniBlock.FutPar{1,i}(x(xi)-1,4) = MiniBlock.FutPar{1,i}(x(xi)-1,4) +  2;
                            end
                            if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.FutPar{1,i}(x(xi)-2,2),37:72)) == 0;
                                MiniBlock.FutPar{1,i}(x(xi)-2,4) = MiniBlock.FutPar{1,i}(x(xi)-2,4) + 2;
                            end
                            if (x(xi)-3) > 0 && isempty(intersect(MiniBlock.FutPar{1,i}(x(xi)-3,2),10)) == 0;
                                MiniBlock.FutPar{1,i}(x(xi)-3,4) = MiniBlock.FutPar{1,i}(x(xi)-3,4) + 2;
                            end
                        end
                    elseif (x(xi)-2) > 0 && isempty(intersect(MiniBlock.FutPar{1,i}(x(xi),2),32768)) == 0; % rightbutton
                        if isempty(intersect(MiniBlock.FutPar{1,i}(x(xi)-2,2),EvcodeTimeRight )) == 0;
                            MiniBlock.FutPar{1,i}(x(xi),4) = MiniBlock.FutPar{1,i}(x(xi),4) +  3; % TimeRightTrue
                            if (x(xi)-1) > 0 && isempty(intersect(MiniBlock.FutPar{1,i}(x(xi)-1,2),16:35)) == 0;
                                MiniBlock.FutPar{1,i}(x(xi)-1,4) = MiniBlock.FutPar{1,i}(x(xi)-1,4) +  3;
                            end
                            if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.FutPar{1,i}(x(xi)-2,2),37:72)) == 0;
                                MiniBlock.FutPar{1,i}(x(xi)-2,4) = MiniBlock.FutPar{1,i}(x(xi)-2,4) +  3;
                            end
                            if (x(xi)-3) > 0 && isempty(intersect(MiniBlock.FutPar{1,i}(x(xi)-3,2),10)) == 0;
                                MiniBlock.FutPar{1,i}(x(xi)-3,4) = MiniBlock.FutPar{1,i}(x(xi)-3,4) +  3;
                            end
                        elseif (x(xi)-2) > 0 && isempty(intersect(MiniBlock.FutPar{1,i}(x(xi)-2,2),EvcodeTimeLeft )) == 0;
                            MiniBlock.FutPar{1,i}(x(xi),4) = MiniBlock.FutPar{1,i}(x(xi),4) +  4; % TimeRightFalse
                            if (x(xi)-1) > 0 && isempty(intersect(MiniBlock.FutPar{1,i}(x(xi)-1,2),16:35)) == 0;
                                MiniBlock.FutPar{1,i}(x(xi)-1,4) = MiniBlock.FutPar{1,i}(x(xi)-1,4) +  4;
                            end
                            if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.FutPar{1,i}(x(xi)-2,2),37:72)) == 0;
                                MiniBlock.FutPar{1,i}(x(xi)-2,4) = MiniBlock.FutPar{1,i}(x(xi)-2,4) +  4;
                            end
                            if (x(xi)-3) > 0 && isempty(intersect(MiniBlock.FutPar{1,i}(x(xi)-3,2),10)) == 0;
                                MiniBlock.FutPar{1,i}(x(xi)-3,4) = MiniBlock.FutPar{1,i}(x(xi)-3,4) + 4;
                            end
                        end
                    end
                elseif (x(xi)-3) > 0 && isempty(intersect(MiniBlock.FutPar{1,i}(x(xi)-3,2),11)) == 0; % spacequestion
                    if isempty(intersect(MiniBlock.FutPar{1,i}(x(xi),2),1024)) == 0; % leftbutton
                        if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.FutPar{1,i}(x(xi)-2,2),EvcodeTimeLeft )) == 0;
                            MiniBlock.FutPar{1,i}(x(xi),4) = MiniBlock.FutPar{1,i}(x(xi),4) +  1; % SpaceLeftTrue
                            if (x(xi)-1) > 0 && isempty(intersect(MiniBlock.FutPar{1,i}(x(xi)-1,2),16:35)) == 0;
                                MiniBlock.FutPar{1,i}(x(xi)-1,4) = MiniBlock.FutPar{1,i}(x(xi)-1,4) +  1;
                            end
                            if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.FutPar{1,i}(x(xi)-2,2),37:72)) == 0;
                                MiniBlock.FutPar{1,i}(x(xi)-2,4) = MiniBlock.FutPar{1,i}(x(xi)-2,4) +  1;
                            end
                            if (x(xi)-3) > 0 && isempty(intersect(MiniBlock.FutPar{1,i}(x(xi)-3,2),11)) == 0;
                                MiniBlock.FutPar{1,i}(x(xi)-3,4) = MiniBlock.FutPar{1,i}(x(xi)-3,4) +  1;
                            end
                        elseif (x(xi)-2) > 0 && isempty(intersect(MiniBlock.FutPar{1,i}(x(xi)-2,2),EvcodeTimeRight )) == 0;
                            MiniBlock.FutPar{1,i}(x(xi),4) = MiniBlock.FutPar{1,i}(x(xi),4) +  2; % SpaceLeftFalse
                            if (x(xi)-1) > 0 && isempty(intersect(MiniBlock.FutPar{1,i}(x(xi)-1,2),16:35)) == 0;
                                MiniBlock.FutPar{1,i}(x(xi)-1,4) = MiniBlock.FutPar{1,i}(x(xi)-1,4) +  2;
                            end
                            if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.FutPar{1,i}(x(xi)-2,2),37:72)) == 0;
                                MiniBlock.FutPar{1,i}(x(xi)-2,4) = MiniBlock.FutPar{1,i}(x(xi)-2,4) + 2;
                            end
                            if (x(xi)-3) > 0 && isempty(intersect(MiniBlock.FutPar{1,i}(x(xi)-3,2),11)) == 0;
                                MiniBlock.FutPar{1,i}(x(xi)-3,4) = MiniBlock.FutPar{1,i}(x(xi)-3,4) + 2;
                            end
                        end
                    elseif isempty(intersect(MiniBlock.FutPar{1,i}(x(xi),2),32768)) == 0; % rightbutton
                        if isempty(intersect(MiniBlock.FutPar{1,i}(x(xi)-2,2),EvcodeTimeRight )) == 0;
                            MiniBlock.FutPar{1,i}(x(xi),4) = MiniBlock.FutPar{1,i}(x(xi),4) +  3; % SpaceRightTrue
                            if (x(xi)-1) > 0 && isempty(intersect(MiniBlock.FutPar{1,i}(x(xi)-1,2),16:35)) == 0;
                                MiniBlock.FutPar{1,i}(x(xi)-1,4) = MiniBlock.FutPar{1,i}(x(xi)-1,4) +  3;
                            end
                            if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.FutPar{1,i}(x(xi)-2,2),37:72)) == 0;
                                MiniBlock.FutPar{1,i}(x(xi)-2,4) = MiniBlock.FutPar{1,i}(x(xi)-2,4) +  3;
                            end
                            if (x(xi)-3) > 0 && isempty(intersect(MiniBlock.FutPar{1,i}(x(xi)-3,2),11)) == 0;
                                MiniBlock.FutPar{1,i}(x(xi)-3,4) = MiniBlock.FutPar{1,i}(x(xi)-3,4) +  3;
                            end
                        elseif (x(xi)-2) > 0 && isempty(intersect(MiniBlock.FutPar{1,i}(x(xi)-2,2),EvcodeTimeLeft )) == 0;
                            MiniBlock.FutPar{1,i}(x(xi),4) = MiniBlock.FutPar{1,i}(x(xi),4) +  4; % SpaceRightFalse
                            if (x(xi)-1) > 0 && isempty(intersect(MiniBlock.FutPar{1,i}(x(xi)-1,2),16:35)) == 0;
                                MiniBlock.FutPar{1,i}(x(xi)-1,4) = MiniBlock.FutPar{1,i}(x(xi)-1,4) +  4;
                            end
                            if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.FutPar{1,i}(x(xi)-2,2),37:72)) == 0;
                                MiniBlock.FutPar{1,i}(x(xi)-2,4) = MiniBlock.FutPar{1,i}(x(xi)-2,4) +  4;
                            end
                            if (x(xi)-3) > 0 && isempty(intersect(MiniBlock.FutPar{1,i}(x(xi)-3,2),11)) == 0;
                                MiniBlock.FutPar{1,i}(x(xi)-3,4) = MiniBlock.FutPar{1,i}(x(xi)-3,4) +  4;
                            end
                        end
                    end
                end
            end
        end
    end
end

% recode PreW

for i = 1:length(MiniBlock.PreW)
    for j = 1:length(MiniBlock.PreW{1,i}(:,:))
        MiniBlock.PreW{1,i}(1:j,4) = 0;
    end
end

if isempty(strfind(cfg.dataset,'GD')) == 0
    EvcodeTimeLeft      = [37:39 43:45 49:51 55:57];
    EvcodeTimeRight    = [40:42 46:48 52:54 58:60];
    EvcodeSpaceLeft     = [37:48];
    EvcodeSpaceRight   = [49:60];
elseif isempty(strfind(cfg.dataset,'DG')) == 0
    EvcodeTimeRight    = [37:39 43:45 49:51 55:57];
    EvcodeTimeLeft      = [40:42 46:48 52:54 58:60];
    EvcodeSpaceRight   = [37:48];
    EvcodeSpaceLeft     = [49:60];
else
    error('Jesus was a coconut!')
end

respcode = [1024 32768];

for k = [1:5 6:15 37:72 1024 32768]
    if isempty(intersect(k,1:5)) == 0
        for i = 1:length(MiniBlock.PreW)
            [x,y] = find(MiniBlock.PreW{1,i}(:,2) == k);
            MiniBlock.PreW{1,i}(x,4) = k;
        end
    elseif  isempty(intersect(k,6:15)) == 0
        for i = 1:length(MiniBlock.PreW)
            [x,y] = find(MiniBlock.PreW{1,i}(:,2) == k);
            for xi = 1:length(x)
                MiniBlock.PreW{1,i}(x(xi),4) = MiniBlock.PreW{1,i}(x(xi),4) +  k*10;
                if (x(xi)+1) <= length(MiniBlock.PreW{1,i}) && isempty(intersect(MiniBlock.PreW{1,i}(x(xi)+1,2),37:72)) == 0;
                    MiniBlock.PreW{1,i}(x(xi)+1,4) = MiniBlock.PreW{1,i}(x(xi)+1,4) +  k*10;
                end
                if (x(xi)+2) <= length(MiniBlock.PreW{1,i}) && isempty(intersect(MiniBlock.PreW{1,i}(x(xi)+2,2),16:35)) == 0;
                    MiniBlock.PreW{1,i}(x(xi)+2,4) = MiniBlock.PreW{1,i}(x(xi)+2,4) +  k*10;
                end
                if (x(xi)+3) <= length(MiniBlock.PreW{1,i}) && isempty(intersect(MiniBlock.PreW{1,i}(x(xi)+3,2),respcode)) == 0;
                    MiniBlock.PreW{1,i}(x(xi)+3,4) = MiniBlock.PreW{1,i}(x(xi)+3,4) +  k*10;
                end
            end
        end
    elseif  isempty(intersect(k,37:72)) == 0
        for i = 1:length(MiniBlock.PreW)
            [x,y] = find(MiniBlock.PreW{1,i}(:,2) == k);
            for xi = 1:length(x)
                MiniBlock.PreW{1,i}(x(xi),4) = MiniBlock.PreW{1,i}(x(xi),4) +  k*1000;
                if (x(xi)-1) >0 && isempty(intersect(MiniBlock.PreW{1,i}(x(xi)-1,2),6:15)) == 0;
                    MiniBlock.PreW{1,i}(x(xi)-1,4) = MiniBlock.PreW{1,i}(x(xi)-1,4) +  k*1000;
                end
                if (x(xi)+1) <= length(MiniBlock.PreW{1,i}) && isempty(intersect(MiniBlock.PreW{1,i}(x(xi)+1,2),16:35)) == 0;
                    MiniBlock.PreW{1,i}(x(xi)+1,4) = MiniBlock.PreW{1,i}(x(xi)+1,4) +  k*1000;
                end
                if (x(xi)+2) <= length(MiniBlock.PreW{1,i}) && isempty(intersect(MiniBlock.PreW{1,i}(x(xi)+2,2),respcode)) == 0;
                    MiniBlock.PreW{1,i}(x(xi)+2,4) = MiniBlock.PreW{1,i}(x(xi)+2,4) +  k*1000;
                end
            end
        end
    elseif  isempty(intersect(k,[1024 32768])) == 0
        for i = 1:length(MiniBlock.PreW)
            [x,y] = find(MiniBlock.PreW{1,i}(:,2) == k);
            for xi = 1:length(x)
                if (x(xi)-3) > 0 && isempty(intersect(MiniBlock.PreW{1,i}(x(xi)-3,2),12)) == 0; % timequestion
                    if isempty(intersect(MiniBlock.PreW{1,i}(x(xi),2),1024)) == 0; % leftbutton
                        if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PreW{1,i}(x(xi)-2,2),EvcodeTimeLeft )) == 0;
                            MiniBlock.PreW{1,i}(x(xi),4) = MiniBlock.PreW{1,i}(x(xi),4) +  1; % TimeLeftTrue
                            if (x(xi)-1) > 0 && isempty(intersect(MiniBlock.PreW{1,i}(x(xi)-1,2),16:35)) == 0;
                                MiniBlock.PreW{1,i}(x(xi)-1,4) = MiniBlock.PreW{1,i}(x(xi)-1,4) +  1;
                            end
                            if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PreW{1,i}(x(xi)-2,2),37:72)) == 0;
                                MiniBlock.PreW{1,i}(x(xi)-2,4) = MiniBlock.PreW{1,i}(x(xi)-2,4) +  1;
                            end
                            if (x(xi)-3) > 0 && isempty(intersect(MiniBlock.PreW{1,i}(x(xi)-3,2),12)) == 0;
                                MiniBlock.PreW{1,i}(x(xi)-3,4) = MiniBlock.PreW{1,i}(x(xi)-3,4) +  1;
                            end
                        elseif (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PreW{1,i}(x(xi)-2,2),EvcodeTimeRight )) == 0;
                            MiniBlock.PreW{1,i}(x(xi),4) = MiniBlock.PreW{1,i}(x(xi),4) +  2; % TimeLeftFalse
                            if (x(xi)-1) > 0 && isempty(intersect(MiniBlock.PreW{1,i}(x(xi)-1,2),16:35)) == 0;
                                MiniBlock.PreW{1,i}(x(xi)-1,4) = MiniBlock.PreW{1,i}(x(xi)-1,4) +  2;
                            end
                            if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PreW{1,i}(x(xi)-2,2),37:72)) == 0;
                                MiniBlock.PreW{1,i}(x(xi)-2,4) = MiniBlock.PreW{1,i}(x(xi)-2,4) + 2;
                            end
                            if (x(xi)-3) > 0 && isempty(intersect(MiniBlock.PreW{1,i}(x(xi)-3,2),12)) == 0;
                                MiniBlock.PreW{1,i}(x(xi)-3,4) = MiniBlock.PreW{1,i}(x(xi)-3,4) + 2;
                            end
                        end
                    elseif isempty(intersect(MiniBlock.PreW{1,i}(x(xi),2),32768)) == 0; % rightbutton
                        if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PreW{1,i}(x(xi)-2,2),EvcodeTimeRight )) == 0;
                            MiniBlock.PreW{1,i}(x(xi),4) = MiniBlock.PreW{1,i}(x(xi),4) +  3; % TimeRightTrue
                            if (x(xi)-1) > 0 && isempty(intersect(MiniBlock.PreW{1,i}(x(xi)-1,2),16:35)) == 0;
                                MiniBlock.PreW{1,i}(x(xi)-1,4) = MiniBlock.PreW{1,i}(x(xi)-1,4) +  3;
                            end
                            if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PreW{1,i}(x(xi)-2,2),37:72)) == 0;
                                MiniBlock.PreW{1,i}(x(xi)-2,4) = MiniBlock.PreW{1,i}(x(xi)-2,4) +  3;
                            end
                            if (x(xi)-3) > 0 && isempty(intersect(MiniBlock.PreW{1,i}(x(xi)-3,2),12)) == 0;
                                MiniBlock.PreW{1,i}(x(xi)-3,4) = MiniBlock.PreW{1,i}(x(xi)-3,4) +  3;
                            end
                        elseif (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PreW{1,i}(x(xi)-2,2),EvcodeTimeLeft )) == 0;
                            MiniBlock.PreW{1,i}(x(xi),4) = MiniBlock.PreW{1,i}(x(xi),4) +  4; % TimeRightFalse
                            if (x(xi)-1) > 0 && isempty(intersect(MiniBlock.PreW{1,i}(x(xi)-1,2),16:35)) == 0;
                                MiniBlock.PreW{1,i}(x(xi)-1,4) = MiniBlock.PreW{1,i}(x(xi)-1,4) +  4;
                            end
                            if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PreW{1,i}(x(xi)-2,2),37:72)) == 0;
                                MiniBlock.PreW{1,i}(x(xi)-2,4) = MiniBlock.PreW{1,i}(x(xi)-2,4) +  4;
                            end
                            if (x(xi)-3) > 0 && isempty(intersect(MiniBlock.PreW{1,i}(x(xi)-3,2),12)) == 0;
                                MiniBlock.PreW{1,i}(x(xi)-3,4) = MiniBlock.PreW{1,i}(x(xi)-3,4) + 4;
                            end
                        end
                    end
                elseif (x(xi)-3) > 0 && isempty(intersect(MiniBlock.PreW{1,i}(x(xi)-3,2),13)) == 0; % spacequestion
                    if isempty(intersect(MiniBlock.PreW{1,i}(x(xi),2),1024)) == 0; % leftbutton
                        if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PreW{1,i}(x(xi)-2,2),EvcodeTimeLeft )) == 0;
                            MiniBlock.PreW{1,i}(x(xi),4) = MiniBlock.PreW{1,i}(x(xi),4) +  1; % SpaceLeftTrue
                            if (x(xi)-1) > 0 && isempty(intersect(MiniBlock.PreW{1,i}(x(xi)-1,2),16:35)) == 0;
                                MiniBlock.PreW{1,i}(x(xi)-1,4) = MiniBlock.PreW{1,i}(x(xi)-1,4) +  1;
                            end
                            if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PreW{1,i}(x(xi)-2,2),37:72)) == 0;
                                MiniBlock.PreW{1,i}(x(xi)-2,4) = MiniBlock.PreW{1,i}(x(xi)-2,4) +  1;
                            end
                            if (x(xi)-3) > 0 && isempty(intersect(MiniBlock.PreW{1,i}(x(xi)-3,2),13)) == 0;
                                MiniBlock.PreW{1,i}(x(xi)-3,4) = MiniBlock.PreW{1,i}(x(xi)-3,4) +  1;
                            end
                        elseif (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PreW{1,i}(x(xi)-2,2),EvcodeTimeRight )) == 0;
                            MiniBlock.PreW{1,i}(x(xi),4) = MiniBlock.PreW{1,i}(x(xi),4) +  2; % SpaceLeftFalse
                            if (x(xi)-1) > 0 && isempty(intersect(MiniBlock.PreW{1,i}(x(xi)-1,2),16:35)) == 0;
                                MiniBlock.PreW{1,i}(x(xi)-1,4) = MiniBlock.PreW{1,i}(x(xi)-1,4) +  2;
                            end
                            if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PreW{1,i}(x(xi)-2,2),37:72)) == 0;
                                MiniBlock.PreW{1,i}(x(xi)-2,4) = MiniBlock.PreW{1,i}(x(xi)-2,4) + 2;
                            end
                            if (x(xi)-3) > 0 && isempty(intersect(MiniBlock.PreW{1,i}(x(xi)-3,2),13)) == 0;
                                MiniBlock.PreW{1,i}(x(xi)-3,4) = MiniBlock.PreW{1,i}(x(xi)-3,4) + 2;
                            end
                        end
                    elseif isempty(intersect(MiniBlock.PreW{1,i}(x(xi),2),32768)) == 0; % rightbutton
                        if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PreW{1,i}(x(xi)-2,2),EvcodeTimeRight )) == 0;
                            MiniBlock.PreW{1,i}(x(xi),4) = MiniBlock.PreW{1,i}(x(xi),4) +  3; % SpaceRightTrue
                            if (x(xi)-1) > 0 && isempty(intersect(MiniBlock.PreW{1,i}(x(xi)-1,2),16:35)) == 0;
                                MiniBlock.PreW{1,i}(x(xi)-1,4) = MiniBlock.PreW{1,i}(x(xi)-1,4) +  3;
                            end
                            if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PreW{1,i}(x(xi)-2,2),37:72)) == 0;
                                MiniBlock.PreW{1,i}(x(xi)-2,4) = MiniBlock.PreW{1,i}(x(xi)-2,4) +  3;
                            end
                            if (x(xi)-3) > 0 && isempty(intersect(MiniBlock.PreW{1,i}(x(xi)-3,2),13)) == 0;
                                MiniBlock.PreW{1,i}(x(xi)-3,4) = MiniBlock.PreW{1,i}(x(xi)-3,4) +  3;
                            end
                        elseif (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PreW{1,i}(x(xi)-2,2),EvcodeTimeLeft )) == 0;
                            MiniBlock.PreW{1,i}(x(xi),4) = MiniBlock.PreW{1,i}(x(xi),4) +  4; % SpaceRightFalse
                            if (x(xi)-1) > 0 && isempty(intersect(MiniBlock.PreW{1,i}(x(xi)-1,2),16:35)) == 0;
                                MiniBlock.PreW{1,i}(x(xi)-1,4) = MiniBlock.PreW{1,i}(x(xi)-1,4) +  4;
                            end
                            if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PreW{1,i}(x(xi)-2,2),37:72)) == 0;
                                MiniBlock.PreW{1,i}(x(xi)-2,4) = MiniBlock.PreW{1,i}(x(xi)-2,4) +  4;
                            end
                            if (x(xi)-3) > 0 && isempty(intersect(MiniBlock.PreW{1,i}(x(xi)-3,2),13)) == 0;
                                MiniBlock.PreW{1,i}(x(xi)-3,4) = MiniBlock.PreW{1,i}(x(xi)-3,4) +  4;
                            end
                        end
                    end
                end
            end
        end
    end
end

% recode PreE

for i = 1:length(MiniBlock.PreE)
    for j = 1:length(MiniBlock.PreE{1,i}(:,:))
        MiniBlock.PreE{1,i}(1:j,4) = 0;
    end
end

if isempty(strfind(cfg.dataset,'GD')) == 0
    EvcodeTimeLeft      = [37:39 43:45 49:51 55:57];
    EvcodeTimeRight    = [40:42 46:48 52:54 58:60];
    EvcodeSpaceLeft     = [37:48];
    EvcodeSpaceRight   = [49:60];
elseif isempty(strfind(cfg.dataset,'DG')) == 0
    EvcodeTimeRight    = [37:39 43:45 49:51 55:57];
    EvcodeTimeLeft      = [40:42 46:48 52:54 58:60];
    EvcodeSpaceRight   = [37:48];
    EvcodeSpaceLeft     = [49:60];
else
    error('Jesus was a coconut!')
end

respcode = [1024 32768];

for k = [1:5 6:15 37:72 1024 32768]
    if isempty(intersect(k,1:5)) == 0
        for i = 1:length(MiniBlock.PreE)
            [x,y] = find(MiniBlock.PreE{1,i}(:,2) == k);
            MiniBlock.PreE{1,i}(x,4) = k;
        end
    elseif  isempty(intersect(k,6:15)) == 0
        for i = 1:length(MiniBlock.PreE)
            [x,y] = find(MiniBlock.PreE{1,i}(:,2) == k);
            for xi = 1:length(x)
                MiniBlock.PreE{1,i}(x(xi),4) = MiniBlock.PreE{1,i}(x(xi),4) +  k*10;
                if (x(xi)+1) <= length(MiniBlock.PreE{1,i}) && isempty(intersect(MiniBlock.PreE{1,i}(x(xi)+1,2),37:72)) == 0;
                    MiniBlock.PreE{1,i}(x(xi)+1,4) = MiniBlock.PreE{1,i}(x(xi)+1,4) +  k*10;
                end
                if (x(xi)+2) <= length(MiniBlock.PreE{1,i}) && isempty(intersect(MiniBlock.PreE{1,i}(x(xi)+2,2),16:35)) == 0;
                    MiniBlock.PreE{1,i}(x(xi)+2,4) = MiniBlock.PreE{1,i}(x(xi)+2,4) +  k*10;
                end
                if (x(xi)+3) <= length(MiniBlock.PreE{1,i}) && isempty(intersect(MiniBlock.PreE{1,i}(x(xi)+3,2),respcode)) == 0;
                    MiniBlock.PreE{1,i}(x(xi)+3,4) = MiniBlock.PreE{1,i}(x(xi)+3,4) +  k*10;
                end
            end
        end
    elseif  isempty(intersect(k,37:72)) == 0
        for i = 1:length(MiniBlock.PreE)
            [x,y] = find(MiniBlock.PreE{1,i}(:,2) == k);
            for xi = 1:length(x)
                MiniBlock.PreE{1,i}(x(xi),4) = MiniBlock.PreE{1,i}(x(xi),4) +  k*1000;
                if (x(xi)-1) >0 && isempty(intersect(MiniBlock.PreE{1,i}(x(xi)-1,2),6:15)) == 0;
                    MiniBlock.PreE{1,i}(x(xi)-1,4) = MiniBlock.PreE{1,i}(x(xi)-1,4) +  k*1000;
                end
                if (x(xi)+1) <= length(MiniBlock.PreE{1,i}) && isempty(intersect(MiniBlock.PreE{1,i}(x(xi)+1,2),16:35)) == 0;
                    MiniBlock.PreE{1,i}(x(xi)+1,4) = MiniBlock.PreE{1,i}(x(xi)+1,4) +  k*1000;
                end
                if (x(xi)+2) <= length(MiniBlock.PreE{1,i}) && isempty(intersect(MiniBlock.PreE{1,i}(x(xi)+2,2),respcode)) == 0;
                    MiniBlock.PreE{1,i}(x(xi)+2,4) = MiniBlock.PreE{1,i}(x(xi)+2,4) +  k*1000;
                end
            end
        end
    elseif  isempty(intersect(k,[1024 32768])) == 0
        for i = 1:length(MiniBlock.PreE)
            [x,y] = find(MiniBlock.PreE{1,i}(:,2) == k);
            for xi = 1:length(x)
                if (x(xi)-3) > 0 && isempty(intersect(MiniBlock.PreE{1,i}(x(xi)-3,2),14)) == 0; % timequestion
                    if isempty(intersect(MiniBlock.PreE{1,i}(x(xi),2),1024)) == 0; % leftbutton
                        if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PreE{1,i}(x(xi)-2,2),EvcodeTimeLeft )) == 0;
                            MiniBlock.PreE{1,i}(x(xi),4) = MiniBlock.PreE{1,i}(x(xi),4) +  1; % TimeLeftTrue
                            if (x(xi)-1) > 0 && isempty(intersect(MiniBlock.PreE{1,i}(x(xi)-1,2),16:35)) == 0;
                                MiniBlock.PreE{1,i}(x(xi)-1,4) = MiniBlock.PreE{1,i}(x(xi)-1,4) +  1;
                            end
                            if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PreE{1,i}(x(xi)-2,2),37:72)) == 0;
                                MiniBlock.PreE{1,i}(x(xi)-2,4) = MiniBlock.PreE{1,i}(x(xi)-2,4) +  1;
                            end
                            if (x(xi)-3) > 0 && isempty(intersect(MiniBlock.PreE{1,i}(x(xi)-3,2),14)) == 0;
                                MiniBlock.PreE{1,i}(x(xi)-3,4) = MiniBlock.PreE{1,i}(x(xi)-3,4) +  1;
                            end
                        elseif (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PreE{1,i}(x(xi)-2,2),EvcodeTimeRight )) == 0;
                            MiniBlock.PreE{1,i}(x(xi),4) = MiniBlock.PreE{1,i}(x(xi),4) +  2; % TimeLeftFalse
                            if (x(xi)-1) > 0 && isempty(intersect(MiniBlock.PreE{1,i}(x(xi)-1,2),16:35)) == 0;
                                MiniBlock.PreE{1,i}(x(xi)-1,4) = MiniBlock.PreE{1,i}(x(xi)-1,4) +  2;
                            end
                            if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PreE{1,i}(x(xi)-2,2),37:72)) == 0;
                                MiniBlock.PreE{1,i}(x(xi)-2,4) = MiniBlock.PreE{1,i}(x(xi)-2,4) + 2;
                            end
                            if (x(xi)-3) > 0 && isempty(intersect(MiniBlock.PreE{1,i}(x(xi)-3,2),14)) == 0;
                                MiniBlock.PreE{1,i}(x(xi)-3,4) = MiniBlock.PreE{1,i}(x(xi)-3,4) + 2;
                            end
                        end
                    elseif isempty(intersect(MiniBlock.PreE{1,i}(x(xi),2),32768)) == 0; % rightbutton
                        if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PreE{1,i}(x(xi)-2,2),EvcodeTimeRight )) == 0;
                            MiniBlock.PreE{1,i}(x(xi),4) = MiniBlock.PreE{1,i}(x(xi),4) +  3; % TimeRightTrue
                            if (x(xi)-1) > 0 && isempty(intersect(MiniBlock.PreE{1,i}(x(xi)-1,2),16:35)) == 0;
                                MiniBlock.PreE{1,i}(x(xi)-1,4) = MiniBlock.PreE{1,i}(x(xi)-1,4) +  3;
                            end
                            if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PreE{1,i}(x(xi)-2,2),37:72)) == 0;
                                MiniBlock.PreE{1,i}(x(xi)-2,4) = MiniBlock.PreE{1,i}(x(xi)-2,4) +  3;
                            end
                            if (x(xi)-3) > 0 && isempty(intersect(MiniBlock.PreE{1,i}(x(xi)-3,2),14)) == 0;
                                MiniBlock.PreE{1,i}(x(xi)-3,4) = MiniBlock.PreE{1,i}(x(xi)-3,4) +  3;
                            end
                        elseif (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PreE{1,i}(x(xi)-2,2),EvcodeTimeLeft )) == 0;
                            MiniBlock.PreE{1,i}(x(xi),4) = MiniBlock.PreE{1,i}(x(xi),4) +  4; % TimeRightFalse
                            if (x(xi)-1) > 0 && isempty(intersect(MiniBlock.PreE{1,i}(x(xi)-1,2),16:35)) == 0;
                                MiniBlock.PreE{1,i}(x(xi)-1,4) = MiniBlock.PreE{1,i}(x(xi)-1,4) +  4;
                            end
                            if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PreE{1,i}(x(xi)-2,2),37:72)) == 0;
                                MiniBlock.PreE{1,i}(x(xi)-2,4) = MiniBlock.PreE{1,i}(x(xi)-2,4) +  4;
                            end
                            if (x(xi)-3) > 0 && isempty(intersect(MiniBlock.PreE{1,i}(x(xi)-3,2),14)) == 0;
                                MiniBlock.PreE{1,i}(x(xi)-3,4) = MiniBlock.PreE{1,i}(x(xi)-3,4) + 4;
                            end
                        end
                    end
                elseif (x(xi)-3) > 0 && isempty(intersect(MiniBlock.PreE{1,i}(x(xi)-3,2),15)) == 0; % spacequestion
                    if isempty(intersect(MiniBlock.PreE{1,i}(x(xi),2),1024)) == 0; % leftbutton
                        if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PreE{1,i}(x(xi)-2,2),EvcodeTimeLeft )) == 0;
                            MiniBlock.PreE{1,i}(x(xi),4) = MiniBlock.PreE{1,i}(x(xi),4) +  1; % SpaceLeftTrue
                            if (x(xi)-1) > 0 && isempty(intersect(MiniBlock.PreE{1,i}(x(xi)-1,2),16:35)) == 0;
                                MiniBlock.PreE{1,i}(x(xi)-1,4) = MiniBlock.PreE{1,i}(x(xi)-1,4) +  1;
                            end
                            if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PreE{1,i}(x(xi)-2,2),37:72)) == 0;
                                MiniBlock.PreE{1,i}(x(xi)-2,4) = MiniBlock.PreE{1,i}(x(xi)-2,4) +  1;
                            end
                            if (x(xi)-3) > 0 && isempty(intersect(MiniBlock.PreE{1,i}(x(xi)-3,2),15)) == 0;
                                MiniBlock.PreE{1,i}(x(xi)-3,4) = MiniBlock.PreE{1,i}(x(xi)-3,4) +  1;
                            end
                        elseif (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PreE{1,i}(x(xi)-2,2),EvcodeTimeRight )) == 0;
                            MiniBlock.PreE{1,i}(x(xi),4) = MiniBlock.PreE{1,i}(x(xi),4) +  2; % SpaceLeftFalse
                            if (x(xi)-1) > 0 && isempty(intersect(MiniBlock.PreE{1,i}(x(xi)-1,2),16:35)) == 0;
                                MiniBlock.PreE{1,i}(x(xi)-1,4) = MiniBlock.PreE{1,i}(x(xi)-1,4) +  2;
                            end
                            if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PreE{1,i}(x(xi)-2,2),37:72)) == 0;
                                MiniBlock.PreE{1,i}(x(xi)-2,4) = MiniBlock.PreE{1,i}(x(xi)-2,4) + 2;
                            end
                            if (x(xi)-3) > 0 && isempty(intersect(MiniBlock.PreE{1,i}(x(xi)-3,2),15)) == 0;
                                MiniBlock.PreE{1,i}(x(xi)-3,4) = MiniBlock.PreE{1,i}(x(xi)-3,4) + 2;
                            end
                        end
                    elseif isempty(intersect(MiniBlock.PreE{1,i}(x(xi),2),32768)) == 0; % rightbutton
                        if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PreE{1,i}(x(xi)-2,2),EvcodeTimeRight )) == 0;
                            MiniBlock.PreE{1,i}(x(xi),4) = MiniBlock.PreE{1,i}(x(xi),4) +  3; % SpaceRightTrue
                            if (x(xi)-1) > 0 && isempty(intersect(MiniBlock.PreE{1,i}(x(xi)-1,2),16:35)) == 0;
                                MiniBlock.PreE{1,i}(x(xi)-1,4) = MiniBlock.PreE{1,i}(x(xi)-1,4) +  3;
                            end
                            if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PreE{1,i}(x(xi)-2,2),37:72)) == 0;
                                MiniBlock.PreE{1,i}(x(xi)-2,4) = MiniBlock.PreE{1,i}(x(xi)-2,4) +  3;
                            end
                            if (x(xi)-3) > 0 && isempty(intersect(MiniBlock.PreE{1,i}(x(xi)-3,2),15)) == 0;
                                MiniBlock.PreE{1,i}(x(xi)-3,4) = MiniBlock.PreE{1,i}(x(xi)-3,4) +  3;
                            end
                        elseif (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PreE{1,i}(x(xi)-2,2),EvcodeTimeLeft )) == 0;
                            MiniBlock.PreE{1,i}(x(xi),4) = MiniBlock.PreE{1,i}(x(xi),4) +  4; % SpaceRightFalse
                            if (x(xi)-1) > 0 && isempty(intersect(MiniBlock.PreE{1,i}(x(xi)-1,2),16:35)) == 0;
                                MiniBlock.PreE{1,i}(x(xi)-1,4) = MiniBlock.PreE{1,i}(x(xi)-1,4) +  4;
                            end
                            if (x(xi)-2) > 0 && isempty(intersect(MiniBlock.PreE{1,i}(x(xi)-2,2),37:72)) == 0;
                                MiniBlock.PreE{1,i}(x(xi)-2,4) = MiniBlock.PreE{1,i}(x(xi)-2,4) +  4;
                            end
                            if (x(xi)-3) > 0 && isempty(intersect(MiniBlock.PreE{1,i}(x(xi)-3,2),15)) == 0;
                                MiniBlock.PreE{1,i}(x(xi)-3,4) = MiniBlock.PreE{1,i}(x(xi)-3,4) +  4;
                            end
                        end
                    end
                end
            end
        end
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% reassemble value and sample vector
valuetrigcorr = [];
samplecorr  = [];
recodetrig    = [];
for i = 1:length(MiniBlock.PrePar)
    valuetrigcorr = [valuetrigcorr; MiniBlock.PrePar{1,i}(:,2)];
    recodetrig    = [recodetrig; MiniBlock.PrePar{1,i}(:,4)];
    samplecorr = [samplecorr; MiniBlock.PrePar{1,i}(:,1)];
end
for i = 1:length(MiniBlock.PasPar)
    valuetrigcorr = [valuetrigcorr; MiniBlock.PasPar{1,i}(:,2)];
    recodetrig    = [recodetrig; MiniBlock.PasPar{1,i}(:,4)];
    samplecorr = [samplecorr; MiniBlock.PasPar{1,i}(:,1)];
end
for i = 1:length(MiniBlock.FutPar)
    valuetrigcorr = [valuetrigcorr; MiniBlock.FutPar{1,i}(:,2)];
    recodetrig    = [recodetrig; MiniBlock.FutPar{1,i}(:,4)];
    samplecorr = [samplecorr; MiniBlock.FutPar{1,i}(:,1)];
end
for i = 1:length(MiniBlock.PreW)
    valuetrigcorr = [valuetrigcorr; MiniBlock.PreW{1,i}(:,2)];
    recodetrig    = [recodetrig; MiniBlock.PreW{1,i}(:,4)];
    samplecorr = [samplecorr; MiniBlock.PreW{1,i}(:,1)];
end
for i = 1:length(MiniBlock.PreE)
    valuetrigcorr = [valuetrigcorr; MiniBlock.PreE{1,i}(:,2)];
    recodetrig    = [recodetrig; MiniBlock.PreE{1,i}(:,4)];
    samplecorr = [samplecorr; MiniBlock.PreE{1,i}(:,1)];
end

%% If the file stop too early
[xlim,ylim] = find(samplecorr >= (hdr.nSamples - max(cfg.trialdef.poststim)*hdr.Fs + min(cfg.photodelay)));

if isempty(xlim) == 0
    samplecorr(xlim) = [];
    valuetrigcorr(xlim) = [];
    recodetrig(xlim) = [];
end

%% epoch according to all triggers
triggerlist1 = [6:2:14 7:2:15]; % question original triggers

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
                trltmp(count,3) = cfg.photodelay(t)*hdr.Fs;
                count = count+1;
            else
            end
        
        trl = [trl ;trltmp];
        
        end
    end
end

