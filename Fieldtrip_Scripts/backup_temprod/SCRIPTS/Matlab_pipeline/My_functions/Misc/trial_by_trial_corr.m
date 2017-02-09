function [Fpeakpow,Fpeak,slopes,R,p] = trial_by_trial_corr(Fullfreq,Fullspctrm,asc_ord,type,tag,corrtag)

% if there is more than one channel
if size(Fullspctrm,2) ~= 1
    
    % compute slopes values
    meanspctrm          = [];
    for k = 1:size(Fullspctrm,1)
        tmp = [];
        meanspctrm(:,k) = squeeze(mean(Fullspctrm(k,:,:),2));
        tmp = polyfit(log(Fullfreq),log(meanspctrm(:,k))',1);
        slopes(k) = tmp(1);
    end
    
    if strcmp(tag,'cumsum') == 1
        Fpeakpow = [];
        Fpeak    = [];
        for i = 1:size(Fullspctrm,1)
            MinSide = min(mean(Fullspctrm(i,:,:)));
            C = cumsum((squeeze(mean(Fullspctrm(i,:,:))) - ones(size(Fullspctrm,3),1)*MinSide));
            j = 1;
            while C(j) <= C(end)/2
                Fpeak(i) = j;
                Fpeakpow(i) = mean(Fullspctrm(i,:,Fpeak(i)));
                j = j+1;
            end
        end
        
        if strcmp(type,'freq') == 1
            [R,p] = corr([asc_ord(:,1) Fullfreq(Fpeak)'],'type',corrtag);
        elseif strcmp(type,'pow') == 1
            [R,p] = corr([asc_ord(:,1) Fpeakpow'],'type',corrtag);
        elseif strcmp(type,'slope')
            [R,p] = corr([asc_ord(:,1) slopes'],'type',corrtag);            
        end
        
    end
    
    if strcmp(tag,'max') == 1
        Fpeakpow = [];
        Fpeak    = [];
        tmp      = [];
        for i = 1:size(Fullspctrm,1)
            Fpeakpow(i) = max(squeeze(mean(Fullspctrm(i,:,:))));
            tmp         = find(squeeze(mean(Fullspctrm(i,:,:))) == Fpeakpow(i));
            Fpeak(i)    = tmp(1);
        end
        
        if strcmp(type,'freq') == 1
            [R,p] = corr([asc_ord(:,1) Fullfreq(Fpeak)'],'type',corrtag);
        elseif strcmp(type,'pow') == 1
            [R,p] = corr([asc_ord(:,1)  Fpeakpow'],'type',corrtag);
        elseif strcmp(type,'slope')
            [R,p] = corr([asc_ord(:,1) slopes'],'type',corrtag);            
        end
        
    end

% if there is only one channel    
elseif size(Fullspctrm,2) == 1
    
    % compute slopes values
    meanspctrm          = [];
    for k = 1:size(Fullspctrm,1)
        tmp = [];
        meanspctrm(:,k) = squeeze(Fullspctrm(k,:,:));
        tmp = polyfit(log(Fullfreq),log(meanspctrm(:,k)'),1);
        slopes(k) = tmp(1);
    end
    
    % compute power/frequency/slope correlation values, method 1
    if strcmp(tag,'cumsum') == 1
        Fpeakpow = [];
        Fpeak    = [];
        for i = 1:size(Fullspctrm,1)
            MinSide = min(mean(Fullspctrm(i,:,:)));
            C = cumsum((squeeze(mean(Fullspctrm(i,:,:),1)) - ones(size(Fullspctrm,3),1)*MinSide));
            j = 1;
            while C(j) <= C(end)/2
                Fpeak(i) = j;
                Fpeakpow(i) = mean(Fullspctrm(i,:,Fpeak(i)),1);
                j = j+1;
            end
        end
        
        if strcmp(type,'freq') == 1
            [R,p] = corr([asc_ord(:,1) Fullfreq(Fpeak)'],'type',corrtag);
        elseif strcmp(type,'pow') == 1
            [R,p] = corr([asc_ord(:,1) Fpeakpow'],'type',corrtag);
        elseif strcmp(type,'slope')
            [R,p] = corr([asc_ord(:,1) slopes'],'type',corrtag);
        end
        
    end
   
    % compute power/frequency/slope correlation values, method 2    
    if strcmp(tag,'max') == 1
        Fpeakpow = [];
        Fpeak    = [];
        tmp      = [];
        for i = 1:size(Fullspctrm,1)
            Fpeakpow(i) = max(squeeze(Fullspctrm(i,:,:)));
            tmp         = find(squeeze(Fullspctrm(i,:,:)) == Fpeakpow(i));
            Fpeak(i)    = tmp(1);
        end
        
        if strcmp(type,'freq') == 1
            [R,p] = corr([asc_ord(:,1) Fullfreq( Fpeak)'],'type',corrtag);
        elseif strcmp(type,'pow') == 1
            [R,p] = corr([asc_ord(:,1) Fpeakpow'],'type',corrtag);
        elseif strcmp(type,'slope')
            [R,p] = corr([asc_ord(:,1) slopes'],'type',corrtag);
        end
    end

end


