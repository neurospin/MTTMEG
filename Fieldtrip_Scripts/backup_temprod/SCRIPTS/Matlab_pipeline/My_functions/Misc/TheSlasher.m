function String = TheSlasher(input,OS)

String = input;

if (strcmp(OS,'windows') == 1) || (strcmp(OS,'Laptop') == 1)
    for i = 1:length(String)
        if strcmp(String(i),'/') == 1
            String(i) = '\';
        end
    end
elseif (strcmp(OS,'linux') == 1) || (strcmp(OS,'Network') == 1)
    for i = 1:length(String)
        if strcmp(String(i),'\') == 1
            String(i) = '/';
        end
    end
end

