function trl = trialfun_temprod_timelock_s10(cfg)

% cfg.dataset = '/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/NEW/Trans_sss_s07/s07_run1_raw_sss.fif';

events = ft_read_event(cfg.dataset);
hdr = ft_read_header(cfg.dataset);

value  = [events(find(strcmp('STI101', {events.type}))).value]';
sample = [events(find(strcmp('STI101', {events.type}))).sample]';

Vindex0  = find(value(1:length(value)) == 16384);
Vindex   = find(value(1:length(value)) == 16512);

if isempty(Vindex) == 1
    Vindex = Vindex0;
end

liminf = 2;
for i = 1:length(sample)
    if sample(i) < 0.5*hdr.Fs
        liminf = liminf + 1;
    end
end

a = 2;
for i = liminf:length(Vindex)
    trl(a-1,1) = sample(Vindex(i-1)) - 0.5*hdr.Fs;
    trl(a-1,2) = sample(Vindex(i));
    trl(a-1,3) = 0;
    a          = a + 1;
end

