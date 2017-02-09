function MiniBlock = mtt_recodetrig(MiniBlock,EvcodeTimeLeft,EvcodeTimeRight,EvcodeSpaceLeft,EvcodeSpaceRight,DATES,LONGS)

EVENT = reshape(37:72,6,6);

MiniBlock(:,4) = 0;
MiniBlock(:,5) = 0;
MiniBlock(:,6) = 0;

respcode  = [1024 32768 33792];
qtcode     = [6:15];
qtcode     = [qtcode (ones(1,10)*1024 +qtcode) (ones(1,10)*32768 +qtcode) (ones(1,10)*33792 +qtcode)];
qtTcode   = [6:2:15];
qtTcode   = [qtTcode (ones(1,5)*1024 +qtTcode) (ones(1,5)*32768 +qtTcode) (ones(1,5)*33792 +qtTcode)];
qtScode   = [7:2:15];
qtScode   = [qtScode (ones(1,5)*1024 +qtScode) (ones(1,5)*32768 +qtScode) (ones(1,5)*33792 +qtScode)];
evcode     = [37:72];
evcode     = [evcode (ones(1,36)*1024 +evcode) (ones(1,36)*32768 +evcode) (ones(1,36)*33792 +evcode)];
distcode   = [16:35];
distcode   = [distcode (ones(1,20)*1024 +distcode) (ones(1,20)*32768 +distcode) (ones(1,20)*33792 +distcode)];

% case 1: check if the miniblock trigger and recode
for k = 1:5
    if isempty(intersect(MiniBlock(1,2),k)) == 0
        [x,y] = find(MiniBlock(:,2) == k);
        MiniBlock(x,4) = k;
    end
end

for k = qtcode
    if isempty(intersect(MiniBlock(:,2),k)) == 0
        [x,y] = find(MiniBlock(:,2) == k);
        for xi = 1:length(x)
            MiniBlock(x(xi),4) = MiniBlock(x(xi),4) +  k*10;
            if (x(xi)+1) <= length(MiniBlock) && isempty(intersect(MiniBlock(x(xi)+1,2),evcode)) == 0;
                MiniBlock(x(xi)+1,4) = MiniBlock(x(xi)+1,4) +  k*10;
            end
            if (x(xi)+2) <= length(MiniBlock) && isempty(intersect(MiniBlock(x(xi)+2,2),distcode)) == 0;
                MiniBlock(x(xi)+2,4) = MiniBlock(x(xi)+2,4) +  k*10;
            end
            if (x(xi)+3) <= length(MiniBlock) && isempty(intersect(MiniBlock(x(xi)+3,2),respcode)) == 0;
                MiniBlock(x(xi)+3,4) = MiniBlock(x(xi)+3,4) +  k*10;
            end
        end
    end
end

for k = evcode
    if isempty(intersect(MiniBlock(:,2),k)) == 0
        [x,y] = find(MiniBlock(:,2) == k);
        for xi = 1:length(x)
            MiniBlock(x(xi),4) = MiniBlock(x(xi),4) +  k*1000;
            MiniBlock(x(xi),5) = DATES(EVENT == k);
            MiniBlock(x(xi),6) = LONGS(EVENT == k);
            if (x(xi)-1) >0 && isempty(intersect(MiniBlock(x(xi)-1,2),qtcode)) == 0;
                MiniBlock(x(xi)-1,4) = MiniBlock(x(xi)-1,4) +  k*1000;
                MiniBlock(x(xi)-1,5) = DATES(EVENT == k);
                MiniBlock(x(xi)-1,6) = LONGS(EVENT == k);
            end
            if (x(xi)+1) <= length(MiniBlock) && isempty(intersect(MiniBlock(x(xi)+1,2),distcode)) == 0;
                MiniBlock(x(xi)+1,4) = MiniBlock(x(xi)+1,4) +  k*1000;
                MiniBlock(x(xi)+1,5) = DATES(EVENT == k);
                MiniBlock(x(xi)+1,6) = LONGS(EVENT == k);
            end
            if (x(xi)+2) <= length(MiniBlock) && isempty(intersect(MiniBlock(x(xi)+2,2),respcode)) == 0;
                MiniBlock(x(xi)+2,4) = MiniBlock(x(xi)+2,4) +  k*1000;
                MiniBlock(x(xi)+2,5) = DATES(EVENT == k);
                MiniBlock(x(xi)+2,6) = LONGS(EVENT == k);
            end
        end
    end
end

for k = respcode
    if isempty(intersect(MiniBlock(:,2),k)) == 0
        [x,y] = find(MiniBlock(:,2) == k);
        for xi = 1:length(x)
            if (x(xi)-3) > 0 && isempty(intersect(MiniBlock(x(xi)-3,2),qtTcode)) == 0; % timequestion
                if isempty(intersect(MiniBlock(x(xi),2),1024)) == 0; % leftbutton
                    if (x(xi)-2) > 0 && isempty(intersect(MiniBlock(x(xi)-2,2),EvcodeTimeLeft )) == 0;
                        MiniBlock(x(xi),4) = MiniBlock(x(xi),4) +  1; % TimeLeftTrue
                        if (x(xi)-1) > 0 && isempty(intersect(MiniBlock(x(xi)-1,2),distcode)) == 0;
                            MiniBlock(x(xi)-1,4) = MiniBlock(x(xi)-1,4) +  1;
                        end
                        if (x(xi)-2) > 0 && isempty(intersect(MiniBlock(x(xi)-2,2),evcode)) == 0;
                            MiniBlock(x(xi)-2,4) = MiniBlock(x(xi)-2,4) +  1;
                        end
                        if (x(xi)-3) > 0 && isempty(intersect(MiniBlock(x(xi)-3,2),qtTcode)) == 0;
                            MiniBlock(x(xi)-3,4) = MiniBlock(x(xi)-3,4) +  1;
                        end
                    elseif (x(xi)-2) > 0 && isempty(intersect(MiniBlock(x(xi)-2,2),EvcodeTimeRight )) == 0;
                        MiniBlock(x(xi),4) = MiniBlock(x(xi),4) +  2; % TimeLeftFalse
                        if (x(xi)-1) > 0 && isempty(intersect(MiniBlock(x(xi)-1,2),distcode)) == 0;
                            MiniBlock(x(xi)-1,4) = MiniBlock(x(xi)-1,4) +  2;
                        end
                        if (x(xi)-2) > 0 && isempty(intersect(MiniBlock(x(xi)-2,2),evcode)) == 0;
                            MiniBlock(x(xi)-2,4) = MiniBlock(x(xi)-2,4) + 2;
                        end
                        if (x(xi)-3) > 0 && isempty(intersect(MiniBlock(x(xi)-3,2),qtTcode)) == 0;
                            MiniBlock(x(xi)-3,4) = MiniBlock(x(xi)-3,4) + 2;
                        end
                    end
                elseif isempty(intersect(MiniBlock(x(xi),2),32768)) == 0; % rightbutton
                    if (x(xi)-2) > 0 && isempty(intersect(MiniBlock(x(xi)-2,2),EvcodeTimeRight )) == 0;
                        MiniBlock(x(xi),4) = MiniBlock(x(xi),4) +  3; % TimeRightTrue
                        if (x(xi)-1) > 0 && isempty(intersect(MiniBlock(x(xi)-1,2),distcode)) == 0;
                            MiniBlock(x(xi)-1,4) = MiniBlock(x(xi)-1,4) +  3;
                        end
                        if (x(xi)-2) > 0 && isempty(intersect(MiniBlock(x(xi)-2,2),evcode)) == 0;
                            MiniBlock(x(xi)-2,4) = MiniBlock(x(xi)-2,4) +  3;
                        end
                        if (x(xi)-3) > 0 && isempty(intersect(MiniBlock(x(xi)-3,2),qtTcode)) == 0;
                            MiniBlock(x(xi)-3,4) = MiniBlock(x(xi)-3,4) +  3;
                        end
                    elseif (x(xi)-2) > 0 && isempty(intersect(MiniBlock(x(xi)-2,2),EvcodeTimeLeft )) == 0;
                        MiniBlock(x(xi),4) = MiniBlock(x(xi),4) +  4; % TimeRightFalse
                        if (x(xi)-1) > 0 && isempty(intersect(MiniBlock(x(xi)-1,2),distcode)) == 0;
                            MiniBlock(x(xi)-1,4) = MiniBlock(x(xi)-1,4) +  4;
                        end
                        if (x(xi)-2) > 0 && isempty(intersect(MiniBlock(x(xi)-2,2),evcode)) == 0;
                            MiniBlock(x(xi)-2,4) = MiniBlock(x(xi)-2,4) +  4;
                        end
                        if (x(xi)-3) > 0 && isempty(intersect(MiniBlock(x(xi)-3,2),qtTcode)) == 0;
                            MiniBlock(x(xi)-3,4) = MiniBlock(x(xi)-3,4) + 4;
                        end
                    end
                end
            elseif (x(xi)-3) > 0 && isempty(intersect(MiniBlock(x(xi)-3,2),qtScode)) == 0; % spacequestion
                if isempty(intersect(MiniBlock(x(xi),2),1024)) == 0; % leftbutton
                    if (x(xi)-2) > 0 && isempty(intersect(MiniBlock(x(xi)-2,2),EvcodeSpaceLeft )) == 0;
                        MiniBlock(x(xi),4) = MiniBlock(x(xi),4) +  1; % SpaceLeftTrue
                        if (x(xi)-1) > 0 && isempty(intersect(MiniBlock(x(xi)-1,2),distcode)) == 0;
                            MiniBlock(x(xi)-1,4) = MiniBlock(x(xi)-1,4) +  1;
                        end
                        if (x(xi)-2) > 0 && isempty(intersect(MiniBlock(x(xi)-2,2),evcode)) == 0;
                            MiniBlock(x(xi)-2,4) = MiniBlock(x(xi)-2,4) +  1;
                        end
                        if (x(xi)-3) > 0 && isempty(intersect(MiniBlock(x(xi)-3,2),qtScode)) == 0;
                            MiniBlock(x(xi)-3,4) = MiniBlock(x(xi)-3,4) +  1;
                        end
                    elseif (x(xi)-2) > 0 && isempty(intersect(MiniBlock(x(xi)-2,2),EvcodeSpaceRight )) == 0;
                        MiniBlock(x(xi),4) = MiniBlock(x(xi),4) +  2; % SpaceLeftFalse
                        if (x(xi)-1) > 0 && isempty(intersect(MiniBlock(x(xi)-1,2),distcode)) == 0;
                            MiniBlock(x(xi)-1,4) = MiniBlock(x(xi)-1,4) +  2;
                        end
                        if (x(xi)-2) > 0 && isempty(intersect(MiniBlock(x(xi)-2,2),evcode)) == 0;
                            MiniBlock(x(xi)-2,4) = MiniBlock(x(xi)-2,4) + 2;
                        end
                        if (x(xi)-3) > 0 && isempty(intersect(MiniBlock(x(xi)-3,2),qtScode)) == 0;
                            MiniBlock(x(xi)-3,4) = MiniBlock(x(xi)-3,4) + 2;
                        end
                    end
                elseif isempty(intersect(MiniBlock(x(xi),2),32768)) == 0; % rightbutton
                    if (x(xi)-2) > 0 && isempty(intersect(MiniBlock(x(xi)-2,2),EvcodeSpaceRight )) == 0;
                        MiniBlock(x(xi),4) = MiniBlock(x(xi),4) +  3; % SpaceRightTrue
                        if (x(xi)-1) > 0 &&  isempty(intersect(MiniBlock(x(xi)-1,2),distcode)) == 0;
                            MiniBlock(x(xi)-1,4) = MiniBlock(x(xi)-1,4) +  3;
                        end
                        if (x(xi)-2) > 0 && isempty(intersect(MiniBlock(x(xi)-2,2),evcode)) == 0;
                            MiniBlock(x(xi)-2,4) = MiniBlock(x(xi)-2,4) +  3;
                        end
                        if (x(xi)-3) > 0 && isempty(intersect(MiniBlock(x(xi)-3,2),qtScode)) == 0;
                            MiniBlock(x(xi)-3,4) = MiniBlock(x(xi)-3,4) +  3;
                        end
                    elseif (x(xi)-2) > 0 && isempty(intersect(MiniBlock(x(xi)-2,2),EvcodeSpaceLeft )) == 0;
                        MiniBlock(x(xi),4) = MiniBlock(x(xi),4) +  4; % SpaceRightFalse
                        if (x(xi)-1) > 0 && isempty(intersect(MiniBlock(x(xi)-1,2),distcode)) == 0;
                            MiniBlock(x(xi)-1,4) = MiniBlock(x(xi)-1,4) +  4;
                        end
                        if (x(xi)-2) > 0 && isempty(intersect(MiniBlock(x(xi)-2,2),evcode)) == 0;
                            MiniBlock(x(xi)-2,4) = MiniBlock(x(xi)-2,4) +  4;
                        end
                        if (x(xi)-3) > 0 && isempty(intersect(MiniBlock(x(xi)-3,2),qtScode)) == 0;
                            MiniBlock(x(xi)-3,4) = MiniBlock(x(xi)-3,4) +  4;
                        end
                    end
                end
            end
        end
    end
end



