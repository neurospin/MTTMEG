function save_plots(nip,mod,filename,fig)

root = ['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' nip '/PlotData'];

if exist([root '/' mod]) == 7
    disp(['result folder ''' root '/' mod ''' already exists']);
    disp(['saving ' filename ' in ''' root '/' mod '''']);
else
    mkdir(root,mod)
    disp(['creating folder ''' root '/' mod '''']);
end

print(fig,'-dpng',[root '/' mod '/' filename])
            
            













