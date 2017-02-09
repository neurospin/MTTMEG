% MEG design

PrePar = ones(6,6);
PreW   = repmat([1 1 1 1 0 0],6,1);
PreE   = repmat([0 0 1 1 1 1],6,1);
PasPar = repmat([1 1 1 1 0 0]',1,6);
FutPar = repmat([0 0 1 1 1 1]',1,6);

figure;
subplot(2,3,1);imagesc(PrePar,[0 5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);set(gca,'ytick',1:6,'yticklabel',[-3 -2 -1 1 2 3]);title('PrePar')
subplot(2,3,2);imagesc(PreW,[0 5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);set(gca,'ytick',1:6,'yticklabel',[-3 -2 -1 1 2 3]);title('PreW')
subplot(2,3,3);imagesc(PreE,[0 5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);set(gca,'ytick',1:6,'yticklabel',[-3 -2 -1 1 2 3]);title('PreE')
subplot(2,3,4);imagesc(PasPar,[0 5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);set(gca,'ytick',1:6,'yticklabel',[-3 -2 -1 1 2 3]);title('PasPar')
subplot(2,3,5);imagesc(FutPar,[0 5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);set(gca,'ytick',1:6,'yticklabel',[-3 -2 -1 1 2 3]);title('FutPar')
subplot(2,3,6);imagesc(PrePar+PreW+PreE+PasPar+FutPar,[0 5]);set(gca,'xtick',1:6,'xticklabel',[-3 -2 -1 1 2 3]);set(gca,'ytick',1:6,'yticklabel',[-3 -2 -1 1 2 3]);title('event occurence')




