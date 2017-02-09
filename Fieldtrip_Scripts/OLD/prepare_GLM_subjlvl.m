function prepare_GLM_subjlvl(nip)

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

for n = 1:19
    
    clear Pred1 Pred2 IND1 IND2 data1 data2 DATA
    
    [Pred1,IND1,data1] = prepare_design(niplist{n},chansel,source1,segwin,latency);
    [Pred2,IND2,data2] = prepare_design(niplist{n},chansel,source2,segwin,latency);
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
    
    BETA = [];
    for chan = 1:size(DATA,2)
        for timepoint = 1:size(DATA,3)
            b =glmfit(PredEv,squeeze(DATA(:,chan,timepoint)),'normal','constant','off');
            BETA(chan,timepoint,:) =b;
        end
    end
    
    BETAallSUB{n} = BETA;
    
end

%%

figure
for i =1:size(BETA,3)
    subplot(4,4,i)
    imagesc(squeeze(BETA(:,:,i)))
end

dummydata = [];
dummydata.avg = squeeze(BETA(:,:,3));
dummydata.time = data1{1}.time;
dummydata.dimord = 'chan_time';
dummydata.label = data1{1}.label;

cfg.layout             = '/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/fieldtrip-20130901/template/layout/NM306mag.lay';
lay                        = ft_prepare_layout(cfg,data1{1});
lay.label                  = data1{1}.label;

lim = [-max(max(dummydata.avg)) max(max(dummydata.avg))];

sample = (dummydata.time(end) - dummydata.time(1))./length(dummydata.time);
n = round(0.1/sample);
nfull = floor(length(dummydata.time)/n);

fig = figure('position',[1 1 1100 1000]);
set(fig,'PaperPosition',[1 1 1100 1000])
set(fig,'PaperPositionmode','auto')
set(fig,'Visible','on')
for j = 1:20
    mysubplot(5,5,j)
    cfg                          = [];
    cfg.layout                 = lay;
    cfg.xlim                   = [round(dummydata.time(1+n*(j-1))*100)/100 round(dummydata.time(1+n*(j-1))*100)/100];
    cfg.zlim                   = lim;
    cfg.style                   = 'straight';
    cfg.parameter          = 'avg';
    cfg.marker               = 'off';
    cfg.comment              = 'no';
    ft_topoplotER(cfg,dummydata);
    text(0.4,0.4,[num2str(round(dummydata.time(1+n*(j-1))*100)/100) ],'fontsize',14,'fontweight','b');
end

%% test stats grouplvl on beta

for chan = 1:size(BETAallSUB{1},1)
    for timepoint = 1:size(BETAallSUB{1},2)
        betatest = [];
        for i =1:length(niplist)
           betatest = [betatest BETAallSUB{i}(chan,timepoint)];
        end
        [H,P,CI,STATS] = ttest(betatest);
        GROUP_TMAP(chan, timepoint) = STATS.tstat;
        GROUP_PMAP(chan, timepoint) = P;
        GROUP_SDMAP(chan, timepoint) = STATS.sd;
    end
end

figure
imagesc(-log(GROUP_PMAP))
figure
imagesc(GROUP_TMAP,[-5 5])

MASK_001_unc = GROUP_PMAP <= 0.001;
MASK_05_unc = GROUP_PMAP <= 0.05;

addpath('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/resampling_statistical_toolkit/statistics')

% [PID,pN] = FDR(GROUP_PMAP,0.05);
% [p_fdr, p_masked] = fdr( GROUP_PMAP, 0.05);
% [p_fdr, p_masked] = fdr( GROUP_PMAP, 0.05,'nonParametric');

%% test t-test grouplvl fiedltrip-based with dummy variable containing zeros vs betas

% ERFstat_General(condnames,latency,GDAVG,GDAVGt, chansel_,graphcolor,varargin)
BETAVG = [];
for i = 1:19
    BETAVG = cat(3,BETAVG,BETAallSUB{i}(:,:,3));
end
BETAVG = permute(BETAVG,[3 1 2]);

condnames               = {'TJ_beta';'dummyzero'};
latency                     = [0 1];
chansel_                   = 'Mags';
graphcolor                = [[1 0 0];[0 0 0]];

GDAVG = [];
GDAVG{1,1}.avg       = squeeze(mean(BETAVG,1));   
GDAVG{1,1}.time      = data1{1}.time;
GDAVG{1,1}.label     =  data1{1}.label;
GDAVG{1,1}.dimord  = 'chan_time';

GDAVG{1,2}.avg       =  zeros(102,564);
GDAVG{1,2}.time      = data1{1}.time;
GDAVG{1,2}.label     =  data1{1}.label;
GDAVG{1,2}.dimord  = 'chan_time';

GDAVGt{1,1} = [];
GDAVGt{1,1}.individual       =  BETAVG;  
GDAVGt{1,1}.time      = data1{1}.time;
GDAVGt{1,1}.label     =  data1{1}.label;
GDAVGt{1,1}.dimord  = 'subj_chan_time';

GDAVGt{1,2} = [];
GDAVGt{1,2}.individual      =  zeros(19,102,564);
GDAVGt{1,2}.time      = data1{1}.time;
GDAVGt{1,2}.label     =  data1{1}.label;
GDAVGt{1,2}.dimord  = 'subj_chan_time';

data_1                        = GDAVGt{1,1};
data_2                        = GDAVGt{1,2};

ERFstat_General(condnames,latency,GDAVG,GDAVGt, chansel_,graphcolor,data_1,data_2)















