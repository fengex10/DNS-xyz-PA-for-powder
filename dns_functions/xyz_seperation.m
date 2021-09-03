function [ struct_out ] = xyz_seperation( struct1 )
% xyz_seperation : Apply xyz-polarized neutron scattering analysis to
% seperate paramagnetic scattering Imag,  spin incoherent scattering Ispin,
% and nuclear scattering Inuc (include nuclear coherent and isotop incoherent scattering)
%   Detailed explanation goes here
%   Ref. O. Schaerpf, the spin of the neutron as a measuring probe, pp 86 (2010)

disp('apply xyz seperation!')
names=fieldnames(struct1);
if ~(isstruct(struct1) && length(names)==6 && size(getfield(struct1,names{1}),2)==5)
    disp(['input wrong, ',inputname(1),'must be structure format with xyz-sf/nsf field in 5 cols!']);
    return;
end
struct_out=struct1;
xsf = struct1.xsf;
xnsf= struct1.xnsf;
ysf = struct1.ysf;
ynsf= struct1.ynsf;
zsf = struct1.zsf;
znsf= struct1.znsf;
disp('calculate magnetic scattering');
Imag_sf = dns_Multy(2,dns_Minus(dns_Plus(xsf,ysf),dns_Multy(2,zsf))); % Imag_sf=2(xsf+ysf-2*zsf)
Imag_nsf= dns_Multy(2,dns_Minus(dns_Multy(2,znsf),dns_Plus(xnsf,ynsf))); % Imag_nsf=2(2*znsf-(xnsf,ynsf))
Imag    = dns_Multy(0.5,dns_Plus(Imag_sf,Imag_nsf)); % Imag=(Imag_sf+Imag_nsf)/2
disp('calculate spin-incoherent scattering');
Isp_inc   = dns_Multy(3/2,dns_Minus(dns_Multy(3,zsf),dns_Plus(xsf,ysf))); % Ispin=3/2(3*zsf-(xsf+ysf))
disp('calculate nuclear scattering');
Inuc    = dns_Minus(znsf,dns_Plus(dns_Multy(1/2,Imag),dns_Multy(1/3,Isp_inc)));  % Inuc=znsf-(1/2Imag+1/3Ispin)

struct_out=setfield(struct_out,'Imag_sf',Imag_sf);
struct_out=setfield(struct_out,'Imag_nsf',Imag_nsf);
struct_out=setfield(struct_out,'Imag',Imag);
struct_out=setfield(struct_out,'Isp_inc',Isp_inc);
struct_out=setfield(struct_out,'Inuc',Inuc);

end

