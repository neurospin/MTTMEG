% test corr alpha peak and behavioral data
clear all
close all

load('/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/peakdata2.mat')
load('/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/behavdata.mat')

% remove replay results
locs04(:,4)         = [];
locs07(:,[3 6])     = []; 
locs08(:,4)         = [];
locs10(:,[3 6])     = [];
locs11(:,[3])       = [];
locs12(:,[3 6])     = [];
locs13(:,[3 6])     = [];
locs14(:,[3 6])     = [];
meAns07([3 6])      = [];
meAns08(4)          = [];
meAns10([3 6])      = [];
meAns11([3])      = [];
meAns12([3 6])      = [];
meAns13([3 6])      = [];
meAns14([3 6])      = [];
meAnnorms07([3 6])  = [];
meAnnorms08(4)      = [];
meAnnorms10([3 6])  = [];
meAnnorms11([3])    = [];
meAnnorms12([3 6])  = [];
meAnnorms13([3 6])  = [];
meAnnorms14([3 6])  = [];
meds07([3 6])       = [];
meds08(4)           = [];
meds10([3 6])       = [];
meds11([3])         = [];
meds12([3 6])       = [];
meds13([3 6])       = [];
meds14([3 6])       = [];
SDs07([3 6])        = [];
SDs08(4)        = [];
SDs10([3 6])        = [];
SDs11([3])          = [];
SDs12([3 6])        = [];
SDs13([3 6])        = [];
SDs14([3 6])        = [];

meAn            = [meAns04 meAns05 meAns06 meAns07 meAns08 meAns10 meAns11 meAns12 meAns13 meAns14];
med             = [meds04  meds05  meds06  meds07  meds08  meds10  meds11  meds12  meds13  meds14];
meAnnorm        = [meAnnorms04 meAnnorms05 meAnnorms06 meAnnorms07 meAnnorms08 ...
                   meAnnorms10 meAnnorms11 meAnnorms12 meAnnorms13 meAnnorms14];
SD              = [SDs04  SDs05  SDs06  SDs07  SDs08  SDs10  SDs11  SDs12  SDs13  SDs14];
locs            = [locs04 locs05 locs06 locs07 locs08 locs10 locs11 locs12 locs13 locs14];

for i = 1:length(locs)
    alphapeaks1(i)  = locs{1,i};
    alphapeaks2(i)  = locs{2,i};
    alphapeaks3(i)  = locs{3,i};
end

[RHO1m,PVAL1m]         = corr([meAn' (alphapeaks1')]);
[RHO2m,PVAL2m]         = corr([meAn' (alphapeaks2')]);
[RHO3m,PVAL3m]         = corr([meAn' (alphapeaks3')]);

[RHO1sd,PVAL1sd]       = corr([SD' (alphapeaks1')]);
[RHO2sd,PVAL2sd]       = corr([SD' (alphapeaks2')]);
[RHO3sd,PVAL3sd]       = corr([SD' (alphapeaks3')]);

[RHO1cv,PVAL1cv]       = corr([meAnnorm' (alphapeaks1')]);
[RHO2cv,PVAL2cv]       = corr([meAnnorm' (alphapeaks2')]);
[RHO3cv,PVAL3cv]       = corr([meAnnorm' (alphapeaks3')]);

figure
% mean
subplot(3,3,1)
plot(alphapeaks1,meAn,'marker','o','linestyle','none')
hold on
P = polyfit(alphapeaks1,meAn,1);
plot(alphapeaks1,polyval(P,alphapeaks1),'color','k','linewidth',1);
xlabel('alpha peak frequency')
ylabel('mean duration')
title(['MAGS : rho : ' num2str(RHO1m(2,1)), ' ,pval : ' num2str(PVAL1m(2,1))]);
subplot(3,3,2)
plot(alphapeaks2,meAn,'marker','o','linestyle','none')
hold on
P = polyfit(alphapeaks1,meAn,1);
plot(alphapeaks2,polyval(P,alphapeaks2),'color','k','linewidth',1);
xlabel('alpha peak frequency')
ylabel('mean duration')
title(['G1 : rho : ' num2str(RHO2m(2,1)), ' ,pval : ' num2str(PVAL2m(2,1))]);
subplot(3,3,3)
plot(alphapeaks3,meAn,'marker','o','linestyle','none')
hold on
P = polyfit(alphapeaks3,meAn,1);
plot(alphapeaks3,polyval(P,alphapeaks3),'color','k','linewidth',1);
xlabel('alpha peak frequency')
ylabel('mean duration')
title(['G2 : rho : ' num2str(RHO3m(2,1)), ' ,pval : ' num2str(PVAL3m(2,1))]);

% SD
subplot(3,3,4)
plot(alphapeaks1,SD,'marker','o','linestyle','none')
hold on
P = polyfit(alphapeaks1,SD,1);
plot(alphapeaks1,polyval(P,alphapeaks1),'color','k','linewidth',1);
xlabel('alpha peak frequency')
ylabel('mean SD')
title(['MAGS rho : ' num2str(RHO1sd(2,1)), ' ,pval : ' num2str(PVAL1sd(2,1))]);
subplot(3,3,5)
plot(alphapeaks2,SD,'marker','o','linestyle','none')
hold on
P = polyfit(alphapeaks2,SD,1);
plot(alphapeaks2,polyval(P,alphapeaks2),'color','k','linewidth',1);
xlabel('alpha peak frequency')
ylabel('mean SD')
title(['G1 : rho : ' num2str(RHO2sd(2,1)), ' ,pval : ' num2str(PVAL2sd(2,1))]);
subplot(3,3,6)
plot(alphapeaks3,SD,'marker','o','linestyle','none')
hold on
P = polyfit(alphapeaks3,SD,1);
plot(alphapeaks3,polyval(P,alphapeaks3),'color','k','linewidth',1);
xlabel('alpha peak frequency')
ylabel('mean SD')
title(['G2 : rho : ' num2str(RHO3sd(2,1)), ' ,pval : ' num2str(PVAL3sd(2,1))]);
% CV
subplot(3,3,7)
plot(alphapeaks1,meAnnorm,'marker','o','linestyle','none')
hold on
P = polyfit(alphapeaks1,meAnnorm,1);
plot(alphapeaks1,polyval(P,alphapeaks1),'color','k','linewidth',1);
xlabel('alpha peak frequency')
ylabel('Coeff of variation')
title(['MAGS : rho : ' num2str(RHO1cv(2,1)), ' ,pval : ' num2str(PVAL1cv(2,1))]);
subplot(3,3,8)
plot(alphapeaks2,meAnnorm,'marker','o','linestyle','none')
hold on
P = polyfit(alphapeaks2,meAnnorm,1);
plot(alphapeaks2,polyval(P,alphapeaks2),'color','k','linewidth',1);
xlabel('alpha peak frequency')
ylabel('Coeff of variation')
title(['G1 : rho : ' num2str(RHO2cv(2,1)), ' ,pval : ' num2str(PVAL2cv(2,1))]);
subplot(3,3,9)
plot(alphapeaks3,meAnnorm,'marker','o','linestyle','none')
hold on
P = polyfit(alphapeaks3,meAnnorm,1);
plot(alphapeaks3,polyval(P,alphapeaks3),'color','k','linewidth',1);
xlabel('alpha peak frequency')
ylabel('Coeff of variation')
title(['G2: rho : ' num2str(RHO3cv(2,1)), ' ,pval : ' num2str(PVAL3cv(2,1))]);

%% average values

avg_meAn            = [mean(meAns04) mean(meAns05) mean(meAns06) mean(meAns07) mean(meAns08) ...
                   mean(meAns10) mean(meAns11) mean(meAns12) mean(meAns13) mean(meAns14)];
avg_med             = [mean(meds04)  mean(meds05)  mean(meds06)  mean(meds07)  mean(meds08) ...
                   mean(meds10)  mean(meds11)  mean(meds12)  mean(meds13)  mean(meds14)];
avg_meAnnorm        = [mean(meAnnorms04) mean(meAnnorms05) mean(meAnnorms06) mean(meAnnorms07) mean(meAnnorms08) ...
                   mean(meAnnorms10) mean(meAnnorms11) mean(meAnnorms12) mean(meAnnorms13) mean(meAnnorms14)];
avg_SD              = [mean(SDs04)  mean(SDs05)  mean(SDs06)  mean(SDs07)  mean(SDs08)...
                   mean(SDs10)  mean(SDs11)  mean(SDs12)  mean(SDs13)  mean(SDs14)];

a = 1;
tmpnb = 0;
nb = [3 3 4 4 4 4 3 4 4 4];
for i = 1:length(nb)
    tmpnb = tmpnb + nb(i);
    ALPHA1(i) = mean(alphapeaks1([a:tmpnb]));
    ALPHA2(i) = mean(alphapeaks1([a:tmpnb]));
    ALPHA3(i) = mean(alphapeaks1([a:tmpnb]));
end

% correlation

[RHO1m,PVAL1m]         = corr([avg_meAn' (ALPHA1')]);
[RHO2m,PVAL2m]         = corr([avg_meAn' (ALPHA2')]);
[RHO3m,PVAL3m]         = corr([avg_meAn' (ALPHA3')]);

[RHO1sd,PVAL1sd]       = corr([avg_SD' (ALPHA1')]);
[RHO2sd,PVAL2sd]       = corr([avg_SD' (ALPHA2')]);
[RHO3sd,PVAL3sd]       = corr([avg_SD' (ALPHA3')]);

[RHO1cv,PVAL1cv]       = corr([avg_meAnnorm' (ALPHA1')]);
[RHO2cv,PVAL2cv]       = corr([avg_meAnnorm' (ALPHA2')]);
[RHO3cv,PVAL3cv]       = corr([avg_meAnnorm' (ALPHA3')]);

figure
% mean
subplot(3,3,1)
plot(ALPHA1,avg_meAn,'marker','o','linestyle','none')
hold on
P = polyfit(ALPHA1,avg_meAn,1);
plot(ALPHA1,polyval(P,ALPHA1),'color','k','linewidth',1);
xlabel('alpha peak frequency')
ylabel('mean duration')
title(['MAGS : rho : ' num2str(RHO1m(2,1)), ' ,pval : ' num2str(PVAL1m(2,1))]);
subplot(3,3,2)
plot(ALPHA2,avg_meAn,'marker','o','linestyle','none')
hold on
P = polyfit(ALPHA2,avg_meAn,1);
plot(ALPHA2,polyval(P,ALPHA2),'color','k','linewidth',1);
xlabel('alpha peak frequency')
ylabel('mean duration')
title(['G1 : rho : ' num2str(RHO2m(2,1)), ' ,pval : ' num2str(PVAL2m(2,1))]);
subplot(3,3,3)
plot(ALPHA3,avg_meAn,'marker','o','linestyle','none')
hold on
P = polyfit(ALPHA3,avg_meAn,1);
plot(ALPHA3,polyval(P,ALPHA3),'color','k','linewidth',1);
xlabel('alpha peak frequency')
ylabel('mean duration')
title(['G2 : rho : ' num2str(RHO3m(2,1)), ' ,pval : ' num2str(PVAL3m(2,1))]);

% mean
subplot(3,3,4)
plot(ALPHA1,avg_SD,'marker','o','linestyle','none')
hold on
P = polyfit(ALPHA1,avg_SD,1);
plot(ALPHA1,polyval(P,ALPHA1),'color','k','linewidth',1);
xlabel('alpha peak frequency')
ylabel('sd duration')
title(['MAGS : rho : ' num2str(RHO1sd(2,1)), ' ,pval : ' num2str(PVAL1sd(2,1))]);
subplot(3,3,5)
plot(ALPHA2,avg_SD,'marker','o','linestyle','none')
hold on
P = polyfit(ALPHA2,avg_SD,1);
plot(ALPHA2,polyval(P,ALPHA2),'color','k','linewidth',1);
xlabel('alpha peak frequency')
ylabel('sd duration')
title(['G1 : rho : ' num2str(RHO2sd(2,1)), ' ,pval : ' num2str(PVAL2sd(2,1))]);
subplot(3,3,6)
plot(ALPHA3,avg_SD,'marker','o','linestyle','none')
hold on
P = polyfit(ALPHA3,avg_SD,1);
plot(ALPHA3,polyval(P,ALPHA3),'color','k','linewidth',1);
xlabel('alpha peak frequency')
ylabel('sd duration')
title(['G2 : rho : ' num2str(RHO3sd(2,1)), ' ,pval : ' num2str(PVAL3sd(2,1))]);

% mean
subplot(3,3,7)
plot(ALPHA1,avg_meAnnorm,'marker','o','linestyle','none')
hold on
P = polyfit(ALPHA1,avg_meAnnorm,1);
plot(ALPHA1,polyval(P,ALPHA1),'color','k','linewidth',1);
xlabel('alpha peak frequency')
ylabel('Coeff of variation')
title(['MAGS : rho : ' num2str(RHO1cv(2,1)), ' ,pval : ' num2str(PVAL1cv(2,1))]);
subplot(3,3,8)
plot(ALPHA2,avg_meAnnorm,'marker','o','linestyle','none')
hold on
P = polyfit(ALPHA2,avg_meAnnorm,1);
plot(ALPHA2,polyval(P,ALPHA2),'color','k','linewidth',1);
xlabel('alpha peak frequency')
ylabel('Coeff of variation')
title(['G1 : rho : ' num2str(RHO2cv(2,1)), ' ,pval : ' num2str(PVAL2cv(2,1))]);
subplot(3,3,9)
plot(ALPHA3,avg_meAnnorm,'marker','o','linestyle','none')
hold on
P = polyfit(ALPHA3,avg_meAnnorm,1);
plot(ALPHA3,polyval(P,ALPHA3),'color','k','linewidth',1);
xlabel('alpha peak frequency')
ylabel('Coeff of variation')
title(['G2 : rho : ' num2str(RHO3cv(2,1)), ' ,pval : ' num2str(PVAL3cv(2,1))]);


