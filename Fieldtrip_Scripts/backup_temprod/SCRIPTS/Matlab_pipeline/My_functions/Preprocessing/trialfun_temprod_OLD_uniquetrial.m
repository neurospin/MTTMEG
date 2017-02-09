function trl = trialfun_temprod_OLD_uniquetrial(cfg)

% cfg.dataset = 'C:\TEMPROD\DATA\NEW/Trans_sss_s13/s13_run1_raw_sss.fif';
hdr = ft_read_header(cfg.dataset);


trl = [];
numtrial = floor((hdr.orig.raw.last_samp - hdr.orig.raw.first_samp ))./(5*hdr.Fs);

for i = 1:(numtrial-1)
    
    trl(i,1) = 5*hdr.Fs*(i-1) +1;
    trl(i,2) = 5*hdr.Fs*(i)   ;
    trl(i,3) = 0;

end
