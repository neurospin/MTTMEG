function [trl1, trl2] = trialfun_mtt_cue_space(cfg)

% cfg.dataset = 'C:\MTT_MEG\data\subj1\run1_left_trans_sss.fif';

events = ft_read_event(cfg.dataset);
hdr    = ft_read_header(cfg.dataset);

value  = [events(find(strcmp('STI101', {events.type}))).value]';
sample = [events(find(strcmp('STI101', {events.type}))).sample]';

trl1 = [];
trl2 = [];
x    = [];
y    = [];

[x,y] = find(value == 2);

for i = 1:length(x)
    trl1(i,1) = sample(x(i)) - cfg.trialdef.prestim*hdr.Fs;
    trl1(i,2) = sample(x(i)) + cfg.trialdef.poststim*hdr.Fs;
    trl1(i,3) = 0;
end

% x = []; y = [];
% [x,y] = find(value == 2);
% 
% for i = 1:length(x)
%     trl2(i,1) = sample(x(i));
%     trl2(i,2) = sample(x(i)) + 0.5*hdr.Fs;
%     trl2(i,3) = 0;
% end


