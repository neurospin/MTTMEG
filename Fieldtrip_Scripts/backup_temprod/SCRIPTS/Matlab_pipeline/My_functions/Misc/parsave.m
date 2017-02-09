%% Parsave avoid transparency errors with parfor loops

function parsave(fname,x,y)
    save(fname,'x','y','-v7.3')
end