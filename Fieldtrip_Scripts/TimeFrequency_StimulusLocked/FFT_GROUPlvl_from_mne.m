function FFT_GROUPlvl_from_mne(niplist,chansel,condnames,latency,graphcolor,test)

% nip = the NIP code of the subject
% chansel, can be either 'Mags', 'Grads1','Grads2' or 'EEG'
% condnames = the name of the columns conditions 
% condarray: conditions organized in a x*y cell array
% the rows x define all the subconditions of the y column conditions

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% PREPARE COMPUTATIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% define channel types
[Grads1,Grads2,Mags]   = grads_for_layouts('Network');
EEG  = EEG_for_layouts('Network');

ch = [];
if strcmp(chansel,'Mags')
    ch = Mags;
elseif strcmp(chansel,'Grads1')
    ch = Grads1;
elseif strcmp(chansel,'Grads2')
    ch = Grads2;
elseif strcmp(chansel,'cmb')
    ch = Mags; %temporary
else strcmp(chansel,'EEG')
    ch = EEG;
end

% selection
if length(condnames) > 2
    statstag = 'F';
else
    statstag = 'T';
end

% switch from separated to concatenated names
cdn = [];
for i = 1:length(condnames)
    cdn = [cdn condnames{i} '_'];
end

% load cell array of conditions
 instrmulti = 'ft_multiplotER(cfg,';
 instrsingle = 'ft_singleplotER(cfg,';
for j = 1:length(niplist)
    datatmp{j}   = load(['/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Subjects/' niplist{j} '/MegData/TFs/FFT_' cdn chansel],'pow');
    instrmulti     = [instrmulti 'datatmp{1,' num2str(j) '}.pow{1,1},'];
    instrsingle    = [instrsingle 'datatmp{1,' num2str(j) '}.pow{1,1},'];
end
instrmulti(end)  = [];
instrsingle(end) = [];
instrmulti          = [instrmulti ');'];
instrsingle         = [instrsingle ');'];

close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% COMPUTE ERFS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:length(datatmp{1,1}.pow)
 
    % for stats
    cfg                             = [];
    cfg.channel                 = ch;
    cfg.trials                     = 'all';
    cfg.keepindividual       = 'yes';
    
    instr = ['GDAVGt{' num2str(i) '} = ft_freqgrandaverage(cfg,'];
    for j = 1:length(datatmp)
        instr = [instr 'datatmp{1,' num2str(j)  '}.pow{1,' num2str(i) '},'];
    end
    instr(end) = [];
    instr      = [instr ');'];
    
    eval([instr]);
    
    instr = [];
    instr = ['GDAVGt{' num2str(i) '} = rmfield(GDAVGt{' num2str(i) '},''cfg'''];
    instr      = [instr ');'];
 
    % for stats
    cfg                             = [];
    cfg.channel                 = ch;
    cfg.trials                     = 'all';
    cfg.keepindividual       = 'no';
    
    instr = ['GDAVG{' num2str(i) '} = ft_freqgrandaverage(cfg,'];
    for j = 1:length(datatmp)
        instr = [instr 'datatmp{1,' num2str(j)  '}.pow{1,' num2str(i) '},'];
    end
    instr(end) = [];
    instr      = [instr ');'];
    
    eval([instr]);
    
    instr = [];
    instr = ['GDAVG{' num2str(i) '} = rmfield(GDAVGt{' num2str(i) '},''cfg'''];
    instr      = [instr ');'];    
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% %%%%%%%%%%%%%%%%%%%% plot summary %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% define channel types
[Grads1,Grads2,Mags]   = grads_for_layouts('Network');
EEG  = EEG_for_layouts('Network');

% prepare layout
cfg                           = [];
if strcmp(chansel,'EEG') == 0
    cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/fieldtrip-20130901/template/layout/NM306mag.lay';
else
    cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/eeg_64_NM20884N.lay';
end
lay                        = ft_prepare_layout(cfg,GDAVGt{1});
lay.label                = GDAVGt{1}.label;

cfg                    = [];
cfg.parameter          = 'powspctrm';
cfg.layout             = lay;
cfg.hlim               = [55 95]
cfg.box                = 'no';
cfg.axes               = 'no'
cfg.interactive        = 'yes';
cfg.linewidth           = 2;
GDAVGt{1}.powspctrm = log(GDAVGt{1}.powspctrm)
GDAVGt{2}.powspctrm = log(GDAVGt{2}.powspctrm)
GDAVGt{3}.powspctrm = log(GDAVGt{3}.powspctrm)

ft_multiplotER(cfg,GDAVGt{1},GDAVGt{2},GDAVGt{3})

tmp1 = GDAVG{1}.powspctrm;
tmp1_1 = GDAVG{1}.powspctrm + squeeze(std(GDAVGt{1}.powspctrm,1))./sqrt(19);
tmp1_2 = GDAVG{1}.powspctrm - squeeze(std(GDAVGt{1}.powspctrm,1))./sqrt(19);
tmp2 = GDAVG{1}.powspctrm;
tmp2_1 = GDAVG{2}.powspctrm + squeeze(std(GDAVGt{2}.powspctrm,1))./sqrt(19);
tmp2_2 = GDAVG{2}.powspctrm - squeeze(std(GDAVGt{2}.powspctrm,1))./sqrt(19);

dummY1   = GDAVG{1};
dummY1_1 = GDAVG{1}; dummY1_1.powspctrm = tmp1_1
dummY1_2 = GDAVG{1}; dummY1_2.powspctrm = tmp1_2
dummY2   = GDAVG{2};
dummY2_1 = GDAVG{2}; dummY2_1.powspctrm = tmp2_1
dummY2_2 = GDAVG{2}; dummY2_2.powspctrm = tmp2_2

cfg.graphcolor          = [[1 0 0];[1 0 0];[1 0 0];[0 0 1];[0 0 1];[0 0 1]];
ft_multiplotER(cfg,dummY1,dummY1_1,dummY1_2,dummY2,dummY2_1,dummY2_2)

cfg.graphcolor = [0 0 0]
diff = GDAVG{1};
% express in dB
diff.powspctrm  = 10* (log(GDAVG{2}.powspctrm)  - log(GDAVG{1}.powspctrm)); 
ft_multiplotER(cfg,diff)

diff2 = GDAVG{3};
% express in dB
diff2.powspctrm  = 10* (log(GDAVG{2}.powspctrm)  - log(GDAVG{3}.powspctrm)); 
ft_multiplotER(cfg,diff2)

cfg.hlim               = [2 100];
cfg.showoutline        = 'yes';
cfg.comment = ['b = Par-W; r = Par-E'];
ft_multiplotER(cfg,diff,diff2)

figure
imagesc(diff.powspctrm(:,2:100),[-1 1]);
title('Power diff (dB)')
ylabel('channels')
xlabel('frequency (Hz)')

figure
imagesc(diff2.powspctrm(:,2:100),[-1 1]);
title('Power diff (dB)')
ylabel('channels')
xlabel('frequency (Hz)')

cfg = []
cfg.style = 'straight'
cfg.xlim = [10 10]
cfg.layout = lay;
cfg.zlim = [-1 1];
cfg.marker = 'off'
figure
for i = 2:100
    mysubplot(10,10,i-1)
    cfg.xlim = [i i]
    cfg.comment = num2str(i);
    ft_topoplotTFR(cfg,diff)
end




