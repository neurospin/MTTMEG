function [trl] = trialfun_mtt_future_distfar(cfg)

%% test dataset
% cfg.dataset = 'C:\MTT_MEG\data\subj2\run1_left_trans_sss.fif'

%% get recording trigger value and corresponding samples
events = ft_read_event(cfg.dataset);
hdr    = ft_read_header(cfg.dataset);

value  = [events(find(strcmp('STI101', {events.type}))).value]';
sample = [events(find(strcmp('STI101', {events.type}))).sample]';

% trl1 = [];
% trl2 = [];
% x    = [];
% y    = [];
% 
% [x,y] = find(value == 1);
% 
% for i = 1:length(x)
%     trl1(i,1) = sample(x(i)) - cfg.trialdef.prestim*hdr.Fs + cfg.photodelay;
%     trl1(i,2) = sample(x(i)) + cfg.trialdef.poststim*hdr.Fs + cfg.photodelay;
%     trl1(i,3) = 0;
% end
% 
% x = []; y = [];
% [x,y] = find(value == 2);
% 
% for i = 1:length(x)
%     trl2(i,1) = sample(x(i));
%     trl2(i,2) = sample(x(i)) + 0.5*hdr.Fs;
%     trl2(i,3) = 0;
% end

%% remove responses trigger values
if (strfind(cfg.dataset,'right')) ~= 0

    for i = 1:length(value)
        if value(i) < 8192
            valuetrig(i) = value(i);
        elseif (value(i) >= 8192) && (value(i) < 16384)
            valuetrig(i) = value(i) - 8192;
        elseif (value(i) >= 16384)
            valuetrig(i) = value(i) - 16384;
        end
    end

elseif (strfind(cfg.dataset,'left')) ~= 0
        
     for i = 1:length(value)
        if value(i) < 256
            valuetrig(i) = value(i);
        elseif (value(i) >= 256) && (value(i) < 512)
            valuetrig(i) = value(i) - 256;
        elseif (value(i) >= 512)
            valuetrig(i) = value(i) - 512;
        end    
     end
end
    
x = []; y = [];
[x,y] = find(valuetrig == 17| valuetrig == 20);

photodelay =repmat([0.048 0.058 0.058 0.058],1,3);

for i = 1:length(x)
    trl(i,1) = sample(y(i)) - cfg.trialdef.prestim*hdr.Fs + photodelay(i)*hdr.Fs;
    trl(i,2) = sample(y(i)) + cfg.trialdef.poststim*hdr.Fs + photodelay(i)*hdr.Fs;
    trl(i,3) = 0;
end
