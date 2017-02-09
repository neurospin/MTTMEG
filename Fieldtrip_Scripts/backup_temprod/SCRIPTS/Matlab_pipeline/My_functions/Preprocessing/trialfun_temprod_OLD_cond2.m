function trl = trialfun_temprod_OLD_cond2(cfg)

% cfg.dataset = '/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Trans_sss_s04/s04_run1_raw_sss.fif';

events = ft_read_event(cfg.dataset);
hdr    = ft_read_header(cfg.dataset);

value  = [events(find(strcmp('STI101', {events.type}))).value]';
sample = [events(find(strcmp('STI101', {events.type}))).sample]';

Vindex0  = find(value(1:length(value)) == 16384);
Vindex   = find(value(1:length(value)) == 16395);

if isempty(Vindex) == 1
    Vindex = Vindex0;
end

for i = 2:length(Vindex)
    trl(i-1,1) = sample(Vindex(i-1)) - cfg.trialdef.prestim*hdr.Fs;
    trl(i-1,2) = sample(Vindex(i))   + cfg.trialdef.poststim*hdr.Fs;
    trl(i-1,3) = 0;
end

