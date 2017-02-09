function b = trialfun_resonance_stimfreq_v2(dataset)

cfg.dataset = 'C:\RESONANCE_MEG\DATA\cb100118\trans_sss\run2_raw_trans_sss.fif';
% cfg.dataset = 'C:\RESONANCE_MEG\DATA\cb100118\trans_sss\run2_raw_trans_sss.fif';
% cfg.dataset = 'C:\RESONANCE_MEG\DATA\pe110338\trans_sss\run4_raw_trans_sss.fif';
% cfg.dataset = 'C:\RESONANCE_MEG\DATA\ns110383\trans_sss\run4_raw_trans_sss.fif';

events = read_event(dataset);
hdr    = ft_read_header(dataset);

value  = [events(find(strcmp('STI101', {events.type}))).value]';
sample = [events(find(strcmp('STI101', {events.type}))).sample]';

[x,y] = find(value >= 128);

b = value(x) - ones(32,1)*128;

