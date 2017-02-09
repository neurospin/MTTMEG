function M = computeprojmatrix_mtt_eeg(subjectpath,chan_file,projfile_id,badEEG)
% Compute the matrix to project PCA on the data
%
% subjectpath : the path of the directory your projection are
% chan_file   : an evoked fif file with data that contains the list of the channel 
% projfile_id : the typical name of your fif file containing the projection
%
% Input example
% subjectpath = 'C:\MTT_MEG\data\sd130343\';
% chan_file = 'C:\MTT_MEG\data\sd130343\run1_GD_trans_sss.fif';
% projfile_id = 'PCA_';

% nip = 'sl130503';
% root = ['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/MEG/' nip '/raw_sss/'];
% badEEG = [25 36];
% 
% subjectpath  = root;
% chan_file      = [root 'run1_GD_trans_sss.fif'];
% projfile_id    = 'PCA_EEG';


%  fieldtrip

proj_id = dir([subjectpath '*' projfile_id '*.fif']);


% load the PCA projection
for pf = 1:length(proj_id)
    [fid, tree, directory] = fiff_open([subjectpath proj_id(pf).name]);

    FIFF = fiff_define_constants;
    [node] = fiff_dir_tree_find(tree,FIFF.FIFFB_PROJ);

    projdata{pf} = fiff_read_proj(fid,node);
    
    for c = 1:length(projdata{pf})
            projdata{pf}(c).channel_type = 'eeg';
    end
    
end

% load the normal list of the channels
info = fiff_read_meas_info(chan_file);

% Load the index of each type of channel
[eeg,mag,grad,MEG,allchan] = loadchan2(info);

% if someone forget to remove eeg064 from recored channels (it always happens!)
if length(eeg) == 61
    eeg(61) = [];
end

EEG = [eeg;1:60];
for i = 1:length(badEEG)
    [x(i),y(i)] = find(eeg(1,:) == (306+badEEG(i)));
end

% Create the matrix that will contain the "cardiac" components vectors that we found
% with the ICA and put zeros in it as a start
colnum = 0;
for i = 1:length(proj_id)
    colnum = colnum + length(projdata{i});
end
% P = zeros(length(info.ch_names),colnum);
P = zeros(60-length(badEEG),colnum);

% Put the "cardiac" and blink components vectors at the correct place in the P matrix
col = 0;
for n = 1:length(proj_id)
    for p = 1:length(projdata{n}) % component number in each chan_type
        col = col + 1;
        P(1:(60 - length(badEEG)),col) = projdata{n}(p).data.data;
    end
end


% Orthogonalize the P matrix (thanks to wikipedia !)
[U,S,V] = svd(P);
P = U*eye(length(U),col)*V';

% Compute de projection matrix that you can multiply your data with ( the multiplication will suppress the component found with
% the PCA that are related to the artifacts)
M = eye((60-length(badEEG))) - P*P';


