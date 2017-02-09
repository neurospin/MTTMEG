function tablestr = table2str(data,numcol)

%% convert statistial table in a table conataining strings for text file printing purpose

s = size(data);
s(2) = numcol;
% select just useful infos

for i = 1:s(1)
    for j = 1:s(2)
        l(i,j) = length(num2str(data{i,j}));
    end
end
lmax = max(l)

tmp = cell(1,s(1));
for i = 1:s(1)
    for j = 1:s(2)
        if length(num2str(data{i,j})) < lmax(j)
            sup = lmax(j) - length(num2str(data{i,j}));
            supstr = num2str(data{i,j});
            for k = 1:sup
                supstr = [supstr ' ' ];
            end
            tmp{i} = [tmp{i} ' ' supstr];
        else
            tmp{i} = [tmp{i} ' ' num2str(data{i,j})];
        end
    end
end

tablestr = tmp;

