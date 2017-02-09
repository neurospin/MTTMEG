function EEG = EEG_for_layouts(tag)

% set root
root = SetPath(tag);

ChannelsLat = cell(1,60);
for a = 1:60
    EEG(1,a) = cellstr(['EEG0' num2str(a,'%02i')]);
end
