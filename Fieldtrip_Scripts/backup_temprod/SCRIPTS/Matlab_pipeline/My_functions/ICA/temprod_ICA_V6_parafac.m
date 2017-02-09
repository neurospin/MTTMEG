function temprod_ICA_V6_parafac(index,subject,freqband,numcomponent)

Dir = ['/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject];

for a = 1:8
    eval(['datapath' num2str(a) '= [''/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_'...
        subject '/run' num2str(a) '.mat'']']);
end

[Gradslong, Gradslat] = grads_for_layouts;
channeltype = {'MEG*1';Gradslong;Gradslat};
chan_index  = {'Mags';'Gradslong';'Gradslat'};
chan_cmt    = {'M';'G1';'G2'};

[GradsLong,GradsLat,Mags]     = grads_for_layouts;

durinfopath = [Dir '/FT_trials/runICA' num2str(index) 'durinfo.mat'];
info = load(durinfopath);

a = 1;
datatmp = [];
for i = 1:size(info.info,1)
    load(fullfile(Dir,['/FT_trials/runICA' num2str(index) 'trial' num2str(i,'%03i') '.mat']))
    N(i)          = length(data.time{1});
    datatmp       = [datatmp data.trial{1,1}];
    a = a + N(i);
end

Factors     = parafac(datatmp,numcomponent);
topos       = Factors{1,1};
timecourses = (Factors{1,2})';

begtrial = 1;
endtrial = N(1);
for i = 1:(size(info.info,1))
    comp_topo.trial{1,i} = timecourses(:,begtrial:endtrial);
    comp_topo.time{1,i}  = 0:0.004:0.004*(N(i)-1);
    if i < (size(info.info,1))
        begtrial = endtrial + 1;
        endtrial = begtrial + N(i+1) -1;
    end
end
for i = 1:numcomponent
    comp_topo.label{i,1} = ['parafac'  num2str(i,'%03i')];
end

comp_topo.fsample     = data.fsample;
comp_topo.grad        = data.grad;
comp_topo.topolabel   = data.label;
comp_topo.topo        = topos;
comp_topo.cfg.numcomponent = numcomponent;

clear data

%% compute power spectra density on pca components
clear cfg
cfg.channel            = 'all';
cfg.method             = 'mtmfft';
cfg.output             = 'pow';
cfg.taper              = 'dpss';
cfg.tapsmofrq          = 1;
cfg.foi                = freqband(1):0.1:freqband(2);
cfg.trials             = 'all';
cfg.keeptrials         = 'yes';
cfg.keeptapers         = 'no';
% cfg.pad                = MaxLength/FSAMPLE;
freq                   = ft_freqanalysis(cfg, comp_topo);

% if removenoise == 1
%     Nfbegin                = find(freq.freq >= 90);
%     Nfend                  = find(freq.freq <= 94);
%     Nfband                 = Nfbegin(1):Nfend(end);
%     for i = 1:size(freq.powspctrm,1)
%         for j = 1:size(freq.powspctrm,2)
%             L = linspace(freq.powspctrm(i,j,Nfbegin(1)),... % beginning of the range
%                 freq.powspctrm(i,j,Nfend(end)),... % end of the range
%                 Nfend(end) - Nfbegin(1) + 1); % number of frequency bins to replace
%             freq.powspctrm(i,j,Nfband) = L;
%         end
%     end
% end

freqcomppath           = [par.ProcDataDir '/FT_ICs/parafac-comp' num2str(numcomponent) 'V5_freq' num2str(index) '.mat'];
save(freqcomppath,'freq','comp_topo','freqband','cfg');
