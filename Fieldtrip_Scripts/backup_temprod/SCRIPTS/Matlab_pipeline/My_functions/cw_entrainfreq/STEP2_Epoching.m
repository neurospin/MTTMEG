%%%%%%%%%%%%%%%%%%
% This script loads the ssp_trans corrected data. It applies PCA to them
% and epochs them for each condition. 
% Input : the subject names
% Output : the saved files par subject and per condition with all epoched
% trials
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

addpath '/neurospin/local/mne/i686/share/matlab/'     % MNE (needed to read and import fif data in fieldtrip)
% addpath '/neurospin/meg_tmp/tools_tmp/pipeline_tmp/'  % Neurospin pipeline scripts
% addpath '/neurospin/meg_tmp/PipelineTest/scripts/'    % local processing scripts
addpath '/neurospin/local/fieldtrip/'                 % fieldtrip
ft_defaults                                           % sets fieldtrip defaults and configures the minimal required path settings
addpath '/neurospin/meg/meg_tmp/entrainFreq_AnneCatherineBaptiste_2011/scripts/from_cw';

GlobalPath = '/neurospin/meg/meg_tmp/entrainFreq_AnneCatherineBaptiste_2011/';
subjects = {'test_pilote', 'test_test'};
close all
clc
freq = [1.5 3 6 12 24];
name_freq = {'01', '03', '06', '12' '24'};
discrim_triggers = [16 18 20 22 24];

for subject = 1:length(subjects)
    if ~exist([GlobalPath subjects{subject} '/Fieldtrip/'],'dir')
        mkdir([GlobalPath subjects{subject} '/Fieldtrip/'])
    end
    % recognize all maxfiltered data
    a = dir([GlobalPath subjects{subject} '/maxfilter/*trans_sss.fif']);
    for run = 1:length(a)
        cfg = [];
        cfg.dataset     = [GlobalPath subjects{subject} '/maxfilter/' a(run).name];
        hdr = ft_read_header(cfg.dataset);
        [EEG, MEGm, MEGg, MEG, ALL] = loadchan_fieldtrip(hdr.label);
        cfg.chantypes               = {MEGg, MEGm};
        cfg.channel                 = {'all', '-CHPI*' };
        cfg.lpfilter                = 'yes';
        cfg.lpfreq                  = 50;
        cfg.threshold_eog           = 2;
        cfg.mode_reject_ecg         = 'fix_num';
        cfg.mode_reject_eog         = 'comp_other';
        data_corr                   = cw_correct_ecgeog(cfg);pause(0.05);
        
        

        %% defining the trl
        eventtype      = 'STI101';
        disp(['epoching file : ' a(run).name])
                
        event = ft_read_event(cfg.dataset);
        sel = find(strcmp(eventtype, {event.type}));
        eventvalue = unique([event(sel).value]);
        Ntrig = hist([event(sel).value],eventvalue);
        std_trig = eventvalue(Ntrig==max(Ntrig));        
        info = [];
        info.trig = std_trig;
        info.modal = a(run).name(1);
        info.freq = freq(find(discrim_triggers==std_trig));
        info.namef = name_freq{find(discrim_triggers==std_trig)};
        T = 1/info.freq;
        if info.freq~=1.5
            continue
        end
        
%%         Epoch definition: Prestimulus and poststimulus time extremes in seconds
        cfg = [];
        cfg.dataset                 = [GlobalPath subjects{subject} '/maxfilter/' a(run).name];
        cfg.trialdef.channel      = 'STI101';
        cfg.trialdef.prestim        = 4*T;
        cfg.trialdef.poststim       = 4*T;
        cfg.delay                   = 0.051;    
        cfg.trialfun                = 'cw_entrainFreq_trialfun2';
        cfg.event                   = event;
        cfg.trialdef.eventvalue     = info.trig;
        cfg                         = ft_definetrial(cfg);
        
        
        disp(['main event value was ' num2str(std_trig) ', deduced frequency is ' num2str(info.freq) ' in modality ' info.modal]);
        
        dataM = cw_epoch_trials(cfg, data_corr);
        
        
        %         for j=1:length(dataM.trial)
        %             dataM.trial{j} = ft_preproc_baselinecorrect(dataM.trial{j}, 1, dataM.fsample*.5);
        %         end
        
        name_save = [GlobalPath subjects{subject} '/Fieldtrip/alltrials_' info.modal '_' info.namef];
        disp(['saving preprocesses data to ' name_save])
        save(name_save, 'dataM', '-v7.3')
        disp('done')
        clear dataM
    end
    
end


