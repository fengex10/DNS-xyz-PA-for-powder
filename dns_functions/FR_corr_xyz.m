function [ struct_out ] = FR_corr_xyz( samp_struct,nicr_struct )
% FR_corr_xyz :Apply flipping ratio correction for xyz fields based on NiCr
%   Cite functin : FR_corr.m
%   input is two structure data. both must include xsf,xnsf,ysf,ynsf,zsf,znsf.
%   output is one structure data. include xsf,xnsf,ysf,ynsf,zsf,znsf.
%   all structure field are 5 col matrix:
%   twotheta,intensity,error,Detector_num,DetBank

struct_out=struct();
if isstruct(samp_struct) && isstruct(nicr_struct) && isequal(fieldnames(samp_struct),fieldnames(samp_struct))
    disp(['apply flipping ratio correction by ',inputname(2)]);
    % x-field
    [xsf,xnsf]=FR_corr(samp_struct.xsf,samp_struct.xnsf,nicr_struct.xsf,nicr_struct.xnsf);
    struct_out=setfield(struct_out,'xsf',xsf);
    struct_out=setfield(struct_out,'xnsf',xnsf);
    disp([inputname(1),' xsf and xsnf have been applied Flipping Ratio correction!']);
    % y-field
    [ysf,ynsf]=FR_corr(samp_struct.ysf,samp_struct.ynsf,nicr_struct.ysf,nicr_struct.ynsf);
    struct_out=setfield(struct_out,'ysf',ysf);
    struct_out=setfield(struct_out,'ynsf',ynsf);
    disp([inputname(1),' ysf and ysnf have been applied Flipping Ratio correction!']);
    % z-field
    [zsf,znsf]=FR_corr(samp_struct.zsf,samp_struct.znsf,nicr_struct.zsf,nicr_struct.znsf);
    struct_out=setfield(struct_out,'zsf',zsf);
    struct_out=setfield(struct_out,'znsf',znsf);
    disp([inputname(1),' zsf and zsnf have been applied Flipping Ratio correction!']);
else
    disp('input wrong! check routines!');
end


end

