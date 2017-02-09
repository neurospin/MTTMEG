function trl = trialfun_resonance_localizerface(cfg)

cfg.dataset = 'C:\RESONANCE_MEG\DATA\MEG\cb100118\trans_sss\localizer_raw_trans_sss.fif';

events = ft_read_event(cfg.dataset);
hdr    = ft_read_header(cfg.dataset);

value  = [events(find(strcmp('STI101', {events.type}))).value]';
sample = [events(find(strcmp('STI101', {events.type}))).sample]';

a = 0;
for i = 1:(size(value,1)-1)
    if value(i) == 1
        a = a + 1;
        trl(a,1) = sample(i) + cfg.photodelay*hdr.Fs - 0.2*hdr.Fs; % add photodelay and baseline timepoints
        trl(a,2) = sample(i) + 0.5*hdr.Fs + cfg.photodelay*hdr.Fs - 0.2*hdr.Fs;
        trl(a,3) = 0;
    end
end

% figure
% plot(sample,value)
% set(gca,'xtick',trl(:,2)','xticklabel',1:1:32)




