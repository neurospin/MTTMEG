function [x, y, w, h, a] = mysubplot(nraw,ncol,n)

col = mod(n-1,ncol)+1;
raw = floor((n-1)/ncol)+1;

if nraw <= 2
    x = (col-1)*(1/(ncol+1)) + col/((ncol+1)*(ncol+1));
    y = 1-((raw-1)/(nraw+1) + raw/((nraw+1)*(nraw+1)) + 1/(nraw+1));
    w = 1/(ncol+1);
    h = 1/(nraw+0.5);
    subplot('Position',[x y w h]);
    % disp([num2str(raw) ' ' num2str(col) ])
else
    x = (col-1)*(1/(ncol+1)) + col/((ncol+1)*(ncol+1));
    y = 1-((raw-1)/(nraw+1) + raw/((nraw+1)*(nraw+1)) + 1/(nraw+1));
    w = 1/(ncol+1);
    h = 1/(nraw+0.5);
    a = subplot('Position',[x y w h]);
    % disp([num2str(raw) ' ' num2str(col) ])
end


        