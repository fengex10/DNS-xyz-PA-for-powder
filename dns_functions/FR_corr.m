function [ sam_sf_corr,sam_nsf_corr ] = FR_corr( sam_sf,sam_nsf,nicr_sf,nicr_nsf )
% FR_corr : Flipping Ratio correction for one field, eg, x, y, or z.
%   Detailed explanation goes here
%   input matrics in 5 col: twotheta,intensity,error,Detector_num,DetBank
%   input matrics in 5 col: twotheta,intensity,error,Detector_num,DetBank

FR_nicr=dns_Divide(nicr_nsf,nicr_sf); %calculate flipping ratio of NiCr.
fac=dns_Divide(1,dns_Minus(FR_nicr,1)); % fac=1/(R-1); R=FR_nicr
fac2=dns_Multy(fac,dns_Minus(sam_nsf,sam_sf));

sam_sf_corr  = dns_Minus(sam_sf,fac2);
sam_nsf_corr = dns_Plus(sam_nsf,fac2);
end

