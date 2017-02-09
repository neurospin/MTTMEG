function LISTFILES = get_filenames_MTMEG(NIP)

% get file from the stored response directory
List = dir('C:\MTT_MEG\psych');

for i = 1:length(List)
    ListFiles{i,1} = getfield(List(i,1),'name');
end

% get NIP corresponding files
for i = 1:length(List)
    tmp = strfind(ListFiles{i,1},NIP);
    if isempty(tmp) ==1
        FilesNIP(i,1) = 0;
    else
        FilesNIP(i,1) = 1;
    end
end
% get MEG-psycho corresponding files
for i = 1:length(List)
    tmp = strfind(ListFiles{i,1},'MentalTravelMeg');
    if isempty(tmp) ==1
        FilesMEG(i,1) = 0;
    else
        FilesMEG(i,1) = 1;
    end
end  
[ind_NIP,y]     = find(FilesNIP == 1);
[ind_MEG,y]     = find(FilesMEG == 1);

LISTFILES = ListFiles(intersect(ind_NIP,ind_MEG));
