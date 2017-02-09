function [ER_S,ER_T,RT_S,RT_T] = GET_ER_and_RT_from_fif(file)

%% test dataset
% file = '\\POIVRE\meg\meg_tmp\MTT_MEG_Baptiste\MEG\mb140004\raw_sss\run3_DG_trans_sss.fif';

%% get recording trigger value and corresponding samples
events = ft_read_event(file);
% hdr    = ft_read_header(file);

value  = [events(find(strcmp('STI101', {events.type}))).value]';
sample = [events(find(strcmp('STI101', {events.type}))).sample]';

%% remove responses trigger values

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
    elseif (value(i) >= 1024) && (value(i) < 32768)
        valuetrig(i) = value(i) - 1024;
    elseif (value(i) >= 32768)
        valuetrig(i) = value(i) - 32768;
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
    value(sampletoremove(i)) = [];
    
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
            (value(samplelist(2,i):(samplelist(2,i+1)-1))')' ...
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
            (value(samplelist(2,i):(samplelist(2,i+1)-1))')' ...
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
            (value(samplelist(2,i):(samplelist(2,i+1)-1))')' ...
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
            (value(samplelist(2,i):(samplelist(2,i+1)-1))')' ...
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
            (value(samplelist(2,i):(samplelist(2,i+1)-1))')' ...
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
%%%%%%%%%%%% ONLY FOR PILOT SUBJECT (WITH A FEW ERRONEOUS TRIGGERS %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isempty(strfind(file(17:24),'sd130343')) == 0 || ...
        isempty(strfind(file(17:24),'cb130477'))
    
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
valuecorr = [];
samplecorr    = [];
for i = 1:length(MiniBlock.PrePar)
    valuecorr = [valuecorr; MiniBlock.PrePar{1,i}(:,2)];
    samplecorr = [samplecorr; MiniBlock.PrePar{1,i}(:,1)];
end
for i = 1:length(MiniBlock.PasPar)
    valuecorr = [valuecorr; MiniBlock.PasPar{1,i}(:,2)];
    samplecorr = [samplecorr; MiniBlock.PasPar{1,i}(:,1)];
end
for i = 1:length(MiniBlock.FutPar)
    valuecorr = [valuecorr; MiniBlock.FutPar{1,i}(:,2)];
    samplecorr = [samplecorr; MiniBlock.FutPar{1,i}(:,1)];
end
for i = 1:length(MiniBlock.PreW)
    valuecorr = [valuecorr; MiniBlock.PreW{1,i}(:,2)];
    samplecorr = [samplecorr; MiniBlock.PreW{1,i}(:,1)];
end
for i = 1:length(MiniBlock.PreE)
    valuecorr = [valuecorr; MiniBlock.PreE{1,i}(:,2)];
    samplecorr = [samplecorr; MiniBlock.PreE{1,i}(:,1)];
end

%% Get response trigger value score for each block/ref/whathever
PrePar_Tmat = ones(6,6)*NaN;
PrePar_Smat = ones(6,6)*NaN;
eventcode = [(37:42)' (43:48)' (49:54)' (55:60)' (61:66)' (67:72)'];

% select responses for TJ & SJ in PrePar context
for i = 1:length(MiniBlock.PrePar)
    
    ind6 = [];
    ind7 = [];
    ind6 = find(MiniBlock.PrePar{1,i}(:,2) == 6);
    ind7 = find(MiniBlock.PrePar{1,i}(:,2) == 7);
    
    if isempty(ind6) == 0
        evcode6 = [];
        for k = 1:length(ind6)
            evcode6 = find(eventcode == MiniBlock.PrePar{1,i}(ind6(k)+1,2));
            evcode6 = find(eventcode == MiniBlock.PrePar{1,i}(ind6(k)+1,2));
            if ind6(k)+3 <= length(MiniBlock.PrePar{1,i});
                PrePar_Tmat(evcode6) = MiniBlock.PrePar{1,i}(ind6(k)+3,2);
            else
                PrePar_Tmat(evcode6) = NaN;
            end
        end
    end
    
    if isempty(ind7) == 0
        evcode7 = [];
        for k = 1:length(ind7)
            evcode7 = find(eventcode == MiniBlock.PrePar{1,i}(ind7(k)+1,2));
            evcode7 = find(eventcode == MiniBlock.PrePar{1,i}(ind7(k)+1,2));
            if ind7(k)+3 <= length(MiniBlock.PrePar{1,i});
                PrePar_Smat(evcode7) = MiniBlock.PrePar{1,i}(ind7(k)+3,2);
            else
                PrePar_Smat(evcode7) = NaN;
            end
        end
    end
    
end

PasPar_Tmat = ones(6,6)*NaN;
PasPar_Smat = ones(6,6)*NaN;
eventcode = [(37:42)' (43:48)' (49:54)' (55:60)' (61:66)' (67:72)'];

% select responses for TJ & SJ in PasPar context
for i = 1:length(MiniBlock.PasPar)
    
    ind8 = [];
    ind9 = [];
    ind8 = find(MiniBlock.PasPar{1,i}(:,2) == 8);
    ind9 = find(MiniBlock.PasPar{1,i}(:,2) == 9);
    
    if isempty(ind8) == 0
        evcode8 = [];
        for k = 1:length(ind8)
            evcode8 = find(eventcode == MiniBlock.PasPar{1,i}(ind8(k)+1,2));
            evcode8 = find(eventcode == MiniBlock.PasPar{1,i}(ind8(k)+1,2));
            if ind8(k)+3 <= length(MiniBlock.PasPar{1,i});
                PasPar_Tmat(evcode8) = MiniBlock.PasPar{1,i}(ind8(k)+3,2);
            else
                PasPar_Tmat(evcode8) = NaN;
            end
        end
    end
    
    if isempty(ind9) == 0
        evcode9 = [];
        for k = 1:length(ind9)
            evcode9 = find(eventcode == MiniBlock.PasPar{1,i}(ind9(k)+1,2));
            if ind9(k)+3 <= length(MiniBlock.PasPar{1,i});
                PasPar_Smat(evcode9) = MiniBlock.PasPar{1,i}(ind9(k)+3,2);
            else
                PasPar_Smat(evcode9) = NaN;
            end
        end
    end
    
end

FutPar_Tmat = ones(6,6)*NaN;
FutPar_Smat = ones(6,6)*NaN;
eventcode = [(37:42)' (43:48)' (49:54)' (55:60)' (61:66)' (67:72)'];

% select responses for TJ & SJ in FutPar context
for i = 1:length(MiniBlock.FutPar)
    
    ind10 = [];
    ind11 = [];
    ind10 = find(MiniBlock.FutPar{1,i}(:,2) == 10);
    ind11 = find(MiniBlock.FutPar{1,i}(:,2) == 11);
    
    if isempty(ind10) == 0
        evcode10 = [];
        for k = 1:length(ind10)
            evcode10 = find(eventcode == MiniBlock.FutPar{1,i}(ind10(k)+1,2));
            evcode10 = find(eventcode == MiniBlock.FutPar{1,i}(ind10(k)+1,2));
            if ind10(k)+3 <= length(MiniBlock.FutPar{1,i});
                FutPar_Tmat(evcode10) = MiniBlock.FutPar{1,i}(ind10(k)+3,2);
            else
                FutPar_Tmat(evcode10) = NaN;
            end
        end
    end
    
    if isempty(ind11) == 0
        evcode11 = [];
        for k = 1:length(ind11)
            evcode11 = find(eventcode == MiniBlock.FutPar{1,i}(ind11(k)+1,2));
            evcode11 = find(eventcode == MiniBlock.FutPar{1,i}(ind11(k)+1,2));
            if ind11(k)+3 <= length(MiniBlock.FutPar{1,i});
                FutPar_Smat(evcode11) = MiniBlock.FutPar{1,i}(ind11(k)+3,2);
            else
                FutPar_Smat(evcode11) = NaN;
            end
        end
    end
    
end

PreW_Tmat = ones(6,6)*NaN;
PreW_Smat = ones(6,6)*NaN;
eventcode = [(37:42)' (43:48)' (49:54)' (55:60)' (61:66)' (67:72)'];

% select responses for TJ & SJ in PreW context
for i = 1:length(MiniBlock.PreW)
    
    ind12 = [];
    ind13 = [];
    ind12 = find(MiniBlock.PreW{1,i}(:,2) == 12);
    ind13 = find(MiniBlock.PreW{1,i}(:,2) == 13);
    
    if isempty(ind12) == 0
        evcode12 = [];
        for k = 1:length(ind12)
            evcode12 = find(eventcode == MiniBlock.PreW{1,i}(ind12(k)+1,2));
            evcode12 = find(eventcode == MiniBlock.PreW{1,i}(ind12(k)+1,2));
            if ind12(k)+3 <= length(MiniBlock.PreW{1,i});
                PreW_Tmat(evcode12) = MiniBlock.PreW{1,i}(ind12(k)+3,2);
            else
                PreW_Tmat(evcode12) = NaN;
            end
        end
    end
    
    if isempty(ind13) == 0
        evcode13 = [];
        for k = 1:length(ind13)
            evcode13 = find(eventcode == MiniBlock.PreW{1,i}(ind13(k)+1,2));
            evcode13 = find(eventcode == MiniBlock.PreW{1,i}(ind13(k)+1,2));
            if ind13(k)+3 <= length(MiniBlock.PreW{1,i});
                PreW_Smat(evcode13) = MiniBlock.PreW{1,i}(ind13(k)+3,2);
            else
                PreW_Smat(evcode13) = NaN;
            end
        end
    end
    
end


PreE_Tmat = ones(6,6)*NaN;
PreE_Smat = ones(6,6)*NaN;
eventcode = [(37:42)' (43:48)' (49:54)' (55:60)' (61:66)' (67:72)'];

% select responses for TJ & SJ in PreE context
for i = 1:length(MiniBlock.PreE)
    
    ind14 = [];
    ind15 = [];
    ind14 = find(MiniBlock.PreE{1,i}(:,2) == 14);
    ind15 = find(MiniBlock.PreE{1,i}(:,2) == 15);
    
    if isempty(ind14) == 0
        evcode14 = [];
        for k = 1:length(ind14)
            evcode14 = find(eventcode == MiniBlock.PreE{1,i}(ind14(k)+1,2));
            evcode14 = find(eventcode == MiniBlock.PreE{1,i}(ind14(k)+1,2));
            if ind14(k)+3 <= length(MiniBlock.PreE{1,i});
                PreE_Tmat(evcode14) = MiniBlock.PreE{1,i}(ind14(k)+3,2);
            else
                PreE_Tmat(evcode14) = NaN;
            end
        end
    end
    
    if isempty(ind15) == 0
        evcode15 = [];
        for k = 1:length(ind15)
            evcode15 = find(eventcode == MiniBlock.PreE{1,i}(ind15(k)+1,2));
            evcode15 = find(eventcode == MiniBlock.PreE{1,i}(ind15(k)+1,2));
            if ind15(k)+3 <= length(MiniBlock.PreE{1,i});
                PreE_Smat(evcode15) = MiniBlock.PreE{1,i}(ind15(k)+3,2);
            else
                PreE_Smat(evcode15) = NaN;
            end
        end
    end
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% compute error matrix for each ref
if isempty(strfind(file,'_GD')) == 0
    
    PrePar_S_Template = [repmat(2^10,6,3) repmat(2^15,6,3)];
    PasPar_S_Template = [[repmat(2^10,4,3) repmat(2^15,4,3)] ; NaN(2,6)];
    FutPar_S_Template = [NaN(2,6) ; [repmat(2^10,4,3) repmat(2^15,4,3)]];
    PreW_S_Template   = [[repmat(2^10,6,2) repmat(2^15,6,2)] NaN(6,2)];
    PreE_S_Template   = [NaN(6,2) [repmat(2^10,6,2) repmat(2^15,6,2)]];
    
    PrePar_T_Template = [repmat(2^10,3,6) ;repmat(2^15,3,6)];
    PasPar_T_Template = [[repmat(2^10,2,6) ;repmat(2^15,2,6)]; NaN(2,6)];
    FutPar_T_Template = [NaN(2,6); [repmat(2^10,2,6) ;repmat(2^15,2,6)]];
    PreW_T_Template   = [[repmat(2^10,3,4) ;repmat(2^15,3,4)] NaN(6,2)];
    PreE_T_Template   = [ NaN(6,2) [repmat(2^10,3,4) ;repmat(2^15,3,4)]];
    
elseif isempty(strfind(file,'_DG')) == 0
    
    PrePar_S_Template = [repmat(2^15,6,3) repmat(2^10,6,3)];
    PasPar_S_Template = [[repmat(2^15,4,3) repmat(2^10,4,3)] ; NaN(2,6)];
    FutPar_S_Template = [NaN(2,6) ; [repmat(2^15,4,3) repmat(2^10,4,3)]];
    PreW_S_Template   = [[repmat(2^15,6,2) repmat(2^10,6,2)] NaN(6,2)];
    PreE_S_Template   = [NaN(6,2) [repmat(2^15,6,2) repmat(2^10,6,2)]];
    
    PrePar_T_Template = [repmat(2^15,3,6) ;repmat(2^10,3,6)];
    PasPar_T_Template = [[repmat(2^15,2,6) ;repmat(2^10,2,6)]; NaN(2,6)];
    FutPar_T_Template = [NaN(2,6); [repmat(2^15,2,6) ;repmat(2^10,2,6)]];
    PreW_T_Template   = [[repmat(2^15,3,4) ;repmat(2^10,3,4)] NaN(6,2)];
    PreE_T_Template   = [ NaN(6,2) [repmat(2^15,3,4) ;repmat(2^10,3,4)]];
    
end


ER_S.PrePar      = (PrePar_Smat ~= PrePar_S_Template);
ER_S.PasPar      = (PasPar_Smat ~= PasPar_S_Template).*[[repmat(1,4,3) repmat(1,4,3)] ; NaN(2,6)];
ER_S.FutPar      = (FutPar_Smat ~= FutPar_S_Template).*[NaN(2,6) ; [repmat(1,4,3) repmat(1,4,3)]];
ER_S.PreW        = (PreW_Smat ~= PreW_S_Template).*[[repmat(1,6,2) repmat(1,6,2)] NaN(6,2)];
ER_S.PreE        = (PreE_Smat ~= PreE_S_Template).*[NaN(6,2) [repmat(1,6,2) repmat(1,6,2)]];

ER_T.PrePar_T    = (PrePar_Tmat ~= PrePar_T_Template);
ER_T.PasPar_T    = (PasPar_Tmat ~= PasPar_T_Template).*[[repmat(1,2,6) ;repmat(1,2,6)]; NaN(2,6)];
ER_T.FutPar_T    = (FutPar_Tmat ~= FutPar_T_Template).*[NaN(2,6); [repmat(1,2,6) ;repmat(1,2,6)]];
ER_T.PreW_T      = (PreW_Tmat ~= PreW_T_Template).*[[repmat(1,3,4) ;repmat(1,3,4)] NaN(6,2)];
ER_T.PreE_T      = (PreE_Tmat ~= PreE_T_Template).*[ NaN(6,2) [repmat(1,3,4) ;repmat(1,3,4)]];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
BLOCKOLOLOL{1} = MiniBlock.PrePar;
BLOCKOLOLOL{2} = MiniBlock.PasPar;
BLOCKOLOLOL{3} = MiniBlock.FutPar;
BLOCKOLOLOL{4} = MiniBlock.PreW;
BLOCKOLOLOL{5} = MiniBlock.PreE;

RT_Time{1}  = ones(6,6)*NaN; RT_Time{2}  = ones(6,6)*NaN; RT_Time{3}  = ones(6,6)*NaN;
RT_Time{4}  = ones(6,6)*NaN; RT_Time{5}  = ones(6,6)*NaN;
RT_Space{1} = ones(6,6)*NaN; RT_Space{2} = ones(6,6)*NaN; RT_Space{3} = ones(6,6)*NaN;
RT_Space{4} = ones(6,6)*NaN; RT_Space{5} = ones(6,6)*NaN;

distcode    = [16:35 ((16:35)+(ones(1,length(16:35))*1024)) ((16:35)+(ones(1,length(16:35))*32768)) ((16:35)+(ones(1,length(16:35))*33792))];
eventcode   = [37:72 ((37:72)+(ones(1,length(37:72))*1024)) ((37:72)+(ones(1,length(37:72))*32768)) ((37:72)+(ones(1,length(37:72))*33792))];
respcode    = [1024 32768];
refcode     = [6 8 10 12 14 ; 7 9 11 13 15 ];
refcodefull = [6:15 ((6:15)+(ones(1,length(6:15))*1024)) ((6:15)+(ones(1,length(6:15))*32768))];

for i = 1:length(BLOCKOLOLOL)
    for n = 1:length(BLOCKOLOLOL{i})
        j = 2;
        while j+3 <= length(BLOCKOLOLOL{i}{1,n})
            if isempty(intersect(BLOCKOLOLOL{i}{1,n}(j,2),[eventcode(:); distcode(:); refcodefull(:)])) == 1
                j = j+1;
            elseif (BLOCKOLOLOL{i}{1,n}(j,2) == refcode(1,i)) || (BLOCKOLOLOL{i}{1,n}(j,2) == refcode(1,i)+1024) || (BLOCKOLOLOL{i}{1,n}(j,2) == refcode(1,i)+32768) || (BLOCKOLOLOL{i}{1,n}(j,2) == refcode(1,i)+33792)
                j = j+1;
                if j == length(BLOCKOLOLOL{i}{1,n})
                    continue
                end
                if isempty(intersect(BLOCKOLOLOL{i}{1,n}(j,2),respcode(:))) == 0
                    BLOCKOLOLOL{i}{1,n}(j,:) = [];
                end
                if BLOCKOLOLOL{i}{1,n}(j,2) == sum(respcode)
                    j = j+1;
                end
                if isempty(intersect(BLOCKOLOLOL{i}{1,n}(j,2),eventcode(:))) == 0
                    j = j+1;
                    if j == length(BLOCKOLOLOL{i}{1,n})
                        continue
                    end
                    if isempty(intersect(BLOCKOLOLOL{i}{1,n}(j,2),respcode(:))) == 0
                        BLOCKOLOLOL{i}{1,n}(j,:) = [];
                    end
                    if isempty(intersect(BLOCKOLOLOL{i}{1,n}(j,2),distcode(:))) == 0
                        j = j+1;
                    end
                    if BLOCKOLOLOL{i}{1,n}(j,2) == sum(respcode)
                        j = j+1;
                    end
                    if isempty(intersect(BLOCKOLOLOL{i}{1,n}(j,2),respcode(:))) == 0
                        RT_Time{i}(BLOCKOLOLOL{i}{1,n}(j-2,2)-36) = BLOCKOLOLOL{i}{1,n}(j-1,3);
                        j = j+1;
                    else
                        j = j;
                    end
                end
            elseif (BLOCKOLOLOL{i}{1,n}(j,2) == refcode(2,i)) || (BLOCKOLOLOL{i}{1,n}(j,2) == refcode(2,i)+1024) || (BLOCKOLOLOL{i}{1,n}(j,2) == refcode(2,i)+32768) || (BLOCKOLOLOL{i}{1,n}(j,2) == refcode(2,i)+33792)
                j = j+1;
                if j == length(BLOCKOLOLOL{i}{1,n})
                    continue
                end
                if isempty(intersect(BLOCKOLOLOL{i}{1,n}(j,2),respcode(:))) == 0
                    BLOCKOLOLOL{i}{1,n}(j,:) = [];
                end
                if BLOCKOLOLOL{i}{1,n}(j,2) == sum(respcode)
                    j = j+1;
                end
                if isempty(intersect(BLOCKOLOLOL{i}{1,n}(j,2),eventcode(:))) == 0
                    j = j+1;
                    if j == length(BLOCKOLOLOL{i}{1,n})
                        continue
                    end
                    if isempty(intersect(BLOCKOLOLOL{i}{1,n}(j,2),respcode(:))) == 0
                        BLOCKOLOLOL{i}{1,n}(j,:) = [];
                    end
                    if isempty(intersect(BLOCKOLOLOL{i}{1,n}(j,2),distcode(:))) == 0
                        j = j+1;
                    end
                    if BLOCKOLOLOL{i}{1,n}(j,2) == sum(respcode)
                        j = j+1;
                    end
                    if isempty(intersect(BLOCKOLOLOL{i}{1,n}(j,2),respcode(:))) == 0
                        if BLOCKOLOLOL{i}{1,n}(j-2,2)> 1024 && BLOCKOLOLOL{i}{1,n}(j-2,2)< 32768
                            RT_Space{i}(BLOCKOLOLOL{i}{1,n}(j-2,2)-1060) = BLOCKOLOLOL{i}{1,n}(j-1,3);
                        elseif  BLOCKOLOLOL{i}{1,n}(j-2,2)> 32768
                            RT_Space{i}(BLOCKOLOLOL{i}{1,n}(j-2,2)-32804) = BLOCKOLOLOL{i}{1,n}(j-1,3);
                        else
                            RT_Space{i}(BLOCKOLOLOL{i}{1,n}(j-2,2)-36) = BLOCKOLOLOL{i}{1,n}(j-1,3);
                        end
                        j = j+1;
                    else
                        j = j;
                    end
                end
            elseif (BLOCKOLOLOL{i}{1,n}(j,2) == 1024) || (BLOCKOLOLOL{i}{1,n}(j,2) == 32768) || (BLOCKOLOLOL{i}{1,n}(j,2) == (1024+32768))
                j = j +1;
            elseif isempty(intersect(BLOCKOLOLOL{i}{1,n}(j,2),eventcode(:))) == 0
                j = j+1;
                if j == length(BLOCKOLOLOL{i}{1,n})
                    continue
                end
                if isempty(intersect(BLOCKOLOLOL{i}{1,n}(j,2),respcode(:))) == 0
                    BLOCKOLOLOL{i}{1,n}(j,:) = [];
                end
                if isempty(intersect(BLOCKOLOLOL{i}{1,n}(j,2),distcode(:))) == 0
                    j = j+1;
                end
                if BLOCKOLOLOL{i}{1,n}(j,2) == sum(respcode)
                    j = j+1;
                end
                if isempty(intersect(BLOCKOLOLOL{i}{1,n}(j,2),respcode(:))) == 0
                    if BLOCKOLOLOL{i}{1,n}(j-2,2)> 1024 && BLOCKOLOLOL{i}{1,n}(j-2,2)< 32768
                        RT_Space{i}(BLOCKOLOLOL{i}{1,n}(j-2,2)-1060) = BLOCKOLOLOL{i}{1,n}(j-1,3);
                    elseif  BLOCKOLOLOL{i}{1,n}(j-2,2)> 32768
                        RT_Space{i}(BLOCKOLOLOL{i}{1,n}(j-2,2)-32804) = BLOCKOLOLOL{i}{1,n}(j-1,3);
                    else
                        RT_Space{i}(BLOCKOLOLOL{i}{1,n}(j-2,2)-36) = BLOCKOLOLOL{i}{1,n}(j-1,3);
                    end
                    j = j+1;
                else
                    j = j;
                end
            end
        end
    end
end

% to prevent some known bugs

RT_T.PrePar    = RT_Time{1}  - ones(6,6)*900;
RT_T.PasPar   = RT_Time{2}  - ones(6,6)*900;
RT_T.FutPar    = RT_Time{3}  - ones(6,6)*900;
RT_T.PreW      = RT_Time{4}  - ones(6,6)*900;
RT_T.PreE       = RT_Time{5}  - ones(6,6)*900;
RT_S.PrePar   = RT_Space{1} - ones(6,6)*900;
RT_S.PasPar  = RT_Space{2} - ones(6,6)*900;
RT_S.FutPar   = RT_Space{3} - ones(6,6)*900;
RT_S.PreW     = RT_Space{4} - ones(6,6)*900;
RT_S.PreE      = RT_Space{5} - ones(6,6)*900;

% a = RT_Time{5}  ;
% b = [a(1:6) ; a(7:12) ; a(13:18) ; a(19:23) ; a(24:30) ; a(31:36) ];

