function [trlbisbisbis] = trialfun_mtt_event2resp(cfg)

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
    elseif (value(i) > 0) && (value(i) < 256)
        valuetrig(i) = value(i);
    elseif (value(i) > 256) && (value(i) < 512)
        valuetrig(i) = value(i) - 256;
    elseif (value(i) > 512) && (value(i) < 1024)
        valuetrig(i) = value(i) - 512;
    elseif (value(i) > 1024) && (value(i) < 32768)
        valuetrig(i) = value(i) - 1024;
    elseif (value(i) > 32768)
        valuetrig(i) = value(i) - 32768;
    else
        valuetrig(i) = value(i);
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
[xlim,ylim] = find(samplecorr >= (hdr.nSamples - max(cfg.trialdef.poststim)*hdr.Fs + min(cfg.photodelay)));

if isempty(xlim) == 0
    samplecorr(xlim) = [];
    valuetrigcorr(xlim) = [];
end

%% epoch according to all triggers
triggerlist = [16:4:32 17:4:33 18:4:34 19:4:35];

%% reorder valuetrigcorr and samplecorr according to real time

trl = [];
x = [];y = [];
for t = 1: length(triggerlist)
    
    [x{t},y{t}]   = find(valuetrigcorr == triggerlist(t));
    
    trltmp = [];
    count= 1;
    for i = 1:length(x{t})
        if (samplecorr(x{t}(i)) - cfg.trialdef.prestim(t)*hdr.Fs - 0.01*hdr.Fs  + cfg.photodelay(t)*hdr.Fs) >= 0
                
            trltmp(count,1) = samplecorr(x{t}(i)) - cfg.trialdef.prestim(t)*hdr.Fs - 0.01*hdr.Fs + cfg.photodelay(t)*hdr.Fs;
            
            k= [];
            k = (x{t}(i));
            while k < (length(samplecorr))
                if (valuetrigcorr(k+1) == 1024) 
                    trltmp(count,2) = samplecorr(k+1) + cfg.trialdef.poststim(t)*hdr.Fs - 0.01*hdr.Fs + cfg.photodelay(t)*hdr.Fs;
                    trltmp(count,4) = 1024;
                    break
                elseif (valuetrigcorr(k+1) == 32768) 
                    trltmp(count,2) = samplecorr(k+1) + cfg.trialdef.poststim(t)*hdr.Fs - 0.01*hdr.Fs + cfg.photodelay(t)*hdr.Fs;
                    trltmp(count,4) = 32768;
                    break
                else
                    k = k+1;
                end
            end
            
            trltmp(count,3) = t;
            count = count+1;
        else
        end
    end
    
    trl = [trl ;trltmp];
    
end

%% recode events with respect to responses
count = 1;
i = 1;
trlbis = [];
while i <= length(trl)
    if trl(i,4) == 1024 && ((trl(i,2) - trl(i,1)) < 5.7*hdr.Fs) && ((trl(i,2) - trl(i,1))  >0)
        trlbis(count,1:2) = trl(i,1:2);
        trlbis(count,3) = (trl(i,3)*2)-1;
        count = count + 1;
    elseif trl(i,4) == 32768 && ((trl(i,2) - trl(i,1)) < 5.7*hdr.Fs) && ((trl(i,2) - trl(i,1))  >0)
        trlbis(count,1:2) = trl(i,1:2);
        trlbis(count,3) = (trl(i,3)*2);
        count = count + 1;
    end
    i= i +1;
end

trlbisbis = [trlbis(:,3) trlbis(:,1) trlbis(:,2)];
trlbisbis = sortrows(trlbisbis);
trlbisbisbis  =[trlbisbis(:,2) trlbisbis(:,3) trlbisbis(:,1)];






