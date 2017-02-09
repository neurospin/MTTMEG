function [MPL,MPR,MAL,MAR,G1PL,G1PR,G1AL,G1AR,G2PL,G2PR,G2AL,G2AR] = APLRchannels

% MAGS

[A B] = xlsread('C:\TEMPROD\SCRIPTS\Layouts_fieldtrip/NM306mags_anterior_left.xls');
ChannelsLong = cell(1,length(A)); 
for a = 1:length(A)
    if A(a,1) < 1000
        MAL(1,a) = cellstr(['MEG0' num2str(A(a,1))]);
    else
        MAL(1,a) = cellstr(['MEG' num2str(A(a,1))]);
    end
end

[A B] = xlsread('C:\TEMPROD\SCRIPTS\Layouts_fieldtrip/NM306mags_posterior_left.xls');
ChannelsLong = cell(1,length(A)); 
for a = 1:length(A)
    if A(a,1) < 1000
        MPL(1,a) = cellstr(['MEG0' num2str(A(a,1))]);
    else
        MPL(1,a) = cellstr(['MEG' num2str(A(a,1))]);
    end
end

[A B] = xlsread('C:\TEMPROD\SCRIPTS\Layouts_fieldtrip/NM306mags_anterior_right.xls');
ChannelsLong = cell(1,length(A)); 
for a = 1:length(A)
    if A(a,1) < 1000
        MAR(1,a) = cellstr(['MEG0' num2str(A(a,1))]);
    else
        MAR(1,a) = cellstr(['MEG' num2str(A(a,1))]);
    end
end

[A B] = xlsread('C:\TEMPROD\SCRIPTS\Layouts_fieldtrip/NM306mags_posterior_right.xls');
ChannelsLong = cell(1,length(A)); 
for a = 1:length(A)
    if A(a,1) < 1000
        MPR(1,a) = cellstr(['MEG0' num2str(A(a,1))]);
    else
        MPR(1,a) = cellstr(['MEG' num2str(A(a,1))]);
    end
end

% G1

[A B] = xlsread('C:\TEMPROD\SCRIPTS\Layouts_fieldtrip/NM306gradlong_anterior_left.xls');
ChannelsLong = cell(1,length(A)); 
for a = 1:length(A)
    if A(a,1) < 1000
        G1AL(1,a) = cellstr(['MEG0' num2str(A(a,1))]);
    else
        G1AL(1,a) = cellstr(['MEG' num2str(A(a,1))]);
    end
end

[A B] = xlsread('C:\TEMPROD\SCRIPTS\Layouts_fieldtrip/NM306gradlong_posterior_left.xls');
ChannelsLong = cell(1,length(A)); 
for a = 1:length(A)
    if A(a,1) < 1000
        G1PL(1,a) = cellstr(['MEG0' num2str(A(a,1))]);
    else
        G1PL(1,a) = cellstr(['MEG' num2str(A(a,1))]);
    end
end

[A B] = xlsread('C:\TEMPROD\SCRIPTS\Layouts_fieldtrip/NM306gradlong_anterior_right.xls');
ChannelsLong = cell(1,length(A)); 
for a = 1:length(A)
    if A(a,1) < 1000
        G1AR(1,a) = cellstr(['MEG0' num2str(A(a,1))]);
    else
        G1AR(1,a) = cellstr(['MEG' num2str(A(a,1))]);
    end
end

[A B] = xlsread('C:\TEMPROD\SCRIPTS\Layouts_fieldtrip/NM306gradlong_posterior_right.xls');
ChannelsLong = cell(1,length(A)); 
for a = 1:length(A)
    if A(a,1) < 1000
        G1PR(1,a) = cellstr(['MEG0' num2str(A(a,1))]);
    else
        G1PR(1,a) = cellstr(['MEG' num2str(A(a,1))]);
    end
end

% G2

[A B] = xlsread('C:\TEMPROD\SCRIPTS\Layouts_fieldtrip/NM306GradLat_anterior_left.xls');
ChannelsLong = cell(1,length(A)); 
for a = 1:length(A)
    if A(a,1) < 1000
        G2AL(1,a) = cellstr(['MEG0' num2str(A(a,1))]);
    else
        G2AL(1,a) = cellstr(['MEG' num2str(A(a,1))]);
    end
end

[A B] = xlsread('C:\TEMPROD\SCRIPTS\Layouts_fieldtrip/NM306GradLat_posterior_left.xls');
ChannelsLong = cell(1,length(A)); 
for a = 1:length(A)
    if A(a,1) < 1000
        G2PL(1,a) = cellstr(['MEG0' num2str(A(a,1))]);
    else
        G2PL(1,a) = cellstr(['MEG' num2str(A(a,1))]);
    end
end

[A B] = xlsread('C:\TEMPROD\SCRIPTS\Layouts_fieldtrip/NM306GradLat_anterior_right.xls');
ChannelsLong = cell(1,length(A)); 
for a = 1:length(A)
    if A(a,1) < 1000
        G2AR(1,a) = cellstr(['MEG0' num2str(A(a,1))]);
    else
        G2AR(1,a) = cellstr(['MEG' num2str(A(a,1))]);
    end
end

[A B] = xlsread('C:\TEMPROD\SCRIPTS\Layouts_fieldtrip/NM306GradLat_posterior_right.xls');
ChannelsLong = cell(1,length(A)); 
for a = 1:length(A)
    if A(a,1) < 1000
        G2PR(1,a) = cellstr(['MEG0' num2str(A(a,1))]);
    else
        G2PR(1,a) = cellstr(['MEG' num2str(A(a,1))]);
    end
end
