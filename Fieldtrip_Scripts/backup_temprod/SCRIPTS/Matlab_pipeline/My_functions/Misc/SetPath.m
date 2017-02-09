function root = SetPath(tag)

if strcmp(tag,'Laptop') == 1
    
    root = 'C:\TEMPROD';
    
elseif strcmp(tag,'Network') == 1
    
    root = '/neurospin/meg/meg_tmp/temprod_Baptiste_2010';
    
end

