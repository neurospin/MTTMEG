function [Grads1,Grads2,Mags] = grads_for_layouts(tag)

% set root
root = SetPath(tag);

% Prepare channels layouts for plots
[A B] = xlsread([root '/SCRIPTS/Layouts_fieldtrip/NM306gradlow.xls']);
Grads1 = cell(1,102); 
for a = 1:102
    if A(a,1) < 1000
        Grads1(1,a) = cellstr(['MEG0' num2str(A(a,1))]);
    else
        Grads1(1,a) = cellstr(['MEG' num2str(A(a,1))]);
    end
end

[A B] = xlsread([root '/SCRIPTS/Layouts_fieldtrip/NM306mags.xls']);
Mags = cell(1,102); 
for a = 1:102
    if A(a,1) < 1000
        Mags(1,a) = cellstr(['MEG0' num2str(A(a,1))]);
    else
        Mags(1,a) = cellstr(['MEG' num2str(A(a,1))]);
    end
end

[A B] = xlsread([root '/SCRIPTS/Layouts_fieldtrip/NM306GradLat.xls']);
Grads2 = cell(1,102); 
for a = 1:102
    if A(a,1) < 1000
        Grads2(1,a) = cellstr(['MEG0' num2str(A(a,1))]);
    else
        Grads2(1,a) = cellstr(['MEG' num2str(A(a,1))]);
    end
end