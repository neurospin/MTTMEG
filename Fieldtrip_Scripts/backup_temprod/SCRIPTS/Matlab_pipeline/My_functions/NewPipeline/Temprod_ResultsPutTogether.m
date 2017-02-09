function Temprod_ResultsPutTogether(SubjectArray,RunArray,freqband,condname,tag)

% SubjectArray = {'s14'         ;'s13'         ;'s12'        ;'s11'    ;'s10'        ;'s08'         ;'s07'         ;'s06'      ;'s05'    ;'s04'};
% RunArray      = {[2 5 3 6 4 7];[2 5 3 6 4 7] ;[2 5 3 6 4 7];[2 5 3 4];[2 5 3 6 4 7];[2 4 5 3 6]   ;[1 3 4 2 5 6] ;[1 3 2 4]  ;[1 3 2]  ;1:3};
% freqband      = [7 14];

% SubjectArray = {'s14'     ;'s13'     ;'s12'    ;'s11'  ;'s10'    ;'s08' ;'s07'     ;'s06';'s05';'s04'};
% RunArray      = {[2 3 5 6];[2 3 5 6] ;[2 3 5 6];[2 3 5];[2 3 5 6];2:6   ;[1 2 4 5] ;1:4  ;1:3  ;1:3};
% freqband      = [2 5];

% set root
root = SetPath(tag);
for i = 1:27
    pos_counts{i}   = zeros(1,102);
    neg_counts{i}   = zeros(1,102);   
end


for i = 1:length(SubjectArray) % loop on subjects
    % build matrices
    pos_NbChanMat_1   = zeros(length(RunArray{i,1}),9);
    pos_NbChanMat_2   = zeros(length(RunArray{i,1}),9);
    pos_NbChanMat_3   = zeros(length(RunArray{i,1}),9);
    neg_NbChanMat_1   = zeros(length(RunArray{i,1}),9);
    neg_NbChanMat_2   = zeros(length(RunArray{i,1}),9);
    neg_NbChanMat_3   = zeros(length(RunArray{i,1}),9);    
    GFPCorrMAt_R1 = zeros(length(RunArray{i,1}),9);
    GFPCorrMAt_p1 = zeros(length(RunArray{i,1}),9);
    GFPCorrMAt_R2 = zeros(length(RunArray{i,1}),9);
    GFPCorrMAt_p2 = zeros(length(RunArray{i,1}),9);
    GFPCorrMAt_R3 = zeros(length(RunArray{i,1}),9);
    GFPCorrMAt_p3 = zeros(length(RunArray{i,1}),9);
    
    
    for j = 1:length(RunArray{i,1}) % loop on runs
        chantype = 'Mags';
        % load data
        ProcDataDir = [root '/DATA/NEW/processed_' char(SubjectArray{i,1}) '/'];
        loadpath = [ProcDataDir 'FT_spectra/POW+FREQ_' chantype '_RUN' num2str(RunArray{i,1}(j),'%02i') ...
            '_' num2str(freqband(1)) '_' num2str(freqband(2)) 'Hz.mat'];
        load(loadpath)
        
        % Mags*duration
        GFPCorrMAt_R1(j,1) = Rf_dur(1,2);
        GFPCorrMAt_p1(j,1) = pf_dur(1,2);
        GFPCorrMAt_R1(j,4) = Rp_dur(1,2);
        GFPCorrMAt_p1(j,4) = pp_dur(1,2);
        GFPCorrMAt_R1(j,7) = Rs_dur(1,2);
        GFPCorrMAt_p1(j,7) = ps_dur(1,2);
        % Mags*mediandeviation
        GFPCorrMAt_R2(j,1) = Rf_med(1,2);
        GFPCorrMAt_p2(j,1) = pf_med(1,2);
        GFPCorrMAt_R2(j,4) = Rp_med(1,2);
        GFPCorrMAt_p2(j,4) = pp_med(1,2);
        GFPCorrMAt_R2(j,7) = Rs_med(1,2);
        GFPCorrMAt_p2(j,7) = ps_med(1,2);
        % Mags*accuracy
        GFPCorrMAt_R3(j,1) = Rf_acc(1,2);
        GFPCorrMAt_p3(j,1) = pf_acc(1,2);
        GFPCorrMAt_R3(j,4) = Rp_acc(1,2);
        GFPCorrMAt_p3(j,4) = pp_acc(1,2);
        GFPCorrMAt_R3(j,7) = Rs_acc(1,2);
        GFPCorrMAt_p3(j,7) = ps_acc(1,2);
        % number of correlated mags chans
        pos_NbChanMat_1(j,1) = sum(pos_selectorf_cbc_dur==1);
        pos_NbChanMat_1(j,4) = sum(pos_selectorp_cbc_dur==1);
        pos_NbChanMat_1(j,7) = sum(pos_selectors_cbc_dur==1);
        pos_NbChanMat_2(j,1) = sum(pos_selectorf_cbc_med==1);
        pos_NbChanMat_2(j,4) = sum(pos_selectorp_cbc_med==1);
        pos_NbChanMat_2(j,7) = sum(pos_selectors_cbc_med==1);
        pos_NbChanMat_3(j,1) = sum(pos_selectorf_cbc_acc==1);
        pos_NbChanMat_3(j,4) = sum(pos_selectorp_cbc_acc==1);
        pos_NbChanMat_3(j,7) = sum(pos_selectors_cbc_acc==1);
        neg_NbChanMat_1(j,1) = sum(pos_selectorf_cbc_dur==0);
        neg_NbChanMat_1(j,4) = sum(pos_selectorp_cbc_dur==0);
        neg_NbChanMat_1(j,7) = sum(pos_selectors_cbc_dur==0);
        neg_NbChanMat_2(j,1) = sum(pos_selectorf_cbc_med==0);
        neg_NbChanMat_2(j,4) = sum(pos_selectorp_cbc_med==0);
        neg_NbChanMat_2(j,7) = sum(pos_selectors_cbc_med==0);
        neg_NbChanMat_3(j,1) = sum(pos_selectorf_cbc_acc==0);
        neg_NbChanMat_3(j,4) = sum(pos_selectorp_cbc_acc==0);
        neg_NbChanMat_3(j,7) = sum(pos_selectors_cbc_acc==0);
        % correlated channels count lists
        % mags*dur
        if isempty(pos_selectorf_cbc_dur) == 0
            for h = 1:length(pos_selectorf_cbc_dur)
                if pos_selectorf_cbc_dur(h) == 1
                    pos_counts{1}(selectorf_cbc_dur(h)) = pos_counts{1}(selectorf_cbc_dur(h))+1;
                elseif pos_selectorf_cbc_dur(h) == 0
                    neg_counts{1}(selectorf_cbc_dur(h)) = neg_counts{1}(selectorf_cbc_dur(h))+1;
                end
            end
        end
        if isempty(pos_selectorp_cbc_dur) == 0
            for h = 1:length(pos_selectorp_cbc_dur)
                if pos_selectorp_cbc_dur(h) == 1
                    pos_counts{10}(selectorp_cbc_dur(h)) = pos_counts{10}(selectorp_cbc_dur(h))+1;
                elseif pos_selectorp_cbc_dur(h) == 0
                    neg_counts{10}(selectorp_cbc_dur(h)) = neg_counts{10}(selectorp_cbc_dur(h))+1;
                end
            end
        end    
        if isempty(pos_selectors_cbc_dur) == 0
            for h = 1:length(pos_selectors_cbc_dur)
                if pos_selectors_cbc_dur(h) == 1
                    pos_counts{19}(selectors_cbc_dur(h)) = pos_counts{19}(selectors_cbc_dur(h))+1;
                elseif pos_selectors_cbc_dur(h) == 0
                    neg_counts{19}(selectors_cbc_dur(h)) = neg_counts{19}(selectors_cbc_dur(h))+1;
                end
            end
        end           
        % mags*med
        if isempty(pos_selectorf_cbc_med) == 0
            for h = 1:length(pos_selectorf_cbc_med)
                if pos_selectorf_cbc_med(h) == 1
                    pos_counts{4}(selectorf_cbc_med(h)) = pos_counts{4}(selectorf_cbc_med(h))+1;
                elseif pos_selectorf_cbc_med(h) == 0
                    neg_counts{4}(selectorf_cbc_med(h)) = neg_counts{4}(selectorf_cbc_med(h))+1;
                end
            end
        end
        if isempty(pos_selectorp_cbc_med) == 0
            for h = 1:length(pos_selectorp_cbc_med)
                if pos_selectorp_cbc_med(h) == 1
                    pos_counts{13}(selectorp_cbc_med(h)) = pos_counts{13}(selectorp_cbc_med(h))+1;
                elseif pos_selectorp_cbc_med(h) == 0
                    neg_counts{13}(selectorp_cbc_med(h)) = neg_counts{13}(selectorp_cbc_med(h))+1;
                end
            end
        end    
        if isempty(pos_selectors_cbc_med) == 0
            for h = 1:length(pos_selectors_cbc_med)
                if pos_selectors_cbc_med(h) == 1
                    pos_counts{22}(selectors_cbc_med(h)) = pos_counts{22}(selectors_cbc_med(h))+1;
                elseif pos_selectors_cbc_med(h) == 0
                    neg_counts{22}(selectors_cbc_med(h)) = neg_counts{22}(selectors_cbc_med(h))+1;
                end
            end
        end           
        % mags*acc
        if isempty(pos_selectorf_cbc_acc) == 0
            for h = 1:length(pos_selectorf_cbc_acc)
                if pos_selectorf_cbc_acc(h) == 1
                    pos_counts{7}(selectorf_cbc_acc(h)) = pos_counts{7}(selectorf_cbc_acc(h))+1;
                elseif pos_selectorf_cbc_acc(h) == 0
                    neg_counts{7}(selectorf_cbc_acc(h)) = neg_counts{7}(selectorf_cbc_acc(h))+1;
                end
            end
        end
        if isempty(pos_selectorp_cbc_acc) == 0
            for h = 1:length(pos_selectorp_cbc_acc)
                if pos_selectorp_cbc_acc(h) == 1
                    pos_counts{16}(selectorp_cbc_acc(h)) = pos_counts{16}(selectorp_cbc_acc(h))+1;
                elseif pos_selectorp_cbc_acc(h) == 0
                    neg_counts{16}(selectorp_cbc_acc(h)) = neg_counts{16}(selectorp_cbc_acc(h))+1;
                end
            end
        end    
        if isempty(pos_selectors_cbc_acc) == 0
            for h = 1:length(pos_selectors_cbc_acc)
                if pos_selectors_cbc_acc(h) == 1
                    pos_counts{25}(selectors_cbc_acc(h)) = pos_counts{25}(selectors_cbc_acc(h))+1;
                elseif pos_selectors_cbc_acc(h) == 0
                    neg_counts{25}(selectors_cbc_acc(h)) = neg_counts{25}(selectors_cbc_acc(h))+1;
                end
            end
        end         
        
        chantype = 'Grads1';
        % load data
        ProcDataDir = [root '/DATA/NEW/processed_' char(SubjectArray{i,1}) '/'];
        loadpath = [ProcDataDir 'FT_spectra/POW+FREQ_' chantype '_RUN' num2str(RunArray{i,1}(j),'%02i') ...
            '_' num2str(freqband(1)) '_' num2str(freqband(2)) 'Hz.mat'];
        load(loadpath)
        
        % G1*duration
        GFPCorrMAt_R1(j,2) = Rf_dur(1,2);
        GFPCorrMAt_p1(j,2) = pf_dur(1,2);
        GFPCorrMAt_R1(j,5) = Rp_dur(1,2);
        GFPCorrMAt_p1(j,5) = pp_dur(1,2);
        GFPCorrMAt_R1(j,8) = Rs_dur(1,2);
        GFPCorrMAt_p1(j,8) = ps_dur(1,2);
        % G1*mediandeviation
        GFPCorrMAt_R2(j,2) = Rf_med(1,2);
        GFPCorrMAt_p2(j,2) = pf_med(1,2);
        GFPCorrMAt_R2(j,5) = Rp_med(1,2);
        GFPCorrMAt_p2(j,5) = pp_med(1,2);
        GFPCorrMAt_R2(j,8) = Rs_med(1,2);
        GFPCorrMAt_p2(j,8) = ps_med(1,2);
        % G1*accuracy
        GFPCorrMAt_R3(j,2) = Rf_acc(1,2);
        GFPCorrMAt_p3(j,2) = pf_acc(1,2);
        GFPCorrMAt_R3(j,5) = Rp_acc(1,2);
        GFPCorrMAt_p3(j,5) = pp_acc(1,2);
        GFPCorrMAt_R3(j,8) = Rs_acc(1,2);
        GFPCorrMAt_p3(j,8) = ps_acc(1,2);
        % number of correlated mags chans
        pos_NbChanMat_1(j,2) = sum(pos_selectorf_cbc_dur==1);
        pos_NbChanMat_1(j,5) = sum(pos_selectorp_cbc_dur==1);
        pos_NbChanMat_1(j,8) = sum(pos_selectors_cbc_dur==1);
        pos_NbChanMat_2(j,2) = sum(pos_selectorf_cbc_med==1);
        pos_NbChanMat_2(j,5) = sum(pos_selectorp_cbc_med==1);
        pos_NbChanMat_2(j,8) = sum(pos_selectors_cbc_med==1);
        pos_NbChanMat_3(j,2) = sum(pos_selectorf_cbc_acc==1);
        pos_NbChanMat_3(j,5) = sum(pos_selectorp_cbc_acc==1);
        pos_NbChanMat_3(j,8) = sum(pos_selectors_cbc_acc==1);
        neg_NbChanMat_1(j,2) = sum(pos_selectorf_cbc_dur==0);
        neg_NbChanMat_1(j,5) = sum(pos_selectorp_cbc_dur==0);
        neg_NbChanMat_1(j,8) = sum(pos_selectors_cbc_dur==0);
        neg_NbChanMat_2(j,2) = sum(pos_selectorf_cbc_med==0);
        neg_NbChanMat_2(j,5) = sum(pos_selectorp_cbc_med==0);
        neg_NbChanMat_2(j,8) = sum(pos_selectors_cbc_med==0);
        neg_NbChanMat_3(j,2) = sum(pos_selectorf_cbc_acc==0);
        neg_NbChanMat_3(j,5) = sum(pos_selectorp_cbc_acc==0);
        neg_NbChanMat_3(j,8) = sum(pos_selectors_cbc_acc==0);
        % grads1*dur
        if isempty(pos_selectorf_cbc_dur) == 0
            for h = 1:length(pos_selectorf_cbc_dur)
                if pos_selectorf_cbc_dur(h) == 1
                    pos_counts{2}(selectorf_cbc_dur(h)) = pos_counts{2}(selectorf_cbc_dur(h))+1;
                elseif pos_selectorf_cbc_dur(h) == 0
                    neg_counts{2}(selectorf_cbc_dur(h)) = neg_counts{2}(selectorf_cbc_dur(h))+1;
                end
            end
        end
        if isempty(pos_selectorp_cbc_dur) == 0
            for h = 1:length(pos_selectorp_cbc_dur)
                if pos_selectorp_cbc_dur(h) == 1
                    pos_counts{11}(selectorp_cbc_dur(h)) = pos_counts{11}(selectorp_cbc_dur(h))+1;
                elseif pos_selectorp_cbc_dur(h) == 0
                    neg_counts{11}(selectorp_cbc_dur(h)) = neg_counts{11}(selectorp_cbc_dur(h))+1;
                end
            end
        end    
        if isempty(pos_selectors_cbc_dur) == 0
            for h = 1:length(pos_selectors_cbc_dur)
                if pos_selectors_cbc_dur(h) == 1
                    pos_counts{20}(selectors_cbc_dur(h)) = pos_counts{20}(selectors_cbc_dur(h))+1;
                elseif pos_selectors_cbc_dur(h) == 0
                    neg_counts{20}(selectors_cbc_dur(h)) = neg_counts{20}(selectors_cbc_dur(h))+1;
                end
            end
        end           
        % grads1*med
        if isempty(pos_selectorf_cbc_med) == 0
            for h = 1:length(pos_selectorf_cbc_med)
                if pos_selectorf_cbc_med(h) == 1
                    pos_counts{5}(selectorf_cbc_med(h)) = pos_counts{5}(selectorf_cbc_med(h))+1;
                elseif pos_selectorf_cbc_med(h) == 0
                    neg_counts{5}(selectorf_cbc_med(h)) = neg_counts{5}(selectorf_cbc_med(h))+1;
                end
            end
        end
        if isempty(pos_selectorp_cbc_med) == 0
            for h = 1:length(pos_selectorp_cbc_med)
                if pos_selectorp_cbc_med(h) == 1
                    pos_counts{14}(selectorp_cbc_med(h)) = pos_counts{14}(selectorp_cbc_med(h))+1;
                elseif pos_selectorp_cbc_med(h) == 0
                    neg_counts{14}(selectorp_cbc_med(h)) = neg_counts{14}(selectorp_cbc_med(h))+1;
                end
            end
        end    
        if isempty(pos_selectors_cbc_med) == 0
            for h = 1:length(pos_selectors_cbc_med)
                if pos_selectors_cbc_med(h) == 1
                    pos_counts{23}(selectors_cbc_med(h)) = pos_counts{23}(selectors_cbc_med(h))+1;
                elseif pos_selectors_cbc_med(h) == 0
                    neg_counts{23}(selectors_cbc_med(h)) = neg_counts{23}(selectors_cbc_med(h))+1;
                end
            end
        end           
        % grads1*acc
        if isempty(pos_selectorf_cbc_acc) == 0
            for h = 1:length(pos_selectorf_cbc_acc)
                if pos_selectorf_cbc_acc(h) == 1
                    pos_counts{8}(selectorf_cbc_acc(h)) = pos_counts{8}(selectorf_cbc_acc(h))+1;
                elseif pos_selectorf_cbc_acc(h) == 0
                    neg_counts{8}(selectorf_cbc_acc(h)) = neg_counts{8}(selectorf_cbc_acc(h))+1;
                end
            end
        end
        if isempty(pos_selectorp_cbc_acc) == 0
            for h = 1:length(pos_selectorp_cbc_acc)
                if pos_selectorp_cbc_acc(h) == 1
                    pos_counts{17}(selectorp_cbc_acc(h)) = pos_counts{17}(selectorp_cbc_acc(h))+1;
                elseif pos_selectorp_cbc_acc(h) == 0
                    neg_counts{17}(selectorp_cbc_acc(h)) = neg_counts{17}(selectorp_cbc_acc(h))+1;
                end
            end
        end    
        if isempty(pos_selectors_cbc_acc) == 0
            for h = 1:length(pos_selectors_cbc_acc)
                if pos_selectors_cbc_acc(h) == 1
                    pos_counts{26}(selectors_cbc_acc(h)) = pos_counts{26}(selectors_cbc_acc(h))+1;
                elseif pos_selectors_cbc_acc(h) == 0
                    neg_counts{26}(selectors_cbc_acc(h)) = neg_counts{26}(selectors_cbc_acc(h))+1;
                end
            end
        end             
        
        chantype = 'Grads2';
        % load data
        ProcDataDir = [root '/DATA/NEW/processed_' char(SubjectArray{i,1}) '/'];
        loadpath = [ProcDataDir 'FT_spectra/POW+FREQ_' chantype '_RUN' num2str(RunArray{i,1}(j),'%02i') ...
            '_' num2str(freqband(1)) '_' num2str(freqband(2)) 'Hz.mat'];
        load(loadpath)
        
        % G2*duration
        GFPCorrMAt_R1(j,3) = Rf_dur(1,2);
        GFPCorrMAt_p1(j,3) = pf_dur(1,2);
        GFPCorrMAt_R1(j,6) = Rp_dur(1,2);
        GFPCorrMAt_p1(j,6) = pp_dur(1,2);
        GFPCorrMAt_R1(j,9) = Rs_dur(1,2);
        GFPCorrMAt_p1(j,9) = ps_dur(1,2);
        % G2*mediandeviation
        GFPCorrMAt_R2(j,3) = Rf_med(1,2);
        GFPCorrMAt_p2(j,3) = pf_med(1,2);
        GFPCorrMAt_R2(j,6) = Rp_med(1,2);
        GFPCorrMAt_p2(j,6) = pp_med(1,2);
        GFPCorrMAt_R2(j,9) = Rs_med(1,2);
        GFPCorrMAt_p2(j,9) = ps_med(1,2);
        % G2*accuracy
        GFPCorrMAt_R3(j,3) = Rf_acc(1,2);
        GFPCorrMAt_p3(j,3) = pf_acc(1,2);
        GFPCorrMAt_R3(j,6) = Rp_acc(1,2);
        GFPCorrMAt_p3(j,6) = pp_acc(1,2);
        GFPCorrMAt_R3(j,9) = Rs_acc(1,2);
        GFPCorrMAt_p3(j,9) = ps_acc(1,2);
        % number of correlated mags chans
        pos_NbChanMat_1(j,3) = sum(pos_selectorf_cbc_dur==1);
        pos_NbChanMat_1(j,6) = sum(pos_selectorp_cbc_dur==1);
        pos_NbChanMat_1(j,9) = sum(pos_selectors_cbc_dur==1);
        pos_NbChanMat_2(j,3) = sum(pos_selectorf_cbc_med==1);
        pos_NbChanMat_2(j,6) = sum(pos_selectorp_cbc_med==1);
        pos_NbChanMat_2(j,9) = sum(pos_selectors_cbc_med==1);
        pos_NbChanMat_3(j,3) = sum(pos_selectorf_cbc_acc==1);
        pos_NbChanMat_3(j,6) = sum(pos_selectorp_cbc_acc==1);
        pos_NbChanMat_3(j,9) = sum(pos_selectors_cbc_acc==1);
        neg_NbChanMat_1(j,3) = sum(pos_selectorf_cbc_dur==0);
        neg_NbChanMat_1(j,6) = sum(pos_selectorp_cbc_dur==0);
        neg_NbChanMat_1(j,9) = sum(pos_selectors_cbc_dur==0);
        neg_NbChanMat_2(j,3) = sum(pos_selectorf_cbc_med==0);
        neg_NbChanMat_2(j,6) = sum(pos_selectorp_cbc_med==0);
        neg_NbChanMat_2(j,9) = sum(pos_selectors_cbc_med==0);
        neg_NbChanMat_3(j,3) = sum(pos_selectorf_cbc_acc==0);
        neg_NbChanMat_3(j,6) = sum(pos_selectorp_cbc_acc==0);
        neg_NbChanMat_3(j,9) = sum(pos_selectors_cbc_acc==0);
        % grads2*dur
        if isempty(pos_selectorf_cbc_dur) == 0
            for h = 1:length(pos_selectorf_cbc_dur)
                if pos_selectorf_cbc_dur(h) == 1
                    pos_counts{3}(selectorf_cbc_dur(h)) = pos_counts{3}(selectorf_cbc_dur(h))+1;
                elseif pos_selectorf_cbc_dur(h) == 0
                    neg_counts{3}(selectorf_cbc_dur(h)) = neg_counts{3}(selectorf_cbc_dur(h))+1;
                end
            end
        end
        if isempty(pos_selectorp_cbc_dur) == 0
            for h = 1:length(pos_selectorp_cbc_dur)
                if pos_selectorp_cbc_dur(h) == 1
                    pos_counts{12}(selectorp_cbc_dur(h)) = pos_counts{12}(selectorp_cbc_dur(h))+1;
                elseif pos_selectorp_cbc_dur(h) == 0
                    neg_counts{12}(selectorp_cbc_dur(h)) = neg_counts{12}(selectorp_cbc_dur(h))+1;
                end
            end
        end    
        if isempty(pos_selectors_cbc_dur) == 0
            for h = 1:length(pos_selectors_cbc_dur)
                if pos_selectors_cbc_dur(h) == 1
                    pos_counts{21}(selectors_cbc_dur(h)) = pos_counts{21}(selectors_cbc_dur(h))+1;
                elseif pos_selectors_cbc_dur(h) == 0
                    neg_counts{21}(selectors_cbc_dur(h)) = neg_counts{21}(selectors_cbc_dur(h))+1;
                end
            end
        end           
        % grads2*med
        if isempty(pos_selectorf_cbc_med) == 0
            for h = 1:length(pos_selectorf_cbc_med)
                if pos_selectorf_cbc_med(h) == 1
                    pos_counts{6}(selectorf_cbc_med(h)) = pos_counts{6}(selectorf_cbc_med(h))+1;
                elseif pos_selectorf_cbc_med(h) == 0
                    neg_counts{6}(selectorf_cbc_med(h)) = neg_counts{6}(selectorf_cbc_med(h))+1;
                end
            end
        end
        if isempty(pos_selectorp_cbc_med) == 0
            for h = 1:length(pos_selectorp_cbc_med)
                if pos_selectorp_cbc_med(h) == 1
                    pos_counts{15}(selectorp_cbc_med(h)) = pos_counts{15}(selectorp_cbc_med(h))+1;
                elseif pos_selectorp_cbc_med(h) == 0
                    neg_counts{15}(selectorp_cbc_med(h)) = neg_counts{15}(selectorp_cbc_med(h))+1;
                end
            end
        end    
        if isempty(pos_selectors_cbc_med) == 0
            for h = 1:length(pos_selectors_cbc_med)
                if pos_selectors_cbc_med(h) == 1
                    pos_counts{24}(selectors_cbc_med(h)) = pos_counts{24}(selectors_cbc_med(h))+1;
                elseif pos_selectors_cbc_med(h) == 0
                    neg_counts{24}(selectors_cbc_med(h)) = neg_counts{24}(selectors_cbc_med(h))+1;
                end
            end
        end           
        % grads2*acc
        if isempty(pos_selectorf_cbc_acc) == 0
            for h = 1:length(pos_selectorf_cbc_acc)
                if pos_selectorf_cbc_acc(h) == 1
                    pos_counts{9}(selectorf_cbc_acc(h)) = pos_counts{9}(selectorf_cbc_acc(h))+1;
                elseif pos_selectorf_cbc_acc(h) == 0
                    neg_counts{9}(selectorf_cbc_acc(h)) = neg_counts{9}(selectorf_cbc_acc(h))+1;
                end
            end
        end
        if isempty(pos_selectorp_cbc_acc) == 0
            for h = 1:length(pos_selectorp_cbc_acc)
                if pos_selectorp_cbc_acc(h) == 1
                    pos_counts{18}(selectorp_cbc_acc(h)) = pos_counts{18}(selectorp_cbc_acc(h))+1;
                elseif pos_selectorp_cbc_acc(h) == 0
                    neg_counts{18}(selectorp_cbc_acc(h)) = neg_counts{18}(selectorp_cbc_acc(h))+1;
                end
            end
        end    
        if isempty(pos_selectors_cbc_acc) == 0
            for h = 1:length(pos_selectors_cbc_acc)
                if pos_selectors_cbc_acc(h) == 1
                    pos_counts{27}(selectors_cbc_acc(h)) = pos_counts{27}(selectors_cbc_acc(h))+1;
                elseif pos_selectors_cbc_acc(h) == 0
                    neg_counts{27}(selectors_cbc_acc(h)) = neg_counts{27}(selectors_cbc_acc(h))+1;
                end
            end
        end         
        
    end
    R1{i} = GFPCorrMAt_R1;
    p1{i} = GFPCorrMAt_p1;
    R2{i} = GFPCorrMAt_R2;
    p2{i} = GFPCorrMAt_p2;
    R3{i} = GFPCorrMAt_R3;
    p3{i} = GFPCorrMAt_p3;
    pos_ch1{i} = pos_NbChanMat_1;
    pos_ch2{i} = pos_NbChanMat_2;
    pos_ch3{i} = pos_NbChanMat_3;
    neg_ch1{i} = neg_NbChanMat_1;
    neg_ch2{i} = neg_NbChanMat_2;
    neg_ch3{i} = neg_NbChanMat_3;    
end

% plot results
Total_R1 = []; Total_p1 = [];
Total_R2 = []; Total_p2 = [];
Total_R3 = []; Total_p3 = [];
Total_pos_ch1 = [];
Total_pos_ch2 = [];
Total_pos_ch3 = [];
Total_neg_ch1 = [];
Total_neg_ch2 = [];
Total_neg_ch3 = [];
for i = 1:length(SubjectArray)
    Total_R1 = [Total_R1 ; R1{i}];
    Total_R2 = [Total_R2 ; R2{i}];
    Total_R3 = [Total_R3 ; R3{i}];
    Total_p1 = [Total_p1 ; p1{i}];
    Total_p2 = [Total_p2 ; p2{i}];
    Total_p3 = [Total_p3 ; p3{i}];
    Total_pos_ch1 = [Total_pos_ch1 ; pos_ch1{i}];
    Total_pos_ch2 = [Total_pos_ch2 ; pos_ch2{i}];
    Total_pos_ch3 = [Total_pos_ch3 ; pos_ch3{i}];
    Total_neg_ch1 = [Total_neg_ch1 ; neg_ch1{i}];
    Total_neg_ch2 = [Total_neg_ch2 ; neg_ch2{i}];
    Total_neg_ch3 = [Total_neg_ch3 ; neg_ch3{i}];    
end

% figure parameters
fig                 = figure('position',[1 1 800 600]);
set(fig,'PaperPosition',[1 1 800 600])
set(fig,'PaperPositionMode','auto')


imagesc([Total_R1(:,1:3) Total_R2(:,1:3) Total_R3(:,1:3)...
         Total_R1(:,4:6) Total_R2(:,4:6) Total_R3(:,4:6)...
         Total_R1(:,7:9) Total_R2(:,7:9) Total_R3(:,7:9)],[-1 1])
set(gca,'xtick',1:27,'xticklabel',{'M: f vs dur';'G1 :f vs dur';'G2: f vs dur';...
                                  'M: f vs md' ;'G1: f vs md' ;'G2: f vs md' ;...
                                  'M: f vs acc';'G1: f vs acc';'G2: f vs acc';...
                                  'M: p vs dur';'G1 :p vs dur';'G2: p vs dur';...
                                  'M: p vs md' ;'G1: p vs md' ;'G2: p vs md' ;...
                                  'M: p vs acc';'G1: p vs acc';'G2: p vs acc';...
                                  'M: s vs dur';'G1 :s vs dur';'G2: s vs dur';...
                                  'M: s vs md' ;'G1: s vs md' ;'G2: s vs md' ;...
                                  'M: s vs acc';'G1: s vs acc';'G2: s vs acc';})
hold on; line('XData',[0.5 0.5],'YData',[0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                              
hold on; line('XData',[9.5 9.5],'YData',[0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                                
hold on; line('XData',[0.5 9.5],'YData',[0.5 0.5],'Color','k','LineWidth',3)                              
hold on; line('XData',[0.5 9.5],'YData',[size(Total_R1,1)+0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)  

hold on; line('XData',[9.5 9.5],'YData',[0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                              
hold on; line('XData',[18.5 18.5],'YData',[0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                                
hold on; line('XData',[9.5 18.5],'YData',[0.5 0.5],'Color','k','LineWidth',3)                              
hold on; line('XData',[9.5 18.5],'YData',[size(Total_R1,1)+0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3) 

hold on; line('XData',[18.5 18.5],'YData',[0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                              
hold on; line('XData',[27.5 27.5],'YData',[0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                                
hold on; line('XData',[18.5 27.5],'YData',[0.5 0.5],'Color','k','LineWidth',3)                              
hold on; line('XData',[18.5 27.5],'YData',[size(Total_R1,1)+0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3) 

xticklabel_rotate([],45,[],'Fontsize',14)
title('GFP Pearson correlation')
colorbar

% save print
print('-dpng',[root '/DATA/NEW/across_subjects_plots/ALLCORR_nocorr_'...
    'ALLCHAN_' num2str(freqband(1)) '-' num2str(freqband(2)) '_' condname 'Hz.png']);

% masked version
mask_p1 = Total_p1 <= 0.05/size(Total_p1,1);
mask_p2 = Total_p2 <= 0.05/size(Total_p1,1);
mask_p3 = Total_p3 <= 0.05/size(Total_p1,1);

fig                 = figure('position',[1 1 800 600]);
set(fig,'PaperPosition',[1 1 800 600])
set(fig,'PaperPositionMode','auto')


imagesc([Total_R1(:,1:3).*mask_p1(:,1:3) Total_R2(:,1:3).*mask_p2(:,1:3) Total_R3(:,1:3).*mask_p3(:,1:3)...
         Total_R1(:,4:6).*mask_p1(:,4:6) Total_R2(:,4:6).*mask_p2(:,4:6) Total_R3(:,4:6).*mask_p3(:,4:6)...
         Total_R1(:,7:9).*mask_p1(:,7:9) Total_R2(:,7:9).*mask_p2(:,7:9) Total_R3(:,7:9).*mask_p3(:,7:9)],[-1 1])
set(gca,'xtick',1:27,'xticklabel',{'M: f vs dur';'G1 :f vs dur';'G2: f vs dur';...
                                  'M: f vs md' ;'G1: f vs md' ;'G2: f vs md' ;...
                                  'M: f vs acc';'G1: f vs acc';'G2: f vs acc';...
                                  'M: p vs dur';'G1 :p vs dur';'G2: p vs dur';...
                                  'M: p vs md' ;'G1: p vs md' ;'G2: p vs md' ;...
                                  'M: p vs acc';'G1: p vs acc';'G2: p vs acc';...
                                  'M: s vs dur';'G1 :s vs dur';'G2: s vs dur';...
                                  'M: s vs md' ;'G1: s vs md' ;'G2: s vs md' ;...
                                  'M: s vs acc';'G1: s vs acc';'G2: s vs acc';})
hold on; line('XData',[0.5 0.5],'YData',[0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                              
hold on; line('XData',[9.5 9.5],'YData',[0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                                
hold on; line('XData',[0.5 9.5],'YData',[0.5 0.5],'Color','k','LineWidth',3)                              
hold on; line('XData',[0.5 9.5],'YData',[size(Total_R1,1)+0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)  

hold on; line('XData',[9.5 9.5],'YData',[0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                              
hold on; line('XData',[18.5 18.5],'YData',[0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                                
hold on; line('XData',[9.5 18.5],'YData',[0.5 0.5],'Color','k','LineWidth',3)                              
hold on; line('XData',[9.5 18.5],'YData',[size(Total_R1,1)+0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3) 

hold on; line('XData',[18.5 18.5],'YData',[0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                              
hold on; line('XData',[27.5 27.5],'YData',[0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                                
hold on; line('XData',[18.5 27.5],'YData',[0.5 0.5],'Color','k','LineWidth',3)                              
hold on; line('XData',[18.5 27.5],'YData',[size(Total_R1,1)+0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                               
xticklabel_rotate([],45,[],'Fontsize',14)
title('GFP Pearson correlation')
colorbar

% save print
print('-dpng',[root '/DATA/NEW/across_subjects_plots/ALLCORR_bonf_'...
    'ALLCHAN_' num2str(freqband(1)) '-' num2str(freqband(2)) '_' condname 'Hz.png']);

% nb of significantly correlated chans
% figure parameters
fig                 = figure('position',[1 1 800 600]);
set(fig,'PaperPosition',[1 1 800 600])
set(fig,'PaperPositionMode','auto')

imagesc([Total_pos_ch1(:,1:3) Total_pos_ch2(:,1:3) Total_pos_ch3(:,1:3)...
         Total_pos_ch1(:,4:6) Total_pos_ch2(:,4:6) Total_pos_ch3(:,4:6)...
         Total_pos_ch1(:,7:9) Total_pos_ch2(:,7:9) Total_pos_ch3(:,7:9)],[0 25])
set(gca,'xtick',1:27,'xticklabel',{'M: f vs dur';'G1 :f vs dur';'G2: f vs dur';...
                                  'M: f vs md' ;'G1: f vs md' ;'G2: f vs md' ;...
                                  'M: f vs acc';'G1: f vs acc';'G2: f vs acc';...
                                  'M: p vs dur';'G1 :p vs dur';'G2: p vs dur';...
                                  'M: p vs md' ;'G1: p vs md' ;'G2: p vs md' ;...
                                  'M: p vs acc';'G1: p vs acc';'G2: p vs acc';...
                                  'M: s vs dur';'G1 :s vs dur';'G2: s vs dur';...
                                  'M: s vs md' ;'G1: s vs md' ;'G2: s vs md' ;...
                                  'M: s vs acc';'G1: s vs acc';'G2: s vs acc';})
hold on; line('XData',[0.5 0.5],'YData',[0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                              
hold on; line('XData',[9.5 9.5],'YData',[0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                                
hold on; line('XData',[0.5 9.5],'YData',[0.5 0.5],'Color','k','LineWidth',3)                              
hold on; line('XData',[0.5 9.5],'YData',[size(Total_R1,1)+0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)  

hold on; line('XData',[9.5 9.5],'YData',[0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                              
hold on; line('XData',[18.5 18.5],'YData',[0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                                
hold on; line('XData',[9.5 18.5],'YData',[0.5 0.5],'Color','k','LineWidth',3)                              
hold on; line('XData',[9.5 18.5],'YData',[size(Total_R1,1)+0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3) 

hold on; line('XData',[18.5 18.5],'YData',[0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                              
hold on; line('XData',[27.5 27.5],'YData',[0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                                
hold on; line('XData',[18.5 27.5],'YData',[0.5 0.5],'Color','k','LineWidth',3)                              
hold on; line('XData',[18.5 27.5],'YData',[size(Total_R1,1)+0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                               
xticklabel_rotate([],45,[],'Fontsize',14)
title('Positively correlated chan nb')
colorbar

% save print
print('-dpng',[root '/DATA/NEW/across_subjects_plots/NBCHAN_posCORR_'...
    num2str(freqband(1)) '-' num2str(freqband(2)) '_' condname 'Hz.png']);

% nb of significantly correlated chans
fig                 = figure('position',[1 1 800 600]);
set(fig,'PaperPosition',[1 1 800 600])
set(fig,'PaperPositionMode','auto')

imagesc([Total_neg_ch1(:,1:3) Total_neg_ch2(:,1:3) Total_neg_ch3(:,1:3)...
         Total_neg_ch1(:,4:6) Total_neg_ch2(:,4:6) Total_neg_ch3(:,4:6)...
         Total_neg_ch1(:,7:9) Total_neg_ch2(:,7:9) Total_neg_ch3(:,7:9)],[0 25])
set(gca,'xtick',1:27,'xticklabel',{'M: f vs dur';'G1 :f vs dur';'G2: f vs dur';...
                                  'M: f vs md' ;'G1: f vs md' ;'G2: f vs md' ;...
                                  'M: f vs acc';'G1: f vs acc';'G2: f vs acc';...
                                  'M: p vs dur';'G1 :p vs dur';'G2: p vs dur';...
                                  'M: p vs md' ;'G1: p vs md' ;'G2: p vs md' ;...
                                  'M: p vs acc';'G1: p vs acc';'G2: p vs acc';...
                                  'M: s vs dur';'G1 :s vs dur';'G2: s vs dur';...
                                  'M: s vs md' ;'G1: s vs md' ;'G2: s vs md' ;...
                                  'M: s vs acc';'G1: s vs acc';'G2: s vs acc';})
hold on; line('XData',[0.5 0.5],'YData',[0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                              
hold on; line('XData',[9.5 9.5],'YData',[0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                                
hold on; line('XData',[0.5 9.5],'YData',[0.5 0.5],'Color','k','LineWidth',3)                              
hold on; line('XData',[0.5 9.5],'YData',[size(Total_R1,1)+0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)  

hold on; line('XData',[9.5 9.5],'YData',[0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                              
hold on; line('XData',[18.5 18.5],'YData',[0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                                
hold on; line('XData',[9.5 18.5],'YData',[0.5 0.5],'Color','k','LineWidth',3)                              
hold on; line('XData',[9.5 18.5],'YData',[size(Total_R1,1)+0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3) 

hold on; line('XData',[18.5 18.5],'YData',[0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                              
hold on; line('XData',[27.5 27.5],'YData',[0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                                
hold on; line('XData',[18.5 27.5],'YData',[0.5 0.5],'Color','k','LineWidth',3)                              
hold on; line('XData',[18.5 27.5],'YData',[size(Total_R1,1)+0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                               
xticklabel_rotate([],45,[],'Fontsize',14)
title('Positively correlated chan nb')
colorbar

% save print
print('-dpng',[root '/DATA/NEW/across_subjects_plots/NBCHAN_negCORR_'...
    num2str(freqband(1)) '-' num2str(freqband(2)) '_' condname 'Hz.png']);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% best corr chan avg %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
root = SetPath(tag);
chan = {'Mags';'Grads1';'Grads2'};

Total_best_pos_avg_R1 = [];
Total_best_pos_avg_R2 = [];
Total_best_pos_avg_R3 = [];
Total_best_pos_avg_p1 = [];
Total_best_pos_avg_p2 = [];
Total_best_pos_avg_p3 = [];

for i = 1:length(SubjectArray) % loop on subjects
    % init matrices
    pos_best_avg_R1 = zeros(length(RunArray{i}),9);
    pos_best_avg_R2 = zeros(length(RunArray{i}),9);
    pos_best_avg_R3 = zeros(length(RunArray{i}),9);
    pos_best_avg_p1 = zeros(length(RunArray{i}),9);
    pos_best_avg_p2 = zeros(length(RunArray{i}),9);
    pos_best_avg_p3 = zeros(length(RunArray{i}),9);
    
    neg_best_avg_R1 = zeros(length(RunArray{i}),9);
    neg_best_avg_R2 = zeros(length(RunArray{i}),9);
    neg_best_avg_R3 = zeros(length(RunArray{i}),9);
    neg_best_avg_p1 = zeros(length(RunArray{i}),9);
    neg_best_avg_p2 = zeros(length(RunArray{i}),9);
    neg_best_avg_p3 = zeros(length(RunArray{i}),9);    
    
    for j = 1:length(RunArray{i,1}) % loop on runs
        for l = 1:3
            chantype = chan{l};
            % load data
            ProcDataDir = [root '/DATA/NEW/processed_' char(SubjectArray{i,1}) '/'];
            loadpath = [ProcDataDir 'FT_spectra/POW+FREQ_' chantype '_RUN' num2str(RunArray{i,1}(j),'%02i') ...
                '_' num2str(freqband(1)) '_' num2str(freqband(2)) 'Hz.mat'];
            load(loadpath)
            
            % freq*dur correlation
            if isempty(selectorf_cbc_dur) == 0
                pos_freq_dur_avg = zeros(1,length(FREQUENCY{1,1}));
                neg_freq_dur_avg = zeros(1,length(FREQUENCY{1,1}));
                [ok,pos_indf_cbc_dur] = find(pos_selectorf_cbc_dur == 1);
                [ok,neg_indf_cbc_dur] = find(pos_selectorf_cbc_dur == 0);
                
                if isempty(pos_indf_cbc_dur) == 0
                    for k = 1:length(pos_indf_cbc_dur)
                        pos_freq_dur_avg = pos_freq_dur_avg + FREQUENCY{1,selectorf_cbc_dur(pos_indf_cbc_dur(k))};
                    end
                    pos_freq_dur_avg = pos_freq_dur_avg/length(pos_indf_cbc_dur);
                    [pos_best_avg_R1(j,(l-1)*3 +1),pos_best_avg_p1(j,(l-1)*3 +1)] = corr(pos_freq_dur_avg(DURATIONSORTED(:,2))',DURATIONSORTED(:,1));   
                else
                    pos_best_avg_R1(j,(l-1)*3 +1) = 0;
                    pos_best_avg_p1(j,(l-1)*3 +1) = 0;
                end
                
                if isempty(neg_indf_cbc_dur) == 0
                    for k = 1:length(neg_indf_cbc_dur)
                        neg_freq_dur_avg = neg_freq_dur_avg + FREQUENCY{1,selectorf_cbc_dur(neg_indf_cbc_dur(k))};
                    end
                    neg_freq_dur_avg = neg_freq_dur_avg/length(neg_indf_cbc_dur);
                    [neg_best_avg_R1(j,(l-1)*3 +1),neg_best_avg_p1(j,(l-1)*3 +1)] = corr(neg_freq_dur_avg(DURATIONSORTED(:,2))',DURATIONSORTED(:,1));
                else
                    neg_best_avg_R1(j,(l-1)*3 +1) = 0;
                    neg_best_avg_p1(j,(l-1)*3 +1) = 0;
                end
            end
            
            % pow*dur correlation
            if isempty(selectorp_cbc_dur) == 0
                pos_pow_dur_avg = zeros(1,length(FREQUENCY{1,1}));
                neg_pow_dur_avg = zeros(1,length(FREQUENCY{1,1}));
                [ok,pos_indp_cbc_dur] = find(pos_selectorp_cbc_dur == 1);
                [ok,neg_indp_cbc_dur] = find(pos_selectorp_cbc_dur == 0);
                
                if isempty(pos_indp_cbc_dur) == 0
                    for k = 1:length(pos_indp_cbc_dur)
                        pos_pow_dur_avg = pos_pow_dur_avg + POWER{1,selectorp_cbc_dur(pos_indp_cbc_dur(k))};
                    end
                    pos_pow_dur_avg = pos_pow_dur_avg/length(pos_indp_cbc_dur);
                    [pos_best_avg_R1(j,(l-1)*3 +2),pos_best_avg_p1(j,(l-1)*3 +2)] = corr(pos_pow_dur_avg(DURATIONSORTED(:,2))',DURATIONSORTED(:,1));   
                else
                    pos_best_avg_R1(j,(l-1)*3 +2) = 0;
                    pos_best_avg_p1(j,(l-1)*3 +2) = 0;
                end
                
                if isempty(neg_indp_cbc_dur) == 0
                    for k = 1:length(neg_indp_cbc_dur)
                        neg_pow_dur_avg = neg_pow_dur_avg + POWER{1,selectorp_cbc_dur(neg_indp_cbc_dur(k))};
                    end
                    neg_pow_dur_avg = neg_pow_dur_avg/length(neg_indp_cbc_dur);
                    [neg_best_avg_R1(j,(l-1)*3 +2),neg_best_avg_p1(j,(l-1)*3 +2)] = corr(neg_pow_dur_avg(DURATIONSORTED(:,2))',DURATIONSORTED(:,1));   
                else
                    neg_best_avg_R1(j,(l-1)*3 +2) = 0;
                    neg_best_avg_p1(j,(l-1)*3 +2) = 0;
                end
            end
            
            % slope*dur correlation
            if isempty(selectors_cbc_dur) == 0
                pos_slope_dur_avg = zeros(1,length(FREQUENCY{1,1}));
                neg_slope_dur_avg = zeros(1,length(FREQUENCY{1,1}));
                [ok,pos_inds_cbc_dur] = find(pos_selectors_cbc_dur == 1);
                [ok,neg_inds_cbc_dur] = find(pos_selectors_cbc_dur == 0);
                
                if isempty(pos_inds_cbc_dur) == 0
                    for k = 1:length(pos_inds_cbc_dur)
                        pos_slope_dur_avg = pos_slope_dur_avg + POWER{1,selectors_cbc_dur(pos_inds_cbc_dur(k))};
                    end
                    pos_slope_dur_avg = pos_slope_dur_avg/length(pos_inds_cbc_dur);
                    [pos_best_avg_R1(j,(l-1)*3 +3),pos_best_avg_p1(j,(l-1)*3 +3)] = corr(pos_slope_dur_avg(DURATIONSORTED(:,2))',DURATIONSORTED(:,1));   
                else
                    pos_best_avg_R1(j,(l-1)*3 +3) = 0;
                    pos_best_avg_p1(j,(l-1)*3 +3) = 0;
                end
                
                if isempty(neg_inds_cbc_dur) == 0
                    for k = 1:length(neg_inds_cbc_dur)
                        neg_slope_dur_avg = neg_slope_dur_avg + POWER{1,selectors_cbc_dur(neg_inds_cbc_dur(k))};
                    end
                    neg_slope_dur_avg = neg_slope_dur_avg/length(neg_inds_cbc_dur);
                    [neg_best_avg_R1(j,(l-1)*3 +3),neg_best_avg_p1(j,(l-1)*3 +3)] = corr(neg_slope_dur_avg(DURATIONSORTED(:,2))',DURATIONSORTED(:,1));   
                else
                    neg_best_avg_R1(j,(l-1)*3 +3) = 0;
                    neg_best_avg_p1(j,(l-1)*3 +3) = 0;
                end
            end      
            
            % freq*med correlation
            if isempty(selectorf_cbc_med) == 0
                pos_freq_med_avg = zeros(1,length(FREQUENCY{1,1}));
                neg_freq_med_avg = zeros(1,length(FREQUENCY{1,1}));
                [ok,pos_indf_cbc_med] = find(pos_selectorf_cbc_med == 1);
                [~,neg_indf_cbc_med] = find(pos_selectorf_cbc_med == 0);
                
                if isempty(pos_indf_cbc_med) == 0
                    for k = 1:length(pos_indf_cbc_med)
                        pos_freq_med_avg = pos_freq_med_avg + FREQUENCY{1,selectorf_cbc_med(pos_indf_cbc_med(k))};
                    end
                    pos_freq_med_avg = pos_freq_med_avg/length(pos_indf_cbc_med);
                    [pos_best_avg_R2(j,(l-1)*3 +1),pos_best_avg_p2(j,(l-1)*3 +1)] = corr(pos_freq_med_avg(MEDDEVIATION(:,2))',MEDDEVIATION(:,1));   
                else
                    pos_best_avg_R2(j,(l-1)*3 +1) = 0;
                    pos_best_avg_p2(j,(l-1)*3 +1) = 0;
                end
                
                if isempty(neg_indf_cbc_med) == 0
                    for k = 1:length(neg_indf_cbc_med)
                        neg_freq_med_avg = neg_freq_med_avg + FREQUENCY{1,selectorf_cbc_med(neg_indf_cbc_med(k))};
                    end
                    neg_freq_med_avg = neg_freq_med_avg/length(neg_indf_cbc_med);
                    [neg_best_avg_R2(j,(l-1)*3 +1),neg_best_avg_p2(j,(l-1)*3 +1)] = corr(neg_freq_med_avg(MEDDEVIATION(:,2))',MEDDEVIATION(:,1));
                else
                    neg_best_avg_R2(j,(l-1)*3 +1) = 0;
                    neg_best_avg_p2(j,(l-1)*3 +1) = 0;
                end
            end
            
            % pow*med correlation
            if isempty(selectorp_cbc_med) == 0
                pos_pow_med_avg = zeros(1,length(FREQUENCY{1,1}));
                neg_pow_med_avg = zeros(1,length(FREQUENCY{1,1}));
                [ok,pos_indp_cbc_med] = find(pos_selectorp_cbc_med == 1);
                [ok,neg_indp_cbc_med] = find(pos_selectorp_cbc_med == 0);
                
                if isempty(pos_indp_cbc_med) == 0
                    for k = 1:length(pos_indp_cbc_med)
                        pos_pow_med_avg = pos_pow_med_avg + POWER{1,selectorp_cbc_med(pos_indp_cbc_med(k))};
                    end
                    pos_pow_med_avg = pos_pow_med_avg/length(pos_indp_cbc_med);
                    [pos_best_avg_R2(j,(l-1)*3 +2),pos_best_avg_p2(j,(l-1)*3 +2)] = corr(pos_pow_med_avg(MEDDEVIATION(:,2))',MEDDEVIATION(:,1));   
                else
                    pos_best_avg_R2(j,(l-1)*3 +2) = 0;
                    pos_best_avg_p2(j,(l-1)*3 +2) = 0;
                end
                
                if isempty(neg_indp_cbc_med) == 0
                    for k = 1:length(neg_indp_cbc_med)
                        neg_pow_med_avg = neg_pow_med_avg + POWER{1,selectorp_cbc_med(neg_indp_cbc_med(k))};
                    end
                    neg_pow_med_avg = neg_pow_med_avg/length(neg_indp_cbc_med);
                    [neg_best_avg_R2(j,(l-1)*3 +2),neg_best_avg_p2(j,(l-1)*3 +2)] = corr(neg_pow_med_avg(MEDDEVIATION(:,2))',MEDDEVIATION(:,1));   
                else
                    neg_best_avg_R2(j,(l-1)*3 +2) = 0;
                    neg_best_avg_p2(j,(l-1)*3 +2) = 0;
                end
            end
            
            % slope*med correlation
            if isempty(selectors_cbc_med) == 0
                pos_slope_med_avg = zeros(1,length(FREQUENCY{1,1}));
                neg_slope_med_avg = zeros(1,length(FREQUENCY{1,1}));
                [ok,pos_inds_cbc_med] = find(pos_selectors_cbc_med == 1);
                [ok,neg_inds_cbc_med] = find(pos_selectors_cbc_med == 0);
                
                if isempty(pos_inds_cbc_med) == 0
                    for k = 1:length(pos_inds_cbc_med)
                        pos_slope_med_avg = pos_slope_med_avg + POWER{1,selectors_cbc_med(pos_inds_cbc_med(k))};
                    end
                    pos_slope_med_avg = pos_slope_med_avg/length(pos_inds_cbc_med);
                    [pos_best_avg_R2(j,(l-1)*3 +3),pos_best_avg_p2(j,(l-1)*3 +3)] = corr(pos_slope_med_avg(MEDDEVIATION(:,2))',MEDDEVIATION(:,1));   
                else
                    pos_best_avg_R2(j,(l-1)*3 +3) = 0;
                    pos_best_avg_p2(j,(l-1)*3 +3) = 0;
                end
                
                if isempty(neg_inds_cbc_med) == 0
                    for k = 1:length(neg_inds_cbc_med)
                        neg_slope_med_avg = neg_slope_med_avg + POWER{1,selectors_cbc_med(neg_inds_cbc_med(k))};
                    end
                    neg_slope_med_avg = neg_slope_med_avg/length(neg_inds_cbc_med);
                    [neg_best_avg_R2(j,(l-1)*3 +3),neg_best_avg_p2(j,(l-1)*3 +3)] = corr(neg_slope_med_avg(MEDDEVIATION(:,2))',MEDDEVIATION(:,1));   
                else
                    neg_best_avg_R2(j,(l-1)*3 +3) = 0;
                    neg_best_avg_p2(j,(l-1)*3 +3) = 0;
                end
            end
            
            % freq*acc correlation
            if isempty(selectorf_cbc_acc) == 0
                pos_freq_acc_avg = zeros(1,length(FREQUENCY{1,1}));
                neg_freq_acc_avg = zeros(1,length(FREQUENCY{1,1}));
                [ok,pos_indf_cbc_acc] = find(pos_selectorf_cbc_acc == 1);
                [ok,neg_indf_cbc_acc] = find(pos_selectorf_cbc_acc == 0);
                
                if isempty(pos_indf_cbc_acc) == 0
                    for k = 1:length(pos_indf_cbc_acc)
                        pos_freq_acc_avg = pos_freq_acc_avg + FREQUENCY{1,selectorf_cbc_acc(pos_indf_cbc_acc(k))};
                    end
                    pos_freq_acc_avg = pos_freq_acc_avg/length(pos_indf_cbc_acc);
                    [pos_best_avg_R3(j,(l-1)*3 +1),pos_best_avg_p3(j,(l-1)*3 +1)] = corr(pos_freq_acc_avg(MEDDEVIATION(:,2))',MEDDEVIATION(:,1));   
                else
                    pos_best_avg_R3(j,(l-1)*3 +1) = 0;
                    pos_best_avg_p3(j,(l-1)*3 +1) = 0;
                end
                
                if isempty(neg_indf_cbc_acc) == 0
                    for k = 1:length(neg_indf_cbc_acc)
                        neg_freq_acc_avg = neg_freq_acc_avg + FREQUENCY{1,selectorf_cbc_acc(neg_indf_cbc_acc(k))};
                    end
                    neg_freq_acc_avg = neg_freq_acc_avg/length(neg_indf_cbc_acc);
                    [neg_best_avg_R3(j,(l-1)*3 +1),neg_best_avg_p3(j,(l-1)*3 +1)] = corr(neg_freq_acc_avg(MEDDEVIATION(:,2))',MEDDEVIATION(:,1));
                else
                    neg_best_avg_R3(j,(l-1)*3 +1) = 0;
                    neg_best_avg_p3(j,(l-1)*3 +1) = 0;
                end
            end
            
            % pow*acc correlation
            if isempty(selectorp_cbc_acc) == 0
                pos_pow_acc_avg = zeros(1,length(FREQUENCY{1,1}));
                neg_pow_acc_avg = zeros(1,length(FREQUENCY{1,1}));
                [ok,pos_indp_cbc_acc] = find(pos_selectorp_cbc_acc == 1);
                [ok,neg_indp_cbc_acc] = find(pos_selectorp_cbc_acc == 0);
                
                if isempty(pos_indp_cbc_acc) == 0
                    for k = 1:length(pos_indp_cbc_acc)
                        pos_pow_acc_avg = pos_pow_acc_avg + POWER{1,selectorp_cbc_acc(pos_indp_cbc_acc(k))};
                    end
                    pos_pow_acc_avg = pos_pow_acc_avg/length(pos_indp_cbc_acc);
                    [pos_best_avg_R3(j,(l-1)*3 +2),pos_best_avg_p3(j,(l-1)*3 +2)] = corr(pos_pow_acc_avg(MEDDEVIATION(:,2))',MEDDEVIATION(:,1));   
                else
                    pos_best_avg_R3(j,(l-1)*3 +2) = 0;
                    pos_best_avg_p3(j,(l-1)*3 +2) = 0;
                end
                
                if isempty(neg_indp_cbc_acc) == 0
                    for k = 1:length(neg_indp_cbc_acc)
                        neg_pow_acc_avg = neg_pow_acc_avg + POWER{1,selectorp_cbc_acc(neg_indp_cbc_acc(k))};
                    end
                    neg_pow_acc_avg = neg_pow_acc_avg/length(neg_indp_cbc_acc);
                    [neg_best_avg_R3(j,(l-1)*3 +2),neg_best_avg_p3(j,(l-1)*3 +2)] = corr(neg_pow_acc_avg(MEDDEVIATION(:,2))',MEDDEVIATION(:,1));   
                else
                    neg_best_avg_R3(j,(l-1)*3 +2) = 0;
                    neg_best_avg_p3(j,(l-1)*3 +2) = 0;
                end
            end
            
            % slope*acc correlation
            if isempty(selectors_cbc_acc) == 0
                pos_slope_acc_avg = zeros(1,length(FREQUENCY{1,1}));
                neg_slope_acc_avg = zeros(1,length(FREQUENCY{1,1}));
                [ok,pos_inds_cbc_acc] = find(pos_selectors_cbc_acc == 1);
                [ok,neg_inds_cbc_acc] = find(pos_selectors_cbc_acc == 0);
                
                if isempty(pos_inds_cbc_acc) == 0
                    for k = 1:length(pos_inds_cbc_acc)
                        pos_slope_acc_avg = pos_slope_acc_avg + POWER{1,selectors_cbc_acc(pos_inds_cbc_acc(k))};
                    end
                    pos_slope_acc_avg = pos_slope_acc_avg/length(pos_inds_cbc_acc);
                    [pos_best_avg_R3(j,(l-1)*3 +3),pos_best_avg_p3(j,(l-1)*3 +3)] = corr(pos_slope_acc_avg(MEDDEVIATION(:,2))',MEDDEVIATION(:,1));   
                else
                    pos_best_avg_R3(j,(l-1)*3 +3) = 0;
                    pos_best_avg_p3(j,(l-1)*3 +3) = 0;
                end
                
                if isempty(neg_inds_cbc_acc) == 0
                    for k = 1:length(neg_inds_cbc_acc)
                        neg_slope_acc_avg = neg_slope_acc_avg + POWER{1,selectors_cbc_acc(neg_inds_cbc_acc(k))};
                    end
                    neg_slope_acc_avg = neg_slope_acc_avg/length(neg_inds_cbc_acc);
                    [neg_best_avg_R3(j,(l-1)*3 +3),neg_best_avg_p3(j,(l-1)*3 +3)] = corr(neg_slope_acc_avg(MEDDEVIATION(:,2))',MEDDEVIATION(:,1));   
                else
                    neg_best_avg_R3(j,(l-1)*3 +3) = 0;
                    neg_best_avg_p3(j,(l-1)*3 +3) = 0;
                end
            end            
            
        end
        
    end
    Total_pos_best_avg_R1{i} = pos_best_avg_R1;
    Total_pos_best_avg_R2{i} = pos_best_avg_R2;
    Total_pos_best_avg_R3{i} = pos_best_avg_R3;
    Total_pos_best_avg_p1{i} = pos_best_avg_p1;
    Total_pos_best_avg_p2{i} = pos_best_avg_p2;
    Total_pos_best_avg_p3{i} = pos_best_avg_p3;
    Total_neg_best_avg_R1{i} = neg_best_avg_R1;
    Total_neg_best_avg_R2{i} = neg_best_avg_R2;
    Total_neg_best_avg_R3{i} = neg_best_avg_R3;
    Total_neg_best_avg_p1{i} = neg_best_avg_p1;
    Total_neg_best_avg_p2{i} = neg_best_avg_p2;
    Total_neg_best_avg_p3{i} = neg_best_avg_p3;  
    
end

% plot results
pos_avg_R1 = []; 
pos_avg_R2 = []; 
pos_avg_R3 = []; 
pos_avg_p1 = [];
pos_avg_p2 = [];
pos_avg_p3 = [];
neg_avg_R1 = []; 
neg_avg_R2 = []; 
neg_avg_R3 = []; 
neg_avg_p1 = [];
neg_avg_p2 = [];
neg_avg_p3 = [];

for i = 1:length(SubjectArray)
    pos_avg_R1 = [pos_avg_R1 ; Total_pos_best_avg_R1{i}];
    pos_avg_R2 = [pos_avg_R2 ; Total_pos_best_avg_R2{i}];
    pos_avg_R3 = [pos_avg_R3 ; Total_pos_best_avg_R3{i}];
    pos_avg_p1 = [pos_avg_p1 ; Total_pos_best_avg_p1{i}];
    pos_avg_p2 = [pos_avg_p2 ; Total_pos_best_avg_p2{i}];
    pos_avg_p3 = [pos_avg_p3 ; Total_pos_best_avg_p3{i}];
    neg_avg_R1 = [neg_avg_R1 ; Total_neg_best_avg_R1{i}];
    neg_avg_R2 = [neg_avg_R2 ; Total_neg_best_avg_R2{i}];
    neg_avg_R3 = [neg_avg_R3 ; Total_neg_best_avg_R3{i}];
    neg_avg_p1 = [neg_avg_p1 ; Total_neg_best_avg_p1{i}];
    neg_avg_p2 = [neg_avg_p2 ; Total_neg_best_avg_p2{i}];
    neg_avg_p3 = [neg_avg_p3 ; Total_neg_best_avg_p3{i}];    
end

% figure parameters
fig                 = figure('position',[1 1 800 600]);
set(fig,'PaperPosition',[1 1 800 600])
set(fig,'PaperPositionMode','auto')


imagesc([pos_avg_R1(:,1:3) pos_avg_R2(:,1:3) pos_avg_R3(:,1:3)...
         pos_avg_R1(:,4:6) pos_avg_R2(:,4:6) pos_avg_R3(:,4:6)...
         pos_avg_R1(:,7:9) pos_avg_R2(:,7:9) pos_avg_R3(:,7:9)],[-1 1])
set(gca,'xtick',1:27,'xticklabel',{'M: f vs dur';'G1 :f vs dur';'G2: f vs dur';...
                                  'M: f vs md' ;'G1: f vs md' ;'G2: f vs md' ;...
                                  'M: f vs acc';'G1: f vs acc';'G2: f vs acc';...
                                  'M: p vs dur';'G1 :p vs dur';'G2: p vs dur';...
                                  'M: p vs md' ;'G1: p vs md' ;'G2: p vs md' ;...
                                  'M: p vs acc';'G1: p vs acc';'G2: p vs acc';...
                                  'M: s vs dur';'G1 :s vs dur';'G2: s vs dur';...
                                  'M: s vs md' ;'G1: s vs md' ;'G2: s vs md' ;...
                                  'M: s vs acc';'G1: s vs acc';'G2: s vs acc';})
hold on; line('XData',[0.5 0.5],'YData',[0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                              
hold on; line('XData',[9.5 9.5],'YData',[0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                                
hold on; line('XData',[0.5 9.5],'YData',[0.5 0.5],'Color','k','LineWidth',3)                              
hold on; line('XData',[0.5 9.5],'YData',[size(Total_R1,1)+0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)  

hold on; line('XData',[9.5 9.5],'YData',[0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                              
hold on; line('XData',[18.5 18.5],'YData',[0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                                
hold on; line('XData',[9.5 18.5],'YData',[0.5 0.5],'Color','k','LineWidth',3)                              
hold on; line('XData',[9.5 18.5],'YData',[size(Total_R1,1)+0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3) 

hold on; line('XData',[18.5 18.5],'YData',[0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                              
hold on; line('XData',[27.5 27.5],'YData',[0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                                
hold on; line('XData',[18.5 27.5],'YData',[0.5 0.5],'Color','k','LineWidth',3)                              
hold on; line('XData',[18.5 27.5],'YData',[size(Total_R1,1)+0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                               
xticklabel_rotate([],45,[],'Fontsize',14)
title('positively correlated chan avg correlation')
colorbar

print('-dpng',[root '/DATA/NEW/across_subjects_plots/best_CHAN_posCORR_nocorr_'...
    num2str(freqband(1)) '-' num2str(freqband(2)) '_' condname 'Hz.png']);

fig                 = figure('position',[1 1 800 600]);
set(fig,'PaperPosition',[1 1 800 600])
set(fig,'PaperPositionMode','auto')


imagesc([neg_avg_R1(:,1:3) neg_avg_R2(:,1:3) neg_avg_R3(:,1:3)...
         neg_avg_R1(:,4:6) neg_avg_R2(:,4:6) neg_avg_R3(:,4:6)...
         neg_avg_R1(:,7:9) neg_avg_R2(:,7:9) neg_avg_R3(:,7:9)],[-1 1])
set(gca,'xtick',1:27,'xticklabel',{'M: f vs dur';'G1 :f vs dur';'G2: f vs dur';...
                                  'M: f vs md' ;'G1: f vs md' ;'G2: f vs md' ;...
                                  'M: f vs acc';'G1: f vs acc';'G2: f vs acc';...
                                  'M: p vs dur';'G1 :p vs dur';'G2: p vs dur';...
                                  'M: p vs md' ;'G1: p vs md' ;'G2: p vs md' ;...
                                  'M: p vs acc';'G1: p vs acc';'G2: p vs acc';...
                                  'M: s vs dur';'G1 :s vs dur';'G2: s vs dur';...
                                  'M: s vs md' ;'G1: s vs md' ;'G2: s vs md' ;...
                                  'M: s vs acc';'G1: s vs acc';'G2: s vs acc';})
hold on; line('XData',[0.5 0.5],'YData',[0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                              
hold on; line('XData',[9.5 9.5],'YData',[0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                                
hold on; line('XData',[0.5 9.5],'YData',[0.5 0.5],'Color','k','LineWidth',3)                              
hold on; line('XData',[0.5 9.5],'YData',[size(Total_R1,1)+0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)  

hold on; line('XData',[9.5 9.5],'YData',[0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                              
hold on; line('XData',[18.5 18.5],'YData',[0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                                
hold on; line('XData',[9.5 18.5],'YData',[0.5 0.5],'Color','k','LineWidth',3)                              
hold on; line('XData',[9.5 18.5],'YData',[size(Total_R1,1)+0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3) 

hold on; line('XData',[18.5 18.5],'YData',[0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                              
hold on; line('XData',[27.5 27.5],'YData',[0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                                
hold on; line('XData',[18.5 27.5],'YData',[0.5 0.5],'Color','k','LineWidth',3)                              
hold on; line('XData',[18.5 27.5],'YData',[size(Total_R1,1)+0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                               
xticklabel_rotate([],45,[],'Fontsize',14)
title('negatively correlated chan avg correlation')
colorbar

% save print
print('-dpng',[root '/DATA/NEW/across_subjects_plots/best_CHAN_negCORR_nocorr_'...
    num2str(freqband(1)) '-' num2str(freqband(2)) '_' condname 'Hz.png']);

pos_mask_1 = (pos_avg_p1 <= 0.05/size(Total_p1,1));
pos_mask_2 = (pos_avg_p2 <= 0.05/size(Total_p1,1));
pos_mask_3 = (pos_avg_p3 <= 0.05/size(Total_p1,1));

neg_mask_1 = (neg_avg_p1 <= 0.05/size(Total_p1,1));
neg_mask_2 = (neg_avg_p2 <= 0.05/size(Total_p1,1));
neg_mask_3 = (neg_avg_p3 <= 0.05/size(Total_p1,1));

% figure parameters
fig                 = figure('position',[1 1 800 600]);
set(fig,'PaperPosition',[1 1 800 600])
set(fig,'PaperPositionMode','auto')
colorbar

imagesc([pos_avg_R1(:,1:3).*pos_mask_1(:,1:3) pos_avg_R2(:,1:3).*pos_mask_2(:,1:3) pos_avg_R3(:,1:3).*pos_mask_3(:,1:3)...
         pos_avg_R1(:,4:6).*pos_mask_1(:,4:6) pos_avg_R2(:,4:6).*pos_mask_2(:,4:6) pos_avg_R3(:,4:6).*pos_mask_3(:,4:6)...
         pos_avg_R1(:,7:9).*pos_mask_1(:,7:9) pos_avg_R2(:,7:9).*pos_mask_2(:,7:9) pos_avg_R3(:,7:9).*pos_mask_3(:,7:9)],[-1 1])
set(gca,'xtick',1:27,'xticklabel',{'M: f vs dur';'G1 :f vs dur';'G2: f vs dur';...
                                  'M: f vs md' ;'G1: f vs md' ;'G2: f vs md' ;...
                                  'M: f vs acc';'G1: f vs acc';'G2: f vs acc';...
                                  'M: p vs dur';'G1 :p vs dur';'G2: p vs dur';...
                                  'M: p vs md' ;'G1: p vs md' ;'G2: p vs md' ;...
                                  'M: p vs acc';'G1: p vs acc';'G2: p vs acc';...
                                  'M: s vs dur';'G1 :s vs dur';'G2: s vs dur';...
                                  'M: s vs md' ;'G1: s vs md' ;'G2: s vs md' ;...
                                  'M: s vs acc';'G1: s vs acc';'G2: s vs acc';})
hold on; line('XData',[0.5 0.5],'YData',[0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                              
hold on; line('XData',[9.5 9.5],'YData',[0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                                
hold on; line('XData',[0.5 9.5],'YData',[0.5 0.5],'Color','k','LineWidth',3)                              
hold on; line('XData',[0.5 9.5],'YData',[size(Total_R1,1)+0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)  

hold on; line('XData',[9.5 9.5],'YData',[0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                              
hold on; line('XData',[18.5 18.5],'YData',[0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                                
hold on; line('XData',[9.5 18.5],'YData',[0.5 0.5],'Color','k','LineWidth',3)                              
hold on; line('XData',[9.5 18.5],'YData',[size(Total_R1,1)+0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3) 

hold on; line('XData',[18.5 18.5],'YData',[0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                              
hold on; line('XData',[27.5 27.5],'YData',[0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                                
hold on; line('XData',[18.5 27.5],'YData',[0.5 0.5],'Color','k','LineWidth',3)                              
hold on; line('XData',[18.5 27.5],'YData',[size(Total_R1,1)+0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                               
xticklabel_rotate([],45,[],'Fontsize',14)
title('positively correlated chan avg correlation')
colorbar

print('-dpng',[root '/DATA/NEW/across_subjects_plots/best_CHAN_posCORR_bonf_'...
    num2str(freqband(1)) '-' num2str(freqband(2)) '_' condname 'Hz.png']);

fig                 = figure('position',[1 1 800 600]);
set(fig,'PaperPosition',[1 1 800 600])
set(fig,'PaperPositionMode','auto')

imagesc([neg_avg_R1(:,1:3).*neg_mask_1(:,1:3) neg_avg_R2(:,1:3).*neg_mask_2(:,1:3) neg_avg_R3(:,1:3).*neg_mask_3(:,1:3)...
         neg_avg_R1(:,4:6).*neg_mask_1(:,4:6) neg_avg_R2(:,4:6).*neg_mask_2(:,4:6) neg_avg_R3(:,4:6).*neg_mask_3(:,4:6)...
         neg_avg_R1(:,7:9).*neg_mask_1(:,7:9) neg_avg_R2(:,7:9).*neg_mask_2(:,7:9) neg_avg_R3(:,7:9).*neg_mask_3(:,7:9)],[-1 1])
set(gca,'xtick',1:27,'xticklabel',{'M: f vs dur';'G1 :f vs dur';'G2: f vs dur';...
                                  'M: f vs md' ;'G1: f vs md' ;'G2: f vs md' ;...
                                  'M: f vs acc';'G1: f vs acc';'G2: f vs acc';...
                                  'M: p vs dur';'G1 :p vs dur';'G2: p vs dur';...
                                  'M: p vs md' ;'G1: p vs md' ;'G2: p vs md' ;...
                                  'M: p vs acc';'G1: p vs acc';'G2: p vs acc';...
                                  'M: s vs dur';'G1 :s vs dur';'G2: s vs dur';...
                                  'M: s vs md' ;'G1: s vs md' ;'G2: s vs md' ;...
                                  'M: s vs acc';'G1: s vs acc';'G2: s vs acc';})
hold on; line('XData',[0.5 0.5],'YData',[0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                              
hold on; line('XData',[9.5 9.5],'YData',[0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                                
hold on; line('XData',[0.5 9.5],'YData',[0.5 0.5],'Color','k','LineWidth',3)                              
hold on; line('XData',[0.5 9.5],'YData',[size(Total_R1,1)+0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)  

hold on; line('XData',[9.5 9.5],'YData',[0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                              
hold on; line('XData',[18.5 18.5],'YData',[0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                                
hold on; line('XData',[9.5 18.5],'YData',[0.5 0.5],'Color','k','LineWidth',3)                              
hold on; line('XData',[9.5 18.5],'YData',[size(Total_R1,1)+0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3) 

hold on; line('XData',[18.5 18.5],'YData',[0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                              
hold on; line('XData',[27.5 27.5],'YData',[0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                                
hold on; line('XData',[18.5 27.5],'YData',[0.5 0.5],'Color','k','LineWidth',3)                              
hold on; line('XData',[18.5 27.5],'YData',[size(Total_R1,1)+0.5 size(Total_R1,1)+0.5],'Color','k','LineWidth',3)                               
xticklabel_rotate([],45,[],'Fontsize',14)
title('negatively correlated chan avg correlation')
colorbar

print('-dpng',[root '/DATA/NEW/across_subjects_plots/best_CHAN_negCORR_bonf_'...
    num2str(freqband(1)) '-' num2str(freqband(2)) '_' condname 'Hz.png']);


%%%%%%%%%%%%%%%%%%%%%% probability topos %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% plot mean topographies
fig                 = figure('position',[1 1 800 600]);
set(fig,'PaperPosition',[1 1 800 600])
set(fig,'PaperPositionMode','auto')
cfg = [];
cfg.layout            = '\\poivre\meg\meg_tmp\temprod_Baptiste_2010\SCRIPTS\Layouts_fieldtrip/NM306mag.lay';
cfg.maplimits         = [0 length(SubjectArray)];
cfg.style             = 'straight';
cfg.electrodes        = 'off';
mysubplot(3,3,1); cfg.comment = 'M: freq vs Dur'; topoplot(cfg,neg_counts{1}');
mysubplot(3,3,2); cfg.comment = 'M: freq vs Med'; topoplot(cfg,neg_counts{4}');
mysubplot(3,3,3); cfg.comment = 'M: freq vs Acc'; topoplot(cfg,neg_counts{7}');
mysubplot(3,3,4); cfg.comment = 'G1: freq vs Dur'; topoplot(cfg,neg_counts{2}');
mysubplot(3,3,5); cfg.comment = 'G1: freq vs Med'; topoplot(cfg,neg_counts{5}');
mysubplot(3,3,6); cfg.comment = 'G1: freq vs Acc'; topoplot(cfg,neg_counts{8}');
mysubplot(3,3,7); cfg.comment = 'G2: freq vs Dur'; topoplot(cfg,neg_counts{3}');
mysubplot(3,3,8); cfg.comment = 'G2: freq vs Med'; topoplot(cfg,neg_counts{6}');
mysubplot(3,3,9); cfg.comment = 'G2: freq vs Acc'; topoplot(cfg,neg_counts{9}');
print('-dpng',[root '/DATA/NEW/across_subjects_plots/probaTOPO_freq_negcorr_'...
    num2str(freqband(1)) '-' num2str(freqband(2)) '_' condname 'Hz.png']);

fig                 = figure('position',[1 1 800 600]);
set(fig,'PaperPosition',[1 1 800 600])
set(fig,'PaperPositionMode','auto')
cfg = [];
cfg.layout            = '\\poivre\meg\meg_tmp\temprod_Baptiste_2010\SCRIPTS\Layouts_fieldtrip/NM306mag.lay';
cfg.maplimits         = [0 length(SubjectArray)];
cfg.style             = 'straight';
cfg.electrodes        = 'off';
mysubplot(3,3,1); cfg.comment = 'M: pow vs Dur'; topoplot(cfg,neg_counts{10}');
mysubplot(3,3,2); cfg.comment = 'M: pow vs Med'; topoplot(cfg,neg_counts{13}');
mysubplot(3,3,3); cfg.comment = 'M: pow vs Acc'; topoplot(cfg,neg_counts{16}');
mysubplot(3,3,4); cfg.comment = 'G1: pow vs Dur'; topoplot(cfg,neg_counts{11}');
mysubplot(3,3,5); cfg.comment = 'G1: pow vs Med'; topoplot(cfg,neg_counts{14}');
mysubplot(3,3,6); cfg.comment = 'G1: pow vs Acc'; topoplot(cfg,neg_counts{17}');
mysubplot(3,3,7); cfg.comment = 'G2: pow vs Dur'; topoplot(cfg,neg_counts{12}');
mysubplot(3,3,8); cfg.comment = 'G2: pow vs Med'; topoplot(cfg,neg_counts{15}');
mysubplot(3,3,9); cfg.comment = 'G2: pow vs Acc'; topoplot(cfg,neg_counts{18}');
print('-dpng',[root '/DATA/NEW/across_subjects_plots/probaTOPO_pow_negcorr_'...
    num2str(freqband(1)) '-' num2str(freqband(2)) '_' condname 'Hz.png']);

fig                 = figure('position',[1 1 800 600]);
set(fig,'PaperPosition',[1 1 800 600])
set(fig,'PaperPositionMode','auto')
cfg = [];
cfg.layout            = '\\poivre\meg\meg_tmp\temprod_Baptiste_2010\SCRIPTS\Layouts_fieldtrip/NM306mag.lay';
cfg.maplimits         = [0 length(SubjectArray)];
cfg.style             = 'straight';
cfg.electrodes        = 'off';
mysubplot(3,3,1); cfg.comment = 'M: slope vs Dur'; topoplot(cfg,neg_counts{19}');
mysubplot(3,3,2); cfg.comment = 'M: slope vs Med'; topoplot(cfg,neg_counts{22}');
mysubplot(3,3,3); cfg.comment = 'M: slope vs Acc'; topoplot(cfg,neg_counts{25}');
mysubplot(3,3,4); cfg.comment = 'G1: slope vs Dur'; topoplot(cfg,neg_counts{20}');
mysubplot(3,3,5); cfg.comment = 'G1: slope vs Med'; topoplot(cfg,neg_counts{23}');
mysubplot(3,3,6); cfg.comment = 'G1: slope vs Acc'; topoplot(cfg,neg_counts{26}');
mysubplot(3,3,7); cfg.comment = 'G2: slope vs Dur'; topoplot(cfg,neg_counts{21}');
mysubplot(3,3,8); cfg.comment = 'G2: slope vs Med'; topoplot(cfg,neg_counts{24}');
mysubplot(3,3,9); cfg.comment = 'G2: slope vs Acc'; topoplot(cfg,neg_counts{27}');
print('-dpng',[root '/DATA/NEW/across_subjects_plots/probaTOPO_pow_negcorr_'...
    num2str(freqband(1)) '-' num2str(freqband(2)) '_' condname 'Hz.png']);

fig                 = figure('position',[1 1 800 600]);
set(fig,'PaperPosition',[1 1 800 600])
set(fig,'PaperPositionMode','auto')
cfg = [];
cfg.layout            = '\\poivre\meg\meg_tmp\temprod_Baptiste_2010\SCRIPTS\Layouts_fieldtrip/NM306mag.lay';
cfg.maplimits         = [0 length(SubjectArray)];
cfg.style             = 'straight';
cfg.electrodes        = 'off';
mysubplot(3,3,1); cfg.comment = 'M: freq vs Dur'; topoplot(cfg,pos_counts{1}');
mysubplot(3,3,2); cfg.comment = 'M: freq vs Med'; topoplot(cfg,pos_counts{4}');
mysubplot(3,3,3); cfg.comment = 'M: freq vs Acc'; topoplot(cfg,pos_counts{7}');
mysubplot(3,3,4); cfg.comment = 'G1: freq vs Dur'; topoplot(cfg,pos_counts{2}');
mysubplot(3,3,5); cfg.comment = 'G1: freq vs Med'; topoplot(cfg,pos_counts{5}');
mysubplot(3,3,6); cfg.comment = 'G1: freq vs Acc'; topoplot(cfg,pos_counts{8}');
mysubplot(3,3,7); cfg.comment = 'G2: freq vs Dur'; topoplot(cfg,pos_counts{3}');
mysubplot(3,3,8); cfg.comment = 'G2: freq vs Med'; topoplot(cfg,pos_counts{6}');
mysubplot(3,3,9); cfg.comment = 'G2: freq vs Acc'; topoplot(cfg,pos_counts{9}');
print('-dpng',[root '/DATA/NEW/across_subjects_plots/probaTOPO_freq_poscorr_'...
    num2str(freqband(1)) '-' num2str(freqband(2)) '_' condname 'Hz.png']);

fig                 = figure('position',[1 1 800 600]);
set(fig,'PaperPosition',[1 1 800 600])
set(fig,'PaperPositionMode','auto')
cfg = [];
cfg.layout            = '\\poivre\meg\meg_tmp\temprod_Baptiste_2010\SCRIPTS\Layouts_fieldtrip/NM306mag.lay';
cfg.maplimits         = [0 length(SubjectArray)];
cfg.style             = 'straight';
cfg.electrodes        = 'off';
mysubplot(3,3,1); cfg.comment = 'M: pow vs Dur'; topoplot(cfg,pos_counts{10}');
mysubplot(3,3,2); cfg.comment = 'M: pow vs Med'; topoplot(cfg,pos_counts{13}');
mysubplot(3,3,3); cfg.comment = 'M: pow vs Acc'; topoplot(cfg,pos_counts{16}');
mysubplot(3,3,4); cfg.comment = 'G1: pow vs Dur'; topoplot(cfg,pos_counts{11}');
mysubplot(3,3,5); cfg.comment = 'G1: pow vs Med'; topoplot(cfg,pos_counts{14}');
mysubplot(3,3,6); cfg.comment = 'G1: pow vs Acc'; topoplot(cfg,pos_counts{17}');
mysubplot(3,3,7); cfg.comment = 'G2: pow vs Dur'; topoplot(cfg,pos_counts{12}');
mysubplot(3,3,8); cfg.comment = 'G2: pow vs Med'; topoplot(cfg,pos_counts{15}');
mysubplot(3,3,9); cfg.comment = 'G2: pow vs Acc'; topoplot(cfg,pos_counts{18}');
print('-dpng',[root '/DATA/NEW/across_subjects_plots/probaTOPO_pow_poscorr_'...
    num2str(freqband(1)) '-' num2str(freqband(2)) '_' condname 'Hz.png']);

fig                 = figure('position',[1 1 800 600]);
set(fig,'PaperPosition',[1 1 800 600])
set(fig,'PaperPositionMode','auto')
cfg = [];
cfg.layout            = '\\poivre\meg\meg_tmp\temprod_Baptiste_2010\SCRIPTS\Layouts_fieldtrip/NM306mag.lay';
cfg.maplimits         = [0 length(SubjectArray)];
cfg.style             = 'straight';
cfg.electrodes        = 'off';
mysubplot(3,3,1); cfg.comment = 'M: slope vs Dur'; topoplot(cfg,pos_counts{19}');
mysubplot(3,3,2); cfg.comment = 'M: slope vs Med'; topoplot(cfg,pos_counts{22}');
mysubplot(3,3,3); cfg.comment = 'M: slope vs Acc'; topoplot(cfg,pos_counts{25}');
mysubplot(3,3,4); cfg.comment = 'G1: slope vs Dur'; topoplot(cfg,pos_counts{20}');
mysubplot(3,3,5); cfg.comment = 'G1: slope vs Med'; topoplot(cfg,pos_counts{23}');
mysubplot(3,3,6); cfg.comment = 'G1: slope vs Acc'; topoplot(cfg,pos_counts{26}');
mysubplot(3,3,7); cfg.comment = 'G2: slope vs Dur'; topoplot(cfg,pos_counts{21}');
mysubplot(3,3,8); cfg.comment = 'G2: slope vs Med'; topoplot(cfg,pos_counts{24}');
mysubplot(3,3,9); cfg.comment = 'G2: slope vs Acc'; topoplot(cfg,pos_counts{27}');
print('-dpng',[root '/DATA/NEW/across_subjects_plots/probaTOPO_pow_negcorr_'...
    num2str(freqband(1)) '-' num2str(freqband(2)) '_' condname 'Hz.png']);

