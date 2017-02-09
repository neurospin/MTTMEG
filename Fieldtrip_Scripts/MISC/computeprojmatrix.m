
function [M,allchan] = computeprojmatrix(subjectpath,chan_file,projfile_id)

% Compute the matrix to project PCA on the data
%
% subjectpath : the path of the directory your projection are
% chan_file   : an evoked fif file with data that contains the list of the channel 
% projfile_id : the typical name of your fif file containing the projection
%
% Input example
subjectpath = 'C:\MTT_MEG\data\sd130343\';
chan_file = 'C:\MTT_MEG\data\sd130343\run1_GD_trans_sss.fif';
projfile_id = 'PCA_';



% fieldtrip

proj_id = dir([subjectpath '*' projfile_id '*.fif']);


% load the PCA projection
for pf = 1:length(proj_id)
    [fid, tree, directory] = fiff_open([subjectpath proj_id(pf).name]);

    FIFF = fiff_define_constants;
    [node] = fiff_dir_tree_find(tree,FIFF.FIFFB_PROJ);

    projdata{pf} = fiff_read_proj(fid,node);
    
    for c = 1:length(projdata{pf})
        if length(projdata{pf}(c).data.data) == 204
            projdata{pf}(c).channel_type = 'grad';
        elseif length(projdata{pf}(c).data.data) == 102
            projdata{pf}(c).channel_type = 'mag';
        elseif length(projdata{pf}(c).data.data) == 60
            projdata{pf}(c).channel_type = 'eeg';
        elseif length(projdata{pf}(c).data.data) == 366
            projdata{pf}(c).channel_type = 'allchan';
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


% Put the "cardiac" and blink components vectors at the correct place in the P matrix
col = 0;
for n = 1:length(proj_id) % grad, mag, eeg
    for p = 1:length(projdata{n}) % componenent number in each chan_type
        col = col + 1;
        P(eval(projdata{n}(p).channel_type),col) = projdata{n}(p).data.data;
    end
end


% Orthogonalize the P matrix (thanks to wikipedia !)
[U,S,V] = svd(P);
P = U*eye(length(U),col)*V';

% Compute de projection matrix that you can multiply your data with ( the multiplication will suppress the component found with
% the PCA that are related to the artifacts)
M = eye(length(info.ch_names)) - P*P';


