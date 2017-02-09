 
EEG  = EEG_for_layouts('Laptop');

cfg = [];
cfg.layout = 'C:\MTT_MEG\scripts\NMeeg_Standard.lay';
lay = ft_prepare_layout(cfg, data);

lay.pos = lay.pos*10;
lay.width = lay.width*10;
lay.height = lay.height*10;
for l = 1:length(lay.outline)
    lay.outline{l} = lay.outline{l}*10;
end
lay.mask{1} = lay.mask{1}*10;

cfg               = [];
myneighbourdist   = 1.5;
cfg.method        = 'distance';
cfg.channel       = EEG;
cfg.layout        = lay;
cfg.minnbchan     = 2;
cfg.neighbourdist = myneighbourdist;
cfg.feedback      = 'no';
allneighbours     = ft_prepare_neighbours(cfg, data);