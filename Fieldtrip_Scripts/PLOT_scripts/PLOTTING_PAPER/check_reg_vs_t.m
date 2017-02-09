addpath('/neurospin/meg/meg_tmp/MTT_MEG_Baptiste/From_laptop/Scripts/PLOTTING_PAPER')

%% TEST INPUT 1 mags occipital
condnames_clust = {'RefPast';'RefFut'};
condnames    = {'RefPast';'RefFut'};
latency      = [1.1 2];
graphcolor   = [[1 0.7 0.7];[1 0 0]];
stat_test    = 'T';
chansel      = 'Mags';
clustnum     = 0;
clusttype    = 'posclust';
timetag      = '2016712104337';

[ch_pasfut2, cdn_pasfut2, cdn_clust_pasfut2, stat_pasfut2, GDAVG_pasfut2, GDAVGt_pasfut2] = prepare_comp(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)

%% data shaping: load cluster 1 and average data across subjects
condnames    = {'RefPast';'RefPre';'RefFut'};
condnames_clust   = {'RefPast';'RefPre';'RefFut'};
latency      = [1.1 2];
graphcolor   = [[1 0.7 0.7];[0 0 0];[1 0 0]];
stat_test    = 'Reg';
chansel      = 'Mags';
clustnum     = 0;
clusttype    = 'negclust';
timetag      = '201651018728';

[ch, cdn, cdn_clust, stat, GDAVG, GDAVGt] = prepare_comp(niplist,condnames,...
    condnames_clust, latency, graphcolor , stat_test, chansel, clustnum, clusttype, timetag)


