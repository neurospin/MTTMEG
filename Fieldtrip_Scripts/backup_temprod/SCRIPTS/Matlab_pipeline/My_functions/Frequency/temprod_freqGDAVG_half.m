function [ShortFreqGAVG,LongFreqGAVG] = temprod_freqGDAVG_half(arrayindex,subject,freqband,tag)

Dir = ['/neurospin/meg/meg_tmp/temprod_Baptiste_2010/DATA/NEW/processed_' subject];
chantypefull  = {'Mags';'Gradslong';'Gradslat'};

if length(arrayindex) == 1
    
    for j = 1:3
        chantype = chantypefull{j};
        [GradsLong, GradsLat]  = grads_for_layouts;
        if strcmp(chantype,'Mags')     == 1
            channeltype        =  {'MEG*1'};
        elseif strcmp(chantype,'Gradslong') == 1;
            channeltype        =  GradsLong;
        elseif strcmp(chantype,'Gradslat')
            channeltype        =  GradsLat;
        end
        
        load([Dir '/FT_spectra/Short&LongFreq_' ...
        num2str(freqband(1)) '-' num2str(freqband(2)) '_' num2str(arrayindex(1)) '.mat'])
        
        ShortFreqGAVG{j} = ShortFreq{j};
        LongFreqGAVG{j}  = LongFreq{j};
    end
else
    for j = 1:3
        chantype = chantypefull{j};
        [GradsLong, GradsLat]  = grads_for_layouts;
        if strcmp(chantype,'Mags')     == 1
            channeltype        =  {'MEG*1'};
        elseif strcmp(chantype,'Gradslong') == 1;
            channeltype        =  GradsLong;
        elseif strcmp(chantype,'Gradslat')
            channeltype        =  GradsLat;
        end
        
        insts = ['SF = ft_freqgrandaverage('];
        instl = ['SL = ft_freqgrandaverage('];
        
        for k = 1:length(arrayindex)
            datapath               = [Dir '/FT_spectra/Short&LongFreq_' ...
                num2str(freqband(1)) '-' num2str(freqband(2)) '_' num2str(arrayindex(k)) '.mat'];
            eval(['data' num2str(k) ' =load(datapath,''ShortFreq'',''LongFreq'')']);
            insts = [insts 'data' num2str(k) '.ShortFreq{1,' num2str(j) '},'];
            instl = [instl 'data' num2str(k) '.LongFreq{1,' num2str(j) '},'];
        end
        insts(end) = ')'; eval(insts)
        instl(end) = ')'; eval(instl)
        
        ShortFreqGAVG{j} = SF;
        LongFreqGAVG{j}  = SL;
    end
end

datapath               = [Dir '/FT_spectra/Short&LongFreqGAVG_' tag '_' ...
    num2str(freqband(1)) '-' num2str(freqband(2)) '.mat'];
save(datapath,'ShortFreqGAVG','LongFreqGAVG');


