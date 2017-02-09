function [trl1] = trialfun_mtt_cue_time(cfg)

cfg.dataset = 'C:\MTT_MEG\data\subj1\run1_left_trans_sss.fif';

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

for i = 1:length(value)
    if value(i) < 256
        valuetrig(i) = value(i);
    elseif (value(i) >= 256) && (value(i) < 512)
        valuetrig(i) = value(i) - 256;
    elseif (value(i) >= 512)
        valuetrig(i) = value(i) - 512;
    end
end

tmp1 = sample;
tmp2 = [sample(2:end); 0];
tmp3 = tmp2 - tmp1;

B = [sample valuetrig' tmp3];
B(end,:) = [];

lim = ceil(length(sample)/100);
len = size(B,1);
B((len+1):(lim*100),:) = NaN;

%%%%%%%%%%%%%%%%%%%%% TRIGGER DEF %%%%%%%%%%%%%%%%%%%%%%%%%%%
% for i = 1:lim
%     subplot(4,1,i)
%     plot(B(((i-1)*100 + 1):((i-1)*100 + 100),3),'color','k','marker','o'); 
%     line([1 100],[2685 2685],'linestyle','--'); 
%     line([1 100],[1014 1014],'linestyle','--');
%     line([1 100],[525 525],'linestyle','--');
%     axis([1 100 0 5300])
% end

PSYCH = load(cfg.psychinfo);

a = 1;
indoI1 = [];
for i = 1:len
    if (B(i,3) == 2685) || (B(i,3) == 2684) || (B(i,3) == 2686)
        indoI1(a) = i ;
        a = a + 1;
    end
end

a = 1;
indoI2 = [];
for i = 1:len
    if (B(i,3) == 1014) || (B(i,3) == 1015) || (B(i,3) == 1016)
        indoI2(a) = i;
        a = a + 1;
    end
end

indOk = intersect((indoI1 - ones(1,length(indoI1))),indoI2);

% plot rescued triggers
for i = 1:lim
    plot(B(1:lim*100,1),B(1:lim*100,3),'color','k','marker','o');
end
hold on
for i = 1:length(indoI1)
    plot(B(indoI1(i),1),B(indoI1(i),3),'marker','o','color','r','linewidth',3)
    hold on
end
for i = 1:length(indoI2)
    plot(B(indoI2(i),1),B(indoI2(i),3),'marker','o','color','b','linewidth',3)
    hold on
end
line([sample(1) sample(len)],[2685 2685],'linestyle','--'); hold on;
line([sample(1) sample(len)],[1015 1015],'linestyle','--'); hold on;
axis([sample(1) sample(len) 0 6000])  
    
%% define rescued trl

trl1 = [];
a = 1;
for i = 1:length(indOk)
    trl1(a,1) = B(indOk(i),1) - 2685 + cfg.trialdef.prestim*hdr.Fs  + cfg.photodelay;
    trl1(a,1) = B(indOk(i),1) - 2685 + cfg.trialdef.poststim*hdr.Fs + cfg.photodelay;
    trl1(a,3) = 0;
    a = a+1;
end

trl2 = [];
a = 1;
indrescue2 = setdiff(indoI2,indOk);
if isempty(indrescue2) == 0
    for i = 1:length(indrescue2)
        trl2(a,1) = B(indrescue2(i),1) + cfg.trialdef.prestim*hdr.Fs  + cfg.photodelay;
        trl2(a,1) = B(indrescue2(i),1) + cfg.trialdef.poststim*hdr.Fs + cfg.photodelay;
        trl2(a,3) = 0;
        a = a+1;
    end
end


trl3 = [];
a = 1;
indrescue3 = setdiff(indoI1,indoI2+1);
if isempty(indrescue3) == 0
    for i = 1:length(indrescue3)
        trl3(a,1) = B(indrescue3(i),1) - 2685 + cfg.trialdef.prestim*hdr.Fs  + cfg.photodelay;
        trl3(a,1) = B(indrescue3(i),1) - 2685 + cfg.trialdef.poststim*hdr.Fs + cfg.photodelay;
        trl3(a,3) = 0;
        a = a+1;
    end
end  
    
    
    
    
    