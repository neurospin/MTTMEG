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

[x7,y7]   = find(valuetrigcorr == 7);
[x9,y9]   = find(valuetrigcorr == 9);
[x11,y11] = find(valuetrigcorr == 11);
[x13,y13] = find(valuetrigcorr == 13);
[x15,y15] = find(valuetrigcorr == 15);

x         = [x15 ];
y         = [y15 ];

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


% %% build matrix B with sample values, trigger value and event duration values
% %(to rescue lost triggers)
% tmp1 = sample;
% tmp2 = [sample(2:end); 0];
% tmp3 = tmp2 - tmp1;
% 
% B = [sample valuetrig' tmp3];
% B(end,:) = [];
% 
% lim = ceil(length(sample)/100);
% len = size(B,1);
% B((len+1):(lim*100),:) = NaN;
% 
% 
% %% rescue lost DIM triggers on the basis of REF trigger latency
% % load psychophysic data saved during acquisition (independently of MEG)
% PSYCH = load(cfg.psychinfo);
% 
% % get REF event indexes in the recording based on durations
% a = 1;
% indoI1 = [];
% for i = 1:len
%     if ((B(i,3) == 2685) || (B(i,3) == 2684) || (B(i,3) == 2686)) &&...
%         (B(i,2) == 1 || B(i,2) == 3 || B(i,2) == 4 || B(i,2) == 5 || B(i,2) == 6);
%         indoI1(a) = i ;
%         a = a + 1;
%     end
% end
% 
% % get DIM event indexes in the recording based on durations
% a = 1;
% indoI2 = [];
% for i = 1:len
%     if ((B(i,3) == 1014) || (B(i,3) == 1015) || (B(i,3) == 1016)) && ...
%         (B(i,2) == 1 || B(i,2) == 2)   
%         indoI2(a) = i;
%         a = a + 1;
%     end
% end
% 
% % get couple DIM*REF event indexes in the recording based on durations
% indOk = [];
% indOk = intersect((indoI1 - ones(1,length(indoI1))),indoI2);
% 
% % Rescue DIM events based on REF events durations
% diffoI1 = [setdiff(indoI1,indoI2+1) NaN];
% a2  = 1;
% a   = 1;
% b   = 1;
% B2  = [];
% while a < lim*100 
%     if a == diffoI1(b)
%         B2(a2,:) = [(B(a,1)-1015) 400 1015];
%         B2(a2+1,:) = B(a,:);
%         B2(a2-1,:) = B(a-1,:) - [1015 0 1015];
%         a2 = a2+2;
%         a = a+1;
%         b = b+1;
%     elseif a ~= diffoI1(b)
%         B2(a2,:) = B(a,:);
%         a2 = a2+1;
%         a = a+1;
%     end
% end
% 
% %% rescue lost REF triggers on the basis of DIM trigger latency
% % get REF event indexes in the recording based on durations
% a = 1;
% indoI1 = [];
% for i = 1:len
%     if ((B2(i,3) == 2685) || (B2(i,3) == 2684) || (B2(i,3) == 2686)) &&...
%         (B2(i,2) == 1 || B2(i,2) == 3 || B2(i,2) == 4 || B2(i,2) == 5 || B2(i,2) == 6);
%         indoI1(a) = i ;
%         a = a + 1;
%     end
% end
% 
% % get DIM event indexes in the recording based on durations
% a = 1;
% indoI2 = [];
% for i = 1:len
%     if ((B2(i,3) == 1014) || (B2(i,3) == 1015) || (B2(i,3) == 1016)) && ...
%         (B2(i,2) == 1 || B2(i,2) == 2)   
%         indoI2(a) = i;
%         a = a + 1;
%     end
% end
% 
% % get couple DIM*REF event indexes in the recording based on durations
% indOk = [];
% indOk = intersect((indoI1 - ones(1,length(indoI1))),indoI2);
% 
% % Rescue REF events based on DIM events durations
% diffoI2 = [setdiff(indoI2,indOk) NaN];
% a3  = 1;
% a2  = 1;
% b   = 1;
% B3  = [];
% while a2 < lim*100 
%     if a2 == diffoI2(b)
%         B3(a3,:) = B2(a2,:);
%         B3(a3+1,:) = [B2(a2+1,1) B2(a2+1,2) 2685];
%         B3(a3+2,:) = [(B2(a2,1) + 1015 + 2685) 500 (B2(a2+1,3) - 2685)];
%         a3 = a3+3;
%         a2 = a2+2;
%         b = b+1;
%     elseif a2 ~= diffoI2(b)
%         B3(a3,:) = B2(a2,:);
%         a3 = a3+1;
%         a2 = a2+1;
%     end
% end
% 
% 
% %% plot rescued triggers
% % get REF event indexes in the recording based on durations
% a = 1;
% indoI1 = [];
% for i = 1:len
%     if ((B3(i,3) == 2685) || (B3(i,3) == 2684) || (B3(i,3) == 2686));
%         indoI1(a) = i ;
%         a = a + 1;
%     end
% end
% 
% % get DIM event indexes in the recording based on durations
% a = 1;
% indoI2 = [];
% for i = 1:len
%     if ((B3(i,3) == 1014) || (B3(i,3) == 1015) || (B3(i,3) == 1016));
%         indoI2(a) = i;
%         a = a + 1;
%     end
% end
% 
% % plot event durations with event of interest
% for i = 1:lim
%     plot(B3(1:size(B3,1),1),B3(1:size(B3,1),3),'color','k','marker','o');
% end
% hold on
% for i = 1:length(indoI1)
%     plot(B3(indoI1(i),1),B3(indoI1(i),3),'marker','o','color','r','linewidth',3)
%     hold on
% end
% for i = 1:length(indoI2)
%     plot(B3(indoI2(i),1),B3(indoI2(i),3),'marker','o','color','b','linewidth',3)
%     hold on
% end
% line([sample(1) sample(len)],[2685 2685],'linestyle','--'); hold on;
% line([sample(1) sample(len)],[1015 1015],'linestyle','--'); hold on;
% axis([sample(1) sample(len) 0 6000])  
%  
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% %%%%%%%%%%%% plot theoritical trigger structure %%%%%%%%%%%%%%%%%%%%%%%%
% Bth = [0 0 0];
% sampleth = 0;
% for i = 1:36
%     tmp = [];
%     tmp(1,:)  = [sampleth PSYCH.TriggerDim(i) 1015];
%     sampleth  = sampleth + 1015;
%     tmp(2,:)  = [sampleth PSYCH.TriggerRef(i) 2685];
%     sampleth  = sampleth + 2685;
%     tmp(3,:)  = [sampleth PSYCH.TriggerEventsPACK{i}(1) PSYCH.RT{i}(1)*1000];
%     sampleth  = sampleth + PSYCH.RT{i}(1);
%     tmp(4,:)  = [sampleth 0 525];
%     sampleth  = sampleth + 525;
%     tmp(5,:)  = [sampleth PSYCH.TriggerEventsPACK{i}(2) PSYCH.RT{i}(2)*1000];
%     sampleth  = sampleth + PSYCH.RT{i}(2);
%     tmp(6,:)  = [sampleth 0 525];
%     sampleth  = sampleth + 525;
%     tmp(7,:)  = [sampleth PSYCH.TriggerEventsPACK{i}(3) PSYCH.RT{i}(3)*1000];
%     sampleth  = sampleth + PSYCH.RT{i}(3);
%     tmp(8,:)  = [sampleth 0 525];
%     sampleth  = sampleth + 525;
%     tmp(9,:)  = [sampleth PSYCH.TriggerEventsPACK{i}(4) PSYCH.RT{i}(4)*1000];
%     sampleth  = sampleth + PSYCH.RT{i}(4);
%     tmp(10,:) = [sampleth 0 525];
%     sampleth  = sampleth + 525;
%     Bth = [Bth ; tmp];
% end
% 
% tmpb32 = (B3(:,2,:) == 2);
% tmpb31 = (B3(:,2,:) == 1);
% tmpb   = tmpb32+tmpb31;
% f = find(tmpb == 1);
% 
% figure
% subplot(2,1,1)
% plot(Bth(:,1),Bth(:,2));title('theoritical event trigger succession'); ylabel('trigger value');
% axis([Bth(1,2) Bth(end,1) 0 256])
% subplot(2,1,2)
% plot(B3(:,1),B3(:,2));title('theoritical event trigger succession'); ylabel('trigger value');
% axis([B3(f(1),1) nanmax(B3(:,1)) 0 256])
% 
% figure
% subplot(2,1,1)
% plot(Bth(:,1),Bth(:,3));title('theoritical event successive durations'); ylabel('event duration (ms)');
% axis([Bth(1,1) Bth(end,1) 0 5000])
% subplot(2,1,2)
% plot(B3(:,1),B3(:,3));title('real event successive durations'); ylabel('event duration (ms)');
% axis([B3(f(1),1) nanmax(B3(:,1)) 0 5000])
% 
% 
% %% define rescued trl
% trl = [];
% 
% a =  1;
% for i = 1:size(B3,1)
%     if B3(i,2) == 1 && (B3(i,3) == 1015 || B3(i,3) == 1014 || B3(i,3) == 1016)
%         trl(a,1) = B3(i,1) - cfg.trialdef.prestim*hdr.Fs + cfg.photodelay;
%         trl(a,2) = B3(i,1) + cfg.trialdef.poststim*hdr.Fs + cfg.photodelay;
%         trl(a,3) = 0;
%         a = a+1;
%     end
% end
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % subplot(2,1,1)
% % plot(ones(length(indth),1).*indth)
% % subplot(2,1,2)
% % plot(ones(length(indrecord),1).*indrecord)
% 
% 
% 
% 
% 
% 
% 
