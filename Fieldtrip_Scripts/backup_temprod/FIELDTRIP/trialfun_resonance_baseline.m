function trl = trialfun_resonance_baseline(cfg)

% cfg.dataset = 'C:\RESONANCE_MEG\DATA\cb100118\trans_sss\run2_raw_trans_sss.fif';
% cfg.dataset = 'C:\RESONANCE_MEG\DATA\pe110338\trans_sss\run4_raw_trans_sss.fif';

events = read_event(cfg.dataset);
hdr    = ft_read_header(cfg.dataset);

value  = [events(find(strcmp('STI101', {events.type}))).value]';
sample = [events(find(strcmp('STI101', {events.type}))).sample]';

[x,y] = find(value >= 128);

for i = 1:length(x)
    trl(i,1) = sample(x(i));
    trl(i,2) = sample(x(i)) +12*hdr.Fs;
    trl(i,3) = 0;
end
% 
% figure
% plot(sample,value)
% set(gca,'xtick',trl(:,2)','xticklabel',1:1:32)




