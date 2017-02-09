function dataM=ns_pca(par,data)
% function dataM = ns_pca(par,data)
% applies ECG-EOG PCA components to ft dataset

% set parameters
subjectpath=par.DataDir;                % the path of the directory containing your projection
chan_file=[par.DataDir par.Sub_Num par.pcaproj];    % an evoked fif file with data that contains the list of the channel    
projfile_id = par.projfile_id;          % ECG-EOG PCA projection file suffix

% compute projection matrix
[M,allchan,badchannels] = computeprojmatrix_onselectedchannels(subjectpath,chan_file,projfile_id);

%%%%%%%%%%%%%%%%%%%%%%%%%% MEG ONLY %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M = M(323:382,323:382);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% apply projection matrix on data
dataM=data;
for i=1:length(data.trial)
    dataM.trial{i}=M*data.trial{i};
end;