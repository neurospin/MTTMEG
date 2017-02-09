function NAMESLIST = get_filenames(FOLDER,varargin)

% get files list from the folder of interest
LIST = dir(FOLDER);

% get each file name
for i = 1:length(LIST)
    FILENAMES{i,1} = getfield(LIST(i,1),'name');
end

% for each argument, match the file names
for i = 1:length(varargin)
    
    for j = 1:length(LIST)
        tmp = strfind(FILENAMES{j,1},varargin{i});
        if isempty(tmp) ==1
            Files{i}(j,1) = 0;
        else
            Files{i}(j,1) = 1;
        end
    end
    [index{i},y]     = find(Files{i} == 1);
    
end

INDEX = index{1};
for i = 1:length(varargin)
    INDEX = intersect(INDEX,index{i});
end

NAMESLIST = FILENAMES(INDEX);
