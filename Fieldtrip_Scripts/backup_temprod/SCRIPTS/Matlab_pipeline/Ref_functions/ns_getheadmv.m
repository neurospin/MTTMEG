function ns_getheadmv(par)

%% Check Head Movement between runs
% Generate an SH script which will get head position for each run and put
% it in a txt file
DirSH       = par.DirHead;
SHname      = ['HeadMov' par.Sub_Num];
fd2         = fopen([DirSH SHname], 'w+');
fprintf(fd2, '#!/bin/tcsh\n');
fprintf(fd2, ['set raw_dir = ' par.RawDir '\n']);
fprintf(fd2, ['set Subject = ' par.Sub_Num '\n']);
fprintf(fd2, 'cd $raw_dir\n');
fprintf(fd2, ['foreach i(' num2str(par.run) ')\n']);
fprintf(fd2, 'ls raw_*run$i.fif\n');
fprintf(fd2, ['show_fiff -vt 222 raw_*run$i.fif > ' par.DirHead 'Pos_$Subject"_run"$i.txt\n']);
fprintf(fd2, 'end\n');
fclose(fd2);
cmd = ['chmod 777 ' DirSH SHname];
system(cmd);
cmd = [DirSH SHname];
[status, result] = system(cmd);
