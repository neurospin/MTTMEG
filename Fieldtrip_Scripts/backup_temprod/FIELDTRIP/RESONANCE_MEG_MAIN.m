% RESONANCE MEG MAIN
clear all
close all

addpath('C:\RESONANCE_MEG\SCRIPTS\FIELDTRIP')
addpath(genpath('C:\FIELDTRIP\fieldtrip-20120402'));
% addpath('C:\FIELDTRIP\fieldtrip-20120402');
% addpath(genpath('C:\FIELDTRIP\fieldtrip-20111020'));
addpath(genpath('C:\TEMPROD\SCRIPTS\Matlab_pipeline\Ref_functions'));
addpath(genpath('C:\RESONANCE_fMRI\Resonance2010_batched'))

% preprocessing
resonance_preproc('run1','cb100118','localizer','Laptop')
resonance_preproc('run2','cb100118','localizer','Laptop')

resonance_preproc('run1','nr100115','localizer','Laptop')
resonance_preproc('run2','nr100115','localizer','Laptop')

resonance_preproc('run1','pe110338','localizer','Laptop')
resonance_preproc('run2','pe110338','localizer','Laptop')
resonance_preproc('run3','pe110338','localizer','Laptop')
resonance_preproc('run4','pe110338','localizer','Laptop')

resonance_preproc('run1','ns110383','localizer','Laptop')
resonance_preproc('run2','ns110383','localizer','Laptop')
resonance_preproc('run3','ns110383','localizer','Laptop')
resonance_preproc('run4','ns110383','localizer','Laptop')

resonance_preproc('run1','cd100449','localizer','Laptop')
resonance_preproc('run2','cd100449','localizer','Laptop')
resonance_preproc('run3','cd100449','localizer','Laptop')
resonance_preproc('run4','cd100449','localizer','Laptop')

resonance_preproc_localizer('localizer','cb100118','localizer','Laptop')
resonance_preproc_localizer('localizer','nr110115','localizer','Laptop')
resonance_preproc_localizer('localizer','pe110338','localizer','Laptop')
resonance_preproc_localizer('localizer','ns110383','localizer','Laptop')
resonance_preproc_localizer('localizer','cd100449','localizer','Laptop')

% frequency analysis

resonance_freqanalysis('run1','cb100118','Laptop')
resonance_freqanalysis('run2','cb100118','Laptop')

resonance_freqanalysis('run1','nr110115','Laptop')
resonance_freqanalysis('run2','nr110115','Laptop')

resonance_freqanalysis('run1','pe110338','Laptop')
resonance_freqanalysis('run2','pe110338','Laptop')
resonance_freqanalysis('run3','pe110338','Laptop')
resonance_freqanalysis('run4','pe110338','Laptop')

resonance_freqanalysis('run1','ns110383','Laptop')
resonance_freqanalysis('run2','ns110383','Laptop')
resonance_freqanalysis('run3','ns110383','Laptop')
resonance_freqanalysis('run4','ns110383','Laptop')

resonance_freqanalysis('run1','cd100449','Laptop')
resonance_freqanalysis('run2','cd100449','Laptop')
resonance_freqanalysis('run3','cd100449','Laptop')
resonance_freqanalysis('run4','cd100449','Laptop')

% average overs trials
resonance_freq_gdavg_trl_keep('cb100118','run1','run2')
resonance_freq_gdavg_trl_keep('nr110115','run1','run2')
resonance_freq_gdavg_trl_keep('pe110338','run1','run2','run3','run4')
resonance_freq_gdavg_trl_keep('ns110383','run1','run2','run3','run4')
resonance_freq_gdavg_trl_keep('cd100449','run1','run2','run3','run4')

% average baseline over trial and cond for each subject for using a unique
% and least noisy ref for each subject
resonance_base_gdavg_trl('cb100118','run1','run2')
resonance_base_gdavg_trl('nr110115','run1','run2')
resonance_base_gdavg_trl('pe110338','run1','run2','run3','run4')
resonance_base_gdavg_trl('ns110383','run1','run2','run3','run4')
resonance_base_gdavg_trl('cd100449','run1','run2','run3','run4')

% plot subject-by-subject spectra
resonance_freq_gdavg_plot('cb100118');
resonance_freq_gdavg_plot('nr110115');
resonance_freq_gdavg_plot('pe110338');
resonance_freq_gdavg_plot('ns110383');
resonance_freq_gdavg_plot('cd100449');

% plot subject-by-subject ssr topographies
resonance_topoplot_2('cb100118');
resonance_topoplot_2('nr110115');
resonance_topoplot_2('pe110338');
resonance_topoplot_2('ns110383');
resonance_topoplot_2('cd100449');

% compute and plot localizer ERFS
resonance_localizer_ERF('cb100118','Laptop')
resonance_localizer_ERF('nr110115','Laptop')
resonance_localizer_ERF('pe110338','Laptop')
resonance_localizer_ERF('ns110383','Laptop')
resonance_localizer_ERF('cd100449','Laptop')

[yf{1},ys{1}] = resonance_tuning_multiplot('cb100118',{'run1','run2'},'Laptop');
[yf{2},ys{2}] = resonance_tuning_multiplot('nr110115',{'run1','run2'},'Laptop');
[yf{3},ys{3}] = resonance_tuning_multiplot('pe110338',{'run1','run2','run3','run4'},'Laptop');
[yf{4},ys{4}] = resonance_tuning_multiplot('ns110383',{'run1','run2','run3','run4'},'Laptop');
[yf{5},ys{5}] = resonance_tuning_multiplot('cd100449',{'run1','run2','run3','run4'},'Laptop');

% compute ERF-based spatial filter
SPF_cb100118_face_v2   = resonance_ERF_spatial_filter_v2('cb100118','face','no','Laptop');
SPF_cb100118_place_v2  = resonance_ERF_spatial_filter_v2('cb100118','place','no','Laptop');
SPF_cb100118_object_v2 = resonance_ERF_spatial_filter_v2('cb100118','object','no','Laptop');

SPF_nr110115_face_v2   = resonance_ERF_spatial_filter_v2('nr110115','face','no','Laptop');
SPF_nr110115_place_v2  = resonance_ERF_spatial_filter_v2('nr110115','place','no','Laptop');
SPF_nr110115_object_v2 = resonance_ERF_spatial_filter_v2('nr110115','object','no','Laptop');

SPF_pe110338_face_v2   = resonance_ERF_spatial_filter_v2('pe110338','face','no','Laptop');
SPF_pe110338_place_v2  = resonance_ERF_spatial_filter_v2('pe110338','place','no','Laptop');
SPF_pe110338_object_v2 = resonance_ERF_spatial_filter_v2('pe110338','object','no','Laptop');

SPF_ns110383_face_v2   = resonance_ERF_spatial_filter_v2('ns110383','face','no','Laptop');
SPF_ns110383_place_v2  = resonance_ERF_spatial_filter_v2('ns110383','place','no','Laptop');
SPF_ns110383_object_v2 = resonance_ERF_spatial_filter_v2('ns110383','object','no','Laptop');

SPF_cd100449_face_v2   = resonance_ERF_spatial_filter_v2('cd100449','face','no','Laptop');
SPF_cd100449_place_v2  = resonance_ERF_spatial_filter_v2('cd100449','place','no','Laptop');
SPF_cd100449_object_v2 = resonance_ERF_spatial_filter_v2('cd100449','object','no','Laptop');

resonance_ERF_spatial_filter_v3('cb100118','Laptop');
resonance_ERF_spatial_filter_v3('nr110115','Laptop');
resonance_ERF_spatial_filter_v3('pr110338','Laptop');
resonance_ERF_spatial_filter_v3('ns110383','Laptop');
resonance_ERF_spatial_filter_v3('cd100449','Laptop');

resonance_topoplot_2('cb100118','Laptop');
resonance_topoplot_2('nr110115','Laptop');
resonance_topoplot_2('pr110338','Laptop');
resonance_topoplot_2('ns110383','Laptop');
resonance_topoplot_2('cd100449','Laptop');

% get tuning profile by applying spatial filter on SSR
[Tfund_face{1}, Tsha_face{1}, cfund_face{1}, csha_face{1}]         = resonance_tuning_SPF('cb100118',{'run1','run2'},SPF_cb100118_face,  'SPF_face'  ,'laptop');
[Tfund_place{1}, Tsha_place{1}, cfund_place{1}, csha_place{1}]     = resonance_tuning_SPF('cb100118',{'run1','run2'},SPF_cb100118_place, 'SPF_place' ,'laptop');
[Tfund_object{1}, Tsha_object{1}, cfund_object{1}, csha_object{1}] = resonance_tuning_SPF('cb100118',{'run1','run2'},SPF_cb100118_object,'SPF_object','laptop');

[Tfund_face{2}, Tsha_face{2}, cfund_face{2}, csha_face{2}]         = resonance_tuning_SPF('nr110115',{'run1','run2'},SPF_nr100115_face,  'SPF_face'  ,'laptop');
[Tfund_place{2}, Tsha_place{2}, cfund_place{2}, csha_place{2}]     = resonance_tuning_SPF('nr110115',{'run1','run2'},SPF_nr100115_place, 'SPF_place' ,'laptop');
[Tfund_object{2}, Tsha_object{2}, cfund_object{2}, csha_object{2}] = resonance_tuning_SPF('nr110115',{'run1','run2'},SPF_nr100115_object,'SPF_object','laptop');

[Tfund_face{3}, Tsha_face{3}, cfund_face{3}, csha_face{3}]         = resonance_tuning_SPF('pe110338',{'run1','run2','run3','run4'},SPF_pe110338_face,  'SPF_face'  ,'laptop');
[Tfund_place{3}, Tsha_place{3}, cfund_place{3}, csha_place{3}]     = resonance_tuning_SPF('pe110338',{'run1','run2','run3','run4'},SPF_pe110338_place, 'SPF_place' ,'laptop');
[Tfund_object{3}, Tsha_object{3}, cfund_object{3}, csha_object{3}] = resonance_tuning_SPF('pe110338',{'run1','run2','run3','run4'},SPF_pe110338_object,'SPF_object','laptop');

[Tfund_face{4}, Tsha_face{4}, cfund_face{4}, csha_face{4}]         = resonance_tuning_SPF('ns110383',{'run1','run2','run3','run4'},SPF_ns110383_face,  'SPF_face'  ,'laptop');
[Tfund_place{4}, Tsha_place{4}, cfund_place{4}, csha_place{4}]     = resonance_tuning_SPF('ns110383',{'run1','run2','run3','run4'},SPF_ns110383_place, 'SPF_place' ,'laptop');
[Tfund_object{4}, Tsha_object{4}, cfund_object{4}, csha_object{4}] = resonance_tuning_SPF('ns110383',{'run1','run2','run3','run4'},SPF_ns110383_object,'SPF_object','laptop');

[Tfund_face{5}, Tsha_face{5}, cfund_face{5}, csha_face{5}]         = resonance_tuning_SPF('cd100449',{'run1','run2','run3','run4'},SPF_cd100449_face,  'SPF_face'  ,'laptop');
[Tfund_place{5}, Tsha_place{5}, cfund_place{5}, csha_place{5}]     = resonance_tuning_SPF('cd100449',{'run1','run2','run3','run4'},SPF_cd100449_place, 'SPF_place' ,'laptop');
[Tfund_object{5}, Tsha_object{5}, cfund_object{5}, csha_object{5}] = resonance_tuning_SPF('cd100449',{'run1','run2','run3','run4'},SPF_cd100449_object,'SPF_object','laptop');

% V2
[Tfund_face{1}, Tsha_face{1}, cfund_face{1}, csha_face{1}]         = resonance_tuning_SPF_v2('cb100118',{'run1','run2'},SPF_cb100118_face_v2,  'SPF_face_V2'  ,'laptop');
[Tfund_place{1}, Tsha_place{1}, cfund_place{1}, csha_place{1}]     = resonance_tuning_SPF_v2('cb100118',{'run1','run2'},SPF_cb100118_place_v2, 'SPF_place_V2' ,'laptop');
[Tfund_object{1}, Tsha_object{1}, cfund_object{1}, csha_object{1}] = resonance_tuning_SPF_v2('cb100118',{'run1','run2'},SPF_cb100118_object_v2,'SPF_object_V2','laptop');

[Tfund_face{2}, Tsha_face{2}, cfund_face{2}, csha_face{2}]         = resonance_tuning_SPF_v2('nr110115',{'run1','run2'},SPF_nr110115_face_v2,  'SPF_face_V2'  ,'laptop');
[Tfund_place{2}, Tsha_place{2}, cfund_place{2}, csha_place{2}]     = resonance_tuning_SPF_v2('nr110115',{'run1','run2'},SPF_nr110115_place_v2, 'SPF_place_V2' ,'laptop');
[Tfund_object{2}, Tsha_object{2}, cfund_object{2}, csha_object{2}] = resonance_tuning_SPF_v2('nr110115',{'run1','run2'},SPF_nr110115_object_v2,'SPF_object_V2','laptop');

[Tfund_face{3}, Tsha_face{3}, cfund_face{3}, csha_face{3}]         = resonance_tuning_SPF_v2('pe110338',{'run1','run2','run3','run4'},SPF_pe110338_face_v2,  'SPF_face_V2'  ,'laptop');
[Tfund_place{3}, Tsha_place{3}, cfund_place{3}, csha_place{3}]     = resonance_tuning_SPF_v2('pe110338',{'run1','run2','run3','run4'},SPF_pe110338_place_v2, 'SPF_place_V2' ,'laptop');
[Tfund_object{3}, Tsha_object{3}, cfund_object{3}, csha_object{3}] = resonance_tuning_SPF_v2('pe110338',{'run1','run2','run3','run4'},SPF_pe110338_object_v2,'SPF_object_V2','laptop');

[Tfund_face{4}, Tsha_face{4}, cfund_face{4}, csha_face{4}]         = resonance_tuning_SPF_v2('ns110383',{'run1','run2','run3','run4'},SPF_ns110383_face_v2,  'SPF_face_V2'  ,'laptop');
[Tfund_place{4}, Tsha_place{4}, cfund_place{4}, csha_place{4}]     = resonance_tuning_SPF_v2('ns110383',{'run1','run2','run3','run4'},SPF_ns110383_place_v2, 'SPF_place_V2' ,'laptop');
[Tfund_object{4}, Tsha_object{4}, cfund_object{4}, csha_object{4}] = resonance_tuning_SPF_v2('ns110383',{'run1','run2','run3','run4'},SPF_ns110383_object_v2,'SPF_object_V2','laptop');

[Tfund_face{5}, Tsha_face{5}, cfund_face{5}, csha_face{5}]         = resonance_tuning_SPF_v2('cd100449',{'run1','run2','run3','run4'},SPF_cd100449_face_v2,  'SPF_face_V2'  ,'laptop');
[Tfund_place{5}, Tsha_place{5}, cfund_place{5}, csha_place{5}]     = resonance_tuning_SPF_v2('cd100449',{'run1','run2','run3','run4'},SPF_cd100449_place_v2, 'SPF_place_V2' ,'laptop');
[Tfund_object{5}, Tsha_object{5}, cfund_object{5}, csha_object{5}] = resonance_tuning_SPF_v2('cd100449',{'run1','run2','run3','run4'},SPF_cd100449_object_v2,'SPF_object_V2','laptop');

% source reconstruction
resonance_meg_sourcespace('pe110338')
resonance_meg_sourcespace('ns110383')
resonance_meg_sourcespace('cb100118')
resonance_meg_sourcespace('nr110115')
resonance_meg_sourcespace('cd100449')

resonance_meg_mnesource_ERF('pe110338','face','Mags')
resonance_meg_mnesource_ERF('pe110338','face','Grads1')
resonance_meg_mnesource_ERF('pe110338','face','Grads2')

resonance_meg_mnesource_ERF('ns110383','face','Mags')
resonance_meg_mnesource_ERF('ns110383','face','Grads1')
resonance_meg_mnesource_ERF('ns110383','face','Grads2')

resonance_meg_mnesource_ERF('cb100118','face','Mags')
resonance_meg_mnesource_ERF('cb100118','face','Grads1')
resonance_meg_mnesource_ERF('cb100118','face','Grads2')

resonance_meg_mnesource_ERF('nr110115','face','Mags')
resonance_meg_mnesource_ERF('nr110115','face','Grads1')
resonance_meg_mnesource_ERF('nr110115','face','Grads2')

resonance_meg_mnesource_ERF('cd100449','face','Mags')
resonance_meg_mnesource_ERF('cd100449','face','Grads1')
resonance_meg_mnesource_ERF('cd100449','face','Grads2')













