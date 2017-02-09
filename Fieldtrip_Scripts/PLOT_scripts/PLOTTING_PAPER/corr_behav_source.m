% corr beghavior source

% subject_psych: sd,cb,sl,lm,ma,sg,ms,tk,sb,jm,rb,jm,wl,mm,dm,hr,mp,mb,rl

% test correlation between ER and source amplitude difference in MT, rTPJ,
% mPFC
ER_pre =[0.0800    0.1333    0.0968    0.0278    0.0743    0.0813    0.0357    0.0686    0.1235    0.0118    0.0833    0.1714    0.0611    0.0556    0.0743    0.0119    0.1061    0.2552    0.0444];
ER_pas =[0.3929    0.2381    0.1957    0.1417    0.1391    0.1048    0.0700    0.1739    0.2333    0.0833    0.0278    0.2500    0.1417    0.0312    0.1478    0.2083    0.2174    0.3200    0.0583];
ER_fut =[0.1806    0.2200    0.1750    0.0500    0.1478    0.0909    0.0421    0.1391    0.1455    0.0273    0.0417    0.2029    0.2083    0.0417    0.1417    0.1818    0.2024    0.3500    0.1250];
ER_w   =[0.1029    0.1273    0.1304    0.0583    0.1417    0.0273    0.0211    0.1130    0.1217    0.0182    0.0833    0.2609    0.0583    0.0625    0.0417    0.0938    0.0870    0.2100    0.0333];
ER_e   =[0.0938    0.1684    0.2105    0.0167    0.0783    0.0818    0.0889    0.1304    0.1273    0.0417    0.0694    0.3611    0.0333    0.0625    0.0870    0.0577    0.1250    0.2333    0.0833];

RT_pre = [0.6373    0.8277    1.0779    0.2698    0.6942    0.6114    0.4533    0.4600    0.5200    0.7548    0.1736    0.8671    0.8147    0.4062    0.5133    0.7438    0.6188    0.7357    0.4826];
RT_pas = [1.2533    0.8555    1.3397    0.5273    0.9783    0.7470    0.4344    0.3910    0.7170    0.9560    0.2053    0.9306    0.7438    0.4467    0.8602    1.1519    0.6295    0.9637    0.5840];
RT_fut = [0.8464    0.9730    1.1650    0.3934    0.8892    0.8328    0.4189    0.4523    0.5681    0.9883    0.2119    1.0586    0.7769    0.5485    0.6699    0.9663    0.6273    0.9109    0.5900];
RT_w = [0.7057    0.8800    1.1760    0.4753    0.8853    0.9285    0.4239    0.4626    0.5527    0.7262    0.1821    0.8422    0.6848    0.4473    0.7148    0.8331    0.5713    1.0006    0.5605];
RT_e = [0.8724    0.9773    1.0937    0.3823    0.8540    0.7532    0.4416    0.5518    0.6146    0.8184    0.1819    0.8908    0.8107    0.4756    0.5960    0.9437    0.5995    1.0112    0.6736];

HC_left = [4.64753433  2.52298029  2.71900388  4.4305709   4.40895382 5.48034762  2.59357061  7.07989535  5.45835227  2.99310808 ...
           4.26357695  3.18170924  1.43508327  4.20563003  4.33746708 4.64716391  1.66449112  0.97335551  6.20492658 2.37405835   1.53520631  1.72765144  1.8894984   3.76216578 ...
           3.15842259  1.99283604  2.02118533  3.21623708  2.02395917 1.32767741  3.71461927  2.43434141  2.61527094  1.76007213 ...
           1.32139432  2.49361229  1.58811138  5.2059167 3.49041472  1.58964662  3.65187704  4.18959401  3.97781085 ...
            2.47419585  1.7928229  3.02192851  3.09623314  3.34834381 2.87918447  2.98582219 1.49823248  2.58052003  2.15996904 1.34010996  1.39860535 1.54898093  4.0701252 ]
HC_left_pas = HC_left(1:19); HC_left_pre = HC_left(20:38); HC_left_fut = HC_left(39:57);   
HC_left_pre = HC_left_pre([1 2 11 8 10 18 9 7 6 5 3 4 16 19 14 15 13 12 17])
HC_left_pas = HC_left_pas([1 2 11 8 10 18 9 7 6 5 3 4 16 19 14 15 13 12 17])
HC_left_fut = HC_left_fut([1 2 11 8 10 18 9 7 6 5 3 4 16 19 14 15 13 12 17])

mPFC_left = [ 3.72852381  2.23046812  2.12990332  2.8220855   4.22630632 2.24292364  2.61393663  2.26835715  3.4485541   2.34371936 ...
        1.42897453  1.72742403  2.47437709  1.78481848  1.6981642 2.13907373  3.1623625   2.57292552  3.89485494  2.18442598 ...
        2.76361597  3.31354531  2.43461977  4.8373799   4.65035144 3.59290602  2.84258329  4.73727411  2.11404267  3.70305315 ...
        1.49236609  2.59864064  2.7515753   4.01510466  2.08640528 4.86226261  2.26887091  8.15511862  4.05082656  3.06692097 ...
        4.11222568  3.37192694  4.34067831  4.19030346  3.42409233 3.09137067  8.04493131  2.57974779  3.47190967  5.36000126 ...
        4.33549956  3.62462087  2.02353242  2.23781776  3.8842677 4.46275413  6.78268243];    
mPFC_left_pas = mPFC_left(1:19); mPFC_left_pre = mPFC_left(20:38); mPFC_left_fut = mPFC_left(39:57);    
mPFC_left_pas = mPFC_left_pas([1 2 11 8 10 18 9 7 6 5 3 4 16 19 14 15 13 12 17])
mPFC_left_pre = mPFC_left_pre([1 2 11 8 10 18 9 7 6 5 3 4 16 19 14 15 13 12 17])
mPFC_left_fut = mPFC_left_fut([1 2 11 8 10 18 9 7 6 5 3 4 16 19 14 15 13 12 17])

mPFC_right = [ 1.51246952  2.45533469  2.33456698  1.46209728  2.77101193 1.79836368  2.1724591   3.96319516  2.3828676   3.29257634 ...
        1.53936775  2.47041596  3.69366367  2.48806435  1.62575224 2.45929847  1.92560802  2.45061127  4.67698216  3.14897394 ...
        2.28219355  3.24820654  2.13074248  2.45748193  3.78002567  2.62834435  3.03533976  4.57034783  2.29603044  2.5324593  ...
        1.91828468  1.99894062  2.09758987  1.84999762  2.37584386 2.02087383  3.92019257  6.911616    3.05815361  1.73777295 ...
        4.9880265   3.09605384  2.28349058  6.60106796  2.26567665 4.82307368  6.86265843  2.9870964   3.84224267  7.4886341  ...
        3.3335566   3.80299258  1.55983862  2.07593553  4.75488509 5.79498593  6.56901128]
mPFC_right_pas = mPFC_right(1:19); mPFC_right_pre = mPFC_right(20:38); mPFC_right_fut = mPFC_right(39:57);    
mPFC_right_pas = mPFC_right_pas([1 2 11 8 10 18 9 7 6 5 3 4 16 19 14 15 13 12 17])
mPFC_right_pre = mPFC_right_pre([1 2 11 8 10 18 9 7 6 5 3 4 16 19 14 15 13 12 17])
mPFC_right_fut = mPFC_right_fut([1 2 11 8 10 18 9 7 6 5 3 4 16 19 14 15 13 12 17])
    
    
RTPJ = [6.56579777  2.72742727  2.74402341  4.92877314  4.23300041 2.3242916   1.31461564  3.62728601  3.10172316  3.19461246 ...
        2.40800021  3.87855309  2.61234398  1.83537812  2.54101838  3.28137507  2.8679112   2.52164263  7.97721688  7.17300158 ...
        5.63448323  4.03113032  4.83032891  5.20076689  3.83977606 1.50105519  3.75909502  5.58072529  3.46482922  2.71060199 ...
        4.98665781  2.55324671  2.75271697  2.22230833  4.41890051 2.89436578  4.39188336  7.27539002  3.15159385  2.58502086 ...
        3.64970756  3.75622441  3.95891101  4.31382342  1.68023141 1.73912087  3.8048314   2.00473417  2.65866446  2.4348857  ...
        2.32137274  2.42274004  1.98858029  2.07391076  2.15823756 1.9116343   3.65123711];
RTPJ_pas = RTPJ(1:19); RTPJ_pre = RTPJ(20:38); RTPJ_fut = RTPJ(39:57);    
RTPJ_pas = RTPJ_pas([1 2 11 8 10 18 9 7 6 5 3 4 16 19 14 15 13 12 17])
RTPJ_pre = RTPJ_pre([1 2 11 8 10 18 9 7 6 5 3 4 16 19 14 15 13 12 17])
RTPJ_fut = RTPJ_fut([1 2 11 8 10 18 9 7 6 5 3 4 16 19 14 15 13 12 17])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
for i  =1:19
    subplot(4,5,i)
    bar([RT_pas(i) RT_pre(i) RT_fut(i)]);
    axis([0 4 0 2])
end
figure
for i  =1:19
    subplot(4,5,i)
    bar([mPFC_left_pas(i) mPFC_left_pre(i) mPFC_left_fut(i)]);
end
figure
for i  =1:19
    subplot(4,5,i)
    bar([mPFC_left_pas(i) mPFC_left_pre(i) mPFC_left_fut(i)]);
end
figure
for i  =1:19
    subplot(4,5,i)
    bar([mPFC_right_pas(i) mPFC_right_pre(i) mPFC_right_fut(i)]);
end
figure
for i  =1:19
    subplot(4,5,i)
    bar([mPFC_right_pas(i)+mPFC_left_pas(i) ...
        mPFC_right_pre(i)+mPFC_left_pre(i) ...
        mPFC_right_fut(i)+mPFC_left_fut(i)]);
end
figure
for i  = 1:19
    subplot(4,5,i)
    bar([HC_left_pas(i) HC_left_pre(i) HC_left_fut(i)]);
end
figure
for i  = 1:19
    subplot(4,5,i)
    bar([RTPJ_pas(i) RTPJ_pre(i) RTPJ_fut(i)]);
    axis([0 4 0 10])
end

figure;plot(ER_pas-ER_pre,HC_left_pas-HC_left_pre, 'marker','o','linestyle','none')
figure;plot(ER_pas,HC_left_pas, 'marker','o','linestyle','none')
[RHO,PVAL] = corr((ER_pas-ER_pre)',(HC_left_pas-HC_left_pre)')
[RHO,PVAL] = corr(ER_pas',HC_left_pas')

figure;plot(ER_fut-ER_pas,mPFC_left_fut-mPFC_left_pas, 'marker','o','linestyle','none')
figure;plot(RT_pre - RT_fut-RT_pas,mPFC_left_fut-mPFC_left_pas, 'marker','o','linestyle','none')
figure;plot(ER_fut,mPFC_left_fut, 'marker','o','linestyle','none')
figure;plot(RT_fut,mPFC_left_fut, 'marker','o','linestyle','none')
[RHO,PVAL] = corr((ER_fut-ER_pas)',(mPFC_left_fut-mPFC_left_pas)')
[RHO,PVAL] = corr((ER_fut)',(mPFC_left_fut([1 2 11 8 10 18 9 7 6 5 3 4 16 19 14 15 13 12 17])'))


figure;plot(RT_pre - RT_fut,RTPJ_pre - RTPJ_fut, 'marker','o','linestyle','none')
figure;plot(RT_pre - RT_pas,RTPJ_pre - RTPJ_pas, 'marker','o','linestyle','none')
figure;plot(RT_fut - RT_pas,RTPJ_fut - RTPJ_pas, 'marker','o','linestyle','none')


figure;plot(RT_fut + RT_pas - RT_pre,RTPJ_fut + RTPJ_pas - RTPJ_pre, 'marker','o','linestyle','none')


for i =1:19
    r(i)  = corr([1 2 3]',[mPFC_right_pas(i) mPFC_right_pre(i) mPFC_right_fut(i)]','type','Spearman')
    r2(i) = corr([1 2 3]',[mPFC_right_pas(i) mPFC_right_pre(i) mPFC_right_fut(i)]','type','Pearson')
end

figure;plot(RT_fut + (RT_pas - RT_pre)/2,r, 'marker','o','linestyle','none')


figure;plot(RT_pas,HC_left_pas , 'marker','o','linestyle','none')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rPM = [  3.57788264   2.48210538   3.36615173   2.03948101 2.78288788   2.39397329   8.40386623   3.21177483 ...
         3.46202935   2.03660133   6.23088528   3.06640946 1.92384429   2.68499296   1.94149122   2.5466072  ...
         2.97259423   2.72415972   1.42450057   2.28653533 3.56506685   5.35398329   2.86298361   2.73542529 ...
         5.72832757   8.83602611   4.11552005   7.72465753 4.64399634   6.49091994   2.6685694    3.37558647 ...
         3.92572994   1.80474057   2.48599268   2.3475436 6.0863481    3.56305247   2.59572016   2.46980147 ...
         3.7291794    1.53201918   2.43059224   3.12202617 9.9018393    3.1946534    3.07271347   1.45265152 ...
         4.75562822   1.43048346   2.66881225   2.31643574 2.14413366   1.76327731   2.63775745   4.19476601 ...
         5.08849294   3.02471459   2.05808736   2.11184191 1.92039142   2.90934366   2.94786017  10.09319897 ...
         4.35962893   3.55745256   2.55130716   5.26588602 1.8092558    2.19068916   3.41238593   2.26837537 ...
         2.06627011   2.67749666   3.00794306   3.44248618 5.60297874   3.45081238   2.441991     3.65573898 ...
         2.54574668   7.33539082  10.28649062   4.651653   6.77937411   2.22669212   6.41307619   1.11915921 ...
         2.45817282   1.86175919   1.98935707   3.41901614 3.58842979   4.82767031   3.60631588   5.28483041 ...
         1.37814254   2.47352811   2.20579843   1.84932532 4.22443514   8.56336975   2.00712022   3.45527171 ...
         2.64034739   3.73682978   1.66842718   1.96601104 2.25823147   1.94750959   1.4876655    2.9483937  ...
         3.09098388   2.43848459];
     
rPM_pas = rPM(1:19); rPM_pre = rPM(20:38); rPM_fut = rPM(39:57);    
rPM_w   = rPM(58:76) ; rPM_par = rPM(77:95); rPM_e = rPM(96:114); 
rPM_pas = rPM_pas([1 2 11 8 10 18 9 7 6 5 3 4 16 19 14 15 13 12 17])
rPM_pre = rPM_pre([1 2 11 8 10 18 9 7 6 5 3 4 16 19 14 15 13 12 17])
rPM_fut = rPM_fut([1 2 11 8 10 18 9 7 6 5 3 4 16 19 14 15 13 12 17])
rPM_w   = rPM_w([1 2 11 8 10 18 9 7 6 5 3 4 16 19 14 15 13 12 17])
rPM_par = rPM_par([1 2 11 8 10 18 9 7 6 5 3 4 16 19 14 15 13 12 17])
rPM_e   = rPM_e([1 2 11 8 10 18 9 7 6 5 3 4 16 19 14 15 13 12 17])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
plot(RT_pas,rPM_pas,'marker','.','markersize',40,'linestyle','none')
plot(RT_pre,rPM_pre,'marker','.','markersize',40,'linestyle','none')
plot(RT_fut,rPM_fut,'marker','.','markersize',40,'linestyle','none')
plot(RT_w,rPM_w,'marker','.','markersize',40,'linestyle','none')
plot(RT_e,rPM_e,'marker','.','markersize',40,'linestyle','none')
plot(RT_pre,rPM_par,'marker','.','markersize',40,'linestyle','none')

[r,p] = corr((rPM_pas)',(RT_pas)','type','Pearson')
[r,p] = corr((rPM_pas)',(RT_pas)','type','Spearman')
[r,p] = corr((rPM_pre)',(RT_pre)','type','Pearson')
[r,p] = corr((rPM_pre)',(RT_pre)','type','Spearman')
[r,p] = corr((rPM_fut)',(RT_fut)','type','Pearson')
[r,p] = corr((rPM_fut)',(RT_fut)','type','Spearman')
[r,p] = corr((rPM_e)',(RT_e)','type','Pearson')
[r,p] = corr((rPM_e)',(RT_e)','type','Spearman')
[r,p] = corr((rPM_w)',(RT_w)','type','Pearson')
[r,p] = corr((rPM_w)',(RT_w)','type','Spearman')
[r,p] = corr((rPM_par)',(RT_pre)','type','Pearson')
[r,p] = corr((rPM_par)',(RT_pre)','type','Spearman')

plot(RT_pas-RT_pre,rPM_pas-rPM_pre,'marker','.','markersize',40,'linestyle','none')
plot(RT_fut-RT_pre,rPM_fut-rPM_pre,'marker','.','markersize',40,'linestyle','none')

plot(RT_w-RT_pre,rPM_w-rPM_par,'marker','.','markersize',40,'linestyle','none')
plot(RT_e-RT_pre,rPM_e-rPM_par,'marker','.','markersize',40,'linestyle','none')

% cat self-porj
plot([RT_w-RT_pre RT_e-RT_pre],[rPM_w-rPM_par rPM_e-rPM_par],'marker','.','markersize',40,'linestyle','none')
[h,p] = corr([RT_w-RT_pre RT_e-RT_pre]',[rPM_w-rPM_par rPM_e-rPM_par]','type','Pearson')
[h,p] = corr([RT_w-RT_pre RT_e-RT_pre]',[rPM_w-rPM_par rPM_e-rPM_par]','type','Spearman')

plot([RT_pas-RT_pre RT_fut-RT_pre],[rPM_pas-rPM_pre rPM_fut-rPM_pre],'marker','.','markersize',40,'linestyle','none')
[h,p] = corr([RT_pas-RT_pre RT_fut-RT_pre]',[rPM_pas-rPM_pre rPM_fut-rPM_pre]','type','Pearson')
[h,p] = corr([RT_pas-RT_pre RT_fut-RT_pre]',[rPM_pas-rPM_pre rPM_fut-rPM_pre]','type','Spearman')

% mean self-proj
plot((RT_w-RT_pre) + (RT_e-RT_pre),(rPM_w-rPM_par) + (rPM_e-rPM_par),'marker','.','markersize',40,'linestyle','none')
[h,p] = corr([(RT_w-RT_pre) + (RT_e-RT_pre)]',[(rPM_w-rPM_par) + (rPM_e-rPM_par)]','type','Pearson')
plot((RT_pas-RT_pre) + (RT_fut-RT_pre),(rPM_pas-rPM_pre) + (rPM_fut-rPM_pre),'marker','.','markersize',40,'linestyle','none')
[h,p] = corr([(RT_pas-RT_pre) + (RT_fut-RT_pre)]',[(rPM_pas-rPM_pre) + (rPM_fut-rPM_pre)]','type','Pearson')

