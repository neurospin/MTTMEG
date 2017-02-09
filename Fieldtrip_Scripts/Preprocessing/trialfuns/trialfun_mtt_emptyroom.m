function [trl] = trialfun_mtt_emptyroom(cfg)

%% test dataset
cfg.dataset = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/sd130343/raw_sss/emptyroom_trans_sss.fif';

%% get recording trigger value and corresponding samples
events = ft_read_event(cfg.dataset);
hdr    = ft_read_header(cfg.dataset);

for i = 1:1:120
    trl(i,1) = i*1000;
    trl(i,2) = i*1000 +1000-1; 
    trl(i,3) = 0;
end