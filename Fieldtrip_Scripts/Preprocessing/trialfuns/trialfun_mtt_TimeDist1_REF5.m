function [trl] = trialfun_mtt_cue_time_v2(cfg)

%% test dataset
% cfg.dataset = 'C:\MTT_MEG\data\sd130343\run2_GD_trans_sss.fif';

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
    elseif (value(i) >= 1024)
        valuetrig(i) = value(i) - 1024;
    end
end

% Lets's check pour MiniBlock REF triggers
sampletriglist = [];
for i = 1:length(valuetrig)
    if valuetrig(i) == 1;
        sampletriglist = [sampletriglist [sample(i) ;i ; 1]];
    elseif valuetrig(i) == 2;
        sampletriglist = [sampletriglist [sample(i) ;i ; 2]];
    elseif valuetrig(i) == 3;
        sampletriglist = [sampletriglist [sample(i) ;i ; 3]];
    elseif valuetrig(i) == 4;
        sampletriglist = [sampletriglist [sample(i) ;i ; 4]];
    elseif valuetrig(i) == 5;
        sampletriglist = [sampletriglist [sample(i) ;i ; 5]];
    end
end
sampletriglist(:,length(sampletriglist)+1) = [sample(end); length(sample); 6];

% there should be between 25 to 33 triggers between each miniblock
% if there is an extra miniblock trigger, let's remove it
sampletoremove = [];
for i = 2:length(sampletriglist)
    if (sampletriglist(2,i) - sampletriglist(2,i-1)) < 25
        sampletoremove = [sampletoremove sampletriglist(2,i)];
    end
end

% correct indices for removed events
for i = 1:length(sampletoremove)
    sample(sampletoremove(i)) = [];
    valuetrig(sampletoremove(i)) = [];
    
    [x,y] = find(sampletriglist(2,:) == sampletoremove(i));
    sampletriglist(:,y) = [];
    
    sampletriglist(2,(y:end)) = sampletriglist(2,(y:end)) - ...
        ones(1,length(sampletriglist(2,(y:end))));
end
    
% Lets's check pour MiniBlock DIM triggers
countMB1 = 1;
countMB2 = 1;
countMB3 = 1;
countMB4 = 1;
countMB5 = 1;
for i = 1:(length(sampletriglist)-1)
    if sampletriglist(3,i) == 1;
        MiniBlock.PrePar{1,countMB1} = [sample(sampletriglist(2,i):(sampletriglist(2,i+1)-1)) ...
                                        (valuetrig(sampletriglist(2,i):(sampletriglist(2,i+1)-1))') ...
                                        [sample(sampletriglist(2,i):(sampletriglist(2,i+1)-1)) - ...
                                        [sample((sampletriglist(2,i)+1):(sampletriglist(2,i+1)-1));0]]*(-1)];
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
    elseif sampletriglist(3,i) == 2;
        MiniBlock.PasPar{1,countMB2} = [sample(sampletriglist(2,i):(sampletriglist(2,i+1)-1)) ...
                                        (valuetrig(sampletriglist(2,i):(sampletriglist(2,i+1)-1))') ...
                                        [sample(sampletriglist(2,i):(sampletriglist(2,i+1)-1)) - ...
                                        [sample((sampletriglist(2,i)+1):(sampletriglist(2,i+1)-1));0]]*(-1)];
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
    elseif sampletriglist(3,i) == 3;
        MiniBlock.FutPar{1,countMB3} = [sample(sampletriglist(2,i):(sampletriglist(2,i+1)-1)) ...
                                        (valuetrig(sampletriglist(2,i):(sampletriglist(2,i+1)-1))') ...
                                        [sample(sampletriglist(2,i):(sampletriglist(2,i+1)-1)) - ...
                                        [sample((sampletriglist(2,i)+1):(sampletriglist(2,i+1)-1));0]]*(-1)];
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
    elseif sampletriglist(3,i) == 4;
        MiniBlock.PreW{1,countMB4}   = [sample(sampletriglist(2,i):(sampletriglist(2,i+1)-1)) ...
                                        (valuetrig(sampletriglist(2,i):(sampletriglist(2,i+1)-1))') ...
                                        [sample(sampletriglist(2,i):(sampletriglist(2,i+1)-1)) - ...
                                        [sample((sampletriglist(2,i)+1):(sampletriglist(2,i+1)-1));0]]*(-1)];
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
    elseif sampletriglist(3,i) == 5;
        MiniBlock.PreE{1,countMB5}   = [sample(sampletriglist(2,i):(sampletriglist(2,i+1)-1)) ...
                                        (valuetrig(sampletriglist(2,i):(sampletriglist(2,i+1)-1))') ...
                                        [sample(sampletriglist(2,i):(sampletriglist(2,i+1)-1)) - ...
                                        [sample((sampletriglist(2,i)+1):(sampletriglist(2,i+1)-1));0]]*(-1)];
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
% recode erroneous triggers
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% reassemble value and sample vector
valuetrigcorr = [];
samplecorr    = [];
for i = 1:length(MiniBlock.PrePar)
    valuetrigcorr = [valuetrigcorr; MiniBlock.PrePar{1,i}(:,2)];
    samplecorr = [samplecorr; MiniBlock.PrePar{1,i}(:,1)];
end
for i = 1:length(MiniBlock.PasPar)
    valuetrigcorr = [valuetrigcorr; MiniBlock.PasPar{1,i}(:,2)];
    samplecorr = [samplecorr; MiniBlock.PasPar{1,i}(:,1)];
end
for i = 1:length(MiniBlock.FutPar)
    valuetrigcorr = [valuetrigcorr; MiniBlock.FutPar{1,i}(:,2)];
    samplecorr = [samplecorr; MiniBlock.FutPar{1,i}(:,1)];
end
for i = 1:length(MiniBlock.PreW)
    valuetrigcorr = [valuetrigcorr; MiniBlock.PreW{1,i}(:,2)];
    samplecorr = [samplecorr; MiniBlock.PreW{1,i}(:,1)];
end
for i = 1:length(MiniBlock.PreE)
    valuetrigcorr = [valuetrigcorr; MiniBlock.PreE{1,i}(:,2)];
    samplecorr = [samplecorr; MiniBlock.PreE{1,i}(:,1)];
end

%% If the file stop too early
[xlim,ylim] = find(samplecorr >= (hdr.nSamples - cfg.trialdef.poststim*hdr.Fs + cfg.photodelay));

if isempty(xlim) == 0
    samplecorr(xlim) = [];
    valuetrigcorr(xlim) = [];
end

x = []; y = [];
% [x16,y16] = find(valuetrigcorr == 16);
% [x20,y20] = find(valuetrigcorr == 20);
% [x24,y24] = find(valuetrigcorr == 24);
% [x28,y28] = find(valuetrigcorr == 28);
[x32,y32] = find(valuetrigcorr == 32);

x = [x32 ];
y = [y32 ];

%% If the file stop too early
[xlim,ylim] = find(samplecorr >= (hdr.nSamples - cfg.trialdef.poststim*hdr.Fs + cfg.photodelay));

if isempty(xlim) == 0
    samplecorr(xlim) = [];
    valuetrigcorr(xlim) = [];
end

count= 1;
for i = 1:length(x)
    if (samplecorr(x(i)) - cfg.trialdef.prestim*hdr.Fs + cfg.photodelay*hdr.Fs) >= 0
        trl(count,1) = samplecorr(x(i)) - cfg.trialdef.prestim*hdr.Fs + cfg.photodelay*hdr.Fs;
        trl(count,2) = samplecorr(x(i)) +cfg.trialdef.poststim*hdr.Fs + cfg.photodelay*hdr.Fs;
        trl(count,3) = 0;
        count = count+1;
    else
    end
end


