% test corr alpha peak and behavioral data
clear all
close all

load('/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/peakdata.mat')
load('/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/behavdata.mat')

% remove replay results
locs04(:,4)         = [];

locs07(:,[3 6])     = [];
locs08(:,4)         = [];
meAns07([3 6])      = [];
meAns08(4)          = [];
meAnnorms07([3 6])  = [];
meAnnorms08(4)      = [];
meds07([3 6])       = [];
meds08(4)           = [];
SDs07([3 6])        = [];
SDs08(4)            = [];

meAn            = [meAns04 meAns05 meAns06 meAns07 meAns08];
med             = [meds04 meds05 meds06 meds07 meds08];
meAnnorm        = [meAnnorms04 meAnnorms05 meAnnorms06 meAnnorms07 meAnnorms08];
SD              = [SDs04 SDs05 SDs06 SDs07 SDs08];
locs            = [locs04 locs05 locs06 locs07 locs08];

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


