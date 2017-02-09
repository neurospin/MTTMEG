%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i = 1:57
    meanspctrm(:,i)          =  squeeze(mean(Fullspctrm(i,:,:)));
    loglog(unique(Fullfreq),meanspctrm(:,i),'color',c(i,:),'linewidth',2)
    axis([1 120 1e-30 1e-26])
    grid('on')
    hold on
end

title('trial-by-trial mean spectrum')
xlabel('frequency (Hz)')
ylabel('Power (Ft)')