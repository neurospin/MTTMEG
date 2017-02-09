function ns_maxfilter(par)

%% Maxfilter %%
fid2            = fopen([par.DirMaxFil par.NameMaxFil], 'w+');
fprintf(fid2, '#!/bin/tcsh\n');
fprintf(fid2, ['set raw_dir = ' par.RawDir '\n']);
fprintf(fid2, ['set out_dir = ' par.DataDir '\n']);
fprintf(fid2, ['set Subject = ' par.Sub_Num '\n']);
fprintf(fid2, ['set Bad = ' par.BadChan '\n']);
fprintf(fid2, 'cd $raw_dir\n');
fprintf(fid2, ['foreach i(' num2str(par.run) ')\n']);
fprintf(fid2, 'ls "raw"*run$i".fif"\n');
fprintf(fid2, ['maxfilter-2.1 -force -f "raw"*run$i".fif" -o $out_dir$Subject"run"$i"_sss".fif -frame head -origin 0 0 40 -bad $Bad -autobad on -badlimit 7 -trans "raw"*run' num2str(par.RunRef) '.fif\n']);
fprintf(fid2, 'end\n');
fclose(fid2);
cmd = ['chmod 777 ' par.DirMaxFil par.NameMaxFil];
system(cmd);
cmd = [par.DirMaxFil par.NameMaxFil];
[status, result] = system(cmd)
