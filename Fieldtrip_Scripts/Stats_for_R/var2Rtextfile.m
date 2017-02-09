function var2Rtextfile(file, varargin)
% var2Rtextfile(file, var1, var2, ...)
% write values of variables var1, var2 (etc...) in a text file that can be
% opened in R. The labels are the names of the variables.
%
% RQ: only works if variables are matrices or cell strings
% RQ2: if the variables do not have the same number of values, the missing
% values are replaced by 'NA' values in R.
%
% example:
% truc= 1:6;
% bidule= {'a','b','c','d','e','f'};
% chouette= [11,12;13,14];
% var2Rtextfile('example',truc, bidule, chouette);

if ~strcmp(file(end-3:end), '.txt')
    file= [file,'.txt'];
end

fid = fopen(file,'wt');

% Total number of data ?
Totlines= 0;

% First insert labels (i.e. names of variables)
for v= 1:length(varargin)
    fprintf(fid, ' %s', inputname(v+1));
    varargin{v}= varargin{v}(:);
    Totlines= max([Totlines, numel(varargin{v})]);
end
fprintf(fid, '\n'); % next line

% Now insert data as columns, line by line
for k= 1:Totlines
    for v= 1:length(varargin)
        if k<= numel(varargin{v})
            if isnumeric(varargin{v}(k))
                fprintf(fid, ' %s', num2str(varargin{v}(k)));
            else
                fprintf(fid, ' ''%s''', varargin{v}{k});
            end
        else
            fprintf(fid, ' NA');
        end
    end
    fprintf(fid, '\n');
   
end
fclose(fid);