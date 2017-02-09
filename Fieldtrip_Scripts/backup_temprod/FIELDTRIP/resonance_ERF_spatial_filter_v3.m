function SPF = resonance_ERF_spatial_filter_v3(nip,tag)

root = SetPath(tag);
[Grads1,Grads2,Mags]   = grads_for_layouts(tag);
[MPL,MPR,MAL,MAR,G1PL,G1PR,G1AL,G1AR,G2PL,G2PR,G2AL,G2AR] = APLRchannels;

chantype = {'Mags','Grads1','Grads2'};

% load stats structure
load(['C:\RESONANCE_MEG\DATA\' nip '\freq\STATS']);

face_avg = 0; place_avg = 0; object_avg = 0;
for i = 1:8
    face_avg   = face_avg   + mean(ERF_face{1,1}.avg(pos(:,88+i),:));
    place_avg  = place_avg  + mean(ERF_place{1,1}.avg(pos(:,88+i),:));
    object_avg = object_avg + mean(ERF_object{1,1}.avg(pos(:,88+i),:));
end
face_avg = face_avg/8; place_avg   = place_avg/8; object_avg   = object_avg/8;

figure
plot(ERF_face{1,1}.time(51:end),face_avg(51:end),'color','k','linewidth',3); hold on;
plot(ERF_place{1,1}.time(51:end),place_avg(51:end),'color','r','linewidth',3); hold on;
plot(ERF_object{1,1}.time(51:end),object_avg(51:end),'color','g','linewidth',3); hold on;
set(gca,'xtick',[0.2 0.25 0.3 0.35 0.4 0.45 0.5],'xticklabel',[0 0.05 0.1 0.15 0.2 0.25 0.3])
set(gca,'box','off','linewidth',3)
legend('visages','scènes','objets')
xlabel('latence (s)','fontsize',12); ylabel('champ magnétique (fT)','fontsize',12)

print('-dpng',['C:\RESONANCE_MEG\DATA\' nip '\plots\Mags_ERF_selchans.png'])

face_avg = 0; place_avg = 0; object_avg = 0;
for i = 1:8
    face_avg   = face_avg   + mean(ERF_face{1,2}.avg(pos(:,88+i),:));
    place_avg  = place_avg  + mean(ERF_place{1,2}.avg(pos(:,88+i),:));
    object_avg = object_avg + mean(ERF_object{1,2}.avg(pos(:,88+i),:));
end
face_avg = face_avg/8; place_avg   = place_avg/8; object_avg   = object_avg/8;

figure
plot(ERF_face{1,2}.time(51:end),face_avg(51:end),'color','k','linewidth',3); hold on;
plot(ERF_place{1,2}.time(51:end),place_avg(51:end),'color','r','linewidth',3); hold on;
plot(ERF_object{1,2}.time(51:end),object_avg(51:end),'color','g','linewidth',3); hold on;
set(gca,'xtick',[0.2 0.25 0.3 0.35 0.4 0.45 0.5],'xticklabel',[0 0.05 0.1 0.15 0.2 0.25 0.3])
set(gca,'box','off','linewidth',3)
legend('visages','scènes','objets')
xlabel('latence (s)','fontsize',12); ylabel('champ magnétique (fT)','fontsize',12)

print('-dpng',['C:\RESONANCE_MEG\DATA\' nip '\plots\Grads1_ERF_selchans.png'])

face_avg = 0; place_avg = 0; object_avg = 0;
for i = 1:8
    face_avg   = face_avg   + mean(ERF_face{1,3}.avg(pos(:,88+i),:));
    place_avg  = place_avg  + mean(ERF_place{1,3}.avg(pos(:,88+i),:));
    object_avg = object_avg + mean(ERF_object{1,3}.avg(pos(:,88+i),:));
end
face_avg = face_avg/8; place_avg   = place_avg/8; object_avg   = object_avg/8;

figure
plot(ERF_face{1,3}.time(51:end),face_avg(51:end),'color','k','linewidth',3); hold on;
plot(ERF_place{1,3}.time(51:end),place_avg(51:end),'color','r','linewidth',3); hold on;
plot(ERF_object{1,3}.time(51:end),object_avg(51:end),'color','g','linewidth',3); hold on;
set(gca,'xtick',[0.2 0.25 0.3 0.35 0.4 0.45 0.5],'xticklabel',[0 0.05 0.1 0.15 0.2 0.25 0.3])
set(gca,'box','off','linewidth',3)
legend('visages','scènes','objets')
xlabel('latence (s)','fontsize',12); ylabel('champ magnétique (fT)','fontsize',12)

print('-dpng',['C:\RESONANCE_MEG\DATA\' nip '\plots\Grads2_ERF_selchans.png'])




