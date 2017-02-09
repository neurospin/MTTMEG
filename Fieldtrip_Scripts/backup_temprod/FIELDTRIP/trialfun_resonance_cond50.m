function trialfun_resonance_cond50

cfg.dataset = 'C:\RESONANCE_MEG\DATA\cb100118\trans_sss\run1_raw_trans_sss.fif';
cfg.dataset = 'C:\RESONANCE_MEG\DATA\pe110338\trans_sss\run1_raw_trans_sss.fif';

events = read_event(cfg.dataset);
hdr    = ft_read_header(cfg.dataset);

value  = [events(find(strcmp('STI101', {events.type}))).value]';
sample = [events(find(strcmp('STI101', {events.type}))).sample]';

[x,y] = find(value > 128);

trl(1,1) = sample(x) - 12*hdr.Fs;
trl(1,2) = sample(x);
trl(1,3) = 0;






