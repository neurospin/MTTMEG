% Make a series of scalp maps from data in an image

clear all
close all

addpath('C:\RESONANCE_MEG\FT_analysis\SCRIPTS\FIELDTRIP')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% tuning BETA VALUES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig1 = figure('position',[1 1 1000 800]);
set(fig1,'PaperPosition',[1 1 1000 800])
set(fig1,'PaperPositionmode','auto')

ListTitle = {'Stim50ms';'Stim83ms';'Stim100ms';'Stim150ms';'Stim200ms';...
             'Stim300ms';'Stim400ms';'Stim600ms';'Baseline'};

for i = 1:9
    subplot(3,3,i)
    VolumeHeader = spm_vol(['C:\RESONANCE_MEG\SPM_analysis\Group\TF_TuningModel1\beta_000' num2str(i) '.img']);
    VolumeData   = spm_read_vols(VolumeHeader);
    ZI           = interp2(VolumeData,3);
    imagesc([flipdim(ZI,2)]',[0 3.e-27]);
    colorbar; set(gca,'xtick',1:32,'xticklabel','')
    colorbar; set(gca,'ytick',1:32,'yticklabel','')
    title(['GroupBetaMap ' ListTitle{i}])
end
    
print('-dpng','C:\RESONANCE_MEG\SPM_analysis\Figures\GROUP_BETA_MAPS')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% tuning T map %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig1 = figure('position',[1 1 1280 800]);
set(fig1,'PaperPosition',[1 1 1280 800])
set(fig1,'PaperPositionmode','auto')

ListTitle = {'StimAllfreq > Baseline';...
             'Stim50ms > Baseline' ;'Stim83ms > Baseline' ;'Stim100ms > Baseline';...
             'Stim150ms > Baseline';'Stim200ms > Baseline';'Stim300ms  > Baseline';...
             'Stim400ms > Baseline';'Stim600ms > Baseline';'Baseline > Baseline';...
             'Baseline > StimAllfreq'};

for i = 1:10
    subplot(3,4,i)
    VolumeHeader = spm_vol(['C:\RESONANCE_MEG\SPM_analysis\Group\TF_TuningModel1\spmT_' num2str(i,'%04.0f') '.img']);
    VolumeData   = spm_read_vols(VolumeHeader);
    ZI           = interp2(VolumeData,3);
    imagesc([flipdim(ZI,2)]',[-4 4]);
    colorbar; set(gca,'xtick',1:32,'xticklabel','')
    colorbar; set(gca,'ytick',1:32,'yticklabel','')
    title(['Tmap ' ListTitle{i}])
end

print('-dpng','C:\RESONANCE_MEG\SPM_analysis\Figures\GROUP_T_MAPS')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%% alpha BETA map %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig1 = figure('position',[1 1 1000 800]);
set(fig1,'PaperPosition',[1 1 1000 800])
set(fig1,'PaperPositionmode','auto')

ListTitle = {'Stim50ms';'Stim83ms';'Stim100ms';'Stim150ms';'Stim200ms';...
             'Stim300ms';'Stim400ms';'Stim600ms';'Baseline'};

for i = 1:9
    subplot(3,3,i)
    VolumeHeader = spm_vol(['C:\RESONANCE_MEG\SPM_analysis\Group\TF_AlphaModel1\beta_000' num2str(i) '.img']);
    VolumeData   = spm_read_vols(VolumeHeader);
    ZI           = interp2(VolumeData,3);
    imagesc([flipdim(ZI,2)]',[0 3.e-27]);
    colorbar; set(gca,'xtick',1:32,'xticklabel','')
    colorbar; set(gca,'ytick',1:32,'yticklabel','')
    title(['GroupBetaMap ' ListTitle{i}])
end
    
print('-dpng','C:\RESONANCE_MEG\SPM_analysis\Figures\GROUP_BETA_MAPS_ALPHAPOWER')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% Alpha T Maps %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig1 = figure('position',[1 1 1280 800]);
set(fig1,'PaperPosition',[1 1 1280 800])
set(fig1,'PaperPositionmode','auto')

ListTitle = {'StimAllfreq < Baseline';...
             'Stim50ms > Baseline' ;'Baseline > Stim83ms' ;'Baseline > Stim100ms';...
             'Baseline > Stim150ms';'Baseline > Stim200ms';'Baseline > Stim300ms';...
             'Baseline > Stim400ms';'Baseline > Stim600ms';'Baseline > StimAllfreq'};

for i = 1:10
    subplot(3,4,i)
    VolumeHeader = spm_vol(['C:\RESONANCE_MEG\SPM_analysis\Group\TF_AlphaModel1\spmT_' num2str(i,'%04.0f') '.img']);
    VolumeData   = spm_read_vols(VolumeHeader);
    ZI           = interp2(VolumeData,3);
    imagesc([flipdim(ZI,2)]',[-4 4]);
    colorbar; set(gca,'xtick',1:32,'xticklabel','')
    colorbar; set(gca,'ytick',1:32,'yticklabel','')
    title(['Tmap ' ListTitle{i}])
end

print('-dpng','C:\RESONANCE_MEG\SPM_analysis\Figures\GROUP_T_MAPS_ALPHAPOWER')

