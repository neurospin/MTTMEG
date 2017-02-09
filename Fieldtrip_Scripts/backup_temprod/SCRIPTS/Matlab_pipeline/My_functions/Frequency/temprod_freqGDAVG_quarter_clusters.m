function [ShortFreqGAVG,LongFreqGAVG] = temprod_freqGDAVG_quarter_clusters(arrayindex,subject,freqband,cond,tag)

% cluster definition
[Find, Bind, Vind, Lind, Rind] = clusteranat(tag);
[GradsLong, GradsLat, Mags]          = grads_for_layouts(tag);

% set root
root = SetPath(tag);
Dir = [root '/DATA/NEW/processed_' subject];

chantypefull  = {'Mags';'Gradslong';'Gradslat'};

for clustind = 1:5
    
    if clustind == 1
        indsel = Find; clustname = 'FRONT';
    elseif clustind == 2
        indsel = Bind; clustname = 'BACK';
    elseif clustind == 3
        indsel = Vind; clustname = 'VERTEX';
    elseif clustind == 4
        indsel = Lind; clustname = 'LEFT';
    elseif clustind == 5
        indsel = Rind; clustname = 'RIGHT';
    end
    
    if length(arrayindex) == 1
        
        for j = 1:3
            chantype = chantypefull{j};
            if strcmp(chantype,'Mags')     == 1
                channeltype        =  Mags;
            elseif strcmp(chantype,'Gradslong') == 1;
                channeltype        =  GradsLong;
            elseif strcmp(chantype,'Gradslat')
                channeltype        =  GradsLat;
            end
            
            load([Dir '/FT_spectra/QuarterCutFreq_1-120_' num2str(arrayindex(1)) '_nodetrend.mat'])
            
            % select frequency band
            fbegin              = find(Part1Freq{1,j}.freq >= freqband(1));
            fend                = find(Part1Freq{1,j}.freq <= freqband(2));
            fband               = fbegin(1):fend(end);
            Part1Freq{1,j}.powspctrm   = Part1Freq{1,j}.powspctrm(:,:,fband);
            Part1Freq{1,j}.freq        = Part1Freq{1,j}.freq(fband);
            Part2Freq{1,j}.powspctrm   = Part2Freq{1,j}.powspctrm(:,:,fband);
            Part2Freq{1,j}.freq        = Part2Freq{1,j}.freq(fband);
            Part3Freq{1,j}.powspctrm   = Part3Freq{1,j}.powspctrm(:,:,fband);
            Part3Freq{1,j}.freq        = Part3Freq{1,j}.freq(fband);
            Part4Freq{1,j}.powspctrm   = Part4Freq{1,j}.powspctrm(:,:,fband);
            Part4Freq{1,j}.freq        = Part4Freq{1,j}.freq(fband);
            
            %% select channels cluster-wise
%             Part1Freq{1,j}.powspctrm = Part1Freq{1,j}.powspctrm(:,indsel(j,:),:);
%             Part2Freq{1,j}.powspctrm = Part2Freq{1,j}.powspctrm(:,indsel(j,:),:);
%             Part3Freq{1,j}.powspctrm = Part3Freq{1,j}.powspctrm(:,indsel(j,:),:);
%             Part4Freq{1,j}.powspctrm = Part4Freq{1,j}.powspctrm(:,indsel(j,:),:);
            
            cfg.variance      = 'no';
            cfg.jackknife     = 'no';
            cfg.keeptrials    = 'no';
            cfg.channel       = channeltype(indsel(j,:));
            cfg.trials        = 'all';
            cfg.foilim        = [freqband(1) freqband(2)];
            
            Part1Freq{1,j}    = ft_freqdescriptives(cfg,Part1Freq{1,j} );
            Part2Freq{1,j}    = ft_freqdescriptives(cfg,Part2Freq{1,j} );
            Part3Freq{1,j}    = ft_freqdescriptives(cfg,Part3Freq{1,j} );
            Part4Freq{1,j}    = ft_freqdescriptives(cfg,Part4Freq{1,j} );
            
            Part1FreqGAVG{j}  = Part1Freq{j};
            Part2FreqGAVG{j}  = Part2Freq{j};
            Part3FreqGAVG{j}  = Part3Freq{j};
            Part4FreqGAVG{j}  = Part4Freq{j};
            
        end
    else
        for j = 1:3
            chantype = chantypefull{j};
            if strcmp(chantype,'Mags')     == 1
                channeltype        =  Mags;
            elseif strcmp(chantype,'Gradslong') == 1;
                channeltype        =  GradsLong;
            elseif strcmp(chantype,'Gradslat')
                channeltype        =  GradsLat;
            end
            
            inst1 = ['S1 = ft_freqgrandaverage('];
            inst2 = ['S2 = ft_freqgrandaverage('];
            inst3 = ['S3 = ft_freqgrandaverage('];
            inst4 = ['S4 = ft_freqgrandaverage('];
            
            cfg.variance      = 'no';
            cfg.jackknife     = 'no';
            cfg.keeptrials    = 'no';
            cfg.channel       = channeltype(indsel(j,:));
            cfg.trials        = 'all';
            cfg.foilim        = [freqband(1) freqband(2)];
            
            % select frequency band
            load([Dir '/FT_spectra/QuarterCutFreq_' ...
                '1-120_' num2str(arrayindex(1)) '_nodetrend.mat'])
            fbegin              = find(Part1Freq{1,j}.freq >= freqband(1));
            fend                = find(Part1Freq{1,j}.freq <= freqband(2));
            fband               = fbegin(1):fend(end);
            
            for k = 1:length(arrayindex)
                datapath               = [Dir '/FT_spectra/QuarterCutFreq_' ...
                    '1-120_' num2str(arrayindex(k)) '_nodetrend.mat'];
                eval(['data' num2str(k) ' =load(datapath,''Part1Freq'',''Part2Freq'',''Part3Freq'',''Part4Freq'')']);
                
                % select frequency band
                eval(['data' num2str(k) '.Part1Freq{1,' num2str(j) '}.powspctrm ='...
                    'data' num2str(k) '.Part1Freq{1,' num2str(j) '}.powspctrm(:,:,fband);'])
                eval(['data' num2str(k) '.Part2Freq{1,' num2str(j) '}.powspctrm ='...
                    'data' num2str(k) '.Part2Freq{1,' num2str(j) '}.powspctrm(:,:,fband);'])
                eval(['data' num2str(k) '.Part3Freq{1,' num2str(j) '}.powspctrm ='...
                    'data' num2str(k) '.Part3Freq{1,' num2str(j) '}.powspctrm(:,:,fband);'])
                eval(['data' num2str(k) '.Part4Freq{1,' num2str(j) '}.powspctrm ='...
                    'data' num2str(k) '.Part4Freq{1,' num2str(j) '}.powspctrm(:,:,fband);'])
                
                eval(['data' num2str(k) '.Part1Freq{1,' num2str(j) '}.freq ='...
                    'data' num2str(k) '.Part1Freq{1,' num2str(j) '}.freq(fband);'])
                eval(['data' num2str(k) '.Part2Freq{1,' num2str(j) '}.freq ='...
                    'data' num2str(k) '.Part2Freq{1,' num2str(j) '}.freq(fband);'])
                eval(['data' num2str(k) '.Part3Freq{1,' num2str(j) '}.freq ='...
                    'data' num2str(k) '.Part3Freq{1,' num2str(j) '}.freq(fband);'])
                eval(['data' num2str(k) '.Part4Freq{1,' num2str(j) '}.freq ='...
                    'data' num2str(k) '.Part4Freq{1,' num2str(j) '}.freq(fband);'])
                
                %% select channels cluster-wise
%                 eval(['data' num2str(k) '.Part1Freq{1,' num2str(j) '}.powspctrm ='...
%                     'data' num2str(k) '.Part1Freq{1,' num2str(j) '}.powspctrm(:,indsel(' num2str(j) ',:),:);'])
%                 eval(['data' num2str(k) '.Part2Freq{1,' num2str(j) '}.powspctrm ='...
%                     'data' num2str(k) '.Part2Freq{1,' num2str(j) '}.powspctrm(:,indsel(' num2str(j) ',:),:);'])
%                 eval(['data' num2str(k) '.Part3Freq{1,' num2str(j) '}.powspctrm ='...
%                     'data' num2str(k) '.Part3Freq{1,' num2str(j) '}.powspctrm(:,indsel(' num2str(j) ',:),:);'])
%                 eval(['data' num2str(k) '.Part4Freq{1,' num2str(j) '}.powspctrm ='...
%                     'data' num2str(k) '.Part4Freq{1,' num2str(j) '}.powspctrm(:,indsel(' num2str(j) ',:),:);'])
                
                % average across trials
                eval(['data' num2str(k) '.Part1Freq{1,' num2str(j) '} = ft_freqdescriptives(cfg,'...
                    'data' num2str(k) '.Part1Freq{1,' num2str(j) '})']);
                eval(['data' num2str(k) '.Part2Freq{1,' num2str(j) '} = ft_freqdescriptives(cfg,'...
                    'data' num2str(k) '.Part2Freq{1,' num2str(j) '})']);
                eval(['data' num2str(k) '.Part3Freq{1,' num2str(j) '} = ft_freqdescriptives(cfg,'...
                    'data' num2str(k) '.Part3Freq{1,' num2str(j) '})']);
                eval(['data' num2str(k) '.Part4Freq{1,' num2str(j) '} = ft_freqdescriptives(cfg,'...
                    'data' num2str(k) '.Part4Freq{1,' num2str(j) '})']);
                
                inst1 = [inst1 'data' num2str(k) '.Part1Freq{1,' num2str(j) '},'];
                inst2 = [inst2 'data' num2str(k) '.Part2Freq{1,' num2str(j) '},'];
                inst3 = [inst3 'data' num2str(k) '.Part3Freq{1,' num2str(j) '},'];
                inst4 = [inst4 'data' num2str(k) '.Part4Freq{1,' num2str(j) '},'];
                
            end
            inst1(end) = ')'; eval(inst1)
            inst2(end) = ')'; eval(inst2)
            inst3(end) = ')'; eval(inst3)
            inst4(end) = ')'; eval(inst4)
            
            Part1FreqGAVG{j} = S1;
            Part2FreqGAVG{j} = S2;
            Part3FreqGAVG{j} = S3;
            Part4FreqGAVG{j} = S4;
        end
    end
    
    datapath               = [Dir '/FT_spectra/QuarterCutFreqGAVG_' clustname '_' cond '_' ...
        num2str(freqband(1)) '-' num2str(freqband(2)) '_nodetrend.mat'];
    save(datapath,'Part1FreqGAVG','Part2FreqGAVG','Part3FreqGAVG','Part4FreqGAVG');
    
end
