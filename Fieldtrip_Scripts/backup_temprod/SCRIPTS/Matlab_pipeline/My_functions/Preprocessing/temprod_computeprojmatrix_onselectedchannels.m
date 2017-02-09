
function [M,allchan,badchannels] = computeprojmatrix_onselectedchannels(subjectpath,chan_file,projfile_id)

% Compute the matrix to project PCA on the data
%
% subjectpath : the path of the directory your projection are
% chan_file   : an evoked fif file with data that contains the list of the channel 
% projfile_id : the typical name of your fif file containing the projection
%
% Input example
% subjectpath = '/neurospin/meg_tmp/MaskingError_Lucie_2009/DATA/jp090012_090414/';
% chan_file = '/neurospin/meg_tmp/MaskingError_Lucie_2009/DATA/jp090012_090414/raw_jp090012_090414_run1_trans_sss.fif';
% projfile_id = 'PCA_ECG';



% fieldtrip

proj_id = dir([subjectpath '*' projfile_id '*.fif']);


% load the PCA projection
for pf = 1:length(proj_id)
    [fid, tree, directory] = fiff_open([subjectpath proj_id(pf).name]);

    FIFF = fiff_define_constants;
    [node] = fiff_dir_tree_find(tree,FIFF.FIFFB_PROJ);

    projdata{pf} = fiff_read_proj(fid,node);
    
    
    for c = 1:length(projdata{pf})
        if strcmp(projdata{pf}(c).data.col_names{1}(1:3),'MEG')
            if strcmp(projdata{pf}(c).data.col_names{1}(end),'1')
                projdata{pf}(c).channel_type = 'mag';
            else
                projdata{pf}(c).channel_type = 'grad';
            end
        elseif strcmp(projdata{pf}(c).data.col_names{1}(1:3),'EEG')
            projdata{pf}(c).channel_type = 'eeg';
        end
    end
end


% load the normal list of the channels
info = fiff_read_meas_info(chan_file);

% Load the index of each type of channel
[eeg,mag,grad,MEG,allchan] = loadchan2(info);


% Create the matrix that will contain the "cardiac" components vectors that we found
% with the ICA and put zeros in it as a start
colnum = 0;
for i = 1:length(proj_id)
    colnum = colnum + length(projdata{i});
end
P = zeros(length(info.ch_names),colnum);


% Put the "cardiac" and blink components vectors at the correct place in
% the P matrix and put the name of the channel discarded in a array of
% cells
col = 0;
badchannels = [];
for n = 1:length(proj_id) % grad, mag, eeg and EOG or ECG ie should be 6
    for p = 1:length(projdata{n}) % componenent number in each chan_type
        col = col + 1;
        for chan = 1: length(projdata{n}(p).data.col_names) % for all the channle for which we computed th PCA
            chan_ind = find(strcmp(projdata{n}(p).data.col_names{chan},info.ch_names)); % this is the index in the real data of this channel          
            P(chan_ind,col) = projdata{n}(p).data.data(chan);
        end
        difchan = setxor(info.ch_names(eval(projdata{n}(p).channel_type)),projdata{n}(p).data.col_names);
        badchannels = [badchannels difchan];
    end
end
badchannels = unique(badchannels);


% Orthogonalize the P matrix (thanks to wikipedia !)
[U,S,V] = svd(P);
P = U*eye(length(U),col)*V';

% Compute de projection matrix that you can multiply your data with ( the multiplication will suppress the component found with
% the PCA that are related to the artifacts)
M = eye(length(info.ch_names)) - P*P';


