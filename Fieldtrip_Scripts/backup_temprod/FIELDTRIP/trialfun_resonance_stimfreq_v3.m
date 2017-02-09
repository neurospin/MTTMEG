function trl = trialfun_resonance_stimfreq(cfg)

% cfg.dataset = 'C:\RESONANCE_MEG\DATA\MEG\pe110338\trans_sss\run2_raw_trans_sss.fif';
cfg.dataset = 'C:\RESONANCE_MEG\DATA\MEG\cl120289\trans_sss\stimfreq_run1_trans_sss.fif';

events = read_event(cfg.dataset);
hdr    = ft_read_header(cfg.dataset);

value  = [events(find(strcmp('STI101', {events.type}))).value]';
sample = [events(find(strcmp('STI101', {events.type}))).sample]';

[x,y] = find(value >= 128);

for i = 1:length(x)
    trl(i,1) = sample(x(i)) - 12*hdr.Fs;
    trl(i,2) = sample(x(i));
    trl(i,3) = 0;
end

b = value(x) - ones(length(trl),1)*128;
onsets = [trl(:,1:2) b];

for i = 1:length(trl)
    if onsets(i,3) == 1 || onsets(i,3) == 2 || onsets(i,3) == 3 || onsets(i,3) == 4
        onsets(i,4) = 40;
    elseif onsets(i,3) == 5 || onsets(i,3) == 6 || onsets(i,3) == 7 || onsets(i,3) == 8
        onsets(i,4) = 65;          
    elseif onsets(i,3) == 9 || onsets(i,3) == 10 || onsets(i,3) == 11 || onsets(i,3) == 12
        onsets(i,4) = 90;
    elseif onsets(i,3) == 13 || onsets(i,3) == 14 || onsets(i,3) == 15 || onsets(i,3) == 16
        onsets(i,4) = 140;
    elseif onsets(i,3) == 17 || onsets(i,3) == 18 || onsets(i,3) == 19 || onsets(i,3) == 20
        onsets(i,4) = 190;
    elseif onsets(i,3) == 21 || onsets(i,3) == 22 || onsets(i,3) == 23 || onsets(i,3) == 24
        onsets(i,4) = 290;
    elseif onsets(i,3) == 25 || onsets(i,3) == 26 || onsets(i,3) == 27 || onsets(i,3) == 28
        onsets(i,4) = 390;
    elseif onsets(i,3) == 29 || onsets(i,3) == 30 || onsets(i,3) == 31 || onsets(i,3) == 32
        onsets(i,4) = 590;
    end
end

onsets = [onsets(:,4) onsets(:,3) onsets(:,1) onsets(:,2)];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% match NIP
NIPstr = strfind(cfg.dataset,'trans_sss');
NIP = cfg.dataset((NIPstr(1)-9):(NIPstr-2));
% match run
runstr = strfind(cfg.dataset,'run');
run = cfg.dataset((runstr(1)+3));

% write results in a text file
Dir = ['C:\RESONANCE_MEG\STIMS\' NIP '_Timing_run' run];
c = clock;
file = [Dir '_' num2str(c(1)) '-' num2str(c(2),'%02i') '-' num2str(c(3),'%02i') '.txt'];
fileID = fopen(file,'w');

DATAforR1 = []; DATAforR2 = [];
% cell-array
DATAforR1 = onsets;
DATAforR2{1,1} = 'Beg';
DATAforR2{1,2} = 'End';
DATAforR2{1,3} = 'Code';

for i = 1:size(DATAforR1,1)
    for j = 1:size(DATAforR1,2)
        DATAforR2{i+1,j} = DATAforR1(i,j);
    end
end

% write data in a text file readable by R
for i = 1:size(DATAforR2,1)
    for j = 1:size(DATAforR2,2)
        if j == 1
            fprintf(fileID, '%s', [' ' num2str(DATAforR2{i,j})]);
        elseif j < size(DATAforR2,2)
            fprintf(fileID, '%s', [' ' num2str(DATAforR2{i,j})]);
        elseif j == size(DATAforR2,2)
            fprintf(fileID, '%s\n', [' ' num2str(DATAforR2{i,j})]);
        end
    end
end
close all



