function prepare_GLM_subjlvl2(nip)

%%%%%%%%%%% test parameters %%%%%%%%%%%%
niplist = {'sd130343' ;'cb130477' ;'rb130313'   ;'jm100042' ;'jm100109';'sb120316';...
    'tk130502'  ;'lm130479' ;'sg120518'   ;'ms130534';'ma100253';'sl130503';...
    'mb140004';'mp140019';'mm130405';'dm130250';'hr130504' ;'wl130316';'rl130571'};
source1 = 'EVT';
source2 = 'EVS';
chansel = 'Mags';
latency   = [-0.2 2];
segwin   = [0.3 2.5];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for n = 1:length(niplist)
    
    clear Pred1 Pred2 IND1 IND2 data1 data2 DATA
    
    [Pred1,IND1,data1] = prepare_design2(niplist{n},chansel,source1,segwin,latency);
    [Pred2,IND2,data2] = prepare_design2(niplist{n},chansel,source2,segwin,latency);
    PredEv = [Pred1 ;Pred2];
    
    DATA = cat(1,data1{1}.trial,data2{1}.trial);
    
    indzero = [];
    for i =1:length(PredEv)
        [x,y] = find(sum(PredEv(i,1:size(PredEv,2))) == 0);
        if isempty(x) == 0
            indzero = [indzero i];
        end
    end
    DATA(indzero,:,:) = [];
    PredEv(indzero,:)   = [];
    
    %% FIXME
    % remove zero lines in the design (and in the data accordingly)
    
    for chan = 1:size(DATA,2)
        for timepoint = 1:size(DATA,3)
            b =glmfit(PredEv,squeeze(DATA(:,chan,timepoint)),'normal','constant','off');
            BETA(chan,timepoint,:) =b;
        end
    end
    
    BETAallSUB{i} = BETA;
    
end

%%

figure
for i =1:size(BETA,3)
    subplot(4,4,i)
    imagesc(squeeze(BETA(:,:,i)),[-5.e-14 5e-14])
end

dummydata = [];
dummydata.avg = squeeze(BETA(:,:,3));
dummydata.time = data1{1}.time;
dummydata.dimord = 'chan_time';
dummydata.label = data1{1}.label;

cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/fieldtrip-20130901/template/layout/NM306mag.lay';
lay                        = ft_prepare_layout(cfg,data1{1});
lay.label                  = data1{1}.label;

% lim = [-max(max(dummydata.avg)) max(max(dummydata.avg))];



