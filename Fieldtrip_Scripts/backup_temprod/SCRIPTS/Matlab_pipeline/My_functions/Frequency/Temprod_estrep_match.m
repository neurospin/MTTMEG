function Temprod_estrep_match(subject,RunArray,chantype,Target,tag)

% % set root
root = SetPath(tag);

% subject  = 's14';
% RunArray = [2 4];
% freqband = [1 120];
% chantype = 'Mags';
% tag      = 'Laptop';
% Target   = [5.7 5.7];

%% I) load uncorrected data
% set data path and load data
for i = 1:2
    ProcDataDir                    = [root '/DATA/NEW/processed_' subject '/'];
    DataDir                        = [ProcDataDir 'FT_trials/BLOCKTRIALS_' chantype '_RUN' num2str(RunArray(i),'%02i') '.mat'];
    eval(['data' num2str(i) ' = load(DataDir)']);
end

%% (2) apply a selection filter to the dataset
data1                   = Temprod_DataSelect(data1,'no','no','no',Target(1));
data2                   = Temprod_DataSelect(data2,'no','no','no',Target(2));

% compute inconsistencies in trial number
diff_nb = abs([size(data2.duration,1) - size(data1.duration,1)]);
maxsize = max(length(data1.duration),length(data2.duration));
if maxsize == length(data1.duration)
    shorterdata = data2.duration;
    shorterdata = [shorterdata ; ones(diff_nb,2)*NaN];
    longerdata  = data1.duration;
    legend1 = 'est'; legend2 = 'rep';
else
    shorterdata = data1.duration;
    shorterdata = [shorterdata ; ones(diff_nb,2)*NaN];    
    longerdata  = data2.duration;
    legend1 = 'rep'; legend2 = 'est';
end

figure

subplot(1,2,1)
plot([longerdata(:,1) shorterdata(:,1)],'linewidth',2)
legend(legend1, legend2)
grid('on')
set(gca,'XMinorGrid','on')

% compute euclidian distance matrix
DMAT = sqdist(longerdata(:,1)',shorterdata(:,1)');

subplot(1,2,2)
mask = (DMAT <= 0.5);
imagesc(DMAT.*mask)
xlabel(legend1)
ylabel(legend2)

% interactive correction
InData  = input('which dataset do you want to correct? :');
InPoint = input('enter a datapoint to remove :');
while isempty(InPoint) == 0
    
    if strcmp(InData,'est') && strcmp(legend1,'est')
        longerdata(InPoint,:)  = [];
        longerdata             = [longerdata ; NaN NaN];
    elseif strcmp(InData,'est') && strcmp(legend2,'est')
        shorterdata(InPoint,:) = [];
        shorterdata            = [shorterdata ; NaN NaN];
    elseif strcmp(InData,'rep') && strcmp(legend1,'rep')
        longerdata(InPoint,:)  = [];
        longerdata             = [longerdata ; NaN NaN];
    elseif strcmp(InData,'rep') && strcmp(legend2,'rep')
        shorterdata(InPoint,:) = [];
        shorterdata            = [shorterdata ; NaN NaN];
    end
    
    figure
    
    subplot(1,2,1)
    plot([longerdata(:,1)  shorterdata(:,1)],'linewidth',2)
    legend(legend1, legend2)
    grid('on')
    set(gca,'XMinorGrid','on')
    
    % compute euclidian distance matrix
    DMAT = sqdist(longerdata(:,1)',shorterdata(:,1)');
    
    subplot(1,2,2)
    mask = (DMAT <= 0.5);
    imagesc(DMAT.*mask)
    xlabel(legend1)
    ylabel(legend2)
    
    InData  = input('which dataset do you want to correct? :');
    InPoint = input('enter a datapoint to remove :');
    
end

if maxsize == length(data1.duration)
    data.matchest = longerdata;
    data.matchrep = shorterdata;        
else
    data.matchest = shorterdata;
    data.matchrep = longerdata;     
end

ProcDataDir                    = [root '/DATA/NEW/processed_' subject '/'];
DataDir                        = [ProcDataDir 'FT_trials/matchestrep_' chantype '_RUN' num2str(RunArray(i),'%02i') '.mat'];

save(DataDir,'-struct','data','matchest','matchrep')

print('-dpng',['C:\TEMPROD\DATA\NEW\across_subjects_plots\' subject '_' chantype '_' ...
    num2str(RunArray(1)) '-' num2str(RunArray(2)) 'Hz'])




