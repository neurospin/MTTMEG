
function set_axes(xmin,xmax,ymin,ymax)

yminsave = ymin;
ymaxsave = ymax;
% 
% ymin = ymin - mod(ymin,10);
% ymax = ymax - mod(ymax,10);
% 
% % x axis
line([-0.2 xmax],[0 0],'linestyle','-','linewidth',2,'color','k');hold on
% % yaxis
% line([-0.2 -0.2],[ymin ymax],'linestyle','-','linewidth',2,'color','k');hold on
% % x graduation
% for i = 0:xmax
%     line([i i],[ 0 (ymax-ymin)*0.1],'linestyle','-','linewidth',2,'color','k');hold on
% end
% % y graduation
% for i = [ymin:round((-ymin)/5):0 0:round((ymax)/5):ymax ]
%     line([-0.2 -0.15],[i i],'linestyle','-','linewidth',2,'color','k');hold on
% end
% % y text
% for i = [ymin:round((-ymin)/5):0 0:round((ymax)/5):ymax ]
%     text(-0.6,i,num2str(i),'fontsize',30,'fontweight','b')
% end
% %x text
% for i = [0 1 2 3 4 5]
%     text(i-0.05,ymin,num2str(i),'fontsize',30)
% end

% axis off
axis([-0.2 xmax yminsave*1.1 ymaxsave*1.1])
set(gca, 'box','off','linewidth',2,'fontsize',30,'fontweight','b');
set(gca, 'xtick',[0 1 2 3 4 5],'xticklabel',[0 1 2 3 4 5],'color','w')