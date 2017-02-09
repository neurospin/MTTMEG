function [ShortFreqGAVG,LongFreqGAVG] = temprod_freqGDAVG_half_v3(arrayindex,subject,freqband,cond,tag)

% set root
root = SetPath(tag); 
Dir = [root '/DATA/NEW/processed_' subject];

chantypefull  = {'Mags';'Gradslong';'Gradslat'};

if length(arrayindex) == 1
    
    for j = 1:3
        chantype = chantypefull{j};
        [GradsLong, GradsLat]  = grads_for_layouts(tag);
        if strcmp(chantype,'Mags')     == 1
            channeltype        =  {'MEG*1'};
        elseif strcmp(chantype,'Gradslong') == 1;
            channeltype        =  GradsLong;
        elseif strcmp(chantype,'Gradslat')
            channeltype        =  GradsLat;
        end
        
        load([Dir '/FT_spectra/Short&LongFreq_1-120_' num2str(arrayindex(1)) '_nodetrend.mat'])
        
        % select frequency band
        fbegin              = find(LongFreq{1,j}.freq >= freqband(1));
        fend                = find(LongFreq{1,j}.freq <= freqband(2));
        fband               = fbegin(1):fend(end);
        LongFreq{1,j}.powspctrm   = LongFreq{1,j}.powspctrm(:,:,fband);
        LongFreq{1,j}.freq        = LongFreq{1,j}.freq(fband);
        ShortFreq{1,j}.powspctrm  = ShortFreq{1,j}.powspctrm(:,:,fband);
        ShortFreq{1,j}.freq       = ShortFreq{1,j}.freq(fband);
        
        cfg.variance      = 'no';
        cfg.jackknife     = 'no';
        cfg.keeptrials    = 'no';
        cfg.channel       = 'all';
        cfg.trials        = 'all';
        cfg.foilim        = [freqband(1) freqband(2)];
        
        ShortFreq{1,j}    = ft_freqdescriptives(cfg,ShortFreq{1,j} );
        LongFreq{1,j}     = ft_freqdescriptives(cfg,LongFreq{1,j} );
        
        ShortFreqGAVG{j} = ShortFreq{j};
        LongFreqGAVG{j}  = LongFreq{j};
    end
else
    for j = 1:3
        chantype = chantypefull{j};
        [GradsLong, GradsLat]  = grads_for_layouts(tag);
        if strcmp(chantype,'Mags')     == 1
            channeltype        =  {'MEG*1'};
        elseif strcmp(chantype,'Gradslong') == 1;
            channeltype        =  GradsLong;
        elseif strcmp(chantype,'Gradslat')
            channeltype        =  GradsLat;
        end
        
        insts = ['SF = ft_freqgrandaverage('];
        instl = ['SL = ft_freqgrandaverage('];
        
        cfg.variance      = 'no';
        cfg.jackknife     = 'no';
        cfg.keeptrials    = 'no';
        cfg.channel       = 'all';
        cfg.trials        = 'all';
        cfg.foilim        = [freqband(1) freqband(2)];
        
        % select frequency band
        load([Dir '/FT_spectra/Short&LongFreq_' ...
                '1-120_' num2str(arrayindex(1)) '_nodetrend.mat'])
        fbegin              = find(LongFreq{1,j}.freq >= freqband(1));
        fend                = find(LongFreq{1,j}.freq <= freqband(2));
        fband               = fbegin(1):fend(end);

        for k = 1:length(arrayindex)
            datapath               = [Dir '/FT_spectra/Short&LongFreq_' ...
                '1-120_' num2str(arrayindex(k)) '_nodetrend.mat'];
            eval(['data' num2str(k) ' =load(datapath,''ShortFreq'',''LongFreq'')']);
            
            % select frequency band
            eval(['data' num2str(k) '.ShortFreq{1,' num2str(j) '}.powspctrm ='...
                'data' num2str(k) '.ShortFreq{1,' num2str(j) '}.powspctrm(:,:,fband);'])
            eval(['data' num2str(k) '.LongFreq{1,' num2str(j) '}.powspctrm ='...
                'data' num2str(k) '.LongFreq{1,' num2str(j) '}.powspctrm(:,:,fband);'])
            eval(['data' num2str(k) '.ShortFreq{1,' num2str(j) '}.freq ='...
                'data' num2str(k) '.ShortFreq{1,' num2str(j) '}.freq(fband);'])
            eval(['data' num2str(k) '.LongFreq{1,' num2str(j) '}.freq ='...
                'data' num2str(k) '.LongFreq{1,' num2str(j) '}.freq(fband);'])    
            
            % average across trials
            eval(['data' num2str(k) '.ShortFreq{1,' num2str(j) '} = ft_freqdescriptives(cfg,'...
                'data' num2str(k) '.ShortFreq{1,' num2str(j) '})']);
            eval(['data' num2str(k) '.LongFreq{1,' num2str(j) '} = ft_freqdescriptives(cfg,'...
                'data' num2str(k) '.LongFreq{1,' num2str(j) '})']);        
            
            insts = [insts 'data' num2str(k) '.ShortFreq{1,' num2str(j) '},'];
            instl = [instl 'data' num2str(k) '.LongFreq{1,' num2str(j) '},'];
        end
        insts(end) = ')'; eval(insts)
        instl(end) = ')'; eval(instl)
        
        ShortFreqGAVG{j} = SF;
        LongFreqGAVG{j}  = SL;
    end
end

datapath               = [Dir '/FT_spectra/Short&LongFreqGAVG_' cond '_' ...
    num2str(freqband(1)) '-' num2str(freqband(2)) '_nodetrend.mat'];
save(datapath,'ShortFreqGAVG','LongFreqGAVG');


