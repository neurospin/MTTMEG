function trl = trialfun_temprod_OLD_cond1(cfg)

% cfg.dataset = '/neurospin/meg_tmp/temprod_Baptiste_2010/DATA/OLD/Trans_sss_s03/s03_run8_raw_sss.fif';

events = ft_read_event(cfg.dataset);

value  = [events(find(strcmp('STI101', {events.type}))).value]';
sample = [events(find(strcmp('STI101', {events.type}))).sample]';

a = 0;

for i = 1:2
    if (value(i) == 1) || (value(i) == 2) || (value(i) == 3) || (value(i) == 4) || (value(i) == 5) || (value(i) == 6) 
        trl(1,1) = sample(i) ;
        trl(1,2) = sample(i+2);
        trl(1,3) = 0; 
        a = 1;
    end
end

for i = 2:(size(value,1)-3)
    if (value(i) == 16395) || (value(i) == 16396) || (value(i) == 16397) || (value(i) == 16398) || (value(i) == 16399) || (value(i) == 16400)    
        a = a + 1;
        trl(a,1) = sample(i) ;
        trl(a,2) = sample(i+3);
        trl(a,3) = 0;  
        if trl(a,2) - trl(a,1) < 2000
            trl(a,1) = sample(i) ;
            trl(a,2) = sample(i+5);
            trl(a,3) = 0;
        end
    end
end

% for i = 1:size(trl, 1)
%     durations(i) = trl(i,2) - trl(i,1);
% end
% 
% outlier = []; a = 0;
% q1                  = prctile(durations,25); % first quartile
% q3                  = prctile(durations,75); % third quartile
% myiqr               = iqr(durations);        % interquartile range
% lower_inner_fence   = q1 - 3*myiqr;
% upper_inner_fence   = q3 + 3*myiqr;
% 
% for i = 1:length(durations)
%     if durations(i) < lower_inner_fence || durations(i) > upper_inner_fence
%         a = a + 1;
%         index(a) = i;
%     end
% end
% 
% if sum(a) ~= 0
%     trl(a,:) = [];
% end


