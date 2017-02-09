% Make a series of scalp maps from data in an image

clear all
close all

addpath('C:\RESONANCE_MEG\FT_analysis\SCRIPTS\FIELDTRIP')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% tuning BETA VALUES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig1 = figure('position',[1 1 1280 420]);
set(fig1,'PaperPosition',[1 1 1280 420])
set(fig1,'PaperPositionmode','auto')

for i = 1:9
    mysubplot(2,9,i)
    VolumeHeader = spm_vol(['C:\RESONANCE_MEG\SPM_analysis\Subjects\cb100118\TF_data\TF_TuningModel1\beta_000' num2str(i) '.img']);
    VolumeData   = spm_read_vols(VolumeHeader);
    ZI           = interp2(VolumeData,3);
    imagesc([flipdim(ZI,2)]',[0 1e-27]);
    set(gca,'xtick',1:32,'xticklabel','')
    set(gca,'ytick',1:32,'yticklabel','')
end
mysubplot(2,9,10)
imagesc([flipdim(ZI,2)]',[0 1e-27]);
set(gca,'xtick',1:32,'xticklabel','')
set(gca,'ytick',1:32,'yticklabel','')
colorbar
print('-dpng','C:\RESONANCE_MEG\SPM_analysis\Figures\cb100118_BETA_MAPS')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 1280 420]);
set(fig1,'PaperPosition',[1 1 1280 420])
set(fig1,'PaperPositionmode','auto')

for i = 1:9
    mysubplot(2,9,i)
    VolumeHeader = spm_vol(['C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\TF_TuningModel1\beta_000' num2str(i) '.img']);
    VolumeData   = spm_read_vols(VolumeHeader);
    ZI           = interp2(VolumeData,3);
    imagesc([flipdim(ZI,2)]',[0 1e-27]);
    set(gca,'xtick',1:32,'xticklabel','')
    set(gca,'ytick',1:32,'yticklabel','')
end
mysubplot(2,9,10)
imagesc([flipdim(ZI,2)]',[0 1e-27]);
set(gca,'xtick',1:32,'xticklabel','')
set(gca,'ytick',1:32,'yticklabel','')
colorbar
print('-dpng','C:\RESONANCE_MEG\SPM_analysis\Figures\cd100449_BETA_MAPS')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 1280 420]);
set(fig1,'PaperPosition',[1 1 1280 420])
set(fig1,'PaperPositionmode','auto')

for i = 1:9
    mysubplot(2,9,i)
    VolumeHeader = spm_vol(['C:\RESONANCE_MEG\SPM_analysis\Subjects\nr110115\TF_data\TF_TuningModel1\beta_000' num2str(i) '.img']);
    VolumeData   = spm_read_vols(VolumeHeader);
    ZI           = interp2(VolumeData,3);
    imagesc([flipdim(ZI,2)]',[0 1e-27]);
    set(gca,'xtick',1:32,'xticklabel','')
    set(gca,'ytick',1:32,'yticklabel','')
end
mysubplot(2,9,10)
imagesc([flipdim(ZI,2)]',[0 1e-27]);
set(gca,'xtick',1:32,'xticklabel','')
set(gca,'ytick',1:32,'yticklabel','')
colorbar
print('-dpng','C:\RESONANCE_MEG\SPM_analysis\Figures\nr110115_BETA_MAPS')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 1280 420]);
set(fig1,'PaperPosition',[1 1 1280 420])
set(fig1,'PaperPositionmode','auto')

for i = 1:9
    mysubplot(2,9,i)
    VolumeHeader = spm_vol(['C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\TF_TuningModel1\beta_000' num2str(i) '.img']);
    VolumeData   = spm_read_vols(VolumeHeader);
    ZI           = interp2(VolumeData,3);
    imagesc([flipdim(ZI,2)]',[0 1e-27]);
    set(gca,'xtick',1:32,'xticklabel','')
    set(gca,'ytick',1:32,'yticklabel','')
end
mysubplot(2,9,10)
imagesc([flipdim(ZI,2)]',[0 1e-27]);
set(gca,'xtick',1:32,'xticklabel','')
set(gca,'ytick',1:32,'yticklabel','')
colorbar
print('-dpng','C:\RESONANCE_MEG\SPM_analysis\Figures\ns110383_BETA_MAPS')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 1280 420]);
set(fig1,'PaperPosition',[1 1 1280 420])
set(fig1,'PaperPositionmode','auto')

for i = 1:9
    mysubplot(2,9,i)
    VolumeHeader = spm_vol(['C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\TF_TuningModel1\beta_000' num2str(i) '.img']);
    VolumeData   = spm_read_vols(VolumeHeader);
    ZI           = interp2(VolumeData,3);
    imagesc([flipdim(ZI,2)]',[0 1e-27]);
    set(gca,'xtick',1:32,'xticklabel','')
    set(gca,'ytick',1:32,'yticklabel','')
end
mysubplot(2,9,10)
imagesc([flipdim(ZI,2)]',[0 2e-27]);
set(gca,'xtick',1:32,'xticklabel','')
set(gca,'ytick',1:32,'yticklabel','')
colorbar
print('-dpng','C:\RESONANCE_MEG\SPM_analysis\Figures\pe110338_BETA_MAPS')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% tuning T map %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 1280 420]);
set(fig1,'PaperPosition',[1 1 1280 420])
set(fig1,'PaperPositionmode','auto')

for i = 1:10
    mysubplot(2,9,i)
    VolumeHeader = spm_vol(['C:\RESONANCE_MEG\SPM_analysis\Subjects\cb100118\TF_data\TF_TuningModel1\spmT_' num2str(i,'%04.0f') '.img']);
    VolumeData   = spm_read_vols(VolumeHeader);
    ZI           = interp2(VolumeData,3);
    imagesc([flipdim(ZI,2)]',[-5 5]);
    set(gca,'xtick',1:32,'xticklabel','')
    set(gca,'ytick',1:32,'yticklabel','')
end

mysubplot(2,9,11)
imagesc([flipdim(ZI,2)]',[-5 5]);
set(gca,'xtick',1:32,'xticklabel','')
set(gca,'ytick',1:32,'yticklabel','')
colorbar
print('-dpng','C:\RESONANCE_MEG\SPM_analysis\Figures\cb100118_T_MAPS')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 1280 420]);
set(fig1,'PaperPosition',[1 1 1280 420])
set(fig1,'PaperPositionmode','auto')

for i = 1:10
    mysubplot(2,9,i)
    VolumeHeader = spm_vol(['C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\TF_TuningModel1\spmT_' num2str(i,'%04.0f') '.img']);
    VolumeData   = spm_read_vols(VolumeHeader);
    ZI           = interp2(VolumeData,3);
    imagesc([flipdim(ZI,2)]',[-4 4]);
    set(gca,'xtick',1:32,'xticklabel','')
    set(gca,'ytick',1:32,'yticklabel','')
end

mysubplot(2,9,11)
imagesc([flipdim(ZI,2)]',[-5 5]);
set(gca,'xtick',1:32,'xticklabel','')
set(gca,'ytick',1:32,'yticklabel','')
colorbar
print('-dpng','C:\RESONANCE_MEG\SPM_analysis\Figures\cd100449_T_MAPS')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 1280 420]);
set(fig1,'PaperPosition',[1 1 1280 420])
set(fig1,'PaperPositionmode','auto')

for i = 1:10
    mysubplot(2,9,i)
    VolumeHeader = spm_vol(['C:\RESONANCE_MEG\SPM_analysis\Subjects\nr110115\TF_data\TF_TuningModel1\spmT_' num2str(i,'%04.0f') '.img']);
    VolumeData   = spm_read_vols(VolumeHeader);
    ZI           = interp2(VolumeData,3);
    imagesc([flipdim(ZI,2)]',[-4 4]);
    set(gca,'xtick',1:32,'xticklabel','')
    set(gca,'ytick',1:32,'yticklabel','')
end

mysubplot(2,9,11)
imagesc([flipdim(ZI,2)]',[-5 5]);
set(gca,'xtick',1:32,'xticklabel','')
set(gca,'ytick',1:32,'yticklabel','')
colorbar
print('-dpng','C:\RESONANCE_MEG\SPM_analysis\Figures\nr110115_T_MAPS')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 1280 420]);
set(fig1,'PaperPosition',[1 1 1280 420])
set(fig1,'PaperPositionmode','auto')

for i = 1:10
    mysubplot(2,9,i)
    VolumeHeader = spm_vol(['C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\TF_TuningModel1\spmT_' num2str(i,'%04.0f') '.img']);
    VolumeData   = spm_read_vols(VolumeHeader);
    ZI           = interp2(VolumeData,3);
    imagesc([flipdim(ZI,2)]',[-4 4]);
    set(gca,'xtick',1:32,'xticklabel','')
    set(gca,'ytick',1:32,'yticklabel','')
end

mysubplot(2,9,11)
imagesc([flipdim(ZI,2)]',[-6 6]);
set(gca,'xtick',1:32,'xticklabel','')
set(gca,'ytick',1:32,'yticklabel','')
colorbar
print('-dpng','C:\RESONANCE_MEG\SPM_analysis\Figures\ns110383_T_MAPS')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 1280 420]);
set(fig1,'PaperPosition',[1 1 1280 420])
set(fig1,'PaperPositionmode','auto')

for i = 1:10
    mysubplot(2,9,i)
    VolumeHeader = spm_vol(['C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\TF_TuningModel1\spmT_' num2str(i,'%04.0f') '.img']);
    VolumeData   = spm_read_vols(VolumeHeader);
    ZI           = interp2(VolumeData,3);
    imagesc([flipdim(ZI,2)]',[-4 4]);
    set(gca,'xtick',1:32,'xticklabel','')
    set(gca,'ytick',1:32,'yticklabel','')
end

mysubplot(2,9,11)
imagesc([flipdim(ZI,2)]',[-4 4]);
set(gca,'xtick',1:32,'xticklabel','')
set(gca,'ytick',1:32,'yticklabel','')
colorbar
print('-dpng','C:\RESONANCE_MEG\SPM_analysis\Figures\pe110338_T_MAPS')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 1280 420]);
set(fig1,'PaperPosition',[1 1 1280 420])
set(fig1,'PaperPositionmode','auto')

for i = 1:9
    mysubplot(2,9,i)
    VolumeHeader = spm_vol(['C:\RESONANCE_MEG\SPM_analysis\Subjects\cb100118\TF_data\TF_AlphaModel1\beta_000' num2str(i) '.img']);
    VolumeData   = spm_read_vols(VolumeHeader);
    ZI           = interp2(VolumeData,3);
    imagesc([flipdim(ZI,2)]',[0 1.e-27]);
    set(gca,'xtick',1:32,'xticklabel','')
    set(gca,'ytick',1:32,'yticklabel','')
end
mysubplot(2,9,10)
imagesc([flipdim(ZI,2)]',[0 1.e-27]);
set(gca,'xtick',1:32,'xticklabel','')
set(gca,'ytick',1:32,'yticklabel','')
colorbar

print('-dpng','C:\RESONANCE_MEG\SPM_analysis\Figures\cb100118_BETA_MAPS_ALPHAPOWER')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 1280 420]);
set(fig1,'PaperPosition',[1 1 1280 420])
set(fig1,'PaperPositionmode','auto')

for i = 1:9
    mysubplot(2,9,i)
    VolumeHeader = spm_vol(['C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\TF_AlphaModel1\beta_000' num2str(i) '.img']);
    VolumeData   = spm_read_vols(VolumeHeader);
    ZI           = interp2(VolumeData,3);
    imagesc([flipdim(ZI,2)]',[0 1.e-27]);
    set(gca,'xtick',1:32,'xticklabel','')
    set(gca,'ytick',1:32,'yticklabel','')
end
mysubplot(2,9,10)
imagesc([flipdim(ZI,2)]',[0 1.e-27]);
set(gca,'xtick',1:32,'xticklabel','')
set(gca,'ytick',1:32,'yticklabel','')
colorbar

print('-dpng','C:\RESONANCE_MEG\SPM_analysis\Figures\cd100449_BETA_MAPS_ALPHAPOWER')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 1280 420]);
set(fig1,'PaperPosition',[1 1 1280 420])
set(fig1,'PaperPositionmode','auto')

for i = 1:9
    mysubplot(2,9,i)
    VolumeHeader = spm_vol(['C:\RESONANCE_MEG\SPM_analysis\Subjects\nr110115\TF_data\TF_AlphaModel1\beta_000' num2str(i) '.img']);
    VolumeData   = spm_read_vols(VolumeHeader);
    ZI           = interp2(VolumeData,3);
    imagesc([flipdim(ZI,2)]',[0 1.e-27]);
    set(gca,'xtick',1:32,'xticklabel','')
    set(gca,'ytick',1:32,'yticklabel','')
end
mysubplot(2,9,10)
imagesc([flipdim(ZI,2)]',[0 1.e-27]);
set(gca,'xtick',1:32,'xticklabel','')
set(gca,'ytick',1:32,'yticklabel','')
colorbar

print('-dpng','C:\RESONANCE_MEG\SPM_analysis\Figures\nr110115_BETA_MAPS_ALPHAPOWER')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 1280 420]);
set(fig1,'PaperPosition',[1 1 1280 420])
set(fig1,'PaperPositionmode','auto')

for i = 1:9
    mysubplot(2,9,i)
    VolumeHeader = spm_vol(['C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\TF_AlphaModel1\beta_000' num2str(i) '.img']);
    VolumeData   = spm_read_vols(VolumeHeader);
    ZI           = interp2(VolumeData,3);
    imagesc([flipdim(ZI,2)]',[0 1.e-27]);
    set(gca,'xtick',1:32,'xticklabel','')
    set(gca,'ytick',1:32,'yticklabel','')
end
mysubplot(2,9,10)
imagesc([flipdim(ZI,2)]',[0 1.e-27]);
set(gca,'xtick',1:32,'xticklabel','')
set(gca,'ytick',1:32,'yticklabel','')
colorbar

print('-dpng','C:\RESONANCE_MEG\SPM_analysis\Figures\ns110383_BETA_MAPS_ALPHAPOWER')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 1280 420]);
set(fig1,'PaperPosition',[1 1 1280 420])
set(fig1,'PaperPositionmode','auto')

for i = 1:9
    mysubplot(2,9,i)
    VolumeHeader = spm_vol(['C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\TF_AlphaModel1\beta_000' num2str(i) '.img']);
    VolumeData   = spm_read_vols(VolumeHeader);
    ZI           = interp2(VolumeData,3);
    imagesc([flipdim(ZI,2)]',[0 3.e-27]);
    set(gca,'xtick',1:32,'xticklabel','')
    set(gca,'ytick',1:32,'yticklabel','')
end
mysubplot(2,9,10)
imagesc([flipdim(ZI,2)]',[0 3.e-27]);
set(gca,'xtick',1:32,'xticklabel','')
set(gca,'ytick',1:32,'yticklabel','')
colorbar

print('-dpng','C:\RESONANCE_MEG\SPM_analysis\Figures\pe110338_BETA_MAPS_ALPHAPOWER')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 1280 420]);
set(fig1,'PaperPosition',[1 1 1280 420])
set(fig1,'PaperPositionmode','auto')

for i = 1:10
    mysubplot(2,9,i)
    VolumeHeader = spm_vol(['C:\RESONANCE_MEG\SPM_analysis\Subjects\cb100118\TF_data\TF_AlphaModel1\spmT_' num2str(i,'%04.0f') '.img']);
    VolumeData   = spm_read_vols(VolumeHeader);
    ZI           = interp2(VolumeData,3);
    imagesc([flipdim(ZI,2)]',[-4 4]);
    set(gca,'xtick',1:32,'xticklabel','')
    set(gca,'ytick',1:32,'yticklabel','')
end

mysubplot(2,9,11)
imagesc([flipdim(ZI,2)]',[-4 4]);
set(gca,'xtick',1:32,'xticklabel','')
set(gca,'ytick',1:32,'yticklabel','')
colorbar
print('-dpng','C:\RESONANCE_MEG\SPM_analysis\Figures\cb100118_T_MAPS_ALPHAPOWER')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 1280 420]);
set(fig1,'PaperPosition',[1 1 1280 420])
set(fig1,'PaperPositionmode','auto')

for i = 1:10
    mysubplot(2,9,i)
    VolumeHeader = spm_vol(['C:\RESONANCE_MEG\SPM_analysis\Subjects\cd100449\TF_data\TF_AlphaModel1\spmT_' num2str(i,'%04.0f') '.img']);
    VolumeData   = spm_read_vols(VolumeHeader);
    ZI           = interp2(VolumeData,3);
    imagesc([flipdim(ZI,2)]',[-4 4]);
    set(gca,'xtick',1:32,'xticklabel','')
    set(gca,'ytick',1:32,'yticklabel','')
end

mysubplot(2,9,11)
imagesc([flipdim(ZI,2)]',[-4 4]);
set(gca,'xtick',1:32,'xticklabel','')
set(gca,'ytick',1:32,'yticklabel','')
colorbar
print('-dpng','C:\RESONANCE_MEG\SPM_analysis\Figures\cd100449_T_MAPS_ALPHAPOWER')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 1280 420]);
set(fig1,'PaperPosition',[1 1 1280 420])
set(fig1,'PaperPositionmode','auto')

for i = 1:10
    mysubplot(2,9,i)
    VolumeHeader = spm_vol(['C:\RESONANCE_MEG\SPM_analysis\Subjects\nr110115\TF_data\TF_AlphaModel1\spmT_' num2str(i,'%04.0f') '.img']);
    VolumeData   = spm_read_vols(VolumeHeader);
    ZI           = interp2(VolumeData,3);
    imagesc([flipdim(ZI,2)]',[-4 4]);
    set(gca,'xtick',1:32,'xticklabel','')
    set(gca,'ytick',1:32,'yticklabel','')
end

mysubplot(2,9,11)
imagesc([flipdim(ZI,2)]',[-4 4]);
set(gca,'xtick',1:32,'xticklabel','')
set(gca,'ytick',1:32,'yticklabel','')
colorbar
print('-dpng','C:\RESONANCE_MEG\SPM_analysis\Figures\nr110115_T_MAPS_ALPHAPOWER')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 1280 420]);
set(fig1,'PaperPosition',[1 1 1280 420])
set(fig1,'PaperPositionmode','auto')

for i = 1:10
    mysubplot(2,9,i)
    VolumeHeader = spm_vol(['C:\RESONANCE_MEG\SPM_analysis\Subjects\ns110383\TF_data\TF_AlphaModel1\spmT_' num2str(i,'%04.0f') '.img']);
    VolumeData   = spm_read_vols(VolumeHeader);
    ZI           = interp2(VolumeData,3);
    imagesc([flipdim(ZI,2)]',[-4 4]);
    set(gca,'xtick',1:32,'xticklabel','')
    set(gca,'ytick',1:32,'yticklabel','')
end

mysubplot(2,9,11)
imagesc([flipdim(ZI,2)]',[-4 4]);
set(gca,'xtick',1:32,'xticklabel','')
set(gca,'ytick',1:32,'yticklabel','')
colorbar
print('-dpng','C:\RESONANCE_MEG\SPM_analysis\Figures\ns110383_T_MAPS_ALPHAPOWER')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 1280 420]);
set(fig1,'PaperPosition',[1 1 1280 420])
set(fig1,'PaperPositionmode','auto')

for i = 1:10
    mysubplot(2,9,i)
    VolumeHeader = spm_vol(['C:\RESONANCE_MEG\SPM_analysis\Subjects\pe110338\TF_data\TF_AlphaModel1\spmT_' num2str(i,'%04.0f') '.img']);
    VolumeData   = spm_read_vols(VolumeHeader);
    ZI           = interp2(VolumeData,3);
    imagesc([flipdim(ZI,2)]',[-4 4]);
    set(gca,'xtick',1:32,'xticklabel','')
    set(gca,'ytick',1:32,'yticklabel','')
end

mysubplot(2,9,11)
imagesc([flipdim(ZI,2)]',[-4 4]);
set(gca,'xtick',1:32,'xticklabel','')
set(gca,'ytick',1:32,'yticklabel','')
colorbar
print('-dpng','C:\RESONANCE_MEG\SPM_analysis\Figures\pe110338_T_MAPS_ALPHAPOWER')
















