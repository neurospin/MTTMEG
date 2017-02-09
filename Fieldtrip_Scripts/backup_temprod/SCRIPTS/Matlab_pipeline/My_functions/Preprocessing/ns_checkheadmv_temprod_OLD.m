function data = ns_checkheadmv(cfg)
%%% CHECK HEAD MOVEMENT ACROSS RUNS FOR ALL SUBJECTS
% adapted from Lucie's script

% Number of Subjects
numberOfSubjects = 1;

% Gets the data from the files and computes the difference between runs
    data.sub = cfg.Sub_Num;
    
% fprintf(cfg.fd, 'Head Movement compared to Run 1:\n');
    for r = cfg.run
        
        % Read the file
        fid = fopen([cfg.DirHead 'Pos_' cfg.Sub_Num '_run' num2str(r) '.txt']); %s_run%d.fif.txt',generalfilename(s,:),r), 'r');
        F = textscan(fid,'%s');
        fclose(fid);
        
        % Put it in a good shape
        R = [];
        T = [];
        for i = 1:4*3
            if i <= 9
                R = [R str2num(F{1}{i+6})];
            else
                T = [T str2num(F{1}{i+6})];
            end
        end      
        R = reshape(R,3,3);  
        R = shiftdim(R,1);   
        
        % Puts it in the big structure
        data.rotation{r} = R; % the rotation matrix
        data.translation{r} = T; %the translation vector
        
        % Computation of differences
        if r == 1 % we compare everything to run one so we put the data of this run in different variables
            
            % Calculate the coordinates of vector [1 1 1] in head
            % coordinates system
            x1 = R(1,1) + R(1,2) + R(1,3);
            y1 = R(2,1) + R(2,2) + R(2,3);
            z1 = R(3,1) + R(3,2) + R(3,3);
            
            % Convert the coordinate to angle in radian with complex
            % numbers
            X1 = angle(y1+1i*z1); 
            Y1 = angle(x1+1i*z1);
            Z1 = angle(x1+1i*y1);
            
            % Save everything into the data structure
            T1 = T;
            data.X(r) = X1; 
            data.Y(r) = Y1;
            data.Z(r) = Z1;
            
        elseif r > 1 % we compare everything to block one
            
            % Calculate the coordinates of vector [1 1 1] in head
            % coordinates system
            x = R(1,1) + R(1,2) + R(1,3);
            y = R(2,1) + R(2,2) + R(2,3);
            z = R(3,1) + R(3,2) + R(3,3);
            
            % Convert the coordinate to angle in radian with complex
            % numbers
            X = angle(y+1i*z); 
            Y = angle(x+1i*z);
            Z = angle(x+1i*y);
            
            
            % Save everything into the data structure
            data.X(r) = X; 
            data.Y(r) = Y;
            data.Z(r)= Z;
            
            % Calculate the difference for each coordinate for rotation ans
            % translation
%            fprintf(cfg.fd, ['Run ' num2str(r) '\n']);
            data.Xdiffrotinrad(r) = abs(pi - abs(pi - abs(X1 - X))); 
            data.Xdiffrotindeg(r) = data.Xdiffrotinrad(r)*180/pi;
%            fprintf(cfg.fd, ['Rotation (deg) X:\t' num2str(data.Xdiffrotindeg(r)) '\n']);
            data.Ydiffrotinrad(r) = abs(pi - abs(pi - abs(Y1 - Y))); 
            data.Ydiffrotindeg(r) = data.Ydiffrotinrad(r)*180/pi;
 %           fprintf(cfg.fd, ['Rotation (deg) Y:\t' num2str(data.Ydiffrotindeg(r)) '\n']);
            data.Zdiffrotinrad(r) = abs(pi - abs(pi - abs(Z1 - Z))); 
            data.Zdiffrotindeg(r) = data.Zdiffrotinrad(r)*180/pi;
  %          fprintf(cfg.fd, ['Rotation (deg) Z:\t' num2str(data.Zdiffrotindeg(r)) '\n']);
            data.Xdifftrans(r) = T1(1) - T(1);
   %         fprintf(cfg.fd, ['Translation (mm) X:\t' num2str(data.Xdifftrans(r)) '\n']);
            data.Ydifftrans(r) = T1(2) - T(2);
    %        fprintf(cfg.fd, ['Translation (mm) Y:\t' num2str(data.Ydifftrans(r)) '\n']);
            data.Zdifftrans(r) = T1(3) - T(3);
     %       fprintf(cfg.fd, ['Translation (mm) Z:\t' num2str(data.Zdifftrans(r)) '\n']);
        end
    end   



% PLOTS
%plot of rotation difference
figure
for s = 1:numberOfSubjects
    subplot(2,3,1)
    col = rand(1,3);
    plot(cfg.run(s), data(s).Xdiffrotindeg(:),'Color',col,'Marker','o')
    title('Difference in rotation to run 1 for X axis')
    ylabel('Degree')
    xlabel('Run')
    hold on
    subplot(2,3,2)
    plot(cfg.run(s), data(s).Ydiffrotindeg(:),'Color',col,'Marker','o')
    title('Difference in rotation to run 1 for Y axis')
    ylabel('Degree')
    xlabel('Run')
    hold on
    subplot(2,3,3)
    plot(cfg.run(s), data(s).Zdiffrotindeg(:),'Color',col,'Marker','o')
    title('Difference in rotation to run 1 for Z axis')
    ylabel('Degree')
    xlabel('Run')
    hold on
end

% PLot of translation difference
for s = 1:numberOfSubjects
    subplot(2,3,4)
    col = rand(1,3);
    plot(cfg.run(s), data(s).Xdifftrans(:),'Color',col,'Marker','o')
    title('Difference to run 1 for X axis')
    ylabel('mm')
    xlabel('Run')
    hold on
    subplot(2,3,5)
    plot(cfg.run(s), data(s).Ydifftrans(:),'Color',col,'Marker','o')
    title('Difference to run 1 for Y axis')
    ylabel('mm')
    xlabel('Run')
    hold on
    subplot(2,3,6)
    plot(cfg.run(s), data(s).Zdifftrans(:),'Color',col,'Marker','o')
    title('Difference to run 1 for Z axis')
    ylabel('mm')
    xlabel('Run')
    hold on
end

   